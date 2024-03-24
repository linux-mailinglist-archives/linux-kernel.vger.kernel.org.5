Return-Path: <linux-kernel+bounces-116030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551808895DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC8BB3B5A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C25726CC25;
	Mon, 25 Mar 2024 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq4r6Gny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F5175CAA;
	Sun, 24 Mar 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323407; cv=none; b=oFtjSmGpkF2K8y5C8TIVji3beUhSOyaST347nJ2NOJVYPRg2LVPiGh9fioHMpiDTc5RV5X15MEb5XeEDEMqLTxQRWAWdbYUvwRURitC/JCjLsEX0R2mvTmvHjPVtiQ7locbJzCCiMpDmUkkp6iKiGf+yG/+XxZoKq5iusnFrC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323407; c=relaxed/simple;
	bh=BVOqvSyGtKmf/122ACtzVkhhLsTLB3szaQSQ0zvlj5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8MOct9dlltuzxeRNYRocgBBZfmRhbH+VmYQacmtdzTMaMLp5ePgmCRMnWeUTFUYoA3K6I919ltLzhMYWsouH5O9MBpI3GnP1zk4ESfoe4ZvS/I8bSoZtVy0ROf5FapX/uENxp70aELDGMy2k9n9sb/W/f1VvaBy0IPs/c5RQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq4r6Gny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87770C433B1;
	Sun, 24 Mar 2024 23:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323407;
	bh=BVOqvSyGtKmf/122ACtzVkhhLsTLB3szaQSQ0zvlj5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kq4r6GnyS0Ob70h+LgEfGgcyul54KPbsbN2vMyg8WyA3cRhwLZq+XKLqEFASR940I
	 j6kbdiFrC01p7xDmSfK34ZLH1HGLAnqmxEAZFUWZ0jKcTbEC/BJMM0iqNKzEYdbixI
	 aG1dBNaN8yxjRpwu9mG0oRJvuC/gufZz2bVb8q2oDWGlf+4XJQGV6MqMqSxmMlR4HE
	 X7MDPMkjYPKAd4x/biJUcIjpu/qZSua9dwg0MJ2IeSf8utV74UaYHSJy/GwqHLoCZR
	 g2HZOZrJBvxAIPNHKCKk/hJRPxCyjfDKHNnEsGLOilrz6YiX4xVYLzlkl+gsuxUuPm
	 kskv4y2Ok+vQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kamal Heib <kheib@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 108/317] net: ena: Remove ena_select_queue
Date: Sun, 24 Mar 2024 19:31:28 -0400
Message-ID: <20240324233458.1352854-109-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 7d4b862be783d..43c099141e211 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3187,22 +3187,6 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -3372,7 +3356,6 @@ static const struct net_device_ops ena_netdev_ops = {
 	.ndo_open		= ena_open,
 	.ndo_stop		= ena_close,
 	.ndo_start_xmit		= ena_start_xmit,
-	.ndo_select_queue	= ena_select_queue,
 	.ndo_get_stats64	= ena_get_stats64,
 	.ndo_tx_timeout		= ena_tx_timeout,
 	.ndo_change_mtu		= ena_change_mtu,
-- 
2.43.0


