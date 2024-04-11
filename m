Return-Path: <linux-kernel+bounces-140951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098A8A19C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14A91F2222F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F973DABFC;
	Thu, 11 Apr 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qpLE6Cw2"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B021C19D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849809; cv=none; b=k4ZVSiZalTFiS8P3+qSTyF1u1YQ+oDfeIrl/m/7XB/4JZf9niwTvUTiCs0QOXXZ1/CawVvZDI1M2GjdlCInS6gtMu4QH1X1hi+KdHn9WPIiyHnVK/EBiyPONhPuRnzuslb2nX51p6dqtMyRRIyZyI+n4ucrqDGUTdkACaxWuEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849809; c=relaxed/simple;
	bh=HeUeBwDSc3iClftRlb4a5dUo5F/rbkCj5Y6bxhnSMJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joFNygJmP1u4K0gZSlAGeVP6N/ZQhEaI1qA4H5DodQ45xmbMNXQJVBGLhpZcMMVnnUf8Vy1+BQfYyU5KOwmNvx/U+SL2nH//LVuTysodtgRhd4ySe48PZ30lBbf/gIy0ZAbGlQT31lwV18JOihLg6Dcl36rsnJDJ1LBVIqA92TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qpLE6Cw2; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58087539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849807; x=1713454607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OybDisNMGnYP511VijlsuJv2L1EoAdGm1en+9fQU3qA=;
        b=qpLE6Cw2YYT71mZQErse04B4sCSf+mwqdB73mBCJBEmQ17bCZcKXcr9ekiRpREI9ca
         fRgIAbzaGXXhdj+nC8wE8r+V45FnHPeVw4L5UQmcR5UYlodwztiANS/gOzFXJ62UnmQz
         c30ObY1z+64lTMKJp8bh+Q3+qYrTE/Na8sVFhDW+e9+HnI5Z1DdfMjcS9flPYDVLX8IM
         OShPPxt3w6gzbSyEtAxh3luGxJio5wBUBHzX+pr981zswuM6rXOYsheScp35OY1oUa0O
         4sveceBbuV4kk2km9Wwq68TC3Vt1yo764H6I+emLPdBX9pT4561qkv1z0QDrbW/hknDl
         us6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849807; x=1713454607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OybDisNMGnYP511VijlsuJv2L1EoAdGm1en+9fQU3qA=;
        b=Ca3KSsbQ3Kwz6ZMSP3cHnP6fAeYP7yPZNQIA22jNsIkfPW4LwK71wBvqw0gYxou2zW
         qDI25Fu91aCbeS1ftPcr/XHEKco3HQifR0Ey8pMPcGi2k7hdm4tz57lge3XDeTVZMsCm
         TojX7DpwhuHr8wCKW/PQKfqXzt6Mv4DgT18KnK4xffjooVqDI3ohk+O7CQ2v3Sa1W33e
         uYNnKQ7+AobqmYzZsc/JvHiUQaqAiMUfK5ucQA0E6ymZ01PKJbHxD/W2SUf0AAJVio4d
         uGMjz89O5QMwGgJHa+hfs3hUSeGy4hyF8OPFHDvtF5r3O9dQ1U/3ukCbbbdfzKSbqYjQ
         32ng==
X-Gm-Message-State: AOJu0YwwUn193sSpmrXfPNk7o3b3PDmEauzwDFP2rDZZLXne0U0+jZ/N
	vdEpSafYzsgDmmsNxUUsyhEEDFaS8zn3HCScCKQYGK8TnTrPYJPtkskM+jMmwm+DMmXMEn6iR6Y
	K
X-Google-Smtp-Source: AGHT+IH01bPHNhUNmfTGp23uDARl+Rp7Y+pp0KT3T2aHFHBc8zVBdZbr1E8m2PdUT2XIIdEXn5ZKzA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr162730ioh.1.1712849806791;
        Thu, 11 Apr 2024 08:36:46 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 182/437] drivers/uio: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:15:22 -0600
Message-ID: <20240411153126.16201-183-axboe@kernel.dk>
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
 drivers/uio/uio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 009158fef2a8..510d3707e694 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -563,10 +563,10 @@ static __poll_t uio_poll(struct file *filep, poll_table *wait)
 	return 0;
 }
 
-static ssize_t uio_read(struct file *filep, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t uio_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct uio_listener *listener = filep->private_data;
+	struct uio_listener *listener = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct uio_device *idev = listener->dev;
 	DECLARE_WAITQUEUE(wait, current);
 	ssize_t retval = 0;
@@ -591,7 +591,7 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
 		event_count = atomic_read(&idev->event);
 		if (event_count != listener->event_count) {
 			__set_current_state(TASK_RUNNING);
-			if (copy_to_user(buf, &event_count, count))
+			if (!copy_to_iter_full(&event_count, count, to))
 				retval = -EFAULT;
 			else {
 				listener->event_count = event_count;
@@ -600,7 +600,7 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
 			break;
 		}
 
-		if (filep->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			break;
 		}
@@ -618,18 +618,18 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
 	return retval;
 }
 
-static ssize_t uio_write(struct file *filep, const char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t uio_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct uio_listener *listener = filep->private_data;
+	struct uio_listener *listener = iocb->ki_filp->private_data;
 	struct uio_device *idev = listener->dev;
+	size_t count = iov_iter_count(from);
 	ssize_t retval;
 	s32 irq_on;
 
 	if (count != sizeof(s32))
 		return -EINVAL;
 
-	if (copy_from_user(&irq_on, buf, count))
+	if (!copy_from_iter_full(&irq_on, count, from))
 		return -EFAULT;
 
 	mutex_lock(&idev->info_lock);
@@ -866,8 +866,8 @@ static const struct file_operations uio_fops = {
 	.owner		= THIS_MODULE,
 	.open		= uio_open,
 	.release	= uio_release,
-	.read		= uio_read,
-	.write		= uio_write,
+	.read_iter	= uio_read,
+	.write_iter	= uio_write,
 	.mmap		= uio_mmap,
 	.poll		= uio_poll,
 	.fasync		= uio_fasync,
-- 
2.43.0


