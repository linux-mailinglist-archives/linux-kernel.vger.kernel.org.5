Return-Path: <linux-kernel+bounces-35547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F983930A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E604EB27A66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7F60EEE;
	Tue, 23 Jan 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBdq8fLF"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417060B8D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024078; cv=none; b=TxG2sI67tvGaT/lAFIbZg1pjX7mszltJTx0xKYBB8NDdw8q0ORK2vjFJ3POB+rK0mcBXVO2fFAAfU5pHHQVd5eEahHfAgUFVpPiDBX6b4gdzl2CpNxfrJqLirLOwEg62oJqABvLfTLQyaD/ZLDY85j4VAfF8thQnNVU9A7v9qFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024078; c=relaxed/simple;
	bh=oZW1dEGYXoOBecvuAgXBXXl9mRMyS0AaQyngq3aW7dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuVFI/c7ADZAq1itJKM4u3T+f/O8OTLl6V+HX7uK3DH2eokD66+nrj4dWw4DD2odjZGuBGu1mQJIf6rChvh6ezrqWUxJAoAHq/Lpeco8gEu5DvW7jt+T2QwE+FVoxTiZLXRm+LhiCDrl+Uk4Ypme9k4Fi41sCUaCrfGCOkpAoPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WBdq8fLF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso25266915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024074; x=1706628874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCR0lpI4fVpLmP3DQ9mG8C0OncX2u+kTHiicR+nRZek=;
        b=WBdq8fLFOYOucgL3tr6oLn/1AZIIG0nciR1UreCJN5o2JoYuzYzcbs2Kht0/DDxPej
         KsdRvqlPkCbmjGh7vpFxMUdpnVMyuHhS8TIqgD/9lVicpvid2T+pMiCyStn1OylRT7yB
         hI6+XnCfrsTAy+qpZSJ+4uOTq3Z+U2HWTmI+OGPcP8obn1FAKc/vGE2wj+HHlJoYHGMq
         z9MbSq5oIysxCRvkbQ1q6POANfAmSsYPtksfE8qhaiWKgh9Zieu43CiqK4LpaLw17RPr
         4qU+1F0cugjrfOBslD03Wc69qPcCGwEQiG0fEe6nd9AZnjeIQKPBSmaKodj/ijba0sK9
         nvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024074; x=1706628874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCR0lpI4fVpLmP3DQ9mG8C0OncX2u+kTHiicR+nRZek=;
        b=kngaUikZ321oshQZgcPnEW8Vp67M0ccak3PNFPU093F8bOPIIGjDAQp+wzSY1JMZ5D
         4094wbCVo49HH73UlCGzYeOAsoZWbSXLPAkPvFrsPNio0xKP8GUsm5ho5Pu58S/kB9X/
         AbSnapgSNOqvOqsxw22z0tNVctdccDHYQkRbBmeaEf/rGnjBA3iCSdzmC8WoIzyhtXFL
         yHjGCwr6dAtHQ7y8Wm+tSlENLFGQ0QojzJbqrQY16xP6Ko5LgzNdkysez9MEWP6gC3zQ
         PE8mEwM9pq5Je1S7+6TDuXAeSZd0azVZvL6ZqkzcoT34ieHcN5j/Z2BkNotNHkJmOKKt
         REWQ==
X-Gm-Message-State: AOJu0YzSHjm6+SvHm+hznYOwZcYwrZCru2uKaVZ1LaC6c7rAFZQXDAZc
	rYV9PWwgJBQJ1woZFJuIGBJl/DmJpafPTbjaHxLDGZtdfaUbpQsSVL/a4d7vP8c=
X-Google-Smtp-Source: AGHT+IG9ffmjdMTbmPgzKsGlfFXptU3Y/H2kV8L9oXd6VmUQvvbkly+26/+kAPCJ0iTtA2RQs4aNqw==
X-Received: by 2002:a05:600c:3784:b0:40e:a366:e718 with SMTP id o4-20020a05600c378400b0040ea366e718mr247710wmr.42.1706024074578;
        Tue, 23 Jan 2024 07:34:34 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:33 -0800 (PST)
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
Subject: [PATCH 10/21] spi: s3c64xx: move common code outside if else
Date: Tue, 23 Jan 2024 15:34:09 +0000
Message-ID: <20240123153421.715951-11-tudor.ambarus@linaro.org>
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

Move common code outside if else to avoid code duplication.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index a06b83b952c6..4b13252da8b8 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -285,20 +285,18 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	if (dma->direction == DMA_DEV_TO_MEM) {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, rx_dma);
-		config.direction = dma->direction;
 		config.src_addr = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
 		config.src_addr_width = sdd->cur_bpw / 8;
 		config.src_maxburst = 1;
-		dmaengine_slave_config(dma->ch, &config);
 	} else {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, tx_dma);
-		config.direction = dma->direction;
 		config.dst_addr = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
 		config.dst_addr_width = sdd->cur_bpw / 8;
 		config.dst_maxburst = 1;
-		dmaengine_slave_config(dma->ch, &config);
 	}
+	config.direction = dma->direction;
+	dmaengine_slave_config(dma->ch, &config);
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
-- 
2.43.0.429.g432eaa2c6b-goog


