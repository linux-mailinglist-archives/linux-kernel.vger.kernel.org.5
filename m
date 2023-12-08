Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525FB80AF09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574799AbjLHVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHVzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:55:36 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104A81989
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:55:41 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c25973988so27066935e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702072539; x=1702677339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjvclqOZQPdp/ySHfQ62/WK4T76lvl+K0DABvIIpwvo=;
        b=ID3x8OxZu23v1b/XsPieOYJtzIj11gpTNJ/QsaLM1dhPFpMVuu6+FC8fBlgBRHMPwe
         XHqZ5dDOuyBBNd0AVp8iRZFlMK81VZGP4f082Xy3PG1YSk0csKZ/5YTVO3kqtOls13Wb
         fdYniWjhs52ggwcKO32LsXjnqO8sdu/I5t/4ITqLkRkZoJYelG+0dKgnHXPN//mkQfsX
         oex1Ai9RbZyYry7WzB+8pRMH3qyeKqP5cz5J/bsFZf86e1sNpJ8PoTpYLL+iFELCcBBB
         /nBtn91+SZPwYHcVWWhKhSB10RMYG3oRPfBlErP4fpDf9pRH1FfdnZFHrn+oBtyhKoyR
         bXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072539; x=1702677339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjvclqOZQPdp/ySHfQ62/WK4T76lvl+K0DABvIIpwvo=;
        b=EZY8OAw5HaNr7ovXFvNIw00Ck9hF9yJ4npe+vVRxC+OtqJ8Jx/eRpIleY0rzBV+TKD
         BS7hjPbkLmDjsQswaMABqloQ8Z3ltRejOR1yuR2f78hQBxq6kObgWPik0+R71Agc02j3
         t3LbTADBQ0YjquS/gu0V1RYT248ErnvSWXS1A+I1mAddM9RpoDhfTdWnquxbKscr2rlA
         3erYXxLZXwRw1wnJt8LoWvjvfueMtIB/4P0uya6vDDXbbILSUXdjOr1+Gu/UfDQzT4Tt
         wW73joPz3MLFL2UAQAwVj0FKh+jc8vCXgDW9VLBzbgodhj3SOcRZ/TT4v/82Moc0BLpe
         0uQw==
X-Gm-Message-State: AOJu0Yzp+j2XcDX2ZXV7cLCzH2ekEN4PEYjEHEqWk3X2NtU5ORCWwoZ5
        9stm5G993XcUK3GBr5POyvC8Vw==
X-Google-Smtp-Source: AGHT+IFes8ntwMuaHaAbleFhA6O4kz2plWbx/N3J8ah3XVD6nOLd43XlUH10ZQB9yrHrmf7i0TLudA==
X-Received: by 2002:a05:600c:3ba6:b0:40b:5e21:e27a with SMTP id n38-20020a05600c3ba600b0040b5e21e27amr321653wms.103.1702072539267;
        Fri, 08 Dec 2023 13:55:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm6321789wmo.16.2023.12.08.13.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:55:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/10] dt-bindings: pinctrl: qcom: create common LPASS LPI schema
Date:   Fri,  8 Dec 2023 22:55:25 +0100
Message-Id: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like regular TLMM pin controllers in Qualcomm SoCs, the Low Power
Audio SubSystem (LPASS) Low Power Island (LPI) TLMM blocks share a lot
of properties, so common part can be moved to separate schema to reduce
code duplication and make reviewing easier.

Except the move of common part, this introduces effective changes:
1. To all LPASS LPI bindings: Reference pinmux-node.yaml in each pin
   muxing and configuration node, to bring definition of "function" and
   "pins" properties.

2. qcom,sc7280-lpass-lpi-pinctrl: Reference pinctrl.yaml in top leve.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../pinctrl/qcom,lpass-lpi-common.yaml        | 75 +++++++++++++++++++
 .../qcom,sc7280-lpass-lpi-pinctrl.yaml        | 49 ++----------
 .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 49 +-----------
 .../qcom,sm6115-lpass-lpi-pinctrl.yaml        | 48 +-----------
 .../qcom,sm8250-lpass-lpi-pinctrl.yaml        | 49 +-----------
 .../qcom,sm8350-lpass-lpi-pinctrl.yaml        | 49 +-----------
 .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 49 +-----------
 .../qcom,sm8550-lpass-lpi-pinctrl.yaml        | 49 +-----------
 .../qcom,sm8650-lpass-lpi-pinctrl.yaml        | 49 +-----------
 9 files changed, 109 insertions(+), 357 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml
new file mode 100644
index 000000000000..3b5045730471
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,lpass-lpi-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoC LPASS LPI TLMM Common Properties
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Common properties for the Top Level Mode Multiplexer pin controllers in the
+  Low Power Audio SubSystem (LPASS) Low Power Island (LPI) of Qualcomm SoCs.
+
+properties:
+  gpio-controller: true
+
+  "#gpio-cells":
+    description:
+      Specifying the pin number and flags, as defined in
+      include/dt-bindings/gpio/gpio.h
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+required:
+  - gpio-controller
+  - "#gpio-cells"
+  - gpio-ranges
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+additionalProperties: true
+
+$defs:
+  qcom-tlmm-state:
+    properties:
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        default: 2
+        description:
+          Selects the drive strength for the specified pins, in mA.
+
+      slew-rate:
+        enum: [0, 1, 2, 3]
+        default: 0
+        description: |
+          0: No adjustments
+          1: Higher Slew rate (faster edges)
+          2: Lower Slew rate (slower edges)
+          3: Reserved (No adjustments)
+
+      bias-bus-hold: true
+      bias-pull-down: true
+      bias-pull-up: true
+      bias-disable: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+      - function
+
+    allOf:
+      - $ref: pincfg-node.yaml#
+      - $ref: pinmux-node.yaml#
+
+    additionalProperties: true
+
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
index 00c5a00e35fc..08801cc4e476 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
@@ -20,16 +20,6 @@ properties:
   reg:
     maxItems: 2
 
-  gpio-controller: true
-
-  "#gpio-cells":
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
 patternProperties:
   "-state$":
     oneOf:
@@ -45,7 +35,8 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: /schemas/pinctrl/pincfg-node.yaml
+    $ref: qcom,lpass-lpi-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
 
     properties:
       pins:
@@ -68,42 +59,14 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins.
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
-      slew-rate:
-        enum: [0, 1, 2, 3]
-        default: 0
-        description: |
-            0: No adjustments
-            1: Higher Slew rate (faster edges)
-            2: Lower Slew rate (slower edges)
-            3: Reserved (No adjustments)
-
-      bias-pull-down: true
-      bias-pull-up: true
-      bias-bus-hold: true
-      bias-disable: true
-      output-high: true
-      output-low: true
-
-    required:
-      - pins
-      - function
-
-    additionalProperties: false
-
 required:
   - compatible
   - reg
-  - gpio-controller
-  - "#gpio-cells"
-  - gpio-ranges
 
-additionalProperties: false
+allOf:
+  - $ref: qcom,lpass-lpi-common.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
index a9167dac9ab5..240e6d45cc95 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
@@ -32,16 +32,6 @@ properties:
       - const: core
       - const: audio
 
-  gpio-controller: true
-
-  "#gpio-cells":
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
 patternProperties:
   "-state$":
     oneOf:
@@ -57,7 +47,8 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: /schemas/pinctrl/pincfg-node.yaml
+    $ref: qcom,lpass-lpi-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
 
     properties:
       pins:
@@ -79,48 +70,16 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins.
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
-      slew-rate:
-        enum: [0, 1, 2, 3]
-        default: 0
-        description: |
-          0: No adjustments
-          1: Higher Slew rate (faster edges)
-          2: Lower Slew rate (slower edges)
-          3: Reserved (No adjustments)
-
-      bias-bus-hold: true
-      bias-pull-down: true
-      bias-pull-up: true
-      bias-disable: true
-      input-enable: true
-      output-high: true
-      output-low: true
-
-    required:
-      - pins
-      - function
-
-    additionalProperties: false
-
 allOf:
-  - $ref: pinctrl.yaml#
+  - $ref: qcom,lpass-lpi-common.yaml#
 
 required:
   - compatible
   - reg
   - clocks
   - clock-names
-  - gpio-controller
-  - "#gpio-cells"
-  - gpio-ranges
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
index abac3311fc55..f4cf2ce86fcd 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
@@ -31,16 +31,6 @@ properties:
     items:
       - const: audio
 
-  gpio-controller: true
-
-  "#gpio-cells":
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
 patternProperties:
   "-state$":
     oneOf:
@@ -56,7 +46,8 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: /schemas/pinctrl/pincfg-node.yaml
+    $ref: qcom,lpass-lpi-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
 
     properties:
       pins:
@@ -75,48 +66,17 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins.
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
-      slew-rate:
-        enum: [0, 1, 2, 3]
-        default: 0
-        description: |
-          0: No adjustments
-          1: Higher Slew rate (faster edges)
-          2: Lower Slew rate (slower edges)
-          3: Reserved (No adjustments)
-
-      bias-bus-hold: true
-      bias-pull-down: true
-      bias-pull-up: true
-      bias-disable: true
-      input-enable: true
-      output-high: true
-      output-low: true
-
-    required:
-      - pins
-      - function
-
-    additionalProperties: false
 
 allOf:
-  - $ref: pinctrl.yaml#
+  - $ref: qcom,lpass-lpi-common.yaml#
 
 required:
   - compatible
   - reg
   - clocks
   - clock-names
-  - gpio-controller
-  - "#gpio-cells"
-  - gpio-ranges
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
index 4b4be7efc150..750c996c10a7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
@@ -30,16 +30,6 @@ properties:
       - const: core
       - const: audio
 
-  gpio-controller: true
-
-  "#gpio-cells":
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
 patternProperties:
   "-state$":
     oneOf:
@@ -55,7 +45,8 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: /schemas/pinctrl/pincfg-node.yaml
+    $ref: qcom,lpass-lpi-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
 
     properties:
       pins:
@@ -78,48 +69,16 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins.
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
-      slew-rate:
-        enum: [0, 1, 2, 3]
-        default: 0
-        description: |
-            0: No adjustments
-            1: Higher Slew rate (faster edges)
-            2: Lower Slew rate (slower edges)
-            3: Reserved (No adjustments)
-
-      bias-pull-down: true
-      bias-pull-up: true
-      bias-bus-hold: true
-      bias-disable: true
-      input-enable: true
-      output-high: true
-      output-low: true
-
-    required:
-      - pins
-      - function
-
-    additionalProperties: false
-
 allOf:
-  - $ref: pinctrl.yaml#
+  - $ref: qcom,lpass-lpi-common.yaml#
 
 required:
   - compatible
   - reg
   - clocks
   - clock-names
-  - gpio-controller
-  - "#gpio-cells"
-  - gpio-ranges
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
index 2e65ae08dd21..9d782f910b31 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
@@ -33,16 +33,6 @@ properties:
       - const: core
       - const: audio
 
-  gpio-controller: true
-
-  "#gpio-cells":
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
 patternProperties:
   "-state$":
     oneOf:
@@ -58,7 +48,8 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: /schemas/pinctrl/pincfg-node.yaml
+    $ref: qcom,lpass-lpi-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
 
     properties:
       pins:
@@ -81,48 +72,16 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins.
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
-      slew-rate:
-        enum: [0, 1, 2, 3]
-        default: 0
-        description: |
-          0: No adjustments
-          1: Higher Slew rate (faster edges)
-          2: Lower Slew rate (slower edges)
-          3: Reserved (No adjustments)
-
-      bias-bus-hold: true
-      bias-pull-down: true
-      bias-pull-up: true
-      bias-disable: true
-      input-enable: true
-      output-high: true
-      output-low: true
-
-    required:
-      - pins
-      - function
-
-    additionalProperties: false
-
 allOf:
-  - $ref: pinctrl.yaml#
+  - $ref: qcom,lpass-lpi-common.yaml#
 
 required:
   - compatible
   - reg
   - clocks
   - clock-names
-  - gpio-controller
-  - "#gpio-cells"
-  - gpio-ranges
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
index 1eefa9aa6a86..e7565592da86 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
@@ -32,16 +32,6 @@ properties:
       - const: core
       - const: audio
 
-  gpio-controller: true
-
-  "#gpio-cells":
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
 patternProperties:
   "-state$":
     oneOf:
@@ -57,7 +47,8 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: /schemas/pinctrl/pincfg-node.yaml
+    $ref: qcom,lpass-lpi-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
 
     properties:
       pins:
@@ -81,48 +72,16 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins.
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
-      slew-rate:
-        enum: [0, 1, 2, 3]
-        default: 0
-        description: |
-          0: No adjustments
-          1: Higher Slew rate (faster edges)
-          2: Lower Slew rate (slower edges)
-          3: Reserved (No adjustments)
-
-      bias-bus-hold: true
-      bias-pull-down: true
-      bias-pull-up: true
-      bias-disable: true
-      input-enable: true
-      output-high: true
-      output-low: true
-
-    required:
-      - pins
-      - function
-
-    additionalProperties: false
-
 allOf:
-  - $ref: pinctrl.yaml#
+  - $ref: qcom,lpass-lpi-common.yaml#
 
 required:
   - compatible
   - reg
   - clocks
   - clock-names
-  - gpio-controller
-  - "#gpio-cells"
-  - gpio-ranges
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
index ad5e32130fd7..bf4a72facae1 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
@@ -37,16 +37,6 @@ properties:
       - const: core
       - const: audio
 
-  gpio-controller: true
-
-  "#gpio-cells":
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
 patternProperties:
   "-state$":
     oneOf:
@@ -62,7 +52,8 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: /schemas/pinctrl/pincfg-node.yaml
+    $ref: qcom,lpass-lpi-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
 
     properties:
       pins:
@@ -85,48 +76,16 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins.
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
-      slew-rate:
-        enum: [0, 1, 2, 3]
-        default: 0
-        description: |
-          0: No adjustments
-          1: Higher Slew rate (faster edges)
-          2: Lower Slew rate (slower edges)
-          3: Reserved (No adjustments)
-
-      bias-bus-hold: true
-      bias-pull-down: true
-      bias-pull-up: true
-      bias-disable: true
-      input-enable: true
-      output-high: true
-      output-low: true
-
-    required:
-      - pins
-      - function
-
-    additionalProperties: false
-
 allOf:
-  - $ref: pinctrl.yaml#
+  - $ref: qcom,lpass-lpi-common.yaml#
 
 required:
   - compatible
   - reg
   - clocks
   - clock-names
-  - gpio-controller
-  - "#gpio-cells"
-  - gpio-ranges
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml
index f5736ed140ee..db7214362301 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml
@@ -32,16 +32,6 @@ properties:
       - const: core
       - const: audio
 
-  gpio-controller: true
-
-  "#gpio-cells":
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
-
 patternProperties:
   "-state$":
     oneOf:
@@ -57,7 +47,8 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: /schemas/pinctrl/pincfg-node.yaml
+    $ref: qcom,lpass-lpi-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
 
     properties:
       pins:
@@ -80,48 +71,16 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins.
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
-      slew-rate:
-        enum: [0, 1, 2, 3]
-        default: 0
-        description: |
-          0: No adjustments
-          1: Higher Slew rate (faster edges)
-          2: Lower Slew rate (slower edges)
-          3: Reserved (No adjustments)
-
-      bias-bus-hold: true
-      bias-pull-down: true
-      bias-pull-up: true
-      bias-disable: true
-      input-enable: true
-      output-high: true
-      output-low: true
-
-    required:
-      - pins
-      - function
-
-    additionalProperties: false
-
 allOf:
-  - $ref: pinctrl.yaml#
+  - $ref: qcom,lpass-lpi-common.yaml#
 
 required:
   - compatible
   - reg
   - clocks
   - clock-names
-  - gpio-controller
-  - "#gpio-cells"
-  - gpio-ranges
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

