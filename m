Return-Path: <linux-kernel+bounces-141134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5FD8A1AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304551C23028
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269CB167A46;
	Thu, 11 Apr 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C1jtS6pn"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7259167A38
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850095; cv=none; b=loCp3NEzw1ttdHaLlW+ABmRPT5Gf7m8eeAOCuTbI4yC7jUBy6bchL65v7b53rbsKwvhPi3BNJLhi3H55GppY0IxR91VXN261K1j4UrC3DmBgzsED/bdL4RfvlRPag4aalgrG9DE8gXN0wrD8afRY24K4CIU1O65B+66e6FKhEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850095; c=relaxed/simple;
	bh=7CPUkBrN8xjyPGLCUDnqIjQ3YwFz8Z3s2tGLPP4pTKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mc8uoZW9vUCjAlLwbmylMkr2A/IZpVLaHRt465wwHQxbeLiu53raQucNy4ogBJmFbJHonXFs2BXedDwJoE3wZ4k2O1iXBkZKIpcl4B/l9Yg8AAuWnqascOcRGYeN2bTVoQmdqCcVIuhzVItP1ngUsj+s7EGVEgGVxZJHFt6Czfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C1jtS6pn; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9077639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850092; x=1713454892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MgonaAJ8bM7EoRbBevWgKvLnyQoKhiQvxy8z1bY5wU=;
        b=C1jtS6pndry/6eGJXipxytsxCwBl+pR8qibzYiZuWw8KfBTOKqFuTeplap6lbZjgbA
         C1DBNViO5bL/teO81SgB/eSGFwclHT+oaArQsWrN9Yz3uHwGJi2XfmJELo1R+qWHJPY7
         qKWJJVcaKYniAFgNk8C+bqLDyl5htUmaXsJc/ErS/Yx23RLTNOFih9kheb/eqN+nUnhG
         b+2rNDY8tKGlH5Wl3fnD1rpWFF9Y2wTEmSJ1+N6anw9nO2H9McLZY2J7Usu0YBizjnwu
         9CTHPDeZfUr85M7Oxou/OUgn2WW025jkoOgyqGlvStoyCMPKFrauOHRUKR+5alWkRxIf
         cPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850092; x=1713454892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MgonaAJ8bM7EoRbBevWgKvLnyQoKhiQvxy8z1bY5wU=;
        b=lRbGrMCQQyzgXaEoWZ96/PjiRzjy6OU2HMugCc7Awb4+pEjwSlBd0twDi3Lt/EsoOD
         6ECrnV9d4T9ZDryKWcL2J9f+QIYvmevFoW4iQkbyEVMDv5sUQ73jP9BXNN2FQnA4nvsu
         ho29Od/axuapYbiv+W1CiSR8lntqBxBhKI08/ZgtkCKeRbOMTSZx9bQPbH8Gx3kTVKYX
         iN91RHPXARAlxIZYdkV/RNDLSuyn3cc8GvZW6Osgc++YzXGcm6CkPqUOAj6SQbaH0X2X
         1GGYK4fwK32G7t6DivXxHlI+0OVS84hOUby/5MTnlXz5gHsPWYmXOzprZVC22h3GnfWw
         5ELg==
X-Gm-Message-State: AOJu0YwBnWoxT799vE1SxUDzQMH72zLZ7s37JduYOw3xD1+H1xIrWFjg
	h/tdUYNNDhlCsM75l2lFpIMKILHJ69gFJ4lXMx1i/biUJi9eACmE74+YpeRpsjfbZuaN5kUOa/E
	V
X-Google-Smtp-Source: AGHT+IFmqXzmrJFX9P/Ko3ZWYXEzHYBSzbJq8rlX8IhegYTqL0auVi6gqDbef6sqQOHxwgU8/lPXlw==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr236277ioh.0.1712850092654;
        Thu, 11 Apr 2024 08:41:32 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 355/437] arch/um: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:15 -0600
Message-ID: <20240411153126.16201-356-axboe@kernel.dk>
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
 arch/um/drivers/harddog_kern.c   |  6 +++---
 arch/um/drivers/hostaudio_kern.c | 22 +++++++++++-----------
 arch/um/drivers/mmapper_kern.c   | 16 +++++++---------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
index 60d1c6cab8a9..77fa33f229f2 100644
--- a/arch/um/drivers/harddog_kern.c
+++ b/arch/um/drivers/harddog_kern.c
@@ -109,9 +109,9 @@ static int harddog_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t harddog_write(struct file *file, const char __user *data, size_t len,
-			     loff_t *ppos)
+static ssize_t harddog_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	/*
 	 *	Refresh the timer.
 	 */
@@ -158,7 +158,7 @@ static long harddog_ioctl(struct file *file,
 
 static const struct file_operations harddog_fops = {
 	.owner		= THIS_MODULE,
-	.write		= harddog_write,
+	.write_iter	= harddog_write,
 	.unlocked_ioctl	= harddog_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= harddog_open,
diff --git a/arch/um/drivers/hostaudio_kern.c b/arch/um/drivers/hostaudio_kern.c
index c42b793bce65..8ea3bb32867c 100644
--- a/arch/um/drivers/hostaudio_kern.c
+++ b/arch/um/drivers/hostaudio_kern.c
@@ -67,10 +67,10 @@ static DEFINE_MUTEX(hostaudio_mutex);
 
 /* /dev/dsp file operations */
 
-static ssize_t hostaudio_read(struct file *file, char __user *buffer,
-			      size_t count, loff_t *ppos)
+static ssize_t hostaudio_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hostaudio_state *state = file->private_data;
+	struct hostaudio_state *state = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	void *kbuf;
 	int err;
 
@@ -86,7 +86,7 @@ static ssize_t hostaudio_read(struct file *file, char __user *buffer,
 	if (err < 0)
 		goto out;
 
-	if (copy_to_user(buffer, kbuf, err))
+	if (!copy_to_iter_full(kbuf, err, to))
 		err = -EFAULT;
 
 out:
@@ -94,10 +94,10 @@ static ssize_t hostaudio_read(struct file *file, char __user *buffer,
 	return err;
 }
 
-static ssize_t hostaudio_write(struct file *file, const char __user *buffer,
-			       size_t count, loff_t *ppos)
+static ssize_t hostaudio_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hostaudio_state *state = file->private_data;
+	struct hostaudio_state *state = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	void *kbuf;
 	int err;
 
@@ -105,14 +105,14 @@ static ssize_t hostaudio_write(struct file *file, const char __user *buffer,
 	printk(KERN_DEBUG "hostaudio: write called, count = %d\n", count);
 #endif
 
-	kbuf = memdup_user(buffer, count);
+	kbuf = iterdup(from, count);
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
 	err = os_write_file(state->fd, kbuf, count);
 	if (err < 0)
 		goto out;
-	*ppos += err;
+	iocb->ki_pos += err;
 
  out:
 	kfree(kbuf);
@@ -292,8 +292,8 @@ static int hostmixer_release(struct inode *inode, struct file *file)
 static const struct file_operations hostaudio_fops = {
 	.owner          = THIS_MODULE,
 	.llseek         = no_llseek,
-	.read           = hostaudio_read,
-	.write          = hostaudio_write,
+	.read_iter      = hostaudio_read,
+	.write_iter     = hostaudio_write,
 	.poll           = hostaudio_poll,
 	.unlocked_ioctl	= hostaudio_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
diff --git a/arch/um/drivers/mmapper_kern.c b/arch/um/drivers/mmapper_kern.c
index 807cd3358740..db66090177d4 100644
--- a/arch/um/drivers/mmapper_kern.c
+++ b/arch/um/drivers/mmapper_kern.c
@@ -26,19 +26,17 @@ static unsigned long mmapper_size;
 static unsigned long p_buf;
 static char *v_buf;
 
-static ssize_t mmapper_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
+static ssize_t mmapper_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(buf, count, ppos, v_buf, mmapper_size);
+	return simple_copy_to_iter(v_buf, &iocb->ki_pos, mmapper_size, to);
 }
 
-static ssize_t mmapper_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t mmapper_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	if (*ppos > mmapper_size)
+	if (iocb->ki_pos > mmapper_size)
 		return -EINVAL;
 
-	return simple_write_to_buffer(v_buf, mmapper_size, ppos, buf, count);
+	return simple_copy_from_iter(v_buf, &iocb->ki_pos,  mmapper_size, from);
 }
 
 static long mmapper_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -82,8 +80,8 @@ static int mmapper_release(struct inode *inode, struct file *file)
 
 static const struct file_operations mmapper_fops = {
 	.owner		= THIS_MODULE,
-	.read		= mmapper_read,
-	.write		= mmapper_write,
+	.read_iter	= mmapper_read,
+	.write_iter	= mmapper_write,
 	.unlocked_ioctl	= mmapper_ioctl,
 	.mmap		= mmapper_mmap,
 	.open		= mmapper_open,
-- 
2.43.0


