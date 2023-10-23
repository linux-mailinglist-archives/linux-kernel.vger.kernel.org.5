Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809777D3F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjJWSiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWSiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:38:17 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF8CC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:38:12 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:375d:2b56:c03f:d72d])
        by michel.telenet-ops.be with bizsmtp
        id 1We92B00F3CbNjd06We9Bz; Mon, 23 Oct 2023 20:38:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1quzoQ-007Kpl-5v;
        Mon, 23 Oct 2023 20:38:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1quzoW-007y4M-W9;
        Mon, 23 Oct 2023 20:38:09 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH RFC] dt-bindings: mfd: ams,as3711: Convert to json-schema
Date:   Mon, 23 Oct 2023 20:38:07 +0200
Message-Id: <9af48b816f2b6397f5ada58a9b5ced85213e5194.1698085945.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Austria MicroSystems AS3711 Quad Buck High Current PMIC with
Charger Device Tree binding documentation to json-schema.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
RFC, as I couldn't get the multiple dependencies right (see FIXMEs):
  1. How to incorporate "su2-dev: [ su2-max-uA ]" and
     "su2-feedback-curr-auto: [ su2-dev ]"?
  2. su2-dev requiring one of su2-fbprot-* does not seem to work?

Anyone with better *Of foo? Thanks!
---
 .../devicetree/bindings/mfd/ams,as3711.yaml   | 223 ++++++++++++++++++
 .../devicetree/bindings/mfd/as3711.txt        |  73 ------
 2 files changed, 223 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ams,as3711.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/as3711.txt

diff --git a/Documentation/devicetree/bindings/mfd/ams,as3711.yaml b/Documentation/devicetree/bindings/mfd/ams,as3711.yaml
new file mode 100644
index 0000000000000000..d9f08e017194c4f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ams,as3711.yaml
@@ -0,0 +1,223 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ams,as3711.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Austria MicroSystems AS3711 Quad Buck High Current PMIC with Charger
+
+maintainers:
+  - Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
+
+description:
+  AS3711 is an I2C PMIC from Austria MicroSystems with multiple DCDC and LDO
+  power supplies, a battery charger and an RTC.  So far only bindings for the
+  two stepup DCDC converters are defined.
+
+properties:
+  compatible:
+    const: ams,as3711
+
+  reg:
+    maxItems: 1
+
+  backlight:
+    description:
+      Step-up converter configuration, to be used as a backlight source
+    type: object
+    properties:
+      compatible:
+        const: ams,as3711-bl
+
+      su1-dev:
+        description: Framebuffer phandle for the first step-up converter
+        $ref: /schemas/types.yaml#/definitions/phandle
+
+      su1-max-uA:
+        description: Maximum current for the first step-up converter
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      su2-dev:
+        description: Framebuffer phandle for the second step-up converter
+        $ref: /schemas/types.yaml#/definitions/phandle
+
+      su2-max-uA:
+        description: Maximum current for the second step-up converter
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      su2-feedback-voltage:
+        description: Second step-up converter uses voltage feedback
+        type: boolean
+
+      su2-feedback-curr1:
+        description:
+          Second step-up converter uses CURR1 input for current feedback
+        type: boolean
+
+      su2-feedback-curr2:
+        description:
+          Second step-up converter uses CURR2 input for current feedback
+        type: boolean
+
+      su2-feedback-curr3:
+        description:
+          Second step-up converter uses CURR3 input for current feedback
+        type: boolean
+
+      su2-feedback-curr-auto:
+        description:
+          Second step-up converter uses automatic current feedback selection
+        type: boolean
+
+      su2-fbprot-lx-sd4:
+        description:
+          Second step-up converter uses LX_SD4 for over-voltage protection
+        type: boolean
+
+      su2-fbprot-gpio2:
+        description:
+          Second step-up converter uses GPIO2 for over-voltage protection
+        type: boolean
+
+      su2-fbprot-gpio3:
+        description:
+          Second step-up converter uses GPIO3 for over-voltage protection
+        type: boolean
+
+      su2-fbprot-gpio4:
+        description:
+          Second step-up converter uses GPIO4 for over-voltage protection
+        type: boolean
+
+      su2-auto-curr1:
+        description:
+          Second step-up converter uses CURR1 input for automatic current
+          feedback
+        type: boolean
+
+      su2-auto-curr2:
+        description:
+          Second step-up converter uses CURR2 input for automatic current
+          feedback
+        type: boolean
+
+      su2-auto-curr3:
+        description:
+          Second step-up converter uses CURR3 input for automatic current
+          feedback
+        type: boolean
+
+    required:
+      - compatible
+
+    dependencies:
+      # To use the SU1 converter as a backlight source the following two
+      # properties must be provided:
+      su1-dev: [ su1-max-uA ]
+      su1-max-uA: [ su1-dev ]
+
+      # To use the SU2 converter as a backlight source the following two
+      # properties must be provided:
+      # FIXME How to incorporate "su2-dev: [ su2-max-uA ]"?
+      # FIXME su2-dev requiring one of su2-fbprot-* does not seem to work?
+      su2-dev:
+        allOf:
+          - oneOf:
+              - required:
+                  - su2-feedback-voltage
+              - required:
+                  - su2-feedback-curr1
+              - required:
+                  - su2-feedback-curr2
+              - required:
+                  - su2-feedback-curr3
+              - required:
+                  - su2-feedback-curr-auto
+          - oneof:
+              - required:
+                  - su2-fbprot-lx-sd4
+              - required:
+                  - su2-fbprot-gpio2
+              - required:
+                  - su2-fbprot-gpio3
+              - required:
+                  - su2-fbprot-gpio4
+
+      su2-max-uA: [ su2-dev ]
+      su2-feedback-voltage: [ su2-dev ]
+      su2-feedback-curr1: [ su2-dev ]
+      su2-feedback-curr2: [ su2-dev ]
+      su2-feedback-curr3: [ su2-dev ]
+      # FIXME How to incorporate "su2-feedback-curr-auto: [ su2-dev ]"?
+      su2-feedback-curr-auto:
+        anyOf:
+          - required:
+              - su2-auto-curr1
+          - required:
+              - su2-auto-curr2
+          - required:
+              - su2-auto-curr3
+      su2-fbprot-lx-sd4: [ su2-dev ]
+      su2-fbprot-gpio2: [ su2-dev ]
+      su2-fbprot-gpio3: [ su2-dev ]
+      su2-fbprot-gpio4: [ su2-dev ]
+      su2-auto-curr1: [ su2-feedback-curr-auto ]
+      su2-auto-curr2: [ su2-feedback-curr-auto ]
+      su2-auto-curr3: [ su2-feedback-curr-auto ]
+
+    additionalProperties: false
+
+  regulators:
+    description: Other DCDC and LDO supplies
+    type: object
+    patternProperties:
+      "^(sd[1-4]|ldo[1-8])$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        as3711@40 {
+            compatible = "ams,as3711";
+            reg = <0x40>;
+
+            regulators {
+                sd4 {
+                    regulator-name = "1.215V";
+                    regulator-min-microvolt = <1215000>;
+                    regulator-max-microvolt = <1235000>;
+                };
+                ldo2 {
+                    regulator-name = "2.8V CPU";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+            };
+
+            backlight {
+                compatible = "ams,as3711-bl";
+                su2-dev = <&lcdc>;
+                su2-max-uA = <36000>;
+                su2-feedback-curr-auto;
+                su2-fbprot-gpio4;
+                su2-auto-curr1;
+                su2-auto-curr2;
+                su2-auto-curr3;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/as3711.txt b/Documentation/devicetree/bindings/mfd/as3711.txt
deleted file mode 100644
index d98cf18c721ceb18..0000000000000000
--- a/Documentation/devicetree/bindings/mfd/as3711.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-AS3711 is an I2C PMIC from Austria MicroSystems with multiple DCDC and LDO power
-supplies, a battery charger and an RTC. So far only bindings for the two stepup
-DCDC converters are defined. Other DCDC and LDO supplies are configured, using
-standard regulator properties, they must belong to a sub-node, called
-"regulators" and be called "sd1" to "sd4" and "ldo1" to "ldo8." Stepup converter
-configuration should be placed in a subnode, called "backlight."
-
-Compulsory properties:
-- compatible		: must be "ams,as3711"
-- reg			: specifies the I2C address
-
-To use the SU1 converter as a backlight source the following two properties must
-be provided:
-- su1-dev		: framebuffer phandle
-- su1-max-uA		: maximum current
-
-To use the SU2 converter as a backlight source the following two properties must
-be provided:
-- su2-dev		: framebuffer phandle
-- su1-max-uA		: maximum current
-
-Additionally one of these properties must be provided to select the type of
-feedback used:
-- su2-feedback-voltage	: voltage feedback is used
-- su2-feedback-curr1	: CURR1 input used for current feedback
-- su2-feedback-curr2	: CURR2 input used for current feedback
-- su2-feedback-curr3	: CURR3 input used for current feedback
-- su2-feedback-curr-auto: automatic current feedback selection
-
-and one of these to select the over-voltage protection pin
-- su2-fbprot-lx-sd4	: LX_SD4 is used for over-voltage protection
-- su2-fbprot-gpio2	: GPIO2 is used for over-voltage protection
-- su2-fbprot-gpio3	: GPIO3 is used for over-voltage protection
-- su2-fbprot-gpio4	: GPIO4 is used for over-voltage protection
-
-If "su2-feedback-curr-auto" is selected, one or more of the following properties
-have to be specified:
-- su2-auto-curr1	: use CURR1 input for current feedback
-- su2-auto-curr2	: use CURR2 input for current feedback
-- su2-auto-curr3	: use CURR3 input for current feedback
-
-Example:
-
-as3711@40 {
-	compatible = "ams,as3711";
-	reg = <0x40>;
-
-	regulators {
-		sd4 {
-			regulator-name = "1.215V";
-			regulator-min-microvolt = <1215000>;
-			regulator-max-microvolt = <1235000>;
-		};
-		ldo2 {
-			regulator-name = "2.8V CPU";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-	};
-
-	backlight {
-		compatible = "ams,as3711-bl";
-		su2-dev = <&lcdc>;
-		su2-max-uA = <36000>;
-		su2-feedback-curr-auto;
-		su2-fbprot-gpio4;
-		su2-auto-curr1;
-		su2-auto-curr2;
-		su2-auto-curr3;
-	};
-};
-- 
2.34.1

