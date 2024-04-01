Return-Path: <linux-kernel+bounces-126748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89807893C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6712B21DC8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A0C43AC2;
	Mon,  1 Apr 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vbRzFtYr"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88522093
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982186; cv=none; b=hjfEcbFTrqtJye5rPZjmxc28nr7VKLV1K9IYxjqdx6OJX8IFjTwMGrldBPAEm8ehpn4ZwT8cfBjTbfWItnnCm5jCuqTfLL796wlz2ag00btLqIYokbQxt+nWEbCiviM4b7onOpHxPVI9WCs+Ze/JOk7/nAE4o3rX6MKVkzohctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982186; c=relaxed/simple;
	bh=tttedzRvaJG3KbiI7Ru6YeDlFsxwkRdr5+bdoF4FuSk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=NtHffpXAbiw7f6RTfTH1+PZuZ7ZTvLxOlSD/7wgbAyatcj8Yoiyvl256YptDEwMebW5qI9705hac/RgFZKoSR6A+hLT3mVklQxUG8jWVBB4v7Nk06uN00k6kAarvQoL0FUo8N2NOrBHI3yUjXnpdyOxbTGvCtl/2y8nrZSrIC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vbRzFtYr; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cc67249181so29184739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711982183; x=1712586983; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ltg0u0ghJ7IRb8fWgHA/21TzuOfUg/SV+vjrDaGMyTw=;
        b=vbRzFtYrerBb3j/GJ2M1vdMcTqz+vNODDItpXimXeZXeAqt6eYxx+gp0CIq+y2pNeV
         PZtMYydFZiai9f5vZIMo0dyNs54hGNQEqMYEQpEz6kQU6K4b/xcIeWi5jfPYmt/WcIVU
         VtZVf5G0Tr6q+t3A3Qd1RRikbpVyazlIHPc/nUJXSN0Rwa6aj17hM9vRulr83h0lS16D
         CB2WoBVneffmHezRu4s1LoGShNfqQmauk4cEey3ESHIuXTDJPAqJQah3sbwsdqKu6Ftg
         QQzxZasjWwgCLp1zZgWgQ2V8GMbXbTGVHht+yF2htli+3y5BlrygINAgXAnFDum4VI71
         SLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711982183; x=1712586983;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ltg0u0ghJ7IRb8fWgHA/21TzuOfUg/SV+vjrDaGMyTw=;
        b=Ahs+dTupWDn2plgy362O4P2hbEXy4oO81WpqH4euZJTeF128OBZx2tHqt+AGZK6IMp
         u8m+DORf1RZ/aElYBmJP2c6XVlESqdjc9aOVrK/kTHeF6KANIdNxeaPBArvOqery8fvK
         gDK+bxBbmGL/8sAH85FDjdM0jzM/IW4HtftWAWxA2zsJ2fZl6pM/2wGt3UQNEdsnVi1+
         CjvS9PIMnR30AQmxV+NUQl+PjIBKOi993sAFAz5XMs+UxQEinQ2F0D/FFu65xcujmemQ
         7t/yggJB+VcHudnZlgwSMSriF19UOaI2HtP9LBt1/YrpYtGX52j7XeAmwcef1eHeJpJG
         11ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV8muc4Fm/JH0bcnS+p7DnLD2FMEwc8dvSyZMvX8SKPZfK9IGGrgbqktjrvJXK0uD9s7i8fSm0vT5qFJlzEli4xNOA+RKm0o/z5VVRl
X-Gm-Message-State: AOJu0YxS4CHztINI79g1QQxeCSkXhFEMv2sIHrthQfoQ+acyH/u4x7Hx
	nWW5+iefN03h+thDRHYXM/0coGq7n7tOInMwotx8fgguNoHKenUzV7tzWyg73K4=
X-Google-Smtp-Source: AGHT+IF07Btw8NGrlUXgq8Iu5rp/C2QJmRs7UVCLEGq0Z18YVznZ0regsIiorY3/kD2WgZyQYfmHtA==
X-Received: by 2002:a05:6602:2b09:b0:7d0:a4d8:f285 with SMTP id p9-20020a0566022b0900b007d0a4d8f285mr9401099iov.0.1711982183263;
        Mon, 01 Apr 2024 07:36:23 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f66-20020a0284c8000000b0047be39e85adsm2646920jai.83.2024.04.01.07.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 07:36:22 -0700 (PDT)
Message-ID: <b4059ed0-5567-44e7-95f7-f7e4b227501c@kernel.dk>
Date: Mon, 1 Apr 2024 08:36:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] timerfd: fix nonblocking reads
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

timerfd is utterly buggy wrt nonblocking reads - regardless of whether
or not there's data available, it returns -EAGAIN. This is incompatible
with how nonblocking reads should work. If there's data available, it
should be returned.

Convert it to use fops->read_iter() so it can handle both nonblocking
fds and IOCB_NOWAIT, mark it as FMODE_NOWAIT to signify that it's
compatible with nonblocking reads, and finally have timerfd_read_iter()
properly check for data availability in nonblocking mode.

Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Can't believe it's this broken... Patch has been tested with a test case
that was reported via io_uring, and I also ran the ltp timerfd test
cases and it passes all of those too.

diff --git a/fs/timerfd.c b/fs/timerfd.c
index e9c96a0c79f1..9297b82af13d 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -262,20 +262,24 @@ static __poll_t timerfd_poll(struct file *file, poll_table *wait)
 	return events;
 }
 
-static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
+static ssize_t timerfd_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct timerfd_ctx *ctx = file->private_data;
 	ssize_t res;
 	u64 ticks = 0;
 
-	if (count < sizeof(ticks))
+	if (iov_iter_count(to) < sizeof(ticks))
 		return -EINVAL;
+
 	spin_lock_irq(&ctx->wqh.lock);
-	if (file->f_flags & O_NONBLOCK)
-		res = -EAGAIN;
-	else
-		res = wait_event_interruptible_locked_irq(ctx->wqh, ctx->ticks);
+	if (!ctx->ticks) {
+		if (file->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT)
+			res = -EAGAIN;
+		else
+			res = wait_event_interruptible_locked_irq(ctx->wqh,
+								  ctx->ticks);
+	}
 
 	/*
 	 * If clock has changed, we do not care about the
@@ -313,7 +317,7 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
 	if (ticks)
-		res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
+		res = copy_to_iter(&ticks, sizeof(ticks), to);
 	return res;
 }
 
@@ -384,7 +388,7 @@ static long timerfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 static const struct file_operations timerfd_fops = {
 	.release	= timerfd_release,
 	.poll		= timerfd_poll,
-	.read		= timerfd_read,
+	.read_iter	= timerfd_read_iter,
 	.llseek		= noop_llseek,
 	.show_fdinfo	= timerfd_show,
 	.unlocked_ioctl	= timerfd_ioctl,
@@ -407,6 +411,7 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 {
 	int ufd;
 	struct timerfd_ctx *ctx;
+	struct file *file;
 
 	/* Check the TFD_* constants for consistency.  */
 	BUILD_BUG_ON(TFD_CLOEXEC != O_CLOEXEC);
@@ -443,11 +448,22 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 
 	ctx->moffs = ktime_mono_to_real(0);
 
-	ufd = anon_inode_getfd("[timerfd]", &timerfd_fops, ctx,
-			       O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
-	if (ufd < 0)
+	ufd = get_unused_fd_flags(O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
+	if (ufd < 0) {
 		kfree(ctx);
+		return ufd;
+	}
+
+	file = anon_inode_getfile("[timerfd]", &timerfd_fops, ctx,
+				    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
+	if (IS_ERR(file)) {
+		put_unused_fd(ufd);
+		kfree(ctx);
+		return PTR_ERR(file);
+	}
 
+	file->f_mode |= FMODE_NOWAIT;
+	fd_install(ufd, file);
 	return ufd;
 }
 
-- 
Jens Axboe


