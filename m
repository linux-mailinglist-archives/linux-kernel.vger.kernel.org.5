Return-Path: <linux-kernel+bounces-82338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91035868306
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0661F24493
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D6C131E47;
	Mon, 26 Feb 2024 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdxR78Sr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69E12F593;
	Mon, 26 Feb 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982865; cv=none; b=F2A13jDYpLNu0+GLTbfJ/JnwVhF3BAJAQsUWTwwRtli5/XNRHQ7AhRJVMfepNIn38pklIUzSN8XsH4K7vxID0zGaX6ZHvaF4+ZnGdJ5icRILHsaLOs3sXmnX/CIVnjEiMiXgZ2EOg/iX87g128BHp+Q/Sgw9WHTufbA+dSFUeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982865; c=relaxed/simple;
	bh=W7KyzBkyJPOjERPAmGBasbk62LFaM6Pz/kkeIkNL5bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omypmVw2heKmMMgk2D014SaUL6z6CROYG/uU8wiM7OfBwVIGIfmOXyfZNvPOMTDDdz1IG6isJ/eKGdwWyqVSXOtZwnb1E3SJLZV9gveikACgsM4fC4bkHmdsm/c4THHfjcMRyTyD0t6RnxQvyGFQmo1I0Cb7Tu0yZaa0NxwEX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdxR78Sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32931C43399;
	Mon, 26 Feb 2024 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982865;
	bh=W7KyzBkyJPOjERPAmGBasbk62LFaM6Pz/kkeIkNL5bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdxR78SrpAa0TFYd0AyYylwTnUDbADZhRGR82OivyPEdJBsBV3Ckquq7C15t+838f
	 DF/MxqCs3zaCE9lDrMSzMu67+D2GaEoEjYUQhz8V1fNM8WuQbmT7UKL/8uXqFUTeKH
	 qKeUr/8V6Fs22XLrWcK5CLXa7gSQeWqYT+TwDvAnfqbl2iktywxEm01AY41b7eI1pb
	 0bCTHa8KdwqXHGLV/dwegg5YWhN8dNw2COcPk0rYJgfhoQl0iKkAIF+BOCIJul9l/Y
	 2dN32yJJPTihGOGV+wuIvAkJ1rEkUNSSB1IgEQmh0hjKUZ7KJKcKB8YpY0sMfRDjZG
	 JgMs2Vf6x4ZYg==
Received: by mercury (Postfix, from userid 1000)
	id B339C1060DFB; Mon, 26 Feb 2024 22:27:41 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 3/6] dt-bindings: soc: imx: fsl,imx-anatop: add binding
Date: Mon, 26 Feb 2024 22:26:25 +0100
Message-ID: <20240226212740.2019837-4-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226212740.2019837-1-sre@kernel.org>
References: <20240226212740.2019837-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing binding for i.MX anatop syscon.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../bindings/soc/imx/fsl,imx-anatop.yaml      | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
new file mode 100644
index 000000000000..5a59e3470510
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx-anatop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ANATOP register
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx6sl-anatop
+              - fsl,imx6sll-anatop
+              - fsl,imx6sx-anatop
+              - fsl,imx6ul-anatop
+              - fsl,imx7d-anatop
+          - const: fsl,imx6q-anatop
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - const: fsl,imx6q-anatop
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Temperature sensor event
+      - description: Brown-out event on either of the support regulators
+      - description: Brown-out event on either the core, gpu or soc regulators
+
+  tempmon:
+    type: object
+    unevaluatedProperties: false
+    $ref: /schemas/thermal/imx-thermal.yaml
+
+patternProperties:
+  "regulator-((3p0)|(vddcore)|(vddsoc))$":
+    type: object
+    unevaluatedProperties: false
+    $ref: /schemas/regulator/anatop-regulator.yaml
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6ul-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    anatop: anatop@20c8000 {
+        compatible = "fsl,imx6ul-anatop", "fsl,imx6q-anatop",
+                     "syscon", "simple-mfd";
+        reg = <0x020c8000 0x1000>;
+        interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+
+        reg_3p0: regulator-3p0 {
+            compatible = "fsl,anatop-regulator";
+            regulator-name = "vdd3p0";
+            regulator-min-microvolt = <2625000>;
+            regulator-max-microvolt = <3400000>;
+            anatop-reg-offset = <0x120>;
+            anatop-vol-bit-shift = <8>;
+            anatop-vol-bit-width = <5>;
+            anatop-min-bit-val = <0>;
+            anatop-min-voltage = <2625000>;
+            anatop-max-voltage = <3400000>;
+            anatop-enable-bit = <0>;
+        };
+
+        reg_arm: regulator-vddcore {
+            compatible = "fsl,anatop-regulator";
+            regulator-name = "cpu";
+            regulator-min-microvolt = <725000>;
+            regulator-max-microvolt = <1450000>;
+            regulator-always-on;
+            anatop-reg-offset = <0x140>;
+            anatop-vol-bit-shift = <0>;
+            anatop-vol-bit-width = <5>;
+            anatop-delay-reg-offset = <0x170>;
+            anatop-delay-bit-shift = <24>;
+            anatop-delay-bit-width = <2>;
+            anatop-min-bit-val = <1>;
+            anatop-min-voltage = <725000>;
+            anatop-max-voltage = <1450000>;
+        };
+
+        reg_soc: regulator-vddsoc {
+            compatible = "fsl,anatop-regulator";
+            regulator-name = "vddsoc";
+            regulator-min-microvolt = <725000>;
+            regulator-max-microvolt = <1450000>;
+            regulator-always-on;
+            anatop-reg-offset = <0x140>;
+            anatop-vol-bit-shift = <18>;
+            anatop-vol-bit-width = <5>;
+            anatop-delay-reg-offset = <0x170>;
+            anatop-delay-bit-shift = <28>;
+            anatop-delay-bit-width = <2>;
+            anatop-min-bit-val = <1>;
+            anatop-min-voltage = <725000>;
+            anatop-max-voltage = <1450000>;
+        };
+
+        tempmon: tempmon {
+            compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
+            interrupt-parent = <&gpc>;
+            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+            fsl,tempmon = <&anatop>;
+            nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+            nvmem-cell-names = "calib", "temp_grade";
+            clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
+            #thermal-sensor-cells = <0>;
+        };
+    };
-- 
2.43.0


