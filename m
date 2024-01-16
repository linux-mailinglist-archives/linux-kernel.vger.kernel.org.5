Return-Path: <linux-kernel+bounces-28045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B982F980
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C151C25902
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14109144633;
	Tue, 16 Jan 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF26MLiS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C714460C;
	Tue, 16 Jan 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434976; cv=none; b=YhzwrV5JLIkbC+O9n+UVvNiyD4fKCgbtWImlHDY9Un0FOktEa3uXiBoYCXzZ0l6+HJYJY4jOQ5TXc57rdup8pL0nOzsouVGrnV9L0zpFlKxD+j/V21EljjSgsnCxZqkikD7fQJfpll/5ddEg9NU5enqiI9OT6+Azz6iTMNnr//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434976; c=relaxed/simple;
	bh=my2hAf1JuzOvFxLVFh13nb8dXCi71BfPzAZcE75ogyM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Cay+VDkYzH4rWS+Qc+EsQJOYBt4m4vZvOQK3Tp41ER3lTb6NFApRhwGiViA4h8hS7Oq1MD+HJVDWNR7Z+Ch3omkawNPp+RLK0C9F5nhxYtVHAFgiboQi6GNPhTBCb+C6/Ka+jO51WR4jQ7i2HveJi43gAmuUIPSXdPFQFQOjxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF26MLiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59071C43390;
	Tue, 16 Jan 2024 19:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434975;
	bh=my2hAf1JuzOvFxLVFh13nb8dXCi71BfPzAZcE75ogyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hF26MLiSrGW4iSLyY34tqaxLrJYr+b8TlcAqPTWowO7t4TLKDK2owmnWagvJNAdD5
	 86wfxME7tncuIsjxxe8Xv57Hizxk3IZ4VcLV80fpbk7YU9n2pGEUKtjtlSNbZrSdXT
	 AoUnemL1KBRowu8p4HN8nVmqqHeXjqKkoGEF5QhrAkeSKLua2M7vhT/eynB0XA4axL
	 CFgvR+aJbuyICj4UdJX0SBIItw6rMWvXVeqTTZDXJkNVC2/NrIuacOXaLBBNSULgkd
	 26l8LS1NAwK3cV+2IJRdRHCDncyTMWWdjG4nqCu++hdY1SlBtt5/UjQW4rwkxonLNK
	 9ae5cd7/E0eYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: duanqiangwen <duanqiangwen@net-swift.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bhelgaas@google.com,
	maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 27/68] net: wangxun: fix changing mac failed when running
Date: Tue, 16 Jan 2024 14:53:26 -0500
Message-ID: <20240116195511.255854-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: duanqiangwen <duanqiangwen@net-swift.com>

[ Upstream commit 87e839c82cc36346a2cd183ca941316902110716 ]

in some bonding mode, service need to change mac when
netif is running. Wangxun netdev add IFF_LIVE_ADDR_CHANGE
priv_flag to support it.

Signed-off-by: duanqiangwen <duanqiangwen@net-swift.com>
Link: https://lore.kernel.org/r/20231206095044.17844-1-duanqiangwen@net-swift.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c   | 1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 7674cb6e5700..a69d95b6014b 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -96,6 +96,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 
 	pci_enable_pcie_error_reporting(pdev);
 	pci_set_master(pdev);
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev = devm_alloc_etherdev_mqs(&pdev->dev,
 					 sizeof(struct ngbe_adapter),
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index d3b9f73ecba4..8aee1371f9d3 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -92,6 +92,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 	pci_enable_pcie_error_reporting(pdev);
 	pci_set_master(pdev);
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev = devm_alloc_etherdev_mqs(&pdev->dev,
 					 sizeof(struct txgbe_adapter),
-- 
2.43.0


