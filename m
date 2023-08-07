Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D7771A61
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjHGG3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjHGG3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:29:23 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 596E51FDF;
        Sun,  6 Aug 2023 23:28:54 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTPS Server V6.0(3962136:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 07 Aug 2023 14:28:11 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 7 Aug
 2023 14:28:11 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 7 Aug 2023 14:28:11 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alina_yu@richtek.com>
Subject: [PATCH v7 1/2] regulator: dt-bindings: rtq2208: Add Richtek RTQ2208 SubPMIC
Date:   Mon, 7 Aug 2023 14:28:06 +0800
Message-ID: <1691389687-31211-2-git-send-email-alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691389687-31211-1-git-send-email-alina_yu@richtek.com>
References: <1691389687-31211-1-git-send-email-alina_yu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Richtek RTQ2208 IC controlled SubPMIC

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
v6
- Add "additionalProperties: false" to regulator node
v5
- Revise filename from $id
- Remove "regulator-compatible" for ldos
- Add missing "high" for "richtek,mtp-sel-high"
- Remove "regulator-mode" property
- Add and modify "unevaluatedProperties: false" and "additionalProperties: false"
- Remove "richtek,fixed-uV"
- Remove redundant space in "buck-a" and "ldo2"
v4
- Modify filename to "richtek,rtq2208"
- Add more desciptions for "regulator-allowed-modes"
---
 .../bindings/regulator/richtek,rtq2208.yaml        | 197 +++++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
new file mode 100644
index 0000000..609c066
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rtq2208.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RTQ2208 SubPMIC Regulator
+
+maintainers:
+  - Alina Yu <alina_yu@richtek.com>
+
+description: |
+  RTQ2208 is a highly integrated power converter that offers functional safety dual
+  multi-configurable synchronous buck converters and two LDOs.
+
+  Bucks support "regulator-allowed-modes" and "regulator-mode". The former defines the permitted
+  switching operation in normal mode; the latter defines the operation in suspend to RAM mode.
+
+  No matter the RTQ2208 is configured to normal or suspend to RAM mode, there are two switching
+  operation modes for all buck rails, automatic power saving mode (Auto mode) and forced continuous
+  conduction mode (FCCM).
+
+  The definition of modes is in the datasheet which is available in below link
+  and their meaning is::
+    0 - Auto mode for power saving, which reducing the switching frequency at light load condition
+    to maintain high frequency.
+    1 - FCCM to meet the strict voltage regulation accuracy, which keeping constant switching frequency.
+
+  Datasheet will be available soon at
+  https://www.richtek.com/assets/Products
+
+properties:
+  compatible:
+    enum:
+      - richtek,rtq2208
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    
+  richtek,mtp-sel-high:
+    type: boolean
+    description:
+      vout register selection based on this boolean value.
+      false - Using DVS0 register setting to adjust vout
+      true - Using DVS1 register setting to adjust vout
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      "^buck-[a-h]$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+        description:
+          description for buck-[a-h] regulator.
+
+        properties:
+          regulator-allowed-modes:
+            description:
+              two buck modes in different switching accuracy.
+              0 - Auto mode
+              1 - FCCM
+            items:
+              enum: [0, 1]
+
+      "^ldo[1-2]$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+        description:
+          regulator description for ldo[1-2].
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@10 {
+        compatible = "richtek,rtq2208";
+        reg = <0x10>;
+        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+        richtek,mtp-sel-high;
+
+        regulators {
+          buck-a {
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+          buck-b {
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+          buck-c {
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+          buck-d {
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+          buck-e {
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+          buck-f {
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+          buck-g {
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+          buck-h {
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <2050000>;
+            regulator-allowed-modes = <0 1>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+              regulator-mode = <1>;
+            };
+          };
+          ldo1 {
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <1200000>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+            };
+          };
+          ldo2 {
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            regulator-always-on;
+            regulator-state-mem {
+              regulator-on-in-suspend;
+            };
+          };
+        };
+      };
+    };
-- 
2.7.4

