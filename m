Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6BD80B576
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjLIRQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjLIRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:16:54 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93219171F;
        Sat,  9 Dec 2023 09:16:58 -0800 (PST)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B5B4E1605EE;
        Sat,  9 Dec 2023 18:16:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1702142215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PPGimCb0zCWXLCiPqrGvo8uTZvUT1nMQ9vjpb2d7wuQ=;
        b=E5r1eHYznJSMqBUPUymD3AjmIzfW4ojNWHc5g49DFMGQaUpwKSaL8S3xopOKbTZoLoVFoQ
        mLdmSuG0spZUKbh5GuV0IS+LS74yCFrW1pE+DbwtMo8JNkTvLk2DMH4VnvKQaNF4c8tqS/
        0jLT3GQx2RBy5GNN0tqJHKRoWAITrKM=
From:   David Heidelberg <david@ixit.cz>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>, Rob Herring <robh@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: arm: hwmon: gpio-fan: Convert txt bindings to yaml
Date:   Sat,  9 Dec 2023 18:15:39 +0100
Message-ID: <20231209171653.85468-1-david@ixit.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert fan devices connected to GPIOs to the YAML syntax.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v4:
 - dropped the 1st example
 - dropped unused label in 2nd example (now 1st example)

 .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 -------------
 .../devicetree/bindings/hwmon/gpio-fan.yaml   | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
deleted file mode 100644
index f4cfa350f6a1..000000000000
--- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Bindings for fan connected to GPIO lines
-
-Required properties:
-- compatible : "gpio-fan"
-
-Optional properties:
-- gpios: Specifies the pins that map to bits in the control value,
-  ordered MSB-->LSB.
-- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
-  control value that should be set to achieve them. This array
-  must have the RPM values in ascending order.
-- alarm-gpios: This pin going active indicates something is wrong with
-  the fan, and a udev event will be fired.
-- #cooling-cells: If used as a cooling device, must be <2>
-  Also see:
-  Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
-  min and max states are derived from the speed-map of the fan.
-
-Note: At least one the "gpios" or "alarm-gpios" properties must be set.
-
-Examples:
-
-	gpio_fan {
-		compatible = "gpio-fan";
-		gpios = <&gpio1 14 1
-			 &gpio1 13 1>;
-		gpio-fan,speed-map = <0    0
-				      3000 1
-				      6000 2>;
-		alarm-gpios = <&gpio1 15 1>;
-	};
-	gpio_fan_cool: gpio_fan {
-		compatible = "gpio-fan";
-		gpios = <&gpio2 14 1
-			 &gpio2 13 1>;
-		gpio-fan,speed-map =	<0    0>,
-					<3000 1>,
-					<6000 2>;
-		alarm-gpios = <&gpio2 15 1>;
-		#cooling-cells = <2>; /* min followed by max */
-	};
diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
new file mode 100644
index 000000000000..7f30cfc87350
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/gpio-fan.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fan connected to GPIO lines
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  compatible:
+    const: gpio-fan
+
+  gpios:
+    description: |
+      Specifies the pins that map to bits in the control value,
+      ordered MSB-->LSB.
+    minItems: 1
+    maxItems: 7
+
+  alarm-gpios:
+    maxItems: 1
+
+  gpio-fan,speed-map:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 2
+    maxItems: 127
+    items:
+      items:
+        - description: fan speed in RPMs
+        - description: control value
+    description: |
+      A mapping of possible fan RPM speeds and the
+      control value that should be set to achieve them. This array
+      must have the RPM values in ascending order.
+
+  '#cooling-cells':
+    const: 2
+
+required:
+  - compatible
+  - gpios
+  - gpio-fan,speed-map
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio-fan {
+      compatible = "gpio-fan";
+      gpios = <&gpio2 14 1
+               &gpio2 13 1>;
+      gpio-fan,speed-map = <   0 0>,
+                           <3000 1>,
+                           <6000 2>;
+      alarm-gpios = <&gpio2 15 1>;
+      #cooling-cells = <2>; /* min followed by max */
+    };
-- 
2.42.0

