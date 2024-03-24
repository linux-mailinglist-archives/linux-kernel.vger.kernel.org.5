Return-Path: <linux-kernel+bounces-114948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F39888C25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C68295CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB371BF1EA;
	Mon, 25 Mar 2024 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNT3HR9V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B017A39F;
	Sun, 24 Mar 2024 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323660; cv=none; b=V4JssnGr36UWCeJJPSCA454V4WQrv9DTdl6vDOMeO0qJ/6Exn0dK451lqAQtvtv3JFSl0/M7lMERvZ7XP86yrT/zXSbmVk1dUpb7qn+D5GwpUe3U7yXV/gowRIakAEE/IEiYio2dTsDNNEdOREf439VME57o+jMJ1Wa/GZCRFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323660; c=relaxed/simple;
	bh=2QmnBqFaoclGLhXwzEZp6wAs7/ysaG7ABlc3lWoqZTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwoZRafgYBeoeDXBWK2rJk856VZjU+hMtKbrjeqrPf9J5Fm0WHkcBxrbTufFVMrKqXnYUn22drYAVZtvCmSvqf6hzq3SIh101Hf0YitBgxUQ+lL91o3tfp6tGMNY9tbp68J3WjBgD1J/7/R3KyiJ8YX57daqHq70xrk+1XM6i6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNT3HR9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4050C43390;
	Sun, 24 Mar 2024 23:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323659;
	bh=2QmnBqFaoclGLhXwzEZp6wAs7/ysaG7ABlc3lWoqZTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNT3HR9VFsSlI3G+PwfxNK4DD2xvT9Jc4FjJcQ19QZQIBnVIauTLVmHjhCW1H1iUH
	 mDKZV3SY6D+pRvWOrCb18kIPri9AHVoBGWmBj0dX9dpO1yWMg5lgm+Py+yw9nNLI7v
	 L6iBZenLZUylEj7qeJqYgJUYJxn/bkXAjiZaZHem6PMEg+6d91mzKA/L+9C43NZCn1
	 wDCunvi4Rr+tQlRQIQ2RgSPbETbpuPLoTQx+A6WQ58bXBWmflx2QBX/SOtYmebSvxe
	 AbTGCSCQx/rRJmOVifZkKH035uHB5OOQfUx9XXOmrUhU/RMQqtdlL1inXJzPecXTQ+
	 uuQBd1o0JvhwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	Andi Kleen <ak@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 031/238] fs/select: rework stack allocation hack for clang
Date: Sun, 24 Mar 2024 19:36:59 -0400
Message-ID: <20240324234027.1354210-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


