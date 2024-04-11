Return-Path: <linux-kernel+bounces-140930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE358A19AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94261C225DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0E1C6890;
	Thu, 11 Apr 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u9+9jIBu"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D51C2324
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849777; cv=none; b=hj8FrwsM5BTGuMYhddCi6fkkk9yTjCYrWZI3xInmlz+Cfcoy8PU7pD/UastlsdMiPM3bk5QhLjF9bwPvn0OG+LmGuDwIoRxB55GGKFHa5TYrj2ZSI5Jpot5k8ZaZtNhm5JaIWTzQj3owCr50LG/Xw7qOtPhrof2uG60syqH1Kcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849777; c=relaxed/simple;
	bh=ISBdg+ViLwWRx11BXE9o/rqRrX42qLFfD7iOm+Nfqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ow+evnU5pC+qm5PX+8wfzfx5hBEsV9oz5ZV+p7MUJL7c7lJB+SRc7urQBwob97nWwsuzBl2k01+dagU711i4Xl7y+MgdAGSoBHQH/K7nHeq8+vZGTZCQ16PISNtJFT8ZK6jSm8uKecDLmTZWDD0wR8+r5tzwg2cOoAe8RrXwIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u9+9jIBu; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58074939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849775; x=1713454575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+weEyOvy9CnYy06W/XGJXPiUa/KuSqJLTOLgcqE6BvI=;
        b=u9+9jIBu8+kkGc/eoNVgNfr8qn4+fGgRJ5vjwFVoLgnygQ3aiByMGF9GnK8W3ILBJa
         SnRJGzgmojjHApl9i4E6laPtOCQEMLZGIIPi1munWcIoLHurMpj/O79POnJ8t/Ifctsx
         az1MAmo8IsjJRsXv0XMWVAD/VF8fAUHRUrgCrdD0QAQdQkVzAbKqQxUNodWjoqD0Qcik
         LhqajDO7QqLDPyUQAihX1TxydXYAOl9G0TklOVc/xaSJO1pfn21Awhe52eOLu8dURPeB
         Uefp2Ykofv07HLGIiPAJJaYePJX8WvYbYmcOp+VLr7ahSFyhxlvxONXMJnMkRivtCOzl
         gqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849775; x=1713454575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+weEyOvy9CnYy06W/XGJXPiUa/KuSqJLTOLgcqE6BvI=;
        b=E/ZvzPJaAVOjv/19ARguO/uM2IVwR4frK7DkM+h9UA4HLguc7bJbhfpLCkWD2VSP2E
         E0pVhJG1hp7oPvA88TTwAAsHZFwzVXDaz0FsVmWOPBe7j79dSP3MrSekxbwPjJRIHJHo
         Xncl1H1O7ErGe5kuCXY982lWKAE+q/mni0+0DME7smFfxbe6rpnxrFcWX6DKKePrigBR
         55trwenv4PSHFd15IKELxZ8S8+ybE7OETLNFZckVAN2NdV5OO0GD1K00tsKI1niozDt7
         8LkRKxPhwobonHYhlEIBARxnZuvtMWgLAZYJAEtOyHG+X3K8QbWReVmWRVP5qhyJx0zS
         80dw==
X-Gm-Message-State: AOJu0YzU4AgeC2vLF42ATPxuo8kSkRc++bfdzsR15sE+C2kc4iyxX5y6
	4/f4ZfjOWgKIIWYJbM6DuxrwrTUctoBquLYT/dvqsmgwLnqI70n2yApsHdCJKVPMb7miL+M8EtN
	g
X-Google-Smtp-Source: AGHT+IGdVKrO++8guGRIpZur7pdvmmrS1LnNRDDwV8dTiFYe3YdS0UWF1orUngBLo7aiF990/jncaQ==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr161234ioh.1.1712849775054;
        Thu, 11 Apr 2024 08:36:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 162/437] usb: gadget: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:02 -0600
Message-ID: <20240411153126.16201-163-axboe@kernel.dk>
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
 drivers/usb/gadget/function/f_fs.c      |  6 ++++--
 drivers/usb/gadget/function/f_hid.c     | 17 ++++++++--------
 drivers/usb/gadget/function/f_printer.c | 26 ++++++++++++-------------
 drivers/usb/gadget/legacy/inode.c       |  6 ++++--
 drivers/usb/gadget/udc/renesas_usb3.c   | 14 ++++++-------
 5 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index bffbc1dc651f..e3514d295e55 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -495,6 +495,7 @@ static ssize_t ffs_ep0_write(struct file *file, const char __user *buf,
 	mutex_unlock(&ffs->mutex);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(ffs_ep0_write);
 
 /* Called with ffs->ev.waitq.lock and ffs->mutex held, both released on exit. */
 static ssize_t __ffs_ep0_read_events(struct ffs_data *ffs, char __user *buf,
@@ -632,6 +633,7 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 	kfree(data);
 	return ret;
 }
+FOPS_READ_ITER_HELPER(ffs_ep0_read);
 
 static int ffs_ep0_open(struct inode *inode, struct file *file)
 {
@@ -720,8 +722,8 @@ static const struct file_operations ffs_ep0_operations = {
 	.llseek =	no_llseek,
 
 	.open =		ffs_ep0_open,
-	.write =	ffs_ep0_write,
-	.read =		ffs_ep0_read,
+	.write_iter =	ffs_ep0_write_iter,
+	.read_iter =	ffs_ep0_read_iter,
 	.release =	ffs_ep0_release,
 	.unlocked_ioctl =	ffs_ep0_ioctl,
 	.poll =		ffs_ep0_poll,
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 3c8a9dd585c0..13e5bab6e1b2 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -414,6 +414,7 @@ static ssize_t f_hidg_read(struct file *file, char __user *buffer,
 	else
 		return f_hidg_ssreport_read(file, buffer, count, ptr);
 }
+FOPS_READ_ITER_HELPER(f_hidg_read);
 
 static void f_hidg_req_complete(struct usb_ep *ep, struct usb_request *req)
 {
@@ -431,10 +432,10 @@ static void f_hidg_req_complete(struct usb_ep *ep, struct usb_request *req)
 	wake_up(&hidg->write_queue);
 }
 
-static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
-			    size_t count, loff_t *offp)
+static ssize_t f_hidg_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct f_hidg *hidg  = file->private_data;
+	struct f_hidg *hidg  = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct usb_request *req;
 	unsigned long flags;
 	ssize_t status = -ENOMEM;
@@ -451,7 +452,7 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 	/* write queue */
 	while (!WRITE_COND) {
 		spin_unlock_irqrestore(&hidg->write_spinlock, flags);
-		if (file->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
 		if (wait_event_interruptible_exclusive(
@@ -473,8 +474,8 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 		goto release_write_pending;
 	}
 
-	status = copy_from_user(req->buf, buffer, count);
-	if (status != 0) {
+	status = copy_from_iter_full(req->buf, count, from);
+	if (!status) {
 		ERROR(hidg->func.config->cdev,
 			"copy_from_user error\n");
 		status = -EINVAL;
@@ -906,8 +907,8 @@ static const struct file_operations f_hidg_fops = {
 	.owner		= THIS_MODULE,
 	.open		= f_hidg_open,
 	.release	= f_hidg_release,
-	.write		= f_hidg_write,
-	.read		= f_hidg_read,
+	.write_iter	= f_hidg_write,
+	.read_iter	= f_hidg_read_iter,
 	.poll		= f_hidg_poll,
 	.llseek		= noop_llseek,
 };
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 076dd4c1be96..de3863f0bfb6 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -426,10 +426,10 @@ setup_rx_reqs(struct printer_dev *dev)
 	}
 }
 
-static ssize_t
-printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
+static ssize_t printer_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct printer_dev		*dev = fd->private_data;
+	struct printer_dev		*dev = iocb->ki_filp->private_data;
+	size_t				len = iov_iter_count(to);
 	unsigned long			flags;
 	size_t				size;
 	size_t				bytes_copied;
@@ -485,7 +485,7 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		 * If no data is available check if this is a NON-Blocking
 		 * call or not.
 		 */
-		if (fd->f_flags & (O_NONBLOCK|O_NDELAY)) {
+		if (iocb->ki_filp->f_flags & (O_NONBLOCK|O_NDELAY)) {
 			mutex_unlock(&dev->lock_printer_io);
 			return -EAGAIN;
 		}
@@ -522,10 +522,9 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		else
 			size = len;
 
-		size -= copy_to_user(buf, current_rx_buf, size);
+		size -= copy_to_iter(current_rx_buf, size, to);
 		bytes_copied += size;
 		len -= size;
-		buf += size;
 
 		spin_lock_irqsave(&dev->lock, flags);
 
@@ -568,10 +567,10 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 		return -EAGAIN;
 }
 
-static ssize_t
-printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
+static ssize_t printer_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct printer_dev	*dev = fd->private_data;
+	struct printer_dev	*dev = iocb->ki_filp->private_data;
+	size_t			len = iov_iter_count(from);
 	unsigned long		flags;
 	size_t			size;	/* Amount of data in a TX request. */
 	size_t			bytes_copied = 0;
@@ -604,7 +603,7 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 		 * If write buffers are available check if this is
 		 * a NON-Blocking call or not.
 		 */
-		if (fd->f_flags & (O_NONBLOCK|O_NDELAY)) {
+		if (iocb->ki_filp->f_flags & (O_NONBLOCK|O_NDELAY)) {
 			mutex_unlock(&dev->lock_printer_io);
 			return -EAGAIN;
 		}
@@ -642,7 +641,7 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 		/* Don't leave irqs off while doing memory copies */
 		spin_unlock_irqrestore(&dev->lock, flags);
 
-		if (copy_from_user(req->buf, buf, size)) {
+		if (!copy_from_iter_full(req->buf, size, from)) {
 			list_add(&req->list, &dev->tx_reqs);
 			mutex_unlock(&dev->lock_printer_io);
 			return bytes_copied;
@@ -650,7 +649,6 @@ printer_write(struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 
 		bytes_copied += size;
 		len -= size;
-		buf += size;
 
 		spin_lock_irqsave(&dev->lock, flags);
 
@@ -794,8 +792,8 @@ printer_ioctl(struct file *fd, unsigned int code, unsigned long arg)
 static const struct file_operations printer_io_operations = {
 	.owner =	THIS_MODULE,
 	.open =		printer_open,
-	.read =		printer_read,
-	.write =	printer_write,
+	.read_iter =	printer_read,
+	.write_iter =	printer_write,
 	.fsync =	printer_fsync,
 	.poll =		printer_poll,
 	.unlocked_ioctl = printer_ioctl,
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 03179b1880fd..2898840a7a41 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1080,6 +1080,7 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
 	spin_unlock_irq (&dev->lock);
 	return retval;
 }
+FOPS_READ_ITER_HELPER(ep0_read);
 
 static struct usb_gadgetfs_event *
 next_event (struct dev_data *dev, enum usb_gadgetfs_event_type type)
@@ -1919,6 +1920,7 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	dev->buf = NULL;
 	return value;
 }
+FOPS_WRITE_ITER_HELPER(dev_config);
 
 static int
 gadget_dev_open (struct inode *inode, struct file *fd)
@@ -1942,8 +1944,8 @@ static const struct file_operations ep0_operations = {
 	.llseek =	no_llseek,
 
 	.open =		gadget_dev_open,
-	.read =		ep0_read,
-	.write =	dev_config,
+	.read_iter =	ep0_read_iter,
+	.write_iter =	dev_config_iter,
 	.fasync =	ep0_fasync,
 	.poll =		ep0_poll,
 	.unlocked_ioctl = gadget_dev_ioctl,
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 3b01734ce1b7..61f5d7ac47ee 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2603,18 +2603,18 @@ static int renesas_usb3_b_device_open(struct inode *inode, struct file *file)
 	return single_open(file, renesas_usb3_b_device_show, inode->i_private);
 }
 
-static ssize_t renesas_usb3_b_device_write(struct file *file,
-					   const char __user *ubuf,
-					   size_t count, loff_t *ppos)
+static ssize_t renesas_usb3_b_device_write(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
 	struct renesas_usb3 *usb3 = s->private;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 
 	if (!usb3->driver)
 		return -ENODEV;
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	usb3->start_to_connect = false;
@@ -2637,8 +2637,8 @@ static ssize_t renesas_usb3_b_device_write(struct file *file,
 
 static const struct file_operations renesas_usb3_b_device_fops = {
 	.open = renesas_usb3_b_device_open,
-	.write = renesas_usb3_b_device_write,
-	.read = seq_read,
+	.write_iter = renesas_usb3_b_device_write,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


