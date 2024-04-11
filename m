Return-Path: <linux-kernel+bounces-140900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB708A197B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58EA288551
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2E917C66;
	Thu, 11 Apr 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KSvwOP9W"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D915E21B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849735; cv=none; b=ET34/99iG954WUPqE/oBA7oU/Ym4cpeU+C5Ucm6GsLiaBl46A2jTn6Yb5voHZfUBu6ORFtbbUKmcZwz5HKVSt0Ou1nAmORgOeUX1EAf9dmRzveO+kHWuGLyXKw72DzrfO+XByoHyps5Kox4okKu9X1SgyqPR9heCZVzLoLaUhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849735; c=relaxed/simple;
	bh=gIlHkHIf61Gez+c2sdXbASHWqOSZOEG/tbFoAfwxOpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAKkBRoTuzMEeXzV18fmjVJVQryERuufOjinBWAWw7xzyrQ/crbQ3dJWSz5hVD/mqW6BQj/P4O0nwQRqh/0oyYRwB8uALRlhDuXMDB6VdmkNpO3erOd68o0mGycMZabcgAl3z+uZsHZPEXtY3Ytfm4V1QQJXKyVwBeP+jTfJVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KSvwOP9W; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9778239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849731; x=1713454531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRmIr7Avw9RuGzUP4Y4BTwANpRPwBbbiIM0lKveuv/U=;
        b=KSvwOP9WnimDsss4Vqdd6qm2KSD/F7OW2KCMz6lxNUQDqJ2qi/jxSZhzaArzpwu5WP
         HyVJSxa6SeRahjMpl06enf7vUu43kEvAkIyfYXMU7j6UB4+o+hKXzJ1/A0rKW/6qe2YU
         H8kCX0EyCJzUbzi0xwcwRlh0k8g2F4J4ZdXiEpDgSMtiRLVRjsWOxxGTwh1MW7cDg7Yt
         zslO8wP4T1PgkFtDvFehckeMFSEf65xm3bK1Sb43DjX3Ws3alRVnBodZUPQHgU3/6NRl
         06AgA2472yduci4EDn5cDdyJoPkcfQ4hCWMCfFYMKyrLfA3DmHE6RbCk8PCOQc0EaUeH
         Y3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849731; x=1713454531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRmIr7Avw9RuGzUP4Y4BTwANpRPwBbbiIM0lKveuv/U=;
        b=qhHA2pjjawkecdeLSYItnCX8UcBSxNF1NmZtZankSYejXOhJv8XxAbmOaU8E2h0j44
         gAExMgXt/mCcNJPbZX7U8UvBwvt8bjPUmF4Ko7wKBZPbkJeUQUHLpSV/4e6P9O17Yanl
         63lu4My0Qh5LLPdt3XQklOoZGgJ2WAu7Sht13UnC7Vq+3Duao16G8V58yESihr7E/8r6
         fnu6Uef+7ROWkpjOLb+qUlVRwJmLz2YSsMWx1lGtb2adFKMUPYTZAK1pL2r2J8/EAqlb
         DexlKJeTB00qDB0lMpL36t/9k3y1DSooh9gXbf30U75TAnL12Yn+wm8JrkRsdzNldaDo
         D44Q==
X-Gm-Message-State: AOJu0YyDjyCs+dZHyrJoOrHBxrcZGkKY2nDkzkZjTIDMI2/YF5ehwAYt
	KoEWOg8kARJoKcvaI2V+KIybOSxhw5+FdvWxAoutM/odoXeTRfZNH5oQo6G6Y6Fqymsb8Ir8Wj5
	X
X-Google-Smtp-Source: AGHT+IEd8+9TyzkO0VQDRsEXi2i7drOC29DRylhM7Oed4nEzkPukvXGRdIDGE/p1lc7R6G32JP54cA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr192372iop.1.1712849731018;
        Thu, 11 Apr 2024 08:35:31 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 138/437] drm/i915: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:38 -0600
Message-ID: <20240411153126.16201-139-axboe@kernel.dk>
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
 .../drm/i915/display/intel_display_debugfs.c  | 114 +++++++++---------
 .../display/intel_display_debugfs_params.c    |  36 +++---
 drivers/gpu/drm/i915/display/intel_hotplug.c  |  28 ++---
 drivers/gpu/drm/i915/display/intel_wm.c       |  42 +++----
 drivers/gpu/drm/i915/display/skl_watermark.c  |  14 +--
 drivers/gpu/drm/i915/gt/intel_gt_debugfs.c    |   2 +-
 drivers/gpu/drm/i915/gt/intel_gt_debugfs.h    |   2 +-
 .../drm/i915/gt/uc/intel_guc_log_debugfs.c    |  13 +-
 drivers/gpu/drm/i915/i915_debugfs_params.c    |  43 ++++---
 drivers/gpu/drm/i915/i915_gpu_error.c         |  28 ++---
 drivers/gpu/drm/i915/i915_perf.c              |   3 +-
 11 files changed, 156 insertions(+), 169 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index b99c024b0934..b8d03be584dd 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -513,26 +513,24 @@ static int crtc_updates_open(struct inode *inode, struct file *file)
 	return single_open(file, crtc_updates_show, inode->i_private);
 }
 
-static ssize_t crtc_updates_write(struct file *file,
-				  const char __user *ubuf,
-				  size_t len, loff_t *offp)
+static ssize_t crtc_updates_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct intel_crtc *crtc = m->private;
 
 	/* May race with an update. Meh. */
 	memset(&crtc->debug.vbl, 0, sizeof(crtc->debug.vbl));
 
-	return len;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations crtc_updates_fops = {
 	.owner = THIS_MODULE,
 	.open = crtc_updates_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = crtc_updates_write
+	.write_iter = crtc_updates_write
 };
 
 static void crtc_updates_add(struct intel_crtc *crtc)
@@ -801,24 +799,24 @@ static int i915_dp_mst_info(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static ssize_t i915_displayport_test_active_write(struct file *file,
-						  const char __user *ubuf,
-						  size_t len, loff_t *offp)
+static ssize_t i915_displayport_test_active_write(struct kiocb *iocb,
+						  struct iov_iter *from)
 {
 	char *input_buffer;
 	int status = 0;
 	struct drm_device *dev;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
+	size_t len = iov_iter_count(from);
 	struct intel_dp *intel_dp;
 	int val = 0;
 
-	dev = ((struct seq_file *)file->private_data)->private;
+	dev = ((struct seq_file *)iocb->ki_filp->private_data)->private;
 
 	if (len == 0)
 		return 0;
 
-	input_buffer = memdup_user_nul(ubuf, len);
+	input_buffer = iterdup_nul(from, len);
 	if (IS_ERR(input_buffer))
 		return PTR_ERR(input_buffer);
 
@@ -856,7 +854,7 @@ static ssize_t i915_displayport_test_active_write(struct file *file,
 	if (status < 0)
 		return status;
 
-	*offp += len;
+	iocb->ki_pos += len;
 	return len;
 }
 
@@ -903,10 +901,10 @@ static int i915_displayport_test_active_open(struct inode *inode,
 static const struct file_operations i915_displayport_test_active_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_displayport_test_active_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = i915_displayport_test_active_write
+	.write_iter = i915_displayport_test_active_write,
 };
 
 static int i915_displayport_test_data_show(struct seq_file *m, void *data)
@@ -994,16 +992,15 @@ static int i915_displayport_test_type_show(struct seq_file *m, void *data)
 DEFINE_SHOW_ATTRIBUTE(i915_displayport_test_type);
 
 static ssize_t
-i915_fifo_underrun_reset_write(struct file *filp,
-			       const char __user *ubuf,
-			       size_t cnt, loff_t *ppos)
+i915_fifo_underrun_reset_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct drm_i915_private *dev_priv = filp->private_data;
+	struct drm_i915_private *dev_priv = iocb->ki_filp->private_data;
+	size_t cnt = iov_iter_count(from);
 	struct intel_crtc *crtc;
 	int ret;
 	bool reset;
 
-	ret = kstrtobool_from_user(ubuf, cnt, &reset);
+	ret = kstrtobool_from_iter(from, cnt, &reset);
 	if (ret)
 		return ret;
 
@@ -1048,7 +1045,7 @@ i915_fifo_underrun_reset_write(struct file *filp,
 static const struct file_operations i915_fifo_underrun_reset_ops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = i915_fifo_underrun_reset_write,
+	.write_iter = i915_fifo_underrun_reset_write,
 	.llseek = default_llseek,
 };
 
@@ -1259,15 +1256,15 @@ static int i915_dsc_fec_support_show(struct seq_file *m, void *data)
 	return ret;
 }
 
-static ssize_t i915_dsc_fec_support_write(struct file *file,
-					  const char __user *ubuf,
-					  size_t len, loff_t *offp)
+static ssize_t i915_dsc_fec_support_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct intel_connector *connector = m->private;
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 	struct intel_encoder *encoder = intel_attached_encoder(connector);
 	struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
+	size_t len = iov_iter_count(from);
 	bool dsc_enable = false;
 	int ret;
 
@@ -1277,7 +1274,7 @@ static ssize_t i915_dsc_fec_support_write(struct file *file,
 	drm_dbg(&i915->drm,
 		"Copied %zu bytes from user to force DSC\n", len);
 
-	ret = kstrtobool_from_user(ubuf, len, &dsc_enable);
+	ret = kstrtobool_from_iter(from, len, &dsc_enable);
 	if (ret < 0)
 		return ret;
 
@@ -1285,7 +1282,7 @@ static ssize_t i915_dsc_fec_support_write(struct file *file,
 		(dsc_enable) ? "true" : "false");
 	intel_dp->force_dsc_en = dsc_enable;
 
-	*offp += len;
+	iocb->ki_pos += len;
 	return len;
 }
 
@@ -1299,10 +1296,10 @@ static int i915_dsc_fec_support_open(struct inode *inode,
 static const struct file_operations i915_dsc_fec_support_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_dsc_fec_support_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = i915_dsc_fec_support_write
+	.write_iter = i915_dsc_fec_support_write
 };
 
 static int i915_dsc_bpc_show(struct seq_file *m, void *data)
@@ -1335,23 +1332,22 @@ out:	drm_modeset_unlock(&i915->drm.mode_config.connection_mutex);
 	return ret;
 }
 
-static ssize_t i915_dsc_bpc_write(struct file *file,
-				  const char __user *ubuf,
-				  size_t len, loff_t *offp)
+static ssize_t i915_dsc_bpc_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct intel_connector *connector = m->private;
 	struct intel_encoder *encoder = intel_attached_encoder(connector);
 	struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
+	size_t len = iov_iter_count(from);
 	int dsc_bpc = 0;
 	int ret;
 
-	ret = kstrtoint_from_user(ubuf, len, 0, &dsc_bpc);
+	ret = kstrtoint_from_iter(from, len, 0, &dsc_bpc);
 	if (ret < 0)
 		return ret;
 
 	intel_dp->force_dsc_bpc = dsc_bpc;
-	*offp += len;
+	iocb->ki_pos += len;
 
 	return len;
 }
@@ -1365,10 +1361,10 @@ static int i915_dsc_bpc_open(struct inode *inode,
 static const struct file_operations i915_dsc_bpc_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_dsc_bpc_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = i915_dsc_bpc_write
+	.write_iter = i915_dsc_bpc_write
 };
 
 static int i915_dsc_output_format_show(struct seq_file *m, void *data)
@@ -1416,33 +1412,33 @@ static int i915_bigjoiner_enable_show(struct seq_file *m, void *data)
 	return 0;
 }
 
-static ssize_t i915_dsc_output_format_write(struct file *file,
-					    const char __user *ubuf,
-					    size_t len, loff_t *offp)
+static ssize_t i915_dsc_output_format_write(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct intel_connector *connector = m->private;
 	struct intel_encoder *encoder = intel_attached_encoder(connector);
 	struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
+	size_t len = iov_iter_count(from);
 	int dsc_output_format = 0;
 	int ret;
 
-	ret = kstrtoint_from_user(ubuf, len, 0, &dsc_output_format);
+	ret = kstrtoint_from_iter(from, len, 0, &dsc_output_format);
 	if (ret < 0)
 		return ret;
 
 	intel_dp->force_dsc_output_format = dsc_output_format;
-	*offp += len;
+	iocb->ki_pos += len;
 
 	return len;
 }
 
-static ssize_t i915_bigjoiner_enable_write(struct file *file,
-					   const char __user *ubuf,
-					   size_t len, loff_t *offp)
+static ssize_t i915_bigjoiner_enable_write_iter(struct kiocb *iocb,
+						struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct intel_connector *connector = m->private;
+	size_t len = iov_iter_count(from);
 	struct drm_crtc *crtc;
 	bool bigjoiner_en = 0;
 	int ret;
@@ -1451,12 +1447,12 @@ static ssize_t i915_bigjoiner_enable_write(struct file *file,
 	if (connector->base.status != connector_status_connected || !crtc)
 		return -ENODEV;
 
-	ret = kstrtobool_from_user(ubuf, len, &bigjoiner_en);
+	ret = kstrtobool_from_iter(from, len, &bigjoiner_en);
 	if (ret < 0)
 		return ret;
 
 	connector->force_bigjoiner_enable = bigjoiner_en;
-	*offp += len;
+	iocb->ki_pos += len;
 
 	return len;
 }
@@ -1470,10 +1466,10 @@ static int i915_dsc_output_format_open(struct inode *inode,
 static const struct file_operations i915_dsc_output_format_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_dsc_output_format_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = i915_dsc_output_format_write
+	.write_iter = i915_dsc_output_format_write
 };
 
 static int i915_dsc_fractional_bpp_show(struct seq_file *m, void *data)
@@ -1508,16 +1504,16 @@ static int i915_dsc_fractional_bpp_show(struct seq_file *m, void *data)
 	return ret;
 }
 
-static ssize_t i915_dsc_fractional_bpp_write(struct file *file,
-					     const char __user *ubuf,
-					     size_t len, loff_t *offp)
+static ssize_t i915_dsc_fractional_bpp_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct intel_connector *connector = m->private;
 	struct intel_encoder *encoder = intel_attached_encoder(connector);
 	struct drm_i915_private *i915 = to_i915(connector->base.dev);
 	struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 	bool dsc_fractional_bpp_enable = false;
+	size_t len = iov_iter_count(from);
 	int ret;
 
 	if (len == 0)
@@ -1526,7 +1522,7 @@ static ssize_t i915_dsc_fractional_bpp_write(struct file *file,
 	drm_dbg(&i915->drm,
 		"Copied %zu bytes from user to force fractional bpp for DSC\n", len);
 
-	ret = kstrtobool_from_user(ubuf, len, &dsc_fractional_bpp_enable);
+	ret = kstrtobool_from_iter(from, len, &dsc_fractional_bpp_enable);
 	if (ret < 0)
 		return ret;
 
@@ -1534,7 +1530,7 @@ static ssize_t i915_dsc_fractional_bpp_write(struct file *file,
 		(dsc_fractional_bpp_enable) ? "true" : "false");
 	intel_dp->force_dsc_fractional_bpp_en = dsc_fractional_bpp_enable;
 
-	*offp += len;
+	iocb->ki_pos += len;
 
 	return len;
 }
@@ -1548,10 +1544,10 @@ static int i915_dsc_fractional_bpp_open(struct inode *inode,
 static const struct file_operations i915_dsc_fractional_bpp_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_dsc_fractional_bpp_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = i915_dsc_fractional_bpp_write
+	.write_iter = i915_dsc_fractional_bpp_write
 };
 
 DEFINE_SHOW_STORE_ATTRIBUTE(i915_bigjoiner_enable);
diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c b/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
index f35718748555..deb2a157a4f9 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
@@ -27,20 +27,20 @@ static int intel_display_param_int_open(struct inode *inode, struct file *file)
 	return single_open(file, intel_display_param_int_show, inode->i_private);
 }
 
-static ssize_t intel_display_param_int_write(struct file *file,
-					     const char __user *ubuf, size_t len,
-					     loff_t *offp)
+static ssize_t intel_display_param_int_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	int *value = m->private;
 	int ret;
 
-	ret = kstrtoint_from_user(ubuf, len, 0, value);
+	ret = kstrtoint_from_iter(from, len, 0, value);
 	if (ret) {
 		/* support boolean values too */
 		bool b;
 
-		ret = kstrtobool_from_user(ubuf, len, &b);
+		ret = kstrtobool_from_iter(from, len, &b);
 		if (!ret)
 			*value = b;
 	}
@@ -51,8 +51,8 @@ static ssize_t intel_display_param_int_write(struct file *file,
 static const struct file_operations intel_display_param_int_fops = {
 	.owner = THIS_MODULE,
 	.open = intel_display_param_int_open,
-	.read = seq_read,
-	.write = intel_display_param_int_write,
+	.read_iter = seq_read_iter,
+	.write_iter = intel_display_param_int_write,
 	.llseek = default_llseek,
 	.release = single_release,
 };
@@ -60,7 +60,7 @@ static const struct file_operations intel_display_param_int_fops = {
 static const struct file_operations intel_display_param_int_fops_ro = {
 	.owner = THIS_MODULE,
 	.open = intel_display_param_int_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = default_llseek,
 	.release = single_release,
 };
@@ -80,20 +80,20 @@ static int intel_display_param_uint_open(struct inode *inode, struct file *file)
 	return single_open(file, intel_display_param_uint_show, inode->i_private);
 }
 
-static ssize_t intel_display_param_uint_write(struct file *file,
-					      const char __user *ubuf, size_t len,
-					      loff_t *offp)
+static ssize_t intel_display_param_uint_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	unsigned int *value = m->private;
 	int ret;
 
-	ret = kstrtouint_from_user(ubuf, len, 0, value);
+	ret = kstrtouint_from_iter(from, len, 0, value);
 	if (ret) {
 		/* support boolean values too */
 		bool b;
 
-		ret = kstrtobool_from_user(ubuf, len, &b);
+		ret = kstrtobool_from_iter(from, len, &b);
 		if (!ret)
 			*value = b;
 	}
@@ -104,8 +104,8 @@ static ssize_t intel_display_param_uint_write(struct file *file,
 static const struct file_operations intel_display_param_uint_fops = {
 	.owner = THIS_MODULE,
 	.open = intel_display_param_uint_open,
-	.read = seq_read,
-	.write = intel_display_param_uint_write,
+	.read_iter = seq_read_iter,
+	.write_iter = intel_display_param_uint_write,
 	.llseek = default_llseek,
 	.release = single_release,
 };
@@ -113,7 +113,7 @@ static const struct file_operations intel_display_param_uint_fops = {
 static const struct file_operations intel_display_param_uint_fops_ro = {
 	.owner = THIS_MODULE,
 	.open = intel_display_param_uint_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = default_llseek,
 	.release = single_release,
 };
diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
index d9ec349f3c8c..0a4a54fea1aa 100644
--- a/drivers/gpu/drm/i915/display/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
@@ -1019,13 +1019,13 @@ static int i915_hpd_storm_ctl_show(struct seq_file *m, void *data)
 	return 0;
 }
 
-static ssize_t i915_hpd_storm_ctl_write(struct file *file,
-					const char __user *ubuf, size_t len,
-					loff_t *offp)
+static ssize_t i915_hpd_storm_ctl_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_i915_private *dev_priv = m->private;
 	struct intel_hotplug *hotplug = &dev_priv->display.hotplug;
+	size_t len = iov_iter_count(from);
 	unsigned int new_threshold;
 	int i;
 	char *newline;
@@ -1034,7 +1034,7 @@ static ssize_t i915_hpd_storm_ctl_write(struct file *file,
 	if (len >= sizeof(tmp))
 		return -EINVAL;
 
-	if (copy_from_user(tmp, ubuf, len))
+	if (!copy_from_iter_full(tmp, len, from))
 		return -EFAULT;
 
 	tmp[len] = '\0';
@@ -1077,10 +1077,10 @@ static int i915_hpd_storm_ctl_open(struct inode *inode, struct file *file)
 static const struct file_operations i915_hpd_storm_ctl_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_hpd_storm_ctl_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = i915_hpd_storm_ctl_write
+	.write_iter = i915_hpd_storm_ctl_write
 };
 
 static int i915_hpd_short_storm_ctl_show(struct seq_file *m, void *data)
@@ -1100,13 +1100,13 @@ i915_hpd_short_storm_ctl_open(struct inode *inode, struct file *file)
 			   inode->i_private);
 }
 
-static ssize_t i915_hpd_short_storm_ctl_write(struct file *file,
-					      const char __user *ubuf,
-					      size_t len, loff_t *offp)
+static ssize_t i915_hpd_short_storm_ctl_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_i915_private *dev_priv = m->private;
 	struct intel_hotplug *hotplug = &dev_priv->display.hotplug;
+	size_t len = iov_iter_count(from);
 	char *newline;
 	char tmp[16];
 	int i;
@@ -1115,7 +1115,7 @@ static ssize_t i915_hpd_short_storm_ctl_write(struct file *file,
 	if (len >= sizeof(tmp))
 		return -EINVAL;
 
-	if (copy_from_user(tmp, ubuf, len))
+	if (!copy_from_iter_full(tmp, len, from))
 		return -EFAULT;
 
 	tmp[len] = '\0';
@@ -1150,10 +1150,10 @@ static ssize_t i915_hpd_short_storm_ctl_write(struct file *file,
 static const struct file_operations i915_hpd_short_storm_ctl_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_hpd_short_storm_ctl_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = i915_hpd_short_storm_ctl_write,
+	.write_iter = i915_hpd_short_storm_ctl_write,
 };
 
 void intel_hpd_debugfs_register(struct drm_i915_private *i915)
diff --git a/drivers/gpu/drm/i915/display/intel_wm.c b/drivers/gpu/drm/i915/display/intel_wm.c
index 82c4933ad507..86be01bb69f3 100644
--- a/drivers/gpu/drm/i915/display/intel_wm.c
+++ b/drivers/gpu/drm/i915/display/intel_wm.c
@@ -285,11 +285,12 @@ static int cur_wm_latency_open(struct inode *inode, struct file *file)
 	return single_open(file, cur_wm_latency_show, dev_priv);
 }
 
-static ssize_t wm_latency_write(struct file *file, const char __user *ubuf,
-				size_t len, loff_t *offp, u16 wm[8])
+static ssize_t wm_latency_write(struct kiocb *iocb, struct iov_iter *from,
+				u16 wm[8])
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_i915_private *dev_priv = m->private;
+	size_t len = iov_iter_count(from);
 	u16 new[8] = {};
 	int level;
 	int ret;
@@ -298,7 +299,7 @@ static ssize_t wm_latency_write(struct file *file, const char __user *ubuf,
 	if (len >= sizeof(tmp))
 		return -EINVAL;
 
-	if (copy_from_user(tmp, ubuf, len))
+	if (!copy_from_iter_full(tmp, len, from))
 		return -EFAULT;
 
 	tmp[len] = '\0';
@@ -319,10 +320,9 @@ static ssize_t wm_latency_write(struct file *file, const char __user *ubuf,
 	return len;
 }
 
-static ssize_t pri_wm_latency_write(struct file *file, const char __user *ubuf,
-				    size_t len, loff_t *offp)
+static ssize_t pri_wm_latency_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_i915_private *dev_priv = m->private;
 	u16 *latencies;
 
@@ -331,13 +331,12 @@ static ssize_t pri_wm_latency_write(struct file *file, const char __user *ubuf,
 	else
 		latencies = dev_priv->display.wm.pri_latency;
 
-	return wm_latency_write(file, ubuf, len, offp, latencies);
+	return wm_latency_write(iocb, from, latencies);
 }
 
-static ssize_t spr_wm_latency_write(struct file *file, const char __user *ubuf,
-				    size_t len, loff_t *offp)
+static ssize_t spr_wm_latency_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_i915_private *dev_priv = m->private;
 	u16 *latencies;
 
@@ -346,13 +345,12 @@ static ssize_t spr_wm_latency_write(struct file *file, const char __user *ubuf,
 	else
 		latencies = dev_priv->display.wm.spr_latency;
 
-	return wm_latency_write(file, ubuf, len, offp, latencies);
+	return wm_latency_write(iocb, from, latencies);
 }
 
-static ssize_t cur_wm_latency_write(struct file *file, const char __user *ubuf,
-				    size_t len, loff_t *offp)
+static ssize_t cur_wm_latency_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_i915_private *dev_priv = m->private;
 	u16 *latencies;
 
@@ -361,34 +359,34 @@ static ssize_t cur_wm_latency_write(struct file *file, const char __user *ubuf,
 	else
 		latencies = dev_priv->display.wm.cur_latency;
 
-	return wm_latency_write(file, ubuf, len, offp, latencies);
+	return wm_latency_write(iocb, from, latencies);
 }
 
 static const struct file_operations i915_pri_wm_latency_fops = {
 	.owner = THIS_MODULE,
 	.open = pri_wm_latency_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = pri_wm_latency_write
+	.write_iter = pri_wm_latency_write
 };
 
 static const struct file_operations i915_spr_wm_latency_fops = {
 	.owner = THIS_MODULE,
 	.open = spr_wm_latency_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = spr_wm_latency_write
+	.write_iter = spr_wm_latency_write
 };
 
 static const struct file_operations i915_cur_wm_latency_fops = {
 	.owner = THIS_MODULE,
 	.open = cur_wm_latency_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = cur_wm_latency_write
+	.write_iter = cur_wm_latency_write
 };
 
 void intel_wm_debugfs_register(struct drm_i915_private *i915)
diff --git a/drivers/gpu/drm/i915/display/skl_watermark.c b/drivers/gpu/drm/i915/display/skl_watermark.c
index c6b9be80d83c..9c87f0c1a0da 100644
--- a/drivers/gpu/drm/i915/display/skl_watermark.c
+++ b/drivers/gpu/drm/i915/display/skl_watermark.c
@@ -3713,17 +3713,17 @@ static int skl_watermark_ipc_status_open(struct inode *inode, struct file *file)
 	return single_open(file, skl_watermark_ipc_status_show, i915);
 }
 
-static ssize_t skl_watermark_ipc_status_write(struct file *file,
-					      const char __user *ubuf,
-					      size_t len, loff_t *offp)
+static ssize_t skl_watermark_ipc_status_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct drm_i915_private *i915 = m->private;
+	size_t len = iov_iter_count(from);
 	intel_wakeref_t wakeref;
 	bool enable;
 	int ret;
 
-	ret = kstrtobool_from_user(ubuf, len, &enable);
+	ret = kstrtobool_from_iter(from, len, &enable);
 	if (ret < 0)
 		return ret;
 
@@ -3741,10 +3741,10 @@ static ssize_t skl_watermark_ipc_status_write(struct file *file,
 static const struct file_operations skl_watermark_ipc_status_fops = {
 	.owner = THIS_MODULE,
 	.open = skl_watermark_ipc_status_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = skl_watermark_ipc_status_write
+	.write_iter = skl_watermark_ipc_status_write
 };
 
 static int intel_sagv_status_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.c b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.c
index 4dc23b8d3aa2..ed8c47f3cc39 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.c
@@ -107,7 +107,7 @@ void intel_gt_debugfs_register_files(struct dentry *root,
 				     unsigned long count, void *data)
 {
 	while (count--) {
-		umode_t mode = files->fops->write ? 0644 : 0444;
+		umode_t mode = files->fops->write_iter ? 0644 : 0444;
 
 		if (!files->eval || files->eval(data))
 			debugfs_create_file(files->name,
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
index e4110eebf093..1753bebb6f70 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_debugfs.h
@@ -14,7 +14,7 @@ struct intel_gt;
 static const struct file_operations __name ## _fops = {			\
 	.owner = THIS_MODULE,						\
 	.open = __name ## _open,					\
-	.read = seq_read,						\
+	.read_iter = seq_read_iter,					\
 	.llseek = seq_lseek,						\
 	.release = single_release,					\
 }
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.c
index ddfbe334689f..3284631a8c07 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log_debugfs.c
@@ -117,17 +117,14 @@ static int guc_log_relay_open(struct inode *inode, struct file *file)
 	return intel_guc_log_relay_open(log);
 }
 
-static ssize_t
-guc_log_relay_write(struct file *filp,
-		    const char __user *ubuf,
-		    size_t cnt,
-		    loff_t *ppos)
+static ssize_t guc_log_relay_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct intel_guc_log *log = filp->private_data;
+	struct intel_guc_log *log = iocb->ki_filp->private_data;
+	size_t cnt = iov_iter_count(from);
 	int val;
 	int ret;
 
-	ret = kstrtoint_from_user(ubuf, cnt, 0, &val);
+	ret = kstrtoint_from_iter(from, cnt, 0, &val);
 	if (ret < 0)
 		return ret;
 
@@ -154,7 +151,7 @@ static int guc_log_relay_release(struct inode *inode, struct file *file)
 static const struct file_operations guc_log_relay_fops = {
 	.owner = THIS_MODULE,
 	.open = guc_log_relay_open,
-	.write = guc_log_relay_write,
+	.write_iter = guc_log_relay_write,
 	.release = guc_log_relay_release,
 };
 
diff --git a/drivers/gpu/drm/i915/i915_debugfs_params.c b/drivers/gpu/drm/i915/i915_debugfs_params.c
index 8bca02025e09..5369d1e7f1b7 100644
--- a/drivers/gpu/drm/i915/i915_debugfs_params.c
+++ b/drivers/gpu/drm/i915/i915_debugfs_params.c
@@ -49,20 +49,19 @@ static int notify_guc(struct drm_i915_private *i915)
 	return ret;
 }
 
-static ssize_t i915_param_int_write(struct file *file,
-				    const char __user *ubuf, size_t len,
-				    loff_t *offp)
+static ssize_t i915_param_int_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	int *value = m->private;
 	int ret;
 
-	ret = kstrtoint_from_user(ubuf, len, 0, value);
+	ret = kstrtoint_from_iter(from, len, 0, value);
 	if (ret) {
 		/* support boolean values too */
 		bool b;
 
-		ret = kstrtobool_from_user(ubuf, len, &b);
+		ret = kstrtobool_from_iter(from, len, &b);
 		if (!ret)
 			*value = b;
 	}
@@ -73,8 +72,8 @@ static ssize_t i915_param_int_write(struct file *file,
 static const struct file_operations i915_param_int_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_param_int_open,
-	.read = seq_read,
-	.write = i915_param_int_write,
+	.read_iter = seq_read_iter,
+	.write_iter = i915_param_int_write,
 	.llseek = default_llseek,
 	.release = single_release,
 };
@@ -82,7 +81,7 @@ static const struct file_operations i915_param_int_fops = {
 static const struct file_operations i915_param_int_fops_ro = {
 	.owner = THIS_MODULE,
 	.open = i915_param_int_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = default_llseek,
 	.release = single_release,
 };
@@ -102,27 +101,26 @@ static int i915_param_uint_open(struct inode *inode, struct file *file)
 	return single_open(file, i915_param_uint_show, inode->i_private);
 }
 
-static ssize_t i915_param_uint_write(struct file *file,
-				     const char __user *ubuf, size_t len,
-				     loff_t *offp)
+static ssize_t i915_param_uint_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct drm_i915_private *i915;
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	unsigned int *value = m->private;
 	unsigned int old = *value;
 	int ret;
 
-	ret = kstrtouint_from_user(ubuf, len, 0, value);
+	ret = kstrtouint_from_iter(from, len, 0, value);
 	if (ret) {
 		/* support boolean values too */
 		bool b;
 
-		ret = kstrtobool_from_user(ubuf, len, &b);
+		ret = kstrtobool_from_iter(from, len, &b);
 		if (!ret)
 			*value = b;
 	}
 
-	if (!ret && MATCH_DEBUGFS_NODE_NAME(file, "reset")) {
+	if (!ret && MATCH_DEBUGFS_NODE_NAME(iocb->ki_filp, "reset")) {
 		GET_I915(i915, reset, value);
 
 		ret = notify_guc(i915);
@@ -136,8 +134,8 @@ static ssize_t i915_param_uint_write(struct file *file,
 static const struct file_operations i915_param_uint_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_param_uint_open,
-	.read = seq_read,
-	.write = i915_param_uint_write,
+	.read_iter = seq_read_iter,
+	.write_iter = i915_param_uint_write,
 	.llseek = default_llseek,
 	.release = single_release,
 };
@@ -145,7 +143,7 @@ static const struct file_operations i915_param_uint_fops = {
 static const struct file_operations i915_param_uint_fops_ro = {
 	.owner = THIS_MODULE,
 	.open = i915_param_uint_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = default_llseek,
 	.release = single_release,
 };
@@ -186,12 +184,13 @@ static ssize_t i915_param_charp_write(struct file *file,
 out:
 	return len;
 }
+FOPS_WRITE_ITER_HELPER(i915_param_charp_write);
 
 static const struct file_operations i915_param_charp_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_param_charp_open,
-	.read = seq_read,
-	.write = i915_param_charp_write,
+	.read_iter = seq_read_iter,
+	.write_iter = i915_param_charp_write_iter,
 	.llseek = default_llseek,
 	.release = single_release,
 };
@@ -199,7 +198,7 @@ static const struct file_operations i915_param_charp_fops = {
 static const struct file_operations i915_param_charp_fops_ro = {
 	.owner = THIS_MODULE,
 	.open = i915_param_charp_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = default_llseek,
 	.release = single_release,
 };
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index a0b784ebaddd..ca0851c07082 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -2380,14 +2380,14 @@ void intel_klog_error_capture(struct intel_gt *gt,
 }
 #endif
 
-static ssize_t gpu_state_read(struct file *file, char __user *ubuf,
-			      size_t count, loff_t *pos)
+static ssize_t gpu_state_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct i915_gpu_coredump *error;
+	size_t count = iov_iter_count(to);
 	ssize_t ret;
 	void *buf;
 
-	error = file->private_data;
+	error = iocb->ki_filp->private_data;
 	if (!error)
 		return 0;
 
@@ -2396,12 +2396,12 @@ static ssize_t gpu_state_read(struct file *file, char __user *ubuf,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = i915_gpu_coredump_copy_to_buffer(error, buf, *pos, count);
+	ret = i915_gpu_coredump_copy_to_buffer(error, buf, iocb->ki_pos, count);
 	if (ret <= 0)
 		goto out;
 
-	if (!copy_to_user(ubuf, buf, ret))
-		*pos += ret;
+	if (copy_to_iter_full(buf, ret, to))
+		iocb->ki_pos += ret;
 	else
 		ret = -EFAULT;
 
@@ -2436,18 +2436,14 @@ static int i915_gpu_info_open(struct inode *inode, struct file *file)
 static const struct file_operations i915_gpu_info_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_gpu_info_open,
-	.read = gpu_state_read,
+	.read_iter = gpu_state_read,
 	.llseek = default_llseek,
 	.release = gpu_state_release,
 };
 
-static ssize_t
-i915_error_state_write(struct file *filp,
-		       const char __user *ubuf,
-		       size_t cnt,
-		       loff_t *ppos)
+static ssize_t i915_error_state_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct i915_gpu_coredump *error = filp->private_data;
+	struct i915_gpu_coredump *error = iocb->ki_filp->private_data;
 
 	if (!error)
 		return 0;
@@ -2455,7 +2451,7 @@ i915_error_state_write(struct file *filp,
 	drm_dbg(&error->i915->drm, "Resetting error state\n");
 	i915_reset_error_state(error->i915);
 
-	return cnt;
+	return iov_iter_count(from);
 }
 
 static int i915_error_state_open(struct inode *inode, struct file *file)
@@ -2473,8 +2469,8 @@ static int i915_error_state_open(struct inode *inode, struct file *file)
 static const struct file_operations i915_error_state_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_error_state_open,
-	.read = gpu_state_read,
-	.write = i915_error_state_write,
+	.read_iter = gpu_state_read,
+	.write_iter = i915_error_state_write,
 	.llseek = default_llseek,
 	.release = gpu_state_release,
 };
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index bd9d812b1afa..8ff6d5b0b40a 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -3512,6 +3512,7 @@ static ssize_t i915_perf_read(struct file *file,
 	/* Possible values for ret are 0, -EFAULT, -ENOSPC, -EIO, ... */
 	return offset ?: (ret ?: -EAGAIN);
 }
+FOPS_READ_ITER_HELPER(i915_perf_read);
 
 static enum hrtimer_restart oa_poll_check_timer_cb(struct hrtimer *hrtimer)
 {
@@ -3788,7 +3789,7 @@ static const struct file_operations fops = {
 	.llseek		= no_llseek,
 	.release	= i915_perf_release,
 	.poll		= i915_perf_poll,
-	.read		= i915_perf_read,
+	.read_iter	= i915_perf_read_iter,
 	.unlocked_ioctl	= i915_perf_ioctl,
 	/* Our ioctl have no arguments, so it's safe to use the same function
 	 * to handle 32bits compatibility.
-- 
2.43.0


