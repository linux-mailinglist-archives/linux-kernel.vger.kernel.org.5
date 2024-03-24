Return-Path: <linux-kernel+bounces-113627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22568885BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B58E288467
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B041D4C40;
	Sun, 24 Mar 2024 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvfPQ7/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239DE1D1D65;
	Sun, 24 Mar 2024 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320534; cv=none; b=YQU+m/n4ie0VcOPbW2pL5/zjFLuH/yOlItb1LtAg5DWcGYO/h1OBf0pWjpM/9Vawi0otANpBQe/Eu2fw++RFzkbukc2es8MfhZT4aH5xJCu4jrD9GDhVc9npWESTbM7dA0VSyu9pl1Ff7PU1I9rXnqIqmfQbNX1vCEl//yG3TB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320534; c=relaxed/simple;
	bh=saSomq0+pwPHqV4U1Bpn2rUVGDiMXZ3Ct/2tCLU8Ur0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msfPDdgZ/XluGHE0z/4C1EPNvamS5ivilsG1yAmAm0qXjDsJ/WtvUD2qXdphATpIBdl+c1wbrYwtENZdhT2jLz4Hbsck3Erk/OqEGijRteGPsOez7zYysPtbhM6CRoBGll1wzMI++FVYsdac8i0nEHi8fngE1cEx+JUzO5jm+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvfPQ7/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326E6C433F1;
	Sun, 24 Mar 2024 22:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320532;
	bh=saSomq0+pwPHqV4U1Bpn2rUVGDiMXZ3Ct/2tCLU8Ur0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvfPQ7/eY2a4vhEUnyfHepTDE12hzbG+LvUudrGYE+Vw6x20y6ZalVL345odsJvXK
	 khbCwT8VhD6IMEwtdey5fBV6I5UEy+fU5YLoem7cHm55QDci5ccOajlsFDpaMAtlDO
	 S0WxQSSdD0Xz5GkXGSsN0QhVGr8DeySWL/FpsqSsTbsG0DFXXfmQl1p61ZiX7hcfms
	 MfMXRkd0LKlIDFBU11PYyekHGCVbB6yEIHYwxZG9efMhhokTSWx1oLjiFYQaPcvxWU
	 EGN5r8Q0g8lrUB3yZjVzuMzUWKw+Z9lvxRUa071OngqJu/sY0gkkyOyj6lcIeF/z8z
	 aA/suHgqkCq0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 094/713] io_uring: remove looping around handling traditional task_work
Date: Sun, 24 Mar 2024 18:37:00 -0400
Message-ID: <20240324224720.1345309-95-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index f8d145fb40bbc..763ef8fff614f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1174,12 +1174,11 @@ static void ctx_flush_and_put(struct io_ring_ctx *ctx, struct io_tw_state *ts)
 
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
@@ -1203,7 +1202,7 @@ static unsigned int handle_tw_list(struct llist_node *node,
 			*ctx = NULL;
 			cond_resched();
 		}
-	}
+	} while (node);
 
 	return count;
 }
@@ -1222,22 +1221,6 @@ static inline struct llist_node *io_llist_xchg(struct llist_head *head,
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
@@ -1272,9 +1255,7 @@ void tctx_task_work(struct callback_head *cb)
 	struct io_ring_ctx *ctx = NULL;
 	struct io_uring_task *tctx = container_of(cb, struct io_uring_task,
 						  task_work);
-	struct llist_node fake = {};
 	struct llist_node *node;
-	unsigned int loops = 0;
 	unsigned int count = 0;
 
 	if (unlikely(current->flags & PF_EXITING)) {
@@ -1282,21 +1263,9 @@ void tctx_task_work(struct callback_head *cb)
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
 
@@ -1304,7 +1273,7 @@ void tctx_task_work(struct callback_head *cb)
 	if (unlikely(atomic_read(&tctx->in_cancel)))
 		io_uring_drop_tctx_refs(current);
 
-	trace_io_uring_task_work_run(tctx, count, loops);
+	trace_io_uring_task_work_run(tctx, count, 1);
 }
 
 static inline void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
-- 
2.43.0


