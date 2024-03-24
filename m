Return-Path: <linux-kernel+bounces-113609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A7E888E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C10B225C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF218061F;
	Sun, 24 Mar 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNfuUV+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09DA1CF8B6;
	Sun, 24 Mar 2024 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320445; cv=none; b=Ywq9/7Gxvc3f+yheNnTQow4flk/LyB2o4M1owhnH1PovgavuidIm9Ovi8/BWBsdPsVXH9ybw0j505AjJFk1JNlZQVgu6jadhe5+iCN4HTnaL0CtcMf10LxyfPJ0nRXlcMAiqAKs6WPXpwuvqlipykxGKKMiw254OikYUS+zIrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320445; c=relaxed/simple;
	bh=FbFa6wgDSvlU/O36o9QDzhEzhmNt5K9ijb5JDOBPrFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oryhAt9IbzVvkySQ42YvbGnEMT6KePKJFCr2+zPO+WsCsJtmGyDq+A/JkLsS6C4fxxs9PgfOEgD703aLdkdbNknf4iG8+gHoQw5hWcq0ERK5aJ3W0ZKpYGOMt4xkde8jyES33bMXurJnvHjOK0DIPLHAHg/arfiIGUJzlL7oyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNfuUV+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE880C433A6;
	Sun, 24 Mar 2024 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320444;
	bh=FbFa6wgDSvlU/O36o9QDzhEzhmNt5K9ijb5JDOBPrFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNfuUV+y04PlMQn+uVh9My6mNzGL501GwkernuELK0LwdMzoiwc8MoDMTGO9vOiO0
	 8ConQUzVJmhfxLzVkACibTEfD5ytALHBn4KOgXoTmXmmj9g1jVTCZdEkFYmta9jnNK
	 ZzsjOQ6yYV4UbDVsxPY782E5dfH6qtMz+lcR+vlvw/wI1ZSptDZsZSbnvixVS1PbDD
	 BfO+UKW1TU/8SCVZEc58iZRhNl6QcCjTAY7PlDZvKYrWSR3Qtx0NNBa8EwmM9P7xlx
	 X0F6RcLA+/enfZJupXKuDJpZa9a8HedMOWMnu7Er86+jnpR1wvUxfERJQV7KOCsEXQ
	 iHwzdlxYW4Gnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 002/713] io_uring/unix: drop usage of io_uring socket
Date: Sun, 24 Mar 2024 18:35:28 -0400
Message-ID: <20240324224720.1345309-3-sashal@kernel.org>
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

Commit a4104821ad651d8a0b374f0b2474c345bbb42f82 upstream.

Since we no longer allow sending io_uring fds over SCM_RIGHTS, move to
using io_is_uring_fops() to detect whether this is a io_uring fd or not.
With that done, kill off io_uring_get_socket() as nobody calls it
anymore.

This is in preparation to yanking out the rest of the core related to
unix gc with io_uring.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/io_uring.h |  9 +++++----
 io_uring/io_uring.c      | 13 -------------
 io_uring/io_uring.h      |  1 -
 net/core/scm.c           |  2 +-
 net/unix/scm.c           |  4 +---
 5 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index aefb73eeeebff..b3a32687f5143 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -93,6 +93,7 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags);
 void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		unsigned int issue_flags);
 struct task_struct *io_uring_cmd_get_task(struct io_uring_cmd *cmd);
+bool io_is_uring_fops(struct file *file);
 #else
 static inline int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter, void *ioucmd)
@@ -111,10 +112,6 @@ static inline void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
 			void (*task_work_cb)(struct io_uring_cmd *, unsigned))
 {
 }
-static inline struct sock *io_uring_get_socket(struct file *file)
-{
-	return NULL;
-}
 static inline void io_uring_task_cancel(void)
 {
 }
@@ -141,6 +138,10 @@ static inline struct task_struct *io_uring_cmd_get_task(struct io_uring_cmd *cmd
 {
 	return NULL;
 }
+static inline bool io_is_uring_fops(struct file *file)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 59f5791c90c31..06bd8795a87d1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -177,19 +177,6 @@ static struct ctl_table kernel_io_uring_disabled_table[] = {
 };
 #endif
 
-struct sock *io_uring_get_socket(struct file *file)
-{
-#if defined(CONFIG_UNIX)
-	if (io_is_uring_fops(file)) {
-		struct io_ring_ctx *ctx = file->private_data;
-
-		return ctx->ring_sock->sk;
-	}
-#endif
-	return NULL;
-}
-EXPORT_SYMBOL(io_uring_get_socket);
-
 static inline void io_submit_flush_completions(struct io_ring_ctx *ctx)
 {
 	if (!wq_list_empty(&ctx->submit_state.compl_reqs) ||
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index c9992cd7f1385..0d66a7058dbe1 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -61,7 +61,6 @@ struct file *io_file_get_fixed(struct io_kiocb *req, int fd,
 			       unsigned issue_flags);
 
 void __io_req_task_work_add(struct io_kiocb *req, unsigned flags);
-bool io_is_uring_fops(struct file *file);
 bool io_alloc_async_data(struct io_kiocb *req);
 void io_req_task_queue(struct io_kiocb *req);
 void io_queue_iowq(struct io_kiocb *req, struct io_tw_state *ts_dont_use);
diff --git a/net/core/scm.c b/net/core/scm.c
index 7dc47c17d8638..737917c7ac627 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -105,7 +105,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		if (fd < 0 || !(file = fget_raw(fd)))
 			return -EBADF;
 		/* don't allow io_uring files */
-		if (io_uring_get_socket(file)) {
+		if (io_is_uring_fops(file)) {
 			fput(file);
 			return -EINVAL;
 		}
diff --git a/net/unix/scm.c b/net/unix/scm.c
index 6ff628f2349f5..822ce0d0d7915 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -35,10 +35,8 @@ struct sock *unix_get_socket(struct file *filp)
 		/* PF_UNIX ? */
 		if (s && ops && ops->family == PF_UNIX)
 			u_sock = s;
-	} else {
-		/* Could be an io_uring instance */
-		u_sock = io_uring_get_socket(filp);
 	}
+
 	return u_sock;
 }
 EXPORT_SYMBOL(unix_get_socket);
-- 
2.43.0


