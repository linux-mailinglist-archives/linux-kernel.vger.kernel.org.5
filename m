Return-Path: <linux-kernel+bounces-124546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C838919B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2801C24D82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343BA14A4F5;
	Fri, 29 Mar 2024 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIjXq1uF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7C514A4D8;
	Fri, 29 Mar 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715350; cv=none; b=Dy0uAtyO11lY0C+Sxet7fVCTc4hsvOYrWAf47DE4cky1yTC8aFEB8ZslDOvFVQa2xshiPqEtYvhwXLBpu4MGfEFSVIpSIsJ3IoJFD0D8ar1xtFz+ifeAnaIbyCMkIHUUSD/pvOloPzQ8pePqtafjNVVsLatUTe6VAvdOa/v2VUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715350; c=relaxed/simple;
	bh=4+My7TVnqb+XSwV5DqQBcNUF1++LB0p2QZlH7Y+9RbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpCVy6B1vW7FN/HVHa23vIFFEQBjDsKfQD7ZTcO0phThtMsSroeUzcaSFIsH3un73isSDbf3JRJcR138guKUbC4yqPH2LbNM9O8scp1HXBJDKetZgAnj9gvb9JE4pKUFcCTVpSDRd7osswsPWyIbdoHRyMIuiEgZHLcQ6AUd0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIjXq1uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF86C43399;
	Fri, 29 Mar 2024 12:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715350;
	bh=4+My7TVnqb+XSwV5DqQBcNUF1++LB0p2QZlH7Y+9RbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIjXq1uFoKvFvL98mBFRtW3vSmISEOI4XuQ8U/YWWiaS7gDUaBimcXPVOUtDD2B9L
	 xlbWbX2FQNznHzXciSJw5PUP+mKf5u1aXKWL/PbjnEpOTNoClw+v70jF7GVTCPOb9p
	 ulKElsxHomJ82AYfCD0TQztWDBJvKbSKtnZX2opOurShukxL/yfhGEDWunxRZn9gZV
	 GcqkWUWOI+Il1fqaMxcIH3l5QCC9LpD1Fx2Cb4rafruftTvqxqcHyer5Ga42sj2JVW
	 GooN6UjlGVi/Qh1QYh0ysdLdXNwhN6wEGZToqU/nZAPBWvTth5TZOOecfIauNAA6N8
	 aijlK/4jYYnkA==
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
Subject: [PATCH AUTOSEL 6.8 64/68] net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()
Date: Fri, 29 Mar 2024 08:26:00 -0400
Message-ID: <20240329122652.3082296-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 9f2c58c5a86b7..2adb92b8c4699 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -806,6 +806,16 @@ static void smc_pnet_create_pnetids_list(struct net *net)
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


