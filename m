Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8FE751C79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjGMJAr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 05:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjGMJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:00:26 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04D81BEB;
        Thu, 13 Jul 2023 02:00:21 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 01AE882EB;
        Thu, 13 Jul 2023 17:00:19 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Jul
 2023 17:00:19 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 13 Jul 2023 17:00:18 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v2 3/3] riscv: dts: starfive: Add spi node for JH7110 SoC
Date:   Thu, 13 Jul 2023 17:00:15 +0800
Message-ID: <20230713090015.127541-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713090015.127541-1-william.qiu@starfivetech.com>
References: <20230713090015.127541-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spi node for JH7110 SoC.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 50 ++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 98 +++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index fa0061eb33a7..ae3f39c33d3c 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -143,6 +143,18 @@ &i2c6 {
 	status = "okay";
 };
 
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	status = "okay";
+
+	spi_dev0: flash@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
 &sysgpio {
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
@@ -200,6 +212,44 @@ GPOEN_SYS_I2C6_DATA,
 		};
 	};
 
+	spi0_pins: spi0-0 {
+		mosi-pins {
+			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		miso-pins {
+			pinmux = <GPIOMUX(53, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_SPI0_RXD)>;
+			bias-pull-up;
+			input-enable;
+			input-schmitt-enable;
+		};
+
+		sck-pins {
+			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_CLK,
+					      GPOEN_ENABLE,
+					      GPI_SYS_SPI0_CLK)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		ss-pins {
+			pinmux = <GPIOMUX(48, GPOUT_SYS_SPI0_FSS,
+					      GPOEN_ENABLE,
+					      GPI_SYS_SPI0_FSS)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+	};
+
 	uart0_pins: uart0-0 {
 		tx-pins {
 			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index ec2e70011a73..13da297c18fe 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -386,6 +386,48 @@ i2c2: i2c@10050000 {
 			status = "disabled";
 		};
 
+		spi0: spi@10060000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0x10060000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SPI0_APB>;
+			clock-names = "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_SPI0_APB>;
+			interrupts = <38>;
+			arm,primecell-periphid = <0x00041022>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi1: spi@10070000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0x10070000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SPI1_APB>;
+			clock-names = "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_SPI1_APB>;
+			interrupts = <39>;
+			arm,primecell-periphid = <0x00041022>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi2: spi@10080000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0x10080000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SPI2_APB>;
+			clock-names = "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_SPI2_APB>;
+			interrupts = <40>;
+			arm,primecell-periphid = <0x00041022>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		uart3: serial@12000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x12000000 0x0 0x10000>;
@@ -473,6 +515,62 @@ i2c6: i2c@12060000 {
 			status = "disabled";
 		};
 
+		spi3: spi@12070000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0x12070000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SPI3_APB>;
+			clock-names = "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_SPI3_APB>;
+			interrupts = <52>;
+			arm,primecell-periphid = <0x00041022>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi4: spi@12080000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0x12080000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SPI4_APB>;
+			clock-names = "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_SPI4_APB>;
+			interrupts = <53>;
+			arm,primecell-periphid = <0x00041022>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi5: spi@12090000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0x12090000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SPI5_APB>;
+			clock-names = "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_SPI5_APB>;
+			interrupts = <54>;
+			arm,primecell-periphid = <0x00041022>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi6: spi@120a0000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x0 0x120A0000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_SPI6_APB>;
+			clock-names = "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_SPI6_APB>;
+			interrupts = <55>;
+			arm,primecell-periphid = <0x00041022>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		syscrg: clock-controller@13020000 {
 			compatible = "starfive,jh7110-syscrg";
 			reg = <0x0 0x13020000 0x0 0x10000>;
-- 
2.34.1

