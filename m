Return-Path: <linux-kernel+bounces-115750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F9188949A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37D81C2F394
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB6368E1A;
	Mon, 25 Mar 2024 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+FTRbno"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857C142906;
	Sun, 24 Mar 2024 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321933; cv=none; b=Q5B43ta+nnlTNmE9RnNMRVfC8wPSiyOPwgdXuGw3oWI/igE2nMGkwVC8nHfzW4xvV9CDTQ61giBZxOkE7FloBPlRDH5ja6xKz0wgJST5DmcOEu9CGR0cjlMyTA+nDYvpOyGvKPmk+/lEvToEkg9Ihy5mtZ07yZ+a/vPROXoDeII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321933; c=relaxed/simple;
	bh=LEKNRecMmvxXUllhD4M+yND2wFd/fo2ndQcInkj7mNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUsb6xohV3jvatPAJYmdACVLem1s6J7R8ZpfC/7jKfz1EgnXsvOpm56U1XysYY1yU+SrZTIGwTE0SUB5CpsMwdf5oYp7g9nN+5NAw70F2oFdTihshVvTa+W8kDOE47c5T4+X+OlgFYDodQUj8YdVbR18OOTmw0HbDFaPfZSmeqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+FTRbno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF05C43394;
	Sun, 24 Mar 2024 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321932;
	bh=LEKNRecMmvxXUllhD4M+yND2wFd/fo2ndQcInkj7mNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+FTRbnoywarMWsCiowx0OdOSAMFOkQqSL+cZqsQ07T+mXXbrZTbEcg/Z7++7R+To
	 EBXITtvxaYbL+M7MU6miDUsuAHxMuGVIvwtplokF946FvHHQPdkEOHPpEnyQKhaE1S
	 Ew4Iu3QC6VxuiO1JBfySj3lSXmaLD0wjgxWDBpOK11mrXoOeJf+rhVYfkAs9XrRXIg
	 rp7Q9A5CObZJwuXR2V2uP+otkqSbFvfhBke2dzVMmymiMf1ECehF0oMe3rKdWEaPM8
	 rp3JXvPa9kXQvzrx6oUWDq7Xu/NfiaLbQVUJ16fgq0T5Ptvq0uwtjSLUI1y4Er0OgJ
	 Hk3pbBdJJCvRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 003/451] io_uring/unix: drop usage of io_uring socket
Date: Sun, 24 Mar 2024 19:04:39 -0400
Message-ID: <20240324231207.1351418-4-sashal@kernel.org>
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
 include/linux/io_uring.h | 10 +++++-----
 io_uring/io_uring.c      | 13 -------------
 io_uring/io_uring.h      |  1 -
 net/core/scm.c           |  2 +-
 net/unix/scm.c           |  4 +---
 5 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index a1484cdb3158e..a8f3058448eaa 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -42,11 +42,11 @@ void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2,
 			unsigned issue_flags);
 void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			void (*task_work_cb)(struct io_uring_cmd *, unsigned));
-struct sock *io_uring_get_socket(struct file *file);
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
 void io_uring_unreg_ringfd(void);
 const char *io_uring_get_opcode(u8 opcode);
+bool io_is_uring_fops(struct file *file);
 
 static inline void io_uring_files_cancel(void)
 {
@@ -71,6 +71,10 @@ static inline int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 {
 	return -EOPNOTSUPP;
 }
+static inline bool io_is_uring_fops(struct file *file)
+{
+	return false;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		ssize_t ret2, unsigned issue_flags)
 {
@@ -79,10 +83,6 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
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
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 35894955b4549..cf7dd62da0e37 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -153,19 +153,6 @@ static void __io_submit_flush_completions(struct io_ring_ctx *ctx);
 
 static struct kmem_cache *req_cachep;
 
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
 	if (!wq_list_empty(&ctx->submit_state.compl_reqs))
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 019600570ee49..59e6f755f12c6 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -52,7 +52,6 @@ static inline bool io_req_ffs_set(struct io_kiocb *req)
 }
 
 void __io_req_task_work_add(struct io_kiocb *req, bool allow_local);
-bool io_is_uring_fops(struct file *file);
 bool io_alloc_async_data(struct io_kiocb *req);
 void io_req_task_queue(struct io_kiocb *req);
 void io_queue_iowq(struct io_kiocb *req, bool *dont_use);
diff --git a/net/core/scm.c b/net/core/scm.c
index e762a4b8a1d22..a877c4ef4c256 100644
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
index e8e2a00bb0f58..d1048b4c2baaf 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -34,10 +34,8 @@ struct sock *unix_get_socket(struct file *filp)
 		/* PF_UNIX ? */
 		if (s && sock->ops && sock->ops->family == PF_UNIX)
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


