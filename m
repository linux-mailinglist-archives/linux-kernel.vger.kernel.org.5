Return-Path: <linux-kernel+bounces-141056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE588A1AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03635B30CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5BE47A58;
	Thu, 11 Apr 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kv3/JTYl"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC24779C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849972; cv=none; b=D0qoJ5EtKSJMBYemUmjkguA4gAlpvHipsKYHGOf2X/azL2dI/OesWsnRQIc1yDEaovEnz+xh1oGZVHuVRAwQCOKB29OcP0Nc4/W2u9khHcGfIm1pMGOnAuGzpY7K28GxZl2MUVWNQTuVrX737dpVrfSEF2jFXpmzT84ri00gnLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849972; c=relaxed/simple;
	bh=mitoK38F4rHn3RGv60MpF5u5BORTHUIfBPm+AR2T63s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXxwLkK+lCH7FcH1+AaWxaX7putG6mPVfFbYbTMyk9HoBTF9Khu9iaUgEPW5ibgyzEchlhk3wZLOEOoAkxyx5I8lwPuJ2o+8T7fuWSFTbGCYSW7Gt36Wbf17lTM+YNu9UdhAvcBqlTel6dIug3srQZQQ29DEhWgdkZaCwv8ib1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kv3/JTYl; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a34b68277so115665ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849969; x=1713454769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qErY0UtmcVaF+o8yj8E2fnKvMqRmo+f4G5KHnsKYdo=;
        b=Kv3/JTYl3AX+7bydhUNdo8jmSPmMR6mZaGolE8+F0KijUec5atfZNwegRtDqGwLekk
         kYCfAyOhoDwxQt/4fRnSvUZq26gDiXAWw1UaGh0PyNkkKhpvRyY2MbKhQnyb3sn0LaZz
         opO07u7WsAQWQ71z5dKcDNO6ZL3NDMN6+Ao0y0eo/9tASB1fxO6OAz+mcXFzprww9bE9
         MEypWrka5E1O4U8s3psSqKnq7N2NDfV7/Dpw3SuRl58Nr3qboorGEoUqaD4DfW49Y6FD
         271BTAC3rfB/pB7ajMND4bDIwRGEKW/jdkozqMPULryEQ1o/Pru+G0nKJnffg0Pl2VqZ
         TgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849969; x=1713454769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qErY0UtmcVaF+o8yj8E2fnKvMqRmo+f4G5KHnsKYdo=;
        b=eSPanYD4OsqDIKkJjkBuduU4+Wz7HSeNn9Hf3cmf686Y5D0t10GkiBA80VfbaOP+AU
         TzPKEUUOXpoUnQ6MobmF4TyEZPL7czbJw4F7ssxINnqWruO2O1XlZVV3bT4CSOY2I3y4
         +6K+oSUGWlPgHOzGfzY8a2gc6ZIO14NAXH1o8C2JkW9hrLrhSpH/7o0tzKZY61fatTIj
         CtiqaEvWHCxd5j4Z4qgKVnyAoZq8/7iY9ySOfwI+0f6/vFYEIbL3TofrN0eqfbjBzUEB
         6Kq+SxMhiuOh5zas3gYBfWJd8YoM5iFjTM5CSlpy87/TRxqn+ScK7mun+tA/5sASdGHU
         lxGw==
X-Gm-Message-State: AOJu0YxASjX6WNBZ883Kw35e7kEMQMBtVTx1pZr2Py65qO6v7T/4iDYZ
	KJNem5yTKyLOqY9PJ++mrnk483739XI17iVaKGFEFqxpdp+rk3fxlXRwZTRj+aeAFmQoS4CC8HE
	c
X-Google-Smtp-Source: AGHT+IE34/yvRaO5iMGmfJXMNgG8TMN191HKJOQIb32Rgr8wcwGlrRgIY3CkuM4R/DCJ3jy9/iF/+w==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr196086iob.0.1712849968649;
        Thu, 11 Apr 2024 08:39:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 282/437] watchdog: wdt977: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:02 -0600
Message-ID: <20240411153126.16201-283-axboe@kernel.dk>
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
 drivers/watchdog/wdt977.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/wdt977.c b/drivers/watchdog/wdt977.c
index c9b8e863f70f..e50a7374ceb1 100644
--- a/drivers/watchdog/wdt977.c
+++ b/drivers/watchdog/wdt977.c
@@ -301,9 +301,10 @@ static int wdt977_release(struct inode *inode, struct file *file)
  *      write of data will do, as we we don't define content meaning.
  */
 
-static ssize_t wdt977_write(struct file *file, const char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t wdt977_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
+
 	if (count) {
 		if (!nowayout) {
 			size_t i;
@@ -313,7 +314,7 @@ static ssize_t wdt977_write(struct file *file, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -420,7 +421,7 @@ static int wdt977_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations wdt977_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= wdt977_write,
+	.write_iter	= wdt977_write,
 	.unlocked_ioctl	= wdt977_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wdt977_open,
-- 
2.43.0


