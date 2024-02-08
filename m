Return-Path: <linux-kernel+bounces-58453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A2684E6AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E3A1F2A2CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054AB839E1;
	Thu,  8 Feb 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSsMKlff"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C485C60;
	Thu,  8 Feb 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413143; cv=none; b=RazvsoIMCaSCIbmDaVZqWFfLkg+sRMWAjozYVpBO//dNolN/DG22rRJG4pGj/XtyFB5tGObmo024kT4NSzxnvIrFD4/6gjO8x7n+qj4snR9qh2QdMChqhkuiqEPYDMTBJ8LyCrE1tqJD/IG55GII2huRTTckSwO55JGbzUp5QzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413143; c=relaxed/simple;
	bh=6aGSDLm5ssrlEa4pWCOca+PsVqrh0hPliOXwPX68UjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mg2M2jfKARnJJujhl7/4b1H/yTlbhxBX+36D+cmGa2HqFUUYsIJ2uB9byhOvwppIw3rzD31PPI3sQAgqwoJVHXw39SnglgE6O3lTghv3MkWb0xgYxnb5pD1AhSib1hUAyNnmsYu0XA1QxNYMapTBbQrBf/aQg1xkDRAQLPyfhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSsMKlff; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4102eae7e6aso768225e9.3;
        Thu, 08 Feb 2024 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707413140; x=1708017940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ1lxhnlR9dTzrQ9UOld5NAHJHnWZ5xZn3HI1aD17qQ=;
        b=KSsMKlfftHvcWxZcvytLWvtblfgpDHktC0fGk+lTpAoK5QIoHoIhN7OyYDPKrgHdQn
         NBO37++De1Oyt2GcacoErmlzblGT7j2Nn0ZqhNOkIjhUNBPHA+xUlh1sziZVgrz3kuVD
         QzHZ+ZyU3b9qCc8h5j5q28FyDG+Ev33DeetrD8KzhwcgPMqggeDhB/LEqoLBYTWe+70Y
         x3cE7hheZyK2WLoPun/6ViScGT61J1zR1cWc+888LN/9WNcMjwFq/EvKLygoyDxeUUg+
         HlgjFrYjLRkbhrjbm9crX4y4CFeO0kRZsLLwl1RahAwhY8Sv3Y9njRrDwi/MmjRdc46F
         z5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413140; x=1708017940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ1lxhnlR9dTzrQ9UOld5NAHJHnWZ5xZn3HI1aD17qQ=;
        b=FQQ4nTF+lhZXy9M1ZWXswkzUPbopKw1AW0FJR6UiTb5FFfmRVT58DYI/VFEEDtgk6h
         /qUnyz2UGz9e7983DblubIW0z74uIMo/u8v57aJ6i6Rcmy7N8Z1cTWTBcKF1CIvYf845
         HC5OdpBRJypeT1oEtTwkS8YD72jCsyRYuN1puyIX0aQ5YtL7f//wPK8ynAfaE4Yzy+xp
         IKKq5wLjoBH1EvpGTG3yveyKw/DHsuNAPW1EHEokLYpG5EHkEt3GDdG0h+TbD/cYpOKd
         Bc+XMoFCKQuvpfuw/9N63exJ9KVNEGE7+q5HJxHiBYn7RIo7D+hSK2DNeS/uh3+MnNw3
         HiWw==
X-Gm-Message-State: AOJu0YzJ/f1JJMVLe5rZpnyNRbZLq4T4rPAFTEdBgd7kRYyT1afdzSbI
	RvoypC2/yekBl3VNlRykwf537h6O43wx1fBS61xYM8dgrIp+2Saz
X-Google-Smtp-Source: AGHT+IFk4nz94CrdvFzn8K4+4zz441ql4Jl8JcqqJnIvtykguLCKMk7CLgk8UTMvysmGFmVQgJjGDA==
X-Received: by 2002:a05:600c:4f88:b0:40f:d1e4:6074 with SMTP id n8-20020a05600c4f8800b0040fd1e46074mr15405wmq.8.1707413139707;
        Thu, 08 Feb 2024 09:25:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7cpVkrK9F8RyVIsEWrSPHKNdOY4VngCxSb7JijCHrIDEFGNO+t9JOak/WqTWQKiOnQylgIKaLJtS1mlRyh/YQyTLKISh3O4nEMTPj9L+UQ4BHQuMGUUi6VkqUJVWMCrive/MTPWc14TIDyjOoNPwlxfcFpY/KbBMFhWkiltFHeIx0SY7VxfN5ZZRbds3EzNrQQsCH7i/0GEzV4fLt6Tnl8QQQl/rjMLR5o5lxIIds7gYcAvboTcMpZysOhIKj5hGPWz5SiHTX1HX1t2SVzPUmRCYgBwv47TKWJYDc9XzYn83R1prdqmHlJRzFluZgOH+gnkV1ZwROI5qwXXoVNb3uCkvOwpQdOgZTqGQLuHMc1sCC407ooWz/NxvI+/rjw0I11abwT5PGD4TGtdfnf5/bf/fSNAsfR+L04RRkdPtxvLksuGtyrj8/z+CyOnnM8zpeNkB09oJa2ZRdfyfu6VRWjhhwtErtAm/2EQMv89nH6TuAdCc7pHs=
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b004101f27737asm2238214wmo.29.2024.02.08.09.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:25:39 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: 
Cc: alexandru.tachici@analog.com,
	alisa.roman@analog.com,
	alisadariana@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	robh+dt@kernel.org
Subject: [PATCH v3 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
Date: Thu,  8 Feb 2024 19:24:58 +0200
Message-Id: <20240208172459.280189-5-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208172459.280189-1-alisa.roman@analog.com>
References: <20240208172459.280189-1-alisa.roman@analog.com>
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
---
 .../bindings/iio/adc/adi,ad7192.yaml          | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index 16def2985ab4..169bdd1dd0e1 100644
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
+  "^channel@([0-7a-f])$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description: The channel index.
+        minimum: 0
+        maximum: 7
+
+      diff-channels:
+        description: |
+          The differential channel pair for Ad7194 configurable channels. The
+          first channel is the positive input, the second channel is the
+          negative input.
+        items:
+          minimum: 1
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
+        "^channel@([0-7a-f])$": false
 
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
+            channel@0 {
+                reg = <0>;
+                diff-channels = <1 6>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                diff-channels = <2 5>;
+            };
+        };
+    };
-- 
2.34.1


