Return-Path: <linux-kernel+bounces-102080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444E387AE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008A92828D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB4C15E5D2;
	Wed, 13 Mar 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijPTWkF7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A415E5B9;
	Wed, 13 Mar 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348462; cv=none; b=KkhqOTHvgche6QxW7/dDoNSD3gqC6g1/OOWwRpPdkoPPTf1NuiYcrSRpWTmG2S6vMYshR2AWwdsEbEO8gMSTVTxGQ29RUaSe2o1ONzSpAm4ZoNq6E6Ks2vSw7r1FRcU5z+HVLWGvTAVd0QN+lzD9BAqOOL+bRk6AqgAiL2jbrmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348462; c=relaxed/simple;
	bh=nhbKbEX9nHakPLpkOIH63yejM4HifZj5GXSMu2I7y9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtYCoatYWaJZ7NkCkLADFEQGghImn+SIzIVsyde34tSeXqbJodnQ+uSXwvlmvYCOKr65eATTwem8M2HOYs04yAGxvEGm/uptuf0/L73sQs7l1pL1X2UqsAetLnpCLXXjzduLzNwwLeom6WqrqZHuFAp9ESDYVdwqhxxXwWOqh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijPTWkF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DB9C433F1;
	Wed, 13 Mar 2024 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348462;
	bh=nhbKbEX9nHakPLpkOIH63yejM4HifZj5GXSMu2I7y9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijPTWkF7TGi52oKap6TAmKdGpaZOMbi+n7cm54b3La3+jEhBRi+TLNUTf75opL3xT
	 tFtsDw3+aTEj8FVvuR5FxOmlGKB1mg1ReHF/EmKPyytqAA2cS1BshUE8YALP6nTcOB
	 6B6FLWI40E7aPZ1/QizAnkaISy0KCZ+5fgvQ0RR20AI67Gil48eyEuaAYun4wfWu52
	 bXscbzWS5uDXSvJqSZTh11TtuJhBEXyvFaGCI2L32jT0ZmFfDsAV0zAa1lekL+SN+U
	 jQSofgz7qb3/QLvpG+cJ/5wigtc8SAONfevNklVni4pWONEc+rCguORhJH04btmlxg
	 wsJW1Y5W+2a4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 54/73] hv_netvsc: Process NETDEV_GOING_DOWN on VF hot remove
Date: Wed, 13 Mar 2024 12:46:21 -0400
Message-ID: <20240313164640.616049-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Long Li <longli@microsoft.com>

[ Upstream commit 34b06a2eee44d469f2e2c013a83e6dac3aff6411 ]

On VF hot remove, NETDEV_GOING_DOWN is sent to notify the VF is about to
go down. At this time, the VF is still sending/receiving traffic and we
request the VSP to switch datapath.

On completion, the datapath is switched to synthetic and we can proceed
with VF hot remove.

Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 9cae43da9867 ("hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 57a5ec098e7e0..057b1a9dde153 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2411,12 +2411,15 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
  * During hibernation, if a VF NIC driver (e.g. mlx5) preserves the network
  * interface, there is only the CHANGE event and no UP or DOWN event.
  */
-static int netvsc_vf_changed(struct net_device *vf_netdev)
+static int netvsc_vf_changed(struct net_device *vf_netdev, unsigned long event)
 {
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
 	struct net_device *ndev;
-	bool vf_is_up = netif_running(vf_netdev);
+	bool vf_is_up = false;
+
+	if (event != NETDEV_GOING_DOWN)
+		vf_is_up = netif_running(vf_netdev);
 
 	ndev = get_netvsc_byref(vf_netdev);
 	if (!ndev)
@@ -2762,7 +2765,8 @@ static int netvsc_netdev_event(struct notifier_block *this,
 	case NETDEV_UP:
 	case NETDEV_DOWN:
 	case NETDEV_CHANGE:
-		return netvsc_vf_changed(event_dev);
+	case NETDEV_GOING_DOWN:
+		return netvsc_vf_changed(event_dev, event);
 	default:
 		return NOTIFY_DONE;
 	}
-- 
2.43.0


