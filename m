Return-Path: <linux-kernel+bounces-101964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DAA87AD22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F277B242E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6B141987;
	Wed, 13 Mar 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la5YW2Gw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29154633F5;
	Wed, 13 Mar 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348173; cv=none; b=LX97koj31RD7tVug5MVEQi7sTCopAsIgUC8a/iwxn3UP+1PChoDnAYi/ozktp5xRvl1QHiKgF3y1RHZBTN05T21qsZlFwilhzPhPkBSNEeh5Yipftw9euoM3GX4r+2vYHuOSzEXuCaBKMdvDmke/b3CPhxu7V1CPbt4GDQzLC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348173; c=relaxed/simple;
	bh=g43Mh+Ckbo7u84Iinkv4s2Oe8nqvUxcd3wBs+YIKlwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TM0r0cUgGSPQ/TArKtTiodC5ZNVknn4qUegobK8GaGBPxKCR9mB1uazhmHB/32/4Zcec5vLpUuEXKnGWLD1cMmapye3aR62BZuyI5L/+YL6iiQ+BOaIP5FyCwdHkTzNpO1zwbAzX7Af6emLrKMVzoBW1z8p4OSyAiu8TcZS7XO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la5YW2Gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3BBC433C7;
	Wed, 13 Mar 2024 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348173;
	bh=g43Mh+Ckbo7u84Iinkv4s2Oe8nqvUxcd3wBs+YIKlwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=la5YW2Gwq7KIqMxEjxF7c/kZ87AVjgcIBpNpWbtJPjL4uzpLoprd5PJh6BLojlpg0
	 8IQepAXmSGtLmkNgxITlphRU6uvmvJpcN1YHpPqHOhcK9e2o5m4eJe+Ln6Qy408j1i
	 gSrTx10zOE9P3W2oI0XuC9tfw1oU2nN9FL1e3QtYfdRNlyCj8XWWMUpUKx1m2QZblw
	 KcF7/vNu4kCXFOZzCyW22rr4CtXEPXjkRaAbJnWtDUlQkix+LaDtdPX99GGFeMrcZ6
	 8YnnH/z+2irlqqc2udKnRqmagnWaSVlgkmUeLMMWm9d/R+ijF3MJH9vxLlWStmci7/
	 vhx3k/gntSiDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 24/76] netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout
Date: Wed, 13 Mar 2024 12:41:31 -0400
Message-ID: <20240313164223.615640-25-sashal@kernel.org>
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

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit f99b494b40431f0ca416859f2345746199398e2b ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/af_netrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index d780adf54e19e..376b6af431448 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -461,7 +461,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t4     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
-		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_no_activity_timeout));
 	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
-- 
2.43.0


