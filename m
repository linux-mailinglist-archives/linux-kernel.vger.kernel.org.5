Return-Path: <linux-kernel+bounces-21992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1DA82979C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AF228F4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3947795;
	Wed, 10 Jan 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jFgJZZ2G"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716033FB36;
	Wed, 10 Jan 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704882394; x=1736418394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PalD82ak/I8XOLyg3wSse6AzSuqcL6BJlR3VoACVMNM=;
  b=jFgJZZ2GqR5KkOPU/M8YNeGRAnoruoEutu6BU8GXKNAp9KANBszYooLp
   z9bMch6Lz/e4sHUgWafVW0yWQQfFsr7ABGEIkdOvclKh0+/+W0MVldYJ/
   +Vo/JwqFv+3UZhXvJ9gjrxwO3i7tm/BFM46fqPYi+Cc89uQDXDDfpX4r2
   nGIHD8SdoCdh7epiIb2Qr9uC19E5TByjgU0xkPKphyhDB8+2jbZonDphT
   wKYD2l3u2nK7Nqu+BE1/nv2XJaL1hUwDVqQq7rcqzyxiLcD8KzkfgA+WH
   My0BagJ66dL5L5RWaVRYMQHEFd21/vjvhQ3/t1rzi2MbQYFvcjMIGhAK/
   g==;
X-CSE-ConnectionGUID: 4FLeVdXIRtGRQjBQXLr/AA==
X-CSE-MsgGUID: rQWy3AwvQpWYwOWWi+XTOw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="181745211"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2024 03:26:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 03:26:09 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 03:26:01 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lee@kernel.org>, <thierry.reding@gmail.com>,
	<u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>
CC: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH 1/3] dt-bindings: display: convert Atmel's HLCDC to DT schema
Date: Wed, 10 Jan 2024 15:55:33 +0530
Message-ID: <20240110102535.246177-2-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110102535.246177-1-dharma.b@microchip.com>
References: <20240110102535.246177-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Convert the existing DT binding to DT schema of the Atmel's HLCDC display
controller.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../display/atmel/atmel,hlcdc-dc.yaml         | 133 ++++++++++++++++++
 .../bindings/display/atmel/hlcdc-dc.txt       |  75 ----------
 2 files changed, 133 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt

diff --git a/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.yaml b/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.yaml
new file mode 100644
index 000000000000..49ef28646c48
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-dc.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2024 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/atmel/atmel,hlcdc-dc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel's HLCDC (High LCD Controller) DRM driver
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
+
+description: |
+  Device-Tree bindings for Atmel's HLCDC DRM driver. The Atmel HLCDC Display
+  Controller is a subdevice of the HLCDC MFD device.
+  # See ../../mfd/atmel,hlcdc.yaml for more details.
+
+properties:
+  compatible:
+    const: atmel,hlcdc-display-controller
+
+  pinctrl-names:
+    const: default
+
+  pinctrl-0: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  port@0:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    unevaluatedProperties: false
+    description:
+      Output endpoint of the controller, connecting the LCD panel signals.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+      reg:
+        maxItems: 1
+
+      endpoint:
+        $ref: /schemas/graph.yaml#/$defs/endpoint-base
+        unevaluatedProperties: false
+        description:
+          Endpoint connecting the LCD panel signals.
+
+        properties:
+          bus-width:
+            description: |
+              Any endpoint grandchild node may specify a desired video interface according to
+              ../../media/video-interfaces.yaml, specifically "bus-width" whose recognized
+              values are <12>, <16>, <18> and <24>, and override any output mode selection
+              heuristic, forcing "rgb444","rgb565", "rgb666" and "rgb888" respectively.
+            enum: [ 12, 16, 18, 24 ]
+
+additionalProperties: false
+
+required:
+  - '#address-cells'
+  - '#size-cells'
+  - compatible
+  - pinctrl-names
+  - pinctrl-0
+  - port@0
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    //Example 1
+    hlcdc: hlcdc@f0030000 {
+      compatible = "atmel,sama5d3-hlcdc";
+      reg = <0xf0030000 0x2000>;
+      interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+      clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+      clock-names = "periph_clk","sys_clk", "slow_clk";
+
+      hlcdc-display-controller {
+        compatible = "atmel,hlcdc-display-controller";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          reg = <0>;
+
+          hlcdc_panel_output: endpoint@0 {
+            reg = <0>;
+            remote-endpoint = <&panel_input>;
+          };
+        };
+      };
+
+      hlcdc_pwm: hlcdc-pwm {
+        compatible = "atmel,hlcdc-pwm";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_lcd_pwm>;
+        #pwm-cells = <3>;
+      };
+    };
+  - |
+    //Example 2 With a video interface override to force rgb565
+    hlcdc-display-controller {
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      port@0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0>;
+        hlcdc_panel_output2: endpoint@0 {
+          reg = <0>;
+          remote-endpoint = <&panel_input>;
+          bus-width = <16>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
deleted file mode 100644
index 923aea25344c..000000000000
--- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
+++ /dev/null
@@ -1,75 +0,0 @@
-Device-Tree bindings for Atmel's HLCDC (High LCD Controller) DRM driver
-
-The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
-See ../../mfd/atmel-hlcdc.txt for more details.
-
-Required properties:
- - compatible: value should be "atmel,hlcdc-display-controller"
- - pinctrl-names: the pin control state names. Should contain "default".
- - pinctrl-0: should contain the default pinctrl states.
- - #address-cells: should be set to 1.
- - #size-cells: should be set to 0.
-
-Required children nodes:
- Children nodes are encoding available output ports and their connections
- to external devices using the OF graph representation (see ../graph.txt).
- At least one port node is required.
-
-Optional properties in grandchild nodes:
- Any endpoint grandchild node may specify a desired video interface
- according to ../../media/video-interfaces.txt, specifically
- - bus-width: recognized values are <12>, <16>, <18> and <24>, and
-   override any output mode selection heuristic, forcing "rgb444",
-   "rgb565", "rgb666" and "rgb888" respectively.
-
-Example:
-
-	hlcdc: hlcdc@f0030000 {
-		compatible = "atmel,sama5d3-hlcdc";
-		reg = <0xf0030000 0x2000>;
-		interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
-		clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
-		clock-names = "periph_clk","sys_clk", "slow_clk";
-
-		hlcdc-display-controller {
-			compatible = "atmel,hlcdc-display-controller";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0>;
-
-				hlcdc_panel_output: endpoint@0 {
-					reg = <0>;
-					remote-endpoint = <&panel_input>;
-				};
-			};
-		};
-
-		hlcdc_pwm: hlcdc-pwm {
-			compatible = "atmel,hlcdc-pwm";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_lcd_pwm>;
-			#pwm-cells = <3>;
-		};
-	};
-
-Example 2: With a video interface override to force rgb565; as above
-but with these changes/additions:
-
-	&hlcdc {
-		hlcdc-display-controller {
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
-
-			port@0 {
-				hlcdc_panel_output: endpoint@0 {
-					bus-width = <16>;
-				};
-			};
-		};
-	};
-- 
2.25.1


