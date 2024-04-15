Return-Path: <linux-kernel+bounces-144860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B373B8A4BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B5A286D21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF75786D;
	Mon, 15 Apr 2024 09:48:41 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B036F5733B;
	Mon, 15 Apr 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174521; cv=none; b=CnuFnJ/NevPbi4ZiNLMdjZ5s88Nh7/R4bgMUSz1ll5zkm3q9lrbzH3Ohx2P/pxUvGOilgG1tA1+MccxLSLm3eTdbT9riiNpIP78Nqzk2C2Qxlg2tscSyCH321vcDbVi5CJ/9ttHNhO5Gjup6L2yxdwC2z+g2SOT/dkGPQ6uPQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174521; c=relaxed/simple;
	bh=0a8sFtUoHMxGNk6So9B9U41s6UQbV0WO1sQRMmFABA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKLl+cP1fo0rFd+r9Xf5ruEhzL7kjOkAK+K0QgIaxfPRLEuKGIZlITXRUE0T/6/0g6CNrX/EaB9Rhx+s1BH5dUmYsQFE3Wb+c7qvUIXPIHOpN3B64gNcdOnS4sS9JOwHTKsxYrRZgCpwxqujK02bHbQJ0tsB7ndueZz+2py9ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="scan'208";a="205432172"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2024 18:48:39 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.74])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9386E4006DE8;
	Mon, 15 Apr 2024 18:48:35 +0900 (JST)
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
Subject: [net-next RFC v3 5/7] net: ravb: Enable SW IRQ Coalescing for GbEth
Date: Mon, 15 Apr 2024 10:48:02 +0100
Message-Id: <20240415094804.8016-6-paul.barker.ct@bp.renesas.com>
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

Software IRQ Coalescing is required to improve network stack performance
in the RZ/G2L SoC family and the RZ/G3S SoC, i.e. the SoCs which use the
GbEth IP.

This patch gives the following improvements during testing with iperf3:

  * RZ/G2L:
    * TCP RX: same bandwidth with -6% CPU load (76% -> 71%)
    * UDP RX: same bandwidth with -10% CPU load (99% -> 89%)

  * RZ/G2UL:
    * UDP RX: +4200% bandwidth (1.23Mbps -> 53Mbps)

  * RZ/G3S:
    * UDP RX: +425% bandwidth (1.23Mbps -> 6.46Mbps)

The improvement of UDP RX bandwidth for the single core SoCs (RZ/G2UL &
RZ/G3S) is particularly critical.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 71de2a7aa27c..9c6392ade2f1 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1054,6 +1054,7 @@ struct ravb_hw_info {
 	u32 rx_max_desc_use;
 	u32 rx_desc_size;
 	unsigned aligned_tx: 1;
+	unsigned needs_irq_coalesce:1;	/* Needs software IRQ coalescing */
 
 	/* hardware features */
 	unsigned internal_delay:1;	/* AVB-DMAC has internal delays */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 12618171f6d5..26b70b996bd3 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2663,6 +2663,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.tx_counters = 1,
 	.carrier_counters = 1,
 	.half_duplex = 1,
+	.needs_irq_coalesce = 1,
 };
 
 static const struct of_device_id ravb_match_table[] = {
@@ -2937,6 +2938,9 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->nc_queues)
 		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
 
+	if (info->needs_irq_coalesce)
+		netdev_sw_irq_coalesce_default_on(ndev);
+
 	/* Network device register */
 	error = register_netdev(ndev);
 	if (error)
-- 
2.39.2


