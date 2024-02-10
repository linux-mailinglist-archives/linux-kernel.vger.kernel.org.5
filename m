Return-Path: <linux-kernel+bounces-60216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5C85018F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AA128AF96
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5B5692;
	Sat, 10 Feb 2024 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEjIDAMh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFE20EB;
	Sat, 10 Feb 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528079; cv=none; b=N2zA5i4HmpQYLIQvsWXoP/+RYNKv3BgHg3z3N7W9vNIBkbdj98MYINr5EAMsG5H9kLc1ZX3XS7fCg29LWk5tt74cl/wMkjwAoFE/TxtIxjwNI8DEO4VpFM3Dlm+/9ezF9do/hb+4MyLiulV2nFD3PI/K3cQk17HuvxX1Akj9/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528079; c=relaxed/simple;
	bh=FcvijwUU2lP+Mh0G39gT/Vb2K87CdhRBfFkJeTBo9gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYGnKSripB48ef6o7YwMrZBTrJ12/TX7Svr5eizFcgbU2DQ+oE1yakb9FdJbC8mNKx0nbFLrxc8ir2mR0G8jYkFminN4M0WERCDBvVctP9gxVNkoGtSlmGfFE8VXev4fAjqCiuff44drEzUjms7aZSxMvCQBkMXe5TSncTnGZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEjIDAMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB2DC43399;
	Sat, 10 Feb 2024 01:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528078;
	bh=FcvijwUU2lP+Mh0G39gT/Vb2K87CdhRBfFkJeTBo9gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fEjIDAMhwu90whUHMA2NejGkJ7Hma651gq4lUx3fJwSeNqDn0GFrgqz+tyOR22Dpc
	 STl0tyOHaYPIq+LTy1rhVUq2A+9QOdH48zzsT/SrZb1NrTY7rEWxPmSNp9s9nB89Ts
	 k5F97QE0tszacPknht2eb0zDlPyI6pRg+zT0lshgFx0ICxc5o+fsIZa7yodBhpDGYn
	 JDuQY6nSHnYNeP5L9KMtm5F6ymYBXguGjPikwv5oDhCvTIYA1trESKlw6SYpESxtD0
	 D1msUpUBWBKt7W0vpwizm64gOPzkvGmWEN6wUr1iJs8DbH5S1QRBMwynAWFVngIBb+
	 CXAi/p4ghROCw==
Received: by mercury (Postfix, from userid 1000)
	id DD4D71068AF6; Sat, 10 Feb 2024 02:21:15 +0100 (CET)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/14] dt-bindings: input: touchscreen: fsl,imx6ul-tsc convert to YAML
Date: Sat, 10 Feb 2024 02:18:08 +0100
Message-ID: <20240210012114.489102-5-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210012114.489102-1-sre@kernel.org>
References: <20240210012114.489102-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the i.MX6UL touchscreen DT binding to YAML.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../input/touchscreen/fsl,imx6ul-tsc.yaml     | 92 +++++++++++++++++++
 .../bindings/input/touchscreen/imx6ul_tsc.txt | 38 --------
 2 files changed, 92 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
new file mode 100644
index 000000000000..db18f24978b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
@@ -0,0 +1,92 @@
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
+  xnur-gpio:
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
+    description: Number of data samples which are averaged for each read.
+    enum: [ 1, 4, 8, 16, 32 ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - xnur-gpio
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx6ul-clock.h>
+    #include <dt-bindings/gpio/gpio.h>
+    tsc: tsc@2040000 {
+        compatible = "fsl,imx6ul-tsc";
+        reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
+        interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6UL_CLK_IPG>,
+                 <&clks IMX6UL_CLK_ADC2>;
+        clock-names = "tsc", "adc";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_tsc>;
+        xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
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


