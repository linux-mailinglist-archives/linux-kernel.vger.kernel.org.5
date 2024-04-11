Return-Path: <linux-kernel+bounces-140839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75908A1928
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F8B1F23E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C1131751;
	Thu, 11 Apr 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SJj2VXYK"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF381311B3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849637; cv=none; b=HXM1DBfa8Ho9UUb4AZNRDxKmsJ3HaXOagyyOT8z/hvMhrOvLaj9ACnPsn0UgCqvxyQ52/KjjXG8LgbK+7ouQLWlUHJPpkH8qEPA63lYyIX0WXxWNdTwEaLtj9IadhllAfH7GJwykh/tScokqdA4iZOh1g8K30rNRTZEE+gHTH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849637; c=relaxed/simple;
	bh=cx8sOxAamrCB0v2KTIn+gNq5QolJZna1nbYPjQwTEWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNXbXKNFZWr+YHCUu7LM2xUNcrTKkeOD9fnX6p8RgFASULnztaN9PO6Wk5B/ncGnijaSYEVlyqjl2f8XYjuEiZSrA8YDuGyjyAhi1gpaFST8zXtrqNdT1KK3bTiLpQCE0aFP4omd+Jh9cFt1+E3rbhq1jIVqEzpVgYAfYKkg2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SJj2VXYK; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170466539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849635; x=1713454435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KRZcfeSiCxixOlLZytLoGKi7V9jw2W3rB1wcxBqkZw=;
        b=SJj2VXYKNYV1lhlNV1YnNyM5/Us6i5LnAVuiO4FShO+eEwQZXlF5AlYRqPgin3EeCi
         4hFxO0WKvJr+IzK0mqw/j1s9SzSyB0KMsaO4JSSEjn5Lf0bWZ/gKPS9zJc/LvfxcN4L8
         vPl9YbBZYSaoph093ZzKfXDublVULzzClj7TrbLBSJgA7VN6XyogH0nyyjR8CQToHIm0
         Mvnnwm787nNrwUwKQ2FkTxlhtKWfrp8h/pGjnVSrGNjx+99kwvW4GLQKMVQ2sHh0v32u
         /ADrY3pr3B++Vw0g2dE+4Ip3vJYO77uAerTlUP0jSZynKGu5XiPUHuDoV9/0fyiFV+2D
         Gsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849635; x=1713454435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KRZcfeSiCxixOlLZytLoGKi7V9jw2W3rB1wcxBqkZw=;
        b=QIjK/ehtEcEsJImrBJhdJLxLoHA+AZJ9ZVcOb9DcK3t/nYCH4VaR8y3xCMrbWWUkoZ
         3+iGBtjIAg5OPGzlVqAVEWo3w3+hsLhrOfKkaCuX3ZMUPtPBwtWXYYJ7nJnI+I3XzCYs
         F9URxGkHJ+dH62ESVyktQmXztYtxbeHxORB50xA4k4GV02mQYI+zXUnmb5sQNQT4VtPx
         gyDvonVo7oFIveSNsFqdH7+8rii69RKiMNQbLZIwe3yVRLp5uAZsvNpvIdF1FjX1/ZE7
         WM/35dVlA02Xoh6Sq83W6DoHI8ou0ZjOEIODCa+/Fg2idLL0vcXlYh/Vd4z0EifU09yi
         fnKg==
X-Gm-Message-State: AOJu0YxaQwsIns2y+aZQ01NQa/9Nnd5QHUDRtvOOEFapX0PL86s+sDAS
	io20ZIwM/cwj7iS8pWxfMSlMP8xjjfwilj+u9uxR4e5VtyLdM+kO0PS+zWTVBlpZv4NQ5cUydcx
	/
X-Google-Smtp-Source: AGHT+IFNXNPZUtWST48LMa5VIx+biIQVxOYZ0RcBSyWVLUPz5r+m0/O95rubJk70hV6qYXon31SKoQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr8636ioc.1.1712849634778;
        Thu, 11 Apr 2024 08:33:54 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 078/437] kernel/time: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:38 -0600
Message-ID: <20240411153126.16201-79-axboe@kernel.dk>
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
 kernel/time/posix-clock.c |  3 ++-
 kernel/time/test_udelay.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 4782edcbe7b9..766ff113753a 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -54,6 +54,7 @@ static ssize_t posix_clock_read(struct file *fp, char __user *buf,
 
 	return err;
 }
+FOPS_READ_ITER_HELPER(posix_clock_read);
 
 static __poll_t posix_clock_poll(struct file *fp, poll_table *wait)
 {
@@ -169,7 +170,7 @@ static int posix_clock_release(struct inode *inode, struct file *fp)
 static const struct file_operations posix_clock_file_operations = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= posix_clock_read,
+	.read_iter	= posix_clock_read_iter,
 	.poll		= posix_clock_poll,
 	.unlocked_ioctl	= posix_clock_ioctl,
 	.open		= posix_clock_open,
diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 20d5df631570..9b6e832f4f47 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -96,9 +96,9 @@ static int udelay_test_open(struct inode *inode, struct file *file)
 	return single_open(file, udelay_test_show, inode->i_private);
 }
 
-static ssize_t udelay_test_write(struct file *file, const char __user *buf,
-		size_t count, loff_t *pos)
+static ssize_t udelay_test_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char lbuf[32];
 	int ret;
 	int usecs;
@@ -107,7 +107,7 @@ static ssize_t udelay_test_write(struct file *file, const char __user *buf,
 	if (count >= sizeof(lbuf))
 		return -EINVAL;
 
-	if (copy_from_user(lbuf, buf, count))
+	if (!copy_from_iter_full(lbuf, count, from))
 		return -EFAULT;
 	lbuf[count] = '\0';
 
@@ -128,8 +128,8 @@ static ssize_t udelay_test_write(struct file *file, const char __user *buf,
 static const struct file_operations udelay_test_debugfs_ops = {
 	.owner = THIS_MODULE,
 	.open = udelay_test_open,
-	.read = seq_read,
-	.write = udelay_test_write,
+	.read_iter = seq_read_iter,
+	.write_iter = udelay_test_write,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


