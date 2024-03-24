Return-Path: <linux-kernel+bounces-115161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47B7888D80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118F31C2AA0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53788305492;
	Mon, 25 Mar 2024 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MglDmZVi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED118277F;
	Sun, 24 Mar 2024 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324194; cv=none; b=Fv2pNjOjxuJqPXIglG+bdmM7k3nTszndIqreSTmHMi+fdYIZzJueMw7UpNqfF0GvuC0KvCoKInQ2u9VSauge9NaID2OcH756jtId36M3PvBLs/TBpSE8Pq1ey68zi6JjluYwi9n74NRiw4PCLH69fs1hFDcDQHWDOmKPGbaLgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324194; c=relaxed/simple;
	bh=0Rc2g67sGLQFqzeHM5BrRlftSLE3u77pUTGIFlbaCNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6Iipa0xJENRoMNnMVO2kau2Jkhef2tHYlfQvqiASAk/akdl5P1nePtH2JHRr9UeY+Onr0LSPapGAFthqToFR99A9fULB/PV3K//dbDKoT1Uxit4Pyayiz73cZzjdFoSxZ7SDLESHhDFI9jXR/lIHAae6Fr/E2lrJ9pgvy4EnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MglDmZVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243D9C43390;
	Sun, 24 Mar 2024 23:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324192;
	bh=0Rc2g67sGLQFqzeHM5BrRlftSLE3u77pUTGIFlbaCNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MglDmZViqDPqxaAYDZEnx9XpYzlM63NkkPRPO3YxLHBAMSBhQSt6cO28j5k+rumEs
	 ydTEekpBNL7y7/8cOnDc1w+D+TQug5Ca325VramY7uZ1ss7tlP9OMKF8vvYFRZ5Ds3
	 46essnqNnMNU2ZQrZLSNvu3ZPj11gWY2jjiuSHHaWs81MjDSMgNnn3oZOSmS9XhbVs
	 h7BFOBIO3NI1VYVPXajRWKmxBiz4Ix0O9u3QWBEk0hsy3GNkKKDfAKIc5VfUuGyU3q
	 N9K3k4Ea1iIMrIASiSxBG0bKLyzhBpYZl4iBxViKLrquvq2WD+UoK6/JBTXhMvKSEP
	 jQijVLHeq3p1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 181/183] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
Date: Sun, 24 Mar 2024 19:46:34 -0400
Message-ID: <20240324234638.1355609-182-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Fei Shao <fshao@chromium.org>

[ Upstream commit a20ad45008a7c82f1184dc6dee280096009ece55 ]

The TX buffer in spi_transfer can be a NULL pointer, so the interrupt
handler may end up writing to the invalid memory and cause crashes.

Add a check to trans->tx_buf before using it.

Fixes: 1ce24864bff4 ("spi: mediatek: Only do dma for 4-byte aligned buffers")
Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://msgid.link/r/20240321070942.1587146-2-fshao@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 29d44f5d5212c..8105b458d12f7 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -559,17 +559,19 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(master);
 
-		cnt = mdata->xfer_len / 4;
-		iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
-				trans->tx_buf + mdata->num_xfered, cnt);
+		if (trans->tx_buf) {
+			cnt = mdata->xfer_len / 4;
+			iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
+					trans->tx_buf + mdata->num_xfered, cnt);
 
-		remainder = mdata->xfer_len % 4;
-		if (remainder > 0) {
-			reg_val = 0;
-			memcpy(&reg_val,
-				trans->tx_buf + (cnt * 4) + mdata->num_xfered,
-				remainder);
-			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+			remainder = mdata->xfer_len % 4;
+			if (remainder > 0) {
+				reg_val = 0;
+				memcpy(&reg_val,
+					trans->tx_buf + (cnt * 4) + mdata->num_xfered,
+					remainder);
+				writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+			}
 		}
 
 		mtk_spi_enable_transfer(master);
-- 
2.43.0


