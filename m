Return-Path: <linux-kernel+bounces-140952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC29A8A19C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D8F1F22E66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986483DAC1B;
	Thu, 11 Apr 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pJYxrJoY"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154EA3DABE9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849811; cv=none; b=bVnt3TVJBvRUSuFyYWJTQf32FxJdmp3hAksB2vaq0G0aHM9nnjcrHvh8qPQeZCTrLYQ7cFSLiUoKg/BOEStT2wsAhWWJzd4XDMnYi2QwIkynX9cyhWcLS/NHrnxRbzp8YFEHa+Ql0ksU9rW5mTtfsL/L5S2TSGVBTxWW6QWkSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849811; c=relaxed/simple;
	bh=sA+XsunIN7Bf4zgU6iMyCJHKJOwUd+f3Q2eN3z+SdfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DShcztlJ8ai1ZrtIFn2PAw+stdc0s+89c/hLTWdyjkSM9p3ylT0qX7l4taI67hiS4u8Fhs2bJDYWjzAdqAhWe9MClg7RZsl0zkmjIzjRL1Klr9Ue1Pu0+3n0G2VgfegE4bmjux92rJF8NTuzTdrx8UDJnQk2c6A6Iv7HFv2ro5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pJYxrJoY; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36a34b68277so111765ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849808; x=1713454608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ksW8iZ7HLDlCDIm8SE6LKBI38Lx/f0gksawzLlfosQ=;
        b=pJYxrJoYifzb6Jumes+zUHKAqSK2QpLh9QychcVWnxesaj09WGW3LcBc0vH347KTmO
         VV2weJnnIKP5oGg23oqWriY1UTLr4ckojyz322v0jecTp9p6BoJ69BUC7EWNb7HWwTmU
         z211NbSEd2lokP9/eU6+Ipr5S+PXCyzmX3cvEASiKSv12Agy7ky5c7diPVuR3hkhCaRk
         ocrZRfghL0obLT9vIeTcuzQArtha2n/HG4YRswP0VW2HC7k7tDi8FfVchOhcgqGHuvrx
         CEmNkMJ0SGZYPGSO1/rIsRxR6Wovuw7YtfF5ymz93Xq6XgKX2Awo3xPmO34lQV+DEkTY
         8u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849808; x=1713454608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ksW8iZ7HLDlCDIm8SE6LKBI38Lx/f0gksawzLlfosQ=;
        b=H2XA+pRW/A+MFFdEF3DlnAjA6ASpOGa3eFGrRA8c9rDe1EvtDscw6x0/UQTgoDrq9V
         J3I3TqV0mqcupJ9bEjVExoUrI5CoEAFOpSQdv9qFtbkjm1hI1L1Zhs6bojcdqUFh+U6W
         bdotMnY1Zgib9SJi3GqoSNk6/3TcxP6iyvyLRATSPjP3LqUpfrnWmV06fQhhz9vTIHFa
         JkfqUuuPamqDd8pYM7uO6IAgibqhOwE0kB8OwfP8ZcGVEchMcqYFtR2s5l3JgKoq19Rm
         SAsTvQg+T2Ifuj0DOuDeGxf9+eWuBZnG/wm5jHoEDlmHDtrIyo/hoLPif1tBEB9OLR4J
         xYcQ==
X-Gm-Message-State: AOJu0Yxv6ganstHQuywAscnH+D75CBnpt/Wk3LdHQ1OF0LKGtuAHvIFT
	1fgLw3aypZJquRSm/Hf77qK+ClNCf0enm6JOLqevi475Ozn4zlpqpHFnQp3UEdq6f11g1QKEEnh
	Q
X-Google-Smtp-Source: AGHT+IG712jQ3Bq/z4hbhxeF+SJokw8o2l7BdWqCL5CrRA05sm39Md+vPgd4R76vl+fNPF+T8lwQyw==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr189561iob.0.1712849807563;
        Thu, 11 Apr 2024 08:36:47 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 183/437] drivers/platform: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:15:23 -0600
Message-ID: <20240411153126.16201-184-axboe@kernel.dk>
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
 drivers/platform/chrome/cros_ec_chardev.c     | 20 +++++------
 drivers/platform/chrome/cros_ec_debugfs.c     | 33 ++++++++-----------
 drivers/platform/chrome/wilco_ec/debugfs.c    | 19 +++++------
 drivers/platform/chrome/wilco_ec/event.c      | 18 +++++-----
 drivers/platform/chrome/wilco_ec/telemetry.c  | 20 +++++------
 drivers/platform/goldfish/goldfish_pipe.c     |  6 ++--
 drivers/platform/olpc/olpc-ec.c               | 15 ++++-----
 .../surface/surface_aggregator_cdev.c         |  3 +-
 drivers/platform/surface/surface_dtx.c        |  3 +-
 drivers/platform/x86/amd/pmc/pmc.c            | 21 ++++++------
 drivers/platform/x86/amd/pmf/tee-if.c         | 10 +++---
 drivers/platform/x86/apple-gmux.c             | 25 +++++++-------
 drivers/platform/x86/asus-wmi.c               |  2 +-
 drivers/platform/x86/dell/dell-smbios-wmi.c   | 11 +++----
 drivers/platform/x86/dell/dell-smo8800.c      |  3 +-
 drivers/platform/x86/intel/pmc/core.c         | 24 +++++++-------
 drivers/platform/x86/intel/pmc/core.h         |  4 +--
 .../platform/x86/intel/telemetry/debugfs.c    | 24 +++++++-------
 drivers/platform/x86/intel/tpmi.c             | 11 ++++---
 drivers/platform/x86/sony-laptop.c            |  3 +-
 20 files changed, 136 insertions(+), 139 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index 81950bb2c6da..527588147a2f 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -197,13 +197,13 @@ static __poll_t cros_ec_chardev_poll(struct file *filp, poll_table *wait)
 	return EPOLLIN | EPOLLRDNORM;
 }
 
-static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
-				     size_t length, loff_t *offset)
+static ssize_t cros_ec_chardev_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char msg[sizeof(struct ec_response_get_version) +
 		 sizeof(CROS_EC_DEV_VERSION)];
-	struct chardev_priv *priv = filp->private_data;
+	struct chardev_priv *priv = iocb->ki_filp->private_data;
 	struct cros_ec_dev *ec_dev = priv->ec_dev;
+	size_t length = iov_iter_count(to);
 	size_t count;
 	int ret;
 
@@ -211,7 +211,7 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
 		struct ec_event *event;
 
 		event = cros_ec_chardev_fetch_event(priv, length != 0,
-						!(filp->f_flags & O_NONBLOCK));
+					!(iocb->ki_filp->f_flags & O_NONBLOCK));
 		if (IS_ERR(event))
 			return PTR_ERR(event);
 		/*
@@ -223,18 +223,18 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
 
 		/* The event is 1 byte of type plus the payload */
 		count = min(length, event->size + 1);
-		ret = copy_to_user(buffer, &event->event_type, count);
+		ret = !copy_to_iter_full(&event->event_type, count, to);
 		kfree(event);
 		if (ret) /* the copy failed */
 			return -EFAULT;
-		*offset = count;
+		iocb->ki_pos = count;
 		return count;
 	}
 
 	/*
 	 * Legacy behavior if no event mask is defined
 	 */
-	if (*offset != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	ret = ec_get_version(ec_dev, msg, sizeof(msg));
@@ -243,10 +243,10 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
 
 	count = min(length, strlen(msg));
 
-	if (copy_to_user(buffer, msg, count))
+	if (!copy_to_iter_full(msg, count, to))
 		return -EFAULT;
 
-	*offset = count;
+	iocb->ki_pos = count;
 	return count;
 }
 
@@ -366,7 +366,7 @@ static long cros_ec_chardev_ioctl(struct file *filp, unsigned int cmd,
 static const struct file_operations chardev_fops = {
 	.open		= cros_ec_chardev_open,
 	.poll		= cros_ec_chardev_poll,
-	.read		= cros_ec_chardev_read,
+	.read_iter	= cros_ec_chardev_read,
 	.release	= cros_ec_chardev_release,
 	.unlocked_ioctl	= cros_ec_chardev_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 6bf6f0e7b597..d4a00fc8f958 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -128,17 +128,17 @@ static int cros_ec_console_log_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 }
 
-static ssize_t cros_ec_console_log_read(struct file *file, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t cros_ec_console_log_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct cros_ec_debugfs *debug_info = file->private_data;
+	struct cros_ec_debugfs *debug_info = iocb->ki_filp->private_data;
 	struct circ_buf *cb = &debug_info->log_buffer;
+	size_t count = iov_iter_count(to);
 	ssize_t ret;
 
 	mutex_lock(&debug_info->log_mutex);
 
 	while (!CIRC_CNT(cb->head, cb->tail, LOG_SIZE)) {
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto error;
 		}
@@ -159,7 +159,7 @@ static ssize_t cros_ec_console_log_read(struct file *file, char __user *buf,
 	ret = min_t(size_t, CIRC_CNT_TO_END(cb->head, cb->tail, LOG_SIZE),
 		    count);
 
-	if (copy_to_user(buf, cb->buf + cb->tail, ret)) {
+	if (!copy_to_iter_full(cb->buf + cb->tail, ret, to)) {
 		ret = -EFAULT;
 		goto error;
 	}
@@ -194,13 +194,10 @@ static int cros_ec_console_log_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t cros_ec_pdinfo_read(struct file *file,
-				   char __user *user_buf,
-				   size_t count,
-				   loff_t *ppos)
+static ssize_t cros_ec_pdinfo_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char read_buf[EC_USB_PD_MAX_PORTS * 40], *p = read_buf;
-	struct cros_ec_debugfs *debug_info = file->private_data;
+	struct cros_ec_debugfs *debug_info = iocb->ki_filp->private_data;
 	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
 	struct {
 		struct cros_ec_command msg;
@@ -242,8 +239,7 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 			       resp->polarity);
 	}
 
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       read_buf, p - read_buf);
+	return simple_copy_to_iter(read_buf, &iocb->ki_pos, p - read_buf, to);
 }
 
 static bool cros_ec_uptime_is_supported(struct cros_ec_device *ec_dev)
@@ -265,10 +261,9 @@ static bool cros_ec_uptime_is_supported(struct cros_ec_device *ec_dev)
 	return true;
 }
 
-static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t cros_ec_uptime_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct cros_ec_debugfs *debug_info = file->private_data;
+	struct cros_ec_debugfs *debug_info = iocb->ki_filp->private_data;
 	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
 	struct {
 		struct cros_ec_command cmd;
@@ -290,13 +285,13 @@ static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
 	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n",
 			resp->time_since_ec_boot_ms);
 
-	return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
+	return simple_copy_to_iter(read_buf, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations cros_ec_console_log_fops = {
 	.owner = THIS_MODULE,
 	.open = cros_ec_console_log_open,
-	.read = cros_ec_console_log_read,
+	.read_iter = cros_ec_console_log_read,
 	.llseek = no_llseek,
 	.poll = cros_ec_console_log_poll,
 	.release = cros_ec_console_log_release,
@@ -305,14 +300,14 @@ static const struct file_operations cros_ec_console_log_fops = {
 static const struct file_operations cros_ec_pdinfo_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = cros_ec_pdinfo_read,
+	.read_iter = cros_ec_pdinfo_read,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations cros_ec_uptime_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = cros_ec_uptime_read,
+	.read_iter = cros_ec_uptime_read,
 	.llseek = default_llseek,
 };
 
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 93c11f81ca45..b3e1850a1dbc 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -92,10 +92,10 @@ static int parse_hex_sentence(const char *in, int isize, u8 *out, int osize)
 /* The message type takes up two bytes*/
 #define TYPE_AND_DATA_SIZE ((EC_MAILBOX_DATA_SIZE) + 2)
 
-static ssize_t raw_write(struct file *file, const char __user *user_buf,
-			 size_t count, loff_t *ppos)
+static ssize_t raw_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char *buf = debug_info->formatted_data;
+	size_t count = iov_iter_count(from);
 	struct wilco_ec_message msg;
 	u8 request_data[TYPE_AND_DATA_SIZE];
 	ssize_t kcount;
@@ -104,8 +104,8 @@ static ssize_t raw_write(struct file *file, const char __user *user_buf,
 	if (count > FORMATTED_BUFFER_SIZE)
 		return -EINVAL;
 
-	kcount = simple_write_to_buffer(buf, FORMATTED_BUFFER_SIZE, ppos,
-					user_buf, count);
+	kcount = simple_copy_from_iter(buf, &iocb->ki_pos, FORMATTED_BUFFER_SIZE,
+					from);
 	if (kcount < 0)
 		return kcount;
 
@@ -132,8 +132,7 @@ static ssize_t raw_write(struct file *file, const char __user *user_buf,
 	return count;
 }
 
-static ssize_t raw_read(struct file *file, char __user *user_buf, size_t count,
-			loff_t *ppos)
+static ssize_t raw_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int fmt_len = 0;
 
@@ -147,14 +146,14 @@ static ssize_t raw_read(struct file *file, char __user *user_buf, size_t count,
 		debug_info->response_size = 0;
 	}
 
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       debug_info->formatted_data, fmt_len);
+	return simple_copy_to_iter(debug_info->formatted_data, &iocb->ki_pos,
+					fmt_len, to);
 }
 
 static const struct file_operations fops_raw = {
 	.owner = THIS_MODULE,
-	.read = raw_read,
-	.write = raw_write,
+	.read_iter = raw_read,
+	.write_iter = raw_write,
 	.llseek = no_llseek,
 };
 
diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 13291fb4214e..581a4c13847c 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -335,10 +335,8 @@ static __poll_t event_poll(struct file *filp, poll_table *wait)
 
 /**
  * event_read() - Callback for passing event data to userspace via read().
- * @filp: The file we are reading from.
- * @buf: Pointer to userspace buffer to fill with one event.
- * @count: Number of bytes requested. Must be at least EC_ACPI_MAX_EVENT_SIZE.
- * @pos: File position pointer, irrelevant since we don't support seeking.
+ * @iocb: Metadata for IO
+ * @to: Pointer to userspace buffer to fill with one event.
  *
  * Removes the first event from the queue, places it in the passed buffer.
  *
@@ -349,10 +347,10 @@ static __poll_t event_poll(struct file *filp, poll_table *wait)
  *
  * Return: Number of bytes placed in buffer, negative error code on failure.
  */
-static ssize_t event_read(struct file *filp, char __user *buf, size_t count,
-			  loff_t *pos)
+static ssize_t event_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct event_device_data *dev_data = filp->private_data;
+	struct event_device_data *dev_data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct ec_event *event;
 	ssize_t n_bytes_written = 0;
 	int err;
@@ -364,7 +362,7 @@ static ssize_t event_read(struct file *filp, char __user *buf, size_t count,
 	spin_lock(&dev_data->queue_lock);
 	while (event_queue_empty(dev_data->events)) {
 		spin_unlock(&dev_data->queue_lock);
-		if (filp->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
 		err = wait_event_interruptible(dev_data->wq,
@@ -381,7 +379,7 @@ static ssize_t event_read(struct file *filp, char __user *buf, size_t count,
 	event = event_queue_pop(dev_data->events);
 	spin_unlock(&dev_data->queue_lock);
 	n_bytes_written = ec_event_size(event);
-	if (copy_to_user(buf, event, n_bytes_written))
+	if (!copy_to_iter_full(event, n_bytes_written, to))
 		n_bytes_written = -EFAULT;
 	kfree(event);
 
@@ -401,7 +399,7 @@ static int event_release(struct inode *inode, struct file *filp)
 static const struct file_operations event_fops = {
 	.open = event_open,
 	.poll  = event_poll,
-	.read = event_read,
+	.read_iter = event_read,
 	.release = event_release,
 	.llseek = no_llseek,
 	.owner = THIS_MODULE,
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index b7c616f3d179..dbb937382cef 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -261,17 +261,17 @@ static int telem_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t telem_write(struct file *filp, const char __user *buf,
-			   size_t count, loff_t *pos)
+static ssize_t telem_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct telem_session_data *sess_data = filp->private_data;
+	struct telem_session_data *sess_data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wilco_ec_message msg = {};
 	int ret;
 
 	if (count > sizeof(sess_data->request))
 		return -EMSGSIZE;
 	memset(&sess_data->request, 0, sizeof(sess_data->request));
-	if (copy_from_user(&sess_data->request, buf, count))
+	if (!copy_from_iter_full(&sess_data->request, count, from))
 		return -EFAULT;
 	ret = check_telem_request(&sess_data->request, count);
 	if (ret < 0)
@@ -295,17 +295,17 @@ static ssize_t telem_write(struct file *filp, const char __user *buf,
 	return count;
 }
 
-static ssize_t telem_read(struct file *filp, char __user *buf, size_t count,
-			  loff_t *pos)
+static ssize_t telem_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct telem_session_data *sess_data = filp->private_data;
+	struct telem_session_data *sess_data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 
 	if (!sess_data->has_msg)
 		return -ENODATA;
 	if (count > sizeof(sess_data->response))
 		return -EINVAL;
 
-	if (copy_to_user(buf, sess_data->response, count))
+	if (!copy_to_iter_full(sess_data->response, count, to))
 		return -EFAULT;
 
 	sess_data->has_msg = false;
@@ -326,8 +326,8 @@ static int telem_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations telem_fops = {
 	.open = telem_open,
-	.write = telem_write,
-	.read = telem_read,
+	.write_iter = telem_write,
+	.read_iter = telem_read,
 	.release = telem_release,
 	.llseek = no_llseek,
 	.owner = THIS_MODULE,
diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 061aa9647c19..8a75fa0b139b 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -475,6 +475,7 @@ static ssize_t goldfish_pipe_read(struct file *filp, char __user *buffer,
 	return goldfish_pipe_read_write(filp, buffer, bufflen,
 					/* is_write */ 0);
 }
+FOPS_READ_ITER_HELPER(goldfish_pipe_read);
 
 static ssize_t goldfish_pipe_write(struct file *filp,
 				   const char __user *buffer, size_t bufflen,
@@ -486,6 +487,7 @@ static ssize_t goldfish_pipe_write(struct file *filp,
 	return goldfish_pipe_read_write(filp, no_const_buffer, bufflen,
 					/* is_write */ 1);
 }
+FOPS_WRITE_ITER_HELPER(goldfish_pipe_write);
 
 static __poll_t goldfish_pipe_poll(struct file *filp, poll_table *wait)
 {
@@ -779,8 +781,8 @@ static int goldfish_pipe_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations goldfish_pipe_fops = {
 	.owner = THIS_MODULE,
-	.read = goldfish_pipe_read,
-	.write = goldfish_pipe_write,
+	.read_iter = goldfish_pipe_read_iter,
+	.write_iter = goldfish_pipe_write_iter,
 	.poll = goldfish_pipe_poll,
 	.open = goldfish_pipe_open,
 	.release = goldfish_pipe_release,
diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index 921520475ff6..89cf016e0767 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -258,10 +258,10 @@ static DEFINE_MUTEX(ec_dbgfs_lock);
 static unsigned char ec_dbgfs_resp[EC_MAX_CMD_REPLY];
 static unsigned int ec_dbgfs_resp_bytes;
 
-static ssize_t ec_dbgfs_cmd_write(struct file *file, const char __user *buf,
-		size_t size, loff_t *ppos)
+static ssize_t ec_dbgfs_cmd_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int i, m;
+	size_t size = iov_iter_count(from);
 	unsigned char ec_cmd[EC_MAX_CMD_ARGS];
 	unsigned int ec_cmd_int[EC_MAX_CMD_ARGS];
 	char cmdbuf[64] = "";
@@ -269,7 +269,7 @@ static ssize_t ec_dbgfs_cmd_write(struct file *file, const char __user *buf,
 
 	mutex_lock(&ec_dbgfs_lock);
 
-	size = simple_write_to_buffer(cmdbuf, sizeof(cmdbuf), ppos, buf, size);
+	size = simple_copy_from_iter(cmdbuf, &iocb->ki_pos, sizeof(cmdbuf), from);
 
 	m = sscanf(cmdbuf, "%x:%u %x %x %x %x %x", &ec_cmd_int[0],
 			&ec_dbgfs_resp_bytes, &ec_cmd_int[1], &ec_cmd_int[2],
@@ -303,8 +303,7 @@ static ssize_t ec_dbgfs_cmd_write(struct file *file, const char __user *buf,
 	return size;
 }
 
-static ssize_t ec_dbgfs_cmd_read(struct file *file, char __user *buf,
-		size_t size, loff_t *ppos)
+static ssize_t ec_dbgfs_cmd_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	unsigned int i, r;
 	char *rp;
@@ -319,12 +318,12 @@ static ssize_t ec_dbgfs_cmd_read(struct file *file, char __user *buf,
 	rp += sprintf(rp, "\n");
 
 	r = rp - respbuf;
-	return simple_read_from_buffer(buf, size, ppos, respbuf, r);
+	return simple_copy_to_iter(respbuf, &iocb->ki_pos, r, to);
 }
 
 static const struct file_operations ec_dbgfs_ops = {
-	.write = ec_dbgfs_cmd_write,
-	.read = ec_dbgfs_cmd_read,
+	.write_iter = ec_dbgfs_cmd_write,
+	.read_iter = ec_dbgfs_cmd_read,
 };
 
 static struct dentry *olpc_ec_setup_debugfs(void)
diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index 07e065b9159f..232f487c3eaf 100644
--- a/drivers/platform/surface/surface_aggregator_cdev.c
+++ b/drivers/platform/surface/surface_aggregator_cdev.c
@@ -637,6 +637,7 @@ static ssize_t ssam_cdev_read(struct file *file, char __user *buf, size_t count,
 	up_read(&cdev->lock);
 	return copied;
 }
+FOPS_READ_ITER_HELPER(ssam_cdev_read);
 
 static __poll_t ssam_cdev_poll(struct file *file, struct poll_table_struct *pt)
 {
@@ -665,7 +666,7 @@ static const struct file_operations ssam_controller_fops = {
 	.owner          = THIS_MODULE,
 	.open           = ssam_cdev_device_open,
 	.release        = ssam_cdev_device_release,
-	.read           = ssam_cdev_read,
+	.read_iter      = ssam_cdev_read_iter,
 	.poll           = ssam_cdev_poll,
 	.fasync         = ssam_cdev_fasync,
 	.unlocked_ioctl = ssam_cdev_device_ioctl,
diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
index 2de843b7ea70..f2b3fe8dcd72 100644
--- a/drivers/platform/surface/surface_dtx.c
+++ b/drivers/platform/surface/surface_dtx.c
@@ -522,6 +522,7 @@ static ssize_t surface_dtx_read(struct file *file, char __user *buf, size_t coun
 	up_read(&ddev->lock);
 	return copied;
 }
+FOPS_READ_ITER_HELPER(surface_dtx_read);
 
 static __poll_t surface_dtx_poll(struct file *file, struct poll_table_struct *pt)
 {
@@ -550,7 +551,7 @@ static const struct file_operations surface_dtx_fops = {
 	.owner          = THIS_MODULE,
 	.open           = surface_dtx_open,
 	.release        = surface_dtx_release,
-	.read           = surface_dtx_read,
+	.read_iter      = surface_dtx_read_iter,
 	.poll           = surface_dtx_poll,
 	.fasync         = surface_dtx_fasync,
 	.unlocked_ioctl = surface_dtx_ioctl,
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 108e12fd580f..c4342280e43d 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -214,14 +214,13 @@ static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
 	return rc;
 }
 
-static ssize_t amd_pmc_stb_debugfs_read(struct file *filp, char __user *buf, size_t size,
-					loff_t *pos)
+static ssize_t amd_pmc_stb_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	if (!filp->private_data)
+	if (!iocb->ki_filp->private_data)
 		return -EINVAL;
 
-	return simple_read_from_buffer(buf, size, pos, filp->private_data,
-				       FIFO_SIZE * sizeof(u32));
+	return simple_copy_to_iter(iocb->ki_filp->private_data, &iocb->ki_pos,
+				   FIFO_SIZE * sizeof(u32), to);
 }
 
 static int amd_pmc_stb_debugfs_release(struct inode *inode, struct file *filp)
@@ -233,7 +232,7 @@ static int amd_pmc_stb_debugfs_release(struct inode *inode, struct file *filp)
 static const struct file_operations amd_pmc_stb_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = amd_pmc_stb_debugfs_open,
-	.read = amd_pmc_stb_debugfs_read,
+	.read_iter = amd_pmc_stb_debugfs_read,
 	.release = amd_pmc_stb_debugfs_release,
 };
 
@@ -321,12 +320,12 @@ static int amd_pmc_stb_debugfs_open_v2(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t amd_pmc_stb_debugfs_read_v2(struct file *filp, char __user *buf, size_t size,
-					   loff_t *pos)
+static ssize_t amd_pmc_stb_debugfs_read_v2(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct amd_pmc_stb_v2_data *data = filp->private_data;
+	struct amd_pmc_stb_v2_data *data = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(buf, size, pos, data->data, data->size);
+	return simple_copy_to_iter(data->data, &iocb->ki_pos, data->size, to);
 }
 
 static int amd_pmc_stb_debugfs_release_v2(struct inode *inode, struct file *filp)
@@ -338,7 +337,7 @@ static int amd_pmc_stb_debugfs_release_v2(struct inode *inode, struct file *filp
 static const struct file_operations amd_pmc_stb_debugfs_fops_v2 = {
 	.owner = THIS_MODULE,
 	.open = amd_pmc_stb_debugfs_open_v2,
-	.read = amd_pmc_stb_debugfs_read_v2,
+	.read_iter = amd_pmc_stb_debugfs_read_v2,
 	.release = amd_pmc_stb_debugfs_release_v2,
 };
 
diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index b438de4d6bfc..3b6bf12a31c4 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -289,10 +289,10 @@ static void amd_pmf_hex_dump_pb(struct amd_pmf_dev *dev)
 			     dev->policy_sz, false);
 }
 
-static ssize_t amd_pmf_get_pb_data(struct file *filp, const char __user *buf,
-				   size_t length, loff_t *pos)
+static ssize_t amd_pmf_get_pb_data(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct amd_pmf_dev *dev = filp->private_data;
+	struct amd_pmf_dev *dev = iocb->ki_filp->private_data;
+	size_t length = iov_iter_count(from);
 	unsigned char *new_policy_buf;
 	int ret;
 
@@ -305,7 +305,7 @@ static ssize_t amd_pmf_get_pb_data(struct file *filp, const char __user *buf,
 	if (!new_policy_buf)
 		return -ENOMEM;
 
-	if (copy_from_user(new_policy_buf, buf, length)) {
+	if (!copy_from_iter_full(new_policy_buf, length, from)) {
 		kfree(new_policy_buf);
 		return -EFAULT;
 	}
@@ -323,7 +323,7 @@ static ssize_t amd_pmf_get_pb_data(struct file *filp, const char __user *buf,
 }
 
 static const struct file_operations pb_fops = {
-	.write = amd_pmf_get_pb_data,
+	.write_iter = amd_pmf_get_pb_data,
 	.open = simple_open,
 };
 
diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 1417e230edbd..7c078a27c67b 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -691,25 +691,26 @@ static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
  * 1 and 4 byte writes are also allowed.
  */
 
-static ssize_t gmux_selected_port_data_write(struct file *file,
-		const char __user *userbuf, size_t count, loff_t *ppos)
+static ssize_t gmux_selected_port_data_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct apple_gmux_data *gmux_data = file->private_data;
+	struct apple_gmux_data *gmux_data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return -EINVAL;
 
 	if (count == 1) {
 		u8 data;
 
-		if (copy_from_user(&data, userbuf, 1))
+		if (!copy_from_iter_full(&data, 1, from))
 			return -EFAULT;
 
 		gmux_write8(gmux_data, gmux_data->selected_port, data);
 	} else if (count == 4) {
 		u32 data;
 
-		if (copy_from_user(&data, userbuf, 4))
+		if (!copy_from_iter_full(&data, 4, from))
 			return -EFAULT;
 
 		gmux_write32(gmux_data, gmux_data->selected_port, data);
@@ -719,21 +720,21 @@ static ssize_t gmux_selected_port_data_write(struct file *file,
 	return count;
 }
 
-static ssize_t gmux_selected_port_data_read(struct file *file,
-		char __user *userbuf, size_t count, loff_t *ppos)
+static ssize_t gmux_selected_port_data_read(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct apple_gmux_data *gmux_data = file->private_data;
+	struct apple_gmux_data *gmux_data = iocb->ki_filp->private_data;
 	u32 data;
 
 	data = gmux_read32(gmux_data, gmux_data->selected_port);
 
-	return simple_read_from_buffer(userbuf, count, ppos, &data, sizeof(data));
+	return simple_copy_to_iter(&data, &iocb->ki_pos, sizeof(data), to);
 }
 
 static const struct file_operations gmux_port_data_ops = {
 	.open = simple_open,
-	.write = gmux_selected_port_data_write,
-	.read = gmux_selected_port_data_read
+	.write_iter = gmux_selected_port_data_write,
+	.read_iter = gmux_selected_port_data_read
 };
 
 static void gmux_init_debugfs(struct apple_gmux_data *gmux_data)
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3f07bbf809ef..02d874c4d30c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4367,7 +4367,7 @@ static int asus_wmi_debugfs_open(struct inode *inode, struct file *file)
 static const struct file_operations asus_wmi_debugfs_io_ops = {
 	.owner = THIS_MODULE,
 	.open = asus_wmi_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/platform/x86/dell/dell-smbios-wmi.c b/drivers/platform/x86/dell/dell-smbios-wmi.c
index ae9012549560..89deb76c0d5e 100644
--- a/drivers/platform/x86/dell/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell/dell-smbios-wmi.c
@@ -123,13 +123,12 @@ static int dell_smbios_wmi_open(struct inode *inode, struct file *filp)
 	return nonseekable_open(inode, filp);
 }
 
-static ssize_t dell_smbios_wmi_read(struct file *filp, char __user *buffer, size_t length,
-				    loff_t *offset)
+static ssize_t dell_smbios_wmi_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wmi_smbios_priv *priv = filp->private_data;
+	struct wmi_smbios_priv *priv = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(buffer, length, offset, &priv->req_buf_size,
-				       sizeof(priv->req_buf_size));
+	return simple_copy_to_iter(&priv->req_buf_size, &iocb->ki_pos,
+				   sizeof(priv->req_buf_size), to);
 }
 
 static long dell_smbios_wmi_do_ioctl(struct wmi_smbios_priv *priv,
@@ -189,7 +188,7 @@ static long dell_smbios_wmi_ioctl(struct file *filp, unsigned int cmd, unsigned
 static const struct file_operations dell_smbios_wmi_fops = {
 	.owner		= THIS_MODULE,
 	.open		= dell_smbios_wmi_open,
-	.read		= dell_smbios_wmi_read,
+	.read_iter	= dell_smbios_wmi_read,
 	.unlocked_ioctl	= dell_smbios_wmi_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 };
diff --git a/drivers/platform/x86/dell/dell-smo8800.c b/drivers/platform/x86/dell/dell-smo8800.c
index f7ec17c56833..b8fa22b0b6bd 100644
--- a/drivers/platform/x86/dell/dell-smo8800.c
+++ b/drivers/platform/x86/dell/dell-smo8800.c
@@ -74,6 +74,7 @@ static ssize_t smo8800_misc_read(struct file *file, char __user *buf,
 
 	return retval;
 }
+FOPS_READ_ITER_HELPER(smo8800_misc_read);
 
 static int smo8800_misc_open(struct inode *inode, struct file *file)
 {
@@ -98,7 +99,7 @@ static int smo8800_misc_release(struct inode *inode, struct file *file)
 
 static const struct file_operations smo8800_misc_fops = {
 	.owner = THIS_MODULE,
-	.read = smo8800_misc_read,
+	.read_iter = smo8800_misc_read_iter,
 	.open = smo8800_misc_open,
 	.release = smo8800_misc_release,
 };
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 10c96c1a850a..f419cc485411 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -525,18 +525,18 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore)
 	return 0;
 }
 
-static ssize_t pmc_core_ltr_ignore_write(struct file *file,
-					 const char __user *userbuf,
-					 size_t count, loff_t *ppos)
+static ssize_t pmc_core_ltr_ignore_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
 	struct pmc_dev *pmcdev = s->private;
+	size_t count = iov_iter_count(from);
 	u32 buf_size, value;
 	int err;
 
 	buf_size = min_t(u32, count, 64);
 
-	err = kstrtou32_from_user(userbuf, buf_size, 10, &value);
+	err = kstrtou32_from_iter(from, buf_size, 10, &value);
 	if (err)
 		return err;
 
@@ -557,8 +557,8 @@ static int pmc_core_ltr_ignore_open(struct inode *inode, struct file *file)
 
 static const struct file_operations pmc_core_ltr_ignore_ops = {
 	.open           = pmc_core_ltr_ignore_open,
-	.read           = seq_read,
-	.write          = pmc_core_ltr_ignore_write,
+	.read_iter      = seq_read_iter,
+	.write_iter     = pmc_core_ltr_ignore_write,
 	.llseek         = seq_lseek,
 	.release        = single_release,
 };
@@ -911,11 +911,11 @@ static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
-					     const char __user *userbuf,
-					     size_t count, loff_t *ppos)
+static ssize_t pmc_core_lpm_latch_mode_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct pmc_dev *pmcdev = s->private;
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	bool clear = false, c10 = false;
@@ -925,7 +925,7 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
 
 	if (count > sizeof(buf) - 1)
 		return -EINVAL;
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 	buf[count] = '\0';
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 83504c49a0e3..5e4d1bef58e8 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -609,8 +609,8 @@ static int __name ## _open(struct inode *inode, struct file *file)	\
 static const struct file_operations __name ## _fops = {			\
 	.owner		= THIS_MODULE,					\
 	.open		= __name ## _open,				\
-	.read		= seq_read,					\
-	.write		= __name ## _write,				\
+	.read_iter	= seq_read_iter,				\
+	.write_iter	= __name ## _write,				\
 	.release	= single_release,				\
 }
 
diff --git a/drivers/platform/x86/intel/telemetry/debugfs.c b/drivers/platform/x86/intel/telemetry/debugfs.c
index 1d4d0fbfd63c..1c2b05418345 100644
--- a/drivers/platform/x86/intel/telemetry/debugfs.c
+++ b/drivers/platform/x86/intel/telemetry/debugfs.c
@@ -679,14 +679,14 @@ static int telem_pss_trc_verb_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static ssize_t telem_pss_trc_verb_write(struct file *file,
-					const char __user *userbuf,
-					size_t count, loff_t *ppos)
+static ssize_t telem_pss_trc_verb_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	u32 verbosity;
 	int err;
 
-	err = kstrtou32_from_user(userbuf, count, 0, &verbosity);
+	err = kstrtou32_from_iter(from, count, 0, &verbosity);
 	if (err)
 		return err;
 
@@ -706,8 +706,8 @@ static int telem_pss_trc_verb_open(struct inode *inode, struct file *file)
 
 static const struct file_operations telem_pss_trc_verb_ops = {
 	.open		= telem_pss_trc_verb_open,
-	.read		= seq_read,
-	.write		= telem_pss_trc_verb_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= telem_pss_trc_verb_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -727,14 +727,14 @@ static int telem_ioss_trc_verb_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static ssize_t telem_ioss_trc_verb_write(struct file *file,
-					 const char __user *userbuf,
-					 size_t count, loff_t *ppos)
+static ssize_t telem_ioss_trc_verb_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	u32 verbosity;
 	int err;
 
-	err = kstrtou32_from_user(userbuf, count, 0, &verbosity);
+	err = kstrtou32_from_iter(from, count, 0, &verbosity);
 	if (err)
 		return err;
 
@@ -754,8 +754,8 @@ static int telem_ioss_trc_verb_open(struct inode *inode, struct file *file)
 
 static const struct file_operations telem_ioss_trc_verb_ops = {
 	.open		= telem_ioss_trc_verb_open,
-	.read		= seq_read,
-	.write		= telem_ioss_trc_verb_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= telem_ioss_trc_verb_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 910df7c654f4..1de0ecfcf1e7 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -438,10 +438,11 @@ static int tpmi_mem_dump_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(tpmi_mem_dump);
 
-static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t len, loff_t *ppos)
+static ssize_t mem_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct intel_tpmi_pm_feature *pfs = m->private;
+	size_t len = iov_iter_count(from);
 	u32 addr, value, punit, size;
 	u32 num_elems, *array;
 	void __iomem *mem;
@@ -451,7 +452,7 @@ static ssize_t mem_write(struct file *file, const char __user *userbuf, size_t l
 	if (!size)
 		return -EIO;
 
-	ret = parse_int_array_user(userbuf, len, (int **)&array);
+	ret = parse_int_array_iter(from, (int **)&array);
 	if (ret < 0)
 		return ret;
 
@@ -510,8 +511,8 @@ static int mem_write_open(struct inode *inode, struct file *file)
 
 static const struct file_operations mem_write_ops = {
 	.open           = mem_write_open,
-	.read           = seq_read,
-	.write          = mem_write,
+	.read_iter      = seq_read_iter,
+	.write_iter     = mem_write,
 	.llseek         = seq_lseek,
 	.release        = single_release,
 };
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 40878e327afd..6308feb23665 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -4097,6 +4097,7 @@ static ssize_t sonypi_misc_read(struct file *file, char __user *buf,
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(sonypi_misc_read);
 
 static __poll_t sonypi_misc_poll(struct file *file, poll_table *wait)
 {
@@ -4249,7 +4250,7 @@ static long sonypi_misc_ioctl(struct file *fp, unsigned int cmd,
 
 static const struct file_operations sonypi_misc_fops = {
 	.owner		= THIS_MODULE,
-	.read		= sonypi_misc_read,
+	.read_iter	= sonypi_misc_read_iter,
 	.poll		= sonypi_misc_poll,
 	.open		= sonypi_misc_open,
 	.release	= sonypi_misc_release,
-- 
2.43.0


