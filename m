Return-Path: <linux-kernel+bounces-114001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD103889066
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96B6B2E42F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E10C143C5B;
	Sun, 24 Mar 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMnxnwwz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C601F4160;
	Sun, 24 Mar 2024 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321146; cv=none; b=QndjL7FsdcFRT7fFgSv5zse3ZVzWe5A7KkXIvBFz1vWlTlGfnqcTe9DSOe9ITgCLMjTvIhqF/xASBZxLgFjO7x6zCAAwkRG16/4k3S3Eb/SbVXYDD1as2vO2xceYw379kJGyUQ2zNHUfEBczPUjfZlwD+H2oArmN3E4TA4vFfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321146; c=relaxed/simple;
	bh=tFj2kkXecT+l6596uU5LihaJJNQADvi51+t5Ax7Pvpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9RPHnXpIjn5DBBy7ozBkGfQ2cJKeAFPMtB0Ck22gwIx2V3MLOuZJh1Y4s9WZgHCmIP7Q9DQVBYtv/ZmO1qolRhWHWj5bw3ecgNy4AKCYQdPKsblBksrueSiX5nA8ja2WzAE7P0kYjT1s/yREosu2j8o5QW26sQjHlmN5Vzcsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMnxnwwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAE6C433F1;
	Sun, 24 Mar 2024 22:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321145;
	bh=tFj2kkXecT+l6596uU5LihaJJNQADvi51+t5Ax7Pvpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMnxnwwz5P9BLlCAsI5M3uafovU7GVoUKetDrun5L1O5UExruq68As/QsTITTeHyY
	 vMkt1oVE97IU1hgMEPhIrX6A4y5vOrjOvQDO4YAv67I6Jbu5w1QaGXSSjZ8IwIAjoK
	 je+KXnQzb5jz0HxVlvhrW55XhBhv1pAeB9ylX1vAnrY9Lqivq7NYOzjU0TP+kELSLR
	 MLH4hC6szw9WyAtyphMNaKQslww5Gr0BBWFg+WR4lAAe2ul5x7hDpF34teNxCL+KLM
	 S2mkRRJPT6JTuBbQyYoZh0ZH39+zyv3GzBXkVnsh0N1TrPij9MRKFkD7y829WKnNQ4
	 p8NLQMgQt4mag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 707/713] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
Date: Sun, 24 Mar 2024 18:47:13 -0400
Message-ID: <20240324224720.1345309-708-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 8d5d170d49cc4..109dac2e69df2 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -787,17 +787,19 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(host);
 
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
 
 		mtk_spi_enable_transfer(host);
-- 
2.43.0


