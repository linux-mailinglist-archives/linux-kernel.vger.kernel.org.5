Return-Path: <linux-kernel+bounces-114754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B895889100
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC3E1C2328E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4261C1AED58;
	Mon, 25 Mar 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF3YOJ0v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645022745F4;
	Sun, 24 Mar 2024 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323341; cv=none; b=Xg99jLeMFxPc5NDyAZRRw1IZYVGGSCXmxZAaiS8DlKPfEKfPPDrgtDlafHREbDYnkMLpIx+cxWxO4eioHclZLim09JwlN8OPylJscpTXzeM51uQJ4z+Mafc0geZk3yTSNsp5KIV75humqlLB7ULtbETRYii1OEF1BnIk4OOCKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323341; c=relaxed/simple;
	bh=2QmnBqFaoclGLhXwzEZp6wAs7/ysaG7ABlc3lWoqZTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cim4bmchLD6GISOTSRFzXLiHJfsDVHwKj7OgLsS7kNdAjo3t2XiG+eR4YJJ9qa4H80MIq3Q9pUOxYvKJE+g5zsfVqC6RKKhJb1V/D0eZSLMnJ4NqD8RQ81Dxc9f2AVA208fXbKLCQ3WrJyx6YP9v+nTb0XxQwgPMO8Pk4O84NGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF3YOJ0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9A3C433F1;
	Sun, 24 Mar 2024 23:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323340;
	bh=2QmnBqFaoclGLhXwzEZp6wAs7/ysaG7ABlc3lWoqZTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PF3YOJ0vVObS5Tx1DLsAa53Pyjo9FjTL+cHht6Y0SYuuKE6Fp/7utSp+1hHlswRSU
	 bn4d+Ty6ysShrwymK6WDVOt7Jk7Lxm93iF2bI+Xwi2pAEwqA6n7Eb4KPijwu6g80DA
	 QGg8PJqOHC0bmBqeg5fC++1KwtgeVXJ2uQb7nbpy5gFJ+StmIIHVhPQypWa6fmPIOo
	 c1FBERr8ZjJHC5qpuuHBCxGH1tpCyFHvIwpkTgpnqnbht9je3xYcQNwP0vZnWv/tgb
	 NdJ43hOZvJvcSUxsMnrea6Kvt+NK1xqUb1ROKzwAGh6CFMDk7CoIQxVfJzbt90MeYU
	 L/1kBhAE23KHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	Andi Kleen <ak@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 040/317] fs/select: rework stack allocation hack for clang
Date: Sun, 24 Mar 2024 19:30:20 -0400
Message-ID: <20240324233458.1352854-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit ddb9fd7a544088ed70eccbb9f85e9cc9952131c1 ]

A while ago, we changed the way that select() and poll() preallocate
a temporary buffer just under the size of the static warning limit of
1024 bytes, as clang was frequently going slightly above that limit.

The warnings have recently returned and I took another look. As it turns
out, clang is not actually inherently worse at reserving stack space,
it just happens to inline do_select() into core_sys_select(), while gcc
never inlines it.

Annotate do_select() to never be inlined and in turn remove the special
case for the allocation size. This should give the same behavior for
both clang and gcc all the time and once more avoids those warnings.

Fixes: ad312f95d41c ("fs/select: avoid clang stack usage warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20240216202352.2492798-1-arnd@kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/select.c          | 2 +-
 include/linux/poll.h | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 5edffee1162c2..668a5200503ae 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -475,7 +475,7 @@ static inline void wait_key_set(poll_table *wait, unsigned long in,
 		wait->_key |= POLLOUT_SET;
 }
 
-static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
+static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 {
 	ktime_t expire, *to = NULL;
 	struct poll_wqueues table;
diff --git a/include/linux/poll.h b/include/linux/poll.h
index 1cdc32b1f1b08..7e0fdcf905d2e 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -16,11 +16,7 @@
 extern struct ctl_table epoll_table[]; /* for sysctl */
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
    additional memory. */
-#ifdef __clang__
-#define MAX_STACK_ALLOC 768
-#else
 #define MAX_STACK_ALLOC 832
-#endif
 #define FRONTEND_STACK_ALLOC	256
 #define SELECT_STACK_ALLOC	FRONTEND_STACK_ALLOC
 #define POLL_STACK_ALLOC	FRONTEND_STACK_ALLOC
-- 
2.43.0


