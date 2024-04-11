Return-Path: <linux-kernel+bounces-141118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D005C8A1A92
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B0128736F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E61E8305;
	Thu, 11 Apr 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UJWx73Zv"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1A1E7955
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850066; cv=none; b=RtB3T+UY0K4xiaF9fIyZcB1/kSjl345W/6DvmwbA7YSrsuXug1RILVNT9pIi60eGF4gcV5MlgoNIQcEH1vSaRg2rP93anntAeNvyW4yRnWDmvfSz2gJWkKU9L9h2+gzE++hynJjn3Vdy+fNq/MqQe1h6GEHMjSEpJhCu6I6yjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850066; c=relaxed/simple;
	bh=1U8ijbqUrqPaQOZ3jdBlGBUkZMII7qIbCc9eeO1/rYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvKn2MxoDYgW9L24jpKPkVJBhUP6/6gTz6BnoCF0jfYfVdtpeDab6ihEnQHewA51osD/P4wd/rPEfZFdnC9u68c6jNf0++1dhMQW8gcYHznR4HhY59VZUxNKijRt76cOITHyA7TLPh8eQZQfIAOlI+0Ns0Ob0F+5CdpMTEUMwuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UJWx73Zv; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9063639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850062; x=1713454862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1VCjRWQQSxBJsxF7soIbkCnGMMt3DjZ26qqRbqQowo=;
        b=UJWx73Zv8BUmLaw+9501lxiKVKOPQat3U/4Oe69VgPQoSljyOGC9HLsbj1yqDE3wez
         DGsbfyzB2Rg4L/ffhCd2e4ImFDlwSLgOvqP0k+qaTmY1W04lmNVACkvu0e6gh6UalwR9
         DsCOwBc2zO6tCQ7NkpVtPi5m413XJ3fMteqgPOZZyR5sNOzAggkyAXsEwVrkJoD6kftF
         dZRmr6YRy4TnBrIQ2NrQYGQXrpTf8/lEiZJXOlUxr2cgxqblUsmUbFQsvbXb5PhtM/J+
         3buqeMGOUsJZB4TdQrzQFwztZ+zIW8EwZviPBtT9DU9Si3q9fLHnSWG+vbEFVNdIHI4Y
         0L0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850062; x=1713454862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1VCjRWQQSxBJsxF7soIbkCnGMMt3DjZ26qqRbqQowo=;
        b=YWzOITjf/KuuSNfmVLNjT3/6fQM9BDV1riPxl7pWxbIiXXFFN1hteDUvmgDFV341pJ
         gU4wHlSHNfhSI4VvJ1jx2dZBPSsEPqJpljDuk6BxOstHCBaILEoXKSAlleygrJR9+SeP
         5G14Q/kjzFYbB+4m77a6UVJVZNKlumBPJEh4qKMJKhxlxJWzOkct7mVzfCWg+GUI8szr
         eUMntwckFKZXTXIQuvSCcN2fBz8+ptCBpfCkF+MpNYwmU9BlXdipztVEzORlzHbkSXyc
         kRKb8PUYX4ka76A4YB8MF0fJ88vw6m32Jhi4mUGcRPw7JH8pJzECivuKjvQGG+ZDsqPN
         L8ew==
X-Gm-Message-State: AOJu0Yyiushu5hJsTm8CXETCi4Hiv6E8NZ6P7S9VJwtX3kGWkOuZK5pW
	DZlg4STZzHi8JwqJTBpbD5N5q1E1acLWwJi6iuJgt0jmvlhx+I4Is2m5SIQOjsQAXOnpo0Bti2w
	c
X-Google-Smtp-Source: AGHT+IGiyusTiXUiExBB3VSTmCsP0Pvm/tqOFyIWVaLxqcGgEmxYCpl/xXkoDRXqU2ns342ZrKhkuQ==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr234734ioh.0.1712850062477;
        Thu, 11 Apr 2024 08:41:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 339/437] powerpc/spufs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:59 -0600
Message-ID: <20240411153126.16201-340-axboe@kernel.dk>
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

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/powerpc/platforms/cell/spufs/file.c | 312 +++++++++++------------
 1 file changed, 147 insertions(+), 165 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 02a8158c469d..025c9b0a0470 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -67,14 +67,13 @@ static int spufs_attr_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t spufs_attr_read(struct file *file, char __user *buf,
-		size_t len, loff_t *ppos)
+static ssize_t spufs_attr_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct spufs_attr *attr;
 	size_t size;
 	ssize_t ret;
 
-	attr = file->private_data;
+	attr = iocb->ki_filp->private_data;
 	if (!attr->get)
 		return -EACCES;
 
@@ -82,7 +81,7 @@ static ssize_t spufs_attr_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	if (*ppos) {		/* continued read */
+	if (iocb->ki_pos) {	/* continued read */
 		size = strlen(attr->get_buf);
 	} else {		/* first read */
 		u64 val;
@@ -94,21 +93,21 @@ static ssize_t spufs_attr_read(struct file *file, char __user *buf,
 				 attr->fmt, (unsigned long long)val);
 	}
 
-	ret = simple_read_from_buffer(buf, len, ppos, attr->get_buf, size);
+	ret = simple_copy_to_iter(attr->get_buf, &iocb->ki_pos, size, to);
 out:
 	mutex_unlock(&attr->mutex);
 	return ret;
 }
 
-static ssize_t spufs_attr_write(struct file *file, const char __user *buf,
-		size_t len, loff_t *ppos)
+static ssize_t spufs_attr_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	struct spufs_attr *attr;
 	u64 val;
 	size_t size;
 	ssize_t ret;
 
-	attr = file->private_data;
+	attr = iocb->ki_filp->private_data;
 	if (!attr->set)
 		return -EACCES;
 
@@ -118,7 +117,7 @@ static ssize_t spufs_attr_write(struct file *file, const char __user *buf,
 
 	ret = -EFAULT;
 	size = min(sizeof(attr->set_buf) - 1, len);
-	if (copy_from_user(attr->set_buf, buf, size))
+	if (!copy_from_iter_full(attr->set_buf, size, from))
 		goto out;
 
 	ret = len; /* claim we got the whole input */
@@ -147,8 +146,8 @@ static int __fops ## _open(struct inode *inode, struct file *file)	\
 static const struct file_operations __fops = {				\
 	.open	 = __fops ## _open,					\
 	.release = spufs_attr_release,					\
-	.read	 = spufs_attr_read,					\
-	.write	 = spufs_attr_write,					\
+	.read_iter = spufs_attr_read,					\
+	.write_iter = spufs_attr_write,					\
 	.llseek  = generic_file_llseek,					\
 };
 
@@ -186,30 +185,27 @@ spufs_mem_dump(struct spu_context *ctx, struct coredump_params *cprm)
 	return spufs_dump_emit(cprm, ctx->ops->get_ls(ctx), LS_SIZE);
 }
 
-static ssize_t
-spufs_mem_read(struct file *file, char __user *buffer,
-				size_t size, loff_t *pos)
+static ssize_t spufs_mem_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 	ssize_t ret;
 
 	ret = spu_acquire(ctx);
 	if (ret)
 		return ret;
-	ret = simple_read_from_buffer(buffer, size, pos, ctx->ops->get_ls(ctx),
-				      LS_SIZE);
+	ret = simple_copy_to_iter(ctx->ops->get_ls(ctx), &iocb->ki_pos, LS_SIZE,
+				  to);
 	spu_release(ctx);
 
 	return ret;
 }
 
-static ssize_t
-spufs_mem_write(struct file *file, const char __user *buffer,
-					size_t size, loff_t *ppos)
+static ssize_t spufs_mem_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 	char *local_store;
-	loff_t pos = *ppos;
+	loff_t pos = iocb->ki_pos;
+	ssize_t size;
 	int ret;
 
 	if (pos > LS_SIZE)
@@ -220,7 +216,7 @@ spufs_mem_write(struct file *file, const char __user *buffer,
 		return ret;
 
 	local_store = ctx->ops->get_ls(ctx);
-	size = simple_write_to_buffer(local_store, LS_SIZE, ppos, buffer, size);
+	size = simple_copy_to_iter(local_store, &iocb->ki_pos, LS_SIZE, from);
 	spu_release(ctx);
 
 	return size;
@@ -301,8 +297,8 @@ static int spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
 static const struct file_operations spufs_mem_fops = {
 	.open			= spufs_mem_open,
 	.release		= spufs_mem_release,
-	.read			= spufs_mem_read,
-	.write			= spufs_mem_write,
+	.read_iter		= spufs_mem_read,
+	.write_iter		= spufs_mem_write,
 	.llseek			= generic_file_llseek,
 	.mmap			= spufs_mem_mmap,
 };
@@ -451,8 +447,8 @@ spufs_cntl_release(struct inode *inode, struct file *file)
 static const struct file_operations spufs_cntl_fops = {
 	.open = spufs_cntl_open,
 	.release = spufs_cntl_release,
-	.read = simple_attr_read,
-	.write = simple_attr_write,
+	.read_iter = simple_attr_read_iter,
+	.write_iter = simple_attr_write_iter,
 	.llseek	= no_llseek,
 	.mmap = spufs_cntl_mmap,
 };
@@ -472,44 +468,41 @@ spufs_regs_dump(struct spu_context *ctx, struct coredump_params *cprm)
 			       sizeof(ctx->csa.lscsa->gprs));
 }
 
-static ssize_t
-spufs_regs_read(struct file *file, char __user *buffer,
-		size_t size, loff_t *pos)
+static ssize_t spufs_regs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int ret;
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 
 	/* pre-check for file position: if we'd return EOF, there's no point
 	 * causing a deschedule */
-	if (*pos >= sizeof(ctx->csa.lscsa->gprs))
+	if (iocb->ki_pos >= sizeof(ctx->csa.lscsa->gprs))
 		return 0;
 
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
-	ret = simple_read_from_buffer(buffer, size, pos, ctx->csa.lscsa->gprs,
-				      sizeof(ctx->csa.lscsa->gprs));
+	ret = simple_copy_to_iter(ctx->csa.lscsa->gprs, &iocb->ki_pos,
+				      sizeof(ctx->csa.lscsa->gprs), to);
 	spu_release_saved(ctx);
 	return ret;
 }
 
-static ssize_t
-spufs_regs_write(struct file *file, const char __user *buffer,
-		 size_t size, loff_t *pos)
+static ssize_t spufs_regs_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	ssize_t size;
 	int ret;
 
-	if (*pos >= sizeof(lscsa->gprs))
+	if (iocb->ki_pos >= sizeof(lscsa->gprs))
 		return -EFBIG;
 
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
 
-	size = simple_write_to_buffer(lscsa->gprs, sizeof(lscsa->gprs), pos,
-					buffer, size);
+	size = simple_copy_from_iter(lscsa->gprs, &iocb->ki_pos,
+					sizeof(lscsa->gprs), from);
 
 	spu_release_saved(ctx);
 	return size;
@@ -517,8 +510,8 @@ spufs_regs_write(struct file *file, const char __user *buffer,
 
 static const struct file_operations spufs_regs_fops = {
 	.open	 = spufs_regs_open,
-	.read    = spufs_regs_read,
-	.write   = spufs_regs_write,
+	.read_iter = spufs_regs_read,
+	.write_iter = spufs_regs_write,
 	.llseek  = generic_file_llseek,
 };
 
@@ -529,39 +522,36 @@ spufs_fpcr_dump(struct spu_context *ctx, struct coredump_params *cprm)
 			       sizeof(ctx->csa.lscsa->fpcr));
 }
 
-static ssize_t
-spufs_fpcr_read(struct file *file, char __user * buffer,
-		size_t size, loff_t * pos)
+static ssize_t spufs_fpcr_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int ret;
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
-	ret = simple_read_from_buffer(buffer, size, pos, &ctx->csa.lscsa->fpcr,
-				      sizeof(ctx->csa.lscsa->fpcr));
+	ret = simple_copy_to_iter(&ctx->csa.lscsa->fpcr, &iocb->ki_pos,
+				      sizeof(ctx->csa.lscsa->fpcr), to);
 	spu_release_saved(ctx);
 	return ret;
 }
 
-static ssize_t
-spufs_fpcr_write(struct file *file, const char __user * buffer,
-		 size_t size, loff_t * pos)
+static ssize_t spufs_fpcr_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 	struct spu_lscsa *lscsa = ctx->csa.lscsa;
+	ssize_t size;
 	int ret;
 
-	if (*pos >= sizeof(lscsa->fpcr))
+	if (iocb->ki_pos >= sizeof(lscsa->fpcr))
 		return -EFBIG;
 
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
 
-	size = simple_write_to_buffer(&lscsa->fpcr, sizeof(lscsa->fpcr), pos,
-					buffer, size);
+	size = simple_copy_from_iter(&lscsa->fpcr, &iocb->ki_pos,
+					sizeof(lscsa->fpcr), from);
 
 	spu_release_saved(ctx);
 	return size;
@@ -569,8 +559,8 @@ spufs_fpcr_write(struct file *file, const char __user * buffer,
 
 static const struct file_operations spufs_fpcr_fops = {
 	.open = spufs_regs_open,
-	.read = spufs_fpcr_read,
-	.write = spufs_fpcr_write,
+	.read_iter = spufs_fpcr_read,
+	.write_iter = spufs_fpcr_write,
 	.llseek = generic_file_llseek,
 };
 
@@ -591,11 +581,11 @@ static int spufs_pipe_open(struct inode *inode, struct file *file)
  * - end of the user provided buffer
  * - end of the mapped area
  */
-static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
-			size_t len, loff_t *pos)
+static ssize_t spufs_mbox_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
-	u32 mbox_data, __user *udata = (void __user *)buf;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
+	u32 mbox_data;
 	ssize_t count;
 
 	if (len < 4)
@@ -605,7 +595,7 @@ static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 	if (count)
 		return count;
 
-	for (count = 0; (count + 4) <= len; count += 4, udata++) {
+	for (count = 0; (count + 4) <= len; count += 4) {
 		int ret;
 		ret = ctx->ops->mbox_read(ctx, &mbox_data);
 		if (ret == 0)
@@ -616,7 +606,7 @@ static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 		 * but still need to return the data we have
 		 * read successfully so far.
 		 */
-		ret = put_user(mbox_data, udata);
+		ret = put_iter(mbox_data, to);
 		if (ret) {
 			if (!count)
 				count = -EFAULT;
@@ -633,14 +623,14 @@ static ssize_t spufs_mbox_read(struct file *file, char __user *buf,
 
 static const struct file_operations spufs_mbox_fops = {
 	.open	= spufs_pipe_open,
-	.read	= spufs_mbox_read,
+	.read_iter = spufs_mbox_read,
 	.llseek	= no_llseek,
 };
 
-static ssize_t spufs_mbox_stat_read(struct file *file, char __user *buf,
-			size_t len, loff_t *pos)
+static ssize_t spufs_mbox_stat_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	ssize_t ret;
 	u32 mbox_stat;
 
@@ -655,7 +645,7 @@ static ssize_t spufs_mbox_stat_read(struct file *file, char __user *buf,
 
 	spu_release(ctx);
 
-	if (copy_to_user(buf, &mbox_stat, sizeof mbox_stat))
+	if (!copy_to_iter_full(&mbox_stat, sizeof (mbox_stat), to))
 		return -EFAULT;
 
 	return 4;
@@ -663,7 +653,7 @@ static ssize_t spufs_mbox_stat_read(struct file *file, char __user *buf,
 
 static const struct file_operations spufs_mbox_stat_fops = {
 	.open	= spufs_pipe_open,
-	.read	= spufs_mbox_stat_read,
+	.read_iter = spufs_mbox_stat_read,
 	.llseek = no_llseek,
 };
 
@@ -694,11 +684,11 @@ void spufs_ibox_callback(struct spu *spu)
  * any data is available, but return when we have been able to
  * read something.
  */
-static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
-			size_t len, loff_t *pos)
+static ssize_t spufs_ibox_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
-	u32 ibox_data, __user *udata = (void __user *)buf;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
+	u32 ibox_data;
 	ssize_t count;
 
 	if (len < 4)
@@ -710,7 +700,7 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 
 	/* wait only for the first element */
 	count = 0;
-	if (file->f_flags & O_NONBLOCK) {
+	if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 		if (!spu_ibox_read(ctx, &ibox_data)) {
 			count = -EAGAIN;
 			goto out_unlock;
@@ -722,11 +712,11 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 	}
 
 	/* if we can't write at all, return -EFAULT */
-	count = put_user(ibox_data, udata);
+	count = put_iter(ibox_data, to);
 	if (count)
 		goto out_unlock;
 
-	for (count = 4, udata++; (count + 4) <= len; count += 4, udata++) {
+	for (count = 4; (count + 4) <= len; count += 4) {
 		int ret;
 		ret = ctx->ops->ibox_read(ctx, &ibox_data);
 		if (ret == 0)
@@ -736,7 +726,7 @@ static ssize_t spufs_ibox_read(struct file *file, char __user *buf,
 		 * but still need to return the data we have
 		 * read successfully so far.
 		 */
-		ret = put_user(ibox_data, udata);
+		ret = put_iter(ibox_data, to);
 		if (ret)
 			break;
 	}
@@ -767,15 +757,15 @@ static __poll_t spufs_ibox_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations spufs_ibox_fops = {
 	.open	= spufs_pipe_open,
-	.read	= spufs_ibox_read,
+	.read_iter = spufs_ibox_read,
 	.poll	= spufs_ibox_poll,
 	.llseek = no_llseek,
 };
 
-static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
-			size_t len, loff_t *pos)
+static ssize_t spufs_ibox_stat_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	ssize_t ret;
 	u32 ibox_stat;
 
@@ -788,7 +778,7 @@ static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
 	ibox_stat = (ctx->ops->mbox_stat_read(ctx) >> 16) & 0xff;
 	spu_release(ctx);
 
-	if (copy_to_user(buf, &ibox_stat, sizeof ibox_stat))
+	if (!copy_to_iter_full(&ibox_stat, sizeof ibox_stat, to))
 		return -EFAULT;
 
 	return 4;
@@ -796,7 +786,7 @@ static ssize_t spufs_ibox_stat_read(struct file *file, char __user *buf,
 
 static const struct file_operations spufs_ibox_stat_fops = {
 	.open	= spufs_pipe_open,
-	.read	= spufs_ibox_stat_read,
+	.read_iter = spufs_ibox_stat_read,
 	.llseek = no_llseek,
 };
 
@@ -827,17 +817,17 @@ void spufs_wbox_callback(struct spu *spu)
  * space is available, but return when we have been able to
  * write something.
  */
-static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
-			size_t len, loff_t *pos)
+static ssize_t spufs_wbox_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct spu_context *ctx = file->private_data;
-	u32 wbox_data, __user *udata = (void __user *)buf;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
+	u32 wbox_data;
 	ssize_t count;
 
 	if (len < 4)
 		return -EINVAL;
 
-	if (get_user(wbox_data, udata))
+	if (get_iter(wbox_data, from))
 		return -EFAULT;
 
 	count = spu_acquire(ctx);
@@ -849,7 +839,7 @@ static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 	 * in case of !O_NONBLOCK
 	 */
 	count = 0;
-	if (file->f_flags & O_NONBLOCK) {
+	if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 		if (!spu_wbox_write(ctx, wbox_data)) {
 			count = -EAGAIN;
 			goto out_unlock;
@@ -862,9 +852,9 @@ static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
 
 
 	/* write as much as possible */
-	for (count = 4, udata++; (count + 4) <= len; count += 4, udata++) {
+	for (count = 4; (count + 4) <= len; count += 4) {
 		int ret;
-		ret = get_user(wbox_data, udata);
+		ret = get_iter(wbox_data, from);
 		if (ret)
 			break;
 
@@ -899,15 +889,15 @@ static __poll_t spufs_wbox_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations spufs_wbox_fops = {
 	.open	= spufs_pipe_open,
-	.write	= spufs_wbox_write,
+	.write_iter = spufs_wbox_write,
 	.poll	= spufs_wbox_poll,
 	.llseek = no_llseek,
 };
 
-static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
-			size_t len, loff_t *pos)
+static ssize_t spufs_wbox_stat_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	ssize_t ret;
 	u32 wbox_stat;
 
@@ -920,7 +910,7 @@ static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
 	wbox_stat = (ctx->ops->mbox_stat_read(ctx) >> 8) & 0xff;
 	spu_release(ctx);
 
-	if (copy_to_user(buf, &wbox_stat, sizeof wbox_stat))
+	if (!copy_to_iter_full(&wbox_stat, sizeof wbox_stat, to))
 		return -EFAULT;
 
 	return 4;
@@ -928,7 +918,7 @@ static ssize_t spufs_wbox_stat_read(struct file *file, char __user *buf,
 
 static const struct file_operations spufs_wbox_stat_fops = {
 	.open	= spufs_pipe_open,
-	.read	= spufs_wbox_stat_read,
+	.read_iter = spufs_wbox_stat_read,
 	.llseek = no_llseek,
 };
 
@@ -994,6 +984,7 @@ static ssize_t spufs_signal1_read(struct file *file, char __user *buf,
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(spufs_signal1_read);
 
 static ssize_t spufs_signal1_write(struct file *file, const char __user *buf,
 			size_t len, loff_t *pos)
@@ -1018,6 +1009,7 @@ static ssize_t spufs_signal1_write(struct file *file, const char __user *buf,
 
 	return 4;
 }
+FOPS_WRITE_ITER_HELPER(spufs_signal1_write);
 
 static vm_fault_t
 spufs_signal1_mmap_fault(struct vm_fault *vmf)
@@ -1053,8 +1045,8 @@ static int spufs_signal1_mmap(struct file *file, struct vm_area_struct *vma)
 static const struct file_operations spufs_signal1_fops = {
 	.open = spufs_signal1_open,
 	.release = spufs_signal1_release,
-	.read = spufs_signal1_read,
-	.write = spufs_signal1_write,
+	.read_iter = spufs_signal1_read_iter,
+	.write_iter = spufs_signal1_write_iter,
 	.mmap = spufs_signal1_mmap,
 	.llseek = no_llseek,
 };
@@ -1062,7 +1054,7 @@ static const struct file_operations spufs_signal1_fops = {
 static const struct file_operations spufs_signal1_nosched_fops = {
 	.open = spufs_signal1_open,
 	.release = spufs_signal1_release,
-	.write = spufs_signal1_write,
+	.write_iter = spufs_signal1_write_iter,
 	.mmap = spufs_signal1_mmap,
 	.llseek = no_llseek,
 };
@@ -1102,29 +1094,28 @@ static ssize_t spufs_signal2_dump(struct spu_context *ctx,
 			       sizeof(ctx->csa.spu_chnldata_RW[4]));
 }
 
-static ssize_t __spufs_signal2_read(struct spu_context *ctx, char __user *buf,
-			size_t len)
+static ssize_t __spufs_signal2_read(struct spu_context *ctx, struct iov_iter *to)
 {
+	size_t len = iov_iter_count(to);
 	if (len < sizeof(ctx->csa.spu_chnldata_RW[4]))
 		return -EINVAL;
 	if (!ctx->csa.spu_chnlcnt_RW[4])
 		return 0;
-	if (copy_to_user(buf, &ctx->csa.spu_chnldata_RW[4],
-			 sizeof(ctx->csa.spu_chnldata_RW[4])))
+	if (!copy_to_iter_full(&ctx->csa.spu_chnldata_RW[4],
+			 sizeof(ctx->csa.spu_chnldata_RW[4]), to))
 		return -EFAULT;
 	return sizeof(ctx->csa.spu_chnldata_RW[4]);
 }
 
-static ssize_t spufs_signal2_read(struct file *file, char __user *buf,
-			size_t len, loff_t *pos)
+static ssize_t spufs_signal2_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 	int ret;
 
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
-	ret = __spufs_signal2_read(ctx, buf, len);
+	ret = __spufs_signal2_read(ctx, to);
 	spu_release_saved(ctx);
 
 	return ret;
@@ -1153,6 +1144,7 @@ static ssize_t spufs_signal2_write(struct file *file, const char __user *buf,
 
 	return 4;
 }
+FOPS_WRITE_ITER_HELPER(spufs_signal2_write);
 
 #if SPUFS_MMAP_4K
 static vm_fault_t
@@ -1192,8 +1184,8 @@ static int spufs_signal2_mmap(struct file *file, struct vm_area_struct *vma)
 static const struct file_operations spufs_signal2_fops = {
 	.open = spufs_signal2_open,
 	.release = spufs_signal2_release,
-	.read = spufs_signal2_read,
-	.write = spufs_signal2_write,
+	.read_iter = spufs_signal2_read,
+	.write_iter = spufs_signal2_write_iter,
 	.mmap = spufs_signal2_mmap,
 	.llseek = no_llseek,
 };
@@ -1201,7 +1193,7 @@ static const struct file_operations spufs_signal2_fops = {
 static const struct file_operations spufs_signal2_nosched_fops = {
 	.open = spufs_signal2_open,
 	.release = spufs_signal2_release,
-	.write = spufs_signal2_write,
+	.write_iter = spufs_signal2_write_iter,
 	.mmap = spufs_signal2_mmap,
 	.llseek = no_llseek,
 };
@@ -1491,10 +1483,10 @@ static int spufs_read_mfc_tagstatus(struct spu_context *ctx, u32 *status)
 	return 0;
 }
 
-static ssize_t spufs_mfc_read(struct file *file, char __user *buffer,
-			size_t size, loff_t *pos)
+static ssize_t spufs_mfc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(to);
 	int ret = -EINVAL;
 	u32 status;
 
@@ -1506,7 +1498,7 @@ static ssize_t spufs_mfc_read(struct file *file, char __user *buffer,
 		return ret;
 
 	ret = -EINVAL;
-	if (file->f_flags & O_NONBLOCK) {
+	if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 		status = ctx->ops->read_mfc_tagstatus(ctx);
 		if (!(status & ctx->tagwait))
 			ret = -EAGAIN;
@@ -1522,7 +1514,7 @@ static ssize_t spufs_mfc_read(struct file *file, char __user *buffer,
 	spu_release(ctx);
 
 	ret = 4;
-	if (copy_to_user(buffer, &status, 4))
+	if (!copy_to_iter_full(&status, 4, to))
 		ret = -EFAULT;
 
 out:
@@ -1617,10 +1609,10 @@ static int spu_send_mfc_command(struct spu_context *ctx,
 	return 1;
 }
 
-static ssize_t spufs_mfc_write(struct file *file, const char __user *buffer,
-			size_t size, loff_t *pos)
+static ssize_t spufs_mfc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	struct mfc_dma_command cmd;
 	int ret = -EINVAL;
 
@@ -1628,7 +1620,7 @@ static ssize_t spufs_mfc_write(struct file *file, const char __user *buffer,
 		goto out;
 
 	ret = -EFAULT;
-	if (copy_from_user(&cmd, buffer, sizeof cmd))
+	if (!copy_from_iter_full(&cmd, sizeof cmd, from))
 		goto out;
 
 	ret = spufs_check_valid_dma(&cmd);
@@ -1643,7 +1635,7 @@ static ssize_t spufs_mfc_write(struct file *file, const char __user *buffer,
 	if (ret)
 		goto out;
 
-	if (file->f_flags & O_NONBLOCK) {
+	if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 		ret = ctx->ops->send_mfc_command(ctx, &cmd);
 	} else {
 		int status;
@@ -1738,8 +1730,8 @@ static int spufs_mfc_fsync(struct file *file, loff_t start, loff_t end, int data
 static const struct file_operations spufs_mfc_fops = {
 	.open	 = spufs_mfc_open,
 	.release = spufs_mfc_release,
-	.read	 = spufs_mfc_read,
-	.write	 = spufs_mfc_write,
+	.read_iter = spufs_mfc_read,
+	.write_iter = spufs_mfc_write,
 	.poll	 = spufs_mfc_poll,
 	.flush	 = spufs_mfc_flush,
 	.fsync	 = spufs_mfc_fsync,
@@ -1943,7 +1935,7 @@ static int spufs_caps_open(struct inode *inode, struct file *file)
 
 static const struct file_operations spufs_caps_fops = {
 	.open		= spufs_caps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -1957,10 +1949,9 @@ static ssize_t spufs_mbox_info_dump(struct spu_context *ctx,
 			       sizeof(ctx->csa.prob.pu_mb_R));
 }
 
-static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
-				   size_t len, loff_t *pos)
+static ssize_t spufs_mbox_info_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 	u32 stat, data;
 	int ret;
 
@@ -1977,12 +1968,12 @@ static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
 	if (!(stat & 0x0000ff))
 		return 0;
 
-	return simple_read_from_buffer(buf, len, pos, &data, sizeof(data));
+	return simple_copy_to_iter(&data, &iocb->ki_pos, sizeof(data), to);
 }
 
 static const struct file_operations spufs_mbox_info_fops = {
 	.open = spufs_info_open,
-	.read = spufs_mbox_info_read,
+	.read_iter = spufs_mbox_info_read,
 	.llseek  = generic_file_llseek,
 };
 
@@ -1995,10 +1986,9 @@ static ssize_t spufs_ibox_info_dump(struct spu_context *ctx,
 			       sizeof(ctx->csa.priv2.puint_mb_R));
 }
 
-static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
-				   size_t len, loff_t *pos)
+static ssize_t spufs_ibox_info_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 	u32 stat, data;
 	int ret;
 
@@ -2015,12 +2005,12 @@ static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
 	if (!(stat & 0xff0000))
 		return 0;
 
-	return simple_read_from_buffer(buf, len, pos, &data, sizeof(data));
+	return simple_copy_to_iter(&data, &iocb->ki_pos, sizeof(data), to);
 }
 
 static const struct file_operations spufs_ibox_info_fops = {
 	.open = spufs_info_open,
-	.read = spufs_ibox_info_read,
+	.read_iter = spufs_ibox_info_read,
 	.llseek  = generic_file_llseek,
 };
 
@@ -2036,10 +2026,9 @@ static ssize_t spufs_wbox_info_dump(struct spu_context *ctx,
 			spufs_wbox_info_cnt(ctx));
 }
 
-static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
-				   size_t len, loff_t *pos)
+static ssize_t spufs_wbox_info_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 	u32 data[ARRAY_SIZE(ctx->csa.spu_mailbox_data)];
 	int ret, count;
 
@@ -2052,13 +2041,12 @@ static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
-	return simple_read_from_buffer(buf, len, pos, &data,
-				count * sizeof(u32));
+	return simple_copy_to_iter(&data, &iocb->ki_pos, count * sizeof(u32), to);
 }
 
 static const struct file_operations spufs_wbox_info_fops = {
 	.open = spufs_info_open,
-	.read = spufs_wbox_info_read,
+	.read_iter = spufs_wbox_info_read,
 	.llseek  = generic_file_llseek,
 };
 
@@ -2092,10 +2080,9 @@ static ssize_t spufs_dma_info_dump(struct spu_context *ctx,
 	return spufs_dump_emit(cprm, &info, sizeof(info));
 }
 
-static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
-			      size_t len, loff_t *pos)
+static ssize_t spufs_dma_info_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
 	struct spu_dma_info info;
 	int ret;
 
@@ -2107,13 +2094,12 @@ static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
-	return simple_read_from_buffer(buf, len, pos, &info,
-				sizeof(info));
+	return simple_copy_to_iter(&info, &iocb->ki_pos, sizeof(info), to);
 }
 
 static const struct file_operations spufs_dma_info_fops = {
 	.open = spufs_info_open,
-	.read = spufs_dma_info_read,
+	.read_iter = spufs_dma_info_read,
 	.llseek = no_llseek,
 };
 
@@ -2146,10 +2132,10 @@ static ssize_t spufs_proxydma_info_dump(struct spu_context *ctx,
 	return spufs_dump_emit(cprm, &info, sizeof(info));
 }
 
-static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
-				   size_t len, loff_t *pos)
+static ssize_t spufs_proxydma_info_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct spu_context *ctx = file->private_data;
+	struct spu_context *ctx = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	struct spu_proxydma_info info;
 	int ret;
 
@@ -2164,13 +2150,12 @@ static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
-	return simple_read_from_buffer(buf, len, pos, &info,
-				sizeof(info));
+	return simple_copy_to_iter(&info, &iocb->ki_pos, sizeof(info), to);
 }
 
 static const struct file_operations spufs_proxydma_info_fops = {
 	.open = spufs_info_open,
-	.read = spufs_proxydma_info_read,
+	.read_iter = spufs_proxydma_info_read,
 	.llseek = no_llseek,
 };
 
@@ -2189,7 +2174,7 @@ static int spufs_tid_open(struct inode *inode, struct file *file)
 
 static const struct file_operations spufs_tid_fops = {
 	.open		= spufs_tid_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -2279,7 +2264,7 @@ static int spufs_stat_open(struct inode *inode, struct file *file)
 
 static const struct file_operations spufs_stat_fops = {
 	.open		= spufs_stat_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -2357,16 +2342,13 @@ static int switch_log_sprint(struct spu_context *ctx, char *tbuf, int n)
 			(unsigned long long) p->timebase);
 }
 
-static ssize_t spufs_switch_log_read(struct file *file, char __user *buf,
-			     size_t len, loff_t *ppos)
+static ssize_t spufs_switch_log_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
 	struct spu_context *ctx = SPUFS_I(inode)->i_ctx;
+	size_t len = iov_iter_count(to);
 	int error = 0, cnt = 0;
 
-	if (!buf)
-		return -EINVAL;
-
 	error = spu_acquire(ctx);
 	if (error)
 		return error;
@@ -2381,7 +2363,7 @@ static ssize_t spufs_switch_log_read(struct file *file, char __user *buf,
 				 * just return straight away */
 				break;
 
-			} else if (file->f_flags & O_NONBLOCK) {
+			} else if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 				error = -EAGAIN;
 				break;
 
@@ -2417,7 +2399,7 @@ static ssize_t spufs_switch_log_read(struct file *file, char __user *buf,
 			 * partial buffer (so far) */
 			break;
 
-		error = copy_to_user(buf + cnt, tbuf, width);
+		error = !copy_to_iter_full(tbuf, width, to);
 		if (error)
 			break;
 		cnt += width;
@@ -2451,7 +2433,7 @@ static __poll_t spufs_switch_log_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations spufs_switch_log_fops = {
 	.open		= spufs_switch_log_open,
-	.read		= spufs_switch_log_read,
+	.read_iter	= spufs_switch_log_read,
 	.poll		= spufs_switch_log_poll,
 	.release	= spufs_switch_log_release,
 	.llseek		= no_llseek,
@@ -2532,7 +2514,7 @@ static int spufs_ctx_open(struct inode *inode, struct file *file)
 
 static const struct file_operations spufs_ctx_fops = {
 	.open           = spufs_ctx_open,
-	.read           = seq_read,
+	.read_iter      = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = single_release,
 };
-- 
2.43.0


