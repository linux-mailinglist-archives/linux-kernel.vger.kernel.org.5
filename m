Return-Path: <linux-kernel+bounces-69428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82108588E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CFA282417
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0893514A0BC;
	Fri, 16 Feb 2024 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="draIw5KD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053251487C7;
	Fri, 16 Feb 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123020; cv=none; b=O1S9VPMYGxvDSn8PiVu3AxOwoYkfgodA1Dz3CPmaxxfbfpic5JTmelVn8hv/Is9BBR67u73m3p7PygKp4dNmv1jg2N8AsgDhBeyfquFacxlYyBg+YbTVH9QriaAJDOS/68i2VaUkto02x4zO0EgMMorNf4ZiHpxg0/bs17vUcUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123020; c=relaxed/simple;
	bh=resC3EdVnr1VmQ6d66ZukTMXBA464nmyoeCuIzkpf5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbpQ1pr2bUjZsdQxxkvXbDV4GVH4lxQhvWpyIH/E/PO1Cn0MKYL43Qqqunu29FaVIywRfLNBO6wwprPnKleUk5ScBGISHRE1gkBSMbG2YG/NYFy5E+pooBoA1xVbWfHidTbHucNMPWUfSS2zW/Ub39/n2eosLqn6r0hEgXceRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=draIw5KD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2F4C43399;
	Fri, 16 Feb 2024 22:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123019;
	bh=resC3EdVnr1VmQ6d66ZukTMXBA464nmyoeCuIzkpf5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=draIw5KD63MEn6mgslqrvMSi26qiChhLr8ex3vt00LPfpA/aWvyugWlMNhmzwxCv6
	 RiQFtfVMspq4nLZkh3TJ+binLJdvgu0JPDILLMqqeqYPrCaCrGfrwK0C+s85ahZmKR
	 1KkpKQFHOSbu7fX0UehI05abFt4NBrL5lrHUaGXENxTv2NDyLeRqtCKOGwTs9Aki+u
	 myHX3KNUorXJT+4LDg0E4iqeQEYbS+tYiZ1geny4Lqr1i9yNOftNq8JmtHjQkHc1Ie
	 Nmo01cuAp5734p1gluhp7QpePpSOll9yWdQfcPSZ3+Q5t6HCV0FeljM9LMWLrMHePs
	 5KBDoRFenk0zA==
Received: by mercury (Postfix, from userid 1000)
	id 8D1131062D86; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
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
Subject: [PATCH v3 01/16] dt-bindings: pinctrl: fsl,imx6ul-pinctrl: convert to YAML
Date: Fri, 16 Feb 2024 23:34:20 +0100
Message-ID: <20240216223654.1312880-2-sre@kernel.org>
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

Convert i.MX6UL pinctrl bindings to YAML.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt   |  37 ------
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.yaml  | 116 ++++++++++++++++++
 2 files changed, 116 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
deleted file mode 100644
index 7ca4f6118d9a..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* Freescale i.MX6 UltraLite IOMUX Controller
-
-Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
-and usage.
-
-Required properties:
-- compatible: "fsl,imx6ul-iomuxc" for main IOMUX controller or
-  "fsl,imx6ull-iomuxc-snvs" for i.MX 6ULL's SNVS IOMUX controller.
-- fsl,pins: each entry consists of 6 integers and represents the mux and config
-  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
-  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
-  imx6ul-pinfunc.h under device tree source folder.  The last integer CONFIG is
-  the pad setting value like pull-up on this pin.  Please refer to i.MX6 UltraLite
-  Reference Manual for detailed CONFIG settings.
-
-CONFIG bits definition:
-PAD_CTL_HYS                     (1 << 16)
-PAD_CTL_PUS_100K_DOWN           (0 << 14)
-PAD_CTL_PUS_47K_UP              (1 << 14)
-PAD_CTL_PUS_100K_UP             (2 << 14)
-PAD_CTL_PUS_22K_UP              (3 << 14)
-PAD_CTL_PUE                     (1 << 13)
-PAD_CTL_PKE                     (1 << 12)
-PAD_CTL_ODE                     (1 << 11)
-PAD_CTL_SPEED_LOW               (0 << 6)
-PAD_CTL_SPEED_MED               (1 << 6)
-PAD_CTL_SPEED_HIGH              (3 << 6)
-PAD_CTL_DSE_DISABLE             (0 << 3)
-PAD_CTL_DSE_260ohm              (1 << 3)
-PAD_CTL_DSE_130ohm              (2 << 3)
-PAD_CTL_DSE_87ohm               (3 << 3)
-PAD_CTL_DSE_65ohm               (4 << 3)
-PAD_CTL_DSE_52ohm               (5 << 3)
-PAD_CTL_DSE_43ohm               (6 << 3)
-PAD_CTL_DSE_37ohm               (7 << 3)
-PAD_CTL_SRE_FAST                (1 << 0)
-PAD_CTL_SRE_SLOW                (0 << 0)
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.yaml
new file mode 100644
index 000000000000..906b264a9e3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,imx6ul-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale IMX6UL IOMUX Controller
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description:
+  Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
+  for common binding part and usage.
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx6ul-iomuxc
+      - fsl,imx6ull-iomuxc-snvs
+
+  reg:
+    maxItems: 1
+
+# Client device subnode's properties
+patternProperties:
+  'grp$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+
+    properties:
+      fsl,pins:
+        description:
+          each entry consists of 6 integers and represents the mux and config
+          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
+          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
+          be found in <arch/arm/boot/dts/imx6ul-pinfunc.h>. The last integer
+          CONFIG is the pad setting value like pull-up on this pin. Please
+          refer to i.MX6UL Reference Manual for detailed CONFIG settings.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        items:
+          items:
+            - description: |
+                "mux_reg" indicates the offset of mux register.
+            - description: |
+                "conf_reg" indicates the offset of pad configuration register.
+            - description: |
+                "input_reg" indicates the offset of select input register.
+            - description: |
+                "mux_val" indicates the mux value to be applied.
+            - description: |
+                "input_val" indicates the select input value to be applied.
+            - description: |
+                "pad_setting" indicates the pad configuration value to be applied:
+                  PAD_CTL_HYS                     (1 << 16)
+                  PAD_CTL_PUS_100K_DOWN           (0 << 14)
+                  PAD_CTL_PUS_47K_UP              (1 << 14)
+                  PAD_CTL_PUS_100K_UP             (2 << 14)
+                  PAD_CTL_PUS_22K_UP              (3 << 14)
+                  PAD_CTL_PUE                     (1 << 13)
+                  PAD_CTL_PKE                     (1 << 12)
+                  PAD_CTL_ODE                     (1 << 11)
+                  PAD_CTL_SPEED_LOW               (0 << 6)
+                  PAD_CTL_SPEED_MED               (1 << 6)
+                  PAD_CTL_SPEED_HIGH              (3 << 6)
+                  PAD_CTL_DSE_DISABLE             (0 << 3)
+                  PAD_CTL_DSE_260ohm              (1 << 3)
+                  PAD_CTL_DSE_130ohm              (2 << 3)
+                  PAD_CTL_DSE_87ohm               (3 << 3)
+                  PAD_CTL_DSE_65ohm               (4 << 3)
+                  PAD_CTL_DSE_52ohm               (5 << 3)
+                  PAD_CTL_DSE_43ohm               (6 << 3)
+                  PAD_CTL_DSE_37ohm               (7 << 3)
+                  PAD_CTL_SRE_FAST                (1 << 0)
+                  PAD_CTL_SRE_SLOW                (0 << 0)
+
+    required:
+      - fsl,pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    iomuxc: pinctrl@20e0000 {
+      compatible = "fsl,imx6ul-iomuxc";
+      reg = <0x020e0000 0x4000>;
+
+      mux_uart: uartgrp {
+        fsl,pins = <
+          0x0084 0x0310 0x0000 0 0 0x1b0b1
+          0x0088 0x0314 0x0624 0 3 0x1b0b1
+        >;
+      };
+    };
+  - |
+    iomuxc_snvs: pinctrl@2290000 {
+      compatible = "fsl,imx6ull-iomuxc-snvs";
+      reg = <0x02290000 0x4000>;
+
+      pinctrl_snvs_usbc_det: snvsusbcdetgrp {
+        fsl,pins = <
+          0x0010 0x0054 0x0000 0x5 0x0 0x130b0
+        >;
+      };
+    };
-- 
2.43.0


