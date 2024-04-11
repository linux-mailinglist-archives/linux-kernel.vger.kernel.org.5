Return-Path: <linux-kernel+bounces-140805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4CF8A1908
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8B51F21047
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24B41CF96;
	Thu, 11 Apr 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EtYkroqT"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5918A1947D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849579; cv=none; b=BTXITrcC+KEFZ3NWrxrmMFXd8drwUSZ2nHsorik3lSe5d5ONfjgyPS+LO4UIS7mnxvbQzvZFv6kPRzf4bKrLIaABKh9zERlDTge8xH6ZjlbBqFbu7CU+mklzQ3P2oHv09fOJ69mzOgVKyIfzoNInDQZRXZLP8PQU+/KKlHIz8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849579; c=relaxed/simple;
	bh=vLWvb3OacZAY+KRIJJDQM0sH9Lk6qVNcnOSoG9pN4c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vALbFQVVXSg+nrLMwIwb7Ncfjxs2Jev7AbHJfrkpLmJIgiiJcY3AoZ7Ov4MpFbea7hhELEKaLO4fmNsqHxlQzZz6g7mnLzh0EB/BoQoZQE/aQtKDheLfsiUtbJWKihJtAiMk4WqxseeOIKjtAjD6X1S+PeMEGu1h7I0Cd7JRqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EtYkroqT; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8869739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849577; x=1713454377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwWFQP64WW8Ug8E+EQIAUt1wXFgwfIuKhZ2rU+4AJRk=;
        b=EtYkroqTxWSkcEBUtIFdenRthY6oWOOfJCeNnvk9XfGG+rbGgj4I3GSiwlHaXYJ+Dh
         cxJPIfkCSUevbbXMDT83SSiVJ9Rz9i63z85CXJyM+pmNObo4jm0D0bExF47k5SKjEnVd
         rqS0XT/onHEbLGVfoLcoM3ebfkHpzhcxu+C4bt7w90bumV+f9GvjE/ZMMxMP03B+DbhT
         AB3UXEkDyDprJQwiE+7VydKEJhg4wnElw2KiV8eNUPGPfXr+rIy+HhwvgEwKRkcLPAI3
         hjBQ1PxFX9uLdaMd7y/029ap2UDQ9768qcWHPYQHPXHVl8yJGzsHrrvqSxYyQaD2pdHf
         VMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849577; x=1713454377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwWFQP64WW8Ug8E+EQIAUt1wXFgwfIuKhZ2rU+4AJRk=;
        b=lN6HCNmRkskS7e/W0qUBTfwrWrSx46wCjVeG1pccbZvoxa+JunoVthlRmZK98IvP0u
         WhvnEYGeoJPSA+sV1x9WQJJYDl1koCc6Ts9SOpEUJqbNigEvur5Ro6+WyNEQycDbsEbC
         Dlkf4etSxB4fMAOzdN1a2npY3hOJT9f0RX2Wy0/3txsEnb1H7h2lS1FmepuVBNUwDl8w
         K1Nf0ogUs+dZpcdx65NEn5JOBOnvXdEcAazGeJszVTkG5TwBxTlYYGWCcY5eznb98Mcr
         HRl00yt57pQlQDwQIVB2pZAQoKQU8GGZun0PV2+h5jLtuFFquMsMaOjmkuLSYMY4TWMM
         rHhA==
X-Gm-Message-State: AOJu0YwdahKtwo7s7W36m4yZOWimO1nY1ieNxOC7xFi8LnEAS8XOzT+f
	TxSlC6q7TVq0sebt1YNVarVnn2kh8NgwBtYTe0FbRjenqF5PrqqzSbyw4U/V5XEvvrhdvOr9VBN
	V
X-Google-Smtp-Source: AGHT+IHhkPaGNo373gYBYB86X6B8CH7K8fjZGdvgdJJtuGaWR2wpwXlS3jxD7YXDVZyvFOC6UrzOdg==
X-Received: by 2002:a92:d352:0:b0:36a:1275:4aeb with SMTP id a18-20020a92d352000000b0036a12754aebmr5874615ilh.1.1712849577156;
        Thu, 11 Apr 2024 08:32:57 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 045/437] orangefs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:05 -0600
Message-ID: <20240411153126.16201-46-axboe@kernel.dk>
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
 fs/orangefs/devorangefs-req.c  | 23 +++++++++----------
 fs/orangefs/orangefs-debugfs.c | 40 ++++++++++++----------------------
 2 files changed, 24 insertions(+), 39 deletions(-)

diff --git a/fs/orangefs/devorangefs-req.c b/fs/orangefs/devorangefs-req.c
index 33ee8cb32f83..b3325cc88b63 100644
--- a/fs/orangefs/devorangefs-req.c
+++ b/fs/orangefs/devorangefs-req.c
@@ -155,18 +155,18 @@ static int orangefs_devreq_open(struct inode *inode, struct file *file)
 }
 
 /* Function for read() callers into the device */
-static ssize_t orangefs_devreq_read(struct file *file,
-				 char __user *buf,
-				 size_t count, loff_t *offset)
+static ssize_t orangefs_devreq_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct orangefs_kernel_op_s *op, *temp;
 	__s32 proto_ver = ORANGEFS_KERNEL_PROTO_VERSION;
 	static __s32 magic = ORANGEFS_DEVREQ_MAGIC;
 	struct orangefs_kernel_op_s *cur_op;
+	size_t count = iov_iter_count(to);
 	unsigned long ret;
 
 	/* We do not support blocking IO. */
-	if (!(file->f_flags & O_NONBLOCK)) {
+	if (!((iocb->ki_filp->f_flags & O_NONBLOCK) &&
+	     (iocb->ki_flags & IOCB_NOWAIT))) {
 		gossip_err("%s: blocking read from client-core.\n",
 			   __func__);
 		return -EINVAL;
@@ -278,20 +278,17 @@ static ssize_t orangefs_devreq_read(struct file *file,
 	spin_unlock(&cur_op->lock);
 
 	/* Push the upcall out. */
-	ret = copy_to_user(buf, &proto_ver, sizeof(__s32));
+	ret = !copy_to_iter_full(&proto_ver, sizeof(__s32), to);
 	if (ret != 0)
 		goto error;
-	ret = copy_to_user(buf + sizeof(__s32), &magic, sizeof(__s32));
+	ret = !copy_to_iter_full(&magic, sizeof(__s32), to);
 	if (ret != 0)
 		goto error;
-	ret = copy_to_user(buf + 2 * sizeof(__s32),
-		&cur_op->tag,
-		sizeof(__u64));
+	ret = !copy_to_iter_full(&cur_op->tag, sizeof(__u64), to);
 	if (ret != 0)
 		goto error;
-	ret = copy_to_user(buf + 2 * sizeof(__s32) + sizeof(__u64),
-		&cur_op->upcall,
-		sizeof(struct orangefs_upcall_s));
+	ret = !copy_to_iter_full(&cur_op->upcall,
+				 sizeof(struct orangefs_upcall_s), to);
 	if (ret != 0)
 		goto error;
 
@@ -768,7 +765,7 @@ static int orangefs_dev_major;
 
 static const struct file_operations orangefs_devreq_file_operations = {
 	.owner = THIS_MODULE,
-	.read = orangefs_devreq_read,
+	.read_iter = orangefs_devreq_read,
 	.write_iter = orangefs_devreq_write_iter,
 	.open = orangefs_devreq_open,
 	.release = orangefs_devreq_release,
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 2f1ed95ac8fb..926800659a41 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -74,15 +74,8 @@ static int help_show(struct seq_file *, void *);
 
 static int orangefs_debug_open(struct inode *, struct file *);
 
-static ssize_t orangefs_debug_read(struct file *,
-				 char __user *,
-				 size_t,
-				 loff_t *);
-
-static ssize_t orangefs_debug_write(struct file *,
-				  const char __user *,
-				  size_t,
-				  loff_t *);
+static ssize_t orangefs_debug_read(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t orangefs_debug_write(struct kiocb *iocb, struct iov_iter *to);
 
 static int orangefs_prepare_cdm_array(char *);
 static void debug_mask_to_string(void *, int);
@@ -124,8 +117,8 @@ static const struct file_operations debug_help_fops = {
 static const struct file_operations kernel_debug_fops = {
 	.owner		= THIS_MODULE,
 	.open           = orangefs_debug_open,
-	.read           = orangefs_debug_read,
-	.write		= orangefs_debug_write,
+	.read_iter      = orangefs_debug_read,
+	.write_iter	= orangefs_debug_write,
 	.llseek         = generic_file_llseek,
 };
 
@@ -338,10 +331,7 @@ static int orangefs_debug_open(struct inode *inode, struct file *file)
 	return rc;
 }
 
-static ssize_t orangefs_debug_read(struct file *file,
-				 char __user *ubuf,
-				 size_t count,
-				 loff_t *ppos)
+static ssize_t orangefs_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *buf;
 	int sprintf_ret;
@@ -354,10 +344,10 @@ static ssize_t orangefs_debug_read(struct file *file,
 		goto out;
 
 	mutex_lock(&orangefs_debug_lock);
-	sprintf_ret = sprintf(buf, "%s", (char *)file->private_data);
+	sprintf_ret = sprintf(buf, "%s", (char *)iocb->ki_filp->private_data);
 	mutex_unlock(&orangefs_debug_lock);
 
-	read_ret = simple_read_from_buffer(ubuf, count, ppos, buf, sprintf_ret);
+	read_ret = simple_copy_to_iter(buf, &iocb->ki_pos, sprintf_ret, to);
 
 	kfree(buf);
 
@@ -369,11 +359,9 @@ static ssize_t orangefs_debug_read(struct file *file,
 	return read_ret;
 }
 
-static ssize_t orangefs_debug_write(struct file *file,
-				  const char __user *ubuf,
-				  size_t count,
-				  loff_t *ppos)
+static ssize_t orangefs_debug_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char *buf;
 	int rc = -EFAULT;
 	size_t silly = 0;
@@ -384,7 +372,7 @@ static ssize_t orangefs_debug_write(struct file *file,
 
 	gossip_debug(GOSSIP_DEBUGFS_DEBUG,
 		"orangefs_debug_write: %pD\n",
-		file);
+		iocb->ki_filp);
 
 	if (count == 0)
 		return 0;
@@ -402,7 +390,7 @@ static ssize_t orangefs_debug_write(struct file *file,
 	if (!buf)
 		goto out;
 
-	if (copy_from_user(buf, ubuf, count - 1)) {
+	if (!copy_from_iter_full(buf, count - 1, from)) {
 		gossip_debug(GOSSIP_DEBUGFS_DEBUG,
 			     "%s: copy_from_user failed!\n",
 			     __func__);
@@ -418,7 +406,7 @@ static ssize_t orangefs_debug_write(struct file *file,
 	 * A service operation is required to set a new client-side
 	 * debug mask.
 	 */
-	if (!strcmp(file->f_path.dentry->d_name.name,
+	if (!strcmp(iocb->ki_filp->f_path.dentry->d_name.name,
 		    ORANGEFS_KMOD_DEBUG_FILE)) {
 		debug_string_to_mask(buf, &orangefs_gossip_debug_mask, 0);
 		debug_mask_to_string(&orangefs_gossip_debug_mask, 0);
@@ -471,12 +459,12 @@ static ssize_t orangefs_debug_write(struct file *file,
 	}
 
 	mutex_lock(&orangefs_debug_lock);
-	s = file_inode(file)->i_private;
+	s = file_inode(iocb->ki_filp)->i_private;
 	memset(s, 0, ORANGEFS_MAX_DEBUG_STRING_LEN);
 	sprintf(s, "%s\n", debug_string);
 	mutex_unlock(&orangefs_debug_lock);
 
-	*ppos += count;
+	iocb->ki_pos += count;
 	if (silly)
 		rc = silly;
 	else
-- 
2.43.0


