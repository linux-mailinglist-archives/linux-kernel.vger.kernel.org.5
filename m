Return-Path: <linux-kernel+bounces-124677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B782891B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90D21F2B0E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A0D171082;
	Fri, 29 Mar 2024 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPS4uExo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D0170A2E;
	Fri, 29 Mar 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715675; cv=none; b=XqGoK0Cq3hYPUj/z5z/5rQEGj/0OXVDXx4K5HxspV5ar8JU20km4T1gvrFSHL64H53ZL2cDj6qGB55pUv/j6mOPho5t5C7DjjV3MXxNi5YG4ZHd3xUkf7XrUeXCrw/01m6SjgNcAp7aCb7tIYiZHavLgXMk3AQYMQWoNrejadaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715675; c=relaxed/simple;
	bh=vxSUUANd7m4g6XoA75yKSEMka/CZt4z3miE59J4d1vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WS7N9t1sssIRc8RysTCgoihMdxfZB2DesSWPJN0873w36xDUr6NO6X47stNS/jKk2e3TEE5VrPkHVTv30GQSt1AyzqZKpk0CF/+besdpdxQ3llpJZWb+XSUQVhcSyR6ecYf+JwMv1ZrB/VIUKQHiMuvpicabJ1oK3MXTOPjdGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPS4uExo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FD5C433C7;
	Fri, 29 Mar 2024 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715675;
	bh=vxSUUANd7m4g6XoA75yKSEMka/CZt4z3miE59J4d1vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPS4uExoOXRIrbtTvkMk3GbqKsupck1DXhA4fp4nXo5rn3WlzM8Z5xVKMAyrDuSel
	 nXknb4tFs1yW2rYjLopQrnlGvqrQtCOGaVMAN6XHtH0Zdm0IQHJJh1w/kBExbUmNBm
	 bbNGJSjkVTIndtp79oCuKc5NgOQ2ERZ0AZg3Tzml0PO/NOjkiVevZH2CNvdxNemUFe
	 c3yEnOzxS7ymCCJ9UoeIFeFGQ22n6ZnbEg+WfeX/6pbhJ5Gycber1Mnnqqs4I8DQZA
	 rNi+H2onz3Mo+DHnFlyUWiInTYc+g4NAEBtWMQD4ZGf/Tz8DODjvjwuxaadAyUoo5w
	 OqhT4fACCye7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/17] net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()
Date: Fri, 29 Mar 2024 08:33:55 -0400
Message-ID: <20240329123405.3086155-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 00af2aa93b76b1bade471ad0d0525d4d29ca5cc0 ]

Many syzbot reports show extreme rtnl pressure, and many of them hint
that smc acquires rtnl in netns creation for no good reason [1]

This patch returns early from smc_pnet_net_init()
if there is no netdevice yet.

I am not even sure why smc_pnet_create_pnetids_list() even exists,
because smc_pnet_netdev_event() is also calling
smc_pnet_add_base_pnetid() when handling NETDEV_UP event.

[1] extract of typical syzbot reports

2 locks held by syz-executor.3/12252:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.4/12253:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.1/12257:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.2/12261:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.0/12265:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.3/12268:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.4/12271:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.1/12274:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878
2 locks held by syz-executor.2/12280:
  #0: ffffffff8f369610 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c7/0x7b0 net/core/net_namespace.c:491
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_create_pnetids_list net/smc/smc_pnet.c:809 [inline]
  #1: ffffffff8f375b88 (rtnl_mutex){+.+.}-{3:3}, at: smc_pnet_net_init+0x10a/0x1e0 net/smc/smc_pnet.c:878

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Link: https://lore.kernel.org/r/20240302100744.3868021-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_pnet.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 30bae60d626c6..ed9cfa11b589f 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -797,6 +797,16 @@ static void smc_pnet_create_pnetids_list(struct net *net)
 	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
 	struct net_device *dev;
 
+	/* Newly created netns do not have devices.
+	 * Do not even acquire rtnl.
+	 */
+	if (list_empty(&net->dev_base_head))
+		return;
+
+	/* Note: This might not be needed, because smc_pnet_netdev_event()
+	 * is also calling smc_pnet_add_base_pnetid() when handling
+	 * NETDEV_UP event.
+	 */
 	rtnl_lock();
 	for_each_netdev(net, dev)
 		smc_pnet_add_base_pnetid(net, dev, ndev_pnetid);
-- 
2.43.0


