Return-Path: <linux-kernel+bounces-140810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7398A190E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335991C20F06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273D85FBAA;
	Thu, 11 Apr 2024 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="c4zFXziB"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697E69D2C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849589; cv=none; b=u4Y6LGz5zGeY81p0HKPArL/zSDibIkdnxiXkxEJkqQFhfFKDKZitlFT8uigqX6xu7UCVrqc6DUZB5bJ6j2ppF7+i652qbkVScV8Y0u1eY9ryOxf2em3mpWTU1BF/eCzmjV6p6RlV60UiMOIQAHUrPtOjDsVTix/xo7iCf/ckgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849589; c=relaxed/simple;
	bh=M+7fxfPhgKLnD8LbIhts9aMTRx5G6pM5NvUn5ahRO4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiMLzogkElbwDpjVlanz+Ef9Z91TEvzwekOxcx/MF9oCCXde5uTiJLykmKwh4m1F2/vxq3esBuBP6thUiwl8d7yy0MEsCbsWUMiEtH4PIhBpn+h4P93oxFtiGvvOOkwthKzB5YlgDoIAQUCXEzs6PkTdWSU01tm82J568NkzBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=c4zFXziB; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso57966739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849586; x=1713454386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0IGfdOIPPmeBHN1Rz28VFhxzC+Bi4+cAJUVksCjDgs=;
        b=c4zFXziBLhg75SBqzqOJvNfDWubW2RzdMuS/9kAScPXUrAQ6SMskJj3jZkVnrijM3b
         ArvtGV636/kILb39/nSTnV+oARccTKirW56H+dbf21aIS9tRWcVqwF2GJObcxYcj6D1T
         aZ3oGrQHAb2S7BHwK85CwvD5KVAGDMUu5W5IUOiBrwVLvpsFv4IL0N8lEChlc16KAVTm
         2mZn7SdNUd7NK58gsYMLckuwrKUEgvujK93lWDlNH7c9rMhA5NF/pD1mDy48fPmSkSaV
         o29Hum/vqWFhjUdFh2mzx9CweQTrYkLgfuS/DuxQhH1h1Q/g+DtAJ3Kq7dbj7HtvzqsC
         hBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849586; x=1713454386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0IGfdOIPPmeBHN1Rz28VFhxzC+Bi4+cAJUVksCjDgs=;
        b=HB8u5vC/8/EEnN2mQ1quoHJfkcX+jg7SB4lh0bLswMQbWrDx2ZYL3trs8MWiDkQtWx
         XE/jWlYXV4fjaQehUch9bD2+GKnSsfUtvOjtrY02BLsWdUs/XZRgF0EhLncTKqAo1j0p
         6SuQyuZ4HMO2nq4+LofniPzjBnJGb4q/J+zeDoHSUXafnAyePXsLV70zHiphHw0nmxc8
         5/7LIRm0f+zdSPO2TYiyuNxBDG1Lr0gj6oW6ULIjGbP5MLwgkRGVRdRo4heJ6iuZ5Um3
         g2txL6uu7HRxSmnTXMKsZb9PyVoYVL/r17OPhWTNDF5M8K+OLHqY5Hvio7wbMVX7hzJZ
         5iSw==
X-Gm-Message-State: AOJu0YyO/WSgiBsX65bGejxWqaVFQ8HDMSK+OWnuilRROmCPl0BgzglQ
	X9fZmURhQG5Oy7PIJhtR72coeVC1GUxkbQgM7B1gAO21b0EZ4BVNvhKYIPg0/kuief6J4+1A3p2
	N
X-Google-Smtp-Source: AGHT+IFN9/+IJc+cOsx8ZC4d01Q8oHlMSChj50vecTIMfMi3bICzJ35xAFPEHG5yYOqsR4GVsSGkjg==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr200047iog.0.1712849586507;
        Thu, 11 Apr 2024 08:33:06 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 050/437] staging: convert drivers to read/write iterators
Date: Thu, 11 Apr 2024 09:13:10 -0600
Message-ID: <20240411153126.16201-51-axboe@kernel.dk>
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
 drivers/staging/axis-fifo/axis-fifo.c | 22 ++++++++++------------
 drivers/staging/pi433/pi433_if.c      | 13 +++++++------
 drivers/staging/vme_user/vme_user.c   |  6 ++++--
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index c51818c56dd2..ba8e08be0daf 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -345,10 +345,10 @@ static void reset_ip_core(struct axis_fifo *fifo)
  * Returns the number of bytes read from the device or negative error code
  *	on failure.
  */
-static ssize_t axis_fifo_read(struct file *f, char __user *buf,
-			      size_t len, loff_t *off)
+static ssize_t axis_fifo_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct axis_fifo *fifo = (struct axis_fifo *)f->private_data;
+	struct axis_fifo *fifo = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	size_t bytes_available;
 	unsigned int words_available;
 	unsigned int copied;
@@ -431,8 +431,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 					      XLLF_RDFD_OFFSET);
 		}
 
-		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
-				 copy * sizeof(u32))) {
+		if (!copy_to_iter_full(tmp_buf, copy * sizeof(u32), to)) {
 			reset_ip_core(fifo);
 			ret = -EFAULT;
 			goto end_unlock;
@@ -465,10 +464,10 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
  * Returns the number of bytes written to the device or negative error code
  *	on failure.
  */
-static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
-			       size_t len, loff_t *off)
+static ssize_t axis_fifo_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct axis_fifo *fifo = (struct axis_fifo *)f->private_data;
+	struct axis_fifo *fifo = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	unsigned int words_to_write;
 	unsigned int copied;
 	unsigned int copy;
@@ -540,8 +539,7 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 	while (words_to_write > 0) {
 		copy = min(words_to_write, WRITE_BUF_SIZE);
 
-		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
-				   copy * sizeof(u32))) {
+		if (!copy_from_iter_full(tmp_buf, copy * sizeof(u32), from)) {
 			reset_ip_core(fifo);
 			ret = -EFAULT;
 			goto end_unlock;
@@ -712,8 +710,8 @@ static const struct file_operations fops = {
 	.owner = THIS_MODULE,
 	.open = axis_fifo_open,
 	.release = axis_fifo_close,
-	.read = axis_fifo_read,
-	.write = axis_fifo_write
+	.read_iter = axis_fifo_read,
+	.write_iter = axis_fifo_write,
 };
 
 /* read named property from the device tree */
diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index b6c4917d515e..f6563e3a7603 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -765,11 +765,11 @@ static int pi433_tx_thread(void *data)
 
 /*-------------------------------------------------------------------------*/
 
-static ssize_t
-pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
+static ssize_t pi433_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
+	size_t			size = iov_iter_count(to);
 	int			bytes_received;
 	ssize_t			retval;
 
@@ -777,7 +777,7 @@ pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
 	if (size > MAX_MSG_SIZE)
 		return -EMSGSIZE;
 
-	instance = filp->private_data;
+	instance = iocb->ki_filp->private_data;
 	device = instance->device;
 
 	/* just one read request at a time */
@@ -802,7 +802,7 @@ pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
 
 	/* if read was successful copy to user space*/
 	if (bytes_received > 0) {
-		retval = copy_to_user(buf, device->rx_buffer, bytes_received);
+		retval = !copy_to_iter_full(device->rx_buffer, bytes_received, to);
 		if (retval)
 			return -EFAULT;
 	}
@@ -883,6 +883,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	mutex_unlock(&device->tx_fifo_lock);
 	return -EAGAIN;
 }
+FOPS_WRITE_ITER_HELPER(pi433_write);
 
 static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
@@ -1094,8 +1095,8 @@ static const struct file_operations pi433_fops = {
 	 * gets more complete API coverage.  It'll simplify things
 	 * too, except for the locking.
 	 */
-	.write =	pi433_write,
-	.read =		pi433_read,
+	.write_iter =	pi433_write_iter,
+	.read_iter =	pi433_read,
 	.unlocked_ioctl = pi433_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.open =		pi433_open,
diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 36183f923768..4ca38d0af25a 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -216,6 +216,7 @@ static ssize_t vme_user_read(struct file *file, char __user *buf, size_t count,
 
 	return retval;
 }
+FOPS_READ_ITER_HELPER(vme_user_read);
 
 static ssize_t vme_user_write(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
@@ -259,6 +260,7 @@ static ssize_t vme_user_write(struct file *file, const char __user *buf,
 
 	return retval;
 }
+FOPS_WRITE_ITER_HELPER(vme_user_write);
 
 static loff_t vme_user_llseek(struct file *file, loff_t off, int whence)
 {
@@ -492,8 +494,8 @@ static int vme_user_mmap(struct file *file, struct vm_area_struct *vma)
 }
 
 static const struct file_operations vme_user_fops = {
-	.read = vme_user_read,
-	.write = vme_user_write,
+	.read_iter = vme_user_read_iter,
+	.write_iter = vme_user_write_iter,
 	.llseek = vme_user_llseek,
 	.unlocked_ioctl = vme_user_unlocked_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
-- 
2.43.0


