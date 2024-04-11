Return-Path: <linux-kernel+bounces-140919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537A8A199D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF109288FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09794199EA4;
	Thu, 11 Apr 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HylPKdnY"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6CB194C9D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849759; cv=none; b=aU7lQcx+0z/0MwNynlLbdmyZfYeT8/cRgPovi4fjjK0GSNbcvozKNhZIUiCuQA5n3Ig7lDCNcqELzNEDdSpgG/gQDcWAKvwvXgXapsopk1LPYAk9rd6/1napT1ODexIFVc2dg0CenqURbpZwq5adnkpSHbDyIj7zoXx13aWzw+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849759; c=relaxed/simple;
	bh=DI38IkjyIYmBb2LOOD88/JS1r834ZsDLcO1QtII+r5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHP9lWljG/3ZBpiqASDiArglmNT/mKaH2ZXgrR2d07S8RlEYy/GpklmaqBzdxfMYRWK88cnotlznmEyrRGbzkfnfBzWf2wfXpcjqVycvhfZJ2OEdXcE52fHVyKMViFe0MtqR8anR17NAkCYyyWYQX3GWrHgGp5RBuMt7CfbySGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HylPKdnY; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8942639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849757; x=1713454557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR3alxiCJxL/WHH6v/vBfbajmTpg3HxRCIj2t2Cj7nI=;
        b=HylPKdnY/DHaBo43299wW7XpBy28EumyH8qWfVKOl3rEZbp1Emro6bfflMDlQsJwQ7
         FzMszlEnedWG9qva61mRSn2CCoPgAo6Qu37kaDANZ389z09Rft6wEZ5uJEspRJJNwg40
         fsvSUgiLxCfdgenUh9WrcRQ14kOfI8wUFC2Cy3RH0rDriLhJZO03Aqo/haIyQZYpwbX1
         t4S8qNCE3hevZAWmgjpnEEVURyO1oiOk8tVn9nJ56d5bBervY76MGSvZz+xJcReXtA7h
         NecgiXkXG80Hg6wQ+dwdfQWlcvvRkPQek+A8bzdKer2C/DMGXyVWd1HeXtBWaodXRA1j
         WdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849757; x=1713454557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR3alxiCJxL/WHH6v/vBfbajmTpg3HxRCIj2t2Cj7nI=;
        b=KywB4f0FK7Igr/9XiQ3i1k894D+MprQ9/8+7milnpi3ansHiVyaqnJP1XH395w4mgI
         IFFRyt2ioPtC4OelgEEc/L5Z9v6OE691HYwnG34XlEz/7glHPEYmCNgaRRu7co0alvYJ
         bD1o1oMMro64iqyUFXZDE9GgnBxSldLx6qcl36hFyDYnk271ZsJS9X3HQUGofjIszev5
         2Z0gWgTudRnDQ86aniJCb2C0IkN4VGV0wyrg9N9uXJzTp31FST6OnSA/9sLxASyFG/Iq
         GPacNmw6KNTtkzzZnbibCnQAldCZyj8xEa4P2nSURztAYgfIJ/T/b1h5M5LDdH1jZGUK
         S9eQ==
X-Gm-Message-State: AOJu0YwIqKTmtkjZsaMfa1ErR4vu1HX/SpQzRAOnxFzi9+4PuNgi43Y3
	lUxQHjPPuKnPMdvCY01NKufQaNLrjm6eXuHxXTvH491tFli8FKvOXr6dgkWyoOpVlp2Hj5RKcKb
	8
X-Google-Smtp-Source: AGHT+IHINX7Q3Qpru03M4osqW0Nwyde0FrkVG3S5iH8Z+BV7tHKGhMurJ1BhNuWfXL5oBW9heH73IA==
X-Received: by 2002:a92:2912:0:b0:36a:f9aa:5757 with SMTP id l18-20020a922912000000b0036af9aa5757mr3582061ilg.2.1712849756717;
        Thu, 11 Apr 2024 08:35:56 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 152/437] drivers/rtc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:52 -0600
Message-ID: <20240411153126.16201-153-axboe@kernel.dk>
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
 drivers/rtc/dev.c        | 20 ++++++++------------
 drivers/rtc/rtc-m41t80.c | 18 +++++++-----------
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index 4aad9bb99868..b37e6d448ee4 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -138,10 +138,10 @@ EXPORT_SYMBOL(rtc_dev_update_irq_enable_emul);
 
 #endif /* CONFIG_RTC_INTF_DEV_UIE_EMUL */
 
-static ssize_t
-rtc_dev_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+static ssize_t rtc_dev_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rtc_device *rtc = file->private_data;
+	struct rtc_device *rtc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long data;
@@ -163,7 +163,7 @@ rtc_dev_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			ret = 0;
 			break;
 		}
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			break;
 		}
@@ -177,13 +177,9 @@ rtc_dev_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	remove_wait_queue(&rtc->irq_queue, &wait);
 
 	if (ret == 0) {
-		if (sizeof(int) != sizeof(long) &&
-		    count == sizeof(unsigned int))
-			ret = put_user(data, (unsigned int __user *)buf) ?:
-				sizeof(unsigned int);
-		else
-			ret = put_user(data, (unsigned long __user *)buf) ?:
-				sizeof(unsigned long);
+		ret = sizeof(data);
+		if (put_iter(data, to))
+			ret = -EFAULT;
 	}
 	return ret;
 }
@@ -524,7 +520,7 @@ static int rtc_dev_release(struct inode *inode, struct file *file)
 static const struct file_operations rtc_dev_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= rtc_dev_read,
+	.read_iter	= rtc_dev_read,
 	.poll		= rtc_dev_poll,
 	.unlocked_ioctl	= rtc_dev_ioctl,
 #ifdef CONFIG_COMPAT
diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 0013bff0447d..2487aafd9698 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -686,26 +686,22 @@ static void wdt_disable(void)
 
 /**
  *	wdt_write - write to watchdog.
- *	@file: file handle to the watchdog
- *	@buf: buffer to write (unused as data does not matter here
- *	@count: count of bytes
- *	@ppos: pointer to the position to write. No seeks allowed
+ *	@iocb: metadata for IO
+ *	@from: buffer to write (unused as data does not matter here
  *
  *	A write to a watchdog device is defined as a keepalive signal. Any
  *	write of data will do, as we don't define content meaning.
  */
-static ssize_t wdt_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	if (count) {
+	if (iov_iter_count(from)) {
 		wdt_ping();
 		return 1;
 	}
 	return 0;
 }
 
-static ssize_t wdt_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t wdt_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
@@ -844,10 +840,10 @@ static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
 
 static const struct file_operations wdt_fops = {
 	.owner	= THIS_MODULE,
-	.read	= wdt_read,
+	.read_iter	= wdt_read,
 	.unlocked_ioctl = wdt_unlocked_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
-	.write	= wdt_write,
+	.write_iter	= wdt_write,
 	.open	= wdt_open,
 	.release = wdt_release,
 	.llseek = no_llseek,
-- 
2.43.0


