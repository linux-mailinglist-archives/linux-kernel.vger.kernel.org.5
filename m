Return-Path: <linux-kernel+bounces-46863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB484458F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32790297F52
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D112DD88;
	Wed, 31 Jan 2024 17:05:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A412C54B;
	Wed, 31 Jan 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720758; cv=none; b=Ad1q3MpM4XBptrUPj2FzQZLaOXndOozMIKULN4oI0Z+SJ3FTJm8tE2pD9CvHvs4/HufjO8ksV0uoCipk9XGM0ksv6voY3PwP7cEnW/IuXBRKubBeZP0bP3zUL6aj3EEWrX+U86Ck7vQ77COtHzSVIZ1sshVEUVKSpRrxPL3H7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720758; c=relaxed/simple;
	bh=O3JgQWQjXJLciyc2HaqxwHx7NmFu6s1KXH6/DXjbg0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qURtoawAvZAw4fKgMA+2hbR/wWjIjp/pR195HNvaiAEJPSdmVYgiIUE7vHzFDCv4M5iJoLIhdzgOtuWR6KUXZKHYPUZCKer+okS41/fWbPHAYg8SWBGTSvTb/FyH6NIX6daT9sE7d2IVcfakH5oToUYsnYfSPjxSGLC8m4g/RgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="196315518"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Feb 2024 02:05:50 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.158])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EA4CB40344F5;
	Thu,  1 Feb 2024 02:05:46 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/8] net: ravb: Split R-Car & GbEth poll functions
Date: Wed, 31 Jan 2024 17:05:15 +0000
Message-Id: <20240131170523.30048-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131170523.30048-1-paul.barker.ct@bp.renesas.com>
References: <20240131170523.30048-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows us to optimise polling and receive processing for the GbEth
IP used in the RZ/G2L Soc family, without affecting the wider family of
R-Car based devices.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 74 ++++++++++++++++++------
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 3cf869fb9a68..9e9cf0d36d72 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1050,7 +1050,7 @@ struct ravb_hw_info {
 	void (*rx_ring_free)(struct net_device *ndev, int q);
 	void (*rx_ring_format)(struct net_device *ndev, int q);
 	void *(*alloc_rx_desc)(struct net_device *ndev, int q);
-	bool (*receive)(struct net_device *ndev, int *quota, int q);
+	int (*poll)(struct napi_struct *napi, int budget);
 	void (*set_rate)(struct net_device *ndev);
 	int (*set_feature)(struct net_device *ndev, netdev_features_t features);
 	int (*dmac_init)(struct net_device *ndev);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4976ecc91cde..c9464c1731b4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1069,15 +1069,6 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	return boguscnt <= 0;
 }
 
-/* Packet receive function for Ethernet AVB */
-static bool ravb_rx(struct net_device *ndev, int *quota, int q)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
-
-	return info->receive(ndev, quota, q);
-}
-
 static void ravb_rcv_snd_disable(struct net_device *ndev)
 {
 	/* Disable TX and RX */
@@ -1345,7 +1336,56 @@ static irqreturn_t ravb_nc_interrupt(int irq, void *dev_id)
 	return ravb_dma_interrupt(irq, dev_id, RAVB_NC);
 }
 
-static int ravb_poll(struct napi_struct *napi, int budget)
+static int ravb_poll_gbeth(struct napi_struct *napi, int budget)
+{
+	struct net_device *ndev = napi->dev;
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+	unsigned long flags;
+	int q = napi - priv->napi;
+	int mask = BIT(q);
+	int quota = budget;
+
+	/* Processing RX Descriptor Ring */
+	/* Clear RX interrupt */
+	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
+	if (ravb_rx_gbeth(ndev, &quota, q))
+		goto out;
+
+	/* Processing TX Descriptor Ring */
+	spin_lock_irqsave(&priv->lock, flags);
+	/* Clear TX interrupt */
+	ravb_write(ndev, ~(mask | TIS_RESERVED), TIS);
+	ravb_tx_free(ndev, q, true);
+	netif_wake_subqueue(ndev, q);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	napi_complete(napi);
+
+	/* Re-enable RX/TX interrupts */
+	spin_lock_irqsave(&priv->lock, flags);
+	if (!info->irq_en_dis) {
+		ravb_modify(ndev, RIC0, mask, mask);
+		ravb_modify(ndev, TIC,  mask, mask);
+	} else {
+		ravb_write(ndev, mask, RIE0);
+		ravb_write(ndev, mask, TIE);
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	/* Receive error message handling */
+	priv->rx_over_errors =  priv->stats[RAVB_BE].rx_over_errors;
+	if (info->nc_queues)
+		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
+	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
+		ndev->stats.rx_over_errors = priv->rx_over_errors;
+	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
+		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
+out:
+	return budget - quota;
+}
+
+static int ravb_poll_rcar(struct napi_struct *napi, int budget)
 {
 	struct net_device *ndev = napi->dev;
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -1358,7 +1398,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (ravb_rx(ndev, &quota, q))
+	if (ravb_rx_rcar(ndev, &quota, q))
 		goto out;
 
 	/* Processing TX Descriptor Ring */
@@ -2559,7 +2599,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.rx_ring_free = ravb_rx_ring_free_rcar,
 	.rx_ring_format = ravb_rx_ring_format_rcar,
 	.alloc_rx_desc = ravb_alloc_rx_desc_rcar,
-	.receive = ravb_rx_rcar,
+	.poll = ravb_poll_rcar,
 	.set_rate = ravb_set_rate_rcar,
 	.set_feature = ravb_set_features_rcar,
 	.dmac_init = ravb_dmac_init_rcar,
@@ -2585,7 +2625,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.rx_ring_free = ravb_rx_ring_free_rcar,
 	.rx_ring_format = ravb_rx_ring_format_rcar,
 	.alloc_rx_desc = ravb_alloc_rx_desc_rcar,
-	.receive = ravb_rx_rcar,
+	.poll = ravb_poll_rcar,
 	.set_rate = ravb_set_rate_rcar,
 	.set_feature = ravb_set_features_rcar,
 	.dmac_init = ravb_dmac_init_rcar,
@@ -2608,7 +2648,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.rx_ring_free = ravb_rx_ring_free_rcar,
 	.rx_ring_format = ravb_rx_ring_format_rcar,
 	.alloc_rx_desc = ravb_alloc_rx_desc_rcar,
-	.receive = ravb_rx_rcar,
+	.poll = ravb_poll_rcar,
 	.set_rate = ravb_set_rate_rcar,
 	.set_feature = ravb_set_features_rcar,
 	.dmac_init = ravb_dmac_init_rcar,
@@ -2633,7 +2673,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.rx_ring_free = ravb_rx_ring_free_gbeth,
 	.rx_ring_format = ravb_rx_ring_format_gbeth,
 	.alloc_rx_desc = ravb_alloc_rx_desc_gbeth,
-	.receive = ravb_rx_gbeth,
+	.poll = ravb_poll_gbeth,
 	.set_rate = ravb_set_rate_gbeth,
 	.set_feature = ravb_set_features_gbeth,
 	.dmac_init = ravb_dmac_init_gbeth,
@@ -2990,9 +3030,9 @@ static int ravb_probe(struct platform_device *pdev)
 		goto out_dma_free;
 	}
 
-	netif_napi_add(ndev, &priv->napi[RAVB_BE], ravb_poll);
+	netif_napi_add(ndev, &priv->napi[RAVB_BE], info->poll);
 	if (info->nc_queues)
-		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
+		netif_napi_add(ndev, &priv->napi[RAVB_NC], info->poll);
 
 	/* Network device register */
 	error = register_netdev(ndev);
-- 
2.39.2


