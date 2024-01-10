Return-Path: <linux-kernel+bounces-22432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3470A829DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463A6281E58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3834C63A;
	Wed, 10 Jan 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXmSLf1K"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DFE4C3AA;
	Wed, 10 Jan 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so3950247f8f.0;
        Wed, 10 Jan 2024 07:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704901084; x=1705505884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi4dOBb6Axd3K1La6gwJO0i7zhXXojoDHVTLnsVvmuc=;
        b=eXmSLf1KhC6+qaALLR6dhmVAz8jE22SGRfsme7bDG8rkEsu+zP/lP2fSNmZeXI3Li6
         4XtKEFBqFTdowONOQyttLHHSngO1eVv8AmHRyy6RDObKEzeol3gmIRQjE3nXjppZ00KK
         Q6h17bEuHqGAt5ho5KBmA8jO8CzcY9claSJyi4jEJ3bv+ASw+scOZ4ENAg1njSp0wgQ6
         6OmZfdZiGuLo6Nyu2QIZOGdfvHRYElgI9UlY9f22HKXWL3WRNz2jLm5OaE0K9RspoxVW
         D1pFTOBJukkklnGan6vqcMOXYiGGaY2wupVNaWxgHm0uKAYp0XVIdbl5hSDqHxM9+VsZ
         RS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901084; x=1705505884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi4dOBb6Axd3K1La6gwJO0i7zhXXojoDHVTLnsVvmuc=;
        b=WEyS/KZxJGzi+9VIQelaw9zSU+V6HNCfUofgaQUbVWB9aMN6CGG07CyrzZyV9LDzwA
         3rvbbpN0oTMjiDKMNOaYZUv2vqzN/hP1wQhQH4+6Rl2yapj69OMJf7GmK2uR3hANsCfE
         oBhuLw56yyXQWqBgbDuTxHhWGJhq1sgUb3BObcgrdESQKSOtw8XpKx6EDkmyzIYBneMX
         jj84CTPZPirew6vUdnG43dAzQU7/yIa88eaf71SCdfGGyOawUKTRIxMpWAyajVghdWID
         oZQl5OIg2RX5++nRA0C/oGFUeWWyZzoC8SSkHYrLgfYyLgZI1tQ1JmWUww2G39Z3nylN
         jN0A==
X-Gm-Message-State: AOJu0YzFt+vSm5THKYMKRrVUnv6x9hkXShl7/XkC/HfckGbBYDt8lXEH
	W0NrdyCvPPrd/VM/h8QRAbc=
X-Google-Smtp-Source: AGHT+IGEKVKhMT8VoltD6U+QHciCX9rfJpoTZz8Q4SWLuKZrlBxGN91+AVrqJP1rrGO+408P9WoaOQ==
X-Received: by 2002:adf:e750:0:b0:336:9c9b:a9f7 with SMTP id c16-20020adfe750000000b003369c9ba9f7mr654020wrn.4.1704901084483;
        Wed, 10 Jan 2024 07:38:04 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([86.125.72.218])
        by smtp.gmail.com with ESMTPSA id e30-20020a5d595e000000b0033776a50472sm4179907wri.10.2024.01.10.07.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:38:04 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
Date: Wed, 10 Jan 2024 17:37:09 +0200
Message-ID: <20240110153757.5754-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110153757.5754-1-mitrutzceclan@gmail.com>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ADRF5740 and HMC540S have a 4 bit parallel interface.
Update ctr-gpios description and min/maxItems values depending on the
matched compatible to correctly reflect the hardware properties.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
index 67de9d4e3a1d..a434cb8ddcc9 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -33,11 +33,38 @@ properties:
 
   ctrl-gpios:
     description:
-      Must contain an array of 6 GPIO specifiers, referring to the GPIO pins
-      connected to the control pins V1-V6.
-    minItems: 6
+      Must contain an array of GPIO specifiers, referring to the GPIO pins
+      connected to the control pins.
+        ADRF5740  - 4 GPIO connected to D2-D5
+        HMC540S   - 4 GPIO connected to V1-V4
+        HMC425A   - 6 GPIO connected to V1-V6
+    minItems: 1
     maxItems: 6
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,hmc425a
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 6
+          maxItems: 6
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: adi,adrf5740
+              - const: adi,hmc540s
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 4
+          maxItems: 4
+
 required:
   - compatible
   - ctrl-gpios
-- 
2.42.0


