Return-Path: <linux-kernel+bounces-101883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13287AC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E4F1F2B4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471057994A;
	Wed, 13 Mar 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNDdY7pa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3279925;
	Wed, 13 Mar 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348018; cv=none; b=DEXw9ednHPreR/ENwzJy5FOYRqjb8E0VCJhvoEnOuKYmrxIZmo6/AoMiDnNbPdrtX9YnP0MXGcMcoSgLM25CF/OkxkbV1P6XDpKuhm+0RbxtW1XmW/K8MUaWCJJpFjfFkgNLqISzWZh/3oClGr2M2nP35WM9/FxzIbnoehLeXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348018; c=relaxed/simple;
	bh=tsRHJiYDxxkCPdHjI0PXWnTWP/c9nI9bvZSGA3yLzSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3L9oy701RxtjAQFhZUD9Ppr9lI1KKUnXfCZ/1uhJqq7J/6/F3Kd120ZHD8IeP8UdpkKKVqIt91iQdsG6/Pz+nLDEZGR2iXkeecqqleTWg6KxViGMUCBs7GCP5PjqMPFLAON2dFvclV2r2jbMGrZM7We1kbrS9N9ViDrOmabUvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNDdY7pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97710C433C7;
	Wed, 13 Mar 2024 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348018;
	bh=tsRHJiYDxxkCPdHjI0PXWnTWP/c9nI9bvZSGA3yLzSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNDdY7paIh+Ufm6GA95LnAD6AlrB7PbxXQIpQg6GjrVq0ZHojj72Xd3Cjuz6QGet7
	 moaQuDJ/wfzuz4xcUVeyEYukIv0KLituyOnG76HL3xvMdkJYdj9r/JkuaZsaBDj2hg
	 Fo4/vaUtbejfnsRUDyxPeJqt8b466XX1Ou7EkhpYzN7gpdDOSUaALuF8+ugEHpzAJu
	 iCLf7+QZUswkldA6wC8A2RPuif0YwAqpKRz8PqJBBqP73dEYts7LX6mYMkD/Giw2Tm
	 p01KR2k8uIjx/tfwb5ZLUNz4Zr+Ahx2Co2PTHUMlCi3yrQV9jTlf0fSON0xGcU5H5I
	 706RxQO9M7SRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 15/71] net/rds: fix WARNING in rds_conn_connect_if_down
Date: Wed, 13 Mar 2024 12:39:01 -0400
Message-ID: <20240313163957.615276-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit c055fc00c07be1f0df7375ab0036cebd1106ed38 ]

If connection isn't established yet, get_mr() will fail, trigger connection after
get_mr().

Fixes: 584a8279a44a ("RDS: RDMA: return appropriate error on rdma map failures")
Reported-and-tested-by: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rds/rdma.c | 3 +++
 net/rds/send.c | 6 +-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index fba82d36593ad..a4e3c5de998be 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -301,6 +301,9 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 			kfree(sg);
 		}
 		ret = PTR_ERR(trans_private);
+		/* Trigger connection so that its ready for the next retry */
+		if (ret == -ENODEV)
+			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
 
diff --git a/net/rds/send.c b/net/rds/send.c
index 0c5504068e3c2..a4ba45c430d81 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1314,12 +1314,8 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 
 	/* Parse any control messages the user may have included. */
 	ret = rds_cmsg_send(rs, rm, msg, &allocated_mr, &vct);
-	if (ret) {
-		/* Trigger connection so that its ready for the next retry */
-		if (ret ==  -EAGAIN)
-			rds_conn_connect_if_down(conn);
+	if (ret)
 		goto out;
-	}
 
 	if (rm->rdma.op_active && !conn->c_trans->xmit_rdma) {
 		printk_ratelimited(KERN_NOTICE "rdma_op %p conn xmit_rdma %p\n",
-- 
2.43.0


