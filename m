Return-Path: <linux-kernel+bounces-140879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A486B8A1958
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305961F21B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE924153819;
	Thu, 11 Apr 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2D8ke4n7"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3315351F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849698; cv=none; b=Wat6l3ZKTwaKR2FyZ6KQDOYETegQRiGhacPzQ//+0Xt2OX4dDfCYNecObjIrmvtLhqNHFCdUTSCDt32vbG5/+zBx4PXTAKL/aHO5VRB3EUopB51v4Z+Nyxc25MvG2X02qknsOT6cpuFunM4EmtrAb/VRXk1okpCdww2fOnXsnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849698; c=relaxed/simple;
	bh=LNeDmHf/c9RfmP+zJv+4NDWg+Hfl/IDiUm2M9Rregfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdOEbMZRTmfiHO+UujahsqWMUoAW/aVwcbT+uhU++M2PjPlsVEPzwnfAqCrk9XSTjYi/l6jLZAVVoQKVa1Z9sH3FFWtUhcvkIw27EfBHBJ3n0L7iqraVM5Pe3DowFFc5iu1B8KHevzoXNNvqR2aLyd2eYZ1BS/EjHwryYpFTmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2D8ke4n7; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170488939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849696; x=1713454496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSQ+RsGRSbfENVXBvbiA637C0r9rKvEhaiQYT/ebYP4=;
        b=2D8ke4n7BX1eUyPAaPKCuL97T5GykRTVn613hpVJJv9/9L1Qn6t8/3vSrXCNL5HFGW
         qJemvAavX1D3tilNYGeB/EtF1wyzRi1TtPXoNsmuk+s+AoqViydWY5qiF7SIUJ9hqpzC
         CEAwU6AvdGI8DpwzPtwP39XTjLUOwcZPGiUir/SfvyHnxxFSjUrSwcST7S87Y26DE7oF
         d3nE8brqJlXVvMASaKex38lKq6gRrXuM4KdjoFaqSQEwtTXaVT0BTEgFvMCtsTm+1j1f
         M8mJaJTE6h8TLK0jgUuEVw6IEpEf8tkzV2/WJKPoBKORikvpm+p3r4SvV0fLAg4nE7eQ
         x+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849696; x=1713454496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSQ+RsGRSbfENVXBvbiA637C0r9rKvEhaiQYT/ebYP4=;
        b=cwUFc0IvKZK/Nnajh0s6z8BqxVIh74XCnvVDunbi6pJFHEDu92pmD9gwUeVIb0eAY9
         cPO0Hvp7yl12APlzeTIyioYczXWcrInFKJ6JeLhRuGKqJ581rXmFVOrqRgPabJqjHAuK
         KbKs8t8+4WU/uVNO9HZzOBwBIsiZCgxe78RWnmZD+vr2H9IY9/vDNQa+iJXTNu+3x31/
         gVMv4z4gmj9BzRiH5jDVLzQhoae0SP845H4/vd08eYJOMIvOw/CBQHEuH/qk0gPerDUN
         g+peNmv121u5ZcfbHEl9Y+gbcewC9hfy5lq993iElvWof9dI3UwNlhnAEp0tkuIV9NqO
         cOEw==
X-Gm-Message-State: AOJu0Yxc7lqpAnDc+XPtT/BSciQm4BRgRS9bYY2DLNuxdEBCxp5UsGBA
	5KfBRHX0/U+OwfYG3PNw7xpu+SyfDsO9s5FHufR7zZzFak0NT81XpKhspHka8u70dZMwU9f4/fR
	T
X-Google-Smtp-Source: AGHT+IGiHXX3i/b+i58q+Q3k+BQ2SqU7VJPWD5LJOxcxaQYEr5lvhtwtf3d19EQoguHZ+RyrPLBPaA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr177850ioj.2.1712849695724;
        Thu, 11 Apr 2024 08:34:55 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 115/437] drivers/comedi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:15 -0600
Message-ID: <20240411153126.16201-116-axboe@kernel.dk>
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
 drivers/comedi/comedi_fops.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 1b481731df96..0e18fac552d3 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -2463,8 +2463,7 @@ static __poll_t comedi_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
-static ssize_t comedi_write(struct file *file, const char __user *buf,
-			    size_t nbytes, loff_t *offset)
+static ssize_t comedi_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct comedi_subdevice *s;
 	struct comedi_async *async;
@@ -2472,7 +2471,9 @@ static ssize_t comedi_write(struct file *file, const char __user *buf,
 	ssize_t count = 0;
 	int retval = 0;
 	DECLARE_WAITQUEUE(wait, current);
+	struct file *file = iocb->ki_filp;
 	struct comedi_file *cfp = file->private_data;
+	size_t nbytes = iov_iter_count(from);
 	struct comedi_device *dev = cfp->dev;
 	bool become_nonbusy = false;
 	bool attach_locked;
@@ -2546,11 +2547,11 @@ static ssize_t comedi_write(struct file *file, const char __user *buf,
 		wp = async->buf_write_ptr;
 		n1 = min(n, async->prealloc_bufsz - wp);
 		n2 = n - n1;
-		m = copy_from_user(async->prealloc_buf + wp, buf, n1);
+		m = copy_from_iter(async->prealloc_buf + wp, n1, from);
 		if (m)
 			m += n2;
 		else if (n2)
-			m = copy_from_user(async->prealloc_buf, buf + n1, n2);
+			m = copy_from_iter(async->prealloc_buf, n2, from);
 		if (m) {
 			n -= m;
 			retval = -EFAULT;
@@ -2559,8 +2560,6 @@ static ssize_t comedi_write(struct file *file, const char __user *buf,
 
 		count += n;
 		nbytes -= n;
-
-		buf += n;
 	}
 	remove_wait_queue(&async->wait_head, &wait);
 	set_current_state(TASK_RUNNING);
@@ -2599,8 +2598,7 @@ static ssize_t comedi_write(struct file *file, const char __user *buf,
 	return count ? count : retval;
 }
 
-static ssize_t comedi_read(struct file *file, char __user *buf, size_t nbytes,
-			   loff_t *offset)
+static ssize_t comedi_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct comedi_subdevice *s;
 	struct comedi_async *async;
@@ -2608,7 +2606,9 @@ static ssize_t comedi_read(struct file *file, char __user *buf, size_t nbytes,
 	ssize_t count = 0;
 	int retval = 0;
 	DECLARE_WAITQUEUE(wait, current);
+	struct file *file = iocb->ki_filp;
 	struct comedi_file *cfp = file->private_data;
+	size_t nbytes = iov_iter_count(to);
 	struct comedi_device *dev = cfp->dev;
 	unsigned int old_detach_count;
 	bool become_nonbusy = false;
@@ -2680,11 +2680,11 @@ static ssize_t comedi_read(struct file *file, char __user *buf, size_t nbytes,
 		rp = async->buf_read_ptr;
 		n1 = min(n, async->prealloc_bufsz - rp);
 		n2 = n - n1;
-		m = copy_to_user(buf, async->prealloc_buf + rp, n1);
+		m = copy_to_iter(async->prealloc_buf + rp, n1, to);
 		if (m)
 			m += n2;
 		else if (n2)
-			m = copy_to_user(buf + n1, async->prealloc_buf, n2);
+			m = copy_to_iter(async->prealloc_buf, n2, to);
 		if (m) {
 			n -= m;
 			retval = -EFAULT;
@@ -2695,8 +2695,6 @@ static ssize_t comedi_read(struct file *file, char __user *buf, size_t nbytes,
 
 		count += n;
 		nbytes -= n;
-
-		buf += n;
 	}
 	remove_wait_queue(&async->wait_head, &wait);
 	set_current_state(TASK_RUNNING);
@@ -3179,8 +3177,8 @@ static const struct file_operations comedi_fops = {
 	.compat_ioctl = comedi_compat_ioctl,
 	.open = comedi_open,
 	.release = comedi_close,
-	.read = comedi_read,
-	.write = comedi_write,
+	.read_iter = comedi_read,
+	.write_iter = comedi_write,
 	.mmap = comedi_mmap,
 	.poll = comedi_poll,
 	.fasync = comedi_fasync,
-- 
2.43.0


