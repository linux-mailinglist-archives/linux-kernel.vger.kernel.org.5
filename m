Return-Path: <linux-kernel+bounces-115612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDB488944C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE3B2885CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBC715A48D;
	Mon, 25 Mar 2024 02:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGkgDaQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A12130E20;
	Sun, 24 Mar 2024 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321377; cv=none; b=ZKJA/zAHOJsNOs9QfSIvXI8EuLkKGlVYouSEJf1cmltXA5ouE/GEI39D7+33ERI+FRQXgXxCdYmtgQ0AlOaBSaRjkjgXk8vi/v7vbBsEizKKxmWDyDZqFkiSlsFH0WDOi6HDqW2q8J3bRG85fb5Ax/GRGuijx+y2SjWGDgDKeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321377; c=relaxed/simple;
	bh=gUOyQMOyLGmeWKluDeufXTqUbLq9Ei/WR0Jgx0MLd2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBgbsAbtxlAXL0JC0qUg+KXDBPiQmKbuZSFdoggUFQxFRijGCOQG8CfmCdC8VoO5UhHbnlYAbkXmfeWP0v1Eo9PiTdUVO1A+i03h0hGkjM7kEL5H8aj1LphhpCU9tLix4XgjVeEvKoF8no0ZnfQUuCjHHc14aHjysDln1Q9y7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGkgDaQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FD4C433C7;
	Sun, 24 Mar 2024 23:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321376;
	bh=gUOyQMOyLGmeWKluDeufXTqUbLq9Ei/WR0Jgx0MLd2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGkgDaQmgdtCa3Bfwd7W/fs/hv8EnIblrr7BMV5vD5pops95rmGeMiGrFfWYxbuxs
	 wc/JsFOUV5/tkANW/cUZe/TFMHYP6LfHUkVVMtJkr+J/MBG1hqqeMMJVax3hjEfU93
	 p7VIu/FwhZL4UK7sU+q9w6PgUKP0yQogTnQtI3LzpCwq98NbR1NUtvyvzPKbc8Cr5+
	 ngYgvKuFJAzJBl1uj9cshzWj0cdYcgRx6HdFguWytUvsE7v/pFE6YUEA+t7A6w3rVt
	 B4oeyHrxdE8Nw1N4YjsYCV+9pQAacBcvCmJINCo86LbiOQtfdObEs2lUYcnO04VVBP
	 vBK4eN791Cifg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 100/638] io_uring/net: move receive multishot out of the generic msghdr path
Date: Sun, 24 Mar 2024 18:52:17 -0400
Message-ID: <20240324230116.1348576-101-sashal@kernel.org>
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

[ Upstream commit c55978024d123d43808ab393a0a4ce3ce8568150 ]

Move the actual user_msghdr / compat_msghdr into the send and receive
sides, respectively, so we can move the uaddr receive handling into its
own handler, and ditto the multishot with buffer selection logic.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 8ede3db5061b ("io_uring/net: fix overflow check in io_recvmsg_mshot_prep()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/net.c | 161 ++++++++++++++++++++++++++++---------------------
 1 file changed, 91 insertions(+), 70 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index ef495e2aac2bc..1d9bfde71809a 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -204,46 +204,26 @@ static int io_setup_async_msg(struct io_kiocb *req,
 	return -EAGAIN;
 }
 
-static bool io_recvmsg_multishot_overflow(struct io_async_msghdr *iomsg)
-{
-	int hdr;
-
-	if (iomsg->namelen < 0)
-		return true;
-	if (check_add_overflow((int)sizeof(struct io_uring_recvmsg_out),
-			       iomsg->namelen, &hdr))
-		return true;
-	if (check_add_overflow(hdr, (int)iomsg->controllen, &hdr))
-		return true;
-
-	return false;
-}
-
 #ifdef CONFIG_COMPAT
-static int __io_compat_msg_copy_hdr(struct io_kiocb *req,
-				    struct io_async_msghdr *iomsg,
-				    struct sockaddr __user **addr, int ddir)
+static int io_compat_msg_copy_hdr(struct io_kiocb *req,
+				  struct io_async_msghdr *iomsg,
+				  struct compat_msghdr *msg, int ddir)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
-	struct compat_msghdr msg;
 	struct compat_iovec __user *uiov;
 	int ret;
 
-	if (copy_from_user(&msg, sr->umsg_compat, sizeof(msg)))
+	if (copy_from_user(msg, sr->umsg_compat, sizeof(*msg)))
 		return -EFAULT;
 
-	ret = __get_compat_msghdr(&iomsg->msg, &msg, addr);
-	if (ret)
-		return ret;
-
-	uiov = compat_ptr(msg.msg_iov);
+	uiov = compat_ptr(msg->msg_iov);
 	if (req->flags & REQ_F_BUFFER_SELECT) {
 		compat_ssize_t clen;
 
 		iomsg->free_iov = NULL;
-		if (msg.msg_iovlen == 0) {
+		if (msg->msg_iovlen == 0) {
 			sr->len = 0;
-		} else if (msg.msg_iovlen > 1) {
+		} else if (msg->msg_iovlen > 1) {
 			return -EINVAL;
 		} else {
 			if (!access_ok(uiov, sizeof(*uiov)))
@@ -255,18 +235,11 @@ static int __io_compat_msg_copy_hdr(struct io_kiocb *req,
 			sr->len = clen;
 		}
 
-		if (ddir == ITER_DEST && req->flags & REQ_F_APOLL_MULTISHOT) {
-			iomsg->namelen = msg.msg_namelen;
-			iomsg->controllen = msg.msg_controllen;
-			if (io_recvmsg_multishot_overflow(iomsg))
-				return -EOVERFLOW;
-		}
-
 		return 0;
 	}
 
 	iomsg->free_iov = iomsg->fast_iov;
-	ret = __import_iovec(ddir, (struct iovec __user *)uiov, msg.msg_iovlen,
+	ret = __import_iovec(ddir, (struct iovec __user *)uiov, msg->msg_iovlen,
 				UIO_FASTIOV, &iomsg->free_iov,
 				&iomsg->msg.msg_iter, true);
 	if (unlikely(ret < 0))
@@ -276,47 +249,35 @@ static int __io_compat_msg_copy_hdr(struct io_kiocb *req,
 }
 #endif
 
-static int __io_msg_copy_hdr(struct io_kiocb *req, struct io_async_msghdr *iomsg,
-			     struct sockaddr __user **addr, int ddir)
+static int io_msg_copy_hdr(struct io_kiocb *req, struct io_async_msghdr *iomsg,
+			   struct user_msghdr *msg, int ddir)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
-	struct user_msghdr msg;
 	int ret;
 
-	if (copy_from_user(&msg, sr->umsg, sizeof(*sr->umsg)))
+	if (copy_from_user(msg, sr->umsg, sizeof(*sr->umsg)))
 		return -EFAULT;
 
-	ret = __copy_msghdr(&iomsg->msg, &msg, addr);
-	if (ret)
-		return ret;
-
 	if (req->flags & REQ_F_BUFFER_SELECT) {
-		if (msg.msg_iovlen == 0) {
+		if (msg->msg_iovlen == 0) {
 			sr->len = iomsg->fast_iov[0].iov_len = 0;
 			iomsg->fast_iov[0].iov_base = NULL;
 			iomsg->free_iov = NULL;
-		} else if (msg.msg_iovlen > 1) {
+		} else if (msg->msg_iovlen > 1) {
 			return -EINVAL;
 		} else {
-			if (copy_from_user(iomsg->fast_iov, msg.msg_iov,
-					   sizeof(*msg.msg_iov)))
+			if (copy_from_user(iomsg->fast_iov, msg->msg_iov,
+					   sizeof(*msg->msg_iov)))
 				return -EFAULT;
 			sr->len = iomsg->fast_iov[0].iov_len;
 			iomsg->free_iov = NULL;
 		}
 
-		if (ddir == ITER_DEST && req->flags & REQ_F_APOLL_MULTISHOT) {
-			iomsg->namelen = msg.msg_namelen;
-			iomsg->controllen = msg.msg_controllen;
-			if (io_recvmsg_multishot_overflow(iomsg))
-				return -EOVERFLOW;
-		}
-
 		return 0;
 	}
 
 	iomsg->free_iov = iomsg->fast_iov;
-	ret = __import_iovec(ddir, msg.msg_iov, msg.msg_iovlen, UIO_FASTIOV,
+	ret = __import_iovec(ddir, msg->msg_iov, msg->msg_iovlen, UIO_FASTIOV,
 				&iomsg->free_iov, &iomsg->msg.msg_iter, false);
 	if (unlikely(ret < 0))
 		return ret;
@@ -324,30 +285,34 @@ static int __io_msg_copy_hdr(struct io_kiocb *req, struct io_async_msghdr *iomsg
 	return 0;
 }
 
-static int io_msg_copy_hdr(struct io_kiocb *req, struct io_async_msghdr *iomsg,
-			   struct sockaddr __user **addr, int ddir)
+static int io_sendmsg_copy_hdr(struct io_kiocb *req,
+			       struct io_async_msghdr *iomsg)
 {
+	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
+	struct user_msghdr msg;
+	int ret;
+
 	iomsg->msg.msg_name = &iomsg->addr;
 	iomsg->msg.msg_iter.nr_segs = 0;
 
 #ifdef CONFIG_COMPAT
-	if (req->ctx->compat)
-		return __io_compat_msg_copy_hdr(req, iomsg, addr, ddir);
-#endif
+	if (unlikely(req->ctx->compat)) {
+		struct compat_msghdr cmsg;
 
-	return __io_msg_copy_hdr(req, iomsg, addr, ddir);
-}
+		ret = io_compat_msg_copy_hdr(req, iomsg, &cmsg, ITER_SOURCE);
+		if (unlikely(ret))
+			return ret;
 
-static int io_sendmsg_copy_hdr(struct io_kiocb *req,
-			       struct io_async_msghdr *iomsg)
-{
-	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
-	int ret;
+		return __get_compat_msghdr(&iomsg->msg, &cmsg, NULL);
+	}
+#endif
 
-	ret = io_msg_copy_hdr(req, iomsg, NULL, ITER_SOURCE);
-	if (ret)
+	ret = io_msg_copy_hdr(req, iomsg, &msg, ITER_SOURCE);
+	if (unlikely(ret))
 		return ret;
 
+	ret = __copy_msghdr(&iomsg->msg, &msg, NULL);
+
 	/* save msg_control as sys_sendmsg() overwrites it */
 	sr->msg_control = iomsg->msg.msg_control_user;
 	return ret;
@@ -569,10 +534,66 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 	return IOU_OK;
 }
 
+static int io_recvmsg_mshot_prep(struct io_kiocb *req,
+				 struct io_async_msghdr *iomsg,
+				 size_t namelen, size_t controllen)
+{
+	if ((req->flags & (REQ_F_APOLL_MULTISHOT|REQ_F_BUFFER_SELECT)) ==
+			  (REQ_F_APOLL_MULTISHOT|REQ_F_BUFFER_SELECT)) {
+		int hdr;
+
+		if (unlikely(namelen < 0))
+			return -EOVERFLOW;
+		if (check_add_overflow((int)sizeof(struct io_uring_recvmsg_out),
+					namelen, &hdr))
+			return -EOVERFLOW;
+		if (check_add_overflow(hdr, (int)controllen, &hdr))
+			return -EOVERFLOW;
+
+		iomsg->namelen = namelen;
+		iomsg->controllen = controllen;
+		return 0;
+	}
+
+	return 0;
+}
+
 static int io_recvmsg_copy_hdr(struct io_kiocb *req,
 			       struct io_async_msghdr *iomsg)
 {
-	return io_msg_copy_hdr(req, iomsg, &iomsg->uaddr, ITER_DEST);
+	struct user_msghdr msg;
+	int ret;
+
+	iomsg->msg.msg_name = &iomsg->addr;
+	iomsg->msg.msg_iter.nr_segs = 0;
+
+#ifdef CONFIG_COMPAT
+	if (unlikely(req->ctx->compat)) {
+		struct compat_msghdr cmsg;
+
+		ret = io_compat_msg_copy_hdr(req, iomsg, &cmsg, ITER_DEST);
+		if (unlikely(ret))
+			return ret;
+
+		ret = __get_compat_msghdr(&iomsg->msg, &cmsg, &iomsg->uaddr);
+		if (unlikely(ret))
+			return ret;
+
+		return io_recvmsg_mshot_prep(req, iomsg, cmsg.msg_namelen,
+						cmsg.msg_controllen);
+	}
+#endif
+
+	ret = io_msg_copy_hdr(req, iomsg, &msg, ITER_DEST);
+	if (unlikely(ret))
+		return ret;
+
+	ret = __copy_msghdr(&iomsg->msg, &msg, &iomsg->uaddr);
+	if (unlikely(ret))
+		return ret;
+
+	return io_recvmsg_mshot_prep(req, iomsg, msg.msg_namelen,
+					msg.msg_controllen);
 }
 
 int io_recvmsg_prep_async(struct io_kiocb *req)
-- 
2.43.0


