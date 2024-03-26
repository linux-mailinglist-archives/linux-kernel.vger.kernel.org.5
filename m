Return-Path: <linux-kernel+bounces-118560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303BB88BC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F861F34216
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B88C125B9;
	Tue, 26 Mar 2024 08:38:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69E2114;
	Tue, 26 Mar 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442291; cv=none; b=r4EpK2EZRa3YHN/TmTzPxWmNU8yfkVEhxi3BlVFxFT/Dvb3+CYqz82hPkxr0zs+bojbjLJtcdqXgz0Eq8m/msv6kK21Hy14okMQ/7yoA7yOVCChP5ge23SinMLqs2xevfrv8/ieY4SJvYMCU8Wo+Ta3ukZ/XqO+FrB2OyNMM1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442291; c=relaxed/simple;
	bh=zRSQJ6WGPCwUjhMT+4T16q3Tfzhz94Gd+n+XYSLM2Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XknMReWL/LSkpzZRnPg6cbBfBKbE+oCjQwBPAMMhfaQynWW+QFB9in/QfH8wors8NY+95OCF1PDTmVEWT+6POACNE78KyDltyd7DCtY88LXDjHSock4E69YdzHBFLsV8yzM+WQG62+ezeXO/mPbPlcMEIwTwfnweXZ0gxmH97BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,155,1708354800"; 
   d="scan'208";a="199297022"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Mar 2024 17:38:07 +0900
Received: from renesas-deb12.mshome.net (unknown [10.226.92.201])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B9CB24006DEF;
	Tue, 26 Mar 2024 17:38:03 +0900 (JST)
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
Subject: [PATCH 1/2] net: ravb: Always process TX descriptor ring
Date: Tue, 26 Mar 2024 08:37:39 +0000
Message-Id: <20240326083740.23364-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
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

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index d1be030c8848..4f98e4e2badb 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1324,12 +1324,12 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	int q = napi - priv->napi;
 	int mask = BIT(q);
 	int quota = budget;
+	bool rearm = true;
 
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (ravb_rx(ndev, &quota, q))
-		goto out;
+	rearm = !ravb_rx(ndev, &quota, q);
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -1339,6 +1339,9 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	netif_wake_subqueue(ndev, q);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	if (!rearm)
+		goto out;
+
 	napi_complete(napi);
 
 	/* Re-enable RX/TX interrupts */

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0


