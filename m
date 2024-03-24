Return-Path: <linux-kernel+bounces-115179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B2888D91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF5A1F2AAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EF630906D;
	Mon, 25 Mar 2024 01:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSb5uQwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F8291B71;
	Sun, 24 Mar 2024 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324237; cv=none; b=Cd9avDY926LeMs2EemoSJKH9tDehFT+15SK7/aXgLiPjM8/ovJhMwTSd/IiOrzntArtFHiDdy85A6D8TcL6z6n626lHASNioLG6UfsYGpUqx3xTBrTR0os1ecg+58Qei3b0aelnanwQ9L4OgHGMsywetkArO0yLfGN07/OwvrRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324237; c=relaxed/simple;
	bh=YwkUYtGUobi3t4tiHcyMA4AKW9oJPCy4a1YK7+7rYIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNagUEm8/vTKag3dl4J3c6j5Il3aUIojMgHHuYDpaY5fHfcMV10z58LdCIQO7Izqt9lfanVD00Ob0YPyRUot197VzTjZ7iVY/YI2nC5Ma6UDOstEsI4Ny2AVM5aObe89dLDiTUOztR6lmyCxFTKbAlBXYcMCyJx+2XzGWooX7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSb5uQwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1572C43394;
	Sun, 24 Mar 2024 23:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324236;
	bh=YwkUYtGUobi3t4tiHcyMA4AKW9oJPCy4a1YK7+7rYIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSb5uQwxFoNiJJMnngo1COEc57IK1Q3ttVCNlOXkk0wnmueTX5Scq79U6D1P/+M4s
	 F6I9rf3w15r6+4HkCiAu4gL5JQ+5rQPOyHG+d38rCtqe/K97bOZ9bn6VwtL0lu6nPe
	 wlsmaCdlYvLrrz9sWjEFcv81Mfv2bQqoSMT3f/FMHQopEsjq0+ikFcyCRkAu8lk883
	 F9pY8aGyHrFuZLOXYddI+8H9jz2CALcYWh9eUVKexp39x1Cyde7UgO6zAYRK36WOki
	 HX/ij6i1V8aA0L7C7t/i114p+jUNMaO/N8WLGvR0a9TR6L8P4eNSClLCIAO133V0ZR
	 V9GFcflr905wQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	Andi Kleen <ak@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 019/148] fs/select: rework stack allocation hack for clang
Date: Sun, 24 Mar 2024 19:48:03 -0400
Message-ID: <20240324235012.1356413-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 1c3985d0bcc3e..e09c43cd75bbb 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -448,7 +448,7 @@ static inline void wait_key_set(poll_table *wait, unsigned long in,
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


