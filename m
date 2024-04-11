Return-Path: <linux-kernel+bounces-140956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916218A19CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE80B1C20889
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588BB1B67E7;
	Thu, 11 Apr 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AE8Qtwz1"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B31B5C4C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849816; cv=none; b=UooLhqu4z7BwC5W4H/fi1tyaE99tkLsZUSgI5QIGwCftDVOULH7j9hHkri7lKlMh5Cd3hd9tgk2KfR456jVmepiUQw0xKb2NakxLKmfK5wxBfC5EdlcsPGxkQ8W8dHvNgGIuqr0TuMFurDIs+bZwlVsYRbsiSEk1f3NIPr0bD1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849816; c=relaxed/simple;
	bh=6B5+sBgpQ49tvqpVnH31J+Qg5MY/I3Q98qyO2aPNYvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeZ5M42DO8JsPMOIOALoWOXfuB0pEuAy0uiKQnL2zqQtdbDggzamOV8RHFCskBjcejPBqCZ53Lfx+L9PgN4oX+qQancLxDvYgcYMNJAgL14jGOB+t5sYPmtlZprbPP7VJ0jBIXIMkD0uopqb1QsJd8S5G7b0UG5i2CNH5taC17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AE8Qtwz1; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9805139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849813; x=1713454613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNzRO5pO1j3jRjqZRnmLYzWISRQfbbN9QTBAFbt7aSo=;
        b=AE8Qtwz1/kjp43RmmvqxyCaH+zsfEX/qfBgxNoIg9Eo6ZyptOdCvZ8PpL3hTLItk8f
         JyDM8u7PBf2QalY+HcRvzM4b1ZoP+fjsTM3GN6nN3kFgjRe6jbQNvawTfM+GXEbyrMyb
         GLkZ7BTobupQqRkBpiWPmA03IX1vbwiWzvwHqmyB5JxY3uO/MVwhoKnYmDsLyDcLSspq
         6tddqsDICYiS7DhKVZliZnSC/9UAV+p/2gpVNEsgcuUyjpSGmQsYCnxyGJEvAvrNBsZp
         SXN1Eif4bj4afVOK4ExG1T5k047upM6Dxl+dnm1wC2A9OryjeEeQxGzpfZgcd1m+pK67
         sVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849813; x=1713454613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNzRO5pO1j3jRjqZRnmLYzWISRQfbbN9QTBAFbt7aSo=;
        b=A7ybkrSvlKf/jf/d0IV/bpS+jkAVoVJtvX6//mDS7+ma/S4mMWFnxzyymiS5AO4tqr
         yF71HcLFzuOZyWHM0OcJ1x18C9W14E1XImdyE8JhkxaQGR5jj/nI51/V8Q9T2XuIz34+
         5lpskDxMrhA+zvW/LPkgRpmGqiRGvKvQUNY63ZSW0+yzxcvGFNGNgyF7CtX+mYrZ+gio
         ga/xl80QSZmct3eA/n+GKoEzUocO0Q3NHcUUx7MRO/DU2r/XnIIucQUMjia7cDsKqovv
         9CFpLLAjabj1IXU87peDNBH3wy2GJCMumkmek4VRcwvjJwWujMJ5Iy+0WgQHD1l5GnxN
         SAqg==
X-Gm-Message-State: AOJu0YzD5S6RNtviDxcsxhscuZXHrgIfp4rSvzQJ3Dc2JFT3x99c325q
	DZctQjGbX6SdnO/rLZAH1DaaghDehOY3wn1nESFVCJd4P7u8PWz6iTHY6fNp5j/DENhREwqDg0b
	h
X-Google-Smtp-Source: AGHT+IHT9d6dRZv2UkY2CS17cfJ+3x6TGh873vCLv+jWLP9jrZ7f6kSj/ZWPV1EEPcxTEuz+4PGDXg==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr219651iof.0.1712849813591;
        Thu, 11 Apr 2024 08:36:53 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 187/437] scsi: fnic: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:27 -0600
Message-ID: <20240411153126.16201-188-axboe@kernel.dk>
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
 drivers/scsi/fnic/fnic_debugfs.c | 82 +++++++++++++-------------------
 1 file changed, 33 insertions(+), 49 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_debugfs.c
index 2619a2d4f5f1..2b2315e239f6 100644
--- a/drivers/scsi/fnic/fnic_debugfs.c
+++ b/drivers/scsi/fnic/fnic_debugfs.c
@@ -95,15 +95,13 @@ void fnic_debugfs_terminate(void)
  * Returns:
  * This function returns the amount of data that was read.
  */
-static ssize_t fnic_trace_ctrl_read(struct file *filp,
-				  char __user *ubuf,
-				  size_t cnt, loff_t *ppos)
+static ssize_t fnic_trace_ctrl_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[64];
 	int len;
 	u8 *trace_type;
 	len = 0;
-	trace_type = (u8 *)filp->private_data;
+	trace_type = (u8 *)iocb->ki_filp->private_data;
 	if (*trace_type == fc_trc_flag->fnic_trace)
 		len = sprintf(buf, "%d\n", fnic_tracing_enabled);
 	else if (*trace_type == fc_trc_flag->fc_trace)
@@ -113,7 +111,7 @@ static ssize_t fnic_trace_ctrl_read(struct file *filp,
 	else
 		pr_err("fnic: Cannot read to any debugfs file\n");
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 /*
@@ -133,20 +131,19 @@ static ssize_t fnic_trace_ctrl_read(struct file *filp,
  * Returns:
  * This function returns the amount of data that was written.
  */
-static ssize_t fnic_trace_ctrl_write(struct file *filp,
-				  const char __user *ubuf,
-				  size_t cnt, loff_t *ppos)
+static ssize_t fnic_trace_ctrl_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char buf[64];
 	unsigned long val;
 	int ret;
 	u8 *trace_type;
-	trace_type = (u8 *)filp->private_data;
+	size_t cnt = iov_iter_count(from);
+	trace_type = (u8 *)iocb->ki_filp->private_data;
 
 	if (cnt >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(&buf, ubuf, cnt))
+	if (!copy_from_iter_full(&buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = 0;
@@ -164,16 +161,15 @@ static ssize_t fnic_trace_ctrl_write(struct file *filp,
 	else
 		pr_err("fnic: cannot write to any debugfs file\n");
 
-	(*ppos)++;
-
+	iocb->ki_pos++;
 	return cnt;
 }
 
 static const struct file_operations fnic_trace_ctrl_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = fnic_trace_ctrl_read,
-	.write = fnic_trace_ctrl_write,
+	.read_iter = fnic_trace_ctrl_read,
+	.write_iter = fnic_trace_ctrl_write,
 };
 
 /*
@@ -267,17 +263,12 @@ static loff_t fnic_trace_debugfs_lseek(struct file *file,
  * This function returns the amount of data that was read (this could be
  * less than @nbytes if the end of the file was reached).
  */
-static ssize_t fnic_trace_debugfs_read(struct file *file,
-					char __user *ubuf,
-					size_t nbytes,
-					loff_t *pos)
+static ssize_t fnic_trace_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	fnic_dbgfs_t *fnic_dbg_prt = file->private_data;
-	int rc = 0;
-	rc = simple_read_from_buffer(ubuf, nbytes, pos,
-				  fnic_dbg_prt->buffer,
-				  fnic_dbg_prt->buffer_len);
-	return rc;
+	fnic_dbgfs_t *fnic_dbg_prt = iocb->ki_filp->private_data;
+
+	return simple_copy_to_iter(fnic_dbg_prt->buffer, &iocb->ki_pos,
+					fnic_dbg_prt->buffer_len, to);
 }
 
 /*
@@ -307,7 +298,7 @@ static const struct file_operations fnic_trace_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = fnic_trace_debugfs_open,
 	.llseek = fnic_trace_debugfs_lseek,
-	.read = fnic_trace_debugfs_read,
+	.read_iter = fnic_trace_debugfs_read,
 	.release = fnic_trace_debugfs_release,
 };
 
@@ -459,18 +450,16 @@ static int fnic_reset_stats_open(struct inode *inode, struct file *file)
  * Returns:
  * This function returns the amount of data that was read.
  */
-static ssize_t fnic_reset_stats_read(struct file *file,
-					char __user *ubuf,
-					size_t cnt, loff_t *ppos)
+static ssize_t fnic_reset_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct stats_debug_info *debug = file->private_data;
+	struct stats_debug_info *debug = iocb->ki_filp->private_data;
 	struct fnic *fnic = (struct fnic *)debug->i_private;
 	char buf[64];
 	int len;
 
 	len = sprintf(buf, "%u\n", fnic->reset_stats);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 /*
@@ -487,15 +476,15 @@ static ssize_t fnic_reset_stats_read(struct file *file,
  * Returns:
  * This function returns the amount of data that was written.
  */
-static ssize_t fnic_reset_stats_write(struct file *file,
-					const char __user *ubuf,
-					size_t cnt, loff_t *ppos)
+static ssize_t fnic_reset_stats_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct stats_debug_info *debug = file->private_data;
+	struct stats_debug_info *debug = iocb->ki_filp->private_data;
 	struct fnic *fnic = (struct fnic *)debug->i_private;
 	struct fnic_stats *stats = &fnic->fnic_stats;
 	u64 *io_stats_p = (u64 *)&stats->io_stats;
 	u64 *fw_stats_p = (u64 *)&stats->fw_stats;
+	size_t cnt = iov_iter_count(from);
 	char buf[64];
 	unsigned long val;
 	int ret;
@@ -503,7 +492,7 @@ static ssize_t fnic_reset_stats_write(struct file *file,
 	if (cnt >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(&buf, ubuf, cnt))
+	if (!copy_from_iter_full(&buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = 0;
@@ -534,7 +523,7 @@ static ssize_t fnic_reset_stats_write(struct file *file,
 		ktime_get_real_ts64(&stats->stats_timestamps.last_reset_time);
 	}
 
-	(*ppos)++;
+	iocb->ki_pos++;
 	return cnt;
 }
 
@@ -615,17 +604,12 @@ static int fnic_stats_debugfs_open(struct inode *inode,
  * This function returns the amount of data that was read (this could be
  * less than @nbytes if the end of the file was reached).
  */
-static ssize_t fnic_stats_debugfs_read(struct file *file,
-					char __user *ubuf,
-					size_t nbytes,
-					loff_t *pos)
+static ssize_t fnic_stats_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct stats_debug_info *debug = file->private_data;
-	int rc = 0;
-	rc = simple_read_from_buffer(ubuf, nbytes, pos,
-					debug->debug_buffer,
-					debug->buffer_len);
-	return rc;
+	struct stats_debug_info *debug = iocb->ki_filp->private_data;
+
+	return simple_copy_to_iter(debug->debug_buffer, &iocb->ki_pos,
+					debug->buffer_len, to);
 }
 
 /*
@@ -653,15 +637,15 @@ static int fnic_stats_debugfs_release(struct inode *inode,
 static const struct file_operations fnic_stats_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = fnic_stats_debugfs_open,
-	.read = fnic_stats_debugfs_read,
+	.read_iter = fnic_stats_debugfs_read,
 	.release = fnic_stats_debugfs_release,
 };
 
 static const struct file_operations fnic_reset_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = fnic_reset_stats_open,
-	.read = fnic_reset_stats_read,
-	.write = fnic_reset_stats_write,
+	.read_iter = fnic_reset_stats_read,
+	.write_iter = fnic_reset_stats_write,
 	.release = fnic_reset_stats_release,
 };
 
-- 
2.43.0


