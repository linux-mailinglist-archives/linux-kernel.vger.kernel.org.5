Return-Path: <linux-kernel+bounces-144859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 013E08A4BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C091F22E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BE156B8F;
	Mon, 15 Apr 2024 09:48:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494F355E7B;
	Mon, 15 Apr 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174517; cv=none; b=gzwMqw6HRpLHiS5lf1O6CyQvKPU3pgWOl4poY0Txy8MhniaOg67ya7j24mT37N+gNGiSG4BUoNpHqe+V1IFI+ZMw++jaFqrosW17FfRwWKLR3GRlAVz4GLp2RWTrIbn2+mRhkAkFr1h0cngKKjFhAUr2BKogQnusyr/I+YIR4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174517; c=relaxed/simple;
	bh=GUKzBRLx8vQMPtz9yQAWhMU1XT4emqE0dhvCfEhN4HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEunvdi+/0Mhx1om0q4TdQaar/7A796zfFGhSDbhdILAMzRzx67zqVUKs3uRAwY6ECP1nY0jbCM8ZGK320JYBBnXYtAoj0NRGjp4qP4jrMkOsc9ZWySXJByqbPZzFJKB+rBUFDO5bUVPwPYXLu+i44IYxRnx6z50wXNGvI6XNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="scan'208";a="205432166"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2024 18:48:35 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.74])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 30AE04006DE8;
	Mon, 15 Apr 2024 18:48:30 +0900 (JST)
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
Subject: [net-next RFC v3 4/7] net: ravb: Refactor GbEth RX code path
Date: Mon, 15 Apr 2024 10:48:01 +0100
Message-Id: <20240415094804.8016-5-paul.barker.ct@bp.renesas.com>
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

We can reduce code duplication in ravb_rx_gbeth() and add comments to
make the code flow easier to understand.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 70 ++++++++++++------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index baa01bd81f2d..12618171f6d5 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -818,47 +818,47 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 				stats->rx_missed_errors++;
 		} else {
 			die_dt = desc->die_dt & 0xF0;
-			switch (die_dt) {
-			case DT_FSINGLE:
-				skb = ravb_get_skb_gbeth(ndev, entry, desc);
+			skb = ravb_get_skb_gbeth(ndev, entry, desc);
+			if (die_dt == DT_FSINGLE || die_dt == DT_FSTART) {
+				/* Start of packet:
+				 * Set initial data length.
+				 */
 				skb_put(skb, desc_len);
+
+				/* Save this SKB if the packet spans multiple
+				 * descriptors.
+				 */
+				if (die_dt == DT_FSTART)
+					priv->rx_1st_skb = skb;
+			} else {
+				/* Continuing a packet:
+				 * Move data into the saved SKB.
+				 */
+				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
+							       priv->rx_1st_skb->len,
+							       skb->data,
+							       desc_len);
+				skb_put(priv->rx_1st_skb, desc_len);
+				dev_kfree_skb(skb);
+
+				/* Set skb to point at the whole packet so that
+				 * we only need one code path for finishing a
+				 * packet.
+				 */
+				skb = priv->rx_1st_skb;
+			}
+
+			if (die_dt == DT_FSINGLE || die_dt == DT_FEND) {
+				/* Finishing a packet:
+				 * Determine protocol & checksum, hand off to
+				 * NAPI and update our stats.
+				 */
 				skb->protocol = eth_type_trans(skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
 					ravb_rx_csum_gbeth(skb);
+				stats->rx_bytes += skb->len;
 				napi_gro_receive(&priv->napi[q], skb);
 				rx_packets++;
-				stats->rx_bytes += desc_len;
-				break;
-			case DT_FSTART:
-				priv->rx_1st_skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_put(priv->rx_1st_skb, desc_len);
-				break;
-			case DT_FMID:
-				skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
-							       priv->rx_1st_skb->len,
-							       skb->data,
-							       desc_len);
-				skb_put(priv->rx_1st_skb, desc_len);
-				dev_kfree_skb(skb);
-				break;
-			case DT_FEND:
-				skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
-							       priv->rx_1st_skb->len,
-							       skb->data,
-							       desc_len);
-				skb_put(priv->rx_1st_skb, desc_len);
-				dev_kfree_skb(skb);
-				priv->rx_1st_skb->protocol =
-					eth_type_trans(priv->rx_1st_skb, ndev);
-				if (ndev->features & NETIF_F_RXCSUM)
-					ravb_rx_csum_gbeth(priv->rx_1st_skb);
-				stats->rx_bytes += priv->rx_1st_skb->len;
-				napi_gro_receive(&priv->napi[q],
-						 priv->rx_1st_skb);
-				rx_packets++;
-				break;
 			}
 		}
 	}
-- 
2.39.2


