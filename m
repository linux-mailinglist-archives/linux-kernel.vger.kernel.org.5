Return-Path: <linux-kernel+bounces-69262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9991885865A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0401C22BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81B13849C;
	Fri, 16 Feb 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Msy6i5QD"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E4136662
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112854; cv=none; b=MW/BbTazC1GlSwS8wZGYVqK6A//QQXbPKtfnGV9ecERYZKXSYNigCBBtF21No7c6wUKwRQbACU3sOisfVxvofDUKKbNOwTKVTnkTMxM2QmR4nSLErRQx38mM///31a7AeGOiQp7KZQ7Ss3RlrrcNjznQGahHhOF1sMgfCVkPBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112854; c=relaxed/simple;
	bh=9T+xW+uRPnvu++upeqSjYoW9sVJRavLn1+6hjgB5tPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byb8C+1F8Zc3WyEoPvqxg1VAiMk9KKsqE9y6vQaljePDIHoRfnSBcSzEA5ZaE4a3XcA5TQI7m+aBLqZ9j3mgNG5Bzi+RolcnSKQOMqhydy1OiS9jjOiRccpbZzgZyjjogF4W8z0WNPLUcpbpp8HZPy2ktQqxOU3FNJwH4c1sziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Msy6i5QD; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c0449eaadaso2206481b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708112851; x=1708717651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl8JT9ZDkQooYxOm8kQdedmu/i43c64+LkzWicl51cg=;
        b=Msy6i5QD2fjMdtMavJAbikcf4Uc7AcAnCaszrdO6wfMOLlMKAwjADGMYvhCfpMmClN
         Urm/kCRruK8dWu5LXmSArHqwKv4eZ8f8lLWy3aE28krOp4vFUONg/7hxqd8S3WklMDl7
         0VboK2zcephPfdyfj62RbdGZU84EVMh1PnkwiBWFlK/6famKksrloVTBw/0HkcmG5+GE
         MwmHovKAliH2vb1WwbPxaiqQ98vaukYBjA1bkEAK7ReakrcrmFotoQZe8wfJWRAl8zjv
         OloLwUWhUcUGbC1cyhydEbvmpmGQ0MmW/gKDF/ekgGhy8TWHVUvpZEdCKIBDMI03Y1Xe
         9ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112851; x=1708717651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl8JT9ZDkQooYxOm8kQdedmu/i43c64+LkzWicl51cg=;
        b=cEok2cd4LqmqrcHk3kG/YR55VcKHo6aepBFN8l3OGioaP5ybE6DjB5EMb0Y1ageLej
         xZlovLoaL+ICWojqkwSFPt/DU2mH2pfWJ4reh9Oa6I45d6hbZinxlwkRDlCiHcbAUp5R
         3ew9c4zuyOR/xqA8ThM4b4VJt355YY4LjhKS3F+9KbgRxqvrCl/K30ryWeSdEDRZWYzT
         kNAFi10WFGQA+sLkLCe5K+hnpknU9Yf4eI98NzUd/ztu9xo4pxltOA8aWknfBXI4Ey8m
         K3E4KNpDRU3xUlENHlA4CTWbkQ96SP867P/gdhitCQqVuF4XgeoL/MITqfyWpFlfQBXP
         jTmg==
X-Forwarded-Encrypted: i=1; AJvYcCVdAt5fAfeq7caDwRgErGlvOVAtFFgeF7QKSDyFm9kLEJ00QBN0OC/ZAWQFUtgjzNmiJXmR0Eln/6dfG6hT4A7/x8dXQ1IcHdZ3bVIk
X-Gm-Message-State: AOJu0YzAijpbsTjWmFR4mlk1GUNITPKNEnuYJBwQxzuMGVT9DRDpoXDS
	J2zrVafeHvrnoEulKVVf4XqsRHS7ODWWHMwqvxs9SLenqGqwkcySWkEMYbAGE+E=
X-Google-Smtp-Source: AGHT+IGoSCyOQLvJjdlUMoNE5d02u//l2zzcK4bOJUyTSYxiUMWnkYqRZT9XmxseCCKD5jYUSZWodg==
X-Received: by 2002:a05:6808:11ca:b0:3c1:33f9:70d7 with SMTP id p10-20020a05680811ca00b003c133f970d7mr6810615oiv.29.1708112851526;
        Fri, 16 Feb 2024 11:47:31 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id cg10-20020a056808328a00b003c136d7ed2dsm83412oib.43.2024.02.16.11.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:47:30 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Date: Fri, 16 Feb 2024 13:46:18 -0600
Message-ID: <20240216-ad7944-mainline-v2-1-7eb69651e592@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216-ad7944-mainline-v2-0-7eb69651e592@baylibre.com>
References: <20240216-ad7944-mainline-v2-0-7eb69651e592@baylibre.com>
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
 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 204 +++++++++++++++++++++
 MAINTAINERS                                        |   8 +
 2 files changed, 212 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
new file mode 100644
index 000000000000..61ee81326660
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
@@ -0,0 +1,204 @@
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
+  spi-cpol: true
+  spi-cpha: true
+
+  adi,spi-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ single, multi, chain ]
+    default: multi
+    description: |
+      * single: The datasheet calls this "3-wire mode". It is often used when
+        the ADC is the only device on the bus. In this mode, SDI is tied to VIO,
+        and the CNV line can be connected to the CS line of the SPI controller
+        or to a GPIO, in which case the CS line of the controller is unused.
+      * multi: The datasheet calls this "4-wire mode". This is the convential
+        SPI mode used when there are multiple devices on the same bus. In this
+        mode, the CNV line is used to initiate the conversion and the SDI line
+        is connected to CS on the SPI controller.
+      * chain: The datasheet calls this "chain mode". This mode is used to save
+        on wiring when multiple ADCs are used. In this mode, the SDI line of
+        one chip is tied to the SDO of the next chip in the chain and the SDI of
+        the last chip in the chain is tied to GND. Only the first chip in the
+        chain is connected to the SPI bus. The CNV line of all chips are tied
+        together. The CS line of the SPI controller is unused.
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
+      Voltage regulator for the external reference voltage (REF). This property
+      is omitted when using an internal reference.
+
+  refin-supply:
+    description:
+      Voltage regulator for the reference buffer input (REFIN). When using an
+      external buffer with internal reference, this should be connected to a
+      1.2V external reference voltage supply. Otherwise, this property is
+      omitted.
+
+  cnv-gpios:
+    description:
+      The Convert Input (CNV). This input has multiple functions. It initiates
+      the conversions and selects the SPI mode of the device (chain or CS). In
+      'single' mode, this property is omitted if the CNV pin is connected to the
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
+      while the SDI line is high and the CNV line is low ('single' mode) or the
+      SDI line is low and the CNV line is high ('multi' mode); or when the SDO
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
+  # ref-supply and refin-supply are mutually exclusive (neither is also valid)
+  - if:
+      required:
+        - ref-supply
+    then:
+      properties:
+        refin-supply: false
+  - if:
+      required:
+        - refin-supply
+    then:
+      properties:
+        ref-supply: false
+  # in 'single' mode, cnv-gpios is optional, for other modes it is required
+  - if:
+      required:
+        - adi,spi-mode
+    then:
+      if:
+        properties:
+          adi,spi-mode:
+            enum: [ multi, chain ]
+      then:
+        required:
+          - cnv-gpios
+    else:
+      required:
+        - cnv-gpios
+  # chain mode has lower SCLK max rate and doesn't work when TURBO is enabled
+  - if:
+      required:
+        - adi,spi-mode
+      properties:
+        adi,spi-mode:
+          const: chain
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 90909090
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
2.43.2


