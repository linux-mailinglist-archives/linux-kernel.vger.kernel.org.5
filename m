Return-Path: <linux-kernel+bounces-68153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2419D857690
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4018284F16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE881C686;
	Fri, 16 Feb 2024 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pc07qB4x"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209891C2B2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067176; cv=none; b=itCXOZ+qzwJOkjWgiyVlcc++qwlwyAULgnyuQXGQ37VK+RYIPok0ELmdPBiteD+wz2mHuB1yTENMOh0Doorfyx8W47prwH+7qWJWsZoIcBMVrwxvwApOB0O681ioOnJd1DnM2mTxdbX2CE+mmLKO0oQFMJlGNiFzMumZPlWtHBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067176; c=relaxed/simple;
	bh=3EdBwoR+7Nrfa5x/e89kDaaHLZR+YpN08+2w1Oy4K+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlWWAdL2K4JOUYZwlAx2V+vjhryiFREp5FRyL0XaVvsJOncUjGZktUb3Kf4jwgPQZbD2DQireTuMlf5yHCXrkeo1YYmTD05xWUh8X7/xt7is1+8OwEVRd0Edo5amMvicrFf/DRlegSMSlYNzKcI683J27aB8HvOp4axPnxcUZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pc07qB4x; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d01faf711so390945f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067173; x=1708671973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQRRPX+blWzvEopmbMKDola2GW+hMdPUAJuHhbzX5L4=;
        b=Pc07qB4xLVBKV7eAuOLhy5kL5+1CG9FFs9ZO0ie9BRw7LiFVFq64nc1MEjW0QE9bZA
         TY4cEfAexk1ZaONfNY8HJpOZb4cRiIjQRZHowYkxYvPJUsiQ+wjmNgOEm5q77fkNAnkA
         Bn6r+UtyN5BwHrDN5mGKG0D7XERbG01FcxyMC2H7AoDGGXPn7D17c+8xQyx9jvSFNNkm
         wCWrYMt5+E5JzNIziZEopBAUNJd+4OgWWLdXcEpUytwQf3rg13dEnCUesvx27pMsiYDU
         jUc2kHEAUUO1bCHKGvupk14F/UnVL0vB6hcsJNbMnM9kiX+WjZUEZZ5HmyES4M208aR5
         /4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067173; x=1708671973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQRRPX+blWzvEopmbMKDola2GW+hMdPUAJuHhbzX5L4=;
        b=iWwxV711MzBrWwUd4DW6izk4v3u3mdRX2KzZJtimEhI1kxFz66E3DA53XFUxpSU1Pa
         ixsT9yurcJP77YwYccjdesuJnGtVnkE8e98ir9O61lXSO1YGnurNRPSsXiTYXicexIak
         OstIA7rP5zoRPAI572/wHqA+Ht8uo2AgqflAX5I4RGxD7Xnr3j2y4w5jV8EJ2KFW3zQB
         dKapt4sdLrlxO9M/siL+uRMi86novFRsumJj0dbwH1p++XQ7R+ATuISxJPfDVCj90/Lz
         Bzh17u48p3vQmrFF/n9eDEzvLNT0nFNB4YclIoXzdLXt2MSiohNq1bc8uD/1R21Cnjja
         YP9A==
X-Forwarded-Encrypted: i=1; AJvYcCV4wmjHPuC1TaTyHDMUNOG3uYDUsEOPsO2SbNb5h7n+zDKFWhbYYQlSmcNIJ54tCE7W4f/kp/phaB6esL0TreswWVPj/GKzXU0aGGGT
X-Gm-Message-State: AOJu0YxJbAIgnzHXBnLPFuTjKlYf/dq1d65m/iPBHOjz9A5gfd7eez7s
	bh9XsWfdZTCeGfAU3K8SDjM43uw2iVJ7aJ5j4019mvNHXK2LHFgiV2mnzjlKaPg=
X-Google-Smtp-Source: AGHT+IErqstmVJ3gg7nFuUbDeEkjVZQK9cB6BlztDErH2tYUhPqM2cCZ8/9WxbIirM2WMTjujF6W/w==
X-Received: by 2002:a5d:508c:0:b0:33d:1f42:ea37 with SMTP id a12-20020a5d508c000000b0033d1f42ea37mr361534wrt.15.1708067173486;
        Thu, 15 Feb 2024 23:06:13 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm1298839wrw.93.2024.02.15.23.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:06:12 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 12/12] spi: s3c64xx: switch exynos850 to new port config data
Date: Fri, 16 Feb 2024 07:05:55 +0000
Message-ID: <20240216070555.2483977-13-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exynos850 has the same version of USI SPI (v2.1) as GS101.
Drop the fifo_lvl_mask and rx_lvl_offset and switch to the new port
config data.

Backward compatibility with DT is not broken because when alises are
set:
- the SPI core will set the bus number according to the alias ID
- the FIFO depth is always the same size for exynos850 (64 bytes) no
  matter the alias ID number.

Advantages of the change:
- drop dependency on the OF alias ID.
- FIFO depth is inferred from the compatible. Exynos850 integrates 3 SPI
  IPs, all with 64 bytes FIFO depths.
- use full mask for SPI_STATUS.{RX, TX}_FIFO_LVL fields. Using partial
  masks is misleading and can hide problems of the driver logic.

Just compiled tested.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 784786407d2e..9fcbe040cb2f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1576,10 +1576,9 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
-	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
-	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f },
-	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
-	.rx_lvl_offset	= 15,
+	.fifo_depth	= 64,
+	.rx_fifomask	= S3C64XX_SPI_ST_RX_FIFO_RDY_V2,
+	.tx_fifomask	= S3C64XX_SPI_ST_TX_FIFO_RDY_V2,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
 	.high_speed	= true,
-- 
2.44.0.rc0.258.g7320e95886-goog


