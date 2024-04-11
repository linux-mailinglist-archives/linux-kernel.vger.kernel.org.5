Return-Path: <linux-kernel+bounces-141151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CFA8A1AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52E91C20FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED15B1EF531;
	Thu, 11 Apr 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hp9gZBun"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AD1F01B9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850125; cv=none; b=fRVK4/xA9DicgcfKwUlAFECCIriHkEKDfyjgTyJQOYBsIi0RgyspLxcuB4dVfYO2JxSYv4zXQqSSQss7Y5dUj+AxtEsJZHWxy6EiVEDLY6Or/KGuZbUUDDPeRJKI9hu1sPywU6gBx11OzkinYiUxjd5+Nn19YXT8BBzfcHQFTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850125; c=relaxed/simple;
	bh=FvfGt/AfAAAx07nwNd35WmUIXyZbd7ojNXTrJbHH3kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7HO9ZSlOUjWFWEtefUL8RfVtHbojn2NmH3pBB9ZBMZ1gSjvobLX6dXQORHaF96anF+A5nG/KEXl07i8AdExKiU7RXSb+CpdmnHfQscaClFlaUcJsFBFR3XBBk5iaa/Snu0yJv5io3fH+jIGDDZhCXAZpzfkz94LRwhxPlhlR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hp9gZBun; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170642639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850122; x=1713454922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMF5/18oGlE92Rx2YgiTSTe37PbVaqd1Nc1FV3ePit0=;
        b=hp9gZBundcHs5LcImi5KtcSac4IO90N6JNiINPZFjzijzjSrA/4GIG469zZVdH6IB4
         35FoTwyPQeFPafskTb7a7GyHln0kfh8ZjMgWmkdW+AjUCUlIM2Yb018gkZfLSQhUiVE4
         WGrxTuzK+ONzH4fGfFiJzWP/up2bkIJCrHs96FbB8qrqQJ5t7ZTwPkwvk/fKASyOBR2o
         rmfa91RY+i6+7MKaeldXby3IqZA2el3iauriGe3brxF/SEckeEv7t2HjsgqXZFkMeZBX
         9cPE5ez7ly6YLliLzxH+dVNyvQdhIrubixa5qimJE5VSa4vP9CAC4eSGFb4cQGPnzN+M
         hT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850122; x=1713454922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMF5/18oGlE92Rx2YgiTSTe37PbVaqd1Nc1FV3ePit0=;
        b=t7JvKPOeqcPzA1wOvncLfLJ+G+91jtKZcyLncy0eGDLezHYW5LVelPQIJ8Xe6HzgAT
         siNVMnxP8HvMNZFV3RcEd/SDINgc/31fmMGe//Iz72VEN8+/GyZDztyRk5pyMwer5Zzg
         PH6FFLY9SbCZtAmfjWvj2i2oXDp0SlzVDa7oWsi1ertcAJlU6gngWCh18MYZjEtFwH3c
         duVDBF1ehAavYJdsb1ANiR06y2tKUh3ScETOhc+piRNKxs40zb9seYCRnYJJJM2oS/+b
         ZzMT8ZwjxIXhsuinsBz1bx1bdPMv0tmL94EvvgKKYWKqhyC9cY5gHPnY9i+ize1Dthpz
         fPCg==
X-Gm-Message-State: AOJu0Yz714r9Lqn5K1Ev5b1RyJcGkOJPJ4Z6ZrKDrIUhskf1IXS8y4xw
	Sx/uLXX9RKuqOFUgR/CrzMI8Ef1ZDkm8wyQ0oErE2j8SbO9VbpSdS6rUNVdBQrpXf5LIbjT2nbG
	R
X-Google-Smtp-Source: AGHT+IFq5UrdmyfFy9AaanRvpt8wH6yK7CTzw0o7buhNS2z1DjVy2eHaTI3cavNTQgT9JSteQUxzxw==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr196616ioj.2.1712850122665;
        Thu, 11 Apr 2024 08:42:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 370/437] drivers/most: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:30 -0600
Message-ID: <20240411153126.16201-371-axboe@kernel.dk>
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
 drivers/most/most_cdev.c | 50 ++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
index 3ed8f461e01e..1653f23caef4 100644
--- a/drivers/most/most_cdev.c
+++ b/drivers/most/most_cdev.c
@@ -174,24 +174,22 @@ static int comp_close(struct inode *inode, struct file *filp)
 
 /**
  * comp_write - implements the syscall to write to the device
- * @filp: file pointer
- * @buf: pointer to user buffer
- * @count: number of bytes to write
- * @offset: offset from where to start writing
+ * @iocb: metadata for IO
+ * @from: pointer to user buffer
  */
-static ssize_t comp_write(struct file *filp, const char __user *buf,
-			  size_t count, loff_t *offset)
+static ssize_t comp_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int ret;
-	size_t to_copy, left;
+	size_t to_copy;
 	struct mbo *mbo = NULL;
-	struct comp_channel *c = filp->private_data;
+	struct comp_channel *c = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
 	mutex_lock(&c->io_mutex);
 	while (c->dev && !ch_get_mbo(c, &mbo)) {
 		mutex_unlock(&c->io_mutex);
 
-		if ((filp->f_flags & O_NONBLOCK))
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 		if (wait_event_interruptible(c->wq, ch_has_mbo(c) || !c->dev))
 			return -ERESTARTSYS;
@@ -204,13 +202,13 @@ static ssize_t comp_write(struct file *filp, const char __user *buf,
 	}
 
 	to_copy = min(count, c->cfg->buffer_size - c->mbo_offs);
-	left = copy_from_user(mbo->virt_address + c->mbo_offs, buf, to_copy);
-	if (left == to_copy) {
+	ret = copy_from_iter(mbo->virt_address + c->mbo_offs, to_copy, from);
+	if (ret != to_copy) {
 		ret = -EFAULT;
 		goto unlock;
 	}
 
-	c->mbo_offs += to_copy - left;
+	c->mbo_offs += ret;
 	if (c->mbo_offs >= c->cfg->buffer_size ||
 	    c->cfg->data_type == MOST_CH_CONTROL ||
 	    c->cfg->data_type == MOST_CH_ASYNC) {
@@ -219,8 +217,6 @@ static ssize_t comp_write(struct file *filp, const char __user *buf,
 		c->mbo_offs = 0;
 		most_submit_mbo(mbo);
 	}
-
-	ret = to_copy - left;
 unlock:
 	mutex_unlock(&c->io_mutex);
 	return ret;
@@ -228,22 +224,20 @@ static ssize_t comp_write(struct file *filp, const char __user *buf,
 
 /**
  * comp_read - implements the syscall to read from the device
- * @filp: file pointer
- * @buf: pointer to user buffer
- * @count: number of bytes to read
- * @offset: offset from where to start reading
+ * @iocb: metadata for IO
+ * @to: pointer to user buffer
  */
-static ssize_t
-comp_read(struct file *filp, char __user *buf, size_t count, loff_t *offset)
+static ssize_t comp_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	size_t to_copy, not_copied, copied;
+	size_t to_copy, copied;
 	struct mbo *mbo = NULL;
-	struct comp_channel *c = filp->private_data;
+	struct comp_channel *c = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 
 	mutex_lock(&c->io_mutex);
 	while (c->dev && !kfifo_peek(&c->fifo, &mbo)) {
 		mutex_unlock(&c->io_mutex);
-		if (filp->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 		if (wait_event_interruptible(c->wq,
 					     (!kfifo_is_empty(&c->fifo) ||
@@ -262,11 +256,7 @@ comp_read(struct file *filp, char __user *buf, size_t count, loff_t *offset)
 			count,
 			mbo->processed_length - c->mbo_offs);
 
-	not_copied = copy_to_user(buf,
-				  mbo->virt_address + c->mbo_offs,
-				  to_copy);
-
-	copied = to_copy - not_copied;
+	copied = copy_to_iter(mbo->virt_address + c->mbo_offs, to_copy, to);
 
 	c->mbo_offs += copied;
 	if (c->mbo_offs >= mbo->processed_length) {
@@ -302,8 +292,8 @@ static __poll_t comp_poll(struct file *filp, poll_table *wait)
  */
 static const struct file_operations channel_fops = {
 	.owner = THIS_MODULE,
-	.read = comp_read,
-	.write = comp_write,
+	.read_iter = comp_read,
+	.write_iter = comp_write,
 	.open = comp_open,
 	.release = comp_close,
 	.poll = comp_poll,
-- 
2.43.0


