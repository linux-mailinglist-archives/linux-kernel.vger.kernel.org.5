Return-Path: <linux-kernel+bounces-140794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEA58A1901
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418C5287CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801FD3D0B8;
	Thu, 11 Apr 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JsPikQp6"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC3417C67
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849554; cv=none; b=QNdtmFpGsFjE8ANhbHYFGcdH2zt0Dkrp2XcB3U7ZZGlkP269fsyajmfbTao+cpkFmG7EusBxPOJM7p6JTdC/+eaGNsPn0xqDnieKbkCsVBNKu9tUBDaNIdBiJFl840gNtGqhHRzfuisPRsxyeA5NMKb6IUYciaupe4zeZwJtOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849554; c=relaxed/simple;
	bh=5waGzhPfxcYMyEQe8vjz+F5by7BxB/NYC2CPV/ITVvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUwFF5lExZfHHR1vH3M5YpXVRYk///JgtFhYwuUq3TSViHs+kzMDxK6p+8/HOwL9OvYpqb+VISddHHKo/CVWb+0b1lGjNkF2GiAjIxBjJdJm9ZwxpERACtZHJLoz3A2sgxMKeN4SotlFgSq5VbolK5d2W7Oi8jOEmSboBGCoWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JsPikQp6; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170426739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849552; x=1713454352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q7u9ARrFRJwgUS99j58MVftKILdlOB1OHFa7KdtmDQ=;
        b=JsPikQp6WEFuQHt4qlqvHJ4FPIHza7neMbSNEErS/XSdXYv25rXm/oTjMN/8xHH6Cz
         ysfV7aD4Vkxek/URvEQ+1HneH+n8y7MVOWct650A9zFT4hAsVNgb/IMsXawi+FEUAuBK
         GAXf8/uIwz8iB3Bfm2ICIuYiFBcDxpYekDDn/3TdCrB5YxT1En0ysYX6D/c24arT2jMt
         l/+k6UA4posqzl7zlFDODLybtqjHaKGFw3ty+g3+XDCevMqVag53+6rMOqrrT/EQ548j
         1O/wpDw5GEGSNxgM4GEHn0aGuRsaEk53wvwiNr3gP1cx7POtd8uxE6pddoImPymHj7fv
         1OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849552; x=1713454352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+q7u9ARrFRJwgUS99j58MVftKILdlOB1OHFa7KdtmDQ=;
        b=lKzwcwHYE73HYHnY65w+fbZyh4Xa4uEwLS9j4oxOZ0Z7TUdlIwjbxwZWFVUzmeoZyp
         NxaW5nqs9q4AAxi/1P7QM6dkvxCzujgwALzie5LkPEdWG0J2EnEeWG2x/rCLAEOZpx7g
         vuNLCOjzFUpopsXeoKbJS/j7ARci92UCNC+6RZRqv1r38+/aT5vQy0xD+JlXQK3P/MUp
         +ygMxX81PFjszmcrcNwdcwoPi9XeTw1dcYNYv5o24EorxgQcU/WeGcvBjxR3IXbY0LoM
         tb7ybB6nowH0g8lb6wZwQODQ0nQgS8Pzsaj6egkOTkQy7fW+hUh0uGEsLELSd9Ha/QQ6
         9sfw==
X-Gm-Message-State: AOJu0YzGOJAAtaVrrc0KxtBlxQfePeMQ0IDe138Qbk5jl3qzdmyo7c9z
	ykcZHKa4B0EiA5mEOn3RbL6L3vSpDTMdHwJ4/cg+14IYdmtZzviATVVYLoyngPWam2AbTzOkbmN
	8
X-Google-Smtp-Source: AGHT+IEqUNN+ZQGoYQHBLASoooFU2dNlekNECIPSkWWgEAg1MBePAzsdCJr4LDi1NMhI12+yppJeuQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr4272ioc.1.1712849551993;
        Thu, 11 Apr 2024 08:32:31 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 037/437] char/xillybus: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:57 -0600
Message-ID: <20240411153126.16201-38-axboe@kernel.dk>
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
 drivers/char/xillybus/xillybus_core.c | 36 +++++++++++++--------------
 drivers/char/xillybus/xillyusb.c      |  6 +++--
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_core.c b/drivers/char/xillybus/xillybus_core.c
index 11b7c4749274..d2f85c01bb74 100644
--- a/drivers/char/xillybus/xillybus_core.c
+++ b/drivers/char/xillybus/xillybus_core.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/uio.h>
 #include "xillybus.h"
 #include "xillybus_class.h"
 
@@ -687,15 +688,15 @@ static int xilly_obtain_idt(struct xilly_endpoint *endpoint)
 	return 0;
 }
 
-static ssize_t xillybus_read(struct file *filp, char __user *userbuf,
-			     size_t count, loff_t *f_pos)
+static ssize_t xillybus_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	ssize_t rc;
 	unsigned long flags;
 	int bytes_done = 0;
 	int no_time_left = 0;
 	long deadline, left_to_sleep;
-	struct xilly_channel *channel = filp->private_data;
+	struct xilly_channel *channel = iocb->ki_filp->private_data;
 
 	int empty, reached_eof, exhausted, ready;
 	/* Initializations are there only to silence warnings */
@@ -775,13 +776,11 @@ static ssize_t xillybus_read(struct file *filp, char __user *userbuf,
 							channel->wr_buf_size,
 							DMA_FROM_DEVICE);
 
-			if (copy_to_user(
-				    userbuf,
+			if (!copy_to_iter_full(
 				    channel->wr_buffers[bufidx]->addr
-				    + bufpos, howmany))
+				    + bufpos, howmany, to))
 				rc = -EFAULT;
 
-			userbuf += howmany;
 			bytes_done += howmany;
 
 			if (bufferdone) {
@@ -831,7 +830,7 @@ static ssize_t xillybus_read(struct file *filp, char __user *userbuf,
 		 * nonblocking mode, but only for a very short time.
 		 */
 
-		if (!no_time_left && (filp->f_flags & O_NONBLOCK)) {
+		if (!no_time_left && (iocb->ki_filp->f_flags & O_NONBLOCK)) {
 			if (bytes_done > 0)
 				break;
 
@@ -933,7 +932,7 @@ static ssize_t xillybus_read(struct file *filp, char __user *userbuf,
 				return -EIO;
 			if (bytes_done)
 				return bytes_done;
-			if (filp->f_flags & O_NONBLOCK)
+			if (iocb->ki_filp->f_flags & O_NONBLOCK)
 				return -EAGAIN; /* Don't admit snoozing */
 			return -EINTR;
 		}
@@ -1199,13 +1198,13 @@ static void xillybus_autoflush(struct work_struct *work)
 			"Autoflush failed under weird circumstances.\n");
 }
 
-static ssize_t xillybus_write(struct file *filp, const char __user *userbuf,
-			      size_t count, loff_t *f_pos)
+static ssize_t xillybus_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	ssize_t rc;
 	unsigned long flags;
 	int bytes_done = 0;
-	struct xilly_channel *channel = filp->private_data;
+	struct xilly_channel *channel = iocb->ki_filp->private_data;
 
 	int full, exhausted;
 	/* Initializations are there only to silence warnings */
@@ -1319,12 +1318,11 @@ static ssize_t xillybus_write(struct file *filp, const char __user *userbuf,
 				channel->rd_leftovers[3] = 0; /* Clear flag */
 			}
 
-			if (copy_from_user(
+			if (!copy_from_iter_full(
 				    channel->rd_buffers[bufidx]->addr + bufpos,
-				    userbuf, howmany))
+				    howmany, from))
 				rc = -EFAULT;
 
-			userbuf += howmany;
 			bytes_done += howmany;
 
 			if (bufferdone) {
@@ -1383,7 +1381,7 @@ static ssize_t xillybus_write(struct file *filp, const char __user *userbuf,
 		 * sleeps.
 		 */
 
-		if (filp->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			rc = -EAGAIN;
 			break;
 		}
@@ -1415,7 +1413,7 @@ static ssize_t xillybus_write(struct file *filp, const char __user *userbuf,
 		return rc;
 
 	if ((channel->rd_synchronous) && (bytes_done > 0)) {
-		rc = xillybus_myflush(filp->private_data, 0); /* No timeout */
+		rc = xillybus_myflush(channel, 0); /* No timeout */
 
 		if (rc && (rc != -EINTR))
 			return rc;
@@ -1793,8 +1791,8 @@ static __poll_t xillybus_poll(struct file *filp, poll_table *wait)
 
 static const struct file_operations xillybus_fops = {
 	.owner      = THIS_MODULE,
-	.read       = xillybus_read,
-	.write      = xillybus_write,
+	.read_iter  = xillybus_read,
+	.write_iter = xillybus_write,
 	.open       = xillybus_open,
 	.flush      = xillybus_flush,
 	.release    = xillybus_release,
diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 5a5afa14ca8c..7a3aad47aabc 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -1605,6 +1605,7 @@ static ssize_t xillyusb_read(struct file *filp, char __user *userbuf,
 
 	return rc;
 }
+FOPS_READ_ITER_HELPER(xillyusb_read);
 
 static int xillyusb_flush(struct file *filp, fl_owner_t id)
 {
@@ -1705,6 +1706,7 @@ static ssize_t xillyusb_write(struct file *filp, const char __user *userbuf,
 
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(xillyusb_write);
 
 static int xillyusb_release(struct inode *inode, struct file *filp)
 {
@@ -1895,8 +1897,8 @@ static __poll_t xillyusb_poll(struct file *filp, poll_table *wait)
 
 static const struct file_operations xillyusb_fops = {
 	.owner      = THIS_MODULE,
-	.read       = xillyusb_read,
-	.write      = xillyusb_write,
+	.read_iter  = xillyusb_read_iter,
+	.write_iter = xillyusb_write_iter,
 	.open       = xillyusb_open,
 	.flush      = xillyusb_flush,
 	.release    = xillyusb_release,
-- 
2.43.0


