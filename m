Return-Path: <linux-kernel+bounces-116002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E3E88955F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B804E297EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A747156C49;
	Mon, 25 Mar 2024 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkGynwkz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF42716DB;
	Sun, 24 Mar 2024 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323301; cv=none; b=pk1wibud46OMD2PWgmmBx/C7QFQ2ddgmAJdpQbZqSlh7ah63HmGDJ+/eliNKlyRyTzvn9npqwTLc/VuSXzG+/mYxC4dMfBNEoYDplMbLp+HyQ1w751AhxJzpNp2H9/at3E5C6AgegKgE2C3J5nP2ighCjHGtackS4TeegTfwepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323301; c=relaxed/simple;
	bh=ELzVn+rRe6bS2yKeO1yNV5To5LEEcDbleSatoALaGSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFrzAAwUZkFiGMQyL1OxokPjwowrsVp2irJryeEMKUSiPChEbfrkrder+jacxMMhS1IyC1zHgims65Vmp9Uf9PnmyFD7OmZHqPdJADAlFaN4VD0rLJ+J8vcbkJn4Lv680S/JI3iQbWg/pqB3S391j65IBX/7r7XFKpbtokQiIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkGynwkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFD8C43390;
	Sun, 24 Mar 2024 23:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323301;
	bh=ELzVn+rRe6bS2yKeO1yNV5To5LEEcDbleSatoALaGSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TkGynwkzZ3DL3PjeKqXAsTDEMIwgXNRPc5rba1NVxbXbu15hEjeETmzTXw8mZfp08
	 HhMV2w0L1j9g0ALepIXR2/IQn2KFIRvHbG58PV8+BuECOJVKwH0OeNunVf49rzf14G
	 v8Hr/EMXmYOGP1Pmvr9YyjNvBJpNhYSaHhmnLK4CtJY6fkniV9sYzrAw2e92c34EIR
	 PcGVPU9zq3DQfosUA6OSo+8HwdnkV7jDCfDmZ+U8oAkYaylB4FgU4UUe7lLsrJzQfH
	 5NP0yWy4CXreYAF+wmXQRiotPb0U8rb5Su31QbVDezHgz09SpCr27SgXhl0G2RsfoA
	 ALtS5g7rotzxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 001/317] io_uring/unix: drop usage of io_uring socket
Date: Sun, 24 Mar 2024 19:29:41 -0400
Message-ID: <20240324233458.1352854-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
 io_uring/io_uring.c      | 18 +++++-------------
 net/core/scm.c           |  2 +-
 net/unix/scm.c           |  4 +---
 4 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 649a4d7c241bc..55d09f594cd14 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -6,9 +6,9 @@
 #include <linux/xarray.h>
 
 #if defined(CONFIG_IO_URING)
-struct sock *io_uring_get_socket(struct file *file);
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
+bool io_is_uring_fops(struct file *file);
 
 static inline void io_uring_files_cancel(void)
 {
@@ -26,10 +26,6 @@ static inline void io_uring_free(struct task_struct *tsk)
 		__io_uring_free(tsk);
 }
 #else
-static inline struct sock *io_uring_get_socket(struct file *file)
-{
-	return NULL;
-}
 static inline void io_uring_task_cancel(void)
 {
 }
@@ -39,6 +35,10 @@ static inline void io_uring_files_cancel(void)
 static inline void io_uring_free(struct task_struct *tsk)
 {
 }
+static inline bool io_is_uring_fops(struct file *file)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 55fd6d98fe121..541e6a6985ecc 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1116,19 +1116,6 @@ static struct kmem_cache *req_cachep;
 
 static const struct file_operations io_uring_fops;
 
-struct sock *io_uring_get_socket(struct file *file)
-{
-#if defined(CONFIG_UNIX)
-	if (file->f_op == &io_uring_fops) {
-		struct io_ring_ctx *ctx = file->private_data;
-
-		return ctx->ring_sock->sk;
-	}
-#endif
-	return NULL;
-}
-EXPORT_SYMBOL(io_uring_get_socket);
-
 static inline void io_tw_lock(struct io_ring_ctx *ctx, bool *locked)
 {
 	if (!*locked) {
@@ -10445,6 +10432,11 @@ static const struct file_operations io_uring_fops = {
 #endif
 };
 
+bool io_is_uring_fops(struct file *file)
+{
+	return file->f_op == &io_uring_fops;
+}
+
 static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 				  struct io_uring_params *p)
 {
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


