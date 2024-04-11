Return-Path: <linux-kernel+bounces-141136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCFB8A1AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0256628C6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E891D1ECE63;
	Thu, 11 Apr 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1YGtsZTR"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1569167A5E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850103; cv=none; b=ob5k9r3AcPLhCz1Tt6QTF4lrk6ex+tp3Gr8tKACl8cff51/timrUXemGV+r97SNXoRcmZ5K0ucylq3ueDmM/gABIgEs2E5AJh9+sUaXPLw75W4hAzHFHZT1JszblL/ZsQJ/IFKrosGluClW3icYYp9ZcgEiX2xxnG2gDnDqOlck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850103; c=relaxed/simple;
	bh=FkYWqTvM+2jSptowiPOt+barHIkCI9dC3b27o9bdQqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9J0e9JpYIAG/2iG9MftDTz+5s7SzL7oPZ1FqOtA0vVv/kxSBUCSUQlNbk2mPGnFNEuPe57MqtNclRMFcyv0ReKmUXg7x2AyOv5CfYyrJ9xhtG0evQ4aUCjn6Vl3EUrwHKoif0V53QMW5bfPKq+gTvjx20UoUsiL7WCUxwETMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1YGtsZTR; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16253139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850099; x=1713454899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjm37oBDCr6T/2qjJEXIR+jYlGucpRAsXgmpYtn7BVc=;
        b=1YGtsZTR4IDAc1pljtlWcCxLQJ5XPo5F0KXFezIE1arDbtxn6/EmKyhJNomkpaE9gG
         dagPFE5A78+TzxX7xfkLznhG8D4HsfofvHJFFIF4sLWabEDa5v7OnDSiGQyye4pumNzu
         kgjC+/LY9QD34V87SQcII7tKH9CnwqNz6VRHoGYTK7Pl/qM5KzZ1Dbo9355H0PCrD18T
         Wb8efdUbyjYMYgU6rW6V9Nim3OQoOMAtabJvUwcgjMwj8dFTrODi2DD1qGI/gwB4giWg
         o/1gopv7VIwDktPszRGNOESphq/gw3y/j/pqNz4QiC3J3nzPcIov+sJJ98TBkPI7JbXE
         CsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850099; x=1713454899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjm37oBDCr6T/2qjJEXIR+jYlGucpRAsXgmpYtn7BVc=;
        b=Lq/clTKdV4Ue8xvQgjOXHNRWYxK/tSgNXwSUYvrj8g36lBkK05WrdrVaPYLRK1lPyW
         r5uQBqh3kgmJ0IhyGX620qu7OTBGK/c7pLtJmP4HS9lga0pcR6eGPYKJs/6awp2fluGw
         lboCJW+9q3k6uqnGTl0pQe427+32lWs4WBajn1oLYRBDdQ5WsISluGjBaof0IzwbEitD
         ZL2XOb05fLibIcHIUNBVtSt+C1EqaCpoDcFsx/nOyhVLQaVZkigvNCOjs449AffVy4Ye
         9gVIFOvxGMx4MJZIjLyBmzI2oBKBbEfCUOtQ9rRu+47uuLviFI4MX69fBi4xRlTHFUQK
         9JQw==
X-Gm-Message-State: AOJu0YwSGCxbansDS+5HCtQ5D8kPzKiiZ3nAYwBz/8ga494S3pMWpEyV
	+VnqYQ0R4RsK/KWNfvvtv+Hlo0VagNZrs+7xLvfGDe15HW5UBv52gnp5Slbzr/t2E8H8BDrKAmh
	P
X-Google-Smtp-Source: AGHT+IEhHZinlhSLuM6YKkPR3YHa9s8EMI9PdzE7fWRTEwfoQStXLGimgMsv/BHWlyxYHGZuJGIm5w==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr176510ioh.1.1712850099437;
        Thu, 11 Apr 2024 08:41:39 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 357/437] samples/vfio-mdev: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:17 -0600
Message-ID: <20240411153126.16201-358-axboe@kernel.dk>
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
 samples/vfio-mdev/mtty.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index 2284b3751240..b7b9c39a0497 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -881,16 +881,17 @@ static long mtty_precopy_ioctl(struct file *filp, unsigned int cmd,
 	return ret;
 }
 
-static ssize_t mtty_save_read(struct file *filp, char __user *buf,
-			      size_t len, loff_t *pos)
+static ssize_t mtty_save_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mtty_migration_file *migf = filp->private_data;
+	struct mtty_migration_file *migf = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	ssize_t ret = 0;
+	loff_t *pos;
 
-	if (pos)
+	if (iocb->ki_pos)
 		return -ESPIPE;
 
-	pos = &filp->f_pos;
+	pos = &iocb->ki_filp->f_pos;
 
 	mutex_lock(&migf->lock);
 
@@ -908,7 +909,7 @@ static ssize_t mtty_save_read(struct file *filp, char __user *buf,
 
 	len = min_t(size_t, migf->filled_size - *pos, len);
 	if (len) {
-		if (copy_to_user(buf, (void *)&migf->data + *pos, len)) {
+		if (!copy_to_iter_full((void *)&migf->data + *pos, len, to)) {
 			ret = -EFAULT;
 			goto out_unlock;
 		}
@@ -923,7 +924,7 @@ static ssize_t mtty_save_read(struct file *filp, char __user *buf,
 
 static const struct file_operations mtty_save_fops = {
 	.owner = THIS_MODULE,
-	.read = mtty_save_read,
+	.read_iter = mtty_save_read,
 	.unlocked_ioctl = mtty_precopy_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.release = mtty_release_migf,
@@ -1018,18 +1019,19 @@ mtty_save_device_data(struct mdev_state *mdev_state,
 	return ret;
 }
 
-static ssize_t mtty_resume_write(struct file *filp, const char __user *buf,
-				 size_t len, loff_t *pos)
+static ssize_t mtty_resume_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mtty_migration_file *migf = filp->private_data;
+	struct mtty_migration_file *migf = iocb->ki_filp->private_data;
 	struct mdev_state *mdev_state = migf->mdev_state;
+	size_t len = iov_iter_count(from);
 	loff_t requested_length;
 	ssize_t ret = 0;
+	loff_t *pos;
 
-	if (pos)
+	if (iocb->ki_pos)
 		return -ESPIPE;
 
-	pos = &filp->f_pos;
+	pos = &iocb->ki_filp->f_pos;
 
 	if (*pos < 0 ||
 	    check_add_overflow((loff_t)len, *pos, &requested_length))
@@ -1045,7 +1047,7 @@ static ssize_t mtty_resume_write(struct file *filp, const char __user *buf,
 		goto out_unlock;
 	}
 
-	if (copy_from_user((void *)&migf->data + *pos, buf, len)) {
+	if (!copy_from_iter_full((void *)&migf->data + *pos, len, from)) {
 		ret = -EFAULT;
 		goto out_unlock;
 	}
@@ -1080,7 +1082,7 @@ static ssize_t mtty_resume_write(struct file *filp, const char __user *buf,
 
 static const struct file_operations mtty_resume_fops = {
 	.owner = THIS_MODULE,
-	.write = mtty_resume_write,
+	.write_iter = mtty_resume_write,
 	.release = mtty_release_migf,
 	.llseek = no_llseek,
 };
-- 
2.43.0


