Return-Path: <linux-kernel+bounces-144857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072DA8A4BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8D728649D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318774EB55;
	Mon, 15 Apr 2024 09:48:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D34E1B5;
	Mon, 15 Apr 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174508; cv=none; b=Wp+TQNlDo9HX3TR7V51YjhTwXtc1smt5NrOBbgQom61ioRNEggblA2vgHgBiyo9GaNrNfzIOIgduLwFhl4vaaaCk848ZWJCfy9mPiTMZ3tp9LoxdX/9crSyTHJFN+4XvPjAKqFCxs4DP6KgeJURiWIC4AlP7Vsi/R+JHm/yU5+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174508; c=relaxed/simple;
	bh=x4Zsub4YbolyN1YLVPle9lSA5gqkeulVwY0tAnBiE5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O98jA5AybIW5IBaZ8hlQXafOGhacI4N8W3/yDeuGyPGMmNbneGv562ZtsmHSJV6xzg6z2jNqo1urSxWwIpQxJGveJFk28e0002bgdrAxu189I4rXBRWy3IvAy3Rio68wt+RtONPXk63K5/nY8h5+hcWgm94GzscIKdEe/pWL5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="scan'208";a="205432156"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2024 18:48:26 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.74])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5D6D94006DE8;
	Mon, 15 Apr 2024 18:48:22 +0900 (JST)
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
Subject: [net-next RFC v3 2/7] net: ravb: Align poll function with NAPI docs
Date: Mon, 15 Apr 2024 10:47:59 +0100
Message-Id: <20240415094804.8016-3-paul.barker.ct@bp.renesas.com>
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

Call napi_complete_done() in accordance with the documentation in
`Documentation/networking/napi.rst`.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 26 ++++++++++--------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 33f8043143c1..1ac599a044b2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1340,23 +1340,19 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
 		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
 
-	if (work_done == budget)
-		goto out;
-
-	napi_complete(napi);
-
-	/* Re-enable RX/TX interrupts */
-	spin_lock_irqsave(&priv->lock, flags);
-	if (!info->irq_en_dis) {
-		ravb_modify(ndev, RIC0, mask, mask);
-		ravb_modify(ndev, TIC,  mask, mask);
-	} else {
-		ravb_write(ndev, mask, RIE0);
-		ravb_write(ndev, mask, TIE);
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		/* Re-enable RX/TX interrupts */
+		spin_lock_irqsave(&priv->lock, flags);
+		if (!info->irq_en_dis) {
+			ravb_modify(ndev, RIC0, mask, mask);
+			ravb_modify(ndev, TIC,  mask, mask);
+		} else {
+			ravb_write(ndev, mask, RIE0);
+			ravb_write(ndev, mask, TIE);
+		}
+		spin_unlock_irqrestore(&priv->lock, flags);
 	}
-	spin_unlock_irqrestore(&priv->lock, flags);
 
-out:
 	return work_done;
 }
 
-- 
2.39.2


