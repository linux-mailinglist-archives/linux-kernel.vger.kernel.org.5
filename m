Return-Path: <linux-kernel+bounces-141193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645B58A1AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8302C1C216AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43511FBC29;
	Thu, 11 Apr 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q+3EEobh"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1611FB093
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850188; cv=none; b=rsfEYjDU4SFlgm+53/G7NHywABHRBlo+3YSMo7F1HPrRB7Pl7LLsjZQLsDxDCNOXisRyHTgsQJ+FADWgy7xVA6uivVgd6xErmXi/pVZQRsByTkSdWOK+RdkpIsadtf9CIfMIN/9lN7E0NVA6ZAQkUBQZoWfihRcE/dTr9fX9qVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850188; c=relaxed/simple;
	bh=g0lIWH0N0zdx5AppWG/FVVxGNCs+tG8DW3d+QUlwwXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNKpYVxWJQWlW7y1qYh1KD1FhLfJgpAN7x+bySC6DM+5becUGiJU2dqJBlLOpR/vtOzBE9/QA3kIZpyBAgzuLWOf8Tot9nHr98+Rjo+2adrRE10gSyaHw2DbGK+s2DRWYIElmmPDu8hvXrg+J9k4IDnWJhl8ouQpOB1hLAekr18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q+3EEobh; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a224d7414so198395ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850185; x=1713454985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcvNWcBSMDpqB+NAzuJWy4wSGo64RVW1rGmLFHq551o=;
        b=q+3EEobhOBuqn7UTJD6Iwt8D1+tDWInM+SqJFRbU7mcstYtiW0o3XYCGqTK/WgYvJY
         2OikCrNOZm9+9/o6c5MHsTnYmHArjNnrJvwTxqIxVduKDD6HPrBjGQVeOlupydrtcvPS
         awk/YDSqfIM9PGe4tsTbkvzm0V1Ah1QvPaMHQ/ll4Bptv8WkJ94Vshc7Xa9QKCBKpTRa
         rdprqyclBLIR7sApORBqlqZgRef7R7/r4PIcdsM97xSx0p+xgS128p9v7tL/Z7HSVJ/b
         tbt+n0ZzoSaSTCcujq9PIi1WoHe2v22xFGtxN8gqi+iQqeZ2TBZJN2Sk/cCzgqzYGDMt
         9h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850185; x=1713454985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcvNWcBSMDpqB+NAzuJWy4wSGo64RVW1rGmLFHq551o=;
        b=URJJ/KYGtKMtFcQQ765qPOEG/tMP0ByU/T1MgCZFziAUGKyoP+tkmaya+l0l2M2QKk
         ZRm6RvBO6DwPBN1WonFYjUDzACT0Bx3AG45V5qqsPX/nGfSTYSRmJpaO/zSt651eEcaq
         zkiL+vuqX27Nv3tUkM4/ROBTWblDuwipcnll5/03+DUeG+8obuMQkfom9Au0AXYIfCfX
         AthxG7QRNyAUbcLrFMkZA3pSTuv/3OveuN5CN+udKppPUAZCuLEHuUviQ5NHctfsBvEC
         j0XxpNbo+SJmbqlYzIidnl7ZsuLBSqIaXeJ07xXj8+hJBl+JggfjnRfDIiwv+1cFu6Rh
         lS/A==
X-Gm-Message-State: AOJu0Yxz8jsofUOS98qWrS1QCRo90zoVjywfKJtBZt6yzqi8Am/VqSRr
	EmQsNAngk4mluFwmZzTSmikvCFJVXfOuxI+A/UMhBKLpLTFS5gFA+yKanTxRn4UZhpcyE1wXJPJ
	P
X-Google-Smtp-Source: AGHT+IFWNIO7UlbbiUAx9Xa4HIiNl0qm3zIeEh/ZwKlE2pEhIwI05i5HbXGSokUcHVdEob7/i08jjQ==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr205841iob.1.1712850185583;
        Thu, 11 Apr 2024 08:43:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 409/437] infiniband/qib: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:09 -0600
Message-ID: <20240411153126.16201-410-axboe@kernel.dk>
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
 drivers/infiniband/hw/qib/qib_debugfs.c  |   2 +-
 drivers/infiniband/hw/qib/qib_diag.c     |  18 ++--
 drivers/infiniband/hw/qib/qib_file_ops.c |   4 +-
 drivers/infiniband/hw/qib/qib_fs.c       | 119 +++++++++++------------
 4 files changed, 68 insertions(+), 75 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_debugfs.c b/drivers/infiniband/hw/qib/qib_debugfs.c
index caeb77d07a58..79144e7b42bd 100644
--- a/drivers/infiniband/hw/qib/qib_debugfs.c
+++ b/drivers/infiniband/hw/qib/qib_debugfs.c
@@ -61,7 +61,7 @@ static int _##name##_open(struct inode *inode, struct file *s) \
 static const struct file_operations _##name##_file_ops = { \
 	.owner   = THIS_MODULE, \
 	.open    = _##name##_open, \
-	.read    = seq_read, \
+	.read_iter = seq_read_iter, \
 	.llseek  = seq_lseek, \
 	.release = seq_release \
 };
diff --git a/drivers/infiniband/hw/qib/qib_diag.c b/drivers/infiniband/hw/qib/qib_diag.c
index 11da796dd1b7..898937c2aead 100644
--- a/drivers/infiniband/hw/qib/qib_diag.c
+++ b/drivers/infiniband/hw/qib/qib_diag.c
@@ -130,15 +130,13 @@ static void return_client(struct qib_diag_client *dc)
 
 static int qib_diag_open(struct inode *in, struct file *fp);
 static int qib_diag_release(struct inode *in, struct file *fp);
-static ssize_t qib_diag_read(struct file *fp, char __user *data,
-			     size_t count, loff_t *off);
-static ssize_t qib_diag_write(struct file *fp, const char __user *data,
-			      size_t count, loff_t *off);
+static ssize_t qib_diag_read_iter(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t qib_diag_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
 static const struct file_operations diag_file_ops = {
 	.owner = THIS_MODULE,
-	.write = qib_diag_write,
-	.read = qib_diag_read,
+	.write_iter = qib_diag_write_iter,
+	.read_iter = qib_diag_read_iter,
 	.open = qib_diag_open,
 	.release = qib_diag_release,
 	.llseek = default_llseek,
@@ -148,12 +146,11 @@ static atomic_t diagpkt_count = ATOMIC_INIT(0);
 static struct cdev *diagpkt_cdev;
 static struct device *diagpkt_device;
 
-static ssize_t qib_diagpkt_write(struct file *fp, const char __user *data,
-				 size_t count, loff_t *off);
+static ssize_t qib_diagpkt_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
 static const struct file_operations diagpkt_file_ops = {
 	.owner = THIS_MODULE,
-	.write = qib_diagpkt_write,
+	.write_iter = qib_diagpkt_write_iter,
 	.llseek = noop_llseek,
 };
 
@@ -672,6 +669,7 @@ static ssize_t qib_diagpkt_write(struct file *fp,
 	vfree(tmpbuf);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(qib_diagpkt_write);
 
 static int qib_diag_release(struct inode *in, struct file *fp)
 {
@@ -829,6 +827,7 @@ static ssize_t qib_diag_read(struct file *fp, char __user *data,
 bail:
 	return ret;
 }
+FOPS_READ_ITER_HELPER(qib_diag_read);
 
 static ssize_t qib_diag_write(struct file *fp, const char __user *data,
 			      size_t count, loff_t *off)
@@ -904,3 +903,4 @@ static ssize_t qib_diag_write(struct file *fp, const char __user *data,
 bail:
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(qib_diag_write);
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 29e4c59aa23b..5bfecbbe2173 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -68,7 +68,6 @@ static int qib_mmapf(struct file *, struct vm_area_struct *);
  */
 static const struct file_operations qib_file_ops = {
 	.owner = THIS_MODULE,
-	.write = qib_write,
 	.write_iter = qib_write_iter,
 	.open = qib_open,
 	.release = qib_close,
@@ -2244,6 +2243,9 @@ static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct qib_ctxtdata *rcd = ctxt_fp(iocb->ki_filp);
 	struct qib_user_sdma_queue *pq = fp->pq;
 
+	if (!(iocb->ki_flags & IOCB_VECTORED))
+		vfs_write_iter(iocb, from, qib_write);
+
 	if (!user_backed_iter(from) || !from->nr_segs || !pq)
 		return -EINVAL;
 
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index 455e966eeff3..87817e706e05 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -100,12 +100,11 @@ static int create_file(const char *name, umode_t mode,
 	return error;
 }
 
-static ssize_t driver_stats_read(struct file *file, char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t driver_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	qib_stats.sps_ints = qib_sps_ints();
-	return simple_read_from_buffer(buf, count, ppos, &qib_stats,
-				       sizeof(qib_stats));
+	return simple_copy_to_iter(&qib_stats, &iocb->ki_pos, sizeof(qib_stats),
+					to);
 }
 
 /*
@@ -128,45 +127,42 @@ static const char qib_statnames[] =
 	"EgrHdrFull\n"
 	;
 
-static ssize_t driver_names_read(struct file *file, char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t driver_names_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(buf, count, ppos, qib_statnames,
-		sizeof(qib_statnames) - 1); /* no null */
+	return simple_copy_to_iter(qib_statnames, &iocb->ki_pos,
+		sizeof(qib_statnames) - 1, to); /* no null */
 }
 
 static const struct file_operations driver_ops[] = {
-	{ .read = driver_stats_read, .llseek = generic_file_llseek, },
-	{ .read = driver_names_read, .llseek = generic_file_llseek, },
+	{ .read_iter = driver_stats_read, .llseek = generic_file_llseek, },
+	{ .read_iter = driver_names_read, .llseek = generic_file_llseek, },
 };
 
 /* read the per-device counters */
-static ssize_t dev_counters_read(struct file *file, char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t dev_counters_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	u64 *counters;
 	size_t avail;
-	struct qib_devdata *dd = private2dd(file);
+	struct qib_devdata *dd = private2dd(iocb->ki_filp);
 
-	avail = dd->f_read_cntrs(dd, *ppos, NULL, &counters);
-	return simple_read_from_buffer(buf, count, ppos, counters, avail);
+	avail = dd->f_read_cntrs(dd, iocb->ki_pos, NULL, &counters);
+	return simple_copy_to_iter(counters, &iocb->ki_pos, avail, to);
 }
 
 /* read the per-device counters */
-static ssize_t dev_names_read(struct file *file, char __user *buf,
-			      size_t count, loff_t *ppos)
+static ssize_t dev_names_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *names;
 	size_t avail;
-	struct qib_devdata *dd = private2dd(file);
+	struct qib_devdata *dd = private2dd(iocb->ki_filp);
 
-	avail = dd->f_read_cntrs(dd, *ppos, &names, NULL);
-	return simple_read_from_buffer(buf, count, ppos, names, avail);
+	avail = dd->f_read_cntrs(dd, iocb->ki_pos, &names, NULL);
+	return simple_copy_to_iter(names, &iocb->ki_pos, avail, to);
 }
 
 static const struct file_operations cntr_ops[] = {
-	{ .read = dev_counters_read, .llseek = generic_file_llseek, },
-	{ .read = dev_names_read, .llseek = generic_file_llseek, },
+	{ .read_iter = dev_counters_read, .llseek = generic_file_llseek, },
+	{ .read_iter = dev_names_read, .llseek = generic_file_llseek, },
 };
 
 /*
@@ -175,54 +171,50 @@ static const struct file_operations cntr_ops[] = {
  */
 
 /* read the per-port names (same for each port) */
-static ssize_t portnames_read(struct file *file, char __user *buf,
-			      size_t count, loff_t *ppos)
+static ssize_t portnames_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *names;
 	size_t avail;
-	struct qib_devdata *dd = private2dd(file);
+	struct qib_devdata *dd = private2dd(iocb->ki_filp);
 
-	avail = dd->f_read_portcntrs(dd, *ppos, 0, &names, NULL);
-	return simple_read_from_buffer(buf, count, ppos, names, avail);
+	avail = dd->f_read_portcntrs(dd, iocb->ki_pos, 0, &names, NULL);
+	return simple_copy_to_iter(names, &iocb->ki_pos, avail, to);
 }
 
 /* read the per-port counters for port 1 (pidx 0) */
-static ssize_t portcntrs_1_read(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t portcntrs_1_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	u64 *counters;
 	size_t avail;
-	struct qib_devdata *dd = private2dd(file);
+	struct qib_devdata *dd = private2dd(iocb->ki_filp);
 
-	avail = dd->f_read_portcntrs(dd, *ppos, 0, NULL, &counters);
-	return simple_read_from_buffer(buf, count, ppos, counters, avail);
+	avail = dd->f_read_portcntrs(dd, iocb->ki_pos, 0, NULL, &counters);
+	return simple_copy_to_iter(counters, &iocb->ki_pos, avail, to);
 }
 
 /* read the per-port counters for port 2 (pidx 1) */
-static ssize_t portcntrs_2_read(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t portcntrs_2_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	u64 *counters;
 	size_t avail;
-	struct qib_devdata *dd = private2dd(file);
+	struct qib_devdata *dd = private2dd(iocb->ki_filp);
 
-	avail = dd->f_read_portcntrs(dd, *ppos, 1, NULL, &counters);
-	return simple_read_from_buffer(buf, count, ppos, counters, avail);
+	avail = dd->f_read_portcntrs(dd, iocb->ki_pos, 1, NULL, &counters);
+	return simple_copy_to_iter(counters, &iocb->ki_pos, avail, to);
 }
 
 static const struct file_operations portcntr_ops[] = {
-	{ .read = portnames_read, .llseek = generic_file_llseek, },
-	{ .read = portcntrs_1_read, .llseek = generic_file_llseek, },
-	{ .read = portcntrs_2_read, .llseek = generic_file_llseek, },
+	{ .read_iter = portnames_read, .llseek = generic_file_llseek, },
+	{ .read_iter = portcntrs_1_read, .llseek = generic_file_llseek, },
+	{ .read_iter = portcntrs_2_read, .llseek = generic_file_llseek, },
 };
 
 /*
  * read the per-port QSFP data for port 1 (pidx 0)
  */
-static ssize_t qsfp_1_read(struct file *file, char __user *buf,
-			   size_t count, loff_t *ppos)
+static ssize_t qsfp_1_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct qib_devdata *dd = private2dd(file);
+	struct qib_devdata *dd = private2dd(iocb->ki_filp);
 	char *tmp;
 	int ret;
 
@@ -232,7 +224,7 @@ static ssize_t qsfp_1_read(struct file *file, char __user *buf,
 
 	ret = qib_qsfp_dump(dd->pport, tmp, PAGE_SIZE);
 	if (ret > 0)
-		ret = simple_read_from_buffer(buf, count, ppos, tmp, ret);
+		ret = simple_copy_to_iter(tmp, &iocb->ki_pos, ret, to);
 	kfree(tmp);
 	return ret;
 }
@@ -240,10 +232,9 @@ static ssize_t qsfp_1_read(struct file *file, char __user *buf,
 /*
  * read the per-port QSFP data for port 2 (pidx 1)
  */
-static ssize_t qsfp_2_read(struct file *file, char __user *buf,
-			   size_t count, loff_t *ppos)
+static ssize_t qsfp_2_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct qib_devdata *dd = private2dd(file);
+	struct qib_devdata *dd = private2dd(iocb->ki_filp);
 	char *tmp;
 	int ret;
 
@@ -256,25 +247,25 @@ static ssize_t qsfp_2_read(struct file *file, char __user *buf,
 
 	ret = qib_qsfp_dump(dd->pport + 1, tmp, PAGE_SIZE);
 	if (ret > 0)
-		ret = simple_read_from_buffer(buf, count, ppos, tmp, ret);
+		ret = simple_copy_to_iter(tmp, &iocb->ki_pos, ret, to);
 	kfree(tmp);
 	return ret;
 }
 
 static const struct file_operations qsfp_ops[] = {
-	{ .read = qsfp_1_read, .llseek = generic_file_llseek, },
-	{ .read = qsfp_2_read, .llseek = generic_file_llseek, },
+	{ .read_iter = qsfp_1_read, .llseek = generic_file_llseek, },
+	{ .read_iter = qsfp_2_read, .llseek = generic_file_llseek, },
 };
 
-static ssize_t flash_read(struct file *file, char __user *buf,
-			  size_t count, loff_t *ppos)
+static ssize_t flash_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct qib_devdata *dd;
 	ssize_t ret;
 	loff_t pos;
 	char *tmp;
 
-	pos = *ppos;
+	pos = iocb->ki_pos;
 
 	if (pos < 0) {
 		ret = -EINVAL;
@@ -295,19 +286,19 @@ static ssize_t flash_read(struct file *file, char __user *buf,
 		goto bail;
 	}
 
-	dd = private2dd(file);
+	dd = private2dd(iocb->ki_filp);
 	if (qib_eeprom_read(dd, pos, tmp, count)) {
 		qib_dev_err(dd, "failed to read from flash\n");
 		ret = -ENXIO;
 		goto bail_tmp;
 	}
 
-	if (copy_to_user(buf, tmp, count)) {
+	if (!copy_to_iter_full(tmp, count, to)) {
 		ret = -EFAULT;
 		goto bail_tmp;
 	}
 
-	*ppos = pos + count;
+	iocb->ki_pos = pos + count;
 	ret = count;
 
 bail_tmp:
@@ -317,31 +308,31 @@ static ssize_t flash_read(struct file *file, char __user *buf,
 	return ret;
 }
 
-static ssize_t flash_write(struct file *file, const char __user *buf,
-			   size_t count, loff_t *ppos)
+static ssize_t flash_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct qib_devdata *dd;
 	ssize_t ret;
 	loff_t pos;
 	char *tmp;
 
-	pos = *ppos;
+	pos = iocb->ki_pos;
 
 	if (pos != 0 || count != sizeof(struct qib_flash))
 		return -EINVAL;
 
-	tmp = memdup_user(buf, count);
+	tmp = iterdup(from, count);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	dd = private2dd(file);
+	dd = private2dd(iocb->ki_filp);
 	if (qib_eeprom_write(dd, pos, tmp, count)) {
 		ret = -ENXIO;
 		qib_dev_err(dd, "failed to write to flash\n");
 		goto bail_tmp;
 	}
 
-	*ppos = pos + count;
+	iocb->ki_pos = pos + count;
 	ret = count;
 
 bail_tmp:
@@ -350,8 +341,8 @@ static ssize_t flash_write(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations flash_ops = {
-	.read = flash_read,
-	.write = flash_write,
+	.read_iter = flash_read,
+	.write_iter = flash_write,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


