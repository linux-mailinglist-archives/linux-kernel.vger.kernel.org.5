Return-Path: <linux-kernel+bounces-116238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3928895C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A9E1F2FDAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E263C2559;
	Mon, 25 Mar 2024 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5a77IsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8E13C831;
	Sun, 24 Mar 2024 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324002; cv=none; b=Z3dNTVbyM5ztLJA7KZi6IEALfsIbeMC+0M7Jt+5M028GjDwjc3TLDv+SXUSxNGw3BobBFi/w3IEr4kdkwOm2asGWA5YUH9iLDz3DspM+VOns+SeZE6gj1GxpsqFbSitvUuZ7mXhEPxhJDyYA/UGNHagTUoVXLOKeNwgZWhVzUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324002; c=relaxed/simple;
	bh=uYZDJMSq8ohf+7c0baTlmnKmzGCcgbGtrBM9HcZxHJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHoLvNtUkvesziD5fHgVuB847zPv/KwsS6DtD/Ykr5mi2kLutP1Q0gREuTI0W1HU+Dr11uG3MY1XfU90Lly/7LQoBcqE+nYGuTNcig+hhPB2KY5dyHJPrw1rh8zoYMTwaFqYpGOuze/OWjF/4nkSYD1f7mJh6Q3kB3ILoNPmoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5a77IsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9911AC433C7;
	Sun, 24 Mar 2024 23:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324001;
	bh=uYZDJMSq8ohf+7c0baTlmnKmzGCcgbGtrBM9HcZxHJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5a77IsSuQAiAF6qJmFI+Vf9NEe1Jumr2qy8zgalOeDHK0Rm3+oeex+GuaCSdAUg9
	 1m368Go4Rrf9OU8WqnqeEdrXoDHw3n6udP7DLUzQsUaz4Omcyqw6uHiuivClbiVY1/
	 2g4FB2ObGOAt0q/WurTU5Ejqn3hBjk0O+F73uzzG8Jg2k4SHFwWzUYn+KDdMzjy503
	 3l7clOBbY0GHEv5l4MtvhrLLS67iHYiH1Q0IfjvDb49sCndUJweCyd/WtpRDh0awsg
	 r1d20NBTrBVVBKqp7nWVWDXOcPsnQmTfAo6vmSz+BSpnWDdkVi4hvbXeAtorlmGQdr
	 9kbT8cjRDVTBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 001/183] io_uring/unix: drop usage of io_uring socket
Date: Sun, 24 Mar 2024 19:43:34 -0400
Message-ID: <20240324234638.1355609-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
 fs/io_uring.c      | 18 +++++-------------
 include/linux/fs.h |  6 +++---
 net/core/scm.c     |  2 +-
 net/unix/scm.c     |  4 +---
 4 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9de8961763b06..cd1858cc63206 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -381,19 +381,6 @@ static struct kmem_cache *req_cachep;
 
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
 static void io_ring_ctx_ref_free(struct percpu_ref *ref)
 {
 	struct io_ring_ctx *ctx = container_of(ref, struct io_ring_ctx, refs);
@@ -3794,6 +3781,11 @@ static const struct file_operations io_uring_fops = {
 	.fasync		= io_uring_fasync,
 };
 
+bool io_is_uring_fops(struct file *file)
+{
+	return file->f_op == &io_uring_fops;
+}
+
 static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 				  struct io_uring_params *p)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e009b52ab6b0d..272f261894b17 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3614,11 +3614,11 @@ extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
 
 #if defined(CONFIG_IO_URING)
-extern struct sock *io_uring_get_socket(struct file *file);
+bool io_is_uring_fops(struct file *file);
 #else
-static inline struct sock *io_uring_get_socket(struct file *file)
+static inline bool io_is_uring_fops(struct file *file)
 {
-	return NULL;
+	return false;
 }
 #endif
 
diff --git a/net/core/scm.c b/net/core/scm.c
index 5525c14f33f1e..a442bf63cd480 100644
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
index e881a6e78af53..51b623de3be5f 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -33,10 +33,8 @@ struct sock *unix_get_socket(struct file *filp)
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


