Return-Path: <linux-kernel+bounces-112926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D409887FCF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D3F281362
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861871B5D;
	Sun, 24 Mar 2024 22:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWkw6TKe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7E71B27;
	Sun, 24 Mar 2024 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319738; cv=none; b=gwxaGx+gFa6KsO0RgKNUpGnaR4f1FcdL3YKwRlQYLr3jHu7rfwozInG3nCO9FMUXMOkbOQVD5Rww1C4U4Gu3OvT4UjdU/9cXAJnFGveKCgVp1lpYsyrrG3C6sqFMQ8qDvEF7oiNideGeROJnlIn1CwtRXJoXsrRT3mUCNrgrsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319738; c=relaxed/simple;
	bh=o0P18BDc75hN2CyaedHN48mE5buT5ZzzGqs59ZBu8ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iS61FswleVqPzo/QWj9Q14NdyGHHTFhVjHF7JF/FgAD6H/EamJez0BA4XBpTo1OsGdHXxJspZUBhERgPZUTjoev1EDaGT6AejKa0u5XCDxdih6Qb+GezJ3kvRvvcMY2sgj4QXrbtTekQkBrtz9NACMXPRBVAcbIERZ0rjULDTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWkw6TKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E25C433F1;
	Sun, 24 Mar 2024 22:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319738;
	bh=o0P18BDc75hN2CyaedHN48mE5buT5ZzzGqs59ZBu8ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWkw6TKeJewCqhJxGijsgPaH8PvSDrp7PDCjOUX1bloCh8uMymh0lrc9RND5Cjfld
	 j6Fvkvdf6lM31PzfXaav4dxqoO7nDlsrF4xmFAROKG28pNB2xyQS/SmVv3dIGTHzS6
	 acLCiOwQAv+yKUm4O7y2WHE7BNslrqNYD8rz3IZHkyNzJfqOpHJHpx5drqP02weDi7
	 Nvw1x+zPLC2OXzC8pkYx1z/zJ+cmsb9Xt2w0Z0wVJq/hBy1FnK9hHdTujg6fAJltuK
	 H/aVboklemGE0sJV60uETiiSGsZvK9EmC2Lwt8rqE/e+yyeA+zLr7tG78bv8rpNMbY
	 Opg7ErDQwuD4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 039/715] io_uring/net: unify how recvmsg and sendmsg copy in the msghdr
Date: Sun, 24 Mar 2024 18:23:38 -0400
Message-ID: <20240324223455.1342824-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 161622029147c..ef495e2aac2bc 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -204,16 +204,150 @@ static int io_setup_async_msg(struct io_kiocb *req,
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
@@ -435,142 +569,21 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
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


