Return-Path: <linux-kernel+bounces-54576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4460684B0F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00331285E21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B112F38F;
	Tue,  6 Feb 2024 09:19:50 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98712F386;
	Tue,  6 Feb 2024 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211190; cv=none; b=aPVtSolvTgHCUQCFBsoPWzBHkz7EV1SacPjyuv4SInB8HVm9nN3kP43j+T9k6yXe9LMvM7tR7EOiSZaO4wFvdZfQS9/l7F/a+Zw69+B4uchcYQw6ICnY6v9fAadu6KO3ed0/iyyxOUcYX2ioftbVTSsU6GBRwmnh7o46y/I+HRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211190; c=relaxed/simple;
	bh=v30FjsWUe3ZhLh+6uEKl3Kbs4m0Yb16dWTX3b3fdzp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GbynWw0Ew48m1AaJbTPC2Tyf7uRoVT4SAxPnDEQJvJRVIC5fOAKPbMwNP0xlVHTbKPeLKN+EYuT7TquEpfkPG6WDx6iLVLQQSNZ91H6IDBhYArvkGIpkoPMPgI9TnLOode2F6vdNoWBYTux81nMsDEX7jwK1fumhr915XpOl+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,246,1701097200"; 
   d="scan'208";a="196934676"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Feb 2024 18:19:47 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0C8F041B8EF7;
	Tue,  6 Feb 2024 18:19:43 +0900 (JST)
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
Subject: [RFC PATCH net-next v2 7/7] net: ravb: Use NAPI threaded mode on 1-core CPUs with GbEth IP
Date: Tue,  6 Feb 2024 09:19:09 +0000
Message-Id: <20240206091909.3191-8-paul.barker.ct@bp.renesas.com>
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

NAPI Threaded mode (along with the previously enabled SW IRQ Coalescing)
is required to improve network stack performance for single core SoCs
using the GbEth IP (currently the RZ/G2L SoC family and the RZ/G3S SoC).

For the RZ/G2UL, network throughput is greatly increased by this change
(results obtained with iperf3) for all test cases except UDP TX:
  * TCP TX: 30% more throughput
  * TCP RX: 9.8% more throughput
  * UDP TX: 9.7% less throughput
  * UDP RX: 89% more throughput

For the RZ/G3S we see improvements in network throughput similar to the
RZ/G2UL.

The improvement of UDP RX bandwidth for the single core SoCs (RZ/G2UL &
RZ/G3S) is particularly critical. NAPI Threaded mode can be disabled at
runtime via sysfs for applications where UDP TX performance is a
priority.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 7bb80608f260..522df82524ff 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2984,8 +2984,11 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->nc_queues)
 		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
 
-	if (info->needs_irq_coalesce)
+	if (info->needs_irq_coalesce) {
 		netdev_sw_irq_coalesce_default_on(ndev);
+		if (num_present_cpus() == 1)
+			dev_set_threaded(ndev, true);
+	}
 
 	/* Network device register */
 	error = register_netdev(ndev);
-- 
2.39.2


