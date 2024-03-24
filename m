Return-Path: <linux-kernel+bounces-115587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC1889473
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24F7B23E78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B0116A1DE;
	Mon, 25 Mar 2024 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyEx+EJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2CA1F9C38;
	Sun, 24 Mar 2024 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321282; cv=none; b=sfyDWziZAHPfTaH1/cogxPMscvDx5ShCU3MCtrx+5pIfeumetLk3xwHqr7PcTPQYTudF5kbHGJNx0oOiBDJUccXbZa6S6lVRJKNIcpqjITPEAYUVVimmh0nuNHHHy2T/VH75UREfhJsWBZpR1et0ZR9eTnM8YSOB6Th2pOrbHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321282; c=relaxed/simple;
	bh=1xrkI0FaU02Etf8mrDA9l6QkmHc9mRQrQ7IPVksNPys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjROBUYVNBqvfaAw1JzWLHQRLmVNn8PXJK8jwiN/Zmf6GGnP4Q09lQOXhKeKRF/rVHrXl9gKLz7YecNjprqJ7dIJC+oyDmq+EZL/OLesK127SNnirT1DeYdS7BYzq3KVCsTueiMZkj7bBC+j78hrTBjm8UnPOw/LZdzc7nUc/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyEx+EJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7BDC433A6;
	Sun, 24 Mar 2024 23:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321280;
	bh=1xrkI0FaU02Etf8mrDA9l6QkmHc9mRQrQ7IPVksNPys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyEx+EJyaXf0qTAqUYOupUOukrMqYCICFMoEo4X8zdbD+GXg6aRo5GZ9QwUMlPwyc
	 vLYBZdy4PoWQh8BgsgKi7V7GoV7+Bs0d/GHObj7DS7uMbF2Jbxf3E6I2oLF/+R+MGP
	 3KPLJUQzKOHJsui34DTq1UUjJv1ds9hgow2Kt5ptSeb6Ji0UKPRIL/RDI8tU5AsMbc
	 nQxmKpzH3ohpVBOOld1ymFlr26DxbIaQCTN2ZkM+tIWfFYJsihwtlgbvCl369Qcc/Z
	 G7Pb6GC/63wcSeUuAiPHAXJP7nXJFu1M8k3ZbAWoh7gdhKkOS8abXEDIha5JR2NdiV
	 PO0S7HpHP5P7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 002/638] io_uring/unix: drop usage of io_uring socket
Date: Sun, 24 Mar 2024 18:50:39 -0400
Message-ID: <20240324230116.1348576-3-sashal@kernel.org>
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
index 106cdc55ff3bd..f99ff6de926cb 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -46,7 +46,6 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter, void *ioucmd);
 void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2,
 			unsigned issue_flags);
-struct sock *io_uring_get_socket(struct file *file);
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
 void io_uring_unreg_ringfd(void);
@@ -82,6 +81,7 @@ static inline void io_uring_free(struct task_struct *tsk)
 		__io_uring_free(tsk);
 }
 int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags);
+bool io_is_uring_fops(struct file *file);
 #else
 static inline int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter, void *ioucmd)
@@ -100,10 +100,6 @@ static inline void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
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
@@ -122,6 +118,10 @@ static inline int io_uring_cmd_sock(struct io_uring_cmd *cmd,
 {
 	return -EOPNOTSUPP;
 }
+static inline bool io_is_uring_fops(struct file *file)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ea772a02c1405..747d2a6ecab89 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -175,19 +175,6 @@ static struct ctl_table kernel_io_uring_disabled_table[] = {
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
index c8cba78310831..411c883b37a95 100644
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


