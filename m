Return-Path: <linux-kernel+bounces-115818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A2889683
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB821F31E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5438621018D;
	Mon, 25 Mar 2024 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwEdszmk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F8145B0A;
	Sun, 24 Mar 2024 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322001; cv=none; b=fIblsAdmHJ7J9Rh4+h1IZEy4NhWd/LSYDkO/2lxWCZ9G/bB6oxyVZVucbzdBUsgEPMiOQQkJZ6Ngr7DV6xLgs8Lk9YQqZ1t/XLhK49zZ1FKX5wAhoTaNYQxFwhvFl++sKlgybpaL3hQIE+OPyshEFbDusEigcQWAjtCJSSHOgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322001; c=relaxed/simple;
	bh=gBWxdnzSSUbsyoZpE0aicv8FxBl1Un4MTYmbqRsNO7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qn7+kuR3rbp34+pCvm+5kyLqSrxsEyuM5uh9nce/M2WHz+OkybU4l0HtB0bZrn/kD/+hFtL+Z0pzmWi64H4J0joJMc9qyzoAD3rI7BxtzwTyJJSL7g0U1tIX6ga+oZ21ouoRQg6IsQ+gsc31rls89IVHByPxF/USBY1KvTVhENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwEdszmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A46EC433F1;
	Sun, 24 Mar 2024 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322000;
	bh=gBWxdnzSSUbsyoZpE0aicv8FxBl1Un4MTYmbqRsNO7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwEdszmkWxWyEwomrIblszuKNkBouPIk1bu+Jy58uWtUAcVreW/J8x4w8ThjoKdBD
	 OFnLowZHMKSYKNTJglyFqftMM+scLcjYw55OchpJxSRiQwX5ba8izdKRkUQOJ5PgYl
	 YN3XP+ttrbmxjFUhMiAkbSEX39YU+feTW4+gC4wmSlth6WSwT8XQ0KhWlTXfyNRq5t
	 Fmlv/yDDoIPu493p8QxiR5Y05pJsqXgJoTov8OnXJK9fT+bmGs0pSBXEMt1rGeJECf
	 JF/5E3cxf/JPn8wRLuIpW+PKE54Sg/iubNnGM1PdDNQy9lFqj1rQP7Fn7uprPbPHvW
	 Q4OmZ298zaUKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 072/451] io_uring/net: unify how recvmsg and sendmsg copy in the msghdr
Date: Sun, 24 Mar 2024 19:05:48 -0400
Message-ID: <20240324231207.1351418-73-sashal@kernel.org>
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

[ Upstream commit 52307ac4f2b507f60bae6df5be938d35e199c688 ]

For recvmsg, we roll our own since we support buffer selections. This
isn't the case for sendmsg right now, but in preparation for doing so,
make the recvmsg copy helpers generic so we can call them from the
sendmsg side as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 8ede3db5061b ("io_uring/net: fix overflow check in io_recvmsg_mshot_prep()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/net.c | 271 ++++++++++++++++++++++++++-----------------------
 1 file changed, 142 insertions(+), 129 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index c062ce66af12c..c770961079749 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -183,16 +183,150 @@ static int io_setup_async_msg(struct io_kiocb *req,
 	return -EAGAIN;
 }
 
+static bool io_recvmsg_multishot_overflow(struct io_async_msghdr *iomsg)
+{
+	int hdr;
+
+	if (iomsg->namelen < 0)
+		return true;
+	if (check_add_overflow((int)sizeof(struct io_uring_recvmsg_out),
+			       iomsg->namelen, &hdr))
+		return true;
+	if (check_add_overflow(hdr, (int)iomsg->controllen, &hdr))
+		return true;
+
+	return false;
+}
+
+#ifdef CONFIG_COMPAT
+static int __io_compat_msg_copy_hdr(struct io_kiocb *req,
+				    struct io_async_msghdr *iomsg,
+				    struct sockaddr __user **addr, int ddir)
+{
+	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
+	struct compat_msghdr msg;
+	struct compat_iovec __user *uiov;
+	int ret;
+
+	if (copy_from_user(&msg, sr->umsg_compat, sizeof(msg)))
+		return -EFAULT;
+
+	ret = __get_compat_msghdr(&iomsg->msg, &msg, addr);
+	if (ret)
+		return ret;
+
+	uiov = compat_ptr(msg.msg_iov);
+	if (req->flags & REQ_F_BUFFER_SELECT) {
+		compat_ssize_t clen;
+
+		iomsg->free_iov = NULL;
+		if (msg.msg_iovlen == 0) {
+			sr->len = 0;
+		} else if (msg.msg_iovlen > 1) {
+			return -EINVAL;
+		} else {
+			if (!access_ok(uiov, sizeof(*uiov)))
+				return -EFAULT;
+			if (__get_user(clen, &uiov->iov_len))
+				return -EFAULT;
+			if (clen < 0)
+				return -EINVAL;
+			sr->len = clen;
+		}
+
+		if (ddir == ITER_DEST && req->flags & REQ_F_APOLL_MULTISHOT) {
+			iomsg->namelen = msg.msg_namelen;
+			iomsg->controllen = msg.msg_controllen;
+			if (io_recvmsg_multishot_overflow(iomsg))
+				return -EOVERFLOW;
+		}
+
+		return 0;
+	}
+
+	iomsg->free_iov = iomsg->fast_iov;
+	ret = __import_iovec(ddir, (struct iovec __user *)uiov, msg.msg_iovlen,
+				UIO_FASTIOV, &iomsg->free_iov,
+				&iomsg->msg.msg_iter, true);
+	if (unlikely(ret < 0))
+		return ret;
+
+	return 0;
+}
+#endif
+
+static int __io_msg_copy_hdr(struct io_kiocb *req, struct io_async_msghdr *iomsg,
+			     struct sockaddr __user **addr, int ddir)
+{
+	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
+	struct user_msghdr msg;
+	int ret;
+
+	if (copy_from_user(&msg, sr->umsg, sizeof(*sr->umsg)))
+		return -EFAULT;
+
+	ret = __copy_msghdr(&iomsg->msg, &msg, addr);
+	if (ret)
+		return ret;
+
+	if (req->flags & REQ_F_BUFFER_SELECT) {
+		if (msg.msg_iovlen == 0) {
+			sr->len = iomsg->fast_iov[0].iov_len = 0;
+			iomsg->fast_iov[0].iov_base = NULL;
+			iomsg->free_iov = NULL;
+		} else if (msg.msg_iovlen > 1) {
+			return -EINVAL;
+		} else {
+			if (copy_from_user(iomsg->fast_iov, msg.msg_iov,
+					   sizeof(*msg.msg_iov)))
+				return -EFAULT;
+			sr->len = iomsg->fast_iov[0].iov_len;
+			iomsg->free_iov = NULL;
+		}
+
+		if (ddir == ITER_DEST && req->flags & REQ_F_APOLL_MULTISHOT) {
+			iomsg->namelen = msg.msg_namelen;
+			iomsg->controllen = msg.msg_controllen;
+			if (io_recvmsg_multishot_overflow(iomsg))
+				return -EOVERFLOW;
+		}
+
+		return 0;
+	}
+
+	iomsg->free_iov = iomsg->fast_iov;
+	ret = __import_iovec(ddir, msg.msg_iov, msg.msg_iovlen, UIO_FASTIOV,
+				&iomsg->free_iov, &iomsg->msg.msg_iter, false);
+	if (unlikely(ret < 0))
+		return ret;
+
+	return 0;
+}
+
+static int io_msg_copy_hdr(struct io_kiocb *req, struct io_async_msghdr *iomsg,
+			   struct sockaddr __user **addr, int ddir)
+{
+	iomsg->msg.msg_name = &iomsg->addr;
+	iomsg->msg.msg_iter.nr_segs = 0;
+
+#ifdef CONFIG_COMPAT
+	if (req->ctx->compat)
+		return __io_compat_msg_copy_hdr(req, iomsg, addr, ddir);
+#endif
+
+	return __io_msg_copy_hdr(req, iomsg, addr, ddir);
+}
+
 static int io_sendmsg_copy_hdr(struct io_kiocb *req,
 			       struct io_async_msghdr *iomsg)
 {
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 	int ret;
 
-	iomsg->msg.msg_name = &iomsg->addr;
-	iomsg->free_iov = iomsg->fast_iov;
-	ret = sendmsg_copy_msghdr(&iomsg->msg, sr->umsg, sr->msg_flags,
-					&iomsg->free_iov);
+	ret = io_msg_copy_hdr(req, iomsg, NULL, ITER_SOURCE);
+	if (ret)
+		return ret;
+
 	/* save msg_control as sys_sendmsg() overwrites it */
 	sr->msg_control = iomsg->msg.msg_control_user;
 	return ret;
@@ -415,142 +549,21 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 	return IOU_OK;
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
-static int __io_recvmsg_copy_hdr(struct io_kiocb *req,
-				 struct io_async_msghdr *iomsg)
-{
-	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
-	struct user_msghdr msg;
-	int ret;
-
-	if (copy_from_user(&msg, sr->umsg, sizeof(*sr->umsg)))
-		return -EFAULT;
-
-	ret = __copy_msghdr(&iomsg->msg, &msg, &iomsg->uaddr);
-	if (ret)
-		return ret;
-
-	if (req->flags & REQ_F_BUFFER_SELECT) {
-		if (msg.msg_iovlen == 0) {
-			sr->len = iomsg->fast_iov[0].iov_len = 0;
-			iomsg->fast_iov[0].iov_base = NULL;
-			iomsg->free_iov = NULL;
-		} else if (msg.msg_iovlen > 1) {
-			return -EINVAL;
-		} else {
-			if (copy_from_user(iomsg->fast_iov, msg.msg_iov, sizeof(*msg.msg_iov)))
-				return -EFAULT;
-			sr->len = iomsg->fast_iov[0].iov_len;
-			iomsg->free_iov = NULL;
-		}
-
-		if (req->flags & REQ_F_APOLL_MULTISHOT) {
-			iomsg->namelen = msg.msg_namelen;
-			iomsg->controllen = msg.msg_controllen;
-			if (io_recvmsg_multishot_overflow(iomsg))
-				return -EOVERFLOW;
-		}
-	} else {
-		iomsg->free_iov = iomsg->fast_iov;
-		ret = __import_iovec(ITER_DEST, msg.msg_iov, msg.msg_iovlen, UIO_FASTIOV,
-				     &iomsg->free_iov, &iomsg->msg.msg_iter,
-				     false);
-		if (ret > 0)
-			ret = 0;
-	}
-
-	return ret;
-}
-
-#ifdef CONFIG_COMPAT
-static int __io_compat_recvmsg_copy_hdr(struct io_kiocb *req,
-					struct io_async_msghdr *iomsg)
-{
-	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
-	struct compat_msghdr msg;
-	struct compat_iovec __user *uiov;
-	int ret;
-
-	if (copy_from_user(&msg, sr->umsg_compat, sizeof(msg)))
-		return -EFAULT;
-
-	ret = __get_compat_msghdr(&iomsg->msg, &msg, &iomsg->uaddr);
-	if (ret)
-		return ret;
-
-	uiov = compat_ptr(msg.msg_iov);
-	if (req->flags & REQ_F_BUFFER_SELECT) {
-		compat_ssize_t clen;
-
-		iomsg->free_iov = NULL;
-		if (msg.msg_iovlen == 0) {
-			sr->len = 0;
-		} else if (msg.msg_iovlen > 1) {
-			return -EINVAL;
-		} else {
-			if (!access_ok(uiov, sizeof(*uiov)))
-				return -EFAULT;
-			if (__get_user(clen, &uiov->iov_len))
-				return -EFAULT;
-			if (clen < 0)
-				return -EINVAL;
-			sr->len = clen;
-		}
-
-		if (req->flags & REQ_F_APOLL_MULTISHOT) {
-			iomsg->namelen = msg.msg_namelen;
-			iomsg->controllen = msg.msg_controllen;
-			if (io_recvmsg_multishot_overflow(iomsg))
-				return -EOVERFLOW;
-		}
-	} else {
-		iomsg->free_iov = iomsg->fast_iov;
-		ret = __import_iovec(ITER_DEST, (struct iovec __user *)uiov, msg.msg_iovlen,
-				   UIO_FASTIOV, &iomsg->free_iov,
-				   &iomsg->msg.msg_iter, true);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-#endif
-
 static int io_recvmsg_copy_hdr(struct io_kiocb *req,
 			       struct io_async_msghdr *iomsg)
 {
-	iomsg->msg.msg_name = &iomsg->addr;
-	iomsg->msg.msg_iter.nr_segs = 0;
-
-#ifdef CONFIG_COMPAT
-	if (req->ctx->compat)
-		return __io_compat_recvmsg_copy_hdr(req, iomsg);
-#endif
-
-	return __io_recvmsg_copy_hdr(req, iomsg);
+	return io_msg_copy_hdr(req, iomsg, &iomsg->uaddr, ITER_DEST);
 }
 
 int io_recvmsg_prep_async(struct io_kiocb *req)
 {
+	struct io_async_msghdr *iomsg;
 	int ret;
 
 	if (!io_msg_alloc_async_prep(req))
 		return -ENOMEM;
-	ret = io_recvmsg_copy_hdr(req, req->async_data);
+	iomsg = req->async_data;
+	ret = io_recvmsg_copy_hdr(req, iomsg);
 	if (!ret)
 		req->flags |= REQ_F_NEED_CLEANUP;
 	return ret;
-- 
2.43.0


