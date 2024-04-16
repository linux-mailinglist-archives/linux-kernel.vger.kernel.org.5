Return-Path: <linux-kernel+bounces-146742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4958A6A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A389B223FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C012BF25;
	Tue, 16 Apr 2024 12:03:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B9412B145;
	Tue, 16 Apr 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269030; cv=none; b=X1exkNOig+dlkJCBu4I0zl9gdbPVamyedmqQVcGGKefugxBzZIXs+DK86V8/o43Tjv4pAu6ZXkAPf6tVEKCbLgkHqh7DQCIwFhPXLIKHEnoIjmW+F9XU33Xsn/Dp6+x1JsUEWA8g98uDbWhP0H5R6RZpIYPftdNZicLLY57r+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269030; c=relaxed/simple;
	bh=CASeUJf1k7le4H22BeIUR9Go94eNU9yShJnelWUCkUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4mU4Y8qjGOV0YCCrgIjujSSxDPmRnBZy6+VG6SFbXfGgK0K7J5o2Rr91U6zwOwFZxiNymTTRr9SduvI/KMrUEW8hEinViukhddo0cbeOyNVB8CL2fmwKYqtwyzt76c5L3PvMNgyDl1qyfeAnFBmYktlhVCg4bqb7ZlhZlyjoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,205,1708354800"; 
   d="scan'208";a="205570153"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Apr 2024 21:03:39 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.86])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4918A40078C7;
	Tue, 16 Apr 2024 21:03:34 +0900 (JST)
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
Subject: [net PATCH v3 2/4] net: ravb: Allow RX loop to move past DMA mapping errors
Date: Tue, 16 Apr 2024 13:02:52 +0100
Message-Id: <20240416120254.2620-3-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240416120254.2620-1-paul.barker.ct@bp.renesas.com>
References: <20240416120254.2620-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RX loops in ravb_rx_gbeth() and ravb_rx_rcar() skip to the next loop
iteration if a zero-length descriptor is seen (indicating a DMA mapping
error). However, the current RX descriptor index `priv->cur_rx[q]` was
incremented at the end of the loop and so would not be incremented when
we skip to the next loop iteration. This would cause the loop to keep
seeing the same zero-length descriptor instead of moving on to the next
descriptor.

As the loop counter `i` still increments, the loop would eventually
terminate so there is no risk of being stuck here forever - but we
should still fix this to avoid wasting cycles.

To fix this, the RX descriptor index is incremented at the top of the
loop, in the for statement itself. The assignments of `entry` and `desc`
are brought into the loop to avoid the need for duplication.

Fixes: d8b48911fd24 ("ravb: fix ring memory allocation")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
Changes v2->v3:
  * Move comparison of `rx_packets` against `*quota` inside the loop.
Changes v1->v2:
  * Fix typos in commit message.
  * Add Sergey's Reviewed-by tag.

 drivers/net/ethernet/renesas/ravb_main.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 7d231d011bff..3b870926af14 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -775,12 +775,15 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	int limit;
 	int i;
 
-	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
 	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
-	desc = &priv->rx_ring[q].desc[entry];
-	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
+	for (i = 0; i < limit; i++, priv->cur_rx[q]++) {
+		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
+		desc = &priv->rx_ring[q].desc[entry];
+		if (rx_packets == *quota || desc->die_dt == DT_FEMPTY)
+			break;
+
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
@@ -848,9 +851,6 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				break;
 			}
 		}
-
-		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q].desc[entry];
 	}
 
 	/* Refill the RX ring buffers. */
@@ -891,7 +891,6 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	int entry = priv->cur_rx[q] % priv->num_rx_ring[q];
 	struct net_device_stats *stats = &priv->stats[q];
 	struct ravb_ex_rx_desc *desc;
 	unsigned int limit, i;
@@ -901,10 +900,15 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	int rx_packets = 0;
 	u8  desc_status;
 	u16 pkt_len;
+	int entry;
 
 	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
-	desc = &priv->rx_ring[q].ex_desc[entry];
-	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
+	for (i = 0; i < limit; i++, priv->cur_rx[q]++) {
+		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
+		desc = &priv->rx_ring[q].ex_desc[entry];
+		if (rx_packets == *quota || desc->die_dt == DT_FEMPTY)
+			break;
+
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
@@ -958,9 +962,6 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 			rx_packets++;
 			stats->rx_bytes += pkt_len;
 		}
-
-		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q].ex_desc[entry];
 	}
 
 	/* Refill the RX ring buffers. */
-- 
2.39.2


