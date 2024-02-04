Return-Path: <linux-kernel+bounces-51781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAE6848F38
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5E91C2200B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1DE22EF0;
	Sun,  4 Feb 2024 16:22:22 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563C22EEB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063742; cv=none; b=P21tPTza7PozmIHu/iK2nd0NhBZvIPhAp4RQ63zWM7thNpoAyIsmYW5YgKsE4ZrgL1n/cbkLe3jzAs1UufD5QbhF4naviEDoyXAO550Cu+XcMWfBwGa9UZdq8nsFvyJbRsbbn+SwP4eYJoOtdLgyvxBKDig9syROFmgOzbFM6cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063742; c=relaxed/simple;
	bh=jWl4w/4OtxRG3KppKdL4PminQ5fAWwwOAlPqvG8qoHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHpZwReFz3fvjY89+Rc80jIhFG+kIp7XMQqN2246Yg61bbMWLSM5UwGSSz7+CGH00io4/COcCqoC/PkqIHJmV9ZxkrgE5hTiPGr4io9KnhNO7S4qG/bFGw0+apSyiEJEuX0CgvOI1Vbr6A/0vaps6Z1nKZhyLTPavfrqFzAZNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 6810e854-c379-11ee-b972-005056bdfda7;
	Sun, 04 Feb 2024 18:21:10 +0200 (EET)
From: andy.shevchenko@gmail.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Minjie Du <duminjie@vivo.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] spi: fsl-dspi: Unify error messaging in dspi_request_dma()
Date: Sun,  4 Feb 2024 18:21:06 +0200
Message-ID: <20240204162106.1179621-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `ret = dev_err_probe(...);` pattern for all messages in dspi_request_dma()
for the sake of uniforming them. While at it, fix indentation issue reported
by Vladimir Oltean.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c9eae046f66c..e0832f1f10bd 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -502,15 +502,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		return -ENOMEM;
 
 	dma->chan_rx = dma_request_chan(dev, "rx");
-	if (IS_ERR(dma->chan_rx)) {
-		return dev_err_probe(dev, PTR_ERR(dma->chan_rx),
-			"rx dma channel not available\n");
-	}
+	if (IS_ERR(dma->chan_rx))
+		return dev_err_probe(dev, PTR_ERR(dma->chan_rx), "rx dma channel not available\n");
 
 	dma->chan_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->chan_tx)) {
-		ret = PTR_ERR(dma->chan_tx);
-		dev_err_probe(dev, ret, "tx dma channel not available\n");
+		ret = dev_err_probe(dev, PTR_ERR(dma->chan_tx), "tx dma channel not available\n");
 		goto err_tx_channel;
 	}
 
@@ -541,16 +538,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	cfg.direction = DMA_DEV_TO_MEM;
 	ret = dmaengine_slave_config(dma->chan_rx, &cfg);
 	if (ret) {
-		dev_err(dev, "can't configure rx dma channel\n");
-		ret = -EINVAL;
+		ret = dev_err_probe(dev, -EINVAL, "can't configure rx dma channel\n");
 		goto err_slave_config;
 	}
 
 	cfg.direction = DMA_MEM_TO_DEV;
 	ret = dmaengine_slave_config(dma->chan_tx, &cfg);
 	if (ret) {
-		dev_err(dev, "can't configure tx dma channel\n");
-		ret = -EINVAL;
+		ret = dev_err_probe(dev, -EINVAL, "can't configure tx dma channel\n");
 		goto err_slave_config;
 	}
 
-- 
2.43.0


