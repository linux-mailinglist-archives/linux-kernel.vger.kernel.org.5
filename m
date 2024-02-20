Return-Path: <linux-kernel+bounces-72729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C93BC85B80C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EF31F26F44
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1250657C4;
	Tue, 20 Feb 2024 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERUCIKxn"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CDF626B2;
	Tue, 20 Feb 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422232; cv=none; b=R37AkxpTsx28Nhw55nEeRpcLDPoq5OCDefJ2x9uDOice0L+gzaAfBnsfAI5GjZjWU8wK9DRONo4fgRu3VqXJPRc7jn7N2vGG7ZNd9p8hRRlrayJn17u8Sca7fc62lIDS+7vOeGoXj8Jf/uBxX/LTAa34fez80OWHwNPhvEW6Wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422232; c=relaxed/simple;
	bh=PL9p/fc//p4mKEZ3pbQoYAvWGl2yUwUCKapaVX+GvB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HR0BR1cXzdF2GOz6z92onG70ghXwNiah4Xc4jJLx9RvYDKm9T+7kF2s7bPBNUXKlU60QV4U+Yak7HsMYVO0bs/TMb9idCfPvuX7zBVtuexvYRkHcKyLe62odnXz61vYCg6xqGLozvukpvsYpITLunhjiFT76J0C22CriblzxoxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERUCIKxn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4126aa42402so9584995e9.0;
        Tue, 20 Feb 2024 01:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708422229; x=1709027029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4J6J8VQrcl48Rr9QejprQCFTeVoHKJ+SX2r+VkT0LY=;
        b=ERUCIKxntE0WgrEKMbasr2ooEJiS9H7Gpfxu29jEWKvbtubyyPhFWYAPbIHH00U+QL
         Cuu8r7ehWXTLvx3D7l7Wa8HqzdPlwkmsCLEct/SeCZBK+VVfRrHrU1f0HG96xZGZZ4u8
         DrRsvKjhJlA0YC+mBwC3fgcQNM4NS+0Y0j4CtDWy26d+isbFUnTGHebN04Hy2IBYhYgl
         6hhj8xD1STEhZRVtZnjjvBNKQ8eGU2+ErZzsU/JHng0m13on10UPFsJoaPA+t2AodL4/
         QFP8zeilSlVqJT67x4wA01iG+ZHw1wv2CufT3CfweF0x3+rcA/nNCMashXe4GEHRUdj/
         1J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422229; x=1709027029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4J6J8VQrcl48Rr9QejprQCFTeVoHKJ+SX2r+VkT0LY=;
        b=XubMOmAEf2k9ToctO/rk6OmKwh6aPmjczGRb5gYJfhaLhx8WEEDIsrcE3Qthhlm5Uq
         fmh43PbMVQMmDDldBG32J67PFGMl78Kz6uzF8VlqxKIhoyiILr2CvoCUu0N41fBZjfVW
         akX14pzRRz+m0FK82lqJH3Cw1WlUd8YuUoMaVtwQ9RxaqxHb18xR/mTe6HPPM9WF9HgS
         BeLRcqhLu2MxJMw/61otOCsz6bq9bvRvRNXUy9rdvkdm/l98snJeFTI5iMIVcsaEXbDA
         CU03xKKq7O46kOzrRceBw1H+11aLX2yyslRKipO4FOgoSimVsA5ZN4BOqA0RyZ2TqqjR
         xwIg==
X-Forwarded-Encrypted: i=1; AJvYcCXvMKKAaeDMM9hB80XHHb9cm6XPmqYzDiy1zUGMEt5DH+cP0/shPbBroXqGVTa6GpMC+At14ev6RDtZN9MUnuMijY/7zpUzcftJiAKR2o4Lkm35EkLtPj7ZzUcIx4ZUldwVBXCzmA0BHWtKHtJbPyKPLFS9+cO2Lwf3WVHeOFYipKZacq+aJSHwJNUY9qPyG5Mzk+Hq4U5yys6xkAq3Pvk=
X-Gm-Message-State: AOJu0YwZ8g9h3ixxDdZBYY1WDBECv0tqvKMyY3wIxpqhakg8U+G6XtH/
	Fr1QfiNDc4JptAQVkvGq/0vEQYPRCw2aDdvjG+ATmjjdM2nZj7Io
X-Google-Smtp-Source: AGHT+IEP0BE/3AW3vgs8wQzzoBx3MbLyrjhk27hon+9DyYdwmTDYFMqEJt0bLYWLPSpI5hDq2gax4Q==
X-Received: by 2002:a05:600c:4713:b0:412:6101:9158 with SMTP id v19-20020a05600c471300b0041261019158mr4971935wmo.29.1708422228398;
        Tue, 20 Feb 2024 01:43:48 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c020d00b00410dd253008sm13865092wmi.42.2024.02.20.01.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:43:47 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
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
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v13 1/3] dt-bindings: adc: add AD7173
Date: Tue, 20 Feb 2024 11:43:38 +0200
Message-ID: <20240220094344.17556-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AD7173 family offer a complete integrated Sigma-Delta ADC solution
which can be used in high precision, low noise single channel applications
or higher speed multiplexed applications. The Sigma-Delta ADC is intended
primarily for measurement of signals close to DC but also delivers
outstanding performance with input bandwidths out to ~10kHz.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
V12->V13
 - Remove adi,clock-select
 - Update avdd and avdd2 supply descriptions
 - Update adi,reference-select description to suggest that it is referenced to avss
 - Make clocks/clock-names and clock-controller mutually exclusive
V11->V12
 - Drop "binding", describe hardware in binding description
 - Rename refin and refin2 to vref and vref2
 - Add better description to external references to better show that the voltage
    value that needs to be specified is the difference between the positive and
    negative reference pins
 - Add optional clocks properties
 - Add optional adi,clock-select property
 - Add option for second interrupt, error
 - Add description to interrupts
V10->V11
 - Fix example warning: '#gpio-cells' is a dependency of 'gpio-controller'
 - Add description to #gpio-cells property
V9->V10
 - Fix dt_binding_check type warning from adi,reference-select
V8->v9
 - Add gpio-controller and "#gpio-cells" properties
 - Add missing avdd2 and iovdd supplies
 - Add string type to reference-select
V7->V8
 - include missing fix from V6
V6->V7 <no changes>
V5->V6
 - Moved global required property to proper placement
V4 -> V5
 - Use string enum instead of integers for "adi,reference-select"
 - Fix conditional checking in regards to compatible
V3 -> V4
 - include supply attributes
 - add channel attribute for selecting conversion reference
V2 -> V3
 - remove redundant descriptions
 - use referenced 'bipolar' property
 - remove newlines from example
V1 -> V2 <no changes>

 .../bindings/iio/adc/adi,ad7173.yaml          | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
new file mode 100644
index 000000000000..347a0cc0e278
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -0,0 +1,242 @@
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
+  Analog Devices AD717x ADC's:
+  The AD717x family offer a complete integrated Sigma-Delta ADC solution which
+  can be used in high precision, low noise single channel applications
+  (Life Science measurements) or higher speed multiplexed applications
+  (Factory Automation PLC Input modules). The Sigma-Delta ADC is intended
+  primarily for measurement of signals close to DC but also delivers
+  outstanding performance with input bandwidths out to ~10kHz.
+
+  Datasheets for supported chips:
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
+    minItems: 1
+    description: |
+      Ready interrupt: multiplexed with SPI data out. While SPI CS is low,
+      can be used to indicate the completion of a conversion.
+
+      Error: The three error bits in the status register (ADC_ERROR, CRC_ERROR,
+      and REG_ERROR) are OR'ed, inverted, and mapped to the ERROR pin. Therefore,
+      the ERROR pin indicates that an error has occurred.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: rdy
+      - const: err
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
+  gpio-controller:
+    description: Marks the device node as a GPIO controller.
+
+  '#gpio-cells':
+    const: 2
+    description:
+      The first cell is the GPIO number and the second cell specifies
+      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
+
+  vref-supply:
+    description: |
+      Differential external reference supply used for conversion. The reference
+      voltage (Vref) specified here must be the voltage difference between the
+      REF+ and REF- pins: Vref = (REF+) - (REF-).
+
+  vref2-supply:
+    description: |
+      Differential external reference supply used for conversion. The reference
+      voltage (Vref2) specified here must be the voltage difference between the
+      REF2+ and REF2- pins: Vref2 = (REF2+) - (REF2-).
+
+  avdd-supply:
+    description: Avdd supply, can be used as reference for conversion.
+                 This supply is referenced to AVSS, voltage specified here
+                 represens (AVDD - AVSS).
+
+  avdd2-supply:
+    description: Avdd2 supply, used as the input to the internal voltage regulator.
+                 This supply is referenced to AVSS, voltage specified here
+                 represens (AVDD2 - AVSS).
+
+  iovdd-supply:
+    description: iovdd supply, used for the chip digital interface.
+
+  clocks:
+    maxItems: 1
+    description: |
+      Optional external clock source. Can include one clock source: external
+      clock or external crystal.
+
+  clock-names:
+    enum:
+      - ext-clk
+      - xtal
+
+  '#clock-cells':
+    const: 0
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
+          vref       : REF+  /REF−
+          vref2      : REF2+ /REF2−
+          refout-avss: REFOUT/AVSS (Internal reference)
+          avdd       : AVDD  /AVSS
+
+          External reference ref2 only available on ad7173-8.
+          If not specified, internal reference used.
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - vref
+          - vref2
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
+        vref2-supply: false
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            adi,reference-select:
+              enum:
+                - vref
+                - refout-avss
+                - avdd
+
+  - if:
+      anyOf:
+        - required: [clock-names]
+        - required: [clocks]
+    then:
+      properties:
+        '#clock-cells': false
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
+        interrupt-names = "rdy";
+        interrupt-parent = <&gpio>;
+        spi-max-frequency = <5000000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        #clock-cells = <0>;
+
+        vref-supply = <&dummy_regulator>;
+
+        channel@0 {
+          reg = <0>;
+          bipolar;
+          diff-channels = <0 1>;
+          adi,reference-select = "vref";
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


