Return-Path: <linux-kernel+bounces-141158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A98A1ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6863B28D5BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7911F20F4;
	Thu, 11 Apr 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N7N1ZU+u"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF751F20C5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850135; cv=none; b=pdcS5snznZjI1iHp82i6Z05U21eX1rvRe01LxmYc8ZP9UbVmXgo0ELpInrhoUo5PsbFWN3T6YRZGwnI3wINOpEWfRv25AMBi5KUHrfZHo5Ni4Ioj4znWzGLhQDyEecACjedXGTRUf9go1wLqnskfpTv8Gyzk+kLf+KmwuC/agWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850135; c=relaxed/simple;
	bh=nQ7inigwCM9TZ1BOLv7VZuWOnWx94/e1sqHLK9wqdpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdS13/aP2IuhRNVR5I1RkJzPSasorb7k0sl5BC8sgUw846Xo+B2UuzQYivB46M4N1VRHyAwuy6c9RNrjhWgYGsl9SOd5hTdCaxV0mCC7b+Vt805/NlytmOP6k89vYOuLjKDXlpeKgz+twjUglOTzcKxKB8aME6w2N/XUZiTRkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N7N1ZU+u; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58255039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850132; x=1713454932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwtpRuvpd0enzm9gHDySDTRg9gYqaPKn4brSPhQiTgI=;
        b=N7N1ZU+uibrP3oDC/Vvp3xcyHh94iGPHP2GvhNpN7KMtWNfWmTwTw0KUo43RaLw+I0
         9CrAPQu7H0yVkjpgGNqwJbZjLlioblNzTcqvfCOy0yC0kOcLP/rih79Jcfon/7/hp83q
         eeyEHVhKdSPr7qAuzjxHqe16/GsdCo/hA2UJtwBr3+ScCSeGpvu2tS+j3jqfogvLbwOQ
         c0wYuPmxz6ooGu+cQc4V/NApdjPhnIfBdIyzRUFTG9DxSl23N1yAKarOQEYIoy425nY0
         4wZne75MO5F4kZOzG8A93tP24jy0U5qHHCoP6QQNSXLY57mlcjn8TuXPn60hGUA0WVDK
         yNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850132; x=1713454932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwtpRuvpd0enzm9gHDySDTRg9gYqaPKn4brSPhQiTgI=;
        b=ETSP1SV3QwQdaOdOx86DDNEW3Pl6oPKSWAcmJwtlTnFiyYWg/jhCDcTzZdSaMCrFHb
         MkX1mHWCrvO98cNAft1baRRd5XEN5VkHtHcWKuGA0ax7XnwMOhWVoE1gNmUZHB1jmhzI
         +tozDx1V1nrHVZfSFAtvGeuSf9ZivZW0ug8zhArhWzYqwOdLj7LqjlnltOkv/GbnpQVl
         oKP9pnd1SXO14SzINSGHubn0oW/Kmw9/fmL0L5efMuYQdRzb6SE1zbIDll35w1G1k1fA
         lOcWB7DpZTZdkyYZEgGov82mHCTDLMjv2vju6C/gYH+UawRAMaXRmR1pkL7zxImKJRau
         ZJ+w==
X-Gm-Message-State: AOJu0YwdI9uGsqN9Vc2zxD9JH7bhpsPr9hdTsLjMVliHdJuld7L6J2HJ
	kDRiCrnNen6jjJPF7GFRqtFjliyo29XUh21ECXGtdLjE4iflDdtBEBJi93tKdnEmq9/u/A8msek
	+
X-Google-Smtp-Source: AGHT+IFTSOW/N+rzPD6opOm9bo8lu3i0TGoy8muj9Nl2w/4PU6p+8wqLnlnMp1J9/OCtj4nQly+Q3Q==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr177917ioh.1.1712850131930;
        Thu, 11 Apr 2024 08:42:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 376/437] drivers/fsi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:36 -0600
Message-ID: <20240411153126.16201-377-axboe@kernel.dk>
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
 drivers/fsi/fsi-core.c    | 28 ++++++++++++++--------------
 drivers/fsi/fsi-occ.c     | 20 ++++++++++----------
 drivers/fsi/fsi-sbefifo.c |  6 ++++--
 drivers/fsi/fsi-scom.c    | 24 ++++++++++++------------
 drivers/fsi/i2cr-scom.c   | 23 ++++++++++++-----------
 5 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 097d5a780264..ce68c470d30e 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -657,12 +657,12 @@ static struct device_node *fsi_slave_find_of_node(struct fsi_master *master,
 	return NULL;
 }
 
-static ssize_t cfam_read(struct file *filep, char __user *buf, size_t count,
-			 loff_t *offset)
+static ssize_t cfam_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct fsi_slave *slave = filep->private_data;
+	struct fsi_slave *slave = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	size_t total_len, read_len;
-	loff_t off = *offset;
+	loff_t off = iocb->ki_pos;
 	ssize_t rc;
 
 	if (off < 0)
@@ -680,7 +680,7 @@ static ssize_t cfam_read(struct file *filep, char __user *buf, size_t count,
 		rc = fsi_slave_read(slave, off, &data, read_len);
 		if (rc)
 			goto fail;
-		rc = copy_to_user(buf + total_len, &data, read_len);
+		rc = !copy_to_iter_full(&data, read_len, to);
 		if (rc) {
 			rc = -EFAULT;
 			goto fail;
@@ -689,16 +689,16 @@ static ssize_t cfam_read(struct file *filep, char __user *buf, size_t count,
 	}
 	rc = count;
  fail:
-	*offset = off;
+	iocb->ki_pos = off;
 	return rc;
 }
 
-static ssize_t cfam_write(struct file *filep, const char __user *buf,
-			  size_t count, loff_t *offset)
+static ssize_t cfam_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct fsi_slave *slave = filep->private_data;
+	struct fsi_slave *slave = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	size_t total_len, write_len;
-	loff_t off = *offset;
+	loff_t off = iocb->ki_pos;
 	ssize_t rc;
 
 
@@ -714,7 +714,7 @@ static ssize_t cfam_write(struct file *filep, const char __user *buf,
 		write_len = min_t(size_t, count, 4);
 		write_len -= off & 0x3;
 
-		rc = copy_from_user(&data, buf + total_len, write_len);
+		rc = !copy_from_iter_full(&data, write_len, from);
 		if (rc) {
 			rc = -EFAULT;
 			goto fail;
@@ -726,7 +726,7 @@ static ssize_t cfam_write(struct file *filep, const char __user *buf,
 	}
 	rc = count;
  fail:
-	*offset = off;
+	iocb->ki_pos = off;
 	return rc;
 }
 
@@ -758,8 +758,8 @@ static const struct file_operations cfam_fops = {
 	.owner		= THIS_MODULE,
 	.open		= cfam_open,
 	.llseek		= cfam_llseek,
-	.read		= cfam_read,
-	.write		= cfam_write,
+	.read_iter	= cfam_read,
+	.write_iter	= cfam_write,
 };
 
 static ssize_t send_term_store(struct device *dev,
diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index da35ca9e84a6..1145df7dbec8 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -104,10 +104,10 @@ static int occ_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t occ_read(struct file *file, char __user *buf, size_t len,
-			loff_t *offset)
+static ssize_t occ_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct occ_client *client = file->private_data;
+	struct occ_client *client = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	ssize_t rc = 0;
 
 	if (!client)
@@ -126,7 +126,7 @@ static ssize_t occ_read(struct file *file, char __user *buf, size_t len,
 
 	/* Grab how much data we have to read */
 	rc = min(len, client->data_size - client->read_offset);
-	if (copy_to_user(buf, client->buffer + client->read_offset, rc))
+	if (!copy_to_iter_full(client->buffer + client->read_offset, rc, to))
 		rc = -EFAULT;
 	else
 		client->read_offset += rc;
@@ -137,10 +137,10 @@ static ssize_t occ_read(struct file *file, char __user *buf, size_t len,
 	return rc;
 }
 
-static ssize_t occ_write(struct file *file, const char __user *buf,
-			 size_t len, loff_t *offset)
+static ssize_t occ_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct occ_client *client = file->private_data;
+	struct occ_client *client = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	size_t rlen, data_length;
 	ssize_t rc;
 	u8 *cmd;
@@ -163,7 +163,7 @@ static ssize_t occ_write(struct file *file, const char __user *buf,
 	 * bytes 1-2: data length (msb first)
 	 * bytes 3-n: data
 	 */
-	if (copy_from_user(&cmd[1], buf, len)) {
+	if (!copy_from_iter_full(&cmd[1], len, from)) {
 		rc = -EFAULT;
 		goto done;
 	}
@@ -209,8 +209,8 @@ static int occ_release(struct inode *inode, struct file *file)
 static const struct file_operations occ_fops = {
 	.owner = THIS_MODULE,
 	.open = occ_open,
-	.read = occ_read,
-	.write = occ_write,
+	.read_iter = occ_read,
+	.write_iter = occ_write,
 	.release = occ_release,
 };
 
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 0a98517f3959..0fe2e4730b4b 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -864,6 +864,7 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
 	mutex_unlock(&user->file_lock);
 	return rc;
 }
+FOPS_READ_ITER_HELPER(sbefifo_user_read);
 
 static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
 				  size_t len, loff_t *offset)
@@ -927,6 +928,7 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
 	/* And that's it, we'll issue the command on a read */
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(sbefifo_user_write);
 
 static int sbefifo_user_release(struct inode *inode, struct file *file)
 {
@@ -1004,8 +1006,8 @@ static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, unsigned lon
 static const struct file_operations sbefifo_fops = {
 	.owner		= THIS_MODULE,
 	.open		= sbefifo_user_open,
-	.read		= sbefifo_user_read,
-	.write		= sbefifo_user_write,
+	.read_iter	= sbefifo_user_read_iter,
+	.write_iter	= sbefifo_user_write_iter,
 	.release	= sbefifo_user_release,
 	.unlocked_ioctl = sbefifo_user_ioctl,
 };
diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 61dbda9dbe2b..1e8e5dcdfb39 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -310,11 +310,11 @@ static int get_scom(struct scom_device *scom, uint64_t *value,
 				 >> SCOM_STATUS_PIB_RESP_SHIFT);
 }
 
-static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
-			 loff_t *offset)
+static ssize_t scom_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct scom_device *scom = filep->private_data;
+	struct scom_device *scom = iocb->ki_filp->private_data;
 	struct device *dev = &scom->fsi_dev->dev;
+	size_t len = iov_iter_count(to);
 	uint64_t val;
 	int rc;
 
@@ -325,32 +325,32 @@ static ssize_t scom_read(struct file *filep, char __user *buf, size_t len,
 	if (scom->dead)
 		rc = -ENODEV;
 	else
-		rc = get_scom(scom, &val, *offset);
+		rc = get_scom(scom, &val, iocb->ki_pos);
 	mutex_unlock(&scom->lock);
 	if (rc) {
 		dev_dbg(dev, "get_scom fail:%d\n", rc);
 		return rc;
 	}
 
-	rc = copy_to_user(buf, &val, len);
+	rc = !copy_to_iter_full(&val, len, to);
 	if (rc)
 		dev_dbg(dev, "copy to user failed:%d\n", rc);
 
 	return rc ? rc : len;
 }
 
-static ssize_t scom_write(struct file *filep, const char __user *buf,
-			  size_t len, loff_t *offset)
+static ssize_t scom_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int rc;
-	struct scom_device *scom = filep->private_data;
+	struct scom_device *scom = iocb->ki_filp->private_data;
 	struct device *dev = &scom->fsi_dev->dev;
+	size_t len = iov_iter_count(from);
 	uint64_t val;
 
 	if (len != sizeof(uint64_t))
 		return -EINVAL;
 
-	rc = copy_from_user(&val, buf, len);
+	rc = !copy_from_iter_full(&val, len, from);
 	if (rc) {
 		dev_dbg(dev, "copy from user failed:%d\n", rc);
 		return -EINVAL;
@@ -360,7 +360,7 @@ static ssize_t scom_write(struct file *filep, const char __user *buf,
 	if (scom->dead)
 		rc = -ENODEV;
 	else
-		rc = put_scom(scom, val, *offset);
+		rc = put_scom(scom, val, iocb->ki_pos);
 	mutex_unlock(&scom->lock);
 	if (rc) {
 		dev_dbg(dev, "put_scom failed with:%d\n", rc);
@@ -514,8 +514,8 @@ static const struct file_operations scom_fops = {
 	.owner		= THIS_MODULE,
 	.open		= scom_open,
 	.llseek		= scom_llseek,
-	.read		= scom_read,
-	.write		= scom_write,
+	.read_iter	= scom_read,
+	.write_iter	= scom_write,
 	.unlocked_ioctl	= scom_ioctl,
 };
 
diff --git a/drivers/fsi/i2cr-scom.c b/drivers/fsi/i2cr-scom.c
index cb7e02213032..e4b3a8310775 100644
--- a/drivers/fsi/i2cr-scom.c
+++ b/drivers/fsi/i2cr-scom.c
@@ -32,41 +32,42 @@ static loff_t i2cr_scom_llseek(struct file *file, loff_t offset, int whence)
 	return offset;
 }
 
-static ssize_t i2cr_scom_read(struct file *filep, char __user *buf, size_t len, loff_t *offset)
+static ssize_t i2cr_scom_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct i2cr_scom *scom = filep->private_data;
+	struct i2cr_scom *scom = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	u64 data;
 	int ret;
 
 	if (len != sizeof(data))
 		return -EINVAL;
 
-	ret = fsi_master_i2cr_read(scom->i2cr, (u32)*offset, &data);
+	ret = fsi_master_i2cr_read(scom->i2cr, (u32)iocb->ki_pos, &data);
 	if (ret)
 		return ret;
 
-	ret = copy_to_user(buf, &data, len);
+	ret = !copy_to_iter_full(&data, len, to);
 	if (ret)
 		return ret;
 
 	return len;
 }
 
-static ssize_t i2cr_scom_write(struct file *filep, const char __user *buf, size_t len,
-			       loff_t *offset)
+static ssize_t i2cr_scom_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct i2cr_scom *scom = filep->private_data;
+	struct i2cr_scom *scom = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	u64 data;
 	int ret;
 
 	if (len != sizeof(data))
 		return -EINVAL;
 
-	ret = copy_from_user(&data, buf, len);
+	ret = !copy_from_iter(&data, len, from);
 	if (ret)
 		return ret;
 
-	ret = fsi_master_i2cr_write(scom->i2cr, (u32)*offset, data);
+	ret = fsi_master_i2cr_write(scom->i2cr, (u32)iocb->ki_pos, data);
 	if (ret)
 		return ret;
 
@@ -77,8 +78,8 @@ static const struct file_operations i2cr_scom_fops = {
 	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.llseek		= i2cr_scom_llseek,
-	.read		= i2cr_scom_read,
-	.write		= i2cr_scom_write,
+	.read_iter	= i2cr_scom_read,
+	.write_iter	= i2cr_scom_write,
 };
 
 static int i2cr_scom_probe(struct device *dev)
-- 
2.43.0


