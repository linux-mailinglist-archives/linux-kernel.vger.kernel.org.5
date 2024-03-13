Return-Path: <linux-kernel+bounces-101952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F9687AD05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CCE1F25A45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FD062A1D;
	Wed, 13 Mar 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZlyfmtw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36588139579;
	Wed, 13 Mar 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348161; cv=none; b=tz+rEdHT1lA8b+kDkv+YdXlM4Dvehg02qkEb3PToa7EJRb8U7GhYsSbj/zLDLuD0VhJVMWai4fyOPowM/9z8sjI6zVcJCaPvf5TwPRki+Xw6SxCLBF+/M9P2mBHLTE1IuOckp+j09o1bbAD+6YU1yNzYvneGhcN3mrtD2q5aaqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348161; c=relaxed/simple;
	bh=BJMqZs3HypZYIgRRS3ZNRgnZRiqh9LAfOakZLpvame4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMzGBxWx8ISuiOlA1RJbchNN8QdmfeXCOT533KlySW4HVkocOsBK20yXrWs4IFN1SZShpgomhNhx54dLkd++5SvXPlBTZ75N1MQFF72WrfvAaBTD47kysFHiFFdFhMLcsPKt9n2FwbEj1E27N/cbASb3mzwSW58S+cznfR/yFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZlyfmtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4508C433C7;
	Wed, 13 Mar 2024 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348160;
	bh=BJMqZs3HypZYIgRRS3ZNRgnZRiqh9LAfOakZLpvame4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZlyfmtwrRtLfiCbXW/8pnac+o21uKiJ0pt0HJCKRbC43Dhm+RjTE9ESOxGpWOOvL
	 YWFqeC6jd67kk1bTXLv/qEOlb3IMYeUaWFBERcboJGH8FJ6OOTplhclObDbPHDnZoI
	 yTJDoq1bNIiFau+ja6sqxN9h3YC6OfuIapTYDIKtMtYCrtfXTcuqJkw4D9AquU9qPb
	 MR6QFMcuUc17C2mhG50x9EiW/kk8JE5prMHPFrpqabFEdK1SlrypnLsynD6cnChN6b
	 LLW27v0e07c/SzUyByYfekNBpaX7dxvVbjWk1Id2SCcK+deaNOpQ8cJpBkMnVu50fr
	 uZsjM+FDsOSow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 12/76] net/rds: fix WARNING in rds_conn_connect_if_down
Date: Wed, 13 Mar 2024 12:41:19 -0400
Message-ID: <20240313164223.615640-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 6f1a50d50d06d..c29c7a59f2053 100644
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
index 53444397de669..d6462d1471c14 100644
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


