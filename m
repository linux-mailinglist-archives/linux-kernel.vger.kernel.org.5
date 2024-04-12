Return-Path: <linux-kernel+bounces-142452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276368A2BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61962879C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D65554BF7;
	Fri, 12 Apr 2024 10:01:21 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C154677;
	Fri, 12 Apr 2024 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916080; cv=none; b=YDdGMQE/gyOjs9rXEO7aMb2eK/+mM6qc3kKO7UvlN5P5dvD4eaugu3hOFWQPY75yVBvv4LqsJGBMtCtUzhPg5pNoBQwSHrfqobs6gTHs2WicqvaDM05t7k2B7doi5aqzK9oPim8EFC4092poBsUC7OYMfmNswi9cNDGRq4TTXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916080; c=relaxed/simple;
	bh=b01fvQMwrTUnnSomPYzsVFXLzVPnHUMI9Mj9CzYrfso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJxF987Cyzk04t7YXax0XqyjAUkNQ620Mrn4tgOIxdXi4PQmxELiyeVkycOztgVcq0E21QMaX+h40O77RYcX36rtp5/4OfzVrCYnCRboQXiekCqtbV/Lsl6Uk/hqVj9yxEyJpAK3zNNLNquQ5exjV/T29iRSge2CEnB07yH6V5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,195,1708354800"; 
   d="scan'208";a="201242371"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Apr 2024 19:01:15 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.65])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0AF6941E0D16;
	Fri, 12 Apr 2024 19:01:10 +0900 (JST)
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
Subject: [net PATCH v2 3/4] net: ravb: Fix GbEth jumbo packet RX checksum handling
Date: Fri, 12 Apr 2024 11:00:23 +0100
Message-Id: <20240412100024.2296-4-paul.barker.ct@bp.renesas.com>
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

Sending a 7kB ping packet to the RZ/G2L in v6.9-rc2 causes the following
backtrace:

	WARNING: CPU: 0 PID: 0 at include/linux/skbuff.h:3127 skb_trim+0x30/0x38
	Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
	pc : skb_trim+0x30/0x38
	lr : ravb_rx_csum_gbeth+0x40/0x90
	Call trace:
	 skb_trim+0x30/0x38
	 ravb_rx_gbeth+0x56c/0x5cc
	 ravb_poll+0xa0/0x204
	 __napi_poll+0x38/0x17c

This is caused by ravb_rx_gbeth() calling ravb_rx_csum_gbeth() with the
wrong skb for a packet which spans multiple descriptors. To fix this,
use the correct skb.

Fixes: c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 028ab5c6aaf7..e1e39f65224c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -843,7 +843,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				priv->rx_1st_skb->protocol =
 					eth_type_trans(priv->rx_1st_skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
-					ravb_rx_csum_gbeth(skb);
+					ravb_rx_csum_gbeth(priv->rx_1st_skb);
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
 				rx_packets++;
-- 
2.39.2


