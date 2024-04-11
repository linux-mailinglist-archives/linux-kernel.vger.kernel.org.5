Return-Path: <linux-kernel+bounces-141073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4015B8A1A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437E31C22DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AF41D3715;
	Thu, 11 Apr 2024 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zMe54c/4"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF61D4EFD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849999; cv=none; b=OdOL+842BMqZ7GgpB4mayTOGop54l0xueeta1L0eURgN8N0o/FcMQZA7XyIsmrPpCtfqoy+iE6I/komEi/dRwfTWQx664jcgAYLb+QDwIUWYYU3AyFSWELBpFAkvpGPEsQTZN+/1UwVNVvud0V9iWP9LWUy1XVfJfnP6wMSbKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849999; c=relaxed/simple;
	bh=JYKfeQH2W+lGFMiN70P4JMv0IGkYPq0LTxf+Rri3iS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsWEWN/ZrnvOSSXqYs8X/pLkGp9WutGTkGqkKmrkJ7XLai3DyG0D8k1dx9iyuE4IsVwoUhbjENJ+fxlaGlO7yMbau+rCAKEBa+hT2hMelDQR+MrM5AN6j8TPkxEBWrx5oLJxDMqKocIg6ZN4Y6TnFCgxDCSgRFCkQBxhR5eQA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zMe54c/4; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69644039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849991; x=1713454791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZqU3+NCMJGiTAxcck0eszLTPFhfVI7z5jzATIpnvgo=;
        b=zMe54c/4afUtmXi70jtbV4CuJW4TinIDIORfPpHvu+GV4taUYyY1HE+YHdFUzzPM8Z
         GPZ3iU4qDHVVOmI+Ye9F7e02glQP//R6GnP70N/R6SjKlku/c1N8+qJmfnsef1LOnZrg
         IBdvrWSz2MZXPz8l2x+H6jqykhRkCKAwrnczBd2meMxZveYryXBTMIeMkCDp5XYP+P1q
         M98jIBAtJgXhHYQ0G4B1wuMRwfauvUSGEQsrJPcrjqZG/YX8H8fUjnqdxnktDSp/5+FY
         1cN+LVSjv8FAift7lUisBddUjEqpBRrWFGnA2T9SLV/ywl/UTmfY3Yt8OT9C6utuRv8L
         4v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849991; x=1713454791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZqU3+NCMJGiTAxcck0eszLTPFhfVI7z5jzATIpnvgo=;
        b=hM8vI48iqNv96ZwAXBXdHqRCUWlGeHGydWjIXHJVFIhJ8C6pWcTdTFDPy+NuvyNYtR
         A284VF1Q67XmCB/z4zyhzt/K4XMGGxn9j/7utKJ4hcRFsnqctQE5wj8omr7LGdjDEqXS
         sKacxkUVJ+wgo4C2G5l/xRYA6q5IJfOwR27RFVeImGwBBckY68x0JUxlUfWV42+Q/N1r
         L28pxMYyDOy8fsheQgvmH4Qf13Bc3Dvq/ZA6o/oI0eeQ933z5P0db0PRB74GmmuypEGR
         mhskktzIsr/GpAgWyWOVDy/4qEZIQseWO4siSJnkayIO3DIAwvhYAG7ss4Z7jxbm94mK
         WD/w==
X-Gm-Message-State: AOJu0YxedJecCEo73Cc3ZHzmxY7FuTJzRc2njWIr/lj+h3c3pFuVFSxP
	6rGUPccZUMmrRrCXFOhJVVjI7sEhURjodJKXEiLhLYTSRHYLMDOBLWSWlf8WZYMCCt6k5GbntQG
	g
X-Google-Smtp-Source: AGHT+IFdFDBeKm0x8jyYKNs0LTrQp8AwQPqhlrn10Fh2gRuf80LDVNpppIPeWVvLqAXLTebMuXPvWw==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr202506iop.1.1712849990063;
        Thu, 11 Apr 2024 08:39:50 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 296/437] drivers/net/wireless/intel: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:16 -0600
Message-ID: <20240411153126.16201-297-axboe@kernel.dk>
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
 drivers/net/wireless/intel/iwlegacy/3945-rs.c |   9 +-
 drivers/net/wireless/intel/iwlegacy/4965-rs.c |  39 +-
 drivers/net/wireless/intel/iwlegacy/debug.c   | 280 +++++------
 .../net/wireless/intel/iwlwifi/dvm/debugfs.c  | 455 ++++++++----------
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   |  42 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  23 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c |  18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   7 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  81 ++--
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 227 ++++-----
 .../net/wireless/intel/iwlwifi/mvm/debugfs.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  62 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  85 ++--
 13 files changed, 609 insertions(+), 728 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
index 0eaad980c85c..1a14dce71bff 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
@@ -801,14 +801,13 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
 #ifdef CONFIG_MAC80211_DEBUGFS
 
 static ssize_t
-il3945_sta_dbgfs_stats_table_read(struct file *file, char __user *user_buf,
-				  size_t count, loff_t *ppos)
+il3945_sta_dbgfs_stats_table_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *buff;
 	int desc = 0;
 	int j;
 	ssize_t ret;
-	struct il3945_rs_sta *lq_sta = file->private_data;
+	struct il3945_rs_sta *lq_sta = iocb->ki_filp->private_data;
 
 	buff = kmalloc(1024, GFP_KERNEL);
 	if (!buff)
@@ -827,13 +826,13 @@ il3945_sta_dbgfs_stats_table_read(struct file *file, char __user *user_buf,
 			    lq_sta->win[j].success_counter,
 			    lq_sta->win[j].success_ratio);
 	}
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 	kfree(buff);
 	return ret;
 }
 
 static const struct file_operations rs_sta_dbgfs_stats_table_ops = {
-	.read = il3945_sta_dbgfs_stats_table_read,
+	.read_iter = il3945_sta_dbgfs_stats_table_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index 718efb1aa1b0..958d7e8e26d6 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -2527,11 +2527,10 @@ il4965_rs_dbgfs_set_mcs(struct il_lq_sta *lq_sta, u32 * rate_n_flags, int idx)
 }
 
 static ssize_t
-il4965_rs_sta_dbgfs_scale_table_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+il4965_rs_sta_dbgfs_scale_table_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct il_lq_sta *lq_sta = file->private_data;
+	struct il_lq_sta *lq_sta = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct il_priv *il;
 	char buf[64];
 	size_t buf_size;
@@ -2540,7 +2539,7 @@ il4965_rs_sta_dbgfs_scale_table_write(struct file *file,
 	il = lq_sta->drv;
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	if (sscanf(buf, "%x", &parsed_rate) == 1)
@@ -2564,8 +2563,7 @@ il4965_rs_sta_dbgfs_scale_table_write(struct file *file,
 }
 
 static ssize_t
-il4965_rs_sta_dbgfs_scale_table_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+il4965_rs_sta_dbgfs_scale_table_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *buff;
 	int desc = 0;
@@ -2573,7 +2571,7 @@ il4965_rs_sta_dbgfs_scale_table_read(struct file *file, char __user *user_buf,
 	int idx = 0;
 	ssize_t ret;
 
-	struct il_lq_sta *lq_sta = file->private_data;
+	struct il_lq_sta *lq_sta = iocb->ki_filp->private_data;
 	struct il_priv *il;
 	struct il_scale_tbl_info *tbl = &(lq_sta->lq_info[lq_sta->active_tbl]);
 
@@ -2659,28 +2657,27 @@ il4965_rs_sta_dbgfs_scale_table_read(struct file *file, char __user *user_buf,
 		}
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 	kfree(buff);
 	return ret;
 }
 
 static const struct file_operations rs_sta_dbgfs_scale_table_ops = {
-	.write = il4965_rs_sta_dbgfs_scale_table_write,
-	.read = il4965_rs_sta_dbgfs_scale_table_read,
+	.write_iter = il4965_rs_sta_dbgfs_scale_table_write,
+	.read_iter = il4965_rs_sta_dbgfs_scale_table_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
 static ssize_t
-il4965_rs_sta_dbgfs_stats_table_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+il4965_rs_sta_dbgfs_stats_table_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *buff;
 	int desc = 0;
 	int i, j;
 	ssize_t ret;
 
-	struct il_lq_sta *lq_sta = file->private_data;
+	struct il_lq_sta *lq_sta = iocb->ki_filp->private_data;
 
 	buff = kmalloc(1024, GFP_KERNEL);
 	if (!buff)
@@ -2705,25 +2702,23 @@ il4965_rs_sta_dbgfs_stats_table_read(struct file *file, char __user *user_buf,
 				    lq_sta->lq_info[i].win[j].success_ratio);
 		}
 	}
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 	kfree(buff);
 	return ret;
 }
 
 static const struct file_operations rs_sta_dbgfs_stats_table_ops = {
-	.read = il4965_rs_sta_dbgfs_stats_table_read,
+	.read_iter = il4965_rs_sta_dbgfs_stats_table_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
 static ssize_t
-il4965_rs_sta_dbgfs_rate_scale_data_read(struct file *file,
-					 char __user *user_buf, size_t count,
-					 loff_t *ppos)
+il4965_rs_sta_dbgfs_rate_scale_data_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buff[120];
 	int desc = 0;
-	struct il_lq_sta *lq_sta = file->private_data;
+	struct il_lq_sta *lq_sta = iocb->ki_filp->private_data;
 	struct il_scale_tbl_info *tbl = &lq_sta->lq_info[lq_sta->active_tbl];
 
 	if (is_Ht(tbl->lq_type))
@@ -2735,11 +2730,11 @@ il4965_rs_sta_dbgfs_rate_scale_data_read(struct file *file,
 		    sprintf(buff + desc, "Bit Rate= %d Mb/s\n",
 			    il_rates[lq_sta->last_txrate_idx].ieee >> 1);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	return simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 }
 
 static const struct file_operations rs_sta_dbgfs_rate_scale_data_ops = {
-	.read = il4965_rs_sta_dbgfs_rate_scale_data_read,
+	.read_iter = il4965_rs_sta_dbgfs_rate_scale_data_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
diff --git a/drivers/net/wireless/intel/iwlegacy/debug.c b/drivers/net/wireless/intel/iwlegacy/debug.c
index d998a3f1b056..c824c1db8186 100644
--- a/drivers/net/wireless/intel/iwlegacy/debug.c
+++ b/drivers/net/wireless/intel/iwlegacy/debug.c
@@ -120,20 +120,18 @@ EXPORT_SYMBOL(il_update_stats);
 
 /* file operation */
 #define DEBUGFS_READ_FUNC(name)                                         \
-static ssize_t il_dbgfs_##name##_read(struct file *file,               \
-					char __user *user_buf,          \
-					size_t count, loff_t *ppos);
+static ssize_t il_dbgfs_##name##_read(struct kiocb *iocb,               \
+					struct iov_iter *to);           \
 
 #define DEBUGFS_WRITE_FUNC(name)                                        \
-static ssize_t il_dbgfs_##name##_write(struct file *file,              \
-					const char __user *user_buf,    \
-					size_t count, loff_t *ppos);
+static ssize_t il_dbgfs_##name##_write(struct kiocb *iocb,              \
+					struct iov_iter *from);         \
 
 
 #define DEBUGFS_READ_FILE_OPS(name)				\
 	DEBUGFS_READ_FUNC(name);				\
 static const struct file_operations il_dbgfs_##name##_ops = {	\
-	.read = il_dbgfs_##name##_read,				\
+	.read_iter = il_dbgfs_##name##_read,			\
 	.open = simple_open,					\
 	.llseek = generic_file_llseek,				\
 };
@@ -141,7 +139,7 @@ static const struct file_operations il_dbgfs_##name##_ops = {	\
 #define DEBUGFS_WRITE_FILE_OPS(name)				\
 	DEBUGFS_WRITE_FUNC(name);				\
 static const struct file_operations il_dbgfs_##name##_ops = {	\
-	.write = il_dbgfs_##name##_write,			\
+	.write_iter = il_dbgfs_##name##_write,			\
 	.open = simple_open,					\
 	.llseek = generic_file_llseek,				\
 };
@@ -150,8 +148,8 @@ static const struct file_operations il_dbgfs_##name##_ops = {	\
 	DEBUGFS_READ_FUNC(name);				\
 	DEBUGFS_WRITE_FUNC(name);				\
 static const struct file_operations il_dbgfs_##name##_ops = {	\
-	.write = il_dbgfs_##name##_write,			\
-	.read = il_dbgfs_##name##_read,				\
+	.write_iter = il_dbgfs_##name##_write,			\
+	.read_iter = il_dbgfs_##name##_read,			\
 	.open = simple_open,					\
 	.llseek = generic_file_llseek,				\
 };
@@ -196,12 +194,10 @@ il_get_ctrl_string(int cmd)
 	}
 }
 
-static ssize_t
-il_dbgfs_tx_stats_read(struct file *file, char __user *user_buf, size_t count,
-		       loff_t *ppos)
+static ssize_t il_dbgfs_tx_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
 
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	char *buf;
 	int pos = 0;
 
@@ -231,24 +227,23 @@ il_dbgfs_tx_stats_read(struct file *file, char __user *user_buf, size_t count,
 	pos +=
 	    scnprintf(buf + pos, bufsz - pos, "\tbytes: %llu\n",
 		      il->tx_stats.data_bytes);
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
 static ssize_t
-il_dbgfs_clear_traffic_stats_write(struct file *file,
-				   const char __user *user_buf, size_t count,
-				   loff_t *ppos)
+il_dbgfs_clear_traffic_stats_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 clear_flag;
 	char buf[8];
 	int buf_size;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%x", &clear_flag) != 1)
 		return -EFAULT;
@@ -257,12 +252,10 @@ il_dbgfs_clear_traffic_stats_write(struct file *file,
 	return count;
 }
 
-static ssize_t
-il_dbgfs_rx_stats_read(struct file *file, char __user *user_buf, size_t count,
-		       loff_t *ppos)
+static ssize_t il_dbgfs_rx_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
 
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	char *buf;
 	int pos = 0;
 	int cnt;
@@ -293,7 +286,7 @@ il_dbgfs_rx_stats_read(struct file *file, char __user *user_buf, size_t count,
 	    scnprintf(buf + pos, bufsz - pos, "\tbytes: %llu\n",
 		      il->rx_stats.data_bytes);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
@@ -301,16 +294,14 @@ il_dbgfs_rx_stats_read(struct file *file, char __user *user_buf, size_t count,
 #define BYTE1_MASK 0x000000ff;
 #define BYTE2_MASK 0x0000ffff;
 #define BYTE3_MASK 0x00ffffff;
-static ssize_t
-il_dbgfs_sram_read(struct file *file, char __user *user_buf, size_t count,
-		   loff_t *ppos)
+static ssize_t il_dbgfs_sram_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	u32 val;
 	char *buf;
 	ssize_t ret;
 	int i;
 	int pos = 0;
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	size_t bufsz;
 
 	/* default is to dump the entire data segment */
@@ -355,23 +346,22 @@ il_dbgfs_sram_read(struct file *file, char __user *user_buf, size_t count,
 	}
 	pos += scnprintf(buf + pos, bufsz - pos, "\n");
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t
-il_dbgfs_sram_write(struct file *file, const char __user *user_buf,
-		    size_t count, loff_t *ppos)
+static ssize_t il_dbgfs_sram_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[64];
 	int buf_size;
 	u32 offset, len;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	if (sscanf(buf, "%x,%x", &offset, &len) == 2) {
@@ -385,11 +375,9 @@ il_dbgfs_sram_write(struct file *file, const char __user *user_buf,
 	return count;
 }
 
-static ssize_t
-il_dbgfs_stations_read(struct file *file, char __user *user_buf, size_t count,
-		       loff_t *ppos)
+static ssize_t il_dbgfs_stations_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	struct il_station_entry *station;
 	int max_sta = il->hw_params.max_stations;
 	char *buf;
@@ -444,17 +432,15 @@ il_dbgfs_stations_read(struct file *file, char __user *user_buf, size_t count,
 		pos += scnprintf(buf + pos, bufsz - pos, "\n");
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t
-il_dbgfs_nvm_read(struct file *file, char __user *user_buf, size_t count,
-		  loff_t *ppos)
+static ssize_t il_dbgfs_nvm_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret;
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	int pos = 0, ofs = 0, buf_size = 0;
 	const u8 *ptr;
 	char *buf;
@@ -488,16 +474,14 @@ il_dbgfs_nvm_read(struct file *file, char __user *user_buf, size_t count,
 				 ofs, ptr + ofs);
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t
-il_dbgfs_channels_read(struct file *file, char __user *user_buf, size_t count,
-		       loff_t *ppos)
+static ssize_t il_dbgfs_channels_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	struct ieee80211_channel *channels = NULL;
 	const struct ieee80211_supported_band *supp_band = NULL;
 	int pos = 0, i, bufsz = PAGE_SIZE;
@@ -567,17 +551,15 @@ il_dbgfs_channels_read(struct file *file, char __user *user_buf, size_t count,
 				      flags & IEEE80211_CHAN_NO_IR ?
 				      "passive only" : "active/passive");
 	}
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t
-il_dbgfs_status_read(struct file *file, char __user *user_buf, size_t count,
-		     loff_t *ppos)
+static ssize_t il_dbgfs_status_read(struct kiocb *iocb, struct iov_iter *to)
 {
 
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	char buf[512];
 	int pos = 0;
 	const size_t bufsz = sizeof(buf);
@@ -630,15 +612,13 @@ il_dbgfs_status_read(struct file *file, char __user *user_buf, size_t count,
 	pos +=
 	    scnprintf(buf + pos, bufsz - pos, "S_FW_ERROR:\t %d\n",
 		      test_bit(S_FW_ERROR, &il->status));
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t
-il_dbgfs_interrupt_read(struct file *file, char __user *user_buf, size_t count,
-			loff_t *ppos)
+static ssize_t il_dbgfs_interrupt_read(struct kiocb *iocb, struct iov_iter *to)
 {
 
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	int pos = 0;
 	int cnt = 0;
 	char *buf;
@@ -707,23 +687,23 @@ il_dbgfs_interrupt_read(struct file *file, char __user *user_buf, size_t count,
 	    scnprintf(buf + pos, bufsz - pos, "Unexpected INTA:\t\t %u\n",
 		      il->isr_stats.unhandled);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
 static ssize_t
-il_dbgfs_interrupt_write(struct file *file, const char __user *user_buf,
-			 size_t count, loff_t *ppos)
+il_dbgfs_interrupt_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	u32 reset_flag;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%x", &reset_flag) != 1)
 		return -EFAULT;
@@ -733,11 +713,9 @@ il_dbgfs_interrupt_write(struct file *file, const char __user *user_buf,
 	return count;
 }
 
-static ssize_t
-il_dbgfs_qos_read(struct file *file, char __user *user_buf, size_t count,
-		  loff_t *ppos)
+static ssize_t il_dbgfs_qos_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	int pos = 0, i;
 	char buf[256];
 	const size_t bufsz = sizeof(buf);
@@ -755,21 +733,21 @@ il_dbgfs_qos_read(struct file *file, char __user *user_buf, size_t count,
 			      il->qos_data.def_qos_parm.ac[i].edca_txop);
 	}
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t
-il_dbgfs_disable_ht40_write(struct file *file, const char __user *user_buf,
-			    size_t count, loff_t *ppos)
+il_dbgfs_disable_ht40_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int ht40;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &ht40) != 1)
 		return -EFAULT;
@@ -784,11 +762,9 @@ il_dbgfs_disable_ht40_write(struct file *file, const char __user *user_buf,
 	return count;
 }
 
-static ssize_t
-il_dbgfs_disable_ht40_read(struct file *file, char __user *user_buf,
-			   size_t count, loff_t *ppos)
+static ssize_t il_dbgfs_disable_ht40_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	char buf[100];
 	int pos = 0;
 	const size_t bufsz = sizeof(buf);
@@ -796,7 +772,7 @@ il_dbgfs_disable_ht40_read(struct file *file, char __user *user_buf,
 	pos +=
 	    scnprintf(buf + pos, bufsz - pos, "11n 40MHz Mode: %s\n",
 		      il->disable_ht40 ? "Disabled" : "Enabled");
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 DEBUGFS_READ_WRITE_FILE_OPS(sram);
@@ -808,12 +784,10 @@ DEBUGFS_READ_WRITE_FILE_OPS(interrupt);
 DEBUGFS_READ_FILE_OPS(qos);
 DEBUGFS_READ_WRITE_FILE_OPS(disable_ht40);
 
-static ssize_t
-il_dbgfs_tx_queue_read(struct file *file, char __user *user_buf, size_t count,
-		       loff_t *ppos)
+static ssize_t il_dbgfs_tx_queue_read(struct kiocb *iocb, struct iov_iter *to)
 {
 
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	struct il_tx_queue *txq;
 	struct il_queue *q;
 	char *buf;
@@ -850,17 +824,15 @@ il_dbgfs_tx_queue_read(struct file *file, char __user *user_buf, size_t count,
 			      "        stop-count: %d\n",
 			      atomic_read(&il->queue_stop_count[cnt]));
 	}
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t
-il_dbgfs_rx_queue_read(struct file *file, char __user *user_buf, size_t count,
-		       loff_t *ppos)
+static ssize_t il_dbgfs_rx_queue_read(struct kiocb *iocb, struct iov_iter *to)
 {
 
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	struct il_rx_queue *rxq = &il->rxq;
 	char buf[256];
 	int pos = 0;
@@ -881,11 +853,11 @@ il_dbgfs_rx_queue_read(struct file *file, char __user *user_buf, size_t count,
 		    scnprintf(buf + pos, bufsz - pos,
 			      "closed_rb_num: Not Allocated\n");
 	}
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t
-il_dbgfs_ucode_rx_stats_read(struct file *file, char __user *user_buf,
+__il_dbgfs_ucode_rx_stats_read(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {
 	struct il_priv *il = file->private_data;
@@ -893,30 +865,47 @@ il_dbgfs_ucode_rx_stats_read(struct file *file, char __user *user_buf,
 	return il->debugfs_ops->rx_stats_read(file, user_buf, count, ppos);
 }
 
+static ssize_t il_dbgfs_ucode_rx_stats_read(struct kiocb *iocb,
+					    struct iov_iter *to)
+{
+	return vfs_read_iter(iocb, to, __il_dbgfs_ucode_rx_stats_read);
+}
+
 static ssize_t
-il_dbgfs_ucode_tx_stats_read(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+__il_dbgfs_ucode_tx_stats_read(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
 {
 	struct il_priv *il = file->private_data;
 
 	return il->debugfs_ops->tx_stats_read(file, user_buf, count, ppos);
 }
 
+static ssize_t il_dbgfs_ucode_tx_stats_read(struct kiocb *iocb,
+					    struct iov_iter *to)
+{
+	return vfs_read_iter(iocb, to, __il_dbgfs_ucode_tx_stats_read);
+}
+
 static ssize_t
-il_dbgfs_ucode_general_stats_read(struct file *file, char __user *user_buf,
-				  size_t count, loff_t *ppos)
+__il_dbgfs_ucode_general_stats_read(struct file *file, char __user *user_buf,
+				    size_t count, loff_t *ppos)
 {
 	struct il_priv *il = file->private_data;
 
 	return il->debugfs_ops->general_stats_read(file, user_buf, count, ppos);
 }
 
-static ssize_t
-il_dbgfs_sensitivity_read(struct file *file, char __user *user_buf,
-			  size_t count, loff_t *ppos)
+static ssize_t il_dbgfs_ucode_general_stats_read(struct kiocb *iocb,
+						 struct iov_iter *to)
 {
+	return vfs_read_iter(iocb, to, __il_dbgfs_ucode_general_stats_read);
+}
 
-	struct il_priv *il = file->private_data;
+
+static ssize_t il_dbgfs_sensitivity_read(struct kiocb *iocb, struct iov_iter *to)
+{
+
+	struct il_priv *il = iocb->ki_filp->private_data;
 	int pos = 0;
 	int cnt = 0;
 	char *buf;
@@ -1005,17 +994,14 @@ il_dbgfs_sensitivity_read(struct file *file, char __user *user_buf,
 	    scnprintf(buf + pos, bufsz - pos, "nrg_th_ofdm:\t\t\t %u\n",
 		      data->nrg_th_ofdm);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t
-il_dbgfs_chain_noise_read(struct file *file, char __user *user_buf,
-			  size_t count, loff_t *ppos)
+static ssize_t il_dbgfs_chain_noise_read(struct kiocb *iocb, struct iov_iter *to)
 {
-
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	int pos = 0;
 	int cnt = 0;
 	char *buf;
@@ -1076,16 +1062,15 @@ il_dbgfs_chain_noise_read(struct file *file, char __user *user_buf,
 	    scnprintf(buf + pos, bufsz - pos, "state:\t\t\t\t %u\n",
 		      data->state);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t
-il_dbgfs_power_save_status_read(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t il_dbgfs_power_save_status_read(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	char buf[60];
 	int pos = 0;
 	const size_t bufsz = sizeof(buf);
@@ -1102,22 +1087,21 @@ il_dbgfs_power_save_status_read(struct file *file, char __user *user_buf,
 		      (pwrsave_status == CSR_GP_REG_PHY_POWER_SAVE) ? "PHY" :
 		      "error");
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t
-il_dbgfs_clear_ucode_stats_write(struct file *file,
-				 const char __user *user_buf, size_t count,
-				 loff_t *ppos)
+il_dbgfs_clear_ucode_stats_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int clear;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &clear) != 1)
 		return -EFAULT;
@@ -1130,38 +1114,31 @@ il_dbgfs_clear_ucode_stats_write(struct file *file,
 	return count;
 }
 
-static ssize_t
-il_dbgfs_rxon_flags_read(struct file *file, char __user *user_buf,
-			 size_t count, loff_t *ppos)
+static ssize_t il_dbgfs_rxon_flags_read(struct kiocb *iocb, struct iov_iter *to)
 {
-
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	int len = 0;
 	char buf[20];
 
 	len = sprintf(buf, "0x%04X\n", le32_to_cpu(il->active.flags));
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static ssize_t
-il_dbgfs_rxon_filter_flags_read(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
+il_dbgfs_rxon_filter_flags_read(struct kiocb *iocb, struct iov_iter *to)
 {
-
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	int len = 0;
 	char buf[20];
 
 	len =
 	    sprintf(buf, "0x%04X\n", le32_to_cpu(il->active.filter_flags));
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t
-il_dbgfs_fh_reg_read(struct file *file, char __user *user_buf, size_t count,
-		     loff_t *ppos)
+static ssize_t il_dbgfs_fh_reg_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	char *buf;
 	int pos = 0;
 	ssize_t ret = -EFAULT;
@@ -1170,8 +1147,7 @@ il_dbgfs_fh_reg_read(struct file *file, char __user *user_buf, size_t count,
 		ret = pos = il->ops->dump_fh(il, &buf, true);
 		if (buf) {
 			ret =
-			    simple_read_from_buffer(user_buf, count, ppos, buf,
-						    pos);
+			    simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 			kfree(buf);
 		}
 	}
@@ -1180,11 +1156,9 @@ il_dbgfs_fh_reg_read(struct file *file, char __user *user_buf, size_t count,
 }
 
 static ssize_t
-il_dbgfs_missed_beacon_read(struct file *file, char __user *user_buf,
-			    size_t count, loff_t *ppos)
+il_dbgfs_missed_beacon_read(struct kiocb *iocb, struct iov_iter *to)
 {
-
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	int pos = 0;
 	char buf[12];
 	const size_t bufsz = sizeof(buf);
@@ -1193,21 +1167,21 @@ il_dbgfs_missed_beacon_read(struct file *file, char __user *user_buf,
 	    scnprintf(buf + pos, bufsz - pos, "%d\n",
 		      il->missed_beacon_threshold);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t
-il_dbgfs_missed_beacon_write(struct file *file, const char __user *user_buf,
-			     size_t count, loff_t *ppos)
+il_dbgfs_missed_beacon_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int missed;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &missed) != 1)
 		return -EINVAL;
@@ -1221,12 +1195,9 @@ il_dbgfs_missed_beacon_write(struct file *file, const char __user *user_buf,
 	return count;
 }
 
-static ssize_t
-il_dbgfs_force_reset_read(struct file *file, char __user *user_buf,
-			  size_t count, loff_t *ppos)
+static ssize_t il_dbgfs_force_reset_read(struct kiocb *iocb, struct iov_iter *to)
 {
-
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 	int pos = 0;
 	char buf[300];
 	const size_t bufsz = sizeof(buf);
@@ -1249,35 +1220,32 @@ il_dbgfs_force_reset_read(struct file *file, char __user *user_buf,
 	    scnprintf(buf + pos, bufsz - pos, "\treset duration: %lu\n",
 		      force_reset->reset_duration);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t
-il_dbgfs_force_reset_write(struct file *file, const char __user *user_buf,
-			   size_t count, loff_t *ppos)
+il_dbgfs_force_reset_write(struct kiocb *iocb, struct iov_iter *from)
 {
-
 	int ret;
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
 
 	ret = il_force_reset(il, true);
 
-	return ret ? ret : count;
+	return ret ? ret : iov_iter_count(from);
 }
 
 static ssize_t
-il_dbgfs_wd_timeout_write(struct file *file, const char __user *user_buf,
-			  size_t count, loff_t *ppos)
+il_dbgfs_wd_timeout_write(struct kiocb *iocb, struct iov_iter *from)
 {
-
-	struct il_priv *il = file->private_data;
+	struct il_priv *il = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int timeout;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &timeout) != 1)
 		return -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
index b246dbd371b3..b2ff6164fbcb 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
@@ -27,14 +27,14 @@
 /* file operation */
 #define DEBUGFS_READ_FILE_OPS(name)                                     \
 static const struct file_operations iwl_dbgfs_##name##_ops = {          \
-	.read = iwl_dbgfs_##name##_read,				\
+	.read_iter = iwl_dbgfs_##name##_read,				\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
 
 #define DEBUGFS_WRITE_FILE_OPS(name)                                    \
 static const struct file_operations iwl_dbgfs_##name##_ops = {          \
-	.write = iwl_dbgfs_##name##_write,                              \
+	.write_iter = iwl_dbgfs_##name##_write,                         \
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
@@ -42,15 +42,13 @@ static const struct file_operations iwl_dbgfs_##name##_ops = {          \
 
 #define DEBUGFS_READ_WRITE_FILE_OPS(name)                               \
 static const struct file_operations iwl_dbgfs_##name##_ops = {          \
-	.write = iwl_dbgfs_##name##_write,                              \
-	.read = iwl_dbgfs_##name##_read,                                \
+	.write_iter = iwl_dbgfs_##name##_write,                         \
+	.read_iter = iwl_dbgfs_##name##_read,                           \
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
 
-static ssize_t iwl_dbgfs_sram_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_sram_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	u32 val = 0;
 	char *buf;
@@ -61,7 +59,7 @@ static ssize_t iwl_dbgfs_sram_read(struct file *file,
 	int len = 0;
 	int pos = 0;
 	int sram;
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	const struct fw_img *img;
 	size_t bufsz;
 
@@ -133,23 +131,22 @@ static ssize_t iwl_dbgfs_sram_read(struct file *file,
 	if (i)
 		pos += scnprintf(buf + pos, bufsz - pos, "\n");
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_sram_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_sram_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[64];
 	int buf_size;
 	u32 offset, len;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	if (sscanf(buf, "%x,%x", &offset, &len) == 2) {
@@ -166,24 +163,21 @@ static ssize_t iwl_dbgfs_sram_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_wowlan_sram_read(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_wowlan_sram_read(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	const struct fw_img *img = &priv->fw->img[IWL_UCODE_WOWLAN];
 
 	if (!priv->wowlan_sram)
 		return -ENODATA;
 
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       priv->wowlan_sram,
-				       img->sec[IWL_UCODE_SECTION_DATA].len);
+	return simple_copy_to_iter(priv->wowlan_sram, &iocb->ki_pos,
+				   img->sec[IWL_UCODE_SECTION_DATA].len, to);
 }
-static ssize_t iwl_dbgfs_stations_read(struct file *file, char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_stations_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	struct iwl_station_entry *station;
 	struct iwl_tid_data *tid_data;
 	char *buf;
@@ -231,18 +225,15 @@ static ssize_t iwl_dbgfs_stations_read(struct file *file, char __user *user_buf,
 		pos += scnprintf(buf + pos, bufsz - pos, "\n");
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_nvm_read(struct file *file,
-				       char __user *user_buf,
-				       size_t count,
-				       loff_t *ppos)
+static ssize_t iwl_dbgfs_nvm_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret;
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0, ofs = 0, buf_size = 0;
 	const u8 *ptr;
 	char *buf;
@@ -270,15 +261,14 @@ static ssize_t iwl_dbgfs_nvm_read(struct file *file,
 				 ofs, ptr + ofs);
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_channels_read(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_channels_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	struct ieee80211_channel *channels = NULL;
 	const struct ieee80211_supported_band *supp_band = NULL;
 	int pos = 0, i, bufsz = PAGE_SIZE;
@@ -335,16 +325,14 @@ static ssize_t iwl_dbgfs_channels_read(struct file *file, char __user *user_buf,
 					IEEE80211_CHAN_NO_IR ?
 					"passive only" : "active/passive");
 	}
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_status_read(struct file *file,
-						char __user *user_buf,
-						size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_status_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	char buf[512];
 	int pos = 0;
 	const size_t bufsz = sizeof(buf);
@@ -371,14 +359,13 @@ static ssize_t iwl_dbgfs_status_read(struct file *file,
 		test_bit(STATUS_POWER_PMI, &priv->status));
 	pos += scnprintf(buf + pos, bufsz - pos, "STATUS_FW_ERROR:\t %d\n",
 		test_bit(STATUS_FW_ERROR, &priv->status));
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_rx_handlers_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_rx_handlers_read(struct kiocb *iocb,
+					  struct iov_iter *to)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 
 	int pos = 0;
 	int cnt = 0;
@@ -398,24 +385,23 @@ static ssize_t iwl_dbgfs_rx_handlers_read(struct file *file,
 				priv->rx_handlers_stats[cnt]);
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_rx_handlers_write(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_rx_handlers_write(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
-
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	u32 reset_flag;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%x", &reset_flag) != 1)
 		return -EFAULT;
@@ -426,10 +412,9 @@ static ssize_t iwl_dbgfs_rx_handlers_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_qos_read(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_qos_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	struct iwl_rxon_context *ctx;
 	int pos = 0, i;
 	char buf[256 * NUM_IWL_RXON_CTX];
@@ -450,14 +435,13 @@ static ssize_t iwl_dbgfs_qos_read(struct file *file, char __user *user_buf,
 		}
 		pos += scnprintf(buf + pos, bufsz - pos, "\n");
 	}
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_thermal_throttling_read(struct file *file,
-				char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_thermal_throttling_read(struct kiocb *iocb,
+				struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	struct iwl_tt_mgmt *tt = &priv->thermal_throttle;
 	struct iwl_tt_restriction *restriction;
 	char buf[100];
@@ -482,21 +466,21 @@ static ssize_t iwl_dbgfs_thermal_throttling_read(struct file *file,
 				"HT mode: %d\n",
 				restriction->is_ht);
 	}
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_disable_ht40_write(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_disable_ht40_write(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int ht40;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &ht40) != 1)
 		return -EFAULT;
@@ -508,11 +492,10 @@ static ssize_t iwl_dbgfs_disable_ht40_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_disable_ht40_read(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_disable_ht40_read(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	char buf[100];
 	int pos = 0;
 	const size_t bufsz = sizeof(buf);
@@ -520,35 +503,34 @@ static ssize_t iwl_dbgfs_disable_ht40_read(struct file *file,
 	pos += scnprintf(buf + pos, bufsz - pos,
 			"11n 40MHz Mode: %s\n",
 			priv->disable_ht40 ? "Disabled" : "Enabled");
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_temperature_read(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_temperature_read(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	char buf[8];
 	int pos = 0;
 	const size_t bufsz = sizeof(buf);
 
 	pos += scnprintf(buf + pos, bufsz - pos, "%d\n", priv->temperature);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 
-static ssize_t iwl_dbgfs_sleep_level_override_write(struct file *file,
-						    const char __user *user_buf,
-						    size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_sleep_level_override_write(struct kiocb *iocb,
+						    struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int value;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	if (sscanf(buf, "%d", &value) != 1)
@@ -579,11 +561,10 @@ static ssize_t iwl_dbgfs_sleep_level_override_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_sleep_level_override_read(struct file *file,
-						   char __user *user_buf,
-						   size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_sleep_level_override_read(struct kiocb *iocb,
+						   struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	char buf[10];
 	int pos, value;
 	const size_t bufsz = sizeof(buf);
@@ -594,14 +575,13 @@ static ssize_t iwl_dbgfs_sleep_level_override_read(struct file *file,
 		value += 1;
 
 	pos = scnprintf(buf, bufsz, "%d\n", value);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_current_sleep_command_read(struct file *file,
-						    char __user *user_buf,
-						    size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_current_sleep_command_read(struct kiocb *iocb,
+						    struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	char buf[200];
 	int pos = 0, i;
 	const size_t bufsz = sizeof(buf);
@@ -618,7 +598,7 @@ static ssize_t iwl_dbgfs_current_sleep_command_read(struct file *file,
 				 "sleep_interval[%d]: %d\n", i,
 				 le32_to_cpu(cmd->sleep_interval[i]));
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 DEBUGFS_READ_WRITE_FILE_OPS(sram);
@@ -663,11 +643,10 @@ static int iwl_statistics_flag(struct iwl_priv *priv, char *buf, int bufsz)
 	return p;
 }
 
-static ssize_t iwl_dbgfs_ucode_rx_stats_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_ucode_rx_stats_read(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	char *buf;
 	int bufsz = sizeof(struct statistics_rx_phy) * 40 +
@@ -1091,16 +1070,15 @@ static ssize_t iwl_dbgfs_ucode_rx_stats_read(struct file *file,
 
 	spin_unlock_bh(&priv->statistics.lock);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_ucode_tx_stats_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_ucode_tx_stats_read(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	char *buf;
 	int bufsz = (sizeof(struct statistics_tx) * 48) + 250;
@@ -1288,16 +1266,15 @@ static ssize_t iwl_dbgfs_ucode_tx_stats_read(struct file *file,
 
 	spin_unlock_bh(&priv->statistics.lock);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_ucode_general_stats_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_ucode_general_stats_read(struct kiocb *iocb,
+						  struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	char *buf;
 	int bufsz = sizeof(struct statistics_general) * 10 + 300;
@@ -1408,16 +1385,15 @@ static ssize_t iwl_dbgfs_ucode_general_stats_read(struct file *file,
 
 	spin_unlock_bh(&priv->statistics.lock);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_ucode_bt_stats_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_ucode_bt_stats_read(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct iwl_priv *priv = (struct iwl_priv *)file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	char *buf;
 	int bufsz = (sizeof(struct statistics_bt_activity) * 24) + 200;
@@ -1496,16 +1472,15 @@ static ssize_t iwl_dbgfs_ucode_bt_stats_read(struct file *file,
 
 	spin_unlock_bh(&priv->statistics.lock);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_reply_tx_error_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_reply_tx_error_read(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct iwl_priv *priv = (struct iwl_priv *)file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	char *buf;
 	int bufsz = (sizeof(struct reply_tx_error_statistics) * 24) +
@@ -1638,16 +1613,15 @@ static ssize_t iwl_dbgfs_reply_tx_error_read(struct file *file,
 	pos += scnprintf(buf + pos, bufsz - pos, "UNKNOWN:\t\t\t%u\n",
 			 priv->reply_agg_tx_stats.unknown);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_sensitivity_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_sensitivity_read(struct kiocb *iocb,
+					  struct iov_iter *to)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	int cnt = 0;
 	char *buf;
@@ -1716,17 +1690,16 @@ static ssize_t iwl_dbgfs_sensitivity_read(struct file *file,
 	pos += scnprintf(buf + pos, bufsz - pos, "nrg_th_ofdm:\t\t\t %u\n",
 			data->nrg_th_ofdm);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
 
-static ssize_t iwl_dbgfs_chain_noise_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_chain_noise_read(struct kiocb *iocb,
+					  struct iov_iter *to)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	int cnt = 0;
 	char *buf;
@@ -1773,16 +1746,15 @@ static ssize_t iwl_dbgfs_chain_noise_read(struct file *file,
 	pos += scnprintf(buf + pos, bufsz - pos, "state:\t\t\t\t %u\n",
 			data->state);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_power_save_status_read(struct file *file,
-						    char __user *user_buf,
-						    size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_power_save_status_read(struct kiocb *iocb,
+						struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	char buf[60];
 	int pos = 0;
 	const size_t bufsz = sizeof(buf);
@@ -1798,21 +1770,21 @@ static ssize_t iwl_dbgfs_power_save_status_read(struct file *file,
 		(pwrsave_status == CSR_GP_REG_PHY_POWER_SAVE) ? "PHY" :
 		"error");
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_clear_ucode_statistics_write(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_clear_ucode_statistics_write(struct kiocb *iocb,
+						      struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int clear;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &clear) != 1)
 		return -EFAULT;
@@ -1825,11 +1797,10 @@ static ssize_t iwl_dbgfs_clear_ucode_statistics_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_ucode_tracing_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_ucode_tracing_read(struct kiocb *iocb,
+					    struct iov_iter *to)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	char buf[128];
 	const size_t bufsz = sizeof(buf);
@@ -1843,21 +1814,21 @@ static ssize_t iwl_dbgfs_ucode_tracing_read(struct file *file,
 	pos += scnprintf(buf + pos, bufsz - pos, "wraps_more_count:\t\t %u\n",
 			priv->event_log.wraps_more_count);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_ucode_tracing_write(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_ucode_tracing_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int trace;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &trace) != 1)
 		return -EFAULT;
@@ -1876,37 +1847,34 @@ static ssize_t iwl_dbgfs_ucode_tracing_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_rxon_flags_read(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_rxon_flags_read(struct kiocb *iocb,
+					 struct iov_iter *to)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int len = 0;
 	char buf[20];
 
 	len = sprintf(buf, "0x%04X\n",
 		le32_to_cpu(priv->contexts[IWL_RXON_CTX_BSS].active.flags));
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t iwl_dbgfs_rxon_filter_flags_read(struct file *file,
-						char __user *user_buf,
-						size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_rxon_filter_flags_read(struct kiocb *iocb,
+						struct iov_iter *to)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int len = 0;
 	char buf[20];
 
 	len = sprintf(buf, "0x%04X\n",
 		le32_to_cpu(priv->contexts[IWL_RXON_CTX_BSS].active.filter_flags));
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t iwl_dbgfs_missed_beacon_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_missed_beacon_read(struct kiocb *iocb,
+					    struct iov_iter *to)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	char buf[12];
 	const size_t bufsz = sizeof(buf);
@@ -1914,21 +1882,21 @@ static ssize_t iwl_dbgfs_missed_beacon_read(struct file *file,
 	pos += scnprintf(buf + pos, bufsz - pos, "%d\n",
 			priv->missed_beacon_threshold);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_missed_beacon_write(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_missed_beacon_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int missed;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &missed) != 1)
 		return -EINVAL;
@@ -1943,11 +1911,10 @@ static ssize_t iwl_dbgfs_missed_beacon_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_plcp_delta_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_plcp_delta_read(struct kiocb *iocb,
+					 struct iov_iter *to)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	char buf[12];
 	const size_t bufsz = sizeof(buf);
@@ -1955,21 +1922,21 @@ static ssize_t iwl_dbgfs_plcp_delta_read(struct file *file,
 	pos += scnprintf(buf + pos, bufsz - pos, "%u\n",
 			priv->plcp_delta_threshold);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_plcp_delta_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_plcp_delta_write(struct kiocb *iocb,
+					  struct iov_iter *from)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int plcp;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &plcp) != 1)
 		return -EINVAL;
@@ -1982,11 +1949,9 @@ static ssize_t iwl_dbgfs_plcp_delta_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_rf_reset_read(struct file *file,
-				       char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_rf_reset_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	char buf[300];
 	const size_t bufsz = sizeof(buf);
@@ -2004,32 +1969,32 @@ static ssize_t iwl_dbgfs_rf_reset_read(struct file *file,
 			"\tnumber of reset request reject: %d\n",
 			rf_reset->reset_reject_count);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_rf_reset_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_rf_reset_write(struct kiocb *iocb,
+					struct iov_iter *from)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 
 	ret = iwl_force_rf_reset(priv, true);
 	return ret ? ret : count;
 }
 
-static ssize_t iwl_dbgfs_txfifo_flush_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_txfifo_flush_write(struct kiocb *iocb,
+					    struct iov_iter *from)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int flush;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &flush) != 1)
 		return -EINVAL;
@@ -2042,18 +2007,16 @@ static ssize_t iwl_dbgfs_txfifo_flush_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_bt_traffic_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = (struct iwl_priv *)file->private_data;
+static ssize_t iwl_dbgfs_bt_traffic_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	int pos = 0;
 	char buf[200];
 	const size_t bufsz = sizeof(buf);
 
 	if (!priv->bt_enable_flag) {
 		pos += scnprintf(buf + pos, bufsz - pos, "BT coex disabled\n");
-		return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+		return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	}
 	pos += scnprintf(buf + pos, bufsz - pos, "BT enable flag: 0x%x\n",
 		priv->bt_enable_flag);
@@ -2084,14 +2047,13 @@ static ssize_t iwl_dbgfs_bt_traffic_read(struct file *file,
 		break;
 	}
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_protection_mode_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_protection_mode_read(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	struct iwl_priv *priv = (struct iwl_priv *)file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 
 	int pos = 0;
 	char buf[40];
@@ -2105,14 +2067,14 @@ static ssize_t iwl_dbgfs_protection_mode_read(struct file *file,
 	else
 		pos += scnprintf(buf + pos, bufsz - pos, "N/A");
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_protection_mode_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos) {
-
-	struct iwl_priv *priv = file->private_data;
+static ssize_t iwl_dbgfs_protection_mode_write(struct kiocb *iocb,
+					       struct iov_iter *from)
+{
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 	int rts;
@@ -2122,7 +2084,7 @@ static ssize_t iwl_dbgfs_protection_mode_write(struct file *file,
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%d", &rts) != 1)
 		return -EINVAL;
@@ -2149,17 +2111,17 @@ static int iwl_cmd_echo_test(struct iwl_priv *priv)
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_echo_test_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_echo_test_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	int buf_size;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	iwl_cmd_echo_test(priv);
@@ -2167,26 +2129,24 @@ static ssize_t iwl_dbgfs_echo_test_write(struct file *file,
 }
 
 #ifdef CONFIG_IWLWIFI_DEBUG
-static ssize_t iwl_dbgfs_log_event_read(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_log_event_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	char *buf = NULL;
 	ssize_t ret;
 
 	ret = iwl_dump_nic_event_log(priv, true, &buf);
 	if (ret > 0)
-		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+		ret = simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_log_event_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_log_event_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 event_log_flag;
 	char buf[8];
 	int buf_size;
@@ -2197,7 +2157,7 @@ static ssize_t iwl_dbgfs_log_event_write(struct file *file,
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%u", &event_log_flag) != 1)
 		return -EFAULT;
@@ -2208,11 +2168,10 @@ static ssize_t iwl_dbgfs_log_event_write(struct file *file,
 }
 #endif
 
-static ssize_t iwl_dbgfs_calib_disabled_read(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_calib_disabled_read(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
 	char buf[120];
 	int pos = 0;
 	const size_t bufsz = sizeof(buf);
@@ -2233,21 +2192,21 @@ static ssize_t iwl_dbgfs_calib_disabled_read(struct file *file,
 					IWL_TX_POWER_CALIB_DISABLED) ?
 			 "DISABLED" : "ENABLED");
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_calib_disabled_write(struct file *file,
-					      const char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_calib_disabled_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[8];
 	u32 calib_disabled;
 	int buf_size;
 
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%x", &calib_disabled) != 1)
 		return -EFAULT;
@@ -2257,11 +2216,11 @@ static ssize_t iwl_dbgfs_calib_disabled_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_fw_restart_write(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_fw_restart_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct iwl_priv *priv = file->private_data;
+	struct iwl_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	bool fw_restart = iwlwifi_mod_params.fw_restart;
 	int __maybe_unused ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index f4a6f76cf193..64ef58cc2bc0 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -3037,20 +3037,20 @@ static void rs_dbgfs_set_mcs(struct iwl_lq_sta *lq_sta,
 	}
 }
 
-static ssize_t rs_sta_dbgfs_scale_table_write(struct file *file,
-			const char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t rs_sta_dbgfs_scale_table_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct iwl_lq_sta *lq_sta = file->private_data;
+	struct iwl_lq_sta *lq_sta = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct iwl_priv *priv;
 	char buf[64];
 	size_t buf_size;
 	u32 parsed_rate;
 
-
 	priv = lq_sta->drv;
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	if (sscanf(buf, "%x", &parsed_rate) == 1)
@@ -3063,8 +3063,8 @@ static ssize_t rs_sta_dbgfs_scale_table_write(struct file *file,
 	return count;
 }
 
-static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
-			char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t rs_sta_dbgfs_scale_table_read(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
 	char *buff;
 	int desc = 0;
@@ -3089,7 +3089,7 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 		{ "60", "64QAM 5/6"},
 	};
 
-	struct iwl_lq_sta *lq_sta = file->private_data;
+	struct iwl_lq_sta *lq_sta = iocb->ki_filp->private_data;
 	struct iwl_priv *priv;
 	struct iwl_scale_tbl_info *tbl = &(lq_sta->lq_info[lq_sta->active_tbl]);
 
@@ -3160,26 +3160,26 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 		}
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 	kfree(buff);
 	return ret;
 }
 
 static const struct file_operations rs_sta_dbgfs_scale_table_ops = {
-	.write = rs_sta_dbgfs_scale_table_write,
-	.read = rs_sta_dbgfs_scale_table_read,
+	.write_iter = rs_sta_dbgfs_scale_table_write,
+	.read_iter = rs_sta_dbgfs_scale_table_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
-static ssize_t rs_sta_dbgfs_stats_table_read(struct file *file,
-			char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t rs_sta_dbgfs_stats_table_read(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
 	char *buff;
 	int desc = 0;
 	int i, j;
 	ssize_t ret;
 
-	struct iwl_lq_sta *lq_sta = file->private_data;
+	struct iwl_lq_sta *lq_sta = iocb->ki_filp->private_data;
 
 	buff = kmalloc(1024, GFP_KERNEL);
 	if (!buff)
@@ -3204,21 +3204,21 @@ static ssize_t rs_sta_dbgfs_stats_table_read(struct file *file,
 				lq_sta->lq_info[i].win[j].success_ratio);
 		}
 	}
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 	kfree(buff);
 	return ret;
 }
 
 static const struct file_operations rs_sta_dbgfs_stats_table_ops = {
-	.read = rs_sta_dbgfs_stats_table_read,
+	.read_iter = rs_sta_dbgfs_stats_table_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t rs_sta_dbgfs_rate_scale_data_read(struct file *file,
-			char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t rs_sta_dbgfs_rate_scale_data_read(struct kiocb *iocb,
+						 struct iov_iter *to)
 {
-	struct iwl_lq_sta *lq_sta = file->private_data;
+	struct iwl_lq_sta *lq_sta = iocb->ki_filp->private_data;
 	struct iwl_scale_tbl_info *tbl = &lq_sta->lq_info[lq_sta->active_tbl];
 	char buff[120];
 	int desc = 0;
@@ -3232,11 +3232,11 @@ static ssize_t rs_sta_dbgfs_rate_scale_data_read(struct file *file,
 				"Bit Rate= %d Mb/s\n",
 				iwl_rates[lq_sta->last_txrate_idx].ieee >> 1);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	return simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 }
 
 static const struct file_operations rs_sta_dbgfs_rate_scale_data_ops = {
-	.read = rs_sta_dbgfs_rate_scale_data_read,
+	.read_iter = rs_sta_dbgfs_rate_scale_data_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 751a125a1566..7378c6fed447 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -33,10 +33,10 @@ static int _iwl_dbgfs_##name##_open(struct inode *inode,		\
 }
 
 #define FWRT_DEBUGFS_READ_WRAPPER(name)					\
-static ssize_t _iwl_dbgfs_##name##_read(struct file *file,		\
-					char __user *user_buf,		\
-					size_t count, loff_t *ppos)	\
+static ssize_t _iwl_dbgfs_##name##_read(struct kiocb *iocb,		\
+					struct iov_iter *to)		\
 {									\
+	struct file *file = iocb->ki_filp;				\
 	struct dbgfs_##name##_data *data = file->private_data;		\
 									\
 	if (!data->read_done) {						\
@@ -48,8 +48,8 @@ static ssize_t _iwl_dbgfs_##name##_read(struct file *file,		\
 									\
 	if (data->rlen < 0)						\
 		return data->rlen;					\
-	return simple_read_from_buffer(user_buf, count, ppos,		\
-				       data->rbuf, data->rlen);		\
+	return simple_copy_to_iter(data->rbuf, &iocb->ki_pos,		\
+					data->rlen, to);		\
 }
 
 static int _iwl_dbgfs_release(struct inode *inode, struct file *file)
@@ -63,7 +63,7 @@ static int _iwl_dbgfs_release(struct inode *inode, struct file *file)
 FWRT_DEBUGFS_OPEN_WRAPPER(name, buflen, argtype)			\
 FWRT_DEBUGFS_READ_WRAPPER(name)						\
 static const struct file_operations iwl_dbgfs_##name##_ops = {		\
-	.read = _iwl_dbgfs_##name##_read,				\
+	.read_iter = _iwl_dbgfs_##name##_read,				\
 	.open = _iwl_dbgfs_##name##_open,				\
 	.llseek = generic_file_llseek,					\
 	.release = _iwl_dbgfs_release,					\
@@ -83,15 +83,16 @@ static ssize_t _iwl_dbgfs_##name##_write(struct file *file,		\
 		return -EFAULT;						\
 									\
 	return iwl_dbgfs_##name##_write(arg, buf, buf_size);		\
-}
+}									\
+FOPS_WRITE_ITER_HELPER(_iwl_dbgfs_##name##_write);			\
 
 #define _FWRT_DEBUGFS_READ_WRITE_FILE_OPS(name, buflen, argtype)	\
 FWRT_DEBUGFS_OPEN_WRAPPER(name, buflen, argtype)			\
 FWRT_DEBUGFS_WRITE_WRAPPER(name, buflen, argtype)			\
 FWRT_DEBUGFS_READ_WRAPPER(name)						\
 static const struct file_operations iwl_dbgfs_##name##_ops = {		\
-	.write = _iwl_dbgfs_##name##_write,				\
-	.read = _iwl_dbgfs_##name##_read,				\
+	.write_iter = _iwl_dbgfs_##name##_write_iter,			\
+	.read_iter = _iwl_dbgfs_##name##_read,				\
 	.open = _iwl_dbgfs_##name##_open,				\
 	.llseek = generic_file_llseek,					\
 	.release = _iwl_dbgfs_release,					\
@@ -101,7 +102,7 @@ static const struct file_operations iwl_dbgfs_##name##_ops = {		\
 FWRT_DEBUGFS_OPEN_WRAPPER(name, buflen, argtype)			\
 FWRT_DEBUGFS_WRITE_WRAPPER(name, buflen, argtype)			\
 static const struct file_operations iwl_dbgfs_##name##_ops = {		\
-	.write = _iwl_dbgfs_##name##_write,				\
+	.write_iter = _iwl_dbgfs_##name##_write_iter,			\
 	.open = _iwl_dbgfs_##name##_open,				\
 	.llseek = generic_file_llseek,					\
 	.release = _iwl_dbgfs_release,					\
@@ -391,7 +392,7 @@ static int iwl_dbgfs_fw_info_open(struct inode *inode, struct file *filp)
 static const struct file_operations iwl_dbgfs_fw_info_ops = {
 	.owner = THIS_MODULE,
 	.open = iwl_dbgfs_fw_info_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 1dd9106c6513..5ad9530659be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1849,9 +1849,8 @@ EXPORT_SYMBOL_GPL(iwl_mei_unregister_complete);
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 static ssize_t
-iwl_mei_dbgfs_send_start_message_write(struct file *file,
-				       const char __user *user_buf,
-				       size_t count, loff_t *ppos)
+iwl_mei_dbgfs_send_start_message_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
 	int ret;
 
@@ -1866,26 +1865,25 @@ iwl_mei_dbgfs_send_start_message_write(struct file *file,
 
 out:
 	mutex_unlock(&iwl_mei_mutex);
-	return ret ?: count;
+	return ret ?: iov_iter_count(from);
 }
 
 static const struct file_operations iwl_mei_dbgfs_send_start_message_ops = {
-	.write = iwl_mei_dbgfs_send_start_message_write,
+	.write_iter = iwl_mei_dbgfs_send_start_message_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t iwl_mei_dbgfs_req_ownership_write(struct file *file,
-						 const char __user *user_buf,
-						 size_t count, loff_t *ppos)
+static ssize_t iwl_mei_dbgfs_req_ownership_write(struct kiocb *iocb,
+						 struct iov_iter *from)
 {
 	iwl_mei_get_ownership();
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations iwl_mei_dbgfs_req_ownership_ops = {
-	.write = iwl_mei_dbgfs_req_ownership_write,
+	.write_iter = iwl_mei_dbgfs_req_ownership_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 52518a47554e..1d911bbef018 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3405,10 +3405,9 @@ static int iwl_mvm_d3_test_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t iwl_mvm_d3_test_read(struct file *file, char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t iwl_mvm_d3_test_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	unsigned long end = jiffies + 60 * HZ;
 	u32 pme_asserted;
 
@@ -3492,7 +3491,7 @@ static int iwl_mvm_d3_test_release(struct inode *inode, struct file *file)
 const struct file_operations iwl_dbgfs_d3_test_ops = {
 	.llseek = no_llseek,
 	.open = iwl_mvm_d3_test_open,
-	.read = iwl_mvm_d3_test_read,
+	.read_iter = iwl_mvm_d3_test_read,
 	.release = iwl_mvm_d3_test_release,
 };
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 7fe57ecd0682..ea93054caf5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -132,11 +132,10 @@ static ssize_t iwl_dbgfs_pm_params_write(struct ieee80211_vif *vif, char *buf,
 	return ret ?: count;
 }
 
-static ssize_t iwl_dbgfs_tx_pwr_lmt_read(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_tx_pwr_lmt_read_iter(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	struct ieee80211_vif *vif = file->private_data;
+	struct ieee80211_vif *vif = iocb->ki_filp->private_data;
 	char buf[64];
 	int bufsz = sizeof(buf);
 	int pos;
@@ -144,14 +143,13 @@ static ssize_t iwl_dbgfs_tx_pwr_lmt_read(struct file *file,
 	pos = scnprintf(buf, bufsz, "bss limit = %d\n",
 			vif->bss_conf.txpower);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_pm_params_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_pm_params_read_iter(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct ieee80211_vif *vif = file->private_data;
+	struct ieee80211_vif *vif = iocb->ki_filp->private_data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
 	char buf[512];
@@ -160,14 +158,13 @@ static ssize_t iwl_dbgfs_pm_params_read(struct file *file,
 
 	pos = iwl_mvm_power_mac_dbgfs_read(mvm, vif, buf, bufsz);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_mac_params_read(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_mac_params_read_iter(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	struct ieee80211_vif *vif = file->private_data;
+	struct ieee80211_vif *vif = iocb->ki_filp->private_data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
 	u8 ap_sta_id;
@@ -244,7 +241,7 @@ static ssize_t iwl_dbgfs_mac_params_read(struct file *file,
 
 	mutex_unlock(&mvm->mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static void iwl_dbgfs_update_bf(struct ieee80211_vif *vif,
@@ -389,11 +386,10 @@ static ssize_t iwl_dbgfs_bf_params_write(struct ieee80211_vif *vif, char *buf,
 	return ret ?: count;
 }
 
-static ssize_t iwl_dbgfs_bf_params_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_bf_params_read_iter(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct ieee80211_vif *vif = file->private_data;
+	struct ieee80211_vif *vif = iocb->ki_filp->private_data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	char buf[256];
 	int pos = 0;
@@ -435,14 +431,13 @@ static ssize_t iwl_dbgfs_bf_params_read(struct file *file,
 	pos += scnprintf(buf+pos, bufsz-pos, "ba_enable_beacon_abort = %d\n",
 			 le32_to_cpu(cmd.ba_enable_beacon_abort));
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_os_device_timediff_read(struct file *file,
-						 char __user *user_buf,
-						 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_os_device_timediff_read_iter(struct kiocb *iocb,
+						      struct iov_iter *to)
 {
-	struct ieee80211_vif *vif = file->private_data;
+	struct ieee80211_vif *vif = iocb->ki_filp->private_data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = mvmvif->mvm;
 	u32 curr_gp2;
@@ -460,7 +455,7 @@ static ssize_t iwl_dbgfs_os_device_timediff_read(struct file *file,
 	diff = curr_os - curr_gp2;
 	pos += scnprintf(buf + pos, bufsz - pos, "diff=%lld\n", diff);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t iwl_dbgfs_low_latency_write(struct ieee80211_vif *vif, char *buf,
@@ -517,11 +512,10 @@ iwl_dbgfs_low_latency_force_write(struct ieee80211_vif *vif, char *buf,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_low_latency_read(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_low_latency_read_iter(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct ieee80211_vif *vif = file->private_data;
+	struct ieee80211_vif *vif = iocb->ki_filp->private_data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	char format[] = "traffic=%d\ndbgfs=%d\nvcmd=%d\nvif_type=%d\n"
 			"dbgfs_force_enable=%d\ndbgfs_force=%d\nactual=%d\n";
@@ -542,20 +536,19 @@ static ssize_t iwl_dbgfs_low_latency_read(struct file *file,
 			   LOW_LATENCY_DEBUGFS_FORCE_ENABLE),
 			!!(mvmvif->low_latency & LOW_LATENCY_DEBUGFS_FORCE),
 			!!(mvmvif->low_latency_actual));
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t iwl_dbgfs_uapsd_misbehaving_read(struct file *file,
-						char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_uapsd_misbehaving_read_iter(struct kiocb *iocb,
+						     struct iov_iter *to)
 {
-	struct ieee80211_vif *vif = file->private_data;
+	struct ieee80211_vif *vif = iocb->ki_filp->private_data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	char buf[20];
 	int len;
 
 	len = sprintf(buf, "%pM\n", mvmvif->uapsd_misbehaving_ap_addr);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static ssize_t iwl_dbgfs_uapsd_misbehaving_write(struct ieee80211_vif *vif,
@@ -624,11 +617,10 @@ static ssize_t iwl_dbgfs_rx_phyinfo_write(struct ieee80211_vif *vif, char *buf,
 	return ret ?: count;
 }
 
-static ssize_t iwl_dbgfs_rx_phyinfo_read(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_rx_phyinfo_read_iter(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	struct ieee80211_vif *vif = file->private_data;
+	struct ieee80211_vif *vif = iocb->ki_filp->private_data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	char buf[8];
 	int len;
@@ -636,7 +628,7 @@ static ssize_t iwl_dbgfs_rx_phyinfo_read(struct file *file,
 	len = scnprintf(buf, sizeof(buf), "0x%04x\n",
 			mvmvif->mvm->dbgfs_rx_phyinfo);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static void iwl_dbgfs_quota_check(void *data, u8 *mac,
@@ -678,18 +670,17 @@ static ssize_t iwl_dbgfs_quota_min_write(struct ieee80211_vif *vif, char *buf,
 	return ret ?: count;
 }
 
-static ssize_t iwl_dbgfs_quota_min_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_quota_min_read_iter(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct ieee80211_vif *vif = file->private_data;
+	struct ieee80211_vif *vif = iocb->ki_filp->private_data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	char buf[10];
 	int len;
 
 	len = scnprintf(buf, sizeof(buf), "%d\n", mvmvif->dbgfs_quota_min);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 #define MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz) \
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 79f4ac8cbc72..af0cc36aac13 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -19,11 +19,10 @@
 #include "fw/error-dump.h"
 #include "fw/api/phy-ctxt.h"
 
-static ssize_t iwl_dbgfs_ctdp_budget_read(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_ctdp_budget_read_iter(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	char buf[16];
 	int pos, budget;
 
@@ -43,7 +42,7 @@ static ssize_t iwl_dbgfs_ctdp_budget_read(struct file *file,
 
 	pos = scnprintf(buf, sizeof(buf), "%d\n", budget);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t iwl_dbgfs_stop_ctdp_write(struct iwl_mvm *mvm, char *buf,
@@ -182,10 +181,9 @@ static ssize_t iwl_dbgfs_sta_drain_write(struct iwl_mvm *mvm, char *buf,
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_sram_read(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_sram_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	const struct fw_img *img;
 	unsigned int ofs, len;
 	size_t ret;
@@ -210,7 +208,7 @@ static ssize_t iwl_dbgfs_sram_read(struct file *file, char __user *user_buf,
 
 	iwl_trans_read_mem_bytes(mvm->trans, ofs, ptr, len);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, ptr, len);
+	ret = simple_copy_to_iter(ptr, &iocb->ki_pos, len, to);
 
 	kfree(ptr);
 
@@ -248,11 +246,10 @@ static ssize_t iwl_dbgfs_sram_write(struct iwl_mvm *mvm, char *buf,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_set_nic_temperature_read(struct file *file,
-						  char __user *user_buf,
-						  size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_set_nic_temperature_read_iter(struct kiocb *iocb,
+						       struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	char buf[16];
 	int pos;
 
@@ -261,7 +258,7 @@ static ssize_t iwl_dbgfs_set_nic_temperature_read(struct file *file,
 	else
 		pos = scnprintf(buf, sizeof(buf), "%d\n", mvm->temperature);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 /*
@@ -315,11 +312,10 @@ static ssize_t iwl_dbgfs_set_nic_temperature_write(struct iwl_mvm *mvm,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_nic_temp_read(struct file *file,
-				       char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_nic_temp_read_iter(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	char buf[16];
 	int pos, ret;
 	s32 temp;
@@ -336,15 +332,14 @@ static ssize_t iwl_dbgfs_nic_temp_read(struct file *file,
 
 	pos = scnprintf(buf, sizeof(buf), "%d\n", temp);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 #ifdef CONFIG_ACPI
-static ssize_t iwl_dbgfs_sar_geo_profile_read(struct file *file,
-					      char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_sar_geo_profile_read_iter(struct kiocb *iocb,
+						   struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	char buf[256];
 	int pos = 0;
 	int bufsz = sizeof(buf);
@@ -379,14 +374,13 @@ static ssize_t iwl_dbgfs_sar_geo_profile_read(struct file *file,
 	}
 	mutex_unlock(&mvm->mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_wifi_6e_enable_read(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_wifi_6e_enable_read_iter(struct kiocb *iocb,
+						  struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	int err, pos;
 	char buf[12];
 	u32 value;
@@ -397,14 +391,14 @@ static ssize_t iwl_dbgfs_wifi_6e_enable_read(struct file *file,
 
 	pos = sprintf(buf, "0x%08x\n", value);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 #endif
 
-static ssize_t iwl_dbgfs_stations_read(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_stations_read_iter(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	struct ieee80211_sta *sta;
 	char buf[400];
 	int i, pos = 0, bufsz = sizeof(buf);
@@ -427,7 +421,7 @@ static ssize_t iwl_dbgfs_stations_read(struct file *file, char __user *user_buf,
 
 	mutex_unlock(&mvm->mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t iwl_dbgfs_rs_data_read(struct ieee80211_link_sta *link_sta,
@@ -524,11 +518,10 @@ static ssize_t iwl_dbgfs_amsdu_len_read(struct ieee80211_link_sta *link_sta,
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
 
-static ssize_t iwl_dbgfs_disable_power_off_read(struct file *file,
-						char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_disable_power_off_read_iter(struct kiocb *iocb,
+						     struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	char buf[64];
 	int bufsz = sizeof(buf);
 	int pos = 0;
@@ -538,7 +531,7 @@ static ssize_t iwl_dbgfs_disable_power_off_read(struct file *file,
 	pos += scnprintf(buf+pos, bufsz-pos, "disable_power_off_d3=%d\n",
 			 mvm->disable_power_off_d3);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t iwl_dbgfs_disable_power_off_write(struct iwl_mvm *mvm, char *buf,
@@ -628,10 +621,10 @@ int iwl_mvm_coex_dump_mbox(struct iwl_bt_coex_profile_notif *notif, char *buf,
 	return pos;
 }
 
-static ssize_t iwl_dbgfs_bt_notif_read(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_bt_notif_read_iter(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	struct iwl_bt_coex_profile_notif *notif = &mvm->last_bt_notif;
 	char *buf;
 	int ret, pos = 0, bufsz = sizeof(char) * 1024;
@@ -665,17 +658,17 @@ static ssize_t iwl_dbgfs_bt_notif_read(struct file *file, char __user *user_buf,
 
 	mutex_unlock(&mvm->mutex);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 
 	return ret;
 }
 #undef BT_MBOX_PRINT
 
-static ssize_t iwl_dbgfs_bt_cmd_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_bt_cmd_read_iter(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	struct iwl_bt_coex_ci_cmd *cmd = &mvm->last_bt_ci_cmd;
 	char buf[256];
 	int bufsz = sizeof(buf);
@@ -693,7 +686,7 @@ static ssize_t iwl_dbgfs_bt_cmd_read(struct file *file, char __user *user_buf,
 
 	mutex_unlock(&mvm->mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t
@@ -748,10 +741,10 @@ iwl_dbgfs_bt_force_ant_write(struct iwl_mvm *mvm, char *buf,
 	return ret ?: count;
 }
 
-static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_fw_ver_read_iter(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	char *buff, *pos, *endpos;
 	static const size_t bufsz = 1024;
 	char _fw_name_pre[FW_NAME_PRE_BUFSIZE];
@@ -773,17 +766,16 @@ static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
 	pos += scnprintf(pos, endpos - pos, "Bus: %s\n",
 			 mvm->fwrt.dev->bus->name);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, pos - buff);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, pos - buff, to);
 	kfree(buff);
 
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_tas_get_status_read_iter(struct kiocb *iocb,
+						  struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	struct iwl_mvm_tas_status_resp tas_rsp;
 	struct iwl_mvm_tas_status_resp *rsp = &tas_rsp;
 	static const size_t bufsz = 1024;
@@ -957,17 +949,16 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 	}
 
 out:
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, pos - buff);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, pos - buff, to);
 	kfree(buff);
 	iwl_free_resp(&hcmd);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_phy_integration_ver_read(struct file *file,
-						  char __user *user_buf,
-						  size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_phy_integration_ver_read_iter(struct kiocb *iocb,
+						       struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	char *buf;
 	size_t bufsz;
 	int pos;
@@ -981,7 +972,7 @@ static ssize_t iwl_dbgfs_phy_integration_ver_read(struct file *file,
 	pos = scnprintf(buf, bufsz, "%.*s\n", mvm->fw->phy_integration_ver_len,
 			mvm->fw->phy_integration_ver);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 
 	kfree(buf);
 	return ret;
@@ -992,11 +983,10 @@ static ssize_t iwl_dbgfs_phy_integration_ver_read(struct file *file,
 					  fmt_table, #_memb,		\
 					  le32_to_cpu(_struct->_memb))
 
-static ssize_t iwl_dbgfs_fw_rx_stats_read(struct file *file,
-					  char __user *user_buf, size_t count,
-					  loff_t *ppos)
+static ssize_t iwl_dbgfs_fw_rx_stats_read_iter(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	static const char *fmt_table = "\t%-30s %10u\n";
 	static const char *fmt_header = "%-32s\n";
 	int pos = 0;
@@ -1182,16 +1172,15 @@ static ssize_t iwl_dbgfs_fw_rx_stats_read(struct file *file,
 
 	mutex_unlock(&mvm->mutex);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 
 	return ret;
 }
 #undef PRINT_STAT_LE32
 
-static ssize_t iwl_dbgfs_fw_system_stats_read(struct file *file,
-					      char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_fw_system_stats_read_iter(struct kiocb *iocb,
+						   struct iov_iter *to)
 {
 	char *buff, *pos, *endpos;
 	int ret;
@@ -1199,7 +1188,7 @@ static ssize_t iwl_dbgfs_fw_system_stats_read(struct file *file,
 	int i;
 	struct iwl_mvm_vif *mvmvif;
 	struct ieee80211_vif *vif;
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
 					   WIDE_ID(SYSTEM_GROUP,
 						   SYSTEM_STATISTICS_CMD),
@@ -1278,7 +1267,7 @@ static ssize_t iwl_dbgfs_fw_system_stats_read(struct file *file,
 	mutex_unlock(&mvm->mutex);
 
 send_out:
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, pos - buff);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, pos - buff, to);
 	kfree(buff);
 
 	return ret;
@@ -1360,6 +1349,7 @@ static ssize_t iwl_dbgfs_drv_rx_stats_read(struct file *file,
 	return iwl_dbgfs_frame_stats_read(mvm, user_buf, count, ppos,
 					  &mvm->drv_rx_stats);
 }
+FOPS_READ_ITER_HELPER(iwl_dbgfs_drv_rx_stats_read);
 
 static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mvm *mvm, char *buf,
 					  size_t count, loff_t *ppos)
@@ -1405,11 +1395,9 @@ static ssize_t iwl_dbgfs_fw_nmi_write(struct iwl_mvm *mvm, char *buf,
 }
 
 static ssize_t
-iwl_dbgfs_scan_ant_rxchain_read(struct file *file,
-				char __user *user_buf,
-				size_t count, loff_t *ppos)
+iwl_dbgfs_scan_ant_rxchain_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	int pos = 0;
 	char buf[32];
 	const size_t bufsz = sizeof(buf);
@@ -1422,7 +1410,7 @@ iwl_dbgfs_scan_ant_rxchain_read(struct file *file,
 		pos += scnprintf(buf + pos, bufsz - pos, "B");
 	pos += scnprintf(buf + pos, bufsz - pos, " (%x)\n", mvm->scan_rx_ant);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t
@@ -1653,11 +1641,10 @@ static ssize_t iwl_dbgfs_inject_beacon_ie_restore_write(struct iwl_mvm *mvm,
 	return ret ?: count;
 }
 
-static ssize_t iwl_dbgfs_fw_dbg_conf_read(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_fw_dbg_conf_read_iter(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	int conf;
 	char buf[8];
 	const size_t bufsz = sizeof(buf);
@@ -1669,7 +1656,7 @@ static ssize_t iwl_dbgfs_fw_dbg_conf_read(struct file *file,
 
 	pos += scnprintf(buf + pos, bufsz - pos, "%d\n", conf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t iwl_dbgfs_fw_dbg_conf_write(struct iwl_mvm *mvm,
@@ -1834,6 +1821,7 @@ static ssize_t _iwl_dbgfs_link_sta_##name##_write(struct file *file,	\
 					      file,			\
 					      buf, buf_size, ppos);	\
 }									\
+FOPS_WRITE_ITER_HELPER(_iwl_dbgfs_link_sta_##name##_write);		\
 
 #define MVM_DEBUGFS_LINK_STA_READ_WRAPPER(name)		\
 static ssize_t _iwl_dbgfs_link_sta_##name##_read(struct file *file,	\
@@ -1844,11 +1832,12 @@ static ssize_t _iwl_dbgfs_link_sta_##name##_read(struct file *file,	\
 					     file,			\
 					     user_buf, count, ppos);	\
 }									\
+FOPS_READ_ITER_HELPER(_iwl_dbgfs_link_sta_##name##_read);		\
 
 #define MVM_DEBUGFS_WRITE_LINK_STA_FILE_OPS(name, bufsz)		\
 MVM_DEBUGFS_LINK_STA_WRITE_WRAPPER(name, bufsz)				\
 static const struct file_operations iwl_dbgfs_link_sta_##name##_ops = {	\
-	.write = _iwl_dbgfs_link_sta_##name##_write,			\
+	.write_iter = _iwl_dbgfs_link_sta_##name##_write_iter,		\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
@@ -1856,7 +1845,7 @@ static const struct file_operations iwl_dbgfs_link_sta_##name##_ops = {	\
 #define MVM_DEBUGFS_READ_LINK_STA_FILE_OPS(name)			\
 MVM_DEBUGFS_LINK_STA_READ_WRAPPER(name)					\
 static const struct file_operations iwl_dbgfs_link_sta_##name##_ops = {	\
-	.read = _iwl_dbgfs_link_sta_##name##_read,			\
+	.read_iter = _iwl_dbgfs_link_sta_##name##_read_iter,		\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
@@ -1865,8 +1854,8 @@ static const struct file_operations iwl_dbgfs_link_sta_##name##_ops = {	\
 MVM_DEBUGFS_LINK_STA_READ_WRAPPER(name)					\
 MVM_DEBUGFS_LINK_STA_WRITE_WRAPPER(name, bufsz)				\
 static const struct file_operations iwl_dbgfs_link_sta_##name##_ops = {	\
-	.read = _iwl_dbgfs_link_sta_##name##_read,			\
-	.write = _iwl_dbgfs_link_sta_##name##_write,			\
+	.read_iter = _iwl_dbgfs_link_sta_##name##_read_iter,		\
+	.write_iter = _iwl_dbgfs_link_sta_##name##_write_iter,		\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
@@ -1878,11 +1867,9 @@ static const struct file_operations iwl_dbgfs_link_sta_##name##_ops = {	\
 	MVM_DEBUGFS_ADD_LINK_STA_FILE_ALIAS(#name, name, parent, mode)
 
 static ssize_t
-iwl_dbgfs_prph_reg_read(struct file *file,
-			char __user *user_buf,
-			size_t count, loff_t *ppos)
+iwl_dbgfs_prph_reg_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	int pos = 0;
 	char buf[32];
 	const size_t bufsz = sizeof(buf);
@@ -1894,7 +1881,7 @@ iwl_dbgfs_prph_reg_read(struct file *file,
 		mvm->dbgfs_prph_reg_addr,
 		iwl_read_prph(mvm->trans, mvm->dbgfs_prph_reg_addr));
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t
@@ -2012,10 +1999,9 @@ iwl_dbgfs_he_sniffer_params_write(struct iwl_mvm *mvm, char *buf,
 }
 
 static ssize_t
-iwl_dbgfs_he_sniffer_params_read(struct file *file, char __user *user_buf,
-				 size_t count, loff_t *ppos)
+iwl_dbgfs_he_sniffer_params_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	u8 buf[32];
 	int len;
 
@@ -2025,14 +2011,13 @@ iwl_dbgfs_he_sniffer_params_read(struct file *file, char __user *user_buf,
 			mvm->cur_bssid[1], mvm->cur_bssid[2], mvm->cur_bssid[3],
 			mvm->cur_bssid[4], mvm->cur_bssid[5]);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static ssize_t
-iwl_dbgfs_uapsd_noagg_bssids_read(struct file *file, char __user *user_buf,
-				  size_t count, loff_t *ppos)
+iwl_dbgfs_uapsd_noagg_bssids_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	u8 buf[IWL_MVM_UAPSD_NOAGG_BSSIDS_NUM * ETH_ALEN * 3 + 1];
 	unsigned int pos = 0;
 	size_t bufsz = sizeof(buf);
@@ -2046,7 +2031,7 @@ iwl_dbgfs_uapsd_noagg_bssids_read(struct file *file, char __user *user_buf,
 
 	mutex_unlock(&mvm->mutex);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t
@@ -2110,11 +2095,10 @@ static ssize_t iwl_dbgfs_rfi_freq_table_write(struct iwl_mvm *mvm, char *buf,
 #define IWL_RFI_BUF_SIZE (IWL_RFI_LUT_INSTALLED_SIZE *\
 				(5 + IWL_RFI_LUT_ENTRY_CHANNELS_NUM * (6 + 5)))
 
-static ssize_t iwl_dbgfs_rfi_freq_table_read(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_rfi_freq_table_read_iter(struct kiocb *iocb,
+						  struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	struct iwl_rfi_freq_table_resp_cmd *resp;
 	u32 status;
 	char buf[IWL_RFI_BUF_SIZE];
@@ -2144,7 +2128,7 @@ static ssize_t iwl_dbgfs_rfi_freq_table_read(struct file *file,
 
 out:
 	kfree(resp);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(prph_reg, 64);
@@ -2200,12 +2184,12 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(he_sniffer_params, 32);
 MVM_DEBUGFS_WRITE_FILE_OPS(ltr_config, 512);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(rfi_freq_table, 16);
 
-static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
-				  size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_mem_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
 	struct iwl_dbg_mem_access_cmd cmd = {};
 	struct iwl_dbg_mem_access_rsp *rsp;
+	size_t count = iov_iter_count(to);
 	struct iwl_host_cmd hcmd = {
 		.flags = CMD_WANT_SKB | CMD_SEND_IN_RFKILL,
 		.data = { &cmd, },
@@ -2217,12 +2201,12 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
 
-	hcmd.id = WIDE_ID(DEBUG_GROUP, *ppos >> 24 ? UMAC_RD_WR : LMAC_RD_WR);
+	hcmd.id = WIDE_ID(DEBUG_GROUP, iocb->ki_pos >> 24 ? UMAC_RD_WR : LMAC_RD_WR);
 	cmd.op = cpu_to_le32(DEBUG_MEM_OP_READ);
 
 	/* Take care of alignment of both the position and the length */
-	delta = *ppos & 0x3;
-	cmd.addr = cpu_to_le32(*ppos - delta);
+	delta = iocb->ki_pos & 0x3;
+	cmd.addr = cpu_to_le32(iocb->ki_pos - delta);
 	cmd.len = cpu_to_le32(min(ALIGN(count + delta, 4) / 4,
 				  (size_t)DEBUG_MEM_MAX_SIZE_DWORDS));
 
@@ -2252,19 +2236,18 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 		goto out;
 	}
 
-	ret = len - copy_to_user(user_buf, (u8 *)rsp->data + delta, len);
-	*ppos += ret;
+	ret = copy_to_iter((u8 *)rsp->data + delta, len, to);
+	iocb->ki_pos += ret;
 
 out:
 	iwl_free_resp(&hcmd);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_mem_write(struct file *file,
-				   const char __user *user_buf, size_t count,
-				   loff_t *ppos)
+static ssize_t iwl_dbgfs_mem_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct iwl_mvm *mvm = file->private_data;
+	struct iwl_mvm *mvm = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct iwl_dbg_mem_access_cmd *cmd;
 	struct iwl_dbg_mem_access_rsp *rsp;
 	struct iwl_host_cmd hcmd = {};
@@ -2276,11 +2259,11 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
 
-	hcmd.id = WIDE_ID(DEBUG_GROUP, *ppos >> 24 ? UMAC_RD_WR : LMAC_RD_WR);
+	hcmd.id = WIDE_ID(DEBUG_GROUP, iocb->ki_pos >> 24 ? UMAC_RD_WR : LMAC_RD_WR);
 
-	if (*ppos & 0x3 || count < 4) {
+	if (iocb->ki_pos & 0x3 || count < 4) {
 		op = DEBUG_MEM_OP_WRITE_BYTES;
-		len = min(count, (size_t)(4 - (*ppos & 0x3)));
+		len = min(count, (size_t)(4 - (iocb->ki_pos & 0x3)));
 		data_size = len;
 	} else {
 		op = DEBUG_MEM_OP_WRITE;
@@ -2295,8 +2278,8 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
 
 	cmd->op = cpu_to_le32(op);
 	cmd->len = cpu_to_le32(len);
-	cmd->addr = cpu_to_le32(*ppos);
-	if (copy_from_user((void *)cmd->data, user_buf, data_size)) {
+	cmd->addr = cpu_to_le32(iocb->ki_pos);
+	if (!copy_from_iter_full((void *)cmd->data, data_size, from)) {
 		kfree(cmd);
 		return -EFAULT;
 	}
@@ -2326,7 +2309,7 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
 	}
 
 	ret = data_size;
-	*ppos += ret;
+	iocb->ki_pos += ret;
 
 out:
 	iwl_free_resp(&hcmd);
@@ -2334,8 +2317,8 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
 }
 
 static const struct file_operations iwl_dbgfs_mem_ops = {
-	.read = iwl_dbgfs_mem_read,
-	.write = iwl_dbgfs_mem_write,
+	.read_iter = iwl_dbgfs_mem_read,
+	.write_iter = iwl_dbgfs_mem_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h
index cc2c45b45ddc..911c4f97709d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h
@@ -6,7 +6,7 @@
  */
 #define MVM_DEBUGFS_READ_FILE_OPS(name)					\
 static const struct file_operations iwl_dbgfs_##name##_ops = {		\
-	.read = iwl_dbgfs_##name##_read,				\
+	.read_iter = iwl_dbgfs_##name##_read_iter,			\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
@@ -25,12 +25,13 @@ static ssize_t _iwl_dbgfs_##name##_write(struct file *file,		\
 									\
 	return iwl_dbgfs_##name##_write(arg, buf, buf_size, ppos);	\
 }									\
+FOPS_WRITE_ITER_HELPER(_iwl_dbgfs_##name##_write);			\
 
 #define _MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, buflen, argtype)		\
 MVM_DEBUGFS_WRITE_WRAPPER(name, buflen, argtype)			\
 static const struct file_operations iwl_dbgfs_##name##_ops = {		\
-	.write = _iwl_dbgfs_##name##_write,				\
-	.read = iwl_dbgfs_##name##_read,				\
+	.write_iter = _iwl_dbgfs_##name##_write_iter,			\
+	.read_iter = iwl_dbgfs_##name##_read_iter,			\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
@@ -38,7 +39,7 @@ static const struct file_operations iwl_dbgfs_##name##_ops = {		\
 #define _MVM_DEBUGFS_WRITE_FILE_OPS(name, buflen, argtype)		\
 MVM_DEBUGFS_WRITE_WRAPPER(name, buflen, argtype)			\
 static const struct file_operations iwl_dbgfs_##name##_ops = {		\
-	.write = _iwl_dbgfs_##name##_write,				\
+	.write_iter = _iwl_dbgfs_##name##_write_iter,			\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index a8c4e354e2ce..d034eff48c37 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -3720,10 +3720,11 @@ static void rs_program_fix_rate(struct iwl_mvm *mvm,
 	}
 }
 
-static ssize_t rs_sta_dbgfs_scale_table_write(struct file *file,
-			const char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t rs_sta_dbgfs_scale_table_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct iwl_lq_sta *lq_sta = file->private_data;
+	struct iwl_lq_sta *lq_sta = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct iwl_mvm *mvm;
 	char buf[64];
 	size_t buf_size;
@@ -3732,7 +3733,7 @@ static ssize_t rs_sta_dbgfs_scale_table_write(struct file *file,
 	mvm = lq_sta->pers.drv;
 	memset(buf, 0, sizeof(buf));
 	buf_size = min(count, sizeof(buf) -  1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	if (sscanf(buf, "%x", &parsed_rate) == 1)
@@ -3745,8 +3746,8 @@ static ssize_t rs_sta_dbgfs_scale_table_write(struct file *file,
 	return count;
 }
 
-static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
-			char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t rs_sta_dbgfs_scale_table_read(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
 	char *buff;
 	int desc = 0;
@@ -3754,7 +3755,7 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 	ssize_t ret;
 	static const size_t bufsz = 2048;
 
-	struct iwl_lq_sta *lq_sta = file->private_data;
+	struct iwl_lq_sta *lq_sta = iocb->ki_filp->private_data;
 	struct iwl_mvm_sta *mvmsta =
 		container_of(lq_sta, struct iwl_mvm_sta, deflink.lq_sta.rs_drv);
 	struct iwl_mvm *mvm;
@@ -3840,19 +3841,19 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 			buff[desc++] = '\n';
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 	kfree(buff);
 	return ret;
 }
 
 static const struct file_operations rs_sta_dbgfs_scale_table_ops = {
-	.write = rs_sta_dbgfs_scale_table_write,
-	.read = rs_sta_dbgfs_scale_table_read,
+	.write_iter = rs_sta_dbgfs_scale_table_write,
+	.read_iter = rs_sta_dbgfs_scale_table_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
-static ssize_t rs_sta_dbgfs_stats_table_read(struct file *file,
-			char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t rs_sta_dbgfs_stats_table_read(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
 	char *buff;
 	int desc = 0;
@@ -3860,7 +3861,7 @@ static ssize_t rs_sta_dbgfs_stats_table_read(struct file *file,
 	ssize_t ret;
 	struct iwl_scale_tbl_info *tbl;
 	struct rs_rate *rate;
-	struct iwl_lq_sta *lq_sta = file->private_data;
+	struct iwl_lq_sta *lq_sta = iocb->ki_filp->private_data;
 
 	buff = kmalloc(1024, GFP_KERNEL);
 	if (!buff)
@@ -3888,20 +3889,19 @@ static ssize_t rs_sta_dbgfs_stats_table_read(struct file *file,
 				tbl->win[j].success_ratio);
 		}
 	}
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 	kfree(buff);
 	return ret;
 }
 
 static const struct file_operations rs_sta_dbgfs_stats_table_ops = {
-	.read = rs_sta_dbgfs_stats_table_read,
+	.read_iter = rs_sta_dbgfs_stats_table_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t rs_sta_dbgfs_drv_tx_stats_read(struct file *file,
-					      char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t rs_sta_dbgfs_drv_tx_stats_read(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
 	static const char * const column_name[] = {
 		[RS_COLUMN_LEGACY_ANT_A] = "LEGACY_ANT_A",
@@ -3937,7 +3937,7 @@ static ssize_t rs_sta_dbgfs_drv_tx_stats_read(struct file *file,
 	char *buff, *pos, *endpos;
 	int col, rate;
 	ssize_t ret;
-	struct iwl_lq_sta *lq_sta = file->private_data;
+	struct iwl_lq_sta *lq_sta = iocb->ki_filp->private_data;
 	struct rs_rate_stats *stats;
 	static const size_t bufsz = 1024;
 
@@ -3967,33 +3967,31 @@ static ssize_t rs_sta_dbgfs_drv_tx_stats_read(struct file *file,
 		pos += scnprintf(pos, endpos - pos, "\n");
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, pos - buff);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, pos - buff, to);
 	kfree(buff);
 	return ret;
 }
 
-static ssize_t rs_sta_dbgfs_drv_tx_stats_write(struct file *file,
-					       const char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t rs_sta_dbgfs_drv_tx_stats_write(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct iwl_lq_sta *lq_sta = file->private_data;
+	struct iwl_lq_sta *lq_sta = iocb->ki_filp->private_data;
 	memset(lq_sta->pers.tx_stats, 0, sizeof(lq_sta->pers.tx_stats));
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations rs_sta_dbgfs_drv_tx_stats_ops = {
-	.read = rs_sta_dbgfs_drv_tx_stats_read,
-	.write = rs_sta_dbgfs_drv_tx_stats_write,
+	.read_iter = rs_sta_dbgfs_drv_tx_stats_read,
+	.write_iter = rs_sta_dbgfs_drv_tx_stats_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t iwl_dbgfs_ss_force_read(struct file *file,
-				       char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_ss_force_read_iter(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct iwl_lq_sta *lq_sta = file->private_data;
+	struct iwl_lq_sta *lq_sta = iocb->ki_filp->private_data;
 	char buf[12];
 	int bufsz = sizeof(buf);
 	int pos = 0;
@@ -4006,7 +4004,7 @@ static ssize_t iwl_dbgfs_ss_force_read(struct file *file,
 
 	pos += scnprintf(buf+pos, bufsz-pos, "%s\n",
 			 ss_force_name[lq_sta->pers.ss_force]);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
 static ssize_t iwl_dbgfs_ss_force_write(struct iwl_lq_sta *lq_sta, char *buf,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 6c76b2dd6878..b4e057adcdfe 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2574,22 +2574,22 @@ void iwl_pcie_dump_csr(struct iwl_trans *trans)
 /* file operation */
 #define DEBUGFS_READ_FILE_OPS(name)					\
 static const struct file_operations iwl_dbgfs_##name##_ops = {		\
-	.read = iwl_dbgfs_##name##_read,				\
+	.read_iter = iwl_dbgfs_##name##_read,				\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
 
 #define DEBUGFS_WRITE_FILE_OPS(name)                                    \
 static const struct file_operations iwl_dbgfs_##name##_ops = {          \
-	.write = iwl_dbgfs_##name##_write,                              \
+	.write_iter = iwl_dbgfs_##name##_write_iter,                    \
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
 
 #define DEBUGFS_READ_WRITE_FILE_OPS(name)				\
 static const struct file_operations iwl_dbgfs_##name##_ops = {		\
-	.write = iwl_dbgfs_##name##_write,				\
-	.read = iwl_dbgfs_##name##_read,				\
+	.write_iter = iwl_dbgfs_##name##_write_iter,			\
+	.read_iter = iwl_dbgfs_##name##_read,				\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
@@ -2684,11 +2684,9 @@ static int iwl_dbgfs_tx_queue_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
-				       char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_rx_queue_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans *trans = iocb->ki_filp->private_data;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	char *buf;
 	int pos = 0, i, ret;
@@ -2727,17 +2725,15 @@ static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
 					 "\tclosed_rb_num: Not Allocated\n");
 		}
 	}
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_interrupt_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_interrupt_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans *trans = iocb->ki_filp->private_data;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
 
@@ -2786,22 +2782,22 @@ static ssize_t iwl_dbgfs_interrupt_read(struct file *file,
 	pos += scnprintf(buf + pos, bufsz - pos, "Unexpected INTA:\t\t %u\n",
 		isr_stats->unhandled);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_interrupt_write(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_interrupt_write_iter(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans *trans = iocb->ki_filp->private_data;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
+	size_t count = iov_iter_count(from);
 	u32 reset_flag;
 	int ret;
 
-	ret = kstrtou32_from_user(user_buf, count, 16, &reset_flag);
+	ret = kstrtou32_from_iter(from, count, 16, &reset_flag);
 	if (ret)
 		return ret;
 	if (reset_flag == 0)
@@ -2810,22 +2806,19 @@ static ssize_t iwl_dbgfs_interrupt_write(struct file *file,
 	return count;
 }
 
-static ssize_t iwl_dbgfs_csr_write(struct file *file,
-				   const char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_csr_write_iter(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans *trans = iocb->ki_filp->private_data;
 
 	iwl_pcie_dump_csr(trans);
 
-	return count;
+	return iov_iter_count(from);
 }
 
-static ssize_t iwl_dbgfs_fh_reg_read(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_fh_reg_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans *trans = iocb->ki_filp->private_data;
 	char *buf = NULL;
 	ssize_t ret;
 
@@ -2834,16 +2827,14 @@ static ssize_t iwl_dbgfs_fh_reg_read(struct file *file,
 		return ret;
 	if (!buf)
 		return -EINVAL;
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t iwl_dbgfs_rfkill_read(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_rfkill_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans *trans = iocb->ki_filp->private_data;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	char buf[100];
 	int pos;
@@ -2853,19 +2844,19 @@ static ssize_t iwl_dbgfs_rfkill_read(struct file *file,
 			!(iwl_read32(trans, CSR_GP_CNTRL) &
 				CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW));
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 }
 
-static ssize_t iwl_dbgfs_rfkill_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_rfkill_write_iter(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans *trans = iocb->ki_filp->private_data;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	size_t count = iov_iter_count(from);
 	bool new_value;
 	int ret;
 
-	ret = kstrtobool_from_user(user_buf, count, &new_value);
+	ret = kstrtobool_from_iter(from, count, &new_value);
 	if (ret)
 		return ret;
 	if (new_value == trans_pcie->debug_rfkill)
@@ -3008,20 +2999,18 @@ static ssize_t iwl_dbgfs_monitor_data_read(struct file *file,
 
 	return bytes_copied;
 }
+FOPS_READ_ITER_HELPER(iwl_dbgfs_monitor_data_read);
 
-static ssize_t iwl_dbgfs_rf_read(struct file *file,
-				 char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t iwl_dbgfs_rf_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans *trans = iocb->ki_filp->private_data;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	if (!trans_pcie->rf_name[0])
 		return -ENODEV;
 
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       trans_pcie->rf_name,
-				       strlen(trans_pcie->rf_name));
+	return simple_copy_to_iter(trans_pcie->rf_name, &iocb->ki_pos,
+				       strlen(trans_pcie->rf_name), to);
 }
 
 DEBUGFS_READ_WRITE_FILE_OPS(interrupt);
@@ -3034,13 +3023,13 @@ DEBUGFS_READ_FILE_OPS(rf);
 static const struct file_operations iwl_dbgfs_tx_queue_ops = {
 	.owner = THIS_MODULE,
 	.open = iwl_dbgfs_tx_queue_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
 
 static const struct file_operations iwl_dbgfs_monitor_data_ops = {
-	.read = iwl_dbgfs_monitor_data_read,
+	.read_iter = iwl_dbgfs_monitor_data_read_iter,
 	.open = iwl_dbgfs_monitor_data_open,
 	.release = iwl_dbgfs_monitor_data_release,
 };
-- 
2.43.0


