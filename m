Return-Path: <linux-kernel+bounces-101837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B7287AC05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0BEB25769
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08956F51A;
	Wed, 13 Mar 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0nTOAAO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A036F08A;
	Wed, 13 Mar 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347873; cv=none; b=mCscHMXQZZHzf8yabI7h8oRdlloWKDX4mJboDQXZm3eFyiVsPUGnbrnsLt3XJBOotxSq/n+yEgFQTKNPU5ysJIa7qyltIhY7PyeEaIceenp4CoIgzwc8Gx8hSvhhy5TA1FwUbHMkD5aWjsSFeQO3LFRbUpdyfY5ASj3LI7VX6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347873; c=relaxed/simple;
	bh=4EfXQp1V4nsCnZPwQOAsK1SnbhpyNfiFQV00BG3FfSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvfQVB5IS06ayULCuT55xEZX6ivkm0g4ke7vYqiF0LLnEoCTKz0qJ98rJc6CQk1QFRQxHc/oR4QGv+UIEovH/cNz92UDDQeztE+BnGWOiXmS9siom72LAnYeeX8RmCOXbizJxo7ZGjn7EsmAC18TXNFyb88802GJGXrIEwKDTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0nTOAAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2068C433F1;
	Wed, 13 Mar 2024 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347872;
	bh=4EfXQp1V4nsCnZPwQOAsK1SnbhpyNfiFQV00BG3FfSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0nTOAAOHK0o8L3c6+Eej+ld20QrLns2GL5qOhhMSSfnCFBBwNefgQvRMtD23Vw9F
	 EhzXV8VLL6A9oEkWHeOUsG5M07oUu3b/aBfExjlJAeyIaH4Mw8owqdLtUQmfb26Bcv
	 X0KfohkxBLZ0B/veGshAPyRaScifQ1zI1Fxmf8ytFITKK4AgEs0/+ks19f+OQd5KXd
	 2EzGCmmDNm8HpRn8mFOgg6PMxW+Y0uobS/6E96nL0C9BxjWkQHZQAmyzVtlyC2ibL3
	 INakTu71iAx2s8eWGLKiLBFANertNVhmqXlZ6AOGbJYWYC8NERhuiyiTJm192UvE+s
	 tz8w7fR7jHYRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 34/60] net/rds: fix WARNING in rds_conn_connect_if_down
Date: Wed, 13 Mar 2024 12:36:41 -0400
Message-ID: <20240313163707.615000-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
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
index 5e57a1581dc60..2899def23865f 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1313,12 +1313,8 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 
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


