Return-Path: <linux-kernel+bounces-140881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD08A195C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46211C228F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEA6154434;
	Thu, 11 Apr 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pq5xXAhT"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5C153BD0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849702; cv=none; b=MuwrT7TTPJFidb6MynB5eX4uAVeIdI0wQf++493uGXvw6KRltAXYn3r1pf6291mIvvhhj8z8mLWSJE+rNBD9bB0kcDZLkaIsfSZn2qeyZZrpOZcqdBWWC/7GKMJKfY6fv3jL8uvT0zfHJSnng9Wwbo5ojxyFcVcxaHSEZJsg8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849702; c=relaxed/simple;
	bh=AtZCFbVdCOf2WMpF3Xa7GB0twP6+abdo3bq4jdzXHw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j44dGupBFe5JExwDZV27/gvuBY9DjKM1Y3xR1Q+2/Ep2OKlBkr7v3vgxZNpxdIZilerPwbzYWpRnEo3GfRj0di/X/OcrSTvMjCGnHXcwTcgkQhe/Xyd+foLp3NJJC711Dll4EHMFr8TL6nnzmn+3/jvfY8SCsnUpjnr+lCOkOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pq5xXAhT; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58033939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849699; x=1713454499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF1yYOi8Uq1y51haZriCVmETMFalxQeH7SVR1N2yoIA=;
        b=pq5xXAhTXXh9rXvL+/zE8bhUPK9FjSbqJo3zDbLK9CvGDpvsac3RopI36QU/gSGzGg
         PDlxovlUlkEdoCf0Zufg8zIt3RlGiaG/O2mMI7n2ilgxYPWCPsevXl+SoBY7rLYbx0up
         Q1b3exqRWjQtECAWy8FG07/0uVzVguedZawG3nzrHuhkL1fpk0Et9QqW8qrCG017eOLw
         lutuu/Ga9m0Vym9RQNog3V0R6sokhQrI6V1xEln8IROgYk548lVnuJTUGEDxR3i2e4Aq
         JTb7eR8J0vjE9Ukf/HKnryOjHb5YoX3FN7Ds05L1mr+3dm9Jeg5zTVpRvC8ZuCSjetyr
         maUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849699; x=1713454499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eF1yYOi8Uq1y51haZriCVmETMFalxQeH7SVR1N2yoIA=;
        b=RD3PRfxjcXUlyXFORijNyGx6mpCpa3BKn+Pidvx3u5+OwIk8xc1qvMTgapBYRF/KlH
         6+dne742QEzt3g45HkKC1GycnEuNuJ1L1WjqbNld6qYC4tEAy7icSHv/YzPv6IVStJpF
         PMqW5dD7TB+tS5Ds6CY1RC4ot0fWHaLicU9kOmZdXHTvs+ztUZZTs5vCnnr9fRbT0ej5
         ea7Uo8Tj2GAXbIaD7pgDyesOOgHHz7gw+zhdaXWxVhupou+ZeeJaQmF7L6DrmXY4Dj71
         R7f4QzXJTBy+ZXxMT6F95IjPk4IwpmVSDP5htKiVAJ9wHSPBNEqdA5sFWytZoJ4Ipsfy
         WCEg==
X-Gm-Message-State: AOJu0YwovwfM1NOJUuUWgKNhzw1srjtyz3puAcy3YvnOKCf+U2MdOVtt
	cMRhr27lIgd+RoKEHx0wkcL1Ns4Rlf0dbWgwYF4FZwni8tfBCeWE8bel1rniywKpy943XWl+EqN
	K
X-Google-Smtp-Source: AGHT+IEwcb0tJl2mhs4UBapibxska/7MEl3degWZSjF6rbAp9CqcpgFYNWD7XsaLD9xhR/WUM+3wnA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr157878ioh.1.1712849699106;
        Thu, 11 Apr 2024 08:34:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 117/437] drivers/hid: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:17 -0600
Message-ID: <20240411153126.16201-118-axboe@kernel.dk>
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
 drivers/hid/hid-debug.c           |  3 +-
 drivers/hid/hid-picolcd_debugfs.c | 65 +++++++++++++++++--------------
 drivers/hid/hid-roccat.c          | 12 +++---
 drivers/hid/hid-sensor-custom.c   |  3 +-
 drivers/hid/hid-wiimote-debug.c   | 15 +++----
 drivers/hid/hidraw.c              | 15 +++----
 drivers/hid/uhid.c                | 15 +++----
 7 files changed, 69 insertions(+), 59 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 7dd83ec74f8a..d5110cd9b440 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1206,6 +1206,7 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 	mutex_unlock(&list->read_mutex);
 	return ret;
 }
+FOPS_READ_ITER_HELPER(hid_debug_events_read);
 
 static __poll_t hid_debug_events_poll(struct file *file, poll_table *wait)
 {
@@ -1240,7 +1241,7 @@ DEFINE_SHOW_ATTRIBUTE(hid_debug_rdesc);
 static const struct file_operations hid_debug_events_fops = {
 	.owner =        THIS_MODULE,
 	.open           = hid_debug_events_open,
-	.read           = hid_debug_events_read,
+	.read_iter      = hid_debug_events_read_iter,
 	.poll		= hid_debug_events_poll,
 	.release        = hid_debug_events_release,
 	.llseek		= noop_llseek,
diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index d01176da8896..63785cb6a8ac 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -34,13 +34,14 @@ static int picolcd_debug_reset_open(struct inode *inode, struct file *f)
 	return single_open(f, picolcd_debug_reset_show, inode->i_private);
 }
 
-static ssize_t picolcd_debug_reset_write(struct file *f, const char __user *user_buf,
-		size_t count, loff_t *ppos)
+static ssize_t picolcd_debug_reset_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct picolcd_data *data = ((struct seq_file *)f->private_data)->private;
+	struct picolcd_data *data = ((struct seq_file *)iocb->ki_filp->private_data)->private;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	size_t cnt = min(count, sizeof(buf)-1);
-	if (copy_from_user(buf, user_buf, cnt))
+	if (!copy_from_iter_full(buf, cnt, from))
 		return -EFAULT;
 
 	while (cnt > 0 && (buf[cnt-1] == ' ' || buf[cnt-1] == '\n'))
@@ -60,34 +61,35 @@ static ssize_t picolcd_debug_reset_write(struct file *f, const char __user *user
 static const struct file_operations picolcd_debug_reset_fops = {
 	.owner    = THIS_MODULE,
 	.open     = picolcd_debug_reset_open,
-	.read     = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek   = seq_lseek,
-	.write    = picolcd_debug_reset_write,
+	.write_iter = picolcd_debug_reset_write,
 	.release  = single_release,
 };
 
 /*
  * The "eeprom" file
  */
-static ssize_t picolcd_debug_eeprom_read(struct file *f, char __user *u,
-		size_t s, loff_t *off)
+static ssize_t picolcd_debug_eeprom_read(struct kiocb *iocb,
+					 struct iov_iter *to)
 {
-	struct picolcd_data *data = f->private_data;
+	struct picolcd_data *data = iocb->ki_filp->private_data;
+	size_t s = iov_iter_count(to);
 	struct picolcd_pending *resp;
 	u8 raw_data[3];
 	ssize_t ret = -EIO;
 
 	if (s == 0)
 		return -EINVAL;
-	if (*off > 0x0ff)
+	if (iocb->ki_pos > 0x0ff)
 		return 0;
 
 	/* prepare buffer with info about what we want to read (addr & len) */
-	raw_data[0] = *off & 0xff;
-	raw_data[1] = (*off >> 8) & 0xff;
+	raw_data[0] = iocb->ki_pos & 0xff;
+	raw_data[1] = (iocb->ki_pos >> 8) & 0xff;
 	raw_data[2] = s < 20 ? s : 20;
-	if (*off + raw_data[2] > 0xff)
-		raw_data[2] = 0x100 - *off;
+	if (iocb->ki_pos + raw_data[2] > 0xff)
+		raw_data[2] = 0x100 - iocb->ki_pos;
 	resp = picolcd_send_and_wait(data->hdev, REPORT_EE_READ, raw_data,
 			sizeof(raw_data));
 	if (!resp)
@@ -98,37 +100,38 @@ static ssize_t picolcd_debug_eeprom_read(struct file *f, char __user *u,
 		ret = resp->raw_data[2];
 		if (ret > s)
 			ret = s;
-		if (copy_to_user(u, resp->raw_data+3, ret))
+		if (!copy_to_iter_full(resp->raw_data+3, ret, to))
 			ret = -EFAULT;
 		else
-			*off += ret;
+			iocb->ki_pos += ret;
 	} /* anything else is some kind of IO error */
 
 	kfree(resp);
 	return ret;
 }
 
-static ssize_t picolcd_debug_eeprom_write(struct file *f, const char __user *u,
-		size_t s, loff_t *off)
+static ssize_t picolcd_debug_eeprom_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct picolcd_data *data = f->private_data;
+	struct picolcd_data *data = iocb->ki_filp->private_data;
+	size_t s = iov_iter_count(from);
 	struct picolcd_pending *resp;
 	ssize_t ret = -EIO;
 	u8 raw_data[23];
 
 	if (s == 0)
 		return -EINVAL;
-	if (*off > 0x0ff)
+	if (iocb->ki_pos > 0x0ff)
 		return -ENOSPC;
 
 	memset(raw_data, 0, sizeof(raw_data));
-	raw_data[0] = *off & 0xff;
-	raw_data[1] = (*off >> 8) & 0xff;
+	raw_data[0] = iocb->ki_pos & 0xff;
+	raw_data[1] = (iocb->ki_pos >> 8) & 0xff;
 	raw_data[2] = min_t(size_t, 20, s);
-	if (*off + raw_data[2] > 0xff)
-		raw_data[2] = 0x100 - *off;
+	if (iocb->ki_pos + raw_data[2] > 0xff)
+		raw_data[2] = 0x100 - iocb->ki_pos;
 
-	if (copy_from_user(raw_data+3, u, min((u8)20, raw_data[2])))
+	if (!copy_from_iter_full(raw_data+3, min((u8)20, raw_data[2]), from))
 		return -EFAULT;
 	resp = picolcd_send_and_wait(data->hdev, REPORT_EE_WRITE, raw_data,
 			sizeof(raw_data));
@@ -139,7 +142,7 @@ static ssize_t picolcd_debug_eeprom_write(struct file *f, const char __user *u,
 	if (resp->in_report && resp->in_report->id == REPORT_EE_DATA) {
 		/* check if written data matches */
 		if (memcmp(raw_data, resp->raw_data, 3+raw_data[2]) == 0) {
-			*off += raw_data[2];
+			iocb->ki_pos += raw_data[2];
 			ret = raw_data[2];
 		}
 	}
@@ -157,8 +160,8 @@ static ssize_t picolcd_debug_eeprom_write(struct file *f, const char __user *u,
 static const struct file_operations picolcd_debug_eeprom_fops = {
 	.owner    = THIS_MODULE,
 	.open     = simple_open,
-	.read     = picolcd_debug_eeprom_read,
-	.write    = picolcd_debug_eeprom_write,
+	.read_iter = picolcd_debug_eeprom_read,
+	.write_iter = picolcd_debug_eeprom_write,
 	.llseek   = generic_file_llseek,
 };
 
@@ -229,6 +232,7 @@ static ssize_t picolcd_debug_flash_read(struct file *f, char __user *u,
 	else
 		return _picolcd_flash_read(data, REPORT_READ_MEMORY, u, s, off);
 }
+FOPS_READ_ITER_HELPER(picolcd_debug_flash_read);
 
 /* erase block aligned to 64bytes boundary */
 static ssize_t _picolcd_flash_erase64(struct picolcd_data *data, int report_id,
@@ -335,6 +339,7 @@ static ssize_t picolcd_debug_flash_write(struct file *f, const char __user *u,
 	mutex_unlock(&data->mutex_flash);
 	return ret > 0 ? ret : err;
 }
+FOPS_WRITE_ITER_HELPER(picolcd_debug_flash_write);
 
 /*
  * Notes:
@@ -350,8 +355,8 @@ static ssize_t picolcd_debug_flash_write(struct file *f, const char __user *u,
 static const struct file_operations picolcd_debug_flash_fops = {
 	.owner    = THIS_MODULE,
 	.open     = simple_open,
-	.read     = picolcd_debug_flash_read,
-	.write    = picolcd_debug_flash_write,
+	.read_iter = picolcd_debug_flash_read_iter,
+	.write_iter = picolcd_debug_flash_write_iter,
 	.llseek   = generic_file_llseek,
 };
 
diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index c7f7562e22e5..072da9cf04a9 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -70,14 +70,14 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICES];
 /* protects modifications of devices array */
 static DEFINE_MUTEX(devices_lock);
 
-static ssize_t roccat_read(struct file *file, char __user *buffer,
-		size_t count, loff_t *ppos)
+static ssize_t roccat_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct roccat_reader *reader = file->private_data;
+	struct roccat_reader *reader = iocb->ki_filp->private_data;
 	struct roccat_device *device = reader->device;
 	struct roccat_report *report;
 	ssize_t retval = 0, len;
 	DECLARE_WAITQUEUE(wait, current);
+	size_t count = iov_iter_count(to);
 
 	mutex_lock(&device->cbuf_lock);
 
@@ -88,7 +88,7 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
 
 		/* wait for data */
 		while (reader->cbuf_start == device->cbuf_end) {
-			if (file->f_flags & O_NONBLOCK) {
+			if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 				retval = -EAGAIN;
 				break;
 			}
@@ -122,7 +122,7 @@ static ssize_t roccat_read(struct file *file, char __user *buffer,
 	 */
 	len = device->report_size > count ? count : device->report_size;
 
-	if (copy_to_user(buffer, report->value, len)) {
+	if (!copy_to_iter_full(report->value, len, to)) {
 		retval = -EFAULT;
 		goto exit_unlock;
 	}
@@ -407,7 +407,7 @@ static long roccat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations roccat_ops = {
 	.owner = THIS_MODULE,
-	.read = roccat_read,
+	.read_iter = roccat_read,
 	.poll = roccat_poll,
 	.open = roccat_open,
 	.release = roccat_release,
diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index d85398721659..a4e58e82b3f1 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -669,6 +669,7 @@ static ssize_t hid_sensor_custom_read(struct file *file, char __user *buf,
 
 	return copied;
 }
+FOPS_READ_ITER_HELPER(hid_sensor_custom_read);
 
 static int hid_sensor_custom_release(struct inode *inode, struct file *file)
 {
@@ -714,7 +715,7 @@ static __poll_t hid_sensor_custom_poll(struct file *file,
 
 static const struct file_operations hid_sensor_custom_fops = {
 	.open =  hid_sensor_custom_open,
-	.read =  hid_sensor_custom_read,
+	.read_iter =  hid_sensor_custom_read_iter,
 	.release = hid_sensor_custom_release,
 	.poll = hid_sensor_custom_poll,
 	.llseek = noop_llseek,
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index 00f9be55f148..5a7a0991a8f7 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -71,11 +71,12 @@ static ssize_t wiidebug_eeprom_read(struct file *f, char __user *u, size_t s,
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(wiidebug_eeprom_read);
 
 static const struct file_operations wiidebug_eeprom_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = wiidebug_eeprom_read,
+	.read_iter = wiidebug_eeprom_read_iter,
 	.llseek = generic_file_llseek,
 };
 
@@ -121,11 +122,11 @@ static int wiidebug_drm_open(struct inode *i, struct file *f)
 	return single_open(f, wiidebug_drm_show, i->i_private);
 }
 
-static ssize_t wiidebug_drm_write(struct file *f, const char __user *u,
-							size_t s, loff_t *off)
+static ssize_t wiidebug_drm_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *sf = f->private_data;
+	struct seq_file *sf = iocb->ki_filp->private_data;
 	struct wiimote_debug *dbg = sf->private;
+	size_t s = iov_iter_count(from);
 	unsigned long flags;
 	char buf[16];
 	ssize_t len;
@@ -135,7 +136,7 @@ static ssize_t wiidebug_drm_write(struct file *f, const char __user *u,
 		return -EINVAL;
 
 	len = min((size_t) 15, s);
-	if (copy_from_user(buf, u, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = 0;
@@ -163,9 +164,9 @@ static ssize_t wiidebug_drm_write(struct file *f, const char __user *u,
 static const struct file_operations wiidebug_drm_fops = {
 	.owner = THIS_MODULE,
 	.open = wiidebug_drm_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
-	.write = wiidebug_drm_write,
+	.write_iter = wiidebug_drm_write,
 	.release = single_release,
 };
 
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 2bc762d31ac7..54fab17f45a5 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -38,9 +38,10 @@ static const struct class hidraw_class = {
 static struct hidraw *hidraw_table[HIDRAW_MAX_DEVICES];
 static DECLARE_RWSEM(minors_rwsem);
 
-static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t hidraw_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hidraw_list *list = file->private_data;
+	struct hidraw_list *list = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	int ret = 0, len;
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -60,7 +61,7 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
 					ret = -EIO;
 					break;
 				}
-				if (file->f_flags & O_NONBLOCK) {
+				if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 					ret = -EAGAIN;
 					break;
 				}
@@ -83,7 +84,7 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
 			count : list->buffer[list->tail].len;
 
 		if (list->buffer[list->tail].value) {
-			if (copy_to_user(buffer, list->buffer[list->tail].value, len)) {
+			if (!copy_to_iter_full(list->buffer[list->tail].value, len, to)) {
 				ret = -EFAULT;
 				goto out;
 			}
@@ -167,7 +168,7 @@ static ssize_t hidraw_write(struct file *file, const char __user *buffer, size_t
 	up_read(&minors_rwsem);
 	return ret;
 }
-
+FOPS_WRITE_ITER_HELPER(hidraw_write);
 
 /*
  * This function performs a Get_Report transfer over the control endpoint
@@ -505,8 +506,8 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations hidraw_ops = {
 	.owner =        THIS_MODULE,
-	.read =         hidraw_read,
-	.write =        hidraw_write,
+	.read_iter =    hidraw_read,
+	.write_iter =   hidraw_write_iter,
 	.poll =         hidraw_poll,
 	.open =         hidraw_open,
 	.release =      hidraw_release,
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index a54c7995b9be..fb23cff65c92 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -669,10 +669,10 @@ static int uhid_char_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t uhid_char_read(struct file *file, char __user *buffer,
-				size_t count, loff_t *ppos)
+static ssize_t uhid_char_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct uhid_device *uhid = file->private_data;
+	struct uhid_device *uhid = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	int ret;
 	unsigned long flags;
 	size_t len;
@@ -682,7 +682,7 @@ static ssize_t uhid_char_read(struct file *file, char __user *buffer,
 		return -EINVAL;
 
 try_again:
-	if (file->f_flags & O_NONBLOCK) {
+	if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 		if (uhid->head == uhid->tail)
 			return -EAGAIN;
 	} else {
@@ -701,7 +701,7 @@ static ssize_t uhid_char_read(struct file *file, char __user *buffer,
 		goto try_again;
 	} else {
 		len = min(count, sizeof(**uhid->outq));
-		if (copy_to_user(buffer, uhid->outq[uhid->tail], len)) {
+		if (!copy_to_iter_full(uhid->outq[uhid->tail], len, to)) {
 			ret = -EFAULT;
 		} else {
 			kfree(uhid->outq[uhid->tail]);
@@ -782,6 +782,7 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 	/* return "count" not "len" to not confuse the caller */
 	return ret ? ret : count;
 }
+FOPS_WRITE_ITER_HELPER(uhid_char_write);
 
 static __poll_t uhid_char_poll(struct file *file, poll_table *wait)
 {
@@ -800,8 +801,8 @@ static const struct file_operations uhid_fops = {
 	.owner		= THIS_MODULE,
 	.open		= uhid_char_open,
 	.release	= uhid_char_release,
-	.read		= uhid_char_read,
-	.write		= uhid_char_write,
+	.read_iter	= uhid_char_read,
+	.write_iter	= uhid_char_write_iter,
 	.poll		= uhid_char_poll,
 	.llseek		= no_llseek,
 };
-- 
2.43.0


