Return-Path: <linux-kernel+bounces-141138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD58A1AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0123D1C2389E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC41ECE79;
	Thu, 11 Apr 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xh+7a57D"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06755167A55
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850104; cv=none; b=bniRaiE55w47ulP/XZBfYvWCushB7odzvmfcccsSWEZMWuG3txT5h4dhHO6YQMZrDqOTQuud7XVcbShhLz1w0uTj8i4XLqSdzY8M/Blz2ZS/6h3MNqHKcHQ3gSJ+TOR1op7VsJ6ylzR13OsiR5QeTvjVCta+42p6QcX8OqrpNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850104; c=relaxed/simple;
	bh=EU0m+GYx750B5TEfB114nPOm0jKAAEysLyRXLk1OWKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHuB87BfW8GpjgbBg4d6gfA79HeF7rN0W9T0oEYmz/7aJmg/h7aj+h+ETDDuts5CPt3DoCDsRjvaBk2uGqTOwv4YP2EyNN8G4cVPH6z92nGEW2zt/P8gPkpYDT0+4ZjouJSCkyxXnD+RM0ni1c6nYy/8KTGYq1tQQfP2MK5DhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xh+7a57D; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170635639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850102; x=1713454902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUwnBOIHWTDqxRA7ju6azON0mNBRNg9CJwY1xMY9Hh4=;
        b=xh+7a57DDm7wRyS95LT3a+SC1utocvGcUn8/pnGzm3QSosmq47L5g/Oi6/ULmh2SzB
         b9vTyeDOUOxHIDF6VW3CtnVg2BCkHbBDrK7VnTiUU6FB5YZrplf+V/8EbAukolr2/BI+
         f5B2OT9yoyRCfoZem9gKWBjvbPvUmq4i6TJLPxn8W3H20sMcrC1YHdgnYJpQLcqJDjk8
         ffBBVEcIjzTfg4KvID00cukRjt/ABrpZ2+2AHjR40+CWDOUb6670iIfQ5otWFb4frqMb
         0Id+lizfpZsJVFwVTzqpDHZVM8rczgnc4LwC5AVsQ2h/WLuT+o580kx7OdpP4fKKqfqn
         IOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850102; x=1713454902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUwnBOIHWTDqxRA7ju6azON0mNBRNg9CJwY1xMY9Hh4=;
        b=d2CYnB9A53M8p1OatWmJo1AkUMRncuAGctt8kMV4xYXAGwGQ685bxKnO5GOL2Ug6NW
         Xm1MSPsQ1Xm1BRuaPPT7XIT31IgNtICFzXuCWzGcfJeTNsrJ67epaXum5zFbQQvzQt/Y
         5SqKfs5pDAV0SS9Ef1sUFpGf9X0kJ8W7K2tHA9AiG1DOQ5VCQbdJKXW9uBpMtK9+2qvU
         DN0Wx945KWTW/NYD0dReuiRdvT7klL32Z3NWG5Z2Nf4AqWZS0epT4S+2HZ0eLAXdtLBz
         F5wzW9tbd8aDAyTLjcdzBM5eV5/oILmaGjzcvfxjqn5KP3BZrz5ATtHGh+0Z4LLp5LxN
         Xe9g==
X-Gm-Message-State: AOJu0Ywtk/J2x8OPuRYw+4+iD9NIiCiBm4kZzUjIKs9WoU26xNamO1YP
	+wJv9vK9/XhrE+R9KQVkC6MTOi7y2roNh9y8xUjjwzdCsCwq9a9rhI3tpBxpUW2hiNr+eJZ0tF5
	c
X-Google-Smtp-Source: AGHT+IFQ/wL3w9aBvPhHTTMmWkVdXQDaNzeLPv/PfBVzZdwDvWnXNYO5iWTDkp3BQDF1237TfAqJVw==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr236714ioh.0.1712850102076;
        Thu, 11 Apr 2024 08:41:42 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 359/437] hwmon: w83793: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:19 -0600
Message-ID: <20240411153126.16201-360-axboe@kernel.dk>
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
 drivers/hwmon/w83793.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 96bab94ba899..7594fc588112 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1352,11 +1352,11 @@ static int watchdog_close(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t watchdog_write(struct file *filp, const char __user *buf,
-	size_t count, loff_t *offset)
+static ssize_t watchdog_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	ssize_t ret;
-	struct w83793_data *data = filp->private_data;
+	struct w83793_data *data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
 	if (count) {
 		if (!nowayout) {
@@ -1367,7 +1367,7 @@ static ssize_t watchdog_write(struct file *filp, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					data->watchdog_expect_close = 1;
@@ -1454,7 +1454,7 @@ static const struct file_operations watchdog_fops = {
 	.llseek = no_llseek,
 	.open = watchdog_open,
 	.release = watchdog_close,
-	.write = watchdog_write,
+	.write_iter = watchdog_write,
 	.unlocked_ioctl = watchdog_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 };
-- 
2.43.0


