Return-Path: <linux-kernel+bounces-141049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ADC8A1A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343A61F21A27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB97415487F;
	Thu, 11 Apr 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VN9UOzMH"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8781CFD26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849959; cv=none; b=ULamtzNwiO6CAsBrOLBzug5nJNlBXtLHJ71bENw0SsR+VXzv6dU56FWCzDtPyUS3D/gp/chqf4AdblHSZGqTsj5RvPkOmL8OKDNv+0xUjaa/Oes6RAT343jdX64j8Dopa2i2Li1nWj0VXvvJrd72wNpKoZKpG21/iFexlZGmLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849959; c=relaxed/simple;
	bh=K1SKuLbLHQ+XjjGUNFAADcDccp7tMugiM2fba9f7wU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suQ4KLmQW48EfXYbXoEGnA+Pr8enBWPwX8fU7l00gI38/kUByZYi/V9p4FBvPpfLQ5ZfsG5jrw2lkVfPZuEjBuLXBHpb0Uec48Vnn/DV+VnU6ToFreni88bmYR4FKINphGCfeUhFaXeiLtsoidsWlBJtV92Rfrs4X2NLaJPjcLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VN9UOzMH; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16209839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849956; x=1713454756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AqxnqBVB6hfcyjEvePFFAZPh9dtkk1FAtMabuM1LjE=;
        b=VN9UOzMHtIq7zpKE9CKM5wvUkIp5UIgdGO0fIEGSO+gxjFWF6LPndmHPIwQwbBHSCQ
         oE7jgPXihDGlCy4gscAmT44nPbOqJhjt8MMrg5b919hF0UzUjG5mBhGqiScOTFPQK9/+
         0icxRsFz6/zLG2yd8BhdwRfQ+JbSe8ZIJe4dkgdb1DBkDbcQsRytCxKXeqima9GmSzqF
         gXgpi1Lm1wHcCq5Jlrc4erkWv0LVkdM24PPYyTd0I0D/9wJou7+GDp7yWWmd+dFFom50
         UuNvxIELSgGndUjWV81APLGkqRAOOPceX2SwllmFUO4dRQ8jMHNnGRhcAmJQhUwhWhes
         23DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849956; x=1713454756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AqxnqBVB6hfcyjEvePFFAZPh9dtkk1FAtMabuM1LjE=;
        b=dsFp51HYGq8RW2UoRnBnQxgLyGtblVpuWf2KNBZahVzStErmkpllTNXKAVf3sOhywI
         3skItMZ1OLDzErgkb9anHEP0cTCQXUpAR/UzvYGEoR5QdOWAA+PKp+bwCTS92W2uHc2H
         +6WlYD+JuaXAZNG+cCgBqw7/7R9Dw003RlH09wGAfKbtDwY1BLK7DUl2YbdRb/8AyzPm
         924SqM7EXr10LdRhR0aK3dSzpk/xlvpTgmX4L7Q+6mreOCSDNPcPxx4UvF6p6mE0KTGs
         hTRpbq1FkzOrnO1ULCuYQQ7gjiN/SDsueGwzG8yLHL+gylRTIyYPBnmjEdoRhGjSGgcr
         4TLA==
X-Gm-Message-State: AOJu0YyhjNWYB3+fLHoJmxw8Ubw8HJKLi4OdcZ+IbTngZu44o66VI9yw
	XSL9QTU33PA8+e8uN50/6sRWFHknFd6DsynHfsBS5nBnr2PljXjN4CwZuXVDR2aA9OfwXJXrBoo
	g
X-Google-Smtp-Source: AGHT+IHDKM5qIfJDmpu0WJZzabsxJ8A2uCgkqV8BOAxeejDkyUdkfIuVmlH7f2nM6tHqQ7d21e9i1g==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr169561ioh.1.1712849956616;
        Thu, 11 Apr 2024 08:39:16 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 275/437] watchdog: sb_wdog: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:55 -0600
Message-ID: <20240411153126.16201-276-axboe@kernel.dk>
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
 drivers/watchdog/sb_wdog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
index 504be461f992..cb1123b7bdbf 100644
--- a/drivers/watchdog/sb_wdog.c
+++ b/drivers/watchdog/sb_wdog.c
@@ -141,9 +141,9 @@ static int sbwdog_release(struct inode *inode, struct file *file)
 /*
  * 42 - the answer
  */
-static ssize_t sbwdog_write(struct file *file, const char __user *data,
-			size_t len, loff_t *ppos)
+static ssize_t sbwdog_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	int i;
 
 	if (len) {
@@ -155,7 +155,7 @@ static ssize_t sbwdog_write(struct file *file, const char __user *data,
 		for (i = 0; i != len; i++) {
 			char c;
 
-			if (get_user(c, data + i))
+			if (get_iter(c, from))
 				return -EFAULT;
 			if (c == 'V')
 				expect_close = 42;
@@ -235,7 +235,7 @@ static int sbwdog_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations sbwdog_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= sbwdog_write,
+	.write_iter	= sbwdog_write,
 	.unlocked_ioctl	= sbwdog_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= sbwdog_open,
-- 
2.43.0


