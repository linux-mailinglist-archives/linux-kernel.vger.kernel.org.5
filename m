Return-Path: <linux-kernel+bounces-141081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E58998A1A66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35DD1C22F58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC01DB520;
	Thu, 11 Apr 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mkjZrDT3"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238C1D8EC1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850011; cv=none; b=hCKeWXw1CZ+GGKg1bCLVE/DxV96tdqQz81tpBmzqOCIvMQ6R44Dglp7WmnQ6TB58gCfqohrktQhmmeqMNUr5+fVRAveM/YdhmJafHEFu5cBWQvKnO39Rg3aCStgmceoUpmU6MEMCpti6kyePcceNOupOjXSgco11zoUvFlpwNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850011; c=relaxed/simple;
	bh=fMtQ2Prs6T1En5TxP1vEmkXLOaTYUjpnIJqVHqvgXzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNjCajhtrskv1WDob4qMjj/XIB9SdOyG4NPtJ6VdtUk3I9oz3h2Pv29FluW/WvBgjORBQy3nF76LCfuk2pIDctR6hf+MGlqX4VqL0/oN5aMx7BG7eHeME9JzEKNS2tqFZtljZGenuNK+qbaW0qwEcvgcLgaYv3p4+5ECJ/n6QYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mkjZrDT3; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58188639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850007; x=1713454807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgXVEFtMhht0OwQoGmHmbQ6tKLYTDBCjb5aIv528JJk=;
        b=mkjZrDT34VrHxV9EXIS7FvzfxVWrPFwVmSK3YbrAtba6VRsP5in439vcEpKZ9DcmHZ
         /w0iC7iUx5VUr1W+CVdlbkkl8YzZcJQ9b8BXHvcu+v8odRecFtpa34N88ar4dkTk3OKj
         c2wZ4TdUJNPymRepWtRuan8S4rvLdgn2Lb63dI0vyoO3soynZv5dJYyw3iLaNgX2ny9l
         +/zeyAig3IyMYeXC2CMDueQxKwbPKCBixPh6209rlfHla0oo09TdOTCBA8S9LI9rtz6/
         ZsJJ9Eaa1C991QtFtJsKLkVWmQCVuHUV9irDnDF6/BmYufMCEeFTI0YsQ9Sa5AAcEA71
         Kxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850007; x=1713454807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgXVEFtMhht0OwQoGmHmbQ6tKLYTDBCjb5aIv528JJk=;
        b=AaoyP2Wecj4/7AmhCkl8KQzDS221cggrd7gFuALqmIdVZ6LkMMgZdcLTVXcLiA5gc/
         v5LvJ2kQYn8ZOIZ9/BNRVY5kap1CegmGgnaDYTgQn0MTbjJmrmZy1Wu/zh9GVvDyn8cS
         qjPJgcODITZHBjO7XfiRpyIOnEbcx1QlLNKl2Xo6qzbWQYq950KUmn0e/87wb0YLoF7w
         NnuEZS6+yB0Urtk6a1w9Z+KfUT9dEg93UhU/LbTdISZAw5AjfUh431xDo4TI7Vj5OKmb
         WEnCGFR59vguBwFS6ghNqMt3WrEmkVNeBudTL+olJZy4YVtMmDL2mHWizhzUYSiqKknK
         UXnQ==
X-Gm-Message-State: AOJu0YwtJ4zuHDr+8NiAbqxANm+F6X8RYpeQTshruXuMq4Ihgi6CgKAr
	+vYVi6Et1rd5WHzED588MA9qlAI7DMrUbDfmeKDdvX0+0YOusQJz19G8hWL+aUG+T7+CxI+4Fe9
	a
X-Google-Smtp-Source: AGHT+IHlQ7/5w4t4qJ6dVpGomkfluZHEeOBi0QTzcC4rYo6W7VRA60KdNIK75jtBJ+p73gx6TgHJ5w==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr172000ioh.1.1712850006441;
        Thu, 11 Apr 2024 08:40:06 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 304/437] drivers/net/wireless/ath/ath10k: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:24 -0600
Message-ID: <20240411153126.16201-305-axboe@kernel.dk>
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
 drivers/net/wireless/ath/ath10k/debug.c       | 502 ++++++++----------
 drivers/net/wireless/ath/ath10k/debugfs_sta.c | 119 ++---
 drivers/net/wireless/ath/ath10k/spectral.c    |  65 ++-
 3 files changed, 316 insertions(+), 370 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index b93a64bf8190..63193a566868 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -148,11 +148,9 @@ EXPORT_SYMBOL(ath10k_warn);
 
 #ifdef CONFIG_ATH10K_DEBUGFS
 
-static ssize_t ath10k_read_wmi_services(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t ath10k_read_wmi_services(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	char *buf;
 	size_t len = 0, buf_len = 8192;
 	const char *name;
@@ -186,7 +184,7 @@ static ssize_t ath10k_read_wmi_services(struct file *file,
 	}
 	spin_unlock_bh(&ar->data_lock);
 
-	ret_cnt = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret_cnt = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 	mutex_unlock(&ar->conf_mutex);
 
@@ -195,7 +193,7 @@ static ssize_t ath10k_read_wmi_services(struct file *file,
 }
 
 static const struct file_operations fops_wmi_services = {
-	.read = ath10k_read_wmi_services,
+	.read_iter = ath10k_read_wmi_services,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -442,28 +440,26 @@ static int ath10k_fw_stats_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath10k_fw_stats_read(struct file *file, char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t ath10k_fw_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	const char *buf = file->private_data;
+	const char *buf = iocb->ki_filp->private_data;
 	size_t len = strlen(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_fw_stats = {
 	.open = ath10k_fw_stats_open,
 	.release = ath10k_fw_stats_release,
-	.read = ath10k_fw_stats_read,
+	.read_iter = ath10k_fw_stats_read,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_debug_fw_reset_stats_read(struct file *file,
-						char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t ath10k_debug_fw_reset_stats_read(struct kiocb *iocb,
+						struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	int ret;
 	size_t len = 0, buf_len = 500;
 	char *buf;
@@ -485,7 +481,7 @@ static ssize_t ath10k_debug_fw_reset_stats_read(struct file *file,
 
 	spin_unlock_bh(&ar->data_lock);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 	kfree(buf);
 
@@ -494,7 +490,7 @@ static ssize_t ath10k_debug_fw_reset_stats_read(struct file *file,
 
 static const struct file_operations fops_fw_reset_stats = {
 	.open = simple_open,
-	.read = ath10k_debug_fw_reset_stats_read,
+	.read_iter = ath10k_debug_fw_reset_stats_read,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
@@ -519,9 +515,8 @@ static int ath10k_debug_fw_assert(struct ath10k *ar)
 				   ar->wmi.cmd->vdev_install_key_cmdid);
 }
 
-static ssize_t ath10k_read_simulate_fw_crash(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static ssize_t ath10k_read_simulate_fw_crash(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
 	const char buf[] =
 		"To simulate firmware crash write one of the keywords to this file:\n"
@@ -530,7 +525,7 @@ static ssize_t ath10k_read_simulate_fw_crash(struct file *file,
 		"`assert` - this will send special illegal parameter to firmware to cause assert failure and crash.\n"
 		"`hw-restart` - this will simply queue hw restart without fw/hw actually crashing.\n";
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+	return simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 }
 
 /* Simulate firmware crash:
@@ -540,26 +535,26 @@ static ssize_t ath10k_read_simulate_fw_crash(struct file *file,
  * vdev id. This is hard firmware crash because it is recoverable only by cold
  * firmware reset.
  */
-static ssize_t ath10k_write_simulate_fw_crash(struct file *file,
-					      const char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath10k_write_simulate_fw_crash(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[32] = {0};
 	ssize_t rc;
 	int ret;
 
 	/* filter partial writes and invalid commands */
-	if (*ppos != 0 || count >= sizeof(buf) || count == 0)
+	if (iocb->ki_pos != 0 || count >= sizeof(buf) || count == 0)
 		return -EINVAL;
 
-	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+	rc = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (rc < 0)
 		return rc;
 
 	/* drop the possible '\n' from the end */
-	if (buf[*ppos - 1] == '\n')
-		buf[*ppos - 1] = '\0';
+	if (buf[iocb->ki_pos - 1] == '\n')
+		buf[iocb->ki_pos - 1] = '\0';
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -605,37 +600,34 @@ static ssize_t ath10k_write_simulate_fw_crash(struct file *file,
 }
 
 static const struct file_operations fops_simulate_fw_crash = {
-	.read = ath10k_read_simulate_fw_crash,
-	.write = ath10k_write_simulate_fw_crash,
+	.read_iter = ath10k_read_simulate_fw_crash,
+	.write_iter = ath10k_write_simulate_fw_crash,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_read_chip_id(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t ath10k_read_chip_id(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	size_t len;
 	char buf[50];
 
 	len = scnprintf(buf, sizeof(buf), "0x%08x\n", ar->bus_param.chip_id);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_chip_id = {
-	.read = ath10k_read_chip_id,
+	.read_iter = ath10k_read_chip_id,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_reg_addr_read(struct file *file,
-				    char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t ath10k_reg_addr_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	u8 buf[32];
 	size_t len = 0;
 	u32 reg_addr;
@@ -646,18 +638,17 @@ static ssize_t ath10k_reg_addr_read(struct file *file,
 
 	len += scnprintf(buf + len, sizeof(buf) - len, "0x%x\n", reg_addr);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath10k_reg_addr_write(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath10k_reg_addr_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 reg_addr;
 	int ret;
 
-	ret = kstrtou32_from_user(user_buf, count, 0, &reg_addr);
+	ret = kstrtou32_from_iter(from, count, 0, &reg_addr);
 	if (ret)
 		return ret;
 
@@ -672,18 +663,16 @@ static ssize_t ath10k_reg_addr_write(struct file *file,
 }
 
 static const struct file_operations fops_reg_addr = {
-	.read = ath10k_reg_addr_read,
-	.write = ath10k_reg_addr_write,
+	.read_iter = ath10k_reg_addr_read,
+	.write_iter = ath10k_reg_addr_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_reg_value_read(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath10k_reg_value_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	u8 buf[48];
 	size_t len;
 	u32 reg_addr, reg_val;
@@ -702,7 +691,7 @@ static ssize_t ath10k_reg_value_read(struct file *file,
 	reg_val = ath10k_hif_read32(ar, reg_addr);
 	len = scnprintf(buf, sizeof(buf), "0x%08x:0x%08x\n", reg_addr, reg_val);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 exit:
 	mutex_unlock(&ar->conf_mutex);
@@ -710,11 +699,10 @@ static ssize_t ath10k_reg_value_read(struct file *file,
 	return ret;
 }
 
-static ssize_t ath10k_reg_value_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath10k_reg_value_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 reg_addr, reg_val;
 	int ret;
 
@@ -728,7 +716,7 @@ static ssize_t ath10k_reg_value_write(struct file *file,
 
 	reg_addr = ar->debug.reg_addr;
 
-	ret = kstrtou32_from_user(user_buf, count, 0, &reg_val);
+	ret = kstrtou32_from_iter(from, count, 0, &reg_val);
 	if (ret)
 		goto exit;
 
@@ -743,22 +731,21 @@ static ssize_t ath10k_reg_value_write(struct file *file,
 }
 
 static const struct file_operations fops_reg_value = {
-	.read = ath10k_reg_value_read,
-	.write = ath10k_reg_value_write,
+	.read_iter = ath10k_reg_value_read,
+	.write_iter = ath10k_reg_value_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_mem_value_read(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath10k_mem_value_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	u8 *buf;
 	int ret;
 
-	if (*ppos < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 
 	if (!count)
@@ -778,21 +765,21 @@ static ssize_t ath10k_mem_value_read(struct file *file,
 		goto exit;
 	}
 
-	ret = ath10k_hif_diag_read(ar, *ppos, buf, count);
+	ret = ath10k_hif_diag_read(ar, iocb->ki_pos, buf, count);
 	if (ret) {
 		ath10k_warn(ar, "failed to read address 0x%08x via diagnose window from debugfs: %d\n",
-			    (u32)(*ppos), ret);
+			    (u32)(iocb->ki_pos), ret);
 		goto exit;
 	}
 
-	ret = copy_to_user(user_buf, buf, count);
+	ret = !copy_to_iter_full(buf, count, to);
 	if (ret) {
 		ret = -EFAULT;
 		goto exit;
 	}
 
 	count -= ret;
-	*ppos += count;
+	iocb->ki_pos += count;
 	ret = count;
 
 exit:
@@ -802,15 +789,14 @@ static ssize_t ath10k_mem_value_read(struct file *file,
 	return ret;
 }
 
-static ssize_t ath10k_mem_value_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath10k_mem_value_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u8 *buf;
 	int ret;
 
-	if (*ppos < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 
 	if (!count)
@@ -830,20 +816,20 @@ static ssize_t ath10k_mem_value_write(struct file *file,
 		goto exit;
 	}
 
-	ret = copy_from_user(buf, user_buf, count);
+	ret = !copy_from_iter_full(buf, count, from);
 	if (ret) {
 		ret = -EFAULT;
 		goto exit;
 	}
 
-	ret = ath10k_hif_diag_write(ar, *ppos, buf, count);
+	ret = ath10k_hif_diag_write(ar, iocb->ki_pos, buf, count);
 	if (ret) {
 		ath10k_warn(ar, "failed to write address 0x%08x via diagnose window from debugfs: %d\n",
-			    (u32)(*ppos), ret);
+			    (u32)(iocb->ki_pos), ret);
 		goto exit;
 	}
 
-	*ppos += count;
+	iocb->ki_pos += count;
 	ret = count;
 
 exit:
@@ -854,8 +840,8 @@ static ssize_t ath10k_mem_value_write(struct file *file,
 }
 
 static const struct file_operations fops_mem_value = {
-	.read = ath10k_mem_value_read,
-	.write = ath10k_mem_value_write,
+	.read_iter = ath10k_mem_value_read,
+	.write_iter = ath10k_mem_value_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -902,28 +888,27 @@ static void ath10k_debug_htt_stats_dwork(struct work_struct *work)
 	mutex_unlock(&ar->conf_mutex);
 }
 
-static ssize_t ath10k_read_htt_stats_mask(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath10k_read_htt_stats_mask(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	size_t len;
 
 	len = scnprintf(buf, sizeof(buf), "%lu\n", ar->debug.htt_stats_mask);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath10k_write_htt_stats_mask(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath10k_write_htt_stats_mask(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long mask;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &mask);
+	ret = kstrtoul_from_iter(from, count, 0, &mask);
 	if (ret)
 		return ret;
 
@@ -948,18 +933,17 @@ static ssize_t ath10k_write_htt_stats_mask(struct file *file,
 }
 
 static const struct file_operations fops_htt_stats_mask = {
-	.read = ath10k_read_htt_stats_mask,
-	.write = ath10k_write_htt_stats_mask,
+	.read_iter = ath10k_read_htt_stats_mask,
+	.write_iter = ath10k_write_htt_stats_mask,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_read_htt_max_amsdu_ampdu(struct file *file,
-					       char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t ath10k_read_htt_max_amsdu_ampdu(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	char buf[64];
 	u8 amsdu, ampdu;
 	size_t len;
@@ -972,20 +956,19 @@ static ssize_t ath10k_read_htt_max_amsdu_ampdu(struct file *file,
 
 	len = scnprintf(buf, sizeof(buf), "%u %u\n", amsdu, ampdu);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath10k_write_htt_max_amsdu_ampdu(struct file *file,
-						const char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t ath10k_write_htt_max_amsdu_ampdu(struct kiocb *iocb,
+						struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int res;
 	char buf[64] = {0};
 	unsigned int amsdu, ampdu;
 
-	res = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
-				     user_buf, count);
+	res = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (res <= 0)
 		return res;
 
@@ -1010,39 +993,35 @@ static ssize_t ath10k_write_htt_max_amsdu_ampdu(struct file *file,
 }
 
 static const struct file_operations fops_htt_max_amsdu_ampdu = {
-	.read = ath10k_read_htt_max_amsdu_ampdu,
-	.write = ath10k_write_htt_max_amsdu_ampdu,
+	.read_iter = ath10k_read_htt_max_amsdu_ampdu,
+	.write_iter = ath10k_write_htt_max_amsdu_ampdu,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_read_fw_dbglog(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath10k_read_fw_dbglog(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	size_t len;
 	char buf[96];
 
 	len = scnprintf(buf, sizeof(buf), "0x%16llx %u\n",
 			ar->debug.fw_dbglog_mask, ar->debug.fw_dbglog_level);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath10k_write_fw_dbglog(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath10k_write_fw_dbglog(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 	char buf[96] = {0};
 	unsigned int log_level;
 	u64 mask;
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
-				     user_buf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret <= 0)
 		return ret;
 
@@ -1241,8 +1220,8 @@ void ath10k_debug_get_et_stats(struct ieee80211_hw *hw,
 }
 
 static const struct file_operations fops_fw_dbglog = {
-	.read = ath10k_read_fw_dbglog,
-	.write = ath10k_write_fw_dbglog,
+	.read_iter = ath10k_read_fw_dbglog,
+	.write_iter = ath10k_write_fw_dbglog,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1298,32 +1277,31 @@ static int ath10k_debug_cal_data_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath10k_debug_cal_data_read(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath10k_debug_cal_data_read(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count;
 
 	mutex_lock(&ar->conf_mutex);
 
-	count = simple_read_from_buffer(user_buf, count, ppos,
-					ar->debug.cal_data,
-					ar->hw_params.cal_data_len);
+	count = simple_copy_to_iter(ar->debug.cal_data, &iocb->ki_pos,
+					ar->hw_params.cal_data_len, to);
 
 	mutex_unlock(&ar->conf_mutex);
 
 	return count;
 }
 
-static ssize_t ath10k_write_ani_enable(struct file *file,
-				       const char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t ath10k_write_ani_enable(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 	u8 enable;
 
-	if (kstrtou8_from_user(user_buf, count, 0, &enable))
+	if (kstrtou8_from_iter(from, count, 0, &enable))
 		return -EINVAL;
 
 	mutex_lock(&ar->conf_mutex);
@@ -1349,21 +1327,20 @@ static ssize_t ath10k_write_ani_enable(struct file *file,
 	return ret;
 }
 
-static ssize_t ath10k_read_ani_enable(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath10k_read_ani_enable(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	size_t len;
 	char buf[32];
 
 	len = scnprintf(buf, sizeof(buf), "%d\n", ar->ani_enabled);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_ani_enable = {
-	.read = ath10k_read_ani_enable,
-	.write = ath10k_write_ani_enable,
+	.read_iter = ath10k_read_ani_enable,
+	.write_iter = ath10k_write_ani_enable,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1371,33 +1348,31 @@ static const struct file_operations fops_ani_enable = {
 
 static const struct file_operations fops_cal_data = {
 	.open = ath10k_debug_cal_data_open,
-	.read = ath10k_debug_cal_data_read,
+	.read_iter = ath10k_debug_cal_data_read,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_read_nf_cal_period(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t ath10k_read_nf_cal_period(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	size_t len;
 	char buf[32];
 
 	len = scnprintf(buf, sizeof(buf), "%d\n", ar->debug.nf_cal_period);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath10k_write_nf_cal_period(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath10k_write_nf_cal_period(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long period;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &period);
+	ret = kstrtoul_from_iter(from, count, 0, &period);
 	if (ret)
 		return ret;
 
@@ -1435,8 +1410,8 @@ static ssize_t ath10k_write_nf_cal_period(struct file *file,
 }
 
 static const struct file_operations fops_nf_cal_period = {
-	.read = ath10k_read_nf_cal_period,
-	.write = ath10k_write_nf_cal_period,
+	.read_iter = ath10k_read_nf_cal_period,
+	.write_iter = ath10k_write_nf_cal_period,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1673,19 +1648,18 @@ static int ath10k_tpc_stats_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath10k_tpc_stats_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath10k_tpc_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	const char *buf = file->private_data;
+	const char *buf = iocb->ki_filp->private_data;
 	size_t len = strlen(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_tpc_stats = {
 	.open = ath10k_tpc_stats_open,
 	.release = ath10k_tpc_stats_release,
-	.read = ath10k_tpc_stats_read,
+	.read_iter = ath10k_tpc_stats_read,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
@@ -1759,11 +1733,10 @@ void ath10k_debug_stop(struct ath10k *ar)
 	ath10k_wmi_pdev_pktlog_disable(ar);
 }
 
-static ssize_t ath10k_write_simulate_radar(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath10k_write_simulate_radar(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	struct ath10k_vif *arvif;
 
 	/* Just check for the first vif alone, as all the vifs will be
@@ -1775,12 +1748,11 @@ static ssize_t ath10k_write_simulate_radar(struct file *file,
 		return -EINVAL;
 
 	ieee80211_radar_detected(ar->hw);
-
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations fops_simulate_radar = {
-	.write = ath10k_write_simulate_radar,
+	.write_iter = ath10k_write_simulate_radar,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1794,12 +1766,11 @@ static const struct file_operations fops_simulate_radar = {
 	len += scnprintf(buf + len, size - len, "%-28s : %10u\n", s, \
 			 ar->debug.dfs_pool_stats.p))
 
-static ssize_t ath10k_read_dfs_stats(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath10k_read_dfs_stats(struct kiocb *iocb, struct iov_iter *to)
 {
 	int retval = 0, len = 0;
 	const int size = 8000;
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	char *buf;
 
 	buf = kzalloc(size, GFP_KERNEL);
@@ -1835,28 +1806,28 @@ static ssize_t ath10k_read_dfs_stats(struct file *file, char __user *user_buf,
 	if (len > size)
 		len = size;
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
 static const struct file_operations fops_dfs_stats = {
-	.read = ath10k_read_dfs_stats,
+	.read_iter = ath10k_read_dfs_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_write_pktlog_filter(struct file *file,
-					  const char __user *ubuf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath10k_write_pktlog_filter(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 filter;
 	int ret;
 
-	if (kstrtouint_from_user(ubuf, count, 0, &filter))
+	if (kstrtouint_from_iter(from, count, 0, &filter))
 		return -EINVAL;
 
 	mutex_lock(&ar->conf_mutex);
@@ -1895,11 +1866,10 @@ static ssize_t ath10k_write_pktlog_filter(struct file *file,
 	return ret;
 }
 
-static ssize_t ath10k_read_pktlog_filter(struct file *file, char __user *ubuf,
-					 size_t count, loff_t *ppos)
+static ssize_t ath10k_read_pktlog_filter(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[32];
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	int len = 0;
 
 	mutex_lock(&ar->conf_mutex);
@@ -1907,23 +1877,23 @@ static ssize_t ath10k_read_pktlog_filter(struct file *file, char __user *ubuf,
 			ar->pktlog_filter);
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_pktlog_filter = {
-	.read = ath10k_read_pktlog_filter,
-	.write = ath10k_write_pktlog_filter,
+	.read_iter = ath10k_read_pktlog_filter,
+	.write_iter = ath10k_write_pktlog_filter,
 	.open = simple_open
 };
 
-static ssize_t ath10k_write_quiet_period(struct file *file,
-					 const char __user *ubuf,
-					 size_t count, loff_t *ppos)
+static ssize_t ath10k_write_quiet_period(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 period;
 
-	if (kstrtouint_from_user(ubuf, count, 0, &period))
+	if (kstrtouint_from_iter(from, count, 0, &period))
 		return -EINVAL;
 
 	if (period < ATH10K_QUIET_PERIOD_MIN) {
@@ -1939,11 +1909,10 @@ static ssize_t ath10k_write_quiet_period(struct file *file,
 	return count;
 }
 
-static ssize_t ath10k_read_quiet_period(struct file *file, char __user *ubuf,
-					size_t count, loff_t *ppos)
+static ssize_t ath10k_read_quiet_period(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[32];
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	int len = 0;
 
 	mutex_lock(&ar->conf_mutex);
@@ -1951,25 +1920,24 @@ static ssize_t ath10k_read_quiet_period(struct file *file, char __user *ubuf,
 			ar->thermal.quiet_period);
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_quiet_period = {
-	.read = ath10k_read_quiet_period,
-	.write = ath10k_write_quiet_period,
+	.read_iter = ath10k_read_quiet_period,
+	.write_iter = ath10k_write_quiet_period,
 	.open = simple_open
 };
 
-static ssize_t ath10k_write_btcoex(struct file *file,
-				   const char __user *ubuf,
-				   size_t count, loff_t *ppos)
+static ssize_t ath10k_write_btcoex(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t ret;
 	bool val;
 	u32 pdev_param;
 
-	ret = kstrtobool_from_user(ubuf, count, &val);
+	ret = kstrtobool_from_iter(from, count, &val);
 	if (ret)
 		return ret;
 
@@ -2016,11 +1984,10 @@ static ssize_t ath10k_write_btcoex(struct file *file,
 	return ret;
 }
 
-static ssize_t ath10k_read_btcoex(struct file *file, char __user *ubuf,
-				  size_t count, loff_t *ppos)
+static ssize_t ath10k_read_btcoex(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[32];
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	int len = 0;
 
 	mutex_lock(&ar->conf_mutex);
@@ -2028,24 +1995,24 @@ static ssize_t ath10k_read_btcoex(struct file *file, char __user *ubuf,
 			test_bit(ATH10K_FLAG_BTCOEX, &ar->dev_flags));
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_btcoex = {
-	.read = ath10k_read_btcoex,
-	.write = ath10k_write_btcoex,
+	.read_iter = ath10k_read_btcoex,
+	.write_iter = ath10k_write_btcoex,
 	.open = simple_open
 };
 
-static ssize_t ath10k_write_enable_extd_tx_stats(struct file *file,
-						 const char __user *ubuf,
-						 size_t count, loff_t *ppos)
+static ssize_t ath10k_write_enable_extd_tx_stats(struct kiocb *iocb,
+						 struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 filter;
 	int ret;
 
-	if (kstrtouint_from_user(ubuf, count, 0, &filter))
+	if (kstrtouint_from_iter(from, count, 0, &filter))
 		return -EINVAL;
 
 	mutex_lock(&ar->conf_mutex);
@@ -2069,13 +2036,12 @@ static ssize_t ath10k_write_enable_extd_tx_stats(struct file *file,
 	return ret;
 }
 
-static ssize_t ath10k_read_enable_extd_tx_stats(struct file *file,
-						char __user *ubuf,
-						size_t count, loff_t *ppos)
+static ssize_t ath10k_read_enable_extd_tx_stats(struct kiocb *iocb,
+						struct iov_iter *to)
 
 {
 	char buf[32];
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	int len = 0;
 
 	mutex_lock(&ar->conf_mutex);
@@ -2083,24 +2049,24 @@ static ssize_t ath10k_read_enable_extd_tx_stats(struct file *file,
 			ar->debug.enable_extd_tx_stats);
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_enable_extd_tx_stats = {
-	.read = ath10k_read_enable_extd_tx_stats,
-	.write = ath10k_write_enable_extd_tx_stats,
+	.read_iter = ath10k_read_enable_extd_tx_stats,
+	.write_iter = ath10k_write_enable_extd_tx_stats,
 	.open = simple_open
 };
 
-static ssize_t ath10k_write_peer_stats(struct file *file,
-				       const char __user *ubuf,
-				       size_t count, loff_t *ppos)
+static ssize_t ath10k_write_peer_stats(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t ret;
 	bool val;
 
-	ret = kstrtobool_from_user(ubuf, count, &val);
+	ret = kstrtobool_from_iter(from, count, &val);
 	if (ret)
 		return ret;
 
@@ -2132,12 +2098,10 @@ static ssize_t ath10k_write_peer_stats(struct file *file,
 	return ret;
 }
 
-static ssize_t ath10k_read_peer_stats(struct file *file, char __user *ubuf,
-				      size_t count, loff_t *ppos)
-
+static ssize_t ath10k_read_peer_stats(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[32];
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	int len = 0;
 
 	mutex_lock(&ar->conf_mutex);
@@ -2145,20 +2109,19 @@ static ssize_t ath10k_read_peer_stats(struct file *file, char __user *ubuf,
 			test_bit(ATH10K_FLAG_PEER_STATS, &ar->dev_flags));
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_peer_stats = {
-	.read = ath10k_read_peer_stats,
-	.write = ath10k_write_peer_stats,
+	.read_iter = ath10k_read_peer_stats,
+	.write_iter = ath10k_write_peer_stats,
 	.open = simple_open
 };
 
-static ssize_t ath10k_debug_fw_checksums_read(struct file *file,
-					      char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath10k_debug_fw_checksums_read(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	size_t len = 0, buf_len = 4096;
 	ssize_t ret_cnt;
 	char *buf;
@@ -2194,7 +2157,7 @@ static ssize_t ath10k_debug_fw_checksums_read(struct file *file,
 			 crc32_le(0, ar->normal_mode_fw.board_data,
 				  ar->normal_mode_fw.board_len));
 
-	ret_cnt = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret_cnt = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 	mutex_unlock(&ar->conf_mutex);
 
@@ -2203,33 +2166,32 @@ static ssize_t ath10k_debug_fw_checksums_read(struct file *file,
 }
 
 static const struct file_operations fops_fw_checksums = {
-	.read = ath10k_debug_fw_checksums_read,
+	.read_iter = ath10k_debug_fw_checksums_read,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_sta_tid_stats_mask_read(struct file *file,
-					      char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath10k_sta_tid_stats_mask_read(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	size_t len;
 
 	len = scnprintf(buf, sizeof(buf), "0x%08x\n", ar->sta_tid_stats_mask);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath10k_sta_tid_stats_mask_write(struct file *file,
-					       const char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t ath10k_sta_tid_stats_mask_write(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t ret;
 	u32 mask;
 
-	ret = kstrtoint_from_user(user_buf, count, 0, &mask);
+	ret = kstrtoint_from_iter(from, count, 0, &mask);
 	if (ret)
 		return ret;
 
@@ -2239,8 +2201,8 @@ static ssize_t ath10k_sta_tid_stats_mask_write(struct file *file,
 }
 
 static const struct file_operations fops_sta_tid_stats_mask = {
-	.read = ath10k_sta_tid_stats_mask_read,
-	.write = ath10k_sta_tid_stats_mask_write,
+	.read_iter = ath10k_sta_tid_stats_mask_read,
+	.write_iter = ath10k_sta_tid_stats_mask_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -2317,33 +2279,32 @@ static int ath10k_tpc_stats_final_release(struct inode *inode,
 	return 0;
 }
 
-static ssize_t ath10k_tpc_stats_final_read(struct file *file,
-					   char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath10k_tpc_stats_final_read(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	const char *buf = file->private_data;
+	const char *buf = iocb->ki_filp->private_data;
 	unsigned int len = strlen(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_tpc_stats_final = {
 	.open = ath10k_tpc_stats_final_open,
 	.release = ath10k_tpc_stats_final_release,
-	.read = ath10k_tpc_stats_final_read,
+	.read_iter = ath10k_tpc_stats_final_read,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_write_warm_hw_reset(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath10k_write_warm_hw_reset(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 	bool val;
 
-	if (kstrtobool_from_user(user_buf, count, &val))
+	if (kstrtobool_from_iter(from, count, &val))
 		return -EFAULT;
 
 	if (!val)
@@ -2372,7 +2333,7 @@ static ssize_t ath10k_write_warm_hw_reset(struct file *file,
 }
 
 static const struct file_operations fops_warm_hw_reset = {
-	.write = ath10k_write_warm_hw_reset,
+	.write_iter = ath10k_write_warm_hw_reset,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -2389,16 +2350,16 @@ static void ath10k_peer_ps_state_disable(void *data,
 	spin_unlock_bh(&ar->data_lock);
 }
 
-static ssize_t ath10k_write_ps_state_enable(struct file *file,
-					    const char __user *user_buf,
-					    size_t count, loff_t *ppos)
+static ssize_t ath10k_write_ps_state_enable(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 	u32 param;
 	u8 ps_state_enable;
 
-	if (kstrtou8_from_user(user_buf, count, 0, &ps_state_enable))
+	if (kstrtou8_from_iter(from, count, 0, &ps_state_enable))
 		return -EINVAL;
 
 	if (ps_state_enable > 1)
@@ -2433,11 +2394,10 @@ static ssize_t ath10k_write_ps_state_enable(struct file *file,
 	return ret;
 }
 
-static ssize_t ath10k_read_ps_state_enable(struct file *file,
-					   char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath10k_read_ps_state_enable(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	int len = 0;
 	char buf[32];
 
@@ -2446,26 +2406,26 @@ static ssize_t ath10k_read_ps_state_enable(struct file *file,
 			ar->ps_state_enable);
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_ps_state_enable = {
-	.read = ath10k_read_ps_state_enable,
-	.write = ath10k_write_ps_state_enable,
+	.read_iter = ath10k_read_ps_state_enable,
+	.write_iter = ath10k_write_ps_state_enable,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_write_reset_htt_stats(struct file *file,
-					    const char __user *user_buf,
-					    size_t count, loff_t *ppos)
+static ssize_t ath10k_write_reset_htt_stats(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long reset;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &reset);
+	ret = kstrtoul_from_iter(from, count, 0, &reset);
 	if (ret)
 		return ret;
 
@@ -2489,7 +2449,7 @@ static ssize_t ath10k_write_reset_htt_stats(struct file *file,
 }
 
 static const struct file_operations fops_reset_htt_stats = {
-	.write = ath10k_write_reset_htt_stats,
+	.write_iter = ath10k_write_reset_htt_stats,
 	.owner = THIS_MODULE,
 	.open = simple_open,
 	.llseek = default_llseek,
diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 394bf3c32abf..450ccb3b4483 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -173,11 +173,10 @@ void ath10k_sta_update_rx_duration(struct ath10k *ar,
 		ath10k_sta_update_stats_rx_duration(ar, stats);
 }
 
-static ssize_t ath10k_dbg_sta_read_aggr_mode(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static ssize_t ath10k_dbg_sta_read_aggr_mode(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
 	char buf[32];
@@ -189,20 +188,20 @@ static ssize_t ath10k_dbg_sta_read_aggr_mode(struct file *file,
 			"auto" : "manual");
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath10k_dbg_sta_write_aggr_mode(struct file *file,
-					      const char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath10k_dbg_sta_write_aggr_mode(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
+	size_t count = iov_iter_count(from);
 	u32 aggr_mode;
 	int ret;
 
-	if (kstrtouint_from_user(user_buf, count, 0, &aggr_mode))
+	if (kstrtouint_from_iter(from, count, 0, &aggr_mode))
 		return -EINVAL;
 
 	if (aggr_mode >= ATH10K_DBG_AGGR_MODE_MAX)
@@ -228,26 +227,25 @@ static ssize_t ath10k_dbg_sta_write_aggr_mode(struct file *file,
 }
 
 static const struct file_operations fops_aggr_mode = {
-	.read = ath10k_dbg_sta_read_aggr_mode,
-	.write = ath10k_dbg_sta_write_aggr_mode,
+	.read_iter = ath10k_dbg_sta_read_aggr_mode,
+	.write_iter = ath10k_dbg_sta_write_aggr_mode,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_dbg_sta_write_addba(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath10k_dbg_sta_write_addba(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
+	size_t count = iov_iter_count(from);
 	u32 tid, buf_size;
 	int ret;
 	char buf[64] = {0};
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
-				     user_buf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret <= 0)
 		return ret;
 
@@ -280,25 +278,24 @@ static ssize_t ath10k_dbg_sta_write_addba(struct file *file,
 }
 
 static const struct file_operations fops_addba = {
-	.write = ath10k_dbg_sta_write_addba,
+	.write_iter = ath10k_dbg_sta_write_addba,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_dbg_sta_write_addba_resp(struct file *file,
-					       const char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t ath10k_dbg_sta_write_addba_resp(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
+	size_t count = iov_iter_count(from);
 	u32 tid, status;
 	int ret;
 	char buf[64] = {0};
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
-				     user_buf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret <= 0)
 		return ret;
 
@@ -330,25 +327,24 @@ static ssize_t ath10k_dbg_sta_write_addba_resp(struct file *file,
 }
 
 static const struct file_operations fops_addba_resp = {
-	.write = ath10k_dbg_sta_write_addba_resp,
+	.write_iter = ath10k_dbg_sta_write_addba_resp,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_dbg_sta_write_delba(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath10k_dbg_sta_write_delba(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
+	size_t count = iov_iter_count(from);
 	u32 tid, initiator, reason;
 	int ret;
 	char buf[64] = {0};
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
-				     user_buf, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	if (ret <= 0)
 		return ret;
 
@@ -381,18 +377,16 @@ static ssize_t ath10k_dbg_sta_write_delba(struct file *file,
 }
 
 static const struct file_operations fops_delba = {
-	.write = ath10k_dbg_sta_write_delba,
+	.write_iter = ath10k_dbg_sta_write_delba,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_dbg_sta_read_peer_debug_trigger(struct file *file,
-						      char __user *user_buf,
-						      size_t count,
-						      loff_t *ppos)
+static ssize_t ath10k_dbg_sta_read_peer_debug_trigger(struct kiocb *iocb,
+						      struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
 	char buf[8];
@@ -403,21 +397,21 @@ static ssize_t ath10k_dbg_sta_read_peer_debug_trigger(struct file *file,
 			"Write 1 to once trigger the debug logs\n");
 	mutex_unlock(&ar->conf_mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static ssize_t
-ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
+ath10k_dbg_sta_write_peer_debug_trigger(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
+	size_t count = iov_iter_count(from);
 	u8 peer_debug_trigger;
 	int ret;
 
-	if (kstrtou8_from_user(user_buf, count, 0, &peer_debug_trigger))
+	if (kstrtou8_from_iter(from, count, 0, &peer_debug_trigger))
 		return -EINVAL;
 
 	if (peer_debug_trigger != 1)
@@ -444,17 +438,16 @@ ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
 
 static const struct file_operations fops_peer_debug_trigger = {
 	.open = simple_open,
-	.read = ath10k_dbg_sta_read_peer_debug_trigger,
-	.write = ath10k_dbg_sta_write_peer_debug_trigger,
+	.read_iter = ath10k_dbg_sta_read_peer_debug_trigger,
+	.write_iter = ath10k_dbg_sta_write_peer_debug_trigger,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_dbg_sta_read_peer_ps_state(struct file *file,
-						 char __user *user_buf,
-						 size_t count, loff_t *ppos)
+static ssize_t ath10k_dbg_sta_read_peer_ps_state(struct kiocb *iocb,
+						 struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
 	char buf[20];
@@ -467,12 +460,12 @@ static ssize_t ath10k_dbg_sta_read_peer_ps_state(struct file *file,
 
 	spin_unlock_bh(&ar->data_lock);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_peer_ps_state = {
 	.open = simple_open,
-	.read = ath10k_dbg_sta_read_peer_ps_state,
+	.read_iter = ath10k_dbg_sta_read_peer_ps_state,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
@@ -560,11 +553,10 @@ static char *get_num_amsdu_subfrm_str(enum ath10k_amsdu_subfrm_num i)
 		len += scnprintf(buf + len, buf_len - len, "\n"); \
 	} while (0)
 
-static ssize_t ath10k_dbg_sta_read_tid_stats(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static ssize_t ath10k_dbg_sta_read_tid_stats(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
 	struct ath10k_sta_tid_stats *stats = arsta->tid_stats;
@@ -627,7 +619,7 @@ static ssize_t ath10k_dbg_sta_read_tid_stats(struct file *file,
 
 	spin_unlock_bh(&ar->data_lock);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 	kfree(buf);
 
@@ -638,16 +630,15 @@ static ssize_t ath10k_dbg_sta_read_tid_stats(struct file *file,
 
 static const struct file_operations fops_tid_stats_dump = {
 	.open = simple_open,
-	.read = ath10k_dbg_sta_read_tid_stats,
+	.read_iter = ath10k_dbg_sta_read_tid_stats,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath10k_dbg_sta_dump_tx_stats(struct file *file,
-					    char __user *user_buf,
-					    size_t count, loff_t *ppos)
+static ssize_t ath10k_dbg_sta_dump_tx_stats(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ath10k *ar = arsta->arvif->ar;
 	struct ath10k_htt_data_stats *stats;
@@ -741,7 +732,7 @@ static ssize_t ath10k_dbg_sta_dump_tx_stats(struct file *file,
 
 	if (len > size)
 		len = size;
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	mutex_unlock(&ar->conf_mutex);
@@ -749,7 +740,7 @@ static ssize_t ath10k_dbg_sta_dump_tx_stats(struct file *file,
 }
 
 static const struct file_operations fops_tx_stats = {
-	.read = ath10k_dbg_sta_dump_tx_stats,
+	.read_iter = ath10k_dbg_sta_dump_tx_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
diff --git a/drivers/net/wireless/ath/ath10k/spectral.c b/drivers/net/wireless/ath/ath10k/spectral.c
index 2240994390ed..b427749a3c63 100644
--- a/drivers/net/wireless/ath/ath10k/spectral.c
+++ b/drivers/net/wireless/ath/ath10k/spectral.c
@@ -270,10 +270,9 @@ static int ath10k_spectral_scan_config(struct ath10k *ar,
 	return 0;
 }
 
-static ssize_t read_file_spec_scan_ctl(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t read_file_spec_scan_ctl(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	char *mode = "";
 	size_t len;
 	enum ath10k_spectral_mode spectral_mode;
@@ -295,20 +294,20 @@ static ssize_t read_file_spec_scan_ctl(struct file *file, char __user *user_buf,
 	}
 
 	len = strlen(mode);
-	return simple_read_from_buffer(user_buf, count, ppos, mode, len);
+	return simple_copy_to_iter(mode, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_spec_scan_ctl(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t write_file_spec_scan_ctl(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	ssize_t len;
 	int res;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -354,18 +353,16 @@ static ssize_t write_file_spec_scan_ctl(struct file *file,
 }
 
 static const struct file_operations fops_spec_scan_ctl = {
-	.read = read_file_spec_scan_ctl,
-	.write = write_file_spec_scan_ctl,
+	.read_iter = read_file_spec_scan_ctl,
+	.write_iter = write_file_spec_scan_ctl,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_spectral_count(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t read_file_spectral_count(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	size_t len;
 	u8 spectral_count;
@@ -375,18 +372,18 @@ static ssize_t read_file_spectral_count(struct file *file,
 	mutex_unlock(&ar->conf_mutex);
 
 	len = sprintf(buf, "%d\n", spectral_count);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_spectral_count(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t write_file_spectral_count(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -401,18 +398,16 @@ static ssize_t write_file_spectral_count(struct file *file,
 }
 
 static const struct file_operations fops_spectral_count = {
-	.read = read_file_spectral_count,
-	.write = write_file_spectral_count,
+	.read_iter = read_file_spectral_count,
+	.write_iter = write_file_spectral_count,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_spectral_bins(struct file *file,
-				       char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t read_file_spectral_bins(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	unsigned int bins, fft_size, bin_scale;
 	size_t len;
@@ -426,18 +421,18 @@ static ssize_t read_file_spectral_bins(struct file *file,
 	mutex_unlock(&ar->conf_mutex);
 
 	len = sprintf(buf, "%d\n", bins);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_spectral_bins(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t write_file_spectral_bins(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct ath10k *ar = file->private_data;
+	struct ath10k *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -456,8 +451,8 @@ static ssize_t write_file_spectral_bins(struct file *file,
 }
 
 static const struct file_operations fops_spectral_bins = {
-	.read = read_file_spectral_bins,
-	.write = write_file_spectral_bins,
+	.read_iter = read_file_spectral_bins,
+	.write_iter = write_file_spectral_bins,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
-- 
2.43.0


