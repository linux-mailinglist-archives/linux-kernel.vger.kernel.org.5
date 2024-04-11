Return-Path: <linux-kernel+bounces-140926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790EE8A19A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C96287483
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219B31A38E3;
	Thu, 11 Apr 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Xq/shxH2"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7961A38C7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849770; cv=none; b=jRlUSF3hbZzRYMGUSG1IUoswSfNQ2j3hMFjpf4JjSqqK34bRJn5FZggqgZWKg/BLfTF0SIoMj46XD5s8K1r3pDDjm7uJ2FtCV5v7tDI1ddjVzfVoSDdiXAKEX6rz/UkD7VYqndrIP4iBl4/RIXK8lY+2zQoLhI0fHXfXIEZ9H8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849770; c=relaxed/simple;
	bh=YdYk418vTwmA+ey7yZx9ARVq0HB6UyKi8g6lBoKZ550=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fae5GvIL8E05wo9U9H+x3GS1u98ZLnfCvAq2ZPxPZkNzL00LIYydXVa3t2Q7mBgQ96khyA2fv7F8cPRJ2nj6EQByzVJJOdndvispwjGTuhMUpVd92Hylp9iNK3+Nxuyxg7nuqeeJhnow5dp2x6JMopXg3c0zsoJaS0CogvVgzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Xq/shxH2; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9789339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849768; x=1713454568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vylp/B+kLpVLQhCobojuB7Q0u9hUZIzqgrY8mV9AQJ8=;
        b=Xq/shxH2KOYODNIX59pHkjGH5eO5SRuwu+eD/VTCRjtl2BNiIqLGkX+G8lGU9WJDAd
         2lems40Otg6F5AjPjIt8VTC80i4DBELpEAXMQ3Elq4ICpgxBMIPcbY2qxVM5otUfT2Xs
         vI1h+sk6I9mXl481/xr6UW3qPSQoA6+BdyLTBg3oSgbI2xECHP+xf3Yq5cADt0H7ze3r
         6u1yEqmFXGOsbgS/bvi9rEocCYONWlEG5e6ZEbx6QiTW51iEbxbqAgmPSd0uLv07Xzys
         Pb/EXioEeEwtjjf8mVbXC/LTf894+qWHKOfPNDOIcc5SQuT1kvCaSaaeLZdbIV1gwurd
         vyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849768; x=1713454568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vylp/B+kLpVLQhCobojuB7Q0u9hUZIzqgrY8mV9AQJ8=;
        b=KPxWxulvnEn6JnNj70ZL7dmUPhAOR5RVyPLCausLggRQZ7+hnLQ2yJuXYT3FYCrgUV
         FP2ibX5RmpSyUaQZvyVnhY3YAvvhhHGLBG8EZ5qz8lMffRFgKTuX9U60XS+cQc6anceL
         4bAr2KiK8s+w+0QQwUdL/PZh3lgMzrXZ8AfLabbFqdvkeoYV22j+PRlrnwG9LfSAYhIm
         +GoQUW4HNdbz5HHhsjXx7L3zo3SSrMXLTQ4h6vSdobvEJT6UN6kDshad2CLDkBix+RzK
         82B2F3W5oBIGjYXSD3m2DvcFB/oYKyBkhK7Pa0JJIOTapvrFh5NF1Avouxie/wSueERC
         4aHg==
X-Gm-Message-State: AOJu0YzBCEAcqLtJG9xZGmIbIk7QTJoQsAVfzGQboaPVDZy8TJIf+Wby
	FAkhMazf8vCmiuHHf4vOHXUHE/RPf0RyxMVKwXBhYJKwmjZTBYFybyZqXllFsQdS+3aHC0DNx97
	o
X-Google-Smtp-Source: AGHT+IHLqpS/2k+aT2Eu6G5HQj3Sk8AorUUybGSbflWbuRljB3aVX4MvGRRkpZKRkTYtpmcC65Bf4A==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr41323iob.2.1712849768132;
        Thu, 11 Apr 2024 08:36:08 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 158/437] usb: core: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:58 -0600
Message-ID: <20240411153126.16201-159-axboe@kernel.dk>
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
 drivers/usb/core/devices.c | 3 ++-
 drivers/usb/core/devio.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/devices.c b/drivers/usb/core/devices.c
index a247da73f34d..f367132a6770 100644
--- a/drivers/usb/core/devices.c
+++ b/drivers/usb/core/devices.c
@@ -538,8 +538,9 @@ static ssize_t usb_device_read(struct file *file, char __user *buf,
 	mutex_unlock(&usb_bus_idr_lock);
 	return total_written;
 }
+FOPS_READ_ITER_HELPER(usb_device_read);
 
 const struct file_operations usbfs_devices_fops = {
 	.llseek =	no_seek_end_llseek,
-	.read =		usb_device_read,
+	.read_iter =	usb_device_read_iter,
 };
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3beb6a862e80..bebfbebc1f69 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -390,6 +390,7 @@ static ssize_t usbdev_read(struct file *file, char __user *buf, size_t nbytes,
 	usb_unlock_device(dev);
 	return ret;
 }
+FOPS_READ_ITER_HELPER(usbdev_read);
 
 /*
  * async list handling
@@ -2846,7 +2847,7 @@ static __poll_t usbdev_poll(struct file *file,
 const struct file_operations usbdev_file_operations = {
 	.owner =	  THIS_MODULE,
 	.llseek =	  no_seek_end_llseek,
-	.read =		  usbdev_read,
+	.read_iter =	  usbdev_read_iter,
 	.poll =		  usbdev_poll,
 	.unlocked_ioctl = usbdev_ioctl,
 	.compat_ioctl =   compat_ptr_ioctl,
-- 
2.43.0


