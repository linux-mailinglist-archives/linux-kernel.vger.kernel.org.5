Return-Path: <linux-kernel+bounces-55367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B384BBD1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5121A1C22580
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB368F6F;
	Tue,  6 Feb 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LXCUuUpB"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2468F7D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240410; cv=none; b=E3WUkOpR5xfWJo9cS5/StmuNvMfSwnayW1ElcnYs1jCJBtC7hVxyDUZSVvi/Qn9DzFzPmP6xjha/a4Q18fvCISEZvt4D6IokvWMiiRWCKktOOw9m5ts9qVRU8+hVpjntV52jpAnB33ynk+YNDqCiu0YTFoZrQ3ZLqxkSJfLYW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240410; c=relaxed/simple;
	bh=EidOcuoZW3ufSG/U+3UtA9DRjyVDFhllbJMEYhp2DsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmpeyMC/3HafIlFTqdz535AWdpnNnWK4uchnEnJ+4J8jlFdpADF6XbL3bA0TRxKJuELxik7o5dPK6AoQ6QcGCc9TmrW91Vg+c5dbLjmI6LO0GUi9QICYq7TSyg3ua0xIqnKyFE2qHdLfaqCn/OaZWuco4zYlvGzhbPJDLfkwQxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LXCUuUpB; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21959190723so1815514fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707240407; x=1707845207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhp8UZm2JwOSFCZ1rISqGYvHQLQ2QqVB/JsYTkrLcX0=;
        b=LXCUuUpBIotkPKF5QGBwzPdQGrY0XinVFcgH2718G3nlDLXHtNUlIDScKO54HuosEr
         f8cpllgMJLMzzhClHlZO4eBgygng5GgYvzV8lOsyL0Bdk7/n2qggkpFNZYqTIbTmfoA2
         i4j+N14ZK/AUembetRd0wUkXlhcij6v13EqkDN/wzg6gH9xiWgARrPBSxOtEnq5jm11e
         7iVJS7ZQRmsbAZbODzuX0jcrxDLcdYCtZ90+pkHMfxZETTrRGqJ4KRwo1Qo88MymSipG
         rVCIi0X9VFfld5WJEl2MVbELNdJd4wdoroMyq1GADFUu1PudB+xazVGPT8MYe7hsVUek
         /tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240407; x=1707845207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhp8UZm2JwOSFCZ1rISqGYvHQLQ2QqVB/JsYTkrLcX0=;
        b=BwZaOk4xFLeGicO5/lS7ikoZQ+yDBvr+Y5rhrVskY/v8K03gLWZsTNOq6z0xfNL48M
         jt7SDIRSxUsTBKEYMlJ7FgYWckJMRTs9wb73IRF3P+J7JLjkkU7JIqY5Ya1bOK122sDf
         b6Oq1TLnvv8DMsDvsBTmDwi+aFBMzJu0EEMxGaEBEIUns/BWvjAZfuyql4k9xW9XdmHW
         ZtnFOURTClwPeweJ2Tjlskz+ceWwklUor11sEoFy0FsqXX+7GOIj+Uwp6xTqHPxAEjE3
         I9CcWVJHS6uRoKtljjSqGY0uSgy8TrCITSGyQhkbPKMzVE5gm7Sy8J7bsebEWaPv1Vxj
         KT9g==
X-Gm-Message-State: AOJu0Yz7eMhrNsrt4qddOytqkDs27PN/0UOHOR03zZW7VaTFq2u1uG3o
	p5yZFvPtSg4PKuTgzbcF1ZJAe1PrbWpkHcuaQkB2cohjE2CF5L7AFUL3lS/plgw=
X-Google-Smtp-Source: AGHT+IGtvybYnA0OSMw3GQ2lQJuEJSNQavMG4ZcH+erpgQxYI503qHE3LPDQAqVX8Vog+X5slbPhew==
X-Received: by 2002:a05:6870:970f:b0:210:cd75:8e34 with SMTP id n15-20020a056870970f00b00210cd758e34mr3845774oaq.17.1707240406797;
        Tue, 06 Feb 2024 09:26:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX+EU8lCf+JNmDlH/8bTZ9vSvI3juhTQGpHJy91a3FNy0M0q14XoZWh4GZ80yeHp5r/7YQCOgH9dM+jgGioWgy2s5x1p74CQEXyQH66ehWG/SiPHBaIZAoYBCwuSdNY0E3YdAYEEi6/O9RNVma+wwHm8T8kKbNS5Qym6bsGtRL8gbjwYFMhbvtWvbQ7ekj5FKIX2r8LXzz3cAsuHnFQb1LtZkgZiGhHLEM5JV7S3Dagj+l51TfWdegyYj0McLdHOwx5wRpNN7nTZjunLxWzbiLofN0VGTYsfcnyV+LOqFeZnJUq0/H0BUB79Skhx43pqrFiYo/mbkoWkoKXhoYNtHrNyWcvtNB4uvNFEyQhIUxhw/z8SuKcMsnk22QFnvytqe7T
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ea9-20020a056870070900b0021998dc2bf1sm510172oab.36.2024.02.06.09.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:26:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Date: Tue,  6 Feb 2024 11:25:59 -0600
Message-ID: <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
AD7986 ADCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 231 +++++++++++++++++++++
 MAINTAINERS                                        |   8 +
 2 files changed, 239 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
new file mode 100644
index 000000000000..a023adbeba42
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
@@ -0,0 +1,231 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7944.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices PulSAR LFCSP Analog to Digital Converters
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  A family of pin-compatible single channel differential analog to digital
+  converters with SPI support in a LFCSP package.
+
+  * https://www.analog.com/en/products/ad7944.html
+  * https://www.analog.com/en/products/ad7985.html
+  * https://www.analog.com/en/products/ad7986.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7944
+      - adi,ad7985
+      - adi,ad7986
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 111111111
+
+  spi-cpha: true
+
+  adi,spi-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ 3-wire, 4-wire, chain ]
+    default: 4-wire
+    description:
+      This chip can operate in a 3-wire mode where SDI is tied to VIO, a 4-wire
+      mode where SDI acts as the CS line, or a chain mode where SDI of one chip
+      is tied to the SDO of the next chip in the chain and the SDI of the last
+      chip in the chain is tied to GND.
+
+  avdd-supply:
+    description: A 2.5V supply that powers the analog circuitry.
+
+  dvdd-supply:
+    description: A 2.5V supply that powers the digital circuitry.
+
+  vio-supply:
+    description:
+      A 1.8V to 2.7V supply for the digital inputs and outputs.
+
+  bvdd-supply:
+    description:
+      A voltage supply for the buffered power. When using an external reference
+      without an internal buffer (PDREF high, REFIN low), this should be
+      connected to the same supply as ref-supply. Otherwise, when using an
+      internal reference or an external reference with an internal buffer, this
+      is connected to a 5V supply.
+
+  ref-supply:
+    description:
+      Voltage regulator for the reference voltage (REF). This property is
+      omitted when using an internal reference.
+
+  refin-supply:
+    description:
+      Voltage regulator for the reference buffer input (REFIN). When using an
+      external buffer with internal reference, this should be connected to a
+      1.2V external reference voltage supply.
+
+  adi,reference:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ internal, internal-buffer, external ]
+    default: internal
+    description: |
+      This property is used to specify the reference voltage source.
+
+      * internal: PDREF is wired low. The internal 4.096V reference voltage is
+        used. The REF pin outputs 4.096V and REFIN outputs 1.2V.
+      * internal-buffer: PDREF is wired high. REFIN is supplied with 1.2V. The
+        buffered internal 4.096V reference voltage is used. The REF pin outputs
+        4.096V.
+      * external: PDREF is wired high and REFIN is wired low. The supply
+        connnected the REF pin is used as the reference voltage.
+
+  cnv-gpios:
+    description:
+      The Convert Input (CNV). This input has multiple functions. It initiates
+      the conversions and selects the SPI mode of the device (chain or CS). In
+      3-wire mode, this property is omitted if the CNV pin is connected to the
+      CS line of the SPI controller.
+    maxItems: 1
+
+  turbo-gpios:
+    description:
+      GPIO connected to the TURBO line. If omitted, it is assumed that the TURBO
+      line is hard-wired and the state is determined by the adi,always-turbo
+      property.
+    maxItems: 1
+
+  adi,always-turbo:
+    type: boolean
+    description:
+      When present, this property indicates that the TURBO line is hard-wired
+      and the state is always high. If neither this property nor turbo-gpios is
+      present, the TURBO line is assumed to be hard-wired and the state is
+      always low.
+
+  interrupts:
+    description:
+      The SDO pin can also function as a busy indicator. This node should be
+      connected to an interrupt that is triggered when the SDO line goes low
+      while the SDI line is high and the CNV line is low (3-wire mode) or the
+      SDI line is low and the CNV line is high (4-wire mode); or when the SDO
+      line goes high while the SDI and CNV lines are high (chain mode),
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+  - vio-supply
+  - bvdd-supply
+
+allOf:
+  # ref-supply is only used for external reference voltage
+  - if:
+      not:
+        required:
+          - adi,reference
+    then:
+      properties:
+        ref-supply: false
+    else:
+      if:
+        properties:
+          adi,reference:
+            const: external
+      then:
+        required:
+          - ref-supply
+      else:
+        properties:
+          ref-supply: false
+  # refin-supply is only used for internal buffer reference voltage
+  - if:
+      not:
+        required:
+          - adi,reference
+    then:
+      properties:
+        refin-supply: false
+    else:
+      if:
+        properties:
+          adi,reference:
+            const: internal-buffer
+      then:
+        required:
+          - refin-supply
+      else:
+        properties:
+          refin-supply: false
+  # in 3-wire mode, cnv-gpios is optional, for other modes it is required
+  - if:
+      not:
+        required:
+          - adi,spi-mode
+    then:
+      required:
+        - cnv-gpios
+    else:
+      if:
+        properties:
+          adi,spi-mode:
+            enum: [ 4-wire, chain ]
+      then:
+        required:
+          - cnv-gpios
+  # chain mode doesn't work when TRUBO is enabled
+  - if:
+      properties:
+        adi,spi-mode:
+          const: chain
+      required:
+        - adi,spi-mode
+    then:
+      properties:
+        adi,always-turbo: false
+  # turbo-gpios and adi,always-turbo are mutually exclusive
+  - if:
+      required:
+        - turbo-gpios
+    then:
+      properties:
+        adi,always-turbo: false
+  - if:
+      required:
+        - adi,always-turbo
+    then:
+      properties:
+        turbo-gpios: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+            compatible = "adi,ad7944";
+            reg = <0>;
+            spi-cpha;
+            spi-max-frequency = <111111111>;
+            avdd-supply = <&supply_2_5V>;
+            dvdd-supply = <&supply_2_5V>;
+            vio-supply = <&supply_1_8V>;
+            bvdd-supply = <&supply_5V>;
+            cnv-gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+            turbo-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 00d354af10f5..4f1e658e1e0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -451,6 +451,14 @@ W:	http://wiki.analog.com/AD7879
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/input/touchscreen/ad7879.c
 
+AD7944 ADC DRIVER (AD7944/AD7985/AD7986)
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	David Lechner <dlechner@baylibre.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
+
 ADAFRUIT MINI I2C GAMEPAD
 M:	Anshul Dalal <anshulusr@gmail.com>
 L:	linux-input@vger.kernel.org

-- 
2.43.0


