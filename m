Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68197A2F25
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbjIPKGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbjIPKFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:05:34 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0B2CD8;
        Sat, 16 Sep 2023 03:05:26 -0700 (PDT)
Received: from p200300ccff1003001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff10:300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qhSAy-003piy-Ov; Sat, 16 Sep 2023 12:05:20 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qhSAy-006vKj-05;
        Sat, 16 Sep 2023 12:05:20 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lee@kernel.org, bcousson@baylibre.com, tony@atomide.com,
        mturquette@baylibre.com, sboyd@kernel.org, andreas@kemnade.info,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/5] dt-bindings: mfd: convert twl-family.txt to json-schema
Date:   Sat, 16 Sep 2023 12:05:11 +0200
Message-Id: <20230916100515.1650336-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230916100515.1650336-1-andreas@kemnade.info>
References: <20230916100515.1650336-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the TWL[46]030 binding to DT schema format. To do it as a step by
step work, do not include / handle nodes for subdevices yet, just convert
things with minimal corrections. There are already some bindings for its
subdevices in the tree.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/input/twl4030-pwrbutton.txt      |  2 +-
 .../devicetree/bindings/mfd/ti,twl.yaml       | 64 +++++++++++++++++++
 .../devicetree/bindings/mfd/twl-family.txt    | 46 -------------
 3 files changed, 65 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl-family.txt

diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
index f5021214edecb..6c201a2ba8acf 100644
--- a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
+++ b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
@@ -1,7 +1,7 @@
 Texas Instruments TWL family (twl4030) pwrbutton module
 
 This module is part of the TWL4030. For more details about the whole
-chip see Documentation/devicetree/bindings/mfd/twl-family.txt.
+chip see Documentation/devicetree/bindings/mfd/ti,twl.yaml.
 
 This module provides a simple power button event via an Interrupt.
 
diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
new file mode 100644
index 0000000000000..f125b254a4b93
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,twl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL family
+
+maintainers:
+  - Andreas Kemnade <andreas@kemnade.info>
+
+description: |
+  The TWLs are Integrated Power Management Chips.
+  Some version might contain much more analog function like
+  USB transceiver or Audio amplifier.
+  These chips are connected to an i2c bus.
+
+properties:
+  compatible:
+    description:
+      TWL4030 for integrated power-management/audio CODEC device used in OMAP3
+      based boards
+      TWL6030/32 for integrated power-management used in OMAP4 based boards
+    enum:
+      - ti,twl4030
+      - ti,twl6030
+      - ti,twl6032
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@48 {
+        compatible = "ti,twl6030";
+        reg = <0x48>;
+        interrupts = <39>; /* IRQ_SYS_1N cascaded to gic */
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        interrupt-parent = <&gic>;
+      };
+    };
+
diff --git a/Documentation/devicetree/bindings/mfd/twl-family.txt b/Documentation/devicetree/bindings/mfd/twl-family.txt
deleted file mode 100644
index c2f9302965dea..0000000000000
--- a/Documentation/devicetree/bindings/mfd/twl-family.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Texas Instruments TWL family
-
-The TWLs are Integrated Power Management Chips.
-Some version might contain much more analog function like
-USB transceiver or Audio amplifier.
-These chips are connected to an i2c bus.
-
-
-Required properties:
-- compatible : Must be "ti,twl4030";
-  For Integrated power-management/audio CODEC device used in OMAP3
-  based boards
-- compatible : Must be "ti,twl6030";
-  For Integrated power-management used in OMAP4 based boards
-- interrupts : This i2c device has an IRQ line connected to the main SoC
-- interrupt-controller : Since the twl support several interrupts internally,
-  it is considered as an interrupt controller cascaded to the SoC one.
-- #interrupt-cells = <1>;
-
-Optional node:
-- Child nodes contain in the twl. The twl family is made of several variants
-  that support a different number of features.
-  The children nodes will thus depend of the capability of the variant.
-
-
-Example:
-/*
- * Integrated Power Management Chip
- * https://www.ti.com/lit/ds/symlink/twl6030.pdf
- */
-twl@48 {
-    compatible = "ti,twl6030";
-    reg = <0x48>;
-    interrupts = <39>; /* IRQ_SYS_1N cascaded to gic */
-    interrupt-controller;
-    #interrupt-cells = <1>;
-    interrupt-parent = <&gic>;
-    #address-cells = <1>;
-    #size-cells = <0>;
-
-    twl_rtc {
-        compatible = "ti,twl_rtc";
-        interrupts = <11>;
-        reg = <0>;
-    };
-};
-- 
2.39.2

