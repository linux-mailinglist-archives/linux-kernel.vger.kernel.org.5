Return-Path: <linux-kernel+bounces-141020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F1B8A1A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50998B29D24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00461C661F;
	Thu, 11 Apr 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="STWKswIH"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD441C78B8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849915; cv=none; b=k5pkd6qkDubwlqcrv0mZz42SfYoqxnC0G+l7JgoIhU/d7ApEiyENlwR8JOW9WnP0lktPiMj9aURxTUEzHSFAbW+HRzJFhojDSGcQBEPL9yu6FVTM8osX/xhZmjXWoHIlV0/gq6sAZ2qshk+5Zv8u6KkFs92UEeOk/itcMpMxffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849915; c=relaxed/simple;
	bh=+a9yMv63GNbPPQbv5rx9qnLZOj3TsWDDG0kOJBo0jB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXK+XSqx+eTsUo5493dSB6kP9H7PcWedcC+88PCBQ7qrUe8tytV36r0gP6Whu2zohvsLjhpUguTyKOyDfj68V3YhuWeha3RBvwNLevowt4xew+1xGzCj3pfTqHFXHyukGGlNwopJO5+am5lR05wAsiRDLvcc8VLldIk7jvnYWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=STWKswIH; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69620339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849912; x=1713454712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y456vMouMnj4swZsS7YmKvdJiW0TUbGoVTArYCeV1kk=;
        b=STWKswIHXUSrn9dnUrOd40DImLNjJa7djRZoanY/Wzr3QJeVB5V+t7WRxISgsOX90i
         yv7y3CF2BSc66nA0JRsAkECUsNh16zhz0szhn/4yfJBXxNAXWZQxnWILtGxjdaESjJ5i
         +W6oO739mSyOMJegy4FO7w7R2O9ofjJmLQQRTjowlRfASwadzFHIBH510gtLXwVuoCf6
         nV3Y3S3Nh+tVBBarVII3kJiddnGXt8hJdkJygaDWhwMkZmhhlMPVhLRaj3U/GuoR9VdQ
         3xvXHkpg7Tg4E+uxOXsawgmFJ06AxDHXa/hkznBOgtg+euZ/OdBfLZ4/FEoomoZzczCa
         PkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849912; x=1713454712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y456vMouMnj4swZsS7YmKvdJiW0TUbGoVTArYCeV1kk=;
        b=ZjZ6XSPem2UeavPQk4iZ8G8z+Y9HUUDZY8GDANVMIt6Z8ity/4a4JPLs639BMma9ly
         T6DSSRpqVSwfblwHlRD5V+WGvZpaHnjJ021Dg9TiRn9JvNYT2xo3f8IgcZy1H6s9tRbv
         jvGb5E0Pr6FlpbTMPyJAkbW4PCdNeuTxcB1mfm5A0+Myvh1qB8lm2gXlryENSKP//wLF
         dM/LY2EwRTbOC1WIwMqCBkQ5MXvfSJDJ3hUYl3yGN9h9H0FVY+HT6ZYe/85om61rPANd
         kU/tAy9rN9YfnZAiy6CfxWAFz3LhCX/ucDeOZilNkyRy60Ncvn+/JchHeRXmiZ7NqxsB
         qKlw==
X-Gm-Message-State: AOJu0YykbV3fO6eV3C5bYaJtoMyC7jH1lyBsuoc7n2kBaG708co/cCrV
	0TG3WJNaYmbHB44JRdA7KaMP3Kb6+BjFBg6+WLWDM7+LeMey0vHi38WMiBioX+25FvKQmOULOPf
	9
X-Google-Smtp-Source: AGHT+IE4OWXW2o2MsDWyflkQWF3oIitZ8eWiwp/C6ZBmEtntvHLaJ8FsEPNMCyIyO2SlrK0ayPwRlw==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr199106iop.1.1712849912398;
        Thu, 11 Apr 2024 08:38:32 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 248/437] watchdog: pcwd_pci: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:28 -0600
Message-ID: <20240411153126.16201-249-axboe@kernel.dk>
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
 drivers/watchdog/pcwd_pci.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index 54d86fcb1837..6b7b3bd2ed83 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -431,9 +431,9 @@ static int pcipcwd_get_timeleft(int *time_left)
  *	/dev/watchdog handling
  */
 
-static ssize_t pcipcwd_write(struct file *file, const char __user *data,
-			     size_t len, loff_t *ppos)
+static ssize_t pcipcwd_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (len) {
 		if (!nowayout) {
@@ -447,7 +447,7 @@ static ssize_t pcipcwd_write(struct file *file, const char __user *data,
 			 * magic character */
 			for (i = 0; i != len; i++) {
 				char c;
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_release = 42;
@@ -597,15 +597,14 @@ static int pcipcwd_release(struct inode *inode, struct file *file)
  *	/dev/temperature handling
  */
 
-static ssize_t pcipcwd_temp_read(struct file *file, char __user *data,
-				size_t len, loff_t *ppos)
+static ssize_t pcipcwd_temp_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int temperature;
 
 	if (pcipcwd_get_temperature(&temperature))
 		return -EFAULT;
 
-	if (copy_to_user(data, &temperature, 1))
+	if (!copy_to_iter_full(&temperature, 1, to))
 		return -EFAULT;
 
 	return 1;
@@ -644,7 +643,7 @@ static int pcipcwd_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations pcipcwd_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
-	.write =	pcipcwd_write,
+	.write_iter =	pcipcwd_write,
 	.unlocked_ioctl = pcipcwd_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.open =		pcipcwd_open,
@@ -660,7 +659,7 @@ static struct miscdevice pcipcwd_miscdev = {
 static const struct file_operations pcipcwd_temp_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
-	.read =		pcipcwd_temp_read,
+	.read_iter =	pcipcwd_temp_read,
 	.open =		pcipcwd_temp_open,
 	.release =	pcipcwd_temp_release,
 };
-- 
2.43.0


