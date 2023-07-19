Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EFB7594FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGSMTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGSMTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:19:30 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D7710D4;
        Wed, 19 Jul 2023 05:19:27 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 6AD99209A8;
        Wed, 19 Jul 2023 14:19:23 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        patches@opensource.cirrus.com
Subject: [PATCH v1] ASoC: dt-bindings: wm8904: Convert to dtschema
Date:   Wed, 19 Jul 2023 14:19:18 +0200
Message-Id: <20230719121918.247397-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Convert the WM8904 audio CODEC bindings to DT schema.

Compared to the original binding #sound-dai-cells and the missing power
supplies are added. The latter are all required as described in the
datasheet.

Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../devicetree/bindings/sound/wlf,wm8904.yaml | 74 +++++++++++++++++++
 .../devicetree/bindings/sound/wm8904.txt      | 33 ---------
 2 files changed, 74 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
new file mode 100644
index 000000000000..329260cf0fa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8904.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wolfson WM8904/WM8912 audio codecs
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description: |
+  Pins on the device (for linking into audio routes):
+  IN1L, IN1R, IN2L, IN2R, IN3L, IN3R, HPOUTL, HPOUTR, LINEOUTL, LINEOUTR,
+  MICBIAS
+
+properties:
+  compatible:
+    enum:
+      - wlf,wm8904
+      - wlf,wm8912
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+  AVDD-supply: true
+  CPVDD-supply: true
+  DBVDD-supply: true
+  DCVDD-supply: true
+  MICVDD-supply: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - AVDD-supply
+  - CPVDD-supply
+  - DBVDD-supply
+  - DCVDD-supply
+  - MICVDD-supply
+
+allOf:
+  - $ref: dai-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            compatible = "wlf,wm8904";
+            reg = <0x1a>;
+            clocks = <&pck0>;
+            clock-names = "mclk";
+            AVDD-supply = <&reg_1p8v>;
+            CPVDD-supply = <&reg_1p8v>;
+            DBVDD-supply = <&reg_1p8v>;
+            DCVDD-supply = <&reg_1p8v>;
+            MICVDD-supply = <&reg_1p8v>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/wm8904.txt b/Documentation/devicetree/bindings/sound/wm8904.txt
deleted file mode 100644
index 66bf261423b9..000000000000
--- a/Documentation/devicetree/bindings/sound/wm8904.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-WM8904 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-  - compatible: "wlf,wm8904" or "wlf,wm8912"
-  - reg: the I2C address of the device.
-  - clock-names: "mclk"
-  - clocks: reference to
-    <Documentation/devicetree/bindings/clock/clock-bindings.txt>
-
-Pins on the device (for linking into audio routes):
-
-  * IN1L
-  * IN1R
-  * IN2L
-  * IN2R
-  * IN3L
-  * IN3R
-  * HPOUTL
-  * HPOUTR
-  * LINEOUTL
-  * LINEOUTR
-  * MICBIAS
-
-Examples:
-
-codec: wm8904@1a {
-	compatible = "wlf,wm8904";
-	reg = <0x1a>;
-	clocks = <&pck0>;
-	clock-names = "mclk";
-};
-- 
2.25.1

