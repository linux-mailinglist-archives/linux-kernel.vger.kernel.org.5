Return-Path: <linux-kernel+bounces-141032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236278A1A26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515B41C21EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3DF43ADD;
	Thu, 11 Apr 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YKCzNatO"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967E1CC4AA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849932; cv=none; b=o1EqAourQ02uekb3r7eEw4mNjeGJkotsBKM+TzA3nGrNo3FeLykqS92QW9A/fcwuJuQKcfNNJqaBkYP6Uzpjz7R/hpsP+Wm9wEmT6KnD2PNFv9n2e+4fuIglhT0D46U58MrSjPpAGKIZCnY58jlCVTRHR9zu6zA0xfBKqlPtJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849932; c=relaxed/simple;
	bh=QW5JsnuNpQivub7twXafOPYH5EAcQBabP9oDDI8Pp7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQtXxQakF7Z/W8i4pImfarQWyvZvXbqRvK7CoVuc8OJ/NLzD/graswPi17wumOPgkYob6K0y+boChSqdA4tlCv3N/BUoMJj/A6uxbo3FEE7plTyLTZbziEc4mHE6PTT0NLk8LrvccDG7yMPHr3qAxavUqi+ZEL5IsjpmYyIwHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YKCzNatO; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170565439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849930; x=1713454730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9OGk8BSTo3E8SS1FHxgTQ8p7oobNBmq1HPuHXWy2Gw=;
        b=YKCzNatOl6qvWHot15l97qf12qUwVHAhY9CuWtM4cFpwb15jqgaU129rTqCB7J4V+s
         i4zSlqooe4xi9TVCjdi6L+IAisOOlLS/fFzqRXa0qn3HMDO42xtpeP/pDzVNR1Mac681
         yAOtZkPxIyo3f0AhWbYgjDkAiDIdd2CDuf/LGoZimyiLiDaq8ED5uh+iojlKHip17rgK
         pHgYZ0Lo0FkrQ2gICxL/fQODB73liljcJENxWtAqIQRiwum/+zouvMnUA4i4cx6Di/zj
         tkQqVKZ4fQaVVoUYzdiVIc4uC0dGk5eWvaHNalaEEKBkxJTIZV9HH1fBwoQvjp+ffI2C
         sXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849930; x=1713454730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9OGk8BSTo3E8SS1FHxgTQ8p7oobNBmq1HPuHXWy2Gw=;
        b=mzSXPGo+ijVyLPO36kG7VlVtq4bp1vjJLqbFmq7MIkILpKYfAQTLUteyEhejOjXn3p
         hZhxU0gRg/fX0srTRSGanxXjc3t7HSuC3SuKIywQRj/bG6Vt+TF/tw6Rvxy61m/Y+o9i
         K11Kak6Qv2LHsZO+AVoYHeSD2RRLATxWcSOinjJxLuKe4os4/1/UNQTGpubdzgPVyCxX
         AMWUPRDwDChMQNoncyEBHIGQh/0+Jkih2PCPOGyajyEZb3dPk45cJPz+kQnzzjfdauEA
         iEncw5SygAiWBZfOB9cJNfKfL4a3Jy4DNDZzziGJFyRWxVIqdlEAcdwjDlnMLUpOd30S
         z2cQ==
X-Gm-Message-State: AOJu0YwsbAPiC+e0U3ifMBqeifdXFiEKarhdkWsW0YuaA4bqZrFSJVUk
	qKEPhfcnlrh2lpF5DJGIZ+373Avs0JJzXmYtpb3reIm0pMBBpS/W+Dj/GqoEDwDHcfWhD3nBkH9
	F
X-Google-Smtp-Source: AGHT+IHx00UzVHHxsBrfoJ3AP8mTejCHu2px1XLuCdgQcLCHW+rpGi8p9OJsmawQOX0PnWQjn8ZX1g==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr228568ioh.0.1712849930358;
        Thu, 11 Apr 2024 08:38:50 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 258/437] watchdog: smsc37b787_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:38 -0600
Message-ID: <20240411153126.16201-259-axboe@kernel.dk>
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
 drivers/watchdog/smsc37b787_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/smsc37b787_wdt.c b/drivers/watchdog/smsc37b787_wdt.c
index 7463df479d11..e1a0c1b4ca90 100644
--- a/drivers/watchdog/smsc37b787_wdt.c
+++ b/drivers/watchdog/smsc37b787_wdt.c
@@ -386,9 +386,9 @@ static int wb_smsc_wdt_release(struct inode *inode, struct file *file)
 
 /* write => update the timer to keep the machine alive */
 
-static ssize_t wb_smsc_wdt_write(struct file *file, const char __user *data,
-				 size_t len, loff_t *ppos)
+static ssize_t wb_smsc_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (len) {
 		if (!nowayout) {
@@ -401,7 +401,7 @@ static ssize_t wb_smsc_wdt_write(struct file *file, const char __user *data,
 			   magic character */
 			for (i = 0; i != len; i++) {
 				char c;
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -503,7 +503,7 @@ static int wb_smsc_wdt_notify_sys(struct notifier_block *this,
 static const struct file_operations wb_smsc_wdt_fops = {
 	.owner	  = THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= wb_smsc_wdt_write,
+	.write_iter	= wb_smsc_wdt_write,
 	.unlocked_ioctl	= wb_smsc_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wb_smsc_wdt_open,
-- 
2.43.0


