Return-Path: <linux-kernel+bounces-65396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A57854C50
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92172286138
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C245D72C;
	Wed, 14 Feb 2024 15:12:57 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30675D461;
	Wed, 14 Feb 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923576; cv=none; b=WMv0exIe3+qH2dx3vKXKnM4Qmwx0w7FhMef0zPSEo/AUO6IjS4Oy/87KazvTkBlrFBRU1kJe9nsfKg4FxOwH/XgdQFabdsjQDR0PbgFCEz/W8/U7+W8wRnPNt6EljeMMpBDy7jkhtYlmFpBgrfCnheBwMiZ7hD7GEF+g0fggHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923576; c=relaxed/simple;
	bh=Fm4f8S9D3dClviZZAq026dnWtTRMEFW8SuKQ8DQrHI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9G7Zb590v3xxPYQq5rsa8eHP0GPnBp1mDEEIpoPKZnU5jwFG17yRhARuMqJ9WHq6VE7yf7WkRNL5czMV9udZTq7e+HrvTXTygAlUc92Zq2GfxNhGBZwk0q3BYas7zGPzExdkXQb/DY4WvSBFql4kZkEnuoaC8J+h6zhztMCat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,159,1705330800"; 
   d="scan'208";a="193932772"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Feb 2024 00:12:46 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.104])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4785B4005460;
	Thu, 15 Feb 2024 00:12:41 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: ravb: Count packets instead of descriptors in GbEth RX path
Date: Wed, 14 Feb 2024 15:12:04 +0000
Message-Id: <20240214151204.2976-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The units of "work done" in the RX path should be packets instead of
descriptors, as large packets can be spread over multiple descriptors.

Fixes: 1c59eb678cbd ("ravb: Fillup ravb_rx_gbeth() stub")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
This patch has been broken out from my previous series "Improve GbEth
performance on Renesas RZ/G2L and related SoCs" and submitted as a
bugfix as requested by Sergey. I've labeled it as 'v3' so the ordering
is clear. Remaining patches from the series will follow once we've done
gPTP testing.

 drivers/net/ethernet/renesas/ravb_main.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0e3731f50fc2..f7566cfa45ca 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -772,29 +772,25 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	struct ravb_rx_desc *desc;
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
+	int rx_packets = 0;
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
 	desc = &priv->gbeth_rx_ring[entry];
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
@@ -820,7 +816,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				skb_put(skb, pkt_len);
 				skb->protocol = eth_type_trans(skb, ndev);
 				napi_gro_receive(&priv->napi[q], skb);
-				stats->rx_packets++;
+				rx_packets++;
 				stats->rx_bytes += pkt_len;
 				break;
 			case DT_FSTART:
@@ -848,7 +844,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 					eth_type_trans(priv->rx_1st_skb, ndev);
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
-				stats->rx_packets++;
+				rx_packets++;
 				stats->rx_bytes += pkt_len;
 				break;
 			}
@@ -887,9 +883,9 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
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
2.43.1


