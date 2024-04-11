Return-Path: <linux-kernel+bounces-140843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6D68A192C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA5D1C2178F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C813340B;
	Thu, 11 Apr 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FhRNiyJc"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084113280D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849643; cv=none; b=eq0BB5e0E52RwWFebtKu+RZi4lR7vLEclWJkLRpdjVCWM/4nEOlHxXlK8bjLnjF01iPQtAj1isxu6Br/bTc+VUBEYFeHOtuQd+CB+LUPcYzaEakjxvqxem3B+MPa+mveVO/vytSXaDTfZ5M5rObNQbM7+9QlWSWlWGa7ImKUBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849643; c=relaxed/simple;
	bh=wQcncLTvx9x0uslUSkx8ifDio14ylUYv78Cehqwdh6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcER4WbAhPBqIvUBeaXHLJxaEhHFC2CGMA5wbg1Gm1fj4cfXTZ6FYmf7mCnc75yyJ55sNnnfn6qP1MLVV3/BCv9/JVYnGVZvA/HvI38LYl3ecdn1WUdXdgkJDBaOINpVn2B3kT7DmJFzZ64in8oaHgZbsH0Kg0IeIwFUoMzkSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FhRNiyJc; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170469839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849641; x=1713454441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hXmLbaCqww99UA4BWGlx+u7paittu8zQHABuwDy1yM=;
        b=FhRNiyJcraYE/D3HsCEGxgJ8YzBKXniZrs1ZJQQWezGJeYb5efoR704HGCjftousn7
         PPS3QajumIWnQufqEs7DNda/LHNlfqwACBcKZFQ6QguNh8Gf35d1nVYhkDE+2y6k9EfV
         UDn+cX0vsh7ZwF9dgkwDXUr+mY/+xqlPVBaOX0NMhGm4qqylPsPmHMIxprLwiSJbE4Zl
         81RhwcWdEYhlcdV9B3Uty+jm0SEkbsJGyaGs5GYgf/UfXzCpMtSXyTvSIlpP70aQbPmG
         sQEPAp4EugNaYoH2fVJl0dRWsYJxvzLueBgb70XJb3HHMEgdNqF0yP10gcZzIPWkE6Ew
         b6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849641; x=1713454441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hXmLbaCqww99UA4BWGlx+u7paittu8zQHABuwDy1yM=;
        b=s/i+mIu/eaKAdgZy3AEOS6xRZ+3Q7sMfFR7D6m72meYMyXzsq7pV92ObK+DRNoCDsm
         wsUwRLa3O3WpRarsvma9p4HovVLNfd454EO7XrEu4hkSjcM5SsAlnzJeuyYNEEdhkUQI
         HGgb59WkdFogCVLeFZ1b1k9uIBkPf/ZdTkiFiiufl1Xdsn8BQKha/0gl7pOwjyzjLD6k
         O+uYrrdovodT4BZgOyYycz0bOGhzxdFtKqy0TIuDaR4KoE6LvcxhH6Xg5CRn11WJxgdC
         ve+RhpOEyjGKcOZPNwb8bk7TbJyQLHvihEt09KKvyicWLwqU9kBRJNPHKvN2qnYIzSZR
         Jdsw==
X-Gm-Message-State: AOJu0YwX+GgI34Pk7IT1YI9HLcQyAs9Wk9B6J3sOUQMk3qDHSYmVy395
	waH+h5EpW6vN0BtAt6xyfUEUSiv9i/pBXqxbq0MwU+10ZCKMXEE8YbFXaRqEEZv+cYUiUzryiRp
	p
X-Google-Smtp-Source: AGHT+IGWGHJOcely6hgFMppcuhj6Iz/a0f1IKao1Ot2VTAIA3l/lSXpLjkN0ZXBqTSNr66SlNGRIiw==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr175374ioj.2.1712849641128;
        Thu, 11 Apr 2024 08:34:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 082/437] sched/debug: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:42 -0600
Message-ID: <20240411153126.16201-83-axboe@kernel.dk>
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
 kernel/sched/debug.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 686a21ea1791..e1e7856727cb 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -120,26 +120,25 @@ static int sched_feat_set(char *cmp)
 	return 0;
 }
 
-static ssize_t
-sched_feat_write(struct file *filp, const char __user *ubuf,
-		size_t cnt, loff_t *ppos)
+static ssize_t sched_feat_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	char buf[64];
 	char *cmp;
 	int ret;
 	struct inode *inode;
+	size_t cnt = iov_iter_count(from);
 
 	if (cnt > 63)
 		cnt = 63;
 
-	if (copy_from_user(&buf, ubuf, cnt))
+	if (!copy_from_iter_full(&buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = 0;
 	cmp = strstrip(buf);
 
 	/* Ensure the static_key remains in a consistent state */
-	inode = file_inode(filp);
+	inode = file_inode(iocb->ki_filp);
 	cpus_read_lock();
 	inode_lock(inode);
 	ret = sched_feat_set(cmp);
@@ -148,7 +147,7 @@ sched_feat_write(struct file *filp, const char __user *ubuf,
 	if (ret < 0)
 		return ret;
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
@@ -160,24 +159,25 @@ static int sched_feat_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations sched_feat_fops = {
 	.open		= sched_feat_open,
-	.write		= sched_feat_write,
-	.read		= seq_read,
+	.write_iter	= sched_feat_write_iter,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
 
 #ifdef CONFIG_SMP
 
-static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
-				   size_t cnt, loff_t *ppos)
+static ssize_t sched_scaling_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
 {
+	size_t cnt = iov_iter_count(from);
 	char buf[16];
 	unsigned int scaling;
 
 	if (cnt > 15)
 		cnt = 15;
 
-	if (copy_from_user(&buf, ubuf, cnt))
+	if (!copy_from_iter_full(&buf, cnt, from))
 		return -EFAULT;
 	buf[cnt] = '\0';
 
@@ -191,7 +191,7 @@ static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
 	if (sched_update_scaling())
 		return -EINVAL;
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 	return cnt;
 }
 
@@ -208,8 +208,8 @@ static int sched_scaling_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations sched_scaling_fops = {
 	.open		= sched_scaling_open,
-	.write		= sched_scaling_write,
-	.read		= seq_read,
+	.write_iter	= sched_scaling_write_iter,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -218,16 +218,16 @@ static const struct file_operations sched_scaling_fops = {
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
-				   size_t cnt, loff_t *ppos)
+static ssize_t sched_dynamic_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t cnt = iov_iter_count(from);
 	char buf[16];
 	int mode;
 
 	if (cnt > 15)
 		cnt = 15;
 
-	if (copy_from_user(&buf, ubuf, cnt))
+	if (!copy_from_iter_full(&buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = 0;
@@ -237,7 +237,7 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 
 	sched_dynamic_update(mode);
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
@@ -270,8 +270,8 @@ static int sched_dynamic_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations sched_dynamic_fops = {
 	.open		= sched_dynamic_open,
-	.write		= sched_dynamic_write,
-	.read		= seq_read,
+	.write_iter	= sched_dynamic_write,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -327,7 +327,7 @@ static int sched_debug_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations sched_debug_fops = {
 	.open		= sched_debug_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -402,7 +402,7 @@ static int sd_flags_open(struct inode *inode, struct file *file)
 
 static const struct file_operations sd_flags_fops = {
 	.open		= sd_flags_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


