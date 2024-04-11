Return-Path: <linux-kernel+bounces-141070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8879A8A1A56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6411C225B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D543BBC2;
	Thu, 11 Apr 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FcxIs4Eu"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121271D2A1E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849993; cv=none; b=TXXxDbM+NfggAE50q1zwAKkiXOh5n8fHwF25WJ7Q1NSNvlSJZVPUgXiF0y8TknnC4m7ply3lkyKivNHqld0Cu98eiaMDfZ1OxC9f7sr9AYchVI8H3xE8pdTlAwgTpYKsnYW73gcFu4vHv6wyT+hmbEShYEbiovK5pjPeKBbvT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849993; c=relaxed/simple;
	bh=RUqCIlWh5Lno+H9NA44P/nJeW+YKWl4NhVLEkfMKYDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhFoHut1rqthoyla9vZs1Z1Y6uEsojhD3yq5/RiXUEwctsj21wRLCn5Oox08pBi1Lz0LoViZq+6rZJF2uFDvY6ORPsWJfDankBB33nuOUNJQY1RxS8hqAeINQWbpXVPBypEwHxq5180C3KTDRauHotOmR73OXEYAQriX10Etdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FcxIs4Eu; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170589539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849989; x=1713454789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVmbO/u0RfFp7oLs75EMek47Iv2G10BWIgRDZrKc9u4=;
        b=FcxIs4Eu6zdYI3PWGSI9A9HTT8wvbbQBqZDYPO60Jj8qioGdWnzNIaqtPd1tyk7psg
         FIcoYLTKuzTCCkqqPUxYktZ+50TxmQodLvVFlaWE48hSVPoeLb+XWPVKPVQfO+gohFkb
         WeaIsH09LCteezzQqG/fHmo76WhDppPn7Qy6wk3ZXa1iOg/fKxThOSVCgucN0OrfTB7t
         RIG0xmNTyLfjlhbE2t2R+uZmM7owZeoqI/0LTKbV/9Eqz1Hf9V+rH/StAOixY1rBacqe
         K+hptnD+c374La2VWieCIBMZP5oZtt82uK+25bsCD80ZJC2M5Zq5g6e+JVD2lG8Ybqiu
         OdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849989; x=1713454789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVmbO/u0RfFp7oLs75EMek47Iv2G10BWIgRDZrKc9u4=;
        b=EBJWQSzYYNvMbwXgKmcZeWnxpDbLjajYxjnaZV81GSTjDuv5d0gthodtthoPnKEi1Q
         tllOyO6JYj0FqSwlMAGG7I8fWxO+n2QIHEXr3FvqvVcjxPtF2/mHnRutLgQuCy1Rr9/j
         CJQ0uGSVU1Se105WlSKYnIknsvJyjAQNQvPM0f1YsCRMO/H7mXYb9pvq6XXAkSGYM+Qu
         VcmDSgj+OiWSYI5RWwermT2Fo8kl+30dDwAM1XAZhoxnSv1KpCNIIpKX0NFf/fGWx+ZD
         0jD4qr1w3tnYHPRQhZOna+NNPB6UOS0+Dm8loTEEazNE3B3/cX3RYZ9x7OXPBmDlPf8o
         TQVg==
X-Gm-Message-State: AOJu0YzwWZu1atYXLziqlWah6ECqGcDXJqM2t0BG4oacw8lb2giMBcco
	nU8I5GbXiGI8MMyW82qoXEDpxMqtnrf5Yk2J4cVOEUY3I5FVQYorsAGlJalg5qwkk5PcIJ7smwQ
	Z
X-Google-Smtp-Source: AGHT+IGpGtVk/LdrIySyA+rOU9fWkiHwF2fSOPg8f2sc6qqkfKlmRMlCJAv8yLvhLov0wcsUOiOyKw==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr231323ioh.0.1712849988931;
        Thu, 11 Apr 2024 08:39:48 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 295/437] drivers/net/wireless/ti: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:15 -0600
Message-ID: <20240411153126.16201-296-axboe@kernel.dk>
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
 drivers/net/wireless/ti/wl1251/debugfs.c |  38 ++-
 drivers/net/wireless/ti/wl18xx/debugfs.c |  73 ++---
 drivers/net/wireless/ti/wlcore/debugfs.c | 373 ++++++++++-------------
 drivers/net/wireless/ti/wlcore/debugfs.h |  37 +--
 4 files changed, 231 insertions(+), 290 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/debugfs.c b/drivers/net/wireless/ti/wl1251/debugfs.c
index a1b778a0fda0..66e57dd0add4 100644
--- a/drivers/net/wireless/ti/wl1251/debugfs.c
+++ b/drivers/net/wireless/ti/wl1251/debugfs.c
@@ -20,19 +20,18 @@
 /* debugfs macros idea from mac80211 */
 
 #define DEBUGFS_READONLY_FILE(name, buflen, fmt, value...)		\
-static ssize_t name## _read(struct file *file, char __user *userbuf,	\
-			    size_t count, loff_t *ppos)			\
+static ssize_t name## _read(struct kiocb *iocb, struct iov_iter *to)	\
 {									\
-	struct wl1251 *wl = file->private_data;				\
+	struct wl1251 *wl = iocb->ki_filp->private_data;			\
 	char buf[buflen];						\
 	int res;							\
 									\
 	res = scnprintf(buf, buflen, fmt "\n", ##value);		\
-	return simple_read_from_buffer(userbuf, count, ppos, buf, res);	\
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);	\
 }									\
 									\
 static const struct file_operations name## _ops = {			\
-	.read = name## _read,						\
+	.read_iter = name## _read,					\
 	.open = simple_open,						\
 	.llseek	= generic_file_llseek,					\
 };
@@ -48,11 +47,10 @@ static const struct file_operations name## _ops = {			\
 	} while (0)
 
 #define DEBUGFS_FWSTATS_FILE(sub, name, buflen, fmt)			\
-static ssize_t sub## _ ##name## _read(struct file *file,		\
-				      char __user *userbuf,		\
-				      size_t count, loff_t *ppos)	\
+static ssize_t sub## _ ##name## _read(struct kiocb *iocb,		\
+				      struct iov_iter *to)		\
 {									\
-	struct wl1251 *wl = file->private_data;				\
+	struct wl1251 *wl = iocb->ki_filp->private_data;		\
 	char buf[buflen];						\
 	int res;							\
 									\
@@ -60,11 +58,11 @@ static ssize_t sub## _ ##name## _read(struct file *file,		\
 									\
 	res = scnprintf(buf, buflen, fmt "\n",				\
 			wl->stats.fw_stats->sub.name);			\
-	return simple_read_from_buffer(userbuf, count, ppos, buf, res);	\
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);	\
 }									\
 									\
 static const struct file_operations sub## _ ##name## _ops = {		\
-	.read = sub## _ ##name## _read,					\
+	.read_iter = sub## _ ##name## _read,				\
 	.open = simple_open,						\
 	.llseek	= generic_file_llseek,					\
 };
@@ -194,10 +192,9 @@ DEBUGFS_READONLY_FILE(retry_count, 20, "%u", wl->stats.retry_count);
 DEBUGFS_READONLY_FILE(excessive_retries, 20, "%u",
 		      wl->stats.excessive_retries);
 
-static ssize_t tx_queue_len_read(struct file *file, char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t tx_queue_len_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1251 *wl = file->private_data;
+	struct wl1251 *wl = iocb->ki_filp->private_data;
 	u32 queue_len;
 	char buf[20];
 	int res;
@@ -205,19 +202,18 @@ static ssize_t tx_queue_len_read(struct file *file, char __user *userbuf,
 	queue_len = skb_queue_len(&wl->tx_queue);
 
 	res = scnprintf(buf, sizeof(buf), "%u\n", queue_len);
-	return simple_read_from_buffer(userbuf, count, ppos, buf, res);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);
 }
 
 static const struct file_operations tx_queue_len_ops = {
-	.read = tx_queue_len_read,
+	.read_iter = tx_queue_len_read,
 	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
 
-static ssize_t tx_queue_status_read(struct file *file, char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static ssize_t tx_queue_status_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1251 *wl = file->private_data;
+	struct wl1251 *wl = iocb->ki_filp->private_data;
 	char buf[3], status;
 	int len;
 
@@ -227,11 +223,11 @@ static ssize_t tx_queue_status_read(struct file *file, char __user *userbuf,
 		status = 'r';
 
 	len = scnprintf(buf, sizeof(buf), "%c\n", status);
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations tx_queue_status_ops = {
-	.read = tx_queue_status_read,
+	.read_iter = tx_queue_status_read,
 	.open = simple_open,
 	.llseek = generic_file_llseek,
 };
diff --git a/drivers/net/wireless/ti/wl18xx/debugfs.c b/drivers/net/wireless/ti/wl18xx/debugfs.c
index 80fbf740fe6d..629838b1a959 100644
--- a/drivers/net/wireless/ti/wl18xx/debugfs.c
+++ b/drivers/net/wireless/ti/wl18xx/debugfs.c
@@ -175,10 +175,9 @@ WL18XX_DEBUGFS_FWSTATS_FILE(roaming, rssi_level, "%d");
 
 WL18XX_DEBUGFS_FWSTATS_FILE(dfs, num_of_radar_detections, "%d");
 
-static ssize_t conf_read(struct file *file, char __user *user_buf,
-			 size_t count, loff_t *ppos)
+static ssize_t conf_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 	struct wl18xx_priv *priv = wl->priv;
 	struct wlcore_conf_header header;
 	char *buf, *pos;
@@ -205,23 +204,22 @@ static ssize_t conf_read(struct file *file, char __user *user_buf,
 
 	mutex_unlock(&wl->mutex);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 	kfree(buf);
 	return ret;
 }
 
 static const struct file_operations conf_ops = {
-	.read = conf_read,
+	.read_iter = conf_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t clear_fw_stats_write(struct file *file,
-			      const char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t clear_fw_stats_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 
 	mutex_lock(&wl->mutex);
@@ -240,20 +238,19 @@ static ssize_t clear_fw_stats_write(struct file *file,
 }
 
 static const struct file_operations clear_fw_stats_ops = {
-	.write = clear_fw_stats_write,
+	.write_iter = clear_fw_stats_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t radar_detection_write(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t radar_detection_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 	u8 channel;
 
-	ret = kstrtou8_from_user(user_buf, count, 10, &channel);
+	ret = kstrtou8_from_iter(from, count, 10, &channel);
 	if (ret < 0) {
 		wl1271_warning("illegal channel");
 		return -EINVAL;
@@ -280,20 +277,19 @@ static ssize_t radar_detection_write(struct file *file,
 }
 
 static const struct file_operations radar_detection_ops = {
-	.write = radar_detection_write,
+	.write_iter = radar_detection_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t dynamic_fw_traces_write(struct file *file,
-					const char __user *user_buf,
-					size_t count, loff_t *ppos)
+static ssize_t dynamic_fw_traces_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &value);
+	ret = kstrtoul_from_iter(from, count, 0, &value);
 	if (ret < 0)
 		return ret;
 
@@ -319,33 +315,29 @@ static ssize_t dynamic_fw_traces_write(struct file *file,
 	return count;
 }
 
-static ssize_t dynamic_fw_traces_read(struct file *file,
-					char __user *userbuf,
-					size_t count, loff_t *ppos)
+static ssize_t dynamic_fw_traces_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
-	return wl1271_format_buffer(userbuf, count, ppos,
-				    "%d\n", wl->dynamic_fw_traces);
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	return wl1271_format_buffer(iocb, to, "%d\n", wl->dynamic_fw_traces);
 }
 
 static const struct file_operations dynamic_fw_traces_ops = {
-	.read = dynamic_fw_traces_read,
-	.write = dynamic_fw_traces_write,
+	.read_iter = dynamic_fw_traces_read,
+	.write_iter = dynamic_fw_traces_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
 #ifdef CONFIG_CFG80211_CERTIFICATION_ONUS
-static ssize_t radar_debug_mode_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t radar_debug_mode_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wl12xx_vif *wlvif;
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	ret = kstrtoul_from_iter(from, count, 10, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal radar_debug_mode value!");
 		return -EINVAL;
@@ -381,19 +373,16 @@ static ssize_t radar_debug_mode_write(struct file *file,
 	return count;
 }
 
-static ssize_t radar_debug_mode_read(struct file *file,
-				     char __user *userbuf,
-				     size_t count, loff_t *ppos)
+static ssize_t radar_debug_mode_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 
-	return wl1271_format_buffer(userbuf, count, ppos,
-				    "%d\n", wl->radar_debug_mode);
+	return wl1271_format_buffer(iocb, to, "%d\n", wl->radar_debug_mode);
 }
 
 static const struct file_operations radar_debug_mode_ops = {
-	.write = radar_debug_mode_write,
-	.read = radar_debug_mode_read,
+	.write_iter = radar_debug_mode_write,
+	.read_iter = radar_debug_mode_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
diff --git a/drivers/net/wireless/ti/wlcore/debugfs.c b/drivers/net/wireless/ti/wlcore/debugfs.c
index eb3d3f0e0b4d..1834cc60aab7 100644
--- a/drivers/net/wireless/ti/wlcore/debugfs.c
+++ b/drivers/net/wireless/ti/wlcore/debugfs.c
@@ -28,8 +28,7 @@
 #define WLCORE_MAX_BLOCK_SIZE ((size_t)(4*PAGE_SIZE))
 
 /* debugfs macros idea from mac80211 */
-int wl1271_format_buffer(char __user *userbuf, size_t count,
-			 loff_t *ppos, char *fmt, ...)
+int wl1271_format_buffer(struct kiocb *iocb, struct iov_iter *to, char *fmt, ...)
 {
 	va_list args;
 	char buf[DEBUGFS_FORMAT_BUFFER_SIZE];
@@ -39,7 +38,7 @@ int wl1271_format_buffer(char __user *userbuf, size_t count,
 	res = vscnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, res);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);
 }
 EXPORT_SYMBOL_GPL(wl1271_format_buffer);
 
@@ -75,10 +74,9 @@ DEBUGFS_READONLY_FILE(retry_count, "%u", wl->stats.retry_count);
 DEBUGFS_READONLY_FILE(excessive_retries, "%u",
 		      wl->stats.excessive_retries);
 
-static ssize_t tx_queue_len_read(struct file *file, char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t tx_queue_len_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 	u32 queue_len;
 	char buf[20];
 	int res;
@@ -86,11 +84,11 @@ static ssize_t tx_queue_len_read(struct file *file, char __user *userbuf,
 	queue_len = wl1271_tx_total_queue_count(wl);
 
 	res = scnprintf(buf, sizeof(buf), "%u\n", queue_len);
-	return simple_read_from_buffer(userbuf, count, ppos, buf, res);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);
 }
 
 static const struct file_operations tx_queue_len_ops = {
-	.read = tx_queue_len_read,
+	.read_iter = tx_queue_len_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
@@ -120,25 +118,23 @@ static void chip_op_handler(struct wl1271 *wl, unsigned long value,
 #define WL12XX_CONF_DEBUGFS(param, conf_sub_struct,			\
 			    min_val, max_val, write_handler_locked,	\
 			    write_handler_arg)				\
-	static ssize_t param##_read(struct file *file,			\
-				      char __user *user_buf,		\
-				      size_t count, loff_t *ppos)	\
+	static ssize_t param##_read(struct kiocb *iocb,			\
+				      struct iov_iter *to)		\
 	{								\
-	struct wl1271 *wl = file->private_data;				\
-	return wl1271_format_buffer(user_buf, count,			\
-				    ppos, "%d\n",			\
-				    wl->conf.conf_sub_struct.param);	\
+	struct wl1271 *wl = iocb->ki_filp->private_data;		\
+	return wl1271_format_buffer(iocb, to, "%d\n",			\
+				wl->conf.conf_sub_struct.param);	\
 	}								\
 									\
-	static ssize_t param##_write(struct file *file,			\
-				     const char __user *user_buf,	\
-				     size_t count, loff_t *ppos)	\
+	static ssize_t param##_write(struct kiocb *iocb,		\
+				     struct iov_iter *from)		\
 	{								\
-	struct wl1271 *wl = file->private_data;				\
+	struct wl1271 *wl = iocb->ki_filp->private_data;		\
+	size_t count = iov_iter_count(from);				\
 	unsigned long value;						\
 	int ret;							\
 									\
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);		\
+	ret = kstrtoul_from_iter(from, count, 10, &value);		\
 	if (ret < 0) {							\
 		wl1271_warning("illegal value for " #param);		\
 		return -EINVAL;						\
@@ -159,8 +155,8 @@ static void chip_op_handler(struct wl1271 *wl, unsigned long value,
 	}								\
 									\
 	static const struct file_operations param##_ops = {		\
-		.read = param##_read,					\
-		.write = param##_write,					\
+		.read_iter = param##_read,				\
+		.write_iter = param##_write,				\
 		.open = simple_open,					\
 		.llseek = default_llseek,				\
 	};
@@ -172,10 +168,9 @@ WL12XX_CONF_DEBUGFS(irq_blk_threshold, rx, 0, 65535,
 WL12XX_CONF_DEBUGFS(irq_timeout, rx, 0, 100,
 		    chip_op_handler, wl1271_acx_init_rx_interrupt)
 
-static ssize_t gpio_power_read(struct file *file, char __user *user_buf,
-			  size_t count, loff_t *ppos)
+static ssize_t gpio_power_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 	bool state = test_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);
 
 	int res;
@@ -183,18 +178,17 @@ static ssize_t gpio_power_read(struct file *file, char __user *user_buf,
 
 	res = scnprintf(buf, sizeof(buf), "%d\n", state);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, res);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);
 }
 
-static ssize_t gpio_power_write(struct file *file,
-			   const char __user *user_buf,
-			   size_t count, loff_t *ppos)
+static ssize_t gpio_power_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	ret = kstrtoul_from_iter(from, count, 10, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value in gpio_power");
 		return -EINVAL;
@@ -212,51 +206,47 @@ static ssize_t gpio_power_write(struct file *file,
 }
 
 static const struct file_operations gpio_power_ops = {
-	.read = gpio_power_read,
-	.write = gpio_power_write,
+	.read_iter = gpio_power_read,
+	.write_iter = gpio_power_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t start_recovery_write(struct file *file,
-				    const char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t start_recovery_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 
 	mutex_lock(&wl->mutex);
 	wl12xx_queue_recovery_work(wl);
 	mutex_unlock(&wl->mutex);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations start_recovery_ops = {
-	.write = start_recovery_write,
+	.write_iter = start_recovery_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t dynamic_ps_timeout_read(struct file *file, char __user *user_buf,
-			  size_t count, loff_t *ppos)
+static ssize_t dynamic_ps_timeout_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 
-	return wl1271_format_buffer(user_buf, count,
-				    ppos, "%d\n",
+	return wl1271_format_buffer(iocb, to, "%d\n",
 				    wl->conf.conn.dynamic_ps_timeout);
 }
 
-static ssize_t dynamic_ps_timeout_write(struct file *file,
-				    const char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t dynamic_ps_timeout_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wl12xx_vif *wlvif;
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	ret = kstrtoul_from_iter(from, count, 10, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value in dynamic_ps");
 		return -EINVAL;
@@ -296,32 +286,29 @@ static ssize_t dynamic_ps_timeout_write(struct file *file,
 }
 
 static const struct file_operations dynamic_ps_timeout_ops = {
-	.read = dynamic_ps_timeout_read,
-	.write = dynamic_ps_timeout_write,
+	.read_iter = dynamic_ps_timeout_read,
+	.write_iter = dynamic_ps_timeout_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t forced_ps_read(struct file *file, char __user *user_buf,
-			  size_t count, loff_t *ppos)
+static ssize_t forced_ps_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 
-	return wl1271_format_buffer(user_buf, count,
-				    ppos, "%d\n",
+	return wl1271_format_buffer(iocb, to, "%d\n",
 				    wl->conf.conn.forced_ps);
 }
 
-static ssize_t forced_ps_write(struct file *file,
-				    const char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t forced_ps_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wl12xx_vif *wlvif;
 	unsigned long value;
 	int ret, ps_mode;
 
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	ret = kstrtoul_from_iter(from, count, 10, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value in forced_ps");
 		return -EINVAL;
@@ -366,31 +353,29 @@ static ssize_t forced_ps_write(struct file *file,
 }
 
 static const struct file_operations forced_ps_ops = {
-	.read = forced_ps_read,
-	.write = forced_ps_write,
+	.read_iter = forced_ps_read,
+	.write_iter = forced_ps_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t split_scan_timeout_read(struct file *file, char __user *user_buf,
-			  size_t count, loff_t *ppos)
+static ssize_t split_scan_timeout_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 
-	return wl1271_format_buffer(user_buf, count,
-				    ppos, "%d\n",
+	return wl1271_format_buffer(iocb, to, "%d\n",
 				    wl->conf.scan.split_scan_timeout / 1000);
 }
 
-static ssize_t split_scan_timeout_write(struct file *file,
-				    const char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t split_scan_timeout_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	ret = kstrtoul_from_iter(from, count, 10, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value in split_scan_timeout");
 		return -EINVAL;
@@ -408,16 +393,15 @@ static ssize_t split_scan_timeout_write(struct file *file,
 }
 
 static const struct file_operations split_scan_timeout_ops = {
-	.read = split_scan_timeout_read,
-	.write = split_scan_timeout_write,
+	.read_iter = split_scan_timeout_read,
+	.write_iter = split_scan_timeout_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t driver_state_read(struct file *file, char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t driver_state_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 	int res = 0;
 	ssize_t ret;
 	char *buf;
@@ -502,21 +486,20 @@ static ssize_t driver_state_read(struct file *file, char __user *user_buf,
 
 	mutex_unlock(&wl->mutex);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, res);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, res, to);
 	kfree(buf);
 	return ret;
 }
 
 static const struct file_operations driver_state_ops = {
-	.read = driver_state_read,
+	.read_iter = driver_state_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t vifs_state_read(struct file *file, char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t vifs_state_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 	struct wl12xx_vif *wlvif;
 	int ret, res = 0;
 	const int buf_size = 4096;
@@ -612,21 +595,20 @@ static ssize_t vifs_state_read(struct file *file, char __user *user_buf,
 
 	mutex_unlock(&wl->mutex);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, res);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, res, to);
 	kfree(buf);
 	return ret;
 }
 
 static const struct file_operations vifs_state_ops = {
-	.read = vifs_state_read,
+	.read_iter = vifs_state_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t dtim_interval_read(struct file *file, char __user *user_buf,
-				  size_t count, loff_t *ppos)
+static ssize_t dtim_interval_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 	u8 value;
 
 	if (wl->conf.conn.wake_up_event == CONF_WAKE_UP_EVENT_DTIM ||
@@ -635,18 +617,17 @@ static ssize_t dtim_interval_read(struct file *file, char __user *user_buf,
 	else
 		value = 0;
 
-	return wl1271_format_buffer(user_buf, count, ppos, "%d\n", value);
+	return wl1271_format_buffer(iocb, to, "%d\n", value);
 }
 
-static ssize_t dtim_interval_write(struct file *file,
-				   const char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t dtim_interval_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	ret = kstrtoul_from_iter(from, count, 10, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value for dtim_interval");
 		return -EINVAL;
@@ -675,19 +656,18 @@ static ssize_t dtim_interval_write(struct file *file,
 }
 
 static const struct file_operations dtim_interval_ops = {
-	.read = dtim_interval_read,
-	.write = dtim_interval_write,
+	.read_iter = dtim_interval_read,
+	.write_iter = dtim_interval_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
 
 
-static ssize_t suspend_dtim_interval_read(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t suspend_dtim_interval_read(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 	u8 value;
 
 	if (wl->conf.conn.suspend_wake_up_event == CONF_WAKE_UP_EVENT_DTIM ||
@@ -696,18 +676,18 @@ static ssize_t suspend_dtim_interval_read(struct file *file,
 	else
 		value = 0;
 
-	return wl1271_format_buffer(user_buf, count, ppos, "%d\n", value);
+	return wl1271_format_buffer(iocb, to, "%d\n", value);
 }
 
-static ssize_t suspend_dtim_interval_write(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t suspend_dtim_interval_write(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	ret = kstrtoul_from_iter(from, count, 10, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value for suspend_dtim_interval");
 		return -EINVAL;
@@ -731,18 +711,16 @@ static ssize_t suspend_dtim_interval_write(struct file *file,
 	return count;
 }
 
-
 static const struct file_operations suspend_dtim_interval_ops = {
-	.read = suspend_dtim_interval_read,
-	.write = suspend_dtim_interval_write,
+	.read_iter = suspend_dtim_interval_read,
+	.write_iter = suspend_dtim_interval_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t beacon_interval_read(struct file *file, char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t beacon_interval_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 	u8 value;
 
 	if (wl->conf.conn.wake_up_event == CONF_WAKE_UP_EVENT_BEACON ||
@@ -751,18 +729,17 @@ static ssize_t beacon_interval_read(struct file *file, char __user *user_buf,
 	else
 		value = 0;
 
-	return wl1271_format_buffer(user_buf, count, ppos, "%d\n", value);
+	return wl1271_format_buffer(iocb, to, "%d\n", value);
 }
 
-static ssize_t beacon_interval_write(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t beacon_interval_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	ret = kstrtoul_from_iter(from, count, 10, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value for beacon_interval");
 		return -EINVAL;
@@ -791,22 +768,22 @@ static ssize_t beacon_interval_write(struct file *file,
 }
 
 static const struct file_operations beacon_interval_ops = {
-	.read = beacon_interval_read,
-	.write = beacon_interval_write,
+	.read_iter = beacon_interval_read,
+	.write_iter = beacon_interval_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t rx_streaming_interval_write(struct file *file,
-			   const char __user *user_buf,
-			   size_t count, loff_t *ppos)
+static ssize_t rx_streaming_interval_write(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wl12xx_vif *wlvif;
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	ret = kstrtoul_from_iter(from, count, 10, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value in rx_streaming_interval!");
 		return -EINVAL;
@@ -837,32 +814,31 @@ static ssize_t rx_streaming_interval_write(struct file *file,
 	return count;
 }
 
-static ssize_t rx_streaming_interval_read(struct file *file,
-			    char __user *userbuf,
-			    size_t count, loff_t *ppos)
+static ssize_t rx_streaming_interval_read(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
-	return wl1271_format_buffer(userbuf, count, ppos,
-				    "%d\n", wl->conf.rx_streaming.interval);
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	return wl1271_format_buffer(iocb, to, "%d\n",
+				    wl->conf.rx_streaming.interval);
 }
 
 static const struct file_operations rx_streaming_interval_ops = {
-	.read = rx_streaming_interval_read,
-	.write = rx_streaming_interval_write,
+	.read_iter = rx_streaming_interval_read,
+	.write_iter = rx_streaming_interval_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t rx_streaming_always_write(struct file *file,
-			   const char __user *user_buf,
-			   size_t count, loff_t *ppos)
+static ssize_t rx_streaming_always_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wl12xx_vif *wlvif;
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 10, &value);
+	ret = kstrtoul_from_iter(from, count, 10, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value in rx_streaming_write!");
 		return -EINVAL;
@@ -893,32 +869,29 @@ static ssize_t rx_streaming_always_write(struct file *file,
 	return count;
 }
 
-static ssize_t rx_streaming_always_read(struct file *file,
-			    char __user *userbuf,
-			    size_t count, loff_t *ppos)
+static ssize_t rx_streaming_always_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
-	return wl1271_format_buffer(userbuf, count, ppos,
-				    "%d\n", wl->conf.rx_streaming.always);
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	return wl1271_format_buffer(iocb, to, "%d\n",
+				    wl->conf.rx_streaming.always);
 }
 
 static const struct file_operations rx_streaming_always_ops = {
-	.read = rx_streaming_always_read,
-	.write = rx_streaming_always_write,
+	.read_iter = rx_streaming_always_read,
+	.write_iter = rx_streaming_always_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t beacon_filtering_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t beacon_filtering_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wl12xx_vif *wlvif;
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &value);
+	ret = kstrtoul_from_iter(from, count, 0, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value for beacon_filtering!");
 		return -EINVAL;
@@ -942,49 +915,42 @@ static ssize_t beacon_filtering_write(struct file *file,
 }
 
 static const struct file_operations beacon_filtering_ops = {
-	.write = beacon_filtering_write,
+	.write_iter = beacon_filtering_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t fw_stats_raw_read(struct file *file,
-				 char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t fw_stats_raw_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 
 	wl1271_debugfs_update_stats(wl);
 
-	return simple_read_from_buffer(userbuf, count, ppos,
-				       wl->stats.fw_stats,
-				       wl->stats.fw_stats_len);
+	return simple_copy_to_iter(wl->stats.fw_stats, &iocb->ki_pos,
+				       wl->stats.fw_stats_len, to);
 }
 
 static const struct file_operations fw_stats_raw_ops = {
-	.read = fw_stats_raw_read,
+	.read_iter = fw_stats_raw_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t sleep_auth_read(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t sleep_auth_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 
-	return wl1271_format_buffer(user_buf, count,
-				    ppos, "%d\n",
-				    wl->sleep_auth);
+	return wl1271_format_buffer(iocb, to, "%d\n", wl->sleep_auth);
 }
 
-static ssize_t sleep_auth_write(struct file *file,
-				const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t sleep_auth_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &value);
+	ret = kstrtoul_from_iter(from, count, 0, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value in sleep_auth");
 		return -EINVAL;
@@ -1023,18 +989,17 @@ static ssize_t sleep_auth_write(struct file *file,
 }
 
 static const struct file_operations sleep_auth_ops = {
-	.read = sleep_auth_read,
-	.write = sleep_auth_write,
+	.read_iter = sleep_auth_read,
+	.write_iter = sleep_auth_write,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t dev_mem_read(struct file *file,
-	     char __user *user_buf, size_t count,
-	     loff_t *ppos)
+static ssize_t dev_mem_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 	struct wlcore_partition_set part, old_part;
+	size_t count = iov_iter_count(to);
 	size_t bytes = count;
 	int ret;
 	char *buf;
@@ -1043,7 +1008,7 @@ static ssize_t dev_mem_read(struct file *file,
 	if (bytes % 4)
 		return -EINVAL;
 
-	if (*ppos % 4)
+	if (iocb->ki_pos % 4)
 		return -EINVAL;
 
 	/* function should return in reasonable time */
@@ -1053,7 +1018,7 @@ static ssize_t dev_mem_read(struct file *file,
 		return -EINVAL;
 
 	memset(&part, 0, sizeof(part));
-	part.mem.start = *ppos;
+	part.mem.start = iocb->ki_pos;
 	part.mem.size = bytes;
 
 	buf = kmalloc(bytes, GFP_KERNEL);
@@ -1097,13 +1062,13 @@ static ssize_t dev_mem_read(struct file *file,
 	mutex_unlock(&wl->mutex);
 
 	if (ret == 0) {
-		ret = copy_to_user(user_buf, buf, bytes);
-		if (ret < bytes) {
+		ret = copy_to_iter(buf, bytes, to);
+		if (!ret) {
+			ret = -EFAULT;
+		} else {
 			bytes -= ret;
-			*ppos += bytes;
+			iocb->ki_pos += bytes;
 			ret = 0;
-		} else {
-			ret = -EFAULT;
 		}
 	}
 
@@ -1112,10 +1077,10 @@ static ssize_t dev_mem_read(struct file *file,
 	return ((ret == 0) ? bytes : ret);
 }
 
-static ssize_t dev_mem_write(struct file *file, const char __user *user_buf,
-		size_t count, loff_t *ppos)
+static ssize_t dev_mem_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct wlcore_partition_set part, old_part;
 	size_t bytes = count;
 	int ret;
@@ -1125,7 +1090,7 @@ static ssize_t dev_mem_write(struct file *file, const char __user *user_buf,
 	if (bytes % 4)
 		return -EINVAL;
 
-	if (*ppos % 4)
+	if (iocb->ki_pos % 4)
 		return -EINVAL;
 
 	/* function should return in reasonable time */
@@ -1135,10 +1100,10 @@ static ssize_t dev_mem_write(struct file *file, const char __user *user_buf,
 		return -EINVAL;
 
 	memset(&part, 0, sizeof(part));
-	part.mem.start = *ppos;
+	part.mem.start = iocb->ki_pos;
 	part.mem.size = bytes;
 
-	buf = memdup_user(user_buf, bytes);
+	buf = iterdup(from, bytes);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -1179,7 +1144,7 @@ static ssize_t dev_mem_write(struct file *file, const char __user *user_buf,
 	mutex_unlock(&wl->mutex);
 
 	if (ret == 0)
-		*ppos += bytes;
+		iocb->ki_pos += bytes;
 
 	kfree(buf);
 
@@ -1197,30 +1162,26 @@ static loff_t dev_mem_seek(struct file *file, loff_t offset, int orig)
 
 static const struct file_operations dev_mem_ops = {
 	.open = simple_open,
-	.read = dev_mem_read,
-	.write = dev_mem_write,
+	.read_iter = dev_mem_read,
+	.write_iter = dev_mem_write,
 	.llseek = dev_mem_seek,
 };
 
-static ssize_t fw_logger_read(struct file *file, char __user *user_buf,
-			      size_t count, loff_t *ppos)
+static ssize_t fw_logger_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
 
-	return wl1271_format_buffer(user_buf, count,
-					ppos, "%d\n",
-					wl->conf.fwlog.output);
+	return wl1271_format_buffer(iocb, to, "%d\n", wl->conf.fwlog.output);
 }
 
-static ssize_t fw_logger_write(struct file *file,
-			       const char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t fw_logger_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct wl1271 *wl = file->private_data;
+	struct wl1271 *wl = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long value;
 	int ret;
 
-	ret = kstrtoul_from_user(user_buf, count, 0, &value);
+	ret = kstrtoul_from_iter(from, count, 0, &value);
 	if (ret < 0) {
 		wl1271_warning("illegal value in fw_logger");
 		return -EINVAL;
@@ -1257,8 +1218,8 @@ static ssize_t fw_logger_write(struct file *file,
 
 static const struct file_operations fw_logger_ops = {
 	.open = simple_open,
-	.read = fw_logger_read,
-	.write = fw_logger_write,
+	.read_iter = fw_logger_read,
+	.write_iter = fw_logger_write,
 	.llseek = default_llseek,
 };
 
diff --git a/drivers/net/wireless/ti/wlcore/debugfs.h b/drivers/net/wireless/ti/wlcore/debugfs.h
index a9e13e6d65c5..294ac6e29c5f 100644
--- a/drivers/net/wireless/ti/wlcore/debugfs.h
+++ b/drivers/net/wireless/ti/wlcore/debugfs.h
@@ -12,8 +12,8 @@
 
 #include "wlcore.h"
 
-__printf(4, 5) int wl1271_format_buffer(char __user *userbuf, size_t count,
-					loff_t *ppos, char *fmt, ...);
+__printf(3, 4) int wl1271_format_buffer(struct kiocb *iocb, struct iov_iter *to,
+					char *fmt, ...);
 
 int wl1271_debugfs_init(struct wl1271 *wl);
 void wl1271_debugfs_exit(struct wl1271 *wl);
@@ -23,16 +23,14 @@ void wl1271_debugfs_update_stats(struct wl1271 *wl);
 #define DEBUGFS_FORMAT_BUFFER_SIZE 256
 
 #define DEBUGFS_READONLY_FILE(name, fmt, value...)			\
-static ssize_t name## _read(struct file *file, char __user *userbuf,	\
-			    size_t count, loff_t *ppos)			\
+static ssize_t name## _read(struct kiocb *iocb, struct iov_iter *to)	\
 {									\
-	struct wl1271 *wl = file->private_data;				\
-	return wl1271_format_buffer(userbuf, count, ppos,		\
-				    fmt "\n", ##value);			\
+	struct wl1271 *wl = iocb->ki_filp->private_data;		\
+	return wl1271_format_buffer(iocb, to, fmt "\n", ##value);	\
 }									\
 									\
 static const struct file_operations name## _ops = {			\
-	.read = name## _read,						\
+	.read_iter = name## _read,					\
 	.open = simple_open,						\
 	.llseek	= generic_file_llseek,					\
 };
@@ -51,31 +49,28 @@ static const struct file_operations name## _ops = {			\
 	} while (0)
 
 #define DEBUGFS_FWSTATS_FILE(sub, name, fmt, struct_type)		\
-static ssize_t sub## _ ##name## _read(struct file *file,		\
-				      char __user *userbuf,		\
-				      size_t count, loff_t *ppos)	\
+static ssize_t sub## _ ##name## _read(struct kiocb *iocb,		\
+				      struct iov_iter *to)		\
 {									\
-	struct wl1271 *wl = file->private_data;				\
+	struct wl1271 *wl = iocb->ki_filp->private_data;		\
 	struct struct_type *stats = wl->stats.fw_stats;			\
 									\
 	wl1271_debugfs_update_stats(wl);				\
 									\
-	return wl1271_format_buffer(userbuf, count, ppos, fmt "\n",	\
-				    stats->sub.name);			\
+	return wl1271_format_buffer(iocb, to, fmt "\n", stats->sub.name);\
 }									\
 									\
 static const struct file_operations sub## _ ##name## _ops = {		\
-	.read = sub## _ ##name## _read,					\
+	.read_iter = sub## _ ##name## _read,				\
 	.open = simple_open,						\
 	.llseek	= generic_file_llseek,					\
 };
 
 #define DEBUGFS_FWSTATS_FILE_ARRAY(sub, name, len, struct_type)		\
-static ssize_t sub## _ ##name## _read(struct file *file,		\
-				      char __user *userbuf,		\
-				      size_t count, loff_t *ppos)	\
+static ssize_t sub## _ ##name## _read(struct kiocb *iocb,		\
+				      struct iov_iter *to)		\
 {									\
-	struct wl1271 *wl = file->private_data;				\
+	struct wl1271 *wl = iocb->ki_filp->private_data;		\
 	struct struct_type *stats = wl->stats.fw_stats;			\
 	char buf[DEBUGFS_FORMAT_BUFFER_SIZE] = "";			\
 	int pos = 0;							\
@@ -87,11 +82,11 @@ static ssize_t sub## _ ##name## _read(struct file *file,		\
 		pos += snprintf(buf + pos, sizeof(buf) - pos,		\
 			 "[%d] = %d\n", i, stats->sub.name[i]);		\
 									\
-	return wl1271_format_buffer(userbuf, count, ppos, "%s", buf);	\
+	return wl1271_format_buffer(iocb, to, "%s", buf);		\
 }									\
 									\
 static const struct file_operations sub## _ ##name## _ops = {		\
-	.read = sub## _ ##name## _read,					\
+	.read_iter = sub## _ ##name## _read,				\
 	.open = simple_open,						\
 	.llseek	= generic_file_llseek,					\
 };
-- 
2.43.0


