Return-Path: <linux-kernel+bounces-113130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719088881B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C26828219F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9F4160873;
	Sun, 24 Mar 2024 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJp7UYrW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223315E5B7;
	Sun, 24 Mar 2024 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319937; cv=none; b=ZPJjB/eIQiAU73PlmhkJYAdX1xSrWLnl8PmTSwXr4HlY9sVY8pUdJngrO2S7CiTRQBlKY/T13xkkZnL9QyFgpxfm85QFKBY/M9phPMcr0MfQxxiPTX//nJpBUuDRsvh3csHY7NaQXPfS4MQngLe2k/anKcs3f4Tsea+d5dmqwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319937; c=relaxed/simple;
	bh=v/fESFmUSW40UM2hj5S3JboOxncvfxWDP/34gyFSfCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlKG2MHbH0+TEKOLlr1NaBVByqHd4qJtv0R7mjdYAkdbHBPc0Y5YUDJhf9hQVImIwOei/JGAZrbRNNln026FuXxWhiVoChenLhux0cf4vFiVPmXYVxPckoRT9bUESL5BWrV3JBdlaRDJBCwilapSiNelDgaki9qEJsrxdCZnxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJp7UYrW reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91B8C43394;
	Sun, 24 Mar 2024 22:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319937;
	bh=v/fESFmUSW40UM2hj5S3JboOxncvfxWDP/34gyFSfCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJp7UYrWfP7RyejAgJTBBCnGQoPcbdNTcPjjBf9P0czhjUh6P5XF8PO/uVPrRFF2L
	 lVbhxJM50nfvQHlxY4nbYmJDJE6h3jj6pvko4XG6sBpUV/u/ZwkNunxSQAcemMF4uB
	 jNoYGBxmhK+D/pLMk7SRxn987fDmvvOGafLoWe9pwtEDoW6Y9FpOFLlg6GaP2isQQM
	 Ql+qKoNH407GAPhFIgPiREc3LDxdRw2a/xfrPdRemoD7TN9pMhdiHQg5Qqt5MxzWRd
	 ut0N8NZ9WBvWPA+Sw9Q+SJXhywLgomkdMv8AYgHuGywYszojm9ytp0SxbFWQ0pwxdv
	 J21ezQeCFVg6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 243/715] wifi: mt76: mt7925: update PCIe DMA settings
Date: Sun, 24 Mar 2024 18:27:02 -0400
Message-ID: <20240324223455.1342824-244-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Deren Wu <deren.wu@mediatek.com>

[ Upstream commit 0844947ccf64ea45edf6619ae2ba6dd9098b3308 ]

Fix the wrong WFDMA settings to improve TX performance.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c  | 13 ++++++++++---
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h |  5 +++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 488326ce5ed4d..8fa36b59e738d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -123,14 +123,13 @@ static void mt792x_dma_prefetch(struct mt792x_dev *dev)
 
 int mt792x_dma_enable(struct mt792x_dev *dev)
 {
-	if (is_mt7925(&dev->mt76))
-		mt76_rmw(dev, MT_UWFDMA0_GLO_CFG_EXT1, BIT(28), BIT(28));
-
 	/* configure perfetch settings */
 	mt792x_dma_prefetch(dev);
 
 	/* reset dma idx */
 	mt76_wr(dev, MT_WFDMA0_RST_DTX_PTR, ~0);
+	if (is_mt7925(&dev->mt76))
+		mt76_wr(dev, MT_WFDMA0_RST_DRX_PTR, ~0);
 
 	/* configure delay interrupt */
 	mt76_wr(dev, MT_WFDMA0_PRI_DLY_INT_CFG0, 0);
@@ -140,12 +139,20 @@ int mt792x_dma_enable(struct mt792x_dev *dev)
 		 MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN |
 		 MT_WFDMA0_GLO_CFG_CLK_GAT_DIS |
 		 MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		 FIELD_PREP(MT_WFDMA0_GLO_CFG_DMA_SIZE, 3) |
+		 MT_WFDMA0_GLO_CFG_FIFO_DIS_CHECK |
+		 MT_WFDMA0_GLO_CFG_RX_WB_DDONE |
 		 MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
 		 MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
 
 	mt76_set(dev, MT_WFDMA0_GLO_CFG,
 		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
 
+	if (is_mt7925(&dev->mt76)) {
+		mt76_rmw(dev, MT_UWFDMA0_GLO_CFG_EXT1, BIT(28), BIT(28));
+		mt76_set(dev, MT_WFDMA0_INT_RX_PRI, 0x0F00);
+		mt76_set(dev, MT_WFDMA0_INT_TX_PRI, 0x7F00);
+	}
 	mt76_set(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 
 	/* enable interrupts for TX/RX rings */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index d7f9b24cd665f..458cfd0260b13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -292,9 +292,12 @@
 #define MT_WFDMA0_GLO_CFG_TX_DMA_BUSY	BIT(1)
 #define MT_WFDMA0_GLO_CFG_RX_DMA_EN	BIT(2)
 #define MT_WFDMA0_GLO_CFG_RX_DMA_BUSY	BIT(3)
+#define MT_WFDMA0_GLO_CFG_DMA_SIZE	GENMASK(5, 4)
 #define MT_WFDMA0_GLO_CFG_TX_WB_DDONE	BIT(6)
 #define MT_WFDMA0_GLO_CFG_FW_DWLD_BYPASS_DMASHDL BIT(9)
+#define MT_WFDMA0_GLO_CFG_FIFO_DIS_CHECK	BIT(11)
 #define MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
+#define MT_WFDMA0_GLO_CFG_RX_WB_DDONE	BIT(13)
 #define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
 #define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
@@ -322,6 +325,8 @@
 
 #define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
 #define MT_WFDMA0_RST_DRX_PTR		MT_WFDMA0(0x280)
+#define MT_WFDMA0_INT_RX_PRI		MT_WFDMA0(0x298)
+#define MT_WFDMA0_INT_TX_PRI		MT_WFDMA0(0x29c)
 #define MT_WFDMA0_GLO_CFG_EXT0		MT_WFDMA0(0x2b0)
 #define MT_WFDMA0_CSR_TX_DMASHDL_ENABLE	BIT(6)
 #define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
-- 
2.43.0


