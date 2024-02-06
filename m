Return-Path: <linux-kernel+bounces-54570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED1784B0E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784BF1F23721
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0A12D755;
	Tue,  6 Feb 2024 09:19:32 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8512D173;
	Tue,  6 Feb 2024 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211171; cv=none; b=qtziCZTA3Z9+2pk8YbWNiO2JqmOy37g0s6n8SWp7LiScx1tXP5IRR+tQnFYX9uvH8lgpYcmaa0AR3/L25d6sFv9r1C+jF9GwQ3Y7xQnAzOZoOqgCABDWezBs5seShLJL4v9JN1houzTRUqJz80/cGqGAHkpydlyr5+8v6OJzvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211171; c=relaxed/simple;
	bh=C1SY0L5Dc5UjHfx9zo6gwJom7EBMAwYl8y/Lr3H2wDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZpCxpbsj1rDDKTFMPU11AmDJ/7bOojRsBOE1rNCw7HnPnfLq2/irG9qw2/aC47DOKAcSt+MAiQtsfwv0wJ858HVBTSqTehQafMAOc35fgNHhFj/yz0LbQRh7NmKU05EEgRRrZ3Eb78UkHOu9pWvQpkKqrP2drelrZW37PhbHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,246,1701097200"; 
   d="scan'208";a="196934614"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Feb 2024 18:19:22 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8206B41B86C7;
	Tue,  6 Feb 2024 18:19:18 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v2 1/7] net: ravb: Simplify poll & receive functions
Date: Tue,  6 Feb 2024 09:19:03 +0000
Message-Id: <20240206091909.3191-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
References: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to pass the work budget to ravb_rx() by reference, it's
cleaner to pass this by value and return the amount of work done. This
allows us to simplify the ravb_poll() function and use the common
`work_done` variable name seen in other network drivers for consistency
and ease of understanding.

In ravb_rx_gbeth() & ravb_rx_rcar(), we can also drop the confusingly
named `boguscnt` variable and use a for loop to iterate through
descriptors.

This is a pure refactor and should not affect behaviour.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 47 +++++++++---------------
 2 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 3cf869fb9a68..55a7a08aabef 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1050,7 +1050,7 @@ struct ravb_hw_info {
 	void (*rx_ring_free)(struct net_device *ndev, int q);
 	void (*rx_ring_format)(struct net_device *ndev, int q);
 	void *(*alloc_rx_desc)(struct net_device *ndev, int q);
-	bool (*receive)(struct net_device *ndev, int *quota, int q);
+	int (*receive)(struct net_device *ndev, int budget, int q);
 	void (*set_rate)(struct net_device *ndev);
 	int (*set_feature)(struct net_device *ndev, netdev_features_t features);
 	int (*dmac_init)(struct net_device *ndev);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4976ecc91cde..b18026575a2d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -822,7 +822,7 @@ static struct sk_buff *ravb_get_skb_gbeth(struct net_device *ndev, int entry,
 }
 
 /* Packet receive function for Gigabit Ethernet */
-static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
+static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
@@ -831,28 +831,24 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
 	u8  desc_status;
-	int boguscnt;
 	u16 pkt_len;
 	u8  die_dt;
 	int entry;
 	int limit;
+	int i;
 
 	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-	boguscnt = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
+	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
-	boguscnt = min(boguscnt, *quota);
-	limit = boguscnt;
+	limit = min(limit, budget);
 	desc = &priv->gbeth_rx_ring[entry];
-	while (desc->die_dt != DT_FEMPTY) {
+	for (i = 0; i < limit && desc->die_dt != DT_FEMPTY; i++) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
 		pkt_len = le16_to_cpu(desc->ds_cc) & RX_DS;
 
-		if (--boguscnt < 0)
-			break;
-
 		/* We use 0-byte descriptors to mark the DMA mapping errors */
 		if (!pkt_len)
 			continue;
@@ -949,19 +945,16 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 		desc->die_dt = DT_FEMPTY;
 	}
 
-	*quota -= limit - (++boguscnt);
-
-	return boguscnt <= 0;
+	return i;
 }
 
 /* Packet receive function for Ethernet AVB */
-static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
+static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	int entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-	int boguscnt = (priv->dirty_rx[q] + priv->num_rx_ring[q]) -
-			priv->cur_rx[q];
+	int limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	struct net_device_stats *stats = &priv->stats[q];
 	struct ravb_ex_rx_desc *desc;
 	struct sk_buff *skb;
@@ -970,19 +963,16 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	u8  desc_status;
 	u16 pkt_len;
 	int limit;
+	int i;
 
-	boguscnt = min(boguscnt, *quota);
-	limit = boguscnt;
+	limit = min(limit, budget);
 	desc = &priv->rx_ring[q][entry];
-	while (desc->die_dt != DT_FEMPTY) {
+	for (i = 0; i < limit && desc->die_dt != DT_FEMPTY; i++) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
 		pkt_len = le16_to_cpu(desc->ds_cc) & RX_DS;
 
-		if (--boguscnt < 0)
-			break;
-
 		/* We use 0-byte descriptors to mark the DMA mapping errors */
 		if (!pkt_len)
 			continue;
@@ -1064,18 +1054,16 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 		desc->die_dt = DT_FEMPTY;
 	}
 
-	*quota -= limit - (++boguscnt);
-
-	return boguscnt <= 0;
+	return i;
 }
 
 /* Packet receive function for Ethernet AVB */
-static bool ravb_rx(struct net_device *ndev, int *quota, int q)
+static int ravb_rx(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 
-	return info->receive(ndev, quota, q);
+	return info->receive(ndev, budget, q);
 }
 
 static void ravb_rcv_snd_disable(struct net_device *ndev)
@@ -1353,12 +1341,13 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
-	int quota = budget;
+	int work_done;
 
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (ravb_rx(ndev, &quota, q))
+	work_done = ravb_rx(ndev, budget, q);
+	if (work_done == budget)
 		goto out;
 
 	/* Processing TX Descriptor Ring */
@@ -1391,7 +1380,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
 		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
 out:
-	return budget - quota;
+	return work_done;
 }
 
 static void ravb_set_duplex_gbeth(struct net_device *ndev)
-- 
2.39.2


