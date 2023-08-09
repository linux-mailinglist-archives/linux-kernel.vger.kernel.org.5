Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABA4775076
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjHIBj2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Aug 2023 21:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHIBjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:39:25 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0471982;
        Tue,  8 Aug 2023 18:39:22 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8134724E293;
        Wed,  9 Aug 2023 09:39:20 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 9 Aug
 2023 09:39:20 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 9 Aug 2023 09:39:19 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v1 2/2] riscv: dts: starfive: Add mmc nodes on VisionFive 2 board
Date:   Wed, 9 Aug 2023 09:39:17 +0800
Message-ID: <20230809013917.81674-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809013917.81674-1-william.qiu@starfivetech.com>
References: <20230809013917.81674-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mmc nodes for the StarFive JH7110 SoC.
Set mmc0 node to emmc and set mmc1 node to sd.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 96 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 32 +++++++
 2 files changed, 128 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index d67e26b9c791..d79f94432b27 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -17,6 +17,8 @@ aliases {
 		i2c2 = &i2c2;
 		i2c5 = &i2c5;
 		i2c6 = &i2c6;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
 		serial0 = &uart0;
 	};
 
@@ -201,6 +203,35 @@ &i2c6 {
 	status = "okay";
 };
 
+&mmc0 {
+	max-frequency = <100000000>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	non-removable;
+	cap-mmc-hw-reset;
+	post-power-on-delay-ms = <200>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+	status = "okay";
+};
+
+&mmc1 {
+	max-frequency = <100000000>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	broken-cd;
+	cap-sd-highspeed;
+	post-power-on-delay-ms = <200>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	status = "okay";
+};
+
 &qspi {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -306,6 +337,71 @@ GPOEN_SYS_I2C6_DATA,
 		};
 	};
 
+	mmc0_pins: mmc0-0 {
+		 rst-pins {
+			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		mmc-pins {
+			pinmux = <PINMUX(64, 0)>,
+				 <PINMUX(65, 0)>,
+				 <PINMUX(66, 0)>,
+				 <PINMUX(67, 0)>,
+				 <PINMUX(68, 0)>,
+				 <PINMUX(69, 0)>,
+				 <PINMUX(70, 0)>,
+				 <PINMUX(71, 0)>,
+				 <PINMUX(72, 0)>,
+				 <PINMUX(73, 0)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-enable;
+		};
+	};
+
+	mmc1_pins: mmc1-0 {
+		clk-pins {
+			pinmux = <GPIOMUX(10, GPOUT_SYS_SDIO1_CLK,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		mmc-pins {
+			pinmux = <GPIOMUX(9, GPOUT_SYS_SDIO1_CMD,
+					     GPOEN_SYS_SDIO1_CMD,
+					     GPI_SYS_SDIO1_CMD)>,
+				 <GPIOMUX(11, GPOUT_SYS_SDIO1_DATA0,
+					      GPOEN_SYS_SDIO1_DATA0,
+					      GPI_SYS_SDIO1_DATA0)>,
+				 <GPIOMUX(12, GPOUT_SYS_SDIO1_DATA1,
+					      GPOEN_SYS_SDIO1_DATA1,
+					      GPI_SYS_SDIO1_DATA1)>,
+				 <GPIOMUX(7, GPOUT_SYS_SDIO1_DATA2,
+					     GPOEN_SYS_SDIO1_DATA2,
+					     GPI_SYS_SDIO1_DATA2)>,
+				 <GPIOMUX(8, GPOUT_SYS_SDIO1_DATA3,
+					     GPOEN_SYS_SDIO1_DATA3,
+					     GPI_SYS_SDIO1_DATA3)>;
+			bias-pull-up;
+			drive-strength = <12>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+	};
+
 	spi0_pins: spi0-0 {
 		mosi-pins {
 			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index a608433200e8..18d4b60a7bbf 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -821,6 +821,38 @@ watchdog@13070000 {
 				 <&syscrg JH7110_SYSRST_WDT_CORE>;
 		};
 
+		mmc0: mmc@16010000 {
+			compatible = "starfive,jh7110-mmc";
+			reg = <0x0 0x16010000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
+				 <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
+			clock-names = "biu","ciu";
+			resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
+			reset-names = "reset";
+			interrupts = <74>;
+			fifo-depth = <32>;
+			fifo-watermark-aligned;
+			data-addr = <0>;
+			starfive,sysreg = <&sys_syscon 0x14 0x1a 0x7c000000>;
+			status = "disabled";
+		};
+
+		mmc1: mmc@16020000 {
+			compatible = "starfive,jh7110-mmc";
+			reg = <0x0 0x16020000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
+				 <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
+			clock-names = "biu","ciu";
+			resets = <&syscrg JH7110_SYSRST_SDIO1_AHB>;
+			reset-names = "reset";
+			interrupts = <75>;
+			fifo-depth = <32>;
+			fifo-watermark-aligned;
+			data-addr = <0>;
+			starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
+			status = "disabled";
+		};
+
 		gmac0: ethernet@16030000 {
 			compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
 			reg = <0x0 0x16030000 0x0 0x10000>;
-- 
2.34.1

