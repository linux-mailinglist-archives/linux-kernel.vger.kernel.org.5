Return-Path: <linux-kernel+bounces-141197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE488A1AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7126B1C21374
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F51FD5C2;
	Thu, 11 Apr 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2LGusfou"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926A1FCA1D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850194; cv=none; b=Rxw2EQlwgCwua2PYd+LsGPXAS81lXFBJWyCjujj1fwj8i5bknViMTxEJPNW4zvHQyOhFQp1s4cUadyGI578mU75R0gq7NBmKaWFSNQTP3elcuBV0v8DSoNIZpkqr6jpli6quzg4vwU0fAOVpeSFHzuOfI0rid1W43hhsxR8Iyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850194; c=relaxed/simple;
	bh=OqeRYAGBYnww6bnv0uYDdepyddZOIaBxQ+BPwM3ZmN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G221zA0YaYRTH+I7Ej+s0jU80RW+B3LUbKnDdewD3lAPh9OfzMB3jEdRuFYxw/26SQ1dPv9bKaGzqTqDD6UmdBZnIip5hFVpVLbV2pDS4pySG/pAhMNLbeqmMPAI/qmWVcm1ZAD9QWcjg3BuLo89oXzyCf2t3KFFWw3NE4596sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2LGusfou; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69698039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850192; x=1713454992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PmE6cYLOEpbXxSqhgYXqA34/7Mp6dcqScCNpKzg50k=;
        b=2LGusfoul9IPelnBvAjNLNlISAzib5IaT7iLOQERwsJKdbqnNnji43x5PQpzgBnBwe
         QZ3Xh9XnVoIjhr2lq7kslktwXgIRJiUj9V4d2WMosTxQ5AKIloIMaX9Si03BPF9Jf5L9
         A+Blv59MTb64/b3uRPdsWuD0DQF+nokYf9ymmVZ1O2lbnwk9UEzW6ImLHKU72aRFGHeh
         NBd2dzZO5dKFfHpo0uKDkglSOMdnzjyZqnPcCCRoQ9SCQDqjtEP0q8WhT2Xs5irg37wu
         1Xwnz9p7+ZDaIvdNqom7vjnIpZncxL8rP4lQGLiPHJglvl5okEvo8UOGDltQJ+ETgdQL
         +tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850192; x=1713454992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PmE6cYLOEpbXxSqhgYXqA34/7Mp6dcqScCNpKzg50k=;
        b=vSVVKcOU1TyIvKyZiHcBpVCPoyhh2Iu31Ye/PYKQWlsiuKVXThO4UH6YMVzY/MfmtU
         t1232Fgl8pHommPDj1VFmeQ7S9QlQ0fqAYi69ewTX+nNCSfZva3kYHD9nvdVL/ccWER3
         FukC2VZOgnSEORZ5pWGy8RKkZH9szzGuiLEOkiDQZ0FwZRLNYP3NxMi6PSY1hv++YbFO
         /Y7FLNmQzxJM7ech8nShKZzbywqEvM3M8JG3ihUM5g0/w0h4Cx4HGIFz4wUWJGhDHhC0
         l3k1Z2e2BdX0pO/X/CIb0DJzsc40d6nJfridlIKVFaboYiazl7NV/Hxi8jRDz3lG10si
         hKMA==
X-Gm-Message-State: AOJu0YwFTOGAqUxrlV+8vl+8yIjZ4+UwbX3uqmoX63N4NKq0iQzd9693
	NiwxWW+hY1vnKrxIsSdOYiamUfV9n9unLa+IFwtwl1UdIQcrphtTzX9ZIQxLmsl1UOFDjXCNztU
	6
X-Google-Smtp-Source: AGHT+IG/eBRicBnxPB94XCARfuaVE4IYhKGZ2yyy4inqQx23fqzMYNzE4QHmVF9tHMlbzK7xkElsOA==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr56943iob.2.1712850191909;
        Thu, 11 Apr 2024 08:43:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 413/437] media/rc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:13 -0600
Message-ID: <20240411153126.16201-414-axboe@kernel.dk>
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
 drivers/media/rc/imon.c     | 26 ++++++++++++--------------
 drivers/media/rc/lirc_dev.c | 15 ++++++++-------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 5719dda6e0f0..cfcf8101164a 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -65,12 +65,10 @@ static int display_open(struct inode *inode, struct file *file);
 static int display_close(struct inode *inode, struct file *file);
 
 /* VFD write operation */
-static ssize_t vfd_write(struct file *file, const char __user *buf,
-			 size_t n_bytes, loff_t *pos);
+static ssize_t vfd_write(struct kiocb *iocb, struct iov_iter *from);
 
 /* LCD file_operations override function prototypes */
-static ssize_t lcd_write(struct file *file, const char __user *buf,
-			 size_t n_bytes, loff_t *pos);
+static ssize_t lcd_write(struct kiocb *iocb, struct iov_iter *from);
 
 /*** G L O B A L S ***/
 
@@ -179,7 +177,7 @@ struct imon_context {
 static const struct file_operations vfd_fops = {
 	.owner		= THIS_MODULE,
 	.open		= display_open,
-	.write		= vfd_write,
+	.write_iter	= vfd_write,
 	.release	= display_close,
 	.llseek		= noop_llseek,
 };
@@ -188,7 +186,7 @@ static const struct file_operations vfd_fops = {
 static const struct file_operations lcd_fops = {
 	.owner		= THIS_MODULE,
 	.open		= display_open,
-	.write		= lcd_write,
+	.write_iter	= lcd_write,
 	.release	= display_close,
 	.llseek		= noop_llseek,
 };
@@ -938,16 +936,16 @@ static const struct attribute_group imon_rf_attr_group = {
  * than 32 bytes are provided spaces will be appended to
  * generate a full screen.
  */
-static ssize_t vfd_write(struct file *file, const char __user *buf,
-			 size_t n_bytes, loff_t *pos)
+static ssize_t vfd_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int i;
 	int offset;
 	int seq;
 	int retval = 0;
-	struct imon_context *ictx = file->private_data;
+	struct imon_context *ictx = iocb->ki_filp->private_data;
 	static const unsigned char vfd_packet6[] = {
 		0x01, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF };
+	size_t n_bytes = iov_iter_count(from);
 
 	if (ictx->disconnected)
 		return -ENODEV;
@@ -967,7 +965,7 @@ static ssize_t vfd_write(struct file *file, const char __user *buf,
 		goto exit;
 	}
 
-	if (copy_from_user(ictx->tx.data_buf, buf, n_bytes)) {
+	if (!copy_from_iter_full(ictx->tx.data_buf, n_bytes, from)) {
 		retval = -EFAULT;
 		goto exit;
 	}
@@ -1023,11 +1021,11 @@ static ssize_t vfd_write(struct file *file, const char __user *buf,
  * display whatever diacritics you need, and so on), but it's also
  * a lot more complicated than most LCDs...
  */
-static ssize_t lcd_write(struct file *file, const char __user *buf,
-			 size_t n_bytes, loff_t *pos)
+static ssize_t lcd_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int retval = 0;
-	struct imon_context *ictx = file->private_data;
+	struct imon_context *ictx = iocb->ki_filp->private_data;
+	size_t n_bytes = iov_iter_count(from);
 
 	if (ictx->disconnected)
 		return -ENODEV;
@@ -1047,7 +1045,7 @@ static ssize_t lcd_write(struct file *file, const char __user *buf,
 		goto exit;
 	}
 
-	if (copy_from_user(ictx->usb_tx_buf, buf, 8)) {
+	if (!copy_from_iter_full(ictx->usb_tx_buf, 8, from)) {
 		retval = -EFAULT;
 		goto exit;
 	}
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index caad59f76793..e88ba11192ea 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -211,10 +211,10 @@ static int lirc_close(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t lirc_transmit(struct file *file, const char __user *buf,
-			     size_t n, loff_t *ppos)
+static ssize_t lirc_transmit(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lirc_fh *fh = file->private_data;
+	struct lirc_fh *fh = iocb->ki_filp->private_data;
+	size_t n = iov_iter_count(from);
 	struct rc_dev *dev = fh->rc;
 	unsigned int *txbuf;
 	struct ir_raw_event *raw = NULL;
@@ -247,7 +247,7 @@ static ssize_t lirc_transmit(struct file *file, const char __user *buf,
 			goto out_unlock;
 		}
 
-		if (copy_from_user(&scan, buf, sizeof(scan))) {
+		if (!copy_from_iter_full(&scan, sizeof(scan), from)) {
 			ret = -EFAULT;
 			goto out_unlock;
 		}
@@ -309,7 +309,7 @@ static ssize_t lirc_transmit(struct file *file, const char __user *buf,
 			goto out_unlock;
 		}
 
-		txbuf = memdup_user(buf, n);
+		txbuf = iterdup(from, n);
 		if (IS_ERR(txbuf)) {
 			ret = PTR_ERR(txbuf);
 			goto out_unlock;
@@ -694,13 +694,14 @@ static ssize_t lirc_read(struct file *file, char __user *buffer, size_t length,
 	else /* LIRC_MODE_SCANCODE */
 		return lirc_read_scancode(file, buffer, length);
 }
+FOPS_READ_ITER_HELPER(lirc_read);
 
 static const struct file_operations lirc_fops = {
 	.owner		= THIS_MODULE,
-	.write		= lirc_transmit,
+	.write_iter	= lirc_transmit,
 	.unlocked_ioctl	= lirc_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
-	.read		= lirc_read,
+	.read_iter	= lirc_read_iter,
 	.poll		= lirc_poll,
 	.open		= lirc_open,
 	.release	= lirc_close,
-- 
2.43.0


