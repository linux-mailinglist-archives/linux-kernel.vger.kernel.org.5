Return-Path: <linux-kernel+bounces-79861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CF48627C0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A523B1F21F33
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486594DA0F;
	Sat, 24 Feb 2024 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HautrxRg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5064CDFB;
	Sat, 24 Feb 2024 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810393; cv=none; b=kHlQm6QJQPn8FZl0zV68IyfE5T/KLF/GYnCIGzH7zkRKgd97HlcQ4RCV7+pJT1HqyOueV5N7DvbuWth8xQy7CIB+pCJkQ20lwaazi0bY6606EVnVIca3HdlpJ9ggIrzYYRvoWHSLn6GAR4+XJ7XPPPzHWoc2hjeIUSXCVHyB9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810393; c=relaxed/simple;
	bh=wsCtGpiDTocW4vbleg11KHxRFROoKpRqbaZuvc+TfiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dX6MJ3lS3ATeU1v4MdNk8/PJx6puKwNYJhic7sHLn/AQjhnRIHDSiE4dl80feDm+iZEs2JKQf3J1bBhe/qUcrKSozdk+yVHbn14DL26WHlts5wjUwKK7QPJ+H8Pxgek3+WypMuXmixv2yIMr+NG20kKDq6vTFXXAo+flEtVjiAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HautrxRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C80C43390;
	Sat, 24 Feb 2024 21:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708810393;
	bh=wsCtGpiDTocW4vbleg11KHxRFROoKpRqbaZuvc+TfiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HautrxRg2EjpVUHAPlVkDDD1i0dNFdPJiHpJ8CXRgFetwTw3/SBIGbrHK5dSLaUMJ
	 3Kx3WKnE7sbz1JJQMdxKjYrQAcCgPFFSfTZRCZeWrYw6gBH6OEFlhHGKDTUPBXDhOH
	 40ZYUKCYUmOugWcQLsOB36xd5cNWNi3NL8oohsQ/BnHNMMT+v7ejGwsm3xCtN+CirL
	 j+yNySWRznMgKrg/V7BG7NwtgISOY6uxSeTigGQ0Cujb82sUEtquQK2SxXRBFOwTar
	 heifzNvUOxMSnUO/BP2yuJ6axbFeE+/iihG2SHQJhXRl1PYvuQqBhG1ODPW3cxTmse
	 G4F6QVCWvZnJg==
Received: by mercury (Postfix, from userid 1000)
	id EBB9A1060DAA; Sat, 24 Feb 2024 22:33:09 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 03/16] dt-bindings: input: touchscreen: fsl,imx6ul-tsc convert to YAML
Date: Sat, 24 Feb 2024 22:29:35 +0100
Message-ID: <20240224213240.1854709-4-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224213240.1854709-1-sre@kernel.org>
References: <20240224213240.1854709-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the i.MX6UL touchscreen DT binding to YAML.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../input/touchscreen/fsl,imx6ul-tsc.yaml     | 97 +++++++++++++++++++
 .../bindings/input/touchscreen/imx6ul_tsc.txt | 38 --------
 2 files changed, 97 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
new file mode 100644
index 000000000000..678756ad0f92
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/fsl,imx6ul-tsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX6UL Touch Controller
+
+maintainers:
+  - Haibo Chen <haibo.chen@nxp.com>
+  - Shawn Guo <shawnguo@kernel.org>
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+properties:
+  compatible:
+    const: fsl,imx6ul-tsc
+
+  reg:
+    items:
+      - description: touch controller address
+      - description: ADC2 address
+
+  interrupts:
+    items:
+      - description: touch controller address
+      - description: ADC2 address
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: tsc
+      - const: adc
+
+  xnur-gpios:
+    maxItems: 1
+    description:
+      The X- gpio this controller connect to. This xnur-gpio returns to
+      low once the finger leave the touch screen (The last touch event
+      the touch controller capture).
+
+  measure-delay-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The value of measure delay time. Before X-axis or Y-axis measurement,
+      the screen need some time before even potential distribution ready.
+    default: 0xffff
+    minimum: 0
+    maximum: 0xffffff
+
+  pre-charge-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The touch screen need some time to precharge.
+    default: 0xfff
+    minimum: 0
+    maximum: 0xffffffff
+
+  touchscreen-average-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of data samples which are averaged for each read.
+    enum: [ 1, 4, 8, 16, 32 ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - xnur-gpios
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx6ul-clock.h>
+    #include <dt-bindings/gpio/gpio.h>
+    touchscreen@2040000 {
+        compatible = "fsl,imx6ul-tsc";
+        reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
+        interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6UL_CLK_IPG>,
+                 <&clks IMX6UL_CLK_ADC2>;
+        clock-names = "tsc", "adc";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_tsc>;
+        xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
+        measure-delay-time = <0xfff>;
+        pre-charge-time = <0xffff>;
+        touchscreen-average-samples = <32>;
+    };
diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
deleted file mode 100644
index 164915004424..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-* Freescale i.MX6UL Touch Controller
-
-Required properties:
-- compatible: must be "fsl,imx6ul-tsc".
-- reg: this touch controller address and the ADC2 address.
-- interrupts: the interrupt of this touch controller and ADC2.
-- clocks: the root clock of touch controller and ADC2.
-- clock-names; must be "tsc" and "adc".
-- xnur-gpio: the X- gpio this controller connect to.
-  This xnur-gpio returns to low once the finger leave the touch screen (The
-  last touch event the touch controller capture).
-
-Optional properties:
-- measure-delay-time: the value of measure delay time.
-  Before X-axis or Y-axis measurement, the screen need some time before
-  even potential distribution ready.
-  This value depends on the touch screen.
-- pre-charge-time: the touch screen need some time to precharge.
-  This value depends on the touch screen.
-- touchscreen-average-samples: Number of data samples which are averaged for
-  each read. Valid values are 1, 4, 8, 16 and 32.
-
-Example:
-	tsc: tsc@2040000 {
-		compatible = "fsl,imx6ul-tsc";
-		reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
-		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clks IMX6UL_CLK_IPG>,
-			 <&clks IMX6UL_CLK_ADC2>;
-		clock-names = "tsc", "adc";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_tsc>;
-		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
-		measure-delay-time = <0xfff>;
-		pre-charge-time = <0xffff>;
-		touchscreen-average-samples = <32>;
-	};
-- 
2.43.0


