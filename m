Return-Path: <linux-kernel+bounces-101894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF8887AC82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3B3B23799
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275A7E576;
	Wed, 13 Mar 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB0QV33N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AEF7E0E5;
	Wed, 13 Mar 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348029; cv=none; b=udAYHufF54aP73Kg827re81fxG5RijI+7lOwn5fM7uy8mKSICQ6R9nIGojJqV+nm0VxtK1v28/FYzDl3g9EZpmBdFKq1JFvCQXJmnNT9ecyUlmPqaC7r+XXHpuWTqeLPbKkBYyh2oYLG1a7F1iz2K1oxaEFtfXAMD9N0K8/k6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348029; c=relaxed/simple;
	bh=Ial15X+T6x046jhvrw91zfjdAqyEhkULXa9p2FVOuBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXzY7C/PF+0PhOMmlGiNNh0M1XAb0ZuijBvzNa9bs5qEhyxFptlkTGbxflsU6zHqZJ7tSoUQ+0RhsBu/Uk3WicL6VWFA3AwYUg3bqK59Kth0Z5bK46cLGE8aBdA0MBe0hf2sWkL1v3WHeALg/Ik45+wgP+nyyXacTK7MHgTa3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB0QV33N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0746BC433F1;
	Wed, 13 Mar 2024 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348029;
	bh=Ial15X+T6x046jhvrw91zfjdAqyEhkULXa9p2FVOuBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HB0QV33NtH35jlWYTQDofpmBYNj4YHpl1tKVBmy8urTt/yUBqxHYhLh5E3F88R088
	 ZeOF8mDj4ybrrPABO5wbWpiBDwJQPHtgYBbWlqDMU7ULbEXR88LpzubqerpSb/KqVr
	 8na5nc8g2/5bYWpR1dyLmiNOSRC5jf8rmgljWhCxRNtX0jhe+CHWDdLtg9uYQIjX6d
	 N866qOikWjSGwgl+RloJdXznqijVk0joZgYndioaeJTY4mEuPjoklCc0nfb1/uH3J8
	 a0NNzficEvQKYCTkocfZL6SvkWkk1tfnO85auGGW56viO6FLrU2PWE/x8rZOhx6i9X
	 CcQ3FHyR8UMUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 26/71] netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size
Date: Wed, 13 Mar 2024 12:39:12 -0400
Message-ID: <20240313163957.615276-27-sashal@kernel.org>
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

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit a2e706841488f474c06e9b33f71afc947fb3bf56 ]

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
index ee6621c0d2e45..88941b66631fc 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -462,7 +462,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
 		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
-	nr->window = sysctl_netrom_transport_requested_window_size;
+	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
 	nr->state  = NR_STATE_0;
-- 
2.43.0


