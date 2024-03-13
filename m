Return-Path: <linux-kernel+bounces-102130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F9187AEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C570CB22407
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ED36EB4C;
	Wed, 13 Mar 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqQ731hj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25A6E608;
	Wed, 13 Mar 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349347; cv=none; b=OkgJSTieKK+xGqm7kNolGZjUkPk6OLHIVBLXX1f0KPyJGvM9RCjRfnTtJenTGw3PpL64YGQYsosh4nBTeVTi2ssrEyHI+/qk8Z8Pb0IaaA0Lt8r2ix8KzfTLg62RkRbA5JMqWqpPYBPPC3MpwBrj4EYTVnwfMz8yGLoJs+jXQv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349347; c=relaxed/simple;
	bh=70jvzExLBCsoEbFcxQpov8Y71vAHjhcX7H6WjMqKrdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqWy7/kue072vSZa32k/324zcbuh8kig27wJ3wA0mh9zB5CIyfv0Ouh+Nh0RNYZlHq8LCHCzwGK8wo7yE2F+hfhpe6yBex+vdrxpNx6HWlhMKPsYcjvXqPeWNMW0vGzcnacslFp6kcM01qRWcovvLqYwkmaYdMPV2vHfLc6+fGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqQ731hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB44FC433B1;
	Wed, 13 Mar 2024 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349346;
	bh=70jvzExLBCsoEbFcxQpov8Y71vAHjhcX7H6WjMqKrdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqQ731hjuMDGUWDrqHlvx/qUFORvaS0cu4neeV4Hq+4j9Z9o4B4vykV6hbMJ+MJgg
	 WRqkIRkjEL8kg4Ta2oJsX15MGhYsYDR1wBQDuDPXnuQp4l1XZhzFRgKhmlw2Qla5Hm
	 CsoMgpkP8Bdct4ZVPYXns+hWU+jCYlRC6rnvMR1By7FMJbh/PfRJjujAOTURqRpAnM
	 qEJispD5yF3lGfZARYYYP7UbEHz+I6jHnnUWKr5wTOVqTnwyAcYnTW62MHqhfyFkzV
	 DuTtuz1GOYhWtY2bU/gUYUIMi3i7BqcTs1fCDm+yiY86mprLUMB/Q6tCS91xKlknBa
	 GrZxDd2ibwvcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 10/51] net/rds: fix WARNING in rds_conn_connect_if_down
Date: Wed, 13 Mar 2024 13:01:31 -0400
Message-ID: <20240313170212.616443-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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
index 1c42a600fe7fa..dc0f7cf1917ff 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -279,6 +279,9 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 			put_page(sg_page(&sg[i]));
 		kfree(sg);
 		ret = PTR_ERR(trans_private);
+		/* Trigger connection so that its ready for the next retry */
+		if (ret == -ENODEV)
+			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
 
diff --git a/net/rds/send.c b/net/rds/send.c
index 68e2bdb08fd09..6c2c5667e3a39 100644
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


