Return-Path: <linux-kernel+bounces-140885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CE08A1960
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2949928756C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681092DF84;
	Thu, 11 Apr 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nr94BhZM"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E3158D95
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849708; cv=none; b=PwAYT3fJA2iYvcrSH7rxYuWQg/KHvqvTJKEH1p5o/5RolaRsxsiRFeafjuJkXe3xWmAk66sbyZAD/dVwt9lGK8uogN3hT38PxW96LMEAmTb63QOHP5zXhSnrg7OkEpfFOqftfnwJdIqg4/d+sBHAoC5ozUk+FZ/vGu1hcZxztZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849708; c=relaxed/simple;
	bh=Y2CuPnfNGCTlH89sPwvg5Qqu+KAOzE/jZXq27+ZlmTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYLJBA95MTkT2u4i1PxNrQIyr84/kbH8/y9of1mS1j5COSJLI24Ha7vSV3IPGQnJpPsaP6N9lhhDYqguujJ9FIkz6Q3BeBF8Ge37xA5qXa/MdEQsxsctQwXhKs3JcBMMBSI/V54088y8IRftazhKo8RrX83IafltpfHM8FK+LGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nr94BhZM; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8922739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849705; x=1713454505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jctYABsZiacNIUyvtBgQSkUe95IwzkHgR2PUGlrc25M=;
        b=Nr94BhZMJW3LQxH3W9dJ2M5jwZUXyi1nP1HcJYZm8QR1F5nJ8HK04lbDbHfomtGGBu
         1tnOUyqIuHD6ESycs14QVwDIb9awUamfapAtKHvQElQCzG/LLX5jyw59iv94CCc4gnpT
         CNlNseV9ZBdPDyWau9vOxVSMWfHoGMRiC8IQAC2U86LQL/vS0HEOtTABPmtu69eG24U1
         vT8kC3qJ0JVQmXAo6WmX7BZ32s4JEOSjnpYGxtyJeONVaKLjCebJa0/TDVa+JSAQlPk6
         67CBJmCxTJNVpMSawFIsKoVPqzFKCNFO9OHNLyj/p/1mQmpIR6fD5TMyi63B8LX0OUIm
         DkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849705; x=1713454505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jctYABsZiacNIUyvtBgQSkUe95IwzkHgR2PUGlrc25M=;
        b=CzRAHhBkcdhOaLsFnVQTzYw8hNutuYHgLmyz0+A3FbcN0UwYJfabN4jctF4gCAAOfy
         TAsk7O/nwaoo1PIlM4fRKfKBRLuIRVOrI/ls+kbD+C2KnNDDa/Tzwl0gkKuoOYrnfIRo
         0fROpigddSmqL2dPjAfGznm5fbmK8gH4dIqZWTw9e5OZPGleUiwENv/tTQkLPwBWYkEi
         fQQIgVPaKIa6HulddptBI8JgWCfVAy5U/ekvEHB+Ha54VN63EE9g5OPUQ2mdyQzA2dwz
         PfR6RYbggvni+IPqJgQhWIkar1EcC+qEETvmV1TEXRbj17PnxsR+ttXW5Xx9gx8P99Is
         D2Jg==
X-Gm-Message-State: AOJu0Yyp8gHD9HvjX4nwebsZtembU5uUwyW/n4g2cFqKO/W8W7SpPltD
	HlRtaMwEKDy/OIQGNOO6bpUu6GHfJuhgt2l7XL8ChG8ZfGGs1F6LN01yWKwXiqphDqg7RyXiHgU
	S
X-Google-Smtp-Source: AGHT+IF9gFig6M+UH9WnMfXESZo6hf1MnyyC+bzgiTIP7ZEz+OCipcMpgkovUtXNnZ/hCbTaC+ccNA==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr219626ioh.0.1712849705156;
        Thu, 11 Apr 2024 08:35:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 121/437] drivers/input: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:21 -0600
Message-ID: <20240411153126.16201-122-axboe@kernel.dk>
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
 drivers/input/evdev.c                  |  6 ++++--
 drivers/input/joydev.c                 | 22 +++++++++++-----------
 drivers/input/keyboard/applespi.c      | 11 +++++------
 drivers/input/misc/uinput.c            |  6 ++++--
 drivers/input/mousedev.c               | 16 +++++++++-------
 drivers/input/serio/serio_raw.c        |  6 ++++--
 drivers/input/serio/userio.c           | 22 +++++++++++-----------
 drivers/input/touchscreen/edt-ft5x06.c | 19 ++++++++++---------
 8 files changed, 58 insertions(+), 50 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 51e0c4954600..9f41631df926 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -536,6 +536,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
 	mutex_unlock(&evdev->mutex);
 	return retval;
 }
+FOPS_WRITE_ITER_HELPER(evdev_write);
 
 static int evdev_fetch_next_event(struct evdev_client *client,
 				  struct input_event *event)
@@ -605,6 +606,7 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
 
 	return read;
 }
+FOPS_READ_ITER_HELPER(evdev_read);
 
 /* No kernel lock - fine */
 static __poll_t evdev_poll(struct file *file, poll_table *wait)
@@ -1291,8 +1293,8 @@ static long evdev_ioctl_compat(struct file *file,
 
 static const struct file_operations evdev_fops = {
 	.owner		= THIS_MODULE,
-	.read		= evdev_read,
-	.write		= evdev_write,
+	.read_iter	= evdev_read_iter,
+	.write_iter	= evdev_write_iter,
 	.poll		= evdev_poll,
 	.open		= evdev_open,
 	.release	= evdev_release,
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 5824bca02e5a..e84acc296aaa 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/uio.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Joystick device interfaces");
@@ -338,8 +339,7 @@ static int joydev_fetch_next_event(struct joydev_client *client,
  * Old joystick interface
  */
 static ssize_t joydev_0x_read(struct joydev_client *client,
-			      struct input_dev *input,
-			      char __user *buf)
+			      struct input_dev *input, struct iov_iter *to)
 {
 	struct joydev *joydev = client->joydev;
 	struct JS_DATA_TYPE data;
@@ -366,7 +366,7 @@ static ssize_t joydev_0x_read(struct joydev_client *client,
 
 	spin_unlock_irq(&input->event_lock);
 
-	if (copy_to_user(buf, &data, sizeof(struct JS_DATA_TYPE)))
+	if (!copy_to_iter(&data, sizeof(struct JS_DATA_TYPE), to))
 		return -EFAULT;
 
 	return sizeof(struct JS_DATA_TYPE);
@@ -380,12 +380,12 @@ static inline int joydev_data_pending(struct joydev_client *client)
 		client->head != client->tail;
 }
 
-static ssize_t joydev_read(struct file *file, char __user *buf,
-			   size_t count, loff_t *ppos)
+static ssize_t joydev_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct joydev_client *client = file->private_data;
+	struct joydev_client *client = iocb->ki_filp->private_data;
 	struct joydev *joydev = client->joydev;
 	struct input_dev *input = joydev->handle.dev;
+	size_t count = iov_iter_count(to);
 	struct js_event event;
 	int retval;
 
@@ -396,9 +396,9 @@ static ssize_t joydev_read(struct file *file, char __user *buf,
 		return -EINVAL;
 
 	if (count == sizeof(struct JS_DATA_TYPE))
-		return joydev_0x_read(client, input, buf);
+		return joydev_0x_read(client, input, to);
 
-	if (!joydev_data_pending(client) && (file->f_flags & O_NONBLOCK))
+	if (!joydev_data_pending(client) && (iocb->ki_filp->f_flags & O_NONBLOCK))
 		return -EAGAIN;
 
 	retval = wait_event_interruptible(joydev->wait,
@@ -412,7 +412,7 @@ static ssize_t joydev_read(struct file *file, char __user *buf,
 	while (retval + sizeof(struct js_event) <= count &&
 	       joydev_generate_startup_event(client, input, &event)) {
 
-		if (copy_to_user(buf + retval, &event, sizeof(struct js_event)))
+		if (!copy_to_iter_full(&event, sizeof(struct js_event), to))
 			return -EFAULT;
 
 		retval += sizeof(struct js_event);
@@ -421,7 +421,7 @@ static ssize_t joydev_read(struct file *file, char __user *buf,
 	while (retval + sizeof(struct js_event) <= count &&
 	       joydev_fetch_next_event(client, &event)) {
 
-		if (copy_to_user(buf + retval, &event, sizeof(struct js_event)))
+		if (!copy_to_iter_full(&event, sizeof(struct js_event), to))
 			return -EFAULT;
 
 		retval += sizeof(struct js_event);
@@ -709,7 +709,7 @@ static long joydev_ioctl(struct file *file,
 
 static const struct file_operations joydev_fops = {
 	.owner		= THIS_MODULE,
-	.read		= joydev_read,
+	.read_iter	= joydev_read,
 	.poll		= joydev_poll,
 	.open		= joydev_open,
 	.release	= joydev_release,
diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index cf25177b4830..fa1ce0d23f14 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -994,19 +994,18 @@ static int applespi_tp_dim_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
-static ssize_t applespi_tp_dim_read(struct file *file, char __user *buf,
-				    size_t len, loff_t *off)
+static ssize_t applespi_tp_dim_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct applespi_data *applespi = file->private_data;
+	struct applespi_data *applespi = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(buf, len, off, applespi->tp_dim_val,
-				       strlen(applespi->tp_dim_val));
+	return simple_copy_to_iter(applespi->tp_dim_val, &iocb->ki_pos,
+				       strlen(applespi->tp_dim_val), to);
 }
 
 static const struct file_operations applespi_tp_dim_fops = {
 	.owner = THIS_MODULE,
 	.open = applespi_tp_dim_open,
-	.read = applespi_tp_dim_read,
+	.read_iter = applespi_tp_dim_read,
 	.llseek = no_llseek,
 };
 
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index d98212d55108..960a0c729bc2 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -651,6 +651,7 @@ static ssize_t uinput_write(struct file *file, const char __user *buffer,
 
 	return retval;
 }
+FOPS_WRITE_ITER_HELPER(uinput_write);
 
 static bool uinput_fetch_next_event(struct uinput_device *udev,
 				    struct input_event *event)
@@ -723,6 +724,7 @@ static ssize_t uinput_read(struct file *file, char __user *buffer,
 
 	return retval;
 }
+FOPS_READ_ITER_HELPER(uinput_read);
 
 static __poll_t uinput_poll(struct file *file, poll_table *wait)
 {
@@ -1111,8 +1113,8 @@ static const struct file_operations uinput_fops = {
 	.owner		= THIS_MODULE,
 	.open		= uinput_open,
 	.release	= uinput_release,
-	.read		= uinput_read,
-	.write		= uinput_write,
+	.read_iter	= uinput_read_iter,
+	.write_iter	= uinput_write_iter,
 	.poll		= uinput_poll,
 	.unlocked_ioctl	= uinput_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 505c562a5daa..5d1905f078d1 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -24,6 +24,7 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/kernel.h>
+#include <linux/uio.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Mouse (ExplorerPS/2) device interfaces");
@@ -712,17 +713,18 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(mousedev_write);
 
-static ssize_t mousedev_read(struct file *file, char __user *buffer,
-			     size_t count, loff_t *ppos)
+static ssize_t mousedev_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mousedev_client *client = file->private_data;
+	struct mousedev_client *client = iocb->ki_filp->private_data;
 	struct mousedev *mousedev = client->mousedev;
+	size_t count = iov_iter_count(to);
 	u8 data[sizeof(client->ps2)];
 	int retval = 0;
 
 	if (!client->ready && !client->buffer && mousedev->exist &&
-	    (file->f_flags & O_NONBLOCK))
+	    (iocb->ki_filp->f_flags & O_NONBLOCK))
 		return -EAGAIN;
 
 	retval = wait_event_interruptible(mousedev->wait,
@@ -748,7 +750,7 @@ static ssize_t mousedev_read(struct file *file, char __user *buffer,
 
 	spin_unlock_irq(&client->packet_lock);
 
-	if (copy_to_user(buffer, data, count))
+	if (!copy_to_iter_full(data, count, to))
 		return -EFAULT;
 
 	return count;
@@ -772,8 +774,8 @@ static __poll_t mousedev_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations mousedev_fops = {
 	.owner		= THIS_MODULE,
-	.read		= mousedev_read,
-	.write		= mousedev_write,
+	.read_iter	= mousedev_read,
+	.write_iter	= mousedev_write_iter,
 	.poll		= mousedev_poll,
 	.open		= mousedev_open,
 	.release	= mousedev_release,
diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index 1e4770094415..3b4e72fdcd4f 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -194,6 +194,7 @@ static ssize_t serio_raw_read(struct file *file, char __user *buffer,
 
 	return read;
 }
+FOPS_READ_ITER_HELPER(serio_raw_read);
 
 static ssize_t serio_raw_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *ppos)
@@ -235,6 +236,7 @@ static ssize_t serio_raw_write(struct file *file, const char __user *buffer,
 	mutex_unlock(&serio_raw_mutex);
 	return retval;
 }
+FOPS_WRITE_ITER_HELPER(serio_raw_write);
 
 static __poll_t serio_raw_poll(struct file *file, poll_table *wait)
 {
@@ -255,8 +257,8 @@ static const struct file_operations serio_raw_fops = {
 	.owner		= THIS_MODULE,
 	.open		= serio_raw_open,
 	.release	= serio_raw_release,
-	.read		= serio_raw_read,
-	.write		= serio_raw_write,
+	.read_iter	= serio_raw_read_iter,
+	.write_iter	= serio_raw_write_iter,
 	.poll		= serio_raw_poll,
 	.fasync		= serio_raw_fasync,
 	.llseek		= noop_llseek,
diff --git a/drivers/input/serio/userio.c b/drivers/input/serio/userio.c
index 9ab5c45c3a9f..3688579d69d2 100644
--- a/drivers/input/serio/userio.c
+++ b/drivers/input/serio/userio.c
@@ -118,10 +118,10 @@ static int userio_char_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t userio_char_read(struct file *file, char __user *user_buffer,
-				size_t count, loff_t *ppos)
+static ssize_t userio_char_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct userio_device *userio = file->private_data;
+	struct userio_device *userio = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	int error;
 	size_t nonwrap_len, copylen;
 	unsigned char buf[USERIO_BUFSIZE];
@@ -153,7 +153,7 @@ static ssize_t userio_char_read(struct file *file, char __user *user_buffer,
 			break;
 
 		/* buffer was/is empty */
-		if (file->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
 		/*
@@ -170,16 +170,16 @@ static ssize_t userio_char_read(struct file *file, char __user *user_buffer,
 	}
 
 	if (copylen)
-		if (copy_to_user(user_buffer, buf, copylen))
+		if (!copy_to_iter_full(buf, copylen, to))
 			return -EFAULT;
 
 	return copylen;
 }
 
-static ssize_t userio_char_write(struct file *file, const char __user *buffer,
-				 size_t count, loff_t *ppos)
+static ssize_t userio_char_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct userio_device *userio = file->private_data;
+	struct userio_device *userio = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct userio_cmd cmd;
 	int error;
 
@@ -188,7 +188,7 @@ static ssize_t userio_char_write(struct file *file, const char __user *buffer,
 		return -EINVAL;
 	}
 
-	if (copy_from_user(&cmd, buffer, sizeof(cmd)))
+	if (!copy_from_iter_full(&cmd, sizeof(cmd), from))
 		return -EFAULT;
 
 	error = mutex_lock_interruptible(&userio->mutex);
@@ -264,8 +264,8 @@ static const struct file_operations userio_fops = {
 	.owner		= THIS_MODULE,
 	.open		= userio_char_open,
 	.release	= userio_char_release,
-	.read		= userio_char_read,
-	.write		= userio_char_write,
+	.read_iter	= userio_char_read,
+	.write_iter	= userio_char_write,
 	.poll		= userio_char_poll,
 	.llseek		= no_llseek,
 };
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 2a1db1134476..fe1b0a2c0925 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -31,6 +31,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 
 #include <asm/unaligned.h>
 
@@ -735,20 +736,20 @@ static int edt_ft5x06_debugfs_mode_set(void *data, u64 mode)
 DEFINE_SIMPLE_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
 			edt_ft5x06_debugfs_mode_set, "%llu\n");
 
-static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
-						char __user *buf, size_t count,
-						loff_t *off)
+static ssize_t edt_ft5x06_debugfs_raw_data_read(struct kiocb *iocb,
+						struct iov_iter *to)
 {
-	struct edt_ft5x06_ts_data *tsdata = file->private_data;
+	struct edt_ft5x06_ts_data *tsdata = iocb->ki_filp->private_data;
 	struct i2c_client *client = tsdata->client;
 	int retries  = EDT_RAW_DATA_RETRIES;
+	size_t count = iov_iter_count(to);
 	unsigned int val;
 	int i, error;
 	size_t read = 0;
 	int colbytes;
 	u8 *rdbuf;
 
-	if (*off < 0 || *off >= tsdata->raw_bufsize)
+	if (iocb->ki_pos < 0 || iocb->ki_pos >= tsdata->raw_bufsize)
 		return 0;
 
 	mutex_lock(&tsdata->mutex);
@@ -798,13 +799,13 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 		rdbuf += colbytes;
 	}
 
-	read = min_t(size_t, count, tsdata->raw_bufsize - *off);
-	if (copy_to_user(buf, tsdata->raw_buffer + *off, read)) {
+	read = min_t(size_t, count, tsdata->raw_bufsize - iocb->ki_pos);
+	if (!copy_to_iter_full(tsdata->raw_buffer + iocb->ki_pos, read, to)) {
 		error = -EFAULT;
 		goto out;
 	}
 
-	*off += read;
+	iocb->ki_pos += read;
 out:
 	mutex_unlock(&tsdata->mutex);
 	return error ?: read;
@@ -812,7 +813,7 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
 
 static const struct file_operations debugfs_raw_data_fops = {
 	.open = simple_open,
-	.read = edt_ft5x06_debugfs_raw_data_read,
+	.read_iter = edt_ft5x06_debugfs_raw_data_read,
 };
 
 static void edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
-- 
2.43.0


