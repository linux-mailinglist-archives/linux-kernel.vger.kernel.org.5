Return-Path: <linux-kernel+bounces-141126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F998A1B77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9474B2419B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16581EA767;
	Thu, 11 Apr 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tTqJViYF"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31D1EA747
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850079; cv=none; b=jIu/ifwByvSnt+yhWYIBj0bgSDF8Nj8/m+0bIFdhwF4nopJPFgvqBLx1p1DchWXDq2D2A8OvtskFwcegenG+76KiMBvR7r4tzXCI1F2NYHrP1MwK99ebOZVUYySTh+vjZ4Weqo3mN4BQPwibQtNNG4KnJVJy20bRs/Bm1OE12/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850079; c=relaxed/simple;
	bh=o7zN9CWFaMWMQlAVPtOY+p2cpzzDnYwHboQIustiNSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riHsZsy0E57o9H84zrWuoZTYBBhZ3IpCijUA4stl/gKAoG7Nes6PfvU2O6IYcnyDugNFDK8Lq/6vbnJweuoCoKuRWdXoNEPDMQo8AABWQTguBydOYykXwtDKHH3yEczgjLRm+05JM58TVJRTFn7/QYt/KfPL77lO+BQnaOA488M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tTqJViYF; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170625739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850076; x=1713454876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zzwpIQ8h/8VlEWcjWWA8wkx+DumuLOQT0dvc2L6+ow=;
        b=tTqJViYFEB/F3ezqaWmWh2IfESDw4ef1/zjrwYBxRaJxpsA4qpT1lfgdrVZeCdrvl6
         tMeIep2avpgp/o/atZkDGADAYdkZ3/8HCar1U9SddYbsK8KQKcOSWYgqEajg1b4Fzagi
         cyWqBYac4xXBI7h/u4PbOhw09SVTNGtfZExQ1//eiTjM4oXFPdJKAktPZs1ySDgUA8wQ
         vU0yQYJonE2vhLRSSwnRVOuYfU/m1ypN1zX18mgLRF6SAqKJPPbc7/na74LLoh/5sL7C
         m5smXPxTSfb9nCvh5zUM6P/pUMDfvrY8CHtFZ491oRELh4mdGulB40v4DXcnuaYiP3gc
         GfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850076; x=1713454876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zzwpIQ8h/8VlEWcjWWA8wkx+DumuLOQT0dvc2L6+ow=;
        b=QSKi64XFHwsmJ43JRTtitGkX7KYd0370EwR8XYWuQq4bpCeEeXmZFRB0iha5W636VQ
         mklIEz9xPHSROvEz3ukfo9871BKFOHOYUzBOBOdzNO7SNEKCnyfPacyQEwoZzzOes1zs
         EsZQeVZ3YymRo74VgIDM7VghKC3akRHIU8in30eU0xPMSxI64EfPWtMVSlxcnc6TvjEm
         tPEHITWerHa7mLpjhA6JPlk9UC+54aCFyMDo00otcDxSv2XNW2oZfnimabDCGxBqyydA
         NYJF3xEpjrXsbrDbpNwWcbH4pzlrUVt/mKZPiWL0yDaIVcsn2O+MOJB7t7puhAgdznpJ
         zq7g==
X-Gm-Message-State: AOJu0YzyJnhYm4iOiIDGu3E4HxPR83bAEu0Vach/cESOtvoviYjTWzWn
	z2y1KWl21G6t1B66bxMi4csgHxeHYg35KeUyl08jSSRGiZUOCuA6+xBYrUzWmtsHRrmDEOt/XVv
	s
X-Google-Smtp-Source: AGHT+IFU7cNEFPVO4V7ID1ecKIF3NULRkox0Yj2iFL7Rf0euRKGm2msdi0LhlTd8SGQ77phM/i37fg==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr235468ioh.0.1712850076610;
        Thu, 11 Apr 2024 08:41:16 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 347/437] s390: zcore: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:07 -0600
Message-ID: <20240411153126.16201-348-axboe@kernel.dk>
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
 drivers/s390/char/zcore.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 0969fa01df58..8f5c890605ce 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -134,8 +134,7 @@ static void release_hsa(void)
 	hsa_available = 0;
 }
 
-static ssize_t zcore_reipl_write(struct file *filp, const char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t zcore_reipl_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	if (zcore_ipl_block) {
 		diag308(DIAG308_SET, zcore_ipl_block);
@@ -147,7 +146,7 @@ static ssize_t zcore_reipl_write(struct file *filp, const char __user *buf,
 		else
 			diag308(DIAG308_LOAD_NORMAL, NULL);
 	}
-	return count;
+	return iov_iter_count(from);
 }
 
 static int zcore_reipl_open(struct inode *inode, struct file *filp)
@@ -162,14 +161,13 @@ static int zcore_reipl_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations zcore_reipl_fops = {
 	.owner		= THIS_MODULE,
-	.write		= zcore_reipl_write,
+	.write_iter	= zcore_reipl_write,
 	.open		= zcore_reipl_open,
 	.release	= zcore_reipl_release,
 	.llseek		= no_llseek,
 };
 
-static ssize_t zcore_hsa_read(struct file *filp, char __user *buf,
-			      size_t count, loff_t *ppos)
+static ssize_t zcore_hsa_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	static char str[18];
 
@@ -177,28 +175,27 @@ static ssize_t zcore_hsa_read(struct file *filp, char __user *buf,
 		snprintf(str, sizeof(str), "%lx\n", sclp.hsa_size);
 	else
 		snprintf(str, sizeof(str), "0\n");
-	return simple_read_from_buffer(buf, count, ppos, str, strlen(str));
+	return simple_copy_to_iter(str, &iocb->ki_pos, strlen(str), to);
 }
 
-static ssize_t zcore_hsa_write(struct file *filp, const char __user *buf,
-			       size_t count, loff_t *ppos)
+static ssize_t zcore_hsa_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char value;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return -EPIPE;
-	if (copy_from_user(&value, buf, 1))
+	if (!copy_from_iter_full(&value, 1, from))
 		return -EFAULT;
 	if (value != '0')
 		return -EINVAL;
 	release_hsa();
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations zcore_hsa_fops = {
 	.owner		= THIS_MODULE,
-	.write		= zcore_hsa_write,
-	.read		= zcore_hsa_read,
+	.write_iter	= zcore_hsa_write,
+	.read_iter	= zcore_hsa_read,
 	.open		= nonseekable_open,
 	.llseek		= no_llseek,
 };
-- 
2.43.0


