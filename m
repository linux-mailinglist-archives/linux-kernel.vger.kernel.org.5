Return-Path: <linux-kernel+bounces-140785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E020D8A18F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC471F2169C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C88753378;
	Thu, 11 Apr 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sohO6bId"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A8051C36
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849539; cv=none; b=H+QJj1iFUP0DmscP9nBjaIuVa96alMQkUOHmUi5JrHOR0qq2Fmg3iPNeheLM5LLmL41XWoNz9XFf1yHGbIXPTzP8DvngMZkNm67M4FUl8lGEbSetP7VMribOUh6k8rP4tgvJf71m6mYCOj+4ZC3L+pKBPT6O920xddcQ/7TwP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849539; c=relaxed/simple;
	bh=nr4UjchYiQ65PutVyR5tP1SJ6zOECRrpkIcZXp6V/i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1THvKqpqrteLFyHeuj3XW7q0+V87MXXXU03RZiuSRww9qsJ3zToKmCWOyds5aN0UhnYjYIkxJLAt6Of/7Y0TN8130Pgbd1QytPXyGDL+uXCkdi5fyrgQCZ+wgUrFFTZqkCSgbInO8NLv2e39V8WRHHcapFv5YiUGCEZq1ztsSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sohO6bId; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16100139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849536; x=1713454336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KKNacRSnh9x5cp5CuEtZJuk2g6Q15fhmcOxJa0XWAg=;
        b=sohO6bIdZXbCZaysRxRENtKLRjJH6PnYrZ+GeB4pCDPey2MpNtAAyYa/F3u59pJ2oZ
         xQZQGw/oltU/LSTgF9SUOeqDhW9AVRLfgDCYpcdtw4B0gAQtyW0amwL3I10WcSFRW49E
         LODk0U0LgksJZ58sq8g/OC63on4DbXpFNRNwQhYK080HQCPCU1+YDWiEMhsQtWtE8WkB
         B7MK8e9uG7PF0WI8n/Gi+Dn7yIx1sb/ybiTMz7Kf8zDAxk7ihIf8LNr7/tSlt9O3sLpb
         60hIGk65fKnFbWTyMND0GlBOeCCSRTyjeLwyinXYPxmCKKbbr6k6EzAEM+LhluLoeA/v
         TzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849536; x=1713454336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KKNacRSnh9x5cp5CuEtZJuk2g6Q15fhmcOxJa0XWAg=;
        b=LC+U/7XtWF6U1sHr77udVsotC5XP+EfcrB5kXB0bJ/teOj65HS3xZ2V4GSMKdWow7I
         UYApAlesLapNfYlqdIyOzZjKoTogGOHg+9QW/yTehB/ccJtgfbLokq7heV99IWbooFb8
         tmEAVfTXjS5goMyK3xa7DyF62x7p71zmCcjsGGLCxt+te0kpXMH3Fq3aPXuEH7zP6E4q
         GONhbNUoWZTfkjpycef+3WAErnqwEPWNfgVuvXIYaD2t0bjY9r++ya0bmy2zXcuVMgB4
         ehsw4bBdTJ005uO4NEtpaq9uvuQTyMIIj6axWLmyWNFLeie2sSNyqilkobf40eAdCOeQ
         ARmQ==
X-Gm-Message-State: AOJu0YwWOsCN0SBGCmonnlh/Grrszfswn5LhYtzPDVfeiT6dUqyK1DhT
	qeWxaj3siV7uhyXB0JSPU9bdqRDJOVNvLuUxzWb3OEQhBPXFNZ3Fn0jWdM857SWpsLcmwLDSIP0
	u
X-Google-Smtp-Source: AGHT+IE2h6CtwKp/yda+QBI2fNcvpGh6wxfFW9x2aV82xDpQDmZd458vuv/JqOXrb8pw1Ho6qcJ8oA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr148784ioh.1.1712849535839;
        Thu, 11 Apr 2024 08:32:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 028/437] char/nwflash: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:48 -0600
Message-ID: <20240411153126.16201-29-axboe@kernel.dk>
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
 drivers/char/nwflash.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/nwflash.c b/drivers/char/nwflash.c
index 0973c2c2b01a..0b66135c7cd4 100644
--- a/drivers/char/nwflash.c
+++ b/drivers/char/nwflash.c
@@ -120,8 +120,7 @@ static long flash_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
-static ssize_t flash_read(struct file *file, char __user *buf, size_t size,
-			  loff_t *ppos)
+static ssize_t flash_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret;
 
@@ -134,7 +133,8 @@ static ssize_t flash_read(struct file *file, char __user *buf, size_t size,
 	if (mutex_lock_interruptible(&nwflash_mutex))
 		return -ERESTARTSYS;
 
-	ret = simple_read_from_buffer(buf, size, ppos, (void *)FLASH_BASE, gbFlashSize);
+	ret = simple_copy_to_iter((void *)FLASH_BASE, &iocb->ki_pos,
+					gbFlashSize, to);
 	mutex_unlock(&nwflash_mutex);
 
 	return ret;
@@ -259,7 +259,7 @@ static ssize_t flash_write(struct file *file, const char __user *buf,
 
 	return written;
 }
-
+FOPS_WRITE_ITER_HELPER(flash_write);
 
 /*
  * The memory devices use the full 32/64 bits of the offset, and so we cannot
@@ -569,8 +569,8 @@ static const struct file_operations flash_fops =
 {
 	.owner		= THIS_MODULE,
 	.llseek		= flash_llseek,
-	.read		= flash_read,
-	.write		= flash_write,
+	.read_iter	= flash_read,
+	.write_iter	= flash_write_iter,
 	.unlocked_ioctl	= flash_ioctl,
 };
 
-- 
2.43.0


