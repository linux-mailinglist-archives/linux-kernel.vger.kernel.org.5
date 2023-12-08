Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C580A7EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574416AbjLHPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjLHPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:52:33 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7A81732
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:52:38 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d9dc789f23so1074826a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702050758; x=1702655558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywOUvwzhsPnUFdJdVAjFAoCNpta5mHBDXP1oy697KOo=;
        b=2MoUcj9YFvkv2iRwz7e5CrWUlp8P4KgoQlid/1FtDaSak9neRPP3SoCEzYTFnIFfSn
         i4I2pG/eeYui4Da6DljLGEFGg31TnAy1nxaumz/75ToaeA+/QvqiFP8L7Gw2Gl0eUfbR
         9d5jhI8PO72VXhdDHIjdDUf7QgU7XrQEkmKSxaVgItm3Y4LsvlF89Tf0dfXKAZxCGKGf
         ykqvY6PW6nui/cOFS+JHrKdC7UT3Rpx65krKlC1YZus1fQfDSnfPSQNMPxbudHx7sRE9
         oy0wZ88t1itnyyk+Arw525cvjYL68+eVypJMfeAcJCweTwRst5tjkyj6JssEAyYTLrYw
         22eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050758; x=1702655558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywOUvwzhsPnUFdJdVAjFAoCNpta5mHBDXP1oy697KOo=;
        b=u4KDHyGJvgB3hZy8dPAMz1OS/qwYCuFgSUMx9sKeKYNl9vgcfGhnFSSWV1WufR1/kl
         98todx4u+QHQ+sK3UimJminV1hexGFBZcmT7KjkukMws3NCXSpOH4xDL7i0OASuzSHLE
         aFbrHjDLxHl+w7ICu7DrO1b65gBwAhfhSEff+jcyXga1dh8jt2AQS6SfN/a1xGWdnRdr
         ivY5SPXctUTG5h7itvtWqro8lqll+QvQvvuChpbXnom07VW9vB9/DAzV3gTOYX0OaZOz
         3MkoAM1gXNvf2MHpoRU0k21CAbWv+TFPHqRm5Th24htcJUSSYCLkAaZu2gEJf+wCBU8b
         XjXg==
X-Gm-Message-State: AOJu0Yyis0NQ8R5SSOzK8X71A2obTZ1yZq/gQRlurzyNYmWkCIR6+UY7
        tXYwegHiX3+KQ1+vPR0upiCYaw==
X-Google-Smtp-Source: AGHT+IHkG+gyplKVBDpxQ76jLBUwd33s9xaUCNOB8yW9om0k0ka6BQc2F2sLG95kvFY6zyPXV49f9Q==
X-Received: by 2002:a9d:6ac1:0:b0:6d9:9be4:b8e8 with SMTP id m1-20020a9d6ac1000000b006d99be4b8e8mr195187otq.77.1702050757957;
        Fri, 08 Dec 2023 07:52:37 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id v3-20020a9d7d03000000b006d99d363723sm332032otn.63.2023.12.08.07.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:52:37 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Date:   Fri,  8 Dec 2023 09:51:40 -0600
Message-ID: <20231208-ad7380-mainline-v1-1-2b33fe2f44ae@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
References: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a binding specification for the Analog Devices Inc. AD7380
family of ADCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 102 +++++++++++++++++++++
 MAINTAINERS                                        |   9 ++
 2 files changed, 111 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
new file mode 100644
index 000000000000..e9a0b72cd9d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7380.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices Simultaneous Sampling Analog to Digital Converters
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  * https://www.analog.com/en/products/ad7380.html
+  * https://www.analog.com/en/products/ad7381.html
+  * https://www.analog.com/en/products/ad7383.html
+  * https://www.analog.com/en/products/ad7384.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7380
+      - adi,ad7381
+      - adi,ad7383
+      - adi,ad7384
+
+  reg: true
+
+  spi-max-frequency:
+    maximum: 80000000
+  spi-cpol: true
+  spi-cpha: true
+
+  adi,sdo-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ 1-wire, 2-wire ]
+    description:
+      In 1-wire mode, the SDOA pin acts as the sole data line and the SDOB/ALERT
+      pin acts as the ALERT interrupt signal. In 2-wire mode, data for input A
+      is read from SDOA and data for input B is read from SDOB/ALERT (and the
+      ALERT interrupt signal is not available).
+
+  vcc-supply:
+    description: A 3V to 3.6V supply that powers the chip.
+
+  vlogic-supply:
+    description:
+      A 1.65V to 3.6V supply for the logic pins.
+
+  refio-supply:
+    description:
+      A 2.5V to 3.3V supply for the external reference voltage. When omitted,
+      the internal 2.5V reference is used.
+
+  interrupts:
+    description:
+      When the device is using 1-wire mode, this property is used to optionally
+      specify the ALERT interrupt.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - adi,sdo-mode
+  - vcc-supply
+  - vlogic-supply
+
+allOf:
+  - if:
+      properties:
+        adi,sdo-mode:
+          const: 2-wire
+    then:
+      properties:
+        interrupts: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7380";
+            reg = <0>;
+
+            spi-cpol;
+            spi-cpha;
+            spi-max-frequency = <80000000>;
+
+            adi,sdo-mode = "1-wire";
+            interrupts = <27>;
+
+            vcc-supply = <&supply_3_3V>;
+            vlogic-supply = <&supply_3_3V>;
+            refio-supply = <&supply_2_5V>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fe1f6f97f96a..e2a998be5879 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -430,6 +430,15 @@ W:	http://wiki.analog.com/AD7142
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/input/misc/ad714x.c
 
+AD738X ADC DRIVER (AD7380/1/2/4)
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	David Lechner <dlechner@baylibre.com>
+S:	Supported
+W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+
 AD7877 TOUCHSCREEN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported

-- 
2.43.0

