Return-Path: <linux-kernel+bounces-129912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FF88971EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D77B290901
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006C1149DE4;
	Wed,  3 Apr 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="o7xE+H1r"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09FD1494DE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153098; cv=none; b=HTanwEfBP8kOcAYuBK7f465PjYP9B0yd8kMZ7jBKzPxPoq5dyukeWslYneKqIc798rEExULNmpKXMLvGg96muzOVZclxENgbGFloI/coQx7+qenrw8Rn92HX3CJ87ktoL+nqWVVnSGpvrxox+6Xh2qrSwVdSLuK/Emu1HXo7lDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153098; c=relaxed/simple;
	bh=RYxshW62rNDqV/XwwfM71cdZpZnhqfyASR91PbgeFwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dc+GXDYH/06mA3SGaJRCpQ/x6Bawdc6RbwsuBEvKYYSU7aOtqret/h4YJ/m6FS+RuAXoUVfpMdnfN6+qF79Vql0Hn/gJISO0PlIaMn8UNrre19DxwMb6NqHbzQZDd+oUjBGbBAcqlIsdFUMYX4C7vpjexPmEFvRhNf7M5Q7UZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=o7xE+H1r; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3688f1b7848so3864995ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712153096; x=1712757896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7phpRQzKHUb5cKw5ojjkDKoDkjW2SeY3RKIXhDXMeoI=;
        b=o7xE+H1rwltHEdaNPiOdFytvVMA+f5fVW0FwhAv57WBI4XaC3HQK/NFMkgCBAGMzc8
         1tSQRmE3JlGfMTbC7+KYX8MW8tUKP0QGCWTiqpCcLHlt+oj8+IAd5VacVRXZKrN8z+Hd
         PLSfvF3QpakKaefxy/MQN/5KUvGXB1wl4e6sIdYJoH5PXya/tRPANJ+HWtLDWDsn9ic3
         NSsqrZTy83FQ6jT0ZuypCm5dYAw4GlyxADV9OgIn7qUdigSqJoNxmoXDSFjqahcxUZEz
         uE9STY8qpDskqs0KgsekQjBq06Eh1sKivD/oYnbWGAJ9oUFk1hXq+QeeicE/9mKld6x5
         2skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153096; x=1712757896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7phpRQzKHUb5cKw5ojjkDKoDkjW2SeY3RKIXhDXMeoI=;
        b=bEEsvsjIL5NOisHyfP10uJ/MpBsQzgBOp/ZonGQztdDPWN6y3hhuA8STyUZ4ox5/fZ
         DmTWFHlmzSSxeXwqHhtJWqlZWRKl5yX94P8ot1sjhiaOMHOjibkVgB9Nx7zEwLD1DGXq
         fY1+tM7EV72Bt68xdxUYilySQh9c/GnuJDdWaHBvFWqV/sUXp0Knt5XyM23G3PLgkeJO
         w/JPIu0rZaSyAlqelGcOanxytnyJSu5jI5m6M0UbWu2DyLw9gNZkHYBwz+KKH8+5KPJp
         Lajg66D+Mo949Y4NyQu8PpTMLEIm1TrTTMHye+iAd6GR3mutyxBUMrvNgAkhHFv+GK0s
         CsWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJK6FRJ+kW0jiFp4F/p79BDpTvytFVrNwJDdkYkIkQ+raYg7kvJVWcfJJka36xBw3LZSq6Y4GFdF3t9L75khFZx+5w8ZYHbNCDCXYz
X-Gm-Message-State: AOJu0YyrJ2suIG8C7QFdm8rUjqW7xTqXhfnMaO5HvXw9G/HiRnlI6zXR
	WxL5ss+O+FVSTZ2+Kl3/okRjv7H8qcKVwaYFXbtzu9rB4bM2CNQiWVHZzX7BKew=
X-Google-Smtp-Source: AGHT+IEBppmO1/3FbazzRqFUqPwmzgcKQdhokjBVL/E2xk7pqmtXNeh2uBIDR19/CXN3YT0AOJ1H0w==
X-Received: by 2002:a05:6e02:2218:b0:365:2bd4:2f74 with SMTP id j24-20020a056e02221800b003652bd42f74mr17975633ilf.0.1712153095826;
        Wed, 03 Apr 2024 07:04:55 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a3-20020a056638164300b0047ef3ea2bdfsm2027098jat.78.2024.04.03.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:04:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] signalfd: convert to ->read_iter()
Date: Wed,  3 Apr 2024 08:02:54 -0600
Message-ID: <20240403140446.1623931-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403140446.1623931-1-axboe@kernel.dk>
References: <20240403140446.1623931-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than use the older style ->read() hook, use ->read_iter() so that
signalfd can support both O_NONBLOCK and IOCB_NOWAIT for non-blocking
read attempts.

Split the fd setup into two parts, so that signalfd can mark the file
mode with FMODE_NOWAIT before installing it into the process table.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/signalfd.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index e20d1484c663..72b6796a9a40 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -68,8 +68,7 @@ static __poll_t signalfd_poll(struct file *file, poll_table *wait)
 /*
  * Copied from copy_siginfo_to_user() in kernel/signal.c
  */
-static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
-			     kernel_siginfo_t const *kinfo)
+static int signalfd_copyinfo(struct iov_iter *to, kernel_siginfo_t const *kinfo)
 {
 	struct signalfd_siginfo new;
 
@@ -146,10 +145,7 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		break;
 	}
 
-	if (copy_to_user(uinfo, &new, sizeof(struct signalfd_siginfo)))
-		return -EFAULT;
-
-	return sizeof(*uinfo);
+	return copy_to_iter(&new, sizeof(struct signalfd_siginfo), to);
 }
 
 static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info,
@@ -199,28 +195,27 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
  * error code. The "count" parameter must be at least the size of a
  * "struct signalfd_siginfo".
  */
-static ssize_t signalfd_read(struct file *file, char __user *buf, size_t count,
-			     loff_t *ppos)
+static ssize_t signalfd_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct signalfd_ctx *ctx = file->private_data;
-	struct signalfd_siginfo __user *siginfo;
-	int nonblock = file->f_flags & O_NONBLOCK;
+	size_t count = iov_iter_count(to);
 	ssize_t ret, total = 0;
 	kernel_siginfo_t info;
+	bool nonblock;
 
 	count /= sizeof(struct signalfd_siginfo);
 	if (!count)
 		return -EINVAL;
 
-	siginfo = (struct signalfd_siginfo __user *) buf;
+	nonblock = file->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT;
 	do {
 		ret = signalfd_dequeue(ctx, &info, nonblock);
 		if (unlikely(ret <= 0))
 			break;
-		ret = signalfd_copyinfo(siginfo, &info);
+		ret = signalfd_copyinfo(to, &info);
 		if (ret < 0)
 			break;
-		siginfo++;
 		total += ret;
 		nonblock = 1;
 	} while (--count);
@@ -246,7 +241,7 @@ static const struct file_operations signalfd_fops = {
 #endif
 	.release	= signalfd_release,
 	.poll		= signalfd_poll,
-	.read		= signalfd_read,
+	.read_iter	= signalfd_read_iter,
 	.llseek		= noop_llseek,
 };
 
@@ -265,20 +260,35 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 	signotset(mask);
 
 	if (ufd == -1) {
+		struct file *file;
+
 		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
 			return -ENOMEM;
 
 		ctx->sigmask = *mask;
 
+		ufd = get_unused_fd_flags(O_RDWR |
+					  (flags & (O_CLOEXEC | O_NONBLOCK)));
+		if (ufd < 0) {
+			kfree(ctx);
+			return ufd;
+		}
+
+		file = anon_inode_getfile("[signalfd]", &signalfd_fops, ctx,
+				       O_RDWR | (flags & (O_CLOEXEC | O_NONBLOCK)));
+		if (IS_ERR(file)) {
+			put_unused_fd(ufd);
+			kfree(ctx);
+			return ufd;
+		}
+		file->f_mode |= FMODE_NOWAIT;
+
 		/*
 		 * When we call this, the initialization must be complete, since
 		 * anon_inode_getfd() will install the fd.
 		 */
-		ufd = anon_inode_getfd("[signalfd]", &signalfd_fops, ctx,
-				       O_RDWR | (flags & (O_CLOEXEC | O_NONBLOCK)));
-		if (ufd < 0)
-			kfree(ctx);
+		fd_install(ufd, file);
 	} else {
 		struct fd f = fdget(ufd);
 		if (!f.file)
-- 
2.43.0


