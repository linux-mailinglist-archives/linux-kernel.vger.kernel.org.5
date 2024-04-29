Return-Path: <linux-kernel+bounces-162141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7245A8B5696
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AB11F235BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3E9481BE;
	Mon, 29 Apr 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="WbKQJDFH"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F44176B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390135; cv=none; b=Mz0rkAm3XbX0yfbfSNM8d8wZpJHx/Ak6l8cjE3PXJ/8af0tvKrZhgoVw9x1yYmDzf2s5YwXJFPTA738enre7lTmy7b5vBQUMDnCsJxn6LlHJpYbqMJgt33DufUrt4ejwrOzdl7aLdt5h70KlEc5ALMuH01vg9xHr93Leg3QQ0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390135; c=relaxed/simple;
	bh=Zmt3mvVxR8/6eumvAZBZCb07XHV0s9S1SjrKXTEDONg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nffv3xNOyDuub4VAuufrVZYjYBMwmO28aeziiLivqlXNkMudnLpO9ZkbEmX4XZ+2Xiz7NWqelv0HQ1coREen+Mj3t1sFISpqDd67o3jx6C6D/hNtUR6WytZss2uE+57UFQCxwJCsSeGq3b7nVR36izNL+YTnsi7XFfP/3nOOvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=WbKQJDFH; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=MInQ7pWHBpWvz99BT9rM0W6PRLzDwOBqZlUusbB0xrA=; b=WbKQJD
	FHMrDGNaxa7kcjZJGqVu3ihuDXv9KISrpMvum40cOr470SRiySzb7UDHfBJm8Tj0
	pr2TYBxLI4CVC/WkJgBljlUOn/GSnJT1W2f7SCVmdQc1X1TrbX5LczsOxBjs5H67
	Q7MsY7QcTbEAul2tCZeWUebTHSQVrz8qYe49tRQN/u0upsjhX2Azuav2aiWLJ/0B
	Z1ShxOI9HNOf6T4cMXydCmTBBZf/wNvvaVmW/5gBuc3G/njYpFupGVsg8c9XD7Is
	TV8ECecwMrNlM61NCgjxGj+k0dD1FhLQbn+kLpnFa7v2vwoC12kb2+hoIcYsk+Lq
	npiM1+AUpgqLHaYw==
Received: (qmail 2279552 invoked from network); 29 Apr 2024 13:28:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:46 +0200
X-UD-Smtp-Session: l3s3148p1@uCdzjjoXtG1tKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] spi: fsl-lpspi: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:28:35 +0200
Message-ID: <20240429112843.67628-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
References: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
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


