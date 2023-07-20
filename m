Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C120A75AC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGTLAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGTLAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:00:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7E02106
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:00:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9923833737eso101447466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689850812; x=1690455612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9z/c9UefbSAEbd+LpqHcGpHJ3vAJFkKNN8r0KWFm0Q4=;
        b=Ny5jrNcYHAgo2DRvdezAyhJASg9CIiIwZpvlMpZG1tNG2rjUcrgUmE5D0jlUlpDs5r
         AYEowUP+GIXIGXK9dEEcbKhpfCfASdRY716Ul8FdnEEK6Mt+O+8KHlL3c8rKbMU3oWlj
         PU5mMqZr4vhFLrRYovpaiLvNjxCI945CECyo3eI0ebRkvYoXk+wQs9kCVeBEI1EaNiwW
         wdNe4HVIopIHkwrLP5+BN8wWIniGtQcW1EihaB1XOKTp6VcWC6FB7Y+TvZdplr5IAtqI
         T81y1RnvrPK94Out0+TvPcDt6OYuFZS9rkh8YiFWmuhTuw8mx4rNT6NLOHd6KPbndC23
         RwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689850812; x=1690455612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z/c9UefbSAEbd+LpqHcGpHJ3vAJFkKNN8r0KWFm0Q4=;
        b=NE4ZpaASDmzVPO2jav+MAUgrlOsg9w1uJUHuujyxTp1J1dk1IETmo29rUSmGoZw0Sr
         f50Pw3OMqfoW7bedmX1GyorM6pUwIBdOM2uKvM2R+ZfFnN3y7+NN5y11SJjNq6+FkML8
         8+OsMI1qnBHf7n4hs9tQqz7DzkOZw1KRq2/ENaZgH9UTbud4U1BpcoHa+Snc8s8EScfV
         hwCMJDM3e6UH5j1WlTa354BP2ZsRE5kYVUi65QG7FJ6Csmrv6ttWQ9A7FfSda/6gnN/r
         2HbyffsUaqcF6QocI978mWd1rcdRIHrXBzJ6Z749dB37JEzjom3aFiqafy5LFFD3AKQX
         y2gg==
X-Gm-Message-State: ABy/qLbI3cl+pyjY7ZNIjR4v0lTuwV8eWkftUV5fgn6QzP3M3XJYA97f
        AHwhxg0qB3mc71bLt15WR8plHA==
X-Google-Smtp-Source: APBJJlFK+zNR1tMd4ygdCovbTwqR8uy9awBkAzPQfHRlwgrxnLOwENp0Kui525Rn8ECYHjOBId0x9g==
X-Received: by 2002:a17:906:51d9:b0:993:a379:6158 with SMTP id v25-20020a17090651d900b00993a3796158mr5071138ejk.17.1689850812076;
        Thu, 20 Jul 2023 04:00:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f7-20020a170906494700b00965a4350411sm541025ejt.9.2023.07.20.04.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:00:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: input: convert syna,rmi4 to DT schema
Date:   Thu, 20 Jul 2023 13:00:08 +0200
Message-Id: <20230720110008.133359-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bindings for Synaptics RMI4 bus and devices to DT schema.
Changes during conversion:
1. Add reset-gpios already used in DTS and mentioned by RMI4
   specification.
2. Do not require address/size cells, because without functions
   (children) they aren't really needed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Jason, Matthias, Vincent,
I put your names as maintainers, because moderately recently you were
changing the driver. Let me know if this is okay or you prefer not to
maintain the hardware.
---
 .../bindings/input/rmi4/rmi_2d_sensor.txt     |  56 ----
 .../bindings/input/rmi4/rmi_f01.txt           |  39 ---
 .../bindings/input/rmi4/rmi_i2c.txt           |  61 ----
 .../bindings/input/rmi4/rmi_spi.txt           |  56 ----
 .../devicetree/bindings/input/syna,rmi4.yaml  | 271 ++++++++++++++++++
 5 files changed, 271 insertions(+), 212 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
 delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
 delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
 create mode 100644 Documentation/devicetree/bindings/input/syna,rmi4.yaml

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
deleted file mode 100644
index 9afffbdf6e28..000000000000
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Synaptics RMI4 2D Sensor Device Binding
-
-The Synaptics RMI4 core is able to support RMI4 devices using different
-transports and different functions. This file describes the device tree
-bindings for devices which contain 2D sensors using Function 11 or
-Function 12. Complete documentation for transports and other functions
-can be found in:
-Documentation/devicetree/bindings/input/rmi4.
-
-RMI4 Function 11 and Function 12 are for 2D touch position sensing.
-Additional documentation for F11 can be found at:
-http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
-
-Optional Touch Properties:
-Description in Documentation/devicetree/bindings/input/touchscreen
-- touchscreen-inverted-x
-- touchscreen-inverted-y
-- touchscreen-swapped-x-y
-- touchscreen-x-mm
-- touchscreen-y-mm
-
-Optional Properties:
-- syna,clip-x-low: Sets a minimum value for X.
-- syna,clip-y-low: Sets a minimum value for Y.
-- syna,clip-x-high: Sets a maximum value for X.
-- syna,clip-y-high: Sets a maximum value for Y.
-- syna,offset-x: Add an offset to X.
-- syna,offset-y: Add an offset to Y.
-- syna,delta-x-threshold: Set the minimum distance on the X axis required
-				to generate an interrupt in reduced reporting
-				mode.
-- syna,delta-y-threshold: Set the minimum distance on the Y axis required
-				to generate an interrupt in reduced reporting
-				mode.
-- syna,sensor-type: Set the sensor type. 1 for touchscreen 2 for touchpad.
-- syna,disable-report-mask: Mask for disabling posiiton reporting. Used to
-				disable reporing absolute position data.
-- syna,rezero-wait-ms: Time in miliseconds to wait after issuing a rezero
-				command.
-
-
-Example of a RMI4 I2C device with F11:
-Example:
-	&i2c1 {
-		rmi4-i2c-dev@2c {
-			compatible = "syna,rmi4-i2c";
-
-			...
-
-			rmi4-f11@11 {
-				reg = <0x11>;
-				touchscreen-inverted-y;
-				syna,sensor-type = <2>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
deleted file mode 100644
index 079cad2b6843..000000000000
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Synaptics RMI4 F01 Device Binding
-
-The Synaptics RMI4 core is able to support RMI4 devices using different
-transports and different functions. This file describes the device tree
-bindings for devices which contain Function 1. Complete documentation
-for transports and other functions can be found in:
-Documentation/devicetree/bindings/input/rmi4.
-
-Additional documentation for F01 can be found at:
-http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
-
-Optional Properties:
-- syna,nosleep-mode: If set the device will run at full power without sleeping.
-			nosleep has 3 modes, 0 will not change the default
-			setting, 1 will disable nosleep (allow sleeping),
-			and 2 will enable nosleep (disabling sleep).
-- syna,wakeup-threshold: Defines the amplitude of the disturbance to the
-				background capacitance that will cause the
-				device to wake from dozing.
-- syna,doze-holdoff-ms: The delay to wait after the last finger lift and the
-				first doze cycle.
-- syna,doze-interval-ms: The time period that the device sleeps between finger
-				activity.
-
-
-Example of a RMI4 I2C device with F01:
-	Example:
-	&i2c1 {
-		rmi4-i2c-dev@2c {
-			compatible = "syna,rmi4-i2c";
-
-			...
-
-			rmi4-f01@1 {
-				reg = <0x1>;
-				syna,nosleep-mode = <1>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
deleted file mode 100644
index dcb012f5b3ee..000000000000
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-Synaptics RMI4 I2C Device Binding
-
-The Synaptics RMI4 core is able to support RMI4 devices using different
-transports and different functions. This file describes the device tree
-bindings for devices using the I2C transport driver. Complete documentation
-for other transports and functions can be found in
-Documentation/devicetree/bindings/input/rmi4.
-
-Required Properties:
-- compatible: syna,rmi4-i2c
-- reg: I2C address
-- #address-cells: Set to 1 to indicate that the function child nodes
-		    consist of only on uint32 value.
-- #size-cells: Set to 0 to indicate that the function child nodes do not
-		have a size property.
-
-Optional Properties:
-- interrupts: interrupt which the rmi device is connected to.
-See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-- syna,reset-delay-ms: The number of milliseconds to wait after resetting the
-			device.
-
-- syna,startup-delay-ms: The number of milliseconds to wait after powering on
-			 the device.
-
-- vdd-supply: VDD power supply.
-See ../regulator/regulator.txt
-
-- vio-supply: VIO power supply
-See ../regulator/regulator.txt
-
-Function Parameters:
-Parameters specific to RMI functions are contained in child nodes of the rmi device
- node. Documentation for the parameters of each function can be found in:
-Documentation/devicetree/bindings/input/rmi4/rmi_f*.txt.
-
-
-
-Example:
-	&i2c1 {
-		rmi4-i2c-dev@2c {
-			compatible = "syna,rmi4-i2c";
-			reg = <0x2c>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&gpio>;
-			interrupts = <4 2>;
-
-			rmi4-f01@1 {
-				reg = <0x1>;
-				syna,nosleep-mode = <1>;
-			};
-
-			rmi4-f11@11 {
-				reg = <0x11>;
-				touchscreen-inverted-y;
-				syna,sensor-type = <2>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
deleted file mode 100644
index 632f473db65b..000000000000
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Synaptics RMI4 SPI Device Binding
-
-The Synaptics RMI4 core is able to support RMI4 devices using different
-transports and different functions. This file describes the device tree
-bindings for devices using the SPI transport driver. Complete documentation
-for other transports and functions can be found in
-Documentation/devicetree/bindings/input/rmi4.
-
-Required Properties:
-- compatible: syna,rmi4-spi
-- reg: Chip select address for the device
-- #address-cells: Set to 1 to indicate that the function child nodes
-		    consist of only on uint32 value.
-- #size-cells: Set to 0 to indicate that the function child nodes do not
-		have a size property.
-
-Optional Properties:
-- interrupts: interrupt which the rmi device is connected to.
-See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-- spi-rx-delay-us: microsecond delay after a read transfer.
-- spi-tx-delay-us: microsecond delay after a write transfer.
-
-Function Parameters:
-Parameters specific to RMI functions are contained in child nodes of the rmi device
- node. Documentation for the parameters of each function can be found in:
-Documentation/devicetree/bindings/input/rmi4/rmi_f*.txt.
-
-
-
-Example:
-	spi@7000d800 {
-		rmi4-spi-dev@0 {
-			compatible = "syna,rmi4-spi";
-			reg = <0x0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			spi-max-frequency = <4000000>;
-			spi-cpha;
-			spi-cpol;
-			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(K, 2) 0x2>;
-			spi-rx-delay-us = <30>;
-
-			rmi4-f01@1 {
-				reg = <0x1>;
-				syna,nosleep-mode = <1>;
-			};
-
-			rmi4-f11@11 {
-				reg = <0x11>;
-				touchscreen-inverted-y;
-				syna,sensor-type = <2>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
new file mode 100644
index 000000000000..286b4d52cea9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
@@ -0,0 +1,271 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/syna,rmi4.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics RMI4 compliant devices
+
+maintainers:
+  - Jason A. Donenfeld <Jason@zx2c4.com>
+  - Matthias Schiffer <matthias.schiffer@ew.tq-group.com
+  - Vincent Huang <vincent.huang@tw.synaptics.com>
+
+description: |
+  The Synaptics RMI4 (Register Mapped Interface 4) core is able to support RMI4
+  devices using different transports (I2C, SPI) and different functions (e.g.
+  Function 1, 2D sensors using Function 11 or 12).
+
+properties:
+  compatible:
+    enum:
+      - syna,rmi4-i2c
+      - syna,rmi4-spi
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: Active low signal
+
+  spi-cpha: true
+  spi-cpol: true
+
+  syna,reset-delay-ms:
+    description:
+      Delay to wait after resetting the device.
+
+  syna,startup-delay-ms:
+    description:
+      Delay to wait after powering on the device.
+
+  vdd-supply: true
+  vio-supply: true
+
+  rmi4-f01@1:
+    type: object
+    additionalProperties: false
+    description:
+      Function 1
+
+    properties:
+      reg:
+        maxItems: 1
+
+      syna,nosleep-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+        description:
+          If set the device will run at full power without sleeping.  nosleep
+          has 3 modes, 0 will not change the default setting, 1 will disable
+          nosleep (allow sleeping), and 2 will enable nosleep (disabling
+          sleep).
+
+      syna,wakeup-threshold:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Defines the amplitude of the disturbance to the background
+          capacitance that will cause the device to wake from dozing.
+
+      syna,doze-holdoff-ms:
+        description:
+          The delay to wait after the last finger lift and the first doze
+          cycle.
+
+      syna,doze-interval-ms:
+        description:
+          The time period that the device sleeps between finger activity.
+
+    required:
+      - reg
+
+patternProperties:
+  "^rmi4-f1[12]@1[12]$":
+    type: object
+    unevaluatedProperties: false
+    $ref: /schemas/input/touchscreen/touchscreen.yaml#
+    description:
+      RMI4 Function 11 and Function 12 are for 2D touch position sensing.
+
+    properties:
+      reg:
+        maxItems: 1
+
+      syna,clip-x-low:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Minimum value for X.
+
+      syna,clip-y-low:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Minimum value for Y.
+
+      syna,clip-x-high:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Maximum value for X.
+
+      syna,clip-y-high:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Maximum value for Y.
+
+      syna,offset-x:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Add an offset to X.
+
+      syna,offset-y:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Add an offset to Y.
+
+      syna,delta-x-threshold:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Minimum distance on the X axis required to generate an interrupt in
+          reduced reporting mode.
+
+      syna,delta-y-threshold:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Minimum distance on the Y axis required to generate an interrupt in
+          reduced reporting mode.
+
+      syna,sensor-type:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2]
+        description: |
+          Sensor type: 1 for touchscreen 2 for touchpad.
+
+      syna,disable-report-mask:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Mask for disabling posiiton reporting. Used to disable reporing
+          absolute position data.
+
+      syna,rezero-wait-ms:
+        description:
+          Time to wait after issuing a rezero command.
+
+    required:
+      - reg
+
+  "^rmi4-f[0-9a-z]+@[0-9a-z]+$":
+    type: object
+    description:
+      Other functions, not documented yet.
+
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: syna,rmi4-i2c
+    then:
+      properties:
+        spi-rx-delay-us: false
+        spi-tx-delay-us: false
+    else:
+      properties:
+        syna,reset-delay-ms: false
+        syna,startup-delay-ms: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@20 {
+            compatible = "syna,rmi4-i2c";
+            reg = <0x20>;
+            interrupt-parent = <&gpx1>;
+            interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+
+            syna,startup-delay-ms = <100>;
+            vdd-supply = <&tsp_vdd>;
+            vio-supply = <&ldo32_reg>;
+
+            pinctrl-0 = <&touch_irq>;
+            pinctrl-names = "default";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            rmi4-f01@1 {
+                reg = <0x1>;
+                syna,nosleep-mode = <1>;
+            };
+
+            rmi4-f12@12 {
+                reg = <0x12>;
+                syna,sensor-type = <1>;
+            };
+
+            rmi4-f1a@1a {
+                reg = <0x1a>;
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@0 {
+            compatible = "syna,rmi4-spi";
+            reg = <0x0>;
+            interrupt-parent = <&gpx1>;
+            interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+
+            spi-max-frequency = <4000000>;
+            spi-rx-delay-us = <30>;
+            spi-cpha;
+            spi-cpol;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            rmi4-f01@1 {
+                reg = <0x1>;
+                syna,nosleep-mode = <1>;
+            };
+
+            rmi4-f11@11 {
+                reg = <0x11>;
+                touchscreen-inverted-y;
+                syna,sensor-type = <2>;
+            };
+        };
+    };
-- 
2.34.1

