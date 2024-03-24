Return-Path: <linux-kernel+bounces-115895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE3889901
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87962B27A93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26D3386614;
	Mon, 25 Mar 2024 03:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnZi47m6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9F537E9;
	Sun, 24 Mar 2024 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322087; cv=none; b=Pm/SV8qRyCU9x1DNhOdKEhdVvYkYXQEl10gBaJUyLvLweT3q9LOsyNlhQdiWGIJGtf0RIb41ApZ8hfEdKXVwS4R11X6nyrcQ1y6GT4P4sMIqlAjk23PJOe/lGShSFzvHHcCwbUvflSgmsqgoYCnrSy69GLBABAKyG1z5YD0mi8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322087; c=relaxed/simple;
	bh=m/Rxmhe3KFCR8yGWDqhgjwHUtAA64+m5mpxe/gXkem4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMhiUKb8yASe47V+73/wsRVeWcGRnMiZE8NMqJ9CJ9DkVP/Q0wiClu6L6ulZpF/e1vmOwW4BXoK1dQ+vDhaplqruPIsgGuSKG3PGd+VG7zQ28o7fsTx0oBWm2XcyAxUm/hep3PrRuzVyPvItVc1J/6Ye5mEEqkiZbNUPxO72UBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnZi47m6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D43C433C7;
	Sun, 24 Mar 2024 23:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322087;
	bh=m/Rxmhe3KFCR8yGWDqhgjwHUtAA64+m5mpxe/gXkem4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnZi47m6/V2aOLy1LrwtarpGcRV4TWVG2yDAPqAznkPznbqAS6/dGyUO4CSYurXVK
	 6Jkv+7sQqegDFeo22Byoa6Pn37cSZsGVmgR99csSUykYeR20QU0Jy76qS2fo1HhYQL
	 AAM72l4+jIGCRh0YUm773NgJU46jKB9xWAiCeyB8qHsvfCk4Hoi+ADLDwRDhMX+o5q
	 YaH2IOn3z9tunhgfVEh0UOBaNFjEk9VbStIij0MX30dxfF96sLpzG/CesTY2xOp1gg
	 5zf7MRFepSHbuL/lTHl4eRMS3ejAGh/udPcyHbK60ct1PnHDMw69RtAYLJ509G8yod
	 pWF0Fjd0fHzPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kamal Heib <kheib@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 161/451] net: ena: Remove ena_select_queue
Date: Sun, 24 Mar 2024 19:07:17 -0400
Message-ID: <20240324231207.1351418-162-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kamal Heib <kheib@redhat.com>

[ Upstream commit 78e886ba2b549945ecada055ee0765f0ded5707a ]

Avoid the following warnings by removing the ena_select_queue() function
and rely on the net core to do the queue selection, The issue happen
when an skb received from an interface with more queues than ena is
forwarded to the ena interface.

[ 1176.159959] eth0 selects TX queue 11, but real number of TX queues is 8
[ 1176.863976] eth0 selects TX queue 14, but real number of TX queues is 8
[ 1180.767877] eth0 selects TX queue 14, but real number of TX queues is 8
[ 1188.703742] eth0 selects TX queue 14, but real number of TX queues is 8

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Kamal Heib <kheib@redhat.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 044b8afde69a0..9e82e7b9c3b72 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3174,22 +3174,6 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static u16 ena_select_queue(struct net_device *dev, struct sk_buff *skb,
-			    struct net_device *sb_dev)
-{
-	u16 qid;
-	/* we suspect that this is good for in--kernel network services that
-	 * want to loop incoming skb rx to tx in normal user generated traffic,
-	 * most probably we will not get to this
-	 */
-	if (skb_rx_queue_recorded(skb))
-		qid = skb_get_rx_queue(skb);
-	else
-		qid = netdev_pick_tx(dev, skb, NULL);
-
-	return qid;
-}
-
 static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -3359,7 +3343,6 @@ static const struct net_device_ops ena_netdev_ops = {
 	.ndo_open		= ena_open,
 	.ndo_stop		= ena_close,
 	.ndo_start_xmit		= ena_start_xmit,
-	.ndo_select_queue	= ena_select_queue,
 	.ndo_get_stats64	= ena_get_stats64,
 	.ndo_tx_timeout		= ena_tx_timeout,
 	.ndo_change_mtu		= ena_change_mtu,
-- 
2.43.0


