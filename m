Return-Path: <linux-kernel+bounces-140942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB78A19BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6F91C2373F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EAA201260;
	Thu, 11 Apr 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YU3GpDXv"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801C200137
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849794; cv=none; b=ASg+zrT3y5bcwxSgQFoJP1ccmsk+XzTXjbm8DHm5hWoJDcRjl7Nwpyn+1HkS9h/8Je/DO2FOqz37bWg79GSKnUXMntodvMlSyJzyB4mtfHkeHaf+DK+/2caL+DayAJhEgtpO2KsU9wCvegcirjSNzFVbSiDsuarhzb2r5Y4FXmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849794; c=relaxed/simple;
	bh=HF6LMEYfoWSFQPO3QyPGLT0EkvxS9ec/1TTiEkjzb2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8u8ptv95REoRuOpHpCRaV35YwAiu7qFRNetImxsTxhiZq/6jPZGMlIg5/Emaq2M/wHtPVJ8Ge1jou3OThm9qaxCgG7oRb02nFPW+BcR2iIuCAnp6uigfoOdTNxt/9XEH8/9XFIutQTmB9aZj2qN/W2uYcdFW/I57zrb2TN5TpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YU3GpDXv; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170522839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849792; x=1713454592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL15F0ClScthbUxssz2YLqWSnBS/ZEF5VqONH3UoJfg=;
        b=YU3GpDXvpEcIkRe9CwxDLOT3YH8vb0kyqePIf849KdU9UMcuhvG0u5DZbTU8Mt51cf
         ryzcUuO43tDfYa9FGmPm2wDosBejGbgao7vkcV67Mk1KRn5UpKjYyPCkyVKdPaaGWdJt
         BuTDKbIHhWPjXsZTEbedUibidjHwmBwbp8k/gw2qTcd1LyALYw2NsHibHfFwEmiumk3y
         U4OQKcYEOCpkz3kILMMQpbJxd9uVgeuBNRPZeMfqf1oBgSmBbEGHE+Di3Dr9wjw0/k+P
         TCAeL9ondCVd7BPsAfRt/N6FjoqNw2i+/XtYS9xiS/fDdM/tQCact7GCk0xsQBxDwLX0
         LuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849792; x=1713454592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uL15F0ClScthbUxssz2YLqWSnBS/ZEF5VqONH3UoJfg=;
        b=hzilUfyuWfvTcOKQU8SJwOBsXDlegWZdybBcQGcwifgYaVNI3dgcXoYZtVHhO/GUjz
         croD3GVL+0WutYXxd48Pp9jcHAQf2LHUab30L/zvxLXrNdLA7CuwhUXYG+WRLsYn31Cm
         AoTX13517W3iW0XgG3EeUNWXtJ8hB/ONT3bsnLZj3+07H/NijghmjF83ImBXufI+YLF1
         KUB4iv0ix5tG3uGW+wvN5XcHi/8e5SlGvV3rjoO1UxxB993jd6+i8wllRxchVYzaeoyD
         ANR2w3oAqqNPWbc4sro4YSAF6dnrfvzoFZOkPELrz+cHbUJrmd5pGGyPEsaJRcd4n/uJ
         HjLg==
X-Gm-Message-State: AOJu0Yz5TKDWT7yoFCtzotXUIkhfqw3SEvUaZN6TUzxOrut0BGSi7IWN
	3ixU6xJYoud+RnA+4zfg8TWAyw1FpKJV0h4Y/qh5IP1VhGJauDrmNYu9qi/d5TN9u7yptoS1jY4
	L
X-Google-Smtp-Source: AGHT+IGxhP2M4YXbfxAu/holvWQtdx5By5BvNims6GE9WIbQMRcl5BlNhmF5Tt7LpYrMxu5B5vGdXg==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr181575ioj.2.1712849792035;
        Thu, 11 Apr 2024 08:36:32 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 173/437] usb: gadget: atmel_usba_udc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:13 -0600
Message-ID: <20240411153126.16201-174-axboe@kernel.dk>
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
 drivers/usb/gadget/udc/atmel_usba_udc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index b76885d78e8a..318e9152f295 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -122,6 +122,7 @@ static ssize_t queue_dbg_read(struct file *file, char __user *buf,
 
 	return actual;
 }
+FOPS_READ_ITER_HELPER(queue_dbg_read);
 
 static int queue_dbg_release(struct inode *inode, struct file *file)
 {
@@ -163,16 +164,14 @@ static int regs_dbg_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static ssize_t regs_dbg_read(struct file *file, char __user *buf,
-		size_t nbytes, loff_t *ppos)
+static ssize_t regs_dbg_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
 	int ret;
 
 	inode_lock(inode);
-	ret = simple_read_from_buffer(buf, nbytes, ppos,
-			file->private_data,
-			file_inode(file)->i_size);
+	ret = simple_copy_to_iter(iocb->ki_filp->private_data, &iocb->ki_pos,
+			file_inode(iocb->ki_filp)->i_size, to);
 	inode_unlock(inode);
 
 	return ret;
@@ -188,7 +187,7 @@ static const struct file_operations queue_dbg_fops = {
 	.owner		= THIS_MODULE,
 	.open		= queue_dbg_open,
 	.llseek		= no_llseek,
-	.read		= queue_dbg_read,
+	.read_iter	= queue_dbg_read_iter,
 	.release	= queue_dbg_release,
 };
 
@@ -196,7 +195,7 @@ static const struct file_operations regs_dbg_fops = {
 	.owner		= THIS_MODULE,
 	.open		= regs_dbg_open,
 	.llseek		= generic_file_llseek,
-	.read		= regs_dbg_read,
+	.read_iter	= regs_dbg_read,
 	.release	= regs_dbg_release,
 };
 
-- 
2.43.0


