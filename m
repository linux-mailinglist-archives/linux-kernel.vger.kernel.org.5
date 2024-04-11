Return-Path: <linux-kernel+bounces-140993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316368A19FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44C41F28463
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A984E16;
	Thu, 11 Apr 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="itper5SB"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68BB3D579
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849875; cv=none; b=kMtM424ogR0vE9+FJZReFica1C01bWaFxGMHLtPkglIe0mPaCJZ7vP4uSlCa8E7Lfijq0sqKUzepaPjh29rSOp3Wd91zxABGKf2ccMm21+TDaiqwGudYtUr9biTRj7XtUevZus4vXc7egR4/Ju2KLCMPYGg+XvLbR1Iq7hF947U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849875; c=relaxed/simple;
	bh=HI6n6cFPPfll7bQ+Kmt38ePuXYCcYimcze1i2sFfkyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHr66Wo3ncMNaNraQH1ybUc8nd7NtocZPk8wkvdtopvALIwsCCwBhseU8tQ/Jf2NKj47lub2hWBfPNU98f1EAJKApIwqh6icmKju5mtKdMbsF6vt+DZj6BuGGMWI9l3yyITU4zyakcWae+HNuh3t/Z0UTmJcutf6os0AmYXoATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=itper5SB; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58114939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849872; x=1713454672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJB5B+coAVvlhitIoWDtN7J9U3iUGwpQ3FYYkVGK6bo=;
        b=itper5SBoITYqPKXQOG/BcwKYBVJAHKYRElOnjsoo+pqOehrbbtGv2nj9PRGoGz7yw
         HC7bONfMc43gkXC8/gdIQ+NuclpnfRmSvQDe5loG3sR9tgT38NgeBbxwAiGXGkmy0Sya
         h5piidCkJOsTIZEsi+YBmp6MC+uddk+stngmYkHFwgiGnpqz88Hn81QZWCPcYPsZ+x7S
         +zfPfG9WUXtwIPEPmdnRtY2VgAKwXNWw7DbhDIT6oHcKYieOqqQ2OWQt954mta7S4ioe
         gkjkTZ+CpAbWq5qgZUmCmQo8rd5H5ELlgKKXDYkcLyARPxemn9zXCjfA1Ytf5ZD6bCme
         V0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849872; x=1713454672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJB5B+coAVvlhitIoWDtN7J9U3iUGwpQ3FYYkVGK6bo=;
        b=KyEtdnZveT6Qhjd71wz3gz5LdZLkshtYXXUvQ25fOIvXoiety1OGr4a/uihBq3hrFP
         oSUdHGnoQfhk6j6i08WCsplzlBr6uDVcRmxZHpwXft8LXlaLzJ/rk/KM8ryFRETPioJ8
         knHQEwEwuLjGGTcDoIBERq2kdDtVlEP7/mpsnohZS8iYDqsKZQ41SBYf0zv0Cvo+H8bt
         RiSx8os8tnLAnqLirfvEnW6j29BXL94e3+CG71yldmifYqfc8FL3H1uc2ig7/Hw4CLY2
         AP+EgKEcJ3iG2oGspfW8fs3JUhPHC3TQcsUQ3dhblgJZLrX8AaKgyISQ0QFFAehjytZo
         Jt4Q==
X-Gm-Message-State: AOJu0Yya9D5YqjsxC7pOEwZp8UeUOqEGmwlHHLUvOR/MP1RU1hjtRtGf
	FItqyBAmq4U4yBIJeCRMwWS9qfsIZUFUVcicW3x/8opbZIi1LA1d1xJ11rkt2ghWMq1WJKo9OKV
	6
X-Google-Smtp-Source: AGHT+IEKaL+1mh4n0QApyJLN37yCnPC/UQyAEdgA9POkyiOVxY12TJOqFU2kBBO12aGpSblAO5DgKg==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr166079ioh.1.1712849872485;
        Thu, 11 Apr 2024 08:37:52 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 222/437] drivers/isdn: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:02 -0600
Message-ID: <20240411153126.16201-223-axboe@kernel.dk>
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
 drivers/isdn/capi/capi.c      | 22 +++++++++++-----------
 drivers/isdn/mISDN/timerdev.c | 16 ++++++++--------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 3ed257334562..6b613e03d85b 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -648,10 +648,10 @@ static void capi_recv_message(struct capi20_appl *ap, struct sk_buff *skb)
 
 /* -------- file_operations for capidev ----------------------------- */
 
-static ssize_t
-capi_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+static ssize_t capi_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct capidev *cdev = file->private_data;
+	struct capidev *cdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct sk_buff *skb;
 	size_t copied;
 	int err;
@@ -661,7 +661,7 @@ capi_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 	skb = skb_dequeue(&cdev->recvqueue);
 	if (!skb) {
-		if (file->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 		err = wait_event_interruptible(cdev->recvwait,
 					       (skb = skb_dequeue(&cdev->recvqueue)));
@@ -672,7 +672,7 @@ capi_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		skb_queue_head(&cdev->recvqueue, skb);
 		return -EMSGSIZE;
 	}
-	if (copy_to_user(buf, skb->data, skb->len)) {
+	if (!copy_to_iter_full(skb->data, skb->len, to)) {
 		skb_queue_head(&cdev->recvqueue, skb);
 		return -EFAULT;
 	}
@@ -683,10 +683,10 @@ capi_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	return copied;
 }
 
-static ssize_t
-capi_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+static ssize_t capi_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct capidev *cdev = file->private_data;
+	struct capidev *cdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct sk_buff *skb;
 	u16 mlen;
 
@@ -700,7 +700,7 @@ capi_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos
 	if (!skb)
 		return -ENOMEM;
 
-	if (copy_from_user(skb_put(skb, count), buf, count)) {
+	if (!copy_from_iter_full(skb_put(skb, count), count, from)) {
 		kfree_skb(skb);
 		return -EFAULT;
 	}
@@ -1025,8 +1025,8 @@ static const struct file_operations capi_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= capi_read,
-	.write		= capi_write,
+	.read_iter	= capi_read,
+	.write_iter	= capi_write,
 	.poll		= capi_poll,
 	.unlocked_ioctl	= capi_unlocked_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/drivers/isdn/mISDN/timerdev.c b/drivers/isdn/mISDN/timerdev.c
index 83d6b484d3c6..cf52b08e2fad 100644
--- a/drivers/isdn/mISDN/timerdev.c
+++ b/drivers/isdn/mISDN/timerdev.c
@@ -89,17 +89,17 @@ mISDN_close(struct inode *ino, struct file *filep)
 	return 0;
 }
 
-static ssize_t
-mISDN_read(struct file *filep, char __user *buf, size_t count, loff_t *off)
+static ssize_t mISDN_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mISDNtimerdev	*dev = filep->private_data;
+	struct mISDNtimerdev	*dev = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(to);
 	struct list_head *list = &dev->expired;
 	struct mISDNtimer	*timer;
 	int	ret = 0;
 
 	if (*debug & DEBUG_TIMER)
-		printk(KERN_DEBUG "%s(%p, %p, %d, %p)\n", __func__,
-		       filep, buf, (int)count, off);
+		printk(KERN_DEBUG "%s(%p, %d)\n", __func__,
+		       iocb->ki_filp, (int)count);
 
 	if (count < sizeof(int))
 		return -ENOSPC;
@@ -107,7 +107,7 @@ mISDN_read(struct file *filep, char __user *buf, size_t count, loff_t *off)
 	spin_lock_irq(&dev->lock);
 	while (list_empty(list) && (dev->work == 0)) {
 		spin_unlock_irq(&dev->lock);
-		if (filep->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 		wait_event_interruptible(dev->wait, (dev->work ||
 						     !list_empty(list)));
@@ -121,7 +121,7 @@ mISDN_read(struct file *filep, char __user *buf, size_t count, loff_t *off)
 		timer = list_first_entry(list, struct mISDNtimer, list);
 		list_del(&timer->list);
 		spin_unlock_irq(&dev->lock);
-		if (put_user(timer->id, (int __user *)buf))
+		if (put_iter(timer->id, to))
 			ret = -EFAULT;
 		else
 			ret = sizeof(int);
@@ -261,7 +261,7 @@ mISDN_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations mISDN_fops = {
 	.owner		= THIS_MODULE,
-	.read		= mISDN_read,
+	.read_iter	= mISDN_read,
 	.poll		= mISDN_poll,
 	.unlocked_ioctl	= mISDN_ioctl,
 	.open		= mISDN_open,
-- 
2.43.0


