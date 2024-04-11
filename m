Return-Path: <linux-kernel+bounces-141011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076418A1A16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364151C21DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C670B12C494;
	Thu, 11 Apr 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ot29EPLW"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ED91C42FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849901; cv=none; b=mLFNM97rzTXZ2d099zTpdxL9UomIdk7TIoza05BIzroCzQ32v4aIsWCm6xAV2V8QhdZrNK40meauCVkWGViqAF8XFvNVyryFV+w1qT5o2LFyiWEcOsL9jA5WGAvahp9iyIGYFBIsKcSp+pKUiMuW2702r7JMqznB5fVBsXWy8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849901; c=relaxed/simple;
	bh=r0gpEGLufdSSDJSUSmGBpzIFe7zazyP/Lyd4xKydQHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFOYor3UOIDmEILISl48uMGHWADcn+pI/n3uQbT/pCQGUJNsrnzBzTbBkZBi8qLsTOLFy9ZHTd68tpTHkIiw1pzJSZhjk8qey/YMrdHx/WAaib6Ca3kK3DI6UnhUYv1YeJLB0GAkpe7FHa6F0AjL7BmRRdcg7gifFiQ/eVSTeHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ot29EPLW; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58130839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849899; x=1713454699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIhvJ0QTKEm+dZZbpq9+5Ejm0PJbjdv4ucEw2PtmBxk=;
        b=Ot29EPLWSRAXEAXyghEyhV32mFkzJzTQmpoONGUc7fWj9l17KK+U/CoUOD4MY2elrO
         cNli+yf0iKYZ38hFCCmh1lV7mvAYAmvP6rPTPh0u6cKZMUc5xHx4xrL44OH7dCV6CuVD
         HA+C4NfxRGu7wO1nRJgGquj8MURKUqjlDEz6BO8oPc8iyddWuYo0VrqxcPM/UG6R1wPi
         riOshhzLOsHl7Hj+ZYYcUXjrEeYTycl7OCHWxTDBwlP6oDcArZv+BqX0dsIe1nQLsSVa
         cV/U+xqNl7Xz5X5ep3BsTblGX8hVpHB33Lrt+8n6tyzU1nzblDmaWkpnNDSnbUBt9I+0
         pBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849899; x=1713454699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIhvJ0QTKEm+dZZbpq9+5Ejm0PJbjdv4ucEw2PtmBxk=;
        b=RtgAP2BAQ1FkeBZy2uId3e70HWAgLpNIipHP+nhQwD8ZqsHTbd7FjBlIoVQfqEuKtT
         fI+nHFes+D5/lF4ZiBNVzOCQ0RQFkBzCuX9E2R8fXhLKa/nmNuoG43v+oro9YCU+nBHk
         D5B0fu/vQ4KDw5URKduIS0ZnH407u/U9sSQRyxsMgSHD9N2AqVzPCjxyOu7VOoZagwR2
         7hojMkt+iWI/NmYdcxayjL8Jfk04hQyGlj8chbOQA63+EoX7BdQYfLBmDxIk8rF+/Fu9
         q2LC/EwDGjVDluUV/KbSREIohIDvdj1xTgHMDSoxtO21h0GsVkEvwlyVIQtJaMaH2+ja
         D3WA==
X-Gm-Message-State: AOJu0YyoXziU69SPaKWtY1uZmvBD1WuJIFDjcpmdgUjY/40PauV8Ui4A
	GJleBoAyIy30ietSOkjvm7ctTfvremFwBfMMgz3okXvaSz9XCwLHzb8TLrj4HP7V0lNqNpEEvoc
	S
X-Google-Smtp-Source: AGHT+IEstS7kc7SyMyIlbgeC5GZU3Pzkh4u9326ew14GjN70UKhmkHatszxWPiWpe4+fhx/VKL1iwQ==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr207390iog.0.1712849898846;
        Thu, 11 Apr 2024 08:38:18 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 239/437] watchdog: eurotechwdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:19 -0600
Message-ID: <20240411153126.16201-240-axboe@kernel.dk>
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
 drivers/watchdog/eurotechwdt.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
index e26609ad4c17..e11b4acfa8ed 100644
--- a/drivers/watchdog/eurotechwdt.c
+++ b/drivers/watchdog/eurotechwdt.c
@@ -186,18 +186,16 @@ static void eurwdt_ping(void)
 
 /**
  * eurwdt_write:
- * @file: file handle to the watchdog
- * @buf: buffer to write (unused as data does not matter here
- * @count: count of bytes
- * @ppos: pointer to the position to write. No seeks allowed
+ * @iocb: metadata for IO
+ * @from: buffer to write (unused as data does not matter here
  *
  * A write to a watchdog device is defined as a keepalive signal. Any
  * write of data will do, as we don't define content meaning.
  */
 
-static ssize_t eurwdt_write(struct file *file, const char __user *buf,
-size_t count, loff_t *ppos)
+static ssize_t eurwdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	if (count) {
 		if (!nowayout) {
 			size_t i;
@@ -206,7 +204,7 @@ size_t count, loff_t *ppos)
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					eur_expect_close = 42;
@@ -369,7 +367,7 @@ static int eurwdt_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations eurwdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= eurwdt_write,
+	.write_iter	= eurwdt_write,
 	.unlocked_ioctl	= eurwdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= eurwdt_open,
-- 
2.43.0


