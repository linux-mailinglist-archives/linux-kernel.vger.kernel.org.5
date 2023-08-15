Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9919577C593
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjHOCBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjHOCBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:01:12 -0400
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC60B0;
        Mon, 14 Aug 2023 19:01:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1570643|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0624248-0.000285605-0.93729;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.UGpC1cr_1692064861;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.UGpC1cr_1692064861)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 10:01:04 +0800
From:   like@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com,
        wangweidong.a@awinic.com, Alec Li <like@awinic.com>
Subject: [PATCH v3 2/2] regulator: dt-bindings: Add Awinic AW37503
Date:   Tue, 15 Aug 2023 02:00:44 +0000
Message-ID: <20230815020044.2159900-3-like@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815020044.2159900-1-like@awinic.com>
References: <20230815020044.2159900-1-like@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alec Li <like@awinic.com>

Add aw37503 regulator device-tree binding documentation.

Signed-off-by: Alec Li <like@awinic.com>
---
 .../bindings/regulator/awinic,aw37503.yaml    | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml

diff --git a/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml b/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
new file mode 100644
index 000000000000..e2770511a082
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/awinic,aw37503.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW37503 Voltage Regulator
+
+maintainers:
+  - Alec Li <like@awinic.com>
+
+description:
+  The AW37503 are dual voltage regulator, designed to support positive/negative
+  supply for driving TFT-LCD panels. It support software-configurable output
+  switching and monitoring. The output voltages can be programmed via an I2C
+  compatible interface.
+
+properties:
+  compatible:
+    const: awinic,aw37503
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^out[pn]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - outp
+  - outn
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@3e {
+            compatible = "awinic,aw37503";
+            reg = <0x3e>;
+
+            outp {
+                regulator-name = "outp";
+                regulator-boot-on;
+                regulator-always-on;
+                enable-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+            };
+
+            outn {
+                regulator-name = "outn";
+                regulator-boot-on;
+                regulator-always-on;
+                enable-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+            };
+        };
+    };
+...
-- 
2.41.0

