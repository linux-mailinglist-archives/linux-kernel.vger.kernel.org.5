Return-Path: <linux-kernel+bounces-141159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0608A1AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140BC283DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E61F2DEB;
	Thu, 11 Apr 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bcdqrn73"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E241F20DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850136; cv=none; b=DiComsMskmssATXj0O63eIvBKAu2BlqY/AcBdHJwCHzpO5NUcdwY5aGx/z/k9SnTI4xgAxxY59IFlYOKtUzKipcscZH7bzDWdWqmM87sRl5tylgQsbRQY4lIGzCEdU9evlOxvpkxpVGm9UZBKmTir1W8xFWviYCKCwhAFwM/vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850136; c=relaxed/simple;
	bh=Ar6UwW1sI0JVpIKkyb5NfOQbdZzkZA80a7y195tD744=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYBX2f3WWRG4V2YxTSwjQs1AAONg76J5CLsOzhdPJME56YJjGsoPH86sv6HOq+5O6vkNf1gmDPMIEPH2rCj7mGmKTGkGmDXXUYshU1Juh0cmea8BbFIf5f0yCo2Iwc6bR1T95Ft1ubcUicDaWkZ6w1JkLvttv35R0YDY4uzMIOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bcdqrn73; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36a34b68277so122645ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850134; x=1713454934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtW1TbguQ4BBpoGOxUyCCgtBSDCXuHADUDUR5tb5p4Q=;
        b=bcdqrn73xzDXFG072tfPGI6NDoUCmpFP4eMGvzMZpJhu7OoySOuu6/1x50gOXp0cdC
         8nFkcQRRMdjMybvA6PeU5LNI5IqdF4LTEzoAm+RxEp3wbw2dgEaJme/FZjM959rU5NwQ
         f+PgNvcjuHEbN+FPzd7vQbAr/L/S+bJy71TUdCBKLUnolPisbVxfT4W14aZYzJS+HQci
         NWd/Yf332gbsbl1SC/Tf0fYMteyTW7KdqPHLe4vOYk51lVMDhF3N0UOZtOND6AV+ZH8R
         s3NgbRNYB29gIdmIBLdWbQ6n3yEkxBYjt+Ykrlg6hpoFYSkaxZBbYLENrB+6BNuH+2Xz
         uBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850134; x=1713454934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtW1TbguQ4BBpoGOxUyCCgtBSDCXuHADUDUR5tb5p4Q=;
        b=wZMA2MKu7foCRfqoLCXpbjRixjJ58eE5R98KHQMcUj6MoLiuBTBmOLffYCKQZicIQO
         7KA6EsdNsG4OOijtvRfQbfwQuUvfu+tKO0h79nKBaVQA1E/gXCnTPJw+2bVXGjcAakj2
         iZaw6W69Duyi0CSGuUwXtrTZzr3ovbEXbkfBNCO3bt+EhPmTApCipAplJC+ae+thn7QP
         tChB3GzYqsiHjOIQ1U5EPmHTvtOFH4aXVF/7szy+0UPhDmZFSxdVNUb5898eH609mDL+
         Fjw0jCiwN3ev12/GPZPqKPDhjbM9lUMLlbFbciCH7RlS8YB7ZARXlKM0RIkfUqScfjDu
         1EJQ==
X-Gm-Message-State: AOJu0YzB1yjHgwEmnlxJiTpOWgfjDOHgwHdRXjjcGVJjE9Fz0VbnUpHZ
	X9TGQgBMydFfswoQzU9Mb3JzksLcNvFbnvndr5eBxG7ETZr91WVq24sOP6EGqRIAFam0Rg+oQAV
	r
X-Google-Smtp-Source: AGHT+IHDJUru5g6Yz5MjJ5gVEFZU+4ZCtQCsR7AQka0AOa2Eyg+c6hayQT2/qcoivgz2t+QKIVIJPg==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr202532iob.0.1712850133867;
        Thu, 11 Apr 2024 08:42:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 377/437] iio: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:37 -0600
Message-ID: <20240411153126.16201-378-axboe@kernel.dk>
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
 drivers/iio/iio_core.h            |  7 +++----
 drivers/iio/industrialio-buffer.c | 20 +++++++++---------
 drivers/iio/industrialio-core.c   | 34 +++++++++++++++----------------
 drivers/iio/industrialio-event.c  |  3 ++-
 4 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 1a38b1915e7a..8aac545ec4d0 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -11,6 +11,7 @@
 #define _IIO_CORE_H_
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/fs.h>
 
 struct iio_buffer;
 struct iio_chan_spec;
@@ -63,10 +64,8 @@ struct poll_table_struct;
 
 __poll_t iio_buffer_poll_wrapper(struct file *filp,
 				 struct poll_table_struct *wait);
-ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
-				size_t n, loff_t *f_ps);
-ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user *buf,
-				 size_t n, loff_t *f_ps);
+ssize_t iio_buffer_read_wrapper( struct kiocb *iocb, struct iov_iter *to);
+ssize_t iio_buffer_write_wrapper( struct kiocb *iocb, struct iov_iter *from);
 
 int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
 void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b581a7e80566..38a75f88adf6 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -163,6 +163,7 @@ static ssize_t iio_buffer_read(struct file *filp, char __user *buf,
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(iio_buffer_read);
 
 static size_t iio_buffer_space_available(struct iio_buffer *buf)
 {
@@ -225,6 +226,7 @@ static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
 
 	return ret < 0 ? ret : written;
 }
+FOPS_WRITE_ITER_HELPER(iio_buffer_write);
 
 /**
  * iio_buffer_poll() - poll the buffer to find out if it has data
@@ -261,30 +263,28 @@ static __poll_t iio_buffer_poll(struct file *filp,
 	return 0;
 }
 
-ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
-				size_t n, loff_t *f_ps)
+ssize_t iio_buffer_read_wrapper(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iio_dev_buffer_pair *ib = filp->private_data;
+	struct iio_dev_buffer_pair *ib = iocb->ki_filp->private_data;
 	struct iio_buffer *rb = ib->buffer;
 
 	/* check if buffer was opened through new API */
 	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
 		return -EBUSY;
 
-	return iio_buffer_read(filp, buf, n, f_ps);
+	return vfs_read_iter(iocb, to, iio_buffer_read);
 }
 
-ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user *buf,
-				 size_t n, loff_t *f_ps)
+ssize_t iio_buffer_write_wrapper(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct iio_dev_buffer_pair *ib = filp->private_data;
+	struct iio_dev_buffer_pair *ib = iocb->ki_filp->private_data;
 	struct iio_buffer *rb = ib->buffer;
 
 	/* check if buffer was opened through new API */
 	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
 		return -EBUSY;
 
-	return iio_buffer_write(filp, buf, n, f_ps);
+	return vfs_write_iter(iocb, from, iio_buffer_write);
 }
 
 __poll_t iio_buffer_poll_wrapper(struct file *filp,
@@ -1537,8 +1537,8 @@ static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
 static const struct file_operations iio_buffer_chrdev_fileops = {
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
-	.read = iio_buffer_read,
-	.write = iio_buffer_write,
+	.read_iter = iio_buffer_read_iter,
+	.write_iter = iio_buffer_write_iter,
 	.poll = iio_buffer_poll,
 	.release = iio_buffer_chrdev_release,
 };
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4302093b92c7..6bf6818e505c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -369,18 +369,17 @@ static void __exit iio_exit(void)
 }
 
 #if defined(CONFIG_DEBUG_FS)
-static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
-			      size_t count, loff_t *ppos)
+static ssize_t iio_debugfs_read_reg(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iio_dev *indio_dev = file->private_data;
+	struct iio_dev *indio_dev = iocb->ki_filp->private_data;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	unsigned int val = 0;
 	int ret;
 
-	if (*ppos > 0)
-		return simple_read_from_buffer(userbuf, count, ppos,
-					       iio_dev_opaque->read_buf,
-					       iio_dev_opaque->read_buf_len);
+	if (iocb->ki_pos > 0)
+		return simple_copy_to_iter(iio_dev_opaque->read_buf,
+					   &iocb->ki_pos,
+					   iio_dev_opaque->read_buf_len, to);
 
 	ret = indio_dev->info->debugfs_reg_access(indio_dev,
 						  iio_dev_opaque->cached_reg_addr,
@@ -394,22 +393,21 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 						sizeof(iio_dev_opaque->read_buf),
 						"0x%X\n", val);
 
-	return simple_read_from_buffer(userbuf, count, ppos,
-				       iio_dev_opaque->read_buf,
-				       iio_dev_opaque->read_buf_len);
+	return simple_copy_to_iter(iio_dev_opaque->read_buf, &iocb->ki_pos,
+				       iio_dev_opaque->read_buf_len, to);
 }
 
-static ssize_t iio_debugfs_write_reg(struct file *file,
-		     const char __user *userbuf, size_t count, loff_t *ppos)
+static ssize_t iio_debugfs_write_reg(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct iio_dev *indio_dev = file->private_data;
+	struct iio_dev *indio_dev = iocb->ki_filp->private_data;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	size_t count = iov_iter_count(from);
 	unsigned int reg, val;
 	char buf[80];
 	int ret;
 
 	count = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	buf[count] = 0;
@@ -439,8 +437,8 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 
 static const struct file_operations iio_debugfs_reg_fops = {
 	.open = simple_open,
-	.read = iio_debugfs_read_reg,
-	.write = iio_debugfs_write_reg,
+	.read_iter = iio_debugfs_read_reg,
+	.write_iter = iio_debugfs_write_reg,
 };
 
 static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
@@ -1839,8 +1837,8 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 static const struct file_operations iio_buffer_fileops = {
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
-	.read = iio_buffer_read_outer_addr,
-	.write = iio_buffer_write_outer_addr,
+	.read_iter = iio_buffer_read_outer_addr,
+	.write_iter = iio_buffer_write_outer_addr,
 	.poll = iio_buffer_poll_addr,
 	.unlocked_ioctl = iio_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 910c1f14abd5..b6ce1ac1d1ca 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -167,6 +167,7 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 
 	return copied;
 }
+FOPS_READ_ITER_HELPER(iio_event_chrdev_read);
 
 static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 {
@@ -182,7 +183,7 @@ static int iio_event_chrdev_release(struct inode *inode, struct file *filep)
 }
 
 static const struct file_operations iio_event_chrdev_fileops = {
-	.read =  iio_event_chrdev_read,
+	.read_iter =  iio_event_chrdev_read_iter,
 	.poll =  iio_event_poll,
 	.release = iio_event_chrdev_release,
 	.owner = THIS_MODULE,
-- 
2.43.0


