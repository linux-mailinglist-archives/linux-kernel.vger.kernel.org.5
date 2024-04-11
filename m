Return-Path: <linux-kernel+bounces-140961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278868A19D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4491F2202A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E01B833F;
	Thu, 11 Apr 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FCfeu0kp"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B881B75BA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849824; cv=none; b=TJdvsHbA36sX5akqlXz+yExz2AuJQIi7gj2LNc9tAyezOAptyLW7aEQKVHiqjutmlCl4AVWwJCJMddQ2aMg/vnHeZKc7qGwXKc7XyZTVt44yLQst3kLNacXi6HftnUJd1STf3zQ3ddkZuwH9fBLUZcl4ub4ZjufsJgvySEfSgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849824; c=relaxed/simple;
	bh=M7HQAvvq2bZD0qtP9ygWTMqptkx9+n9nS7xEy8bJjLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HABmCoJO67gjPaeqUkyLtsGVx34UfopxfZ2ojYl37Pbre+pccn/9i7wENXngKxKt1+Q9qk6h3VVjH60WkmyHU2Y3e4Ju2Z5gEuKRHICW48+n8ABj3h8hsZpnIBF0wTxWjzTIF5S9dG6ktIFR6iid+xiSXh3ADj4Jbt4MOaxU15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FCfeu0kp; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69587439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849821; x=1713454621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foLshYHoNSiA+bNhIaIfSXBA5u0u+3j+zD0hPKG7pGk=;
        b=FCfeu0kpzR7mIcOSHV15SY1qH0GrZ+PwD7RksUTbHt1Za4Pdse/jDX/FyfoEHMZGPS
         07rQptLcme8rqXjqQ7lAKpmmOMYFNKmOKgnHTuY1AdZjlevSfXIOhQCwMdLkuvPlNtnI
         9hxwEfmAGMlInp2n5SkI2ovRMQM8qPXBIkfiVUpZESdVN2Pl/mWqi140rBDksTE9bcLH
         /yK5RqpFhvzCWIdDTz7q+V5Xf1H2erjXRtrpUFgt66wxusthgGYOcKvy6bBLcurgeKhq
         CefxGiN8oztFc8lpjZ1Gb1nyNakOa1becxr2juSTkU/I+XTfunEp9grtGeHCF+2GcRMn
         Lw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849821; x=1713454621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foLshYHoNSiA+bNhIaIfSXBA5u0u+3j+zD0hPKG7pGk=;
        b=wO72kdKifD8m5U6UQvebITuLMn3OLiVI2bvfqBpFbPOXBxq8429Aoe9rcNaUDUwNC3
         kz1kJcFnvzjbY4ckE7pz+TTPs5PJI9N8gvLxjLvJLoaAzxhJqJXOetSVrcYmdpyr4qkK
         uXw83z1f5N9AvDFu4HJhBSduNQ2ozx4r11PMcZHsD0RdnWi56Z0OZEViCgTfpxF/jKXa
         wu187sMy4EU+tgQlI8Kl+Eg9CClJTRb9TENxj3Ub40vWIMK69JZ08kaVnBd1i22zxsjP
         65t9T7ky25BkOH/Gg94uoPAQbQvx6o75epCfzTX5k6Gc0V99ukrOgIVSzz31EvV2e6rM
         dhxQ==
X-Gm-Message-State: AOJu0YwU2eYRZuk1tCN3D3b/YXIJSdfV/c3RoDPs0h8fdCAOps84AZhH
	eOidnc0VEdvOHdX43j7uOZvQXs/JiBRqw4Va7qGyymGkMM3RiAviansxBgfW3wjUg5Y6yHiP01N
	9
X-Google-Smtp-Source: AGHT+IFtK2KWlUQeuUuPWw00Dsgk5pIdToc4ZvZvP4t2uT3OyJ4q3ahI03CARsSvcZ71dk/WdibusQ==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr43618iob.2.1712849821608;
        Thu, 11 Apr 2024 08:37:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 192/437] scsi: qedf: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:32 -0600
Message-ID: <20240411153126.16201-193-axboe@kernel.dk>
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
 drivers/scsi/qedf/qedf_dbg.h     |  6 +--
 drivers/scsi/qedf/qedf_debugfs.c | 76 +++++++++++++-------------------
 2 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_dbg.h b/drivers/scsi/qedf/qedf_dbg.h
index 5ec2b817c694..802cbb5353f7 100644
--- a/drivers/scsi/qedf/qedf_dbg.h
+++ b/drivers/scsi/qedf/qedf_dbg.h
@@ -133,8 +133,8 @@ struct qedf_list_of_funcs {
 { \
 	.owner  = THIS_MODULE, \
 	.open   = simple_open, \
-	.read   = drv##_dbg_##ops##_cmd_read, \
-	.write  = drv##_dbg_##ops##_cmd_write \
+	.read_iter   = drv##_dbg_##ops##_cmd_read, \
+	.write_iter  = drv##_dbg_##ops##_cmd_write \
 }
 
 /* Used for debugfs sequential files */
@@ -142,7 +142,7 @@ struct qedf_list_of_funcs {
 { \
 	.owner = THIS_MODULE, \
 	.open = drv##_dbg_##ops##_open, \
-	.read = seq_read, \
+	.read_iter = seq_read_iter, \
 	.llseek = seq_lseek, \
 	.release = single_release, \
 }
diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 451fd236bfd0..53ae21f14a11 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -95,17 +95,14 @@ const struct qedf_debugfs_ops qedf_debugfs_ops[] = {
 
 DECLARE_PER_CPU(struct qedf_percpu_iothread_s, qedf_percpu_iothreads);
 
-static ssize_t
-qedf_dbg_fp_int_cmd_read(struct file *filp, char __user *buffer, size_t count,
-			 loff_t *ppos)
+static ssize_t qedf_dbg_fp_int_cmd_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret;
 	size_t cnt = 0;
 	char *cbuf;
 	int id;
 	struct qedf_fastpath *fp = NULL;
-	struct qedf_dbg_ctx *qedf_dbg =
-				(struct qedf_dbg_ctx *)filp->private_data;
+	struct qedf_dbg_ctx *qedf_dbg = iocb->ki_filp->private_data;
 	struct qedf_ctx *qedf = container_of(qedf_dbg,
 	    struct qedf_ctx, dbg_ctx);
 
@@ -125,52 +122,47 @@ qedf_dbg_fp_int_cmd_read(struct file *filp, char __user *buffer, size_t count,
 				 "#%d: %lu\n", id, fp->completions);
 	}
 
-	ret = simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
-
+	ret = simple_copy_to_iter(cbuf, &iocb->ki_pos, cnt, to);
 	vfree(cbuf);
-
 	return ret;
 }
 
 static ssize_t
-qedf_dbg_fp_int_cmd_write(struct file *filp, const char __user *buffer,
-			  size_t count, loff_t *ppos)
+qedf_dbg_fp_int_cmd_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	if (!count || *ppos)
+	size_t count = iov_iter_count(from);
+
+	if (!count || iocb->ki_pos)
 		return 0;
 
 	return count;
 }
 
-static ssize_t
-qedf_dbg_debug_cmd_read(struct file *filp, char __user *buffer, size_t count,
-			loff_t *ppos)
+static ssize_t qedf_dbg_debug_cmd_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int cnt;
 	char cbuf[32];
-	struct qedf_dbg_ctx *qedf_dbg =
-				(struct qedf_dbg_ctx *)filp->private_data;
+	struct qedf_dbg_ctx *qedf_dbg = iocb->ki_filp->private_data;
 
 	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "debug mask=0x%x\n", qedf_debug);
 	cnt = scnprintf(cbuf, sizeof(cbuf), "debug mask = 0x%x\n", qedf_debug);
 
-	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
+	return simple_copy_to_iter(cbuf, &iocb->ki_pos, cnt, to);
 }
 
 static ssize_t
-qedf_dbg_debug_cmd_write(struct file *filp, const char __user *buffer,
-			 size_t count, loff_t *ppos)
+qedf_dbg_debug_cmd_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	uint32_t val;
 	void *kern_buf;
 	int rval;
-	struct qedf_dbg_ctx *qedf_dbg =
-	    (struct qedf_dbg_ctx *)filp->private_data;
+	struct qedf_dbg_ctx *qedf_dbg = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
-	if (!count || *ppos)
+	if (!count || iocb->ki_pos)
 		return 0;
 
-	kern_buf = memdup_user(buffer, count);
+	kern_buf = iterdup(from, count);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -189,13 +181,11 @@ qedf_dbg_debug_cmd_write(struct file *filp, const char __user *buffer,
 }
 
 static ssize_t
-qedf_dbg_stop_io_on_error_cmd_read(struct file *filp, char __user *buffer,
-				   size_t count, loff_t *ppos)
+qedf_dbg_stop_io_on_error_cmd_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int cnt;
 	char cbuf[7];
-	struct qedf_dbg_ctx *qedf_dbg =
-				(struct qedf_dbg_ctx *)filp->private_data;
+	struct qedf_dbg_ctx *qedf_dbg = iocb->ki_filp->private_data;
 	struct qedf_ctx *qedf = container_of(qedf_dbg,
 	    struct qedf_ctx, dbg_ctx);
 
@@ -203,26 +193,24 @@ qedf_dbg_stop_io_on_error_cmd_read(struct file *filp, char __user *buffer,
 	cnt = scnprintf(cbuf, sizeof(cbuf), "%s\n",
 	    qedf->stop_io_on_error ? "true" : "false");
 
-	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
+	return simple_copy_to_iter(cbuf, &iocb->ki_pos, cnt, to);
 }
 
 static ssize_t
-qedf_dbg_stop_io_on_error_cmd_write(struct file *filp,
-				    const char __user *buffer, size_t count,
-				    loff_t *ppos)
+qedf_dbg_stop_io_on_error_cmd_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	void *kern_buf;
-	struct qedf_dbg_ctx *qedf_dbg =
-				(struct qedf_dbg_ctx *)filp->private_data;
+	struct qedf_dbg_ctx *qedf_dbg = iocb->ki_filp->private_data;
 	struct qedf_ctx *qedf = container_of(qedf_dbg, struct qedf_ctx,
 	    dbg_ctx);
+	size_t count = iov_iter_count(from);
 
 	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "entered\n");
 
-	if (!count || *ppos)
+	if (!count || iocb->ki_pos)
 		return 0;
 
-	kern_buf = memdup_user(buffer, 6);
+	kern_buf = iterdup(from, 6);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -383,30 +371,28 @@ qedf_dbg_driver_stats_open(struct inode *inode, struct file *file)
 }
 
 static ssize_t
-qedf_dbg_clear_stats_cmd_read(struct file *filp, char __user *buffer,
-				   size_t count, loff_t *ppos)
+qedf_dbg_clear_stats_cmd_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	int cnt = 0;
 
 	/* Essentially a read stub */
-	cnt = min_t(int, count, cnt - *ppos);
-	*ppos += cnt;
+	cnt = min_t(int, count, cnt - iocb->ki_pos);
+	iocb->ki_pos += cnt;
 	return cnt;
 }
 
 static ssize_t
-qedf_dbg_clear_stats_cmd_write(struct file *filp,
-				    const char __user *buffer, size_t count,
-				    loff_t *ppos)
+qedf_dbg_clear_stats_cmd_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct qedf_dbg_ctx *qedf_dbg =
-				(struct qedf_dbg_ctx *)filp->private_data;
+	struct qedf_dbg_ctx *qedf_dbg = iocb->ki_filp->private_data;
 	struct qedf_ctx *qedf = container_of(qedf_dbg, struct qedf_ctx,
 	    dbg_ctx);
+	size_t count = iov_iter_count(from);
 
 	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "Clearing stat counters.\n");
 
-	if (!count || *ppos)
+	if (!count || iocb->ki_pos)
 		return 0;
 
 	/* Clear stat counters exposed by 'stats' node */
-- 
2.43.0


