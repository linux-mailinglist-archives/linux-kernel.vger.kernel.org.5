Return-Path: <linux-kernel+bounces-114488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65E889026
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4631F2BDAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4351802B0;
	Sun, 24 Mar 2024 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8GaUDlr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E2143C6D;
	Sun, 24 Mar 2024 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321934; cv=none; b=Lm4Bey8Cq8rJYJ5F13qSp3Rpbj/jq0RGKOP/B6z7I2MkvFiY6cCvtQAox3etkW7JDiiZg1HXxXOQ/o671TrzoFn+Mpb5Ftl6mimDCk/HEa5yzurRgCC4PbmmlHkavkoDEJZGTo8JlxzZeTwv1X0VV0uAQ91KLqIS6XddZvbF5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321934; c=relaxed/simple;
	bh=MBOlApBH+Ue2ggX5YRsrJ0g8BPJ06b3hhJaPRlT76YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APiYlLg4trOoNqOcBN1V7hp1fXA6ZOg2HiC5AxvtrHmzK7vaUALmUk6zIUI/r6v4M4URzvRNLRCZfIpNMpAlXg5ZJCHUuaklaFGmQ9knsV4zVW8bSkb1LY0pviHRLpIa8HdAjDEE2H8mUuimZV5N9HKvF6d7pGvjyXRHpKKtxKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8GaUDlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08287C43399;
	Sun, 24 Mar 2024 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321933;
	bh=MBOlApBH+Ue2ggX5YRsrJ0g8BPJ06b3hhJaPRlT76YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8GaUDlrfSLOi2Usp9Bd6unKkZOxyhO1utxa8cKoDCtwAf8kTVlTxSgCD9YblRAO5
	 SsQtaZ867reqBK+oVEJiAdsfxlfxFk0EO1F+GOYEFRGYKufditBrttHKf/wVdQxtpN
	 lExOoUW7kvAObwxTV4QHDmBgRpBda3VgCpeu8P8mj102HHzMyjsJlWbnW1RBLsQb3N
	 5FbdIWoSKayLlkzBumOmkulTHwLD4P4Fkz5La3mXirjsyW90xRln6KQnrT6ShhxMz9
	 Q92t+4knLj2/qo1FcrkI1+W1TCz89YEE+tGWDYYxZharSEcHW5tXVkw0XsTbd4MCsR
	 hhxfKifboeBQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 004/451] io_uring: drop any code related to SCM_RIGHTS
Date: Sun, 24 Mar 2024 19:04:40 -0400
Message-ID: <20240324231207.1351418-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
 include/linux/io_uring_types.h |   3 -
 io_uring/filetable.c           |  10 +--
 io_uring/io_uring.c            |  31 +------
 io_uring/rsrc.c                | 151 +--------------------------------
 io_uring/rsrc.h                |  15 ----
 5 files changed, 8 insertions(+), 202 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index f5b687a787a34..37aeea266ebb3 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -330,9 +330,6 @@ struct io_ring_ctx {
 
 	struct list_head		io_buffers_pages;
 
-	#if defined(CONFIG_UNIX)
-		struct socket		*ring_sock;
-	#endif
 	/* hashed buffered write serialization */
 	struct io_wq_hash		*hash_map;
 
diff --git a/io_uring/filetable.c b/io_uring/filetable.c
index b80614e7d6051..4660cb89ea9f5 100644
--- a/io_uring/filetable.c
+++ b/io_uring/filetable.c
@@ -95,12 +95,10 @@ static int io_install_fixed_file(struct io_ring_ctx *ctx, struct file *file,
 		needs_switch = true;
 	}
 
-	ret = io_scm_file_account(ctx, file);
-	if (!ret) {
-		*io_get_tag_slot(ctx->file_data, slot_index) = 0;
-		io_fixed_file_set(file_slot, file);
-		io_file_bitmap_set(&ctx->file_table, slot_index);
-	}
+	*io_get_tag_slot(ctx->file_data, slot_index) = 0;
+	io_fixed_file_set(file_slot, file);
+	io_file_bitmap_set(&ctx->file_table, slot_index);
+	return 0;
 err:
 	if (needs_switch)
 		io_rsrc_node_switch(ctx, ctx->file_data);
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index cf7dd62da0e37..415248c1f82c6 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -60,7 +60,6 @@
 #include <linux/net.h>
 #include <net/sock.h>
 #include <net/af_unix.h>
-#include <net/scm.h>
 #include <linux/anon_inodes.h>
 #include <linux/sched/mm.h>
 #include <linux/uaccess.h>
@@ -2628,12 +2627,6 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
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
@@ -3438,32 +3431,12 @@ static int io_uring_install_fd(struct io_ring_ctx *ctx, struct file *file)
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
-	file = anon_inode_getfile_secure("[io_uring]", &io_uring_fops, ctx,
+	return anon_inode_getfile_secure("[io_uring]", &io_uring_fops, ctx,
 					 O_RDWR | O_CLOEXEC, NULL);
-#if defined(CONFIG_UNIX)
-	if (IS_ERR(file)) {
-		sock_release(ctx->ring_sock);
-		ctx->ring_sock = NULL;
-	} else {
-		ctx->ring_sock->file = file;
-	}
-#endif
-	return file;
 }
 
 static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 7ada0339b3870..ac658cfa89c63 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -494,11 +494,6 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 				err = -EBADF;
 				break;
 			}
-			err = io_scm_file_account(ctx, file);
-			if (err) {
-				fput(file);
-				break;
-			}
 			*io_get_tag_slot(data, i) = tag;
 			io_fixed_file_set(file_slot, file);
 			io_file_bitmap_set(&ctx->file_table, i);
@@ -762,22 +757,12 @@ void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
 	for (i = 0; i < ctx->nr_user_files; i++) {
 		struct file *file = io_file_from_index(&ctx->file_table, i);
 
-		/* skip scm accounted files, they'll be freed by ->ring_sock */
-		if (!file || io_file_need_scm(file))
+		if (!file)
 			continue;
 		io_file_bitmap_clear(&ctx->file_table, i);
 		fput(file);
 	}
 
-#if defined(CONFIG_UNIX)
-	if (ctx->ring_sock) {
-		struct sock *sock = ctx->ring_sock->sk;
-		struct sk_buff *skb;
-
-		while ((skb = skb_dequeue(&sock->sk_receive_queue)) != NULL)
-			kfree_skb(skb);
-	}
-#endif
 	io_free_file_tables(&ctx->file_table);
 	io_file_table_set_alloc_range(ctx, 0, 0);
 	io_rsrc_data_free(ctx->file_data);
@@ -805,134 +790,11 @@ int io_sqe_files_unregister(struct io_ring_ctx *ctx)
 	return ret;
 }
 
-/*
- * Ensure the UNIX gc is aware of our file set, so we are certain that
- * the io_uring can be safely unregistered on process exit, even if we have
- * loops in the file referencing. We account only files that can hold other
- * files because otherwise they can't form a loop and so are not interesting
- * for GC.
- */
-int __io_scm_file_account(struct io_ring_ctx *ctx, struct file *file)
-{
-#if defined(CONFIG_UNIX)
-	struct sock *sk = ctx->ring_sock->sk;
-	struct sk_buff_head *head = &sk->sk_receive_queue;
-	struct scm_fp_list *fpl;
-	struct sk_buff *skb;
-
-	if (likely(!io_file_need_scm(file)))
-		return 0;
-
-	/*
-	 * See if we can merge this file into an existing skb SCM_RIGHTS
-	 * file set. If there's no room, fall back to allocating a new skb
-	 * and filling it in.
-	 */
-	spin_lock_irq(&head->lock);
-	skb = skb_peek(head);
-	if (skb && UNIXCB(skb).fp->count < SCM_MAX_FD)
-		__skb_unlink(skb, head);
-	else
-		skb = NULL;
-	spin_unlock_irq(&head->lock);
-
-	if (!skb) {
-		fpl = kzalloc(sizeof(*fpl), GFP_KERNEL);
-		if (!fpl)
-			return -ENOMEM;
-
-		skb = alloc_skb(0, GFP_KERNEL);
-		if (!skb) {
-			kfree(fpl);
-			return -ENOMEM;
-		}
-
-		fpl->user = get_uid(current_user());
-		fpl->max = SCM_MAX_FD;
-		fpl->count = 0;
-
-		UNIXCB(skb).fp = fpl;
-		skb->sk = sk;
-		skb->scm_io_uring = 1;
-		skb->destructor = unix_destruct_scm;
-		refcount_add(skb->truesize, &sk->sk_wmem_alloc);
-	}
-
-	fpl = UNIXCB(skb).fp;
-	fpl->fp[fpl->count++] = get_file(file);
-	unix_inflight(fpl->user, file);
-	skb_queue_head(head, skb);
-	fput(file);
-#endif
-	return 0;
-}
-
 static void io_rsrc_file_put(struct io_ring_ctx *ctx, struct io_rsrc_put *prsrc)
 {
 	struct file *file = prsrc->file;
-#if defined(CONFIG_UNIX)
-	struct sock *sock = ctx->ring_sock->sk;
-	struct sk_buff_head list, *head = &sock->sk_receive_queue;
-	struct sk_buff *skb;
-	int i;
-
-	if (!io_file_need_scm(file)) {
-		fput(file);
-		return;
-	}
-
-	__skb_queue_head_init(&list);
-
-	/*
-	 * Find the skb that holds this file in its SCM_RIGHTS. When found,
-	 * remove this entry and rearrange the file array.
-	 */
-	skb = skb_dequeue(head);
-	while (skb) {
-		struct scm_fp_list *fp;
 
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
 
 int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
@@ -986,21 +848,12 @@ int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 			goto fail;
 
 		/*
-		 * Don't allow io_uring instances to be registered. If UNIX
-		 * isn't enabled, then this causes a reference cycle and this
-		 * instance can never get freed. If UNIX is enabled we'll
-		 * handle it just fine, but there's still no point in allowing
-		 * a ring fd as it doesn't support regular read/write anyway.
+		 * Don't allow io_uring instances to be registered.
 		 */
 		if (io_is_uring_fops(file)) {
 			fput(file);
 			goto fail;
 		}
-		ret = io_scm_file_account(ctx, file);
-		if (ret) {
-			fput(file);
-			goto fail;
-		}
 		file_slot = io_fixed_file_slot(&ctx->file_table, i);
 		io_fixed_file_set(file_slot, file);
 		io_file_bitmap_set(&ctx->file_table, i);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index acaf8dad05401..85f145607c620 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -77,21 +77,6 @@ int io_sqe_files_unregister(struct io_ring_ctx *ctx);
 int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 			  unsigned nr_args, u64 __user *tags);
 
-int __io_scm_file_account(struct io_ring_ctx *ctx, struct file *file);
-
-static inline bool io_file_need_scm(struct file *filp)
-{
-	return false;
-}
-
-static inline int io_scm_file_account(struct io_ring_ctx *ctx,
-				      struct file *file)
-{
-	if (likely(!io_file_need_scm(file)))
-		return 0;
-	return __io_scm_file_account(ctx, file);
-}
-
 int io_register_files_update(struct io_ring_ctx *ctx, void __user *arg,
 			     unsigned nr_args);
 int io_register_rsrc_update(struct io_ring_ctx *ctx, void __user *arg,
-- 
2.43.0


