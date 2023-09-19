Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1A7A6C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjISUJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjISUJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:09:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F106B6;
        Tue, 19 Sep 2023 13:09:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD448C433C7;
        Tue, 19 Sep 2023 20:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695154178;
        bh=FNVxPQJYr8MGjYiR3OTqCQUWjoyGVbh3+o5wbD/5/Oo=;
        h=From:To:Cc:Subject:Date:From;
        b=kW/cXRy/ERILUTE2Xlx40q8HHGOjpKWXtl5rWAofkxPPzWTNeG7Abs8zffXM1voUH
         vjh3HQnJvcBhXgy+q06ykvdvhUzZ7uEAtCGbyMsFoAj3hS3/dLrqHv8z5kB+3fwZ0l
         hgHkg3yTwcxG+L8QkJ8Mcn4aD1VwdWTIW64oNNABxXz2nc308yT9vGCEnTwUqd3Fj2
         Q4D6rMUp4wT3uWr21PGp1Tbwp9k4Ut0Ubbo6Nn7JG6UR/j8TCDspgaUKnElLph9zpl
         Ayt+l5VDStCugUnoJExYEgf6midsmtOHMoYS0VIqflS+y4JP/k1+c4qPsvv3PczsVt
         ZsNbucvytR3lg==
Received: (nullmailer pid 137500 invoked by uid 1000);
        Tue, 19 Sep 2023 20:09:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mfd: armltd: Move Arm board syscon's to separate schema
Date:   Tue, 19 Sep 2023 15:09:21 -0500
Message-Id: <20230919200930.137164-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arm Ltd board bindings are a bit unusual in that they define child
nodes for various syscon's. The schemas are also incomplete as they lack
constraints on having additional properties and some properties are
missing. As the bindings for the different platforms only vary by
compatibles, combine them into a single schema doc.

Add the "arm,im-pd1-syscon" compatible which was not documented. Add
"ranges", "#address-cells", and "#size-cells properties which were
missing.

With this, fix the error exposed in the register-bit-led binding.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/arm,integrator.yaml          | 39 -----------
 .../devicetree/bindings/arm/arm,realview.yaml | 37 ----------
 .../bindings/arm/arm,versatile.yaml           | 40 +++--------
 .../bindings/leds/register-bit-led.yaml       |  2 +-
 .../mfd/arm,dev-platforms-syscon.yaml         | 67 +++++++++++++++++++
 5 files changed, 76 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/arm,dev-platforms-syscon.yaml

diff --git a/Documentation/devicetree/bindings/arm/arm,integrator.yaml b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
index 98ff5698ae1f..1bdbd1b7ee38 100644
--- a/Documentation/devicetree/bindings/arm/arm,integrator.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
@@ -40,45 +40,6 @@ properties:
         items:
           - const: arm,integrator-sp
 
-  core-module@10000000:
-    type: object
-    description: the root node in the Integrator platforms must contain
-      a core module child node. They are always at physical address
-      0x10000000 in all the Integrator variants.
-    properties:
-      compatible:
-        items:
-          - const: arm,core-module-integrator
-          - const: syscon
-          - const: simple-mfd
-      reg:
-        maxItems: 1
-
-    required:
-      - compatible
-      - reg
-
-patternProperties:
-  "^syscon@[0-9a-f]+$":
-    description: All Integrator boards must provide a system controller as a
-      node in the root of the device tree.
-    type: object
-    properties:
-      compatible:
-        items:
-          - enum:
-              - arm,integrator-ap-syscon
-              - arm,integrator-cp-syscon
-              - arm,integrator-sp-syscon
-          - const: syscon
-      reg:
-        maxItems: 1
-
-    required:
-      - compatible
-      - reg
-
-
 required:
   - compatible
   - core-module@10000000
diff --git a/Documentation/devicetree/bindings/arm/arm,realview.yaml b/Documentation/devicetree/bindings/arm/arm,realview.yaml
index 8d3ed2e4ed31..d1bdee98f9af 100644
--- a/Documentation/devicetree/bindings/arm/arm,realview.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,realview.yaml
@@ -75,43 +75,6 @@ properties:
         type: object
         description: All RealView boards must provide a syscon system controller
           node inside the soc node.
-        properties:
-          compatible:
-            oneOf:
-              - items:
-                  - const: arm,realview-eb11mp-revb-syscon
-                  - const: arm,realview-eb-syscon
-                  - const: syscon
-                  - const: simple-mfd
-              - items:
-                  - const: arm,realview-eb11mp-revc-syscon
-                  - const: arm,realview-eb-syscon
-                  - const: syscon
-                  - const: simple-mfd
-              - items:
-                  - const: arm,realview-eb-syscon
-                  - const: syscon
-                  - const: simple-mfd
-              - items:
-                  - const: arm,realview-pb1176-syscon
-                  - const: syscon
-                  - const: simple-mfd
-              - items:
-                  - const: arm,realview-pb11mp-syscon
-                  - const: syscon
-                  - const: simple-mfd
-              - items:
-                  - const: arm,realview-pba8-syscon
-                  - const: syscon
-                  - const: simple-mfd
-              - items:
-                  - const: arm,realview-pbx-syscon
-                  - const: syscon
-                  - const: simple-mfd
-
-        required:
-          - compatible
-          - reg
 
     required:
       - compatible
diff --git a/Documentation/devicetree/bindings/arm/arm,versatile.yaml b/Documentation/devicetree/bindings/arm/arm,versatile.yaml
index 13e52ba92060..7a3caf6af200 100644
--- a/Documentation/devicetree/bindings/arm/arm,versatile.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,versatile.yaml
@@ -14,6 +14,14 @@ description: |+
   with various pluggable interface boards, in essence the Versatile PB version
   is a superset of the Versatile AB version.
 
+  The root node in the Versatile platforms must contain a core module child
+  node. They are always at physical address 0x10000000 in all the Versatile
+  variants.
+
+  When fitted with the IB2 Interface Board, the Versatile AB will present an
+  optional system controller node which controls the extra peripherals on the
+  interface board.
+
 properties:
   $nodename:
     const: '/'
@@ -32,38 +40,6 @@ properties:
         items:
           - const: arm,versatile-pb
 
-  core-module@10000000:
-    type: object
-    description: the root node in the Versatile platforms must contain
-      a core module child node. They are always at physical address
-      0x10000000 in all the Versatile variants.
-    properties:
-      compatible:
-        items:
-          - const: arm,core-module-versatile
-          - const: syscon
-          - const: simple-mfd
-      reg:
-        maxItems: 1
-
-    required:
-      - compatible
-      - reg
-
-patternProperties:
-  "^syscon@[0-9a-f]+$":
-    type: object
-    description: When fitted with the IB2 Interface Board, the Versatile
-      AB will present an optional system controller node which controls the
-      extra peripherals on the interface board.
-    properties:
-      compatible:
-        contains:
-          const: arm,versatile-ib2-syscon
-    required:
-      - compatible
-      - reg
-
 required:
   - compatible
   - core-module@10000000
diff --git a/Documentation/devicetree/bindings/leds/register-bit-led.yaml b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
index ed26ec19ecbd..20930d327ae9 100644
--- a/Documentation/devicetree/bindings/leds/register-bit-led.yaml
+++ b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
@@ -60,7 +60,7 @@ examples:
   - |
 
     syscon@10000000 {
-        compatible = "arm,realview-pb1176-syscon", "syscon";
+        compatible = "arm,realview-pb1176-syscon", "syscon", "simple-mfd";
         reg = <0x10000000 0x1000>;
         #address-cells = <1>;
         #size-cells = <1>;
diff --git a/Documentation/devicetree/bindings/mfd/arm,dev-platforms-syscon.yaml b/Documentation/devicetree/bindings/mfd/arm,dev-platforms-syscon.yaml
new file mode 100644
index 000000000000..46b164ae0831
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/arm,dev-platforms-syscon.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/arm,dev-platforms-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm Ltd Developer Platforms System Controllers
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  The Arm Ltd Integrator, Realview, and Versatile families of developer
+  platforms are contain various system controller blocks. Often these blocks
+  are part of a daughterboard or motherboard module.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - arm,integrator-ap-syscon
+              - arm,integrator-cp-syscon
+              - arm,integrator-sp-syscon
+              - arm,im-pd1-syscon
+          - const: syscon
+      - items:
+          - enum:
+              - arm,core-module-integrator
+              - arm,integrator-ap-syscon
+              - arm,integrator-cp-syscon
+              - arm,integrator-sp-syscon
+              - arm,realview-eb-syscon
+              - arm,realview-pb1176-syscon
+              - arm,realview-pb11mp-syscon
+              - arm,realview-pba8-syscon
+              - arm,realview-pbx-syscon
+              - arm,versatile-ib2-syscon
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - enum:
+              - arm,realview-eb11mp-revb-syscon
+              - arm,realview-eb11mp-revc-syscon
+          - const: arm,realview-eb-syscon
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties:
+  type: object
+
+...
-- 
2.40.1

