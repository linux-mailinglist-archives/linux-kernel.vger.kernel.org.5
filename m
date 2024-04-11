Return-Path: <linux-kernel+bounces-140925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CA78A19A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10361F22C67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD81A38CD;
	Thu, 11 Apr 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nBztdBaN"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CE1A0B0B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849768; cv=none; b=tds1gXlRq9iBRJkGh0U629Vtt9QOrwWc1s2a71S71J9JSLQKf6D5akn/HSYy3aPuOsw9vcPgr4nwJormv80W8D4dYpSv8a2Q/43N5AK2pwK6UNf+qMEOWWqB6dudNwIFEC3J2OSmMgwvcHXjjIvdtN7dL6RARzmxufEm8h+e86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849768; c=relaxed/simple;
	bh=+5eGTQuXClbzDJtZcXIqmdGdgZwAoQdeNnA2FFXvzLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRI4gMDBgdOpfknxVVcbh1tkNcsY9uTA3pFFCBhA2azhnofCzDUmCjQ6Ttz8lH58dvYLHjxtR9CUrKneDQ9U+vej5fE62C92E4oUt4n5hNMEOiGuthpJAcjHaCuzrlfBZZF2wOVs9OqdhzVRPEMGjx+LmQ+/PIcigyuUjSQh38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nBztdBaN; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso81845339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849766; x=1713454566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c0TLT+6r44FWOywZJ0UCMvqPCeYqv+2VLmgi7KaxQw=;
        b=nBztdBaNcdWSfzWcYPJNhpDRTZJoO2KbvXZkSFEh6y1UYowsQ+d+SbWMAwaBlOcEkZ
         50+kghiWJmUoBeqoicC+iRtG7zmB9EfSDZ5w6IhEbCYQ5tW6hjATLZi2YesGW1VTGTVg
         KLLhzier/biBh/B/zk+iW6r+wLxXF+VWH2Nb9t4x51f2oij9mzt4JAXcB4O8G73TRpMk
         2nudDB1TU/OMFihNbKpmRI+uWpQutRChlhR7dIh/K1NYPA/7HBOhNOLi3KeLjZiTwc/O
         jgdHqu3bHX4X1ObDAT1Gog1iUHsAzjhStAdleUw7Wt9X1cNiQKugx2N1pyBaW1ek43sG
         nEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849766; x=1713454566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9c0TLT+6r44FWOywZJ0UCMvqPCeYqv+2VLmgi7KaxQw=;
        b=D5gQDX9Qu9DkHmuZY0pMuqCBTDZUwCvkPG2GyMKDOjOqY40h5GWL/MU+24TXy19I1y
         wPRzlL8TzAs6LAt9DpG/AFqxi1vPWacyg6NTtpN0akPdH1ow9O3c/Or+Js/Kx1dgjEOc
         qAD+lGaZV21RjkM5uOt8aNzF40SidJIh4ZJGIHCEvcpfLOBo/GJrYX6f8+o/OFcW4GN1
         YbfikRXxHsyHenUg51JsR2+8NKYJ3xb/7m+I1zqzt6VjH0+34vFxKPAuyELYq/qE1Gnx
         iB6KUsP648ARwoVhtG+zrgb9PMglIA96Ok4Zscf8hwaDtyI+NLLGFX95VUKrbiwk7ZuM
         pDkg==
X-Gm-Message-State: AOJu0YwZTHae6uONYe8xTSlDHnxxpPsiXy+GjSWIfXSFA9C2VbeHcKnX
	gErMQ70uIQ76G4DnI3MAdBSyQ1TA+Lu2UGtCMr6vC3m6D1tRGq2tLhm1pVCFZOjD0IRaWfPcUfz
	I
X-Google-Smtp-Source: AGHT+IEv29KcUmrJQfkNQMRGZqbLCtW3maagC+h2/wtUbBZDnUURoeWCEdLFCTfK9PnQKglrSGZMUQ==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr149020ioc.2.1712849766052;
        Thu, 11 Apr 2024 08:36:06 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 157/437] usb: class: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:57 -0600
Message-ID: <20240411153126.16201-158-axboe@kernel.dk>
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
 drivers/usb/class/cdc-wdm.c | 18 +++++++++---------
 drivers/usb/class/usblp.c   |  6 ++++--
 drivers/usb/class/usbtmc.c  |  6 ++++--
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index c8262e2f2917..a811000b5eb2 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -476,6 +476,7 @@ static ssize_t wdm_write
 	kfree(buf);
 	return rv;
 }
+FOPS_WRITE_ITER_HELPER(wdm_write);
 
 /*
  * Submit the read urb if resp_count is non-zero.
@@ -520,13 +521,12 @@ static int service_outstanding_interrupt(struct wdm_device *desc)
 	return rv;
 }
 
-static ssize_t wdm_read
-(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
+static ssize_t wdm_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int rv, cntr;
 	int i = 0;
-	struct wdm_device *desc = file->private_data;
-
+	struct wdm_device *desc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 
 	rv = mutex_lock_interruptible(&desc->rlock); /*concurrent reads */
 	if (rv < 0)
@@ -546,7 +546,7 @@ static ssize_t wdm_read
 			goto err;
 		}
 		i++;
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			if (!test_bit(WDM_READ, &desc->flags)) {
 				rv = -EAGAIN;
 				goto err;
@@ -604,8 +604,8 @@ static ssize_t wdm_read
 
 	if (cntr > count)
 		cntr = count;
-	rv = copy_to_user(buffer, desc->ubuf, cntr);
-	if (rv > 0) {
+	rv = !copy_to_iter_full(desc->ubuf, cntr, to);
+	if (rv) {
 		rv = -EFAULT;
 		goto err;
 	}
@@ -810,8 +810,8 @@ static long wdm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations wdm_fops = {
 	.owner =	THIS_MODULE,
-	.read =		wdm_read,
-	.write =	wdm_write,
+	.read_iter =	wdm_read,
+	.write_iter =	wdm_write_iter,
 	.fsync =	wdm_fsync,
 	.open =		wdm_open,
 	.flush =	wdm_flush,
diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index 5a2e43331064..2f16b7916963 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -832,6 +832,7 @@ static ssize_t usblp_write(struct file *file, const char __user *buffer, size_t
 raise_biglock:
 	return writecount ? writecount : rv;
 }
+FOPS_WRITE_ITER_HELPER(usblp_write);
 
 /*
  * Notice that we fail to restart in a few cases: on EFAULT, on restart
@@ -885,6 +886,7 @@ static ssize_t usblp_read(struct file *file, char __user *buffer, size_t len, lo
 	mutex_unlock(&usblp->mut);
 	return count;
 }
+FOPS_READ_ITER_HELPER(usblp_read);
 
 /*
  * Wait for the write path to come idle.
@@ -1080,8 +1082,8 @@ static unsigned int usblp_quirks(__u16 vendor, __u16 product)
 
 static const struct file_operations usblp_fops = {
 	.owner =	THIS_MODULE,
-	.read =		usblp_read,
-	.write =	usblp_write,
+	.read_iter =	usblp_read_iter,
+	.write_iter =	usblp_write_iter,
 	.poll =		usblp_poll,
 	.unlocked_ioctl =	usblp_ioctl,
 	.compat_ioctl =		usblp_ioctl,
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 311007b1d904..281eeb29cf7f 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1506,6 +1506,7 @@ static ssize_t usbtmc_read(struct file *filp, char __user *buf,
 	kfree(buffer);
 	return retval;
 }
+FOPS_READ_ITER_HELPER(usbtmc_read);
 
 static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 			    size_t count, loff_t *f_pos)
@@ -1644,6 +1645,7 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 	mutex_unlock(&data->io_mutex);
 	return retval;
 }
+FOPS_WRITE_ITER_HELPER(usbtmc_write);
 
 static int usbtmc_ioctl_clear(struct usbtmc_device_data *data)
 {
@@ -2261,8 +2263,8 @@ static __poll_t usbtmc_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations fops = {
 	.owner		= THIS_MODULE,
-	.read		= usbtmc_read,
-	.write		= usbtmc_write,
+	.read_iter	= usbtmc_read_iter,
+	.write_iter	= usbtmc_write_iter,
 	.open		= usbtmc_open,
 	.release	= usbtmc_release,
 	.flush		= usbtmc_flush,
-- 
2.43.0


