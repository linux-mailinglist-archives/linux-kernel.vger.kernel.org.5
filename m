Return-Path: <linux-kernel+bounces-142453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC168A2BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EDA1F234A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E47256448;
	Fri, 12 Apr 2024 10:01:26 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A8455774;
	Fri, 12 Apr 2024 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916085; cv=none; b=dM07XuYnWfVT4PAd/8XXfNd+S5iLhgUBP5t7QQBxE0oAT7w5nTVAhPsIXvoUhxmYEgrUnyIzT5k+FxEh3m7Slnp1YZdpVOruJqLLTz0ezuw5s/oj7XeHwtos1xnVRi9bl76xVZI6PzBbQVo2NZKD6Npw2badA1cKQBeRIIFMjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916085; c=relaxed/simple;
	bh=MsTjAOc8LxDsKaFl5Csrf742XdcLyMoxIe5ic/J1zcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gs/LpPW9zZXbvpLL0+2lbY4rDt3LHHRN65J6SKe1TQuv1DTyNsdBXW2icGfLvsrUn5od0UCLR/msNiq8jVb5XOggQScMP+J8j87e0aX7s9W1Ln1IejSYc28Kiwd/rzB69gzc5U0sHtIpyBekwjtxcAsw+xT5jG9MBnMSTsZk9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,195,1708354800"; 
   d="scan'208";a="205195042"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Apr 2024 19:01:20 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.65])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C03AF41E0D3A;
	Fri, 12 Apr 2024 19:01:15 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	YueHaibing <yuehaibing@huawei.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net PATCH v2 4/4] net: ravb: Fix RX byte accounting for jumbo packets
Date: Fri, 12 Apr 2024 11:00:24 +0100
Message-Id: <20240412100024.2296-5-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412100024.2296-1-paul.barker.ct@bp.renesas.com>
References: <20240412100024.2296-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RX byte accounting for jumbo packets was changed to fix a potential
use-after-free bug. However, that fix used the wrong variable and so
only accounted for the number of bytes in the final descriptor, not the
number of bytes in the whole packet.

To fix this, we can simply update our stats with the correct number of
bytes before calling napi_gro_receive().

Also rename pkt_len to desc_len in ravb_rx_gbeth() to avoid any future
confusion. The variable name pkt_len is correct in ravb_rx_rcar() as
that function does not handle packets spanning multiple descriptors.

Fixes: 5a5a3e564de6 ("ravb: Fix potential use-after-free in ravb_rx_gbeth()")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/net/ethernet/renesas/ravb_main.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e1e39f65224c..c4ac9fbe0af4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -769,7 +769,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	dma_addr_t dma_addr;
 	int rx_packets = 0;
 	u8  desc_status;
-	u16 pkt_len;
+	u16 desc_len;
 	u8  die_dt;
 	int entry;
 	int limit;
@@ -787,10 +787,10 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
-		pkt_len = le16_to_cpu(desc->ds_cc) & RX_DS;
+		desc_len = le16_to_cpu(desc->ds_cc) & RX_DS;
 
 		/* We use 0-byte descriptors to mark the DMA mapping errors */
-		if (!pkt_len)
+		if (!desc_len)
 			continue;
 
 		if (desc_status & MSC_MC)
@@ -811,25 +811,25 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 			switch (die_dt) {
 			case DT_FSINGLE:
 				skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_put(skb, pkt_len);
+				skb_put(skb, desc_len);
 				skb->protocol = eth_type_trans(skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
 					ravb_rx_csum_gbeth(skb);
 				napi_gro_receive(&priv->napi[q], skb);
 				rx_packets++;
-				stats->rx_bytes += pkt_len;
+				stats->rx_bytes += desc_len;
 				break;
 			case DT_FSTART:
 				priv->rx_1st_skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_put(priv->rx_1st_skb, pkt_len);
+				skb_put(priv->rx_1st_skb, desc_len);
 				break;
 			case DT_FMID:
 				skb = ravb_get_skb_gbeth(ndev, entry, desc);
 				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
 							       priv->rx_1st_skb->len,
 							       skb->data,
-							       pkt_len);
-				skb_put(priv->rx_1st_skb, pkt_len);
+							       desc_len);
+				skb_put(priv->rx_1st_skb, desc_len);
 				dev_kfree_skb(skb);
 				break;
 			case DT_FEND:
@@ -837,17 +837,17 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
 							       priv->rx_1st_skb->len,
 							       skb->data,
-							       pkt_len);
-				skb_put(priv->rx_1st_skb, pkt_len);
+							       desc_len);
+				skb_put(priv->rx_1st_skb, desc_len);
 				dev_kfree_skb(skb);
 				priv->rx_1st_skb->protocol =
 					eth_type_trans(priv->rx_1st_skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
 					ravb_rx_csum_gbeth(priv->rx_1st_skb);
+				stats->rx_bytes += priv->rx_1st_skb->len;
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
 				rx_packets++;
-				stats->rx_bytes += pkt_len;
 				break;
 			}
 		}
-- 
2.39.2


