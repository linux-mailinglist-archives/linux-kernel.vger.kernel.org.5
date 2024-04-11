Return-Path: <linux-kernel+bounces-140871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4BC8A194D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35F61F20F13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3171509A6;
	Thu, 11 Apr 2024 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w0eCcn1d"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593C14F9C7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849687; cv=none; b=QRRdiNhU5qQjqNVPRpflEUbz2Y3nB9/SAbywSibJBsPFKTtKgVwcQFUoucjFWAOQK4vf08qTl38xKlbv2K6i1/CRgRqF8qIGvIN/KRx6IL/xMSF95ndm3Sw3g6602JaCQ9xqHKDVrvyEb0e7CB5ridaHOFyOvpAZ3tvVM1x7CEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849687; c=relaxed/simple;
	bh=RSUJQjeM07YTEW7iK7Vv1f86mHksd87EkLpZ7ewIE7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5q7Uly4w4movHNvh1nfNym4UADOLwSBt2qj+yFmH6wIZb1msxLN9WLM5enXYaNFbgTVM64Y3shVIRIKNvT9UJO2NyIqoDv1ORxm6GgVP/7k6scbpLSzpgrTFvLF1B5Zkn1wyHUcXJgKTgdDXQc0Jj6ipREvcXbgzEW+PZ44EG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w0eCcn1d; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso81843039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849684; x=1713454484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZenr5X/CAMte1lyF7FxF/QUsCyBfYGHK81fLlnNAdY=;
        b=w0eCcn1dN+RliGO9L9ztryL4nWZo+93EUakuAcVByslU99fJxr439oPPGxyjB91Fz1
         3jv7dAMNpJdFUTUN9vfwrKGZfAQNcBC1nOxOxq3vkgeTbpsSAnVq4UEMnbrV0Kps28Ti
         xjjVDBTWKU0qx9Cjj5uo//K48QvnUkLYD4/n0dKXp7t6EtpcY2mtlXB18cAscBAPr962
         KSSzEy3YLqKeNycQF/W46GNg0aXGHtJv4hmK+EP4szaSbPBvsViFYBWwM+1fmxa8bM3B
         Jxwk7QeolcrTFT5Z1PirS/rbDm3lA3dZYjxb84VKQENMggLE7WxoLgKz1ahMiMl2Lix7
         eENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849684; x=1713454484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZenr5X/CAMte1lyF7FxF/QUsCyBfYGHK81fLlnNAdY=;
        b=wzuS3BUWjtT4TYx0cFtuSMeJoNglFTh3G/Y9J6l8KSOU/s1S7FtrMiZoD/M2z27GsF
         yaevW+Pxk1uYHR75TPo0CRcSkc3zY8H8V+rAg+Jbc9vD0+MULyvatxAk1u+jW3CNpuHc
         mvPIfD91qpdCqq9MG7F5LizV9DCsNBpg/OYWSDBsTnks2rueH6uU17CqIU/YyT14n1rj
         LosNCpRoXolJcIRWllY9djvY+1RFx539XB/SDSsw2pzaZzcKPI1nSVGqiUemKjzsavMW
         uQJMsEq+hIelvxX25ypWIb8/pkqJIhYbVryyoD0y+sdeDSquIwkeqsiDLQ0K2IDcTQwH
         uYmQ==
X-Gm-Message-State: AOJu0YzDPNC6M8ic7jZmwc03G4zz8K63fx5fFDoBLWhtkXP032SZgtqv
	gSp0eXV1+aBKMD/ky0t/z0sQ/tuhdzXvcRcluvbkA3hFl9ozhb24d2Gf34AzBm3q+3NPzSnQTkh
	9
X-Google-Smtp-Source: AGHT+IGdY95NkkefYGBsVbceHMr8M72oFVC/nwJNCDb8xSYre7GYk4QsR/mMBuWFbeVTenjOGwEmnA==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr145562ioc.2.1712849683801;
        Thu, 11 Apr 2024 08:34:43 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 108/437] crypto: qat: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:08 -0600
Message-ID: <20240411153126.16201-109-axboe@kernel.dk>
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
 .../intel/qat/qat_common/adf_cnv_dbgfs.c      | 10 ++--
 .../intel/qat/qat_common/adf_fw_counters.c    |  2 +-
 .../qat/qat_common/adf_heartbeat_dbgfs.c      | 60 +++++++++----------
 .../intel/qat/qat_common/adf_pm_dbgfs.c       |  3 +-
 .../intel/qat/qat_common/adf_tl_debugfs.c     | 18 +++---
 5 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c
index 627953a72d47..3c6b7d0b2e9d 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_cnv_dbgfs.c
@@ -255,23 +255,21 @@ static int qat_cnv_errors_file_release(struct inode *inode, struct file *file)
 static const struct file_operations qat_cnv_fops = {
 	.owner = THIS_MODULE,
 	.open = qat_cnv_errors_file_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = qat_cnv_errors_file_release,
 };
 
-static ssize_t no_comp_file_read(struct file *f, char __user *buf, size_t count,
-				 loff_t *pos)
+static ssize_t no_comp_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *file_msg = "No engine configured for comp\n";
 
-	return simple_read_from_buffer(buf, count, pos, file_msg,
-				       strlen(file_msg));
+	return simple_copy_to_iter(file_msg, &iocb->ki_pos, strlen(file_msg), to);
 }
 
 static const struct file_operations qat_cnv_no_comp_fops = {
 	.owner = THIS_MODULE,
-	.read = no_comp_file_read,
+	.read_iter = no_comp_file_read,
 };
 
 void adf_cnv_dbgfs_add(struct adf_accel_dev *accel_dev)
diff --git a/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c b/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c
index 98fb7ccfed9f..f654d698efe9 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_fw_counters.c
@@ -224,7 +224,7 @@ static int qat_fw_counters_file_release(struct inode *inode, struct file *file)
 static const struct file_operations qat_fw_counters_fops = {
 	.owner = THIS_MODULE,
 	.open = qat_fw_counters_file_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = qat_fw_counters_file_release,
 };
diff --git a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
index cccdff24b48d..16f4dfdbb434 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_heartbeat_dbgfs.c
@@ -19,30 +19,28 @@
 #define HB_STATUS_MAX_STRLEN 4
 #define HB_STATS_MAX_STRLEN 16
 
-static ssize_t adf_hb_stats_read(struct file *file, char __user *user_buffer,
-				 size_t count, loff_t *ppos)
+static ssize_t adf_hb_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[HB_STATS_MAX_STRLEN];
 	unsigned int *value;
 	int len;
 
-	if (*ppos > 0)
+	if (iocb->ki_pos > 0)
 		return 0;
 
-	value = file->private_data;
+	value = iocb->ki_filp->private_data;
 	len = scnprintf(buf, sizeof(buf), "%u\n", *value);
 
-	return simple_read_from_buffer(user_buffer, count, ppos, buf, len + 1);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len + 1, to);
 }
 
 static const struct file_operations adf_hb_stats_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = adf_hb_stats_read,
+	.read_iter = adf_hb_stats_read,
 };
 
-static ssize_t adf_hb_status_read(struct file *file, char __user *user_buf,
-				  size_t count, loff_t *ppos)
+static ssize_t adf_hb_status_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	enum adf_device_heartbeat_status hb_status;
 	char ret_str[HB_STATUS_MAX_STRLEN];
@@ -50,10 +48,10 @@ static ssize_t adf_hb_status_read(struct file *file, char __user *user_buf,
 	int ret_code;
 	size_t len;
 
-	if (*ppos > 0)
+	if (iocb->ki_pos > 0)
 		return 0;
 
-	accel_dev = file->private_data;
+	accel_dev = iocb->ki_filp->private_data;
 	ret_code = HB_OK;
 
 	adf_heartbeat_status(accel_dev, &hb_status);
@@ -63,52 +61,50 @@ static ssize_t adf_hb_status_read(struct file *file, char __user *user_buf,
 
 	len = scnprintf(ret_str, sizeof(ret_str), "%d\n", ret_code);
 
-	return simple_read_from_buffer(user_buf, count, ppos, ret_str, len + 1);
+	return simple_copy_to_iter(ret_str, &iocb->ki_pos, len + 1, to);
 }
 
 static const struct file_operations adf_hb_status_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = adf_hb_status_read,
+	.read_iter = adf_hb_status_read,
 };
 
-static ssize_t adf_hb_cfg_read(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t adf_hb_cfg_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char timer_str[ADF_CFG_MAX_VAL_LEN_IN_BYTES];
 	struct adf_accel_dev *accel_dev;
 	unsigned int timer_ms;
 	int len;
 
-	if (*ppos > 0)
+	if (iocb->ki_pos > 0)
 		return 0;
 
-	accel_dev = file->private_data;
+	accel_dev = iocb->ki_filp->private_data;
 	timer_ms = accel_dev->heartbeat->hb_timer;
 	len = scnprintf(timer_str, sizeof(timer_str), "%u\n", timer_ms);
 
-	return simple_read_from_buffer(user_buf, count, ppos, timer_str,
-				       len + 1);
+	return simple_copy_to_iter(timer_str, &iocb->ki_pos, len + 1, to);
 }
 
-static ssize_t adf_hb_cfg_write(struct file *file, const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t adf_hb_cfg_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char input_str[ADF_CFG_MAX_VAL_LEN_IN_BYTES] = { };
+	size_t count = iov_iter_count(from);
 	struct adf_accel_dev *accel_dev;
 	int ret, written_chars;
 	unsigned int timer_ms;
 	u32 ticks;
 
-	accel_dev = file->private_data;
+	accel_dev = iocb->ki_filp->private_data;
 	timer_ms = ADF_CFG_HB_TIMER_DEFAULT_MS;
 
 	/* last byte left as string termination */
 	if (count > sizeof(input_str) - 1)
 		return -EINVAL;
 
-	written_chars = simple_write_to_buffer(input_str, sizeof(input_str) - 1,
-					       ppos, user_buf, count);
+	written_chars = simple_copy_from_iter(input_str, &iocb->ki_pos,
+						sizeof(input_str) - 1, from);
 	if (written_chars > 0) {
 		ret = kstrtouint(input_str, 10, &timer_ms);
 		if (ret) {
@@ -151,23 +147,23 @@ static ssize_t adf_hb_cfg_write(struct file *file, const char __user *user_buf,
 static const struct file_operations adf_hb_cfg_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = adf_hb_cfg_read,
-	.write = adf_hb_cfg_write,
+	.read_iter = adf_hb_cfg_read,
+	.write_iter = adf_hb_cfg_write,
 };
 
-static ssize_t adf_hb_error_inject_write(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t adf_hb_error_inject_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct adf_accel_dev *accel_dev = file->private_data;
+	struct adf_accel_dev *accel_dev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[3];
 	int ret;
 
 	/* last byte left as string termination */
-	if (*ppos != 0 || count != 2)
+	if (iocb->ki_pos != 0 || count != 2)
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 	buf[count] = '\0';
 
@@ -190,7 +186,7 @@ static ssize_t adf_hb_error_inject_write(struct file *file,
 static const struct file_operations adf_hb_error_inject_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = adf_hb_error_inject_write,
+	.write_iter = adf_hb_error_inject_write,
 };
 
 void adf_heartbeat_dbgfs_add(struct adf_accel_dev *accel_dev)
diff --git a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c
index f0a13c190196..95105baa68d0 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs.c
@@ -18,10 +18,11 @@ static ssize_t pm_status_read(struct file *f, char __user *buf, size_t count,
 
 	return count;
 }
+FOPS_READ_ITER_HELPER(pm_status_read);
 
 static const struct file_operations pm_status_fops = {
 	.owner = THIS_MODULE,
-	.read = pm_status_read,
+	.read_iter = pm_status_read_iter,
 };
 
 void adf_pm_dbgfs_add(struct adf_accel_dev *accel_dev)
diff --git a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
index c8241f5a0a26..d3704f41c406 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_tl_debugfs.c
@@ -413,10 +413,10 @@ static int tl_control_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static ssize_t tl_control_write(struct file *file, const char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t tl_control_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *seq_f = file->private_data;
+	struct seq_file *seq_f = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct adf_accel_dev *accel_dev;
 	struct adf_telemetry *telemetry;
 	struct adf_tl_hw_data *tl_data;
@@ -434,7 +434,7 @@ static ssize_t tl_control_write(struct file *file, const char __user *userbuf,
 
 	mutex_lock(&telemetry->wr_lock);
 
-	ret = kstrtou32_from_user(userbuf, count, 10, &input);
+	ret = kstrtou32_from_iter(from, count, 10, &input);
 	if (ret)
 		goto unlock_and_exit;
 
@@ -627,10 +627,10 @@ static int tl_rp_data_show(struct seq_file *s, void *unused)
 	return tl_print_rp_data(accel_dev, s, rp_regs_index);
 }
 
-static ssize_t tl_rp_data_write(struct file *file, const char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t tl_rp_data_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *seq_f = file->private_data;
+	struct seq_file *seq_f = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct adf_accel_dev *accel_dev;
 	struct adf_telemetry *telemetry;
 	unsigned int new_rp_num;
@@ -647,13 +647,13 @@ static ssize_t tl_rp_data_write(struct file *file, const char __user *userbuf,
 
 	mutex_lock(&telemetry->wr_lock);
 
-	ret = get_rp_index_from_file(file, &rp_regs_index, max_rp);
+	ret = get_rp_index_from_file(iocb->ki_filp, &rp_regs_index, max_rp);
 	if (ret) {
 		dev_dbg(&GET_DEV(accel_dev), "invalid RP data file name\n");
 		goto unlock_and_exit;
 	}
 
-	ret = kstrtou32_from_user(userbuf, count, 10, &new_rp_num);
+	ret = kstrtou32_from_iter(from, count, 10, &new_rp_num);
 	if (ret)
 		goto unlock_and_exit;
 
-- 
2.43.0


