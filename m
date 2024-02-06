Return-Path: <linux-kernel+bounces-54571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F5C84B0E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D933F28561B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B417212DD8C;
	Tue,  6 Feb 2024 09:19:34 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573612D74A;
	Tue,  6 Feb 2024 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211174; cv=none; b=ca8Kv5RNPKPIJA3qTdXxbPok9wu4zfzAXhuMOnOw0cGnbnnsuGqmQ5ed64SmNA4OD+O4jaLpD4bmJijeBvzicXqRDuD3BVM3+2HrT2MPV41OgfzBtrUJ6rxayr6EmKJmKIuUDIGa9ArA/cnf/oO/SNP8Y/USddeWoe0lfrjnlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211174; c=relaxed/simple;
	bh=wMCMA52G6QYbcIfsCp50vOc4fUzt5+fBqBVJp0vQUgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyMfN1P0xk0HEeFOwGONIvRbUhpDco+esn955C5iOsVI3XdoiqlNBVRJ8ROOAaUty9SvMDyVca1ApJilmj0IQ2RdAYQbvkycJzkr90ItJm3tj2MNGlWzcGkDphyl3vPvxi/C2wgI8Ixp3VTQSGLZZ1Riya5JPTLfLHfsPtuA6Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,246,1701097200"; 
   d="scan'208";a="196934634"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Feb 2024 18:19:30 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0011241B9447;
	Tue,  6 Feb 2024 18:19:26 +0900 (JST)
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
Subject: [RFC PATCH net-next v2 3/7] net: ravb: Always process TX descriptor ring
Date: Tue,  6 Feb 2024 09:19:05 +0000
Message-Id: <20240206091909.3191-4-paul.barker.ct@bp.renesas.com>
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

The TX queue should be serviced each time the poll function is called,
even if the full RX work budget has been consumed. This prevents
starvation of the TX queue when RX bandwidth usage is high.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 20193944c143..10f11141569f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1349,8 +1349,6 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
 	work_done = ravb_rx(ndev, budget, q);
-	if (work_done == budget)
-		goto out;
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -1360,6 +1358,9 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	netif_wake_subqueue(ndev, q);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	if (work_done == budget)
+		goto out;
+
 	napi_complete(napi);
 
 	/* Re-enable RX/TX interrupts */
-- 
2.39.2


