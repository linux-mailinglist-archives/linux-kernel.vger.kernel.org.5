Return-Path: <linux-kernel+bounces-54222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB3384AC66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F65B1C23C55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA57316F;
	Tue,  6 Feb 2024 02:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmUdgTyx"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61F6E2B9;
	Tue,  6 Feb 2024 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187961; cv=none; b=gvMYTV/TRGeBS/wVV4/DOX9TlOk7C3/hx9UmaRLtzAlFMQHByuaj6iOZoMERmdvY6uqjYSTk3E+mW3FrETshd8L2qye+pqlIFsWCMJoL2Aq+NtZEbBboM2bvEVHOyL11D2Dd9H2bNpzLoUQKPPCmpQHxcUouVgMUZ7pzP2olxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187961; c=relaxed/simple;
	bh=VyizzXBnuSh2yCZo5Q9pqxckyk6aljdMhXbyB44HoPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITpvsGbFFKJosbKqK+wsCfxERFOM4pxZNsVUXD5kMSlW+/sjuayJkXx8HBqjzS92sBbW1OBX18FbzA/e/Xj2wHPTwTH7IbWRflLDp4lvPboyzrRZLHXpU3f0bJKJgnaF9ViXx7RfblFDF4oOdJEDjlwRmoRXwCdJcM9pdd/057A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmUdgTyx; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e2b05edd46so63821a34.2;
        Mon, 05 Feb 2024 18:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707187958; x=1707792758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URtUqdMbVJrpdv6ULH02uflW1yxi0rUp9KzQmw/RnEI=;
        b=NmUdgTyxqCPzcgUZ9MmM7MIvlHzF7s+okyAf4gjB3+l8DV6rKpDD0791SOFO7YprpT
         Kmy+hR0pr4J4tWDGCgxNvO2Uhvu48ATI8L9Kvb8jrfpCWr4g1WfWW4nby3HcFCO3jjbQ
         7c83xfmDmDQ0YMXn/4P38YaF++tG7p1N6mospDs1FRHiHsaUk8o/5jgzuI2L5tUxwayo
         4vPE+7tNTRx4cZgdedYlbkHAd9A3xywzYT4DVCEkWjyOpjUNfebo8WEwrC76Cja3N8rB
         CppDj9Q7LiDUtNrK+RxfpDBKRhxxXi6dtMLxKjbu7vNF8qkHICvM290WGC9qArR41pZc
         zw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187958; x=1707792758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URtUqdMbVJrpdv6ULH02uflW1yxi0rUp9KzQmw/RnEI=;
        b=Vq0UaZFBwIUpHAZUy0g9cqolW5DMv4baT7dDsYk3OBSDu2R0B7+9wHelp3nt4WkTRn
         6g8uBrRp7Q1WbHT00x9U2vneTELwq6EwwkkbiHpJJy11iK6gLpOrcKYXlSCWTofoNHUI
         tsmqqWcr76rRV9QSGkK9RgArIQS4w/ia+Vi4qzJB2HPAoleZgyz9F7IZ5CnTEaL4oO+y
         X5nqPe02V5W+a89aJffE7WqmrQ+CKDLoGpDToaUaIVI7Mkrtr4rA5OQjROxicuR8qp37
         AY/OMCxDndHzCCg0ma9rifDCclu2HrVyRwfhWWgqzTlkceFfopY44P6TgnBs/g1+elbA
         xUpQ==
X-Gm-Message-State: AOJu0Yxc6B+JauernuFrnmrSWsTlzfn0zM6biPBz+3AvPlyJdZ6JYVhb
	nPzhhUgaRHfr1fiBTR043YmU1Lbk6pwuKYa+3PLE3RVLWUk9uwVK/hW/NLLt
X-Google-Smtp-Source: AGHT+IHs70GfXpuEkVtmSMfDwWunflNcWpdgsCUvBGLQrkSMQC4l0pbUf8kOzh9UkmEj4DFgPUZc+Q==
X-Received: by 2002:a05:6808:13c5:b0:3bf:cf6c:8de2 with SMTP id d5-20020a05680813c500b003bfcf6c8de2mr1760418oiw.40.1707187958583;
        Mon, 05 Feb 2024 18:52:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUCL9rQhkvArblM5b61CjuvcBX6d/oe7pHnXda/QmqqC0aUUAXEfeJZRr46Zqsh8Bx/n933emIAVY7JNdaga+fyVwGYXUs2qrGnPrpX5iZj32yN6nxr8ueOAEmagqrpY+j9slJ6G0dB5hmEDs32tgtCzcKyPGf6bsC3GyVvRE06lNpF3zOBslDtHAtMrR7kUMr96+vLlZRbSafdQCRGLLbBBNaJasBbS7UNTeHBds8yHMBHwqOdc41ZgokXn6Dx/OZxS/xG96BpJ/pOe8yJC+xxJ2PSiYnUn+bTCLvVjqlfsHcSJipg1U3JXSu0Q9GaPD/0aHIb1xSZZIZ0Wy4hQu8wwTAKiDslkfY4GtYp5O2RfffqRhJdBz1f8CqqLqjGwAldwqAbVUR3z3w=
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id gx22-20020a056a001e1600b006d94291679asm622542pfb.78.2024.02.05.18.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:52:38 -0800 (PST)
From: Jacky Huang <ychuang570808@gmail.com>
To: linus.walleij@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com
Subject: [PATCH v4 3/4] arm64: dts: nuvoton: Add pinctrl support for ma35d1
Date: Tue,  6 Feb 2024 02:52:22 +0000
Message-Id: <20240206025223.35147-4-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206025223.35147-1-ychuang570808@gmail.com>
References: <20240206025223.35147-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

Add 'pinctrl' node and 'gpioa' ~ 'gpion' nodes to the dtsi of ma35d1
SoC and describe default pin configurations.

Enable all UART nodes presented on som and iot boards, and add pinctrl
function settings to these nodes.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  80 +++++++++-
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  83 +++++++++-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 150 +++++++++++++++++-
 3 files changed, 304 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index b89e2be6abae..9482bec1aa57 100644
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
@@ -54,3 +54,75 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&pinctrl {
+	uart-grp {
+		pinctrl_uart0: uart0-pins {
+			nuvoton,pins = <4 14 1>,
+				       <4 15 1>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart10: uart10-pins {
+			nuvoton,pins = <7 4 2>,
+				       <7 5 2>,
+				       <7 6 2>,
+				       <7 7 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart12: uart12-pins {
+			nuvoton,pins = <2 13 2>,
+				       <2 14 2>,
+				       <2 15 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart13: uart13-pins {
+			nuvoton,pins = <7 12 3>,
+				       <7 13 3>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart14: uart14-pins {
+			nuvoton,pins = <7 14 2>,
+				       <7 15 2>;
+			bias-disable;
+			power-source = <1>;
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
index a1ebddecb7f8..f6f20a17e501 100644
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
@@ -54,3 +54,78 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&pinctrl {
+	uart-grp {
+		pinctrl_uart0: uart0-pins {
+			nuvoton,pins = <4 14 1>,
+				       <4 15 1>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart11: uart11-pins {
+			nuvoton,pins = <11 0 2>,
+				       <11 1 2>,
+				       <11 2 2>,
+				       <11 3 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart12: uart12-pins {
+			nuvoton,pins = <8 1 2>,
+				       <8 2 2>,
+				       <8 3 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart14: uart14-pins {
+			nuvoton,pins = <8 5 2>,
+				       <8 6 2>,
+				       <8 7 2>;
+			bias-disable;
+			power-source = <1>;
+		};
+
+		pinctrl_uart16: uart16-pins {
+			nuvoton,pins = <10 0 2>,
+				       <10 1 2>,
+				       <10 2 2>,
+				       <10 3 2>;
+			bias-disable;
+			power-source = <1>;
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
index 781cdae566a0..5f366f4c7fde 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -83,7 +83,7 @@ soc {
 		ranges;
 
 		sys: system-management@40460000 {
-			compatible = "nuvoton,ma35d1-reset";
+			compatible = "nuvoton,ma35d1-reset", "syscon";
 			reg = <0x0 0x40460000 0x0 0x200>;
 			#reset-cells = <1>;
 		};
@@ -95,6 +95,154 @@ clk: clock-controller@40460200 {
 			clocks = <&clk_hxt>;
 		};
 
+		pinctrl: pinctrl@40040000 {
+			compatible = "nuvoton,ma35d1-pinctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			nuvoton,sys = <&sys>;
+			ranges = <0x0 0x0 0x40040000 0xc00>;
+
+			gpioa: gpio@0 {
+				reg = <0x0 0x40>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPA_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiob: gpio@40 {
+				reg = <0x40 0x40>;
+				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPB_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioc: gpio@80 {
+				reg = <0x80 0x40>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPC_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiod: gpio@c0 {
+				reg = <0xc0 0x40>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPD_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioe: gpio@100 {
+				reg = <0x100 0x40>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPE_GATE>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiof: gpio@140 {
+				reg = <0x140 0x40>;
+				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPF_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiog: gpio@180 {
+				reg = <0x180 0x40>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPG_GATE>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioh: gpio@1c0 {
+				reg = <0x1c0 0x40>;
+				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPH_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioi: gpio@200 {
+				reg = <0x200 0x40>;
+				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPI_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioj: gpio@240 {
+				reg = <0x240 0x40>;
+				interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPJ_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiok: gpio@280 {
+				reg = <0x280 0x40>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPK_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiol: gpio@2c0 {
+				reg = <0x2c0 0x40>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPL_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiom: gpio@300 {
+				reg = <0x300 0x40>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPM_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpion: gpio@340 {
+				reg = <0x340 0x40>;
+				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk GPN_GATE>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
+
 		uart0: serial@40700000 {
 			compatible = "nuvoton,ma35d1-uart";
 			reg = <0x0 0x40700000 0x0 0x100>;
-- 
2.34.1


