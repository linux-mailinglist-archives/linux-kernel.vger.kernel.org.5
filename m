Return-Path: <linux-kernel+bounces-37858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7380883B6A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DF51C21C60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E82C748F;
	Thu, 25 Jan 2024 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="McT2ebja"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC967C63
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146541; cv=none; b=B33gxE5Fgpwe8nNDdwDXk4w4xgCk4fplUee/d9PY4NTorAxUN252KHaBaNeUfZLWs6qU1+8WTjYWZiy7eB2Wxp0BX5yefY5AVumKU/NODfBG0xNgQJQ75P8KufdUOJqvPWNHHe7yjpzJpBV3dhXr9hLnuc8EDSr9ZJ7en5uMt5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146541; c=relaxed/simple;
	bh=1F1Aj5cUnjbKZW0MFBSCuoAq2nQMH9+wqAVLv2/faSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKxFiqJ47pjcJC0/W2fFCeFT7MVhDlGHpsSBZ/SYoFgqKwolsYzic1cNHgaI2kNJQLzLS4DorkXqvwXbqvF5LE/teg83hmcnTHH39AC1/UyVdlfxFm08Tl2nv1BXisLu66lNvs3ZVa+eE3REPwvgaSaBIAu17BKouVAsKTsgXqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=McT2ebja; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5988e55ede0so2811344eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706146539; x=1706751339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjuRSpcIWXYqOZvjAWqHzFzzwLvT3n28RLPhePkG0iw=;
        b=McT2ebjaMezC9n+XrWKaR3E0yPcpkF5JBw46wen9wpDMOf3ol6+8GQhAPivdBn023u
         wYx70FlUhm2gfgrLMBUbujVSW43KNaT0bjKDKZRVEOicp1oEBsAWvUDxjSyIAJoRWuOR
         kyZ8Hk2HdCf94V/PfdJZJ+qVINtTbIKht2op+OT7o0BxB/qbuRfxm1z3tkpzeyTuirCj
         09XPZTkGmmC5WsoywSZY/hD3S955wzNZGC5E6x9XoC3thmFnZB5wsm3+z3lolxqm311u
         BHv3pIjPqj/37cBLKzbzV3Rq1vv5I/tTCnL9IdaiNIoPE5whAG3Xmlv9vXtmzkucbF7W
         hSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706146539; x=1706751339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjuRSpcIWXYqOZvjAWqHzFzzwLvT3n28RLPhePkG0iw=;
        b=dcJWVvWlrHMyjPiYbMzCnocMaRioJ/54cM6LeDlhug7Qu1kdc2Tu9FxgJUA6T3FPEZ
         0fPcpz4LEwyY8x0UFqptGNdDp5iyBSoYIEuWL6XpkV9V7Xhimc4SC6SO0SH8s/sxb0aE
         Doj1obADEYi4/gM1y0MRmBHpnHchz8asHGGZJiEcVnOT4UR/LL736nLxYIc61KVAXent
         AJyQJkve/jD4OD9JV2B4jwCDHzFCZhuJFNO1M77fVxHHvFc6gJ4aFZr4uHBzJc3WkXFs
         pFb5lalRogvh7EKbDwxdr0trOvgFpGwtVMZ9KBpwatsw1Eirn/UN6MuqaV6U101V1oJF
         kvrg==
X-Gm-Message-State: AOJu0YzEAZesNOliHncIEoSOkc+P/8td/+MjaHtl3NouZ53gPeFg2Oh1
	15vz32heToW48MJp7lz5s8aNiiGgHrLDDIcqpOtaAOX4H8xb3tJkeKFOWRgfU6M=
X-Google-Smtp-Source: AGHT+IFunPKogENZFotEKH1JF2UT4MeAeYVGiWXJdEp5H18lXtn5KFzRJ5z23tLujkzDKPtbFWtY4w==
X-Received: by 2002:a05:6820:16b:b0:591:dc1e:d8c8 with SMTP id k11-20020a056820016b00b00591dc1ed8c8mr301082ood.15.1706146539238;
        Wed, 24 Jan 2024 17:35:39 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id t18-20020a4adbd2000000b00599dee152aesm159392oou.0.2024.01.24.17.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:35:38 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] spi: s3c64xx: Add Exynos850 support
Date: Wed, 24 Jan 2024 19:35:36 -0600
Message-Id: <20240125013536.30887-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125013536.30887-1-semen.protsenko@linaro.org>
References: <20240125013536.30887-1-semen.protsenko@linaro.org>
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
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v2:
  - Collected R-b tags

 drivers/spi/spi-s3c64xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 432ec60d3568..7f7eb8f742e4 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1460,6 +1460,17 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
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
@@ -1514,6 +1525,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
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


