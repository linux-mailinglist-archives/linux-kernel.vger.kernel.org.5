Return-Path: <linux-kernel+bounces-140986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9928A19EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76046282B42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFAF1BED79;
	Thu, 11 Apr 2024 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DOMfSM0d"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0A1BE418
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849863; cv=none; b=mhMpK0k+3qwcdsTzRUVJNr8RdT3DG7a9ah9gFZ4EaHJJ78u0pMrxCH5LZN85vZ0wiVJ8XTLFhZRTqmvMyMIIUCrUc7ojph2ieHVCXlZgDDYMaVDJ+SP0v/v4x3Wc+F5Z486jHzHpg5FvmenaycOsMvYUccLvZ4rQws4p/bTccpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849863; c=relaxed/simple;
	bh=b8fBtgiZiqGJZMi5lYFhAdirVPCXkwCkZCiHBhjnpKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/E/LhmsyQKg8uYlqkRQfGtwDIpmAXArj60jlHdR3Uhuxh8MQTsknWVzLevA/2jYyeMSBcC12fhnoIvXQreACAynUqrYN907ZDRerf3oKJU8jDFhp51j4Q3lyThmHnabBs0i+g0A2Imy7qtjm1UYqG55+daQ5u7eVIXADkxuCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DOMfSM0d; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58109239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849861; x=1713454661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FyqLSYmWmwJxpm8RitgJ8rY2UKti8lQVAXLtysgzwI=;
        b=DOMfSM0d9YWlEQDz4Oa+utjVjIXvsHJ758WskB605NoBkEbWOAIGQ73RmIR5+RRLco
         a9bFlYoQrKev+XP4ivx7mFdYkVTFRwuf8hUul61Fx5QggQ3EQLqXvBbPYMeqX+nmcZUU
         GOMJYF4rqnAivuXUNKocmVmRFkXH6CFeSY1ylcBOqzgDLm1+or8gRy00qE9HuIATwK2r
         tlKObKjah3RPOEGLAWz4CYyQ8hY0UM4wSVs6D+xErDzCos+C7tNRQlfkPLfEWbzUPE/t
         l5fePqusQpdo2SCxDRddnXLUWY/Xd994m6V+GXmRjb0nYnOD17770DvSZ5uuiTrFqeYP
         JH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849861; x=1713454661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FyqLSYmWmwJxpm8RitgJ8rY2UKti8lQVAXLtysgzwI=;
        b=Sg+KM4QkCOvLBm2/pbhAkOZpPTKuA2bY3Qj9ATjamyfHmQvxGD8HsMAaIYcd44+LuJ
         NprEWtDCgTOGmY6kgF+uPJ/wDenLNB9HCgWhkUxdSH8JjsjF9ZatdmAKwN8xaFzAyl3j
         PipAl9/E2zGjZuoJ73os4zSiZ1poy+aYRKTLGQug1GVfMs/EaWPMNEwUveoHIZBXwpza
         +ZzM4iGhl9Y3CYOw1DrhC45oe2GZYn46NctyfAwI1TBc2T2rPG+C46/hKPMRzZR5iHhU
         Et8Q3g5eohCTN+MhQPqphsTGvlmPWQ89PK1OdL+T5SIULURMokyplD5vFG4UtDgmuqWb
         blPA==
X-Gm-Message-State: AOJu0Yymv2xpj+9luXPhZgLEhkJ+QGj4iibowS0j0s/mKEb0iFjouglQ
	cQKHdPbmPMCk+xXhwdZtdjG0aEywMdhND0/VTzN6G4m1BXy+Rdlt12gK5fwRmeGVdNVfP8Sxcrl
	E
X-Google-Smtp-Source: AGHT+IF0y7qbQbSe1fj9uYpj2j+i794cOX9/VCudphc1XHGTQq40b4cfW70Y89FIB9QO2cYwhxF92A==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr189457iov.2.1712849861103;
        Thu, 11 Apr 2024 08:37:41 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 216/437] misc: lkdtm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:56 -0600
Message-ID: <20240411153126.16201-217-axboe@kernel.dk>
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
 drivers/misc/lkdtm/core.c | 40 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 5732fd59a227..12f02713f39c 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -27,20 +27,17 @@
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 #include <linux/utsname.h>
+#include <linux/uio.h>
 
 #define DEFAULT_COUNT 10
 
 static int lkdtm_debugfs_open(struct inode *inode, struct file *file);
-static ssize_t lkdtm_debugfs_read(struct file *f, char __user *user_buf,
-		size_t count, loff_t *off);
-static ssize_t direct_entry(struct file *f, const char __user *user_buf,
-			    size_t count, loff_t *off);
+static ssize_t lkdtm_debugfs_read(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t direct_entry(struct kiocb *iocb, struct iov_iter *from);
 
 #ifdef CONFIG_KPROBES
 static int lkdtm_kprobe_handler(struct kprobe *kp, struct pt_regs *regs);
-static ssize_t lkdtm_debugfs_entry(struct file *f,
-				   const char __user *user_buf,
-				   size_t count, loff_t *off);
+static ssize_t lkdtm_debugfs_entry(struct kiocb *iocb, struct iov_iter *from);
 # define CRASHPOINT_KPROBE(_symbol)				\
 		.kprobe = {					\
 			.symbol_name = (_symbol),		\
@@ -64,10 +61,10 @@ struct crashpoint {
 	{							\
 		.name = _name,					\
 		.fops = {					\
-			.read	= lkdtm_debugfs_read,		\
+			.read_iter= lkdtm_debugfs_read,		\
 			.llseek	= generic_file_llseek,		\
 			.open	= lkdtm_debugfs_open,		\
-			.write	= CRASHPOINT_WRITE(_symbol)	\
+			.write_iter = CRASHPOINT_WRITE(_symbol)	\
 		},						\
 		CRASHPOINT_KPROBE(_symbol)			\
 	}
@@ -224,12 +221,11 @@ static int lkdtm_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
 	return 0;
 }
 
-static ssize_t lkdtm_debugfs_entry(struct file *f,
-				   const char __user *user_buf,
-				   size_t count, loff_t *off)
+static ssize_t lkdtm_debugfs_entry(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct crashpoint *crashpoint = file_inode(f)->i_private;
+	struct crashpoint *crashpoint = file_inode(iocb->ki_filp)->i_private;
 	const struct crashtype *crashtype = NULL;
+	size_t count = iov_iter_count(from);
 	char *buf;
 	int err;
 
@@ -239,7 +235,7 @@ static ssize_t lkdtm_debugfs_entry(struct file *f,
 	buf = (char *)__get_free_page(GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	if (copy_from_user(buf, user_buf, count)) {
+	if (!copy_from_iter_full(buf, count, from)) {
 		free_page((unsigned long) buf);
 		return -EFAULT;
 	}
@@ -257,15 +253,14 @@ static ssize_t lkdtm_debugfs_entry(struct file *f,
 	if (err < 0)
 		return err;
 
-	*off += count;
+	iocb->ki_pos += count;
 
 	return count;
 }
 #endif
 
 /* Generic read callback that just prints out the available crash types */
-static ssize_t lkdtm_debugfs_read(struct file *f, char __user *user_buf,
-		size_t count, loff_t *off)
+static ssize_t lkdtm_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int n, cat, idx;
 	ssize_t out;
@@ -288,8 +283,7 @@ static ssize_t lkdtm_debugfs_read(struct file *f, char __user *user_buf,
 	}
 	buf[n] = '\0';
 
-	out = simple_read_from_buffer(user_buf, count, off,
-				      buf, n);
+	out = simple_copy_to_iter(buf, &iocb->ki_pos, n, to);
 	free_page((unsigned long) buf);
 
 	return out;
@@ -301,10 +295,10 @@ static int lkdtm_debugfs_open(struct inode *inode, struct file *file)
 }
 
 /* Special entry to just crash directly. Available without KPROBEs */
-static ssize_t direct_entry(struct file *f, const char __user *user_buf,
-		size_t count, loff_t *off)
+static ssize_t direct_entry(struct kiocb *iocb, struct iov_iter *from)
 {
 	const struct crashtype *crashtype;
+	size_t count = iov_iter_count(from);
 	char *buf;
 	int err;
 
@@ -316,7 +310,7 @@ static ssize_t direct_entry(struct file *f, const char __user *user_buf,
 	buf = (char *)__get_free_page(GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	if (copy_from_user(buf, user_buf, count)) {
+	if (!copy_from_iter_full(buf, count, from)) {
 		free_page((unsigned long) buf);
 		return -EFAULT;
 	}
@@ -331,7 +325,7 @@ static ssize_t direct_entry(struct file *f, const char __user *user_buf,
 
 	pr_info("Performing direct entry %s\n", crashtype->name);
 	err = lkdtm_do_action(crashtype);
-	*off += count;
+	iocb->ki_pos += count;
 
 	if (err)
 		return err;
-- 
2.43.0


