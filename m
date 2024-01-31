Return-Path: <linux-kernel+bounces-46865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A74D844595
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96AE284856
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6D012F5AF;
	Wed, 31 Jan 2024 17:06:03 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F2212C54B;
	Wed, 31 Jan 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720763; cv=none; b=AtufSdndp6l9i5r5gQavEKklXszUJ7oidqFxo/CtlnOMWk3y/0QWZZhDH/CJ0TKsPr/jFV3DSjp5UO4GQo7cWbt0xaZNr/cHq8Kup0nfktEPChFJj9yiW7EwA/wlskcrTcFkw9ryv6eUHAIJG2LcHwNuXaaPuiBoBobzGrA11rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720763; c=relaxed/simple;
	bh=Xm80ToVUWKO7Ssi3UnhJlGbnKtKdlIZTdxjYk0JSBdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ktrq3fxNTzsJ2/lH4HXCc6PUNP0XH4v4bh5z2VxPmaFsbtj8rPBhKQPQ4K79wsyms6JbDgA0vCZAEipS1MWEH7gFn2DV+WnwFl+cR0fD3dyLUFBMWXK5fNpDFhIXI0JuqrtUmR/2UrThLlkgnkk/4ckKhDmEVWuay6AmwmW9Zcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="192404880"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Feb 2024 02:05:54 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.158])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1F16940344F5;
	Thu,  1 Feb 2024 02:05:50 +0900 (JST)
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
Subject: [PATCH net-next 2/8] net: ravb: Simplify GbEth poll & receive functions
Date: Wed, 31 Jan 2024 17:05:16 +0000
Message-Id: <20240131170523.30048-3-paul.barker.ct@bp.renesas.com>
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

We don't need to pass the work budget to ravb_rx_gbeth() by reference,
it's cleaner to pass this by value and return the amount of work done.
This allows us to simplify the ravb_poll_gbeth() function and use the
common `work_done` variable name seen in other network drivers for
consistency and ease of understanding.

In ravb_rx_gbeth(), we can also drop the confusingly named `boguscnt`
variable and use a for loop to iterate through descriptors.

This is a pure refactor and should not affect behaviour.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 25 ++++++++++--------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c9464c1731b4..5a6a2a7a9e7a 100644
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
@@ -949,9 +945,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 		desc->die_dt = DT_FEMPTY;
 	}
 
-	*quota -= limit - (++boguscnt);
-
-	return boguscnt <= 0;
+	return i;
 }
 
 /* Packet receive function for Ethernet AVB */
@@ -1344,12 +1338,13 @@ static int ravb_poll_gbeth(struct napi_struct *napi, int budget)
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
-	int quota = budget;
+	int work_done;
 
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (ravb_rx_gbeth(ndev, &quota, q))
+	work_done = ravb_rx_gbeth(ndev, budget, q);
+	if (work_done == budget)
 		goto out;
 
 	/* Processing TX Descriptor Ring */
@@ -1382,7 +1377,7 @@ static int ravb_poll_gbeth(struct napi_struct *napi, int budget)
 	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
 		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
 out:
-	return budget - quota;
+	return work_done;
 }
 
 static int ravb_poll_rcar(struct napi_struct *napi, int budget)
-- 
2.39.2


