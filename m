Return-Path: <linux-kernel+bounces-126922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D525894478
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29021F21B8A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7529B4D9E9;
	Mon,  1 Apr 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nVjPjm4W"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E94D108
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993723; cv=none; b=BeBFBRBAYY8HRL9+TgOecyhxfgGILxvd0pBaroXvb2YDwxIWkk8YAD3rmUHrA4uA7rjNtVULAxqZ+RJCzTEToWY72arvrVLJdIIBgqO6G4uSNBrUWfrO17E7SVa/dyO1WXIxkx3lj9FvwytLZJcV0R2vC0uiThT5X/fdQMaf6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993723; c=relaxed/simple;
	bh=yxB0dOFsnApMxhzVwJxbVhnB33RiypuVh5rus9uAs8s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ixjbyk1xCmD56R1QG8W6KqESiEMap31HlZ5nnU6vFItjBMrDtVasUSMnMtHE+x1AYvDpIr3akITtBpPYP2D9/ROx+Z8MI8rdmxLkhy9bE76aLO7c8RGgFOzzzPLZYzRfDVKq76e4rKEvw/2Q9NiD7WvBZrM0g5kTMH+1mEW24gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nVjPjm4W; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-369c4242a9eso596705ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711993720; x=1712598520; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rchbz1AFF3OkIIHRAAhxgGnMNfzyh5TM1jV/yRZNAtQ=;
        b=nVjPjm4WCDdhZiuu5l0ACSE6INeZJtEyhw5CX5OQwQ9ABGXVVSrr+PAdOADHEterI/
         VIwtcS27Ll01tJJL78pdS1zvItcqswJN5jE3FAwREW5vEPyqOfoXtzR9sIAQ29FTp8Kx
         1abyEw8nNrCItmX7WrIzlp7sCja5AA6IFumfEB76CsAGZULjdtReciS9ZkgJ5ZM4reG+
         JmV/3VX3QRHfoZePLcB+PLJy9OPV8yLw/fm+YNz+At7EDDcRwmq0hpQQkRiHIvGMh3ge
         SPbDJmmrMXo9SL4Ha9w/iIh1mlzg0+01AxrADFLI0Ed6TQNi4GsZcb+erHN6cZuLfv19
         KmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711993720; x=1712598520;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rchbz1AFF3OkIIHRAAhxgGnMNfzyh5TM1jV/yRZNAtQ=;
        b=X6mgVbkCOEt8Gs4FEHhPAvcvziA2hzLaSGWpDjFVR4hjbdbw3v/3/nuWIXKUnJtYRJ
         3RgS/utkjUubzY6XhsmsNWlqKtskcqvRXoI3VKbfr22fj9HXDX9aknNqoKgt4pZecyHR
         4yS4vnulObsOnl/4C+cWVMD0ohG+4EdeZMZE1YqWbX+1ECV0uVkNszv74DUlXc/aQD+2
         dn0ewWO248ghRo3VzBu/6aOy1GD/LLJSPjHZiqVXbnerakSuGeslHySY6DGdnU+2FswE
         +Z8OY+GZlXLJxSPcyIquWlKKQkpXjS4t7/9w6g/XcGGBL/rRgZjAMKp8nA+TxwNT67Bx
         9Icg==
X-Forwarded-Encrypted: i=1; AJvYcCVsld7oQ//teJAjUmJv8Li9cG6MVo2Xi/ZQ0vo2nWhoOB/MtMb55pJHBE+2Nom3Jlk9XaIHTNvkSyBBzy1oe1vi88tLD2YEM8R68qnx
X-Gm-Message-State: AOJu0Yw73ha+n1EsVc5kkS1QrwkcDxp8QzAdCKayHM7GxfRypwD7GR/F
	iI8yqLOUqdGsiqRCINq4rQxxxm66XABK60ow9wxT60x5tKAGT0QeVnBwtuz1u/s=
X-Google-Smtp-Source: AGHT+IH9xOrenAtzSndO5V7eWzUg0/Za/z8CKMutC40UThJAlB9+A5yuxDW9owrUJjVW0wITAPx5IA==
X-Received: by 2002:a6b:6d16:0:b0:7d0:c0e7:b577 with SMTP id a22-20020a6b6d16000000b007d0c0e7b577mr4489043iod.2.1711993720096;
        Mon, 01 Apr 2024 10:48:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u20-20020a056638305400b0047eed909f46sm1263603jak.66.2024.04.01.10.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 10:48:39 -0700 (PDT)
Message-ID: <d29bda9d-13fb-428e-8e1d-1a87bbc77751@kernel.dk>
Date: Mon, 1 Apr 2024 11:48:37 -0600
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
Subject: [PATCH v2] timerfd: switch to ->read_iter() for proper NOWAIT support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Switch timerfd to using fops->read_iter(), so it can support not just
O_NONBLOCK but IOCB_NOWAIT as well. With the latter, users like io_uring
interact with timerfds a lot better, as they can be driven purely
by the poll trigger.

Manually get and install the required fd, so that FMODE_NOWAIT can be
set before the file is installed into the file table.

No functional changes intended in this patch, it's purely a straight
conversion to using the read iterator method.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/timerfd.c b/fs/timerfd.c
index e9c96a0c79f1..b96690b46c1f 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -262,17 +262,18 @@ static __poll_t timerfd_poll(struct file *file, poll_table *wait)
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
+	if (file->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT)
 		res = -EAGAIN;
 	else
 		res = wait_event_interruptible_locked_irq(ctx->wqh, ctx->ticks);
@@ -313,7 +314,7 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
 	if (ticks)
-		res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
+		res = copy_to_iter(&ticks, sizeof(ticks), to);
 	return res;
 }
 
@@ -384,7 +385,7 @@ static long timerfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 static const struct file_operations timerfd_fops = {
 	.release	= timerfd_release,
 	.poll		= timerfd_poll,
-	.read		= timerfd_read,
+	.read_iter	= timerfd_read_iter,
 	.llseek		= noop_llseek,
 	.show_fdinfo	= timerfd_show,
 	.unlocked_ioctl	= timerfd_ioctl,
@@ -407,6 +408,7 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 {
 	int ufd;
 	struct timerfd_ctx *ctx;
+	struct file *file;
 
 	/* Check the TFD_* constants for consistency.  */
 	BUILD_BUG_ON(TFD_CLOEXEC != O_CLOEXEC);
@@ -443,11 +445,22 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 
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


