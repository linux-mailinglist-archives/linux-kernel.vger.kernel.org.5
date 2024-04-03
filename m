Return-Path: <linux-kernel+bounces-129911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7DD8971ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE72B1C27415
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791E149C52;
	Wed,  3 Apr 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rzr89TDQ"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDB1494AD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153096; cv=none; b=fkz4T8QzX3cqP0D3TXTV2Pa+L/D2hS5s01a/oUJOrCx9TyWYjbNBC0YoU8QX6NNyx+RksrnLbj7jd4TMX4lN5l4PRr4nsxNqx9A4+FcK4Z17FyKAfVMb6dbeXhnIB+XAEBdR1spB7LZ//HBWyohHH0i3qveD5XZreQNNiWk4qb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153096; c=relaxed/simple;
	bh=6STkbNF9IykgRTEcdff9wMG+OREzNqGuxRB0b8pdocg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUGYVzUusoVbOoUvc955OKkRx/ANYBzqN8fTS16TtVJjq1EHRtNEKtfYRHnPuxhzbJmRAPlV1un/lgh6TOljyqBWq+Zr4Tr45qlI81MJnZeAGiFMhayl8CXsuwaboHh1asp7FFtXjWwhrV85Mp77Ezs/eRIMmXkWw5qdjljbNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rzr89TDQ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d341631262so21025339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712153094; x=1712757894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/02XYy/LfSK56jjNNQ4gWduGouBBNFPrgasM4Sr4mA=;
        b=rzr89TDQcUtgS8BElm8txGhRp+UOLHEQKfUqPBYzs56deAzKpMYvNVyQa0U6uoWj6z
         jv3VZN5xALjQ0aYWrSbNdvJ4PmH7cvmo63ONR2aOkcYdXbOmhvwhHGzaZC8rj4L0UxZc
         0H8Vud6Puzl6WfM6fRcw0+DueMPbuZBohnUYcov/9I9rvPGc4Kp+85DrfHbM+A6OnYjj
         JcpCKovllsnbuiwkOjUDiDNCDop1mbVtK4I5yKLhFhBUSC1kB8eiDnlktT6dRHelRlC1
         p9crDhHczuiyHa6mCMgsU6ZbOGsoLVmBkBXzBKNj0QBCJCHXczHUmYN7d0YyGAXagR7W
         RIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153094; x=1712757894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/02XYy/LfSK56jjNNQ4gWduGouBBNFPrgasM4Sr4mA=;
        b=TIbS7sKECJ0+ySJOhu2UqGuSeKi/KyY7ATZz7LIjcKQnEpqlGkRteHh8RVQAeXCVjI
         2+9PpbEPGfmirua/ez3xdH6xTfjYjjUeuG/6nU1DPtoGV7b4tSderDihcwEo8iqRH92K
         i22jONKTrp9/QhyicxuFDtlAfnid+NBnWISY7ySLTkmHaHYyLHyFI2DrPuEAk0t5IXhR
         CrZzmOxJ9VKVJD7mbjOtRc7tzYwDYk2jfT9BHODGIrdv8R3Dv95yPrSuNxwCZQvLOu+k
         tqPW5Q5tl5ODde0pss5Zgym9oqkd+vSWV0JZz6d//3Dj/ivEH26ywG3QHgGFKa/JsAQw
         RXxA==
X-Forwarded-Encrypted: i=1; AJvYcCVyK64bzKj3jyu671GUim7FrUtW5CdVZhJQSwKbOJxVOps/eDAbzX0LwbsUQ1niqjt1hENkTL05xpeH5bAcafE/IFW6AxgJu0AEVTht
X-Gm-Message-State: AOJu0Yza4ykb7qGpxRBWrVCChheSy1ffctYMX43RpYpTF7eo6rBAARS0
	8EOpb104m+vG6TIY11R/Zz2Zre/LUmSOo/3SNSrPxP7MFJDjwVfJosFc9JKN2/wXa30GJ4UJmUW
	+
X-Google-Smtp-Source: AGHT+IFGqYAojbvaoIpX7A9sUe4fZS+QXUdR7LHOFgZEIG7dI5Xy+Zv7TlHS4XMezmx0QW3VMe40AQ==
X-Received: by 2002:a5d:9b1a:0:b0:7d0:8461:7819 with SMTP id y26-20020a5d9b1a000000b007d084617819mr15118977ion.1.1712153093784;
        Wed, 03 Apr 2024 07:04:53 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a3-20020a056638164300b0047ef3ea2bdfsm2027098jat.78.2024.04.03.07.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:04:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] userfaultfd: convert to ->read_iter()
Date: Wed,  3 Apr 2024 08:02:53 -0600
Message-ID: <20240403140446.1623931-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403140446.1623931-1-axboe@kernel.dk>
References: <20240403140446.1623931-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than use the older style ->read() hook, use ->read_iter() so that
userfaultfd can support both O_NONBLOCK and IOCB_NOWAIT for non-blocking
read attempts.

Split the fd setup into two parts, so that userfaultfd can mark the file
mode with FMODE_NOWAIT before installing it into the process table. With
that, we can also defer grabbing the mm until we know the rest will
succeed, as the fd isn't visible before then.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/userfaultfd.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 60dcfafdc11a..d2f5409d60b6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -31,6 +31,7 @@
 #include <linux/hugetlb.h>
 #include <linux/swapops.h>
 #include <linux/miscdevice.h>
+#include <linux/uio.h>
 
 static int sysctl_unprivileged_userfaultfd __read_mostly;
 
@@ -282,7 +283,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 /*
  * Verify the pagetables are still not ok after having reigstered into
  * the fault_pending_wqh to avoid userland having to UFFDIO_WAKE any
- * userfault that has already been resolved, if userfaultfd_read and
+ * userfault that has already been resolved, if userfaultfd_read_iter and
  * UFFDIO_COPY|ZEROPAGE are being run simultaneously on two different
  * threads.
  */
@@ -1177,34 +1178,34 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 	return ret;
 }
 
-static ssize_t userfaultfd_read(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t userfaultfd_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct userfaultfd_ctx *ctx = file->private_data;
 	ssize_t _ret, ret = 0;
 	struct uffd_msg msg;
-	int no_wait = file->f_flags & O_NONBLOCK;
 	struct inode *inode = file_inode(file);
+	bool no_wait;
 
 	if (!userfaultfd_is_initialized(ctx))
 		return -EINVAL;
 
+	no_wait = file->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT;
 	for (;;) {
-		if (count < sizeof(msg))
+		if (iov_iter_count(to) < sizeof(msg))
 			return ret ? ret : -EINVAL;
 		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg, inode);
 		if (_ret < 0)
 			return ret ? ret : _ret;
-		if (copy_to_user((__u64 __user *) buf, &msg, sizeof(msg)))
+		_ret = copy_to_iter(&msg, sizeof(msg), to);
+		if (_ret < 0)
 			return ret ? ret : -EFAULT;
 		ret += sizeof(msg);
-		buf += sizeof(msg);
-		count -= sizeof(msg);
 		/*
 		 * Allow to read more than one fault at time but only
 		 * block if waiting for the very first one.
 		 */
-		no_wait = O_NONBLOCK;
+		no_wait = true;
 	}
 }
 
@@ -2172,7 +2173,7 @@ static const struct file_operations userfaultfd_fops = {
 #endif
 	.release	= userfaultfd_release,
 	.poll		= userfaultfd_poll,
-	.read		= userfaultfd_read,
+	.read_iter	= userfaultfd_read_iter,
 	.unlocked_ioctl = userfaultfd_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= noop_llseek,
@@ -2192,6 +2193,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 static int new_userfaultfd(int flags)
 {
 	struct userfaultfd_ctx *ctx;
+	struct file *file;
 	int fd;
 
 	BUG_ON(!current->mm);
@@ -2215,16 +2217,26 @@ static int new_userfaultfd(int flags)
 	init_rwsem(&ctx->map_changing_lock);
 	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
-	/* prevent the mm struct to be freed */
-	mmgrab(ctx->mm);
+
+	fd = get_unused_fd_flags(O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	if (fd < 0)
+		goto err_out;
 
 	/* Create a new inode so that the LSM can block the creation.  */
-	fd = anon_inode_create_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
+	file = anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
 			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
-	if (fd < 0) {
-		mmdrop(ctx->mm);
-		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		fd = PTR_ERR(file);
+		goto err_out;
 	}
+	/* prevent the mm struct to be freed */
+	mmgrab(ctx->mm);
+	file->f_mode |= FMODE_NOWAIT;
+	fd_install(fd, file);
+	return fd;
+err_out:
+	kmem_cache_free(userfaultfd_ctx_cachep, ctx);
 	return fd;
 }
 
-- 
2.43.0


