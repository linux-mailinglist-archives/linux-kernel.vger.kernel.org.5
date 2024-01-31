Return-Path: <linux-kernel+bounces-46869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC18445A1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E401F219D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B213A273;
	Wed, 31 Jan 2024 17:06:14 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F33137C5B;
	Wed, 31 Jan 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720774; cv=none; b=uoX33JkQQyLKUQTcfBuKYfAT/wC3gr1Npf+gly5z+9CHkxQ7/txQDPPKcBjYFnYCtj2dvw6UtoSyuKp7X47fVsIJme6Ec9C8HgO2eYg0cLyiwVu302fN4McgV0XahjMSUgawLlEzU3ZxsJTJkoDmcIYWYKdDrSOyT+g1tgEWDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720774; c=relaxed/simple;
	bh=Xmw9KV3Egdvfg0TUeQfDphSDxUXsZykmY75UH/aGsXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zg7AKqvopXKiqghYFlym6RmRWJDczcXfvCZHTUb6lelnxKIGamCl9kGhWxml7+UKIriyi0X/9vhBcSxUHRCKfknNfyP9a+2vFWrPm3IA4hm5U4rpvSzXUOgUViumKoY5tFzwFZNtJApmYYZ7uUOIflRBEYMNRU7WssDzHyAr2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="196315544"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Feb 2024 02:06:11 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.158])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D134440344FE;
	Thu,  1 Feb 2024 02:06:07 +0900 (JST)
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
Subject: [PATCH net-next 6/8] net: ravb: Align GbEth poll function with NAPI docs
Date: Wed, 31 Jan 2024 17:05:20 +0000
Message-Id: <20240131170523.30048-7-paul.barker.ct@bp.renesas.com>
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

Call napi_complete_done() in accordance with the documentation in
`Documentation/networking/napi.rst`.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 26 ++++++++++--------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a90e70b25875..c3a5e4bb61f9 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1363,23 +1363,19 @@ static int ravb_poll_gbeth(struct napi_struct *napi, int budget)
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


