Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9E77DBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbjHPISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242828AbjHPIR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:17:58 -0400
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC0D94;
        Wed, 16 Aug 2023 01:17:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1804206|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0624248-0.000285605-0.93729;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.UI3zHA1_1692173867;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.UI3zHA1_1692173867)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 16:17:50 +0800
From:   like@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com,
        wangweidong.a@awinic.com, Alec Li <like@awinic.com>
Subject: [PATCH v4 2/2] regulator: dt-bindings: Add Awinic AW37503
Date:   Wed, 16 Aug 2023 08:17:28 +0000
Message-ID: <20230816081728.2812458-3-like@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816081728.2812458-1-like@awinic.com>
References: <20230816081728.2812458-1-like@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alec Li <like@awinic.com>

Add aw37503 regulator device-tree binding documentation.

Signed-off-by: Alec Li <like@awinic.com>
---
 .../bindings/regulator/awinic,aw37503.yaml    | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml

diff --git a/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml b/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
new file mode 100644
index 000000000000..65a891505808
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
@@ -0,0 +1,80 @@
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
+description: |
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
+    description: |
+      Properties for single regulator.
+
+    properties:
+      regulator-name: true
+      regulator-always-on: true
+      regulator-boot-on: true
+      enable-gpio:
+        maxItems: 1
+        description: |
+          GPIO specifier to enable the GPIO control (on/off) for regulator.
+
+    required:
+      - regulator-name
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
+                enable-gpio = <&gpio 17 GPIO_ACTIVE_LOW>;
+            };
+
+            outn {
+                regulator-name = "outn";
+                regulator-boot-on;
+                regulator-always-on;
+                enable-gpio = <&gpio 27 GPIO_ACTIVE_LOW>;
+            };
+        };
+    };
+...
-- 
2.41.0

