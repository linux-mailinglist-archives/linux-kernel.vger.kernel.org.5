Return-Path: <linux-kernel+bounces-69427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D8F8588E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CD5B2B251
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92A914A0B8;
	Fri, 16 Feb 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBx+jJNZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529E1487C0;
	Fri, 16 Feb 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123020; cv=none; b=OuNXhODPu6F36z//G9XKm9XY82bCrUkvG+x2u92h3wB74wnFFJtknBZmAYCAF7FFkRH6+NBBwKfo69zV7AW66fG6+flUcyA6prL3kH/+JQcq0lrsxltRoUjkkqklIzQiUmiVWv3ysygVXERzuQAtiqPVywhATLwgrA3hVyxchmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123020; c=relaxed/simple;
	bh=SwGh5DLM5LsIthu3tG63lPvezvOw26wv4J7Bcpkos2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOxSgssxsoO4WpoPEgtcJVDq40oCE1Kc1AjM8/KtjP+oqEKCuUuyOeICjNyWxa3mmE449CZjisV6wHOAMXJAOlOX1JDRjL2Y4uEqciufWXUo6/FSYPv6CZHYhRMjpEthyq0KhwU9H0lGPUFkyTFVjweeuCfk5ql3nfLrf50fB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBx+jJNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C9EC433C7;
	Fri, 16 Feb 2024 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123019;
	bh=SwGh5DLM5LsIthu3tG63lPvezvOw26wv4J7Bcpkos2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBx+jJNZVcp74Yh9OEQGJVsKg7x9CXSCrPPWDt3BIC14J7XLKK+X8JIDqjQhlz27U
	 rweQ0f8meSVGWimYDWOsMz7YAU0bjQpXdZVaaVqxliZEisNzeX/l2VjLa+32WT/wOm
	 VpMGJ+6c3hqIoFpSHr+KWjPaPWi4a2qK+DpDnFWuBCtRNo9Dk9oXHiyW/lchxMTpb9
	 Pz0iayOPJcvyjEc5tNVYL39dDBRjIy2zjQv6kPr0daOJmvRfP2hyLGzQZnuFyJzjCL
	 G6up6HPliboZC+TT8KaHP5dpTUi/T1aOwr7GgW3ar8My9VZf7dGqYA3EYT21VWt/q0
	 rYAbwbXHdP2jA==
Received: by mercury (Postfix, from userid 1000)
	id 9EF6A10633B8; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
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
Subject: [PATCH v3 04/16] dt-bindings: soc: imx: fsl,imx-anatop: add binding
Date: Fri, 16 Feb 2024 23:34:23 +0100
Message-ID: <20240216223654.1312880-5-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216223654.1312880-1-sre@kernel.org>
References: <20240216223654.1312880-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing binding for i.MX anatop syscon.

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


