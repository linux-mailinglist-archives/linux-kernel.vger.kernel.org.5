Return-Path: <linux-kernel+bounces-140840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2198A1929
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42DA1F21D97
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587E413248D;
	Thu, 11 Apr 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sRUbPuV3"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A76131756
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849639; cv=none; b=CAfrIKCGbReAz3Yz+fqSwwJW0qo2arpVRyG5FrRUonUn1CYxqZIXGLnZWppab+dRMl18OSMg//bbboEY2eI5sjDbJhKcFdBj682HjYCIZLfyppwIh4YIX2KscMl9lDli0RGWuKNBCL2Ez2ZgrK8oN2fzgR5pAvjVm6LRFXhyx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849639; c=relaxed/simple;
	bh=Zo/x26WS9n9rARO6znUcDnuZyVuHxycxEnyoGTvJz2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZ6tpD+Pzw2QEqgImbst/tmJuArln/IBO1nS6r1ZZvixjl5BudPBM19iXh/CkKC89iPfwNdSrmRyP7LOJIxrd9o2nSTNUEv+5FeEgrqQaYccTvSabTOzuEl5faX9QMO/QxWSP5KBtgM88/+mfgm8ev0XAP0xl3zkDcA5/lqCdcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sRUbPuV3; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9743539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849636; x=1713454436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmd8KmNNkkxHDALLgA03v64s0+v+FthfsPXOyGkj3lQ=;
        b=sRUbPuV3vv81WeqgeaT47S1YHJ8ZEeqSeQ37RqCLG5IK++qvuvMjZ+o/NfBJ9arsTt
         WM4JTeH3ZBV0yQSYQg+JqhV49X/9BTnIjZV7jtNQEj3H2+oicujfS3p+gMljHw+XRqEN
         uJ6SvHDETm49sCy3aaDY/MeR80NydmboPYTTuoq9MyEt49ZKog9ecPELNaF5j4K1WHrg
         r2PWKxoLcIO4UbImnxUwXfjwoeWQ6PNGL3fKdXoP1wHw3jaFo4celwXAP2AOVcBEphXF
         4KYHu73FFLyGIw+gExzutAM5dstSbYkFkgQGPI1TKDAil4BOMVkbj7MZOh+yU3TL4TTr
         KDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849637; x=1713454437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmd8KmNNkkxHDALLgA03v64s0+v+FthfsPXOyGkj3lQ=;
        b=N3nIWpIY31RrNLnYCbYQlOtWzB2ujtWYF+n1QU4WPik751Quzmd37/equJslwwXZ1S
         JmpTPK44Zg+zx4+8YCuDjXfHxcGORGm9A3DVdjcuqzPyneXy7k6Y3ZXDzCGne8VB22Ho
         jz5Ws8eWibP07L/pqW/H1aQZB1R1LYPBV1lTMHXQHU/YG+Tb4acEHBJsfJMYSC+xaEGB
         2u2+HTj4Hj0AHWUL20M9mj9QmdXdiHHIanmDD/zH0COiE45rH7+8eLJObxRUQIU8yT9P
         DTtEH7inZPParR/z2F0ydILQU5lHMln/RKLUvFbn8WDG5PBPqFX19r41sygCMORmrXOn
         0o2A==
X-Gm-Message-State: AOJu0YygKQTwdIGh1cyL0YMFV/8634LLUqa7fz/BFuyoVMk6zHixBX57
	Q+PBKjQ0ru7jVfdcJsxavkp3Y5jaBTrwId2h6C2g/NjEfC+Q5acXrTgSAppzhEz/jmLGVdz9IZY
	R
X-Google-Smtp-Source: AGHT+IHK7To518a2TTCNhyFt3csxTIn3WbA3wFxO/LYxkmpFWi6wsj344W91o9zGWF8hcuvU18qQ+w==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr209725iof.0.1712849636680;
        Thu, 11 Apr 2024 08:33:56 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 079/437] rv: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:39 -0600
Message-ID: <20240411153126.16201-80-axboe@kernel.dk>
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
 kernel/trace/rv/rv.c          | 58 +++++++++++++++++------------------
 kernel/trace/rv/rv_reactors.c | 32 +++++++++----------
 2 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 2f68e93fff0b..7402b77a1b89 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -209,15 +209,14 @@ void rv_put_task_monitor_slot(int slot)
 /*
  * This section collects the monitor/ files and folders.
  */
-static ssize_t monitor_enable_read_data(struct file *filp, char __user *user_buf, size_t count,
-					loff_t *ppos)
+static ssize_t monitor_enable_read_data(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rv_monitor_def *mdef = filp->private_data;
+	struct rv_monitor_def *mdef = iocb->ki_filp->private_data;
 	const char *buff;
 
 	buff = mdef->monitor->enabled ? "1\n" : "0\n";
 
-	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+1);
+	return simple_copy_to_iter(buff, &iocb->ki_pos, strlen(buff)+1, to);
 }
 
 /*
@@ -279,14 +278,15 @@ int rv_enable_monitor(struct rv_monitor_def *mdef)
 /*
  * interface for enabling/disabling a monitor.
  */
-static ssize_t monitor_enable_write_data(struct file *filp, const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t monitor_enable_write_data(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct rv_monitor_def *mdef = filp->private_data;
+	struct rv_monitor_def *mdef = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int retval;
 	bool val;
 
-	retval = kstrtobool_from_user(user_buf, count, &val);
+	retval = kstrtobool_from_iter(from, count, &val);
 	if (retval)
 		return retval;
 
@@ -305,30 +305,29 @@ static ssize_t monitor_enable_write_data(struct file *filp, const char __user *u
 static const struct file_operations interface_enable_fops = {
 	.open   = simple_open,
 	.llseek = no_llseek,
-	.write  = monitor_enable_write_data,
-	.read   = monitor_enable_read_data,
+	.write_iter  = monitor_enable_write_data,
+	.read_iter   = monitor_enable_read_data,
 };
 
 /*
  * Interface to read monitors description.
  */
-static ssize_t monitor_desc_read_data(struct file *filp, char __user *user_buf, size_t count,
-				      loff_t *ppos)
+static ssize_t monitor_desc_read_data(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rv_monitor_def *mdef = filp->private_data;
+	struct rv_monitor_def *mdef = iocb->ki_filp->private_data;
 	char buff[256];
 
 	memset(buff, 0, sizeof(buff));
 
 	snprintf(buff, sizeof(buff), "%s\n", mdef->monitor->description);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
+	return simple_copy_to_iter(buff, &iocb->ki_pos, strlen(buff) + 1, to);
 }
 
 static const struct file_operations interface_desc_fops = {
 	.open   = simple_open,
 	.llseek	= no_llseek,
-	.read	= monitor_desc_read_data,
+	.read_iter = monitor_desc_read_data,
 };
 
 /*
@@ -469,7 +468,7 @@ static int available_monitors_open(struct inode *inode, struct file *file)
 
 static const struct file_operations available_monitors_ops = {
 	.open    = available_monitors_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
@@ -507,10 +506,10 @@ static int enabled_monitors_open(struct inode *inode, struct file *file)
 	return seq_open(file, &enabled_monitors_seq_ops);
 };
 
-static ssize_t enabled_monitors_write(struct file *filp, const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t enabled_monitors_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
+	size_t count = iov_iter_count(from);
 	struct rv_monitor_def *mdef;
 	int retval = -EINVAL;
 	bool enable = true;
@@ -522,7 +521,8 @@ static ssize_t enabled_monitors_write(struct file *filp, const char __user *user
 
 	memset(buff, 0, sizeof(buff));
 
-	retval = simple_write_to_buffer(buff, sizeof(buff) - 1, ppos, user_buf, count);
+	retval = simple_copy_from_iter(buff, &iocb->ki_pos, sizeof(buff) - 1,
+					from);
 	if (retval < 0)
 		return -EFAULT;
 
@@ -565,8 +565,8 @@ static ssize_t enabled_monitors_write(struct file *filp, const char __user *user
 
 static const struct file_operations enabled_monitors_ops = {
 	.open		= enabled_monitors_open,
-	.read		= seq_read,
-	.write		= enabled_monitors_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= enabled_monitors_write,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -591,14 +591,13 @@ bool rv_monitoring_on(void)
 /*
  * monitoring_on general switcher.
  */
-static ssize_t monitoring_on_read_data(struct file *filp, char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t monitoring_on_read_data(struct kiocb *iocb, struct iov_iter *to)
 {
 	const char *buff;
 
 	buff = rv_monitoring_on() ? "1\n" : "0\n";
 
-	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
+	return simple_copy_to_iter(buff, &iocb->ki_pos, strlen(buff) + 1, to);
 }
 
 static void turn_monitoring_off(void)
@@ -642,13 +641,14 @@ static void turn_monitoring_on_with_reset(void)
 	turn_monitoring_on();
 }
 
-static ssize_t monitoring_on_write_data(struct file *filp, const char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t monitoring_on_write_data(struct kiocb *iocb,
+					struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	int retval;
 	bool val;
 
-	retval = kstrtobool_from_user(user_buf, count, &val);
+	retval = kstrtobool_from_iter(from, count, &val);
 	if (retval)
 		return retval;
 
@@ -673,8 +673,8 @@ static ssize_t monitoring_on_write_data(struct file *filp, const char __user *us
 static const struct file_operations monitoring_on_fops = {
 	.open   = simple_open,
 	.llseek = no_llseek,
-	.write  = monitoring_on_write_data,
-	.read   = monitoring_on_read_data,
+	.write_iter  = monitoring_on_write_data,
+	.read_iter   = monitoring_on_read_data,
 };
 
 static void destroy_monitor_dir(struct rv_monitor_def *mdef)
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 6aae106695b6..0649acd03726 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -128,7 +128,7 @@ static int available_reactors_open(struct inode *inode, struct file *file)
 
 static const struct file_operations available_reactors_ops = {
 	.open    = available_reactors_open,
-	.read    = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
@@ -183,11 +183,10 @@ static void monitor_swap_reactors(struct rv_monitor_def *mdef, struct rv_reactor
 		rv_enable_monitor(mdef);
 }
 
-static ssize_t
-monitor_reactors_write(struct file *file, const char __user *user_buf,
-		      size_t count, loff_t *ppos)
+static ssize_t monitor_reactors_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
+	size_t count = iov_iter_count(from);
 	struct rv_monitor_def *mdef;
 	struct rv_reactor_def *rdef;
 	struct seq_file *seq_f;
@@ -201,7 +200,8 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 
 	memset(buff, 0, sizeof(buff));
 
-	retval = simple_write_to_buffer(buff, sizeof(buff) - 1, ppos, user_buf, count);
+	retval = simple_copy_from_iter(buff, &iocb->ki_pos, sizeof(buff) - 1,
+					from);
 	if (retval < 0)
 		return -EFAULT;
 
@@ -214,7 +214,7 @@ monitor_reactors_write(struct file *file, const char __user *user_buf,
 	/*
 	 * See monitor_reactors_open()
 	 */
-	seq_f = file->private_data;
+	seq_f = iocb->ki_filp->private_data;
 	mdef = seq_f->private;
 
 	mutex_lock(&rv_interface_lock);
@@ -269,10 +269,10 @@ static int monitor_reactors_open(struct inode *inode, struct file *file)
 
 static const struct file_operations monitor_reactors_ops = {
 	.open    = monitor_reactors_open,
-	.read    = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
-	.write = monitor_reactors_write
+	.write_iter = monitor_reactors_write
 };
 
 static int __rv_register_reactor(struct rv_reactor *reactor)
@@ -371,15 +371,13 @@ bool rv_reacting_on(void)
 	return READ_ONCE(reacting_on);
 }
 
-static ssize_t reacting_on_read_data(struct file *filp,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t reacting_on_read_data(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *buff;
 
 	buff = rv_reacting_on() ? "1\n" : "0\n";
 
-	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+1);
+	return simple_copy_to_iter(buff, &iocb->ki_pos, strlen(buff)+1, to);
 }
 
 static void turn_reacting_off(void)
@@ -396,13 +394,13 @@ static void turn_reacting_on(void)
 	smp_wmb();
 }
 
-static ssize_t reacting_on_write_data(struct file *filp, const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t reacting_on_write_data(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	int retval;
 	bool val;
 
-	retval = kstrtobool_from_user(user_buf, count, &val);
+	retval = kstrtobool_from_iter(from, count, &val);
 	if (retval)
 		return retval;
 
@@ -427,8 +425,8 @@ static ssize_t reacting_on_write_data(struct file *filp, const char __user *user
 static const struct file_operations reacting_on_fops = {
 	.open   = simple_open,
 	.llseek = no_llseek,
-	.write  = reacting_on_write_data,
-	.read   = reacting_on_read_data,
+	.write_iter  = reacting_on_write_data,
+	.read_iter   = reacting_on_read_data,
 };
 
 /**
-- 
2.43.0


