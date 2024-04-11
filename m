Return-Path: <linux-kernel+bounces-140894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D61A8A1970
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470A91F21231
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D715B57C;
	Thu, 11 Apr 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q6j6H949"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F015B543
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849722; cv=none; b=U3r626CaxgyPBaYI9GmRS3DUht6sUXE+aF/+LkG6GQISH36+8mlRPIoRH87RJrzbKffefDaSPYeEyyarflYmLlkMypAMBzHib+xgGC7Nn4DF/fssini197uXaek9+g1stwAPP1dvkg74aT/Q0NFONk0Ab4KUHSBk2EG22KEJJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849722; c=relaxed/simple;
	bh=+lDbOx8B3H81a2Nwh9y9l2fau2gFkHxlFuErUguf/Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq9FlWOltqjIsx0YEBEDjPwNdLiXjS2sMmmuqjnIoKm7Yz5kb09R8GIS85k/dTCJ3qm9RfKWhOp7Lo4zzqTqJeqcV7UF8U8pE+baWkZI2dLoumj81UCP+Xwusx+fxqNrBrY4tsqzpIPahllsAOYt8qaYj6zSaGddhkkcNmDeHB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q6j6H949; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a34b68277so109275ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849720; x=1713454520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbcPbLGbd9qV2Apa3HgnAaIcGwsKPnC2z8OjMHiEjxA=;
        b=q6j6H949/G/+ofcCRNCQNy78Q+LAIYY0B0gykGd59jHelWk+7ZdHqapzSWtViKXwFS
         CWXB1bWUaDCeRQyFyWvcyaJXraHGy3p1W7QFSSO9WJbXUXfOXJWq4qZkbOR3yLL28nHE
         aog/KWPSKnp+MBpwEhUlM8K2NU8lNSW4Smvf/EK+kf5nu54XFfgKTpf9nlgmmp2whGWF
         0SBUpJopxSz4Wy+pTIXwNGx0nwbo+bGqFlI1QKKqLBeb80jqPgE2sZo0yAtM68P36bFl
         mNoWstTDiNbzkY2sdz5LdzKTXf6sNIo5KgNcX+ScOyO1Bv8ogOFd0lNTAY8IzU63ttFf
         k41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849720; x=1713454520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbcPbLGbd9qV2Apa3HgnAaIcGwsKPnC2z8OjMHiEjxA=;
        b=HOqRZrFa/cqK0gz93jV9De//Hag8TdVYqfBwYF7nR36oQhqqqeK5ReezoiJzBgW8Xj
         xUewi9QFwuRFwQ20nkkrbc/RpJbYUhKEZHn1tXO1yPKNs/Vt6TyNx3EnakeZ9aJm5cRY
         llvh6K7piD81ZaQiAWhB5Qs+2JjIralFCn3xs+NDxK2iay+V9piyAgVqGqoMRSm7WVy4
         holJvq8xNY7gPRMqJIeoFLsNC3s6ZfbadsO6xBWnWqHPXBz+BF2PqHs9m56eBFNAcngN
         JUvui1SPThqYKBEGZS1281Y5ZV3W5bI/MUbmOoIuglMaRDIy5ptaM4xnbaTrOttufSAe
         DD+g==
X-Gm-Message-State: AOJu0YwvbpAdfZ56MgtA9PEqE7dl36UQl/2Rmzy4Ak0R1h/WnJxLTcrg
	/lugav6bWaLoNubZpOw8SFHMjWlyT9OZ7LPbW8DmgVZ9BIYbrwxzwBV8eeGB7iLVSpBM9fXVACD
	B
X-Google-Smtp-Source: AGHT+IHyu8IdJGTw2wmybsF8abPpNPvdEu8Ocer6mRzfEfLKS8cdPvCmu+uoONlukxZ9pfjHahzwAw==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr183983iob.1.1712849719852;
        Thu, 11 Apr 2024 08:35:19 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 130/437] drivers/i2c: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:30 -0600
Message-ID: <20240411153126.16201-131-axboe@kernel.dk>
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
 drivers/i2c/i2c-dev.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 8b7e599f1674..4997e70499d5 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -131,14 +131,13 @@ ATTRIBUTE_GROUPS(i2c);
  * needed by those system calls and by this SMBus interface.
  */
 
-static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
-		loff_t *offset)
+static ssize_t i2cdev_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct i2c_client *client = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	char *tmp;
 	int ret;
 
-	struct i2c_client *client = file->private_data;
-
 	if (count > 8192)
 		count = 8192;
 
@@ -146,31 +145,31 @@ static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
 	if (tmp == NULL)
 		return -ENOMEM;
 
-	pr_debug("i2c-%d reading %zu bytes.\n", iminor(file_inode(file)), count);
+	pr_debug("i2c-%d reading %zu bytes.\n", iminor(file_inode(iocb->ki_filp)), count);
 
 	ret = i2c_master_recv(client, tmp, count);
 	if (ret >= 0)
-		if (copy_to_user(buf, tmp, ret))
+		if (!copy_to_iter_full(tmp, ret, to))
 			ret = -EFAULT;
 	kfree(tmp);
 	return ret;
 }
 
-static ssize_t i2cdev_write(struct file *file, const char __user *buf,
-		size_t count, loff_t *offset)
+static ssize_t i2cdev_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int ret;
 	char *tmp;
-	struct i2c_client *client = file->private_data;
+	struct i2c_client *client = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
 	if (count > 8192)
 		count = 8192;
 
-	tmp = memdup_user(buf, count);
+	tmp = iterdup(from, count);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	pr_debug("i2c-%d writing %zu bytes.\n", iminor(file_inode(file)), count);
+	pr_debug("i2c-%d writing %zu bytes.\n", iminor(file_inode(iocb->ki_filp)), count);
 
 	ret = i2c_master_send(client, tmp, count);
 	kfree(tmp);
@@ -626,8 +625,8 @@ static int i2cdev_release(struct inode *inode, struct file *file)
 static const struct file_operations i2cdev_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= i2cdev_read,
-	.write		= i2cdev_write,
+	.read_iter	= i2cdev_read,
+	.write_iter	= i2cdev_write,
 	.unlocked_ioctl	= i2cdev_ioctl,
 	.compat_ioctl	= compat_i2cdev_ioctl,
 	.open		= i2cdev_open,
-- 
2.43.0


