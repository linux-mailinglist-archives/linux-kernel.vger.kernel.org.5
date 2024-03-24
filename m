Return-Path: <linux-kernel+bounces-114933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D4488929D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB701C2E331
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7476E13DDC8;
	Mon, 25 Mar 2024 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQhydWND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C02801F6;
	Sun, 24 Mar 2024 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323632; cv=none; b=UYXrP9YGSeL8cXIplv0WUmz2FqO0S+ysZIiibU3U71XD00GUiClT2NpqImdlS/mW1b4qhPhDBvk4ut2LpVxQ/uXv/1kBwKN7XFtBMihLxt9pvBJxnPhbwYeOQvmrmpQQyIdl8zJZZRzzDaJaQ+zbN47e5VamcfNeIKpTA0+1gbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323632; c=relaxed/simple;
	bh=J+kza5llwUr7p0ALHqCiykreV4U0IS3mZ8uq84k+KVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYRH/MW6lEoNrYtnkpp9yc91x0Ee1H9k94ms+TxWblws0W/yzEU3gALpPndDDWA+RCkViZVgYAttSryyRohOSYTLbSTOT82MfAKMsduXlVI62fY5htrW2GWZdBLcN5e38UN0WRDOGuL8Ph8Mthr1gGssaRTXp9VE+LLj1JJn7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQhydWND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593BCC43390;
	Sun, 24 Mar 2024 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323630;
	bh=J+kza5llwUr7p0ALHqCiykreV4U0IS3mZ8uq84k+KVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQhydWNDKs/dGOn8VrUJl5b/KRokv5+CqzWDfrvryfUq64s9sT0pi79WH5k91YCA9
	 Q0bTfnc9bHdgwWvN5PyEdC//hyxdl7szV8s+GABLM5QeipVLQDWjJMQhknq3daeV5n
	 nMOVMlsu2hTk2oeX6bBIwe0XgIeqEZa9TVUwGoFbZsz8K7qjOUhnSal9gXbpGcZk/w
	 SDPaO9oYmysm3rM5i6cLp6XB7sRnSUFu3peqpaq2H88vhgu2gBkIzo6BPeD7lSqjYz
	 tfz3Kpfn2W45VVpwxJVMEQw9LH/pGHrNUYRYwNWLBwoBLq5DuQ1ewQVyQNxvwtsBdq
	 GkEm/4zYU1L0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 002/238] io_uring: drop any code related to SCM_RIGHTS
Date: Sun, 24 Mar 2024 19:36:30 -0400
Message-ID: <20240324234027.1354210-3-sashal@kernel.org>
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

From: Jens Axboe <axboe@kernel.dk>

Commit 6e5e6d274956305f1fc0340522b38f5f5be74bdb upstream.

This is dead code after we dropped support for passing io_uring fds
over SCM_RIGHTS, get rid of it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 211 +-------------------------------------------
 1 file changed, 3 insertions(+), 208 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index a80c808d3a0ef..67a355f27ad80 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -62,7 +62,6 @@
 #include <linux/net.h>
 #include <net/sock.h>
 #include <net/af_unix.h>
-#include <net/scm.h>
 #include <linux/anon_inodes.h>
 #include <linux/sched/mm.h>
 #include <linux/uaccess.h>
@@ -440,9 +439,6 @@ struct io_ring_ctx {
 
 	/* Keep this last, we don't need it for the fast path */
 	struct {
-		#if defined(CONFIG_UNIX)
-			struct socket		*ring_sock;
-		#endif
 		/* hashed buffered write serialization */
 		struct io_wq_hash		*hash_map;
 
@@ -7976,15 +7972,6 @@ static void io_free_file_tables(struct io_file_table *table)
 
 static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
 {
-#if defined(CONFIG_UNIX)
-	if (ctx->ring_sock) {
-		struct sock *sock = ctx->ring_sock->sk;
-		struct sk_buff *skb;
-
-		while ((skb = skb_dequeue(&sock->sk_receive_queue)) != NULL)
-			kfree_skb(skb);
-	}
-#else
 	int i;
 
 	for (i = 0; i < ctx->nr_user_files; i++) {
@@ -7994,7 +7981,6 @@ static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
 		if (file)
 			fput(file);
 	}
-#endif
 	io_free_file_tables(&ctx->file_table);
 	io_rsrc_data_free(ctx->file_data);
 	ctx->file_data = NULL;
@@ -8146,170 +8132,11 @@ static struct io_sq_data *io_get_sq_data(struct io_uring_params *p,
 	return sqd;
 }
 
-#if defined(CONFIG_UNIX)
-/*
- * Ensure the UNIX gc is aware of our file set, so we are certain that
- * the io_uring can be safely unregistered on process exit, even if we have
- * loops in the file referencing.
- */
-static int __io_sqe_files_scm(struct io_ring_ctx *ctx, int nr, int offset)
-{
-	struct sock *sk = ctx->ring_sock->sk;
-	struct scm_fp_list *fpl;
-	struct sk_buff *skb;
-	int i, nr_files;
-
-	fpl = kzalloc(sizeof(*fpl), GFP_KERNEL);
-	if (!fpl)
-		return -ENOMEM;
-
-	skb = alloc_skb(0, GFP_KERNEL);
-	if (!skb) {
-		kfree(fpl);
-		return -ENOMEM;
-	}
-
-	skb->sk = sk;
-	skb->scm_io_uring = 1;
-
-	nr_files = 0;
-	fpl->user = get_uid(current_user());
-	for (i = 0; i < nr; i++) {
-		struct file *file = io_file_from_index(ctx, i + offset);
-
-		if (!file)
-			continue;
-		fpl->fp[nr_files] = get_file(file);
-		unix_inflight(fpl->user, fpl->fp[nr_files]);
-		nr_files++;
-	}
-
-	if (nr_files) {
-		fpl->max = SCM_MAX_FD;
-		fpl->count = nr_files;
-		UNIXCB(skb).fp = fpl;
-		skb->destructor = unix_destruct_scm;
-		refcount_add(skb->truesize, &sk->sk_wmem_alloc);
-		skb_queue_head(&sk->sk_receive_queue, skb);
-
-		for (i = 0; i < nr; i++) {
-			struct file *file = io_file_from_index(ctx, i + offset);
-
-			if (file)
-				fput(file);
-		}
-	} else {
-		kfree_skb(skb);
-		free_uid(fpl->user);
-		kfree(fpl);
-	}
-
-	return 0;
-}
-
-/*
- * If UNIX sockets are enabled, fd passing can cause a reference cycle which
- * causes regular reference counting to break down. We rely on the UNIX
- * garbage collection to take care of this problem for us.
- */
-static int io_sqe_files_scm(struct io_ring_ctx *ctx)
-{
-	unsigned left, total;
-	int ret = 0;
-
-	total = 0;
-	left = ctx->nr_user_files;
-	while (left) {
-		unsigned this_files = min_t(unsigned, left, SCM_MAX_FD);
-
-		ret = __io_sqe_files_scm(ctx, this_files, total);
-		if (ret)
-			break;
-		left -= this_files;
-		total += this_files;
-	}
-
-	if (!ret)
-		return 0;
-
-	while (total < ctx->nr_user_files) {
-		struct file *file = io_file_from_index(ctx, total);
-
-		if (file)
-			fput(file);
-		total++;
-	}
-
-	return ret;
-}
-#else
-static int io_sqe_files_scm(struct io_ring_ctx *ctx)
-{
-	return 0;
-}
-#endif
-
 static void io_rsrc_file_put(struct io_ring_ctx *ctx, struct io_rsrc_put *prsrc)
 {
 	struct file *file = prsrc->file;
-#if defined(CONFIG_UNIX)
-	struct sock *sock = ctx->ring_sock->sk;
-	struct sk_buff_head list, *head = &sock->sk_receive_queue;
-	struct sk_buff *skb;
-	int i;
 
-	__skb_queue_head_init(&list);
-
-	/*
-	 * Find the skb that holds this file in its SCM_RIGHTS. When found,
-	 * remove this entry and rearrange the file array.
-	 */
-	skb = skb_dequeue(head);
-	while (skb) {
-		struct scm_fp_list *fp;
-
-		fp = UNIXCB(skb).fp;
-		for (i = 0; i < fp->count; i++) {
-			int left;
-
-			if (fp->fp[i] != file)
-				continue;
-
-			unix_notinflight(fp->user, fp->fp[i]);
-			left = fp->count - 1 - i;
-			if (left) {
-				memmove(&fp->fp[i], &fp->fp[i + 1],
-						left * sizeof(struct file *));
-			}
-			fp->count--;
-			if (!fp->count) {
-				kfree_skb(skb);
-				skb = NULL;
-			} else {
-				__skb_queue_tail(&list, skb);
-			}
-			fput(file);
-			file = NULL;
-			break;
-		}
-
-		if (!file)
-			break;
-
-		__skb_queue_tail(&list, skb);
-
-		skb = skb_dequeue(head);
-	}
-
-	if (skb_peek(&list)) {
-		spin_lock_irq(&head->lock);
-		while ((skb = __skb_dequeue(&list)) != NULL)
-			__skb_queue_tail(head, skb);
-		spin_unlock_irq(&head->lock);
-	}
-#else
 	fput(file);
-#endif
 }
 
 static void __io_rsrc_put_work(struct io_rsrc_node *ref_node)
@@ -8420,12 +8247,6 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 		io_fixed_file_set(io_fixed_file_slot(&ctx->file_table, i), file);
 	}
 
-	ret = io_sqe_files_scm(ctx);
-	if (ret) {
-		__io_sqe_files_unregister(ctx);
-		return ret;
-	}
-
 	io_rsrc_node_switch(ctx, NULL);
 	return ret;
 out_fput:
@@ -9382,12 +9203,6 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	WARN_ON_ONCE(!list_empty(&ctx->rsrc_ref_list));
 	WARN_ON_ONCE(!llist_empty(&ctx->rsrc_put_llist));
 
-#if defined(CONFIG_UNIX)
-	if (ctx->ring_sock) {
-		ctx->ring_sock->file = NULL; /* so that iput() is called */
-		sock_release(ctx->ring_sock);
-	}
-#endif
 	WARN_ON_ONCE(!list_empty(&ctx->ltimeout_list));
 
 	if (ctx->mm_account) {
@@ -10329,32 +10144,12 @@ static int io_uring_install_fd(struct io_ring_ctx *ctx, struct file *file)
 /*
  * Allocate an anonymous fd, this is what constitutes the application
  * visible backing of an io_uring instance. The application mmaps this
- * fd to gain access to the SQ/CQ ring details. If UNIX sockets are enabled,
- * we have to tie this fd to a socket for file garbage collection purposes.
+ * fd to gain access to the SQ/CQ ring details.
  */
 static struct file *io_uring_get_file(struct io_ring_ctx *ctx)
 {
-	struct file *file;
-#if defined(CONFIG_UNIX)
-	int ret;
-
-	ret = sock_create_kern(&init_net, PF_UNIX, SOCK_RAW, IPPROTO_IP,
-				&ctx->ring_sock);
-	if (ret)
-		return ERR_PTR(ret);
-#endif
-
-	file = anon_inode_getfile("[io_uring]", &io_uring_fops, ctx,
-					O_RDWR | O_CLOEXEC);
-#if defined(CONFIG_UNIX)
-	if (IS_ERR(file)) {
-		sock_release(ctx->ring_sock);
-		ctx->ring_sock = NULL;
-	} else {
-		ctx->ring_sock->file = file;
-	}
-#endif
-	return file;
+	return anon_inode_getfile("[io_uring]", &io_uring_fops, ctx,
+				  O_RDWR | O_CLOEXEC);
 }
 
 static int io_uring_create(unsigned entries, struct io_uring_params *p,
-- 
2.43.0


