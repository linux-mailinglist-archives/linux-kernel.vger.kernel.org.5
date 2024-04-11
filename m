Return-Path: <linux-kernel+bounces-141013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC9A8A1A18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043041C219D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674D417D029;
	Thu, 11 Apr 2024 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rXyI+QWR"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210B3FE4B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849903; cv=none; b=Ks1WzWV2tTzXw+h4ejlmYfHjZh22ZRXgk7gzC1+SYYr2XY+Qz8zr4eNVVH5WCZG9ZQSGlOsGRs2I1QXEbIbAABjF/Jh3WBy49ks71NxH3swL4O6Na3Rpl9H3xJrPg35qzapchfqGDUZjPP/1SWaLNIWAY9+vk9NqSd5aWZHXGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849903; c=relaxed/simple;
	bh=QkykjnyhiIsmqxTqNUJFbZcIYgen5qApI74Rmh1qFY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDSClpMd8eldl2KrHIuIlFsY4NV04y3yvuToBpOd0MAmpbb45b14l6qQ1z2/I7+JwdT4/ra0/CI/7OEmHyWbEM5SLcx4xfrfGafkvXziRiH3ie/66yp0p/JvdUI3enwvu1qx4U7fPnTM1JhGsqVcKwNA9T7fuIsyG3n6Exs18Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rXyI+QWR; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170556739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849901; x=1713454701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3feDQWPp0h4HB2jNcmqUMgdeJ8japBxB2SfPZpWZN3M=;
        b=rXyI+QWRzjv/1Ip4BcK7l343U9F7UCXR7eq2F4XlzgDhfSCoS5WDh3X0q7QSd1/tL0
         gd3iCzTndf2ZOLJJMmV728jMZCPovS2dGdlsstjAXeS4GIyh1Sb8UTEL56OprcA7PtyT
         5y9mzIVlC6pLFWQ9lUI9u0ae9+Z0oy+KwERRAUkt6kVnpiURaty2dWai9zuPGp4NZKXL
         afD7uDrDm2jtddckRKbumvqeISBJIm5BNIH52mf27PhRaV/2e0HEMtnhesQEOMBzAqDE
         W76rs+HRlHHO3H/rnpBb3KWIj5rQ5KTK+NwgSdhEycRsZNuCnjcjwVk0ggpWZSsxgMzI
         hS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849901; x=1713454701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3feDQWPp0h4HB2jNcmqUMgdeJ8japBxB2SfPZpWZN3M=;
        b=IwkEUrysn66rzdq8ChH5dc4pLZVF/FouSYspvKwJ1E6KD/2KipGzC+Tk3HbUMpzwhk
         dYs4TE2LEaT2xVnwlAJDR3LaKhU0s1VKNM23r8+aupgh1AWV9unHjR7mDblT8pkkz47G
         tACOFCN4OAEg895Nisk7aNttj7c9zOIcz3X9jc/Z5RtFeHmFc3BK/7bWpYgQe8tGYeZs
         flw1TS9hPe2BwYZANNp4cGHXS/CUBM075MUYb0vPpcTypdT00FrjfUxDjUKPWfv3b2Yk
         cyDbYXkV5sQx1x6z2ZPnAGOmR50ZmgmkX7ws3VScmvVEnjT+QwCY9Air2Fn/ecXWWZUU
         Gh1g==
X-Gm-Message-State: AOJu0YwkzJY94pQ3GeWX9rWsPnyM67k71/tAddA9Nhh4wZH01xkPukEN
	cZYD8uLwnlZA6Tf6nzO2xd82y1lGXsJi0Lm2ZtfhN9QPqvhGmDCrBrC1iBoJMy+yedutJ1zqcLS
	x
X-Google-Smtp-Source: AGHT+IFK/kmmEeAD+Q+Gz99Ep0sisFLM6Ckl7gV99dZbTFVo2hKKE2rkIT0pfK+XOPDrblDiAfohGg==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr22163ioc.1.1712849901349;
        Thu, 11 Apr 2024 08:38:21 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 241/437] watchdog: ib700wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:21 -0600
Message-ID: <20240411153126.16201-242-axboe@kernel.dk>
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
 drivers/watchdog/ib700wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
index 39ea97009abd..e5daeed9cd5c 100644
--- a/drivers/watchdog/ib700wdt.c
+++ b/drivers/watchdog/ib700wdt.c
@@ -141,9 +141,9 @@ static int ibwdt_set_heartbeat(int t)
  *	/dev/watchdog handling
  */
 
-static ssize_t ibwdt_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t ibwdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	if (count) {
 		if (!nowayout) {
 			size_t i;
@@ -153,7 +153,7 @@ static ssize_t ibwdt_write(struct file *file, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -257,7 +257,7 @@ static int ibwdt_close(struct inode *inode, struct file *file)
 static const struct file_operations ibwdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= ibwdt_write,
+	.write_iter	= ibwdt_write,
 	.unlocked_ioctl	= ibwdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= ibwdt_open,
-- 
2.43.0


