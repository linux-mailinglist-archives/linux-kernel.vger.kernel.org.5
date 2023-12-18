Return-Path: <linux-kernel+bounces-4153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0471817886
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4342D283DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C81F72067;
	Mon, 18 Dec 2023 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HSQZsWPF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231131E4BF;
	Mon, 18 Dec 2023 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88F362000B;
	Mon, 18 Dec 2023 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702920010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JT0DcVH4FYgIj1FT5JoVaRhNHTajfdKgAuI0ECPU2cM=;
	b=HSQZsWPFzVpwIv6jd6yGxe44rUiH+xlZ/XIsbvHO1ryhvpkcYPF/0NEN8YXkliGsXjiA9z
	XnmUcj6/FNOmna4hqvWEQV4myRcHiVuGLhqLQBYtTP+6ByMz4FSxgYrGLEi+AqgYdtVSzh
	H6ZC3afVmZTslOOmqDsttGmelzhQ9YPJZPSbirwtXNJo7JU13cVo2NbfH0GFZTsZlnBaU7
	HMTX39qfmn2fI2+g28yP0X0LEiYm7FPEo2Soe++a8z0iqYsyVGsPUq2LS/ldrD2QEtQSyy
	nZlF3OxXFymfiCto+26iVKsYjhDQuF5wj+f94nQ8vOT06YmRRWBinGdsKbdt9g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 18 Dec 2023 18:19:48 +0100
Subject: [PATCH 3/4] MIPS: mobileye: eyeq5: add pinctrl nodes & pinmux
 function nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231218-mbly-pinctrl-v1-3-2f7d366c2051@bootlin.com>
References: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
In-Reply-To: <20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Pins on this platform have two functions: GPIO or something-else. We
create function nodes for each something-else based on functions.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi | 128 ++++++++++++++++++++++++++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi      |  11 +++
 2 files changed, 139 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi b/arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi
new file mode 100644
index 000000000000..33df4a021863
--- /dev/null
+++ b/arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+/*
+ * Default pin configuration for Mobileye EyeQ5 boards. We mostly create one
+ * pin configuration node per function.
+ */
+
+&pinctrl0 {
+	timer0_pins: timer0-pins {
+		function = "timer0";
+		pins = "PA0", "PA1";
+	};
+	timer1_pins: timer1-pins {
+		function = "timer1";
+		pins = "PA2", "PA3";
+	};
+	timer2_pins: timer2-pins {
+		function = "timer2";
+		pins = "PA4", "PA5";
+	};
+	pps0_pins: pps0-pin {
+		function = "timer2";
+		pins = "PA4";
+	};
+	pps1_pins: pps1-pin {
+		function = "timer2";
+		pins = "PA5";
+	};
+	timer5_ext_pins: timer5-ext-pins {
+		function = "timer5";
+		pins = "PA6", "PA7", "PA8", "PA9";
+	};
+	timer5_ext_input_pins: timer5-ext-input-pins {
+		function = "timer5";
+		pins = "PA6", "PA7";
+	};
+	timer5_ext_incap_a_pins: timer5-ext-incap-a-pin {
+		function = "timer5";
+		pins = "PA6";
+	};
+	timer5_ext_incap_b_pins: timer5-ext-incap-b-pin {
+		function = "timer5";
+		pins = "PA7";
+	};
+	can0_pins: can0-pins {
+		function = "can0";
+		pins = "PA14", "PA15";
+	};
+	can1_pins: can1-pins {
+		function = "can1";
+		pins = "PA16", "PA17";
+	};
+	uart0_pins: uart0-pins {
+		function = "uart0";
+		pins = "PA10", "PA11";
+	};
+	uart1_pins: uart1-pins {
+		function = "uart1";
+		pins = "PA12", "PA13";
+	};
+	spi0_pins: spi0-pins {
+		function = "spi0";
+		pins = "PA18", "PA19", "PA20", "PA21", "PA22";
+	};
+	spi1_pins: spi1-pins {
+		function = "spi1";
+		pins = "PA23", "PA24", "PA25", "PA26", "PA27";
+	};
+	spi1_slave_pins: spi1-slave-pins {
+		function = "spi1";
+		pins = "PA24", "PA25", "PA26";
+	};
+	refclk0_pins: refclk0-pin {
+		function = "refclk0";
+		pins = "PA28";
+	};
+};
+
+&pinctrl1 {
+	timer3_pins: timer3-pins {
+		function = "timer3";
+		pins = "PB0", "PB1";
+	};
+	timer4_pins: timer4-pins {
+		function = "timer4";
+		pins = "PB2", "PB3";
+	};
+	timer6_ext_pins: timer6-ext-pins {
+		function = "timer6";
+		pins = "PB4", "PB5", "PB6", "PB7";
+	};
+	timer6_ext_input_pins: timer6-ext-input-pins {
+		function = "timer6";
+		pins = "PB4", "PB5";
+	};
+	timer6_ext_incap_a_pins: timer6-ext-incap-a-pin {
+		function = "timer6";
+		pins = "PB4";
+	};
+	timer6_ext_incap_b_pins: timer6-ext-incap-b-pin {
+		function = "timer6";
+		pins = "PB5";
+	};
+	can2_pins: can2-pins {
+		function = "can2";
+		pins = "PB10", "PB11";
+	};
+	uart2_pins: uart2-pins {
+		function = "uart2";
+		pins = "PB8", "PB9";
+	};
+	spi2_pins: spi2-pins {
+		function = "spi2";
+		pins = "PB12", "PB13", "PB14", "PB15", "PB16";
+	};
+	spi3_pins: spi3-pins {
+		function = "spi3";
+		pins = "PB17", "PB18", "PB19", "PB20", "PB21";
+	};
+	spi3_slave_pins: spi3-slave-pins {
+		function = "spi3";
+		pins = "PB18", "PB19", "PB20";
+	};
+	mclk0_pins: mclk0-pin {
+		function = "mclk0";
+		pins = "PB22";
+	};
+};
diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index 746148eb423f..def9e9645dac 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -85,6 +85,16 @@ reset: reset-controller {
 				compatible = "mobileye,eyeq5-reset";
 				#reset-cells = <2>;
 			};
+
+			pinctrl0: pinctrl0 {
+				compatible = "mobileye,eyeq5-a-pinctrl";
+				#pinctrl-cells = <1>;
+			};
+
+			pinctrl1: pinctrl1 {
+				compatible = "mobileye,eyeq5-b-pinctrl";
+				#pinctrl-cells = <1>;
+			};
 		};
 
 		gic: interrupt-controller@140000 {
@@ -110,3 +120,4 @@ timer {
 	};
 };
 
+#include "eyeq5-pins.dtsi"

-- 
2.43.0


