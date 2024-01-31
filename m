Return-Path: <linux-kernel+bounces-46867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1584459B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B071F23AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F0412CD8E;
	Wed, 31 Jan 2024 17:06:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3812C539;
	Wed, 31 Jan 2024 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720769; cv=none; b=RDjnVz2Wp9veKKl4VKxk2stvSAZZvTeUH0LZ4/T7GtsLw5Ac8aC7AsvW6yXYqVEnS/ka4dmwNwHT5bsadEBou4H7royPkzfk1AclZyHhsIK5OoX0kwKvVbZCHgMViIMp2spLfPnqlRRLfK4loOqynktoW/dFfNaIYsPmlmTs/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720769; c=relaxed/simple;
	bh=jDaoRchUeMb3jhh/QTDuC4oc5ie9+ahUDA1P+pGYTO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ev/IOwYXBWa8RCPTcDXaiHxVuQoTTuBka22JMTiHtAHCM+PEM5rKwK92tfoTY1xcpvFLMeLF4VFJD5BeQxq9STvxUrQCYX0ajLc8WSPvbaYLidRl9oHwmvl1waVxfYBEFD1jcUvZyTpe4DkhnUaM0Hjl/bTCpSdfWpUcZE8Dtt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="192404892"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Feb 2024 02:06:07 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.158])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A1E50403490C;
	Thu,  1 Feb 2024 02:06:03 +0900 (JST)
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
Subject: [PATCH net-next 5/8] net: ravb: Always update error counters
Date: Wed, 31 Jan 2024 17:05:19 +0000
Message-Id: <20240131170523.30048-6-paul.barker.ct@bp.renesas.com>
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

The error statistics should be updated each time the poll function is
called, even if the full RX work budget has been consumed. This prevents
the counts from becoming stuck when RX bandwidth usage is high.

This also ensures that error counters are not updated after we've
re-enabled interrupts as that could result in a race condition.

Also drop an unnecessary space.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 9b0ed269e69b..a90e70b25875 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1354,6 +1354,15 @@ static int ravb_poll_gbeth(struct napi_struct *napi, int budget)
 	netif_wake_subqueue(ndev, q);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	/* Receive error message handling */
+	priv->rx_over_errors = priv->stats[RAVB_BE].rx_over_errors;
+	if (info->nc_queues)
+		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
+	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
+		ndev->stats.rx_over_errors = priv->rx_over_errors;
+	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
+		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
+
 	if (work_done == budget)
 		goto out;
 
@@ -1370,14 +1379,6 @@ static int ravb_poll_gbeth(struct napi_struct *napi, int budget)
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
 	return work_done;
 }
-- 
2.39.2


