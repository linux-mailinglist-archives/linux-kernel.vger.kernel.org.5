Return-Path: <linux-kernel+bounces-54575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8DF84B0F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD96DB2382F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306AD12F365;
	Tue,  6 Feb 2024 09:19:47 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A184012EBFA;
	Tue,  6 Feb 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211186; cv=none; b=kmvL59kKGPatmadeToN4eKyREwEyTpTL3Gw/YYHzw3rtykaqtuVqt7/E7RnokBriQsRCKOFXgU09fZtSEhLRfiHSwIW54y8ajXqMKypGm6dFNYgWL7sRP24L+bDBo5lk1XZMur8CN3U1t91YxNBS4TUceLmV40gmHydy92oH6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211186; c=relaxed/simple;
	bh=K2OpG4YqvGtxSFVnu+Kxv9nWWw/e4YY7sJiQxe5ZN2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B20oA7PMcW72MRe7U27IsbNX3y944XoMiIJzESer4yQR7pPkLgnyIqvykqYTNtZ3X2r0irhtLxZNGUVpbM2WB/5oHplXFeFVqZE9y1jeB4SYZzAbyz7vrnd0T2BI64z67OZcP9FhjHjMpNcybWjsrWysRhjR/fA5nfHMYMuCmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,246,1701097200"; 
   d="scan'208";a="193022712"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Feb 2024 18:19:43 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BFCCE41B86C7;
	Tue,  6 Feb 2024 18:19:39 +0900 (JST)
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
Subject: [RFC PATCH net-next v2 6/7] net: ravb: Enable SW IRQ Coalescing for GbEth
Date: Tue,  6 Feb 2024 09:19:08 +0000
Message-Id: <20240206091909.3191-7-paul.barker.ct@bp.renesas.com>
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

Software IRQ Coalescing is required to improve network stack performance
in the RZ/G2L SoC family and the RZ/G3S SoC, i.e. the SoCs which use the
GbEth IP.

For the RZ/G2L, network throughput is comparable before and after this
change. CPU usage during TCP RX testing dropped by 6.5% and during UDP
RX testing dropped by 10%.

For the RZ/G2UL, network throughput is greatly increased by this change
(results obtained with iperf3):
  * TCP TX: 2.9% more throughput
  * TCP RX: 1.1% more throughput
  * UDP TX: similar throughput
  * UDP RX: 41500% more throughput

For the RZ/G3S we see improvements in network throughput similar to the
RZ/G2UL.

The improvement of UDP RX bandwidth for the single core SoCs (RZ/G2UL &
RZ/G3S) is particularly critical.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 55a7a08aabef..ca7a66759e35 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1078,6 +1078,7 @@ struct ravb_hw_info {
 	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
 	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
 	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
+	unsigned needs_irq_coalesce:1;	/* Requires SW IRQ Coalescing to achieve best performance */
 };
 
 struct ravb_private {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 661fd86899ac..7bb80608f260 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2639,6 +2639,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.tx_counters = 1,
 	.carrier_counters = 1,
 	.half_duplex = 1,
+	.needs_irq_coalesce = 1,
 };
 
 static const struct of_device_id ravb_match_table[] = {
@@ -2983,6 +2984,9 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->nc_queues)
 		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
 
+	if (info->needs_irq_coalesce)
+		netdev_sw_irq_coalesce_default_on(ndev);
+
 	/* Network device register */
 	error = register_netdev(ndev);
 	if (error)
-- 
2.39.2


