Return-Path: <linux-kernel+bounces-85014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46BD86AF29
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C752F1C225AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83370CBC;
	Wed, 28 Feb 2024 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzdCtDGW"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2CF3BBFD;
	Wed, 28 Feb 2024 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123219; cv=none; b=VnLDjGA+ij4KHtlzVLMjchkgOfVpAMx1H5zKC3EGukbJfBQ/G3tpquh/2/YabbnzHbNbiVuOREFR69qHs0GAvAu6YlYdOfXorfN8FoEMmokKuEOGOQhTuQAckq8puRe9ZJpqlNzwejIUYgqSWsm1o9JY0p0MbtOvAwgC0Lkk1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123219; c=relaxed/simple;
	bh=FND/JS4mKdDTpHs2/1Zg6IwC+sbA0VPhdHTLkhMI1R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BISy1WuADPDxcM7nqIokV2vkRI5j/kLFJWhekv35kfDRgAbTsiUa5yRpk/N3KUQxnUSgybq6sG+SMRMkgOErdH4CTAgSqWKJZqRv3idHJxJYCB9aQXEEld2Ahg4fhluaYXKoJvBUrkWKTmxIDuCj/bYBD7spbCw0ou96hwa4G6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzdCtDGW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a43dba50bb7so148139266b.0;
        Wed, 28 Feb 2024 04:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709123216; x=1709728016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncTqrMpj0Gd+aXnyQBraEqljHukvPzkzJwUIgSZJAWI=;
        b=lzdCtDGWAD5ovOASUAxoBv7mALujMk+dl3ZSNtN2Nl7wYiIbwPWzNYmdXO4oeceJkp
         JZhNEF1/hGs/tXeuQoCE/chRbeGI04qHo7xa3dHmaWqAxdsimFcSfYyOzeTWmtwUXpYS
         /QckwvmTmg0jbB6BnqC8qcpk0JXWJWyfEHZS0036RRl7+qhj+98/30dpua/T1ZTEwBX7
         gdwqiviMSQTvvh7J/PwmSzCHI3UJuFxsHzXfob4f+dwJ9vKByPjU4Mdjh84eMsNLnl/c
         XrzrRzBl6gnEPM3RzCBF9Ue5n9Me08E5od55+lp3mlBbdqpFuYVljVin6yeaxKhM7ZiV
         qhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123216; x=1709728016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncTqrMpj0Gd+aXnyQBraEqljHukvPzkzJwUIgSZJAWI=;
        b=OM7N93O/yGZ/IEYc6MxLrJblBmVgf1fGHMi99/p+BbqiHCm12WKI4AprKNVvdkpxGm
         pG10vq5aE01Fgm3yQwqE85AFazKSTo8qqs/lbgZREpsRsA845RojumGETCXr3nh6eNlu
         LMz+2PEaHVFFjPLzrp1Q4xU0L5JSXYyYRh0IeZ3cCfPeZnTbOz2iCwe28NoVv+0+GcZq
         BPkWrnk0KzRrzCHYPiu6aQZ8LzjuGMVQqcMuInUkkPrZRke6PcpxMJ0HKvZAg/2w1/Yd
         MkDrl3GNk2Gnld1i85jP3TLO3BkDqgh+vzRa/ezWrIFIvkv0e3ruirScUHkzW8HVkP9J
         gdIg==
X-Forwarded-Encrypted: i=1; AJvYcCUgQLo23iCM9FHpicGdjvy0EsGf6GOYYrlXATG2J7V63fa8BkxoubQFoxGM7YCTOAhbAe6x98JazfWEFHg8jLlNKvuUSD7uXh/8GdUqHrtZ3j1l/92GKuXWGQab/t4uW4tYsPCidFT8BnxzmCuVRZ6ym+tE6bmBtgA5fzKFHZzzRgulRw==
X-Gm-Message-State: AOJu0YznJfIrprplmNcL3PdmTLX9YiHI8w3+/IEb4vkoQb25hpUqAlJ5
	MtuThvBezCgms5dCS6i7WLSJhVa7MA+64PvnqFbWnK+B3Il69pfc
X-Google-Smtp-Source: AGHT+IFmXBvuEoBBwLsaX+Yp5xFmu9/i/MA1GpKhpjng4AxQ8wFqADfTwcjIdvAZ06MY8C0EIEm1ew==
X-Received: by 2002:a17:906:28db:b0:a3f:816:1e29 with SMTP id p27-20020a17090628db00b00a3f08161e29mr8600151ejd.39.1709123216443;
        Wed, 28 Feb 2024 04:26:56 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906c08300b00a3d1c0a3d5dsm1800417ejz.63.2024.02.28.04.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:26:56 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com,
	alisa.roman@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v4 3/4] dt-bindings: iio: adc: ad7192: Add AD7194 support
Date: Wed, 28 Feb 2024 14:26:16 +0200
Message-Id: <20240228122617.185814-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228122617.185814-1-alisa.roman@analog.com>
References: <20240228122617.185814-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike the other AD719Xs, AD7194 has configurable differential
channels. The default configuration for these channels can be changed
from the devicetree.

Also add an example for AD7194 devicetree.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Signed-off-by: romandariana <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 16def2985ab4..c62862760311 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -21,8 +21,15 @@ properties:
       - adi,ad7190
       - adi,ad7192
       - adi,ad7193
+      - adi,ad7194
       - adi,ad7195
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
   reg:
     maxItems: 1
 
@@ -96,8 +103,44 @@ required:
   - spi-cpol
   - spi-cpha
 
+patternProperties:
+  "^channel@([0-9]+)$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: The channel index.
+        minimum: 1
+        maximum: 16
+
+      diff-channels:
+        description: |
+          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
+          appropriate value from 1 to 16. The negative input can also be
+          connected to AINCOM by choosing 0.
+        items:
+          minimum: 0
+          maximum: 16
+
+    required:
+      - reg
+      - diff-channels
+
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7190
+            - adi,ad7192
+            - adi,ad7193
+            - adi,ad7195
+    then:
+      patternProperties:
+        "^channel@([0-9]+)$": false
 
 unevaluatedProperties: false
 
@@ -127,3 +170,35 @@ examples:
             adi,burnout-currents-enable;
         };
     };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "adi,ad7194";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+            clocks = <&ad7192_mclk>;
+            clock-names = "mclk";
+            interrupts = <25 0x2>;
+            interrupt-parent = <&gpio>;
+            dvdd-supply = <&dvdd>;
+            avdd-supply = <&avdd>;
+            vref-supply = <&vref>;
+
+            channel@1 {
+                reg = <1>;
+                diff-channels = <1 6>;
+            };
+
+            channel@16 {
+                reg = <16>;
+                diff-channels = <16 5>;
+            };
+        };
+    };
-- 
2.34.1


