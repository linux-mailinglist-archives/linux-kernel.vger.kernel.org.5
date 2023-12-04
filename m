Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14038803FB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346082AbjLDUfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346159AbjLDUeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:34:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092F010E7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:34:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9F7C433C9;
        Mon,  4 Dec 2023 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722049;
        bh=AZ4e0D5QbPxg4VQmGNpyeeGH8zOTpO8U4j6t8+mlc7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l99a2idxo/SxNB/eHg5Oc+EDrUuRYazP1E8z+8PLXGXeJhh30Xnp8tWgSdDP2vXZR
         vpiNZRsS40tQFqvbIaFV0bRnt2Mq+50idc7TtI+WpSuUJKQA2jHB4T0OAhnqTO5xde
         VBZmnh85D5i8uKW9WRAhIhPPb8xOx76/V6a9hwAd6OFANRPgWkmmnEKlqa5uwP2smK
         jF6ieXXtolxpYDQL/zsRAwC+7u+SQ5lgmRZ8rY7fs/LRQ4VQt722vulRzzeyqkMeOs
         4fZWudypKVf9MZ6o1fhDuAP/q3LV2jiVVle/fP7IjT8XnjnP8J5TkJrCFaP3l1IyoG
         jfKv+qevrjtqA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
        Sasha Levin <sashal@kernel.org>, io-uring@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 21/32] io_uring: use fget/fput consistently
Date:   Mon,  4 Dec 2023 15:32:41 -0500
Message-ID: <20231204203317.2092321-21-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 73363c262d6a7d26063da96610f61baf69a70f7c ]

Normally within a syscall it's fine to use fdget/fdput for grabbing a
file from the file table, and it's fine within io_uring as well. We do
that via io_uring_enter(2), io_uring_register(2), and then also for
cancel which is invoked from the latter. io_uring cannot close its own
file descriptors as that is explicitly rejected, and for the cancel
side of things, the file itself is just used as a lookup cookie.

However, it is more prudent to ensure that full references are always
grabbed. For anything threaded, either explicitly in the application
itself or through use of the io-wq worker threads, this is what happens
anyway. Generalize it and use fget/fput throughout.

Also see the below link for more details.

Link: https://lore.kernel.org/io-uring/CAG48ez1htVSO3TqmrF8QcX2WFuYTRM-VZ_N10i-VZgbtg=NNqw@mail.gmail.com/
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/cancel.c   | 11 ++++++-----
 io_uring/io_uring.c | 36 ++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 7b23607cf4afd..a5d51471feebb 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -263,7 +263,7 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	};
 	ktime_t timeout = KTIME_MAX;
 	struct io_uring_sync_cancel_reg sc;
-	struct fd f = { };
+	struct file *file = NULL;
 	DEFINE_WAIT(wait);
 	int ret, i;
 
@@ -285,10 +285,10 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	/* we can grab a normal file descriptor upfront */
 	if ((cd.flags & IORING_ASYNC_CANCEL_FD) &&
 	   !(cd.flags & IORING_ASYNC_CANCEL_FD_FIXED)) {
-		f = fdget(sc.fd);
-		if (!f.file)
+		file = fget(sc.fd);
+		if (!file)
 			return -EBADF;
-		cd.file = f.file;
+		cd.file = file;
 	}
 
 	ret = __io_sync_cancel(current->io_uring, &cd, sc.fd);
@@ -338,6 +338,7 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	if (ret == -ENOENT || ret > 0)
 		ret = 0;
 out:
-	fdput(f);
+	if (file)
+		fput(file);
 	return ret;
 }
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8d1bc6cdfe712..e27d970b140c3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3603,7 +3603,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		size_t, argsz)
 {
 	struct io_ring_ctx *ctx;
-	struct fd f;
+	struct file *file;
 	long ret;
 
 	if (unlikely(flags & ~(IORING_ENTER_GETEVENTS | IORING_ENTER_SQ_WAKEUP |
@@ -3621,20 +3621,19 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		if (unlikely(!tctx || fd >= IO_RINGFD_REG_MAX))
 			return -EINVAL;
 		fd = array_index_nospec(fd, IO_RINGFD_REG_MAX);
-		f.file = tctx->registered_rings[fd];
-		f.flags = 0;
-		if (unlikely(!f.file))
+		file = tctx->registered_rings[fd];
+		if (unlikely(!file))
 			return -EBADF;
 	} else {
-		f = fdget(fd);
-		if (unlikely(!f.file))
+		file = fget(fd);
+		if (unlikely(!file))
 			return -EBADF;
 		ret = -EOPNOTSUPP;
-		if (unlikely(!io_is_uring_fops(f.file)))
+		if (unlikely(!io_is_uring_fops(file)))
 			goto out;
 	}
 
-	ctx = f.file->private_data;
+	ctx = file->private_data;
 	ret = -EBADFD;
 	if (unlikely(ctx->flags & IORING_SETUP_R_DISABLED))
 		goto out;
@@ -3728,7 +3727,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		}
 	}
 out:
-	fdput(f);
+	if (!(flags & IORING_ENTER_REGISTERED_RING))
+		fput(file);
 	return ret;
 }
 
@@ -4569,7 +4569,7 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
 {
 	struct io_ring_ctx *ctx;
 	long ret = -EBADF;
-	struct fd f;
+	struct file *file;
 	bool use_registered_ring;
 
 	use_registered_ring = !!(opcode & IORING_REGISTER_USE_REGISTERED_RING);
@@ -4588,27 +4588,27 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
 		if (unlikely(!tctx || fd >= IO_RINGFD_REG_MAX))
 			return -EINVAL;
 		fd = array_index_nospec(fd, IO_RINGFD_REG_MAX);
-		f.file = tctx->registered_rings[fd];
-		f.flags = 0;
-		if (unlikely(!f.file))
+		file = tctx->registered_rings[fd];
+		if (unlikely(!file))
 			return -EBADF;
 	} else {
-		f = fdget(fd);
-		if (unlikely(!f.file))
+		file = fget(fd);
+		if (unlikely(!file))
 			return -EBADF;
 		ret = -EOPNOTSUPP;
-		if (!io_is_uring_fops(f.file))
+		if (!io_is_uring_fops(file))
 			goto out_fput;
 	}
 
-	ctx = f.file->private_data;
+	ctx = file->private_data;
 
 	mutex_lock(&ctx->uring_lock);
 	ret = __io_uring_register(ctx, opcode, arg, nr_args);
 	mutex_unlock(&ctx->uring_lock);
 	trace_io_uring_register(ctx, opcode, ctx->nr_user_files, ctx->nr_user_bufs, ret);
 out_fput:
-	fdput(f);
+	if (!use_registered_ring)
+		fput(file);
 	return ret;
 }
 
-- 
2.42.0

