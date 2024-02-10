Return-Path: <linux-kernel+bounces-60217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F7850191
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2270B26C51
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267255CB5;
	Sat, 10 Feb 2024 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBe392Sm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3620F1;
	Sat, 10 Feb 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528079; cv=none; b=albn0MbPd1b33WPNHir7OeFVThT7WdHtqu2rZ25m7Ys48XPALKA6n+FUEzJ6BhCLBiClJi1gGFLF6SVTlSlTX8pHA5n75+NGMdBLEsWLinwj0/IQEp5QzPilXBdsDYZlGQCF80YZXCA6InSd7C74HOuQ1L7WT8gjZ9yWo1kTR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528079; c=relaxed/simple;
	bh=YxQ5LMsMzEjuOZcPovgNYIQMKbIBxJn4ha0PHBzpGcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myTF4afF2S554wsKmidv4Vu2zUXztJ6Sc/pIo60TyLUHnOW0C1/1MB8f0MyV37B/RgVADH2VvaJvPnMsiNH+52j+bKl461+BGmX4dzM3FRY2UNpCTWiuIAIWkrrTW8Wpu7DSqzBspYwKT4m43sGHfITN1qQQ6vgel5GevklkgSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBe392Sm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765D8C43390;
	Sat, 10 Feb 2024 01:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528078;
	bh=YxQ5LMsMzEjuOZcPovgNYIQMKbIBxJn4ha0PHBzpGcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBe392SmZd26CtDKNzpqe+91/ErPLtAEgyR7/4OIymBD7veyr5eyKlddEAgR/8wYV
	 KnUEoXqJf4MZKrN4TB/vMS7usnqqdcXwz38VtKi/xycZsfd1GxDFRP4sr6BRNriOXM
	 gKMS+WM3gbeM9+Ph81dVLPBS+SkezE44XE07e9svrDRUQQs41cUOh4VI1pE1SGpvLD
	 XPCyZdaVB55onRLmrh5ua8UslempSMUDwgmkOAy/EJQ9D81MNaEtxfxJ1K9fEhp7qV
	 7X9w0klJ1ailo8zJN8UdZt5tJ/fJqCey8feS3eCBgcQru7zs1XX4mHBLzxYxgOhQzO
	 5rbJK8x41yBkA==
Received: by mercury (Postfix, from userid 1000)
	id DA48D106861A; Sat, 10 Feb 2024 02:21:15 +0100 (CET)
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
Subject: [PATCH v1 03/14] dt-bindings: sound: fsl,imx-asrc: convert to YAML
Date: Sat, 10 Feb 2024 02:18:07 +0100
Message-ID: <20240210012114.489102-4-sre@kernel.org>
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

Convert the i.MX ASRC DT binding to YAML.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../devicetree/bindings/sound/fsl,asrc.txt    |  80 ---------
 .../bindings/sound/fsl,imx-asrc.yaml          | 159 ++++++++++++++++++
 2 files changed, 159 insertions(+), 80 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
deleted file mode 100644
index 998b4c8a7f78..000000000000
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ /dev/null
@@ -1,80 +0,0 @@
-Freescale Asynchronous Sample Rate Converter (ASRC) Controller
-
-The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
-signal associated with an input clock into a signal associated with a different
-output clock. The driver currently works as a Front End of DPCM with other Back
-Ends Audio controller such as ESAI, SSI and SAI. It has three pairs to support
-three substreams within totally 10 channels.
-
-Required properties:
-
-  - compatible		: Compatible list, should contain one of the following
-			  compatibles:
-			  "fsl,imx35-asrc",
-			  "fsl,imx53-asrc",
-			  "fsl,imx8qm-asrc",
-			  "fsl,imx8qxp-asrc",
-
-  - reg			: Offset and length of the register set for the device.
-
-  - interrupts		: Contains the spdif interrupt.
-
-  - dmas		: Generic dma devicetree binding as described in
-			  Documentation/devicetree/bindings/dma/dma.txt.
-
-  - dma-names		: Contains "rxa", "rxb", "rxc", "txa", "txb" and "txc".
-
-  - clocks		: Contains an entry for each entry in clock-names.
-
-  - clock-names		: Contains the following entries
-	"mem"		  Peripheral access clock to access registers.
-	"ipg"		  Peripheral clock to driver module.
-	"asrck_<0-f>"	  Clock sources for input and output clock.
-	"spba"		  The spba clock is required when ASRC is placed as a
-			  bus slave of the Shared Peripheral Bus and when two
-			  or more bus masters (CPU, DMA or DSP) try to access
-			  it. This property is optional depending on the SoC
-			  design.
-
-   - fsl,asrc-rate	: Defines a mutual sample rate used by DPCM Back Ends.
-
-   - fsl,asrc-width	: Defines a mutual sample width used by DPCM Back Ends.
-
-   - fsl,asrc-clk-map   : Defines clock map used in driver. which is required
-			  by imx8qm/imx8qxp platform
-			  <0> - select the map for asrc0 in imx8qm/imx8qxp
-			  <1> - select the map for asrc1 in imx8qm/imx8qxp
-
-Optional properties:
-
-   - big-endian		: If this property is absent, the little endian mode
-			  will be in use as default. Otherwise, the big endian
-			  mode will be in use for all the device registers.
-
-   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
-			  Ends, which can replace the fsl,asrc-width.
-			  The value is 2 (S16_LE), or 6 (S24_LE).
-
-Example:
-
-asrc: asrc@2034000 {
-	compatible = "fsl,imx53-asrc";
-	reg = <0x02034000 0x4000>;
-	interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks 107>, <&clks 107>, <&clks 0>,
-	       <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
-	       <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
-	       <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
-	       <&clks 107>, <&clks 0>, <&clks 0>;
-	clock-names = "mem", "ipg", "asrck0",
-		"asrck_1", "asrck_2", "asrck_3", "asrck_4",
-		"asrck_5", "asrck_6", "asrck_7", "asrck_8",
-		"asrck_9", "asrck_a", "asrck_b", "asrck_c",
-		"asrck_d", "asrck_e", "asrck_f";
-	dmas = <&sdma 17 23 1>, <&sdma 18 23 1>, <&sdma 19 23 1>,
-	     <&sdma 20 23 1>, <&sdma 21 23 1>, <&sdma 22 23 1>;
-	dma-names = "rxa", "rxb", "rxc",
-		"txa", "txb", "txc";
-	fsl,asrc-rate  = <48000>;
-	fsl,asrc-width = <16>;
-};
diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
new file mode 100644
index 000000000000..bc1607ecf345
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,imx-asrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Asynchronous Sample Rate Converter (ASRC) Controller
+
+description:
+  The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of
+  a signal associated with an input clock into a signal associated with a
+  different output clock. The driver currently works as a Front End of DPCM
+  with other Back Ends Audio controller such as ESAI, SSI and SAI. It has
+  three pairs to support three substreams within totally 10 channels.
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+  - Sascha Hauer <s.hauer@pengutronix.de>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,imx35-asrc
+          - fsl,imx53-asrc
+          - fsl,imx8qm-asrc
+          - fsl,imx8qxp-asrc
+      - items:
+          - enum:
+              - fsl,imx6sx-asrc
+              - fsl,imx6ul-asrc
+          - const: fsl,imx53-asrc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 6
+
+  dma-names:
+    items:
+      - const: rxa
+      - const: rxb
+      - const: rxc
+      - const: txa
+      - const: txb
+      - const: txc
+
+  clocks:
+    maxItems: 19
+
+  clock-names:
+    items:
+      - const: mem
+      - const: ipg
+      - const: asrck_0
+      - const: asrck_1
+      - const: asrck_2
+      - const: asrck_3
+      - const: asrck_4
+      - const: asrck_5
+      - const: asrck_6
+      - const: asrck_7
+      - const: asrck_8
+      - const: asrck_9
+      - const: asrck_a
+      - const: asrck_b
+      - const: asrck_c
+      - const: asrck_d
+      - const: asrck_e
+      - const: asrck_f
+      - const: spba
+
+  fsl,asrc-rate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The mutual sample rate used by DPCM Back Ends
+
+  fsl,asrc-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The mutual sample width used by DPCM Back Ends
+
+  fsl,asrc-clk-map:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines clock map used in driver
+      <0> - select the map for asrc0 in imx8qm/imx8qxp
+      <1> - select the map for asrc1 in imx8qm/imx8qxp
+
+  big-endian:
+    type: boolean
+    description:
+      If this property is absent, the little endian mode will be in use as
+      default. Otherwise, the big endian mode will be in use for all the
+      device registers.
+
+  fsl,asrc-format:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Defines a mutual sample format used by DPCM Back Ends, which can
+      replace the fsl,asrc-width. The value is 2 (S16_LE), or 6 (S24_LE).
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+  - fsl,asrc-rate
+  - fsl,asrc-width
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-asrc
+              - fsl,imx8qxp-asrc
+    then:
+      required:
+        - fsl,asrc-clk-map
+    else:
+      properties:
+        fsl,asrc-clk-map: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+    asrc: asrc@2034000 {
+        compatible = "fsl,imx53-asrc";
+        reg = <0x02034000 0x4000>;
+        interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX6QDL_CLK_ASRC_IPG>,
+                 <&clks IMX6QDL_CLK_ASRC_MEM>, <&clks 0>,
+                 <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+                 <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+                 <&clks 0>, <&clks 0>, <&clks 0>, <&clks 0>,
+                 <&clks IMX6QDL_CLK_ASRC>, <&clks 0>, <&clks 0>,
+                 <&clks IMX6QDL_CLK_SPBA>;
+        clock-names = "mem", "ipg", "asrck_0",
+                "asrck_1", "asrck_2", "asrck_3", "asrck_4",
+                "asrck_5", "asrck_6", "asrck_7", "asrck_8",
+                "asrck_9", "asrck_a", "asrck_b", "asrck_c",
+                "asrck_d", "asrck_e", "asrck_f", "spba";
+        dmas = <&sdma 17 23 1>, <&sdma 18 23 1>, <&sdma 19 23 1>,
+               <&sdma 20 23 1>, <&sdma 21 23 1>, <&sdma 22 23 1>;
+        dma-names = "rxa", "rxb", "rxc",
+                    "txa", "txb", "txc";
+        fsl,asrc-rate  = <48000>;
+        fsl,asrc-width = <16>;
+    };
-- 
2.43.0


