Return-Path: <linux-kernel+bounces-35540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57098392E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603441F2716F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C14605A3;
	Tue, 23 Jan 2024 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDA/xbR6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE55FEE8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024072; cv=none; b=iEaEcBWqGW6oePfyQ7jRFCU8F4rRVZN33GO02+2LMB2tIA6Sk6w/1y3Lrc9ElQ4egUlyWB3Qw5t5ydEEOxwAUyFMhojtXkEpPu5tZ6xhX1O9J056AJQuGrHzPVsxd+sEytNqhcSRzxs0SCg/YHFDrc4LvWvjHD+ZWxnPN7arYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024072; c=relaxed/simple;
	bh=TH1sVFAhrdGV6Yp4bPleYA0ox21IwTqCKXRbqk0AOdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8Hk+VScnSO7XWE2u01RBwFfzvESV6dLmn68LG3uIG7UWaDyLyoAwwv7FQYxRQBu9OEsww93s1THFoScry2C2d1jy/ZREN1vXH9KbVJVHS/WW8luQP3Ii0HhFKQc+aeuGYsv3RwqBRiYlkvrZpbSpciIkXwqM6cKL53xcn7Wjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JDA/xbR6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ec2594544so4093865e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024068; x=1706628868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYolP7qSHiJsNw4Rdgmh202yjvtbAUk4vGAE3cDed4M=;
        b=JDA/xbR6KvLA8/Z/tWfYjY0wQ7l6LqEZy1svkdh5EQtmC3adowT1kpanGtenap66O+
         JtD+9BCDAF6MU2Avl60gOLNVZYIRMnLdzShy18Y0w3oeLBYDGhuj0enDxtfUOgaln8QZ
         6uD6assl1guwiG1Ek2XDn+XMRDlgRMR2iF4gERgajaL11C0ZSsY0o3V7rLU58HXqbkEN
         2Jl6tcJlMM6cWnmamSCKQpfJqu5qPyMtZ5ItMGBDiu/bwy/kcGhBUXyzqb7ZVXndv92B
         hxrNfQvXxf/8h+CyzFMFZ71E0iyeqLv1Th0n4o4w5r1JUaK7LCAvx/yFxDOb26741yE4
         8b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024068; x=1706628868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYolP7qSHiJsNw4Rdgmh202yjvtbAUk4vGAE3cDed4M=;
        b=EFPdGCm5RuzXfuCBZfwNvvlX1DaWN8DXclWZmZkfesplP8BhE4qoO992665uEWzZ58
         XGJsAew8GUDln4smnjrEMuP1d0VJ6jSzLdd9XFJ5SLkOXH3F8byGDz18H/vn1hFeJekN
         o9n8H3pLm8mVECK9v4D9Bn+RoIIwVqKTAZ+3R4Cl8PwDxpMfEudnIYVd6w8Ar4aQPliT
         I6I0qS7OfwC0qAVnJNgEQSR+h3V6dbn94/JTLU6xHaD32s943iHUWbaljfEvX7EafYHQ
         CHuCjrCVUdwFUu9+5Kkucf4iZuqqrwKWHxmE+As4lt4wz2kSmRvU9+7HiXM82QS8co5C
         JWGA==
X-Gm-Message-State: AOJu0YwN72/I7VbQvUAj89ENm8MZJ6lKBbViCVlNnnQ8KaGFFEjRgCTM
	yhJCMmN6WxwzQHHjRG0I+7DJynvTDeqtRJE97lj3GN13Udmld7pvnLIOW/nHcCw=
X-Google-Smtp-Source: AGHT+IHWuxpxzMg8g8EGj2cXNPfD+1g/XO+XPmUi/g8fAIxbN4ApYg+KOHjM4WPsFejLGkzpu2Gcog==
X-Received: by 2002:a05:600c:2d16:b0:40e:5571:2c6f with SMTP id x22-20020a05600c2d1600b0040e55712c6fmr254080wmf.67.1706024068416;
        Tue, 23 Jan 2024 07:34:28 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:28 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 04/21] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
Date: Tue, 23 Jan 2024 15:34:03 +0000
Message-ID: <20240123153421.715951-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_device_id::data is an opaque pointer. No explicit cast is needed.
Remove unneeded (void *) casts in of_match_table. While here align the
compatible and data members.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 40 +++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 26d389d95af9..b350e70fd179 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1495,29 +1495,37 @@ static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 };
 
 static const struct of_device_id s3c64xx_spi_dt_match[] = {
-	{ .compatible = "samsung,s3c2443-spi",
-			.data = (void *)&s3c2443_spi_port_config,
+	{
+		.compatible = "samsung,s3c2443-spi",
+		.data = &s3c2443_spi_port_config,
 	},
-	{ .compatible = "samsung,s3c6410-spi",
-			.data = (void *)&s3c6410_spi_port_config,
+	{
+		.compatible = "samsung,s3c6410-spi",
+		.data = &s3c6410_spi_port_config,
 	},
-	{ .compatible = "samsung,s5pv210-spi",
-			.data = (void *)&s5pv210_spi_port_config,
+	{
+		.compatible = "samsung,s5pv210-spi",
+		.data = &s5pv210_spi_port_config,
 	},
-	{ .compatible = "samsung,exynos4210-spi",
-			.data = (void *)&exynos4_spi_port_config,
+	{
+		.compatible = "samsung,exynos4210-spi",
+		.data = &exynos4_spi_port_config,
 	},
-	{ .compatible = "samsung,exynos7-spi",
-			.data = (void *)&exynos7_spi_port_config,
+	{
+		.compatible = "samsung,exynos7-spi",
+		.data = &exynos7_spi_port_config,
 	},
-	{ .compatible = "samsung,exynos5433-spi",
-			.data = (void *)&exynos5433_spi_port_config,
+	{
+		.compatible = "samsung,exynos5433-spi",
+		.data = &exynos5433_spi_port_config,
 	},
-	{ .compatible = "samsung,exynosautov9-spi",
-			.data = (void *)&exynosautov9_spi_port_config,
+	{
+		.compatible = "samsung,exynosautov9-spi",
+		.data = &exynosautov9_spi_port_config,
 	},
-	{ .compatible = "tesla,fsd-spi",
-			.data = (void *)&fsd_spi_port_config,
+	{
+		.compatible = "tesla,fsd-spi",
+		.data = &fsd_spi_port_config,
 	},
 	{ },
 };
-- 
2.43.0.429.g432eaa2c6b-goog


