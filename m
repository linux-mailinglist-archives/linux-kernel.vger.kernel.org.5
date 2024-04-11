Return-Path: <linux-kernel+bounces-140902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF538A197C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462DD28843B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929D15E5AF;
	Thu, 11 Apr 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W+0bx4ec"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41A15E215
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849736; cv=none; b=j2vsuhEVwSBwX9Zml9srm6UdvK6awZvIACGToaXCw2PIPL4BjByB57WC/gsVIP9KGxfKDM6C2sLZgLreNCDFmBj3wZq4LlvdZnruVGi67jq0Lwu72gZPFZ4SAzPY5LlZJ5FDxlr48z8N9weJPSP0ZF1KCQT7/oGiKTTTF5H02EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849736; c=relaxed/simple;
	bh=5xe9jRMxDoCB0HZYWN+nEJ6OLqj9Atl3s8UCsRCpkSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8FsLv0vuDi8Bx+wgVjAdl0ImRW02GgEXmUpXte97YxtykGahkGCFuGqxQGLwRmi5mC1Pyd31TEMI8v1wvUqDrSXRJdLnGU7+NUxuklmAHaTNYe12mSmrmACQlbv30eFRvCPKAeqLkPf+QIZQlgwdjiS76hjeTc0XUoJ3/idqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W+0bx4ec; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58053039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849734; x=1713454534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onVXsekqILXYLFJqWP9FkN2dHXUc/kieAaTnFHuLlLA=;
        b=W+0bx4ecEAQFOGGM+aSM9pYvtoUwTZc3AQlU4Z7wwoQ1E/cVIGagqvmVUvGROxq4xd
         GRhIccEuMH3EnECUpkBWGX3RnhJrQOwkJuFjlNOCufFJlXxK5eWgwNlb0XR3EbpglM6U
         6XR8pFyB3FIjiWfSu0FhvvAGzOnC44VAk1hsubxSdItabXLKAaw6q1tq7+VjsHizU2nI
         Ye59Nf/TC+PU3KMU1h7sO/B5/o0uQlPWtQj1Wb4B9FixHbDtLmRaW+5A+vdkSlbl9hUa
         h7C/anIYnAdFiVw7cDefNw+maao2H06CypCr9UDx6Hw7+hJ8E1/kSErt5f5/5kKr+uMI
         WXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849734; x=1713454534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onVXsekqILXYLFJqWP9FkN2dHXUc/kieAaTnFHuLlLA=;
        b=PZT7xBWxrMRJv6U5KY+5LccIicR0XTq8RNIFnrgrELxjrJagitTU3kmHR/sSlxwwdJ
         2SkHlJ7GNDHrqDzYffbpKCR8YK6Jkqt5kK5l3gQM/5ZF4h0OpxHjMXmLBcZ3TK8uAJ37
         Cwk7kcBNkp3b0Rz3+ZX7vqxwwYGsBc2HfYu63OlCj3B0bGElD+L0GDyk1yFJ7a1fYbVa
         e07hv9UgY/754J8k9kFEHaf65UFwnPBcbV38PC/wJ3nQuEQHHaN4SJZ39IJxJg0DQDzw
         2gWNtono7M1thtunVHXvpRS3OWkYuyi/xcBKbvKyqwCmm4TQDq4p4QDY2lTcKdczJl4P
         uufA==
X-Gm-Message-State: AOJu0Yz2+gmYmHyvf7ISyxWAhtDJIjj3bhTDmxnLoiWeR6QpJrLjOjVG
	fSDIV5wqfHRO5Qb06b0OEB0pmUQlz2eiZwk2kG3CNhtNgBRrmwg5ZADUJEboHssCILTFRJI7tqb
	Q
X-Google-Smtp-Source: AGHT+IGmButBnNJfkfgBXvfJ3qnEJ1rm2MMsS0tuokexDUrQ/pjV+Zi8bhmeft6bKxq1A3aqsge35Q==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr203572iog.0.1712849734093;
        Thu, 11 Apr 2024 08:35:34 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 140/437] drm: msm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:40 -0600
Message-ID: <20240411153126.16201-141-axboe@kernel.dk>
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 20 +++++++++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       | 20 +++++++++----------
 drivers/gpu/drm/msm/dp/dp_debug.c             | 15 +++++++-------
 drivers/gpu/drm/msm/msm_debugfs.c             |  4 ++--
 drivers/gpu/drm/msm/msm_perf.c                | 12 +++++------
 drivers/gpu/drm/msm/msm_rd.c                  | 12 +++++------
 6 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index ef871239adb2..c8971ba26cd4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -398,14 +398,15 @@ int dpu_core_perf_crtc_update(struct drm_crtc *crtc,
 
 #ifdef CONFIG_DEBUG_FS
 
-static ssize_t _dpu_core_perf_mode_write(struct file *file,
-		    const char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t _dpu_core_perf_mode_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct dpu_core_perf *perf = file->private_data;
+	struct dpu_core_perf *perf = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 perf_mode = 0;
 	int ret;
 
-	ret = kstrtouint_from_user(user_buf, count, 0, &perf_mode);
+	ret = kstrtouint_from_iter(from, count, 0, &perf_mode);
 	if (ret)
 		return ret;
 
@@ -426,10 +427,9 @@ static ssize_t _dpu_core_perf_mode_write(struct file *file,
 	return count;
 }
 
-static ssize_t _dpu_core_perf_mode_read(struct file *file,
-			char __user *buff, size_t count, loff_t *ppos)
+static ssize_t _dpu_core_perf_mode_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dpu_core_perf *perf = file->private_data;
+	struct dpu_core_perf *perf = iocb->ki_filp->private_data;
 	int len;
 	char buf[128];
 
@@ -437,13 +437,13 @@ static ssize_t _dpu_core_perf_mode_read(struct file *file,
 			"mode %d\n",
 			perf->perf_tune.mode);
 
-	return simple_read_from_buffer(buff, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations dpu_core_perf_mode_fops = {
 	.open = simple_open,
-	.read = _dpu_core_perf_mode_read,
-	.write = _dpu_core_perf_mode_write,
+	.read_iter = _dpu_core_perf_mode_read,
+	.write_iter = _dpu_core_perf_mode_write,
 };
 
 int dpu_core_perf_debugfs_init(struct dpu_kms *dpu_kms, struct dentry *parent)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index a1f5d7c4ab91..0c1484439229 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -105,16 +105,15 @@ static int dpu_debugfs_safe_stats_show(struct seq_file *s, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(dpu_debugfs_safe_stats);
 
-static ssize_t _dpu_plane_danger_read(struct file *file,
-			char __user *buff, size_t count, loff_t *ppos)
+static ssize_t _dpu_plane_danger_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dpu_kms *kms = file->private_data;
+	struct dpu_kms *kms = iocb->ki_filp->private_data;
 	int len;
 	char buf[40];
 
 	len = scnprintf(buf, sizeof(buf), "%d\n", !kms->has_danger_ctrl);
 
-	return simple_read_from_buffer(buff, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static void _dpu_plane_set_danger_state(struct dpu_kms *kms, bool enable)
@@ -140,14 +139,15 @@ static void _dpu_plane_set_danger_state(struct dpu_kms *kms, bool enable)
 	}
 }
 
-static ssize_t _dpu_plane_danger_write(struct file *file,
-		    const char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t _dpu_plane_danger_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct dpu_kms *kms = file->private_data;
+	struct dpu_kms *kms = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int disable_panic;
 	int ret;
 
-	ret = kstrtouint_from_user(user_buf, count, 0, &disable_panic);
+	ret = kstrtouint_from_iter(from, count, 0, &disable_panic);
 	if (ret)
 		return ret;
 
@@ -168,8 +168,8 @@ static ssize_t _dpu_plane_danger_write(struct file *file,
 
 static const struct file_operations dpu_plane_danger_enable = {
 	.open = simple_open,
-	.read = _dpu_plane_danger_read,
-	.write = _dpu_plane_danger_write,
+	.read_iter = _dpu_plane_danger_read,
+	.write_iter = _dpu_plane_danger_write,
 };
 
 static void dpu_debugfs_danger_init(struct dpu_kms *dpu_kms,
diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
index eca5a02f9003..7589f40309ff 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.c
+++ b/drivers/gpu/drm/msm/dp/dp_debug.c
@@ -123,23 +123,22 @@ static int dp_test_type_show(struct seq_file *m, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(dp_test_type);
 
-static ssize_t dp_test_active_write(struct file *file,
-		const char __user *ubuf,
-		size_t len, loff_t *offp)
+static ssize_t dp_test_active_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char *input_buffer;
 	int status = 0;
 	const struct dp_debug_private *debug;
 	const struct drm_connector *connector;
+	size_t len = iov_iter_count(from);
 	int val = 0;
 
-	debug = ((struct seq_file *)file->private_data)->private;
+	debug = ((struct seq_file *)iocb->ki_filp->private_data)->private;
 	connector = debug->connector;
 
 	if (len == 0)
 		return 0;
 
-	input_buffer = memdup_user_nul(ubuf, len);
+	input_buffer = iterdup_nul(from, len);
 	if (IS_ERR(input_buffer))
 		return PTR_ERR(input_buffer);
 
@@ -162,7 +161,7 @@ static ssize_t dp_test_active_write(struct file *file,
 	}
 	kfree(input_buffer);
 
-	*offp += len;
+	iocb->ki_pos += len;
 	return len;
 }
 
@@ -193,10 +192,10 @@ static int dp_test_active_open(struct inode *inode,
 static const struct file_operations test_active_fops = {
 	.owner = THIS_MODULE,
 	.open = dp_test_active_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = dp_test_active_write
+	.write_iter = dp_test_active_write,
 };
 
 static void dp_debug_init(struct dp_debug *dp_debug, struct dentry *root, bool is_edp)
diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index 4494f6d1c7cb..237bb6dace46 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -112,7 +112,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 static const struct file_operations msm_gpu_fops = {
 	.owner = THIS_MODULE,
 	.open = msm_gpu_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = msm_gpu_release,
 };
@@ -175,7 +175,7 @@ static int msm_kms_open(struct inode *inode, struct file *file)
 static const struct file_operations msm_kms_fops = {
 	.owner = THIS_MODULE,
 	.open = msm_kms_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = msm_kms_release,
 };
diff --git a/drivers/gpu/drm/msm/msm_perf.c b/drivers/gpu/drm/msm/msm_perf.c
index 3d3da79fec2a..494d714ce6a2 100644
--- a/drivers/gpu/drm/msm/msm_perf.c
+++ b/drivers/gpu/drm/msm/msm_perf.c
@@ -117,10 +117,10 @@ static int refill_buf(struct msm_perf_state *perf)
 	return 0;
 }
 
-static ssize_t perf_read(struct file *file, char __user *buf,
-		size_t sz, loff_t *ppos)
+static ssize_t perf_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct msm_perf_state *perf = file->private_data;
+	struct msm_perf_state *perf = iocb->ki_filp->private_data;
+	size_t sz = iov_iter_count(to);
 	int n = 0, ret = 0;
 
 	mutex_lock(&perf->read_lock);
@@ -132,13 +132,13 @@ static ssize_t perf_read(struct file *file, char __user *buf,
 	}
 
 	n = min((int)sz, perf->buftot - perf->bufpos);
-	if (copy_to_user(buf, &perf->buf[perf->bufpos], n)) {
+	if (!copy_to_iter_full(&perf->buf[perf->bufpos], n, to)) {
 		ret = -EFAULT;
 		goto out;
 	}
 
 	perf->bufpos += n;
-	*ppos += n;
+	iocb->ki_pos += n;
 
 out:
 	mutex_unlock(&perf->read_lock);
@@ -191,7 +191,7 @@ static int perf_release(struct inode *inode, struct file *file)
 static const struct file_operations perf_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = perf_open,
-	.read = perf_read,
+	.read_iter = perf_read,
 	.llseek = no_llseek,
 	.release = perf_release,
 };
diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index ca44fd291c5b..d5f65377ba65 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -130,12 +130,12 @@ static void rd_write_section(struct msm_rd_state *rd,
 	rd_write(rd, buf, sz);
 }
 
-static ssize_t rd_read(struct file *file, char __user *buf,
-		size_t sz, loff_t *ppos)
+static ssize_t rd_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct msm_rd_state *rd = file->private_data;
+	struct msm_rd_state *rd = iocb->ki_filp->private_data;
 	struct circ_buf *fifo = &rd->fifo;
 	const char *fptr = &fifo->buf[fifo->tail];
+	size_t sz = iov_iter_count(to);
 	int n = 0, ret = 0;
 
 	mutex_lock(&rd->read_lock);
@@ -150,13 +150,13 @@ static ssize_t rd_read(struct file *file, char __user *buf,
 	 * once.
 	 */
 	n = min_t(int, sz, circ_count_to_end(&rd->fifo));
-	if (copy_to_user(buf, fptr, n)) {
+	if (!copy_to_iter_full(fptr, n, to)) {
 		ret = -EFAULT;
 		goto out;
 	}
 
 	smp_store_release(&fifo->tail, (fifo->tail + n) & (BUF_SZ - 1));
-	*ppos += n;
+	iocb->ki_pos += n;
 
 	wake_up_all(&rd->fifo_event);
 
@@ -226,7 +226,7 @@ static int rd_release(struct inode *inode, struct file *file)
 static const struct file_operations rd_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = rd_open,
-	.read = rd_read,
+	.read_iter = rd_read,
 	.llseek = no_llseek,
 	.release = rd_release,
 };
-- 
2.43.0


