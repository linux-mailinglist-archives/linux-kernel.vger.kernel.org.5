Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970DA810FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377378AbjLMLV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377206AbjLMLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:21:23 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFB1E3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:21:28 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so71697985e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702466487; x=1703071287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bomf4aXZC8+IO5Rq2ObEdOBWF547Dj5ueGNAmoI5nTA=;
        b=zxjFMSmK4hFwAB567IW+69YMwRTdj8nTNyV3Vcren0FKbHpcFgFRL59pQC9E2kKgts
         aXQdQnvK42Jy1gepnteNF8Q6Albv6exaH5A++NbRcJ8mjgB5qpmtWjPOpBUCGW/yWLWf
         DpruQMV5EvOpU+01Sj19QWcV8XVvd5JEDw9qUZkFG0l2WWR4k4yiaZx9GBDwki31HN47
         /XXzo0IGECm2M3fiM2IPKbfXd1zE8suzYJ8np83TETmpQF5QF8OzADyxCU6yeECWhwRG
         PCDfPszjsy21hyiAmaUUgHyASwUo5Gnz06syt7jH7Dq0MI9she9mWO4k4iURGMgYJnY3
         MKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702466487; x=1703071287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bomf4aXZC8+IO5Rq2ObEdOBWF547Dj5ueGNAmoI5nTA=;
        b=N/p7tn6bEMN8s6iyCGlSsZgZOMT4FgPJFbJSvFZrSbnmLQenRBEjoTzeJ3o64YsmWY
         AKJVpUeEj6LGGlVxjVdWKk89dAukSVOzlyZYPBCCYPcsJfMW9NsB/qPhcSGr1iZ74Hsq
         pXnAyFF9Jvx+j7y1j0jkhLN6KOR3vLvUn6f5mFs0hcdurhtOuTww5Kpwij1ijjBizwrc
         YI1VjpVpNbA9/UcbrAhN6AaSwAT9C8TmQdE8a4ZT08zaKpeFT2Ew1eZNXmMxqyD+lYxL
         PZ8YNMm5JsJZdSDpQPa6yWI0Dzu7HmKg+SY6JO2D3wru1Vyf/Gd6Ao50RhaMk8p8pxlg
         VTwg==
X-Gm-Message-State: AOJu0Yy8wGS9RfsAy1Dw4CR0LEMTOkHJGMl2NoSMbE4L1GVBJmCY/29c
        V3Ohg8Swzj2wraHdekGnqVWyWQ==
X-Google-Smtp-Source: AGHT+IHSl5XN25l8BlzIZdtXtV06HArIrJdtvYV01fS7XJjeeyfTNbqysMD3xvgXqexr5gVKLCZpAw==
X-Received: by 2002:a05:600c:46cf:b0:40c:32ef:aa87 with SMTP id q15-20020a05600c46cf00b0040c32efaa87mr4282647wmo.146.1702466486842;
        Wed, 13 Dec 2023 03:21:26 -0800 (PST)
Received: from localhost.localdomain (abordeaux-655-1-152-60.w90-5.abo.wanadoo.fr. [90.5.9.60])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b0040b3515cdf8sm20097617wms.7.2023.12.13.03.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:21:26 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Date:   Wed, 13 Dec 2023 05:21:19 -0600
Message-Id: <20231213-ad7380-mainline-v2-2-cd32150d84a3@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
References: <20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com>
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

v2 changes:
- Added maxItems to reg property
- Replaced adi,sdo-mode property with spi-rx-bus-channels
- Made spi-rx-bus-channels property optional with default value of 1
    (this made the if: check more complex)
- Changed example to use gpio for interrupt

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 107 +++++++++++++++++++++
 MAINTAINERS                                        |   9 ++
 2 files changed, 116 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
new file mode 100644
index 000000000000..43d58c52f7dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -0,0 +1,107 @@
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
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 80000000
+  spi-cpol: true
+  spi-cpha: true
+
+  spi-rx-bus-channels:
+    description:
+      In 1-wire mode, the SDOA pin acts as the sole data line and the SDOB/ALERT
+      pin acts as the ALERT interrupt signal. In 2-wire mode, data for input A
+      is read from SDOA and data for input B is read from SDOB/ALERT (and the
+      ALERT interrupt signal is not available).
+    enum: [1, 2]
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
+  - vcc-supply
+  - vlogic-supply
+
+allOf:
+  - if:
+      required:
+        - spi-rx-bus-channels
+    then:
+      if:
+        properties:
+          spi-rx-bus-channels:
+            const: 2
+      then:
+        properties:
+          interrupts: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
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
+            interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio0>;
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
2.34.1

