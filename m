Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8537602EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGXXDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGXXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:03:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A85EA;
        Mon, 24 Jul 2023 16:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60C6D6145A;
        Mon, 24 Jul 2023 23:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE69C433C7;
        Mon, 24 Jul 2023 23:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690239806;
        bh=HdXCBkJC6y8xmaikj3v3JuRSAllSb+fugmrt05+9R+8=;
        h=From:To:Cc:Subject:Date:From;
        b=tP4SLIjxJM84HZM8PVsNB6zuSpHeExq9O/E/+5sE5BAPATPnujMXngLls2F16qiL/
         +GXpgss+DgrCRuMCQj1kWxFy8kEe3YbgDVd2iTSjbvg6StfMzeZFG5VCt0rtJMV/p1
         KFGDE3zJqKs5/EMbmH6TJeU0ZqelZ01e5YD0r83VnWfsJW9240mOJZT8bCJGpiYaXK
         IV9w5CdCu1sNAZNmsvfndWz9n7C0D53TU7BbMjOKyGi/suyQtkZhKfHj4R8loDD3Wa
         IMNkPkAO0+grfC4sKzKR1edV4IPe3VnxuwlVAgx1Qr5d4AovDK3CZYWe8pJmOdH4AG
         Dr5R7vokMWIDg==
Received: (nullmailer pid 1018011 invoked by uid 1000);
        Mon, 24 Jul 2023 23:03:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Iskren Chernev <me@iskren.info>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: leds: Convert Panasonic AN30259A to DT schema
Date:   Mon, 24 Jul 2023 17:02:58 -0600
Message-Id: <20230724230258.1017258-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Panasonic AN30259A 3-channel LED controller binding to DT
schema format.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Update maintainer

 .../bindings/leds/leds-an30259a.txt           | 55 ------------
 .../bindings/leds/panasonic,an30259a.yaml     | 84 +++++++++++++++++++
 2 files changed, 84 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-an30259a.txt
 create mode 100644 Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-an30259a.txt b/Documentation/devicetree/bindings/leds/leds-an30259a.txt
deleted file mode 100644
index cbd833906b2b..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-an30259a.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* Panasonic AN30259A 3-channel LED driver
-
-The AN30259A is a LED controller capable of driving three LEDs independently. It supports
-constant current output and sloping current output modes. The chip is connected over I2C.
-
-Required properties:
-	- compatible: Must be "panasonic,an30259a".
-	- reg: I2C slave address.
-	- #address-cells: Must be 1.
-	- #size-cells: Must be 0.
-
-Each LED is represented as a sub-node of the panasonic,an30259a node.
-
-Required sub-node properties:
-	- reg: Pin that the LED is connected to. Must be 1, 2, or 3.
-
-Optional sub-node properties:
-	- function :
-		see Documentation/devicetree/bindings/leds/common.txt
-	- color :
-		see Documentation/devicetree/bindings/leds/common.txt
-	- label :
-		see Documentation/devicetree/bindings/leds/common.txt (deprecated)
-	- linux,default-trigger :
-		see Documentation/devicetree/bindings/leds/common.txt
-
-Example:
-
-#include <dt-bindings/leds/common.h>
-
-led-controller@30 {
-	compatible = "panasonic,an30259a";
-	reg = <0x30>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	led@1 {
-		reg = <1>;
-		linux,default-trigger = "heartbeat";
-		function = LED_FUNCTION_INDICATOR;
-		color = <LED_COLOR_ID_RED>;
-	};
-
-	led@2 {
-		reg = <2>;
-		function = LED_FUNCTION_INDICATOR;
-		color = <LED_COLOR_ID_GREEN>;
-	};
-
-	led@3 {
-		reg = <3>;
-		function = LED_FUNCTION_INDICATOR;
-		color = <LED_COLOR_ID_BLUE>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml b/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml
new file mode 100644
index 000000000000..e918dceea082
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/panasonic,an30259a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Panasonic AN30259A 3-channel LED controller
+
+maintainers:
+  - Iskren Chernev <me@iskren.info>
+
+description:
+  The AN30259A is a LED controller capable of driving three LEDs independently.
+  It supports constant current output and sloping current output modes. The chip
+  is connected over I2C.
+
+properties:
+  compatible:
+    const: panasonic,an30259a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[1-3]$":
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [ 1, 2, 3 ]
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@30 {
+            compatible = "panasonic,an30259a";
+            reg = <0x30>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            led@1 {
+                reg = <1>;
+                linux,default-trigger = "heartbeat";
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_RED>;
+            };
+
+            led@2 {
+                reg = <2>;
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_GREEN>;
+            };
+
+            led@3 {
+                reg = <3>;
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_BLUE>;
+            };
+        };
+    };
+...
-- 
2.40.1

