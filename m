Return-Path: <linux-kernel+bounces-141068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D38A1AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0070AB2A908
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E01D4EEC;
	Thu, 11 Apr 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kc/WGvPH"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57DF1D3715
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849988; cv=none; b=rWx/83FeMnHgsAo25plm/q89nIa+d5NWyNXnA0swK57g1KjtFDAy/EMYruT++fnqH53zs2CT1TvgY1wFiydoSQBtYAkUTk/s7EO6GcKFr/8kD3MvSYSXAX9km6C84c0ZTRBPaSyor20aIfcfzmL88b04/p+X9v/j89n3bwzzjck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849988; c=relaxed/simple;
	bh=RXUlDOLuNF/HHMmDhiKlgGCW6A93WhnZ1njUSN+7FP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n98WQs4RmrMtDlxKWKTMLG/mGzuJRrppY8F9W2tMX+EUAdzQO+F+7NFABf4rGPXosAatrAiGedgZHhyztEMFxbiyXLHd7J9y2yoZBjRR8+IWS4nPPKk1dVkDw6DtB4MhrAmHBiOsV49yqg+XW1qvZusJVZrbkcFM8SairyixCmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kc/WGvPH; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69641939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849984; x=1713454784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DfTI2DpINtENEVOMzZkNWy1YEK4tmII71QpZm5OrVg=;
        b=kc/WGvPH628XPxr1aUtSLtuVryhXSBlsctCxvsOtp2iT4F7xFiqfJKijvrs54CyTP4
         maZfCxXeOEcvas6B2IW4gUcvZvV6zesaEYEFDdRV8JOp2Ex1j3tftF0OhYNMzXOH2YuV
         Q06uiteWWOKnjHZZ+VpCcUCF2XtJ3ZSYkTfIHa08PYwd/cyWUghOlEMsVAoFQbtOiXHY
         4ZUPjmjCBfsjkgjvKDUl5NbmZn5xbTs66z5szQmVKB+r+Havj1ypOy3MDzwPy5LIzpe1
         yIilQ54Wo8WcNLzVDk9IgVJksI1gQYWI1trpPqhaCvBvkafoXYrNy0yaCWyrXZWvkgpY
         sndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849984; x=1713454784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DfTI2DpINtENEVOMzZkNWy1YEK4tmII71QpZm5OrVg=;
        b=esLRwPAPje6XpB9HouAy42PCQxbLCy8exj0KaaARxrQYR5wVXEXDyE5EIX2s08GAiE
         PTjIilu+1R9KpYei2obn0Dk9CpnnowgZO8lr4GGWSx5Dxq+JuTw2kfY2GtqWRwCzIgcF
         bny45GMFTfCO4qXDoiLyAjJsRpUbiaZP28m/G1J8jg5HUSbMGNjpApMl0RKGxJ7MD+vy
         DdsLIjPtVO8h6FHs7124wqL/9q98FZ6iWkwVquKxDw/lK7zjXw0xzT2zEaen2dP4oQCr
         Fi6r+UE2Z79x5LztJ57AMHUaHl3SK4xKoy9puibI8cYl3kztgAQZ6SBJKzTH1iqT7t0y
         L6+g==
X-Gm-Message-State: AOJu0Yxy419E2xJGnNyRDubKiZKhbGJGOVTZim+Vfbbd+v+rDFMXyunv
	TtsZpgS6uOb5OIbKNjsYZSQXBwvmqKlRhxPK0+ihx8YB8MqiyfPUpcJBpmK+piN/xndRM7QRA5m
	F
X-Google-Smtp-Source: AGHT+IEYDUj3JvPKraxejtWRtkJHMkOS7p5ypbE+pOyLK5tsOI8e0rgiKevEx6Pk7wqxWupTA16XVA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr202278iop.1.1712849984049;
        Thu, 11 Apr 2024 08:39:44 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 292/437] fs/proc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:12 -0600
Message-ID: <20240411153126.16201-293-axboe@kernel.dk>
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
 fs/proc/base.c                 | 316 ++++++++++++++++-----------------
 fs/proc/fd.c                   |   2 +-
 fs/proc/inode.c                |  18 +-
 fs/proc/task_mmu.c             |  37 ++--
 fs/proc/task_nommu.c           |   2 +-
 include/linux/user_namespace.h |  10 +-
 kernel/user_namespace.c        |  39 ++--
 7 files changed, 214 insertions(+), 210 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4c6a7aafe66a..d810ede0e399 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -373,9 +373,10 @@ static ssize_t proc_pid_cmdline_read(struct file *file, char __user *buf,
 		*pos += ret;
 	return ret;
 }
+FOPS_READ_ITER_HELPER(proc_pid_cmdline_read);
 
 static const struct file_operations proc_pid_cmdline_ops = {
-	.read	= proc_pid_cmdline_read,
+	.read_iter = proc_pid_cmdline_read_iter,
 	.llseek	= generic_file_llseek,
 };
 
@@ -525,23 +526,22 @@ static int lstats_open(struct inode *inode, struct file *file)
 	return single_open(file, lstats_show_proc, inode);
 }
 
-static ssize_t lstats_write(struct file *file, const char __user *buf,
-			    size_t count, loff_t *offs)
+static ssize_t lstats_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct task_struct *task = get_proc_task(file_inode(file));
+	struct task_struct *task = get_proc_task(file_inode(iocb->ki_filp));
 
 	if (!task)
 		return -ESRCH;
 	clear_tsk_latency_tracing(task);
 	put_task_struct(task);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations proc_lstats_operations = {
 	.open		= lstats_open,
-	.read		= seq_read,
-	.write		= lstats_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= lstats_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -788,7 +788,7 @@ static int proc_single_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_single_file_operations = {
 	.open		= proc_single_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -835,11 +835,11 @@ static int mem_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static ssize_t mem_rw(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos, int write)
+static ssize_t mem_rw(struct kiocb *iocb, struct iov_iter *iov, int write)
 {
-	struct mm_struct *mm = file->private_data;
-	unsigned long addr = *ppos;
+	struct mm_struct *mm = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(iov);
+	unsigned long addr = iocb->ki_pos;
 	ssize_t copied;
 	char *page;
 	unsigned int flags;
@@ -860,7 +860,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	while (count > 0) {
 		size_t this_len = min_t(size_t, count, PAGE_SIZE);
 
-		if (write && copy_from_user(page, buf, this_len)) {
+		if (write && !copy_from_iter_full(page, this_len, iov)) {
 			copied = -EFAULT;
 			break;
 		}
@@ -872,17 +872,16 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 			break;
 		}
 
-		if (!write && copy_to_user(buf, page, this_len)) {
+		if (!write && !copy_to_iter_full(page, this_len, iov)) {
 			copied = -EFAULT;
 			break;
 		}
 
-		buf += this_len;
 		addr += this_len;
 		copied += this_len;
 		count -= this_len;
 	}
-	*ppos = addr;
+	iocb->ki_pos = addr;
 
 	mmput(mm);
 free:
@@ -890,16 +889,14 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	return copied;
 }
 
-static ssize_t mem_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t mem_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return mem_rw(file, buf, count, ppos, 0);
+	return mem_rw(iocb, to, 0);
 }
 
-static ssize_t mem_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t mem_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	return mem_rw(file, (char __user*)buf, count, ppos, 1);
+	return mem_rw(iocb, from, 1);
 }
 
 loff_t mem_lseek(struct file *file, loff_t offset, int orig)
@@ -928,8 +925,8 @@ static int mem_release(struct inode *inode, struct file *file)
 
 static const struct file_operations proc_mem_operations = {
 	.llseek		= mem_lseek,
-	.read		= mem_read,
-	.write		= mem_write,
+	.read_iter	= mem_read,
+	.write_iter	= mem_write,
 	.open		= mem_open,
 	.release	= mem_release,
 };
@@ -939,13 +936,13 @@ static int environ_open(struct inode *inode, struct file *file)
 	return __mem_open(inode, file, PTRACE_MODE_READ);
 }
 
-static ssize_t environ_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t environ_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	char *page;
-	unsigned long src = *ppos;
+	unsigned long src = iocb->ki_pos;
 	int ret = 0;
-	struct mm_struct *mm = file->private_data;
+	struct mm_struct *mm = iocb->ki_filp->private_data;
 	unsigned long env_start, env_end;
 
 	/* Ensure the process spawned far enough to have an environment. */
@@ -984,17 +981,16 @@ static ssize_t environ_read(struct file *file, char __user *buf,
 			break;
 		}
 
-		if (copy_to_user(buf, page, retval)) {
+		if (!copy_to_iter_full(page, retval, to)) {
 			ret = -EFAULT;
 			break;
 		}
 
 		ret += retval;
 		src += retval;
-		buf += retval;
 		count -= retval;
 	}
-	*ppos = src;
+	iocb->ki_pos = src;
 	mmput(mm);
 
 free:
@@ -1004,7 +1000,7 @@ static ssize_t environ_read(struct file *file, char __user *buf,
 
 static const struct file_operations proc_environ_operations = {
 	.open		= environ_open,
-	.read		= environ_read,
+	.read_iter	= environ_read,
 	.llseek		= generic_file_llseek,
 	.release	= mem_release,
 };
@@ -1014,10 +1010,9 @@ static int auxv_open(struct inode *inode, struct file *file)
 	return __mem_open(inode, file, PTRACE_MODE_READ_FSCREDS);
 }
 
-static ssize_t auxv_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t auxv_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mm_struct *mm = file->private_data;
+	struct mm_struct *mm = iocb->ki_filp->private_data;
 	unsigned int nwords = 0;
 
 	if (!mm)
@@ -1025,21 +1020,20 @@ static ssize_t auxv_read(struct file *file, char __user *buf,
 	do {
 		nwords += 2;
 	} while (mm->saved_auxv[nwords - 2] != 0); /* AT_NULL */
-	return simple_read_from_buffer(buf, count, ppos, mm->saved_auxv,
-				       nwords * sizeof(mm->saved_auxv[0]));
+	return simple_copy_to_iter(mm->saved_auxv, &iocb->ki_pos,
+				   nwords * sizeof(mm->saved_auxv[0]), to);
 }
 
 static const struct file_operations proc_auxv_operations = {
 	.open		= auxv_open,
-	.read		= auxv_read,
+	.read_iter	= auxv_read,
 	.llseek		= generic_file_llseek,
 	.release	= mem_release,
 };
 
-static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
+static ssize_t oom_adj_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct task_struct *task = get_proc_task(file_inode(file));
+	struct task_struct *task = get_proc_task(file_inode(iocb->ki_filp));
 	char buffer[PROC_NUMBUF];
 	int oom_adj = OOM_ADJUST_MIN;
 	size_t len;
@@ -1055,7 +1049,7 @@ static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
 	if (oom_adj > OOM_ADJUST_MAX)
 		oom_adj = OOM_ADJUST_MAX;
 	len = snprintf(buffer, sizeof(buffer), "%d\n", oom_adj);
-	return simple_read_from_buffer(buf, count, ppos, buffer, len);
+	return simple_copy_to_iter(buffer, &iocb->ki_pos, len, to);
 }
 
 static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
@@ -1151,16 +1145,16 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
  *
  * oom_adj cannot be removed since existing userspace binaries use it.
  */
-static ssize_t oom_adj_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t oom_adj_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char buffer[PROC_NUMBUF] = {};
 	int oom_adj;
 	int err;
 
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
-	if (copy_from_user(buffer, buf, count)) {
+	if (!copy_from_iter_full(buffer, count, from)) {
 		err = -EFAULT;
 		goto out;
 	}
@@ -1183,21 +1177,20 @@ static ssize_t oom_adj_write(struct file *file, const char __user *buf,
 	else
 		oom_adj = (oom_adj * OOM_SCORE_ADJ_MAX) / -OOM_DISABLE;
 
-	err = __set_oom_adj(file, oom_adj, true);
+	err = __set_oom_adj(iocb->ki_filp, oom_adj, true);
 out:
 	return err < 0 ? err : count;
 }
 
 static const struct file_operations proc_oom_adj_operations = {
-	.read		= oom_adj_read,
-	.write		= oom_adj_write,
+	.read_iter	= oom_adj_read,
+	.write_iter	= oom_adj_write,
 	.llseek		= generic_file_llseek,
 };
 
-static ssize_t oom_score_adj_read(struct file *file, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t oom_score_adj_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct task_struct *task = get_proc_task(file_inode(file));
+	struct task_struct *task = get_proc_task(file_inode(iocb->ki_filp));
 	char buffer[PROC_NUMBUF];
 	short oom_score_adj = OOM_SCORE_ADJ_MIN;
 	size_t len;
@@ -1207,19 +1200,19 @@ static ssize_t oom_score_adj_read(struct file *file, char __user *buf,
 	oom_score_adj = task->signal->oom_score_adj;
 	put_task_struct(task);
 	len = snprintf(buffer, sizeof(buffer), "%hd\n", oom_score_adj);
-	return simple_read_from_buffer(buf, count, ppos, buffer, len);
+	return simple_copy_to_iter(buffer, &iocb->ki_pos, len, to);
 }
 
-static ssize_t oom_score_adj_write(struct file *file, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t oom_score_adj_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char buffer[PROC_NUMBUF] = {};
 	int oom_score_adj;
 	int err;
 
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
-	if (copy_from_user(buffer, buf, count)) {
+	if (!copy_from_iter_full(buffer, count, from)) {
 		err = -EFAULT;
 		goto out;
 	}
@@ -1233,23 +1226,22 @@ static ssize_t oom_score_adj_write(struct file *file, const char __user *buf,
 		goto out;
 	}
 
-	err = __set_oom_adj(file, oom_score_adj, false);
+	err = __set_oom_adj(iocb->ki_filp, oom_score_adj, false);
 out:
 	return err < 0 ? err : count;
 }
 
 static const struct file_operations proc_oom_score_adj_operations = {
-	.read		= oom_score_adj_read,
-	.write		= oom_score_adj_write,
+	.read_iter	= oom_score_adj_read,
+	.write_iter	= oom_score_adj_write,
 	.llseek		= default_llseek,
 };
 
 #ifdef CONFIG_AUDIT
 #define TMPBUFLEN 11
-static ssize_t proc_loginuid_read(struct file * file, char __user * buf,
-				  size_t count, loff_t *ppos)
+static ssize_t proc_loginuid_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct inode * inode = file_inode(file);
+	struct inode * inode = file_inode(iocb->ki_filp);
 	struct task_struct *task = get_proc_task(inode);
 	ssize_t length;
 	char tmpbuf[TMPBUFLEN];
@@ -1257,16 +1249,16 @@ static ssize_t proc_loginuid_read(struct file * file, char __user * buf,
 	if (!task)
 		return -ESRCH;
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
-			   from_kuid(file->f_cred->user_ns,
+			   from_kuid(iocb->ki_filp->f_cred->user_ns,
 				     audit_get_loginuid(task)));
 	put_task_struct(task);
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+	return simple_copy_to_iter(tmpbuf, &iocb->ki_pos, length, to);
 }
 
-static ssize_t proc_loginuid_write(struct file * file, const char __user * buf,
-				   size_t count, loff_t *ppos)
+static ssize_t proc_loginuid_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode * inode = file_inode(file);
+	struct inode * inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	uid_t loginuid;
 	kuid_t kloginuid;
 	int rv;
@@ -1282,12 +1274,12 @@ static ssize_t proc_loginuid_write(struct file * file, const char __user * buf,
 	}
 	rcu_read_unlock();
 
-	if (*ppos != 0) {
+	if (iocb->ki_pos != 0) {
 		/* No partial writes. */
 		return -EINVAL;
 	}
 
-	rv = kstrtou32_from_user(buf, count, 10, &loginuid);
+	rv = kstrtou32_from_iter(from, count, 10, &loginuid);
 	if (rv < 0)
 		return rv;
 
@@ -1295,7 +1287,7 @@ static ssize_t proc_loginuid_write(struct file * file, const char __user * buf,
 	if (loginuid == AUDIT_UID_UNSET) {
 		kloginuid = INVALID_UID;
 	} else {
-		kloginuid = make_kuid(file->f_cred->user_ns, loginuid);
+		kloginuid = make_kuid(iocb->ki_filp->f_cred->user_ns, loginuid);
 		if (!uid_valid(kloginuid))
 			return -EINVAL;
 	}
@@ -1307,15 +1299,14 @@ static ssize_t proc_loginuid_write(struct file * file, const char __user * buf,
 }
 
 static const struct file_operations proc_loginuid_operations = {
-	.read		= proc_loginuid_read,
-	.write		= proc_loginuid_write,
+	.read_iter	= proc_loginuid_read,
+	.write_iter	= proc_loginuid_write,
 	.llseek		= generic_file_llseek,
 };
 
-static ssize_t proc_sessionid_read(struct file * file, char __user * buf,
-				  size_t count, loff_t *ppos)
+static ssize_t proc_sessionid_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct inode * inode = file_inode(file);
+	struct inode * inode = file_inode(iocb->ki_filp);
 	struct task_struct *task = get_proc_task(inode);
 	ssize_t length;
 	char tmpbuf[TMPBUFLEN];
@@ -1325,20 +1316,19 @@ static ssize_t proc_sessionid_read(struct file * file, char __user * buf,
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
 				audit_get_sessionid(task));
 	put_task_struct(task);
-	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+	return simple_copy_to_iter(tmpbuf, &iocb->ki_pos, length, to);
 }
 
 static const struct file_operations proc_sessionid_operations = {
-	.read		= proc_sessionid_read,
+	.read_iter	= proc_sessionid_read,
 	.llseek		= generic_file_llseek,
 };
 #endif
 
 #ifdef CONFIG_FAULT_INJECTION
-static ssize_t proc_fault_inject_read(struct file * file, char __user * buf,
-				      size_t count, loff_t *ppos)
+static ssize_t proc_fault_inject_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct task_struct *task = get_proc_task(file_inode(file));
+	struct task_struct *task = get_proc_task(file_inode(iocb->ki_filp));
 	char buffer[PROC_NUMBUF];
 	size_t len;
 	int make_it_fail;
@@ -1349,13 +1339,12 @@ static ssize_t proc_fault_inject_read(struct file * file, char __user * buf,
 	put_task_struct(task);
 
 	len = snprintf(buffer, sizeof(buffer), "%i\n", make_it_fail);
-
-	return simple_read_from_buffer(buf, count, ppos, buffer, len);
+	return simple_copy_to_iter(buffer, &iocb->ki_pos, len, to);
 }
 
-static ssize_t proc_fault_inject_write(struct file * file,
-			const char __user * buf, size_t count, loff_t *ppos)
+static ssize_t proc_fault_inject_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct task_struct *task;
 	char buffer[PROC_NUMBUF] = {};
 	int make_it_fail;
@@ -1366,7 +1355,7 @@ static ssize_t proc_fault_inject_write(struct file * file,
 
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
-	if (copy_from_user(buffer, buf, count))
+	if (!copy_from_iter_full(buffer, count, from))
 		return -EFAULT;
 	rv = kstrtoint(strstrip(buffer), 0, &make_it_fail);
 	if (rv < 0)
@@ -1374,7 +1363,7 @@ static ssize_t proc_fault_inject_write(struct file * file,
 	if (make_it_fail < 0 || make_it_fail > 1)
 		return -EINVAL;
 
-	task = get_proc_task(file_inode(file));
+	task = get_proc_task(file_inode(iocb->ki_filp));
 	if (!task)
 		return -ESRCH;
 	task->make_it_fail = make_it_fail;
@@ -1384,23 +1373,23 @@ static ssize_t proc_fault_inject_write(struct file * file,
 }
 
 static const struct file_operations proc_fault_inject_operations = {
-	.read		= proc_fault_inject_read,
-	.write		= proc_fault_inject_write,
+	.read_iter	= proc_fault_inject_read,
+	.write_iter	= proc_fault_inject_write,
 	.llseek		= generic_file_llseek,
 };
 
-static ssize_t proc_fail_nth_write(struct file *file, const char __user *buf,
-				   size_t count, loff_t *ppos)
+static ssize_t proc_fail_nth_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct task_struct *task;
 	int err;
 	unsigned int n;
 
-	err = kstrtouint_from_user(buf, count, 0, &n);
+	err = kstrtouint_from_iter(from, count, 0, &n);
 	if (err)
 		return err;
 
-	task = get_proc_task(file_inode(file));
+	task = get_proc_task(file_inode(iocb->ki_filp));
 	if (!task)
 		return -ESRCH;
 	task->fail_nth = n;
@@ -1409,24 +1398,23 @@ static ssize_t proc_fail_nth_write(struct file *file, const char __user *buf,
 	return count;
 }
 
-static ssize_t proc_fail_nth_read(struct file *file, char __user *buf,
-				  size_t count, loff_t *ppos)
+static ssize_t proc_fail_nth_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct task_struct *task;
 	char numbuf[PROC_NUMBUF];
 	ssize_t len;
 
-	task = get_proc_task(file_inode(file));
+	task = get_proc_task(file_inode(iocb->ki_filp));
 	if (!task)
 		return -ESRCH;
 	len = snprintf(numbuf, sizeof(numbuf), "%u\n", task->fail_nth);
 	put_task_struct(task);
-	return simple_read_from_buffer(buf, count, ppos, numbuf, len);
+	return simple_copy_to_iter(numbuf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations proc_fail_nth_operations = {
-	.read		= proc_fail_nth_read,
-	.write		= proc_fail_nth_write,
+	.read_iter	= proc_fail_nth_read,
+	.write_iter	= proc_fail_nth_write,
 };
 #endif
 
@@ -1451,11 +1439,9 @@ static int sched_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t
-sched_write(struct file *file, const char __user *buf,
-	    size_t count, loff_t *offset)
+static ssize_t sched_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
 	struct task_struct *p;
 
 	p = get_proc_task(inode);
@@ -1465,7 +1451,7 @@ sched_write(struct file *file, const char __user *buf,
 
 	put_task_struct(p);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static int sched_open(struct inode *inode, struct file *filp)
@@ -1475,8 +1461,8 @@ static int sched_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_sched_operations = {
 	.open		= sched_open,
-	.read		= seq_read,
-	.write		= sched_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= sched_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -1502,11 +1488,10 @@ static int sched_autogroup_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t
-sched_autogroup_write(struct file *file, const char __user *buf,
-	    size_t count, loff_t *offset)
+static ssize_t sched_autogroup_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	struct task_struct *p;
 	char buffer[PROC_NUMBUF] = {};
 	int nice;
@@ -1514,7 +1499,7 @@ sched_autogroup_write(struct file *file, const char __user *buf,
 
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
-	if (copy_from_user(buffer, buf, count))
+	if (!copy_from_iter_full(buffer, count, from))
 		return -EFAULT;
 
 	err = kstrtoint(strstrip(buffer), 0, &nice);
@@ -1549,8 +1534,8 @@ static int sched_autogroup_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_sched_autogroup_operations = {
 	.open		= sched_autogroup_open,
-	.read		= seq_read,
-	.write		= sched_autogroup_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= sched_autogroup_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -1572,21 +1557,21 @@ static int timens_offsets_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
-				    size_t count, loff_t *ppos)
+static ssize_t timens_offsets_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	struct proc_timens_offset offsets[2];
 	char *kbuf = NULL, *pos, *next_line;
 	struct task_struct *p;
 	int ret, noffsets;
 
 	/* Only allow < page size writes at the beginning of the file */
-	if ((*ppos != 0) || (count >= PAGE_SIZE))
+	if ((iocb->ki_pos != 0) || (count >= PAGE_SIZE))
 		return -EINVAL;
 
 	/* Slurp in the user data */
-	kbuf = memdup_user_nul(buf, count);
+	kbuf = iterdup_nul(from, count);
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
@@ -1634,7 +1619,7 @@ static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
 	p = get_proc_task(inode);
 	if (!p)
 		goto out;
-	ret = proc_timens_set_offset(file, p, offsets, noffsets);
+	ret = proc_timens_set_offset(iocb->ki_filp, p, offsets, noffsets);
 	put_task_struct(p);
 	if (ret)
 		goto out;
@@ -1652,22 +1637,22 @@ static int timens_offsets_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_timens_offsets_operations = {
 	.open		= timens_offsets_open,
-	.read		= seq_read,
-	.write		= timens_offsets_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= timens_offsets_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
 #endif /* CONFIG_TIME_NS */
 
-static ssize_t comm_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *offset)
+static ssize_t comm_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	struct task_struct *p;
 	char buffer[TASK_COMM_LEN] = {};
 	const size_t maxlen = sizeof(buffer) - 1;
 
-	if (copy_from_user(buffer, buf, count > maxlen ? maxlen : count))
+	if (!copy_from_iter_full(buffer, count > maxlen ? maxlen : count, from))
 		return -EFAULT;
 
 	p = get_proc_task(inode);
@@ -1710,8 +1695,8 @@ static int comm_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_set_comm_operations = {
 	.open		= comm_open,
-	.read		= seq_read,
-	.write		= comm_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= comm_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -2530,21 +2515,21 @@ static int proc_timers_open(struct inode *inode, struct file *file)
 
 static const struct file_operations proc_timers_operations = {
 	.open		= proc_timers_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release_private,
 };
 #endif
 
-static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
-					size_t count, loff_t *offset)
+static ssize_t timerslack_ns_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	struct task_struct *p;
 	u64 slack_ns;
 	int err;
 
-	err = kstrtoull_from_user(buf, count, 10, &slack_ns);
+	err = kstrtoull_from_iter(from, count, 10, &slack_ns);
 	if (err < 0)
 		return err;
 
@@ -2622,8 +2607,8 @@ static int timerslack_ns_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_set_timerslack_ns_operations = {
 	.open		= timerslack_ns_open,
-	.read		= seq_read,
-	.write		= timerslack_ns_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= timerslack_ns_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -2714,10 +2699,9 @@ static int proc_pid_attr_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
-				  size_t count, loff_t *ppos)
+static ssize_t proc_pid_attr_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct inode * inode = file_inode(file);
+	struct inode * inode = file_inode(iocb->ki_filp);
 	char *p = NULL;
 	ssize_t length;
 	struct task_struct *task = get_proc_task(inode);
@@ -2726,25 +2710,25 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 		return -ESRCH;
 
 	length = security_getprocattr(task, PROC_I(inode)->op.lsmid,
-				      file->f_path.dentry->d_name.name,
+				      iocb->ki_filp->f_path.dentry->d_name.name,
 				      &p);
 	put_task_struct(task);
 	if (length > 0)
-		length = simple_read_from_buffer(buf, count, ppos, p, length);
+		length = simple_copy_to_iter(p, &iocb->ki_pos, length, to);
 	kfree(p);
 	return length;
 }
 
-static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
-				   size_t count, loff_t *ppos)
+static ssize_t proc_pid_attr_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode * inode = file_inode(file);
+	struct inode * inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	struct task_struct *task;
 	void *page;
 	int rv;
 
 	/* A task may only write when it was the opener. */
-	if (file->private_data != current->mm)
+	if (iocb->ki_filp->private_data != current->mm)
 		return -EPERM;
 
 	rcu_read_lock();
@@ -2769,10 +2753,10 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 		count = PAGE_SIZE;
 
 	/* No partial writes. */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return -EINVAL;
 
-	page = memdup_user(buf, count);
+	page = iterdup(from, count);
 	if (IS_ERR(page)) {
 		rv = PTR_ERR(page);
 		goto out;
@@ -2784,8 +2768,8 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 		goto out_free;
 
 	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
-				  file->f_path.dentry->d_name.name, page,
-				  count);
+				  iocb->ki_filp->f_path.dentry->d_name.name,
+				  page, count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
 out_free:
 	kfree(page);
@@ -2795,8 +2779,8 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 
 static const struct file_operations proc_pid_attr_operations = {
 	.open		= proc_pid_attr_open,
-	.read		= proc_pid_attr_read,
-	.write		= proc_pid_attr_write,
+	.read_iter	= proc_pid_attr_read,
+	.write_iter	= proc_pid_attr_write,
 	.llseek		= generic_file_llseek,
 	.release	= mem_release,
 };
@@ -2892,10 +2876,9 @@ static const struct inode_operations proc_attr_dir_inode_operations = {
 #endif
 
 #ifdef CONFIG_ELF_CORE
-static ssize_t proc_coredump_filter_read(struct file *file, char __user *buf,
-					 size_t count, loff_t *ppos)
+static ssize_t proc_coredump_filter_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct task_struct *task = get_proc_task(file_inode(file));
+	struct task_struct *task = get_proc_task(file_inode(iocb->ki_filp));
 	struct mm_struct *mm;
 	char buffer[PROC_NUMBUF];
 	size_t len;
@@ -2911,7 +2894,7 @@ static ssize_t proc_coredump_filter_read(struct file *file, char __user *buf,
 			       ((mm->flags & MMF_DUMP_FILTER_MASK) >>
 				MMF_DUMP_FILTER_SHIFT));
 		mmput(mm);
-		ret = simple_read_from_buffer(buf, count, ppos, buffer, len);
+		ret = simple_copy_to_iter(buffer, &iocb->ki_pos, len, to);
 	}
 
 	put_task_struct(task);
@@ -2919,11 +2902,10 @@ static ssize_t proc_coredump_filter_read(struct file *file, char __user *buf,
 	return ret;
 }
 
-static ssize_t proc_coredump_filter_write(struct file *file,
-					  const char __user *buf,
-					  size_t count,
-					  loff_t *ppos)
+static ssize_t proc_coredump_filter_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct task_struct *task;
 	struct mm_struct *mm;
 	unsigned int val;
@@ -2931,12 +2913,12 @@ static ssize_t proc_coredump_filter_write(struct file *file,
 	int i;
 	unsigned long mask;
 
-	ret = kstrtouint_from_user(buf, count, 0, &val);
+	ret = kstrtouint_from_iter(from, count, 0, &val);
 	if (ret < 0)
 		return ret;
 
 	ret = -ESRCH;
-	task = get_proc_task(file_inode(file));
+	task = get_proc_task(file_inode(iocb->ki_filp));
 	if (!task)
 		goto out_no_task;
 
@@ -2962,8 +2944,8 @@ static ssize_t proc_coredump_filter_write(struct file *file,
 }
 
 static const struct file_operations proc_coredump_filter_operations = {
-	.read		= proc_coredump_filter_read,
-	.write		= proc_coredump_filter_write,
+	.read_iter	= proc_coredump_filter_read,
+	.write_iter	= proc_coredump_filter_write,
 	.llseek		= generic_file_llseek,
 };
 #endif
@@ -3098,24 +3080,24 @@ static int proc_projid_map_open(struct inode *inode, struct file *file)
 
 static const struct file_operations proc_uid_map_operations = {
 	.open		= proc_uid_map_open,
-	.write		= proc_uid_map_write,
-	.read		= seq_read,
+	.write_iter	= proc_uid_map_write_iter,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_id_map_release,
 };
 
 static const struct file_operations proc_gid_map_operations = {
 	.open		= proc_gid_map_open,
-	.write		= proc_gid_map_write,
-	.read		= seq_read,
+	.write_iter	= proc_gid_map_write_iter,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_id_map_release,
 };
 
 static const struct file_operations proc_projid_map_operations = {
 	.open		= proc_projid_map_open,
-	.write		= proc_projid_map_write,
-	.read		= seq_read,
+	.write_iter	= proc_projid_map_write_iter,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_id_map_release,
 };
@@ -3165,8 +3147,8 @@ static int proc_setgroups_release(struct inode *inode, struct file *file)
 
 static const struct file_operations proc_setgroups_operations = {
 	.open		= proc_setgroups_open,
-	.write		= proc_setgroups_write,
-	.read		= seq_read,
+	.write_iter	= proc_setgroups_write,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_setgroups_release,
 };
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 63a3aebdf223..ee3f608559e5 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -103,7 +103,7 @@ static int seq_fdinfo_open(struct inode *inode, struct file *file)
 
 static const struct file_operations proc_fdinfo_file_operations = {
 	.open		= seq_fdinfo_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index dcd513dccf55..092164889e74 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -325,6 +325,11 @@ static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count,
 	return rv;
 }
 
+static ssize_t __proc_reg_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	return vfs_read_iter(iocb, to, proc_reg_read);
+}
+
 static ssize_t pde_write(struct proc_dir_entry *pde, struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	typeof_member(struct proc_ops, proc_write) write;
@@ -348,6 +353,7 @@ static ssize_t proc_reg_write(struct file *file, const char __user *buf, size_t
 	}
 	return rv;
 }
+FOPS_WRITE_ITER_HELPER(proc_reg_write);
 
 static __poll_t pde_poll(struct proc_dir_entry *pde, struct file *file, struct poll_table_struct *pts)
 {
@@ -571,8 +577,8 @@ static int proc_reg_release(struct inode *inode, struct file *file)
 
 static const struct file_operations proc_reg_file_ops = {
 	.llseek		= proc_reg_llseek,
-	.read		= proc_reg_read,
-	.write		= proc_reg_write,
+	.read_iter	= __proc_reg_read_iter,
+	.write_iter	= proc_reg_write_iter,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
 	.mmap		= proc_reg_mmap,
@@ -584,7 +590,7 @@ static const struct file_operations proc_reg_file_ops = {
 static const struct file_operations proc_iter_file_ops = {
 	.llseek		= proc_reg_llseek,
 	.read_iter	= proc_reg_read_iter,
-	.write		= proc_reg_write,
+	.write_iter	= proc_reg_write_iter,
 	.splice_read	= copy_splice_read,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
@@ -597,8 +603,8 @@ static const struct file_operations proc_iter_file_ops = {
 #ifdef CONFIG_COMPAT
 static const struct file_operations proc_reg_file_ops_compat = {
 	.llseek		= proc_reg_llseek,
-	.read		= proc_reg_read,
-	.write		= proc_reg_write,
+	.read_iter	= proc_reg_read_iter,
+	.write_iter	= proc_reg_write_iter,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
 	.compat_ioctl	= proc_reg_compat_ioctl,
@@ -612,7 +618,7 @@ static const struct file_operations proc_iter_file_ops_compat = {
 	.llseek		= proc_reg_llseek,
 	.read_iter	= proc_reg_read_iter,
 	.splice_read	= copy_splice_read,
-	.write		= proc_reg_write,
+	.write_iter	= proc_reg_write_iter,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
 	.compat_ioctl	= proc_reg_compat_ioctl,
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 23fbab954c20..ff86fe94fcba 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -360,7 +360,7 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_maps_operations = {
 	.open		= pid_maps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
@@ -1049,14 +1049,14 @@ static int smaps_rollup_release(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_smaps_operations = {
 	.open		= pid_smaps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
 
 const struct file_operations proc_pid_smaps_rollup_operations = {
 	.open		= smaps_rollup_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= smaps_rollup_release,
 };
@@ -1242,9 +1242,9 @@ static const struct mm_walk_ops clear_refs_walk_ops = {
 	.walk_lock		= PGWALK_WRLOCK,
 };
 
-static ssize_t clear_refs_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t clear_refs_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct task_struct *task;
 	char buffer[PROC_NUMBUF] = {};
 	struct mm_struct *mm;
@@ -1255,7 +1255,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
-	if (copy_from_user(buffer, buf, count))
+	if (!copy_from_iter_full(buffer, count, from))
 		return -EFAULT;
 	rv = kstrtoint(strstrip(buffer), 10, &itype);
 	if (rv < 0)
@@ -1264,7 +1264,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	if (type < CLEAR_REFS_ALL || type >= CLEAR_REFS_LAST)
 		return -EINVAL;
 
-	task = get_proc_task(file_inode(file));
+	task = get_proc_task(file_inode(iocb->ki_filp));
 	if (!task)
 		return -ESRCH;
 	mm = get_task_mm(task);
@@ -1318,7 +1318,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 }
 
 const struct file_operations proc_clear_refs_operations = {
-	.write		= clear_refs_write,
+	.write_iter	= clear_refs_write,
 	.llseek		= noop_llseek,
 };
 
@@ -1645,10 +1645,10 @@ static const struct mm_walk_ops pagemap_ops = {
  * determine which areas of memory are actually mapped and llseek to
  * skip over unmapped regions.
  */
-static ssize_t pagemap_read(struct file *file, char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t pagemap_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mm_struct *mm = file->private_data;
+	struct mm_struct *mm = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct pagemapread pm;
 	unsigned long src;
 	unsigned long svpfn;
@@ -1661,7 +1661,7 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 
 	ret = -EINVAL;
 	/* file position must be aligned */
-	if ((*ppos % PM_ENTRY_BYTES) || (count % PM_ENTRY_BYTES))
+	if ((iocb->ki_pos % PM_ENTRY_BYTES) || (count % PM_ENTRY_BYTES))
 		goto out_mm;
 
 	ret = 0;
@@ -1669,7 +1669,7 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 		goto out_mm;
 
 	/* do not disclose physical addresses: attack vector */
-	pm.show_pfn = file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN);
+	pm.show_pfn = file_ns_capable(iocb->ki_filp, &init_user_ns, CAP_SYS_ADMIN);
 
 	pm.len = (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
 	pm.buffer = kmalloc_array(pm.len, PM_ENTRY_BYTES, GFP_KERNEL);
@@ -1677,7 +1677,7 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 	if (!pm.buffer)
 		goto out_mm;
 
-	src = *ppos;
+	src = iocb->ki_pos;
 	svpfn = src / PM_ENTRY_BYTES;
 	end_vaddr = mm->task_size;
 
@@ -1719,15 +1719,14 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 		start_vaddr = end;
 
 		len = min(count, PM_ENTRY_BYTES * pm.pos);
-		if (copy_to_user(buf, pm.buffer, len)) {
+		if (!copy_to_iter_full(pm.buffer, len, to)) {
 			ret = -EFAULT;
 			goto out_free;
 		}
 		copied += len;
-		buf += len;
 		count -= len;
 	}
-	*ppos += copied;
+	iocb->ki_pos += copied;
 	if (!ret || ret == PM_END_OF_BUFFER)
 		ret = copied;
 
@@ -2518,7 +2517,7 @@ static long do_pagemap_cmd(struct file *file, unsigned int cmd,
 
 const struct file_operations proc_pagemap_operations = {
 	.llseek		= mem_lseek, /* borrow this */
-	.read		= pagemap_read,
+	.read_iter	= pagemap_read,
 	.open		= pagemap_open,
 	.release	= pagemap_release,
 	.unlocked_ioctl = do_pagemap_cmd,
@@ -2787,7 +2786,7 @@ static int pid_numa_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_numa_maps_operations = {
 	.open		= pid_numa_maps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index bce674533000..b1385bf8dd05 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -289,7 +289,7 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_maps_operations = {
 	.open		= pid_maps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= map_release,
 };
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6030a8235617..181ba788a56b 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -174,13 +174,15 @@ static inline void put_user_ns(struct user_namespace *ns)
 }
 
 struct seq_operations;
+struct kiocb;
+struct iov_iter;
 extern const struct seq_operations proc_uid_seq_operations;
 extern const struct seq_operations proc_gid_seq_operations;
 extern const struct seq_operations proc_projid_seq_operations;
-extern ssize_t proc_uid_map_write(struct file *, const char __user *, size_t, loff_t *);
-extern ssize_t proc_gid_map_write(struct file *, const char __user *, size_t, loff_t *);
-extern ssize_t proc_projid_map_write(struct file *, const char __user *, size_t, loff_t *);
-extern ssize_t proc_setgroups_write(struct file *, const char __user *, size_t, loff_t *);
+ssize_t proc_uid_map_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t proc_gid_map_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t proc_projid_map_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t proc_setgroups_write(struct kiocb *iocb, struct iov_iter *from);
 extern int proc_setgroups_show(struct seq_file *m, void *v);
 extern bool userns_may_setgroups(const struct user_namespace *ns);
 extern bool in_userns(const struct user_namespace *ancestor,
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 0b0b95418b16..05ec5be1c2d7 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1108,8 +1108,8 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	return ret;
 }
 
-ssize_t proc_uid_map_write(struct file *file, const char __user *buf,
-			   size_t size, loff_t *ppos)
+static ssize_t proc_uid_map_write(struct file *file, const char __user *buf,
+				  size_t size, loff_t *ppos)
 {
 	struct seq_file *seq = file->private_data;
 	struct user_namespace *ns = seq->private;
@@ -1125,8 +1125,13 @@ ssize_t proc_uid_map_write(struct file *file, const char __user *buf,
 			 &ns->uid_map, &ns->parent->uid_map);
 }
 
-ssize_t proc_gid_map_write(struct file *file, const char __user *buf,
-			   size_t size, loff_t *ppos)
+ssize_t proc_uid_map_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, proc_uid_map_write);
+}
+
+static ssize_t proc_gid_map_write(struct file *file, const char __user *buf,
+				  size_t size, loff_t *ppos)
 {
 	struct seq_file *seq = file->private_data;
 	struct user_namespace *ns = seq->private;
@@ -1142,8 +1147,13 @@ ssize_t proc_gid_map_write(struct file *file, const char __user *buf,
 			 &ns->gid_map, &ns->parent->gid_map);
 }
 
-ssize_t proc_projid_map_write(struct file *file, const char __user *buf,
-			      size_t size, loff_t *ppos)
+ssize_t proc_gid_map_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, proc_gid_map_write);
+}
+
+static ssize_t proc_projid_map_write(struct file *file, const char __user *buf,
+				     size_t size, loff_t *ppos)
 {
 	struct seq_file *seq = file->private_data;
 	struct user_namespace *ns = seq->private;
@@ -1160,6 +1170,11 @@ ssize_t proc_projid_map_write(struct file *file, const char __user *buf,
 			 &ns->projid_map, &ns->parent->projid_map);
 }
 
+ssize_t proc_projid_map_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, proc_projid_map_write);
+}
+
 static bool new_idmap_permitted(const struct file *file,
 				struct user_namespace *ns, int cap_setid,
 				struct uid_gid_map *new_map)
@@ -1213,23 +1228,23 @@ int proc_setgroups_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
-			     size_t count, loff_t *ppos)
+ssize_t proc_setgroups_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *seq = file->private_data;
+	struct seq_file *seq = iocb->ki_filp->private_data;
 	struct user_namespace *ns = seq->private;
+	size_t count = iov_iter_count(from);
 	char kbuf[8], *pos;
 	bool setgroups_allowed;
 	ssize_t ret;
 
 	/* Only allow a very narrow range of strings to be written */
 	ret = -EINVAL;
-	if ((*ppos != 0) || (count >= sizeof(kbuf)))
+	if ((iocb->ki_pos != 0) || (count >= sizeof(kbuf)))
 		goto out;
 
 	/* What was written? */
 	ret = -EFAULT;
-	if (copy_from_user(kbuf, buf, count))
+	if (!copy_from_iter_full(kbuf, count, from))
 		goto out;
 	kbuf[count] = '\0';
 	pos = kbuf;
@@ -1271,7 +1286,7 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 	mutex_unlock(&userns_state_mutex);
 
 	/* Report a successful write */
-	*ppos = count;
+	iocb->ki_pos = count;
 	ret = count;
 out:
 	return ret;
-- 
2.43.0


