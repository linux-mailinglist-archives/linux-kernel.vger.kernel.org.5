Return-Path: <linux-kernel+bounces-114008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA17888F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C48A1F31BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA221482ED;
	Sun, 24 Mar 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU0Fi7+m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB212F5B4;
	Sun, 24 Mar 2024 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321282; cv=none; b=pAbdRMJqoYBOMJSJzXPpgNKKf20YRQVaHVcpK/VJ8oaNvlJNuHG6X6h65rdFEEVYzg+Xsj1xB5pNpIz6MJibr1b0pMZV1DjjVdFR2c4wnd3cyHzarHVsxFNyoJlAjal4db4EgKfg8/pf7JpFlTaXg6C7W2H8wDgJ1/in4y+QLAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321282; c=relaxed/simple;
	bh=lG9e6KRtjN/U1H6KMmjH5jokgsg175DdzyNoabZ/AVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkrfpqbXKR//dHyRYBMdtkv1RlM7Jv+oh6Sox8kJbYrsHDIedVx+HChV1617dSwFxbK0LrU0TDINmXmYfA8hidG+sn77BMGZITK157la/4Uf22pse7rAcetatwtAwErdNQhI36dOsnD7KxO2MJ0nGBkPvPAvNEQGEmPtqt77AkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU0Fi7+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BFAC433F1;
	Sun, 24 Mar 2024 23:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321281;
	bh=lG9e6KRtjN/U1H6KMmjH5jokgsg175DdzyNoabZ/AVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nU0Fi7+mXK9HZQnflVHCUxyk9zm9UW9GCdftn4k4j4+Do71TpjWJvdPgVX4YidWnO
	 JCafBotnBIsH41yANIFK6PhE9y9cComd8TAxwAYy7rI+vAMXxQJ6MX28RSKFswoDVa
	 bfKn1qMkgD5bFNqOCzarSeh+TvhPQFcFV9uj4fgy+jmf2KL16dOwYqNo+pSXJbkM2z
	 AYViXq6SD5Y4PPtKPWifngeWGA3BEE6dK8P84Btxn0gUHyXVekNtX0HQYiXFzdFsk3
	 N5B87PMOtI2RvjV4Pdnyg9p+fWS3gXDYwuoruFpqLChfSk9tFmPDwyFtG2BN3iY2lF
	 fEB+gNNhjul/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 003/638] io_uring: drop any code related to SCM_RIGHTS
Date: Sun, 24 Mar 2024 18:50:40 -0400
Message-ID: <20240324230116.1348576-4-sashal@kernel.org>
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

This is dead code after we dropped support for passing io_uring fds
over SCM_RIGHTS, get rid of it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/io_uring_types.h |   3 -
 io_uring/filetable.c           |  11 +--
 io_uring/io_uring.c            |  32 +------
 io_uring/rsrc.c                | 169 +--------------------------------
 io_uring/rsrc.h                |  15 ---
 5 files changed, 10 insertions(+), 220 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 5fd664fb71c86..731beb3198c4f 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -347,9 +347,6 @@ struct io_ring_ctx {
 
 	struct list_head		io_buffers_pages;
 
-	#if defined(CONFIG_UNIX)
-		struct socket		*ring_sock;
-	#endif
 	/* hashed buffered write serialization */
 	struct io_wq_hash		*hash_map;
 
diff --git a/io_uring/filetable.c b/io_uring/filetable.c
index e7d749991de42..6e86e6188dbee 100644
--- a/io_uring/filetable.c
+++ b/io_uring/filetable.c
@@ -87,13 +87,10 @@ static int io_install_fixed_file(struct io_ring_ctx *ctx, struct file *file,
 		io_file_bitmap_clear(&ctx->file_table, slot_index);
 	}
 
-	ret = io_scm_file_account(ctx, file);
-	if (!ret) {
-		*io_get_tag_slot(ctx->file_data, slot_index) = 0;
-		io_fixed_file_set(file_slot, file);
-		io_file_bitmap_set(&ctx->file_table, slot_index);
-	}
-	return ret;
+	*io_get_tag_slot(ctx->file_data, slot_index) = 0;
+	io_fixed_file_set(file_slot, file);
+	io_file_bitmap_set(&ctx->file_table, slot_index);
+	return 0;
 }
 
 int __io_fixed_fd_install(struct io_ring_ctx *ctx, struct file *file,
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 747d2a6ecab89..2744d72f10858 100644
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
@@ -2931,13 +2930,6 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		io_rsrc_node_destroy(ctx, ctx->rsrc_node);
 
 	WARN_ON_ONCE(!list_empty(&ctx->rsrc_ref_list));
-
-#if defined(CONFIG_UNIX)
-	if (ctx->ring_sock) {
-		ctx->ring_sock->file = NULL; /* so that iput() is called */
-		sock_release(ctx->ring_sock);
-	}
-#endif
 	WARN_ON_ONCE(!list_empty(&ctx->ltimeout_list));
 
 	io_alloc_cache_free(&ctx->rsrc_node_cache, io_rsrc_node_cache_free);
@@ -3825,32 +3817,12 @@ static int io_uring_install_fd(struct file *file)
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
index dde501abd7196..95230921b16d0 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -24,7 +24,6 @@ struct io_rsrc_update {
 };
 
 static void io_rsrc_buf_put(struct io_ring_ctx *ctx, struct io_rsrc_put *prsrc);
-static void io_rsrc_file_put(struct io_ring_ctx *ctx, struct io_rsrc_put *prsrc);
 static int io_sqe_buffer_register(struct io_ring_ctx *ctx, struct iovec *iov,
 				  struct io_mapped_ubuf **pimu,
 				  struct page **last_hpage);
@@ -157,7 +156,7 @@ static void io_rsrc_put_work(struct io_rsrc_node *node)
 
 	switch (node->type) {
 	case IORING_RSRC_FILE:
-		io_rsrc_file_put(node->ctx, prsrc);
+		fput(prsrc->file);
 		break;
 	case IORING_RSRC_BUFFER:
 		io_rsrc_buf_put(node->ctx, prsrc);
@@ -402,23 +401,13 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 				break;
 			}
 			/*
-			 * Don't allow io_uring instances to be registered. If
-			 * UNIX isn't enabled, then this causes a reference
-			 * cycle and this instance can never get freed. If UNIX
-			 * is enabled we'll handle it just fine, but there's
-			 * still no point in allowing a ring fd as it doesn't
-			 * support regular read/write anyway.
+			 * Don't allow io_uring instances to be registered.
 			 */
 			if (io_is_uring_fops(file)) {
 				fput(file);
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
@@ -675,22 +664,12 @@ void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
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
@@ -718,137 +697,6 @@ int io_sqe_files_unregister(struct io_ring_ctx *ctx)
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
-		skb->destructor = io_uring_destruct_scm;
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
-static __cold void io_rsrc_file_scm_put(struct io_ring_ctx *ctx, struct file *file)
-{
-#if defined(CONFIG_UNIX)
-	struct sock *sock = ctx->ring_sock->sk;
-	struct sk_buff_head list, *head = &sock->sk_receive_queue;
-	struct sk_buff *skb;
-	int i;
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
-#endif
-}
-
-static void io_rsrc_file_put(struct io_ring_ctx *ctx, struct io_rsrc_put *prsrc)
-{
-	struct file *file = prsrc->file;
-
-	if (likely(!io_file_need_scm(file)))
-		fput(file);
-	else
-		io_rsrc_file_scm_put(ctx, file);
-}
-
 int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 			  unsigned nr_args, u64 __user *tags)
 {
@@ -897,21 +745,12 @@ int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
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
index 08ac0d8e07ef8..7238b9cfe33b6 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -75,21 +75,6 @@ int io_sqe_files_unregister(struct io_ring_ctx *ctx);
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


