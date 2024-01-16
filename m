Return-Path: <linux-kernel+bounces-27821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1382F661
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034B0283D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BCC31732;
	Tue, 16 Jan 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMfMvhYU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1755200DB;
	Tue, 16 Jan 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434286; cv=none; b=LgHwA0Sny8n54Oy5uUI46voi1Y/4N3cKWZDiS9RYCXFhGPirJdi1L8hZvsbxJehJ5l75sir62z6+pN6ztBMR3UphQXJcFV4wjptCjPRg3harMMaXEHnHx4agxD5l/knQ56wDDaHuHyaHwH9Pknvr/f7Qv4zkhoiQYxdqA7j8FNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434286; c=relaxed/simple;
	bh=B6vfzVnC/GrAGTLt3GQNzuN97eOxeLSK0sZPBZpGPhE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=TjNetgvWQux61MqKppJXw5CNSR/qiN/V4BgpZFlTybWOrp0IAcJzKoPuxVlgxbqj8SqjuoBCxbvL6Os1NiK2288rF6lcGciDHJOeHUN1YFiWfVNc3iEy+Lm+nel/oPybUMIoABqdWj5uEZEWG4kP1f6zTIaRufTBS9bf3O8gGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMfMvhYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA43C433C7;
	Tue, 16 Jan 2024 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434285;
	bh=B6vfzVnC/GrAGTLt3GQNzuN97eOxeLSK0sZPBZpGPhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMfMvhYUQuDF09qA5lCQwLh/geRyqLrcuTN4uiZ8ZxzVQUfmfiP1gIetkDCo9UpL5
	 x+sDbz3ZqcBLwxd/6wexOhe8zLD9wUIB8koaWQbuaU7xW73laLFn4yNyQBuhYPPl5Q
	 0rIkUQicAIV1uQ7rqQM+rzW0d69OEwLeVdDcBHlsifeYMXzmHyV+uv5tTxgN/0M/by
	 AbUzoDU3FzRPNyZRrNDMzMkBwHFinpO/fQ1LMdC74YL7tuHmSMy0pjMW4iQk5gbkyR
	 ukdi9n+DCDKEbLlfhzzgm6jy0SpcilmqIxkzvP3o0gZ2E6T39BaJm4EIVd40SH4zkJ
	 8E4fy4131lgYQ==
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
	andrew@lunn.ch,
	bhelgaas@google.com,
	maciej.fijalkowski@intel.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 050/108] net: wangxun: fix changing mac failed when running
Date: Tue, 16 Jan 2024 14:39:16 -0500
Message-ID: <20240116194225.250921-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 8db804543e66..a5c623fd023e 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -582,6 +582,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = WX_MAX_JUMBO_FRAME_SIZE -
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 526250102db2..a78da2309db5 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -638,6 +638,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = WX_MAX_JUMBO_FRAME_SIZE -
-- 
2.43.0


