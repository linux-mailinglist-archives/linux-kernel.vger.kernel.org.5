Return-Path: <linux-kernel+bounces-84857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB33986ACA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E353A1C2254B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF94F12EBF0;
	Wed, 28 Feb 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMzfXjGi"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50AF1468FE;
	Wed, 28 Feb 2024 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118390; cv=none; b=gX5FvZsDynrKaNH2rnG3sqozQ5pSPgONkkByLysow8S+yYuZ1vBIpmBSkGh03J7nnBlv0NkyXLu+Oi7asSsKEeXNIRUa2rnuQCymh+u9ielQb8KS+7UYVOHQQHVGEEyIR8UX7QlBW+3quKsJKSTzSZRTJURgoikCLR8s/7nYMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118390; c=relaxed/simple;
	bh=NG9jjFMMGUsZRhIERVitOP0wAPVxrbwVxWx7a41Jx6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+KSOMqr+jW5bwNu72yYRFK/gptjSAaeSLVMEeo2jVPxiZHUU7VfjoYDjC9rM7GrYLYVF6rqsF3KyJIkyeWY2Ced1tck4XQHt8xGIdNFUXZPZ4F54G0bbyzwjXS/wbVRB4Syb+/Fo8xL6nyiuMpVPNE84R276RvWBUFdr5FTLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMzfXjGi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e550ef31cso601991266b.3;
        Wed, 28 Feb 2024 03:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709118387; x=1709723187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXR+vZSRsxp+bz7abuSwBYoIFwH+xPcJow77x1YgBck=;
        b=KMzfXjGijpao6hhmVK5ac0Nk85XrzzVnDEZcLKgmisRon+xkr+voWjZUPfWl/1okMe
         dBEWh8i03uD40rs2uU1eHaboHimOZkUfz98Q1pDM/NHYksZ9C5XydCVEHQi/tMOQncvJ
         iSaUB8tDml8hhvGW+plg5MgxO74I66QSyVsD9qF0Sp+Q0rqfyns3yXr3p4fKcmk5O4ns
         /OVmZ8WqqLKvnrHrbjXfA9KzOjiWnNT22cd+pQV1aBCFnoMyhiQAZWKwmwIZOJAYF7IN
         hxAODMh2sd81PfbvUzhWz8aAkHch1Ho4EqP80CTV78LDBiPoTE4N23vKiZXDmMA3R6T8
         esiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709118387; x=1709723187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXR+vZSRsxp+bz7abuSwBYoIFwH+xPcJow77x1YgBck=;
        b=WwG782p+ofDofYngZPWoJ38vaCwNc2NugpUBTl2jXuWyFVcu7ihirLJ/J0FYTMTuWp
         uIgEUl9VTEnKmOdiXgy3Gd1yv+GYJckMOOnhEVY6CcsOP4GwsJvX6B5v5Zmyx23wDfbY
         zP9CDdJFoAtbUrOajk7oX4goagrpWcIapjyUfIRuWcHEuuLH2Z/w5Aq5atpJQor1UzGn
         BX+e6DoZk8ej/d/PySXbMf03eRt+PzGDqDvB7bgC19JBXxceSv1ixH+VEt+5X0QEnDlV
         gVo1HHzFUZ+inXRnj94KokZr5a5cjZZU7cOD4DK6vlF1pK6IOAY3JeD2HWqRR0mjYdEy
         6dEA==
X-Forwarded-Encrypted: i=1; AJvYcCXVu/EY0Qgfik+wBS4OReVaR5hFczE0SMdZBBJJg8V+qhvuwvBWDVAmbFBwZ9LqPXToTv9FI0faz3q1tL4Eibukc4iS5RxUAwBCbl0JtrjKs68oCsl/LySHKRtf2Y3VH6oRRG+h3OKEe+UozR6q4ztI2u+sDSmDnOpAmP/A2mJ9kw2U5ygHu+sy5bdxCKwCJXH2SJmzmKRaVAXcskEVGAQ=
X-Gm-Message-State: AOJu0YzckGQSg+PPOe+VupQIy4u3etURpj9NYOi4sEfdspxf+R+eOQHo
	XL2fgeeoeMNsLMM4OWZybEGZqLEyccchBV7ljMg2nVrBH9TIQSwZPfzSOoHaztOCohMj
X-Google-Smtp-Source: AGHT+IEbWqHRF8dL43pgacUx97konC6OS79BSf8dfRykVJzAyrnZR3G9ffSbZZDrFZ+JNESNDRU1rQ==
X-Received: by 2002:a17:906:3507:b0:a43:9f21:1a08 with SMTP id r7-20020a170906350700b00a439f211a08mr3471529eja.63.1709118386683;
        Wed, 28 Feb 2024 03:06:26 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090622cb00b00a431e4d5deasm1717773eja.155.2024.02.28.03.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:06:26 -0800 (PST)
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
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 1/3] dt-bindings: adc: add AD7173
Date: Wed, 28 Feb 2024 13:06:18 +0200
Message-ID: <20240228110622.25114-1-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
Link: https://lore.kernel.org/r/20240223133758.9787-1-mitrutzceclan@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V15->V16 <no changes>
V14->V15 <no changes>
V13->V14
 - Refer in descriptions of the avdd-supply as AVDD1 in concordance to datasheet
 - Fix typo
 - Place interrupts descriptions separately for each item
 - Restrict max channel reg to 3 for models AD717x-2
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
 .../bindings/iio/adc/adi,ad7173.yaml          | 246 ++++++++++++++++++
 1 file changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
new file mode 100644
index 000000000000..36f16a325bc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -0,0 +1,246 @@
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
+    items:
+      - description: |
+          Ready: multiplexed with SPI data out. While SPI CS is low,
+          can be used to indicate the completion of a conversion.
+
+      - description: |
+          Error: The three error bits in the status register (ADC_ERROR, CRC_ERROR,
+          and REG_ERROR) are OR'ed, inverted, and mapped to the ERROR pin.
+          Therefore, the ERROR pin indicates that an error has occurred.
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
+                 represents (AVDD1 - AVSS).
+
+  avdd2-supply:
+    description: Avdd2 supply, used as the input to the internal voltage regulator.
+                 This supply is referenced to AVSS, voltage specified here
+                 represents (AVDD2 - AVSS).
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
+            reg:
+              maximum: 3
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
2.43.0


