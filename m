Return-Path: <linux-kernel+bounces-102195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915AF87AF50
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA592892BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0BB19D9D7;
	Wed, 13 Mar 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o25G4pr1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32419D9C3;
	Wed, 13 Mar 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349490; cv=none; b=GoVCxovfJd0QbVJn1tt11zTD5PQuRrPvjpvDgx1VLY3IPbWJW9sYWWBoHzNQKyD1+AUP+5Sb+mZKZZJ8214H8I3p7DysasgCR3UKdzOHtduSzXgT/aMs9NM6IkkhMQoOSfIfFr04Ym2vMr6KYuPPDX2h1UF787lpfucoU471qG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349490; c=relaxed/simple;
	bh=9KqGsTxtPM2C2qcbJWlCOteDNqiv2gMmn1TTx8K/PY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWhbilsi0OthmfvsOoEF2KalOYKR/SvZHD+/3xFba55872C9Wl4OiCAssLFzxzsea0DlXjXMeWnVKcGRc5+fnEE44ln1HOkWNWvvSG17DMS1vqKJlovDfS5lY7VhUQySTvlsVpnYI06YOoD5lek41HU258dn9gqOWL/qdFllzRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o25G4pr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0882DC433B1;
	Wed, 13 Mar 2024 17:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349489;
	bh=9KqGsTxtPM2C2qcbJWlCOteDNqiv2gMmn1TTx8K/PY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o25G4pr1IEM5b1I5NYj5kwYJ9L6xwnB1HtPuJLromBH7cvUhH9k9M0O+jrX80UnGM
	 O30uTzEd6Dd5hbGyNcMSnoMBooS7NlXjGHkZPhr6CE8Pa94g6SH6FLiV4twIxrd2Ow
	 GbRzHlXpGOD5dS+jwylphINF/MckGXsrBU1reeUdj0ErQfajN/Llo4vNwGN3jNBsUZ
	 wtJ70dJrEadyea96HCeuFqa9sRoGNfn9RBF4VvOdD8Wmtoj7HCXzD0kLBJG8qRx9y5
	 ztUFgLcVTbOV62EcBuAfnGhZB/eVPwwVcGBzoZsyWnHEUmi968kZRxCI3qSm1efdFB
	 PH99b0kgh6orQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 10/41] net/rds: fix WARNING in rds_conn_connect_if_down
Date: Wed, 13 Mar 2024 13:04:04 -0400
Message-ID: <20240313170435.616724-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
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
index 9882cebfcad60..2632f3f3aa284 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -278,6 +278,9 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 			put_page(sg_page(&sg[i]));
 		kfree(sg);
 		ret = PTR_ERR(trans_private);
+		/* Trigger connection so that its ready for the next retry */
+		if (ret == -ENODEV)
+			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
 
diff --git a/net/rds/send.c b/net/rds/send.c
index 26e2c2305f7aa..c856e6c963af9 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1300,12 +1300,8 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 
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


