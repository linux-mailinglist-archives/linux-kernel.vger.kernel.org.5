Return-Path: <linux-kernel+bounces-124632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E27891ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C6C28804C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777F15EFD7;
	Fri, 29 Mar 2024 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B59uAkC7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690E515EFC2;
	Fri, 29 Mar 2024 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715583; cv=none; b=akU4ejQ8Uivc5TpqEnlR/MOnOuN0vcN9FS8N5ly2mYgyujhK46H61jSRGU+LTaBPvTIdRCTUaGZHomPkMxx7bUlp93qKrMH59i0rvRx0N7cLso1+klYfhOwE3dlBGaQpN7NdnsX/dZslVFRWVichNXw/oCYa3yTSq1vp248wj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715583; c=relaxed/simple;
	bh=0JtsYJXLKTpwPDDeMYYcj8Jdj9ASxamAkp23qC74TwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RetHz6Y0chiYMozTbbj1QoVO9SQswYs7KoiGdKWelmRJpAm53XQ0CDED99gU/UyhYoYMeWGwLAJJl+oCzXMxoI1q6OIoUteZOW/gIJQLVG2ewltoK8U0UTvDlQ7OgjwnpBBglBUPuh1VT/kKGxFiW7KGX0/zDZdOCllSi0n2/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B59uAkC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04E7C433C7;
	Fri, 29 Mar 2024 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715583;
	bh=0JtsYJXLKTpwPDDeMYYcj8Jdj9ASxamAkp23qC74TwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B59uAkC7tmX66qdtUVYOgSoMg0jbOQVUVxTSZVyA5mK+bjpWdZb1iXddAVnry87cB
	 PNbtV0B9jlDSLNJ3XGqVLo+46RK8m7ZSCKI5KyMKyPspS6MEo9ty4jq3UhplRiUbTn
	 YUyzfkv6sWyNUyif/Yw2k6cHthHrDIvH2lyx2UdoyyoNt5/JLUAY70dQhZqRemvAJ4
	 pM3ZnG5x/IdzAK4kkfXJjPobe+LfZZXXdj2d8qITr/4pZ0EJhT9GZ7tXHDAWxfnbew
	 EoAQgTKZGnrWbADexlXFtDc8O7uowSwuJbCKyVMndantTC0SezujbabDi/DOqIS23I
	 zBoz1R8kNQLbg==
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
Subject: [PATCH AUTOSEL 6.1 29/31] net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()
Date: Fri, 29 Mar 2024 08:31:48 -0400
Message-ID: <20240329123207.3085013-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 25fb2fd186e22..21b8bf23e4ee6 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -802,6 +802,16 @@ static void smc_pnet_create_pnetids_list(struct net *net)
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


