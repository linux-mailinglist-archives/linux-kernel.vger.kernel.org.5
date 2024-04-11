Return-Path: <linux-kernel+bounces-141057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D8C8A1ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B3AB30D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880991D2145;
	Thu, 11 Apr 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jmfoVQB2"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4A15535B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849973; cv=none; b=NcJmRg6frFjD+Sy+daNZVZsn4Pcon4fFhn4Dsa9O0GipDRWrTfV5mThNVtoaVQi+hLpcSAAAWcEiM3pF0CYRRZVft+b0RvTahQabYaDWfia1ahEkkOrvkzbqlxwwSAdN6rJ6lxqciOB29JZ+gU4kAbuN+XTSw2UkLjwlQhLkNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849973; c=relaxed/simple;
	bh=kBOG6gh9L+YlXUEO5PvC5HwNjQ+tJN1HQ2raep5WTkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0e3t/ge5CZW2AS39c/fOUOSNoYc9+atSUwOQleQAvvem7/Fy7NM+QHyNscw3qOEHaaTGXlRDGygGitgerJxM+IatTffSWebOGSSnrQuPHagGRpN1FTUHoryMOGpSsNjDJ2ZbwAxVO0zOSSonXXJ/FZKWbkoPGrKxGyUlrd4L1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jmfoVQB2; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69635839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849969; x=1713454769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyiv3PYk9uivp8uRbPKfheMtxKLuVXL7eV2fO7HBsks=;
        b=jmfoVQB2l7npa+vChySWBlEM7k9h/jRMrg3OL++SemkaaPhXopomw2KYADHoOuE688
         yBjtb8szD28w05ikvOzt2v2720i+kMJWKXhFxF2dqo6LygiHIbyP9a/s1U4C/AXF0wQc
         JPWh75ul5gWCi3ApwZD/YEyripLBCTJAJSdkYFKVK7uKJXZQ11zGxYnm/lL78z3csCsE
         FxDawscqYeSX0/E9TGztT7jjec5Cr9HklhTCFpfxkNcUjoUofdbIAO6NoLD1l2HSDsZ3
         bjIHevRakpBMW4XhMDW0Bl4mb8LtI4U49O753G5eCOzMWRQeYXiDXo3PmbXfmZpQusW8
         LdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849969; x=1713454769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyiv3PYk9uivp8uRbPKfheMtxKLuVXL7eV2fO7HBsks=;
        b=akGMd67fkZgXjGIrEO8vI4fKiVK37z1JYxA3V4akQzviKOR6sSDMcuiT82fwz8s4rq
         Xqif3BXKjtEmYowPWHe1vAudNoNk8WJtoLSXfxHA+QE//oY/RDrGaET5OTjHWOBkbfH4
         CoapP51ct8gAQNHQ41NDkHID/6fjwmRAmWMieeTwqn7kr8KvzFvrRw2AW84d9uYTYV9M
         2aGMfZIVnoqyYbLbvyUMPVS/xyM03sGBNRVL/M7xvkWzSOLsxKA9X8KjRwZNc10k3nQI
         o0VtVcITd8Ztq+G9zdNT8MVNLuI6xsFg/jFi68vrsQn5uYDLWf1Ti9yj6BnyO1c1k9Ky
         kWEg==
X-Gm-Message-State: AOJu0YxBEBX9vYd8Vw7gA1nUyJaoevGNue9T46ouZqwhjIWRngIf2KG9
	KvAQxj5quEQVvXlHta4ePcxnwiAKUHwhb+UZnrkfRxMJI30ctDUTe7eik94tHCOCd8L9oRPUCog
	h
X-Google-Smtp-Source: AGHT+IHnHqHFdbaYWaxk1fQBzMyd2DbudQT1Wh4gn2HLzuhQ7Cs4H7PH0h48GZ0QDr0OdZw8jfahzg==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr227452iof.0.1712849969399;
        Thu, 11 Apr 2024 08:39:29 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 283/437] fs/binfmt_misc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:03 -0600
Message-ID: <20240411153126.16201-284-axboe@kernel.dk>
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
 fs/binfmt_misc.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 68fa225f89e5..f44b626c4df7 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -734,10 +734,9 @@ static void remove_binfmt_handler(struct binfmt_misc *misc, Node *e)
 
 /* /<entry> */
 
-static ssize_t
-bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+static ssize_t bm_entry_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	Node *e = file_inode(file)->i_private;
+	Node *e = file_inode(iocb->ki_filp)->i_private;
 	ssize_t res;
 	char *page;
 
@@ -747,7 +746,7 @@ bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 
 	entry_status(e, page);
 
-	res = simple_read_from_buffer(buf, nbytes, ppos, page, strlen(page));
+	res = simple_copy_to_iter(page, &iocb->ki_pos, strlen(page), to);
 
 	free_page((unsigned long) page);
 	return res;
@@ -794,10 +793,11 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(bm_entry_write);
 
 static const struct file_operations bm_entry_operations = {
-	.read		= bm_entry_read,
-	.write		= bm_entry_write,
+	.read_iter	= bm_entry_read,
+	.write_iter	= bm_entry_write_iter,
 	.llseek		= default_llseek,
 };
 
@@ -882,23 +882,23 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	}
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(bm_register_write);
 
 static const struct file_operations bm_register_operations = {
-	.write		= bm_register_write,
+	.write_iter	= bm_register_write_iter,
 	.llseek		= noop_llseek,
 };
 
 /* /status */
 
-static ssize_t
-bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+static ssize_t bm_status_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct binfmt_misc *misc;
 	char *s;
 
-	misc = i_binfmt_misc(file_inode(file));
+	misc = i_binfmt_misc(file_inode(iocb->ki_filp));
 	s = misc->enabled ? "enabled\n" : "disabled\n";
-	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
+	return simple_copy_to_iter(s, &iocb->ki_pos, strlen(s), to);
 }
 
 static ssize_t bm_status_write(struct file *file, const char __user *buffer,
@@ -944,10 +944,11 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(bm_status_write);
 
 static const struct file_operations bm_status_operations = {
-	.read		= bm_status_read,
-	.write		= bm_status_write,
+	.read_iter	= bm_status_read,
+	.write_iter	= bm_status_write_iter,
 	.llseek		= default_llseek,
 };
 
-- 
2.43.0


