Return-Path: <linux-kernel+bounces-140844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBEC8A192F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8B9281F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE6C135415;
	Thu, 11 Apr 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AvIMyT+R"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3E132493
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849644; cv=none; b=p4fY/g6xQGoNcZ5z84MjSd3SlAg32a8I9zmdjFejE/pYmzlRazcJCn17ioMGuBFhaaFaR4McHnKQPJGZLXSFUVJ4c/IsP7fzwqhBd+LM3lg4gEUnIpWvpeRKdBilaoT2LdYvgsMFVvmuJrgxnrDumy8BAvbaY1N/weFnEpF5LsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849644; c=relaxed/simple;
	bh=tTl9JicU9qQjpuuZhE3mdeairZEkh5tZB8cSfmaNHxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HggtLfno9ePsPvBCMF8bldTyl5y7ceiI6+B0M04LOO469W9D7G8k9ruHGCXp7hcBEi/hL+eUed/azv08VTMHiz8xaFzo/UHRdCqYV45FTE2wVtfXhCx46TQd9qayvSicoJTFOpBLig7KUTHf4yR5J3XjqO3NDj1e1KQktpEOUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AvIMyT+R; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a224d7414so178745ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849639; x=1713454439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZbq7P9YraOmrevJ7TTs3QHfJV+Xj0h81a6eZ8qrRgA=;
        b=AvIMyT+RmZ1nOi67UZq3vQTxZ+DdMc6r1kGkLFS4DXLn5TYfMIoHJG/sMmHrUOUkHR
         iNfl1HaPpAasnU/wTgGygbzQkfhfCQlYg93HYqdc5Eua89Pvj+uiE4pfSYwA3WdNQqy/
         PqbvifOvKqpEd0DlqFiqXVqJccZz4KTftwf1mHxGeVhTdteefjo7wjiLCqKPkOtfwns7
         cbym2q8lpZvV/MxYUID76tQMmfnFVqpL/u+bo8xHsZPZa1Mpf1aOhF66t8neFRT8yvcu
         qnShcbn8YsfATemEmuRAcu0by3VL8dlUUNMLU+PGdtLM4aVCho/rgzSg1ZRbMhHoc/Mv
         AbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849639; x=1713454439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZbq7P9YraOmrevJ7TTs3QHfJV+Xj0h81a6eZ8qrRgA=;
        b=E2N2hrh+sWtWQyqWnDfQbmyCk3/yxU5IHNZyWKSmK4YGaHkKF9YHtOOnC9GSpQci1+
         1epIKiC8BlMFRzoIjvZ30f/LbpROZG2q0ci/kAh/PxSGhRo/4kQ3Hl5EQj9TUD4cU9F5
         zNKCd+Dwf4FMOO6F6z/e6uzUr4nS6s/F9addZ9Pmmfz+EY1Jd3dm8Wnq21zyPe673352
         B/EOED2eKkOnwY1GUAPrsiHJSkgqJC49A+zTID9NBrM7QVoreIuSNKMs0/Q6iUg7OU5n
         P56/l4BofqFSfX0qlV8iMrkLGPhSyhFejU56kCZKUerprdcO6OrvTpHDQfma8Lkvedgx
         JXLA==
X-Gm-Message-State: AOJu0Yze6elpEsZVYyLCj3lYOqlBUISIKRBPbngiMKuCj9YKqP8vJMMd
	55PVm03c62cntUiV5yrbYraYQptlQbSnw6EJXRitEBI27CoL4+9y69q0xD3XLrFL1BN+LBM2/oX
	L
X-Google-Smtp-Source: AGHT+IGRsrnq4EyfV7abmJtDvS0t9j4G6I3OTelz9m2I1gucUtm3UtK3GRyYy59q0OCOKV+1iZjKyA==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr143702ioc.2.1712849638504;
        Thu, 11 Apr 2024 08:33:58 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 080/437] tracing: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:40 -0600
Message-ID: <20240411153126.16201-81-axboe@kernel.dk>
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
 include/linux/ftrace.h                |  11 +-
 kernel/trace/blktrace.c               |  19 +-
 kernel/trace/ftrace.c                 |  68 +++--
 kernel/trace/trace.c                  | 386 ++++++++++++--------------
 kernel/trace/trace_dynevent.c         |   5 +-
 kernel/trace/trace_events.c           | 116 ++++----
 kernel/trace/trace_events_hist.c      |   4 +-
 kernel/trace/trace_events_inject.c    |  19 +-
 kernel/trace/trace_events_synth.c     |   5 +-
 kernel/trace/trace_events_trigger.c   |  22 +-
 kernel/trace/trace_events_user.c      |  17 +-
 kernel/trace/trace_functions_graph.c  |  20 +-
 kernel/trace/trace_hwlat.c            |  20 +-
 kernel/trace/trace_kprobe.c           |   7 +-
 kernel/trace/trace_osnoise.c          |  42 ++-
 kernel/trace/trace_printk.c           |   2 +-
 kernel/trace/trace_recursion_record.c |  10 +-
 kernel/trace/trace_sched_switch.c     |  21 +-
 kernel/trace/trace_stack.c            |  27 +-
 kernel/trace/trace_stat.c             |   2 +-
 kernel/trace/trace_uprobe.c           |   7 +-
 21 files changed, 378 insertions(+), 452 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 54d53f345d14..468db649094b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -674,10 +674,8 @@ extern ftrace_func_t ftrace_trace_function;
 
 int ftrace_regex_open(struct ftrace_ops *ops, int flag,
 		  struct inode *inode, struct file *file);
-ssize_t ftrace_filter_write(struct file *file, const char __user *ubuf,
-			    size_t cnt, loff_t *ppos);
-ssize_t ftrace_notrace_write(struct file *file, const char __user *ubuf,
-			     size_t cnt, loff_t *ppos);
+ssize_t ftrace_filter_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t ftrace_notrace_write_iter(struct kiocb *iocb, struct iov_iter *from);
 int ftrace_regex_release(struct inode *inode, struct file *file);
 
 void __init
@@ -890,8 +888,9 @@ static inline unsigned long ftrace_location(unsigned long ip)
 #define ftrace_free_filter(ops) do { } while (0)
 #define ftrace_ops_set_global_filter(ops) do { } while (0)
 
-static inline ssize_t ftrace_filter_write(struct file *file, const char __user *ubuf,
-			    size_t cnt, loff_t *ppos) { return -ENODEV; }
+static inline ssize_t ftrace_filter_write_iter(struct kiocb *iocb,
+					       struct iov_iter *from)
+{ return -ENODEV; }
 static inline ssize_t ftrace_notrace_write(struct file *file, const char __user *ubuf,
 			     size_t cnt, loff_t *ppos) { return -ENODEV; }
 static inline int
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..737551849daf 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -411,38 +411,37 @@ int blk_trace_remove(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_trace_remove);
 
-static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
-				size_t count, loff_t *ppos)
+static ssize_t blk_dropped_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct blk_trace *bt = filp->private_data;
+	struct blk_trace *bt = iocb->ki_filp->private_data;
 	char buf[16];
 
 	snprintf(buf, sizeof(buf), "%u\n", atomic_read(&bt->dropped));
 
-	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
+	return simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 }
 
 static const struct file_operations blk_dropped_fops = {
 	.owner =	THIS_MODULE,
 	.open =		simple_open,
-	.read =		blk_dropped_read,
+	.read_iter =	blk_dropped_read,
 	.llseek =	default_llseek,
 };
 
-static ssize_t blk_msg_write(struct file *filp, const char __user *buffer,
-				size_t count, loff_t *ppos)
+static ssize_t blk_msg_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char *msg;
 	struct blk_trace *bt;
 
 	if (count >= BLK_TN_MAX_MSG)
 		return -EINVAL;
 
-	msg = memdup_user_nul(buffer, count);
+	msg = iterdup_nul(from, count);
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
-	bt = filp->private_data;
+	bt = iocb->ki_filp->private_data;
 	__blk_trace_note_message(bt, NULL, "%s", msg);
 	kfree(msg);
 
@@ -452,7 +451,7 @@ static ssize_t blk_msg_write(struct file *filp, const char __user *buffer,
 static const struct file_operations blk_msg_fops = {
 	.owner =	THIS_MODULE,
 	.open =		simple_open,
-	.write =	blk_msg_write,
+	.write_iter =	blk_msg_write,
 	.llseek =	noop_llseek,
 };
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..fa9b0bcc7cb1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -909,14 +909,13 @@ static void unregister_ftrace_profiler(void)
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-static ssize_t
-ftrace_profile_write(struct file *filp, const char __user *ubuf,
-		     size_t cnt, loff_t *ppos)
+static ssize_t ftrace_profile_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t cnt = iov_iter_count(from);
 	unsigned long val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtoul_from_iter(from, cnt, 10, &val);
 	if (ret)
 		return ret;
 
@@ -949,26 +948,24 @@ ftrace_profile_write(struct file *filp, const char __user *ubuf,
  out:
 	mutex_unlock(&ftrace_profile_lock);
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
 
-static ssize_t
-ftrace_profile_read(struct file *filp, char __user *ubuf,
-		     size_t cnt, loff_t *ppos)
+static ssize_t ftrace_profile_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[64];		/* big enough to hold a number */
 	int r;
 
 	r = sprintf(buf, "%u\n", ftrace_profile_enabled);
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, r, to);
 }
 
 static const struct file_operations ftrace_profile_fops = {
 	.open		= tracing_open_generic,
-	.read		= ftrace_profile_read,
-	.write		= ftrace_profile_write,
+	.read_iter	= ftrace_profile_read,
+	.write_iter	= ftrace_profile_write,
 	.llseek		= default_llseek,
 };
 
@@ -5204,20 +5201,30 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 	return ret;
 }
 
-ssize_t
+static ssize_t
 ftrace_filter_write(struct file *file, const char __user *ubuf,
 		    size_t cnt, loff_t *ppos)
 {
 	return ftrace_regex_write(file, ubuf, cnt, ppos, 1);
 }
 
-ssize_t
+ssize_t ftrace_filter_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, ftrace_filter_write);
+}
+
+static ssize_t
 ftrace_notrace_write(struct file *file, const char __user *ubuf,
 		     size_t cnt, loff_t *ppos)
 {
 	return ftrace_regex_write(file, ubuf, cnt, ppos, 0);
 }
 
+ssize_t ftrace_notrace_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return vfs_write_iter(iocb, from, ftrace_notrace_write);
+}
+
 static int
 __ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 {
@@ -5937,44 +5944,44 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 
 static const struct file_operations ftrace_avail_fops = {
 	.open = ftrace_avail_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
 
 static const struct file_operations ftrace_enabled_fops = {
 	.open = ftrace_enabled_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
 
 static const struct file_operations ftrace_touched_fops = {
 	.open = ftrace_touched_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
 
 static const struct file_operations ftrace_avail_addrs_fops = {
 	.open = ftrace_avail_addrs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
 
 static const struct file_operations ftrace_filter_fops = {
 	.open = ftrace_filter_open,
-	.read = seq_read,
-	.write = ftrace_filter_write,
+	.read_iter = seq_read_iter,
+	.write_iter = ftrace_filter_write_iter,
 	.llseek = tracing_lseek,
 	.release = ftrace_regex_release,
 };
 
 static const struct file_operations ftrace_notrace_fops = {
 	.open = ftrace_notrace_open,
-	.read = seq_read,
-	.write = ftrace_notrace_write,
+	.read_iter = seq_read_iter,
+	.write_iter = ftrace_notrace_write_iter,
 	.llseek = tracing_lseek,
 	.release = ftrace_regex_release,
 };
@@ -6369,19 +6376,20 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(ftrace_graph_write);
 
 static const struct file_operations ftrace_graph_fops = {
 	.open		= ftrace_graph_open,
-	.read		= seq_read,
-	.write		= ftrace_graph_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= ftrace_graph_write_iter,
 	.llseek		= tracing_lseek,
 	.release	= ftrace_graph_release,
 };
 
 static const struct file_operations ftrace_graph_notrace_fops = {
 	.open		= ftrace_graph_notrace_open,
-	.read		= seq_read,
-	.write		= ftrace_graph_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= ftrace_graph_write_iter,
 	.llseek		= tracing_lseek,
 	.release	= ftrace_graph_release,
 };
@@ -7831,6 +7839,7 @@ ftrace_pid_write(struct file *filp, const char __user *ubuf,
 {
 	return pid_write(filp, ubuf, cnt, ppos, TRACE_PIDS);
 }
+FOPS_WRITE_ITER_HELPER(ftrace_pid_write);
 
 static ssize_t
 ftrace_no_pid_write(struct file *filp, const char __user *ubuf,
@@ -7838,6 +7847,7 @@ ftrace_no_pid_write(struct file *filp, const char __user *ubuf,
 {
 	return pid_write(filp, ubuf, cnt, ppos, TRACE_NO_PIDS);
 }
+FOPS_WRITE_ITER_HELPER(ftrace_no_pid_write);
 
 static int
 ftrace_pid_release(struct inode *inode, struct file *file)
@@ -7851,16 +7861,16 @@ ftrace_pid_release(struct inode *inode, struct file *file)
 
 static const struct file_operations ftrace_pid_fops = {
 	.open		= ftrace_pid_open,
-	.write		= ftrace_pid_write,
-	.read		= seq_read,
+	.write_iter	= ftrace_pid_write_iter,
+	.read_iter	= seq_read_iter,
 	.llseek		= tracing_lseek,
 	.release	= ftrace_pid_release,
 };
 
 static const struct file_operations ftrace_no_pid_fops = {
 	.open		= ftrace_no_pid_open,
-	.write		= ftrace_no_pid_write,
-	.read		= seq_read,
+	.write_iter	= ftrace_no_pid_write_iter,
+	.read_iter	= seq_read_iter,
 	.llseek		= tracing_lseek,
 	.release	= ftrace_pid_release,
 };
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 233d1af39fff..317aa6a5944f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5015,11 +5015,9 @@ static int show_traces_release(struct inode *inode, struct file *file)
 	return seq_release(inode, file);
 }
 
-static ssize_t
-tracing_write_stub(struct file *filp, const char __user *ubuf,
-		   size_t count, loff_t *ppos)
+static ssize_t tracing_write_stub(struct kiocb *iocb, struct iov_iter *to)
 {
-	return count;
+	return iov_iter_count(to);
 }
 
 loff_t tracing_lseek(struct file *file, loff_t offset, int whence)
@@ -5036,26 +5034,24 @@ loff_t tracing_lseek(struct file *file, loff_t offset, int whence)
 
 static const struct file_operations tracing_fops = {
 	.open		= tracing_open,
-	.read		= seq_read,
 	.read_iter	= seq_read_iter,
 	.splice_read	= copy_splice_read,
-	.write		= tracing_write_stub,
+	.write_iter	= tracing_write_stub,
 	.llseek		= tracing_lseek,
 	.release	= tracing_release,
 };
 
 static const struct file_operations show_traces_fops = {
 	.open		= show_traces_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= show_traces_release,
 };
 
-static ssize_t
-tracing_cpumask_read(struct file *filp, char __user *ubuf,
-		     size_t count, loff_t *ppos)
+static ssize_t tracing_cpumask_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct trace_array *tr = file_inode(filp)->i_private;
+	struct trace_array *tr = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(to);
 	char *mask_str;
 	int len;
 
@@ -5071,7 +5067,7 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 		count = -EINVAL;
 		goto out_err;
 	}
-	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
+	count = simple_copy_to_iter(mask_str, &iocb->ki_pos, len, to);
 
 out_err:
 	kfree(mask_str);
@@ -5147,11 +5143,12 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 
 	return err;
 }
+FOPS_WRITE_ITER_HELPER(tracing_cpumask_write);
 
 static const struct file_operations tracing_cpumask_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= tracing_cpumask_read,
-	.write		= tracing_cpumask_write,
+	.read_iter	= tracing_cpumask_read,
+	.write_iter	= tracing_cpumask_write_iter,
 	.release	= tracing_release_generic_tr,
 	.llseek		= generic_file_llseek,
 };
@@ -5343,19 +5340,19 @@ static void __init apply_trace_boot_options(void)
 	}
 }
 
-static ssize_t
-tracing_trace_options_write(struct file *filp, const char __user *ubuf,
-			size_t cnt, loff_t *ppos)
+static ssize_t tracing_trace_options_write(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct seq_file *m = filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct trace_array *tr = m->private;
+	size_t cnt = iov_iter_count(from);
 	char buf[64];
 	int ret;
 
 	if (cnt >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, ubuf, cnt))
+	if (!copy_from_iter_full(buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = 0;
@@ -5364,7 +5361,7 @@ tracing_trace_options_write(struct file *filp, const char __user *ubuf,
 	if (ret < 0)
 		return ret;
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
@@ -5387,10 +5384,10 @@ static int tracing_trace_options_open(struct inode *inode, struct file *file)
 
 static const struct file_operations tracing_iter_fops = {
 	.open		= tracing_trace_options_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= tracing_single_release_tr,
-	.write		= tracing_trace_options_write,
+	.write_iter	= tracing_trace_options_write,
 };
 
 static const char readme_msg[] =
@@ -5685,17 +5682,15 @@ static const char readme_msg[] =
 #endif
 ;
 
-static ssize_t
-tracing_readme_read(struct file *filp, char __user *ubuf,
-		       size_t cnt, loff_t *ppos)
+static ssize_t tracing_readme_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(ubuf, cnt, ppos,
-					readme_msg, strlen(readme_msg));
+	return simple_copy_to_iter(readme_msg, &iocb->ki_pos,
+				   strlen(readme_msg), to);
 }
 
 static const struct file_operations tracing_readme_fops = {
 	.open		= tracing_open_generic,
-	.read		= tracing_readme_read,
+	.read_iter	= tracing_readme_read,
 	.llseek		= generic_file_llseek,
 };
 
@@ -5787,7 +5782,7 @@ static int tracing_eval_map_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations tracing_eval_map_fops = {
 	.open		= tracing_eval_map_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -5876,11 +5871,9 @@ static void trace_insert_eval_map(struct module *mod,
 	trace_insert_eval_map_file(mod, start, len);
 }
 
-static ssize_t
-tracing_set_trace_read(struct file *filp, char __user *ubuf,
-		       size_t cnt, loff_t *ppos)
+static ssize_t tracing_set_trace_read(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
 	char buf[MAX_TRACER_SIZE+2];
 	int r;
 
@@ -5888,7 +5881,7 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 	r = sprintf(buf, "%s\n", tr->current_trace->name);
 	mutex_unlock(&trace_types_lock);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	return simple_copy_from_iter(buf, &iocb->ki_pos, r, from);
 }
 
 int tracer_init(struct tracer *t, struct trace_array *tr)
@@ -6207,11 +6200,11 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	return ret;
 }
 
-static ssize_t
-tracing_set_trace_write(struct file *filp, const char __user *ubuf,
-			size_t cnt, loff_t *ppos)
+static ssize_t tracing_set_trace_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
+	size_t cnt = iov_iter_count(from);
 	char buf[MAX_TRACER_SIZE+1];
 	char *name;
 	size_t ret;
@@ -6222,7 +6215,7 @@ tracing_set_trace_write(struct file *filp, const char __user *ubuf,
 	if (cnt > MAX_TRACER_SIZE)
 		cnt = MAX_TRACER_SIZE;
 
-	if (copy_from_user(buf, ubuf, cnt))
+	if (!copy_from_iter_full(buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = 0;
@@ -6233,14 +6226,13 @@ tracing_set_trace_write(struct file *filp, const char __user *ubuf,
 	if (err)
 		return err;
 
-	*ppos += ret;
+	iocb->ki_pos += ret;
 
 	return ret;
 }
 
 static ssize_t
-tracing_nsecs_read(unsigned long *ptr, char __user *ubuf,
-		   size_t cnt, loff_t *ppos)
+tracing_nsecs_read(unsigned long *ptr, struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[64];
 	int r;
@@ -6249,17 +6241,18 @@ tracing_nsecs_read(unsigned long *ptr, char __user *ubuf,
 		     *ptr == (unsigned long)-1 ? -1 : nsecs_to_usecs(*ptr));
 	if (r > sizeof(buf))
 		r = sizeof(buf);
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, r, to);
 }
 
 static ssize_t
-tracing_nsecs_write(unsigned long *ptr, const char __user *ubuf,
-		    size_t cnt, loff_t *ppos)
+tracing_nsecs_write(unsigned long *ptr, struct kiocb *iocb,
+		    struct iov_iter *from)
 {
+	size_t cnt = iov_iter_count(from);
 	unsigned long val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtoul_from_iter(from, cnt, 10, &val);
 	if (ret)
 		return ret;
 
@@ -6268,22 +6261,19 @@ tracing_nsecs_write(unsigned long *ptr, const char __user *ubuf,
 	return cnt;
 }
 
-static ssize_t
-tracing_thresh_read(struct file *filp, char __user *ubuf,
-		    size_t cnt, loff_t *ppos)
+static ssize_t tracing_thresh_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return tracing_nsecs_read(&tracing_thresh, ubuf, cnt, ppos);
+	return tracing_nsecs_read(&tracing_thresh, iocb, to);
 }
 
-static ssize_t
-tracing_thresh_write(struct file *filp, const char __user *ubuf,
-		     size_t cnt, loff_t *ppos)
+static ssize_t tracing_thresh_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
+	size_t cnt = iov_iter_count(from);
 	int ret;
 
 	mutex_lock(&trace_types_lock);
-	ret = tracing_nsecs_write(&tracing_thresh, ubuf, cnt, ppos);
+	ret = tracing_nsecs_write(&tracing_thresh, iocb, from);
 	if (ret < 0)
 		goto out;
 
@@ -6302,22 +6292,18 @@ tracing_thresh_write(struct file *filp, const char __user *ubuf,
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 
-static ssize_t
-tracing_max_lat_read(struct file *filp, char __user *ubuf,
-		     size_t cnt, loff_t *ppos)
+static ssize_t tracing_max_lat_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
 
-	return tracing_nsecs_read(&tr->max_latency, ubuf, cnt, ppos);
+	return tracing_nsecs_read(&tr->max_latency, iocb, to);
 }
 
-static ssize_t
-tracing_max_lat_write(struct file *filp, const char __user *ubuf,
-		      size_t cnt, loff_t *ppos)
+static ssize_t tracing_max_lat_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
 
-	return tracing_nsecs_write(&tr->max_latency, ubuf, cnt, ppos);
+	return tracing_nsecs_write(&tr->max_latency, iocb, from);
 }
 
 #endif
@@ -6609,6 +6595,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 
 	return sret;
 }
+FOPS_READ_ITER_HELPER(tracing_read_pipe);
 
 static void tracing_spd_release_pipe(struct splice_pipe_desc *spd,
 				     unsigned int idx)
@@ -6749,16 +6736,13 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 	goto out;
 }
 
-static ssize_t
-tracing_entries_read(struct file *filp, char __user *ubuf,
-		     size_t cnt, loff_t *ppos)
+static ssize_t tracing_entries_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct inode *inode = file_inode(filp);
+	struct inode *inode = file_inode(iocb->ki_filp);
 	struct trace_array *tr = inode->i_private;
 	int cpu = tracing_get_cpu(inode);
 	char buf[64];
 	int r = 0;
-	ssize_t ret;
 
 	mutex_lock(&trace_types_lock);
 
@@ -6792,21 +6776,18 @@ tracing_entries_read(struct file *filp, char __user *ubuf,
 		r = sprintf(buf, "%lu\n", per_cpu_ptr(tr->array_buffer.data, cpu)->entries >> 10);
 
 	mutex_unlock(&trace_types_lock);
-
-	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
-	return ret;
+	return simple_copy_to_iter(buf, &iocb->ki_pos, r, to);
 }
 
-static ssize_t
-tracing_entries_write(struct file *filp, const char __user *ubuf,
-		      size_t cnt, loff_t *ppos)
+static ssize_t tracing_entries_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(filp);
+	struct inode *inode = file_inode(iocb->ki_filp);
 	struct trace_array *tr = inode->i_private;
+	size_t cnt = iov_iter_count(from);
 	unsigned long val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtoul_from_iter(from, cnt, 10, &val);
 	if (ret)
 		return ret;
 
@@ -6820,16 +6801,15 @@ tracing_entries_write(struct file *filp, const char __user *ubuf,
 	if (ret < 0)
 		return ret;
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
 
 static ssize_t
-tracing_total_entries_read(struct file *filp, char __user *ubuf,
-				size_t cnt, loff_t *ppos)
+tracing_total_entries_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
 	char buf[64];
 	int r, cpu;
 	unsigned long size = 0, expanded_size = 0;
@@ -6846,19 +6826,20 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
 		r = sprintf(buf, "%lu (expanded: %lu)\n", size, expanded_size);
 	mutex_unlock(&trace_types_lock);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, r, to);
 }
 
 static ssize_t
-tracing_free_buffer_write(struct file *filp, const char __user *ubuf,
-			  size_t cnt, loff_t *ppos)
+tracing_free_buffer_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t cnt = iov_iter_count(from);
+
 	/*
 	 * There is no need to read what the user has written, this function
 	 * is just to make sure that there is no error when "echo" is used
 	 */
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
@@ -6974,6 +6955,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 
 	return written;
 }
+FOPS_WRITE_ITER_HELPER(tracing_mark_write);
 
 static ssize_t
 tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
@@ -7028,6 +7010,7 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 
 	return written;
 }
+FOPS_WRITE_ITER_HELPER(tracing_mark_raw_write);
 
 static int tracing_clock_show(struct seq_file *m, void *v)
 {
@@ -7078,11 +7061,11 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 	return 0;
 }
 
-static ssize_t tracing_clock_write(struct file *filp, const char __user *ubuf,
-				   size_t cnt, loff_t *fpos)
+static ssize_t tracing_clock_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct trace_array *tr = m->private;
+	size_t cnt = iov_iter_count(from);
 	char buf[64];
 	const char *clockstr;
 	int ret;
@@ -7090,7 +7073,7 @@ static ssize_t tracing_clock_write(struct file *filp, const char __user *ubuf,
 	if (cnt >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, ubuf, cnt))
+	if (!copy_from_iter(buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = 0;
@@ -7101,7 +7084,7 @@ static ssize_t tracing_clock_write(struct file *filp, const char __user *ubuf,
 	if (ret)
 		return ret;
 
-	*fpos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
@@ -7331,6 +7314,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	mutex_unlock(&trace_types_lock);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(tracing_snapshot_write);
 
 static int tracing_snapshot_release(struct inode *inode, struct file *file)
 {
@@ -7351,8 +7335,7 @@ static int tracing_snapshot_release(struct inode *inode, struct file *file)
 }
 
 static int tracing_buffers_open(struct inode *inode, struct file *filp);
-static ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
-				    size_t count, loff_t *ppos);
+static ssize_t tracing_buffers_read(struct kiocb *iocb, struct iov_iter *to);
 static int tracing_buffers_release(struct inode *inode, struct file *file);
 static ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		   struct pipe_inode_info *pipe, size_t len, unsigned int flags);
@@ -7385,16 +7368,16 @@ static int snapshot_raw_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations tracing_thresh_fops = {
 	.open		= tracing_open_generic,
-	.read		= tracing_thresh_read,
-	.write		= tracing_thresh_write,
+	.read_iter	= tracing_thresh_read,
+	.write_iter	= tracing_thresh_write,
 	.llseek		= generic_file_llseek,
 };
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 static const struct file_operations tracing_max_lat_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= tracing_max_lat_read,
-	.write		= tracing_max_lat_write,
+	.read_iter	= tracing_max_lat_read,
+	.write_iter	= tracing_max_lat_write,
 	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
@@ -7402,8 +7385,8 @@ static const struct file_operations tracing_max_lat_fops = {
 
 static const struct file_operations set_tracer_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= tracing_set_trace_read,
-	.write		= tracing_set_trace_write,
+	.read_iter	= tracing_set_trace_read,
+	.write_iter	= tracing_set_trace_write,
 	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
@@ -7411,7 +7394,7 @@ static const struct file_operations set_tracer_fops = {
 static const struct file_operations tracing_pipe_fops = {
 	.open		= tracing_open_pipe,
 	.poll		= tracing_poll_pipe,
-	.read		= tracing_read_pipe,
+	.read_iter	= tracing_read_pipe_iter,
 	.splice_read	= tracing_splice_read_pipe,
 	.release	= tracing_release_pipe,
 	.llseek		= no_llseek,
@@ -7419,48 +7402,48 @@ static const struct file_operations tracing_pipe_fops = {
 
 static const struct file_operations tracing_entries_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= tracing_entries_read,
-	.write		= tracing_entries_write,
+	.read_iter	= tracing_entries_read,
+	.write_iter	= tracing_entries_write,
 	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
 
 static const struct file_operations tracing_total_entries_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= tracing_total_entries_read,
+	.read_iter	= tracing_total_entries_read,
 	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
 
 static const struct file_operations tracing_free_buffer_fops = {
 	.open		= tracing_open_generic_tr,
-	.write		= tracing_free_buffer_write,
+	.write_iter	= tracing_free_buffer_write,
 	.release	= tracing_free_buffer_release,
 };
 
 static const struct file_operations tracing_mark_fops = {
 	.open		= tracing_mark_open,
-	.write		= tracing_mark_write,
+	.write_iter	= tracing_mark_write_iter,
 	.release	= tracing_release_generic_tr,
 };
 
 static const struct file_operations tracing_mark_raw_fops = {
 	.open		= tracing_mark_open,
-	.write		= tracing_mark_raw_write,
+	.write_iter	= tracing_mark_raw_write_iter,
 	.release	= tracing_release_generic_tr,
 };
 
 static const struct file_operations trace_clock_fops = {
 	.open		= tracing_clock_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= tracing_single_release_tr,
-	.write		= tracing_clock_write,
+	.write_iter	= tracing_clock_write,
 };
 
 static const struct file_operations trace_time_stamp_mode_fops = {
 	.open		= tracing_time_stamp_mode_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= tracing_single_release_tr,
 };
@@ -7468,15 +7451,15 @@ static const struct file_operations trace_time_stamp_mode_fops = {
 #ifdef CONFIG_TRACER_SNAPSHOT
 static const struct file_operations snapshot_fops = {
 	.open		= tracing_snapshot_open,
-	.read		= seq_read,
-	.write		= tracing_snapshot_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= tracing_snapshot_write_iter,
 	.llseek		= tracing_lseek,
 	.release	= tracing_snapshot_release,
 };
 
 static const struct file_operations snapshot_raw_fops = {
 	.open		= snapshot_raw_open,
-	.read		= tracing_buffers_read,
+	.read_iter	= tracing_buffers_read,
 	.release	= tracing_buffers_release,
 	.splice_read	= tracing_buffers_splice_read,
 	.llseek		= no_llseek,
@@ -7496,17 +7479,17 @@ static const struct file_operations snapshot_raw_fops = {
  * defines where to write the value, the min and the max acceptable values,
  * and a lock to protect the write.
  */
-static ssize_t
-trace_min_max_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
+static ssize_t trace_min_max_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct trace_min_max_param *param = filp->private_data;
+	struct trace_min_max_param *param = iocb->ki_filp->private_data;
+	size_t cnt = iov_iter_count(from);
 	u64 val;
 	int err;
 
 	if (!param)
 		return -EFAULT;
 
-	err = kstrtoull_from_user(ubuf, cnt, 10, &val);
+	err = kstrtoull_from_iter(from, cnt, 10, &val);
 	if (err)
 		return err;
 
@@ -7542,10 +7525,10 @@ trace_min_max_write(struct file *filp, const char __user *ubuf, size_t cnt, loff
  * The filp->private_data must point to a trace_min_max_param struct with valid
  * data.
  */
-static ssize_t
-trace_min_max_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+static ssize_t trace_min_max_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct trace_min_max_param *param = filp->private_data;
+	struct trace_min_max_param *param = iocb->ki_filp->private_data;
+	size_t cnt = iov_iter_count(to);
 	char buf[U64_STR_SIZE];
 	int len;
 	u64 val;
@@ -7560,13 +7543,13 @@ trace_min_max_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppo
 
 	len = snprintf(buf, sizeof(buf), "%llu\n", val);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 const struct file_operations trace_min_max_fops = {
 	.open		= tracing_open_generic,
-	.read		= trace_min_max_read,
-	.write		= trace_min_max_write,
+	.read_iter	= trace_min_max_read,
+	.write_iter	= trace_min_max_write,
 };
 
 #define TRACING_LOG_ERRS_MAX	8
@@ -7818,11 +7801,9 @@ static int tracing_err_log_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static ssize_t tracing_err_log_write(struct file *file,
-				     const char __user *buffer,
-				     size_t count, loff_t *ppos)
+static ssize_t tracing_err_log_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	return count;
+	return iov_iter_count(from);
 }
 
 static int tracing_err_log_release(struct inode *inode, struct file *file)
@@ -7839,8 +7820,8 @@ static int tracing_err_log_release(struct inode *inode, struct file *file)
 
 static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
-	.write		= tracing_err_log_write,
-	.read           = seq_read,
+	.write_iter	= tracing_err_log_write,
+	.read_iter      = seq_read_iter,
 	.llseek         = tracing_lseek,
 	.release        = tracing_err_log_release,
 };
@@ -7893,12 +7874,11 @@ tracing_buffers_poll(struct file *filp, poll_table *poll_table)
 	return trace_poll(iter, filp, poll_table);
 }
 
-static ssize_t
-tracing_buffers_read(struct file *filp, char __user *ubuf,
-		     size_t count, loff_t *ppos)
+static ssize_t tracing_buffers_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ftrace_buffer_info *info = filp->private_data;
+	struct ftrace_buffer_info *info = iocb->ki_filp->private_data;
 	struct trace_iterator *iter = &info->iter;
+	size_t count = iov_iter_count(to);
 	void *trace_data;
 	int page_size;
 	ssize_t ret = 0;
@@ -7951,7 +7931,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 
 	if (ret < 0) {
 		if (trace_empty(iter)) {
-			if ((filp->f_flags & O_NONBLOCK))
+			if (iocb->ki_filp->f_flags & O_NONBLOCK)
 				return -EAGAIN;
 
 			ret = wait_on_pipe(iter, 0);
@@ -7969,13 +7949,13 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	if (size > count)
 		size = count;
 	trace_data = ring_buffer_read_page_data(info->spare);
-	ret = copy_to_user(ubuf, trace_data + info->read, size);
+	ret = copy_to_iter(trace_data + info->read, size, to);
 	if (ret == size)
 		return -EFAULT;
 
 	size -= ret;
 
-	*ppos += size;
+	iocb->ki_pos += size;
 	info->read += size;
 
 	return size;
@@ -8216,7 +8196,7 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
-	.read		= tracing_buffers_read,
+	.read_iter	= tracing_buffers_read,
 	.poll		= tracing_buffers_poll,
 	.release	= tracing_buffers_release,
 	.flush		= tracing_buffers_flush,
@@ -8225,11 +8205,9 @@ static const struct file_operations tracing_buffers_fops = {
 	.llseek		= no_llseek,
 };
 
-static ssize_t
-tracing_stats_read(struct file *filp, char __user *ubuf,
-		   size_t count, loff_t *ppos)
+static ssize_t tracing_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct inode *inode = file_inode(filp);
+	struct inode *inode = file_inode(iocb->ki_filp);
 	struct trace_array *tr = inode->i_private;
 	struct array_buffer *trace_buf = &tr->array_buffer;
 	int cpu = tracing_get_cpu(inode);
@@ -8237,6 +8215,7 @@ tracing_stats_read(struct file *filp, char __user *ubuf,
 	unsigned long cnt;
 	unsigned long long t;
 	unsigned long usec_rem;
+	ssize_t count;
 
 	s = kmalloc(sizeof(*s), GFP_KERNEL);
 	if (!s)
@@ -8281,17 +8260,15 @@ tracing_stats_read(struct file *filp, char __user *ubuf,
 	cnt = ring_buffer_read_events_cpu(trace_buf->buffer, cpu);
 	trace_seq_printf(s, "read events: %ld\n", cnt);
 
-	count = simple_read_from_buffer(ubuf, count, ppos,
-					s->buffer, trace_seq_used(s));
-
+	count = simple_copy_to_iter(s->buffer, &iocb->ki_pos, trace_seq_used(s),
+					to);
 	kfree(s);
-
 	return count;
 }
 
 static const struct file_operations tracing_stats_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= tracing_stats_read,
+	.read_iter	= tracing_stats_read,
 	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
@@ -8299,8 +8276,7 @@ static const struct file_operations tracing_stats_fops = {
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 static ssize_t
-tracing_read_dyn_info(struct file *filp, char __user *ubuf,
-		  size_t cnt, loff_t *ppos)
+tracing_read_dyn_info(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret;
 	char *buf;
@@ -8316,14 +8292,14 @@ tracing_read_dyn_info(struct file *filp, char __user *ubuf,
 		      ftrace_number_of_pages,
 		      ftrace_number_of_groups);
 
-	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, r, to);
 	kfree(buf);
 	return ret;
 }
 
 static const struct file_operations tracing_dyn_info_fops = {
 	.open		= tracing_open_generic,
-	.read		= tracing_read_dyn_info,
+	.read_iter	= tracing_read_dyn_info,
 	.llseek		= generic_file_llseek,
 };
 #endif /* CONFIG_DYNAMIC_FTRACE */
@@ -8583,11 +8559,9 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 #include "trace_selftest.c"
 #endif
 
-static ssize_t
-trace_options_read(struct file *filp, char __user *ubuf, size_t cnt,
-			loff_t *ppos)
+static ssize_t trace_options_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct trace_option_dentry *topt = filp->private_data;
+	struct trace_option_dentry *topt = iocb->ki_filp->private_data;
 	char *buf;
 
 	if (topt->flags->val & topt->opt->bit)
@@ -8595,18 +8569,17 @@ trace_options_read(struct file *filp, char __user *ubuf, size_t cnt,
 	else
 		buf = "0\n";
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
-static ssize_t
-trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
-			 loff_t *ppos)
+static ssize_t trace_options_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct trace_option_dentry *topt = filp->private_data;
+	struct trace_option_dentry *topt = iocb->ki_filp->private_data;
+	size_t cnt = iov_iter_count(from);
 	unsigned long val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtoul_from_iter(from, cnt, 10, &val);
 	if (ret)
 		return ret;
 
@@ -8622,7 +8595,7 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			return ret;
 	}
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
@@ -8650,8 +8623,8 @@ static int tracing_release_options(struct inode *inode, struct file *file)
 
 static const struct file_operations trace_options_fops = {
 	.open = tracing_open_options,
-	.read = trace_options_read,
-	.write = trace_options_write,
+	.read_iter = trace_options_read,
+	.write_iter = trace_options_write,
 	.llseek	= generic_file_llseek,
 	.release = tracing_release_options,
 };
@@ -8689,11 +8662,9 @@ static void get_tr_index(void *data, struct trace_array **ptr,
 			    trace_flags_index);
 }
 
-static ssize_t
-trace_options_core_read(struct file *filp, char __user *ubuf, size_t cnt,
-			loff_t *ppos)
+static ssize_t trace_options_core_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	void *tr_index = filp->private_data;
+	void *tr_index = iocb->ki_filp->private_data;
 	struct trace_array *tr;
 	unsigned int index;
 	char *buf;
@@ -8705,14 +8676,14 @@ trace_options_core_read(struct file *filp, char __user *ubuf, size_t cnt,
 	else
 		buf = "0\n";
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, 2);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
 static ssize_t
-trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
-			 loff_t *ppos)
+trace_options_core_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	void *tr_index = filp->private_data;
+	void *tr_index = iocb->ki_filp->private_data;
+	size_t cnt = iov_iter_count(from);
 	struct trace_array *tr;
 	unsigned int index;
 	unsigned long val;
@@ -8720,7 +8691,7 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	get_tr_index(tr_index, &tr, &index);
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtoul_from_iter(from, cnt, 10, &val);
 	if (ret)
 		return ret;
 
@@ -8736,15 +8707,15 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (ret < 0)
 		return ret;
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
 
 static const struct file_operations trace_options_core_fops = {
 	.open = tracing_open_generic,
-	.read = trace_options_core_read,
-	.write = trace_options_core_write,
+	.read_iter = trace_options_core_read,
+	.write_iter = trace_options_core_write,
 	.llseek = generic_file_llseek,
 };
 
@@ -8898,30 +8869,27 @@ static void create_trace_options_dir(struct trace_array *tr)
 	}
 }
 
-static ssize_t
-rb_simple_read(struct file *filp, char __user *ubuf,
-	       size_t cnt, loff_t *ppos)
+static ssize_t rb_simple_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
 	char buf[64];
 	int r;
 
 	r = tracer_tracing_is_on(tr);
 	r = sprintf(buf, "%d\n", r);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, r, to);
 }
 
-static ssize_t
-rb_simple_write(struct file *filp, const char __user *ubuf,
-		size_t cnt, loff_t *ppos)
+static ssize_t rb_simple_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	size_t cnt = iov_iter_count(from);
 	unsigned long val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtoul_from_iter(from, cnt, 10, &val);
 	if (ret)
 		return ret;
 
@@ -8943,42 +8911,39 @@ rb_simple_write(struct file *filp, const char __user *ubuf,
 		mutex_unlock(&trace_types_lock);
 	}
 
-	(*ppos)++;
+	iocb->ki_pos++;
 
 	return cnt;
 }
 
 static const struct file_operations rb_simple_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= rb_simple_read,
-	.write		= rb_simple_write,
+	.read_iter	= rb_simple_read,
+	.write_iter	= rb_simple_write,
 	.release	= tracing_release_generic_tr,
 	.llseek		= default_llseek,
 };
 
-static ssize_t
-buffer_percent_read(struct file *filp, char __user *ubuf,
-		    size_t cnt, loff_t *ppos)
+static ssize_t buffer_percent_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
 	char buf[64];
 	int r;
 
 	r = tr->buffer_percent;
 	r = sprintf(buf, "%d\n", r);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, r, to);
 }
 
-static ssize_t
-buffer_percent_write(struct file *filp, const char __user *ubuf,
-		     size_t cnt, loff_t *ppos)
+static ssize_t buffer_percent_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
+	size_t cnt = iov_iter_count(from);
 	unsigned long val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtoul_from_iter(from, cnt, 10, &val);
 	if (ret)
 		return ret;
 
@@ -8987,23 +8952,22 @@ buffer_percent_write(struct file *filp, const char __user *ubuf,
 
 	tr->buffer_percent = val;
 
-	(*ppos)++;
+	iocb->ki_pos++;
 
 	return cnt;
 }
 
 static const struct file_operations buffer_percent_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= buffer_percent_read,
-	.write		= buffer_percent_write,
+	.read_iter	= buffer_percent_read,
+	.write_iter	= buffer_percent_write,
 	.release	= tracing_release_generic_tr,
 	.llseek		= default_llseek,
 };
 
-static ssize_t
-buffer_subbuf_size_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+static ssize_t buffer_subbuf_size_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
 	size_t size;
 	char buf[64];
 	int order;
@@ -9014,21 +8978,21 @@ buffer_subbuf_size_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t
 
 	r = sprintf(buf, "%zd\n", size);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, r, to);
 }
 
 static ssize_t
-buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
-			 size_t cnt, loff_t *ppos)
+buffer_subbuf_size_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
+	size_t cnt = iov_iter_count(from);
 	unsigned long val;
 	int old_order;
 	int order;
 	int pages;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtoul_from_iter(from, cnt, 10, &val);
 	if (ret)
 		return ret;
 
@@ -9081,7 +9045,7 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	}
  out_max:
 #endif
-	(*ppos)++;
+	iocb->ki_pos++;
  out:
 	if (ret)
 		cnt = ret;
@@ -9091,8 +9055,8 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 
 static const struct file_operations buffer_subbuf_size_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= buffer_subbuf_size_read,
-	.write		= buffer_subbuf_size_write,
+	.read_iter	= buffer_subbuf_size_read,
+	.write_iter	= buffer_subbuf_size_write,
 	.release	= tracing_release_generic_tr,
 	.llseek		= default_llseek,
 };
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4376887e0d8a..cea3f5947025 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -244,14 +244,15 @@ static ssize_t dyn_event_write(struct file *file, const char __user *buffer,
 	return trace_parse_run_command(file, buffer, count, ppos,
 				       create_dyn_event);
 }
+FOPS_WRITE_ITER_HELPER(dyn_event_write);
 
 static const struct file_operations dynamic_events_ops = {
 	.owner          = THIS_MODULE,
 	.open           = dyn_event_open,
-	.read           = seq_read,
+	.read_iter      = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = seq_release,
-	.write		= dyn_event_write,
+	.write_iter	= dyn_event_write_iter,
 };
 
 /* Make a tracefs interface for controlling dynamic events */
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7c364b87352e..bc1bfc3f387c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1215,6 +1215,7 @@ ftrace_event_write(struct file *file, const char __user *ubuf,
 
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(ftrace_event_write);
 
 static void *
 t_next(struct seq_file *m, void *v, loff_t *pos)
@@ -1377,16 +1378,14 @@ static void p_stop(struct seq_file *m, void *p)
 	mutex_unlock(&event_mutex);
 }
 
-static ssize_t
-event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
-		  loff_t *ppos)
+static ssize_t event_enable_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct trace_event_file *file;
 	unsigned long flags;
 	char buf[4] = "0";
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
+	file = event_file_data(iocb->ki_filp);
 	if (likely(file))
 		flags = file->flags;
 	mutex_unlock(&event_mutex);
@@ -1404,7 +1403,7 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 
 	strcat(buf, "\n");
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, strlen(buf));
+	return simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 }
 
 static ssize_t
@@ -1444,20 +1443,18 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	return ret ? ret : cnt;
 }
+FOPS_WRITE_ITER_HELPER(event_enable_write);
 
-static ssize_t
-system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
-		   loff_t *ppos)
+static ssize_t system_enable_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	const char set_to_char[4] = { '?', '0', '1', 'X' };
-	struct trace_subsystem_dir *dir = filp->private_data;
+	struct trace_subsystem_dir *dir = iocb->ki_filp->private_data;
 	struct event_subsystem *system = dir->subsystem;
 	struct trace_event_call *call;
 	struct trace_event_file *file;
 	struct trace_array *tr = dir->tr;
 	char buf[2];
 	int set = 0;
-	int ret;
 
 	mutex_lock(&event_mutex);
 	list_for_each_entry(file, &tr->events, list) {
@@ -1487,9 +1484,7 @@ system_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	buf[0] = set_to_char[set];
 	buf[1] = '\n';
 
-	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, 2);
-
-	return ret;
+	return simple_copy_to_iter(buf, &iocb->ki_pos, 2, to);
 }
 
 static ssize_t
@@ -1531,6 +1526,7 @@ system_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(system_enable_write);
 
 enum {
 	FORMAT_HEADER		= 1,
@@ -1670,10 +1666,9 @@ static int trace_format_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t
-event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+static ssize_t event_id_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	int id = (long)event_file_data(filp);
+	int id = (long)event_file_data(iocb->ki_filp);
 	char buf[32];
 	int len;
 
@@ -1682,18 +1677,16 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 
 	len = sprintf(buf, "%d\n", id);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t
-event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
-		  loff_t *ppos)
+static ssize_t event_filter_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct trace_event_file *file;
 	struct trace_seq *s;
 	int r = -ENODEV;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	s = kmalloc(sizeof(*s), GFP_KERNEL);
@@ -1704,14 +1697,14 @@ event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 	trace_seq_init(s);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
+	file = event_file_data(iocb->ki_filp);
 	if (file && !(file->flags & EVENT_FILE_FL_FREED))
 		print_event_filter(file, s);
 	mutex_unlock(&event_mutex);
 
 	if (file)
-		r = simple_read_from_buffer(ubuf, cnt, ppos,
-					    s->buffer, trace_seq_used(s));
+		r = simple_copy_to_iter(s->buffer, &iocb->ki_pos,
+					trace_seq_used(s), to);
 
 	kfree(s);
 
@@ -1747,6 +1740,7 @@ event_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	return cnt;
 }
+FOPS_WRITE_ITER_HELPER(event_filter_write);
 
 static LIST_HEAD(event_subsystems);
 
@@ -1840,16 +1834,14 @@ static int subsystem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t
-subsystem_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
-		      loff_t *ppos)
+static ssize_t subsystem_filter_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct trace_subsystem_dir *dir = filp->private_data;
+	struct trace_subsystem_dir *dir = iocb->ki_filp->private_data;
 	struct event_subsystem *system = dir->subsystem;
 	struct trace_seq *s;
 	int r;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	s = kmalloc(sizeof(*s), GFP_KERNEL);
@@ -1859,8 +1851,7 @@ subsystem_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 	trace_seq_init(s);
 
 	print_subsystem_event_filter(system, s);
-	r = simple_read_from_buffer(ubuf, cnt, ppos,
-				    s->buffer, trace_seq_used(s));
+	r = simple_copy_to_iter(s->buffer, &iocb->ki_pos, trace_seq_used(s), to);
 
 	kfree(s);
 
@@ -1891,15 +1882,15 @@ subsystem_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	return cnt;
 }
+FOPS_WRITE_ITER_HELPER(subsystem_filter_write);
 
-static ssize_t
-show_header_page_file(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+static ssize_t show_header_page_file(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct trace_array *tr = filp->private_data;
+	struct trace_array *tr = iocb->ki_filp->private_data;
 	struct trace_seq *s;
 	int r;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	s = kmalloc(sizeof(*s), GFP_KERNEL);
@@ -1909,21 +1900,19 @@ show_header_page_file(struct file *filp, char __user *ubuf, size_t cnt, loff_t *
 	trace_seq_init(s);
 
 	ring_buffer_print_page_header(tr->array_buffer.buffer, s);
-	r = simple_read_from_buffer(ubuf, cnt, ppos,
-				    s->buffer, trace_seq_used(s));
+	r = simple_copy_to_iter(s->buffer, &iocb->ki_pos, trace_seq_used(s), to);
 
 	kfree(s);
 
 	return r;
 }
 
-static ssize_t
-show_header_event_file(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+static ssize_t show_header_event_file(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct trace_seq *s;
 	int r;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	s = kmalloc(sizeof(*s), GFP_KERNEL);
@@ -1933,8 +1922,7 @@ show_header_event_file(struct file *filp, char __user *ubuf, size_t cnt, loff_t
 	trace_seq_init(s);
 
 	ring_buffer_print_entry_header(s);
-	r = simple_read_from_buffer(ubuf, cnt, ppos,
-				    s->buffer, trace_seq_used(s));
+	r = simple_copy_to_iter(s->buffer, &iocb->ki_pos, trace_seq_used(s), to);
 
 	kfree(s);
 
@@ -2064,6 +2052,7 @@ ftrace_event_pid_write(struct file *filp, const char __user *ubuf,
 {
 	return event_pid_write(filp, ubuf, cnt, ppos, TRACE_PIDS);
 }
+FOPS_WRITE_ITER_HELPER(ftrace_event_pid_write);
 
 static ssize_t
 ftrace_event_npid_write(struct file *filp, const char __user *ubuf,
@@ -2071,6 +2060,7 @@ ftrace_event_npid_write(struct file *filp, const char __user *ubuf,
 {
 	return event_pid_write(filp, ubuf, cnt, ppos, TRACE_NO_PIDS);
 }
+FOPS_WRITE_ITER_HELPER(ftrace_event_npid_write);
 
 static int ftrace_event_avail_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_open(struct inode *inode, struct file *file);
@@ -2108,97 +2098,97 @@ static const struct seq_operations show_set_no_pid_seq_ops = {
 
 static const struct file_operations ftrace_avail_fops = {
 	.open = ftrace_event_avail_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
 
 static const struct file_operations ftrace_set_event_fops = {
 	.open = ftrace_event_set_open,
-	.read = seq_read,
-	.write = ftrace_event_write,
+	.read_iter = seq_read_iter,
+	.write_iter = ftrace_event_write_iter,
 	.llseek = seq_lseek,
 	.release = ftrace_event_release,
 };
 
 static const struct file_operations ftrace_set_event_pid_fops = {
 	.open = ftrace_event_set_pid_open,
-	.read = seq_read,
-	.write = ftrace_event_pid_write,
+	.read_iter = seq_read_iter,
+	.write_iter = ftrace_event_pid_write_iter,
 	.llseek = seq_lseek,
 	.release = ftrace_event_release,
 };
 
 static const struct file_operations ftrace_set_event_notrace_pid_fops = {
 	.open = ftrace_event_set_npid_open,
-	.read = seq_read,
-	.write = ftrace_event_npid_write,
+	.read_iter = seq_read_iter,
+	.write_iter = ftrace_event_npid_write_iter,
 	.llseek = seq_lseek,
 	.release = ftrace_event_release,
 };
 
 static const struct file_operations ftrace_enable_fops = {
 	.open = tracing_open_file_tr,
-	.read = event_enable_read,
-	.write = event_enable_write,
+	.read_iter = event_enable_read,
+	.write_iter = event_enable_write_iter,
 	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations ftrace_event_format_fops = {
 	.open = trace_format_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
 
 static const struct file_operations ftrace_event_id_fops = {
-	.read = event_id_read,
+	.read_iter = event_id_read,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations ftrace_event_filter_fops = {
 	.open = tracing_open_file_tr,
-	.read = event_filter_read,
-	.write = event_filter_write,
+	.read_iter = event_filter_read,
+	.write_iter = event_filter_write_iter,
 	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations ftrace_subsystem_filter_fops = {
 	.open = subsystem_open,
-	.read = subsystem_filter_read,
-	.write = subsystem_filter_write,
+	.read_iter = subsystem_filter_read,
+	.write_iter = subsystem_filter_write_iter,
 	.llseek = default_llseek,
 	.release = subsystem_release,
 };
 
 static const struct file_operations ftrace_system_enable_fops = {
 	.open = subsystem_open,
-	.read = system_enable_read,
-	.write = system_enable_write,
+	.read_iter = system_enable_read,
+	.write_iter = system_enable_write_iter,
 	.llseek = default_llseek,
 	.release = subsystem_release,
 };
 
 static const struct file_operations ftrace_tr_enable_fops = {
 	.open = system_tr_open,
-	.read = system_enable_read,
-	.write = system_enable_write,
+	.read_iter = system_enable_read,
+	.write_iter = system_enable_write_iter,
 	.llseek = default_llseek,
 	.release = subsystem_release,
 };
 
 static const struct file_operations ftrace_show_header_page_fops = {
 	.open = tracing_open_generic_tr,
-	.read = show_header_page_file,
+	.read_iter = show_header_page_file,
 	.llseek = default_llseek,
 	.release = tracing_release_generic_tr,
 };
 
 static const struct file_operations ftrace_show_header_event_fops = {
 	.open = tracing_open_generic_tr,
-	.read = show_header_event_file,
+	.read_iter = show_header_event_file,
 	.llseek = default_llseek,
 	.release = tracing_release_generic_tr,
 };
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ece1308d36a..18e8914ffa67 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5633,7 +5633,7 @@ static int event_hist_open(struct inode *inode, struct file *file)
 
 const struct file_operations event_hist_fops = {
 	.open = event_hist_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = tracing_single_release_file_tr,
 };
@@ -5912,7 +5912,7 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 
 const struct file_operations event_hist_debug_fops = {
 	.open = event_hist_debug_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = tracing_single_release_file_tr,
 };
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index 8650562bdaa9..840c3e786968 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -280,10 +280,9 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
 	return entry_size;
 }
 
-static ssize_t
-event_inject_write(struct file *filp, const char __user *ubuf, size_t cnt,
-		   loff_t *ppos)
+static ssize_t event_inject_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t cnt = iov_iter_count(from);
 	struct trace_event_call *call;
 	struct trace_event_file *file;
 	int err = -ENODEV, size;
@@ -293,13 +292,13 @@ event_inject_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (cnt >= PAGE_SIZE)
 		return -EINVAL;
 
-	buf = memdup_user_nul(ubuf, cnt);
+	buf = iterdup_nul(from, cnt);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 	strim(buf);
 
 	mutex_lock(&event_mutex);
-	file = event_file_data(filp);
+	file = event_file_data(iocb->ki_filp);
 	if (file) {
 		call = file->event_call;
 		size = parse_entry(buf, call, &entry);
@@ -316,20 +315,18 @@ event_inject_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	if (err < 0)
 		return err;
 
-	*ppos += err;
+	iocb->ki_pos += err;
 	return cnt;
 }
 
-static ssize_t
-event_inject_read(struct file *file, char __user *buf, size_t size,
-		  loff_t *ppos)
+static ssize_t event_inject_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return -EPERM;
 }
 
 const struct file_operations event_inject_fops = {
 	.open = tracing_open_file_tr,
-	.read = event_inject_read,
-	.write = event_inject_write,
+	.read_iter = event_inject_read,
+	.write_iter = event_inject_write,
 	.release = tracing_release_file_tr,
 };
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index c82b401a294d..5ff782e5870e 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -2286,11 +2286,12 @@ static ssize_t synth_events_write(struct file *file,
 	return trace_parse_run_command(file, buffer, count, ppos,
 				       create_or_delete_synth_event);
 }
+FOPS_WRITE_ITER_HELPER(synth_events_write);
 
 static const struct file_operations synth_events_fops = {
 	.open           = synth_events_open,
-	.write		= synth_events_write,
-	.read           = seq_read,
+	.write_iter	= synth_events_write_iter,
+	.read_iter      = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = seq_release,
 };
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4bec043c8690..9f838fa4691e 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -272,11 +272,11 @@ int trigger_process_regex(struct trace_event_file *file, char *buff)
 	return ret;
 }
 
-static ssize_t event_trigger_regex_write(struct file *file,
-					 const char __user *ubuf,
-					 size_t cnt, loff_t *ppos)
+static ssize_t event_trigger_regex_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
 	struct trace_event_file *event_file;
+	size_t cnt = iov_iter_count(from);
 	ssize_t ret;
 	char *buf;
 
@@ -286,14 +286,14 @@ static ssize_t event_trigger_regex_write(struct file *file,
 	if (cnt >= PAGE_SIZE)
 		return -EINVAL;
 
-	buf = memdup_user_nul(ubuf, cnt);
+	buf = iterdup_nul(from, cnt);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
 	strim(buf);
 
 	mutex_lock(&event_mutex);
-	event_file = event_file_data(file);
+	event_file = event_file_data(iocb->ki_filp);
 	if (unlikely(!event_file)) {
 		mutex_unlock(&event_mutex);
 		kfree(buf);
@@ -306,7 +306,7 @@ static ssize_t event_trigger_regex_write(struct file *file,
 	if (ret < 0)
 		goto out;
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 	ret = cnt;
  out:
 	return ret;
@@ -324,11 +324,9 @@ static int event_trigger_regex_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t
-event_trigger_write(struct file *filp, const char __user *ubuf,
-		    size_t cnt, loff_t *ppos)
+static ssize_t event_trigger_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	return event_trigger_regex_write(filp, ubuf, cnt, ppos);
+	return event_trigger_regex_write(iocb, from);
 }
 
 static int
@@ -346,8 +344,8 @@ event_trigger_release(struct inode *inode, struct file *file)
 
 const struct file_operations event_trigger_fops = {
 	.open = event_trigger_open,
-	.read = seq_read,
-	.write = event_trigger_write,
+	.read_iter = seq_read_iter,
+	.write_iter = event_trigger_write,
 	.llseek = tracing_lseek,
 	.release = event_trigger_release,
 };
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 70d428c394b6..780329517bd5 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2263,20 +2263,6 @@ static int user_events_open(struct inode *node, struct file *file)
 	return 0;
 }
 
-static ssize_t user_events_write(struct file *file, const char __user *ubuf,
-				 size_t count, loff_t *ppos)
-{
-	struct iov_iter i;
-
-	if (unlikely(*ppos != 0))
-		return -EFAULT;
-
-	if (unlikely(import_ubuf(ITER_SOURCE, (char __user *)ubuf, count, &i)))
-		return -EFAULT;
-
-	return user_events_write_core(file, &i);
-}
-
 static ssize_t user_events_write_iter(struct kiocb *kp, struct iov_iter *i)
 {
 	return user_events_write_core(kp->ki_filp, i);
@@ -2678,7 +2664,6 @@ static int user_events_release(struct inode *node, struct file *file)
 
 static const struct file_operations user_data_fops = {
 	.open		= user_events_open,
-	.write		= user_events_write,
 	.write_iter	= user_events_write_iter,
 	.unlocked_ioctl	= user_events_ioctl,
 	.release	= user_events_release,
@@ -2777,7 +2762,7 @@ static int user_status_open(struct inode *node, struct file *file)
 
 static const struct file_operations user_status_fops = {
 	.open		= user_status_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index c35fbaab2a47..1d761e2de910 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1368,40 +1368,36 @@ static struct tracer graph_trace __tracer_data = {
 };
 
 
-static ssize_t
-graph_depth_write(struct file *filp, const char __user *ubuf, size_t cnt,
-		  loff_t *ppos)
+static ssize_t graph_depth_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t cnt = iov_iter_count(from);
 	unsigned long val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtoul_from_iter(from, cnt, 10, &val);
 	if (ret)
 		return ret;
 
 	fgraph_max_depth = val;
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
 
-static ssize_t
-graph_depth_read(struct file *filp, char __user *ubuf, size_t cnt,
-		 loff_t *ppos)
+static ssize_t graph_depth_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[15]; /* More than enough to hold UINT_MAX + "\n"*/
 	int n;
 
 	n = sprintf(buf, "%d\n", fgraph_max_depth);
-
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, n);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, n, to);
 }
 
 static const struct file_operations graph_depth_fops = {
 	.open		= tracing_open_generic,
-	.write		= graph_depth_write,
-	.read		= graph_depth_read,
+	.write_iter	= graph_depth_write,
+	.read_iter	= graph_depth_read,
 	.llseek		= generic_file_llseek,
 };
 
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6536..eea28d7205ed 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -664,10 +664,8 @@ static void hwlat_tracer_stop(struct trace_array *tr);
 
 /**
  * hwlat_mode_write - Write function for "mode" entry
- * @filp: The active open file structure
- * @ubuf: The user buffer that contains the value to write
- * @cnt: The maximum number of bytes to write to "file"
- * @ppos: The current position in @file
+ * @iocb: Metadata for IO
+ * @from: The user buffer that contains the value to write
  *
  * This function provides a write implementation for the "mode" interface
  * to the hardware latency detector. hwlatd has different operation modes.
@@ -677,10 +675,10 @@ static void hwlat_tracer_stop(struct trace_array *tr);
  * among the allowed CPUs in a round-robin fashion. The "per-cpu" mode
  * creates one hwlatd thread per allowed CPU.
  */
-static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
-				 size_t cnt, loff_t *ppos)
+static ssize_t hwlat_mode_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct trace_array *tr = hwlat_trace;
+	size_t cnt = iov_iter_count(from);
 	const char *mode;
 	char buf[64];
 	int ret, i;
@@ -688,7 +686,7 @@ static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
 	if (cnt >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, ubuf, cnt))
+	if (!copy_from_iter_full(buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = 0;
@@ -720,9 +718,7 @@ static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
 		hwlat_tracer_start(tr);
 	mutex_unlock(&trace_types_lock);
 
-	*ppos += cnt;
-
-
+	iocb->ki_pos += cnt;
 
 	return ret;
 }
@@ -753,10 +749,10 @@ static struct trace_min_max_param hwlat_window = {
 
 static const struct file_operations thread_mode_fops = {
 	.open		= hwlat_mode_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
-	.write		= hwlat_mode_write
+	.write_iter	= hwlat_mode_write
 };
 /**
  * init_tracefs - A function to initialize the tracefs interface files
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 14099cc17fc9..65006adc0854 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1247,14 +1247,15 @@ static ssize_t probes_write(struct file *file, const char __user *buffer,
 	return trace_parse_run_command(file, buffer, count, ppos,
 				       create_or_delete_trace_kprobe);
 }
+FOPS_WRITE_ITER_HELPER(probes_write);
 
 static const struct file_operations kprobe_events_ops = {
 	.owner          = THIS_MODULE,
 	.open           = probes_open,
-	.read           = seq_read,
+	.read_iter      = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = seq_release,
-	.write		= probes_write,
+	.write_iter	= probes_write_iter,
 };
 
 static unsigned long trace_kprobe_missed(struct trace_kprobe *tk)
@@ -1304,7 +1305,7 @@ static int profile_open(struct inode *inode, struct file *file)
 static const struct file_operations kprobe_profile_ops = {
 	.owner          = THIS_MODULE,
 	.open           = profile_open,
-	.read           = seq_read,
+	.read_iter      = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = seq_release,
 };
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a8e28f9b9271..ac11c293656e 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2198,26 +2198,24 @@ static int osnoise_options_open(struct inode *inode, struct file *file)
 
 /**
  * osnoise_options_write - Write function for "options" entry
- * @filp: The active open file structure
- * @ubuf: The user buffer that contains the value to write
- * @cnt: The maximum number of bytes to write to "file"
- * @ppos: The current position in @file
+ * @iocb: Metadata for IO
+ * @from: The user buffer that contains the value to write
  *
  * Writing the option name sets the option, writing the "NO_"
  * prefix in front of the option name disables it.
  *
  * Writing "DEFAULTS" resets the option values to the default ones.
  */
-static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
-				     size_t cnt, loff_t *ppos)
+static ssize_t osnoise_options_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int running, option, enable, retval;
+	size_t cnt = iov_iter_count(from);
 	char buf[256], *option_str;
 
 	if (cnt >= 256)
 		return -EINVAL;
 
-	if (copy_from_user(buf, ubuf, cnt))
+	if (!copy_from_iter_full(buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = 0;
@@ -2281,10 +2279,9 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
  *
  * Prints the "cpus" output into the user-provided buffer.
  */
-static ssize_t
-osnoise_cpus_read(struct file *filp, char __user *ubuf, size_t count,
-		  loff_t *ppos)
+static ssize_t osnoise_cpus_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	ssize_t count = iov_iter_count(to);
 	char *mask_str;
 	int len;
 
@@ -2303,7 +2300,7 @@ osnoise_cpus_read(struct file *filp, char __user *ubuf, size_t count,
 		goto out_free;
 	}
 
-	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
+	count = simple_copy_to_iter(mask_str, &iocb->ki_pos, len, to);
 
 out_free:
 	kfree(mask_str);
@@ -2329,18 +2326,17 @@ osnoise_cpus_read(struct file *filp, char __user *ubuf, size_t count,
  * other CPUs. For instance, one might run osnoise in one HT CPU
  * while observing what is running on the sibling HT CPU.
  */
-static ssize_t
-osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
-		   loff_t *ppos)
+static ssize_t osnoise_cpus_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	cpumask_var_t osnoise_cpumask_new;
+	size_t count = iov_iter_count(from);
 	int running, err;
 	char buf[256];
 
 	if (count >= 256)
 		return -EINVAL;
 
-	if (copy_from_user(buf, ubuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
@@ -2460,11 +2456,9 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
  *
  * Prints 1 on timerlat, the number of interferences on osnoise, -1 on error.
  */
-static ssize_t
-timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
-		  loff_t *ppos)
+static ssize_t timerlat_fd_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	long cpu = (long) file->private_data;
+	long cpu = (long) iocb->ki_filp->private_data;
 	struct osnoise_variables *osn_var;
 	struct timerlat_variables *tlat;
 	struct timerlat_sample s;
@@ -2665,7 +2659,7 @@ static struct trace_min_max_param timerlat_period = {
 
 static const struct file_operations timerlat_fd_fops = {
 	.open		= timerlat_fd_open,
-	.read		= timerlat_fd_read,
+	.read_iter	= timerlat_fd_read,
 	.release	= timerlat_fd_release,
 	.llseek		= generic_file_llseek,
 };
@@ -2673,17 +2667,17 @@ static const struct file_operations timerlat_fd_fops = {
 
 static const struct file_operations cpus_fops = {
 	.open		= tracing_open_generic,
-	.read		= osnoise_cpus_read,
-	.write		= osnoise_cpus_write,
+	.read_iter	= osnoise_cpus_read,
+	.write_iter	= osnoise_cpus_write,
 	.llseek		= generic_file_llseek,
 };
 
 static const struct file_operations osnoise_options_fops = {
 	.open		= osnoise_options_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
-	.write		= osnoise_options_write
+	.write_iter	= osnoise_options_write
 };
 
 #ifdef CONFIG_TIMERLAT_TRACER
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 29f6e95439b6..c98e09959e3c 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -371,7 +371,7 @@ ftrace_formats_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ftrace_formats_fops = {
 	.open = ftrace_formats_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
diff --git a/kernel/trace/trace_recursion_record.c b/kernel/trace/trace_recursion_record.c
index a520b11afb0d..d3b91a732d25 100644
--- a/kernel/trace/trace_recursion_record.c
+++ b/kernel/trace/trace_recursion_record.c
@@ -200,11 +200,9 @@ static int recursed_function_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static ssize_t recursed_function_write(struct file *file,
-				       const char __user *buffer,
-				       size_t count, loff_t *ppos)
+static ssize_t recursed_function_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	return count;
+	return iov_iter_count(from);
 }
 
 static int recursed_function_release(struct inode *inode, struct file *file)
@@ -216,8 +214,8 @@ static int recursed_function_release(struct inode *inode, struct file *file)
 
 static const struct file_operations recursed_functions_fops = {
 	.open           = recursed_function_open,
-	.write		= recursed_function_write,
-	.read           = seq_read,
+	.write_iter	= recursed_function_write,
+	.read_iter      = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = recursed_function_release,
 };
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 8a407adb0e1c..510c6320f7c7 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -510,7 +510,7 @@ static int tracing_saved_tgids_open(struct inode *inode, struct file *filp)
 
 const struct file_operations tracing_saved_tgids_fops = {
 	.open		= tracing_saved_tgids_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -589,14 +589,13 @@ static int tracing_saved_cmdlines_open(struct inode *inode, struct file *filp)
 
 const struct file_operations tracing_saved_cmdlines_fops = {
 	.open		= tracing_saved_cmdlines_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
 
 static ssize_t
-tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
-				 size_t cnt, loff_t *ppos)
+tracing_saved_cmdlines_size_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[64];
 	int r;
@@ -607,7 +606,7 @@ tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
 	arch_spin_unlock(&trace_cmdline_lock);
 	preempt_enable();
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, r, to);
 }
 
 void trace_free_saved_cmdlines_buffer(void)
@@ -635,13 +634,13 @@ static int tracing_resize_saved_cmdlines(unsigned int val)
 }
 
 static ssize_t
-tracing_saved_cmdlines_size_write(struct file *filp, const char __user *ubuf,
-				  size_t cnt, loff_t *ppos)
+tracing_saved_cmdlines_size_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t cnt = iov_iter_count(from);
 	unsigned long val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtoul_from_iter(from, cnt, 10, &val);
 	if (ret)
 		return ret;
 
@@ -653,13 +652,13 @@ tracing_saved_cmdlines_size_write(struct file *filp, const char __user *ubuf,
 	if (ret < 0)
 		return ret;
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
 
 const struct file_operations tracing_saved_cmdlines_size_fops = {
 	.open		= tracing_open_generic,
-	.read		= tracing_saved_cmdlines_size_read,
-	.write		= tracing_saved_cmdlines_size_write,
+	.read_iter	= tracing_saved_cmdlines_size_read,
+	.write_iter	= tracing_saved_cmdlines_size_write,
 };
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5a48dba912ea..fb657b1203de 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -320,29 +320,26 @@ static struct ftrace_ops trace_ops __read_mostly =
 	.func = stack_trace_call,
 };
 
-static ssize_t
-stack_max_size_read(struct file *filp, char __user *ubuf,
-		    size_t count, loff_t *ppos)
+static ssize_t stack_max_size_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	unsigned long *ptr = filp->private_data;
+	unsigned long *ptr = iocb->ki_filp->private_data;
 	char buf[64];
 	int r;
 
 	r = snprintf(buf, sizeof(buf), "%ld\n", *ptr);
 	if (r > sizeof(buf))
 		r = sizeof(buf);
-	return simple_read_from_buffer(ubuf, count, ppos, buf, r);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, r, to);
 }
 
-static ssize_t
-stack_max_size_write(struct file *filp, const char __user *ubuf,
-		     size_t count, loff_t *ppos)
+static ssize_t stack_max_size_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	long *ptr = filp->private_data;
+	long *ptr = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val, flags;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, count, 10, &val);
+	ret = kstrtoul_from_iter(from, count, 10, &val);
 	if (ret)
 		return ret;
 
@@ -367,8 +364,8 @@ stack_max_size_write(struct file *filp, const char __user *ubuf,
 
 static const struct file_operations stack_max_size_fops = {
 	.open		= tracing_open_generic,
-	.read		= stack_max_size_read,
-	.write		= stack_max_size_write,
+	.read_iter	= stack_max_size_read,
+	.write_iter	= stack_max_size_write,
 	.llseek		= default_llseek,
 };
 
@@ -486,7 +483,7 @@ static int stack_trace_open(struct inode *inode, struct file *file)
 
 static const struct file_operations stack_trace_fops = {
 	.open		= stack_trace_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -505,8 +502,8 @@ stack_trace_filter_open(struct inode *inode, struct file *file)
 
 static const struct file_operations stack_trace_filter_fops = {
 	.open = stack_trace_filter_open,
-	.read = seq_read,
-	.write = ftrace_filter_write,
+	.read_iter = seq_read_iter,
+	.write_iter = ftrace_filter_write_iter,
 	.llseek = tracing_lseek,
 	.release = ftrace_regex_release,
 };
diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index bb247beec447..d6cf9e0ecf81 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -269,7 +269,7 @@ static int tracing_stat_release(struct inode *i, struct file *f)
 
 static const struct file_operations tracing_stat_fops = {
 	.open		= tracing_stat_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= tracing_stat_release
 };
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9e461362450a..04a06f938969 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -800,14 +800,15 @@ static ssize_t probes_write(struct file *file, const char __user *buffer,
 	return trace_parse_run_command(file, buffer, count, ppos,
 					create_or_delete_trace_uprobe);
 }
+FOPS_WRITE_ITER_HELPER(probes_write);
 
 static const struct file_operations uprobe_events_ops = {
 	.owner		= THIS_MODULE,
 	.open		= probes_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
-	.write		= probes_write,
+	.write_iter	= probes_write_iter,
 };
 
 /* Probes profiling interfaces */
@@ -846,7 +847,7 @@ static int profile_open(struct inode *inode, struct file *file)
 static const struct file_operations uprobe_profile_ops = {
 	.owner		= THIS_MODULE,
 	.open		= profile_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
-- 
2.43.0


