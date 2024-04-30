Return-Path: <linux-kernel+bounces-163857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0199B8B74AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52161B20DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974CA13D29C;
	Tue, 30 Apr 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PFBQx0Lc"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D613249E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477314; cv=none; b=o/9VkmWfcZRt0pd1MTAeuNIv4PHbXvm/B39ymSD8kSY+ZZH8EAsIOiJK4ftOu/W5G6zZdbu9RLOvgYKDybt9IJr7vGndXqh3ufkmH1F5aydmx1vqLEH3gjT7BGq5UsC24S8Kst6dcksurTc3npv91jlKiT/B8dlhXiAVdcSb3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477314; c=relaxed/simple;
	bh=Zmt3mvVxR8/6eumvAZBZCb07XHV0s9S1SjrKXTEDONg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqgMARY5cnR5zTLwUBvH04KJFntYehJoVoCxgwfM0O1gzBkOa3lEiytNJxfm2EcpbOKzxznc/hLJOFnu+gAcE4N8tlvT8dPvA/Uenq35BB3mTjJv14x1l5jbafMcb93I7VRxgn3XpEHBxiodQGylYmRc9altdUfY8K771TBqah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PFBQx0Lc; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=MInQ7pWHBpWvz99BT9rM0W6PRLzDwOBqZlUusbB0xrA=; b=PFBQx0
	LcjP1lOQmgur5cxsF4MmLzW62BCayntJYN4KnDO2hx/4ZDpKZii/2uEIF9Sscfxn
	LbychW4mVAebCRENjb91HKlc8I3v1lzbj+e664RMGpIh7RHb/yyn5uHfi1BllnY8
	JKFCp8aftvut1CRRGWDsxpTUmuBseaPoSfVXXFLoqZZQ+mGSUi1g+/6vBEU++D5o
	sxLMOR67vLtttJ/NnYJ5tpJqUsoVq445SdbggPqlfECvUV3w75FLmmvVxB0HMGiQ
	UhQrbU0OMXVgiLlqDLuEdKTe4sMVkcRzdJtNvqBy39RJugUQ6ha7TzI/reM5RYNW
	RnMBlBWupT4CC4fA==
Received: (qmail 2617804 invoked from network); 30 Apr 2024 13:41:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:41:45 +0200
X-UD-Smtp-Session: l3s3148p1@2Qu+2k4Xtuhehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] spi: fsl-lpspi: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:41:34 +0200
Message-ID: <20240430114142.28551-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
References: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/spi/spi-fsl-lpspi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 92a662d1b55c..aa5ed254be46 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -553,7 +553,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 {
 	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
 	unsigned long transfer_timeout;
-	unsigned long timeout;
+	unsigned long time_left;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
 	int ret;
 
@@ -594,9 +594,9 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 							       transfer->len);
 
 		/* Wait eDMA to finish the data transfer.*/
-		timeout = wait_for_completion_timeout(&fsl_lpspi->dma_tx_completion,
-						      transfer_timeout);
-		if (!timeout) {
+		time_left = wait_for_completion_timeout(&fsl_lpspi->dma_tx_completion,
+							transfer_timeout);
+		if (!time_left) {
 			dev_err(fsl_lpspi->dev, "I/O Error in DMA TX\n");
 			dmaengine_terminate_all(controller->dma_tx);
 			dmaengine_terminate_all(controller->dma_rx);
@@ -604,9 +604,9 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 			return -ETIMEDOUT;
 		}
 
-		timeout = wait_for_completion_timeout(&fsl_lpspi->dma_rx_completion,
-						      transfer_timeout);
-		if (!timeout) {
+		time_left = wait_for_completion_timeout(&fsl_lpspi->dma_rx_completion,
+							transfer_timeout);
+		if (!time_left) {
 			dev_err(fsl_lpspi->dev, "I/O Error in DMA RX\n");
 			dmaengine_terminate_all(controller->dma_tx);
 			dmaengine_terminate_all(controller->dma_rx);
-- 
2.43.0


