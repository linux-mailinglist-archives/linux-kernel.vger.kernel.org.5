Return-Path: <linux-kernel+bounces-144858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC48A4BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C1B1F22ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91BE54FBB;
	Mon, 15 Apr 2024 09:48:33 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19444C61;
	Mon, 15 Apr 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174513; cv=none; b=fy7i7atGRN58q2GKwX7tYF2fVPLcbWbJuUhWm00+n3H++dj6Oec2IDj/Uk4f38BZX/vHl0tskKd4tSR69s4Iw+qu0egh409gQNiaxuWSq0Ae6B97qy4DzkZwK9QFMygb9G7p04tR6bHJPb9cYAyFMHC2U+dttukZFJD2ozDcrHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174513; c=relaxed/simple;
	bh=56LJgh0ds28jb8jSLNuLADKVWUY4cz3jIGos/B05xPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6Ym0hSS18UXIDVzKd+Xj3rid78kXWgF61UQUo6+YRCHv1LtLqTZgcDxP7wHH5DY9lHWgb1Fms8maK/5Hf2SPywYqcH9+wTmHCc3Q3RBmV3GHgjAIKvCUaeWkcOp8R/1GtgpTVHA0SrZtK2hHfBYd04F09gQAxc7AuQRsnl+oME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="scan'208";a="205432159"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2024 18:48:30 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.74])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C28254006DE8;
	Mon, 15 Apr 2024 18:48:26 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC v3 3/7] net: ravb: Refactor RX ring refill
Date: Mon, 15 Apr 2024 10:48:00 +0100
Message-Id: <20240415094804.8016-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reduce code duplication, we add a new RX ring refill function which
can handle both the initial RX ring population (which was split between
ravb_ring_init() and ravb_ring_format()) and the RX ring refill after
polling (in ravb_rx()).

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 141 +++++++++--------------
 1 file changed, 52 insertions(+), 89 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1ac599a044b2..baa01bd81f2d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -317,35 +317,42 @@ static void ravb_ring_free(struct net_device *ndev, int q)
 	priv->tx_skb[q] = NULL;
 }
 
-static void ravb_rx_ring_format(struct net_device *ndev, int q)
+static u32
+ravb_rx_ring_refill(struct net_device *ndev, int q, u32 count, gfp_t gfp_mask)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	struct ravb_rx_desc *rx_desc;
-	unsigned int rx_ring_size;
 	dma_addr_t dma_addr;
-	unsigned int i;
+	u32 i, entry;
 
-	rx_ring_size = priv->info->rx_desc_size * priv->num_rx_ring[q];
-	memset(priv->rx_ring[q].raw, 0, rx_ring_size);
-	/* Build RX ring buffer */
-	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		/* RX descriptor */
-		rx_desc = ravb_rx_get_desc(priv, q, i);
-		rx_desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
-		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
-					  priv->info->rx_max_frame_size,
-					  DMA_FROM_DEVICE);
-		/* We just set the data size to 0 for a failed mapping which
-		 * should prevent DMA from happening...
-		 */
-		if (dma_mapping_error(ndev->dev.parent, dma_addr))
-			rx_desc->ds_cc = cpu_to_le16(0);
-		rx_desc->dptr = cpu_to_le32(dma_addr);
+	for (i = 0; i < count; i++) {
+		entry = (priv->dirty_rx[q] + i) % priv->num_rx_ring[q];
+		rx_desc = ravb_rx_get_desc(priv, q, entry);
+		rx_desc->ds_cc = cpu_to_le16(info->rx_max_desc_use);
+
+		if (!priv->rx_skb[q][entry]) {
+			priv->rx_skb[q][entry] = ravb_alloc_skb(ndev, info, gfp_mask);
+			if (!priv->rx_skb[q][entry])
+				break;
+			dma_addr = dma_map_single(ndev->dev.parent,
+						  priv->rx_skb[q][entry]->data,
+						  priv->info->rx_max_frame_size,
+						  DMA_FROM_DEVICE);
+			skb_checksum_none_assert(priv->rx_skb[q][entry]);
+			/* We just set the data size to 0 for a failed mapping
+			 * which should prevent DMA from happening...
+			 */
+			if (dma_mapping_error(ndev->dev.parent, dma_addr))
+				rx_desc->ds_cc = cpu_to_le16(0);
+			rx_desc->dptr = cpu_to_le32(dma_addr);
+		}
+		/* Descriptor type must be set after all the above writes */
+		dma_wmb();
 		rx_desc->die_dt = DT_FEMPTY;
 	}
-	rx_desc = ravb_rx_get_desc(priv, q, i);
-	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
-	rx_desc->die_dt = DT_LINKFIX; /* type */
+
+	return i;
 }
 
 /* Format skb and descriptor buffer for Ethernet AVB */
@@ -353,6 +360,7 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned int num_tx_desc = priv->num_tx_desc;
+	struct ravb_rx_desc *rx_desc;
 	struct ravb_tx_desc *tx_desc;
 	struct ravb_desc *desc;
 	unsigned int tx_ring_size = sizeof(*tx_desc) * priv->num_tx_ring[q] *
@@ -364,8 +372,6 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 	priv->dirty_rx[q] = 0;
 	priv->dirty_tx[q] = 0;
 
-	ravb_rx_ring_format(ndev, q);
-
 	memset(priv->tx_ring[q], 0, tx_ring_size);
 	/* Build TX ring buffer */
 	for (i = 0, tx_desc = priv->tx_ring[q]; i < priv->num_tx_ring[q];
@@ -379,6 +385,14 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 	tx_desc->dptr = cpu_to_le32((u32)priv->tx_desc_dma[q]);
 	tx_desc->die_dt = DT_LINKFIX; /* type */
 
+	/* Regular RX descriptors have already been initialized by
+	 * ravb_rx_ring_refill(), we just need to initialize the final link
+	 * descriptor.
+	 */
+	rx_desc = ravb_rx_get_desc(priv, q, priv->num_rx_ring[q]);
+	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
+	rx_desc->die_dt = DT_LINKFIX; /* type */
+
 	/* RX descriptor base address for best effort */
 	desc = &priv->desc_bat[RX_QUEUE_OFFSET + q];
 	desc->die_dt = DT_LINKFIX; /* type */
@@ -408,11 +422,9 @@ static void *ravb_alloc_rx_desc(struct net_device *ndev, int q)
 static int ravb_ring_init(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	unsigned int num_tx_desc = priv->num_tx_desc;
 	unsigned int ring_size;
-	struct sk_buff *skb;
-	unsigned int i;
+	u32 num_filled;
 
 	/* Allocate RX and TX skb rings */
 	priv->rx_skb[q] = kcalloc(priv->num_rx_ring[q],
@@ -422,13 +434,6 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 	if (!priv->rx_skb[q] || !priv->tx_skb[q])
 		goto error;
 
-	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		skb = ravb_alloc_skb(ndev, info, GFP_KERNEL);
-		if (!skb)
-			goto error;
-		priv->rx_skb[q][i] = skb;
-	}
-
 	if (num_tx_desc > 1) {
 		/* Allocate rings for the aligned buffers */
 		priv->tx_align[q] = kmalloc(DPTR_ALIGN * priv->num_tx_ring[q] +
@@ -443,6 +448,13 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 
 	priv->dirty_rx[q] = 0;
 
+	/* Populate RX ring buffer. */
+	ring_size = priv->info->rx_desc_size * priv->num_rx_ring[q];
+	memset(priv->rx_ring[q].raw, 0, ring_size);
+	num_filled = ravb_rx_ring_refill(ndev, q, priv->num_rx_ring[q], GFP_KERNEL);
+	if (num_filled != priv->num_rx_ring[q])
+		goto error;
+
 	/* Allocate all TX descriptors. */
 	ring_size = sizeof(struct ravb_tx_desc) *
 		    (priv->num_tx_ring[q] * num_tx_desc + 1);
@@ -762,11 +774,9 @@ static struct sk_buff *ravb_get_skb_gbeth(struct net_device *ndev, int entry,
 static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	struct net_device_stats *stats;
 	struct ravb_rx_desc *desc;
 	struct sk_buff *skb;
-	dma_addr_t dma_addr;
 	int rx_packets = 0;
 	u8  desc_status;
 	u16 desc_len;
@@ -854,32 +864,9 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 	}
 
 	/* Refill the RX ring buffers. */
-	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
-		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q].desc[entry];
-		desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
-
-		if (!priv->rx_skb[q][entry]) {
-			skb = ravb_alloc_skb(ndev, info, GFP_ATOMIC);
-			if (!skb)
-				break;
-			dma_addr = dma_map_single(ndev->dev.parent,
-						  skb->data,
-						  priv->info->rx_max_frame_size,
-						  DMA_FROM_DEVICE);
-			skb_checksum_none_assert(skb);
-			/* We just set the data size to 0 for a failed mapping
-			 * which should prevent DMA  from happening...
-			 */
-			if (dma_mapping_error(ndev->dev.parent, dma_addr))
-				desc->ds_cc = cpu_to_le16(0);
-			desc->dptr = cpu_to_le32(dma_addr);
-			priv->rx_skb[q][entry] = skb;
-		}
-		/* Descriptor type must be set after all the above writes */
-		dma_wmb();
-		desc->die_dt = DT_FEMPTY;
-	}
+	priv->dirty_rx[q] += ravb_rx_ring_refill(ndev, q,
+						 priv->cur_rx[q] - priv->dirty_rx[q],
+						 GFP_ATOMIC);
 
 	return rx_packets;
 }
@@ -888,11 +875,9 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	struct net_device_stats *stats = &priv->stats[q];
 	struct ravb_ex_rx_desc *desc;
 	struct sk_buff *skb;
-	dma_addr_t dma_addr;
 	struct timespec64 ts;
 	int rx_packets = 0;
 	u8  desc_status;
@@ -964,31 +949,9 @@ static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
 	}
 
 	/* Refill the RX ring buffers. */
-	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
-		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q].ex_desc[entry];
-		desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
-
-		if (!priv->rx_skb[q][entry]) {
-			skb = ravb_alloc_skb(ndev, info, GFP_ATOMIC);
-			if (!skb)
-				break;	/* Better luck next round. */
-			dma_addr = dma_map_single(ndev->dev.parent, skb->data,
-						  priv->info->rx_max_frame_size,
-						  DMA_FROM_DEVICE);
-			skb_checksum_none_assert(skb);
-			/* We just set the data size to 0 for a failed mapping
-			 * which should prevent DMA  from happening...
-			 */
-			if (dma_mapping_error(ndev->dev.parent, dma_addr))
-				desc->ds_cc = cpu_to_le16(0);
-			desc->dptr = cpu_to_le32(dma_addr);
-			priv->rx_skb[q][entry] = skb;
-		}
-		/* Descriptor type must be set after all the above writes */
-		dma_wmb();
-		desc->die_dt = DT_FEMPTY;
-	}
+	priv->dirty_rx[q] += ravb_rx_ring_refill(ndev, q,
+						 priv->cur_rx[q] - priv->dirty_rx[q],
+						 GFP_ATOMIC);
 
 	return rx_packets;
 }
-- 
2.39.2


