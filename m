Return-Path: <linux-kernel+bounces-58451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6138184E6A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF2EB279E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156184FAD;
	Thu,  8 Feb 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElyugyKn"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2777BAE3;
	Thu,  8 Feb 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413138; cv=none; b=BtUF+Tm2CPTPBiMJb8TcfqYUOMaY3kH6ura3MLh3xjU5Bjix1sIw9mAT7WBuvvksxaELTy5Bgm8H/1GCl319SYBzs2YkRun6qT06C55uyX2MEFDnkDFzkp5SKRpugCg2VKrYf2o2we9W7yia+/ditfpVb5eVXmUWzsC40Cyqfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413138; c=relaxed/simple;
	bh=M2tGrQ8zBguuWu0chhjnKP2xU1A7rwPqp1gZTNzV6dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=alfS9FfXu7ICMkCXvUW5+/S7sz5T0d4b7EwK2H3G5prNTWzbr1Kx8PY86u9wpZt1Sh8KduJJdMlWAzoRqaQSiRXD9mlJ4BR2tJmJlOSjSGmy0Odr6hc8nakG63Y3TKqqezmK6EEia7qaPih29EsdQ5NmmUTWPLA7nI3M1iwZsN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElyugyKn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso997805e9.0;
        Thu, 08 Feb 2024 09:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707413135; x=1708017935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K83FXQV1rEavwkJOFpM97Til5o64vlhCwh57IjDM62M=;
        b=ElyugyKnuOVHqP1tdBkBisOkYbBkXCPnLx0kbAK6Cwog3O+raDZGhUYG6cA/dH0a/x
         aNsMErNPemW3zX/A3xl0HWgCnl5MeScFlgmu3eSbJqJfS93qOeEI0vm0QLPgiHqIQXbj
         l7qTuinrz42KDhxkM4L32icRIMicFdtJ5sELKMFNfhlWid+yKU3iDy47dBst6CdZQABC
         UZUhMlmy5D8jj0ITQbse4q5KqMya0Hs9ASGPs6cmx/TBDPaXyLT9zSoC229CNnT2oJWK
         xAxl6RvDWnAZFb8fxLm8bZVGYUVQLsupA0c4XdkW2vkQeH4DIhyzE7gJoVqqRqYGvEg4
         6Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413135; x=1708017935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K83FXQV1rEavwkJOFpM97Til5o64vlhCwh57IjDM62M=;
        b=lJ37UItWpqEJU9hjvwQ3tvqnIm7jg8YyTR70C6Ij558ie/q77ScPbGX6BQfdwMhHB4
         lox84mb1GVJwvMDn94s0wqoNU/9ZSsrvAk9LhJJUtDFnlF8sTV+FSH5Jp4rm/PbFryOp
         iSY7tEhU0zOXY2czk7DoeSzYEECQ4USz3JMpjEdjfTOx+Ujo5YRO9D/KmUFgDmkiw9xW
         MEpZBrV0L+zXe4qvibRLITEQnWU4TdgHtzX6YAC6P1JU5DUtVd3yR9vE6EVQMn19dvRp
         ZrQA3wE4MCrks9dera53vr1dMdYi5ZZA/Aa+Xx1qjDGKcI5/ParrGKnK44QLRUmYnrcT
         Nhfw==
X-Forwarded-Encrypted: i=1; AJvYcCV471v1u/YcVCxhtsjdxzKtAzRaF4Yqa4jxhiSBsiDXistc/Pza4+SPqxo0kkVxrJ2K7xClRCPJmZxFEqrEGV/c6qlUKwoWBFPt8tnVJzpqS+iSBC2hj22ZNELyOTzRHp5mb6R6z/JLN/WkLALD/8ODadUDf61fJbf2yTHqtU4S7SQ0kg==
X-Gm-Message-State: AOJu0YyaQxiL/qK7b2iW9kufe4lHXdieGZuGNFc2c0k6EaYKdGdUDQ9i
	Z0juKC2ohMU2MYrU0GWGbPOrVONrFQldMyHeMblvmAVeqNRKys0+
X-Google-Smtp-Source: AGHT+IH67U1POXljUXKpNt2O3qjofjkylhL3WYlKbNqgjtx737hdMLnBbAx6vRQ+WUyypuO0dd7OWg==
X-Received: by 2002:a05:600c:524a:b0:40f:b5d2:1b16 with SMTP id fc10-20020a05600c524a00b0040fb5d21b16mr7194314wmb.25.1707413135304;
        Thu, 08 Feb 2024 09:25:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIgIyrVnDsE9VG+gyKDu+eaGc5ZgJ8X6aAC1pKey7LAjud8VHVNWTMM5o6h0JHYqtIKbkwN+yqK2NKrZ+3QUgWhwlZFvm/20FK1CyIoyiGg5wLaeQm7yKtBsnGu423gcG6NfSTLtCtX9IFqOgsp5L5833uy2xFJnFFWApr52U2P18aNe1FBLlhQeRxoCfpgzVd8aWcuf/bQru8aCyZx1F+CfcmBe6BF4byr0YiBAl+jt7Cup2+kMQO6iakBYNyVJ7p6xeq46Bf4ambecRC2gdmkRxegeKkAVVNRHY+0TQZsAyOeDR/tbr0FrJbC6NXLC5WqtI1cCySh2KhDp8jhOCuE74pVgqmaywWpSIN6+F7KaQDkWJLKETIP7Jsc7N/OlR382tUs6Ci97eEzdoDnFliUADnSAqWt4WtuowDKcnWooy4pYr+SnHPkNjCTCyyUVPtEbTF7V+ojnBGFbjEy2hIej4blZVPBVPIkAyPhA05FoHu5KW9jog=
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b004101f27737asm2238214wmo.29.2024.02.08.09.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:25:34 -0800 (PST)
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
Subject: [PATCH v3 2/5] iio: adc: ad7192: Pass state directly
Date: Thu,  8 Feb 2024 19:24:56 +0200
Message-Id: <20240208172459.280189-3-alisa.roman@analog.com>
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

Pass only the ad7192_state structure. There is no need to pass the
iio_dev structure.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 48e0357564af..5e8043865233 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -384,9 +384,8 @@ static int ad7192_device_clock_select(struct ad7192_state *st)
 	return clock_sel;
 }
 
-static int ad7192_setup(struct iio_dev *indio_dev)
+static int ad7192_setup(struct ad7192_state *st)
 {
-	struct ad7192_state *st = iio_priv(indio_dev);
 	struct device *dev = &st->sd.spi->dev;
 	bool rej60_en, refin2_en;
 	bool buf_en, bipolar, burnout_curr_en;
@@ -458,7 +457,7 @@ static int ad7192_setup(struct iio_dev *indio_dev)
 	/* Populate available ADC input ranges */
 	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
 		scale_uv = ((u64)st->int_vref_mv * 100000000)
-			>> (indio_dev->channels[0].scan_type.realbits -
+			>> (st->chip_info->channels[0].scan_type.realbits -
 			!FIELD_GET(AD7192_CONF_UNIPOLAR, st->conf));
 		scale_uv >>= i;
 
@@ -1150,7 +1149,7 @@ static int ad7192_probe(struct spi_device *spi)
 		}
 	}
 
-	ret = ad7192_setup(indio_dev);
+	ret = ad7192_setup(st);
 	if (ret)
 		return ret;
 
-- 
2.34.1


