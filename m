Return-Path: <linux-kernel+bounces-146740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F208A6A24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55565B217E7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EDC12AAE3;
	Tue, 16 Apr 2024 12:03:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D214312A163;
	Tue, 16 Apr 2024 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269024; cv=none; b=N7hS7fWonVIcgD6cGPIvFZ9SoU1dzMhVRcvSvVfi0/bvklFSEE1CGusoDno3+UU3+yqLDGGUFsQ5qRy74XNtBGFM6M8xNYM0HDNwyhmMYiFfHE66SvBVH2z/Q+jyRpjbyZ5APiVIIedD5aTjJrx4yyD1STbxcy+I57gTjICS8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269024; c=relaxed/simple;
	bh=rN+VTapyrFesE5ziZd1kIa7UZiklbkDypdkDabD7ipU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXpMOKLvoLZks7GqJ5fFJvG4LRdakDto3DYQ3NJGSJc4iNt10YwSzU4j2AruqWjkw6+5pQyO/1a+GDRb6tN+J2LYn1sIJdtfP8gQ5ZMar0L1FWGei3194JX3gzkdG/EoMW/lc/U88OwMvCqw0cdFKN70DYOWGxBJmQM4f4USNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,205,1708354800"; 
   d="scan'208";a="201616920"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Apr 2024 21:03:33 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.86])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E0D6B400C44B;
	Tue, 16 Apr 2024 21:03:28 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	YueHaibing <yuehaibing@huawei.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net PATCH v3 1/4] net: ravb: Count packets instead of descriptors in R-Car RX path
Date: Tue, 16 Apr 2024 13:02:51 +0100
Message-Id: <20240416120254.2620-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240416120254.2620-1-paul.barker.ct@bp.renesas.com>
References: <20240416120254.2620-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The units of "work done" in the RX path should be packets instead of
descriptors.

Descriptors which are used by the hardware to record error conditions or
are empty in the case of a DMA mapping error should not count towards
our RX work budget.

Also make the limit variable unsigned as it can never be negative.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
Changes v2->v3:
  * Use unsigned int for `limit` and `i` variables.
  * Add Niklas' Reviewed-by tag.
Changes v1->v2:
  * Add Sergey's Reviewed-by tag.

 drivers/net/ethernet/renesas/ravb_main.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ba01c8cc3c90..7d231d011bff 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -892,29 +892,24 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	int entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-	int boguscnt = (priv->dirty_rx[q] + priv->num_rx_ring[q]) -
-			priv->cur_rx[q];
 	struct net_device_stats *stats = &priv->stats[q];
 	struct ravb_ex_rx_desc *desc;
+	unsigned int limit, i;
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
 	struct timespec64 ts;
+	int rx_packets = 0;
 	u8  desc_status;
 	u16 pkt_len;
-	int limit;
 
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
@@ -960,7 +955,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 			if (ndev->features & NETIF_F_RXCSUM)
 				ravb_rx_csum(skb);
 			napi_gro_receive(&priv->napi[q], skb);
-			stats->rx_packets++;
+			rx_packets++;
 			stats->rx_bytes += pkt_len;
 		}
 
@@ -995,9 +990,9 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
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


