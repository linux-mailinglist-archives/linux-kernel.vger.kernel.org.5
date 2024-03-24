Return-Path: <linux-kernel+bounces-114479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949D6888AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C181F26685
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65B2863C2;
	Sun, 24 Mar 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7Mh6FT9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DF622289E;
	Sun, 24 Mar 2024 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321904; cv=none; b=PQBlUn6p9Z41HOrotnFXBG9+RxHncy9RATPtCphUHffeYBwxH4z1YMgxKldHu51Z0tKlQj+cxhNZ0em+Go1AlHfJ0ivLipIVInQZrpgBu0CfHcFhqY5lh3E5RoHqIQMMAPHtccIJvCyv9ZOXuVE2yRjhOtvdk8Fl+8G+//ZXlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321904; c=relaxed/simple;
	bh=Bdba+b5vVd/9U9IPqNb4dJUJzIpPU6qJZ7ufuwR2K9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy5BICkCgJrCNzEtDklkJafqac9C33oQgmH/oifRe7RLSuzyF0V1uSJ2hComK7TpXQ4jUsHqaUX/F1cQFrYrn9PC86lS9qkqAmPOW6wGdDa/D2Rx/6ZUlGiSBF1X4I+0uNpFi6ILsdsWroWb+98r4SBkdXwreG8mtZa/2xyGo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7Mh6FT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFF3C433C7;
	Sun, 24 Mar 2024 23:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321903;
	bh=Bdba+b5vVd/9U9IPqNb4dJUJzIpPU6qJZ7ufuwR2K9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W7Mh6FT9uDZ/Mm0AbG//1xVbB/SGOHRy+/KEKSM7hXZnKwnZrgL0GOdItb/tbOJan
	 eR6N8KmHVoiUVJfYBcUX0sOk9Q9lIdocv3O938j2COdx6VAy8FhVuDU93zWgyvSOcf
	 h9s1J4OV+Gthd0SPSeDUMSgzpd7/eIlph5YoiZJtOyy8zTeyoZGHh6qqbBS6cklpMc
	 CJKfNHZU/DUGGD5sY3AjZg2n723yD52AtfihLT+kJ3BAeBlz09FiuPp4kE7hLmrVPG
	 UwbPA56rcm6Tn8AY4RU7IFYoYZy+uRsPb6JVc9MYZiNdrshV7qkOqGh2eJNCSOaJEM
	 Ec2eG0OmqG2vQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 632/638] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
Date: Sun, 24 Mar 2024 19:01:09 -0400
Message-ID: <20240324230116.1348576-633-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 0757985947dd9..ea8e38bfa1746 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -787,17 +787,19 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
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


