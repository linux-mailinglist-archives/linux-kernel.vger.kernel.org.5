Return-Path: <linux-kernel+bounces-140938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA418A19D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C705EB28953
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7D1CB326;
	Thu, 11 Apr 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O2uig6EW"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47A1C9ECE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849788; cv=none; b=AVIjmWYGP9QuIf4Tlw/lRe1oO478fGvFZYkz9707MDwkM8QYpIt6sNOSkp06+q264K7TWLBvJDXni3RK1Z95hzWYLq8iAVLehmlsp7t9PsSTrVkiD+UY4q0+YqbX9CS9UCGxPInrJBUsCpC0ivk0vH8ZYKyfERJNuAyfPBV/efY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849788; c=relaxed/simple;
	bh=JjpU4GRBcne7lTFL4A+MIuHfW0eUTaqr2Y5mR//C6Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPr0D7RWQFAJ3HA/i5k55Gw5vfwWpg9Y+l7+vI5XT/oULy/YjY6oVuKa5D84v8yYh9JiPx3O+MvHeinrmG1mp0ZcJ1uJ+jFxt+j4I3PmeNXPtt8k7NT3Z0fMxsqbp2agb4JZw1yLxkyBQtCP7HYOTfcjGaNegM4TFFr0SGJB+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O2uig6EW; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58079039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849784; x=1713454584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njqcBwWUNR1MADk9nqYz8nv4i+lwHFUPJWFghnPuFjs=;
        b=O2uig6EWdPRgHZCZ7otrCPrfQypJ1eQs8IaGl9xO+Sjaq6qhRfI9goEzbM5DWWD6nW
         Md6ucGTyEPzUhp8nyegNQyQPVQ6JtPKrvXKydV7r22VKlR/YG97t8cLStJF3WsjcoIdc
         k9TuvH3aLnRPAwUpp731F8RGW9y36kUqhA5QwvAemUZ5e/2DnzKFtPs43hGMSceAz6q0
         5aYbzpXEQvMkIxILaX+N3FR7BG3n+L9ngco6j97GONMy3ekJmgHa0CTgeETP278DBNrL
         fMPW3geiN6KvU2qvXBjkO1Mjg637mycUoNNr05s45nBYkrMF6kVIG2OyGOiZ1fdL51jU
         +B1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849784; x=1713454584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njqcBwWUNR1MADk9nqYz8nv4i+lwHFUPJWFghnPuFjs=;
        b=erZQfcC8sOEJQyi2Y+SOsSbMuTI1UpjLnMeZSV8M7Krdctm64JTHSOR41NAOs0WP0X
         vd3+QAxHa6sTyvKy1S7YUgo8Lf+JYLOqnZRw2rBSqLM3DXQ2obJxVK1VKz2IpnrBgG2G
         +c5grEh86RHE+g5I2dcfenYDABBc1tKMf0MzM3001AY39/UWZPsfYXcezZrK85O1X2Qk
         IhCFVgVlvugghabqGxOJmUYgZb+vc8+nago+sTl3Y9JxcnPv0KNxeSAuUVZDFrgOiO7u
         T+DmU6JWOovfcPePGm0pI4BjIFptcirf+oprcmuLx1PMnc8A5jX+qemft7XgfNRBJUv1
         w9hQ==
X-Gm-Message-State: AOJu0YwvF6y2YkwGS5KNlHyN4/BhNzo8Qx/8NNqTj8kABApLDRmoUw1z
	OOFvfe74cWwgX+ElaegQxmrlLgm0+UF1TkcXCbdUbck/2n+9/BEfy5hReLeWAD64mBhbqzsid9W
	7
X-Google-Smtp-Source: AGHT+IECsoBNkAbvG8lBtHH7uIgp/F+qevwgD8Qpg9Vu2GLAHqfkogTYBEztciutqEbyCeCDWjFT5g==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr161720ioh.1.1712849784482;
        Thu, 11 Apr 2024 08:36:24 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 168/437] usb: misc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:08 -0600
Message-ID: <20240411153126.16201-169-axboe@kernel.dk>
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
 drivers/usb/misc/adutux.c              |  6 ++++--
 drivers/usb/misc/chaoskey.c            | 13 +++++--------
 drivers/usb/misc/idmouse.c             | 15 ++++++---------
 drivers/usb/misc/iowarrior.c           |  6 ++++--
 drivers/usb/misc/ldusb.c               | 24 ++++++++++++------------
 drivers/usb/misc/legousbtower.c        | 26 ++++++++++++++------------
 drivers/usb/misc/sisusbvga/sisusbvga.c |  6 ++++--
 drivers/usb/misc/usblcd.c              | 20 ++++++++++----------
 drivers/usb/misc/yurex.c               | 19 +++++++++----------
 9 files changed, 68 insertions(+), 67 deletions(-)

diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
index ed6a19254d2f..20d6107682c2 100644
--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -499,6 +499,7 @@ static ssize_t adu_read(struct file *file, __user char *buffer, size_t count,
 
 	return retval;
 }
+FOPS_READ_ITER_HELPER(adu_read);
 
 static ssize_t adu_write(struct file *file, const __user char *buffer,
 			 size_t count, loff_t *ppos)
@@ -619,12 +620,13 @@ static ssize_t adu_write(struct file *file, const __user char *buffer,
 	remove_wait_queue(&dev->write_wait, &waita);
 	return retval;
 }
+FOPS_WRITE_ITER_HELPER(adu_write);
 
 /* file operations needed when we register this driver */
 static const struct file_operations adu_fops = {
 	.owner = THIS_MODULE,
-	.read  = adu_read,
-	.write = adu_write,
+	.read_iter  = adu_read_iter,
+	.write_iter = adu_write_iter,
 	.open = adu_open,
 	.release = adu_release,
 	.llseek = noop_llseek,
diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index 6fb5140e29b9..400b19bb1ee6 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -403,18 +403,16 @@ static int _chaoskey_fill(struct chaoskey *dev)
 	return result;
 }
 
-static ssize_t chaoskey_read(struct file *file,
-			     char __user *buffer,
-			     size_t count,
-			     loff_t *ppos)
+static ssize_t chaoskey_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct chaoskey *dev;
 	ssize_t read_count = 0;
 	int this_time;
 	int result = 0;
 	unsigned long remain;
+	size_t count = iov_iter_count(to);
 
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	if (dev == NULL || !dev->present)
 		return -ENODEV;
@@ -446,7 +444,7 @@ static ssize_t chaoskey_read(struct file *file,
 		if (this_time > count)
 			this_time = count;
 
-		remain = copy_to_user(buffer, dev->buf + dev->used, this_time);
+		remain = !copy_to_iter_full(dev->buf + dev->used, this_time, to);
 		if (remain) {
 			result = -EFAULT;
 
@@ -460,7 +458,6 @@ static ssize_t chaoskey_read(struct file *file,
 
 		count -= this_time;
 		read_count += this_time;
-		buffer += this_time;
 		dev->used += this_time;
 		mutex_unlock(&dev->lock);
 	}
@@ -554,7 +551,7 @@ static int chaoskey_resume(struct usb_interface *interface)
 /* file operation pointers */
 static const struct file_operations chaoskey_fops = {
 	.owner = THIS_MODULE,
-	.read = chaoskey_read,
+	.read_iter = chaoskey_read,
 	.open = chaoskey_open,
 	.release = chaoskey_release,
 	.llseek = default_llseek,
diff --git a/drivers/usb/misc/idmouse.c b/drivers/usb/misc/idmouse.c
index ea39243efee3..91534f0982ea 100644
--- a/drivers/usb/misc/idmouse.c
+++ b/drivers/usb/misc/idmouse.c
@@ -79,9 +79,7 @@ struct usb_idmouse {
 };
 
 /* local function prototypes */
-static ssize_t idmouse_read(struct file *file, char __user *buffer,
-				size_t count, loff_t * ppos);
-
+static ssize_t idmouse_read(struct kiocb *iocb, struct iov_iter *to);
 static int idmouse_open(struct inode *inode, struct file *file);
 static int idmouse_release(struct inode *inode, struct file *file);
 
@@ -95,7 +93,7 @@ static int idmouse_resume(struct usb_interface *intf);
 /* file operation pointers */
 static const struct file_operations idmouse_fops = {
 	.owner = THIS_MODULE,
-	.read = idmouse_read,
+	.read_iter = idmouse_read,
 	.open = idmouse_open,
 	.release = idmouse_release,
 	.llseek = default_llseek,
@@ -290,10 +288,9 @@ static int idmouse_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t idmouse_read(struct file *file, char __user *buffer, size_t count,
-				loff_t * ppos)
+static ssize_t idmouse_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct usb_idmouse *dev = file->private_data;
+	struct usb_idmouse *dev = iocb->ki_filp->private_data;
 	int result;
 
 	/* lock this object */
@@ -305,8 +302,8 @@ static ssize_t idmouse_read(struct file *file, char __user *buffer, size_t count
 		return -ENODEV;
 	}
 
-	result = simple_read_from_buffer(buffer, count, ppos,
-					dev->bulk_in_buffer, IMGSIZE);
+	result = simple_copy_to_iter(dev->bulk_in_buffer, &iocb->ki_pos,
+					IMGSIZE, to);
 	/* unlock the device */
 	mutex_unlock(&dev->lock);
 	return result;
diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..bb0f28e1cdca 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -332,6 +332,7 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 	atomic_set(&dev->read_idx, read_idx);
 	return count;
 }
+FOPS_READ_ITER_HELPER(iowarrior_read);
 
 /*
  * iowarrior_write
@@ -468,6 +469,7 @@ static ssize_t iowarrior_write(struct file *file,
 	mutex_unlock(&dev->mutex);
 	return retval;
 }
+FOPS_WRITE_ITER_HELPER(iowarrior_write);
 
 /*
  *	iowarrior_ioctl
@@ -707,8 +709,8 @@ static __poll_t iowarrior_poll(struct file *file, poll_table * wait)
  */
 static const struct file_operations iowarrior_fops = {
 	.owner = THIS_MODULE,
-	.write = iowarrior_write,
-	.read = iowarrior_read,
+	.write_iter = iowarrior_write_iter,
+	.read_iter = iowarrior_read_iter,
 	.unlocked_ioctl = iowarrior_ioctl,
 	.open = iowarrior_open,
 	.release = iowarrior_release,
diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index 7cbef74dfc9a..7fef44f35b45 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -433,16 +433,16 @@ static __poll_t ld_usb_poll(struct file *file, poll_table *wait)
 /*
  *	ld_usb_read
  */
-static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
-			   loff_t *ppos)
+static ssize_t ld_usb_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct ld_usb *dev;
 	size_t *actual_buffer;
 	size_t bytes_to_read;
 	int retval = 0;
 	int rv;
 
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	/* verify that we actually have some data to read */
 	if (count == 0)
@@ -466,7 +466,7 @@ static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
 	while (dev->ring_head == dev->ring_tail) {
 		dev->interrupt_in_done = 0;
 		spin_unlock_irq(&dev->rbsl);
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto unlock_exit;
 		}
@@ -490,7 +490,7 @@ static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
 			 *actual_buffer-bytes_to_read);
 
 	/* copy one interrupt_in_buffer from ring_buffer into userspace */
-	if (copy_to_user(buffer, actual_buffer+1, bytes_to_read)) {
+	if (!copy_to_iter_full(actual_buffer+1, bytes_to_read, to)) {
 		retval = -EFAULT;
 		goto unlock_exit;
 	}
@@ -520,14 +520,14 @@ static ssize_t ld_usb_read(struct file *file, char __user *buffer, size_t count,
 /*
  *	ld_usb_write
  */
-static ssize_t ld_usb_write(struct file *file, const char __user *buffer,
-			    size_t count, loff_t *ppos)
+static ssize_t ld_usb_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct ld_usb *dev;
 	size_t bytes_to_write;
 	int retval = 0;
 
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	/* verify that we actually have some data to write */
 	if (count == 0)
@@ -548,7 +548,7 @@ static ssize_t ld_usb_write(struct file *file, const char __user *buffer,
 
 	/* wait until previous transfer is finished */
 	if (dev->interrupt_out_busy) {
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto unlock_exit;
 		}
@@ -566,7 +566,7 @@ static ssize_t ld_usb_write(struct file *file, const char __user *buffer,
 	dev_dbg(&dev->intf->dev, "%s: count = %zu, bytes_to_write = %zu\n",
 		__func__, count, bytes_to_write);
 
-	if (copy_from_user(dev->interrupt_out_buffer, buffer, bytes_to_write)) {
+	if (!copy_from_iter_full(dev->interrupt_out_buffer, bytes_to_write, from)) {
 		retval = -EFAULT;
 		goto unlock_exit;
 	}
@@ -622,8 +622,8 @@ static ssize_t ld_usb_write(struct file *file, const char __user *buffer,
 /* file operations needed when we register this driver */
 static const struct file_operations ld_usb_fops = {
 	.owner =	THIS_MODULE,
-	.read  =	ld_usb_read,
-	.write =	ld_usb_write,
+	.read_iter  =	ld_usb_read,
+	.write_iter =	ld_usb_write,
 	.open =		ld_usb_open,
 	.release =	ld_usb_release,
 	.poll =		ld_usb_poll,
diff --git a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
index 379cf01a6e96..57dcb5612734 100644
--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -218,8 +218,8 @@ struct lego_usb_tower {
 
 
 /* local function prototypes */
-static ssize_t tower_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos);
-static ssize_t tower_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos);
+static ssize_t tower_read(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t tower_write(struct kiocb *iocb, struct iov_iter *from);
 static inline void tower_delete(struct lego_usb_tower *dev);
 static int tower_open(struct inode *inode, struct file *file);
 static int tower_release(struct inode *inode, struct file *file);
@@ -237,8 +237,8 @@ static void tower_disconnect(struct usb_interface *interface);
 /* file operations needed when we register this driver */
 static const struct file_operations tower_fops = {
 	.owner =	THIS_MODULE,
-	.read  =	tower_read,
-	.write =	tower_write,
+	.read_iter  =	tower_read,
+	.write_iter =	tower_write,
 	.open =		tower_open,
 	.release =	tower_release,
 	.poll =		tower_poll,
@@ -489,15 +489,16 @@ static loff_t tower_llseek(struct file *file, loff_t off, int whence)
 /*
  *	tower_read
  */
-static ssize_t tower_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t tower_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct lego_usb_tower *dev;
 	size_t bytes_to_read;
 	int i;
 	int retval = 0;
 	unsigned long timeout = 0;
 
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	/* lock this object */
 	if (mutex_lock_interruptible(&dev->lock)) {
@@ -523,7 +524,7 @@ static ssize_t tower_read(struct file *file, char __user *buffer, size_t count,
 	/* wait for data */
 	tower_check_for_read_packet(dev);
 	while (dev->read_packet_length == 0) {
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto unlock_exit;
 		}
@@ -547,7 +548,7 @@ static ssize_t tower_read(struct file *file, char __user *buffer, size_t count,
 	/* copy the data from read_buffer into userspace */
 	bytes_to_read = min(count, dev->read_packet_length);
 
-	if (copy_to_user(buffer, dev->read_buffer, bytes_to_read)) {
+	if (!copy_to_iter_full(dev->read_buffer, bytes_to_read, to)) {
 		retval = -EFAULT;
 		goto unlock_exit;
 	}
@@ -573,13 +574,14 @@ static ssize_t tower_read(struct file *file, char __user *buffer, size_t count,
 /*
  *	tower_write
  */
-static ssize_t tower_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t tower_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct lego_usb_tower *dev;
 	size_t bytes_to_write;
 	int retval = 0;
 
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	/* lock this object */
 	if (mutex_lock_interruptible(&dev->lock)) {
@@ -601,7 +603,7 @@ static ssize_t tower_write(struct file *file, const char __user *buffer, size_t
 
 	/* wait until previous transfer is finished */
 	while (dev->interrupt_out_busy) {
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto unlock_exit;
 		}
@@ -616,7 +618,7 @@ static ssize_t tower_write(struct file *file, const char __user *buffer, size_t
 	dev_dbg(&dev->udev->dev, "%s: count = %zd, bytes_to_write = %zd\n",
 		__func__, count, bytes_to_write);
 
-	if (copy_from_user(dev->interrupt_out_buffer, buffer, bytes_to_write)) {
+	if (!copy_from_iter_full(dev->interrupt_out_buffer, bytes_to_write, from)) {
 		retval = -EFAULT;
 		goto unlock_exit;
 	}
diff --git a/drivers/usb/misc/sisusbvga/sisusbvga.c b/drivers/usb/misc/sisusbvga/sisusbvga.c
index febf34f9f049..88a94fafe594 100644
--- a/drivers/usb/misc/sisusbvga/sisusbvga.c
+++ b/drivers/usb/misc/sisusbvga/sisusbvga.c
@@ -2428,6 +2428,7 @@ static ssize_t sisusb_read(struct file *file, char __user *buffer,
 
 	return errno ? errno : bytes_read;
 }
+FOPS_READ_ITER_HELPER(sisusb_read);
 
 static ssize_t sisusb_write(struct file *file, const char __user *buffer,
 		size_t count, loff_t *ppos)
@@ -2572,6 +2573,7 @@ static ssize_t sisusb_write(struct file *file, const char __user *buffer,
 
 	return errno ? errno : bytes_written;
 }
+FOPS_WRITE_ITER_HELPER(sisusb_write);
 
 static loff_t sisusb_lseek(struct file *file, loff_t offset, int orig)
 {
@@ -2757,8 +2759,8 @@ static const struct file_operations usb_sisusb_fops = {
 	.owner =	THIS_MODULE,
 	.open =		sisusb_open,
 	.release =	sisusb_release,
-	.read =		sisusb_read,
-	.write =	sisusb_write,
+	.read_iter =	sisusb_read_iter,
+	.write_iter =	sisusb_write_iter,
 	.llseek =	sisusb_lseek,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = sisusb_compat_ioctl,
diff --git a/drivers/usb/misc/usblcd.c b/drivers/usb/misc/usblcd.c
index bb546f624a45..8d826e648b84 100644
--- a/drivers/usb/misc/usblcd.c
+++ b/drivers/usb/misc/usblcd.c
@@ -121,14 +121,14 @@ static int lcd_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t lcd_read(struct file *file, char __user * buffer,
-			size_t count, loff_t *ppos)
+static ssize_t lcd_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct usb_lcd *dev;
 	int retval = 0;
 	int bytes_read;
 
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	down_read(&dev->io_rwsem);
 
@@ -147,7 +147,7 @@ static ssize_t lcd_read(struct file *file, char __user * buffer,
 
 	/* if the read was successful, copy the data to userspace */
 	if (!retval) {
-		if (copy_to_user(buffer, dev->bulk_in_buffer, bytes_read))
+		if (!copy_to_iter_full(dev->bulk_in_buffer, bytes_read, to))
 			retval = -EFAULT;
 		else
 			retval = bytes_read;
@@ -214,15 +214,15 @@ static void lcd_write_bulk_callback(struct urb *urb)
 	up(&dev->limit_sem);
 }
 
-static ssize_t lcd_write(struct file *file, const char __user * user_buffer,
-			 size_t count, loff_t *ppos)
+static ssize_t lcd_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct usb_lcd *dev;
 	int retval = 0, r;
 	struct urb *urb = NULL;
 	char *buf = NULL;
 
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	/* verify that we actually have some data to write */
 	if (count == 0)
@@ -253,7 +253,7 @@ static ssize_t lcd_write(struct file *file, const char __user * user_buffer,
 		goto error;
 	}
 
-	if (copy_from_user(buf, user_buffer, count)) {
+	if (!copy_from_iter_full(buf, count, from)) {
 		retval = -EFAULT;
 		goto error;
 	}
@@ -296,8 +296,8 @@ static ssize_t lcd_write(struct file *file, const char __user * user_buffer,
 
 static const struct file_operations lcd_fops = {
 	.owner =        THIS_MODULE,
-	.read =         lcd_read,
-	.write =        lcd_write,
+	.read_iter =    lcd_read,
+	.write_iter =   lcd_write,
 	.open =         lcd_open,
 	.unlocked_ioctl = lcd_ioctl,
 	.release =      lcd_release,
diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 9a0649d23693..b3dd24aeae23 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -398,15 +398,14 @@ static int yurex_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t yurex_read(struct file *file, char __user *buffer, size_t count,
-			  loff_t *ppos)
+static ssize_t yurex_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct usb_yurex *dev;
 	int len = 0;
 	char in_buffer[MAX_S64_STRLEN];
 	unsigned long flags;
 
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	mutex_lock(&dev->io_mutex);
 	if (dev->disconnected) {		/* already disconnected */
@@ -424,11 +423,10 @@ static ssize_t yurex_read(struct file *file, char __user *buffer, size_t count,
 	spin_unlock_irqrestore(&dev->lock, flags);
 	mutex_unlock(&dev->io_mutex);
 
-	return simple_read_from_buffer(buffer, count, ppos, in_buffer, len);
+	return simple_copy_to_iter(in_buffer, &iocb->ki_pos, len, to);
 }
 
-static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
-			   size_t count, loff_t *ppos)
+static ssize_t yurex_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct usb_yurex *dev;
 	int i, set = 0, retval = 0;
@@ -436,10 +434,11 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
 	char *data = buffer;
 	unsigned long long c, c2 = 0;
 	signed long timeout = 0;
+	size_t count = iov_iter_count(from);
 	DEFINE_WAIT(wait);
 
 	count = min(sizeof(buffer) - 1, count);
-	dev = file->private_data;
+	dev = iocb->ki_filp->private_data;
 
 	/* verify that we actually have some data to write */
 	if (count == 0)
@@ -452,7 +451,7 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
 		goto error;
 	}
 
-	if (copy_from_user(buffer, user_buffer, count)) {
+	if (!copy_from_iter_full(buffer, count, from)) {
 		mutex_unlock(&dev->io_mutex);
 		retval = -EFAULT;
 		goto error;
@@ -521,8 +520,8 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
 
 static const struct file_operations yurex_fops = {
 	.owner =	THIS_MODULE,
-	.read =		yurex_read,
-	.write =	yurex_write,
+	.read_iter =	yurex_read,
+	.write_iter =	yurex_write,
 	.open =		yurex_open,
 	.release =	yurex_release,
 	.fasync	=	yurex_fasync,
-- 
2.43.0


