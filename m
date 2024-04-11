Return-Path: <linux-kernel+bounces-140849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623D18A196C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28030B2D6FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF828136E2C;
	Thu, 11 Apr 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MKQw8p5u"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FD136668
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849652; cv=none; b=a3AXDWGSMH/UUNP2Xropmdx2CT6DHYozDBIMaMpV1BZ5ZqacJfUqpdqRgpggbSYZZA4/9/QaJ0DPMHOyeZ0h15DThQwoMyPMOEqsspKpozSvJKdPfXEpmwEtDXqFa9tzoLAdP7taWGThaWkSme9qtQX9y0/YLuUy80TefYJcIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849652; c=relaxed/simple;
	bh=oTaDXFM2veSIyrNSg5ZwzsREHddfR59ebpLyhWZ1ke0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2+S+awASfo4F2lY8RXgeQWYExHtagnLxvlieCndVm0x+VSUz+zrQNGacOt1I14XUdee2IkF5lnT1PFEo1j5kcMuzXDk6qWDiNC0fpPaXdjnNFyiQ6j6lDLjzIj4iuVgrvGjxHuAEfRkP/QSnToZ4PnfCpp29GkwNeeiU1ihxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MKQw8p5u; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9749539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849649; x=1713454449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUMzmo7ip1drKjJbzrWPdbZGVRE9zIxWmxeF2eW3oUU=;
        b=MKQw8p5uX3wkTgee/Q+RwQCHdZOf75YHLV3Sr0pwyjKFNlqDOGKT6XOVhwqjMJtWMQ
         CUcKrjH3YAU2GstvLivuO6XWwdaNwWF4Gnay2wftaKDEVQOhlktvEc1vZXTMX2lSF3TE
         2eVPlFmaRPl7GkGV9MPNGSKv42NZG0JcMO4E8vB9YzTUxXUVBtxHjcQjDwjHlhlIQjlf
         /3m1R84OLZhVpdsFgiLWJVsYefXozBW2oGCepchjfmOitscNAFs1E31cDUp6DncLOcO/
         oxrB26ZhLx0DNNFgYIVObOFrbQkxFa1Fb19rWyohFL+J8pNm8zGqV3AZmjAhum+igtsO
         AUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849649; x=1713454449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUMzmo7ip1drKjJbzrWPdbZGVRE9zIxWmxeF2eW3oUU=;
        b=wdMrFHU3C/3qJm76WyL+3iofyIKAqyRxPp8omPbUkIIL7/DhsobQIXYjujowLBRG1h
         f5QqFt3B/kl5rl33qXEpOgzpL81Lr8Y7Fj4tv5De/hiDIJ/ixC5hr5NwaRNrjbGz8XrF
         jVI4ZbB/LlUZQfsrZuRyJGGR41BZBYo1gw9kP0Z3/jINxVWTPat2985kRylD4jCFy8VZ
         tGK97gn7aGdufq2uK266f9ckTEX/GOY/4dvGPSDcCsp1DpQr6MB/uAGL80+x9eqG8Fq3
         tsoStyxFRWr6F6U00VlUFYUDsxfOWhjwooFStmyHl9m85CaGZ4eCyCGjyAH5wLCmpAuf
         HyEg==
X-Gm-Message-State: AOJu0YyJFSA4UVKTmusk3vnYo7qDX5NUrb74JDwZgMxKdGMZoN4O1LyM
	lXpP0+lNDsDlLukeCJJ3ZliQtnEJKdiGuMAwObhD8Id58isvppHqR9i/fUU+ThynFmLq0Cqpaf+
	8
X-Google-Smtp-Source: AGHT+IG1x877YI2RFmKVhkdXI57Y7MyYyKNDrYr4StNLgdVVnDKXFcW8kAt0couhz/WCGirFg3JuPw==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr36569iob.2.1712849649515;
        Thu, 11 Apr 2024 08:34:09 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 087/437] tomoyo: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:47 -0600
Message-ID: <20240411153126.16201-88-axboe@kernel.dk>
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
 security/tomoyo/securityfs_if.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index a2705798476f..49421d5377f7 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -86,6 +86,7 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
 	kfree(data);
 	return error ? error : count;
 }
+FOPS_WRITE_ITER_HELPER(tomoyo_write_self);
 
 /**
  * tomoyo_read_self - read() for /sys/kernel/security/tomoyo/self_domain interface.
@@ -97,28 +98,28 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
  *
  * Returns read size on success, negative value otherwise.
  */
-static ssize_t tomoyo_read_self(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t tomoyo_read_self(struct kiocb *iocb, struct iov_iter *to)
 {
 	const char *domain = tomoyo_domain()->domainname->name;
+	size_t count = iov_iter_count(to);
 	loff_t len = strlen(domain);
-	loff_t pos = *ppos;
+	loff_t pos = iocb->ki_pos;
 
 	if (pos >= len || !count)
 		return 0;
 	len -= pos;
 	if (count < len)
 		len = count;
-	if (copy_to_user(buf, domain + pos, len))
+	if (copy_to_iter(domain + pos, len, to))
 		return -EFAULT;
-	*ppos += len;
+	iocb->ki_pos += len;
 	return len;
 }
 
 /* Operations for /sys/kernel/security/tomoyo/self_domain interface. */
 static const struct file_operations tomoyo_self_operations = {
-	.write = tomoyo_write_self,
-	.read  = tomoyo_read_self,
+	.write_iter = tomoyo_write_self_iter,
+	.read_iter  = tomoyo_read_self,
 };
 
 /**
@@ -178,6 +179,7 @@ static ssize_t tomoyo_read(struct file *file, char __user *buf, size_t count,
 {
 	return tomoyo_read_control(file->private_data, buf, count);
 }
+FOPS_READ_ITER_HELPER(tomoyo_read);
 
 /**
  * tomoyo_write - write() for /sys/kernel/security/tomoyo/ interface.
@@ -194,6 +196,7 @@ static ssize_t tomoyo_write(struct file *file, const char __user *buf,
 {
 	return tomoyo_write_control(file->private_data, buf, count);
 }
+FOPS_WRITE_ITER_HELPER(tomoyo_write);
 
 /*
  * tomoyo_operations is a "struct file_operations" which is used for handling
@@ -206,8 +209,8 @@ static const struct file_operations tomoyo_operations = {
 	.open    = tomoyo_open,
 	.release = tomoyo_release,
 	.poll    = tomoyo_poll,
-	.read    = tomoyo_read,
-	.write   = tomoyo_write,
+	.read_iter = tomoyo_read_iter,
+	.write_iter = tomoyo_write_iter,
 	.llseek  = noop_llseek,
 };
 
-- 
2.43.0


