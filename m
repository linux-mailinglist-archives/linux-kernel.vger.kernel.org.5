Return-Path: <linux-kernel+bounces-40408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4613683DFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035EE283D81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311E82111B;
	Fri, 26 Jan 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+UqC9/d"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA8620B38
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289358; cv=none; b=HeQtsPqNtZH6X6tUgA+/Kb13nW+E7Kg8uHpkvl1CPjrN8C9YY3ukONAmOK65iVug9h8ejWhhaEkf3Fx+n7Qb2y0Wn7zZPb51Xr/On3cIF7IYSJYUfE7X9y4VwVXL4quvXy1DaOYprrFYC9emPy93MuB10UN5Oi/eijDTxNinZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289358; c=relaxed/simple;
	bh=VTX861XLM6xkP27hQbVL364w94zE9V+adeI06HzUo8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4o9oC0ZOlY7+X0oH0qzARNuCDlcdXo3dkXvoHomZSLzZ4XE1xkpDfUI5zoRz8mvFTKUa70HIo3bIEQtEyyEkbSMgVVOQ4r77PWKdC5/4p0jTRBNwTbtCiNg7orxnm8fmhZm6dIlpsILnTlDVXy3n8ivF5VxMzINPL/GtBCH6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+UqC9/d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40eac352733so12299495e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289355; x=1706894155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ltiFYCSIhgmUya18eTjqQJ7jz6+WhmArMeXn4kQ+FI=;
        b=i+UqC9/dfzvyTTlVuhEwaqwNJQiuZOzSk/GTu1sHbj+stoUZLXpvvZ/aydLt4stxui
         QVYftd4yzJEYFPfX518e2EQalCm7E6WnM1ZdDFzcgCfS9pAn2bXn41EMA+Y1Iu055WJQ
         QZyz+MeI3Vpo+sC175KM+aNuEeqOHC27lwtNbvxJ+JGPT7Wp9u/sdtEHm0k+GDnQ08xv
         4jMGGfN4SEy2kvQoNYgOI/Stdk+glqNqOmWfiA92cyVgMYh76Hwz6FuwLzcqSNf98ben
         OQihzj6UsYDH6uATHdNgFspFzwy/pDzurpf3J062Z+AFzBjKI425UZu66NTlMX/JqryD
         O+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289355; x=1706894155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ltiFYCSIhgmUya18eTjqQJ7jz6+WhmArMeXn4kQ+FI=;
        b=Y46ul1aO7OTNLbVZ5VpfXT/vhmq4u5oJ1voorBNKtBsLEkxRC5eamfGEYC585QpTeO
         H8566nHsdMJjnsl9oB3/oPZ3wlHgmhQdgCBwE5sbN9FGDaDM4fUbyZ7BUU5pWI7KthsD
         dkZHsxMuzY8ztQxbHZ6+PCBKplaghGr5CM9Z8sj2kc4t2K3KFihEM2qS3HKxH3AXc3CD
         h8MJ19A+IS5J5YLkk2psxTYXC/uDMSIOAKj1yW0OSrqupBEoLRm+WdAVvJQR+PQtLVG0
         ljKf1PAqXft7fOnJP7Bqo4cPbtgHY6I34Qo6PMbpjMpzKD62u5dKRC8I5341yzDpwQMZ
         3qOg==
X-Gm-Message-State: AOJu0Yzk7LarQ6qtKgwAc/U766TsKhxno4n2XjPiYG85fpNoJjb0qY+Y
	hjBUhSww+DnuUfljh06W/UgM0wm+wB6x/jgGjoc2dzUQtujvGS1HLuUsUjJWsuQ=
X-Google-Smtp-Source: AGHT+IGXyL9t9hz0rG7kmzfIGdhxA4l+IpUxFH4k8alwPjXlpgx8+SYwtpsf3ubKNpcU9Hrlqka7uA==
X-Received: by 2002:a05:600c:9a5:b0:40e:7d37:5fed with SMTP id w37-20020a05600c09a500b0040e7d375fedmr88633wmp.78.1706289354869;
        Fri, 26 Jan 2024 09:15:54 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:54 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 06/17] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
Date: Fri, 26 Jan 2024 17:15:34 +0000
Message-ID: <20240126171546.1233172-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
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

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 45 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ccb700312d64..9bf54c1044b3 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1511,32 +1511,41 @@ static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
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
-	{ .compatible = "samsung,exynos850-spi",
-			.data = (void *)&exynos850_spi_port_config,
+	{
+		.compatible = "samsung,exynos850-spi",
+		.data = &exynos850_spi_port_config,
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


