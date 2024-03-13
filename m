Return-Path: <linux-kernel+bounces-101778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B93987AB81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5F51C20895
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5729626DF;
	Wed, 13 Mar 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCd0i2hw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB7626B4;
	Wed, 13 Mar 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347607; cv=none; b=TEMZtxi1NJgJwIbEd5yn/ztpztw9tjeMtwPl37/dix276C4abOwtaCCcaUBUEK6Egl/UVc5MxVK2kdfn3M8GOZr7S6Ix47eqhpfkNjCmM2DW9KXQUw74pqzDrr+gWKcxJEuojWD6KDD3eoj4SMO8xHMbRA1tfGMwNClNNlhMjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347607; c=relaxed/simple;
	bh=4EfXQp1V4nsCnZPwQOAsK1SnbhpyNfiFQV00BG3FfSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUrT2uu+t6pJrOGgRisA2GBFeIusazjo/yipwz92Ge5rv995k8a0Kdn25ZMO3sYOH56MI4/BBm6vMZNNagdtYWAbBNt13HpTEaqoiIs3JA4ia9Rk5FPOdE4qoUkHP6fkr/3l44PL75zI7fRevHdzCv9WTxVH/KcxFlATeR247C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCd0i2hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00F7C433B2;
	Wed, 13 Mar 2024 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347606;
	bh=4EfXQp1V4nsCnZPwQOAsK1SnbhpyNfiFQV00BG3FfSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCd0i2hwiIzQMMpe5/xepK0BPkGh7QGqPYbEefpbjqtZ1JCJUxYVLik4pdud0XC7S
	 MJhemoSV//WuWFNZ9PxdEKxG8otVJK+BcCahEdd/ElZbehstRfrMIp56t/DdceORW+
	 ajJ9Tt4XeLXJA9OaD3WBSWXOPtiVRFIGUAq/UlmxaXL8zXK9znrocbdIje7jTQQsoy
	 KjqeGYCWMm6zmcuF66nRskd0arjkROK8KGp3VC6/dCOCMr3zPcWjvmE1xdp1L+ykIV
	 0qICNvnE0kns5faN8YTZ7xRifFK32TwalPSPBchCwzf7WAq3/ZDwStbkOGRIOcUyD/
	 8PxaBHCFiN4jA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 39/61] net/rds: fix WARNING in rds_conn_connect_if_down
Date: Wed, 13 Mar 2024 12:32:14 -0400
Message-ID: <20240313163236.613880-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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


