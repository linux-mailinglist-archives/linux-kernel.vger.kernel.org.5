Return-Path: <linux-kernel+bounces-141064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DA18A1A80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F9AB311EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9251B1D3704;
	Thu, 11 Apr 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k32LLqze"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5817588
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849983; cv=none; b=YmGssRJ/XEbcG2NbSC/5N0mStwLF5y4isFceGZUhi7s/XziD3xF024t6mrdkI0ZLSf+NJZrfPBNu5fiv48+dLI1n6UkntHIGf/kaXvOSaLeS2nEQU/2yuUdgqWxS7BDEwLROZhct3dONOtQr0nMVTj7lt97zk5whcxHC6Gw71K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849983; c=relaxed/simple;
	bh=DHMCYYdUCRmhOpDhCXsUNeZsXB4zDSnDq1t7y0GuQrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/PQLLAyyQX//FJjBY7rwK6FIB/ve7G8uzIUw4iSBhHzODwHhfAHkL313EQhb8LhgEZodA7Iz5RKNyQC2wlDdWm5y5NtZgpjsVGwHXpI9s/VUdN4/sPln7YCOHLutzLvjq04ipNP2yPwOl9pDQJDsHXdgZk48t/wsvVcX7XjYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k32LLqze; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58171039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849979; x=1713454779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GcTesiZb4x6GGSKP7V2H2rQRehxL1gBgTA2zgMpf1Y=;
        b=k32LLqzeFV3/CijDCPxMAZBsSCk+u2VEBZIhCC550zasoG8zWI94WR0KO06fDoBJM8
         VkmCJH3cNFnHGv7S9QgguNPg+KaWdF0a6yh++p5Oo48AqwQKegJJ9iLlh/s3BaVfIsbK
         lgi6jJHrXuTFP1XMQE1K5r3PxBjlkbQ0XrE8DJ0pXtwxkbUT4FEIays2Ukd5sERMJzBu
         tBJR2yvMb/qt8wtFyz/wJ53N4/tIvUnqmoXPKQisjhKGlkDQF96Whu12tCwbHmcXpJLj
         PemWmAprEwOo+9AK8MPjQXvKUHLKVJ4+Rn7ACaV2qfiRETcZU5YnDoGO2MmDDus5957E
         TQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849979; x=1713454779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GcTesiZb4x6GGSKP7V2H2rQRehxL1gBgTA2zgMpf1Y=;
        b=q668YDKXW/tCpiDrGPhKaTDTmWtALKXfeFF86y2md4A8dBtgGGTUnk4s35iIICiBRJ
         oq4VbjiUiCSBalxqAnmuyyu1ghWKN7ioGbXETvb3L3Xha/0eKl+jZrGurFCpMSuuRR53
         5vrMSOU4dUKEi7ODDa9/E2FootTsfV0G39II+wwIu65jKeJemXmarRvwUrcsgalOzMDA
         lNv/HIhcEaACDsnIXo8cyOW/91WEKcyYKdw96Yw1GNrlGYtObBY0tcXqFN5a9J2DE+tL
         6+bDkKWFI2ba8gELcwTvx7P55XAIwE5h6PhfcE9ezn771iYtzWzcbuuf7hiSY3P5hYbV
         U5rw==
X-Gm-Message-State: AOJu0YzgFAx3rV7BGRaBgkq8+dLV5DGGLuPNkPiOoS3qy1cXKbmnFUuj
	q0nPkAW2utX4R+j7z0nCG2Iu7DFuPkzznmSRfQqVrRYYKRSGZPqlb9BE8z+FoDKKy/S1hnAvkUZ
	7
X-Google-Smtp-Source: AGHT+IHZM910AfQ/3vgC/pPYbjR4S5LmFsbnLM9ttLjIN3mqH+NvXYT6FtZgBRM+t45xJgTSSe12fQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr196106iov.2.1712849979487;
        Thu, 11 Apr 2024 08:39:39 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 289/437] fs/bcachefs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:09 -0600
Message-ID: <20240411153126.16201-290-axboe@kernel.dk>
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
 fs/bcachefs/chardev.c          | 10 +++++-----
 fs/bcachefs/debug.c            | 24 ++++++++++++++++--------
 fs/bcachefs/thread_with_file.c | 14 ++++++++------
 3 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index cbfa6459bdbc..9f27c3f4b960 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -438,10 +438,9 @@ static int bch2_data_job_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t bch2_data_job_read(struct file *file, char __user *buf,
-				  size_t len, loff_t *ppos)
+static ssize_t bch2_data_job_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct bch_data_ctx *ctx = container_of(file->private_data, struct bch_data_ctx, thr);
+	struct bch_data_ctx *ctx = container_of(iocb->ki_filp->private_data, struct bch_data_ctx, thr);
 	struct bch_fs *c = ctx->c;
 	struct bch_ioctl_data_event e = {
 		.type			= BCH_DATA_EVENT_PROGRESS,
@@ -451,16 +450,17 @@ static ssize_t bch2_data_job_read(struct file *file, char __user *buf,
 		.p.sectors_done		= atomic64_read(&ctx->stats.sectors_seen),
 		.p.sectors_total	= bch2_fs_usage_read_short(c).used,
 	};
+	size_t len = iov_iter_count(to);
 
 	if (len < sizeof(e))
 		return -EINVAL;
 
-	return copy_to_user_errcode(buf, &e, sizeof(e)) ?: sizeof(e);
+	return copy_to_iter(&e, sizeof(e), to);
 }
 
 static const struct file_operations bcachefs_data_ops = {
 	.release	= bch2_data_job_release,
-	.read		= bch2_data_job_read,
+	.read_iter	= bch2_data_job_read,
 	.llseek		= no_llseek,
 };
 
diff --git a/fs/bcachefs/debug.c b/fs/bcachefs/debug.c
index 208ce6f0fc43..9b5c7aa57fda 100644
--- a/fs/bcachefs/debug.c
+++ b/fs/bcachefs/debug.c
@@ -384,12 +384,13 @@ static ssize_t bch2_read_btree(struct file *file, char __user *buf,
 			}))) ?:
 		i->ret;
 }
+FOPS_READ_ITER_HELPER(bch2_read_btree);
 
 static const struct file_operations btree_debug_ops = {
 	.owner		= THIS_MODULE,
 	.open		= bch2_dump_open,
 	.release	= bch2_dump_release,
-	.read		= bch2_read_btree,
+	.read_iter	= bch2_read_btree_iter,
 };
 
 static ssize_t bch2_read_btree_formats(struct file *file, char __user *buf,
@@ -438,12 +439,13 @@ static ssize_t bch2_read_btree_formats(struct file *file, char __user *buf,
 
 	return ret ?: i->ret;
 }
+FOPS_READ_ITER_HELPER(bch2_read_btree_formats);
 
 static const struct file_operations btree_format_debug_ops = {
 	.owner		= THIS_MODULE,
 	.open		= bch2_dump_open,
 	.release	= bch2_dump_release,
-	.read		= bch2_read_btree_formats,
+	.read_iter	= bch2_read_btree_formats_iter,
 };
 
 static ssize_t bch2_read_bfloat_failed(struct file *file, char __user *buf,
@@ -477,12 +479,13 @@ static ssize_t bch2_read_bfloat_failed(struct file *file, char __user *buf,
 			}))) ?:
 		i->ret;
 }
+FOPS_READ_ITER_HELPER(bch2_read_bfloat_failed);
 
 static const struct file_operations bfloat_failed_debug_ops = {
 	.owner		= THIS_MODULE,
 	.open		= bch2_dump_open,
 	.release	= bch2_dump_release,
-	.read		= bch2_read_bfloat_failed,
+	.read_iter	= bch2_read_bfloat_failed_iter,
 };
 
 static void bch2_cached_btree_node_to_text(struct printbuf *out, struct bch_fs *c,
@@ -584,12 +587,13 @@ static ssize_t bch2_cached_btree_nodes_read(struct file *file, char __user *buf,
 
 	return ret ?: i->ret;
 }
+FOPS_READ_ITER_HELPER(bch2_cached_btree_nodes_read);
 
 static const struct file_operations cached_btree_nodes_ops = {
 	.owner		= THIS_MODULE,
 	.open		= bch2_dump_open,
 	.release	= bch2_dump_release,
-	.read		= bch2_cached_btree_nodes_read,
+	.read_iter	= bch2_cached_btree_nodes_read_iter,
 };
 
 static ssize_t bch2_btree_transactions_read(struct file *file, char __user *buf,
@@ -648,12 +652,13 @@ static ssize_t bch2_btree_transactions_read(struct file *file, char __user *buf,
 
 	return ret ?: i->ret;
 }
+FOPS_READ_ITER_HELPER(bch2_btree_transactions_read);
 
 static const struct file_operations btree_transactions_ops = {
 	.owner		= THIS_MODULE,
 	.open		= bch2_dump_open,
 	.release	= bch2_dump_release,
-	.read		= bch2_btree_transactions_read,
+	.read_iter	= bch2_btree_transactions_read_iter,
 };
 
 static ssize_t bch2_journal_pins_read(struct file *file, char __user *buf,
@@ -685,12 +690,13 @@ static ssize_t bch2_journal_pins_read(struct file *file, char __user *buf,
 
 	return i->ret;
 }
+FOPS_READ_ITER_HELPER(bch2_journal_pins_read);
 
 static const struct file_operations journal_pins_ops = {
 	.owner		= THIS_MODULE,
 	.open		= bch2_dump_open,
 	.release	= bch2_dump_release,
-	.read		= bch2_journal_pins_read,
+	.read_iter	= bch2_journal_pins_read_iter,
 };
 
 static int btree_transaction_stats_open(struct inode *inode, struct file *file)
@@ -792,12 +798,13 @@ static ssize_t btree_transaction_stats_read(struct file *file, char __user *buf,
 
 	return i->ret;
 }
+FOPS_READ_ITER_HELPER(btree_transaction_stats_read);
 
 static const struct file_operations btree_transaction_stats_op = {
 	.owner		= THIS_MODULE,
 	.open		= btree_transaction_stats_open,
 	.release	= btree_transaction_stats_release,
-	.read		= btree_transaction_stats_read,
+	.read_iter	= btree_transaction_stats_read_iter,
 };
 
 static ssize_t bch2_btree_deadlock_read(struct file *file, char __user *buf,
@@ -852,12 +859,13 @@ static ssize_t bch2_btree_deadlock_read(struct file *file, char __user *buf,
 
 	return ret ?: i->ret;
 }
+FOPS_READ_ITER_HELPER(bch2_btree_deadlock_read);
 
 static const struct file_operations btree_deadlock_ops = {
 	.owner		= THIS_MODULE,
 	.open		= bch2_dump_open,
 	.release	= bch2_dump_release,
-	.read		= bch2_btree_deadlock_read,
+	.read_iter	= bch2_btree_deadlock_read_iter,
 };
 
 void bch2_fs_debug_exit(struct bch_fs *c)
diff --git a/fs/bcachefs/thread_with_file.c b/fs/bcachefs/thread_with_file.c
index 940db15d6a93..fa6f333605da 100644
--- a/fs/bcachefs/thread_with_file.c
+++ b/fs/bcachefs/thread_with_file.c
@@ -27,11 +27,11 @@ int bch2_run_thread_with_file(struct thread_with_file *thr,
 	int ret, fd = -1;
 	unsigned fd_flags = O_CLOEXEC;
 
-	if (fops->read && fops->write)
+	if (fops->read_iter && fops->write_iter)
 		fd_flags |= O_RDWR;
-	else if (fops->read)
+	else if (fops->read_iter)
 		fd_flags |= O_RDONLY;
-	else if (fops->write)
+	else if (fops->write_iter)
 		fd_flags |= O_WRONLY;
 
 	char name[TASK_COMM_LEN];
@@ -145,6 +145,7 @@ static ssize_t thread_with_stdio_read(struct file *file, char __user *ubuf,
 
 	return copied ?: ret;
 }
+FOPS_READ_ITER_HELPER(thread_with_stdio_read);
 
 static int thread_with_stdio_release(struct inode *inode, struct file *file)
 {
@@ -211,6 +212,7 @@ static ssize_t thread_with_stdio_write(struct file *file, const char __user *ubu
 
 	return copied ?: ret;
 }
+FOPS_WRITE_ITER_HELPER(thread_with_stdio_write);
 
 static __poll_t thread_with_stdio_poll(struct file *file, struct poll_table_struct *wait)
 {
@@ -267,8 +269,8 @@ static long thread_with_stdio_ioctl(struct file *file, unsigned int cmd, unsigne
 
 static const struct file_operations thread_with_stdio_fops = {
 	.llseek		= no_llseek,
-	.read		= thread_with_stdio_read,
-	.write		= thread_with_stdio_write,
+	.read_iter	= thread_with_stdio_read_iter,
+	.write_iter	= thread_with_stdio_write_iter,
 	.poll		= thread_with_stdio_poll,
 	.flush		= thread_with_stdio_flush,
 	.release	= thread_with_stdio_release,
@@ -277,7 +279,7 @@ static const struct file_operations thread_with_stdio_fops = {
 
 static const struct file_operations thread_with_stdout_fops = {
 	.llseek		= no_llseek,
-	.read		= thread_with_stdio_read,
+	.read_iter	= thread_with_stdio_read_iter,
 	.poll		= thread_with_stdout_poll,
 	.flush		= thread_with_stdio_flush,
 	.release	= thread_with_stdio_release,
-- 
2.43.0


