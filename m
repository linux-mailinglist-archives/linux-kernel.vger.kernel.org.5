Return-Path: <linux-kernel+bounces-114965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DA08892C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822DE1F2EAB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026BC2DF1C4;
	Mon, 25 Mar 2024 00:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2tdOiR1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261B17A92F;
	Sun, 24 Mar 2024 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323698; cv=none; b=jC+sC3SbRdaroNn+tJjZRdftrayMr4F4K2pi1wMRD40EED44CWjR03n07w7yjMvY3IcWHOocnfRlndSSbzB5YAYWOkE9zuZft/geiLAbuLJ9yzGCpyXgiptlRifJd8vaWJm0ft9fsRetiypjeCO6aQe8Tar5DZFDdS2sYQzRTJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323698; c=relaxed/simple;
	bh=LxXCsMHV06d1AmLDDwEmpwTgUubYkAlaotSgTsXd4QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0A69yHg6quzBo6P2zOng8Qa8cji6E7mlB6wQgua7DLuPH0gHSusTUzjLlonmwZcYQcCVhctCH94BB2tIXeTOIIZfZ2vYLN+msSnpsTchfbwL2VSdUCx1tSaWkvImAZrWq5nVW8qpHkSnF3kn//CuFUCq+H1B0HGsnopNtxrdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2tdOiR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C06C43390;
	Sun, 24 Mar 2024 23:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323698;
	bh=LxXCsMHV06d1AmLDDwEmpwTgUubYkAlaotSgTsXd4QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2tdOiR1i1MXoiSRgosAAZEjycp8sJrC3QhO7fswGib7AlYMb+dcrjVH6chaFIAyf
	 elS+CSWAdt37TuKjd1fJtZrFFscOSwx/K/o9k445ev+MVGXFKTBp8G1O7lZvEX2OtG
	 aNx/WYT/20cKColmJSytAv3Hp+XratwB72i34CZ0gAeVJMxTsUetLYj+7TgBP7C3dw
	 tWjfPezfPQG7GyPDCRy5PauczHBVfMX6kbzH3as11gsFNlWSYppSXB+kONCLMuxihe
	 al/pMAJ4i5QB0A/uvNiJ4KKjfcXSysIz17WlWvAUBb/ujQDM8N0PRekqI/0gjEVXw/
	 sfuP3mh3R5crA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kamal Heib <kheib@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 071/238] net: ena: Remove ena_select_queue
Date: Sun, 24 Mar 2024 19:37:39 -0400
Message-ID: <20240324234027.1354210-72-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index e13ae04d2f0fd..fa65971949fce 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3057,22 +3057,6 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -3242,7 +3226,6 @@ static const struct net_device_ops ena_netdev_ops = {
 	.ndo_open		= ena_open,
 	.ndo_stop		= ena_close,
 	.ndo_start_xmit		= ena_start_xmit,
-	.ndo_select_queue	= ena_select_queue,
 	.ndo_get_stats64	= ena_get_stats64,
 	.ndo_tx_timeout		= ena_tx_timeout,
 	.ndo_change_mtu		= ena_change_mtu,
-- 
2.43.0


