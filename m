Return-Path: <linux-kernel+bounces-112910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3828B887FAD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AC028136E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4AB67A01;
	Sun, 24 Mar 2024 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZF9RYIw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104E62802;
	Sun, 24 Mar 2024 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319721; cv=none; b=XF3zFEQE7SmVk3Jyj5qerzzfJ3yuu4cA56LlRH0n5TuBqTAOQSNvq7wG6M9yxH4gps1vxoQk0fe+T0/ZnlrgSA8IEDD1iA6qg7R6zj3oSAl+SD7Gn/+MVsSxjNzkYVyKr3yj+KxBYpxEbgScsQZWrW1/oY3Ic19sK70Y3+gfLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319721; c=relaxed/simple;
	bh=c/8ThzkfXePMKSUnih7WKsu2s/C2H5smRXIfTXnLdnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvOSQoLrOwn8IfQTRVQd3TRc7E/V0Gwffb3na/ErmdQr/gUADDJTtXcA79sV+kNC1/OJB5yOzjQ55/36NxGbpRj7pQ9R06kwZ5NHyUAM6xm6aq6CC9Wfj8gEx89GSPskmZu6Fz0nNeTV6B+suUyOr8R34hjb134A6D+FxoKYgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZF9RYIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6FEC433C7;
	Sun, 24 Mar 2024 22:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319721;
	bh=c/8ThzkfXePMKSUnih7WKsu2s/C2H5smRXIfTXnLdnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZF9RYIw/nR3jg+ructF7EbBdjduUsN/Odhm1nHGHUd8iG2u3U07pdCc8es1tnm3Q
	 mB5Zsk7AlI7TRD4zn9do1YDTInmLYBGf7QADlZiMayaFuqN7zzhDuI7J7UoOEVKT0A
	 o5qhRIEug0HyhWq0ulZ6chSB8s9Mq7w4IdYNEA85IuAt7JxgYmJ402Op9CcfmyrQ+M
	 6gIWd+v/QTo4gfzvmXVvsu5s+yBbwwqMUq8RwWOz2pUkB0kxxlZfI2xnEuWRamu+oA
	 WHjprW2VuSlODvY3V49dUUFHxHDQpiqvIDjbv8ppkq/aAgIVOzPL0sZJ9SYvXYBx2O
	 RqWgmELXwpRZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	Andi Kleen <ak@linux.intel.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 023/715] fs/select: rework stack allocation hack for clang
Date: Sun, 24 Mar 2024 18:23:22 -0400
Message-ID: <20240324223455.1342824-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 0ee55af1a55c2..d4d881d439dcd 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -476,7 +476,7 @@ static inline void wait_key_set(poll_table *wait, unsigned long in,
 		wait->_key |= POLLOUT_SET;
 }
 
-static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
+static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
 {
 	ktime_t expire, *to = NULL;
 	struct poll_wqueues table;
diff --git a/include/linux/poll.h b/include/linux/poll.h
index a9e0e1c2d1f2f..d1ea4f3714a84 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -14,11 +14,7 @@
 
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


