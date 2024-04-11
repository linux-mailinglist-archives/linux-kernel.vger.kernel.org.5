Return-Path: <linux-kernel+bounces-141071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7102A8A1A97
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB26B31103
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA151D4F1C;
	Thu, 11 Apr 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EzEFqTzl"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAC1D4EFF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849994; cv=none; b=PP+hb/o85OtobgmJrPO7MoZKCAF3ZHWPaB0Ht6TAAuiNM/gXcttvkYdudZcis0f7z4JOTIMvTZfU6EJpH8YicoDRNJJ6qhp150uIC+einzl0z6IinZfiRkt3yAichm2XHHUPYzTV+mekIEfBeWvjAyfKilyFoEUK3ryH3PRGSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849994; c=relaxed/simple;
	bh=fwJ7khPh4ChdkEO88piUTbxHoQXcEodNw8Xfb0B3BC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qglxIAdTgqr2K7gkKhuTolWQd+tnMKhsrp0z53Ho+00fMrsGqXkv+tp5XD82Z0Fx+qDjjF45usfxm38Pe0Rt/gZB1Hb1EcfxUatxTryCb/szX7tzDXa1wRdKIxJoKffp8wA+p0I/Cutxo49AHx84s8mpd9jyyIPRbcJJV5ZSx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EzEFqTzl; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16219339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849991; x=1713454791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sY1G3WB3oWbEDWMyhadFocvPxsdClQQVjP7gxOGVYlE=;
        b=EzEFqTzlmioIKn+4V2NuZGm2fKU7s/LJNcpCV2UMzE9StFy3nMoYvWASW7XkqiHSKZ
         28nr3OXhEqF33DJOoyAYv02MvmaLAtopHodWO7/SdHF9wrohKl1pvZ/ClGHYCgS1KbCk
         Amd1vokgqn80zLYH82U78PiCEmr0SXzlzmc7y2kmC5HsPZOpl0B0/xqyjTgCYn//naHZ
         7nc6o+/Hkl3+OE9jMI69FlHhVpPRRAe/y2RqlSU1GcqGzaKAK3rlZcKwGTVp+1eJfDP4
         fJ4MrIzyqPw5Pw5ZO0j9AP4I5at6dB8lS8ObPFJu59KjhQOkdy7RrID52c+6eO0HVkgQ
         18+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849991; x=1713454791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sY1G3WB3oWbEDWMyhadFocvPxsdClQQVjP7gxOGVYlE=;
        b=lSUQrQGBPg8PonwOfnlrvaEmzAGjPcxvS8m+/w2o2cJzAmWa2Jt/UAM2z+uqCUCzLY
         y6ZBsY5SI/jMRa7srr5frt2hnvIV7KS52s34s9ZkTez5WgQuwE6Oi5NedIqinnPGpBxj
         dhmzpBUlW/91W+1nKb0AUenCnxGgPK6r7h/PjCjPEgP1SuNmQslpzlRdUHtZ/z7ikhqR
         xUGXKv9kUriHsg1mXFLZJq0mFmkMqw0hDPUmP8enLFtiG3fc7A9OAwX2bQP68r3w0cpf
         Hwb9/MDID7IYY5dyaOzRJYQpB+skugqUava2gP5pASYpaByuYQ9u3M5LFYwmprPutv35
         9jyQ==
X-Gm-Message-State: AOJu0YxQitsi4zNOvqv9ePjfiIlu26zhR3y0ji4Txt4ngYZMlAoS30Ri
	/xNTZfQK56qmWxH7nGmGN+AxckPLmABBT13acE7LlIPyQPUcwppiOIt2WQDCTPFVI8Hz96jm3zR
	N
X-Google-Smtp-Source: AGHT+IGso9ZMv8lNDU+B9K8NWTUuro6/iLrPH7TO+3/QoCJWPqBw/GGHReebqcWD5ghB7c3MWBbTnQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr196815iov.2.1712849991612;
        Thu, 11 Apr 2024 08:39:51 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 297/437] drivers/net/wireless/mediatek: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:17 -0600
Message-ID: <20240411153126.16201-298-axboe@kernel.dk>
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
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 20 ++++---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 52 +++++++++----------
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 33 ++++++------
 3 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 2a6d317db5e0..d645550bab86 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -436,11 +436,9 @@ mt7615_rf_reg_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_rf_reg, mt7615_rf_reg_get, mt7615_rf_reg_set,
 			 "0x%08llx\n");
 
-static ssize_t
-mt7615_ext_mac_addr_read(struct file *file, char __user *userbuf,
-			 size_t count, loff_t *ppos)
+static ssize_t mt7615_ext_mac_addr_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mt7615_dev *dev = file->private_data;
+	struct mt7615_dev *dev = iocb->ki_filp->private_data;
 	u32 len = 32 * ((ETH_ALEN * 3) + 4) + 1;
 	u8 addr[ETH_ALEN];
 	char *buf;
@@ -464,17 +462,17 @@ mt7615_ext_mac_addr_read(struct file *file, char __user *userbuf,
 		ofs += snprintf(buf + ofs, len - ofs, "%d=%pM\n", i, addr);
 	}
 
-	ofs = simple_read_from_buffer(userbuf, count, ppos, buf, ofs);
+	ofs = simple_copy_to_iter(buf, &iocb->ki_pos, ofs, to);
 
 	kfree(buf);
 	return ofs;
 }
 
 static ssize_t
-mt7615_ext_mac_addr_write(struct file *file, const char __user *userbuf,
-			  size_t count, loff_t *ppos)
+mt7615_ext_mac_addr_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mt7615_dev *dev = file->private_data;
+	struct mt7615_dev *dev = iocb->ki_filp->private_data;;
+	size_t count = iov_iter_count(from);
 	unsigned long idx = 0;
 	u8 addr[ETH_ALEN];
 	char buf[32];
@@ -483,7 +481,7 @@ mt7615_ext_mac_addr_write(struct file *file, const char __user *userbuf,
 	if (count > sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	buf[sizeof(buf) - 1] = '\0';
@@ -526,8 +524,8 @@ mt7615_ext_mac_addr_write(struct file *file, const char __user *userbuf,
 static const struct file_operations fops_ext_mac_addr = {
 	.open = simple_open,
 	.llseek = generic_file_llseek,
-	.read = mt7615_ext_mac_addr_read,
-	.write = mt7615_ext_mac_addr_write,
+	.read_iter = mt7615_ext_mac_addr_read,
+	.write_iter = mt7615_ext_mac_addr_write,
 	.owner = THIS_MODULE,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 6c3696c8c700..66ffdd915bc5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -46,10 +46,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7915_implicit_txbf_get,
 
 /* test knob of system error recovery */
 static ssize_t
-mt7915_sys_recovery_set(struct file *file, const char __user *user_buf,
-			size_t count, loff_t *ppos)
+mt7915_sys_recovery_set(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mt7915_phy *phy = file->private_data;
+	struct mt7915_phy *phy = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct mt7915_dev *dev = phy->dev;
 	bool band = phy->mt76->band_idx;
 	char buf[16];
@@ -59,7 +59,7 @@ mt7915_sys_recovery_set(struct file *file, const char __user *user_buf,
 	if (count >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	if (count && buf[count - 1] == '\n')
@@ -121,11 +121,9 @@ mt7915_sys_recovery_set(struct file *file, const char __user *user_buf,
 	return ret ? ret : count;
 }
 
-static ssize_t
-mt7915_sys_recovery_get(struct file *file, char __user *user_buf,
-			size_t count, loff_t *ppos)
+static ssize_t mt7915_sys_recovery_get(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mt7915_phy *phy = file->private_data;
+	struct mt7915_phy *phy = iocb->ki_filp->private_data;
 	struct mt7915_dev *dev = phy->dev;
 	char *buff;
 	int desc = 0;
@@ -196,14 +194,14 @@ mt7915_sys_recovery_get(struct file *file, char __user *user_buf,
 			  dev->recovery.wm_reset_count,
 			  dev->recovery.wa_reset_count);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 	kfree(buff);
 	return ret;
 }
 
 static const struct file_operations mt7915_sys_recovery_ops = {
-	.write = mt7915_sys_recovery_set,
-	.read = mt7915_sys_recovery_get,
+	.write_iter = mt7915_sys_recovery_set,
+	.read_iter = mt7915_sys_recovery_get,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
@@ -968,11 +966,9 @@ DEFINE_SHOW_ATTRIBUTE(mt7915_xmit_queues);
 	}							\
 })
 
-static ssize_t
-mt7915_rate_txpower_get(struct file *file, char __user *user_buf,
-			size_t count, loff_t *ppos)
+static ssize_t mt7915_rate_txpower_get(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mt7915_phy *phy = file->private_data;
+	struct mt7915_phy *phy = iocb->ki_filp->private_data;
 	struct mt7915_dev *dev = phy->dev;
 	s8 txpwr[MT7915_SKU_RATE_NUM];
 	static const size_t sz = 2048;
@@ -1038,7 +1034,7 @@ mt7915_rate_txpower_get(struct file *file, char __user *user_buf,
 	len += scnprintf(buf + len, sz - len, "\nTx power (bbp)  : %6ld\n",
 			 mt76_get_field(dev, reg, MT_WF_PHY_TPC_POWER));
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 out:
 	kfree(buf);
@@ -1046,10 +1042,10 @@ mt7915_rate_txpower_get(struct file *file, char __user *user_buf,
 }
 
 static ssize_t
-mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
-			size_t count, loff_t *ppos)
+mt7915_rate_txpower_set(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mt7915_phy *phy = file->private_data;
+	struct mt7915_phy *phy = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct mt7915_dev *dev = phy->dev;
 	struct mt76_phy *mphy = phy->mt76;
 	struct mt7915_mcu_txpower_sku req = {
@@ -1064,7 +1060,7 @@ mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 	if (count >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	if (count && buf[count - 1] == '\n')
@@ -1139,8 +1135,8 @@ mt7915_rate_txpower_set(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations mt7915_rate_txpower_fops = {
-	.write = mt7915_rate_txpower_set,
-	.read = mt7915_rate_txpower_get,
+	.write_iter = mt7915_rate_txpower_set,
+	.read_iter = mt7915_rate_txpower_get,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1311,13 +1307,13 @@ bool mt7915_debugfs_rx_log(struct mt7915_dev *dev, const void *data, int len)
 #ifdef CONFIG_MAC80211_DEBUGFS
 /** per-station debugfs **/
 
-static ssize_t mt7915_sta_fixed_rate_set(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t mt7915_sta_fixed_rate_set(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
 	struct mt7915_dev *dev = msta->vif->phy->dev;
+	size_t count = iov_iter_count(from);
 	struct ieee80211_vif *vif;
 	struct sta_phy phy = {};
 	char buf[100];
@@ -1328,7 +1324,7 @@ static ssize_t mt7915_sta_fixed_rate_set(struct file *file,
 	if (count >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	if (count && buf[count - 1] == '\n')
@@ -1371,7 +1367,7 @@ static ssize_t mt7915_sta_fixed_rate_set(struct file *file,
 }
 
 static const struct file_operations fops_fixed_rate = {
-	.write = mt7915_sta_fixed_rate_set,
+	.write_iter = mt7915_sta_fixed_rate_set,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 9bd953586b04..afd8a6623b9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -47,11 +47,10 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7996_implicit_txbf_get,
 			 mt7996_implicit_txbf_set, "%lld\n");
 
 /* test knob of system error recovery */
-static ssize_t
-mt7996_sys_recovery_set(struct file *file, const char __user *user_buf,
-			size_t count, loff_t *ppos)
+static ssize_t mt7996_sys_recovery_set(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mt7996_phy *phy = file->private_data;
+	struct mt7996_phy *phy = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct mt7996_dev *dev = phy->dev;
 	bool band = phy->mt76->band_idx;
 	char buf[16];
@@ -61,7 +60,7 @@ mt7996_sys_recovery_set(struct file *file, const char __user *user_buf,
 	if (count >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	if (count && buf[count - 1] == '\n')
@@ -122,11 +121,9 @@ mt7996_sys_recovery_set(struct file *file, const char __user *user_buf,
 	return ret ? ret : count;
 }
 
-static ssize_t
-mt7996_sys_recovery_get(struct file *file, char __user *user_buf,
-			size_t count, loff_t *ppos)
+static ssize_t mt7996_sys_recovery_get(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mt7996_phy *phy = file->private_data;
+	struct mt7996_phy *phy = iocb->ki_filp->private_data;
 	struct mt7996_dev *dev = phy->dev;
 	char *buff;
 	int desc = 0;
@@ -205,14 +202,14 @@ mt7996_sys_recovery_get(struct file *file, char __user *user_buf,
 			  dev->recovery.wm_reset_count,
 			  dev->recovery.wa_reset_count);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buff, desc);
+	ret = simple_copy_to_iter(buff, &iocb->ki_pos, desc, to);
 	kfree(buff);
 	return ret;
 }
 
 static const struct file_operations mt7996_sys_recovery_ops = {
-	.write = mt7996_sys_recovery_set,
-	.read = mt7996_sys_recovery_get,
+	.write_iter = mt7996_sys_recovery_set,
+	.read_iter = mt7996_sys_recovery_get,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
@@ -886,15 +883,15 @@ bool mt7996_debugfs_rx_log(struct mt7996_dev *dev, const void *data, int len)
 #ifdef CONFIG_MAC80211_DEBUGFS
 /** per-station debugfs **/
 
-static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
-					 const char __user *user_buf,
-					 size_t count, loff_t *ppos)
+static ssize_t mt7996_sta_fixed_rate_set(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
 #define SHORT_PREAMBLE 0
 #define LONG_PREAMBLE 1
-	struct ieee80211_sta *sta = file->private_data;
+	struct ieee80211_sta *sta = iocb->ki_filp->private_data;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct mt7996_dev *dev = msta->vif->phy->dev;
+	size_t count = iov_iter_count(from);
 	struct ra_rate phy = {};
 	char buf[100];
 	int ret;
@@ -903,7 +900,7 @@ static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
 	if (count >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	if (count && buf[count - 1] == '\n')
@@ -944,7 +941,7 @@ static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
 }
 
 static const struct file_operations fops_fixed_rate = {
-	.write = mt7996_sta_fixed_rate_set,
+	.write_iter = mt7996_sta_fixed_rate_set,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
-- 
2.43.0


