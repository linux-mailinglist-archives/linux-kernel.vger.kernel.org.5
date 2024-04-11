Return-Path: <linux-kernel+bounces-140370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B2A8A1372
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D3F28B0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2322814BFA8;
	Thu, 11 Apr 2024 11:45:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C7F14AD3F;
	Thu, 11 Apr 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835908; cv=none; b=UjFzeE5gUnw+nfxQiHaInSco9S4V5M+6SmPV1lhdXkodExGHVPln+7v83BB9u9nh94d+zLkuhjlkCKvdwJQ5rVBCRE7xq5vydRRGLSfORzi7SLZa3FAdizg+O6tQeDGbVNnWW65PG4iV2OHwopmpfP0nAxDY1+0bj1Bc2l194PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835908; c=relaxed/simple;
	bh=rpjBKncb2PPsMI+z0Kjkp03iK4cJcujdCC28t4DeLjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ehMNGAfE17AcpO7RwYFxU3YEll9HZdNFsEZCa+WuJHMIVouXQEB+Gr6yfWnGz7OcYd9IIKH5jBhLh8mJm1wpK1LJ+lW3gVfbHvQLKK0l+TFk6eQB1yLmf0/s5aPzWwQ5BxnG4z3ZVMclrEujRIGiHE3vV/X/0FVBOdYbdMeYKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,193,1708354800"; 
   d="scan'208";a="205076264"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Apr 2024 20:44:59 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.85])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 982B742017D7;
	Thu, 11 Apr 2024 20:44:55 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/4] net: ravb: Count packets instead of descriptors in R-Car RX path
Date: Thu, 11 Apr 2024 12:44:30 +0100
Message-Id: <20240411114434.26186-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The units of "work done" in the RX path should be packets instead of
descriptors.

Descriptors which are used by the hardware to record error conditions or
are empty in the case of a DMA mapping error should not count towards
our RX work budget.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ba01c8cc3c90..70f2900648d4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -892,29 +892,25 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	int entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-	int boguscnt = (priv->dirty_rx[q] + priv->num_rx_ring[q]) -
-			priv->cur_rx[q];
 	struct net_device_stats *stats = &priv->stats[q];
 	struct ravb_ex_rx_desc *desc;
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
 	struct timespec64 ts;
+	int rx_packets = 0;
 	u8  desc_status;
 	u16 pkt_len;
 	int limit;
+	int i;
 
-	boguscnt = min(boguscnt, *quota);
-	limit = boguscnt;
+	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	desc = &priv->rx_ring[q].ex_desc[entry];
-	while (desc->die_dt != DT_FEMPTY) {
+	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
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
@@ -960,7 +956,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 			if (ndev->features & NETIF_F_RXCSUM)
 				ravb_rx_csum(skb);
 			napi_gro_receive(&priv->napi[q], skb);
-			stats->rx_packets++;
+			rx_packets++;
 			stats->rx_bytes += pkt_len;
 		}
 
@@ -995,9 +991,9 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 		desc->die_dt = DT_FEMPTY;
 	}
 
-	*quota -= limit - (++boguscnt);
-
-	return boguscnt <= 0;
+	stats->rx_packets += rx_packets;
+	*quota -= rx_packets;
+	return *quota == 0;
 }
 
 /* Packet receive function for Ethernet AVB */
-- 
2.39.2


