Return-Path: <linux-kernel+bounces-141216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CA08A1B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03F6B325DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED420358E;
	Thu, 11 Apr 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U4YU+PZp"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AD4202A6D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850221; cv=none; b=EQgJRAtDJkycSRSl2ZdNFsDUr5MEJHskusmHdlr0HAWIaD+RpY4grqIwx/ndzBFbXgQCOdXIUZqk8x0rZtOoJrlHu40BZjXzuujtGCjOFoAnvLwfBEYJxIyE3ae7PHqI6TZ7DcSLF/CYj6qY/AvXMNqBc0Ht4CNXSHdjTSbI29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850221; c=relaxed/simple;
	bh=GJK7XXFh5gnnKJH43kYoV0NfBP/fp6A1qBURcN2Yy4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEbuQrUwpzBkb3Gy1VpJZBOVQ3R1QGjFLhDaBBE1G5ZJqyK7UhRnfnLzf/eV0fMitQJT/jpsKDQV5zi1of6iJPaVOq0O6RNo1dgiVWCJMrGRrDDScfVTVVnyQSJlqX7xVfE7ZP9w42me0D0gH8NBqRHtXagGDoxHM3erx+OGWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U4YU+PZp; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69704939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850218; x=1713455018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRxGlN/pwy9RyKX4DwH5rXOxL/UwdSpMUyhLjmgkt+c=;
        b=U4YU+PZpydsQGtCu1qbFC215lUrhCEFaSxfuclTY1GAFjPkA7D/w606hjmoJ3L9xtm
         nPGhgNori3v/X1suQHmGUlblSOxDAKXJ+Vl+01B4UCuWdgih2XKaPqIKYyd9vHOJSh+f
         VU8N6gdIlave1gIJspwe7sSGXFbOCduzLkoueNslRG58N1QhP4VVNk7/rsFLnKbzFXMe
         WSptJUBvdVZFJ//Vu8x/q7duQ6bq4xPqSs4OLHdeys03f3ZQQ3hWkNWukajOGeJGuxkY
         QTYHP1n3K6ejh5ngjB5dnxmZQkKAp0uLHUOFzyZl5cqAh5iGKYTZKSHtz+XTNZWyzLkK
         kg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850218; x=1713455018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRxGlN/pwy9RyKX4DwH5rXOxL/UwdSpMUyhLjmgkt+c=;
        b=D7dVsCudYvjGjHk1eMX7sSGodqNnvv7EuVibpIIJNZXVARtzfo/EyTvNfhQ5vEAXex
         ByCsFCMz7EaDdX1YHuTu1ptsb60AZcajO62jHIYZcuUIi1vOz3sEBDFRUiU8phRtUBY7
         Ey6A9G12cDp8Jz1lmYw6iaXLE0bjwX3aO8YsUbzR9/5qds7lEm54nMJzARN3AYx7j2BJ
         8LOWDgMRNJQO/j74RP2+8ovb6MwuZGxLe8tJ75jYPSDG4G64s3Dt8G84JFVnsW36HI1s
         MhQ6qxgs5+3HjkdN+SXD+A4KAfuw8or7zsqCeRHINQWnJoGbXbneaeydAPvieckrL+8E
         XxeA==
X-Gm-Message-State: AOJu0Yzag4MC4D9fSdWxG31NuBjp2VDpcI8sM7HaC7PfRuWjnY6gx/v9
	qeSeekW+cT7CJtN4NdU3BJEwwRvMV7u0D3p0s46jNSJ1Y8Lu2/eKMquZOY/9qKWRsJOoSowFFfJ
	x
X-Google-Smtp-Source: AGHT+IHL5GoHW7sKYQvvRcB8RVKCpTARffC0A2lfDao3ExJIurqZOydR/ogbF1QCaoJxZBOZg7PAPQ==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr212536iop.1.1712850218624;
        Thu, 11 Apr 2024 08:43:38 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 429/437] sbus: envctrl: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:29 -0600
Message-ID: <20240411153126.16201-430-axboe@kernel.dk>
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
 drivers/sbus/char/envctrl.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 491cc6c0b3f9..ceebe708647d 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -533,8 +533,7 @@ static unsigned char envctrl_i2c_voltage_status(struct i2c_child_t *pchild,
 /* Function Description: Read a byte from /dev/envctrl. Mapped to user read().
  * Return: Number of read bytes. 0 for error.
  */
-static ssize_t
-envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+static ssize_t envctrl_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct i2c_child_t *pchild;
 	unsigned char data[10];
@@ -545,14 +544,14 @@ envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	 * Get the data and put back to the user buffer.
 	 */
 
-	switch ((int)(long)file->private_data) {
+	switch ((int)(long)iocb->ki_filp->private_data) {
 	case ENVCTRL_RD_WARNING_TEMPERATURE:
 		if (warning_temperature == 0)
 			return 0;
 
 		data[0] = (unsigned char)(warning_temperature);
 		ret = 1;
-		if (copy_to_user(buf, data, ret))
+		if (!copy_to_iter_full(data, ret, to))
 			ret = -EFAULT;
 		break;
 
@@ -562,7 +561,7 @@ envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 		data[0] = (unsigned char)(shutdown_temperature);
 		ret = 1;
-		if (copy_to_user(buf, data, ret))
+		if (!copy_to_iter_full(data, ret, to))
 			ret = -EFAULT;
 		break;
 
@@ -570,7 +569,7 @@ envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		if (!(pchild = envctrl_get_i2c_child(ENVCTRL_MTHRBDTEMP_MON)))
 			return 0;
 		ret = envctrl_read_noncpu_info(pchild, ENVCTRL_MTHRBDTEMP_MON, data);
-		if (copy_to_user(buf, data, ret))
+		if (!copy_to_iter_full(data, ret, to))
 			ret = -EFAULT;
 		break;
 
@@ -580,7 +579,7 @@ envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		ret = envctrl_read_cpu_info(read_cpu, pchild, ENVCTRL_CPUTEMP_MON, data);
 
 		/* Reset cpu to the default cpu0. */
-		if (copy_to_user(buf, data, ret))
+		if (!copy_to_iter_full(data, ret, to))
 			ret = -EFAULT;
 		break;
 
@@ -590,7 +589,7 @@ envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		ret = envctrl_read_cpu_info(read_cpu, pchild, ENVCTRL_CPUVOLTAGE_MON, data);
 
 		/* Reset cpu to the default cpu0. */
-		if (copy_to_user(buf, data, ret))
+		if (!copy_to_iter_full(data, ret, to))
 			ret = -EFAULT;
 		break;
 
@@ -598,7 +597,7 @@ envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		if (!(pchild = envctrl_get_i2c_child(ENVCTRL_SCSITEMP_MON)))
 			return 0;
 		ret = envctrl_read_noncpu_info(pchild, ENVCTRL_SCSITEMP_MON, data);
-		if (copy_to_user(buf, data, ret))
+		if (!copy_to_iter_full(data, ret, to))
 			ret = -EFAULT;
 		break;
 
@@ -606,7 +605,7 @@ envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		if (!(pchild = envctrl_get_i2c_child(ENVCTRL_ETHERTEMP_MON)))
 			return 0;
 		ret = envctrl_read_noncpu_info(pchild, ENVCTRL_ETHERTEMP_MON, data);
-		if (copy_to_user(buf, data, ret))
+		if (!copy_to_iter_full(data, ret, to))
 			ret = -EFAULT;
 		break;
 
@@ -615,7 +614,7 @@ envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			return 0;
 		data[0] = envctrl_i2c_read_8574(pchild->addr);
 		ret = envctrl_i2c_fan_status(pchild,data[0], data);
-		if (copy_to_user(buf, data, ret))
+		if (!copy_to_iter_full(data, ret, to))
 			ret = -EFAULT;
 		break;
 	
@@ -624,7 +623,7 @@ envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			return 0;
 		data[0] = envctrl_i2c_read_8574(pchild->addr);
 		ret = envctrl_i2c_globaladdr(pchild, data[0], data);
-		if (copy_to_user(buf, data, ret))
+		if (!copy_to_iter_full(data, ret, to))
 			ret = -EFAULT;
 		break;
 
@@ -635,7 +634,7 @@ envctrl_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 				return 0;
 		data[0] = envctrl_i2c_read_8574(pchild->addr);
 		ret = envctrl_i2c_voltage_status(pchild, data[0], data);
-		if (copy_to_user(buf, data, ret))
+		if (!copy_to_iter_full(data, ret, to))
 			ret = -EFAULT;
 		break;
 
@@ -711,7 +710,7 @@ envctrl_release(struct inode *inode, struct file *file)
 
 static const struct file_operations envctrl_fops = {
 	.owner =		THIS_MODULE,
-	.read =			envctrl_read,
+	.read_iter =		envctrl_read,
 	.unlocked_ioctl =	envctrl_ioctl,
 	.compat_ioctl =		compat_ptr_ioctl,
 	.open =			envctrl_open,
-- 
2.43.0


