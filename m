Return-Path: <linux-kernel+bounces-141054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7958A1A90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9362B255EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD7647774;
	Thu, 11 Apr 2024 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="j4LWdugy"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF21D0F06
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849967; cv=none; b=OxAqWXWpHctORR/6catOfZyLZfsIk26JpM/8YDHA8YeeeqAd5REIpBAEiwq5XhHj7aZNNjU1/6xbEYiCp8Ij/69nXaP9t/UAgpl3o0czsE4PV+uEYmxqAfCji0hGpUWE71QzuqIOxUWaywx6K5Z+HKFuECkYmESJhSFJl5O01QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849967; c=relaxed/simple;
	bh=D0X+0qHO4LOxbD44kAq8JISn/l9Eg21JclAtONFSTmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTkqvCgTBsg+4H20rhmC2HScF/2/cc3BGqBFCnTq90BpRDsZmI1S36mX3yMT6H8E1CL2ms0fYeDeK//yR5fB2VgwKOZserrGHSFs57vy/JDtbbFQgs7jImwNDRL45Bmz+wgndWyOBT/KWPnzPTY0XTfz+1vUPnKZDTjHwvcFle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=j4LWdugy; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69634839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849965; x=1713454765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SBd5rZ9o1mmKXDhdun2TfAKNJ6vmtHzimJxT00GKKI=;
        b=j4LWdugy0K9YfyTPRDO/EZ/2/QV4O+Bp0GxU4BCxkM99nwZ8bMwFZV56LwmcI0w8Th
         kz94iqGeQjYPzk4nMB3WmElpv1gQAQbaTYgGPLV96FihxjdlWCekb4OMENg0fNVLkfjy
         kAUTlE6pOX1MxhT7ZGAg4J8CRoHUfCbGoGsP3kpHA1rjHkBnvEu5di7YBYMqK4pglxqK
         MffhItBEPkP8BrOAh/KlM61lhf5L8FLBbZHXnk9d9UDS8Ji7og/RifnS4vLPw8qLlbv0
         jf+PpdJtcIQbMPoh/JVBMop8uL2/BZFRonZVF57B7AiL/g3A3GURbI5Y3Z6AFXUduMs+
         ki2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849965; x=1713454765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SBd5rZ9o1mmKXDhdun2TfAKNJ6vmtHzimJxT00GKKI=;
        b=tKKZB/2k93l9SUc1gzf6vZz5eSavjLGfjDvWDIVnRJ4vWxtNPKRBQhCOOJdrhqtOy8
         DlfAbdXpM0EoOg8RsgFLN4KLvBgWiCBm1kKckRuMol+axOrWaEa0i3gvbvG2skRXamIZ
         wSd+4z5By+Ncbm9oTM4nsvoMw6KRqEP/QShxgJF93X1feZPo+uSK4fgqt0qDsDGEjBjO
         weHjsRP7xBk/n1IU72F7Pqjw8Ujyd3mEce/q6XNamyK4gdA1YSp6cfN0XcaV1TNlzGqd
         sXAHmudcjs+bGOnd2IS35L0YluHBxmQN+GWQ/uDDKIKSz/gaa4t76vFS/9x7KB6wKtgK
         5qog==
X-Gm-Message-State: AOJu0YzZDcyOc06WpzURo/is3pi6TYwqdAuAAOCG9vfXBQYUT14xrtW4
	og6WJknfYKWZbjwhfcvRcznfySGtq8DCdWXelS+RW5Vl8T/su8vwY4/FQfIissHGGeJJfBI746u
	3
X-Google-Smtp-Source: AGHT+IGjEQD8a64IsmpxMnNHA9MDi9GjRz4TS4tRz7fvCZDtwTvhtiInOlcH+7QFBf+gPPLi3xowNA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr201536iop.1.1712849964834;
        Thu, 11 Apr 2024 08:39:24 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 280/437] watchdog: wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:00 -0600
Message-ID: <20240411153126.16201-281-axboe@kernel.dk>
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
 drivers/watchdog/wdt.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/wdt.c b/drivers/watchdog/wdt.c
index 183876156243..4f942a82271b 100644
--- a/drivers/watchdog/wdt.c
+++ b/drivers/watchdog/wdt.c
@@ -305,18 +305,17 @@ static irqreturn_t wdt_interrupt(int irq, void *dev_id)
 
 /**
  *	wdt_write:
- *	@file: file handle to the watchdog
- *	@buf: buffer to write (unused as data does not matter here
- *	@count: count of bytes
- *	@ppos: pointer to the position to write. No seeks allowed
+ *	@iocb: metadata for the request
+ *	@from: iov_iter to read from
  *
  *	A write to a watchdog device is defined as a keepalive signal. Any
  *	write of data will do, as we we don't define content meaning.
  */
 
-static ssize_t wdt_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
+
 	if (count) {
 		if (!nowayout) {
 			size_t i;
@@ -326,7 +325,7 @@ static ssize_t wdt_write(struct file *file, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -447,21 +446,18 @@ static int wdt_release(struct inode *inode, struct file *file)
 
 /**
  *	wdt_temp_read:
- *	@file: file handle to the watchdog board
- *	@buf: buffer to write 1 byte into
- *	@count: length of buffer
- *	@ptr: offset (no seek allowed)
+ *	@iocb: metadata for the request
+ *	@to: iov_iter to write to
  *
  *	Temp_read reports the temperature in degrees Fahrenheit. The API is in
  *	farenheit. It was designed by an imperial measurement luddite.
  */
 
-static ssize_t wdt_temp_read(struct file *file, char __user *buf,
-						size_t count, loff_t *ptr)
+static ssize_t wdt_temp_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int temperature = wdt_get_temperature();
 
-	if (copy_to_user(buf, &temperature, 1))
+	if (!copy_to_iter_full(&temperature, 1, to))
 		return -EFAULT;
 
 	return 1;
@@ -521,7 +517,7 @@ static int wdt_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= wdt_write,
+	.write_iter	= wdt_write,
 	.unlocked_ioctl	= wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wdt_open,
@@ -537,7 +533,7 @@ static struct miscdevice wdt_miscdev = {
 static const struct file_operations wdt_temp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= wdt_temp_read,
+	.read_iter	= wdt_temp_read,
 	.open		= wdt_temp_open,
 	.release	= wdt_temp_release,
 };
-- 
2.43.0


