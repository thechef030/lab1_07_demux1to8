`timescale 1ns/1ps
module tb_demux_1x8;
  reg i; reg [2:0] s; wire [7:0] o; demux_1x8 dut(i,s,o);
  integer n,checked=0;
  reg [7:0] expected;
  initial begin
    $dumpfile("wave.vcd"); $dumpvars(0,tb_demux_1x8);

    for(n=0;n<16;n=n+1) begin
      {i,s}=n;
      expected=(n>=8) ? (128 >> (n%8)) : 0;
      #10;
      if (o !== expected)
        $fatal(1,"FAIL demux_1x8 vector=%0d expected=%h actual=%h",n,expected,o);
      checked=checked+1;
    end
    if(checked!=16) $fatal(1,"Incomplete test");
    $display("LAB1_PASS demux_1x8 cases=%0d",checked);
    $finish;
  end
  initial begin #100000; $fatal(1,"Watchdog"); end
endmodule
