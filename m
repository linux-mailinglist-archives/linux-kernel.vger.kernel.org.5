Return-Path: <linux-kernel+bounces-102039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26187ADD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFD31F27E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8FD151CE7;
	Wed, 13 Mar 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhEc8GQ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2178D151CD4;
	Wed, 13 Mar 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348420; cv=none; b=iYiuJMLH2mpyovqxJnLZ2ttKozrBgokWY8CM1/DmsFndmyK6QWRkgnu5S/jtiXAcLWE/hVCkSHsM2qMGHnim36MLJqtYgw9aTpDMlllGL2oRxNRTfo4iL/67QX8AS/dhllOF+Qu7THDFvaLEvS9mP9+WOT0tB2tB2u333yg80X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348420; c=relaxed/simple;
	bh=2X0S2vvszqlOoS3sCZkbGf3s1JKi2aR5XwTcWPgOZXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1+9W3AOp1jXKJg3PwOnTR4ySDWmYRwcRAcDS6kszh3jcvrl6cv/AOAhy2Py/USHZ1vtrHVSNF0kKyiPesB0aZ/n/Kh94xVl1jQO2otgNIyEVRubal2z5dFIILz2ib6rTF+9nWEqWFv0rUryq2U0cawen7k7Q4ZTTBonkXmLL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhEc8GQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32484C433C7;
	Wed, 13 Mar 2024 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348420;
	bh=2X0S2vvszqlOoS3sCZkbGf3s1JKi2aR5XwTcWPgOZXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhEc8GQ3ehymbiNKNKPz1bUPkN0NpghO66y8FF6ewfEXv8DHNqfprA4U8RR90v33B
	 /o9+VufgkYUXxjpjgax/eWdKgdNkqux/qiwLYC3R0c5ugk8Q5sdES9ABpH/63DdNzw
	 dVcA7Vh5wZi2otB5VNz/FGF4CejRv+QvB5CvV8n6oDsdZPFH3fTL9L4uBr9Od0xW4O
	 wHpi9CojA8OeW5PzFTpvtAFY2lpSbRnz4sRQXRYOOC2IJNPjFZfi0BIfFc9kfB2GdT
	 X8+klLq09iGYAUnPWLLtcBTxK72qQlkDmKxn1IicLzS7XuIEZSBj0LnJGCJVlZ9471
	 idu96C2TUfL3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 15/73] net/rds: fix WARNING in rds_conn_connect_if_down
Date: Wed, 13 Mar 2024 12:45:42 -0400
Message-ID: <20240313164640.616049-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index 985d0b7713acc..65eeb82cb5de5 100644
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


