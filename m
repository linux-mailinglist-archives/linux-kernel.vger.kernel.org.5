Return-Path: <linux-kernel+bounces-27959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E36A82F856
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16A61F2622D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED6313172B;
	Tue, 16 Jan 2024 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3ivBYF8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37524B54;
	Tue, 16 Jan 2024 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434690; cv=none; b=SafSoQOcOS36AJdSXLrJ8/xZ0/ulPXWIY9TLdswwerXwRpHn4jP6V7Ah5maLn2huIc2q/WlUHrGgdBCiAstBGGhLDyF5DCXWPVbLMzAUmNCe7Fs3D98aVPzfL2YE+qFoxtIN54guGb/D/S5FNOi9RsQvS/QiECCnqtPnOebLRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434690; c=relaxed/simple;
	bh=BtqA+sNM66b7KK6xY6BvU9nMAVkX1m27+Hn1UAJLH6I=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=D087vg1AEstZRsCxh9mqWWCKAJdX66WRlrRFxHNJRHjymtPKsgLhd4qxFYp13o4c8DeWvX1VVtNzazjXdlPiEVxtMG2iAgukNmI/cKrUUG4VPDPbOdsgBOQ1Cqmk177H8DvnNBrOhjsiiWe0/BMOUOxn7LVVijvxGtzVONJ1xT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3ivBYF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0A4C433C7;
	Tue, 16 Jan 2024 19:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434690;
	bh=BtqA+sNM66b7KK6xY6BvU9nMAVkX1m27+Hn1UAJLH6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3ivBYF8+ZfglOggXQY6KJXkhCccMKNjJycz+oNjFXzZiljnbzf2LVmcfGnLOXE8s
	 T9+n/IncH+Vwzjuginpv7ovLbrUBJ9SvU5/Ip22xj3cSLtJKDvTZYZZMHkdSslyYCY
	 Wp3PcDMLhW6rUlqFnOjw3qH2zdbl+xaN9oinrIq9NHaRHgLWG9NPBCAFEudOybW3H+
	 bdSRB3H1ogLWb2UdJvDdsuSaQNCz3HWaaLWOqIDGgFNtJCke8Zz/4UGSdWIndGSuZL
	 lzI7Bh3guIpzssupWy1WTzd5SI51n1lCQ8O2YT9RzQDliR+quRbUFq27CkNdnVgUpJ
	 8MvExmnFNCKUw==
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
Subject: [PATCH AUTOSEL 6.6 049/104] net: wangxun: fix changing mac failed when running
Date: Tue, 16 Jan 2024 14:46:15 -0500
Message-ID: <20240116194908.253437-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index a4d63d2f3c5b..2085b9c38a15 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -580,6 +580,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = WX_MAX_JUMBO_FRAME_SIZE -
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index d60c26ba0ba4..2482b661bc99 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -637,6 +637,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = WX_MAX_JUMBO_FRAME_SIZE -
-- 
2.43.0


