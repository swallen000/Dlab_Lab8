`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:09 12/01/2016 
// Design Name: 
// Module Name:    CAL 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CAL(
		input clk1,
		input BTN_SOUTH,	//reset
		input BTN_WEST,		//square root
		input BTN_EAST,		//multiplication
		input BTN_NORTH,	//addition
		input SW_0,
		input SW_1,
		input SW_2,
		input SW_3,
		output reg [7:0]LED,
		output reg LCD_E,
		output reg LCD_RS,
		output reg LCD_RW,
		output reg SF_D8,
		output reg SF_D9,
		output reg SF_D10,
		output reg SF_D11
    );
	
parameter IDLE=0;
parameter INPUT=1;
parameter OUTPUT=2;

parameter mode1=1;
parameter mode2=2;
parameter mode3=3;

reg [5:0]lcd;
reg [159:0]row1;
reg [187:0]row2;
reg [3:0]a2_1,a1_1;
reg [3:0]a2_2,a1_2;
reg [28:0]count2;
reg refresh;
reg [7:0]LED2;
wire [1:0]mode;
wire rfd1,rfd2,rfd3,rfd4;
wire [7:0]dividend,dividend2;
wire [7:0]divisor;
wire [7:0]quotient4,quotient1,quotient2,quotient3;
wire [7:0]fractional4,fractional1,fractional2,fractional3;
assign divisor=10;
assign dividend=LED;
assign dividend2=LED2;

reg [1:0]current_state,next_state;
reg [1:0]operator,operator2;
reg [22:0]count;
reg flag1,flag2,flag3,flag4;
reg f1,f2,f3,f4;
reg [3:0]sum;
reg [7:0]sum2;
wire [7:0]in;
wire [7:0]ans;
wire clk;

assign mode=operator2;
assign in=LED;
sqrt s(
	.x_in(in), // input [7 : 0] x_in
	.x_out(ans), // output [7 : 0] x_out
	.clk(clk) // input clk
);

div d1(
	.clk(clk1), // input clk
	.rfd(rfd1), // output rfd
	.dividend(dividend), // input [7 : 0] dividend
	.divisor(divisor), // input [7 : 0] divisor
	.quotient(quotient1), // output [7 : 0] quotient
	.fractional(fractional1)); // output [7 : 0] fractional  ans3
div d2(
	.clk(clk1), // input clk
	.rfd(rfd2), // output rfd
	.dividend(quotient1), // input [7 : 0] dividend
	.divisor(divisor), // input [7 : 0] divisor
	.quotient(quotient2), // output [7 : 0] quotient   ans1
	.fractional(fractional2)); // output [7 : 0] fractional   ans2
div d3(
	.clk(clk1), // input clk
	.rfd(rfd3), // output rfd
	.dividend(dividend2), // input [7 : 0] dividend
	.divisor(divisor), // input [7 : 0] divisor
	.quotient(quotient3), // output [7 : 0] quotient
	.fractional(fractional3)); // output [7 : 0] fractional
div d4(
	.clk(clk1), // input clk
	.rfd(rfd4), // output rfd
	.dividend(quotient3), // input [7 : 0] dividend
	.divisor(divisor), // input [7 : 0] divisor
	.quotient(quotient4), // output [7 : 0] quotient
	.fractional(fractional4)); // output [7 : 0] fractional
//LCD
always@(posedge clk1) begin
	if(BTN_SOUTH)
		row1<=160'h4C61737420616E737765723D3030302020202020;
	/*else if(count2[24:0]==25'b0110010000000000000000000)begin
		row1[159:152]<=row1[7:0];
		row1[151:144]<=row1[159:152];
		row1[143:136]<=row1[151:144];
		row1[135:128]<=row1[143:136];
		row1[127:120]<=row1[135:128];
		row1[119:112]<=row1[127:120];
		row1[111:104]<=row1[119:112];
		row1[103:96]<=row1[111:104];
		row1[95:88]<=row1[103:96];
		row1[87:80]<=row1[95:88];
		row1[79:72]<=row1[87:80];
		row1[71:64]<=row1[79:72];
		row1[63:56]<=row1[71:64];
		row1[55:48]<=row1[63:56];
		row1[47:40]<=row1[55:48];
		row1[39:32]<=row1[47:40];
		row1[31:24]<=row1[39:32];
		row1[23:16]<=row1[31:24];
		row1[15:8]<=row1[23:16];
		row1[7:0]<=row1[15:8];
	end*/
	else begin
		case(quotient4)
			0:row1[63:56]<=8'h30;
			1:row1[63:56]<=8'h31;
			2:row1[63:56]<=8'h32;
			3:row1[63:56]<=8'h33;
			4:row1[63:56]<=8'h34;
			5:row1[63:56]<=8'h35;
			6:row1[63:56]<=8'h36;
			7:row1[63:56]<=8'h37;
			8:row1[63:56]<=8'h38;
			9:row1[63:56]<=8'h39;
		endcase
		case(fractional4)
			0:row1[55:48]<=8'h30;
			1:row1[55:48]<=8'h31;
			2:row1[55:48]<=8'h32;
			3:row1[55:48]<=8'h33;
			4:row1[55:48]<=8'h34;
			5:row1[55:48]<=8'h35;
			6:row1[55:48]<=8'h36;
			7:row1[55:48]<=8'h37;
			8:row1[55:48]<=8'h38;
			9:row1[55:48]<=8'h39;
		endcase
		case(fractional3)
			0:row1[47:40]<=8'h30;
			1:row1[47:40]<=8'h31;
			2:row1[47:40]<=8'h32;
			3:row1[47:40]<=8'h33;
			4:row1[47:40]<=8'h34;
			5:row1[47:40]<=8'h35;
			6:row1[47:40]<=8'h36;
			7:row1[47:40]<=8'h37;
			8:row1[47:40]<=8'h38;
			9:row1[47:40]<=8'h39;
		endcase
	end	
end

always@(posedge clk1) begin
	if(BTN_SOUTH)
		row2<=184'h43757272656E7420616E737765723D3030302020202020;
	/*else if(count2[24:0]==25'b0110010000000000000000000) begin
		row2[183:176]<=row2[7:0];
		row2[175:168]<=row2[183:176];
		row2[167:160]<=row2[175:168];
		row2[159:152]<=row2[167:160];
		row2[151:144]<=row2[159:152];
		row2[143:136]<=row2[151:144];
		row2[135:128]<=row2[143:136];
		row2[127:120]<=row2[135:128];
		row2[119:112]<=row2[127:120];
		row2[111:104]<=row2[119:112];
		row2[103:96]<=row2[111:104];
		row2[95:88]<=row2[103:96];
		row2[87:80]<=row2[95:88];
		row2[79:72]<=row2[87:80];
		row2[71:64]<=row2[79:72];
		row2[63:56]<=row2[71:64];
		row2[55:48]<=row2[63:56];
		row2[47:40]<=row2[55:48];
		row2[39:32]<=row2[47:40];
		row2[31:24]<=row2[39:32];
		row2[23:16]<=row2[31:24];
		row2[15:8]<=row2[23:16];
		row2[7:0]<=row2[15:8];
	end*/
	else begin
		case(quotient2)
			0:row2[63:56]<=8'h30;
			1:row2[63:56]<=8'h31;
			2:row2[63:56]<=8'h32;
			3:row2[63:56]<=8'h33;
			4:row2[63:56]<=8'h34;
			5:row2[63:56]<=8'h35;
			6:row2[63:56]<=8'h36;
			7:row2[63:56]<=8'h37;
			8:row2[63:56]<=8'h38;
			9:row2[63:56]<=8'h39;
		endcase
		case(fractional2)
			0:row2[55:48]<=8'h30;
			1:row2[55:48]<=8'h31;
			2:row2[55:48]<=8'h32;
			3:row2[55:48]<=8'h33;
			4:row2[55:48]<=8'h34;
			5:row2[55:48]<=8'h35;
			6:row2[55:48]<=8'h36;
			7:row2[55:48]<=8'h37;
			8:row2[55:48]<=8'h38;
			9:row2[55:48]<=8'h39;
		endcase
		case(fractional1)
			0:row2[47:40]<=8'h30;
			1:row2[47:40]<=8'h31;
			2:row2[47:40]<=8'h32;
			3:row2[47:40]<=8'h33;
			4:row2[47:40]<=8'h34;
			5:row2[47:40]<=8'h35;
			6:row2[47:40]<=8'h36;
			7:row2[47:40]<=8'h37;
			8:row2[47:40]<=8'h38;
			9:row2[47:40]<=8'h39;
		endcase
	end
end

always@(posedge clk1) begin
	if(BTN_SOUTH) begin
		a1_1<=4'b1000;
		a1_2<=4'b0000;
	end
	else begin
		case(mode)
			1,3: begin
				if(count2[24:0]==25'b0000000011111111111111111&&a1_1==4'b1000&&a1_2==4'b1111) begin
					a1_1<=4'b1101;
					a1_2<=4'b0111;
				end
				else if(count2[24:0]==25'b0000000011111111111111111&&a1_1==4'b1110&&a1_2==4'b0111) begin
					a1_1<=4'b1000;
					a1_2<=4'b0000;
				end
				else if(count2[24:0]==25'b0000000011111111111111111&&a1_2==4'b1111)begin
					a1_1<=a1_1+1;
					a1_2<=4'b0000;
				end
				else if(count2[24:0]==25'b0000000011111111111111111)begin
					a1_1<=a1_1;
					a1_2<=a1_2+1;
				end
				else begin
					a1_1<=a1_1;
					a1_2<=a1_2;
				end
			end
			2: begin
				if(count2[24:0]==25'b0000000011111111111111111&&a1_1==4'b1000&&a1_2==4'b0000) begin
					a1_1<=4'b1110;
					a1_2<=4'b0111;
				end
				else if(count2[24:0]==25'b0000000011111111111111111&&a1_1==4'b1101&&a1_2==4'b0101) begin
					a1_1<=4'b1000;
					a1_2<=4'b1111;
				end
				else if(count2[24:0]==25'b0000000011111111111111111&&a1_2==4'b0000)begin
					a1_1<=a1_1-1;
					a1_2<=4'b1111;
				end
				else if(count2[24:0]==25'b0000000011111111111111111)begin
					a1_1<=a1_1;
					a1_2<=a1_2-1;
				end
				else begin
					a1_1<=a1_1;
					a1_2<=a1_2;
				end
			end
		endcase
	end
end

always@(posedge clk1) begin
	if(BTN_SOUTH) begin
		a2_1<=4'b1100;
		a2_2<=4'b0000;
	end
	else begin
		case(mode)
			2,3: begin
				if(count2[24:0]==25'b0000000011111111111111111&&a2_1==4'b1100&&a2_2==4'b1111)begin
					a2_1<=4'b1001;
					a2_2<=4'b1000;
				end
				else if(count2[24:0]==25'b0000000011111111111111111&&a2_1==4'b1010&&a2_2==4'b0111)begin
					a2_1<=4'b1100;
					a2_2<=4'b0000;
				end
				else if(count2[24:0]==25'b0000000011111111111111111&&a2_2==4'b1111)begin
					a2_1<=a2_1+1;
					a2_2<=4'b0000;
				end
				else if(count2[24:0]==25'b0000000011111111111111111)begin
					a2_1<=a2_1;
					a2_2<=a2_2+1;
				end
				else begin
					a2_1<=a2_1;
					a2_2<=a2_2;
				end
			end
			1:begin
				if(count2[24:0]==25'b0000000011111111111111111&&a2_1==4'b1100&&a2_2==4'b0000)begin
					a2_1<=4'b1010;
					a2_2<=4'b0111;
				end
				else if(count2[24:0]==25'b0000000011111111111111111&&a2_1==4'b1001&&a2_2==4'b0101) begin
					a2_1<=4'b1100;
					a2_2<=4'b1111;
				end
				else if(count2[24:0]==25'b0000000011111111111111111&&a2_1==4'b1001&&a2_2==4'b0000)begin
					a2_1<=4'b1100;
					a2_2<=4'b1111;
				end
				else if(count2[24:0]==25'b0000000011111111111111111&&a2_2==4'b0000)begin
					a2_1<=a2_1-1;
					a2_2<=4'b1111;
				end
				else if(count2[24:0]==25'b0000000011111111111111111)begin
					a2_1<=a2_1;
					a2_2<=a2_2-1;
				end
				else begin
					a2_1<=a2_1;
					a2_2<=a2_2;
				end
			end
		endcase
	end
end

always@(posedge clk1) begin
	if(BTN_SOUTH) begin
		count2<=0;
	end
	else begin
			count2<=count2+1;
			begin
				case(count2[24:17])
					0: lcd <= 6'h03;			 // power-on initialization
					 1: lcd <= 6'h03;
					 2: lcd <= 6'h03;
					 3: lcd <= 6'h02;
					 4: lcd <= 6'h02;        // function set
					 5: lcd <= 6'h08;
					 6: lcd <= 6'h00;        // entry mode set
					 7: lcd <= 6'h06;
					 8: lcd <= 6'h00;        // display on/off control
					 9: lcd <= 6'h0C;
					10: lcd <= 6'h00;
					11: lcd <= 6'h01;
					12: lcd <= a1_1;        // display clear
					13: lcd <= a1_2;
					14: lcd <= 32+row1[159:156];        // L
					15: lcd <= 32+row1[155:152];
					16: lcd <= 32+row1[151:148];        // a
					17: lcd <= 32+row1[147:144];
					18: lcd <= 32+row1[143:140];        // s
					19: lcd <= 32+row1[139:136];
					20: lcd <= 32+row1[135:132];        // t
					21: lcd <= 32+row1[131:128];
					22: lcd <= 32+row1[127:124];        // 
					23: lcd <= 32+row1[123:120];
					24: lcd <= 32+row1[119:116];        // a
					25: lcd <= 32+row1[115:112];
					26: lcd <= 32+row1[111:108];        // n
					27: lcd <= 32+row1[107:104];
					28: lcd <= 32+row1[103:100];        // s
					29: lcd <= 32+row1[99:96];
					30: lcd <= 32+row1[95:92];        // w
					31: lcd <= 32+row1[91:88];
					32: lcd <= 32+row1[87:84];        // e
					33: lcd <= 32+row1[83:80];
					34: lcd <= 32+row1[79:76];        // r
					35: lcd <= 32+row1[75:72];
					36: lcd <= 32+row1[71:68];        // =
					37: lcd <= 32+row1[67:64];
					38: lcd <= 32+row1[63:60];		  // 0
					39: lcd <= 32+row1[59:56]; 		  
					40: lcd <= 32+row1[55:52];		  // 0
					41: lcd <= 32+row1[51:48];
					42: lcd <= 32+row1[47:44];		  // 0
					43: lcd <= 32+row1[43:40];
					44:lcd<=32+row1[39:36]; //
					45:lcd<=32+row1[35:32];
					46:lcd<=32+row1[31:28]; //
					47:lcd<=32+row1[27:24];
					48:lcd<=32+row1[23:20]; //
					49:lcd<=32+row1[19:16];
					50:lcd<=32+row1[15:12]; //
					51:lcd<=32+row1[11:8];
					52:lcd<=32+row1[7:4]; //
					53:lcd<=32+row1[3:0];
					/////////////////////////////////
					(54): lcd <= a2_1;
					(55): lcd <= a2_2;
					/////////////////////////////////
					(56): lcd <= 32+row2[183:180];				  // a
					(57): lcd <= 32+row2[179:176];
					(58): lcd <= 32+row2[175:172];				  // n
					(59): lcd <= 32+row2[171:168];
					(60): lcd <= 32+row2[167:164];				  // s
					(61): lcd <= 32+row2[163:160];
					(62): lcd <= 32+row2[159:156];				  // w
					(63): lcd <= 32+row2[155:152];
					(64): lcd <= 32+row2[151:148];				  // e
					(65): lcd <= 32+row2[147:144];
					(66): lcd <= 32+row2[143:140];				  // r
					(67): lcd <= 32+row2[139:136];
					(68): lcd <= 32+row2[135:132];				  // =
					(69): lcd <= 32+row2[131:128];
					(70): lcd <= 32+row2[127:124];				  // 0
					(71): lcd <= 32+row2[123:120];
					(72): lcd <= 32+row2[119:116];				  // 0
					(73): lcd <= 32+row2[115:112];
					(74): lcd <= 32+row2[111:108];				  // 0
					(75): lcd <= 32+row2[107:104];
					(76): lcd <= 32+row2[103:100];				  // 
					(77): lcd <= 32+row2[99:96];
					(78): lcd <= 32+row2[95:92];				  // C
					(79): lcd <= 32+row2[91:88];
					(80): lcd <= 32+row2[87:84];				  // u
					(81): lcd <= 32+row2[83:80];
					(82): lcd <= 32+row2[79:76];				  // r
					(83): lcd <= 32+row2[75:72];
					(84): lcd <= 32+row2[71:68];				  // r
					(85): lcd <= 32+row2[67:64];
					(86): lcd <= 32+row2[63:60];				  // e
					(87): lcd <= 32+row2[59:56];
					(88): lcd <= 32+row2[55:52];				  // n
					(89): lcd <= 32+row2[51:48];
					(90): lcd <= 32+row2[47:44];				  // t
					(91): lcd <= 32+row2[43:40];
					(92): lcd <= 32+row2[39:36];				  // 
					(93): lcd <= 32+row2[35:32];
					94:lcd<=32+row2[31:28]; //
					95:lcd<=32+row2[27:24];
					96:lcd<=32+row2[23:20]; //
					97:lcd<=32+row2[19:16];
					98:lcd<=32+row2[15:12]; //
					99:lcd<=32+row2[11:8];
					100:lcd<=32+row2[7:4]; //
					101:lcd<=32+row2[3:0];
					default: lcd<=6'b100001;
				endcase
			end
		refresh<=count2[16];
		{LCD_E,LCD_RS,LCD_RW,SF_D11,SF_D10,SF_D9,SF_D8}<={refresh,lcd};
	end
end

//

always @ (posedge clk1)
	count<=count+1'b1;
assign clk=count[22];

always@(posedge clk) begin
	if(BTN_SOUTH)
		current_state=IDLE;
	else 
		current_state=next_state;
end

always@(*) begin 
	case(current_state)
		IDLE:	next_state=INPUT;
		INPUT: begin
			if(!BTN_WEST&&!BTN_EAST&&!BTN_NORTH)
				next_state=INPUT;
			else
				next_state=OUTPUT;
		end
		OUTPUT: begin
			if(BTN_SOUTH)
				next_state=IDLE;
			else
				next_state=OUTPUT;
		end
		default:next_state=IDLE;
	endcase
end

always@(posedge clk) begin
	if(BTN_SOUTH)
		operator=0;
	else begin
		if(current_state==INPUT||current_state==OUTPUT) begin
			if(BTN_WEST) begin
					operator=1;
			end
			else if(BTN_NORTH) begin
					operator=2;
			end
			else if(BTN_EAST) begin
					operator=3;
			end
			else
				operator=operator;
		end
		else
			operator=operator;
	end
end

always@(posedge clk1) begin
	if(BTN_SOUTH) 
		operator2=0;
	else if(operator==1) begin
		if(!BTN_WEST)
			operator2=1;
		else
			operator2=0;
	end
	else if(operator==2) begin
		if(!BTN_NORTH)
			operator2=2;
		else
			operator2=0;
	end
	else if(operator==3) begin
		if(!BTN_EAST)
			operator2=3;
		else 
			operator2=0;
	end
	else
		operator2=operator2;
end

always@(posedge clk) begin
	if(BTN_SOUTH) begin
		f1=0;
	end
	else begin
		if(current_state==OUTPUT) begin
			if(!f1)
				f1=1;
			else if((8*SW_3+4*SW_2+2*SW_1+SW_0)!=sum)
				f1=0;			
			else
				f1=f1;
		end
		else begin
			f1=f1;
		end
	end
end

always@(posedge clk) begin
	if(BTN_SOUTH) begin
		f2=0;
	end
	else begin
		if(current_state==OUTPUT) begin
			if(f2)
				f2=0;
			else if(BTN_EAST||BTN_NORTH||BTN_WEST)
				f2=1;			
			else
				f2=f2;
		end
		else begin
			f2=f2;
		end
	end
end

always@(posedge clk) begin
	if(BTN_SOUTH) begin
		f3=0;
	end
	else begin
		if(current_state==OUTPUT) begin
			if(f3)
				f3=0;
			else if(f2)
				f3=1;			
			else
				f3=f3;
		end
		else begin
			f3=f3;
		end
	end
end

always@(posedge clk) begin
	if(BTN_SOUTH)
		sum=0;
	else begin
		if(current_state==OUTPUT) begin
			if(!f1)
				sum=(8*SW_3+4*SW_2+2*SW_1+SW_0);
			else
				sum=sum;
		end
	end
end

always@(posedge clk) begin
	if(BTN_SOUTH)
		sum2=0;
	else begin
		if(current_state==INPUT) begin
			sum2=LED;
		end
		else if(f2)
			sum2=LED;
		else
			sum2=sum2;
	end
end

always@(posedge clk) begin
	if(BTN_SOUTH)
			LED=0;
	else begin
		if(current_state==INPUT) begin
			LED=8*SW_3+4*SW_2+2*SW_1+SW_0;
		end
		else if(current_state==OUTPUT) begin
			case(operator2)
				1: begin
					if(!f1) begin
						LED=ans;
					end
					if(f3) begin
						LED=ans;
					end
					else
						LED=LED;
				end
				2:begin
					if(!f1) begin
						LED=sum2*(8*SW_3+4*SW_2+2*SW_1+SW_0);				
					end
					if(f3)
						LED=sum2*(8*SW_3+4*SW_2+2*SW_1+SW_0);
					else
						LED=LED;
				end
				3:begin
					if(!f1)
						LED=LED+(8*SW_3+4*SW_2+2*SW_1+SW_0)-sum;
					if(f3)
						LED=LED+(8*SW_3+4*SW_2+2*SW_1+SW_0);
					else
						LED=LED;
				end
				default:LED=LED;
			endcase
		end
		else
			LED=LED;
	end
end

always@(posedge clk) begin
	if(BTN_SOUTH) begin
		LED2<=0;
	end
	else if(current_state==OUTPUT)begin
		if(BTN_NORTH||BTN_EAST||BTN_WEST||!f1) begin
			LED2<=LED;
		end
	end
	else
		LED2<=LED2;
end

endmodule
