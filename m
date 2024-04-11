Return-Path: <linux-kernel+bounces-141155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A9A8A1ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222DC1C22B20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50B1F142F;
	Thu, 11 Apr 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eR+UPjrn"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E573D1F1401
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850130; cv=none; b=Vf3Q9lQAj+mgkNSVm/0gmg4KnQkNWqaRsTvHpMfl/9kPHa41DvnfXUt/MZFXL9bidiYi3qHqX8bEi0LrtXSV08I7ViWoG7KE7MzVP7N97e/UqAOTb15squ8AVPgrjs9onlzu1xxwGx07EPReacolxmLdRsWMRXtMRUovsx07YDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850130; c=relaxed/simple;
	bh=RwBcVN+jLnnMiQ0jfv/xxaYBhfaMYpfLQ1DcZtpGx/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAi4khDCCDJKAPxZAaxDVW8XlY5KBtoLBwlc0tSxEeG7Dbqfbpp48K+jYnLRJXBL4ZiHiQAvxYeBJY2+IR1EmD4CJCExXaRvZhE/Jlg/uiyKTWT5ftiLBYIx3VAmQkNqqaqIEboINv1DAjEPAtW8rKNwbbyUIntKXEYySnYZPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eR+UPjrn; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58252439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850128; x=1713454928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJ5Xr4lI2duetN729tRqNo0//AAlpg+2cueAQi+m1X4=;
        b=eR+UPjrnxvxY2FPu/j7tYGMLXx7H7lBAnIAw738PrwDm3ZIKX7GDP7XUEhvDmsDtwv
         Y912JhUjWN92lBJRVPA8nlM/7K1oGwWasAbT3CQ3BwByE41X4k6xEHcCvQk5MrmJsEVM
         MBAPJLnSVA4n3GGRaeF4H+MvFwV17jVDKZp3y3aNDIU3zpo69xJclZ/TFq/4kVps3lWK
         YwpPGoJ5KigVOw8FCiZvuE1QanMvTEY+Bm4i+EUZJInfEjEagTRofOxouzPZLd4EB/0U
         TvshxXNk9jNKdRUEkYW8vYuoNtRat9+YjURPEv6bLTfcqtvOw6ikTO6rsLwi8wzJ3SFh
         d05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850128; x=1713454928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJ5Xr4lI2duetN729tRqNo0//AAlpg+2cueAQi+m1X4=;
        b=XRHsxKKuTiPujf9baFFH1K5kyOb9cOaQIAzMa9BysebT70QOD/PTM9oCcaYXVHB8dl
         Q7s06PBa9ZsERDarlWPf18WXwSpmoN7/rvoY2uEeGx5JSGtLHvUUAaU/bNXy+qccklwJ
         fQea3FRJIb2Ts7wSN547Mz0mqbzd0PfFhkSdv/zfhPI7BhuC1HH/eNYqX/lV7H1fnDNu
         WSRMQEW0qLfq1U1M5f26e+m9MSIWOpJ1dWlDI6V0KtLKrXIhXgseDOiFhXI1qHoAk8Dl
         DBEq8zbXzm9Zl9EUvw75gerKB9wuRGyOJuOK8bapLTOZWZIR9WrPodXj8tjDPPaa8vH/
         CoIw==
X-Gm-Message-State: AOJu0YzSgehQO9ZQFBSM4wxgtjw1sQzxleeekPs1PGiifIPNj5VOgAWi
	ypYTBpn/fsbjiKqA196HdLCLxXI6eBAU0AKlkLnXPUFbmfjhrc4/U9DdiVPd5Tre9FvunhEq5Ve
	L
X-Google-Smtp-Source: AGHT+IE0mhrZ+63rxn3HEqhWZLKYrB5Z8OIvbWyufqtZkUKVdnpV+6MHV9/MRsSCHjB4lWbhbZRIlg==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr203359iov.2.1712850127823;
        Thu, 11 Apr 2024 08:42:07 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 373/437] drivers/remoteproc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:33 -0600
Message-ID: <20240411153126.16201-374-axboe@kernel.dk>
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
 drivers/remoteproc/remoteproc_cdev.c    |  9 ++--
 drivers/remoteproc/remoteproc_debugfs.c | 68 +++++++++++--------------
 2 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 687f205fd70a..c36a0fa6c991 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -18,16 +18,17 @@
 #define NUM_RPROC_DEVICES	64
 static dev_t rproc_major;
 
-static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_t len, loff_t *pos)
+static ssize_t rproc_cdev_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct rproc *rproc = container_of(filp->f_inode->i_cdev, struct rproc, cdev);
+	struct rproc *rproc = container_of(iocb->ki_filp->f_inode->i_cdev, struct rproc, cdev);
+	size_t len = iov_iter_count(from);
 	int ret = 0;
 	char cmd[10];
 
 	if (!len || len > sizeof(cmd))
 		return -EINVAL;
 
-	ret = copy_from_user(cmd, buf, len);
+	ret = !copy_from_iter_full(cmd, len, from);
 	if (ret)
 		return -EFAULT;
 
@@ -89,7 +90,7 @@ static int rproc_cdev_release(struct inode *inode, struct file *filp)
 }
 
 static const struct file_operations rproc_fops = {
-	.write = rproc_cdev_write,
+	.write_iter = rproc_cdev_write,
 	.unlocked_ioctl = rproc_device_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.release = rproc_cdev_release,
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index b86c1d09c70c..dd5900143475 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -39,17 +39,16 @@ static const char * const rproc_coredump_str[] = {
 };
 
 /* Expose the current coredump configuration via debugfs */
-static ssize_t rproc_coredump_read(struct file *filp, char __user *userbuf,
-				   size_t count, loff_t *ppos)
+static ssize_t rproc_coredump_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rproc *rproc = filp->private_data;
+	struct rproc *rproc = iocb->ki_filp->private_data;
 	char buf[20];
 	int len;
 
 	len = scnprintf(buf, sizeof(buf), "%s\n",
 			rproc_coredump_str[rproc->dump_conf]);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 /*
@@ -68,18 +67,17 @@ static ssize_t rproc_coredump_read(struct file *filp, char __user *userbuf,
  *		recovery process will have to wait until data is read by
  *		userspace. But this avoid usage of extra memory.
  */
-static ssize_t rproc_coredump_write(struct file *filp,
-				    const char __user *user_buf, size_t count,
-				    loff_t *ppos)
+static ssize_t rproc_coredump_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct rproc *rproc = filp->private_data;
+	struct rproc *rproc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret, err = 0;
 	char buf[20];
 
 	if (count < 1 || count > sizeof(buf))
 		return -EINVAL;
 
-	ret = copy_from_user(buf, user_buf, count);
+	ret = !copy_from_iter_full(buf, count, from);
 	if (ret)
 		return -EFAULT;
 
@@ -108,8 +106,8 @@ static ssize_t rproc_coredump_write(struct file *filp,
 }
 
 static const struct file_operations rproc_coredump_fops = {
-	.read = rproc_coredump_read,
-	.write = rproc_coredump_write,
+	.read_iter = rproc_coredump_read,
+	.write_iter = rproc_coredump_write,
 	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
@@ -123,10 +121,9 @@ static const struct file_operations rproc_coredump_fops = {
  * but this kind of lightweight and simple mechanism is always good to have,
  * as it provides very early tracing with little to no dependencies at all.
  */
-static ssize_t rproc_trace_read(struct file *filp, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t rproc_trace_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rproc_debug_trace *data = filp->private_data;
+	struct rproc_debug_trace *data = iocb->ki_filp->private_data;
 	struct rproc_mem_entry *trace = &data->trace_mem;
 	void *va;
 	char buf[100];
@@ -142,43 +139,41 @@ static ssize_t rproc_trace_read(struct file *filp, char __user *userbuf,
 		len = strnlen(va, trace->len);
 	}
 
-	return simple_read_from_buffer(userbuf, count, ppos, va, len);
+	return simple_copy_to_iter(va, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations trace_rproc_ops = {
-	.read = rproc_trace_read,
+	.read_iter = rproc_trace_read,
 	.open = simple_open,
 	.llseek	= generic_file_llseek,
 };
 
 /* expose the name of the remote processor via debugfs */
-static ssize_t rproc_name_read(struct file *filp, char __user *userbuf,
-			       size_t count, loff_t *ppos)
+static ssize_t rproc_name_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rproc *rproc = filp->private_data;
+	struct rproc *rproc = iocb->ki_filp->private_data;
 	/* need room for the name, a newline and a terminating null */
 	char buf[100];
 	int i;
 
 	i = scnprintf(buf, sizeof(buf), "%.98s\n", rproc->name);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, i);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, i, to);
 }
 
 static const struct file_operations rproc_name_ops = {
-	.read = rproc_name_read,
+	.read_iter = rproc_name_read,
 	.open = simple_open,
 	.llseek	= generic_file_llseek,
 };
 
 /* expose recovery flag via debugfs */
-static ssize_t rproc_recovery_read(struct file *filp, char __user *userbuf,
-				   size_t count, loff_t *ppos)
+static ssize_t rproc_recovery_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rproc *rproc = filp->private_data;
+	struct rproc *rproc = iocb->ki_filp->private_data;
 	char *buf = rproc->recovery_disabled ? "disabled\n" : "enabled\n";
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
+	return simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 }
 
 /*
@@ -206,17 +201,17 @@ static ssize_t rproc_recovery_read(struct file *filp, char __user *userbuf,
  *		instead use the "recover" command as needed.
  */
 static ssize_t
-rproc_recovery_write(struct file *filp, const char __user *user_buf,
-		     size_t count, loff_t *ppos)
+rproc_recovery_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct rproc *rproc = filp->private_data;
+	struct rproc *rproc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[10];
 	int ret;
 
 	if (count < 1 || count > sizeof(buf))
 		return -EINVAL;
 
-	ret = copy_from_user(buf, user_buf, count);
+	ret = !copy_from_iter_full(buf, count, from);
 	if (ret)
 		return -EFAULT;
 
@@ -241,22 +236,21 @@ rproc_recovery_write(struct file *filp, const char __user *user_buf,
 }
 
 static const struct file_operations rproc_recovery_ops = {
-	.read = rproc_recovery_read,
-	.write = rproc_recovery_write,
+	.read_iter = rproc_recovery_read,
+	.write_iter = rproc_recovery_write,
 	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
 
 /* expose the crash trigger via debugfs */
-static ssize_t
-rproc_crash_write(struct file *filp, const char __user *user_buf,
-		  size_t count, loff_t *ppos)
+static ssize_t rproc_crash_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct rproc *rproc = filp->private_data;
+	struct rproc *rproc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned int type;
 	int ret;
 
-	ret = kstrtouint_from_user(user_buf, count, 0, &type);
+	ret = kstrtouint_from_iter(from, count, 0, &type);
 	if (ret < 0)
 		return ret;
 
@@ -266,7 +260,7 @@ rproc_crash_write(struct file *filp, const char __user *user_buf,
 }
 
 static const struct file_operations rproc_crash_ops = {
-	.write = rproc_crash_write,
+	.write_iter = rproc_crash_write,
 	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
-- 
2.43.0


