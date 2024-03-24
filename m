Return-Path: <linux-kernel+bounces-115484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A3A889BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5AC1F34EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DDF22C65A;
	Mon, 25 Mar 2024 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSIvHMr7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC31DD2DF;
	Sun, 24 Mar 2024 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320730; cv=none; b=s5/Ng4bq2a9RocwSQLszS4hpgjPn0RXb9kL4U6bQR+1ADsGSczjWLyTYZmZaWAB56QNsYQiZ7UILE/QW6gTy1KdKepbVO8kJPyULSJEfGSCB3zgbJyUNHFyqR3ggT82y/bFg21rv2wRd5vEcEsryTWGIRiFje2Hf6FzxkZs0be8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320730; c=relaxed/simple;
	bh=v/fESFmUSW40UM2hj5S3JboOxncvfxWDP/34gyFSfCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uevon26qrrRoNrpPIUYjrVPKVZifsdwslCg2mczldQaxqWo/y9Vx0jCEYeGWWwsbX0blPo60lfQfToTqhqbghKc115KSAwSOyPC9fp4u1/EfNl37HWRiGxWaCpKFH7reXvAxLZvk11uruO4fNv9c0saeHJZWphkUmLLKZH8aWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSIvHMr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2FFC433C7;
	Sun, 24 Mar 2024 22:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320729;
	bh=v/fESFmUSW40UM2hj5S3JboOxncvfxWDP/34gyFSfCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSIvHMr7wkxmtcwG8MCgDQbypkqe9ockD+NHzoHmfjZYyPupVT/Mlu1MKBjmkP3xM
	 btodU8YhsqQwqYn0O1fsskyVS+o1BLiInhdr/xzHNINiAygLXf9ExqR4ElZ0Fxalgi
	 p+jp3I8KKUd1pmPumzNdXNbYyMxHFYJJzUmBXwszBONFIaciQxy/JJDaUIuQrq11dy
	 B3P7nhya0H+egFPMKZpXB1qYSvlMYbOD8Lcldej7T47GwfsFjGAxrgAevEbVtmNNHW
	 4tNt7A258yAsw67JfV6MgYmT9VcM+NigF4eCt/eFvfgV8/XPKVP0mqzWkcnRvseIn6
	 qViBoeWPGQBHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 292/713] wifi: mt76: mt7925: update PCIe DMA settings
Date: Sun, 24 Mar 2024 18:40:18 -0400
Message-ID: <20240324224720.1345309-293-sashal@kernel.org>
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


