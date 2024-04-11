Return-Path: <linux-kernel+bounces-141080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EC98A1A63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E9E1C22EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B231DA014;
	Thu, 11 Apr 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kbq7vX5I"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B81D8EAF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850010; cv=none; b=oixzj91QbybP+CvN1cWQAkJJXVDcSqrTov5HNjcqjdeIh5jv2Qu4sKfHt3p1y5h02NyH66GzTkgAB7kCu2YuPIFqex6NfMXejWfkyZb180oiVr9qmO7FMMIKLglbzZ3ySa5yTRIZbQIUTPG0PnSt3o+1SIOADKKs3vbNIYJWDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850010; c=relaxed/simple;
	bh=IgRYp/Hxm5DGEfTo6/7noFjNi5D2RtGO1iJFKp/xbzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2oQ5+lNGGouv+K9ELfE9mJd4b0rY4SfGIDUsp1pMPb90vZs9HXdBWzHrieQFqx4MB/Oicpk/PVx3mu9RPMd3Z9zcnp9/Wn87QuSLRdi85/M+5YAdJ0LQih04/tUMmS43HiQiHx5CThq2L4XMVOzKHU6JqflJwLd1Dzgi4nVde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kbq7vX5I; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170594339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850006; x=1713454806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH9WeNKS5cvWXammTwVIHJ5OZgsvJ7hVaDojdvy5Oqg=;
        b=kbq7vX5IExEQ+i7Y1MOUUTEWDeBv6oeModwZTqw29SNojH2H+q37vG5dINe9kGHzOU
         fr4EGLoCE2h/sDjPDrHOgMl0IN0fWmv9HT0hgkV3DeFWKB+8yzpogtsN917do9tedyUd
         rJ9wZdMuHkN6l1nK4Yac+piGFO8qgWurOXT+vM/xFVXa2Wpp/P2H9YOO9J9zImKWs0yX
         gZSwgGv6Z9LnSlXbSVxhzOl2PoIFwvD6xRZV1TB1m2Dh2T2K3X6PbWYQwB7/Tjhc1zdc
         6xX8EZZhvW/O3EzKeq2I8Rmh6UMIGclzJ6ViqVCioOfYJbkOe1rbwn0jJwAHAzOVy0nU
         YmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850006; x=1713454806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH9WeNKS5cvWXammTwVIHJ5OZgsvJ7hVaDojdvy5Oqg=;
        b=sPTVuTWiWIp13PiLby1ebPSlVTh65gVvgWi1YVDaZqnwx1MdmAZ5/sn94fK9fpFW1L
         gSnH8LB0AFv9RiSOCAqFFl7ANgNkU8DKgvR9gRSqqCvW7ARx4emmqto+vBxCR+9YPvaK
         WBreX3eCO99tD/GnTYGa3ueAhTenJgMp/rey2moGalVSLJ1oImQp0ZdxPu2YZgA0TWfO
         DQuETfRAIFC/7JTigiMCDya3mh5Y2dsiFciYkhd8vvKGiuGqqCfrsi283Fv4twujw4+y
         NizmsqXoXf1rpwFrCN4O1Hs4bhz4/y/TidFc0k8Nd7NSvbyR8GJ6sq6S/RndRA+Mjpb5
         kMDg==
X-Gm-Message-State: AOJu0Yw9EwDxhgzDXTm+ionTRL71v4RI1BRxykFozcXzkOI4TjVOjMEc
	1/1KOaAbzA78vAgI+tq4xVZX9tOwNrkMYX9Q3KLfTtrjdyhFZqiU8Phpg8SnO2obUY0/jkMm8uP
	7
X-Google-Smtp-Source: AGHT+IHB7bTiEePL0OhSCbxV1hNu8PRdzZ+2jb6nAmGhBgfiQbImU9HsnGUpWTxTmXBBCvPQaJKRug==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr191217ioj.2.1712850005496;
        Thu, 11 Apr 2024 08:40:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 303/437] drivers/net/wireless/ath/ath9k: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:23 -0600
Message-ID: <20240411153126.16201-304-axboe@kernel.dk>
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
 drivers/net/wireless/ath/ath9k/common-debug.c |  36 ++-
 .../net/wireless/ath/ath9k/common-spectral.c  | 111 +++++----
 drivers/net/wireless/ath/ath9k/debug.c        | 210 ++++++++----------
 drivers/net/wireless/ath/ath9k/debug_sta.c    |  18 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c    |  30 ++-
 .../net/wireless/ath/ath9k/htc_drv_debug.c    |  82 +++----
 drivers/net/wireless/ath/ath9k/tx99.c         |  40 ++--
 7 files changed, 242 insertions(+), 285 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/common-debug.c b/drivers/net/wireless/ath/ath9k/common-debug.c
index 7aefb79f6bed..080a57674c23 100644
--- a/drivers/net/wireless/ath/ath9k/common-debug.c
+++ b/drivers/net/wireless/ath/ath9k/common-debug.c
@@ -16,10 +16,9 @@
 
 #include "common.h"
 
-static ssize_t read_file_modal_eeprom(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t read_file_modal_eeprom(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_hw *ah = file->private_data;
+	struct ath_hw *ah = iocb->ki_filp->private_data;
 	u32 len = 0, size = 6000;
 	char *buf;
 	size_t retval;
@@ -30,14 +29,14 @@ static ssize_t read_file_modal_eeprom(struct file *file, char __user *user_buf,
 
 	len = ah->eep_ops->dump_eeprom(ah, false, buf, len, size);
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
 static const struct file_operations fops_modal_eeprom = {
-	.read = read_file_modal_eeprom,
+	.read_iter = read_file_modal_eeprom,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -52,10 +51,9 @@ void ath9k_cmn_debug_modal_eeprom(struct dentry *debugfs_phy,
 }
 EXPORT_SYMBOL(ath9k_cmn_debug_modal_eeprom);
 
-static ssize_t read_file_base_eeprom(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t read_file_base_eeprom(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_hw *ah = file->private_data;
+	struct ath_hw *ah = iocb->ki_filp->private_data;
 	u32 len = 0, size = 1500;
 	ssize_t retval = 0;
 	char *buf;
@@ -66,14 +64,14 @@ static ssize_t read_file_base_eeprom(struct file *file, char __user *user_buf,
 
 	len = ah->eep_ops->dump_eeprom(ah, true, buf, len, size);
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
 static const struct file_operations fops_base_eeprom = {
-	.read = read_file_base_eeprom,
+	.read_iter = read_file_base_eeprom,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -120,8 +118,7 @@ void ath9k_cmn_debug_stat_rx(struct ath_rx_stats *rxstats,
 }
 EXPORT_SYMBOL(ath9k_cmn_debug_stat_rx);
 
-static ssize_t read_file_recv(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t read_file_recv(struct kiocb *iocb, struct iov_iter *to)
 {
 #define RXS_ERR(s, e)					\
 	do {						\
@@ -130,7 +127,7 @@ static ssize_t read_file_recv(struct file *file, char __user *user_buf,
 				 rxstats->e);		\
 	} while (0)
 
-	struct ath_rx_stats *rxstats = file->private_data;
+	struct ath_rx_stats *rxstats = iocb->ki_filp->private_data;
 	char *buf;
 	unsigned int len = 0, size = 1600;
 	ssize_t retval = 0;
@@ -162,7 +159,7 @@ static ssize_t read_file_recv(struct file *file, char __user *user_buf,
 	if (len > size)
 		len = size;
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
@@ -171,7 +168,7 @@ static ssize_t read_file_recv(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations fops_recv = {
-	.read = read_file_recv,
+	.read_iter = read_file_recv,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -184,14 +181,13 @@ void ath9k_cmn_debug_recv(struct dentry *debugfs_phy,
 }
 EXPORT_SYMBOL(ath9k_cmn_debug_recv);
 
-static ssize_t read_file_phy_err(struct file *file, char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t read_file_phy_err(struct kiocb *iocb, struct iov_iter *to)
 {
 #define PHY_ERR(s, p) \
 	len += scnprintf(buf + len, size - len, "%22s : %10u\n", s, \
 			 rxstats->phy_err_stats[p])
 
-	struct ath_rx_stats *rxstats = file->private_data;
+	struct ath_rx_stats *rxstats = iocb->ki_filp->private_data;
 	char *buf;
 	unsigned int len = 0, size = 1600;
 	ssize_t retval = 0;
@@ -238,7 +234,7 @@ static ssize_t read_file_phy_err(struct file *file, char __user *user_buf,
 	if (len > size)
 		len = size;
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
@@ -247,7 +243,7 @@ static ssize_t read_file_phy_err(struct file *file, char __user *user_buf,
 }
 
 static const struct file_operations fops_phy_err = {
-	.read = read_file_phy_err,
+	.read_iter = read_file_phy_err,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.c b/drivers/net/wireless/ath/ath9k/common-spectral.c
index 4b27445a5fb8..56ea7faf2da1 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
@@ -686,10 +686,9 @@ EXPORT_SYMBOL(ath_cmn_process_fft);
 /* spectral_scan_ctl */
 /*********************/
 
-static ssize_t read_file_spec_scan_ctl(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t read_file_spec_scan_ctl(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_spec_scan_priv *spec_priv = file->private_data;
+	struct ath_spec_scan_priv *spec_priv = iocb->ki_filp->private_data;
 	char *mode = "";
 	unsigned int len;
 
@@ -708,7 +707,7 @@ static ssize_t read_file_spec_scan_ctl(struct file *file, char __user *user_buf,
 		break;
 	}
 	len = strlen(mode);
-	return simple_read_from_buffer(user_buf, count, ppos, mode, len);
+	return simple_copy_to_iter(mode, &iocb->ki_pos, len, to);
 }
 
 void ath9k_cmn_spectral_scan_trigger(struct ath_common *common,
@@ -786,12 +785,12 @@ int ath9k_cmn_spectral_scan_config(struct ath_common *common,
 }
 EXPORT_SYMBOL(ath9k_cmn_spectral_scan_config);
 
-static ssize_t write_file_spec_scan_ctl(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t write_file_spec_scan_ctl(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct ath_spec_scan_priv *spec_priv = file->private_data;
+	struct ath_spec_scan_priv *spec_priv = iocb->ki_filp->private_data;
 	struct ath_common *common = ath9k_hw_common(spec_priv->ah);
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	ssize_t len;
 
@@ -799,7 +798,7 @@ static ssize_t write_file_spec_scan_ctl(struct file *file,
 		return -EOPNOTSUPP;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -826,8 +825,8 @@ static ssize_t write_file_spec_scan_ctl(struct file *file,
 }
 
 static const struct file_operations fops_spec_scan_ctl = {
-	.read = read_file_spec_scan_ctl,
-	.write = write_file_spec_scan_ctl,
+	.read_iter = read_file_spec_scan_ctl,
+	.write_iter = write_file_spec_scan_ctl,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -837,27 +836,26 @@ static const struct file_operations fops_spec_scan_ctl = {
 /* spectral_short_repeat */
 /*************************/
 
-static ssize_t read_file_spectral_short_repeat(struct file *file,
-					       char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t read_file_spectral_short_repeat(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct ath_spec_scan_priv *spec_priv = file->private_data;
+	struct ath_spec_scan_priv *spec_priv = iocb->ki_filp->private_data;
 	char buf[32];
 	unsigned int len;
 
 	len = sprintf(buf, "%d\n", spec_priv->spec_config.short_repeat);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_spectral_short_repeat(struct file *file,
-						const char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t write_file_spectral_short_repeat(struct kiocb *iocb,
+						struct iov_iter *from)
 {
-	struct ath_spec_scan_priv *spec_priv = file->private_data;
+	struct ath_spec_scan_priv *spec_priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -869,8 +867,8 @@ static ssize_t write_file_spectral_short_repeat(struct file *file,
 }
 
 static const struct file_operations fops_spectral_short_repeat = {
-	.read = read_file_spectral_short_repeat,
-	.write = write_file_spectral_short_repeat,
+	.read_iter = read_file_spectral_short_repeat,
+	.write_iter = write_file_spectral_short_repeat,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -880,27 +878,25 @@ static const struct file_operations fops_spectral_short_repeat = {
 /* spectral_count */
 /******************/
 
-static ssize_t read_file_spectral_count(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t read_file_spectral_count(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_spec_scan_priv *spec_priv = file->private_data;
+	struct ath_spec_scan_priv *spec_priv = iocb->ki_filp->private_data;
 	char buf[32];
 	unsigned int len;
 
 	len = sprintf(buf, "%d\n", spec_priv->spec_config.count);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_spectral_count(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t write_file_spectral_count(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct ath_spec_scan_priv *spec_priv = file->private_data;
+	struct ath_spec_scan_priv *spec_priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 	if (val > 255)
@@ -911,8 +907,8 @@ static ssize_t write_file_spectral_count(struct file *file,
 }
 
 static const struct file_operations fops_spectral_count = {
-	.read = read_file_spectral_count,
-	.write = write_file_spectral_count,
+	.read_iter = read_file_spectral_count,
+	.write_iter = write_file_spectral_count,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -922,27 +918,25 @@ static const struct file_operations fops_spectral_count = {
 /* spectral_period */
 /*******************/
 
-static ssize_t read_file_spectral_period(struct file *file,
-					 char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t read_file_spectral_period(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_spec_scan_priv *spec_priv = file->private_data;
+	struct ath_spec_scan_priv *spec_priv = iocb->ki_filp->private_data;
 	char buf[32];
 	unsigned int len;
 
 	len = sprintf(buf, "%d\n", spec_priv->spec_config.period);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_spectral_period(struct file *file,
-					  const char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t write_file_spectral_period(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct ath_spec_scan_priv *spec_priv = file->private_data;
+	struct ath_spec_scan_priv *spec_priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -954,8 +948,8 @@ static ssize_t write_file_spectral_period(struct file *file,
 }
 
 static const struct file_operations fops_spectral_period = {
-	.read = read_file_spectral_period,
-	.write = write_file_spectral_period,
+	.read_iter = read_file_spectral_period,
+	.write_iter = write_file_spectral_period,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -965,27 +959,26 @@ static const struct file_operations fops_spectral_period = {
 /* spectral_fft_period */
 /***********************/
 
-static ssize_t read_file_spectral_fft_period(struct file *file,
-					     char __user *user_buf,
-					     size_t count, loff_t *ppos)
+static ssize_t read_file_spectral_fft_period(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct ath_spec_scan_priv *spec_priv = file->private_data;
+	struct ath_spec_scan_priv *spec_priv = iocb->ki_filp->private_data;
 	char buf[32];
 	unsigned int len;
 
 	len = sprintf(buf, "%d\n", spec_priv->spec_config.fft_period);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_spectral_fft_period(struct file *file,
-					      const char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t write_file_spectral_fft_period(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct ath_spec_scan_priv *spec_priv = file->private_data;
+	struct ath_spec_scan_priv *spec_priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -997,8 +990,8 @@ static ssize_t write_file_spectral_fft_period(struct file *file,
 }
 
 static const struct file_operations fops_spectral_fft_period = {
-	.read = read_file_spectral_fft_period,
-	.write = write_file_spectral_fft_period,
+	.read_iter = read_file_spectral_fft_period,
+	.write_iter = write_file_spectral_fft_period,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index d84e3ee7b5d9..728b11732afd 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -68,11 +68,10 @@ void ath9k_debug_sync_cause(struct ath_softc *sc, u32 sync_cause)
 		sc->debug.stats.istats.mac_sleep_access++;
 }
 
-static ssize_t ath9k_debugfs_read_buf(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath9k_debugfs_read_buf(struct kiocb *iocb, struct iov_iter *to)
 {
-	u8 *buf = file->private_data;
-	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+	u8 *buf = iocb->ki_filp->private_data;
+	return simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 }
 
 static int ath9k_debugfs_release_buf(struct inode *inode, struct file *file)
@@ -83,27 +82,26 @@ static int ath9k_debugfs_release_buf(struct inode *inode, struct file *file)
 
 #ifdef CONFIG_ATH_DEBUG
 
-static ssize_t read_file_debug(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t read_file_debug(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	char buf[32];
 	unsigned int len;
 
 	len = sprintf(buf, "0x%08x\n", common->debug_mask);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_debug(struct file *file, const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t write_file_debug(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	unsigned long mask;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &mask);
+	ret = kstrtoul_from_iter(from, count, 0, &mask);
 	if (ret)
 		return ret;
 
@@ -112,8 +110,8 @@ static ssize_t write_file_debug(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations fops_debug = {
-	.read = read_file_debug,
-	.write = write_file_debug,
+	.read_iter = read_file_debug,
+	.write_iter = write_file_debug,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -124,10 +122,9 @@ static const struct file_operations fops_debug = {
 #define DMA_BUF_LEN 1024
 
 
-static ssize_t read_file_ani(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t read_file_ani(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	struct ath_hw *ah = sc->sc_ah;
 	unsigned int len = 0;
@@ -173,22 +170,21 @@ static ssize_t read_file_ani(struct file *file, char __user *user_buf,
 	if (len > size)
 		len = size;
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
-static ssize_t write_file_ani(struct file *file,
-			      const char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t write_file_ani(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	unsigned long ani;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &ani);
+	ret = kstrtoul_from_iter(from, count, 0, &ani);
 	if (ret)
 		return ret;
 
@@ -208,8 +204,8 @@ static ssize_t write_file_ani(struct file *file,
 }
 
 static const struct file_operations fops_ani = {
-	.read = read_file_ani,
-	.write = write_file_ani,
+	.read_iter = read_file_ani,
+	.write_iter = write_file_ani,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -217,30 +213,29 @@ static const struct file_operations fops_ani = {
 
 #ifdef CONFIG_ATH9K_BTCOEX_SUPPORT
 
-static ssize_t read_file_bt_ant_diversity(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t read_file_bt_ant_diversity(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	char buf[32];
 	unsigned int len;
 
 	len = sprintf(buf, "%d\n", common->bt_ant_diversity);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_bt_ant_diversity(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t write_file_bt_ant_diversity(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	struct ath9k_hw_capabilities *pCap = &sc->sc_ah->caps;
 	unsigned long bt_ant_diversity;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &bt_ant_diversity);
+	ret = kstrtoul_from_iter(from, count, 0, &bt_ant_diversity);
 	if (ret)
 		return ret;
 
@@ -258,8 +253,8 @@ static ssize_t write_file_bt_ant_diversity(struct file *file,
 }
 
 static const struct file_operations fops_bt_ant_diversity = {
-	.read = read_file_bt_ant_diversity,
-	.write = write_file_bt_ant_diversity,
+	.read_iter = read_file_bt_ant_diversity,
+	.write_iter = write_file_bt_ant_diversity,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -281,11 +276,10 @@ void ath9k_debug_stat_ant(struct ath_softc *sc,
 	as_alt->rssi_avg = alt_rssi_avg;
 }
 
-static ssize_t read_file_antenna_diversity(struct file *file,
-					   char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t read_file_antenna_diversity(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	struct ath_hw *ah = sc->sc_ah;
 	struct ath9k_hw_capabilities *pCap = &ah->caps;
 	struct ath_antenna_stats *as_main = &sc->debug.stats.ant_stats[ANT_MAIN];
@@ -373,14 +367,14 @@ static ssize_t read_file_antenna_diversity(struct file *file,
 	if (len > size)
 		len = size;
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
 static const struct file_operations fops_antenna_diversity = {
-	.read = read_file_antenna_diversity,
+	.read_iter = read_file_antenna_diversity,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -769,17 +763,16 @@ static int open_file_reset(struct inode *inode, struct file *f)
 	return single_open(f, read_file_reset, inode->i_private);
 }
 
-static ssize_t write_file_reset(struct file *file,
-				const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t write_file_reset(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file_inode(file)->i_private;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath_hw *ah = sc->sc_ah;
 	struct ath_common *common = ath9k_hw_common(ah);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -800,8 +793,8 @@ static ssize_t write_file_reset(struct file *file,
 }
 
 static const struct file_operations fops_reset = {
-	.read = seq_read,
-	.write = write_file_reset,
+	.read_iter = seq_read_iter,
+	.write_iter = write_file_reset,
 	.open = open_file_reset,
 	.owner = THIS_MODULE,
 	.llseek = seq_lseek,
@@ -850,25 +843,24 @@ void ath_debug_stat_rx(struct ath_softc *sc, struct ath_rx_status *rs)
 	ath9k_cmn_debug_stat_rx(&sc->debug.stats.rxstats, rs);
 }
 
-static ssize_t read_file_regidx(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t read_file_regidx(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	char buf[32];
 	unsigned int len;
 
 	len = sprintf(buf, "0x%08x\n", sc->debug.regidx);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_regidx(struct file *file, const char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t write_file_regidx(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long regidx;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &regidx);
+	ret = kstrtoul_from_iter(from, count, 0, &regidx);
 	if (ret)
 		return ret;
 
@@ -877,17 +869,16 @@ static ssize_t write_file_regidx(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations fops_regidx = {
-	.read = read_file_regidx,
-	.write = write_file_regidx,
+	.read_iter = read_file_regidx,
+	.write_iter = write_file_regidx,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_regval(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t read_file_regval(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	struct ath_hw *ah = sc->sc_ah;
 	char buf[32];
 	unsigned int len;
@@ -897,18 +888,18 @@ static ssize_t read_file_regval(struct file *file, char __user *user_buf,
 	regval = REG_READ_D(ah, sc->debug.regidx);
 	ath9k_ps_restore(sc);
 	len = sprintf(buf, "0x%08x\n", regval);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_regval(struct file *file, const char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t write_file_regval(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath_hw *ah = sc->sc_ah;
 	unsigned long regval;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &regval);
+	ret = kstrtoul_from_iter(from, count, 0, &regval);
 	if (ret)
 		return ret;
 
@@ -919,8 +910,8 @@ static ssize_t write_file_regval(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations fops_regval = {
-	.read = read_file_regval,
-	.write = write_file_regval,
+	.read_iter = read_file_regval,
+	.write_iter = write_file_regval,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -974,7 +965,7 @@ static int open_file_regdump(struct inode *inode, struct file *file)
 
 static const struct file_operations fops_regdump = {
 	.open = open_file_regdump,
-	.read = ath9k_debugfs_read_buf,
+	.read_iter = ath9k_debugfs_read_buf,
 	.release = ath9k_debugfs_release_buf,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,/* read accesses f_pos */
@@ -1010,10 +1001,9 @@ static int read_file_dump_nfcal(struct seq_file *file, void *data)
 }
 
 #ifdef CONFIG_ATH9K_BTCOEX_SUPPORT
-static ssize_t read_file_btcoex(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t read_file_btcoex(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	u32 len = 0, size = 1500;
 	char *buf;
 	size_t retval;
@@ -1030,14 +1020,14 @@ static ssize_t read_file_btcoex(struct file *file, char __user *user_buf,
 
 	len = ath9k_dump_btcoex(sc, buf, size);
 exit:
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
 static const struct file_operations fops_btcoex = {
-	.read = read_file_btcoex,
+	.read_iter = read_file_btcoex,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1045,10 +1035,9 @@ static const struct file_operations fops_btcoex = {
 #endif
 
 #ifdef CONFIG_ATH9K_DYNACK
-static ssize_t read_file_ackto(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t read_file_ackto(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	struct ath_hw *ah = sc->sc_ah;
 	char buf[32];
 	unsigned int len;
@@ -1056,11 +1045,11 @@ static ssize_t read_file_ackto(struct file *file, char __user *user_buf,
 	len = sprintf(buf, "%u %c\n", ah->dynack.ackto,
 		      (ah->dynack.enabled) ? 'A' : 'S');
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_ackto = {
-	.read = read_file_ackto,
+	.read_iter = read_file_ackto,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1069,10 +1058,9 @@ static const struct file_operations fops_ackto = {
 
 #ifdef CONFIG_ATH9K_WOW
 
-static ssize_t read_file_wow(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t read_file_wow(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	unsigned int len = 0, size = 32;
 	ssize_t retval;
 	char *buf;
@@ -1087,20 +1075,20 @@ static ssize_t read_file_wow(struct file *file, char __user *user_buf,
 	if (len > size)
 		len = size;
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
-static ssize_t write_file_wow(struct file *file, const char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t write_file_wow(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -1116,8 +1104,8 @@ static ssize_t write_file_wow(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations fops_wow = {
-	.read = read_file_wow,
-	.write = write_file_wow,
+	.read_iter = read_file_wow,
+	.write_iter = write_file_wow,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1125,10 +1113,9 @@ static const struct file_operations fops_wow = {
 
 #endif
 
-static ssize_t read_file_tpc(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t read_file_tpc(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	struct ath_hw *ah = sc->sc_ah;
 	unsigned int len = 0, size = 32;
 	ssize_t retval;
@@ -1144,22 +1131,22 @@ static ssize_t read_file_tpc(struct file *file, char __user *user_buf,
 	if (len > size)
 		len = size;
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
-static ssize_t write_file_tpc(struct file *file, const char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t write_file_tpc(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath_hw *ah = sc->sc_ah;
 	unsigned long val;
 	ssize_t ret;
 	bool tpc_enabled;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -1180,18 +1167,16 @@ static ssize_t write_file_tpc(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations fops_tpc = {
-	.read = read_file_tpc,
-	.write = write_file_tpc,
+	.read_iter = read_file_tpc,
+	.write_iter = write_file_tpc,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_nf_override(struct file *file,
-				     char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t read_file_nf_override(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	struct ath_hw *ah = sc->sc_ah;
 	char buf[32];
 	unsigned int len;
@@ -1201,21 +1186,20 @@ static ssize_t read_file_nf_override(struct file *file,
 	else
 		len = sprintf(buf, "%d\n", ah->nf_override);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_nf_override(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t write_file_nf_override(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath_hw *ah = sc->sc_ah;
 	long val;
 	char buf[32];
 	ssize_t len;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -1242,8 +1226,8 @@ static ssize_t write_file_nf_override(struct file *file,
 }
 
 static const struct file_operations fops_nf_override = {
-	.read = read_file_nf_override,
-	.write = write_file_nf_override,
+	.read_iter = read_file_nf_override,
+	.write_iter = write_file_nf_override,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
diff --git a/drivers/net/wireless/ath/ath9k/debug_sta.c b/drivers/net/wireless/ath/ath9k/debug_sta.c
index 1e2a30019fb6..18aa2b6d1c72 100644
--- a/drivers/net/wireless/ath/ath9k/debug_sta.c
+++ b/drivers/net/wireless/ath/ath9k/debug_sta.c
@@ -20,10 +20,9 @@
 /* node_aggr */
 /*************/
 
-static ssize_t read_file_node_aggr(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_node_aggr(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_node *an = file->private_data;
+	struct ath_node *an = iocb->ki_filp->private_data;
 	struct ath_softc *sc = an->sc;
 	struct ath_atx_tid *tid;
 	struct ath_txq *txq;
@@ -71,14 +70,14 @@ static ssize_t read_file_node_aggr(struct file *file, char __user *user_buf,
 		ath_txq_unlock(sc, txq);
 	}
 exit:
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
 static const struct file_operations fops_node_aggr = {
-	.read = read_file_node_aggr,
+	.read_iter = read_file_node_aggr,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -165,10 +164,9 @@ void ath_debug_rate_stats(struct ath_softc *sc,
 			 rstats->ofdm_stats[i].ofdm_cnt);	\
 	} while (0)
 
-static ssize_t read_file_node_recv(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_node_recv(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_node *an = file->private_data;
+	struct ath_node *an = iocb->ki_filp->private_data;
 	struct ath_softc *sc = an->sc;
 	struct ath_hw *ah = sc->sc_ah;
 	struct ath_rx_rate_stats *rstats;
@@ -226,7 +224,7 @@ static ssize_t read_file_node_recv(struct file *file, char __user *user_buf,
 	PRINT_OFDM_RATE("OFDM-48M", 6);
 	PRINT_OFDM_RATE("OFDM-54M", 7);
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
@@ -236,7 +234,7 @@ static ssize_t read_file_node_recv(struct file *file, char __user *user_buf,
 #undef PRINT_CCK_RATE
 
 static const struct file_operations fops_node_recv = {
-	.read = read_file_node_recv,
+	.read_iter = read_file_node_recv,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
diff --git a/drivers/net/wireless/ath/ath9k/dfs_debug.c b/drivers/net/wireless/ath/ath9k/dfs_debug.c
index 8e18e9b4ef48..709e8be90e99 100644
--- a/drivers/net/wireless/ath/ath9k/dfs_debug.c
+++ b/drivers/net/wireless/ath/ath9k/dfs_debug.c
@@ -31,10 +31,9 @@ static struct ath_dfs_pool_stats dfs_pool_stats = { 0 };
 	len += scnprintf(buf + len, size - len, "%28s : %10u\n", s, \
 			 dfs_pool_stats.p);
 
-static ssize_t read_file_dfs(struct file *file, char __user *user_buf,
-			     size_t count, loff_t *ppos)
+static ssize_t read_file_dfs(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	struct ath9k_hw_version *hw_ver = &sc->sc_ah->hw_version;
 	char *buf;
 	unsigned int len = 0, size = 8000;
@@ -86,7 +85,7 @@ static ssize_t read_file_dfs(struct file *file, char __user *user_buf,
 	if (len > size)
 		len = size;
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
@@ -94,14 +93,14 @@ static ssize_t read_file_dfs(struct file *file, char __user *user_buf,
 
 /* magic number to prevent accidental reset of DFS statistics */
 #define DFS_STATS_RESET_MAGIC	0x80000000
-static ssize_t write_file_dfs(struct file *file, const char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t write_file_dfs(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &val);
+	ret = kstrtoul_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 	if (val == DFS_STATS_RESET_MAGIC)
@@ -110,27 +109,26 @@ static ssize_t write_file_dfs(struct file *file, const char __user *user_buf,
 	return count;
 }
 
-static ssize_t write_file_simulate_radar(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t write_file_simulate_radar(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 
 	ieee80211_radar_detected(sc->hw);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations fops_simulate_radar = {
-	.write = write_file_simulate_radar,
+	.write_iter = write_file_simulate_radar,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations fops_dfs_stats = {
-	.read = read_file_dfs,
-	.write = write_file_dfs,
+	.read_iter = read_file_dfs,
+	.write_iter = write_file_dfs,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index f7c6d9bc9311..4743687dc8ab 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -16,10 +16,9 @@
 
 #include "htc.h"
 
-static ssize_t read_file_tgt_int_stats(struct file *file, char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t read_file_tgt_int_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath9k_htc_priv *priv = file->private_data;
+	struct ath9k_htc_priv *priv = iocb->ki_filp->private_data;
 	struct ath9k_htc_target_int_stats cmd_rsp;
 	char buf[512];
 	unsigned int len = 0;
@@ -64,20 +63,19 @@ static ssize_t read_file_tgt_int_stats(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_tgt_int_stats = {
-	.read = read_file_tgt_int_stats,
+	.read_iter = read_file_tgt_int_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_tgt_tx_stats(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t read_file_tgt_tx_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath9k_htc_priv *priv = file->private_data;
+	struct ath9k_htc_priv *priv = iocb->ki_filp->private_data;
 	struct ath9k_htc_target_tx_stats cmd_rsp;
 	char buf[512];
 	unsigned int len = 0;
@@ -134,20 +132,19 @@ static ssize_t read_file_tgt_tx_stats(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_tgt_tx_stats = {
-	.read = read_file_tgt_tx_stats,
+	.read_iter = read_file_tgt_tx_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_tgt_rx_stats(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t read_file_tgt_rx_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath9k_htc_priv *priv = file->private_data;
+	struct ath9k_htc_priv *priv = iocb->ki_filp->private_data;
 	struct ath9k_htc_target_rx_stats cmd_rsp;
 	char buf[512];
 	unsigned int len = 0;
@@ -180,20 +177,19 @@ static ssize_t read_file_tgt_rx_stats(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_tgt_rx_stats = {
-	.read = read_file_tgt_rx_stats,
+	.read_iter = read_file_tgt_rx_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_xmit(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t read_file_xmit(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath9k_htc_priv *priv = file->private_data;
+	struct ath9k_htc_priv *priv = iocb->ki_filp->private_data;
 	char buf[512];
 	unsigned int len = 0;
 
@@ -232,11 +228,11 @@ static ssize_t read_file_xmit(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_xmit = {
-	.read = read_file_xmit,
+	.read_iter = read_file_xmit,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -248,10 +244,9 @@ void ath9k_htc_err_stat_rx(struct ath9k_htc_priv *priv,
 	ath9k_cmn_debug_stat_rx(&priv->debug.rx_stats, rs);
 }
 
-static ssize_t read_file_skb_rx(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t read_file_skb_rx(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath9k_htc_priv *priv = file->private_data;
+	struct ath9k_htc_priv *priv = iocb->ki_filp->private_data;
 	char *buf;
 	unsigned int len = 0, size = 1500;
 	ssize_t retval = 0;
@@ -273,23 +268,22 @@ static ssize_t read_file_skb_rx(struct file *file, char __user *user_buf,
 	if (len > size)
 		len = size;
 
-	retval = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	retval = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 
 	return retval;
 }
 
 static const struct file_operations fops_skb_rx = {
-	.read = read_file_skb_rx,
+	.read_iter = read_file_skb_rx,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_slot(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t read_file_slot(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath9k_htc_priv *priv = file->private_data;
+	struct ath9k_htc_priv *priv = iocb->ki_filp->private_data;
 	char buf[512];
 	unsigned int len;
 
@@ -300,20 +294,19 @@ static ssize_t read_file_slot(struct file *file, char __user *user_buf,
 			MAX_TX_BUF_NUM, priv->tx.tx_slot,
 			bitmap_weight(priv->tx.tx_slot, MAX_TX_BUF_NUM));
 	spin_unlock_bh(&priv->tx.tx_lock);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_slot = {
-	.read = read_file_slot,
+	.read_iter = read_file_slot,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_queue(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t read_file_queue(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath9k_htc_priv *priv = file->private_data;
+	struct ath9k_htc_priv *priv = iocb->ki_filp->private_data;
 	char buf[512];
 	unsigned int len = 0;
 
@@ -346,38 +339,37 @@ static ssize_t read_file_queue(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 }
 
 static const struct file_operations fops_queue = {
-	.read = read_file_queue,
+	.read_iter = read_file_queue,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_debug(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t read_file_debug(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath9k_htc_priv *priv = file->private_data;
+	struct ath9k_htc_priv *priv = iocb->ki_filp->private_data;
 	struct ath_common *common = ath9k_hw_common(priv->ah);
 	char buf[32];
 	unsigned int len;
 
 	len = sprintf(buf, "0x%08x\n", common->debug_mask);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_debug(struct file *file, const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t write_file_debug(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath9k_htc_priv *priv = file->private_data;
+	struct ath9k_htc_priv *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath_common *common = ath9k_hw_common(priv->ah);
 	unsigned long mask;
 	ssize_t ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &mask);
+	ret = kstrtoul_from_iter(from, count, 0, &mask);
 	if (ret)
 		return ret;
 
@@ -386,8 +378,8 @@ static ssize_t write_file_debug(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations fops_debug = {
-	.read = read_file_debug,
-	.write = write_file_debug,
+	.read_iter = read_file_debug,
+	.write_iter = write_file_debug,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
diff --git a/drivers/net/wireless/ath/ath9k/tx99.c b/drivers/net/wireless/ath/ath9k/tx99.c
index f2144fd39093..349aa30cef9f 100644
--- a/drivers/net/wireless/ath/ath9k/tx99.c
+++ b/drivers/net/wireless/ath/ath9k/tx99.c
@@ -156,21 +156,20 @@ static int ath9k_tx99_init(struct ath_softc *sc)
 	return 0;
 }
 
-static ssize_t read_file_tx99(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t read_file_tx99(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	char buf[3];
 	unsigned int len;
 
 	len = sprintf(buf, "%d\n", sc->tx99_state);
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_tx99(struct file *file, const char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t write_file_tx99(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	bool start;
 	ssize_t ret;
@@ -182,7 +181,7 @@ static ssize_t write_file_tx99(struct file *file, const char __user *user_buf,
 	if (sc->cur_chan->nvifs > 1)
 		return -EOPNOTSUPP;
 
-	ret = kstrtobool_from_user(user_buf, count, &start);
+	ret = kstrtobool_from_iter(from, count, &start);
 	if (ret)
 		return ret;
 
@@ -211,18 +210,16 @@ static ssize_t write_file_tx99(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations fops_tx99 = {
-	.read = read_file_tx99,
-	.write = write_file_tx99,
+	.read_iter = read_file_tx99,
+	.write_iter = write_file_tx99,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_tx99_power(struct file *file,
-				    char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t read_file_tx99_power(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
 	char buf[32];
 	unsigned int len;
 
@@ -230,18 +227,17 @@ static ssize_t read_file_tx99_power(struct file *file,
 		      sc->tx99_power,
 		      sc->tx99_power / 2);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_tx99_power(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t write_file_tx99_power(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath_softc *sc = file->private_data;
+	struct ath_softc *sc = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int r;
 	u8 tx_power;
 
-	r = kstrtou8_from_user(user_buf, count, 0, &tx_power);
+	r = kstrtou8_from_iter(from, count, 0, &tx_power);
 	if (r)
 		return r;
 
@@ -258,8 +254,8 @@ static ssize_t write_file_tx99_power(struct file *file,
 }
 
 static const struct file_operations fops_tx99_power = {
-	.read = read_file_tx99_power,
-	.write = write_file_tx99_power,
+	.read_iter = read_file_tx99_power,
+	.write_iter = write_file_tx99_power,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
-- 
2.43.0


