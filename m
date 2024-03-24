Return-Path: <linux-kernel+bounces-113724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AB3888643
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751CD28C902
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411B1E9F7B;
	Sun, 24 Mar 2024 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COuN7xny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B01D5F97;
	Sun, 24 Mar 2024 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320707; cv=none; b=h54CcJEi/up2NZw4puERdybctxKsopl4mG6bkrPNzdKlgwWcRMZxaUACp82XZOnALNZiT3ml4WGb28NhVDZp7I8Z7lxFZkaeTdef41uRmcPDcopmirlns32td9uz+XeRv825WdiqJiOmwcpTXgChzPTQHsLWzVb9Qp7sRYfnjvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320707; c=relaxed/simple;
	bh=/W3KWWGDJM94lmVHEzMgu1o4ztowe19RrmIKAEZrIHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQO4Xbae2+pbAtZWNBxquWh9w5f8be5azvf9B6JUzwd7kbdU7fKTw16vQxFlHwohDBHTE3r5gGIv6NUNkPHGm5INJ3vnATycux+KwggFpU3X+WvhZ7qn035Y5sN5h5m39HmIXbKio4F8OA8I8YhitioXCPAllBDZ7ZQDmx44o2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COuN7xny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49633C43399;
	Sun, 24 Mar 2024 22:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320706;
	bh=/W3KWWGDJM94lmVHEzMgu1o4ztowe19RrmIKAEZrIHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COuN7xnyZCXOtPyh8BFc83EK0anUNRfIujtMrl350hd2NM7K9Ijq1YE5Qqp1H8cWH
	 LNhWjujZ+uRcSrhStxbObpHavb30EI3S72IC2s42CU8GoFoBkPpfgL2F4rbkZG7d+1
	 8frI+Y45sFxd/dz1pCXgeuZMsm/ttbO6vWaK5ruf7RhjCZf38lef6fSpiU6u0Qv1Ju
	 EjTHiO/Oonj+IOlXEuZ7OKFF4SVh647uv7Wn7tLmrM12pqxUgcowPCyOM/JdX+Atn0
	 EMkp4zhu+OZim2cWbkGA4N+S3z0vmNXBnPQSU+skPjYvI6aeDu3Aa0MFFH+VhCdco4
	 c4v6dDIHvH2QQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kamal Heib <kheib@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 268/713] net: ena: Remove ena_select_queue
Date: Sun, 24 Mar 2024 18:39:54 -0400
Message-ID: <20240324224720.1345309-269-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index c44c44e26ddfe..4fa27c9a33974 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3238,22 +3238,6 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -3424,7 +3408,6 @@ static const struct net_device_ops ena_netdev_ops = {
 	.ndo_open		= ena_open,
 	.ndo_stop		= ena_close,
 	.ndo_start_xmit		= ena_start_xmit,
-	.ndo_select_queue	= ena_select_queue,
 	.ndo_get_stats64	= ena_get_stats64,
 	.ndo_tx_timeout		= ena_tx_timeout,
 	.ndo_change_mtu		= ena_change_mtu,
-- 
2.43.0


