Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1F7FB1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbjK1GLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbjK1GLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:11:30 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32FDD6D;
        Mon, 27 Nov 2023 22:11:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfc985c92dso16924065ad.0;
        Mon, 27 Nov 2023 22:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701151894; x=1701756694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRa17WZLUC24HKUHdpci3trSEQpdoaDeITWDqryGqws=;
        b=l7ZhPC+xFQVqGlJNJGgpQfLz+IliTfFEF0h+aBdAT1RAzfCz5/O6buoMhyONx//UZF
         HmYYM83iP8ORzfmXheYumb6N5aZFMxPF0lM7n5o8PT1AGSPWjsZx4cziDu1WmUDZz852
         nwIqnR0WRcDyfeRkyYapgvWBf29qLUEncKsD4p3cM1F4d48ZoDPVia8xZVYSiw+guqjv
         78PWdMrdRNXbHvTccB4UbJ14cWqoHPCXGQ3KOvqlaacpkxMT2UvmShvKitMPCuE4qaF6
         HLx9z753iIEnHBZGI5g6A8S1spP5yctaTLgCB9NX8bnMTOU3WuBtoqo2v0VIPffHgunu
         RkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701151894; x=1701756694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRa17WZLUC24HKUHdpci3trSEQpdoaDeITWDqryGqws=;
        b=uEoCHBgg/UZyyr7oWeHLF9QXsHZqZdQHwlsAlXsFPLgSIU+YGrZo/9jtUihUkSYtMz
         yjbxtP20Ws9Qs4yx+Xmqex76dQd63Ws7INBI+S0oRJo3klfKPd50O5uk0QYOSEDEWq05
         PJjgOlMDFKaiZpj9pf1y9J4EHcp/rUsiZh+ml4u3eViFTL0pF8I5cwghTKwJmCNxdnjK
         Uk0RhwYMknSuzsdzxjyJkR+lkJduIueqpITpbZoPm9II7+D+wRy4fRCPbZeHnYL0GYMg
         wm1nfM8oiETqZcZKxlbArN5x5KuwRvoEdHbqhFSJNtqq8VT3pNMKdFj1g7l35wczX2Su
         hIYg==
X-Gm-Message-State: AOJu0YwT0iVaeGtSFQXF43u2PdPa2bdD3tK0d8w+WL0JewKruXNeuMF2
        ML5Uq/EUJMfRr8qfKAL+10REM14f67A=
X-Google-Smtp-Source: AGHT+IHoiYPYg6iAPX5ChbAKJpgZ8WtKV9FhnGebbhnizcIF1wyG1g8oRNFiSSYZCcEBTBLztGJKHQ==
X-Received: by 2002:a17:902:d2c5:b0:1cf:cd73:557 with SMTP id n5-20020a170902d2c500b001cfcd730557mr6221600plc.14.1701151894222;
        Mon, 27 Nov 2023 22:11:34 -0800 (PST)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001c73f3a9b7fsm9402694plb.185.2023.11.27.22.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:11:33 -0800 (PST)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
Subject: [PATCH v2 3/4] arm64: dts: nuvoton: Add pinctrl support for ma35d1
Date:   Tue, 28 Nov 2023 06:11:17 +0000
Message-Id: <20231128061118.575847-4-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128061118.575847-1-ychuang570808@gmail.com>
References: <20231128061118.575847-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add 'pinctrl' node and 'gpioa' ~ 'gpion' nodes to the dtsi of ma35d1
SoC and describe default pin configurations.

Enable all UART nodes presented on som and iot boards, and add pinctrl
function settings to these nodes.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  70 +++++++-
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  73 +++++++-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 159 +++++++++++++++++-
 3 files changed, 293 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index b89e2be6abae..74a85c23c26b 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -14,6 +14,10 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		serial10 = &uart10;
+		serial12 = &uart12;
+		serial13 = &uart13;
+		serial14 = &uart14;
 	};
 
 	chosen {
@@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
 &clk {
 	assigned-clocks = <&clk CAPLL>,
 			  <&clk DDRPLL>,
@@ -54,3 +54,65 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&pinctrl {
+	uart-grp {
+		pinctrl_uart0: uart0-pins {
+			nuvoton,pins = <4 14 1 &pcfg_default>,
+				       <4 15 1 &pcfg_default>;
+		};
+
+		pinctrl_uart10: uart10-pins {
+			nuvoton,pins = <7 4 2 &pcfg_default>,
+				       <7 5 2 &pcfg_default>,
+				       <7 6 2 &pcfg_default>,
+				       <7 7 2 &pcfg_default>;
+		};
+
+		pinctrl_uart12: uart12-pins {
+			nuvoton,pins = <2 13 2 &pcfg_default>,
+				       <2 14 2 &pcfg_default>,
+				       <2 15 2 &pcfg_default>;
+		};
+
+		pinctrl_uart13: uart13-pins {
+			nuvoton,pins = <7 12 3 &pcfg_default>,
+				       <7 13 3 &pcfg_default>;
+		};
+
+		pinctrl_uart14: uart14-pins {
+			nuvoton,pins = <7 14 2 &pcfg_default>,
+				       <7 15 2 &pcfg_default>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart10 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart10>;
+	status = "okay";
+};
+
+&uart12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart12>;
+	status = "okay";
+};
+
+&uart13 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart13>;
+	status = "okay";
+};
+
+&uart14 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart14>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index a1ebddecb7f8..2cd11e2b2067 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -14,6 +14,10 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		serial11 = &uart11;
+		serial12 = &uart12;
+		serial14 = &uart14;
+		serial16 = &uart16;
 	};
 
 	chosen {
@@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
 &clk {
 	assigned-clocks = <&clk CAPLL>,
 			  <&clk DDRPLL>,
@@ -54,3 +54,68 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&pinctrl {
+	uart-grp {
+		pinctrl_uart0: uart0-pins {
+			nuvoton,pins = <4 14 1 &pcfg_default>,
+				       <4 15 1 &pcfg_default>;
+		};
+
+		pinctrl_uart11: uart11-pins {
+			nuvoton,pins = <11 0 2 &pcfg_default>,
+				       <11 1 2 &pcfg_default>,
+				       <11 2 2 &pcfg_default>,
+				       <11 3 2 &pcfg_default>;
+		};
+
+		pinctrl_uart12: uart12-pins {
+			nuvoton,pins = <8 1 2 &pcfg_default>,
+				       <8 2 2 &pcfg_default>,
+				       <8 3 2 &pcfg_default>;
+		};
+
+		pinctrl_uart14: uart14-pins {
+			nuvoton,pins = <8 5 2 &pcfg_default>,
+				       <8 6 2 &pcfg_default>,
+				       <8 7 2 &pcfg_default>;
+		};
+
+		pinctrl_uart16: uart16-pins {
+			nuvoton,pins = <10 0 2 &pcfg_default>,
+				       <10 1 2 &pcfg_default>,
+				       <10 2 2 &pcfg_default>,
+				       <10 3 2 &pcfg_default>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&uart11 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart11>;
+	status = "okay";
+};
+
+&uart12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart12>;
+	status = "okay";
+};
+
+&uart14 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart14>;
+	status = "okay";
+};
+
+&uart16 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart16>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 781cdae566a0..a93bce545f5f 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
 #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+#include <dt-bindings/pinctrl/ma35d1-pinfunc.h>
 
 / {
 	compatible = "nuvoton,ma35d1";
@@ -83,7 +84,7 @@ soc {
 		ranges;
 
 		sys: system-management@40460000 {
-			compatible = "nuvoton,ma35d1-reset";
+			compatible = "nuvoton,ma35d1-reset", "syscon";
 			reg = <0x0 0x40460000 0x0 0x200>;
 			#reset-cells = <1>;
 		};
@@ -95,6 +96,162 @@ clk: clock-controller@40460200 {
 			clocks = <&clk_hxt>;
 		};
 
+		pinctrl: pinctrl@40040000 {
+			compatible = "nuvoton,ma35d1-pinctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			nuvoton,sys = <&sys>;
+			ranges = <0x0 0x0 0x40040000 0xc00>;
+
+			gpioa: gpio@40040000 {
+				reg = <0x0 0x40>;
+				interrupts = <GIC_SPI  14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPA_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiob: gpio@40040040 {
+				reg = <0x40 0x40>;
+				interrupts = <GIC_SPI  15 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPB_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioc: gpio@40040080 {
+				reg = <0x80 0x40>;
+				interrupts = <GIC_SPI  16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPC_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiod: gpio@400400c0 {
+				reg = <0xc0 0x40>;
+				interrupts = <GIC_SPI  17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPD_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioe: gpio@40040100 {
+				reg = <0x100 0x40>;
+				interrupts = <GIC_SPI  73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPE_GATE>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiof: gpio@40040140 {
+				reg = <0x140 0x40>;
+				interrupts = <GIC_SPI  74 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPF_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiog: gpio@40040180 {
+				reg = <0x180 0x40>;
+				interrupts = <GIC_SPI  75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPG_GATE>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioh: gpio@400401c0 {
+				reg = <0x1c0 0x40>;
+				interrupts = <GIC_SPI  76 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPH_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioi: gpio@40040200 {
+				reg = <0x200 0x40>;
+				interrupts = <GIC_SPI  77 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPI_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioj: gpio@40040240 {
+				reg = <0x240 0x40>;
+				interrupts = <GIC_SPI  78 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPJ_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiok: gpio@40040280 {
+				reg = <0x280 0x40>;
+				interrupts = <GIC_SPI  102 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPK_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiol: gpio@400402c0 {
+				reg = <0x2c0 0x40>;
+				interrupts = <GIC_SPI  103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPL_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiom: gpio@40040300 {
+				reg = <0x300 0x40>;
+				interrupts = <GIC_SPI  104 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPM_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpion: gpio@40040340 {
+				reg = <0x340 0x40>;
+				interrupts = <GIC_SPI  105 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPN_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			pcfg_default: pin-default {
+				slew-rate = <0>;
+				input-schmitt-disable;
+				bias-disable;
+				power-source = <1>;
+				drive-strength = <17100>;
+			};
+		};
+
 		uart0: serial@40700000 {
 			compatible = "nuvoton,ma35d1-uart";
 			reg = <0x0 0x40700000 0x0 0x100>;
-- 
2.34.1

