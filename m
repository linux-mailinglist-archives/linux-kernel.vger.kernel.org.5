Return-Path: <linux-kernel+bounces-141023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3456D8A1AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A135B3033C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3150E42057;
	Thu, 11 Apr 2024 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Obt1PtK0"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041A1C821A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849918; cv=none; b=m2Q936KhGg3c4oPMMweKZb9qHlS/L5J4xgTLg1Ihb/NPGIi/e97Kcv2+dnsdXvMSXZ7FY4TTQErOVjiuLOOjJEDtOGoZOXRrtZb1v7ZIfn7dSIm5smAKF5sgzOgx4VMWGmSP8Uz8qwD7IH1NLvkCyfCJteP+IYIh23AwTqn0w5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849918; c=relaxed/simple;
	bh=OQ0W9bp0HU7TtMcL48U2CrHKsJboA+uK+477ONyAyyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owAx2Oyxr2ytp8/e/wEM6WqUKmRxibmlB746XAwl7QwGNzSgr+P/+j2OtZIygtGKAhi6KU2YdAbpNEi2PVWwYrkMRgCvfZm9L/3Uz5Cj/phIG31bwBDBC0naPbthhYiC1CZ+xSbKx9S9OxCu9wXMDjUytldPb5NHlM1jecBsGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Obt1PtK0; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170561139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849916; x=1713454716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32KyDmFi9HeKijDVBtDWWRaKu/f1KLN1UiQaEnm+lrg=;
        b=Obt1PtK0QGv1FEw5o/TfMFxgMV7YbpY4+MEBFLoswpT1H7sujFrgcv765FEkaQL3Py
         Rp5H6j6C6/FhCONio1pVUcjZkhFERGynNGyUXEcoWBEIPsEVU8KJ3c6862m3Dji5uKzx
         SE7k+n84wWXfqZWdHBqF0Flh2W1vQ4Vlq5HNC/QqLJGdfk55d3unSfbJTepAp+88akV8
         q4OfkDTmsR8c6i6M9NIsYI752zstKFEF/o/MhqW57HCvlV02XwEiD8rBtZBc1ew27iZV
         21uUza3anRU0LBQiaj9AIhZvut7B84bk6c7rxF8rkeF3Y3E0b3XEECCI//UifL2eOOdD
         0Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849916; x=1713454716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32KyDmFi9HeKijDVBtDWWRaKu/f1KLN1UiQaEnm+lrg=;
        b=ljqk4GZH679D92uENqsduX4JiJixZNBGvcUoGfg9bcDyIJpiSlhZWS6j5EHbCjgIOK
         V1dgmWxVgikD+ponoodiEt61i7jGCbpnCMHLecT4Me4Im7NU6apnHXBNBtOOntm/1ooS
         np4VQFDt6rFiWC3XwSO21UamBHl9glfIINQ5VSDUIhXEEZ6yxPvxsm8FlEutMqi53669
         DBsI4d1fCxmLjwJslWGZDasOYKHBGAR1ZGHE5NkjgxtjR9KK5Bwf9JK3TliG5dJVTtth
         kCpdcEPDaZ0Td72OHmqnaYxIl7Fz0jYhviGfxwGPPqiuYDv7hAAfVHfXDeLt6LusdGe6
         /MPQ==
X-Gm-Message-State: AOJu0Yzv/vs+38JRf72gS6Iimd3c02pzS/jtuh1U+ygvn6SohjA56E1f
	112RjpD/BhI1UCkulDQHYl5vx0ashJj09/FYZAk505Vig1rcEZ5nPAJAzonCLSywfErIxfJc/JD
	I
X-Google-Smtp-Source: AGHT+IFm8OhKpoqYmuU8IKgCLH0ijvDh6j2SwClDhK7c/zBrtw+xgww/diD3AGqupcOZKcp/e3Jnlw==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr22752ioc.1.1712849914416;
        Thu, 11 Apr 2024 08:38:34 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 249/437] watchdog: pcwd_usb: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:29 -0600
Message-ID: <20240411153126.16201-250-axboe@kernel.dk>
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
 drivers/watchdog/pcwd_usb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 8202f0a6b093..5fd830c0fdf3 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -358,9 +358,9 @@ static int usb_pcwd_get_timeleft(struct usb_pcwd_private *usb_pcwd,
  *	/dev/watchdog handling
  */
 
-static ssize_t usb_pcwd_write(struct file *file, const char __user *data,
-						size_t len, loff_t *ppos)
+static ssize_t usb_pcwd_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (len) {
 		if (!nowayout) {
@@ -374,7 +374,7 @@ static ssize_t usb_pcwd_write(struct file *file, const char __user *data,
 			 * magic character */
 			for (i = 0; i != len; i++) {
 				char c;
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_release = 42;
@@ -506,15 +506,15 @@ static int usb_pcwd_release(struct inode *inode, struct file *file)
  *	/dev/temperature handling
  */
 
-static ssize_t usb_pcwd_temperature_read(struct file *file, char __user *data,
-				size_t len, loff_t *ppos)
+static ssize_t usb_pcwd_temperature_read(struct kiocb *iocb,
+					 struct iov_iter *to)
 {
 	int temperature;
 
 	if (usb_pcwd_get_temperature(usb_pcwd_device, &temperature))
 		return -EFAULT;
 
-	if (copy_to_user(data, &temperature, 1))
+	if (!copy_to_iter_full(&temperature, 1, to))
 		return -EFAULT;
 
 	return 1;
@@ -550,7 +550,7 @@ static int usb_pcwd_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations usb_pcwd_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
-	.write =	usb_pcwd_write,
+	.write_iter =	usb_pcwd_write,
 	.unlocked_ioctl = usb_pcwd_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.open =		usb_pcwd_open,
@@ -566,7 +566,7 @@ static struct miscdevice usb_pcwd_miscdev = {
 static const struct file_operations usb_pcwd_temperature_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
-	.read =		usb_pcwd_temperature_read,
+	.read_iter =	usb_pcwd_temperature_read,
 	.open =		usb_pcwd_temperature_open,
 	.release =	usb_pcwd_temperature_release,
 };
-- 
2.43.0


