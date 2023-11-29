Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDDA7FD2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjK2JbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjK2Jao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:30:44 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52441BF8;
        Wed, 29 Nov 2023 01:29:54 -0800 (PST)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Wed, 29 Nov 2023
 17:29:51 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH] arm64: dts: amlogic: s4: add some device nodes
Date:   Wed, 29 Nov 2023 17:29:49 +0800
Message-ID: <20231129092949.2103338-1-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some device nodes for board AQ222,
including clock,I2C,SPICC,nand and ethernet.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../dts/amlogic/meson-s4-s805x2-aq222.dts     |  55 +++
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     | 350 +++++++++++++++++-
 2 files changed, 404 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
index c1f322c73982..fd349c49ebf5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
@@ -23,6 +23,16 @@ memory@0 {
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secmon_reserved: secmon@5000000 {
+			reg = <0x0 0x05000000 0x0 0x4000000>;
+			no-map;
+		};
+	};
 };
 
 &uart_B {
@@ -34,3 +44,48 @@ &ir {
 	pinctrl-0 = <&remote_pins>;
 	pinctrl-names = "default";
 };
+
+&nand {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	pinctrl-0 = <&nand_pins>;
+	pinctrl-names = "default";
+
+	nand@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		nand-on-flash-bbt;
+
+		partition@0 {
+			label = "boot";
+			reg = <0x0 0x00200000>;
+		};
+		partition@200000 {
+			label = "env";
+			reg = <0x00200000 0x00400000>;
+		};
+		partition@600000 {
+			label = "system";
+			reg = <0x00600000 0x00a00000>;
+		};
+		partition@1000000 {
+			label = "rootfs";
+			reg = <0x01000000 0x03000000>;
+		};
+		partition@4000000 {
+			label = "media";
+			reg = <0x04000000 0x8000000>;
+		};
+	};
+};
+
+&spicc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spicc0_pins_x>;
+	cs-gpios = <&gpio GPIOX_10 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index 2344b2d741c3..022aba0f9ef7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -6,6 +6,10 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/meson-s4-gpio.h>
+#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
+#include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
+#include <dt-bindings/power/meson-s4-power.h>
 
 / {
 	cpus {
@@ -92,6 +96,38 @@ apb4: bus@fe000000 {
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
 
+			clkc_periphs: clock-controller@0 {
+				compatible = "amlogic,s4-peripherals-clkc";
+				reg = <0x0 0x0 0x0 0x49c>;
+				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
+					<&clkc_pll CLKID_FCLK_DIV2P5>,
+					<&clkc_pll CLKID_FCLK_DIV3>,
+					<&clkc_pll CLKID_FCLK_DIV4>,
+					<&clkc_pll CLKID_FCLK_DIV5>,
+					<&clkc_pll CLKID_FCLK_DIV7>,
+					<&clkc_pll CLKID_HIFI_PLL>,
+					<&clkc_pll CLKID_GP0_PLL>,
+					<&clkc_pll CLKID_MPLL0>,
+					<&clkc_pll CLKID_MPLL1>,
+					<&clkc_pll CLKID_MPLL2>,
+					<&clkc_pll CLKID_MPLL3>,
+					<&clkc_pll CLKID_HDMI_PLL>,
+					<&xtal>;
+				clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3",
+						"fclk_div4", "fclk_div5", "fclk_div7",
+						"hifi_pll", "gp0_pll", "mpll0", "mpll1",
+						"mpll2", "mpll3", "hdmi_pll", "xtal";
+				#clock-cells = <1>;
+			};
+
+			clkc_pll: clock-controller@8000 {
+				compatible = "amlogic,s4-pll-clkc";
+				reg = <0x0 0x8000 0x0 0x1e8>;
+				clocks = <&xtal>;
+				clock-names = "xtal";
+				#clock-cells = <1>;
+			};
+
 			watchdog@2100 {
 				compatible = "amlogic,s4-wdt", "amlogic,t7-wdt";
 				reg = <0x0 0x2100 0x0 0x10>;
@@ -120,6 +156,187 @@ mux {
 						bias-disable;
 					};
 				};
+
+				i2c0_pins1:i2c0-pins1 {
+					mux {
+						groups = "i2c0_sda",
+						       "i2c0_scl";
+						function = "i2c0";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c1_pins1:i2c1-pins1 {
+					mux {
+						groups = "i2c1_sda_c",
+						       "i2c1_scl_c";
+						function = "i2c1";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c1_pins2:i2c1-pins2 {
+					mux {
+						groups = "i2c1_sda_d",
+						       "i2c1_scl_d";
+						function = "i2c1";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c1_pins3:i2c1-pins3 {
+					mux {
+						groups = "i2c1_sda_h",
+						       "i2c1_scl_h";
+						function = "i2c1";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c1_pins4:i2c1-pins4 {
+					mux {
+						groups = "i2c1_sda_x",
+						       "i2c1_scl_x";
+						function = "i2c1";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c2_pins1:i2c2-pins1 {
+					mux {
+						groups = "i2c2_sda_d",
+						       "i2c2_scl_d";
+						function = "i2c2";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c2_pins2:i2c2-pins2 {
+					mux {
+						groups = "i2c2_sda_h8",
+						       "i2c2_scl_h9";
+						function = "i2c2";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c2_pins3:i2c2-pins3 {
+					mux {
+						groups = "i2c2_sda_h0",
+						       "i2c2_scl_h1";
+						function = "i2c2";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c3_pins1:i2c3-pins1 {
+					mux {
+						groups = "i2c3_sda_x",
+						       "i2c3_scl_x";
+						function = "i2c3";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c3_pins2:i2c3-pins2 {
+					mux {
+						groups = "i2c3_sda_z",
+						       "i2c3_scl_z";
+						function = "i2c3";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c4_pins1:i2c4-pins1 {
+					mux {
+						groups = "i2c4_sda_c",
+						       "i2c4_scl_c";
+						function = "i2c4";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c4_pins2:i2c4-pins2 {
+					mux {
+						groups = "i2c4_sda_d",
+						       "i2c4_scl_d";
+						function = "i2c4";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				i2c4_pins3:i2c4-pins3 {
+					mux {
+						groups = "i2c4_sda_z",
+						       "i2c4_scl_z";
+						function = "i2c4";
+						drive-strength-microamp = <3000>;
+						bias-disable;
+					};
+				};
+
+				nand_pins: nand-pins {
+					mux {
+						groups = "emmc_nand_d0",
+						       "emmc_nand_d1",
+						       "emmc_nand_d2",
+						       "emmc_nand_d3",
+						       "emmc_nand_d4",
+						       "emmc_nand_d5",
+						       "emmc_nand_d6",
+						       "emmc_nand_d7",
+						       "nand_ce0",
+						       "nand_ale",
+						       "nand_cle",
+						       "nand_wen_clk",
+						       "nand_ren_wr";
+						function = "nand";
+						input-enable;
+					};
+				};
+
+				spicc0_pins_x: spicc0-pins_x {
+					mux {
+						groups = "spi_a_mosi_x",
+						       "spi_a_miso_x",
+						       "spi_a_clk_x";
+						function = "spi_a";
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				spicc0_pins_h: spicc0-pins-h {
+					mux {
+						groups = "spi_a_mosi_h",
+						       "spi_a_miso_h",
+						       "spi_a_clk_h";
+						function = "spi_a";
+						drive-strength-microamp = <3000>;
+					};
+				};
+
+				spicc0_pins_z: spicc0-pins-z {
+					mux {
+						groups = "spi_a_mosi_z",
+						       "spi_a_miso_z",
+						       "spi_a_clk_z";
+						function = "spi_a";
+						drive-strength-microamp = <3000>;
+					};
+				};
+
 			};
 
 			gpio_intc: interrupt-controller@4080 {
@@ -132,13 +349,119 @@ gpio_intc: interrupt-controller@4080 {
 					<10 11 12 13 14 15 16 17 18 19 20 21>;
 			};
 
+			eth_phy: mdio-multiplexer@28000 {
+				compatible = "amlogic,g12a-mdio-mux";
+				reg = <0x0 0x28000 0x0 0xa4>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc_periphs CLKID_ETHPHY>,
+					 <&xtal>,
+					 <&clkc_pll CLKID_MPLL_50M>;
+				clock-names = "pclk", "clkin0", "clkin1";
+				mdio-parent-bus = <&mdio0>;
+
+				ext_mdio: mdio@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				int_mdio: mdio@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					internal_ephy: ethernet-phy@8 {
+						compatible = "ethernet-phy-id0180.3301",
+							     "ethernet-phy-ieee802.3-c22";
+						interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+						reg = <8>;
+						max-speed = <100>;
+					};
+				};
+			};
+
+			spicc0: spi@50000 {
+				compatible = "amlogic,meson-g12a-spicc";
+				reg = <0x0 0x50000 0x0 0x44>;
+				interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc_periphs CLKID_SPICC0>,
+					 <&clkc_periphs CLKID_SPICC0_EN>;
+				clock-names = "core", "pclk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c0: i2c@66000 {
+				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x66000 0x0 0x20>;
+				interrupts = <GIC_SPI 160 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_periphs CLKID_I2C_M_A>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@68000 {
+				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x68000 0x0 0x20>;
+				interrupts = <GIC_SPI 161 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_periphs CLKID_I2C_M_B>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@6a000 {
+				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x6a000 0x0 0x20>;
+				interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_periphs CLKID_I2C_M_C>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c3: i2c@6c000 {
+				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x6c000 0x0 0x20>;
+				interrupts = <GIC_SPI 163 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_periphs CLKID_I2C_M_D>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c4: i2c@6e000 {
+				compatible = "amlogic,meson-axg-i2c";
+				reg = <0x0 0x6e000 0x0 0x20>;
+				interrupts = <GIC_SPI 164 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_periphs CLKID_I2C_M_E>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			nand: nand-controller@8c800 {
+				compatible = "amlogic,meson-axg-nfc";
+				reg = <0x0 0x8c800 0x0 0x100>, <0x0 0x8c000 0x0 0x4>;
+				reg-names = "nfc", "emmc";
+				interrupts = <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_periphs CLKID_SD_EMMC_C>,
+					<&clkc_pll CLKID_FCLK_DIV2>;
+				clock-names = "core", "device";
+				status = "disabled";
+			};
+
 			uart_B: serial@7a000 {
 				compatible = "amlogic,meson-s4-uart",
 					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x7a000 0x0 0x18>;
 				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
-				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clocks = <&xtal>, <&clkc_periphs CLKID_UART_B>, <&xtal>;
 				clock-names = "xtal", "pclk", "baud";
 			};
 
@@ -160,5 +483,30 @@ hwrng: rng@440788 {
 				reg = <0x0 0x440788 0x0 0x0c>;
 			};
 		};
+
+		ethmac: ethernet@fdc00000 {
+			compatible = "amlogic,meson-axg-dwmac",
+				     "snps,dwmac-3.70a",
+				     "snps,dwmac";
+			reg = <0x0 0xfdc00000 0x0 0x10000>,
+			      <0x0 0xfe024000 0x0 0x8>;
+
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			power-domains = <&pwrc PWRC_S4_ETH_ID>;
+			clocks = <&clkc_periphs CLKID_ETH>,
+				 <&clkc_pll CLKID_FCLK_DIV2>,
+				 <&clkc_pll CLKID_MPLL2>;
+			clock-names = "stmmaceth", "clkin0", "clkin1";
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <2048>;
+			status = "disabled";
+
+			mdio0: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
+		};
 	};
 };

base-commit: 3a5038e9c0556e51db96c2f7149d853efb886c95
-- 
2.39.2

