Return-Path: <linux-kernel+bounces-140860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545F8A193A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEF81C2178F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7813A255;
	Thu, 11 Apr 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0cr9gBoI"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356F13959C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849669; cv=none; b=A9CEjG+gbt86+ukMI4/vNF1eP/hz1C597cQhVAJ7pjSxIW3v4e8yWqosiaiqDHH0bx7rR63PQqfgd4p0hvNla5t70uKbzMWfFdmvu0qnYirBCEyl4saJrtdjBjRgD8Pj3pa8+XlXumyvRQ6DOF7816r3ILLSs9AEnNTi/IeGAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849669; c=relaxed/simple;
	bh=iuIbXnuLBLxEnmsPlq5L3vYBovGCP0mETk1nTzZWaYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WajWDL5jxLfL9wRhCLdV8swTsW8XNhHSC1AUtsEB228dyN+DMDQmF4+H7GWHUokBPjqKxWKujktaAUpOMpgohdiUyzQ4vWYKx4gK5TjyBaJyLJcikmSrDfg0uLHyjpRqqO5Ff8py2RZ3cpfJm+CL3EKUaWPYCjn4F0m8KvMZ0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0cr9gBoI; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso81841839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849666; x=1713454466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60Z5LyJVD/i6pC/+p1lDBPcD69xpIdoPuegUMJnJm8Q=;
        b=0cr9gBoIfcYkCk5m8rZybg75SaxefPshXhPQEC+AuW+VATbHs5E875kD87em/7duSf
         Ow1zun8xgIDtSeX5W9TzHaeFyjdSp7UM0u4LuEwxMOu3EJ3UWG+m1oi3Y2k50rrT4Njy
         Oier6CrkEY5jxsj8X1FWR/WDceP7Jr8Hdx65d2LSTxbkf0rruXsuqE15mfMlKwwu9dgq
         Urv7sqEQnYJGXgbf9lsnw4+U3fM7uE9dEFl66g8CAdrHCfBcntp5YVV494xwVOCGIJwL
         rwrgsm3AACVCzq5bOt4nyD2/BJdfUvv9UM3Uz1m76VkjZgQIOKmf/RcZ0xvkFYLx7wd0
         PSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849666; x=1713454466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60Z5LyJVD/i6pC/+p1lDBPcD69xpIdoPuegUMJnJm8Q=;
        b=GBSQwDJftZH6+NGzzU95Mxg1XoSXWh0q/6ajjI2Hc0cVA0YYEauw5c7FA4SQtYyR0p
         8AFIp9cu9oFx8lDTm1wpy55rhxZyEYf4RWUYcOWIqo/ex3FzyxZ46oIeQMduMPUabQ/X
         HyIyMs8ezTzSLpsZmwgjoiX/QCXhBHsWQuhfHgWq8mx3gwCnOtQ1Z90Uqc8vLtXxGeVi
         IBf5RC783AM/HvRXkXVxeLZnoE2y/Zr7bVdvMk2Lec2XWqBAL+sQ3SUajzBbl5jC9HKc
         afGgxBFIGXMZsSHoRX5SsgGsv99m1Kcwlo1m1bKyyqaXFpDbkqznHd430whzd325fjzU
         qIiw==
X-Gm-Message-State: AOJu0YyiHwpIPxJmG1pOHa6NjFQ3aaXHoXaYjo9Mk59nVU2zMV3L4U4M
	GiyeZqOu5uga8qOYpfCCXDFlT5U/ia31hV0IsQI0WXyjKJp0NKE/opHNU+0tBLdvi8twLvh1FdR
	V
X-Google-Smtp-Source: AGHT+IHYg8m+GZSAs1iUrmaXdBM1taYVW0gjbOLEdpHyYY5ysBdf1Bh3q+HlIg5pfBtgexd2qMF97Q==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr184245iob.0.1712849665901;
        Thu, 11 Apr 2024 08:34:25 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 096/437] mm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:56 -0600
Message-ID: <20240411153126.16201-97-axboe@kernel.dk>
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
 mm/damon/dbgfs.c    | 84 ++++++++++++++++++++++++---------------------
 mm/huge_memory.c    | 10 +++---
 mm/kmemleak.c       |  5 +--
 mm/page_owner.c     |  5 +--
 mm/shrinker_debug.c | 12 +++----
 mm/slub.c           |  2 +-
 mm/vmscan.c         | 14 ++++----
 7 files changed, 69 insertions(+), 63 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 2461cfe2e968..1ee9d28ded80 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -56,10 +56,9 @@ static char *user_input_str(const char __user *buf, size_t count, loff_t *ppos)
 	return kbuf;
 }
 
-static ssize_t dbgfs_attrs_read(struct file *file,
-		char __user *buf, size_t count, loff_t *ppos)
+static ssize_t dbgfs_attrs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct damon_ctx *ctx = file->private_data;
+	struct damon_ctx *ctx = iocb->ki_filp->private_data;
 	char kbuf[128];
 	int ret;
 
@@ -70,7 +69,7 @@ static ssize_t dbgfs_attrs_read(struct file *file,
 			ctx->attrs.min_nr_regions, ctx->attrs.max_nr_regions);
 	mutex_unlock(&ctx->kdamond_lock);
 
-	return simple_read_from_buffer(buf, count, ppos, kbuf, ret);
+	return simple_copy_to_iter(kbuf, &iocb->ki_pos, ret, to);
 }
 
 static ssize_t dbgfs_attrs_write(struct file *file,
@@ -109,6 +108,7 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 	kfree(kbuf);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(dbgfs_attrs_write);
 
 /*
  * Return corresponding dbgfs' scheme action value (int) for the given
@@ -169,10 +169,10 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 	return written;
 }
 
-static ssize_t dbgfs_schemes_read(struct file *file, char __user *buf,
-		size_t count, loff_t *ppos)
+static ssize_t dbgfs_schemes_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct damon_ctx *ctx = file->private_data;
+	struct damon_ctx *ctx = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	char *kbuf;
 	ssize_t len;
 
@@ -185,7 +185,7 @@ static ssize_t dbgfs_schemes_read(struct file *file, char __user *buf,
 	mutex_unlock(&ctx->kdamond_lock);
 	if (len < 0)
 		goto out;
-	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
+	len = simple_copy_to_iter(kbuf, &iocb->ki_pos, len, to);
 
 out:
 	kfree(kbuf);
@@ -329,6 +329,7 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 	kfree(kbuf);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(dbgfs_schemes_write);
 
 static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
 {
@@ -356,10 +357,9 @@ static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
 	return written;
 }
 
-static ssize_t dbgfs_target_ids_read(struct file *file,
-		char __user *buf, size_t count, loff_t *ppos)
+static ssize_t dbgfs_target_ids_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct damon_ctx *ctx = file->private_data;
+	struct damon_ctx *ctx = iocb->ki_filp->private_data;
 	ssize_t len;
 	char ids_buf[320];
 
@@ -369,7 +369,7 @@ static ssize_t dbgfs_target_ids_read(struct file *file,
 	if (len < 0)
 		return len;
 
-	return simple_read_from_buffer(buf, count, ppos, ids_buf, len);
+	return simple_copy_to_iter(ids_buf, &iocb->ki_pos, len, to);
 }
 
 /*
@@ -548,6 +548,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	kfree(kbuf);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(dbgfs_target_ids_write);
 
 static ssize_t sprint_init_regions(struct damon_ctx *c, char *buf, ssize_t len)
 {
@@ -571,10 +572,10 @@ static ssize_t sprint_init_regions(struct damon_ctx *c, char *buf, ssize_t len)
 	return written;
 }
 
-static ssize_t dbgfs_init_regions_read(struct file *file, char __user *buf,
-		size_t count, loff_t *ppos)
+static ssize_t dbgfs_init_regions_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct damon_ctx *ctx = file->private_data;
+	struct damon_ctx *ctx = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	char *kbuf;
 	ssize_t len;
 
@@ -593,7 +594,7 @@ static ssize_t dbgfs_init_regions_read(struct file *file, char __user *buf,
 	mutex_unlock(&ctx->kdamond_lock);
 	if (len < 0)
 		goto out;
-	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
+	len = simple_copy_to_iter(kbuf, &iocb->ki_pos, len, to);
 
 out:
 	kfree(kbuf);
@@ -693,11 +694,12 @@ static ssize_t dbgfs_init_regions_write(struct file *file,
 	kfree(kbuf);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(dbgfs_init_regions_write);
 
-static ssize_t dbgfs_kdamond_pid_read(struct file *file,
-		char __user *buf, size_t count, loff_t *ppos)
+static ssize_t dbgfs_kdamond_pid_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct damon_ctx *ctx = file->private_data;
+	struct damon_ctx *ctx = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	char *kbuf;
 	ssize_t len;
 
@@ -713,7 +715,7 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 	mutex_unlock(&ctx->kdamond_lock);
 	if (!len)
 		goto out;
-	len = simple_read_from_buffer(buf, count, ppos, kbuf, len);
+	len = simple_copy_to_iter(kbuf, &iocb->ki_pos, len, to);
 
 out:
 	kfree(kbuf);
@@ -731,31 +733,31 @@ static int damon_dbgfs_open(struct inode *inode, struct file *file)
 
 static const struct file_operations attrs_fops = {
 	.open = damon_dbgfs_open,
-	.read = dbgfs_attrs_read,
-	.write = dbgfs_attrs_write,
+	.read_iter = dbgfs_attrs_read,
+	.write_iter = dbgfs_attrs_write_iter,
 };
 
 static const struct file_operations schemes_fops = {
 	.open = damon_dbgfs_open,
-	.read = dbgfs_schemes_read,
-	.write = dbgfs_schemes_write,
+	.read_iter = dbgfs_schemes_read,
+	.write_iter = dbgfs_schemes_write_iter,
 };
 
 static const struct file_operations target_ids_fops = {
 	.open = damon_dbgfs_open,
-	.read = dbgfs_target_ids_read,
-	.write = dbgfs_target_ids_write,
+	.read_iter = dbgfs_target_ids_read,
+	.write_iter = dbgfs_target_ids_write_iter,
 };
 
 static const struct file_operations init_regions_fops = {
 	.open = damon_dbgfs_open,
-	.read = dbgfs_init_regions_read,
-	.write = dbgfs_init_regions_write,
+	.read_iter = dbgfs_init_regions_read,
+	.write_iter = dbgfs_init_regions_write_iter,
 };
 
 static const struct file_operations kdamond_pid_fops = {
 	.open = damon_dbgfs_open,
-	.read = dbgfs_kdamond_pid_read,
+	.read_iter = dbgfs_kdamond_pid_read,
 };
 
 static void dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
@@ -807,12 +809,12 @@ static void dbgfs_destroy_ctx(struct damon_ctx *ctx)
 	damon_destroy_ctx(ctx);
 }
 
-static ssize_t damon_dbgfs_deprecated_read(struct file *file,
-		char __user *buf, size_t count, loff_t *ppos)
+static ssize_t damon_dbgfs_deprecated_read(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
 	static const char kbuf[512] = DAMON_DBGFS_DEPRECATION_NOTICE;
 
-	return simple_read_from_buffer(buf, count, ppos, kbuf, strlen(kbuf));
+	return simple_copy_to_iter(kbuf, &iocb->ki_pos, strlen(kbuf), to);
 }
 
 /*
@@ -900,6 +902,7 @@ static ssize_t dbgfs_mk_context_write(struct file *file,
 	kfree(ctx_name);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(dbgfs_mk_context_write);
 
 /*
  * Remove a context of @name and its debugfs directory.
@@ -1006,9 +1009,9 @@ static ssize_t dbgfs_rm_context_write(struct file *file,
 	kfree(ctx_name);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(dbgfs_rm_context_write);
 
-static ssize_t dbgfs_monitor_on_read(struct file *file,
-		char __user *buf, size_t count, loff_t *ppos)
+static ssize_t dbgfs_monitor_on_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char monitor_on_buf[5];
 	bool monitor_on = damon_nr_running_ctxs() != 0;
@@ -1016,7 +1019,7 @@ static ssize_t dbgfs_monitor_on_read(struct file *file,
 
 	len = scnprintf(monitor_on_buf, 5, monitor_on ? "on\n" : "off\n");
 
-	return simple_read_from_buffer(buf, count, ppos, monitor_on_buf, len);
+	return simple_copy_to_iter(monitor_on_buf, &iocb->ki_pos, len, to);
 }
 
 static ssize_t dbgfs_monitor_on_write(struct file *file,
@@ -1059,6 +1062,7 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 	kfree(kbuf);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(dbgfs_monitor_on_write);
 
 static int damon_dbgfs_static_file_open(struct inode *inode, struct file *file)
 {
@@ -1067,23 +1071,23 @@ static int damon_dbgfs_static_file_open(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations deprecated_fops = {
-	.read = damon_dbgfs_deprecated_read,
+	.read_iter = damon_dbgfs_deprecated_read,
 };
 
 static const struct file_operations mk_contexts_fops = {
 	.open = damon_dbgfs_static_file_open,
-	.write = dbgfs_mk_context_write,
+	.write_iter = dbgfs_mk_context_write_iter,
 };
 
 static const struct file_operations rm_contexts_fops = {
 	.open = damon_dbgfs_static_file_open,
-	.write = dbgfs_rm_context_write,
+	.write_iter = dbgfs_rm_context_write_iter,
 };
 
 static const struct file_operations monitor_on_fops = {
 	.open = damon_dbgfs_static_file_open,
-	.read = dbgfs_monitor_on_read,
-	.write = dbgfs_monitor_on_write,
+	.read_iter = dbgfs_monitor_on_read,
+	.write_iter = dbgfs_monitor_on_write_iter,
 };
 
 static int __init __damon_dbgfs_init(void)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..989847ed0f92 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3582,8 +3582,7 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 
 #define MAX_INPUT_BUF_SZ 255
 
-static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppops)
+static ssize_t split_huge_pages_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	static DEFINE_MUTEX(split_debug_mutex);
 	ssize_t ret;
@@ -3594,6 +3593,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	char input_buf[MAX_INPUT_BUF_SZ];
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
+	size_t count = iov_iter_count(from);
 	unsigned int new_order = 0;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
@@ -3603,7 +3603,8 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	ret = -EFAULT;
 
 	memset(input_buf, 0, MAX_INPUT_BUF_SZ);
-	if (copy_from_user(input_buf, buf, min_t(size_t, count, MAX_INPUT_BUF_SZ)))
+	if (!copy_from_iter_full(input_buf,
+				 min_t(size_t, count, MAX_INPUT_BUF_SZ), from))
 		goto out;
 
 	input_buf[MAX_INPUT_BUF_SZ - 1] = '\0';
@@ -3651,12 +3652,11 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 out:
 	mutex_unlock(&split_debug_mutex);
 	return ret;
-
 }
 
 static const struct file_operations split_huge_pages_fops = {
 	.owner	 = THIS_MODULE,
-	.write	 = split_huge_pages_write,
+	.write_iter = split_huge_pages_write,
 	.llseek  = no_llseek,
 };
 
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 6a540c2b27c5..3ff7dc613e70 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -2063,12 +2063,13 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
 	*ppos += size;
 	return size;
 }
+FOPS_WRITE_ITER_HELPER(kmemleak_write);
 
 static const struct file_operations kmemleak_fops = {
 	.owner		= THIS_MODULE,
 	.open		= kmemleak_open,
-	.read		= seq_read,
-	.write		= kmemleak_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= kmemleak_write_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d17d1351ec84..ab5cfbc718b4 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -715,6 +715,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 	return 0;
 }
+FOPS_READ_ITER_HELPER(read_page_owner);
 
 static loff_t lseek_page_owner(struct file *file, loff_t offset, int orig)
 {
@@ -822,7 +823,7 @@ static void init_early_allocated_pages(void)
 }
 
 static const struct file_operations proc_page_owner_operations = {
-	.read		= read_page_owner,
+	.read_iter	= read_page_owner_iter,
 	.llseek		= lseek_page_owner,
 };
 
@@ -906,7 +907,7 @@ static int page_owner_stack_open(struct inode *inode, struct file *file)
 
 static const struct file_operations page_owner_stack_operations = {
 	.open		= page_owner_stack_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 12ea5486a3e9..b3b4d5a36dc0 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -101,11 +101,11 @@ static int shrinker_debugfs_scan_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
-static ssize_t shrinker_debugfs_scan_write(struct file *file,
-					   const char __user *buf,
-					   size_t size, loff_t *pos)
+static ssize_t shrinker_debugfs_scan_write(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct shrinker *shrinker = file->private_data;
+	struct shrinker *shrinker = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	unsigned long nr_to_scan = 0, ino, read_len;
 	struct shrink_control sc = {
 		.gfp_mask = GFP_KERNEL,
@@ -115,7 +115,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 	char kbuf[72];
 
 	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
-	if (copy_from_user(kbuf, buf, read_len))
+	if (!copy_from_iter_full(kbuf, read_len, from))
 		return -EFAULT;
 	kbuf[read_len] = '\0';
 
@@ -156,7 +156,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 static const struct file_operations shrinker_debugfs_scan_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = shrinker_debugfs_scan_open,
-	.write	 = shrinker_debugfs_scan_write,
+	.write_iter	 = shrinker_debugfs_scan_write,
 };
 
 int shrinker_debugfs_add(struct shrinker *shrinker)
diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..aff701599b6a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7033,7 +7033,7 @@ static int slab_debug_trace_release(struct inode *inode, struct file *file)
 
 static const struct file_operations slab_debugfs_fops = {
 	.open    = slab_debug_trace_open,
-	.read    = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = slab_debug_trace_release,
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3ef654addd44..bf6e9292aea2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5278,7 +5278,7 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 static int lru_gen_seq_show(struct seq_file *m, void *v)
 {
 	unsigned long seq;
-	bool full = !debugfs_real_fops(m->file)->write;
+	bool full = !debugfs_real_fops(m->file)->write_iter;
 	struct lruvec *lruvec = v;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int nid = lruvec_pgdat(lruvec)->node_id;
@@ -5434,9 +5434,9 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 }
 
 /* see Documentation/admin-guide/mm/multigen_lru.rst for details */
-static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
-				 size_t len, loff_t *pos)
+static ssize_t lru_gen_seq_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	void *buf;
 	char *cur, *next;
 	unsigned int flags;
@@ -5454,7 +5454,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 	if (!buf)
 		return -ENOMEM;
 
-	if (copy_from_user(buf, src, len)) {
+	if (!copy_from_iter_full(buf, len, from)) {
 		kvfree(buf);
 		return -EFAULT;
 	}
@@ -5513,15 +5513,15 @@ static int lru_gen_seq_open(struct inode *inode, struct file *file)
 
 static const struct file_operations lru_gen_rw_fops = {
 	.open = lru_gen_seq_open,
-	.read = seq_read,
-	.write = lru_gen_seq_write,
+	.read_iter = seq_read_iter,
+	.write_iter = lru_gen_seq_write,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
 
 static const struct file_operations lru_gen_ro_fops = {
 	.open = lru_gen_seq_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
-- 
2.43.0


