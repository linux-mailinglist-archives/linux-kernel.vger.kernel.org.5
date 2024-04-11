Return-Path: <linux-kernel+bounces-140971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5318A1A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41CD0B29AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F85517AD96;
	Thu, 11 Apr 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="leBWsYW4"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57917AD6E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849840; cv=none; b=Z1+kLYbRt7fm31ZZ28wSGskT9PANU5i9h9U/Psw6eiT3RZd8fn4ZaUH8fXHkR5t6SWYZgIFBjGibhZugtSY+cjfsp1hw1reQrFeHa4FOgos2+dzEUNhGh8lNAENqlcizcuqqYhmZi/ryfO0cYG3ayaOe2BdZAhUp60molEeD2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849840; c=relaxed/simple;
	bh=YgKKAw0gpDESSsI2B6G/XXVsv75kYSvOz6HNWqNIjR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StKLz+s7u4O7aMPbvw2J4tEK43mPk1NrhWtptA44fgdWA4vJYgTSno9Ps/Q4TwzgNLLSylUznpT82aen3fhObYVEpaG1qfUjEIT5dnFXBoAMR1vnZFiTPdeXJYCDp9vvhQSNK6qXbB8DFQbiY+/qtZFqQ0YDxvifMTHYlIINN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=leBWsYW4; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8971239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849838; x=1713454638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8L8sEl0WgDwyMr/iJ731l7Aq9M52WzbzAWJBy9EPdM=;
        b=leBWsYW4QeFWAsA3Zrh8b6jnUeUUDwwajofe4gzeGJkfQ5XdgFYy6etmzvqBZ2HqQL
         vPbBVycpxtIGwFh2EChzuJaibc+BRhdsnZlTBY1IrsgXJnIWf+mEQOHNSe+YSzirgL13
         jA+NLgHmFQC1Yv1UHVcZ/TmYhqjbX4DHqMKoiHenjhcXUJBIluHYKhzBm+Kb7+395gGK
         BgPnmQespTllP3iRAHbSbEIrgUKQakZ1FEcHkvQ1CWMT/B/QH6g8WDz7xoUhwNjU43LM
         Hl0HmJ8/2KU+gQWraw6V3BJiDak4l9mvQlHicuOJ14w06IFG2Obj8DWwQw1qkrDReI2M
         NmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849838; x=1713454638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8L8sEl0WgDwyMr/iJ731l7Aq9M52WzbzAWJBy9EPdM=;
        b=qEH/Srg1xHKOXbQbsqeuwmBWnZl2+s3wHN845qGQrY21CDvXrLEQS3EIuSpGQhzfPH
         xfQbBsKWBVoDoHzWvkmuIXL7Ey8n8sCKJPmlqySmlBCiwcb5RIwO+8RWhwisAVTxrTQV
         1LIeT/bo9fQzuaGVALd1wC+FFv4wJrLKwrFksoPMAxLhttPJ6Xm/+NzF4b2g3HhuhDqM
         hgJHDZmSbh725sx3m+SqyLxBn8Fh5lWXrExoxY1GbA/wzHJ3HBbipA7n8LTmCB1SRusX
         UF6vlIpdOsrVu2c6T/SuXHqs28e1/7JQhqNg68mX1CADtZ+xFON+0f955JbaopGGh5aP
         JHPg==
X-Gm-Message-State: AOJu0YySA07/th2t3Ql4KQ9Q+rbUUyF0nv5BBhB5B4SqELSTwzPtwdc2
	bzONNR62nOxKgBzv9ehGXnig/1EfJpdkajah+CxHCnHna6kVGxLHXck9j57PeZdxuTISWkd102w
	3
X-Google-Smtp-Source: AGHT+IFDeQ2HNukEXPQ2crxfo6oqaj6M/HAQG2sYDLHTDP9x0NiXerdTQ+bmFDY84FO5Vbk1KjH9Rw==
X-Received: by 2002:a92:d352:0:b0:36a:1275:4aeb with SMTP id a18-20020a92d352000000b0036a12754aebmr5885173ilh.1.1712849837855;
        Thu, 11 Apr 2024 08:37:17 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 202/437] staging: greybus: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:42 -0600
Message-ID: <20240411153126.16201-203-axboe@kernel.dk>
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
 drivers/greybus/es2.c            | 29 ++++++++++++++---------------
 drivers/greybus/svc.c            | 27 ++++++++++++---------------
 drivers/staging/greybus/camera.c | 22 ++++++++++------------
 drivers/staging/greybus/raw.c    |  6 ++++--
 4 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index 1ee78d0d90b4..ef9c68ef8632 100644
--- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -1109,10 +1109,10 @@ static int apb_log_poll(void *data)
 	return 0;
 }
 
-static ssize_t apb_log_read(struct file *f, char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t apb_log_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct es2_ap_dev *es2 = file_inode(f)->i_private;
+	struct es2_ap_dev *es2 = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(to);
 	ssize_t ret;
 	size_t copied;
 	char *tmp_buf;
@@ -1125,7 +1125,7 @@ static ssize_t apb_log_read(struct file *f, char __user *buf,
 		return -ENOMEM;
 
 	copied = kfifo_out(&es2->apb_log_fifo, tmp_buf, count);
-	ret = simple_read_from_buffer(buf, count, ppos, tmp_buf, copied);
+	ret = simple_copy_to_iter(tmp_buf, &iocb->ki_pos, copied, to);
 
 	kfree(tmp_buf);
 
@@ -1133,7 +1133,7 @@ static ssize_t apb_log_read(struct file *f, char __user *buf,
 }
 
 static const struct file_operations apb_log_fops = {
-	.read	= apb_log_read,
+	.read_iter	= apb_log_read,
 };
 
 static void usb_log_enable(struct es2_ap_dev *es2)
@@ -1163,25 +1163,24 @@ static void usb_log_disable(struct es2_ap_dev *es2)
 	es2->apb_log_task = NULL;
 }
 
-static ssize_t apb_log_enable_read(struct file *f, char __user *buf,
-				   size_t count, loff_t *ppos)
+static ssize_t apb_log_enable_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct es2_ap_dev *es2 = file_inode(f)->i_private;
+	struct es2_ap_dev *es2 = file_inode(iocb->ki_filp)->i_private;
 	int enable = !IS_ERR_OR_NULL(es2->apb_log_task);
 	char tmp_buf[3];
 
 	sprintf(tmp_buf, "%d\n", enable);
-	return simple_read_from_buffer(buf, count, ppos, tmp_buf, 2);
+	return simple_copy_to_iter(tmp_buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t apb_log_enable_write(struct file *f, const char __user *buf,
-				    size_t count, loff_t *ppos)
+static ssize_t apb_log_enable_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int enable;
 	ssize_t retval;
-	struct es2_ap_dev *es2 = file_inode(f)->i_private;
+	struct es2_ap_dev *es2 = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 
-	retval = kstrtoint_from_user(buf, count, 10, &enable);
+	retval = kstrtoint_from_iter(from, count, 10, &enable);
 	if (retval)
 		return retval;
 
@@ -1194,8 +1193,8 @@ static ssize_t apb_log_enable_write(struct file *f, const char __user *buf,
 }
 
 static const struct file_operations apb_log_enable_fops = {
-	.read	= apb_log_enable_read,
-	.write	= apb_log_enable_write,
+	.read_iter	= apb_log_enable_read,
+	.write_iter	= apb_log_enable_write,
 };
 
 static int apb_get_cport_count(struct usb_device *udev)
diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index 4256467fcd35..989ee7a3ac17 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -673,11 +673,10 @@ static int gb_svc_version_request(struct gb_operation *op)
 	return 0;
 }
 
-static ssize_t pwr_debugfs_voltage_read(struct file *file, char __user *buf,
-					size_t len, loff_t *offset)
+static ssize_t pwr_debugfs_voltage_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct svc_debugfs_pwrmon_rail *pwrmon_rails =
-		file_inode(file)->i_private;
+		file_inode(iocb->ki_filp)->i_private;
 	struct gb_svc *svc = pwrmon_rails->svc;
 	int ret, desc;
 	u32 value;
@@ -694,14 +693,13 @@ static ssize_t pwr_debugfs_voltage_read(struct file *file, char __user *buf,
 
 	desc = scnprintf(buff, sizeof(buff), "%u\n", value);
 
-	return simple_read_from_buffer(buf, len, offset, buff, desc);
+	return simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 }
 
-static ssize_t pwr_debugfs_current_read(struct file *file, char __user *buf,
-					size_t len, loff_t *offset)
+static ssize_t pwr_debugfs_current_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct svc_debugfs_pwrmon_rail *pwrmon_rails =
-		file_inode(file)->i_private;
+		file_inode(iocb->ki_filp)->i_private;
 	struct gb_svc *svc = pwrmon_rails->svc;
 	int ret, desc;
 	u32 value;
@@ -718,14 +716,13 @@ static ssize_t pwr_debugfs_current_read(struct file *file, char __user *buf,
 
 	desc = scnprintf(buff, sizeof(buff), "%u\n", value);
 
-	return simple_read_from_buffer(buf, len, offset, buff, desc);
+	return simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 }
 
-static ssize_t pwr_debugfs_power_read(struct file *file, char __user *buf,
-				      size_t len, loff_t *offset)
+static ssize_t pwr_debugfs_power_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct svc_debugfs_pwrmon_rail *pwrmon_rails =
-		file_inode(file)->i_private;
+		file_inode(iocb->ki_filp)->i_private;
 	struct gb_svc *svc = pwrmon_rails->svc;
 	int ret, desc;
 	u32 value;
@@ -741,19 +738,19 @@ static ssize_t pwr_debugfs_power_read(struct file *file, char __user *buf,
 
 	desc = scnprintf(buff, sizeof(buff), "%u\n", value);
 
-	return simple_read_from_buffer(buf, len, offset, buff, desc);
+	return simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 }
 
 static const struct file_operations pwrmon_debugfs_voltage_fops = {
-	.read		= pwr_debugfs_voltage_read,
+	.read_iter	= pwr_debugfs_voltage_read,
 };
 
 static const struct file_operations pwrmon_debugfs_current_fops = {
-	.read		= pwr_debugfs_current_read,
+	.read_iter	= pwr_debugfs_current_read,
 };
 
 static const struct file_operations pwrmon_debugfs_power_fops = {
-	.read		= pwr_debugfs_power_read,
+	.read_iter	= pwr_debugfs_power_read,
 };
 
 static void gb_svc_pwrmon_debugfs_init(struct gb_svc *svc)
diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
index a8173aa3a995..f18f690a31ee 100644
--- a/drivers/staging/greybus/camera.c
+++ b/drivers/staging/greybus/camera.c
@@ -1086,10 +1086,9 @@ static const struct gb_camera_debugfs_entry gb_camera_debugfs_entries[] = {
 	},
 };
 
-static ssize_t gb_camera_debugfs_read(struct file *file, char __user *buf,
-				      size_t len, loff_t *offset)
+static ssize_t gb_camera_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	const struct gb_camera_debugfs_entry *op = file->private_data;
+	const struct gb_camera_debugfs_entry *op = iocb->ki_filp->private_data;
 	struct gb_camera *gcam = file_inode(file)->i_private;
 	struct gb_camera_debugfs_buffer *buffer;
 	ssize_t ret;
@@ -1103,23 +1102,22 @@ static ssize_t gb_camera_debugfs_read(struct file *file, char __user *buf,
 
 	buffer = &gcam->debugfs.buffers[op->buffer];
 
-	return simple_read_from_buffer(buf, len, offset, buffer->data,
-				       buffer->length);
+	return simple_copy_to_iter(buffer->data, &iocb->ki_pos, buffer->length,
+					to);
 }
 
-static ssize_t gb_camera_debugfs_write(struct file *file,
-				       const char __user *buf, size_t len,
-				       loff_t *offset)
+static ssize_t gb_camera_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	const struct gb_camera_debugfs_entry *op = file->private_data;
+	const struct gb_camera_debugfs_entry *op = iocb->ki_filp->private_data;
 	struct gb_camera *gcam = file_inode(file)->i_private;
+	size_t len = iov_iter_count(from);
 	ssize_t ret;
 	char *kbuf;
 
 	if (len > 1024)
 		return -EINVAL;
 
-	kbuf = memdup_user_nul(buf, len);
+	kbuf = iterdup_nul(buf, len);
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
@@ -1149,8 +1147,8 @@ static int gb_camera_debugfs_open(struct inode *inode, struct file *file)
 
 static const struct file_operations gb_camera_debugfs_ops = {
 	.open = gb_camera_debugfs_open,
-	.read = gb_camera_debugfs_read,
-	.write = gb_camera_debugfs_write,
+	.read_iter = gb_camera_debugfs_read,
+	.write_iter = gb_camera_debugfs_write,
 };
 
 static int gb_camera_debugfs_init(struct gb_camera *gcam)
diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
index 836d35e5fa85..44b85032b755 100644
--- a/drivers/staging/greybus/raw.c
+++ b/drivers/staging/greybus/raw.c
@@ -284,6 +284,7 @@ static ssize_t raw_write(struct file *file, const char __user *buf,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(raw_write);
 
 static ssize_t raw_read(struct file *file, char __user *buf, size_t count,
 			loff_t *ppos)
@@ -316,11 +317,12 @@ static ssize_t raw_read(struct file *file, char __user *buf, size_t count,
 	mutex_unlock(&raw->list_lock);
 	return retval;
 }
+FOPS_READ_ITER_HELPER(raw_read);
 
 static const struct file_operations raw_fops = {
 	.owner		= THIS_MODULE,
-	.write		= raw_write,
-	.read		= raw_read,
+	.write_iter	= raw_write_iter,
+	.read_iter	= raw_read_iter,
 	.open		= raw_open,
 	.llseek		= noop_llseek,
 };
-- 
2.43.0


