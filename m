Return-Path: <linux-kernel+bounces-118561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E65788BCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32401F34CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D11C698;
	Tue, 26 Mar 2024 08:38:15 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913EC134C4;
	Tue, 26 Mar 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442294; cv=none; b=nPj+uEVuprjs1UNM/PJddOs6SNX3aAkwxUQz3V8NVPytL34S9MRkLvkY8lDBjfxQbYlU/uN9nflCjrvAERDOpIedr+z9GqzI3E3dd22aUSn3AREddyg9AujoVIyd4zG+EKYjoIMuBBL7jVxGmylYaQXsMqa4GyQw8bFvSWBCIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442294; c=relaxed/simple;
	bh=93MtjCx4OQlnkcMW4ACk+vB8pMhtkvceUpV5vJv1CyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZtrfCRvyBhtokzC6fO5pQK/c5kgU8nxsNGvu9BRVzXK7K/QD50uhDyIfF/3GIjvC1mh7woPEGhwufVY/B/og1BQCtxm4dt+dGtEfLvXsCsxN8lmQtzZL1PUCvXTMuDIdfQhnbyxUnUmoJmjdqGeEt1aNCNf9M+EWEuoX0N67Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,155,1708354800"; 
   d="scan'208";a="199297043"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Mar 2024 17:38:12 +0900
Received: from renesas-deb12.mshome.net (unknown [10.226.92.201])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5DF404006DEF;
	Tue, 26 Mar 2024 17:38:08 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: ravb: Always update error counters
Date: Tue, 26 Mar 2024 08:37:40 +0000
Message-Id: <20240326083740.23364-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326083740.23364-1-paul.barker.ct@bp.renesas.com>
References: <20240326083740.23364-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error statistics should be updated each time the poll function is
called, even if the full RX work budget has been consumed. This prevents
the counts from becoming stuck when RX bandwidth usage is high.

This also ensures that error counters are not updated after we've
re-enabled interrupts as that could result in a race condition.

Also drop an unnecessary space.

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4f98e4e2badb..a95703948a36 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1339,6 +1339,15 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	netif_wake_subqueue(ndev, q);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	/* Receive error message handling */
+	priv->rx_over_errors =  priv->stats[RAVB_BE].rx_over_errors;
+	if (info->nc_queues)
+		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
+	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
+		ndev->stats.rx_over_errors = priv->rx_over_errors;
+	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
+		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
+
 	if (!rearm)
 		goto out;
 
@@ -1355,14 +1364,6 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	/* Receive error message handling */
-	priv->rx_over_errors =  priv->stats[RAVB_BE].rx_over_errors;
-	if (info->nc_queues)
-		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
-	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
-		ndev->stats.rx_over_errors = priv->rx_over_errors;
-	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
-		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
 out:
 	return budget - quota;
 }
-- 
2.44.0


