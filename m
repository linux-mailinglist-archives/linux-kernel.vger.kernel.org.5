Return-Path: <linux-kernel+bounces-85515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE6286B6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D931C2233D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9CA71EAE;
	Wed, 28 Feb 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eYl7yEPv"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147940851
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144042; cv=none; b=hJEMTL1f7Z2GSyBoH1QUeL532o1v35cBCKmX5EI3n6QL7AHZALfSbyXMgRt094fTENVTxWz0FkjLiRKXwC46GPA10dTmz4ro8LzTaujRc3T5U0mbdbRHICyc7NqWo+wYG8AvNx2EzfHk/1WTT33GyY1qvx0Z2NM5+wgYSINlKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144042; c=relaxed/simple;
	bh=nwBJEqzb8tc+28EC6ZFnJqxWVn55v/s4Sw5uG+VwozQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0bX42crXjKCh46R+d3K/ei+G5+wEZNwEKgG31DlujwaYWFeKLmqSPkp1jw3d/N5D2vu5T2IPVO3KvjvG1F1Wxrkwfnemoj2ZqXixqAVH9iC7eMN6Bc/bQTYKhoQRsEE0W3biV+ViQV45T+YEOi7NHAFTUcoFmYkTBqPU2/80Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eYl7yEPv; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a0cb906d2dso11470eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709144039; x=1709748839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnbohTCBC6Ta16b0W88DjhGJ2/duTfCA5UrtYsVtG2w=;
        b=eYl7yEPvuX64ofkx2tia7H1WH0DrDanctSwulb+uIEKPMlO3bywqffY2UDw9be39O5
         sMP4yGrQ417DycuOEeYOW5wWNAhM97DMNuiYHUO9TGkrruLigmjvdhk+Rveh3jVsdTnU
         cD97pjkxViI98Y75lC65Je/rc7JGrxXpQi9g5mcq7CRov/7o5L8gpcpRwDQTNjFqN6/q
         bj77+9F+3EK4EIx9H5vMJTvuAuQvxhoUQtmKxU8ic4PJtUSyybD0Wz/0wzS0iY9WnVAI
         T3H9s1JFvan+60G9+LG6aIi9rIduTEfAhz8COKRs9KH2OsqWXZIittDMH7D7TKPuPAvn
         RfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144039; x=1709748839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnbohTCBC6Ta16b0W88DjhGJ2/duTfCA5UrtYsVtG2w=;
        b=fpr+Y7wHIAuLs8+xvBAV+N02gapTwn6oHmC1RYplPRBBxYm/1XdNcAIWA8wbnCXigC
         MqX84K3D0S0ftkU1xPABAYphTPsrVwlL7XDw1zhoC5hK4lhlQTIJfzqpy3vx3t4FOzHF
         mSgDU8SiaGDHJ3ACDKKWOyp3OXMlm0kKkI6ZsWHjdvJK0U29HwCGXWYbdGuYDUQdgO8w
         OxlXodwq7d8Z9i6+KWE4bMuv0IljBVf2I4/7+2xyEaY88L2/0o1a8qZzUUS9IEmggQNS
         DK0TeLqS1ebW9V5igTo4aUOttlHuPa7CpTCl6jaYLJTCWUYR5xLPicLLQPfXYIkrhVeT
         5XMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoG1lO1eFgmtkvwHjgwCFt3l6yihXo8usNuNbsHfu7CiQrbWll7l95HK/Rfme1JVrfs5tICHlQ0hKKpajr3H3KWAns7CR/Fi9Ad1ab
X-Gm-Message-State: AOJu0YxvTBVCjsuf2KXIle6+ZQ4BkZtgAPcJR4YFQeS/usavKFWV2z0t
	nN12u9ULVhkksXRcsxbDSrVckQBWrP83vUy2KAuHTbT3enER5soLFvHyhzfYkuI=
X-Google-Smtp-Source: AGHT+IFhDfyrxwMZyExh2ZX2RP4lzUpbBa6IDgSQKMqJ1c6BoFsJ6F6EXhWadg+JTBd2T2JdMVu6vA==
X-Received: by 2002:a4a:9191:0:b0:5a0:2a65:a14f with SMTP id d17-20020a4a9191000000b005a02a65a14fmr338554ooh.3.1709144038040;
        Wed, 28 Feb 2024 10:13:58 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f20-20020a4a9d54000000b005a0ac863a99sm12291ook.13.2024.02.28.10.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:13:57 -0800 (PST)
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
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Date: Wed, 28 Feb 2024 12:10:03 -0600
Message-ID: <20240228-ad7944-mainline-v3-1-781b922334af@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com>
References: <20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com>
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
 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 213 +++++++++++++++++++++
 MAINTAINERS                                        |   8 +
 2 files changed, 221 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
new file mode 100644
index 000000000000..2564ef4f58cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
@@ -0,0 +1,213 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---

v2 changes:
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
+      the he datasheet calls "4-wire mode". This is the conventional SPI mode
+      used when there are multiple devices on the same bus. In this mode, the
+      CNV line is used to initiate the conversion and the SDI line is connected
+      to CS on the SPI controller.
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


