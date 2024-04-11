Return-Path: <linux-kernel+bounces-141039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FBA8A1A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E8E1C226D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8171CE128;
	Thu, 11 Apr 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AbpVXOCY"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F11CD77F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849944; cv=none; b=ZUmWf9LGfCOFVljWtAU2XP1r1DVZhKJ4M9ylqC9c4Ka8Mx1w/AuelMGMkhDMiu60danNdANvqy4hGx6e5zt1x5J86Yn1mZ0TWoTYc4A4doDeL4r4bb8MR9vs9qWKsGI7OjQLsQPZQXSZCQ0dJU/HAPtoc9+myQWFFTOabj2EALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849944; c=relaxed/simple;
	bh=xShioC90yhdGNMgFydnNZ/9wTb65LFc2jsMjXFGjd80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijCSsdBVjrhPRHQWyIyOfEXgR1XMuQWBEjh+NqusAzarwbV8Y6gmI9vtRVvAg0Q//G3TBkSr0rCxfrGVw7eOBWDHb395sP4PnskzNRUEXyoBJ1ApRQ2VYVAieET2ca6Yl4VsFxGbyVGxQ4kJwg0tYs87v6DbpMDNYFMWPMvJYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AbpVXOCY; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36a224d7414so188575ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849942; x=1713454742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXpsrimWRyxwEEReCCDJMdTK91+YNZPOEGJBjVtf1ZE=;
        b=AbpVXOCYvYlXOsNIVjoUkikXYrPxqQ/ie/Y1jUxr3bhlnSSe7dzFJiWkXzwVgt5xEH
         7Tsn8PqbOmIXv6IHGzyRStX0VqFyc0q8m1G1n+PYrkhp9rPbaRGPaQX98saQXJNWUtzJ
         EPgGgD4BpTHpRlvglA/UusdMgF2m4JhkjmP0JHRUGjAu5bGfh6eHHBvNHQsJR3XIkfSh
         jmQ++eT++VEcGLxXRmtumEtCptjZTZS/oMpn2TS5XgEszNSQE80qlso6R3f5UjnOUOOr
         r+uH8qolvPfqQO2h09bRxGkL1JQq5hOlpODuVZ0gmO041v/WyL2PPLsEPwsiomGdh4ud
         yQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849942; x=1713454742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXpsrimWRyxwEEReCCDJMdTK91+YNZPOEGJBjVtf1ZE=;
        b=xBr9efI+KG/AreQD8DqgZRFHVDu3NUumeHWsipI3KdJAB3bjvQ63yWR2HS8ZL5af6p
         L91u3pY4vVnraOFstJVNmsC0deKE7x+6x6nV/zuZdem1UjV1fdJRlXQLyaIV0IHazI6B
         76fnAcVOGzOvy6QR3/IWyYs4sZ+86hxniGZznLq/m0acEYLMEMYim7gqmWPmoPO0ymlu
         50vVAhnC9ltnIqKY3y5xZXe4ShR2TjFzY6Juhcldiphoyh30PidxJCqvxoecxdUFvA6Q
         BaqEGXoyEWznN/9gb41tTjpFqV4/8VG9v17AyLSsYBcJBxxahjXqAqflyDoXqyTV1Z7o
         k95Q==
X-Gm-Message-State: AOJu0YwKyhUT5ztCzY4V+vfpDK2rk0sZK5Y7MAkSq+xcSrttEkcAhzO1
	gvKF+h/OG+h7y1nz04hvEPpIXgR6uj/UB0qM6vBSOtTe1CAokVOdQ4WmVcolqRiu4fZL4jyzMs/
	n
X-Google-Smtp-Source: AGHT+IEm+e6VGvD/D28PJ/V7Q3R3ewu5QB3578H8F1yMFWKL/QZAURXSF6wFiy3kF1eVl/6CaSlxDg==
X-Received: by 2002:a92:d812:0:b0:369:bf80:e367 with SMTP id y18-20020a92d812000000b00369bf80e367mr6248808ilm.3.1712849942000;
        Thu, 11 Apr 2024 08:39:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 265/437] watchdog: cpwd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:45 -0600
Message-ID: <20240411153126.16201-266-axboe@kernel.dk>
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
 drivers/watchdog/cpwd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 901b94d456db..ca6d08107043 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -478,10 +478,10 @@ static long cpwd_compat_ioctl(struct file *file, unsigned int cmd, unsigned long
 	return cpwd_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 }
 
-static ssize_t cpwd_write(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
+static ssize_t cpwd_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	struct cpwd *p = cpwd_device;
 	int index = iminor(inode);
 
@@ -493,8 +493,7 @@ static ssize_t cpwd_write(struct file *file, const char __user *buf,
 	return 0;
 }
 
-static ssize_t cpwd_read(struct file *file, char __user *buffer,
-			 size_t count, loff_t *ppos)
+static ssize_t cpwd_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return -EINVAL;
 }
@@ -504,8 +503,8 @@ static const struct file_operations cpwd_fops = {
 	.unlocked_ioctl =	cpwd_ioctl,
 	.compat_ioctl =		cpwd_compat_ioctl,
 	.open =			cpwd_open,
-	.write =		cpwd_write,
-	.read =			cpwd_read,
+	.write_iter =		cpwd_write,
+	.read_iter =		cpwd_read,
 	.release =		cpwd_release,
 	.llseek =		no_llseek,
 };
-- 
2.43.0


