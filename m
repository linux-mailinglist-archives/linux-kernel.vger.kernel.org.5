Return-Path: <linux-kernel+bounces-114067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB83888836
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EA81F26B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3514F10C;
	Sun, 24 Mar 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNvrv+Ix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF11FEC4E;
	Sun, 24 Mar 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321356; cv=none; b=XdBbcOMsFx3hlJMpPaxJfYOfQbo4Kknjcyv1ebM5gBWKyLE4BbGf5i6w69TBRVTRi4K5gu+NwIZ2tPzQLG63eFg4UHVet2sa/omJA77e8h7/fiPQAf40Z7kg3wM5/Ac306wHMVbQ+hoO44iFpFcw1nIrrg5x450OZgRDlzDCkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321356; c=relaxed/simple;
	bh=WWGno4u/ko4ud8l+2nYlDUuKalDfim/YmxwwaIa58dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdznUV+2JwhuyiZAfBbePXlz8Q00u4FAbjDL8yiw41k7NE19Oek/bh8pUTQUVNWBlvlyV8KcQXQvDaaB7SYgtMKGin6TjoG3OoCz/UvgRTAUnIwf20TVWBp9i4oWl5v4vS3+nI/CGK6WsHomukZ8hVq1W0ki9eg+BNt34DZofO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNvrv+Ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C397C433C7;
	Sun, 24 Mar 2024 23:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321355;
	bh=WWGno4u/ko4ud8l+2nYlDUuKalDfim/YmxwwaIa58dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNvrv+Ix/HHqL4c/Ze3a/OBR9dQHW4p2JDeHN8tIx+FSYgWdO+arR+XUPGozAs8Zm
	 PCGtU6peuUij/WJUaTtxUro90U0gNE8QzqaNH1RNZn77ikbAYH+lJ3Mj8LFzG6I5CK
	 GpxUIgQHXepwI6flGyhpp4X4bxgWVfzVCMm8HJXzpupQMAui7QDQPLZP+xI4+FNrSF
	 bBnZi3tjA7Ydv1ohXb0upG+apWDuYH25rva3wP7jUfkSg++8lSF1PCCnLvFBWG3RfE
	 UnsQW/vfFUjM17DOiFkZuLcORuVMFrPwdvYxsYz+XCRv6c6cF7G4tTsU4+4hjNgslB
	 wzBdEYxPz5ESw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 080/638] io_uring: remove looping around handling traditional task_work
Date: Sun, 24 Mar 2024 18:51:57 -0400
Message-ID: <20240324230116.1348576-81-sashal@kernel.org>
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

[ Upstream commit 592b4805432af075468876771c0f7d41273ccb3c ]

A previous commit added looping around handling traditional task_work
as an optimization, and while that may seem like a good idea, it's also
possible to run into application starvation doing so. If the task_work
generation is bursty, we can get very deep task_work queues, and we can
end up looping in here for a very long time.

One immediately observable problem with that is handling network traffic
using provided buffers, where flooding incoming traffic and looping
task_work handling will very quickly lead to buffer starvation as we
keep running task_work rather than returning to the application so it
can handle the associated CQEs and also provide buffers back.

Fixes: 3a0c037b0e16 ("io_uring: batch task_work")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 45 +++++++--------------------------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 2744d72f10858..e22f6bf837f9d 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1167,12 +1167,11 @@ static void ctx_flush_and_put(struct io_ring_ctx *ctx, struct io_tw_state *ts)
 
 static unsigned int handle_tw_list(struct llist_node *node,
 				   struct io_ring_ctx **ctx,
-				   struct io_tw_state *ts,
-				   struct llist_node *last)
+				   struct io_tw_state *ts)
 {
 	unsigned int count = 0;
 
-	while (node && node != last) {
+	do {
 		struct llist_node *next = node->next;
 		struct io_kiocb *req = container_of(node, struct io_kiocb,
 						    io_task_work.node);
@@ -1196,7 +1195,7 @@ static unsigned int handle_tw_list(struct llist_node *node,
 			*ctx = NULL;
 			cond_resched();
 		}
-	}
+	} while (node);
 
 	return count;
 }
@@ -1215,22 +1214,6 @@ static inline struct llist_node *io_llist_xchg(struct llist_head *head,
 	return xchg(&head->first, new);
 }
 
-/**
- * io_llist_cmpxchg - possibly swap all entries in a lock-less list
- * @head:	the head of lock-less list to delete all entries
- * @old:	expected old value of the first entry of the list
- * @new:	new entry as the head of the list
- *
- * perform a cmpxchg on the first entry of the list.
- */
-
-static inline struct llist_node *io_llist_cmpxchg(struct llist_head *head,
-						  struct llist_node *old,
-						  struct llist_node *new)
-{
-	return cmpxchg(&head->first, old, new);
-}
-
 static __cold void io_fallback_tw(struct io_uring_task *tctx, bool sync)
 {
 	struct llist_node *node = llist_del_all(&tctx->task_list);
@@ -1265,9 +1248,7 @@ void tctx_task_work(struct callback_head *cb)
 	struct io_ring_ctx *ctx = NULL;
 	struct io_uring_task *tctx = container_of(cb, struct io_uring_task,
 						  task_work);
-	struct llist_node fake = {};
 	struct llist_node *node;
-	unsigned int loops = 0;
 	unsigned int count = 0;
 
 	if (unlikely(current->flags & PF_EXITING)) {
@@ -1275,21 +1256,9 @@ void tctx_task_work(struct callback_head *cb)
 		return;
 	}
 
-	do {
-		loops++;
-		node = io_llist_xchg(&tctx->task_list, &fake);
-		count += handle_tw_list(node, &ctx, &ts, &fake);
-
-		/* skip expensive cmpxchg if there are items in the list */
-		if (READ_ONCE(tctx->task_list.first) != &fake)
-			continue;
-		if (ts.locked && !wq_list_empty(&ctx->submit_state.compl_reqs)) {
-			io_submit_flush_completions(ctx);
-			if (READ_ONCE(tctx->task_list.first) != &fake)
-				continue;
-		}
-		node = io_llist_cmpxchg(&tctx->task_list, &fake, NULL);
-	} while (node != &fake);
+	node = llist_del_all(&tctx->task_list);
+	if (node)
+		count = handle_tw_list(node, &ctx, &ts);
 
 	ctx_flush_and_put(ctx, &ts);
 
@@ -1297,7 +1266,7 @@ void tctx_task_work(struct callback_head *cb)
 	if (unlikely(atomic_read(&tctx->in_cancel)))
 		io_uring_drop_tctx_refs(current);
 
-	trace_io_uring_task_work_run(tctx, count, loops);
+	trace_io_uring_task_work_run(tctx, count, 1);
 }
 
 static inline void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
-- 
2.43.0


