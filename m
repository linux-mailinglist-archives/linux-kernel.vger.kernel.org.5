Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E25D7D117B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377547AbjJTOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377499AbjJTOYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:24:18 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50436D5F;
        Fri, 20 Oct 2023 07:24:16 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6c4a25f6390so582065a34.2;
        Fri, 20 Oct 2023 07:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697811855; x=1698416655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpyuqb3nsHDmCv8YtSUWMqqdvrrwmI8tv0H9WE8n+t0=;
        b=Lzh2OSmoamk2ccKRNw+qXOySO0jo3RTJurKtWOBAN3q42zgNSTNfIbuh4NH85hNjB/
         FycPUVishWES6qF65/Ob5VIDpx8adLEiT/bHuwpKwgQ9iMnFq8C6G8+vDwDAmrFOmo++
         vt1uH7gVmKiE+vDxiTb2jR/nUDF3N2MF0JX0HXN179RFd2EPLNp9ZPHx7Xv5VM26wkoz
         Qmm08RPeejYaSKVKMFXV+VTB62KGOUBaX6hfh7pV/GGPpvKiAirIAzefWErUjRoy/y94
         u6MdWI2XnBm14PrFdJBDmMG5lWAh0TD177L/GPE6DmQDM7oePz3NpXot5cRrm3f50dMJ
         oi3Q==
X-Gm-Message-State: AOJu0YwWVIudJD5oMNayBGprd3K2su05bdlQCqGCoK/dSmZNN1diC0eH
        AzrBGR67kRqNSYILc6HJhw==
X-Google-Smtp-Source: AGHT+IF5BVhuATH3mF8LocwWD5gHZPV7Pevsya0HXGJBddt6M2u5C2JAdl1zDyilQz/jN1XvUiV2UQ==
X-Received: by 2002:a05:6830:92a:b0:6c6:3ea5:cdbe with SMTP id v42-20020a056830092a00b006c63ea5cdbemr2158742ott.18.1697811855458;
        Fri, 20 Oct 2023 07:24:15 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d13-20020a056830138d00b006b89dafb721sm330177otq.78.2023.10.20.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 07:24:14 -0700 (PDT)
Received: (nullmailer pid 3115824 invoked by uid 1000);
        Fri, 20 Oct 2023 14:24:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [RESEND PATCH v2] dt-bindings: mfd: armltd: Move Arm board syscon's to separate schema
Date:   Fri, 20 Oct 2023 09:22:51 -0500
Message-ID: <20231020142252.3113716-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
2.42.0

