Return-Path: <linux-kernel+bounces-38776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1CF83C5D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2F91F227A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEAD12CD9A;
	Thu, 25 Jan 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKp6/D3N"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBC812BEAD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194239; cv=none; b=F0JLBf2V0eR9HoXq97fwXML6nrMWn2PQkvxWip/0VCfDJUo1viNCacTwQ30d0Gd9fgjTDeCeiqxTQi/2i7A6VVGdFdRj4uXjursNtl5aw03RoJyI8k5QZzd9StS7k+A1FMs8u9Meg3iZF4o5sE9/3tmUsQJjQpqMQImHQp+ZEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194239; c=relaxed/simple;
	bh=WoVNESRo30BvS2OYppNAo5D8k2m5AsfvJTHHEVaE0W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuSlah5Mb3zmohEA+UpEXR2C9p41dSIhCj0oRcWNH0hFtFwHSqVmamiF0T5qvIp/pCKq8/k3epj3hty1v5I/bi1U3CFXHG2RBg7zfyWEdRGpwl8VWbPLzWHx8uWn47MrDuSr5DseGj1iphN/DngPZBz95huPSYuZ/aJe9NpEN+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKp6/D3N; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40eccccfce0so18425335e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194235; x=1706799035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19XNc7jIAxEmcrcFqH2bLQ+8jlId4AXQd1JRVfuNpBo=;
        b=DKp6/D3NmmKVStOw6FpuJcCXu6l7SGZAxLaOu8FbmOKv0nrvZJXR0MQ3T7QP4zNq2o
         4tpi5GzUPUKRj556gB/jKXsLy7XXPmoWfh3dZzdzjIp4yQr79IvsNvm39y1CM91aIdQx
         BMrlov9PLr/U3oyfA5H9fhgto/6EIivVddDUMjuS9guuH8CnmY/VzayG9P9+jSiP+Myd
         rafK/talC+4v4NyBv2cswDpseJDn3bBjweaLa3t6ZFAqJbxCiDfFmCoOIUjDkLQdInaJ
         7AdVGxQSG5xKbL5225VAtBTDYOdPFJ9vXjA1tWB6g7T4J+W+4lw3ht1Lbn6QPKQlOT/U
         6UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194235; x=1706799035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19XNc7jIAxEmcrcFqH2bLQ+8jlId4AXQd1JRVfuNpBo=;
        b=iOQlOO/56ZzGYSujchbDqGJj+wl7OLgNrfSTY7W4KNwN+VWfPPXNTZwa7nAJ8WG2fD
         G9IwD/9kw3kqw4vLk9A6frYUqnD8I1KGSuIbLhg4hqQuUk/zhAwfaW8Tg1Aihi2In+7Y
         E09kHiYM67nL6sMoE2ghCr8z6dcXYLTYfUvYeffzW/TSY3pc5u51FzLnd9lzRL/gY5m5
         npuEymk7F7Ez7oYnyam3neRd3lA3Kkt2ZVbdDX+a9e97+GR/NItGUS8NU1PENDKEzZd+
         gltMVCCdyKQO3BEDxnvjYzp4Fmtg0IWvkBQJhapeXhO5kO00uO9UIId9fOEKpZGY/thM
         6edw==
X-Gm-Message-State: AOJu0Yy3530gsm+VX5FuNIABbdoYxikvrUvuztTS2WZysH9EbPd3czSt
	ScnRUfC/rEqIu7EOmxWWacI9bT+aanKFgk3nFHgd6IV4W+TjXzqfHyL8cd8VQVo=
X-Google-Smtp-Source: AGHT+IEFr/987GA7O5P+jHyDvY1MNzaWPBQnTT94NwSUHH8TDDZpjDbDCXcvpcmOYFXkXrFx2sxc0A==
X-Received: by 2002:a05:600c:5293:b0:40b:5e59:ccdb with SMTP id hj19-20020a05600c529300b0040b5e59ccdbmr659803wmb.188.1706194235159;
        Thu, 25 Jan 2024 06:50:35 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:34 -0800 (PST)
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
Subject: [PATCH v2 27/28] spi: s3c64xx: add support for google,gs101-spi
Date: Thu, 25 Jan 2024 14:50:05 +0000
Message-ID: <20240125145007.748295-28-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for GS101 SPI. All the SPI nodes on GS101 have 64 bytes
FIFOs, infer the FIFO size from the compatible. GS101 allows just 32bit
register accesses, otherwise a Serror Interrupt is raised. Do the write
reg accesses in 32 bits.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 35a2d5554dfd..e887be6955a0 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1501,6 +1501,18 @@ static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static const struct s3c64xx_spi_port_config gs101_spi_port_config = {
+	.fifosize       = 64,
+	.rx_lvl_offset  = 15,
+	.tx_st_done     = 25,
+	.clk_div        = 4,
+	.high_speed     = true,
+	.clk_from_cmu   = true,
+	.has_loopback   = true,
+	.use_32bit_io	= true,
+	.quirks         = S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
 	.fifosize	= 64,
 	.rx_lvl_offset	= 15,
@@ -1556,6 +1568,10 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 		.compatible = "samsung,exynosautov9-spi",
 		.data = &exynosautov9_spi_port_config,
 	},
+	{
+		.compatible = "google,gs101-spi",
+		.data = &gs101_spi_port_config,
+	},
 	{
 		.compatible = "tesla,fsd-spi",
 		.data = &fsd_spi_port_config,
-- 
2.43.0.429.g432eaa2c6b-goog


