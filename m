Return-Path: <linux-kernel+bounces-91213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786B870B46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4011C211B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD77B3C6;
	Mon,  4 Mar 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OJ3XhT6W"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9221B7A150
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583222; cv=none; b=LiwdO/VnH8VM5ZoSsFT7JKoXX2xKuX5cWCGgd5p9ZTMEhiIe5eZQuv4nRd/8I8qBBvWjxUbr22Q1+eKHdsTLIyXIVTsl58p4nWLUUgcf+yMA7QDVgMhuQjvt5HU4hYYqx2EmnXrk6ypPeRG1hve8son1SEg5hY/XjqnVgpXZDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583222; c=relaxed/simple;
	bh=LWejQcoT6m+vybwuRgPEQXfB48ANaOyvkwKEje0JkCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbEU+4nJo8uGbHgBg0TYOWA6TH+jZTA7+HxjqdpTRpQDhrf3ff7V0CLFQRlMQqt0J0BPJnJ/aEM0qFt+MHR+gKcUz1RkkJVyLjB5JiyuBtzm+pQUH5coSxD5F3gA0zPAnlyvdkCHShVpDNU29xuhVvJ0nwJE1YoYlUbHzUcruSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OJ3XhT6W; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c1bfc9a35eso2850307b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709583220; x=1710188020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJdxV1kAL7xkhZisZuQ5hA4D9OsKX5BPg2qE7YeGVNI=;
        b=OJ3XhT6WhyoejitXAsVU2RmqDyRmV09VxG+HoZl1ADRd5WuQnyseanQWbE/jQjrQfv
         qp4nyDKrPtKFu7pdCgOfXvxf93MsXxnfkZkHJz6NoDsUA/bHIWCf6mQ08CE4dW1t1ZUN
         MIvHf01s/KM9PrmJ1nkeRC2rrV9kr+A0OgemecubHftaIPx+WrEOslJS2QZbLgKVQBPM
         d7Mj1675PMmecQavjiGfXgnkwoD8apLgOnZ4Fk7RQD1OQVrbQXUsZ2X5aX6wQpLTIvbQ
         mzPsBizj2FzpJomJawugu7eq8b3bR0gfiHD2+YKlzvHTTSXfvxusrjUEIzlVokNzxtFC
         o4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583220; x=1710188020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJdxV1kAL7xkhZisZuQ5hA4D9OsKX5BPg2qE7YeGVNI=;
        b=h+QDhzyAYv2T/Pu49ZNH6yuSHH+jx+RldBos0ev7qbC+gbbeqIyiLt9kIP0/RHdywd
         G6ibU5M6mCr/gOZMnedQaACmNq18oBeRRHh0AtYErYSqhEYJMSl7kyWrYD4MRmyRILDa
         ALjpW3xQUlmnuuNs1n6dEkNGT5DpDmrzbumcbhenDHI5+gHbY8ohzDYxpKvYDwSy0gFy
         aZnBQnrvSNR1huH/RBFbEJIdfQzqDQ2LuFEgleLyZgklDya5LmTFmpWcBmxo5hYiZSch
         Zz8s1E7Ac3oDKuelrnM9+/y901PFfUSXA93mh+PM2EnBFFxc9lQIwUM9+XASgHs7B6Dl
         SVmA==
X-Forwarded-Encrypted: i=1; AJvYcCXN5fv5+KV/k+JwhZPzePwTF0i1znB3gyAM/Varg6WeGUW3iSdBsI9Hm05cSOOkz0b22duFodb4Bzr1a4RAFI/uu1BjQN2FwoYV07UC
X-Gm-Message-State: AOJu0YzmTPvQmyPhX0EHkIaUBvs2d4qjLwmlp46DacC92MFFAphR8nce
	nJuQ4nonwdY+hhAOoz6Y/nlCH5KHlFAJSEmgE4FsZWqnlZL/GSvr1AakhEXYcNk=
X-Google-Smtp-Source: AGHT+IHPiWmmSsDx5ZhQH6+dTitlqL0MDNOKhwi6WnuLLr9X7UfWzm2q1puQby7TgPDjStYuDClziQ==
X-Received: by 2002:aca:280e:0:b0:3c1:e7b2:53a7 with SMTP id 14-20020aca280e000000b003c1e7b253a7mr5904472oix.19.1709583219750;
        Mon, 04 Mar 2024 12:13:39 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id n30-20020a0568080a1e00b003c1973dbca6sm865748oij.2.2024.03.04.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:13:39 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Date: Mon,  4 Mar 2024 13:48:46 -0600
Message-ID: <20240304-ad7944-mainline-v5-1-f0a38cea8901@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240304-ad7944-mainline-v5-0-f0a38cea8901@baylibre.com>
References: <20240304-ad7944-mainline-v5-0-f0a38cea8901@baylibre.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v5 changes:
- fixed typo
- picked up Rob's reviewed-by

v4 changes:
- Fixed broken patch due to misplaced changelog

v3 changes:
- Removed default 'multi' value from adi,spi-mode property. This simplifies
  things a bit by not having to check for two possible conditions (absence of
  property or explicit default value). Now, only absence of property is valid to
  indicate the default mode. Constraints that depend on this property are
  updated accordingly.
- Fixed spelling of 'conventional'.
- Expanded description to call out potential confusion of '3-wire' mode being
  unrelated to the standard spi-3wire property.
- Added standard '#daisy-chained-devices' property for chain mode.
- Relaxed requirement of cnv-gpios since it was determined that an active high
  CS could actually be used in chain mode.
---
 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 213 +++++++++++++++++++++
 MAINTAINERS                                        |   8 +
 2 files changed, 221 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
new file mode 100644
index 000000000000..d17d184842d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
@@ -0,0 +1,213 @@
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
+    enum: [ single, chain ]
+    description: |
+      This property indicates the SPI wiring configuration.
+
+      When this property is omitted, it is assumed that the device is using what
+      the datasheet calls "4-wire mode". This is the conventional SPI mode used
+      when there are multiple devices on the same bus. In this mode, the CNV
+      line is used to initiate the conversion and the SDI line is connected to
+      CS on the SPI controller.
+
+      When this property is present, it indicates that the device is using one
+      of the following alternative wiring configurations:
+
+      * single: The datasheet calls this "3-wire mode". (NOTE: The datasheet's
+        definition of 3-wire mode is NOT at all related to the standard
+        spi-3wire property!) This mode is often used when the ADC is the only
+        device on the bus. In this mode, SDI is tied to VIO, and the CNV line
+        can be connected to the CS line of the SPI controller or to a GPIO, in
+        which case the CS line of the controller is unused.
+      * chain: The datasheet calls this "chain mode". This mode is used to save
+        on wiring when multiple ADCs are used. In this mode, the SDI line of
+        one chip is tied to the SDO of the next chip in the chain and the SDI of
+        the last chip in the chain is tied to GND. Only the first chip in the
+        chain is connected to the SPI bus. The CNV line of all chips are tied
+        together. The CS line of the SPI controller can be used as the CNV line
+        only if it is active high.
+
+  '#daisy-chained-devices': true
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
+  # in '4-wire' mode, cnv-gpios is required, for other modes it is optional
+  - if:
+      not:
+        required:
+          - adi,spi-mode
+    then:
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
+      required:
+        - '#daisy-chained-devices'
+    else:
+      properties:
+        '#daisy-chained-devices': false
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
index 2662ec49b297..35f27504632d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -441,6 +441,14 @@ W:	http://wiki.analog.com/AD7879
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


