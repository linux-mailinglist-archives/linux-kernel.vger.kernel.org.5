Return-Path: <linux-kernel+bounces-140781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4CA8A18EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354DA2863E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23634D9F6;
	Thu, 11 Apr 2024 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lhCySkFl"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE054AEE4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849531; cv=none; b=WrpS7qGQg2Z7ulN2TJBwvmZtSsFOH4WXVQcePZcT3YtsirCjgEIJwfN711FF/M28dhAfEGTv6EEdq70GQ93ELIg1zurxGDS999Th7+X4WfcMMTRpN8Zod7+yLjLnw8JQby7ItPY6t5WDk+y7/zJ7nWp/Cd6yS5aR+5VIwX240uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849531; c=relaxed/simple;
	bh=V4OjKlhW+1r1w596hsTLaY2KUU1d/5CE0khjue5wnpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDoTMUV/FTPouHT6atyodb7rG1rDl6OYwbVTjNQCnZIBs7/THR0a0AdustvKbyXX+WxzTrQ+iZ8mwv0kFSvfXOW2rv4iMXcn5+VVl8LYWR5ULhvvgeS1CSKJgSo0Ul921xOYINZowqNY0/MZLX91JlqmYhTFIQFmJzIzwvs5OPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lhCySkFl; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170420139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849529; x=1713454329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHGMPVjYkcCZSLtyI9o+5xRAMWVV6AJ4ug8MxTGe0WM=;
        b=lhCySkFlOXPnFPCbduLNeqNOQZrj23LFJtHXdbn3m9wk67dWmkhsFs0y/woxEWO4s1
         jtF+51Z+m6vyaBbM8ZBOPzGM/Hlw6QZNOOqB9bBuNOqKXwzE82ZZD8AUcC5UUxoO4vUa
         RZLAwzj/3ONNpt1bzPj3gJ21NGhwrQZmfE08W5dEZw36eLfb9Wb9xVC6/M7f7v0bl/zs
         eejeTMyzK7m5jgrjiO9T8fp6iFcK07wwQWqBryhcb/OQS6k7wwYFjtzLhGHCIV48jHmu
         6aJMwY81H5oTMsHoj8zY06nwMPDdRCifYhb4LFwyMAX2/62bWXuh4Yg/Yv8f/xpf7VYO
         jDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849529; x=1713454329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHGMPVjYkcCZSLtyI9o+5xRAMWVV6AJ4ug8MxTGe0WM=;
        b=Te/VeJNqlvDeB2wllB/wnCEWAcgVB0XfEXofMaG1Hcjqb6VBPmDdUDcVnn/zONmx1D
         PaqC5ecuA87qbenX0wto+3lPPGFqLFkb1Rwg80k4TFH9h4ZeD7fXhzCNa0zCeses6upo
         2PCCxFYyH2RtK4UuCyznzl46AkkStdUIId/qhfdEdwOWO8DStzL0MhMq87R55Leywqc6
         66Zt5g0RlRf6651jY0JyOt34E+PD/P8LgFugjZPw1OkEpomcghgwJbnK1KT5Rw8yxRXt
         Yaz/x3o/UcnQB/inHl9Lvarfy+gQ93/HR/9hW50AwGPdXTpq3fzazVBq9LQZwBXNKBVX
         CQbg==
X-Gm-Message-State: AOJu0YzI2gmUC84mOjvYjloOwFWXKKGtLKwyaocCoXB5FTy13++9AtRG
	+M0wvy3UOoz/QobAo2R4r6m+0yYgQQlssjjgc0CLWDRU/2cBima/V+bcI1Kmw6oohlx1pmnM7P2
	c
X-Google-Smtp-Source: AGHT+IG4nApm7JmA7yhgIWAnTjLoKu5kVDNGDNRK7JpOsywQJdhM+Ao2jS30cAsWY6H1h1QKuNP+cg==
X-Received: by 2002:a05:6e02:b26:b0:368:974b:f7c7 with SMTP id e6-20020a056e020b2600b00368974bf7c7mr7608037ilu.0.1712849529182;
        Thu, 11 Apr 2024 08:32:09 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 024/437] char/mem: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:44 -0600
Message-ID: <20240411153126.16201-25-axboe@kernel.dk>
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
 drivers/char/mem.c | 106 ++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 79 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 3c6670cf905f..00ab09ad98e6 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -183,16 +183,17 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 	kfree(bounce);
 	return err;
 }
+FOPS_READ_ITER_HELPER(read_mem);
 
-static ssize_t write_mem(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t write_mem(struct kiocb *iocb, struct iov_iter *from)
 {
-	phys_addr_t p = *ppos;
+	size_t count = iov_iter_count(from);
+	phys_addr_t p = iocb->ki_pos;
 	ssize_t written, sz;
 	unsigned long copied;
 	void *ptr;
 
-	if (p != *ppos)
+	if (p != iocb->ki_pos)
 		return -EFBIG;
 
 	if (!valid_phys_addr_range(p, count))
@@ -235,7 +236,7 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 				return -EFAULT;
 			}
 
-			copied = copy_from_user(ptr, buf, sz);
+			copied = copy_from_iter(ptr, sz, from);
 			unxlate_dev_mem_ptr(p, ptr);
 			if (copied) {
 				written += sz - copied;
@@ -245,7 +246,6 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 			}
 		}
 
-		buf += sz;
 		p += sz;
 		count -= sz;
 		written += sz;
@@ -253,7 +253,7 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 			break;
 	}
 
-	*ppos += written;
+	iocb->ki_pos += written;
 	return written;
 }
 
@@ -383,58 +383,39 @@ static int mmap_mem(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
-static ssize_t read_port(struct file *file, char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t read_port(struct kiocb *iocb, struct iov_iter *to)
 {
-	unsigned long i = *ppos;
-	char __user *tmp = buf;
+	unsigned long i = iocb->ki_pos, org_i = i;
+	size_t count = iov_iter_count(to);
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
 	while (count-- > 0 && i < 65536) {
-		if (__put_user(inb(i), tmp) < 0)
+		char val = inb(i);
+		if (put_iter(val, to))
 			return -EFAULT;
 		i++;
-		tmp++;
 	}
-	*ppos = i;
-	return tmp-buf;
+	iocb->ki_pos = i;
+	return i - org_i;
 }
 
-static ssize_t write_port(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
+static ssize_t write_port(struct kiocb *iocb, struct iov_iter *from)
 {
-	unsigned long i = *ppos;
-	const char __user *tmp = buf;
+	unsigned long i = iocb->ki_pos, org_i = i;
+	size_t count = iov_iter_count(from);
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
 	while (count-- > 0 && i < 65536) {
 		char c;
 
-		if (__get_user(c, tmp)) {
-			if (tmp > buf)
+		if (get_iter(c, from)) {
+			if (i != org_i)
 				break;
 			return -EFAULT;
 		}
 		outb(c, i);
 		i++;
-		tmp++;
 	}
-	*ppos = i;
-	return tmp-buf;
-}
-
-static ssize_t read_null(struct file *file, char __user *buf,
-			 size_t count, loff_t *ppos)
-{
-	return 0;
-}
-
-static ssize_t write_null(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
-{
-	return count;
+	iocb->ki_pos = i;
+	return i - org_i;
 }
 
 static ssize_t read_iter_null(struct kiocb *iocb, struct iov_iter *to)
@@ -490,33 +471,6 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
 	return written;
 }
 
-static ssize_t read_zero(struct file *file, char __user *buf,
-			 size_t count, loff_t *ppos)
-{
-	size_t cleared = 0;
-
-	while (count) {
-		size_t chunk = min_t(size_t, count, PAGE_SIZE);
-		size_t left;
-
-		left = clear_user(buf + cleared, chunk);
-		if (unlikely(left)) {
-			cleared += (chunk - left);
-			if (!cleared)
-				return -EFAULT;
-			break;
-		}
-		cleared += chunk;
-		count -= chunk;
-
-		if (signal_pending(current))
-			break;
-		cond_resched();
-	}
-
-	return cleared;
-}
-
 static int mmap_zero(struct file *file, struct vm_area_struct *vma)
 {
 #ifndef CONFIG_MMU
@@ -550,8 +504,7 @@ static unsigned long get_unmapped_area_zero(struct file *file,
 #endif
 }
 
-static ssize_t write_full(struct file *file, const char __user *buf,
-			  size_t count, loff_t *ppos)
+static ssize_t write_full_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	return -ENOSPC;
 }
@@ -626,15 +579,14 @@ static int open_port(struct inode *inode, struct file *filp)
 
 #define zero_lseek	null_lseek
 #define full_lseek      null_lseek
-#define write_zero	write_null
 #define write_iter_zero	write_iter_null
 #define splice_write_zero	splice_write_null
 #define open_mem	open_port
 
 static const struct file_operations __maybe_unused mem_fops = {
 	.llseek		= memory_lseek,
-	.read		= read_mem,
-	.write		= write_mem,
+	.read_iter	= read_mem_iter,
+	.write_iter	= write_mem,
 	.mmap		= mmap_mem,
 	.open		= open_mem,
 #ifndef CONFIG_MMU
@@ -645,8 +597,6 @@ static const struct file_operations __maybe_unused mem_fops = {
 
 static const struct file_operations null_fops = {
 	.llseek		= null_lseek,
-	.read		= read_null,
-	.write		= write_null,
 	.read_iter	= read_iter_null,
 	.write_iter	= write_iter_null,
 	.splice_write	= splice_write_null,
@@ -655,16 +605,14 @@ static const struct file_operations null_fops = {
 
 static const struct file_operations __maybe_unused port_fops = {
 	.llseek		= memory_lseek,
-	.read		= read_port,
-	.write		= write_port,
+	.read_iter	= read_port,
+	.write_iter	= write_port,
 	.open		= open_port,
 };
 
 static const struct file_operations zero_fops = {
 	.llseek		= zero_lseek,
-	.write		= write_zero,
 	.read_iter	= read_iter_zero,
-	.read		= read_zero,
 	.write_iter	= write_iter_zero,
 	.splice_read	= copy_splice_read,
 	.splice_write	= splice_write_zero,
@@ -678,7 +626,7 @@ static const struct file_operations zero_fops = {
 static const struct file_operations full_fops = {
 	.llseek		= full_lseek,
 	.read_iter	= read_iter_zero,
-	.write		= write_full,
+	.write_iter	= write_full_iter,
 	.splice_read	= copy_splice_read,
 };
 
-- 
2.43.0


