Return-Path: <linux-kernel+bounces-56443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA684CA3B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEAC5B23D0A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEE15B21D;
	Wed,  7 Feb 2024 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXlCH8nK"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523D5A11C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307490; cv=none; b=Zn2MYlYm442F6e+BKNpPar6EjAiZfKU2c7i8A8cEbjgs0Au/L2ZwRZSldAGy9MR8N1EhAHFbVAnywD/ZcIjEcIZ4Mjh4KKtco9IBUjNV30GFhqpinKApm5GEbW9+MV/Ne/St8S0y2kNjJf7S8pxjSTlQn1aHZPFsHboeGTPpHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307490; c=relaxed/simple;
	bh=TBx1M+Fba6cWfMz81SybTjKqSJmQaQpPFiDkoNL5c9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUrtPK3zoVUe1MOLnx6lA4l1nX0x2MZ/55OKs2++HEdlMovfw+9bXa+WwawmeuJP2JjlVHxfRQzCH4HdMkpM0nHSgF75Z9cD61qmmeruATCFxmfS2S2xaoLsE544hSF1qjD854o58hp8xHhBCw6DvU/yjtMggwtBIJloZIZSJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wXlCH8nK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511538be947so596846e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307482; x=1707912282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Bzl1XVd4VG7OC9yiL2j94dw6vCN8qDUED8GxJICOsA=;
        b=wXlCH8nK5Yl5vB4XKNY/dWd3KeZVR6MMkS8/lD0GxEEtHrDVawK+aKAq0/fAdOWZn+
         6q/yqJNva0DsXG4vtdGnJ5meu25e6LZAbT/aFYfSyQm+geLVmCEWvQ+mFTWXkjS72niv
         OB+5xGdImj5QvkPvFGbBQU2qX08q6SHLiKbtNI+lQDlKzb5PPbPpG9ZuXU+QiyafuIu2
         z2w7tdsfTFWl2cJhRKA5i6+kiIUr1xvCtEGCGCF1c+rh1BUJUKKoyrCupaFYB3cPZ6jF
         G9+5Kc3Y06zMv8Vn9D3YBvawWJ3e89T8fJU4Wb7RuXCHfLTFbPSclihB67cu1yQXo3s8
         +l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307482; x=1707912282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Bzl1XVd4VG7OC9yiL2j94dw6vCN8qDUED8GxJICOsA=;
        b=FXnFzc+MAxWLZ18vCKL+FxKkkvBxWj1Q9v7Cr7nNHI188bwNCt9ki1Mbw5cGDyPvpl
         nA/CoODiILOcy83jndWLt9nOFaLDSWghlSqvOu8IGtIp33uUrPGR2UNV5MfUf0cEsAwY
         59xwOWBHZiXd9KlutMQsPExh9wl/DosAIrdd7/RuRlk41t1mggOyA2Y565PvYHIXbpFg
         2Lw5VrIDmW4h26bR/+q7YTRWnrrSmxcog487bQ59+hKz+gEwnkdpcB5i2Hg9+F2gxbZz
         BoGsXL5pcf1NGq6mHqE/YJTN3TsohyRXZgBL4ynTfM9IOaKIy6ndLq+7LiO0bouG9JkU
         GD0g==
X-Forwarded-Encrypted: i=1; AJvYcCU8MudkeTr3zx/HfUgMSz6+FQkXtvRvfh7cCSt56W1FGTLNfqYHTZvnIsryB4zMMHqnHE4HJRDu5aCH1+xb3ZoHqDm56Kg9J390YkZV
X-Gm-Message-State: AOJu0Yx14UQo5r+/TV3BFaXZnPdeHqxXuvtyfa10tNLCBJMiFlv3PXQL
	E4LnYaalOfdeZ6YRE+nPaGM6QnfAWXIz8Zzp2qTKTkrSNSbEKA0mDwpx+bvqELc=
X-Google-Smtp-Source: AGHT+IGcck/xmUicyK/uSuRdySCd6lMKVJAEjrg4NVjjnDTt9057DOq1RhPNTzrfhuYWeIgmMq9WnA==
X-Received: by 2002:a05:6512:31c7:b0:511:4e64:fe09 with SMTP id j7-20020a05651231c700b005114e64fe09mr4393588lfe.43.1707307481710;
        Wed, 07 Feb 2024 04:04:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQv6Y3rp8ha8/1pYWIrhm+SSEwXtyTCHxObJ+7Ec7urGBGiCErba4U9qGVl0fQMRgdootm7T/BpCm8MPhq9X3a1QZ2sw4/eiosfzFJsXtPDeLqGwIPX2yskvLe2RtPMU7yi/h+PWaU7yVpqnIIyBwGnOgrEYlXe9De1jQ/vWs6raG/hjYtUeofYZ4BQ2pY9Ks3MwWtmU976uew+KP7gBsqzCk1DuXFUlo60/csbqywTZcB7vBeJ2s8YXn0g8nIfphWKpuqkkbiI4UlK7D/A2TJX1KgsnaFpnGue9dXTTrLTRGX0Rt5LeQ5p1MMX7mbttA81TfmAsq8neWBmTI09soUUih5hy/fZWx8xN3N6y2vbCXQZ9ZGCbi8sofdpmry0WflT+B6QLaw250aN0bLXZTGjzdu6uYboFTjuTH5GJFrZ0ZsBA/ScVlfzAJnNpF4r/OF6RoRgbpbchVl/u4syxaWTf2Z3MWkjAadY3Z+xUVwoFpcRsjgm+z9t5T+VQ==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:40 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 05/17] spi: s3c64xx: avoid possible negative array index
Date: Wed,  7 Feb 2024 12:04:19 +0000
Message-ID: <20240207120431.2766269-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
References: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform id is used as an index into the fifo_lvl_mask array.
Platforms can come with a negative device ID, PLATFORM_DEVID_NONE (-1),
thus we risked a negative array index. Catch such cases and fail to
probe.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 0a30d034e288..dfe78ddfa233 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1228,6 +1228,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 					     "Failed to get alias id\n");
 		sdd->port_id = ret;
 	} else {
+		if (pdev->id < 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "Negative platform ID is not allowed\n");
 		sdd->port_id = pdev->id;
 	}
 
-- 
2.43.0.687.g38aa6559b0-goog


