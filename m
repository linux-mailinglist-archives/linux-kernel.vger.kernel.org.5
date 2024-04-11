Return-Path: <linux-kernel+bounces-141128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8778A1A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1441C235D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77321EB1CD;
	Thu, 11 Apr 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d8UQiDE1"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA31EA769
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850083; cv=none; b=k3dHvN0iCcDc/PcBiaUJZS64C+M7XgKmKSg53aCp/bXykf1e0IKzV7LN5SeZyjm4dWqq9V/UQDV6E/G1DiyhGeLvRqu9MWewCV/SuryuVsyNlRgLozzEKSfuOoobYumU1xuB/2l+/J0vYpw6BJx2T0mm5baRBqd0mFBmmpdycTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850083; c=relaxed/simple;
	bh=6edJZ0jtd5omUayrt66jMF5vKFJjV3HWFHBjXCygvYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghMKy1xPWU4NiXhWx5e3DD5YWv2t7wRD2MK7X7ZUgrUA0y5M49YPOaaERq2eEbJEPpFiNFBRXBpj3W8Lsy7yqeAkTZV0nDcAugUGyjJ660oHsdhHVsG21qVoaLwAyMCRi8lDOTVVU04Wjn64q/nq2pKD5zZxr/+cdAxESPogiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d8UQiDE1; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58236239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850080; x=1713454880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wO000BX4rIAv1096OGOZIi9DLZcNqie5/W5vT1nXmk=;
        b=d8UQiDE1dpu0xWx1Ihxiv3oz+VWBXj+aTPjSip19lihgHBmr+YkvXZy+ChZyblxGLB
         k3J0Y2uPmD9tutiYtj/x5gYdORoD/y0mwv/P8Mt3ueRcb6y4gdXGYCmD8wbk2ddx/rQ1
         jgBNuYiZPbeR1Ui2lyRJUQXtHdgOLaA/NL0u46BRrihXCvibvv/s5UonGZFnXEu3ylJB
         fnXJSKt5A1+2NRyUbeHT8pVIUnAsBMamkR4UuGDvyfECaTlQ5YY4rON4fUIxfHTUYrhL
         eyzHCzxyT4k/ulg1soxZZ8oBDXJmlNJBWUvdaVGr4Un41h68jPiapONc/z989Vb9Ppwk
         xkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850080; x=1713454880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wO000BX4rIAv1096OGOZIi9DLZcNqie5/W5vT1nXmk=;
        b=RU+aZP1gLCuTe1jTdtIjm6cr33zrwg9TJ5MWagwfJTPWadelQf49r9kObq1Ey+phGX
         uq388m66aC2CDV7IkkpPQ8coBQGDITP92RrbW0Kvqju3s81tTSJh6rWbxa3rfaHGZ6Mb
         Ug+OnbCg1Bf5j980yoxLgTMno9GJYNiC/S8P8tPoPPKefP5eNWZa6JVhOIRd1g4H0MMM
         p6NgLz/ptXOzu0VVKwIvZQa4nyZN0EaOI4afwXSY3JzDZO8W1jkPFqXmeQc/dRnLEeGo
         6jAt9mi7sG5G94LaX3vutKCTr4PE+LfloAZCRcy8icN4nbOLZofXcBuegyyeM6ZnUlNw
         An5Q==
X-Gm-Message-State: AOJu0YzNXlL0aNwZ+y9EvK4QAxt//qB+tb8Pk3GDZ/hDYMMiBowkAp2R
	UO5K/iL0oEO4fRwvcrEIlmOED7b8+CTIXBXBpe6hDpx3aCdH70RZviElpZl3Uln+xyQ/UL5znGO
	s
X-Google-Smtp-Source: AGHT+IFp741XHWDD5Z5z0RkNFBzNAlDtdvkL5sFJeIwYGz5OkgL+03gAPuAi0OVVIr9FM0B49mP7zw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr175641ioh.1.1712850080606;
        Thu, 11 Apr 2024 08:41:20 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 349/437] s390: monreader: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:09 -0600
Message-ID: <20240411153126.16201-350-axboe@kernel.dk>
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
 drivers/s390/char/monreader.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/char/monreader.c b/drivers/s390/char/monreader.c
index 7207a7f5842a..151030779624 100644
--- a/drivers/s390/char/monreader.c
+++ b/drivers/s390/char/monreader.c
@@ -358,10 +358,10 @@ static int mon_close(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t mon_read(struct file *filp, char __user *data,
-			size_t count, loff_t *ppos)
+static ssize_t mon_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mon_private *monpriv = filp->private_data;
+	struct mon_private *monpriv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct mon_msg *monmsg;
 	int ret;
 	u32 mce_start;
@@ -371,7 +371,7 @@ static ssize_t mon_read(struct file *filp, char __user *data,
 		return PTR_ERR(monmsg);
 
 	if (!monmsg) {
-		if (filp->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 		ret = wait_event_interruptible(mon_read_wait_queue,
 					atomic_read(&monpriv->read_ready) ||
@@ -392,7 +392,7 @@ static ssize_t mon_read(struct file *filp, char __user *data,
 	mce_start = mon_mca_start(monmsg) + monmsg->mca_offset;
 	if ((monmsg->pos >= mce_start) && (monmsg->pos < mce_start + 12)) {
 		count = min(count, (size_t) mce_start + 12 - monmsg->pos);
-		ret = copy_to_user(data, __va(monmsg->pos), count);
+		ret = !copy_to_iter_full(__va(monmsg->pos), count, to);
 		if (ret)
 			return -EFAULT;
 		monmsg->pos += count;
@@ -405,7 +405,7 @@ static ssize_t mon_read(struct file *filp, char __user *data,
 	if (monmsg->pos <= mon_rec_end(monmsg)) {
 		count = min(count, (size_t) mon_rec_end(monmsg) - monmsg->pos
 					    + 1);
-		ret = copy_to_user(data, __va(monmsg->pos), count);
+		ret = !copy_to_iter_full(__va(monmsg->pos), count, to);
 		if (ret)
 			return -EFAULT;
 		monmsg->pos += count;
@@ -418,7 +418,7 @@ static ssize_t mon_read(struct file *filp, char __user *data,
 	return ret;
 
 out_copy:
-	*ppos += count;
+	iocb->ki_pos += count;
 	return count;
 }
 
@@ -438,7 +438,7 @@ static const struct file_operations mon_fops = {
 	.owner   = THIS_MODULE,
 	.open    = &mon_open,
 	.release = &mon_close,
-	.read    = &mon_read,
+	.read_iter = &mon_read,
 	.poll    = &mon_poll,
 	.llseek  = noop_llseek,
 };
-- 
2.43.0


