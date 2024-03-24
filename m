Return-Path: <linux-kernel+bounces-114068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA7F888830
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7DA1C273E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD690233CDB;
	Sun, 24 Mar 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7yrMtyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A621FEC57;
	Sun, 24 Mar 2024 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321357; cv=none; b=BT0jtAUN/DHjlUlNQasVLS3JQxTH+9GZm7v2KE6kSYaEhwr7Gvrq7KaTe19unsy0GCVI2jxkWsfS0PMIbYlb/MD5zq7DrvihfJS/CM1jjJXwN2I+KKisvm1Va1tSkhM8HKerQ2eCoRGVZWD/rfOuCgM0CRChEZwaA5vZP7VxSvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321357; c=relaxed/simple;
	bh=d27Wlxo7LW/OPlWiQL7BRxlIURlkj4LhLWUZy3m8rOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMUN8mRsF/5XuqsyZ7Y66HQPtmAtTH3wFQVLnEdnWbO2XN7Tj3jTdhOQISE3QIkzdVq75K+dNc1rPgn0AHq0ttdDTNTHFYEkKa1uGTb8qNCf2CjbkSGFtyvDLC84r5TjJJkCD0VkAoHT2/HWrKi8+MlTpzVfjflaVvgNwjEu780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7yrMtyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAB5C433F1;
	Sun, 24 Mar 2024 23:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321356;
	bh=d27Wlxo7LW/OPlWiQL7BRxlIURlkj4LhLWUZy3m8rOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7yrMtyzXMT6rYsP/bwgx720MOMjUq2h6nbUvdtDQ/q+Q+6jRzqkPJQ6WWzOwlM30
	 GuAr1d7WRp4apED2DUUpCJcrxS/jEVOhJZXlfgef1R4YxjeI+VjaKgONEXMaZD/ukr
	 HkxdQrFE0AwL0c3Lu63oTitpk5BBlm7EabakqGkV94hDNAZI5fL5oMeUNxQ73xz9Mc
	 MWLxu10KE67OgC/0MnHNiwHutFUh6jGMCqpzvw1Wm/Fg2MOeBwpyhCHAlf+xA0V2eW
	 JPJ3/BDktO67Jn+rvZtnohGnoj650pmOQyfxeNWN1HbMbek2+oIyfCMWx2yrh50+6t
	 tt1DjTANo/dJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 081/638] io_uring: remove unconditional looping in local task_work handling
Date: Sun, 24 Mar 2024 18:51:58 -0400
Message-ID: <20240324230116.1348576-82-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 9fe3eaea4a3530ca34a8d8ff00b1848c528789ca ]

If we have a ton of notifications coming in, we can be looping in here
for a long time. This can be problematic for various reasons, mostly
because we can starve userspace. If the application is waiting on N
events, then only re-run if we need more events.

Fixes: c0e0d6ba25f1 ("io_uring: add IORING_SETUP_DEFER_TASKRUN")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e22f6bf837f9d..049a163d0fdd0 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1363,7 +1363,20 @@ static void __cold io_move_task_work_from_local(struct io_ring_ctx *ctx)
 	}
 }
 
-static int __io_run_local_work(struct io_ring_ctx *ctx, struct io_tw_state *ts)
+static bool io_run_local_work_continue(struct io_ring_ctx *ctx, int events,
+				       int min_events)
+{
+	if (llist_empty(&ctx->work_llist))
+		return false;
+	if (events < min_events)
+		return true;
+	if (ctx->flags & IORING_SETUP_TASKRUN_FLAG)
+		atomic_or(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
+	return false;
+}
+
+static int __io_run_local_work(struct io_ring_ctx *ctx, struct io_tw_state *ts,
+			       int min_events)
 {
 	struct llist_node *node;
 	unsigned int loops = 0;
@@ -1392,18 +1405,20 @@ static int __io_run_local_work(struct io_ring_ctx *ctx, struct io_tw_state *ts)
 	}
 	loops++;
 
-	if (!llist_empty(&ctx->work_llist))
+	if (io_run_local_work_continue(ctx, ret, min_events))
 		goto again;
 	if (ts->locked) {
 		io_submit_flush_completions(ctx);
-		if (!llist_empty(&ctx->work_llist))
+		if (io_run_local_work_continue(ctx, ret, min_events))
 			goto again;
 	}
+
 	trace_io_uring_local_work_run(ctx, ret, loops);
 	return ret;
 }
 
-static inline int io_run_local_work_locked(struct io_ring_ctx *ctx)
+static inline int io_run_local_work_locked(struct io_ring_ctx *ctx,
+					   int min_events)
 {
 	struct io_tw_state ts = { .locked = true, };
 	int ret;
@@ -1411,20 +1426,20 @@ static inline int io_run_local_work_locked(struct io_ring_ctx *ctx)
 	if (llist_empty(&ctx->work_llist))
 		return 0;
 
-	ret = __io_run_local_work(ctx, &ts);
+	ret = __io_run_local_work(ctx, &ts, min_events);
 	/* shouldn't happen! */
 	if (WARN_ON_ONCE(!ts.locked))
 		mutex_lock(&ctx->uring_lock);
 	return ret;
 }
 
-static int io_run_local_work(struct io_ring_ctx *ctx)
+static int io_run_local_work(struct io_ring_ctx *ctx, int min_events)
 {
 	struct io_tw_state ts = {};
 	int ret;
 
 	ts.locked = mutex_trylock(&ctx->uring_lock);
-	ret = __io_run_local_work(ctx, &ts);
+	ret = __io_run_local_work(ctx, &ts, min_events);
 	if (ts.locked)
 		mutex_unlock(&ctx->uring_lock);
 
@@ -1620,7 +1635,7 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
 		    io_task_work_pending(ctx)) {
 			u32 tail = ctx->cached_cq_tail;
 
-			(void) io_run_local_work_locked(ctx);
+			(void) io_run_local_work_locked(ctx, min);
 
 			if (task_work_pending(current) ||
 			    wq_list_empty(&ctx->iopoll_list)) {
@@ -2463,7 +2478,7 @@ int io_run_task_work_sig(struct io_ring_ctx *ctx)
 {
 	if (!llist_empty(&ctx->work_llist)) {
 		__set_current_state(TASK_RUNNING);
-		if (io_run_local_work(ctx) > 0)
+		if (io_run_local_work(ctx, INT_MAX) > 0)
 			return 0;
 	}
 	if (io_run_task_work() > 0)
@@ -2531,7 +2546,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	if (!io_allowed_run_tw(ctx))
 		return -EEXIST;
 	if (!llist_empty(&ctx->work_llist))
-		io_run_local_work(ctx);
+		io_run_local_work(ctx, min_events);
 	io_run_task_work();
 	io_cqring_overflow_flush(ctx);
 	/* if user messes with these they will just get an early return */
@@ -2569,11 +2584,10 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 
 	trace_io_uring_cqring_wait(ctx, min_events);
 	do {
+		int nr_wait = (int) iowq.cq_tail - READ_ONCE(ctx->rings->cq.tail);
 		unsigned long check_cq;
 
 		if (ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
-			int nr_wait = (int) iowq.cq_tail - READ_ONCE(ctx->rings->cq.tail);
-
 			atomic_set(&ctx->cq_wait_nr, nr_wait);
 			set_current_state(TASK_INTERRUPTIBLE);
 		} else {
@@ -2592,7 +2606,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 		 */
 		io_run_task_work();
 		if (!llist_empty(&ctx->work_llist))
-			io_run_local_work(ctx);
+			io_run_local_work(ctx, nr_wait);
 
 		/*
 		 * Non-local task_work will be run on exit to userspace, but
@@ -3283,7 +3297,7 @@ static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
 
 	if ((ctx->flags & IORING_SETUP_DEFER_TASKRUN) &&
 	    io_allowed_defer_tw_run(ctx))
-		ret |= io_run_local_work(ctx) > 0;
+		ret |= io_run_local_work(ctx, INT_MAX) > 0;
 	ret |= io_cancel_defer_files(ctx, task, cancel_all);
 	mutex_lock(&ctx->uring_lock);
 	ret |= io_poll_remove_all(ctx, task, cancel_all);
@@ -3642,7 +3656,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 			 * it should handle ownership problems if any.
 			 */
 			if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
-				(void)io_run_local_work_locked(ctx);
+				(void)io_run_local_work_locked(ctx, min_complete);
 		}
 		mutex_unlock(&ctx->uring_lock);
 	}
-- 
2.43.0


