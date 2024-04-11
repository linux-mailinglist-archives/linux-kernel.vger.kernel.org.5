Return-Path: <linux-kernel+bounces-140994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171AB8A1A00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BC01C21931
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D99C3DB91;
	Thu, 11 Apr 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f7cZ+6n4"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4AE84DF8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849876; cv=none; b=k4PZHp0E7b0FXmT68yaGwcASwHmbDtQVAePwo9J2VtGx9jJ4klA+/lxHaeoZ81peMcdmPcgBORQSQ8Vy6Jk6+51dBz1l5baTlzZD5RsklxmZ6zNC2GjkUKksURwMFTRxKLhCElfJch+i5MD5TwMwPO0ii+WQwIxHlP/d5KIXZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849876; c=relaxed/simple;
	bh=2b+wmRTPa43GlgcQRxpKllSYOoAfs4n74u6WABWCQoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRM+m7szQmPPa8TSM6uWKuH3vhdui4h0W4T1KJvqoslZMYyH+GYBFgUiMEkorsMqiDXoe01QnNo9BGQDj7SPp4FwaNvMzRdkCYvdL1Yq7ANRCJ/UThN3dg+f9VIveQWQeqMb1fxK+dG1CFqQB4afo7bqRQkTaCNk/oSW2c/Mni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f7cZ+6n4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9828139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849874; x=1713454674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMcAzrEZJ/ituJuEchEklnEamqivJ8zTrCNfYMwWS1g=;
        b=f7cZ+6n49Le4VTGXUfWqbG1cDzS1KEUwXH1dfuuPxoAtNfAzEqsdaqyErowjKF/V2u
         PkdIIInVhaKsw3/r7VCKSylUwDCTgXa5Ld5ZOuKupvV3bzPZDhn7dBS2aAyZz7CCC+S4
         nC+Hde56F+DI9Z1Q+Ri6uheFlnS6hXjBsxg0OpAtHb9gcSkKUiMztVPIdC351sRekuyz
         7nNGGLFtD2fxMKeD09yFY78eabd1kEiTYppmreRkHiD+vDjhwxBs8eq2PaBXZ5n1JC7z
         2oDq7h54bPD/spOKXa3FjUUHdY8kNziBjsAh6vusLW9Nb/wS4xXza3+wH43oM0PUWca/
         StTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849874; x=1713454674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMcAzrEZJ/ituJuEchEklnEamqivJ8zTrCNfYMwWS1g=;
        b=KMSsr6GEUDbMKh58ZB0Km0jr4GC/tuoxKYnDQ8bTRT5627Q7yWGEWqZQnR7xmd4sO2
         jrMoDNy4RNnO6DxpVLSnE73ras++M7eoXiHqZTDglTfaexaDjWYMD657ZKzPZcLUaz/R
         LtrRzGZtggR3hk44xyfm1FTRAzFrMrTsFBvllYETKRKFcHFhbam7+em8bWX1p1/7LcQK
         rs/rJcx11I4aNZ3+FdQynr9f25A/Nb1byVvyVv+oqwsA/mj1jgXkQGIguJV+ozkWYSoL
         ATEC072bf52WM3mBsE0B1CgLRGykN7M2zrkg8/fQWmaZeNxDOifivPv9SeCfEmFw5vjX
         52XA==
X-Gm-Message-State: AOJu0Yy0gCFMx/WLf1aXqR0+e9ZnASP+Old1GFG/SDnUH7xP+HoIthIU
	UPgSmOzM0VZZZZCC8glcoAttZ4N0cT40PsQvG14RgeGiW0/8ueXsQ1kaMZhFiE3Srwgtuh+PNmy
	Z
X-Google-Smtp-Source: AGHT+IEwi6vJuKt9dpmAhSXAkYuOH2Zxw0c5i3O3wYHyS8ooLuWOsOeMVVGldgROJjwAutjJBm2/Xg==
X-Received: by 2002:a92:2c10:0:b0:36a:2d25:3d82 with SMTP id t16-20020a922c10000000b0036a2d253d82mr6166719ile.0.1712849874001;
        Thu, 11 Apr 2024 08:37:54 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 223/437] drivers/leds: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:03 -0600
Message-ID: <20240411153126.16201-224-axboe@kernel.dk>
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
 drivers/leds/uleds.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/leds/uleds.c b/drivers/leds/uleds.c
index 3d361c920030..b1fa00407364 100644
--- a/drivers/leds/uleds.c
+++ b/drivers/leds/uleds.c
@@ -70,10 +70,10 @@ static int uleds_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t uleds_write(struct file *file, const char __user *buffer,
-			   size_t count, loff_t *ppos)
+static ssize_t uleds_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct uleds_device *udev = file->private_data;
+	struct uleds_device *udev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	const char *name;
 	int ret;
 
@@ -94,8 +94,8 @@ static ssize_t uleds_write(struct file *file, const char __user *buffer,
 		goto out;
 	}
 
-	if (copy_from_user(&udev->user_dev, buffer,
-			   sizeof(struct uleds_user_dev))) {
+	if (!copy_from_iter_full(&udev->user_dev, sizeof(struct uleds_user_dev),
+				 from)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -128,10 +128,10 @@ static ssize_t uleds_write(struct file *file, const char __user *buffer,
 	return ret;
 }
 
-static ssize_t uleds_read(struct file *file, char __user *buffer, size_t count,
-			  loff_t *ppos)
+static ssize_t uleds_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct uleds_device *udev = file->private_data;
+	struct uleds_device *udev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	ssize_t retval;
 
 	if (count < sizeof(udev->brightness))
@@ -144,13 +144,16 @@ static ssize_t uleds_read(struct file *file, char __user *buffer, size_t count,
 
 		if (udev->state != ULEDS_STATE_REGISTERED) {
 			retval = -ENODEV;
-		} else if (!udev->new_data && (file->f_flags & O_NONBLOCK)) {
+		} else if (!udev->new_data && (iocb->ki_filp->f_flags & O_NONBLOCK)) {
 			retval = -EAGAIN;
 		} else if (udev->new_data) {
-			retval = copy_to_user(buffer, &udev->brightness,
-					      sizeof(udev->brightness));
+			retval = !copy_to_iter_full(&udev->brightness,
+					      sizeof(udev->brightness), to);
 			udev->new_data = false;
-			retval = sizeof(udev->brightness);
+			if (retval)
+				retval = -EFAULT;
+			else
+				retval = sizeof(udev->brightness);
 		}
 
 		mutex_unlock(&udev->mutex);
@@ -158,7 +161,7 @@ static ssize_t uleds_read(struct file *file, char __user *buffer, size_t count,
 		if (retval)
 			break;
 
-		if (!(file->f_flags & O_NONBLOCK))
+		if (!(iocb->ki_filp->f_flags & O_NONBLOCK))
 			retval = wait_event_interruptible(udev->waitq,
 					udev->new_data ||
 					udev->state != ULEDS_STATE_REGISTERED);
@@ -197,8 +200,8 @@ static const struct file_operations uleds_fops = {
 	.owner		= THIS_MODULE,
 	.open		= uleds_open,
 	.release	= uleds_release,
-	.read		= uleds_read,
-	.write		= uleds_write,
+	.read_iter	= uleds_read,
+	.write_iter	= uleds_write,
 	.poll		= uleds_poll,
 	.llseek		= no_llseek,
 };
-- 
2.43.0


