Return-Path: <linux-kernel+bounces-113103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3332A88817C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78B4B2229D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E86654FB5;
	Sun, 24 Mar 2024 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTF5vTY/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E7156975;
	Sun, 24 Mar 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319911; cv=none; b=FeRfj12pSS9PsNhgUMO+C3NyaEoSGiQ7E/4CLOUOYwpYkuIc7N8kYhYKnedfaHf6Pdnc/iqbNrvWU81Fk801poO6AgUNc5cS3uknK9U4u+oDzvXhWl0Hbvdgjj7zcvL8tfKhkpJjwVP9jvgtzMtONmYAvaxCbHl688LthrewThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319911; c=relaxed/simple;
	bh=dhlXIN0G772gb/0OtjhjujHY758spByvfKEwk4FRehk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZQCNng203bvguRpB3sz+77uKt1fyJsgyDTzU7w7CLBugy21dcmbOtkXkR4pGpBLOb0Bt3eW+9TWXgJZwsEwH7dWiSlVK6/LSSYgdgnLSv85p8y2KycRIHL7q+xtDWPC3RbUUD1fHzNAcDT1NcKFawku9gvLJwdrbJT2Z1CqfV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTF5vTY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEDEC433C7;
	Sun, 24 Mar 2024 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319910;
	bh=dhlXIN0G772gb/0OtjhjujHY758spByvfKEwk4FRehk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTF5vTY/GGloIgBVEYE3wf/7kIW3NloVGRIFKyJ+jIlBZZYDg+WhsiWi2spV6FwO0
	 bdji7kpOEsXAvWWsmN17Q8NSSuIh1mniL5RLmjl5FyuuWIhBZR47BS8AC9fVMAPuuj
	 dyA352fstddMTTytD92nU9bp/Z6vghpxuy8PqyY1MFSE1CDsap3TTq+icDZf7zAvMp
	 MhcPttQRuYT4Dd5dgrsHgnPZonmZE78Dja2EZ0CipnHQr7uPtXISZr3mBrMm7Heq6n
	 hQp19h4Ngm1RixVibKokAnjHL44WwxPit8e0vvkw4jo1zoPYPwJT5pr10imfqeux1I
	 opCbZrWd7XeLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kamal Heib <kheib@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 216/715] net: ena: Remove ena_select_queue
Date: Sun, 24 Mar 2024 18:26:35 -0400
Message-ID: <20240324223455.1342824-217-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 1c0a7828d397b..5482015411f2f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2670,22 +2670,6 @@ static netdev_tx_t ena_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -2863,7 +2847,6 @@ static const struct net_device_ops ena_netdev_ops = {
 	.ndo_open		= ena_open,
 	.ndo_stop		= ena_close,
 	.ndo_start_xmit		= ena_start_xmit,
-	.ndo_select_queue	= ena_select_queue,
 	.ndo_get_stats64	= ena_get_stats64,
 	.ndo_tx_timeout		= ena_tx_timeout,
 	.ndo_change_mtu		= ena_change_mtu,
-- 
2.43.0


