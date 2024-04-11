Return-Path: <linux-kernel+bounces-141224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C78D8A1B10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9391C2154C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271E205395;
	Thu, 11 Apr 2024 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yQvxLmy1"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E6205371
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850234; cv=none; b=TMnpzhODnLVtV1t5Sxl38WCYQ2a8J7RtN6GnRhaWY2W/8gY3piWMdMjDnYBrfC2NNoSF4SaskbIsTJsGerhm4nGuv6rWCp6T8629ezoe2HorOx4oamrapMA2uKbQOPXmpgiw5TQREX6Gt/YSmXK1ed47+w7dvo93nDLssPdK0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850234; c=relaxed/simple;
	bh=rHXTRstvyXvEinfQqa+odOLroN/rU5lJPdVIxyZIyKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZosiWhPCIOqI9G/JQ8MiF0zmLLR2VQWZqYA40i788SOMjvuwcQ0MrcNIcNru79bljr+7GRspM25HOBv+KG/c6uQORHdyMVGFbMpu88vBcWGWJ5Ew/VJOKRYLtXvZmdvzKxbGu/qvyoYN0pXW8XAzWq0t4AmFRUsVz89gYTSU7VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yQvxLmy1; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58299439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850232; x=1713455032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbAtfgGgTyyTwkWcoE+4CccCugNods6xg7l8RNoygg4=;
        b=yQvxLmy1ErGfacFHBCW9Lauf5JyPQcLVVPhTSSxKqSbv3+ID3sKrG8PJ4Rdke3Tjpz
         P76WV1De9xQwuSyHOFA7S6aSQfuyWKkBmLMch3zzQe/KXf98IjinSde5eHZjWTHvgI9E
         o9LpgOjEtV4DjnjtUOarWB4yVsKj3kK0NFw2WQN+1HjHB6+1fF0oJ3QjeTYbKui0+R2j
         07N6VjHH7N1aZu9nlaJIRo6JvH2dhhudxdA9H3XvjK2ZHeyaMriYQpH79uG6qSQDhUQ2
         ma9QfWuJfNdpMl2NqkTeTKDa15ax0d3GrhDk7a0AjKrxvrB2FWasmE81ncuyZC6sGEcU
         PUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850232; x=1713455032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbAtfgGgTyyTwkWcoE+4CccCugNods6xg7l8RNoygg4=;
        b=nKOCt+woni+9aOzB75vRMnGaQxOZ2zjVLdQLI0Op78alrXIT58FLafkSmhs5An9iOu
         8XnBNtsVm6FU3leuvG8a+BBCB5oxhzqZB/YQpkX0ehsBnjWyz8G3GoIDJaoADWjzhQ7l
         ch5KyH87Ud57QYawuJapIJkbhRxNEN+NHRMUz4BYbb3DsjiNx/8Ji1uUcXRyNDDqB9z4
         PRp3HWFKvWFHUXUfKJ3j9YRWwCzy5QqQdEwKPyltnm1dClAnfTY5Yqo1ZxbnbLmVsAHv
         AZm+4e5gMvtKbUF9Agvpymj9N+P37M8rXnK2hSla9Xxbt8xgR67Tw4ztuuL1mZnL4TxJ
         vjIw==
X-Gm-Message-State: AOJu0YxOj+KvLDe0mePmTbHvTFn1UlodiQ7VTfgGwAiP0U4LeL1eOE5+
	E+zZgGMiJIqmtvR69Z8rCitl5ZL4w9ia8N2Lwb+h6kFAZjMqIfX7H2H4zNBX9/hix7mQcdR531b
	5
X-Google-Smtp-Source: AGHT+IE0aGaJWy/7ZBF3nfd+nSqjwxdw1Z/v0YruBvVEJItBCkKs5fN5rzDLIXWQ8naoeKXod1tEzw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr183198ioh.1.1712850231824;
        Thu, 11 Apr 2024 08:43:51 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 437/437] REMOVE ->read() and ->write()
Date: Thu, 11 Apr 2024 09:19:37 -0600
Message-ID: <20240411153126.16201-438-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test patch just to check coverage.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/file_table.c    |  4 +--
 fs/open.c          |  4 +--
 fs/read_write.c    | 16 +++--------
 include/linux/fs.h |  2 --
 io_uring/rw.c      | 70 ----------------------------------------------
 5 files changed, 8 insertions(+), 88 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 4f03beed4737..54cf21766633 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -292,10 +292,10 @@ static void file_init_path(struct file *file, const struct path *path,
 	if (fop->llseek)
 		file->f_mode |= FMODE_LSEEK;
 	if ((file->f_mode & FMODE_READ) &&
-	     likely(fop->read || fop->read_iter))
+	     likely(fop->read_iter))
 		file->f_mode |= FMODE_CAN_READ;
 	if ((file->f_mode & FMODE_WRITE) &&
-	     likely(fop->write || fop->write_iter))
+	     likely(fop->write_iter))
 		file->f_mode |= FMODE_CAN_WRITE;
 	file->f_iocb_flags = iocb_flags(file);
 	file->f_mode |= FMODE_OPENED;
diff --git a/fs/open.c b/fs/open.c
index ee8460c83c77..63caada91fc5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -958,10 +958,10 @@ static int do_dentry_open(struct file *f,
 	}
 	f->f_mode |= FMODE_OPENED;
 	if ((f->f_mode & FMODE_READ) &&
-	     likely(f->f_op->read || f->f_op->read_iter))
+	     likely(f->f_op->read_iter))
 		f->f_mode |= FMODE_CAN_READ;
 	if ((f->f_mode & FMODE_WRITE) &&
-	     likely(f->f_op->write || f->f_op->write_iter))
+	     likely(f->f_op->write_iter))
 		f->f_mode |= FMODE_CAN_WRITE;
 	if ((f->f_mode & FMODE_LSEEK) && !f->f_op->llseek)
 		f->f_mode &= ~FMODE_LSEEK;
diff --git a/fs/read_write.c b/fs/read_write.c
index efddd395d436..caec0998f28a 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -425,7 +425,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 	 * Also fail if ->read_iter and ->read are both wired up as that
 	 * implies very convoluted semantics.
 	 */
-	if (unlikely(!file->f_op->read_iter || file->f_op->read))
+	if (unlikely(!file->f_op->read_iter))
 		return warn_unsupported(file, "read");
 
 	init_sync_kiocb(&kiocb, file);
@@ -470,9 +470,7 @@ ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
 
-	if (file->f_op->read)
-		ret = file->f_op->read(file, buf, count, pos);
-	else if (file->f_op->read_iter)
+	if (file->f_op->read_iter)
 		ret = new_sync_read(file, buf, count, pos);
 	else
 		ret = -EINVAL;
@@ -515,7 +513,7 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
 	 * Also fail if ->write_iter and ->write are both wired up as that
 	 * implies very convoluted semantics.
 	 */
-	if (unlikely(!file->f_op->write_iter || file->f_op->write))
+	if (unlikely(!file->f_op->write_iter))
 		return warn_unsupported(file, "write");
 
 	init_sync_kiocb(&kiocb, file);
@@ -584,9 +582,7 @@ ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
 	file_start_write(file);
-	if (file->f_op->write)
-		ret = file->f_op->write(file, buf, count, pos);
-	else if (file->f_op->write_iter)
+	if (file->f_op->write_iter)
 		ret = new_sync_write(file, buf, count, pos);
 	else
 		ret = -EINVAL;
@@ -972,8 +968,6 @@ static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 
 	if (file->f_op->read_iter)
 		ret = do_iter_readv_writev(file, &iter, pos, READ, flags);
-	else
-		ret = do_loop_readv(file, &iter, pos, flags, file->f_op->read);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);
@@ -1011,8 +1005,6 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 	file_start_write(file);
 	if (file->f_op->write_iter)
 		ret = do_iter_readv_writev(file, &iter, pos, WRITE, flags);
-	else
-		ret = do_loop_writev(file, &iter, pos, flags, file->f_op->write);
 	if (ret > 0)
 		fsnotify_modify(file);
 	file_end_write(file);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 55fc02b99cf6..7606ed6b9dbc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2009,8 +2009,6 @@ struct offset_ctx;
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
-	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
-	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iopoll)(struct kiocb *kiocb, struct io_comp_batch *,
diff --git a/io_uring/rw.c b/io_uring/rw.c
index c8d48287439e..9178b1bccb8b 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -474,72 +474,6 @@ static inline loff_t *io_kiocb_ppos(struct kiocb *kiocb)
 	return (kiocb->ki_filp->f_mode & FMODE_STREAM) ? NULL : &kiocb->ki_pos;
 }
 
-/*
- * For files that don't have ->read_iter() and ->write_iter(), handle them
- * by looping over ->read() or ->write() manually.
- */
-static ssize_t loop_rw_iter(int ddir, struct io_rw *rw, struct iov_iter *iter)
-{
-	struct kiocb *kiocb = &rw->kiocb;
-	struct file *file = kiocb->ki_filp;
-	ssize_t ret = 0;
-	loff_t *ppos;
-
-	/*
-	 * Don't support polled IO through this interface, and we can't
-	 * support non-blocking either. For the latter, this just causes
-	 * the kiocb to be handled from an async context.
-	 */
-	if (kiocb->ki_flags & IOCB_HIPRI)
-		return -EOPNOTSUPP;
-	if ((kiocb->ki_flags & IOCB_NOWAIT) &&
-	    !(kiocb->ki_filp->f_flags & O_NONBLOCK))
-		return -EAGAIN;
-
-	ppos = io_kiocb_ppos(kiocb);
-
-	while (iov_iter_count(iter)) {
-		void __user *addr;
-		size_t len;
-		ssize_t nr;
-
-		if (iter_is_ubuf(iter)) {
-			addr = iter->ubuf + iter->iov_offset;
-			len = iov_iter_count(iter);
-		} else if (!iov_iter_is_bvec(iter)) {
-			addr = iter_iov_addr(iter);
-			len = iter_iov_len(iter);
-		} else {
-			addr = u64_to_user_ptr(rw->addr);
-			len = rw->len;
-		}
-
-		if (ddir == READ)
-			nr = file->f_op->read(file, addr, len, ppos);
-		else
-			nr = file->f_op->write(file, addr, len, ppos);
-
-		if (nr < 0) {
-			if (!ret)
-				ret = nr;
-			break;
-		}
-		ret += nr;
-		if (!iov_iter_is_bvec(iter)) {
-			iov_iter_advance(iter, nr);
-		} else {
-			rw->addr += nr;
-			rw->len -= nr;
-			if (!rw->len)
-				break;
-		}
-		if (nr != len)
-			break;
-	}
-
-	return ret;
-}
-
 static void io_req_map_rw(struct io_kiocb *req, const struct iovec *iovec,
 			  const struct iovec *fast_iov, struct iov_iter *iter)
 {
@@ -702,8 +636,6 @@ static inline int io_iter_do_read(struct io_rw *rw, struct iov_iter *iter)
 
 	if (likely(file->f_op->read_iter))
 		return call_read_iter(file, &rw->kiocb, iter);
-	else if (file->f_op->read)
-		return loop_rw_iter(READ, rw, iter);
 	else
 		return -EINVAL;
 }
@@ -1055,8 +987,6 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (likely(req->file->f_op->write_iter))
 		ret2 = call_write_iter(req->file, kiocb, &s->iter);
-	else if (req->file->f_op->write)
-		ret2 = loop_rw_iter(WRITE, rw, &s->iter);
 	else
 		ret2 = -EINVAL;
 
-- 
2.43.0


