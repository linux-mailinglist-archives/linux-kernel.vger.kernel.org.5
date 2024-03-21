Return-Path: <linux-kernel+bounces-109720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BB2881CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE1C1C20ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AD9524B8;
	Thu, 21 Mar 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YmoCEUNX"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEA3A1DE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005321; cv=none; b=SBa3D3GUc0d6zjixLJc8vYnuZV7yUMg+J+63kvQhgRnxqrlztz5xtWS1diUhzWv44ISJy3LvzN6A2R6/wzEhZjx5TUPHMinOq1kf3JjVlPWUaq9DsTGMG5ridRfnRt45bdgGIi/AfVEe7ixsARFhvPxoKIfdnmklY9VWbqkWEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005321; c=relaxed/simple;
	bh=qN167YbicTtxBH0X94nItJpPsdy2kwXk0SkOGtrqkz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEwe4febwXkd40l46Q901c1d91Ca0sJoS2Lzyhe9anFemy2bVUVh8iClvpf8L8i8MJ9ZK5FNWNzEN7Dw+9TPPhTnufeSYfB1+Y/YU9UI7ycSVkyZE81obtEogmFm2jD2SEZPYBOYi7Jv0X4wBeADsg7VtLMaVY2QoQMb+rEPNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YmoCEUNX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6965878603cso1102036d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711005318; x=1711610118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSVRkP1CEN/2Cgd43eVZqXzzvCIz80rEAhuUK1PkoaA=;
        b=YmoCEUNXNCNOX0fwjaHTetZlDAXRhd+BTMXY/fDX88/Znqzx3+xPerx3Xafab+Ak8e
         oItB8ZPD2a3sMqXPb3zOpKkpXftep86dTNk5M4JlfGILBbQTbNObzWWnkuussgCkPG5E
         SRjZXV+jlzsFsbEdB0+dxjxwxG0ukPCJLVx1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711005318; x=1711610118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSVRkP1CEN/2Cgd43eVZqXzzvCIz80rEAhuUK1PkoaA=;
        b=ESR7XW33/wlfwOxC2zHTFWIlCqqaObSLyqpxdc8G3reWAtXCpXCsadL0hEGNH5ceiQ
         LJPvr8WdvvfaF8T5/cUILgYWYxgm6qUK0UEqBlFzJDApnXvDFjsCJwzEAqA/VTLHrawG
         oxFvNX3T87Z4lE6omcYjaIN9a2Hqify9tQ2XkwhDwiV7oc2GXm/zMyH6OozgeIfV7axc
         G2ALlgh3W/z5dUHxaV9Ye+nW4ds0pWr14wpzeAIHpMKottnMsgJxdurMSQAi//OHA95D
         qG7xdEjZ0ZnhkQAUhMb6tR1lLn14XwKSY7uL/yE1TRVsNCjA5vrrDu+dBct8AY7qENOi
         hvlA==
X-Forwarded-Encrypted: i=1; AJvYcCWNB2XZ5PZqlVfNXihP2Lcwco7xQMCEV3I9/6w6AsvqT/cX8+ZXntDxO1nlba/0UMHHvcv8yt1hHPydOtQRPXnGwjnePodiulmFRBOl
X-Gm-Message-State: AOJu0YxsEK5wduRspl6tEEZFZIy0lQZ6LL5eXyPcEMrlcjC4uKXTvGA6
	f0MTtuaByBpefTfECoj3ITXkI7XK6ndaCa0R3f3EQgryjjkYSwY4qxAQjmqtaVUOOZ8lw3xFE7l
	Qcg==
X-Google-Smtp-Source: AGHT+IE7zDY2bPbXvYy4oPA05ILy81XLNYUL1pNTca/VSSwS1G6IzocntbS/L6V+8RGTtIae+u5dmw==
X-Received: by 2002:a05:6a21:3396:b0:1a1:87b5:298b with SMTP id yy22-20020a056a21339600b001a187b5298bmr1341758pzb.21.1711004993178;
        Thu, 21 Mar 2024 00:09:53 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:c1ff:a4cf:ac35:8df6])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001dbcfb4766csm8705582plg.226.2024.03.21.00.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:09:52 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 2/2] spi: spi-mt65xx: Rename a variable in interrupt handler
Date: Thu, 21 Mar 2024 15:08:58 +0800
Message-ID: <20240321070942.1587146-3-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240321070942.1587146-1-fshao@chromium.org>
References: <20240321070942.1587146-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the spi_transfer variables in this file use the name "xfer" except
the one in mtk_spi_interrupt(). Align the naming for consistency and
easier searching.

While at it, reformat one memcpy() usage since the coding style allows
100 column lines today.

This commit has no functional change.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 drivers/spi/spi-mt65xx.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index e4cb22fe0075..36c2f52cd6b8 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -748,7 +748,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	u32 cmd, reg_val, cnt, remainder, len;
 	struct spi_controller *host = dev_id;
 	struct mtk_spi *mdata = spi_controller_get_devdata(host);
-	struct spi_transfer *trans = mdata->cur_transfer;
+	struct spi_transfer *xfer = mdata->cur_transfer;
 
 	reg_val = readl(mdata->base + SPI_STATUS0_REG);
 	if (reg_val & MTK_SPI_PAUSE_INT_STATUS)
@@ -762,42 +762,40 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	if (!host->can_dma(host, NULL, trans)) {
-		if (trans->rx_buf) {
+	if (!host->can_dma(host, NULL, xfer)) {
+		if (xfer->rx_buf) {
 			cnt = mdata->xfer_len / 4;
 			ioread32_rep(mdata->base + SPI_RX_DATA_REG,
-				     trans->rx_buf + mdata->num_xfered, cnt);
+				     xfer->rx_buf + mdata->num_xfered, cnt);
 			remainder = mdata->xfer_len % 4;
 			if (remainder > 0) {
 				reg_val = readl(mdata->base + SPI_RX_DATA_REG);
-				memcpy(trans->rx_buf +
-					mdata->num_xfered +
-					(cnt * 4),
+				memcpy(xfer->rx_buf + (cnt * 4) + mdata->num_xfered,
 					&reg_val,
 					remainder);
 			}
 		}
 
 		mdata->num_xfered += mdata->xfer_len;
-		if (mdata->num_xfered == trans->len) {
+		if (mdata->num_xfered == xfer->len) {
 			spi_finalize_current_transfer(host);
 			return IRQ_HANDLED;
 		}
 
-		len = trans->len - mdata->num_xfered;
+		len = xfer->len - mdata->num_xfered;
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(host);
 
-		if (trans->tx_buf) {
+		if (xfer->tx_buf) {
 			cnt = mdata->xfer_len / 4;
 			iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
-					trans->tx_buf + mdata->num_xfered, cnt);
+					xfer->tx_buf + mdata->num_xfered, cnt);
 
 			remainder = mdata->xfer_len % 4;
 			if (remainder > 0) {
 				reg_val = 0;
 				memcpy(&reg_val,
-					trans->tx_buf + (cnt * 4) + mdata->num_xfered,
+					xfer->tx_buf + (cnt * 4) + mdata->num_xfered,
 					remainder);
 				writel(reg_val, mdata->base + SPI_TX_DATA_REG);
 			}
@@ -809,21 +807,21 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	}
 
 	if (mdata->tx_sgl)
-		trans->tx_dma += mdata->xfer_len;
+		xfer->tx_dma += mdata->xfer_len;
 	if (mdata->rx_sgl)
-		trans->rx_dma += mdata->xfer_len;
+		xfer->rx_dma += mdata->xfer_len;
 
 	if (mdata->tx_sgl && (mdata->tx_sgl_len == 0)) {
 		mdata->tx_sgl = sg_next(mdata->tx_sgl);
 		if (mdata->tx_sgl) {
-			trans->tx_dma = sg_dma_address(mdata->tx_sgl);
+			xfer->tx_dma = sg_dma_address(mdata->tx_sgl);
 			mdata->tx_sgl_len = sg_dma_len(mdata->tx_sgl);
 		}
 	}
 	if (mdata->rx_sgl && (mdata->rx_sgl_len == 0)) {
 		mdata->rx_sgl = sg_next(mdata->rx_sgl);
 		if (mdata->rx_sgl) {
-			trans->rx_dma = sg_dma_address(mdata->rx_sgl);
+			xfer->rx_dma = sg_dma_address(mdata->rx_sgl);
 			mdata->rx_sgl_len = sg_dma_len(mdata->rx_sgl);
 		}
 	}
@@ -841,7 +839,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 
 	mtk_spi_update_mdata_len(host);
 	mtk_spi_setup_packet(host);
-	mtk_spi_setup_dma_addr(host, trans);
+	mtk_spi_setup_dma_addr(host, xfer);
 	mtk_spi_enable_transfer(host);
 
 	return IRQ_HANDLED;
-- 
2.44.0.396.g6e790dbe36-goog


