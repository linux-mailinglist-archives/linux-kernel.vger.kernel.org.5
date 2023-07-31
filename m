Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6C768A52
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGaD27 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 30 Jul 2023 23:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGaD2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:28:42 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EB1E6F;
        Sun, 30 Jul 2023 20:28:40 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9888524E225;
        Mon, 31 Jul 2023 11:28:34 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 31 Jul
 2023 11:28:34 +0800
Received: from ubuntu.localdomain (113.72.147.196) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 31 Jul
 2023 11:28:33 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] riscv: dts: starfive: Add JH7110 PWM-DAC support
Date:   Mon, 31 Jul 2023 11:28:29 +0800
Message-ID: <20230731032829.127864-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230731032829.127864-1-hal.feng@starfivetech.com>
References: <20230731032829.127864-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.196]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PWM-DAC support for StarFive JH7110 SoC.

Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 49 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 13 +++++
 2 files changed, 62 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index f874d31006a6..98373b743019 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -38,6 +38,33 @@ gpio-restart {
 		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
 		priority = <224>;
 	};
+
+	pwmdac_codec: pwmdac-codec {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
+	sound-pwmdac {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "left_j";
+			bitclock-master = <&sndcpu0>;
+			frame-master = <&sndcpu0>;
+
+			sndcpu0: cpu {
+				sound-dai = <&pwmdac>;
+			};
+
+			codec {
+				sound-dai = <&pwmdac_codec>;
+			};
+		};
+	};
 };
 
 &dvp_clk {
@@ -185,6 +212,12 @@ &i2c6 {
 	status = "okay";
 };
 
+&pwmdac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwmdac_pins>;
+	status = "okay";
+};
+
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
@@ -254,6 +287,22 @@ GPOEN_SYS_I2C6_DATA,
 		};
 	};
 
+	pwmdac_pins: pwmdac-0 {
+		pwmdac-pins {
+			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>,
+				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <2>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
 	spi0_pins: spi0-0 {
 		mosi-pins {
 			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 05f843b8ca03..7f508b4475e0 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -512,6 +512,19 @@ tdm: tdm@10090000 {
 			status = "disabled";
 		};
 
+		pwmdac: pwmdac@100b0000 {
+			compatible = "starfive,jh7110-pwmdac";
+			reg = <0x0 0x100b0000 0x0 0x1000>;
+			clocks = <&syscrg JH7110_SYSCLK_PWMDAC_APB>,
+				 <&syscrg JH7110_SYSCLK_PWMDAC_CORE>;
+			clock-names = "apb", "core";
+			resets = <&syscrg JH7110_SYSRST_PWMDAC_APB>;
+			dmas = <&dma 22>;
+			dma-names = "tx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		usb0: usb@10100000 {
 			compatible = "starfive,jh7110-usb";
 			ranges = <0x0 0x0 0x10100000 0x100000>;
-- 
2.38.1

