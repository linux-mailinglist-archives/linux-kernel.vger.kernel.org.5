Return-Path: <linux-kernel+bounces-31664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D9283323E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510ABB22BB2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF8D512;
	Sat, 20 Jan 2024 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WptZtKel"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A92211A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705714196; cv=none; b=fBfZP4eUKuoPWeNzKBtawFDZg82Yd0WrRO3rHR2q6Rfco0qvqvsOCIUGLjm+H0QD1IT0l7lVdzHwJmhfB46N8urVLN63DTwmfynzTznKJKsewzeBVxb3QiphoWmIkssDw3AddpxvrJeorJPpXqHAyFXuBAq7hpl0liOfFK9Yrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705714196; c=relaxed/simple;
	bh=fk8XiabqMiTLyefse8VZLRwgyi31Z1xKcKy6eX/vYSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkpwYZz/fyvjMoK7F/wFDTfVANu5aUncp1KQxkti4bZt2yvDayGo/fbmcjFoB6k/dAEZLPNA5z3/fa/KNklDlZKzPSVdR4CNK6YEo8Mab9kcb7PWZ4V7OH3qBb12KnUB4Ix06S2bQ+V3sbUtaJQKC0ZjhekN2nxEq3Ad9hITctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WptZtKel; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-210cc863229so735006fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705714193; x=1706318993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMnp1EnNyy6QblTmu0JteJYMQKXa/fw0V+fbcltXPTE=;
        b=WptZtKel4ZLqhEN/lirtHuuTO/OdBV5aTrWlK3mMS0DaxgrdnVaN+hF3zaA0k3EEnV
         pTXeE5wDusr1gWr7feXrxHqEHRBC6JqB8PqDEE71y5pfIXQ/omi09g+q40VxRB8qgkJ8
         qLLJAJneetQK6IY1e/opM9WNyS3ROI3lwnDRFAgmKUoQf+StDHWTzut53nvD5ESB4JRM
         XXpMP8f/+i8+zi2xeNz7nXuPx8z2L/FIicky8wR11xFuYFNpzrkbFgdJvoDTnu0F0nB0
         UEW2ACEMiCkE+m7AezI6ozyMaKbQnjicYrnmZvRHS7oXxN5YNwlfCA+RdanM67Am0uWx
         xD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705714193; x=1706318993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMnp1EnNyy6QblTmu0JteJYMQKXa/fw0V+fbcltXPTE=;
        b=asJ/cXJA5Q7NHx1E5O3R9IpYa/LtSZaRVus/OW/Rsz0dEZlTYCf4+t0W3Davx+1wWB
         +EZdR9ETBtcx1lgAIG2ANy+nHxcBDgJaBNBLvSgmSPA60Gzkr7UDh/PBp3NTHRefvSN3
         n26G5bT+9X1Gr9/43ALGia0tuzY4ofaK/COgpR7Um5t4VHNHgZwSV4LYVB7VJbXqYuBD
         Aq69uGNzI8LosoBMzCrfSQdcxJScEIuTYZ2MDNP0PXByfQASSqcoR9Hci13FJvD6HMOy
         387CHm3uRfc/2YX7/sDrcR0kCaKNnzIVoY5Z9OAkVCaEg+RaPaAM4CmhZoLlXoAN39lG
         TvSw==
X-Gm-Message-State: AOJu0YxfGpUfLhFHuiYMmjpip16E4n5PXOqEYnFfMBxmKLhgNbSG+bei
	SqFuYjyuT8Wqpn477YhC7dEBMKaomTXa0wnkdeaIPIB90GkijaWGRzwpiNK9rKI=
X-Google-Smtp-Source: AGHT+IE5ugFsy7UmjXj1qZCVNbkAYGUUWs7jRHd0FQAWQYKi6FOfsXMA/F4m2hxtyMEwUlCAYRksZw==
X-Received: by 2002:a05:6870:eca8:b0:214:2544:bfd9 with SMTP id eo40-20020a056870eca800b002142544bfd9mr379997oab.43.1705714193150;
        Fri, 19 Jan 2024 17:29:53 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id yl13-20020a05687c218d00b002109874642esm1096224oab.44.2024.01.19.17.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 17:29:52 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 5/7] spi: s3c64xx: Add Exynos850 support
Date: Fri, 19 Jan 2024 19:29:46 -0600
Message-Id: <20240120012948.8836-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120012948.8836-1-semen.protsenko@linaro.org>
References: <20240120012948.8836-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPI port configuration for Exynos850 SoC. It has 3 USI blocks which
can be configured in SPI mode:

  * spi_0: BLK_PERI_SPI_0 (0x13940000)
  * spi_1: BLK_ALIVE_USI_CMGP00 (0x11d00000)
  * spi_2: BLK_ALIVE_USI_CMGP01 (0x11d20000)

SPI FIFO depth is 64 bytes for all those SPI blocks, so the
fifo_lvl_mask value is set to 0x7f. All blocks have DIV_4 as the
default internal clock divider, and an internal loopback mode to run
a loopback test.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 0e48ffd499b9..f7d623ad6ac3 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1461,6 +1461,17 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
 };
 
+static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
+	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f },
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.clk_div	= 4,
+	.high_speed	= true,
+	.clk_from_cmu	= true,
+	.has_loopback	= true,
+	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
 	.fifo_lvl_mask	= { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff, 0x7f,
 			    0x7f, 0x7f, 0x7f, 0x7f},
@@ -1515,6 +1526,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,exynos5433-spi",
 			.data = (void *)&exynos5433_spi_port_config,
 	},
+	{ .compatible = "samsung,exynos850-spi",
+			.data = (void *)&exynos850_spi_port_config,
+	},
 	{ .compatible = "samsung,exynosautov9-spi",
 			.data = (void *)&exynosautov9_spi_port_config,
 	},
-- 
2.39.2


