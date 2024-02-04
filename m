Return-Path: <linux-kernel+bounces-51881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA0F84905E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6D7281890
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C832C1A4;
	Sun,  4 Feb 2024 20:31:35 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998D25575
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707078695; cv=none; b=lsNeqsqYrNH6P/t0iES09alo/phMKybjBdkf3V6yRpL68LoSADggcmnaAiYvoxwdNqul+xdA8TBByZoeYgo7BEEbs2sJZjqvJLGEYK2VHslCfXgBpFS8QePbk7FTLQ/eiHwoMLGgG6zOrUfykd9EK6/AdX8HGS7dIL08HBBbirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707078695; c=relaxed/simple;
	bh=MhE/DRokJGyxHoqiW1gqVDgK1hamRUWnqv9bb+Y9vPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOQSWxNvSXqd8uQRPY7tAhpg6sTN35Bnj+1/vqSyQuY1807SjW1RxSeJL/1TrabsDDkg6YXN0crGmivOiUEnbCSqtudsi6k96GO/bdbGwHA0j+P8cjoHBc7NEYL3adJ8KR5x9wQffbfQL7NNWna2XoCWhU+LOjxwoL8u2g7C6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 6158c527-c39c-11ee-b972-005056bdfda7;
	Sun, 04 Feb 2024 22:31:31 +0200 (EET)
From: andy.shevchenko@gmail.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Minjie Du <duminjie@vivo.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/2] spi: fsl-dspi: Preserve error code returned by dmaengine_slave_config()
Date: Sun,  4 Feb 2024 22:29:18 +0200
Message-ID: <20240204203127.1186621-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204203127.1186621-1-andy.shevchenko@gmail.com>
References: <20240204203127.1186621-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dmaengine_slave_config() may return different error codes based on
the circumstances. Preserve it instead of shadowing to -EINVAL.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c9eae046f66c..0b5ea7a7da71 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -542,7 +542,6 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	ret = dmaengine_slave_config(dma->chan_rx, &cfg);
 	if (ret) {
 		dev_err(dev, "can't configure rx dma channel\n");
-		ret = -EINVAL;
 		goto err_slave_config;
 	}
 
@@ -550,7 +549,6 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	ret = dmaengine_slave_config(dma->chan_tx, &cfg);
 	if (ret) {
 		dev_err(dev, "can't configure tx dma channel\n");
-		ret = -EINVAL;
 		goto err_slave_config;
 	}
 
-- 
2.43.0


