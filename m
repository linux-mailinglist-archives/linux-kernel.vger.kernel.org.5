Return-Path: <linux-kernel+bounces-140874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094238A1950
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B3C284BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E686615219C;
	Thu, 11 Apr 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZWFq2oSr"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA41514CC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849690; cv=none; b=P/VzIbgf2hGhv6xt8NYPl4l4RyD/BVMFcg9N0RE2aipGhhXGqggUgZ/U3+cg/zH8M1aPnbSEMBEMA6iDz/jlCP68vMQCLCNJTvlLCv6Oiq6WiJKDO8pOMHCXf1pY53fvaJyHGj7dFzb1f9cs+GSDdbRdvX8RfOz04vh4RRYd7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849690; c=relaxed/simple;
	bh=wjPbRD+SxzfVOSuUJ+DZj7X2BEm3PyDEY0MdcUM6Ssk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMSxZi2ToaFNBO5x4zT6L+iqr7PyIGT4oP2rZxi0KHdTez8XkB/dVZhhERdDZTnyXa1OpGOtdGA32NhxZQDyWIkzjDpMTR7tGqht4m5tg7qkV7z0MLhy4Vstx/3E+WnIAqAQPzdTiy86dSRO4Fsn80wokdYUANVstfhE17XuJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZWFq2oSr; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58028939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849688; x=1713454488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxOEKYmjmqxvph5eRX+z+JQl4yii6xdSIwuuep0YMHY=;
        b=ZWFq2oSrlZ2y5xs21Luz6L9yVk4lwgzm71A+qoC8cG2Idcc6nVROPIGwMrHhmps2nb
         gKzbhKopw8QT8IXvjrnc8jvRrySpWXLLm00/aZhq9B3tV/5Pl8W9+G2tA28eGTWf5gXA
         2XyuYtei1tE750MpFADTILmkIlTdmfphf8ODNh/uoVfBYe9gEHOJexlWUGzmtmLlit0J
         ommRfmfSEa8RbmtdCt+4s0FtqmZHNJ6Ht6x3YaqmqEwEbrheMKLW7wd6gcJ+nUOpInKh
         C9O12N3dJmyvcrxV7Zx2WEgi2EVRtw+mxsn3ZMgItFcrNQglSSAtOEAYW8aJ6aB0Ly/i
         RdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849688; x=1713454488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxOEKYmjmqxvph5eRX+z+JQl4yii6xdSIwuuep0YMHY=;
        b=oWs5RgqRp78ialGDpGsCbsMZOWcDjxblKt82Ncbu5TK5yYiBKEXt7jYO4gcVPfwZA2
         JVXg0zBbWpoFa4I03o2uBmhBa/6f3+hjWH2Blbpbq7eC1QYNX8NJbeQ/uIRT/2m310Uj
         YOETYA85EoDdoNlTIKXvsp1axOX5PBGlqXFyS/NOI3RZE4RxrfLvkWWqlwi2Q0KaaRQX
         wjvcgyZ7sHd7r60BkM7m3Z6d9ZFsWIyJATBuc+7a+WKySAKvsAzbQ0N+9mFCkTeWwjlz
         CgBCfBHcC2IkzAWG2cy8xaUsSHz1PX490xRwChKf7L/5EI6IG+noA2nLzg2FONQJnnl0
         ZHpA==
X-Gm-Message-State: AOJu0Yxv6Nv2aZI80UEoDg+dzJ9+NB5lE/nNmuRJimUGvav/CpkRRpT4
	6kqh/ZEOLTjd4Dxpe13EwLYbavlqaFopivdVLIaemz7Y2RfWDTBRcmoGurXuXjuLz/y/4mYwQXR
	M
X-Google-Smtp-Source: AGHT+IG6VcFcbYSmPuk/QQx1paNFOrXzfLVr/w1cPc/RoPbI/VZ74sVjzQRExzYlh9VYjZL1XKLHgA==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr202361iog.0.1712849688286;
        Thu, 11 Apr 2024 08:34:48 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 111/437] drivers/gpio: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:14:11 -0600
Message-ID: <20240411153126.16201-112-axboe@kernel.dk>
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
 drivers/gpio/gpio-mockup.c  | 26 +++++++++++------------
 drivers/gpio/gpiolib-cdev.c | 41 ++++++++++++++++++-------------------
 2 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 455eecf6380e..34fc0f921284 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -265,9 +265,7 @@ static void gpio_mockup_free(struct gpio_chip *gc, unsigned int offset)
 	__gpio_mockup_set(chip, offset, chip->lines[offset].pull);
 }
 
-static ssize_t gpio_mockup_debugfs_read(struct file *file,
-					char __user *usr_buf,
-					size_t size, loff_t *ppos)
+static ssize_t gpio_mockup_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct gpio_mockup_dbgfs_private *priv;
 	struct gpio_mockup_chip *chip;
@@ -276,10 +274,10 @@ static ssize_t gpio_mockup_debugfs_read(struct file *file,
 	int val, cnt;
 	char buf[3];
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
-	sfile = file->private_data;
+	sfile = iocb->ki_filp->private_data;
 	priv = sfile->private;
 	chip = priv->chip;
 	gc = &chip->gc;
@@ -287,27 +285,27 @@ static ssize_t gpio_mockup_debugfs_read(struct file *file,
 	val = gpio_mockup_get(gc, priv->offset);
 	cnt = snprintf(buf, sizeof(buf), "%d\n", val);
 
-	return simple_read_from_buffer(usr_buf, size, ppos, buf, cnt);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, cnt, to);
 }
 
-static ssize_t gpio_mockup_debugfs_write(struct file *file,
-					 const char __user *usr_buf,
-					 size_t size, loff_t *ppos)
+static ssize_t gpio_mockup_debugfs_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
 	struct gpio_mockup_dbgfs_private *priv;
+	size_t size = iov_iter_count(from);
 	int rv, val;
 	struct seq_file *sfile;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return -EINVAL;
 
-	rv = kstrtoint_from_user(usr_buf, size, 0, &val);
+	rv = kstrtoint_from_iter(from, size, 0, &val);
 	if (rv)
 		return rv;
 	if (val != 0 && val != 1)
 		return -EINVAL;
 
-	sfile = file->private_data;
+	sfile = iocb->ki_filp->private_data;
 	priv = sfile->private;
 	rv = gpio_mockup_apply_pull(priv->chip, priv->offset, val);
 	if (rv)
@@ -345,8 +343,8 @@ static int gpio_mockup_debugfs_open(struct inode *inode, struct file *file)
 static const struct file_operations gpio_mockup_debugfs_ops = {
 	.owner = THIS_MODULE,
 	.open = gpio_mockup_debugfs_open,
-	.read = gpio_mockup_debugfs_read,
-	.write = gpio_mockup_debugfs_write,
+	.read_iter = gpio_mockup_debugfs_read,
+	.write_iter = gpio_mockup_debugfs_write,
 	.llseek = no_llseek,
 	.release = single_release,
 };
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index d09c7d728365..25e054a42bb1 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1597,10 +1597,10 @@ static __poll_t linereq_poll(struct file *file,
 	return events;
 }
 
-static ssize_t linereq_read(struct file *file, char __user *buf,
-			    size_t count, loff_t *f_ps)
+static ssize_t linereq_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct linereq *lr = file->private_data;
+	struct linereq *lr = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct gpio_v2_line_event le;
 	ssize_t bytes_read = 0;
 	int ret;
@@ -1619,7 +1619,7 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 				if (bytes_read)
 					return bytes_read;
 
-				if (file->f_flags & O_NONBLOCK)
+				if (iocb->ki_filp->f_flags & O_NONBLOCK)
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(lr->wait,
@@ -1640,7 +1640,7 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 			break;
 		}
 
-		if (copy_to_user(buf + bytes_read, &le, sizeof(le)))
+		if (!copy_to_iter_full(&le, sizeof(le), to))
 			return -EFAULT;
 		bytes_read += sizeof(le);
 	} while (count >= bytes_read + sizeof(le));
@@ -1698,7 +1698,7 @@ static void linereq_show_fdinfo(struct seq_file *out, struct file *file)
 
 static const struct file_operations line_fileops = {
 	.release = linereq_release,
-	.read = linereq_read,
+	.read_iter = linereq_read,
 	.poll = linereq_poll,
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
@@ -1935,10 +1935,10 @@ struct compat_gpioeevent_data {
 	u32		id;
 };
 
-static ssize_t lineevent_read(struct file *file, char __user *buf,
-			      size_t count, loff_t *f_ps)
+static ssize_t lineevent_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lineevent_state *le = file->private_data;
+	struct lineevent_state *le = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct gpioevent_data ge;
 	ssize_t bytes_read = 0;
 	ssize_t ge_size;
@@ -1971,7 +1971,7 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 				if (bytes_read)
 					return bytes_read;
 
-				if (file->f_flags & O_NONBLOCK)
+				if (iocb->ki_filp->f_flags & O_NONBLOCK)
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(le->wait,
@@ -1992,7 +1992,7 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 			break;
 		}
 
-		if (copy_to_user(buf + bytes_read, &ge, ge_size))
+		if (!copy_to_iter_full(&ge, ge_size, to))
 			return -EFAULT;
 		bytes_read += ge_size;
 	} while (count >= bytes_read + ge_size);
@@ -2064,7 +2064,7 @@ static long lineevent_ioctl_compat(struct file *file, unsigned int cmd,
 
 static const struct file_operations lineevent_fileops = {
 	.release = lineevent_release,
-	.read = lineevent_read,
+	.read_iter = lineevent_read,
 	.poll = lineevent_poll,
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
@@ -2649,11 +2649,11 @@ static __poll_t lineinfo_watch_poll(struct file *file,
 	return events;
 }
 
-static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
-				   size_t count, loff_t *off)
+static ssize_t lineinfo_watch_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct gpio_chardev_data *cdev = file->private_data;
+	struct gpio_chardev_data *cdev = iocb->ki_filp->private_data;
 	struct gpio_v2_line_info_changed event;
+	size_t count = iov_iter_count(to);
 	ssize_t bytes_read = 0;
 	int ret;
 	size_t event_size;
@@ -2675,7 +2675,7 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 				if (bytes_read)
 					return bytes_read;
 
-				if (file->f_flags & O_NONBLOCK)
+				if (iocb->ki_filp->f_flags & O_NONBLOCK)
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(cdev->wait,
@@ -2702,18 +2702,17 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 
 #ifdef CONFIG_GPIO_CDEV_V1
 		if (event_size == sizeof(struct gpio_v2_line_info_changed)) {
-			if (copy_to_user(buf + bytes_read, &event, event_size))
+			if (!copy_to_iter_full(&event, event_size, to))
 				return -EFAULT;
 		} else {
 			struct gpioline_info_changed event_v1;
 
 			gpio_v2_line_info_changed_to_v1(&event, &event_v1);
-			if (copy_to_user(buf + bytes_read, &event_v1,
-					 event_size))
+			if (!copy_to_iter_full(&event_v1, event_size, to))
 				return -EFAULT;
 		}
 #else
-		if (copy_to_user(buf + bytes_read, &event, event_size))
+		if (!copy_to_iter_full(&event, event_size, to))
 			return -EFAULT;
 #endif
 		bytes_read += event_size;
@@ -2814,7 +2813,7 @@ static const struct file_operations gpio_fileops = {
 	.release = gpio_chrdev_release,
 	.open = gpio_chrdev_open,
 	.poll = lineinfo_watch_poll,
-	.read = lineinfo_watch_read,
+	.read_iter = lineinfo_watch_read,
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.unlocked_ioctl = gpio_ioctl,
-- 
2.43.0


