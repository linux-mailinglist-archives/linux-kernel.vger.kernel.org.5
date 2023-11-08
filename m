Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3907E57F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbjKHN10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjKHN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:27:23 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D81BFC;
        Wed,  8 Nov 2023 05:27:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45AFEC0002;
        Wed,  8 Nov 2023 13:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699450039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIjYBAmnoy1dHJ8r112X89k/GpZVZZ5hj35H3qqtBeE=;
        b=jsaCzaab2Hx7pl5cQvF7Iz6doK54GzjvHj4bAIzUQ3lOP3YZZQCjbw89UyN6eUi3M4MPgR
        8YD6DOYTUZroHmynDy2xmYqeIZdeTe6MA0Mz/kWKxDkuWQMyU5Ayh8k74PSroE0ijCD592
        67xjojUj6uQ/Bf2kR190CV/8B3oVaUa5uMNPpzGNvVsUWUqLsErZKtGUuoXAXTk5lRaUog
        Jrlh7zHtdrXdO+gXfKGl1dSTQYTo7H2q9R9eDaTtEH4o3z2xDk+pZW6YOVA5p20AL+bbYz
        UBneY/zuoYUeZ5ba8gBlMtxNzCTpVXFvLtfLIQGdy3E9bXPFGfQFkIIr7E3evQ==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [PATCH v8 2/3] media: dt-bindings: media: i2c: Add bindings for TW9900
Date:   Wed,  8 Nov 2023 14:27:13 +0100
Message-ID: <0af5607f13b95e1312a1e8df516c8f3d6d0b20f0.1699449537.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699449537.git.mehdi.djait@bootlin.com>
References: <cover.1699449537.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Techwell TW9900 is a video decoder supporting multiple input
standards such as PAL and NTSC and has a parallel BT.656 output
interface.

It's designed to be low-power, posesses some features such as a
programmable comb-filter, and automatic input standard detection

Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
V7->V8: 
- fixed the number of analog input ports: it is just one.
- added endpoints of the analog input port
- added vdd-supply to the required in the dt-binding documentation

V6->V7: 
- added powerdown-gpios and input ports
- used 4 spaces for example identation

V5->V6: 
- This commit had a "Reviewed-by: Rob Herring <robh@kernel.org>" Tag but
  decided not to collect it because the last Iteration was more than 2
  years ago
- removed SECAM from the mentioned standards
- changed maintainer

V4->V5: 
- renamed the file to match the compatible string, and referenced
  the graph.yaml schema

V3->V4: 
- add the missing reset-gpios node to the binding

V2->V3: 
- fix the example not compiling due to a typo in the reset-gpios
  node.

 .../bindings/media/i2c/techwell,tw9900.yaml   | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
new file mode 100644
index 000000000000..e37317f81072
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/techwell,tw9900.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Techwell TW9900 NTSC/PAL video decoder
+
+maintainers:
+  - Mehdi Djait <mehdi.djait@bootlin.com>
+
+description:
+  The tw9900 is a multi-standard video decoder, supporting NTSC, PAL standards
+  with auto-detection features.
+
+properties:
+  compatible:
+    const: techwell,tw9900
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: VDD power supply
+
+  reset-gpios:
+    description: GPIO descriptor for the RESET input pin
+    maxItems: 1
+
+  powerdown-gpios:
+    description: GPIO descriptor for the POWERDOWN input pin
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: Analog input port
+
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: CVBS over MUX0
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: CVBS over MUX1
+
+          endpoint@2:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: Chroma over CIN0 and Y over MUX0
+
+          endpoint@3:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: Chroma over CIN0 and Y over MUX1
+
+        oneOf:
+          - required:
+              - endpoint@0
+          - required:
+              - endpoint@1
+          - required:
+              - endpoint@2
+          - required:
+              - endpoint@3
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for the decoder output.
+
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - ports
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/display/sdtv-standards.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    composite_connector {
+        compatible = "composite-video-connector";
+        label = "tv";
+        sdtv-standards = <(SDTV_STD_PAL | SDTV_STD_NTSC)>;
+
+        port {
+            composite_to_tw9900: endpoint {
+                remote-endpoint = <&tw9900_to_composite>;
+            };
+        };
+    };
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        video-decoder@44 {
+            compatible = "techwell,tw9900";
+            reg = <0x44>;
+
+            vdd-supply = <&tw9900_supply>;
+            reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    reg = <0>;
+                    tw9900_to_composite: endpoint@0 {
+                        reg = <0>;
+                        remote-endpoint = <&composite_to_tw9900>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    endpoint {
+                        remote-endpoint = <&cif_in>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.41.0

