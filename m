Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8447AA037
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjIUUeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjIUUdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:33:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F82266EA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:32:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c01d22f332so28698751fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317549; x=1695922349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZXK6IdVBTSXcGTIHRUU/WhDyCqjH/rftizzn5sbxAE=;
        b=k1i4uBjTloXGxXlLxo2zcwKsbn6RrrqAdMoTX9iZ7Cx7ZaOHg6WnbwC8mF4FmoDypf
         ZFOJIabFJgxhrMx/l5pCOg1Rxj700qsrVDLR2trikSx5Wqc6DXD30AyEMUY/4WOZm39h
         BnagZwFRmlK5RaIhfouTfu0peyGOlGqlN9qqb2sU67c3rd2ktpiFS1i8JxuJ9EWCYNv9
         +hK/d5mMK4H9KS+o3ikUqlxKGgp/LTjevFQFeoTQoEfadvYR86FyHtIj+7Zz/JfIXyUL
         O0Um9KE9ZepIv0/FeCHYQ14GyxQl/rRmGhsU6tjKokgASXjRIhQVbbAe2jPaRyg7OTvf
         PI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317549; x=1695922349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZXK6IdVBTSXcGTIHRUU/WhDyCqjH/rftizzn5sbxAE=;
        b=ps0Sm/Q1rTIee54D9URaUF1iLFMmiRCNb86WZmYdvBjnlDyA05W4ev/ApFHylknmHV
         0UzD0OBHHmzlAHNOqg3DUyIgB5kpEeQjfc+lI73KT9TCDmjww2Ex52Al76N2lSzi1B7z
         ykSie/7Ayk/GMgAEDcgMDvVeEdqdcdjrg0nvIwU4U61UGAgfI7pO5WdEglf/5Kj0hVNn
         1UF1i7vjll6DQPYr7dRk45xuayjUN3M8CBc5MlU0XX2nL5o/7L92VlmO4ya2m1/Zofgy
         9oWbTJEzl7a6uxi3mAayb7VrE0Yxx/YViu3fA7Q0h+8tgWLLpdmBIkeV9Og3yR644NFF
         fihg==
X-Gm-Message-State: AOJu0YyV3Y6jgMv9/xEuqan+7JyPHIA+RV4shXMtPkx+iHSuA6rIrdIG
        xM4yZiWO7Asd3wyLa7JGvmyK3enyUeNLRSJB0rv86/CJ
X-Google-Smtp-Source: AGHT+IHMEHv2klXQ63wwzWGVjMOGX5bZqWdw2Z4sNl3hAMpsWXkSNUzWXIDheODJzKMZ7lJR41f9Ow==
X-Received: by 2002:a5d:4dc2:0:b0:320:968:f3b0 with SMTP id f2-20020a5d4dc2000000b003200968f3b0mr6330695wru.35.1695307453560;
        Thu, 21 Sep 2023 07:44:13 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:13 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>
Subject: [PATCH v2 01/19] dt-bindings: iio: resolver: add devicetree bindings for ad2s1210
Date:   Thu, 21 Sep 2023 09:43:42 -0500
Message-Id: <20230921144400.62380-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds new DeviceTree bindings for the Analog Devices, Inc. AD2S1210
resolver-to-digital converter.

Co-developed-by: Apelete Seketeli <aseketeli@baylibre.com>
Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Add Co-developed-by:
* Remove extraneous quotes on strings
* Remove extraneous pipe on some multi-line descriptions

 .../bindings/iio/resolver/adi,ad2s1210.yaml   | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml

diff --git a/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
new file mode 100644
index 000000000000..f55c9652cfb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/resolver/adi,ad2s1210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD2S1210 Resolver-to-Digital Converter
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  The AD2S1210 is a complete 10-bit to 16-bit resolution tracking
+  resolver-to-digital converter, integrating an on-board programmable
+  sinusoidal oscillator that provides sine wave excitation for
+  resolvers.
+
+  The AD2S1210 allows the user to read the angular position or the
+  angular velocity data directly from the parallel outputs or through
+  the serial interface.
+
+    A1  A0  Result
+     0   0  Normal mode - position output
+     0   1  Normal mode - velocity output
+     1   0  Reserved
+     1   1  Configuration mode
+
+  In normal mode, the resolution of the digital output is selected using
+  the RES0 and RES1 input pins. In configuration mode, the resolution is
+  selected by setting the RES0 and RES1 bits in the control register.
+
+  RES1  RES0  Resolution (Bits)
+     0     0  10
+     0     1  12
+     1     0  14
+     1     1  16
+
+  Note on SPI connections: The CS line on the AD2S1210 should hard-wired to
+  logic low and the WR/FSYNC line on the AD2S1210 should be connected to the
+  SPI CSn output of the SPI controller.
+
+  Datasheet:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad2s1210.pdf
+
+properties:
+  compatible:
+    const: adi,ad2s1210
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  spi-cpha: true
+
+  clocks:
+    maxItems: 1
+    description: External oscillator clock (CLKIN).
+
+  reset-gpios:
+    description:
+      GPIO connected to the /RESET pin. As the line needs to be low for the
+      reset to be active, it should be configured as GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  sample-gpios:
+    description:
+      GPIO connected to the /SAMPLE pin. As the line needs to be low to trigger
+      a sample, it should be configured as GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  mode-gpios:
+    description:
+      GPIO lines connected to the A0 and A1 pins. These pins select the data
+      transfer mode.
+    minItems: 2
+    maxItems: 2
+
+  resolution-gpios:
+    description:
+      GPIO lines connected to the RES0 and RES1 pins. These pins select the
+      resolution of the digital output. If omitted, it is assumed that the
+      RES0 and RES1 pins are hard-wired to match the assigned-resolution-bits
+      property.
+    minItems: 2
+    maxItems: 2
+
+  fault-gpios:
+    description:
+      GPIO lines connected to the LOT and DOS pins. These pins combined indicate
+      the type of fault present, if any. As these pins a pulled low to indicate
+      a fault condition, they should be configured as GPIO_ACTIVE_LOW.
+    minItems: 2
+    maxItems: 2
+
+  adi,fixed-mode:
+    description:
+      This is used to indicate the selected mode if A0 and A1 are hard-wired
+      instead of connected to GPIOS (i.e. mode-gpios is omitted).
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [config, velocity, position]
+
+  assigned-resolution-bits:
+    description:
+      Resolution of the digital output required by the application. This
+      determines the precision of the angle and/or the maximum speed that can
+      be measured. If resolution-gpios is omitted, it is assumed that RES0 and
+      RES1 are hard-wired to match this value.
+    enum: [10, 12, 14, 16]
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - clocks
+  - sample-gpios
+  - assigned-resolution-bits
+
+oneOf:
+  - required:
+      - mode-gpios
+  - required:
+      - adi,fixed-mode
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        resolver@0 {
+            compatible = "adi,ad2s1210";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            spi-cpha;
+            clocks = <&ext_osc>;
+            sample-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
+            mode-gpios = <&gpio0 86 0>, <&gpio0 87 0>;
+            resolution-gpios = <&gpio0 88 0>, <&gpio0 89 0>;
+            assigned-resolution-bits = <16>;
+        };
+    };
-- 
2.34.1

