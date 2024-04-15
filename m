Return-Path: <linux-kernel+bounces-144862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB558A4BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF036287507
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB2657875;
	Mon, 15 Apr 2024 09:48:47 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F050F5810D;
	Mon, 15 Apr 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174526; cv=none; b=N2kD3pDxcmIr0/LJyuze1oAE78MUESSGA0jbLMbkPHXIkTCrV/Q2Ec2suMgXTJVjgNXlYgD75UaJbDDiLT74i5JgvNc605I7xon7pOM9aVc6Euybxea/zJjaaFhUwg3VeJQTCoqpvCmBxnZ0x2804w0HtNMa01A6ALe1HD63RBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174526; c=relaxed/simple;
	bh=X6lYavWy79tCYcp+pVwRpetbT7q8jO8kWdKXbffGxXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OtyREGeMgnr7F2nHvRZeNjElVwMD7+InGowBzAHh/UL/yPQPpYZVpfJpi6fTIEm8IWH5wT3aW8EYvcEmdyufF51Oa9BzewJvAynHIKlrTWrJpwfZ0gFomCDxwUKIx2i4G/5sNDe3o5NgAncIdyf48UM+Bt8hc+giwJp0LWRfBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="scan'208";a="201479155"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Apr 2024 18:48:43 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.74])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0A3EC4006DE8;
	Mon, 15 Apr 2024 18:48:39 +0900 (JST)
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
Subject: [net-next RFC v3 6/7] net: ravb: Use NAPI threaded mode on 1-core CPUs with GbEth IP
Date: Mon, 15 Apr 2024 10:48:03 +0100
Message-Id: <20240415094804.8016-7-paul.barker.ct@bp.renesas.com>
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

NAPI Threaded mode (along with the previously enabled SW IRQ Coalescing)
is required to improve network stack performance for single core SoCs
using the GbEth IP (currently the RZ/G2L SoC family and the RZ/G3S SoC).

This patch gives the following improvements during testing with iperf3.

  * RZ/G2UL:
    * TCP TX: +32% bandwidth (638Mbps -> 841Mbps)
    * TXP RX: +8.8% bandwidth (667Mbps -> 726Mbps)
    * UDP RX: +104% bandwidth (53Mbps -> 108Mbps)

  * RZ/G3S:
    * TCP TX: 29% bandwidth (529Mbps -> 681Mbps)
    * UDP RX: +1290% bandwidth (6.46Mbps -> 90Mbps)

  * RZ/Five:
    * UDP RX: Test no longer crashes (0 -> 20 Mbps)

This patch gives the following reductions in performance in the same
testing:

  * RZ/G2UL:
    * UDP TX: -7.5% bandwidth (594Mbps -> 549Mbps)

  * RZ/G3S:
    * UDP TX: -5% bandwidth (625Mbps -> 594Mbps)

These losses are considered acceptable given the benefits shown above.
If UDP TX bandwidth must be maximised for a particular use case, NAPI
threaded mode can be disabled at runtime via sysfs writes.

The improvement of UDP RX bandwidth for the single core SoCs (RZ/G2UL &
RZ/G3S) is particularly critical.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 26b70b996bd3..7434faf0820c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2938,8 +2938,11 @@ static int ravb_probe(struct platform_device *pdev)
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


