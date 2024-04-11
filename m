Return-Path: <linux-kernel+bounces-140779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC48A18EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F251F2123C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66BC4AEC7;
	Thu, 11 Apr 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ez1gL4pw"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C019481C6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849528; cv=none; b=gYNDiux8ztuXIBWh/vdyZocdcnU5SFcT6sZ9HlDpe7LFyNAfGd44cvRZtp9HX4/2n9CD/XYJZfDHV1fPDbjQ08PEN9EYM8G/ExSo9eOjytMuGpAiiUiba9NkduA4FM67buXTBLuIjn/jeRC1atUhRAi3U4mG5Hrnu01lHkViXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849528; c=relaxed/simple;
	bh=TIg6/xRT1sF2uz3iDSlDLHbUI07ew3w55/s+64nRfV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8IJiHoRTYKGl7GJCY2MzOW0EMhLPWEFYGNY3u606nypZOVN8W2kt0Q66B+6qWCPFRIYdfubeo1WW1pYYvNmWJWiRJ+rVzEyqzJH0LOcm8StJNu5WC3yDVSaaoQFvLAxJ32IU2EAxnM0Sq4GQ9Wj3OlvqRaFLv3IveMFehqvOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ez1gL4pw; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8849039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849526; x=1713454326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEIqreAhrWHWiNMJ3bjnYGKI5wqJlayBXmXujNYutLg=;
        b=ez1gL4pwlEyMCyQR2Zirsbqd7MrMj8Xz31E18QCzs8FqdAU74+dvbvMiVzHCktYddE
         yPi056SSpFwyJgCtiTdOpfSDW5dyvLGVc1EvulEhxEodj5i6mroYB2rIkJby7q8sh0Uf
         qejLos2HarmFyZgHS/EgfvGPKWlEezeoMCpxHaPMELO0MIYfrWl2meH4GlToLvvHnWtQ
         a3ZoeeL2XHuaYEUlZWxuuR02j5oWlwe+b6Jc4E/POW+0fdolET5lidxItc+Gqej90rgj
         1BSybtS/DWH4ABlRZVIuI2fkeXh9R2DN8JsAhU5ykrJX6Tq7RCOOVWcXHOVsTtmdRQLq
         kxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849526; x=1713454326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEIqreAhrWHWiNMJ3bjnYGKI5wqJlayBXmXujNYutLg=;
        b=ljK1irn9grFM5lbBRVRLbD9tA4YVt8Q9OMpwYkp136Z75kj56Z/u3WtRSRoshmhr8a
         URWqRqgpm1XEhJpCNoGOcWwHtlYZ/hwy9iQWjBZ2a28K4w5xT0y+APt/I6Rm9efeKI+2
         ljMgdLTJi2HRxv+R8tJlqBLwlQYA0dlywUTtPLVQEeCi5jCGIikOfuHCqYhrVvhbQLA8
         1oLWVal07h3W/1RHyVw8gX/p03M6yTtcXl29t0hizRasDLKmEzqyEfDbmuzxsdI60CHX
         bh7Vg7l6a31K9wtoS38sssmxaViTrP9HE47cHk7FuhrW/fiihQQ3iZ6kh48IizUn1Xer
         GKlw==
X-Gm-Message-State: AOJu0Yw4QqM86RXfYdUi+1QOCpDZUPQQteT8hYFh+7h1dZsxFFrLzP6d
	I+zxJ/08Lg0AzSKh21+LKnDqaIBMEPElPiEZ5OQ5Fn9Z5T1J/bCiYCt7B1m863BTeG2XhHiMoF5
	o
X-Google-Smtp-Source: AGHT+IES27zf7b+QjVz8qu+U8JgrFMdX8B/9/TvD1n6gnb6LfTBJJ2czbrnOTW1DjjgViqiyVk+zAQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr2844ioc.1.1712849525775;
        Thu, 11 Apr 2024 08:32:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 022/437] char/tpm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:42 -0600
Message-ID: <20240411153126.16201-23-axboe@kernel.dk>
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
 drivers/char/tpm/eventlog/common.c |  2 +-
 drivers/char/tpm/tpm-dev-common.c  | 26 +++++++++++++-------------
 drivers/char/tpm/tpm-dev.c         |  4 ++--
 drivers/char/tpm/tpm-dev.h         |  6 ++----
 drivers/char/tpm/tpm_vtpm_proxy.c  | 20 ++++++++++----------
 drivers/char/tpm/tpmrm-dev.c       |  4 ++--
 6 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 639c3f395a5a..5df887f7b119 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -66,7 +66,7 @@ static int tpm_bios_measurements_release(struct inode *inode,
 static const struct file_operations tpm_bios_measurements_ops = {
 	.owner = THIS_MODULE,
 	.open = tpm_bios_measurements_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = tpm_bios_measurements_release,
 };
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 30b4c288c1bb..6cb20cb43ac0 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -122,10 +122,10 @@ void tpm_common_open(struct file *file, struct tpm_chip *chip,
 	file->private_data = priv;
 }
 
-ssize_t tpm_common_read(struct file *file, char __user *buf,
-			size_t size, loff_t *off)
+ssize_t tpm_common_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct file_priv *priv = file->private_data;
+	struct file_priv *priv = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(to);
 	ssize_t ret_size = 0;
 	int rc;
 
@@ -140,21 +140,21 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 			goto out;
 		}
 
-		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
+		rc = !copy_to_iter_full(priv->data_buffer + iocb->ki_pos, ret_size, to);
 		if (rc) {
 			memset(priv->data_buffer, 0, TPM_BUFSIZE);
 			priv->response_length = 0;
 			ret_size = -EFAULT;
 		} else {
-			memset(priv->data_buffer + *off, 0, ret_size);
+			memset(priv->data_buffer + iocb->ki_pos, 0, ret_size);
 			priv->response_length -= ret_size;
-			*off += ret_size;
+			iocb->ki_pos += ret_size;
 		}
 	}
 
 out:
 	if (!priv->response_length) {
-		*off = 0;
+		iocb->ki_pos = 0;
 		del_timer_sync(&priv->user_read_timer);
 		flush_work(&priv->timeout_work);
 	}
@@ -162,10 +162,10 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 	return ret_size;
 }
 
-ssize_t tpm_common_write(struct file *file, const char __user *buf,
-			 size_t size, loff_t *off)
+ssize_t tpm_common_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct file_priv *priv = file->private_data;
+	struct file_priv *priv = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	int ret = 0;
 
 	if (size > TPM_BUFSIZE)
@@ -183,7 +183,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 		goto out;
 	}
 
-	if (copy_from_user(priv->data_buffer, buf, size)) {
+	if (!copy_from_iter_full(priv->data_buffer, size, from)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -196,7 +196,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 
 	priv->response_length = 0;
 	priv->response_read = false;
-	*off = 0;
+	iocb->ki_pos = 0;
 
 	/*
 	 * If in nonblocking mode schedule an async job to send
@@ -204,7 +204,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	 * In case of error the err code will be returned in
 	 * the subsequent read call.
 	 */
-	if (file->f_flags & O_NONBLOCK) {
+	if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 		priv->command_enqueued = true;
 		queue_work(tpm_dev_wq, &priv->async_work);
 		mutex_unlock(&priv->buffer_mutex);
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index e2c0baa69fef..2f499c38fef5 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -61,8 +61,8 @@ const struct file_operations tpm_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.open = tpm_open,
-	.read = tpm_common_read,
-	.write = tpm_common_write,
+	.read_iter = tpm_common_read_iter,
+	.write_iter = tpm_common_write_iter,
 	.poll = tpm_common_poll,
 	.release = tpm_release,
 };
diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
index f3742bcc73e3..bc02b9509724 100644
--- a/drivers/char/tpm/tpm-dev.h
+++ b/drivers/char/tpm/tpm-dev.h
@@ -23,10 +23,8 @@ struct file_priv {
 
 void tpm_common_open(struct file *file, struct tpm_chip *chip,
 		     struct file_priv *priv, struct tpm_space *space);
-ssize_t tpm_common_read(struct file *file, char __user *buf,
-			size_t size, loff_t *off);
-ssize_t tpm_common_write(struct file *file, const char __user *buf,
-			 size_t size, loff_t *off);
+ssize_t tpm_common_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t tpm_common_write_iter(struct kiocb *iocb, struct iov_iter *from);
 __poll_t tpm_common_poll(struct file *file, poll_table *wait);
 
 void tpm_common_release(struct file *file, struct file_priv *priv);
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 11c502039faf..70d51ccb9a98 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -69,10 +69,10 @@ static void vtpm_proxy_delete_device(struct proxy_dev *proxy_dev);
  * Return:
  *	Number of bytes read or negative error code
  */
-static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
-				    size_t count, loff_t *off)
+static ssize_t vtpm_proxy_fops_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct proxy_dev *proxy_dev = filp->private_data;
+	struct proxy_dev *proxy_dev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	size_t len;
 	int sig, rc;
 
@@ -98,7 +98,7 @@ static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
 		return -EIO;
 	}
 
-	rc = copy_to_user(buf, proxy_dev->buffer, len);
+	rc = !copy_to_iter_full(proxy_dev->buffer, len, to);
 	memset(proxy_dev->buffer, 0, len);
 	proxy_dev->req_len = 0;
 
@@ -124,10 +124,10 @@ static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
  * Return:
  *	Number of bytes read or negative error value
  */
-static ssize_t vtpm_proxy_fops_write(struct file *filp, const char __user *buf,
-				     size_t count, loff_t *off)
+static ssize_t vtpm_proxy_fops_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct proxy_dev *proxy_dev = filp->private_data;
+	struct proxy_dev *proxy_dev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
 	mutex_lock(&proxy_dev->buf_lock);
 
@@ -146,7 +146,7 @@ static ssize_t vtpm_proxy_fops_write(struct file *filp, const char __user *buf,
 
 	proxy_dev->req_len = 0;
 
-	if (copy_from_user(proxy_dev->buffer, buf, count)) {
+	if (!copy_from_iter_full(proxy_dev->buffer, count, from)) {
 		mutex_unlock(&proxy_dev->buf_lock);
 		return -EFAULT;
 	}
@@ -244,8 +244,8 @@ static int vtpm_proxy_fops_release(struct inode *inode, struct file *filp)
 static const struct file_operations vtpm_proxy_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
-	.read = vtpm_proxy_fops_read,
-	.write = vtpm_proxy_fops_write,
+	.read_iter = vtpm_proxy_fops_read,
+	.write_iter = vtpm_proxy_fops_write,
 	.poll = vtpm_proxy_fops_poll,
 	.release = vtpm_proxy_fops_release,
 };
diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index eef0fb06ea83..f1f5cc0ba627 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -48,8 +48,8 @@ const struct file_operations tpmrm_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 	.open = tpmrm_open,
-	.read = tpm_common_read,
-	.write = tpm_common_write,
+	.read_iter = tpm_common_read_iter,
+	.write_iter = tpm_common_write_iter,
 	.poll = tpm_common_poll,
 	.release = tpmrm_release,
 };
-- 
2.43.0


