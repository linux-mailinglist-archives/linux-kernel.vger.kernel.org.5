Return-Path: <linux-kernel+bounces-54572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FD84B0E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF04285930
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2B12E1D8;
	Tue,  6 Feb 2024 09:19:36 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83CC12D164;
	Tue,  6 Feb 2024 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211175; cv=none; b=u88ylkjkO6w6UgaivNg7UH3RD89la/KLN94+cKcFJwedtm0iGqR1jxwv/hhOqkNlAayEDRQYyLuFmyNygskSId9kAmyw+jpmSb3bEHN30yt1qdJ9Zds7gETipyBuAIx4HFghQyKEFrVYAVY7CvCnYAk5BMfWPGDJeW4Y28SixnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211175; c=relaxed/simple;
	bh=+nLdJAeGVZo7YdSrELcAYK8JRq4WJ5ippaKl609J+3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZmXMA8pl9cTt8B1mpsrMYib1hC7LVw9VzQHegCXBkhB6GlVf/peBEY/uvdI6RExPeWsNA+Vfphh/lTUkU68OfU/DjjnSr6+wQ34+ZyMZasSnhIdcbnocFOYXEYHihl+EseSQnIsQZbVSXhejzEYzq49tuemylTJg9wIDoBsDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,246,1701097200"; 
   d="scan'208";a="196934627"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Feb 2024 18:19:26 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BA8EE41B8EF7;
	Tue,  6 Feb 2024 18:19:22 +0900 (JST)
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
Subject: [RFC PATCH net-next v2 2/7] net: ravb: Count packets instead of descriptors in RX path
Date: Tue,  6 Feb 2024 09:19:04 +0000
Message-Id: <20240206091909.3191-3-paul.barker.ct@bp.renesas.com>
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

The units of "work done" in the RX path should be packets instead of
descriptors, as large packets can be spread over multiple descriptors.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b18026575a2d..20193944c143 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -830,6 +830,7 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 	struct ravb_rx_desc *desc;
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
+	int rx_packets = 0;
 	u8  desc_status;
 	u16 pkt_len;
 	u8  die_dt;
@@ -841,9 +842,8 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
-	limit = min(limit, budget);
 	desc = &priv->gbeth_rx_ring[entry];
-	for (i = 0; i < limit && desc->die_dt != DT_FEMPTY; i++) {
+	for (i = 0; i < limit && rx_packets < budget && desc->die_dt != DT_FEMPTY; i++) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
@@ -876,7 +876,7 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 				if (ndev->features & NETIF_F_RXCSUM)
 					ravb_rx_csum_gbeth(skb);
 				napi_gro_receive(&priv->napi[q], skb);
-				stats->rx_packets++;
+				rx_packets++;
 				stats->rx_bytes += pkt_len;
 				break;
 			case DT_FSTART:
@@ -906,7 +906,7 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 					ravb_rx_csum_gbeth(skb);
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
-				stats->rx_packets++;
+				rx_packets++;
 				stats->rx_bytes += pkt_len;
 				break;
 			}
@@ -945,7 +945,8 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 		desc->die_dt = DT_FEMPTY;
 	}
 
-	return i;
+	stats->rx_packets += rx_packets;
+	return rx_packets;
 }
 
 /* Packet receive function for Ethernet AVB */
@@ -960,14 +961,14 @@ static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
 	struct timespec64 ts;
+	int rx_packets = 0;
 	u8  desc_status;
 	u16 pkt_len;
 	int limit;
 	int i;
 
-	limit = min(limit, budget);
 	desc = &priv->rx_ring[q][entry];
-	for (i = 0; i < limit && desc->die_dt != DT_FEMPTY; i++) {
+	for (i = 0; i < limit && rx_packets < budget && desc->die_dt != DT_FEMPTY; i++) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
@@ -1018,7 +1019,7 @@ static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
 			if (ndev->features & NETIF_F_RXCSUM)
 				ravb_rx_csum(skb);
 			napi_gro_receive(&priv->napi[q], skb);
-			stats->rx_packets++;
+			rx_packets++;
 			stats->rx_bytes += pkt_len;
 		}
 
@@ -1054,7 +1055,8 @@ static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
 		desc->die_dt = DT_FEMPTY;
 	}
 
-	return i;
+	stats->rx_packets += rx_packets;
+	return rx_packets;
 }
 
 /* Packet receive function for Ethernet AVB */
-- 
2.39.2


