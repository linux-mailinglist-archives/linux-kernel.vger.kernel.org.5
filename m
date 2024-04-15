Return-Path: <linux-kernel+bounces-144856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 435FA8A4BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1ED31F22CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6E74D133;
	Mon, 15 Apr 2024 09:48:25 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3184BA94;
	Mon, 15 Apr 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174505; cv=none; b=ld8znIbF+akuHqBrRFdeHLsNOrRCEuOx+6TwQr0Gr6BIy7vjEPWDOmcIGBvMgDMtIlaz+tDox5IRbwPxO9vipCNv5iud5ebNN/w4RaGkg4dXnXoCIKHA0Fcx7MhNEX+WHVcBIErfDLNRx8OrPfODG/ArWpIVtF5/ZTqNT4LB6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174505; c=relaxed/simple;
	bh=7nhUt6O4iAUVzanmrs0yvjSNUnYqMNXljpHT9AbtBFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGXitvKXEsUnw8dyTNhFgOj9dVh7eUVgjzlXnLP9Imi6OsUOx8bCp2yjNpM3s8H6WPonir6ps6WQHKrek4QtdJI1Q0KFECiRqdcuNc9vCboI1BlZepj9jgR9/sjVlir4yItmdwmRB+95JbxB82hdlCUVk0nOZVpQ3hXMgZQsmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="scan'208";a="205432152"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2024 18:48:21 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.74])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E98E84006DE8;
	Mon, 15 Apr 2024 18:48:17 +0900 (JST)
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
Subject: [net-next RFC v3 1/7] net: ravb: Simplify poll & receive functions
Date: Mon, 15 Apr 2024 10:47:58 +0100
Message-Id: <20240415094804.8016-2-paul.barker.ct@bp.renesas.com>
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

We don't need to pass the work budget to ravb_rx() by reference, it's
cleaner to pass this by value and return the amount of work done. This
allows us to simplify the ravb_poll() function and use the common
`work_done` variable name seen in other network drivers for consistency
and ease of understanding.

This is a pure refactor and should not affect behaviour.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 29 ++++++++++--------------
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b48935ec7e28..71de2a7aa27c 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1039,7 +1039,7 @@ struct ravb_ptp {
 };
 
 struct ravb_hw_info {
-	bool (*receive)(struct net_device *ndev, int *quota, int q);
+	int (*receive)(struct net_device *ndev, int budget, int q);
 	void (*set_rate)(struct net_device *ndev);
 	int (*set_feature)(struct net_device *ndev, netdev_features_t features);
 	int (*dmac_init)(struct net_device *ndev);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index fd2679ce4e3d..33f8043143c1 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -759,7 +759,7 @@ static struct sk_buff *ravb_get_skb_gbeth(struct net_device *ndev, int entry,
 }
 
 /* Packet receive function for Gigabit Ethernet */
-static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
+static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
@@ -778,7 +778,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
-	for (i = 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]++) {
+	for (i = 0; i < limit && rx_packets < budget; i++, priv->cur_rx[q]++) {
 		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
 		desc = &priv->rx_ring[q].desc[entry];
 		if (desc->die_dt == DT_FEMPTY)
@@ -881,13 +881,11 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 		desc->die_dt = DT_FEMPTY;
 	}
 
-	stats->rx_packets += rx_packets;
-	*quota -= rx_packets;
-	return *quota == 0;
+	return rx_packets;
 }
 
 /* Packet receive function for Ethernet AVB */
-static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
+static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
@@ -904,7 +902,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	int i;
 
 	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
-	for (i = 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]++) {
+	for (i = 0; i < limit && rx_packets < budget; i++, priv->cur_rx[q]++) {
 		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
 		desc = &priv->rx_ring[q].ex_desc[entry];
 		if (desc->die_dt == DT_FEMPTY)
@@ -992,18 +990,16 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 		desc->die_dt = DT_FEMPTY;
 	}
 
-	stats->rx_packets += rx_packets;
-	*quota -= rx_packets;
-	return *quota == 0;
+	return rx_packets;
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
@@ -1320,13 +1316,12 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
-	int quota = budget;
-	bool unmask;
+	int work_done;
 
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	unmask = !ravb_rx(ndev, &quota, q);
+	work_done = ravb_rx(ndev, budget, q);
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -1345,7 +1340,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
 		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
 
-	if (!unmask)
+	if (work_done == budget)
 		goto out;
 
 	napi_complete(napi);
@@ -1362,7 +1357,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 out:
-	return budget - quota;
+	return work_done;
 }
 
 static void ravb_set_duplex_gbeth(struct net_device *ndev)
-- 
2.39.2


