Return-Path: <linux-kernel+bounces-85139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022E486B101
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD1F282EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C00157E86;
	Wed, 28 Feb 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAiwVkdS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68162130AEF;
	Wed, 28 Feb 2024 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128548; cv=none; b=NBQciMBfOdTwgXtpHrEAQeX2Uar7uf4LS6FfJffa2Xxr23/4y9/Dy75ZjlY8oNr/RW4Of19G8n6nr9z1A0DQcJmgDAYCiwrSqZJKItReCfhJOS4xXzkgiFQVxKyf6i5A4Z5Cu3o1oO2n44CQgrsIBRwgKL23NcyE2fqQnIEzHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128548; c=relaxed/simple;
	bh=h16MzRqm6mctOweCzZ+zDJrdVpqgxmO5XN+1vM6huAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fl1ngCzuXJJXogM+yohZ5LGdT5/FAMzNP9lobmmz3oWhkTRqJ7Hn8N8MRws4OKrbe7jIefN2ioaSJujGkDZM7y6IwBsTRi28TeMeVic+UNU431ht+Q926ZVWldsjrdDRSsB5V74dsQ8X+udfdkoBcFTSFmpu78ffSMZ97Da++7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAiwVkdS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a441882f276so49240266b.2;
        Wed, 28 Feb 2024 05:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128545; x=1709733345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRw7LGFP+/omuqCxFZ/dxg3Hn4jlJTMa3DAg0Bp1/RE=;
        b=gAiwVkdSyiZndwTAcLGrjcoUqGPhSmFHiDgb9Rdb6Fn7KfGglBhteQAW4flqlyl9Rg
         9hc2NSLTtSBB4gLhSNDxtZh4TbWNp3iNVxGo5tqX3bHW8gCNkS8Cf/0Posjs5VjpSLFn
         7Ju8d3rwo6gHYbbqJtHjaUTdsTX08PgLG4wERRqzyCbl59x3qaqwtn4v/LhzG6kys2sT
         fyyj45Tl/7iNodZXbAhWTwq1+8G+ys0mfNNzDX6pFAhSzRxjZK96uG9Sk6cPeX/wIAGG
         ly0m2xYIsfphfWF20tfPvR2N+tHGcwz+KBvpjG/Cz2WDYpkf5XXH/DBaEZ4/sNrO8BDK
         JDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128545; x=1709733345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRw7LGFP+/omuqCxFZ/dxg3Hn4jlJTMa3DAg0Bp1/RE=;
        b=YNHG57vzM97wSavUaLvXPrdfyN8aMAJ5PgStFzeVNw08uStXaixGVSWN1naBFoeAaK
         +t3mu1z1KySGVRaQXg+RZcKyATBph9NhMXaIm8/aEfiCuxxPnTK9YEAC7J/arHpvSCRG
         1x9hvLbHpE+GrHPQJTh98DMYaB8lKJfRiYD02Ygr16p4qLoTj5f9+X/3TU46polHWV6r
         Vdvoo4Aru+W5VSMvXVnrrqLXOt6iVIcVRImkUItDvL4H3AKxzfLxrnmI7UJf8QAP3y0k
         zdlme2/sHQpEt7r9X3/NcU2yPAonz+ZznpWcBsoFkzC6NAsZzfneWbh0y391JgLX+3vD
         Z0bg==
X-Forwarded-Encrypted: i=1; AJvYcCVVPYzm7sPiibnAIpTulSYC/1F2nQEm1r83kokQvmkf97zHn3Rvjs9Qr4mlmL1Nsfx5qkv8cS12UqVaxhx0URIUsl5tp4HRHYEo9BBlxeN6urqBEG+yOqJzrcb/G2DxFKvXT5IwPd28SmyFVbR6vm8DX0rPwqIdTj5PvhwHLYg/utDdTQ==
X-Gm-Message-State: AOJu0YwDnL8i76Xf3kevuMYQCnROT47ncSyIBJRKvCsYTIFW9PoeNu+3
	kk+BviyTLZgDfoJiwWzp9DO3DSahl9X4NY/8OAG7TRKa2IqCf57c4KDrAy9/gJJx6tUt
X-Google-Smtp-Source: AGHT+IEpgcw4iV+cBNRwE5apG/BqM3uOOMq2cC2cVW+0ZhK6kCl/NQt5tPhmWPtIZTcQ8LRz58A6CA==
X-Received: by 2002:a17:906:4088:b0:a44:176e:410c with SMTP id u8-20020a170906408800b00a44176e410cmr649821ejj.5.1709128544765;
        Wed, 28 Feb 2024 05:55:44 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id dc6-20020a170906c7c600b00a441674cae4sm312487ejb.222.2024.02.28.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:55:44 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: adc: ad7173: add support for additional models
Date: Wed, 28 Feb 2024 15:54:56 +0200
Message-ID: <20240228135532.30761-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228135532.30761-1-mitrutzceclan@gmail.com>
References: <20240228135532.30761-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for: AD7172-2, AD7175-8, AD7177-2.
AD7172-4 does not feature an internal reference, check for external
 reference presence.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/adc/adi,ad7173.yaml          | 39 +++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index 36f16a325bc5..7b5bb839fc3e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -21,17 +21,23 @@ description: |
 
   Datasheets for supported chips:
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-8.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7176-2.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7177-2.pdf
 
 properties:
   compatible:
     enum:
       - adi,ad7172-2
+      - adi,ad7172-4
       - adi,ad7173-8
       - adi,ad7175-2
+      - adi,ad7175-8
       - adi,ad7176-2
+      - adi,ad7177-2
 
   reg:
     maxItems: 1
@@ -136,8 +142,10 @@ patternProperties:
           refout-avss: REFOUT/AVSS (Internal reference)
           avdd       : AVDD  /AVSS
 
-          External reference ref2 only available on ad7173-8.
-          If not specified, internal reference used.
+          External reference ref2 only available on ad7173-8 and ad7172-4.
+          Internal reference refout-avss not available on ad7172-4.
+
+          If not specified, internal reference used (if available).
         $ref: /schemas/types.yaml#/definitions/string
         enum:
           - vref
@@ -157,12 +165,15 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  # Only ad7172-4 and ad7173-8 support vref2
   - if:
       properties:
         compatible:
           not:
             contains:
-              const: adi,ad7173-8
+              anyOf:
+                - const: adi,ad7172-4
+                - const: adi,ad7173-8
     then:
       properties:
         vref2-supply: false
@@ -177,6 +188,28 @@ allOf:
             reg:
               maximum: 3
 
+  # Model ad7172-4 does not support internal reference
+  #  mandatory to have an external reference
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7172-4
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            adi,reference-select:
+              enum:
+                - vref
+                - vref2
+                - avdd
+          required:
+            - adi,reference-select
+      oneOf:
+        - required: [vref2-supply]
+        - required: [vref-supply]
+
   - if:
       anyOf:
         - required: [clock-names]
-- 
2.43.0


