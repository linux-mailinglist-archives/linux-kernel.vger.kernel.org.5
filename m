Return-Path: <linux-kernel+bounces-140806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B28A1909
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DCD1F2143F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63685D471;
	Thu, 11 Apr 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dHYImB+g"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569EE1CA8F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849581; cv=none; b=MVUO2c3VLeyZmlnXarZ0GU4r5GleQJv4h7iUnOuvjcrOIgxHQVLAiyJ8QC+++6Sf0vIpViUl2Pr4nS7VWTAlWQ+Mr4yp8v1MRRm5NCkAGnhrUnJt+sWjOw9kK7GLpYUt41FeWIn0Zj0hIfHB3khA9IHskFEJnCw+fPR6yqzzV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849581; c=relaxed/simple;
	bh=3A3Y2S1TN0uiD3XfMhL2MRzknmu6Zu0BIJ5mcQpELWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdmxDVFjXvOci55Fsuo1ZdI4S6KXBBLL8IzJzQFfRlDmO/xFdn+KWsdtGj2g+Ln+VTZ+3vtfBdWf1odm25n6kXWrvnt/wsYZB8YofzXKuDxuiDsNNlNKwczKKiaS8DUL7LTpHq6yR4CN+7AHoGShrkGXiPJQTm3FVKLTRyljKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dHYImB+g; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8870039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849579; x=1713454379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r84YY1rOyk7rzLeeyW1VHrY32e6Xsj7KT90entdsH4=;
        b=dHYImB+gTpGwzAVWst9VvFTOyNkgy5KkxWWc0woYmO3NwDVscY2fTuesx1SrylODQ4
         I/Gn0WBvSAFfjPn+GW+EeBWGdZWn2GwT9ihqYPr6CZcIP+Wb2v/38z7pLPr5C52gugQn
         g6mes9LjHsLEr7m0BlrKXxVHgyQWW31F/3thwM0pst2G1k3JEtz35siDEWpOdr4qYUld
         5ZK9M/Yd8w7JfZgW6ybFjMcvBRmMsaIBWz6oagj8iQQidVRXU5uI5TMwSLiA3njfq6zX
         r9rrpua9+kM69nvfDDR0riZpzGlqpwv/+v1pVEDsv/bkZrlMPF0pH+RISXgkZeR49fpH
         wRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849579; x=1713454379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4r84YY1rOyk7rzLeeyW1VHrY32e6Xsj7KT90entdsH4=;
        b=LkR4/F5Ht40Ka0KszMuoaEKVgiCY9jzGwCxXt53O/hZD80uneId4a498EGMXxSamXQ
         lgPWlFh5Bnha4sgsHFHiOsYzn61J+q4ofm1CvlnrCl4U/1yNTyUKIDBX+aYpLfSN6n1H
         YodWXaEnfwZ8QEXYB6TyVb8/IuNyBXAoNNpQDjzfpc5Z6nt0A5L7eNovmWWBrOTxJzj/
         DoKrK6BkqAPTzlLAMDV/KaW3HqhxEDgu82JztfZQez1XNPyxNFpLlBKPJ6kGwtlj41ED
         rcHaS5SJ9lv2NVC+n8SFFp12skAutsevh1RlDXiM+TXBLVYVMGXJXHZYmFzAcxtjKvt6
         dY8Q==
X-Gm-Message-State: AOJu0YxWUVT4t2gwBBNHXHI1A5Ek3u32TGj2J5hq6uKQdlof6Eb9t7Z4
	U74uAQ5hzL/Iw/w3E5+0o0tRfFkADPclmNpNF/wMOtRMzKE6QSSU5hrhlUQhU5Lwi7WLKuz8JVt
	S
X-Google-Smtp-Source: AGHT+IEo2Ae59GIcxcCa31jjb6H3XDSS8642W0puNU+vRXryUpOW30/Y7CeXxBtL913jmZVEb7mnbQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr5550ioc.1.1712849578994;
        Thu, 11 Apr 2024 08:32:58 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 046/437] dlm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:06 -0600
Message-ID: <20240411153126.16201-47-axboe@kernel.dk>
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
 fs/dlm/debug_fs.c | 41 +++++++++++++++++++----------------------
 fs/dlm/plock.c    | 16 ++++++++--------
 fs/dlm/user.c     | 17 +++++++++--------
 3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index 1236e8d13453..2207cd83ab09 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -700,10 +700,10 @@ static int table_open2(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t table_write2(struct file *file, const char __user *user_buf,
-			    size_t count, loff_t *ppos)
+static ssize_t table_write2(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *seq = file->private_data;
+	struct seq_file *seq = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int n, len, lkb_nodeid, lkb_status, error;
 	char name[DLM_RESNAME_MAXLEN + 1] = {};
 	struct dlm_ls *ls = seq->private;
@@ -711,8 +711,7 @@ static ssize_t table_write2(struct file *file, const char __user *user_buf,
 	char buf[256] = {};
 	uint32_t lkb_id;
 
-	if (copy_from_user(buf, user_buf,
-			   min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	n = sscanf(buf, "%x %" __stringify(DLM_RESNAME_MAXLEN) "s %x %d %d",
@@ -783,7 +782,7 @@ static const struct file_operations format2_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open2,
 	.read_iter    = seq_read_iter,
-	.write   = table_write2,
+	.write_iter   = table_write2,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
@@ -815,10 +814,9 @@ static const struct file_operations format5_fops = {
 /*
  * dump lkb's on the ls_waiters list
  */
-static ssize_t waiters_read(struct file *file, char __user *userbuf,
-			    size_t count, loff_t *ppos)
+static ssize_t waiters_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dlm_ls *ls = file->private_data;
+	struct dlm_ls *ls = iocb->ki_filp->private_data;
 	struct dlm_lkb *lkb;
 	size_t len = DLM_DEBUG_BUF_LEN, pos = 0, ret, rv;
 
@@ -836,22 +834,21 @@ static ssize_t waiters_read(struct file *file, char __user *userbuf,
 	}
 	mutex_unlock(&ls->ls_waiters_mutex);
 
-	rv = simple_read_from_buffer(userbuf, count, ppos, debug_buf, pos);
+	rv = simple_copy_to_iter(debug_buf, &iocb->ki_pos, pos, to);
 	mutex_unlock(&debug_buf_lock);
 	return rv;
 }
 
-static ssize_t waiters_write(struct file *file, const char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t waiters_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct dlm_ls *ls = file->private_data;
+	struct dlm_ls *ls = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int mstype, to_nodeid;
 	char buf[128] = {};
 	uint32_t lkb_id;
 	int n, error;
 
-	if (copy_from_user(buf, user_buf,
-			   min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	n = sscanf(buf, "%x %d %d", &lkb_id, &mstype, &to_nodeid);
@@ -868,8 +865,8 @@ static ssize_t waiters_write(struct file *file, const char __user *user_buf,
 static const struct file_operations waiters_fops = {
 	.owner   = THIS_MODULE,
 	.open    = simple_open,
-	.read    = waiters_read,
-	.write   = waiters_write,
+	.read_iter    = waiters_read,
+	.write_iter   = waiters_write,
 	.llseek  = default_llseek,
 };
 
@@ -911,9 +908,9 @@ static int dlm_version_show(struct seq_file *file, void *offset)
 }
 DEFINE_SHOW_ATTRIBUTE(dlm_version);
 
-static ssize_t dlm_rawmsg_write(struct file *fp, const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t dlm_rawmsg_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	void *buf;
 	int ret;
 
@@ -924,12 +921,12 @@ static ssize_t dlm_rawmsg_write(struct file *fp, const char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	if (copy_from_user(buf, user_buf, count)) {
+	if (!copy_from_iter_full(buf, count, from)) {
 		ret = -EFAULT;
 		goto out;
 	}
 
-	ret = dlm_midcomms_rawmsg_send(fp->private_data, buf, count);
+	ret = dlm_midcomms_rawmsg_send(iocb->ki_filp->private_data, buf, count);
 	if (ret)
 		goto out;
 
@@ -943,7 +940,7 @@ static ssize_t dlm_rawmsg_write(struct file *fp, const char __user *user_buf,
 
 static const struct file_operations dlm_rawmsg_fops = {
 	.open	= simple_open,
-	.write	= dlm_rawmsg_write,
+	.write_iter	= dlm_rawmsg_write,
 	.llseek	= no_llseek,
 };
 
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 9ca83ef70ed1..f6d00f39f991 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -478,9 +478,9 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 EXPORT_SYMBOL_GPL(dlm_posix_get);
 
 /* a read copies out one plock request from the send list */
-static ssize_t dev_read(struct file *file, char __user *u, size_t count,
-			loff_t *ppos)
+static ssize_t dev_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct dlm_plock_info info;
 	struct plock_op *op = NULL;
 
@@ -510,16 +510,16 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 	if (op->info.flags & DLM_PLOCK_FL_CLOSE)
 		dlm_release_plock_op(op);
 
-	if (copy_to_user(u, &info, sizeof(info)))
+	if (!copy_to_iter_full(&info, sizeof(info), to))
 		return -EFAULT;
 	return sizeof(info);
 }
 
 /* a write copies in one plock result that should match a plock_op
    on the recv list */
-static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
-			 loff_t *ppos)
+static ssize_t dev_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct plock_op *op = NULL, *iter;
 	struct dlm_plock_info info;
 	int do_callback = 0;
@@ -527,7 +527,7 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 	if (count != sizeof(info))
 		return -EINVAL;
 
-	if (copy_from_user(&info, u, sizeof(info)))
+	if (!copy_from_iter_full(&info, sizeof(info), from))
 		return -EFAULT;
 
 	trace_dlm_plock_write(&info);
@@ -598,8 +598,8 @@ static __poll_t dev_poll(struct file *file, poll_table *wait)
 }
 
 static const struct file_operations dev_fops = {
-	.read    = dev_read,
-	.write   = dev_write,
+	.read_iter    = dev_read,
+	.write_iter   = dev_write,
 	.poll    = dev_poll,
 	.owner   = THIS_MODULE,
 	.llseek  = noop_llseek,
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index 9f9b68448830..362c9998929e 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -524,10 +524,10 @@ static int check_version(struct dlm_write_request *req)
 /* a write to a lockspace device is a lock or unlock request, a write
    to the control device is to create/remove a lockspace */
 
-static ssize_t device_write(struct file *file, const char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t device_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct dlm_user_proc *proc = file->private_data;
+	struct dlm_user_proc *proc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct dlm_write_request *kbuf;
 	int error;
 
@@ -545,7 +545,7 @@ static ssize_t device_write(struct file *file, const char __user *buf,
 	if (count > sizeof(struct dlm_write_request) + DLM_RESNAME_MAXLEN)
 		return -EINVAL;
 
-	kbuf = memdup_user_nul(buf, count);
+	kbuf = iterdup_nul(from, count);
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
@@ -918,6 +918,7 @@ static ssize_t device_read(struct file *file, char __user *buf, size_t count,
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(device_read);
 
 static __poll_t device_poll(struct file *file, poll_table *wait)
 {
@@ -982,8 +983,8 @@ static int monitor_device_close(struct inode *inode, struct file *file)
 static const struct file_operations device_fops = {
 	.open    = device_open,
 	.release = device_close,
-	.read    = device_read,
-	.write   = device_write,
+	.read_iter    = device_read_iter,
+	.write_iter   = device_write,
 	.poll    = device_poll,
 	.owner   = THIS_MODULE,
 	.llseek  = noop_llseek,
@@ -992,8 +993,8 @@ static const struct file_operations device_fops = {
 static const struct file_operations ctl_device_fops = {
 	.open    = ctl_device_open,
 	.release = ctl_device_close,
-	.read    = device_read,
-	.write   = device_write,
+	.read_iter    = device_read_iter,
+	.write_iter   = device_write,
 	.owner   = THIS_MODULE,
 	.llseek  = noop_llseek,
 };
-- 
2.43.0


