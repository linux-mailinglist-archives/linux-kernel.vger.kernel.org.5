Return-Path: <linux-kernel+bounces-141045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC78A1A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3653B2F387
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BF5154863;
	Thu, 11 Apr 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QEVSSn1l"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127601CEBE8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849953; cv=none; b=P7C5BVwsUtwVZCBEKGrURAlJgaC2qfCSl/S1XwJCi6WypY/0IXSWSsjtNy+UYzmRj4ny55F+jIrPITQhniNem8x4TtukixfUby5Qi79+NK/10tWecrG6euCA5nCw288KEyQIpYzqrxxYY8VHLPycOiI7lZi7Xe2EcCVOKUXwJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849953; c=relaxed/simple;
	bh=5MwfqhUBb8B/5Qs46Wfdn5mfen8Ks1g5KO4fzTQoHC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=he+TTPb32fkurCQFz8SVV4zbIKER7w4I030kdw84RJFwbJUj/LwLPXtk5Nf1w9Jv0E90AYS+N67S7v2nOrKXh3fuyxEZiYaSrizhrDV5y9MXtn2cAKXJNxVv9yRgSKx76d+nVtnuuLAY8/QvMnUKnplRZ/INE+YT46gR6pcEcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QEVSSn1l; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16208439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849951; x=1713454751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y80FFdMmbg2mjqEQywLLQI/f2SdKNe+1liZ3cfliOVA=;
        b=QEVSSn1lCNAkncank18Jtz9SHrYecWt5aQapQiNgmQKcL36byX8Ymd7d0/NpeJ+sZh
         yTC7qKl1lutHXoeeXLhv0hEyay/ck6LGgws14cHyqzkmVBORCt27sv8TeCvmTTje2OHS
         lKlPfa4NVLsJPO4QtsZyUGACq+DtI/6iHE9esjYoMbyItH5f637N14pTZrHgYggxsaRe
         EKY/vVcmK+CaXdVRAYMV6mRSZrCD3rrSfRWVLZ/Ft0AP1QfQah1ZNEqA/mag1hG+s/vF
         91lV0uBtG9tGM0TZI/gqQMfkLx2RbAHyCZz+gXQcRRB2ij96eSSP7o41HW1KlfCqET5v
         XidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849951; x=1713454751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y80FFdMmbg2mjqEQywLLQI/f2SdKNe+1liZ3cfliOVA=;
        b=WfL+9KDDu+KVcyJtEMgxFt5OTVsRs/InjQZkO4YJZkdaUpbDOhQXTi/+SXK9PUKt2k
         cLyq6/vkS7RIZCY9YsxuJNI209WCVknJfMlNImm37wYRqPSjT29Ikly5agWYaGlQhKdQ
         6M+wmrSy52lWrwcUn9o0GnzxHEuQ7Kc3w324iiKSa5HSF2bWKP87jr6QW7tfwOHqO1k0
         Nu1G8RXxZXeliPo7WtUGCF4g5dOTHKLaEnJO8Mn14HD4bsdNED3UuMTutFBpBetdUDW1
         DS894jL2bN/pEZifz9M1demP6k3BjjmwGNJJNbMFQWcqMmt6Z38bJkq5+4nunrKQtULe
         I0ag==
X-Gm-Message-State: AOJu0YzErqqCw2YUpYN5t0HF3qHDqZQUgNOf3K/rXAwEKN58ot5rxPXL
	CtgY+aHVFDYihPaxdDXCps3lBAtK0utjALxo60Tk+72GM6HWureEOv3m1EHeqQ/CqcAbBH8U9tX
	/
X-Google-Smtp-Source: AGHT+IEunKW4kAfHp3WRRBeOgGCYq2JINlgAHZ0q0QdnJUb96Q/xKojcyB0lbQFDxC4LrLTKEIxvaw==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr208819iog.0.1712849950896;
        Thu, 11 Apr 2024 08:39:10 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 271/437] watchdog: pcwd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:51 -0600
Message-ID: <20240411153126.16201-272-axboe@kernel.dk>
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
 drivers/watchdog/pcwd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index a793b03a785d..9515f87c0b9e 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -663,9 +663,9 @@ static long pcwd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
-static ssize_t pcwd_write(struct file *file, const char __user *buf, size_t len,
-			  loff_t *ppos)
+static ssize_t pcwd_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	if (len) {
 		if (!nowayout) {
 			size_t i;
@@ -676,7 +676,7 @@ static ssize_t pcwd_write(struct file *file, const char __user *buf, size_t len,
 			for (i = 0; i != len; i++) {
 				char c;
 
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -716,15 +716,14 @@ static int pcwd_close(struct inode *inode, struct file *file)
  *	/dev/temperature handling
  */
 
-static ssize_t pcwd_temp_read(struct file *file, char __user *buf, size_t count,
-			 loff_t *ppos)
+static ssize_t pcwd_temp_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int temperature;
 
 	if (pcwd_get_temperature(&temperature))
 		return -EFAULT;
 
-	if (copy_to_user(buf, &temperature, 1))
+	if (!copy_to_iter_full(&temperature, 1, to))
 		return -EFAULT;
 
 	return 1;
@@ -750,7 +749,7 @@ static int pcwd_temp_close(struct inode *inode, struct file *file)
 static const struct file_operations pcwd_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= pcwd_write,
+	.write_iter	= pcwd_write,
 	.unlocked_ioctl	= pcwd_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= pcwd_open,
@@ -766,7 +765,7 @@ static struct miscdevice pcwd_miscdev = {
 static const struct file_operations pcwd_temp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= pcwd_temp_read,
+	.read_iter	= pcwd_temp_read,
 	.open		= pcwd_temp_open,
 	.release	= pcwd_temp_close,
 };
-- 
2.43.0


