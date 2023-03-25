pragma solidity ^0.8.0;

contract TRAI {
    string public constant name = "TeleradiologyAI";
    string public constant symbol = "TRAI";
    uint8 public constant decimals = 18;
    uint256 public constant initialSupply = 8_000_000_000 * 10 ** uint256(decimals);
    address public constant airdropWallet = 0x000000000000000000000000000000000000dEaD ; // address reserved for airdrops and community building
    address public constant privateSaleWallet = 0x000000000000000000000000000000000000dEaD ; // address for private sale
    address public constant publicSaleWallet = 0x000000000000000000000000000000000000dEaD ; // address for public sale
    address public constant reserveWallet = 0x000000000000000000000000000000000000dEaD ; // address for company reserves
    address public constant partnershipWallet = 0x000000000000000000000000000000000000dEaD ; // address for sponsorships and partnerships
    
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    constructor() {
        balances[airdropWallet] = initialSupply * 18 / 100;
        balances[privateSaleWallet] = initialSupply * 12 / 100;
        balances[publicSaleWallet] = initialSupply * 20 / 100;
        balances[reserveWallet] = initialSupply * 25 / 100;
        balances[partnershipWallet] = initialSupply * 25 / 100;
    }
    
    function totalSupply() public pure returns (uint256) {
        return initialSupply;
    }
    
    function balanceOf(address tokenOwner) public view returns (uint256) {
        return balances[tokenOwner];
    }
    
    function transfer(address receiver, uint256 numTokens) public returns (bool) {
        require(numTokens <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= numTokens;
        balances[receiver] += numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }
    
    function approve(address delegate, uint256 numTokens) public returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }
    
    function allowance(address owner, address delegate) public view returns (uint256) {
        return allowed[owner][delegate];
    }
    
    function transferFrom(address owner, address buyer, uint256 numTokens) public returns (bool) {
        require(numTokens <= balances[owner], "Insufficient balance");
        require(numTokens <= allowed[owner][msg.sender], "Not enough allowance");
        balances[owner] -= numTokens;
        allowed[owner][msg.sender] -= numTokens;
        balances[buyer] += numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed delegate, uint256 value);
}