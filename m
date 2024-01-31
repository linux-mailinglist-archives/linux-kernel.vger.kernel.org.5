Return-Path: <linux-kernel+bounces-46866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D5844598
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B9E1F2172D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293112FF8D;
	Wed, 31 Jan 2024 17:06:05 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8FD12C539;
	Wed, 31 Jan 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720765; cv=none; b=iOtmyN/0tHfJRBFDCcQYC59Ei4E5pzwLujs381fTRpnubc3pyhuc/8kNsFivWbMNnpydy1ypMFNVwbaj6LmD9HGwNkE+e0QefBm1x9mjbl+VR6PTxW7YEL6Swm0IKZPF6ZbJZlK4KZWLtjCjxrTr3YCB2CO/xSpt/VosaZTCyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720765; c=relaxed/simple;
	bh=mvngnWhUGFgDKAimI+Ks/pS3pEFP764zRzb5IWxzsLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XO+6qYdeew1F24THDOJuzp84Xr1HlaLzHQy5+WshAMjEolSPKBshv3LV6hcGYTS6v+3Ophnd+dhi9meUNvV1ZRsqDi3uFqZRW2lrBJuQ4h2qds7dHXym7dyRumRCcQqENNjXN5Mz37qKPJR+tB3UOw+ftLMuJtMcRThuEUBEM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="196315533"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Feb 2024 02:06:03 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.158])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 760E440344FE;
	Thu,  1 Feb 2024 02:05:59 +0900 (JST)
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
Subject: [PATCH net-next 4/8] net: ravb: Always process TX descriptor ring in GbEth poll
Date: Wed, 31 Jan 2024 17:05:18 +0000
Message-Id: <20240131170523.30048-5-paul.barker.ct@bp.renesas.com>
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

The TX queue should be serviced each time the poll function is called,
even if the full RX work budget has been consumed. This prevents
starvation of the TX queue when RX bandwidth usage is high.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 077c189bcc6f..9b0ed269e69b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1345,8 +1345,6 @@ static int ravb_poll_gbeth(struct napi_struct *napi, int budget)
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
 	work_done = ravb_rx_gbeth(ndev, budget, q);
-	if (work_done == budget)
-		goto out;
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -1356,6 +1354,9 @@ static int ravb_poll_gbeth(struct napi_struct *napi, int budget)
 	netif_wake_subqueue(ndev, q);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	if (work_done == budget)
+		goto out;
+
 	napi_complete(napi);
 
 	/* Re-enable RX/TX interrupts */
-- 
2.39.2


