Return-Path: <linux-kernel+bounces-46870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585298445A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BA9294E80
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C2913B79A;
	Wed, 31 Jan 2024 17:06:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048C413AA57;
	Wed, 31 Jan 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720778; cv=none; b=a74aVr7naPU6y1ByxqrB6cqNGV6aEAbeGsGW9mE95Y/e/nJmo+Y7CxAg/PLrxo2lBeR/M/FaMh8oGZehDnHrmMgM04fwVWHmp9vQF9wjqUvjx8RwyVJZFt42dvvutGUCRNlRJ5D+WtKgWvGpfX56EeYwzweFAJzbSiYLd74/2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720778; c=relaxed/simple;
	bh=+zP2Yfb+XDrqENpMYSAPO48dniuvwW7PYMvOK0s1V/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVesUzeCeuIlCLiHxTd4pLBANfXDFi53Jq0NlH/0rfDCZQ/22C4rWtpaHFJ/lPh4nNRIgCTJ6pWoq8fnRIKq9X0raywry/2d2FSoOfSYTTEqElFZiZf/f9cBSKOw82+J3tNZcwbfjvqTTXHvNvo/u0VHGSstw/MT9A3pN/xR19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="196315550"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Feb 2024 02:06:15 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.158])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0D61440344FE;
	Thu,  1 Feb 2024 02:06:11 +0900 (JST)
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
Subject: [PATCH net-next 7/8] net: ravb: Enable SW IRQ Coalescing for GbEth
Date: Wed, 31 Jan 2024 17:05:21 +0000
Message-Id: <20240131170523.30048-8-paul.barker.ct@bp.renesas.com>
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

Software IRQ Coalescing is required to improve network stack performance
in the RZ/G2L SoC family and the RZ/G3S SoC, i.e. the SoCs which use the
GbEth IP.

For the RZ/G2L, network throughput is comparable before and after this
change. CPU usage during TCP RX testing dropped by 6.5% and during UDP
RX testing dropped by 10%.

For the RZ/G2UL, network throughput is generally increased by this
change (results obtained with iperf3):
  * TCP TX: 2.9% more throughput
  * TCP RX: 1.1% more throughput
  * UDP TX: similar throughput
  * UDP RX: 41500% more throughput

For the RZ/G3S we see improvements in network throughput similar to the
RZ/G2UL.

The improvement of UDP RX bandwidth for the single core SoCs (RZ/G2UL &
RZ/G3S) is particularly critical.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 9e9cf0d36d72..da2c09b14389 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1078,6 +1078,7 @@ struct ravb_hw_info {
 	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
 	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
 	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
+	unsigned needs_irq_coalesce:1;	/* Requires SW IRQ Coalescing to achieve best performance */
 };
 
 struct ravb_private {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c3a5e4bb61f9..483993ec25ba 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2684,6 +2684,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.tx_counters = 1,
 	.carrier_counters = 1,
 	.half_duplex = 1,
+	.needs_irq_coalesce = 1,
 };
 
 static const struct of_device_id ravb_match_table[] = {
@@ -3028,6 +3029,9 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->nc_queues)
 		netif_napi_add(ndev, &priv->napi[RAVB_NC], info->poll);
 
+	if (info->needs_irq_coalesce)
+		netdev_sw_irq_coalesce_default_on(ndev);
+
 	/* Network device register */
 	error = register_netdev(ndev);
 	if (error)
-- 
2.39.2


