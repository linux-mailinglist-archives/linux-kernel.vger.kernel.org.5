Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC18B80E967
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjLLKpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:45:02 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE87A0;
        Tue, 12 Dec 2023 02:45:08 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1f8f470903so311201366b.1;
        Tue, 12 Dec 2023 02:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702377906; x=1702982706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDoKshOkT4oCICh2o81EREp905fbii0tDR9Si3tjgWs=;
        b=TXZFx4aEkbGbnwDXU76390wyQvFqwgKUOEytwEa9STZPVS76aJLLpgWlciCY19cIAd
         4TfdiUQBU+eYEThjCcoChTVkCix/WVdNHHk2ApkyGCANRcxo99yX7cW9sNWVjCNVYDCR
         xX1ax1gfCxAhbpA9yBAXRbjgtu2flZ9myVtTXbp22aWazH7UsTZ/k28eEIPPMEl9vPCx
         IlEFHaL8G75gYLxBHJAhTVbYpifgwsfE10gEqff9Dj8vcFm7ys+fVI9xq2KK33CM297T
         hfRs2zAbCAJRqbd3nZiA3j/l1cgMQ9v9fDpk7hsd00MRYjD9jaWWCi7yOvXAcKIFj82Y
         38xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377906; x=1702982706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDoKshOkT4oCICh2o81EREp905fbii0tDR9Si3tjgWs=;
        b=QPKceZprUrG//IoAzY61uU1uGjxwDj5YT4UotF7aCVMwsiJMadlkEHQ6omSfQ2Q8R5
         KiLpunInaoGlFcT1iZ/n7RIW2azXGGe9UbTfetcJkRh25LuAmfGncuCNlFwQuhbrnQ7P
         HT+0lWxEjkyWQb5xFg8Ty+22j9fISqucHG1oDUYVNimbaoEt7z1s+5FD6xWJEScCBbMk
         c/yYWdm5LR24MCLEPsrECQAbyZCd8F2ou2M4nyM00jXQG7Of6hTzacHSdpt8FWIjYkt3
         joqsR1EauDAuHVpfYdowZ2N9bzqOvEzMgid916ezLSJZ8eaPqpnlaGu/jTHBpxm/7VxG
         5Q2Q==
X-Gm-Message-State: AOJu0YwPI/8+1sdUf2G1u1RNdiz5RaeHPOWjxTyriYj/hVp6DI287NJz
        YO6fy0nxldrQ3+q9uv8zSAE=
X-Google-Smtp-Source: AGHT+IGwmSAFBmPK8BIkBt+jlW7Oce8vXCTkIslcIlDx6vDOikQAgus7RKZh9vRAc+tFlysqi2cZMg==
X-Received: by 2002:a17:906:230f:b0:a02:a2cc:66b5 with SMTP id l15-20020a170906230f00b00a02a2cc66b5mr3394168eja.76.1702377906245;
        Tue, 12 Dec 2023 02:45:06 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id vo10-20020a170907a80a00b00a1d17c92ef3sm6066013ejc.51.2023.12.12.02.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:45:05 -0800 (PST)
From:   Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v8 1/2] dt-bindings: adc: add AD7173
Date:   Tue, 12 Dec 2023 12:44:35 +0200
Message-ID: <20231212104451.22522-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD7173 family offer a complete integrated Sigma-Delta ADC solution
which can be used in high precision, low noise single channel applications
or higher speed multiplexed applications. The Sigma-Delta ADC is intended
primarily for measurement of signals close to DC but also delivers
outstanding performance with input bandwidths out to ~10kHz.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
V7->V8
 - include missing fix from V6

 .../bindings/iio/adc/adi,ad7173.yaml          | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
new file mode 100644
index 000000000000..25a5404ee353
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7173 ADC
+
+maintainers:
+  - Ceclan Dumitru <dumitru.ceclan@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported chips:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7176-2.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7172-2
+      - adi,ad7173-8
+      - adi,ad7175-2
+      - adi,ad7176-2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  refin-supply:
+    description: external reference supply, can be used as reference for conversion.
+
+  refin2-supply:
+    description: external reference supply, can be used as reference for conversion.
+
+  avdd-supply:
+    description: avdd supply, can be used as reference for conversion.
+
+patternProperties:
+  "^channel@[0-9a-f]$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 15
+
+      diff-channels:
+        items:
+          minimum: 0
+          maximum: 31
+
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on
+          the specific channel. Valid values are:
+          refin      : REFIN(+)/REFIN(−).
+          refin2     : REFIN2(+)/REFIN2(−)
+          refout-avss: REFOUT/AVSS (Internal reference)
+          avdd       : AVDD
+
+          External reference refin2 only available on ad7173-8.
+          If not specified, internal reference used.
+        enum:
+          - refin
+          - refin2
+          - refout-avss
+          - avdd
+        default: refout-avss
+
+    required:
+      - reg
+      - diff-channels
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: adi,ad7173-8
+    then:
+      properties:
+        refin2-supply: false
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            adi,reference-select:
+              enum:
+                - refin
+                - refout-avss
+                - avdd
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,ad7173-8";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-parent = <&gpio>;
+        spi-max-frequency = <5000000>;
+
+        refin-supply = <&dummy_regulator>;
+
+        channel@0 {
+          reg = <0>;
+          bipolar;
+          diff-channels = <0 1>;
+          adi,reference-select = "refin";
+        };
+
+        channel@1 {
+          reg = <1>;
+          diff-channels = <2 3>;
+        };
+
+        channel@2 {
+          reg = <2>;
+          bipolar;
+          diff-channels = <4 5>;
+        };
+
+        channel@3 {
+          reg = <3>;
+          bipolar;
+          diff-channels = <6 7>;
+        };
+
+        channel@4 {
+          reg = <4>;
+          diff-channels = <8 9>;
+          adi,reference-select = "avdd";
+        };
+      };
+    };
-- 
2.42.0

