Return-Path: <linux-kernel+bounces-62840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E2E8526C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D661C2500B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F16A00E;
	Tue, 13 Feb 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLmi2THy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084967E8B;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786235; cv=none; b=i5Y0UQT9fTtLg/c7rt1I1LEyZYvHnn80F4juEjH1Yx1Ao5q6K/5B57ePD/OOyptaR7QZ/tiQXF3a5JC92zP/7+ctsA5k2i9jWa88R/XDS9filvZGWJPcKWyxiTwbqPAf5ByxswKWMlyh7afKgSG4BqKrOt2Z6y7RW6ZGRLME1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786235; c=relaxed/simple;
	bh=SwGh5DLM5LsIthu3tG63lPvezvOw26wv4J7Bcpkos2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LD/LeIRWEd2XQDYKQixKiQt6sx4bYjHzETkGrlHbOE3vLC0oGFzJGyksB9pRfiRQgZTdMNCQyVpUddzF74uB8mbutbiIThCe6CODcehdYS7xhfhd30SWQW+Wh0JegRIp8KVmK3SAjPzLcwOHPpbQhdhw4kM8yQBIxmr4k7/FQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLmi2THy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E67C43390;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786235;
	bh=SwGh5DLM5LsIthu3tG63lPvezvOw26wv4J7Bcpkos2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLmi2THy7it1s9W8KIjFVFEVjxibd2FA725t3HWn6KI+e1L2Xx8yU8V7jLrYZlWv5
	 ayB01TJ3ZOHjE/t0nToWqfvJ5HuMcJfhxodhVjOYoIYC9+BMgPiHxnNDK0rE+buzmD
	 BC7kveBIWKPJHHujko6+UMKUIpW7mixuNVfWh0ttiaHDyinOXJJX7/mfLXpMFBTgln
	 /UNtOY5mdLcp+ARakeRqMpj2w6EmsxgZofNAPeNlx9aqIaQPOEeU5tbhKPJWfJdoRC
	 Es1IX15Ibb8jkDKoLuuDnCv+5FNoEF5Lv8Z+bwr5+O2XiAcOJCgXVq3ON3QjRatoC/
	 5CebyHtMUQMZw==
Received: by mercury (Postfix, from userid 1000)
	id 39A86106A504; Tue, 13 Feb 2024 02:03:49 +0100 (CET)
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
Subject: [PATCH v2 05/17] dt-bindings: soc: imx: fsl,imx-anatop: add binding
Date: Tue, 13 Feb 2024 02:00:54 +0100
Message-ID: <20240213010347.1075251-6-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213010347.1075251-1-sre@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
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


