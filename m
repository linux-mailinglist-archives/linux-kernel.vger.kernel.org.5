Return-Path: <linux-kernel+bounces-141114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57BE8A1A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DC81F25A16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5B71E6F75;
	Thu, 11 Apr 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fwKAUDbO"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E214D9F6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850059; cv=none; b=X0RJcLf6S9yuS7M/YgKjK6qA7r/W5w1uLHUNgMziz5/nE00vmwIPg1e5DFJdIRIPsQoSwzFsARCXbTAqZJGYaBbVbr6hunX7KYVwxAALGnZVgkJyxTqRGZMmblofVGvlktqkzfYaod8t603hznJocL2o5ut1sXltKpR9zTIeiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850059; c=relaxed/simple;
	bh=NuywpkEJ5uhb61Za5WDF+0PlW+3AqHNQYk0iWLinWvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5i6/cHW67Tk3sRjr58mSXvj9tT6QFSx1ILpvR+e0RVndH0nUkri5xGCjXz9eCUQTBRbBUUjvCIxc5LGfb9uWOdyJZ9Kc7vG7avy61bZ7BUmmIfpWf7vdbrCidqHdlhnHC0GlRVRlAHKnqpGf0TvX55vTw1JjtoUanm+B3qa5dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fwKAUDbO; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69662339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850057; x=1713454857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIZgOldQW0QFPrl6wrSTTi1GrjsH4AXNzCd6PgRTJVI=;
        b=fwKAUDbOMmxuCVZsjswh8Ncd6uZYU9fX66Op1/Y7d35ehjibkPIBpmR3lJ5hBiEbiA
         CfmIarAB2rASLdiJGpMhnwFmHK6F6uLDec5a18UutQKw3809aEqMhpNPu5Z/FP5kLepc
         olQwLoPv3nWVRPzJSuKhTMj4KVT15WocnT3JWgpBc39d5Nq/2ognzYss5IcCkLNy+4sZ
         lMQAv+JX4twxF9D8LQIvdwt4PsOktTrV+ctjQuYehql1Hnj6ZAXTdBQvwSaW15V/m6wB
         NGrXs0Qj6mzECKAXtwYhIyGRoZhuCE1mf7SE50K+RUIlq32Ds3fGeR54RbZhMHCHTy3a
         kXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850057; x=1713454857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIZgOldQW0QFPrl6wrSTTi1GrjsH4AXNzCd6PgRTJVI=;
        b=XXPqIoKeYMXH1aUc45GDciuACeEBYZn3nzCWEXnHGLnGjp4Fh09UwvJGGw+AFDJ+3s
         3IzRAzM15soaz9wGy0rsFcXKq2iUlz75/hIekcS1Qgd3nNwzpgE3KHofmotmGMYtqzqs
         tyV0atMltn9SUSzSLxonlupJv0ZEKkd1G7o+ikyjOWHcTCN8kP1gCm148iZRuf3QWMiq
         gQeayfIeMsd6g6MDqSQO+t765iOtJR68GI0QkKYRbnJNtBAmylZC2cFFjUgdVdlc2qZk
         JpjuvWCQrg/AgnDvDafeid1QFgWNitBUj+OrdVVdIGvuZ5ptYELFU4Zx9l6hpIQDpD3e
         1odw==
X-Gm-Message-State: AOJu0YzNasp8MsgaBe3EQRinxiQWwCESEYLE1IUpvU7BcPMo7Onmx/Pm
	DcEx5swcNi0aA55lIJNhFD7w6LkSmaJIH35cBNB+u0vbiRDG3jC5ptE7P7p2BT2dL3tEUbWEj2t
	y
X-Google-Smtp-Source: AGHT+IEhwzwKxQDtxPKhqB1oUHaRTC6e4LPrpANGHEfXe5AKtPUIHOQYcHW2x1KMq/UFyK6UoYzj4A==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr231908iof.0.1712850057399;
        Thu, 11 Apr 2024 08:40:57 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 336/437] arch/parisc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:56 -0600
Message-ID: <20240411153126.16201-337-axboe@kernel.dk>
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
 arch/parisc/kernel/perf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/kernel/perf.c b/arch/parisc/kernel/perf.c
index b0f0816879df..a564c56ebb6f 100644
--- a/arch/parisc/kernel/perf.c
+++ b/arch/parisc/kernel/perf.c
@@ -181,7 +181,7 @@ static const uint64_t *bitmask_array;   /* array of bitmasks to use */
 static int perf_config(uint32_t *image_ptr);
 static int perf_release(struct inode *inode, struct file *file);
 static int perf_open(struct inode *inode, struct file *file);
-static ssize_t perf_read(struct file *file, char __user *buf, size_t cnt, loff_t *ppos);
+static ssize_t perf_read(struct kiocb *iocb, struct iov_iter *to);
 static ssize_t perf_write(struct file *file, const char __user *buf,
 	size_t count, loff_t *ppos);
 static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
@@ -273,7 +273,7 @@ static int perf_release(struct inode *inode, struct file *file)
 /*
  * Read does nothing for this driver
  */
-static ssize_t perf_read(struct file *file, char __user *buf, size_t cnt, loff_t *ppos)
+static ssize_t perf_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
@@ -285,9 +285,9 @@ static ssize_t perf_read(struct file *file, char __user *buf, size_t cnt, loff_t
  * called on the processor that the download should happen
  * on.
  */
-static ssize_t perf_write(struct file *file, const char __user *buf,
-	size_t count, loff_t *ppos)
+static ssize_t perf_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	size_t image_size __maybe_unused;
 	uint32_t image_type;
 	uint32_t interface_type;
@@ -306,7 +306,7 @@ static ssize_t perf_write(struct file *file, const char __user *buf,
 	if (count != sizeof(uint32_t))
 		return -EIO;
 
-	if (copy_from_user(&image_type, buf, sizeof(uint32_t)))
+	if (!copy_from_iter_full(&image_type, sizeof(uint32_t), from))
 		return -EFAULT;
 
 	/* Get the interface type and test type */
@@ -467,8 +467,8 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations perf_fops = {
 	.llseek = no_llseek,
-	.read = perf_read,
-	.write = perf_write,
+	.read_iter = perf_read,
+	.write_iter = perf_write,
 	.unlocked_ioctl = perf_ioctl,
 	.compat_ioctl = perf_ioctl,
 	.open = perf_open,
-- 
2.43.0


