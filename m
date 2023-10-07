Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C724C7BCA8F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjJGXs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjJGXsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:48:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFE3BA;
        Sat,  7 Oct 2023 16:48:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9338e4695so41918391fa.2;
        Sat, 07 Oct 2023 16:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696722526; x=1697327326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj10Py7IBKBz9XXHSbV7ylgPUIRscGPue9zQsqhzdac=;
        b=f0UmpYTTVytN2d2wmUbClDyQPR3fxuvdcrYyCq8zFUm/sKxh2EpN0sxYWdMBiyK9RE
         /lXYgOkL8kxTRmFi1MTL2azC6KRcIxTQbGd8paQRbs373jXJPOxWTkkliSHE3H+w1RtY
         BpMGuf5iBeebSDxpHO1iyUSrVEom7I/WIA0g+qKTimdqhHayN6sARoXM9qzfEGKt75p2
         UEb0E+IF/BuJcHZJa9QWF/HYI0HdAb21h0gToOv8UVS6fhmG2+ZWyR4oAtsEsM3I8YX+
         LMe8JJiLrUZlT56D8phD9tk3GqMZag4tv4ARKZTK1d/ZXtDoEMQ1jq8SMBuEFtaYPF11
         Tjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696722526; x=1697327326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj10Py7IBKBz9XXHSbV7ylgPUIRscGPue9zQsqhzdac=;
        b=pQZRepQOB/1lBu+zqdVSDhcJZxbi+RpOK2OaKTx7aNYEZgv8+Phi89ykxNyLgV2SV1
         o0RescrU5VUE6UaPzsJEhoJ5Z9KQYVnqctA5va9hKJ5zk9kog8ympP5rze6nz6wz9DI3
         SASbIUcapYh6BH9La1Oq2t1kRT+OPPcDaGBgcXRLY/+HT+5+TUOd4OUNClhrQUuOy3sA
         /9gLVa6Sk2HRJaEuXWIxNpqGMgwEcme4yqo6zWPveVu1BNfq5dpkUATrPWAAKJ3O/tU2
         Ffmhbvss5O2GkUb6TVHf6mnySpsvnQQ7m8RyfO6/NXHMor2lP/S997ybeOcP2/X8rkcJ
         CvbA==
X-Gm-Message-State: AOJu0YxgacE9d6er0sMbSSFJ0dEMBodzIfqUzAsdt9UUw0mwXnizOIR0
        R7LoDo6dyFerLpg97rYUHGE=
X-Google-Smtp-Source: AGHT+IGGF1JfL9Ke09LCBmYH4gmlG2UxxrwfIDHdV656IMTLh2cXVoTFB2HN+l98IJSIOBkk3AGoyA==
X-Received: by 2002:a19:8c5a:0:b0:504:7f2e:9391 with SMTP id i26-20020a198c5a000000b005047f2e9391mr9442696lfj.34.1696722525705;
        Sat, 07 Oct 2023 16:48:45 -0700 (PDT)
Received: from fr.lan ([46.31.31.132])
        by smtp.googlemail.com with ESMTPSA id k7-20020a2e8887000000b002c0336f0f27sm1359871lji.119.2023.10.07.16.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 16:48:45 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH v5 1/2] dt-bindings: adc: provide max34408/9 device tree binding document
Date:   Sun,  8 Oct 2023 02:48:37 +0300
Message-ID: <20231007234838.8748-2-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007234838.8748-1-fr0st61te@gmail.com>
References: <20231007234838.8748-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware binding for i2c current monitoring device with overcurrent
control.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 .../bindings/iio/adc/maxim,max34408.yaml      | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
new file mode 100644
index 000000000000..9749f1fd1802
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Two- and four-channel current monitors with overcurrent control
+
+maintainers:
+  - Ivan Mikhaylov <fr0st61te@gmail.com>
+
+description: |
+  The MAX34408/MAX34409 are two- and four-channel current monitors that are
+  configured and monitored with a standard I2C/SMBus serial interface. Each
+  unidirectional current sensor offers precision high-side operation with a
+  low full-scale sense voltage. The devices automatically sequence through
+  two or four channels and collect the current-sense samples and average them
+  to reduce the effect of impulse noise. The raw ADC samples are compared to
+  user-programmable digital thresholds to indicate overcurrent conditions.
+  Overcurrent conditions trigger a hardware output to provide an immediate
+  indication to shut down any necessary external circuitry.
+
+  Specifications about the devices can be found at:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max34408
+      - maxim,max34409
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  powerdown-gpios:
+    description:
+      Shutdown Output. Open-drain output. This output transitions to high impedance
+      when any of the digital comparator thresholds are exceeded as long as the ENA
+      pin is high.
+    maxItems: 1
+
+  shtdn-enable-gpios:
+    description:
+      SHTDN Enable Input. CMOS digital input. Connect to GND to clear the latch and
+      unconditionally deassert (force low) the SHTDN output and reset the shutdown
+      delay. Connect to VDD to enable normal latch operation of the SHTDN output.
+    maxItems: 1
+
+  vdd-supply: true
+
+patternProperties:
+  "^channel@[0-3]$":
+    $ref: adc.yaml
+    type: object
+    description:
+      Represents the internal channels of the ADC.
+
+    properties:
+      reg:
+        items:
+          minimum: 0
+          maximum: 3
+
+      maxim,rsense-val-micro-ohms:
+        description:
+          Adjust the Rsense value to monitor higher or lower current levels for
+          input.
+        enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
+        default: 1000
+
+    required:
+      - reg
+      - maxim,rsense-val-micro-ohms
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max34408
+    then:
+      patternProperties:
+        "^channel@[2-3]$": false
+        "^channel@[0-1]$":
+          properties:
+            reg:
+              minimum: 0
+              maximum: 1
+    else:
+      patternProperties:
+        "^channel@[0-3]$":
+          properties:
+            reg:
+              minimum: 0
+              maximum: 3
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
+        adc@1e {
+              compatible = "maxim,max34409";
+              reg = <0x1e>;
+              powerdown-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+              shtdn-enable-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              channel@0 {
+                  reg = <0x0>;
+                  maxim,rsense-val-micro-ohms = <5000>;
+              };
+
+              channel@1 {
+                  reg = <0x1>;
+                  maxim,rsense-val-micro-ohms = <10000>;
+             };
+        };
+    };
-- 
2.42.0

