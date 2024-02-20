Return-Path: <linux-kernel+bounces-73257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BC185C021
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC4AB22BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352E77647;
	Tue, 20 Feb 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7B7vVGk"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920AA76C82;
	Tue, 20 Feb 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443366; cv=none; b=Ja1u6kB4Px/0W9mICEF9AHAYoKrBCCvQzyLocBreEnU4pO5l8mgGYYYeC+Kr3Tho7hB1Z26NJ9ytG92cVsNyhOqykkDaFO+a3d2C1z4u0RV3q4+hGtKo6U7Iwx/zOXtQ2G2AR9vmPOhrQOIBL+KAt6K1IMgHxWSErglZcIsaPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443366; c=relaxed/simple;
	bh=WsaD/EyThPxR9x3pk2tU6dkPvkHaD1C0ZLhbybr6sC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiAh1UBS1/qjdLxbh+6RwHzvGXcsDmIDHsMpenChwuWcl79dosp/LfnlQ5dCFzHVwhRsbeviIpRpjv3kfmRbQy0aGCrzjl2A9eCIJwa6NKAFBTsBxxbBCgE2BzKIQALgCd0I8VkIn0uO2XroXjs0U7FNLeKpx4GBCKnuyklxpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7B7vVGk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e72ec566aso316192366b.2;
        Tue, 20 Feb 2024 07:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708443363; x=1709048163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IfByO+2rIcCGnCKsv3npkbJVqHFL3ale3i7+O8UKFk=;
        b=K7B7vVGkwjptlWsnJ6eRbsJCVdmHsE6imX8jBoM1tEEfCQ9wvkX3Pm6Or+M4lgOUx1
         K5JwtHyhJQyANBJe+oyoqTjHzQqLZbtqg5MaBub3svpqY+tim+Sb5YqSnbbxIaidtG7J
         eiU1HMJ1yg2vzDb/52ci+inAb/d4egVzdU5Ve6rpdhff5IhvT3XpFDIlYwG0s7R6npLE
         F6/rOJO8UNeujnxp2z59nZCGESfj0UZICRxjYOE+ZvR7QrISHwESRkSV3GhHfylQPomp
         X6gbHBiTVWNR0ujIlYSDXmnaKm2d97qGLBgak+Ez0rvSby+jXZYGl55qs2yF+6uAs2bl
         y+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443363; x=1709048163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IfByO+2rIcCGnCKsv3npkbJVqHFL3ale3i7+O8UKFk=;
        b=KO6WKFyhK4Wj/PPqVIa42PDbUVjbJCdut0sC6YRjrkpO2gZDwQKWqzj+mfNPJLiavN
         NBvGIXbMKRgPmHxjCDXHMFF4FxarKVdecswdxTRRqlj1sUkWT/jrVjIPSek3yTRnuSVc
         nvwVsLQoSjfSGP4khAfGo1U9UVVMttFk+ckEVSzxwxLcxzjsWR1T4QdyROVYC2lcJ2qZ
         aNDmI4jXYOwNpU8cpK1qz7v6+H6WkYTw3BCvSMNaVRIBdrGa1TKAmoIYLy7l3uc+rVQh
         j9qGgR3PgIjgdT8XuYM/JAL5RKe/kqejHf2yq4X6fqWPjpPIGE8/4d53aFZSEULIHz+o
         KtDg==
X-Forwarded-Encrypted: i=1; AJvYcCW7lBffQMn+fA/IfIrdxzoNR6YMxNVIsr0UZJ0oktbdRivLxL78ALS6Zc0ZcVPiAOOfbN/e4eSg0c/EfXQlGusd3Eal2+KfpQVD5oJUiLifQ8M0s42UQzGngVGJFMEn5fQWUL31m9I0aFgmua8AN5D0VfBMdhEsBU3YLZ3zbxI7miOSBw==
X-Gm-Message-State: AOJu0YyXPksqluRfWdHMCZFg2rwncjS99i+JFXlxpIPqH+nv/F2EDbnh
	Vh7EZwOgaHrsfalZaQ+GEYOZZMDQ8j5tpc4LRXlqc5HY5FlyRSwf
X-Google-Smtp-Source: AGHT+IGUTtfOYGzuOrHJz19AccjYRiQJVfFTdBpbx8ugPcjvRuC6KUt66v/WR1iRLaV2gG2IT9Fw3w==
X-Received: by 2002:a17:906:55ca:b0:a3e:4c8f:2340 with SMTP id z10-20020a17090655ca00b00a3e4c8f2340mr4633651ejp.61.1708443362727;
        Tue, 20 Feb 2024 07:36:02 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906281600b00a3d777aa8fesm4039024ejc.69.2024.02.20.07.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:36:02 -0800 (PST)
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
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/5] dt-bindings: iio: hmc425a: add entry for LTC6373
Date: Tue, 20 Feb 2024 17:34:52 +0200
Message-ID: <20240220153553.2432-5-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240220153553.2432-1-mitrutzceclan@gmail.com>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LTC6373 is a silicon, 3-bit Fully-Differential digital instrumentation
amplifier that supports the following programmable gains (Vout/Vin):
 G = 0.25, 0.5, 1, 2, 4, 8, 16 + Shutdown.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
index a434cb8ddcc9..3a470459b965 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -21,6 +21,8 @@ description: |
   HMC540S 1 dB LSB Silicon MMIC 4-Bit Digital Positive Control Attenuator, 0.1 - 8 GHz
     https://www.analog.com/media/en/technical-documentation/data-sheets/hmc540s.pdf
 
+  LTC6373 is a 3-Bit precision instrumentation amplifier with fully differential outputs
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ltc6373.pdf
 
 properties:
   compatible:
@@ -28,6 +30,7 @@ properties:
       - adi,adrf5740
       - adi,hmc425a
       - adi,hmc540s
+      - adi,ltc6373
 
   vcc-supply: true
 
@@ -38,6 +41,7 @@ properties:
         ADRF5740  - 4 GPIO connected to D2-D5
         HMC540S   - 4 GPIO connected to V1-V4
         HMC425A   - 6 GPIO connected to V1-V6
+        LTC6373   - 3 GPIO connected to A0-A2
     minItems: 1
     maxItems: 6
 
@@ -64,6 +68,16 @@ allOf:
         ctrl-gpios:
           minItems: 4
           maxItems: 4
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ltc6373
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 3
+          maxItems: 3
 
 required:
   - compatible
-- 
2.42.0


