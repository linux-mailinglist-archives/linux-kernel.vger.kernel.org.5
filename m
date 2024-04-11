Return-Path: <linux-kernel+bounces-141053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62A8A1AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B9AB25141
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB501D0F13;
	Thu, 11 Apr 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YE90ZHHp"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7861D0EF0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849966; cv=none; b=q247o/FsaaAPfycLgDkHHK8YsEx8asHV0wLKzQi7qep8HmhRwvCKJI8i20xPgWmtOKLJnVHqXf2c/ZvwMUbmkQC9n5/8+HSrl8Jua7CM0XhiAeYYskJ5+5fJ5bpIzF0jg4CeQ3i2JH7UMK8j5L8eZbEbYAZBxOsqy7i27KJJmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849966; c=relaxed/simple;
	bh=XSDs3cU9rj+x1JPGkiTPvq3pxijO3vs2c6WGeCdHo8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBnQO/BknPSm1K0vkBVxANSmJg+JdDj/jhZSM0hL+ioiqK56hnpXu/sQLY/nV6lP5I0At5p/58tUq7vELtj+KkDWJeCvyqTuRhNJwpeD4evf7szmRQqgUPL8oVYBa6bKRYEy+zH8MPQqMEt7IbYnWD1Q62T0CYdyF7HvC50lru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YE90ZHHp; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58160139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849963; x=1713454763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFQTNrnvRbaU79eFHZUCx+SNcopoXcWQ3jEGPidKEg0=;
        b=YE90ZHHpuicqxgUaBivT6iKTgnwkBR8EBDaTx8EmiirCZagRa4a1/+Qa671XL3Nvwb
         UtKBYS/xMApi4Ko50E9isoqwO/JCzB5PxolG2k8F/EsvYWHooxMt5mTshSfpX2/HAD7j
         Ubqb+N/FJGBc/fM4OMz+jK4kr988WK20mAFS/JfMehHX+9MoVe+6aXGyiZ1Mg56VO3iz
         rsylE6/Su5z6QBgozAN69iK6UmZ4sSDtFbKz1eemORXY+vkiWattq0nN553L8ppGpFOC
         VOr+F9iFdHwxBarb/uXOC+nfcUPMRl6T+wczLJlQe6OajeOVLU4X1VCny5KLcOBA6YLD
         OlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849963; x=1713454763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFQTNrnvRbaU79eFHZUCx+SNcopoXcWQ3jEGPidKEg0=;
        b=EE4qZKjFPqkF7i35ASiXdtymx6rXrJUEjqNksW/GRPhNRMGQsdABU6RlXyE7O969wc
         48xXCaiyk4zu/pyyBquH3SNqlQw0F82exThVVI3Z70rR3N/dMdPERARw+iK6fibhC1Gm
         c856DofM6tvOILjtUm6OfBH9iBWVLl5hHhJnfpZ8Eh0LB6g5bU4GRRZZS3roGyFHRoa8
         ++pCQ1TBJKIapaEwuZiUB5lViqKzAH0YEoIXlbl2HkccF8HaZ9JYKaUy1kLYgxbunGye
         GvEflOBivspEiuZRvHn3+c+veOYooBh4jgob3BwOAcoNf64GeEYRrNydMynsIuWCssTT
         AtSQ==
X-Gm-Message-State: AOJu0YyzARj4jwBZTCy4ybvXbkTlkMGB5q9WWAmWeD8t3rn3vPRbuuCc
	K8URSHGajwD5NQPkAU2Lvtz+vkEM4UsrW/Exs3sLux8880pk9UUCsnZlIPnw2vRyiBCgS945F7H
	9
X-Google-Smtp-Source: AGHT+IHzBfa5XTjezPtl1VEG+SI5zqaGqUKI+OBRJwq6PhBQQYHxfz5x4RQgR5y6Lh1J/HTQA8e7dQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr195325iov.2.1712849963011;
        Thu, 11 Apr 2024 08:39:23 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 279/437] watchdog: wdrtas: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:59 -0600
Message-ID: <20240411153126.16201-280-axboe@kernel.dk>
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
 drivers/watchdog/wdrtas.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index c00627825de8..591e5dcc8383 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -231,9 +231,9 @@ static int wdrtas_get_boot_status(void)
  * character 'V'. This character allows the watchdog device to be closed
  * properly.
  */
-static ssize_t wdrtas_write(struct file *file, const char __user *buf,
-	     size_t len, loff_t *ppos)
+static ssize_t wdrtas_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	int i;
 	char c;
 
@@ -244,7 +244,7 @@ static ssize_t wdrtas_write(struct file *file, const char __user *buf,
 		wdrtas_expect_close = 0;
 		/* look for 'V' */
 		for (i = 0; i < len; i++) {
-			if (get_user(c, buf + i))
+			if (get_iter(c, from))
 				return -EFAULT;
 			/* allow to close device */
 			if (c == 'V')
@@ -392,10 +392,8 @@ static int wdrtas_close(struct inode *inode, struct file *file)
 
 /**
  * wdrtas_temp_read - gives back the temperature in fahrenheit
- * @file: file structure
- * @buf: user buffer
- * @count: number of bytes to be read
- * @ppos: position in file
+ * @iocb: metadata for IO
+ * @to: user buffer
  *
  * returns always 1 or -EFAULT in case of user space copy failures, <0 on
  * other failures
@@ -403,8 +401,7 @@ static int wdrtas_close(struct inode *inode, struct file *file)
  * wdrtas_temp_read gives the temperature to the users by copying this
  * value as one byte into the user space buffer. The unit is Fahrenheit...
  */
-static ssize_t wdrtas_temp_read(struct file *file, char __user *buf,
-		 size_t count, loff_t *ppos)
+static ssize_t wdrtas_temp_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int temperature = 0;
 
@@ -412,7 +409,7 @@ static ssize_t wdrtas_temp_read(struct file *file, char __user *buf,
 	if (temperature < 0)
 		return temperature;
 
-	if (copy_to_user(buf, &temperature, 1))
+	if (!copy_to_iter_full(&temperature, 1, to))
 		return -EFAULT;
 
 	return 1;
@@ -470,7 +467,7 @@ static int wdrtas_reboot(struct notifier_block *this,
 static const struct file_operations wdrtas_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= wdrtas_write,
+	.write_iter	= wdrtas_write,
 	.unlocked_ioctl	= wdrtas_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wdrtas_open,
@@ -486,7 +483,7 @@ static struct miscdevice wdrtas_miscdev = {
 static const struct file_operations wdrtas_temp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= wdrtas_temp_read,
+	.read_iter	= wdrtas_temp_read,
 	.open		= wdrtas_temp_open,
 	.release	= wdrtas_temp_close,
 };
-- 
2.43.0


