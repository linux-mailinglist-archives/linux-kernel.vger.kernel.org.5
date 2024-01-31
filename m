Return-Path: <linux-kernel+bounces-46864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49266844592
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29DB297F94
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E912DDB8;
	Wed, 31 Jan 2024 17:06:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D72112DD9A;
	Wed, 31 Jan 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720762; cv=none; b=RGWi46HY2bdvT9Xlcwa81JwBuMTN5mr9dP8vUhm8+1X0ZTwV2GoN5F2iYrnQ/p+XagR5lTkygfWMKCJC13iWI/ffTs8nszesvich38nPrJYoscHC/jKNNuNisRdQnzI4CeZW1FHgcdfie/2eTdYDV37sHvnOUaCT0Z+/d3vN0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720762; c=relaxed/simple;
	bh=jP6QldFPdAD5uJhr8/CvILmn76QiLrkdjUHamTufTEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u44YTGBxqAosyROGTUnaPO8YXTuK4jRv/OCXiJ2oerhq8PMs19TNnpJf7NACUypBlHngEmIfzRejiMk5eWiUhbPPMGHfeRxN7yMHZDJL/0IinglrU8xAatUqCxzkFH2Ar5JrqfLwND7gitD6euAhN6/Lmzben62w1EsJ6T7NUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="196315527"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Feb 2024 02:05:58 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.158])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4A7EE40344F5;
	Thu,  1 Feb 2024 02:05:55 +0900 (JST)
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
Subject: [PATCH net-next 3/8] net: ravb: Count packets in GbEth RX (not descriptors)
Date: Wed, 31 Jan 2024 17:05:17 +0000
Message-Id: <20240131170523.30048-4-paul.barker.ct@bp.renesas.com>
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

The units of "work done" in the RX path should be packets instead of
descriptors, as large packets can be spread over multiple descriptors.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5a6a2a7a9e7a..077c189bcc6f 100644
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
-- 
2.39.2


