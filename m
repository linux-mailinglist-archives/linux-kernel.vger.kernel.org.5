Return-Path: <linux-kernel+bounces-141065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8759E8A1A54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90491C223BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275001D42A9;
	Thu, 11 Apr 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YwVB9E41"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971A1D370B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849987; cv=none; b=PC8I2WqsM1p0DFQzyEKLDOskXOEv6UKx0mFJupxjTjdzeoun812whXSRp6Dfbg0G0mP3se/iEhr8bvpO3JCoik2il5RF9Q7134NW7hFHkU9IV+dI7wETPCEeP7vvtABlpEWPgUAQWiniEonKH3MyEDlOPAMShEOQB+03/HLshJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849987; c=relaxed/simple;
	bh=JEwIyhrb4B8Cd4P3gfUy6BSaexYaYBtcvRp4BZDhVh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp4UkqhIV3x5tGQdl4C14Da417Joh3TFJLNHPpHsXt2FYg9KQwGqOW5iTbKz9beh30ZJBSFA1N7f1KXe6FW9Yvda4yHJyyBUPoTrgRmwCEMeeTxEBHWhglyqODzSSYku4Og+BzWIFebr0QpMtJeK14ixa1nR9ATelx4VS1P+b0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YwVB9E41; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36a34b68277so116875ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849983; x=1713454783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwr1GPSeZp0pZoSE/EKWdcZh0vh8v5dKr9MrE/elW1Y=;
        b=YwVB9E412SdDCsaC6PZuz0RsQmG+pWlpJYJsjnm+mKhNY5lYcj2MEhIdbnQ08e8yqM
         moqi2IGcXs2xF0VBZyUgI+rSVVJwF6MAaojQU/NAC88EhCkrpYtA2D288waMtuHouQ47
         gyrOYsQ9cqGsRZGeFEYB0fTcv0tTwkQrZG8wg7dr+yRKxSVq78W/Hosn3CvXvtEuBbR1
         SKEw6c9hw1WP32EayKfolObIcgAglElIrq4jz4bMTVWGS8X0gcL8N/NJS0zrt+blTMbL
         ZaaB0fJNLudfMx9khX9WLFqTUh9QLk/SZR4qwBlmyc/fH7Cs0TymvAiW657rEbZE9fGB
         dgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849983; x=1713454783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwr1GPSeZp0pZoSE/EKWdcZh0vh8v5dKr9MrE/elW1Y=;
        b=DnW+PvFXxajxziZO0KgkCQ2UHHt2/kQEVEpqDHLo1geRzX6Xw5YNeWDfOf5yzq+m4q
         4owowEgZboEt5nTOqt8h/KLc+qAu2ad7J+voij7+7SO+YOX9itPl2kQ4hqyZQFAKZPa0
         7LWI9tEEARw/y6in77zn3+tNLcLg6HdddYtkpd1zllk55hjFxvdUrfShApOJx5pgHOtS
         XiSfRV6/0V2jeNB4tU3l9C71+39Njpf9l5bq9lGqKhOcRqr6p/N47/pAYL4cMjYiKDLU
         adUUP4yI2epR3lhj27/1RL7yFHAuZe+0ai4dDbQvy4KeVvDlmkGAaoE0um05npKua4u9
         7GNw==
X-Gm-Message-State: AOJu0Ywk1gj5z+Pzl+Zqe4sifk8YI4FHsuipigsXb0uCnbULQgEFqi7q
	MT0ATHi5BNKvEJtCz2XLvGkkvmkfJVVnwvcHc9ve8ahgrdxRS0g0pc7dd9xGk1tMDF3unF17nQU
	1
X-Google-Smtp-Source: AGHT+IHDVyjlOOFDURMMfBAsRqBh3DkIfNQnR2+QmQbTCQBCqsR0uUxeefJ/nOi5jUgJQGsgxE/2CA==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr157399ioc.2.1712849983189;
        Thu, 11 Apr 2024 08:39:43 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 291/437] drivers/net/wireless/marvell: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:11 -0600
Message-ID: <20240411153126.16201-292-axboe@kernel.dk>
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
 .../net/wireless/marvell/libertas/debugfs.c   | 242 +++++++-----------
 .../net/wireless/marvell/mwifiex/debugfs.c    | 183 ++++++-------
 2 files changed, 172 insertions(+), 253 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/debugfs.c b/drivers/net/wireless/marvell/libertas/debugfs.c
index c604613ab506..0a5a2084b0d6 100644
--- a/drivers/net/wireless/marvell/libertas/debugfs.c
+++ b/drivers/net/wireless/marvell/libertas/debugfs.c
@@ -22,18 +22,16 @@ static char *szStates[] = {
 static void lbs_debug_init(struct lbs_private *priv);
 #endif
 
-static ssize_t write_file_dummy(struct file *file, const char __user *buf,
-                                size_t count, loff_t *ppos)
+static ssize_t write_file_dummy(struct kiocb *iocb, struct iov_iter *from)
 {
         return -EINVAL;
 }
 
 static const size_t len = PAGE_SIZE;
 
-static ssize_t lbs_dev_info(struct file *file, char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t lbs_dev_info(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
 	size_t pos = 0;
 	unsigned long addr = get_zeroed_page(GFP_KERNEL);
 	char *buf = (char *)addr;
@@ -46,23 +44,22 @@ static ssize_t lbs_dev_info(struct file *file, char __user *userbuf,
 	pos += snprintf(buf+pos, len-pos, "region_code = %02x\n",
 				(u32) priv->regioncode);
 
-	res = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
+	res = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 
 	free_page(addr);
 	return res;
 }
 
-static ssize_t lbs_sleepparams_write(struct file *file,
-				const char __user *user_buf, size_t count,
-				loff_t *ppos)
+static ssize_t lbs_sleepparams_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t ret;
 	struct sleep_params sp;
 	int p1, p2, p3, p4, p5, p6;
 	char *buf;
 
-	buf = memdup_user_nul(user_buf, min(count, len - 1));
+	buf = iterdup_nul(from, min(count, len - 1));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -89,10 +86,9 @@ static ssize_t lbs_sleepparams_write(struct file *file,
 	return ret;
 }
 
-static ssize_t lbs_sleepparams_read(struct file *file, char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t lbs_sleepparams_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
 	ssize_t ret;
 	size_t pos = 0;
 	struct sleep_params sp;
@@ -110,23 +106,22 @@ static ssize_t lbs_sleepparams_read(struct file *file, char __user *userbuf,
 			sp.sp_calcontrol, sp.sp_extsleepclk,
 			sp.sp_reserved);
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 
 out_unlock:
 	free_page(addr);
 	return ret;
 }
 
-static ssize_t lbs_host_sleep_write(struct file *file,
-				const char __user *user_buf, size_t count,
-				loff_t *ppos)
+static ssize_t lbs_host_sleep_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t ret;
 	int host_sleep;
 	char *buf;
 
-	buf = memdup_user_nul(user_buf, min(count, len - 1));
+	buf = iterdup_nul(from, min(count, len - 1));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -159,10 +154,9 @@ static ssize_t lbs_host_sleep_write(struct file *file,
 	return ret;
 }
 
-static ssize_t lbs_host_sleep_read(struct file *file, char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t lbs_host_sleep_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
 	ssize_t ret;
 	size_t pos = 0;
 	unsigned long addr = get_zeroed_page(GFP_KERNEL);
@@ -172,7 +166,7 @@ static ssize_t lbs_host_sleep_read(struct file *file, char __user *userbuf,
 
 	pos += snprintf(buf, len, "%d\n", priv->is_host_sleep_activated);
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 
 	free_page(addr);
 	return ret;
@@ -215,12 +209,11 @@ static void *lbs_tlv_find(uint16_t tlv_type, const uint8_t *tlv, uint16_t size)
 
 
 static ssize_t lbs_threshold_read(uint16_t tlv_type, uint16_t event_mask,
-				  struct file *file, char __user *userbuf,
-				  size_t count, loff_t *ppos)
+				  struct kiocb *iocb, struct iov_iter *to)
 {
 	struct cmd_ds_802_11_subscribe_event *subscribed;
 	struct mrvl_ie_thresholds *got;
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
 	ssize_t ret = 0;
 	size_t pos = 0;
 	char *buf;
@@ -255,7 +248,7 @@ static ssize_t lbs_threshold_read(uint16_t tlv_type, uint16_t event_mask,
 				!!(events & event_mask));
 	}
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 
  out_cmd:
 	kfree(subscribed);
@@ -267,19 +260,18 @@ static ssize_t lbs_threshold_read(uint16_t tlv_type, uint16_t event_mask,
 
 
 static ssize_t lbs_threshold_write(uint16_t tlv_type, uint16_t event_mask,
-				   struct file *file,
-				   const char __user *userbuf, size_t count,
-				   loff_t *ppos)
+				   struct kiocb *iocb, struct iov_iter *from)
 {
 	struct cmd_ds_802_11_subscribe_event *events;
 	struct mrvl_ie_thresholds *tlv;
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int value, freq, new_mask;
 	uint16_t curr_mask;
 	char *buf;
 	int ret;
 
-	buf = memdup_user_nul(userbuf, min(count, len - 1));
+	buf = iterdup_nul(from, min(count, len - 1));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -335,105 +327,81 @@ static ssize_t lbs_threshold_write(uint16_t tlv_type, uint16_t event_mask,
 }
 
 
-static ssize_t lbs_lowrssi_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t lbs_lowrssi_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return lbs_threshold_read(TLV_TYPE_RSSI_LOW, CMD_SUBSCRIBE_RSSI_LOW,
-				  file, userbuf, count, ppos);
+				  iocb, to);
 }
 
-
-static ssize_t lbs_lowrssi_write(struct file *file, const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t lbs_lowrssi_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return lbs_threshold_write(TLV_TYPE_RSSI_LOW, CMD_SUBSCRIBE_RSSI_LOW,
-				   file, userbuf, count, ppos);
+				   iocb, from);
 }
 
-
-static ssize_t lbs_lowsnr_read(struct file *file, char __user *userbuf,
-			       size_t count, loff_t *ppos)
+static ssize_t lbs_lowsnr_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return lbs_threshold_read(TLV_TYPE_SNR_LOW, CMD_SUBSCRIBE_SNR_LOW,
-				  file, userbuf, count, ppos);
+				  iocb, to);
 }
 
-
-static ssize_t lbs_lowsnr_write(struct file *file, const char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t lbs_lowsnr_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return lbs_threshold_write(TLV_TYPE_SNR_LOW, CMD_SUBSCRIBE_SNR_LOW,
-				   file, userbuf, count, ppos);
+				   iocb, from);
 }
 
-
-static ssize_t lbs_failcount_read(struct file *file, char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t lbs_failcount_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return lbs_threshold_read(TLV_TYPE_FAILCOUNT, CMD_SUBSCRIBE_FAILCOUNT,
-				  file, userbuf, count, ppos);
+				  iocb, to);
 }
 
-
-static ssize_t lbs_failcount_write(struct file *file, const char __user *userbuf,
-				   size_t count, loff_t *ppos)
+static ssize_t lbs_failcount_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return lbs_threshold_write(TLV_TYPE_FAILCOUNT, CMD_SUBSCRIBE_FAILCOUNT,
-				   file, userbuf, count, ppos);
+				   iocb, from);
 }
 
-
-static ssize_t lbs_highrssi_read(struct file *file, char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t lbs_highrssi_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return lbs_threshold_read(TLV_TYPE_RSSI_HIGH, CMD_SUBSCRIBE_RSSI_HIGH,
-				  file, userbuf, count, ppos);
+				  iocb, to);
 }
 
-
-static ssize_t lbs_highrssi_write(struct file *file, const char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t lbs_highrssi_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return lbs_threshold_write(TLV_TYPE_RSSI_HIGH, CMD_SUBSCRIBE_RSSI_HIGH,
-				   file, userbuf, count, ppos);
+				   iocb, from);
 }
 
-
-static ssize_t lbs_highsnr_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t lbs_highsnr_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return lbs_threshold_read(TLV_TYPE_SNR_HIGH, CMD_SUBSCRIBE_SNR_HIGH,
-				  file, userbuf, count, ppos);
+				  iocb, to);
 }
 
-
-static ssize_t lbs_highsnr_write(struct file *file, const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t lbs_highsnr_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return lbs_threshold_write(TLV_TYPE_SNR_HIGH, CMD_SUBSCRIBE_SNR_HIGH,
-				   file, userbuf, count, ppos);
+				   iocb, from);
 }
 
-static ssize_t lbs_bcnmiss_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t lbs_bcnmiss_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return lbs_threshold_read(TLV_TYPE_BCNMISS, CMD_SUBSCRIBE_BCNMISS,
-				  file, userbuf, count, ppos);
+				  iocb, to);
 }
 
-
-static ssize_t lbs_bcnmiss_write(struct file *file, const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t lbs_bcnmiss_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return lbs_threshold_write(TLV_TYPE_BCNMISS, CMD_SUBSCRIBE_BCNMISS,
-				   file, userbuf, count, ppos);
+				   iocb, from);
 }
 
-
-static ssize_t lbs_rdmac_read(struct file *file, char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t lbs_rdmac_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
 	ssize_t pos = 0;
 	int ret;
 	unsigned long addr = get_zeroed_page(GFP_KERNEL);
@@ -448,20 +416,19 @@ static ssize_t lbs_rdmac_read(struct file *file, char __user *userbuf,
 	if (!ret) {
 		pos = snprintf(buf, len, "MAC[0x%x] = 0x%08x\n",
 				priv->mac_offset, val);
-		ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
+		ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	}
 	free_page(addr);
 	return ret;
 }
 
-static ssize_t lbs_rdmac_write(struct file *file,
-				    const char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static ssize_t lbs_rdmac_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char *buf;
 
-	buf = memdup_user_nul(userbuf, min(count, len - 1));
+	buf = iterdup_nul(from, min(count, len - 1));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -470,17 +437,15 @@ static ssize_t lbs_rdmac_write(struct file *file,
 	return count;
 }
 
-static ssize_t lbs_wrmac_write(struct file *file,
-				    const char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static ssize_t lbs_wrmac_write(struct kiocb *iocb, struct iov_iter *from)
 {
-
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t res;
 	u32 offset, value;
 	char *buf;
 
-	buf = memdup_user_nul(userbuf, min(count, len - 1));
+	buf = iterdup_nul(from, min(count, len - 1));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -500,10 +465,9 @@ static ssize_t lbs_wrmac_write(struct file *file,
 	return res;
 }
 
-static ssize_t lbs_rdbbp_read(struct file *file, char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t lbs_rdbbp_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
 	ssize_t pos = 0;
 	int ret;
 	unsigned long addr = get_zeroed_page(GFP_KERNEL);
@@ -518,21 +482,20 @@ static ssize_t lbs_rdbbp_read(struct file *file, char __user *userbuf,
 	if (!ret) {
 		pos = snprintf(buf, len, "BBP[0x%x] = 0x%08x\n",
 				priv->bbp_offset, val);
-		ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
+		ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	}
 	free_page(addr);
 
 	return ret;
 }
 
-static ssize_t lbs_rdbbp_write(struct file *file,
-				    const char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static ssize_t lbs_rdbbp_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char *buf;
 
-	buf = memdup_user_nul(userbuf, min(count, len - 1));
+	buf = iterdup_nul(from, min(count, len - 1));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -542,17 +505,15 @@ static ssize_t lbs_rdbbp_write(struct file *file,
 	return count;
 }
 
-static ssize_t lbs_wrbbp_write(struct file *file,
-				    const char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static ssize_t lbs_wrbbp_write(struct kiocb *iocb, struct iov_iter *from)
 {
-
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t res;
 	u32 offset, value;
 	char *buf;
 
-	buf = memdup_user_nul(userbuf, min(count, len - 1));
+	buf = iterdup_nul(from, min(count, len - 1));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -572,10 +533,9 @@ static ssize_t lbs_wrbbp_write(struct file *file,
 	return res;
 }
 
-static ssize_t lbs_rdrf_read(struct file *file, char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t lbs_rdrf_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
 	ssize_t pos = 0;
 	int ret;
 	unsigned long addr = get_zeroed_page(GFP_KERNEL);
@@ -590,21 +550,20 @@ static ssize_t lbs_rdrf_read(struct file *file, char __user *userbuf,
 	if (!ret) {
 		pos = snprintf(buf, len, "RF[0x%x] = 0x%08x\n",
 				priv->rf_offset, val);
-		ret = simple_read_from_buffer(userbuf, count, ppos, buf, pos);
+		ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 	}
 	free_page(addr);
 
 	return ret;
 }
 
-static ssize_t lbs_rdrf_write(struct file *file,
-				    const char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static ssize_t lbs_rdrf_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char *buf;
 
-	buf = memdup_user_nul(userbuf, min(count, len - 1));
+	buf = iterdup_nul(from, min(count, len - 1));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -613,17 +572,15 @@ static ssize_t lbs_rdrf_write(struct file *file,
 	return count;
 }
 
-static ssize_t lbs_wrrf_write(struct file *file,
-				    const char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static ssize_t lbs_wrrf_write(struct kiocb *iocb, struct iov_iter *from)
 {
-
-	struct lbs_private *priv = file->private_data;
+	struct lbs_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t res;
 	u32 offset, value;
 	char *buf;
 
-	buf = memdup_user_nul(userbuf, min(count, len - 1));
+	buf = iterdup_nul(from, min(count, len - 1));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -646,8 +603,8 @@ static ssize_t lbs_wrrf_write(struct file *file,
 #define FOPS(fread, fwrite) { \
 	.owner = THIS_MODULE, \
 	.open = simple_open, \
-	.read = (fread), \
-	.write = (fwrite), \
+	.read_iter = (fread), \
+	.write_iter = (fwrite), \
 	.llseek = generic_file_llseek, \
 }
 
@@ -796,15 +753,12 @@ static int num_of_items = ARRAY_SIZE(items);
 /**
  * lbs_debugfs_read - proc read function
  *
- * @file:	file to read
- * @userbuf:	pointer to buffer
- * @count:	number of bytes to read
- * @ppos:	read data starting position
+ * @iocb:	metadata for IO
+ * @to:		iov_iter to copy to
  *
  * returns:	amount of data read or negative error code
  */
-static ssize_t lbs_debugfs_read(struct file *file, char __user *userbuf,
-			size_t count, loff_t *ppos)
+static ssize_t lbs_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int val = 0;
 	size_t pos = 0;
@@ -819,7 +773,7 @@ static ssize_t lbs_debugfs_read(struct file *file, char __user *userbuf,
 
 	p = buf;
 
-	d = file->private_data;
+	d = iocb->ki_filp->private_data;
 
 	for (i = 0; i < num_of_items; i++) {
 		if (d[i].size == 1)
@@ -834,7 +788,7 @@ static ssize_t lbs_debugfs_read(struct file *file, char __user *userbuf,
 		pos += sprintf(p + pos, "%s=%d\n", d[i].name, val);
 	}
 
-	res = simple_read_from_buffer(userbuf, count, ppos, p, pos);
+	res = simple_copy_to_iter(p, &iocb->ki_pos, pos, to);
 
 	free_page(addr);
 	return res;
@@ -843,28 +797,26 @@ static ssize_t lbs_debugfs_read(struct file *file, char __user *userbuf,
 /**
  * lbs_debugfs_write - proc write function
  *
- * @f:		file pointer
- * @buf:	pointer to data buffer
- * @cnt:	data number to write
- * @ppos:	file position
+ * @iocb:	metadata for IO
+ * @from:	iov_iter to cooy from
  *
  * returns:	amount of data written
  */
-static ssize_t lbs_debugfs_write(struct file *f, const char __user *buf,
-			    size_t cnt, loff_t *ppos)
+static ssize_t lbs_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t cnt = iov_iter_count(from);
 	int r, i;
 	char *pdata;
 	char *p;
 	char *p0;
 	char *p1;
 	char *p2;
-	struct debug_data *d = f->private_data;
+	struct debug_data *d = iocb->ki_filp->private_data;
 
 	if (cnt == 0)
 		return 0;
 
-	pdata = memdup_user_nul(buf, cnt);
+	pdata = iterdup_nul(from, cnt);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 
@@ -902,8 +854,8 @@ static ssize_t lbs_debugfs_write(struct file *f, const char __user *buf,
 static const struct file_operations lbs_debug_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = lbs_debugfs_write,
-	.read = lbs_debugfs_read,
+	.write_iter = lbs_debugfs_write,
+	.read_iter = lbs_debugfs_read,
 	.llseek = default_llseek,
 };
 
diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 9deaf59dcb62..ad94780582e2 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -58,12 +58,9 @@ static char *bss_modes[] = {
  *      - Multicast count
  *      - Multicast addresses
  */
-static ssize_t
-mwifiex_info_read(struct file *file, char __user *ubuf,
-		  size_t count, loff_t *ppos)
+static ssize_t mwifiex_info_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mwifiex_private *priv =
-		(struct mwifiex_private *) file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	struct net_device *netdev = priv->netdev;
 	struct netdev_hw_addr *ha;
 	struct netdev_queue *txq;
@@ -133,8 +130,8 @@ mwifiex_info_read(struct file *file, char __user *ubuf,
 	}
 	p += sprintf(p, "\n");
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, (char *) page,
-				      (unsigned long) p - page);
+	ret = simple_copy_to_iter((char *) page, &iocb->ki_pos,
+				      (unsigned long) p - page, to);
 
 free_and_exit:
 	free_page(page);
@@ -162,12 +159,9 @@ mwifiex_info_read(struct file *file, char __user *ubuf,
  *      - Number of received beacons
  *      - Number of missed beacons
  */
-static ssize_t
-mwifiex_getlog_read(struct file *file, char __user *ubuf,
-		    size_t count, loff_t *ppos)
+static ssize_t mwifiex_getlog_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mwifiex_private *priv =
-		(struct mwifiex_private *) file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	unsigned long page = get_zeroed_page(GFP_KERNEL);
 	char *p = (char *) page;
 	ssize_t ret;
@@ -220,8 +214,8 @@ mwifiex_getlog_read(struct file *file, char __user *ubuf,
 		     stats.bcn_miss_cnt);
 
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, (char *) page,
-				      (unsigned long) p - page);
+	ret = simple_copy_to_iter((char *) page, &iocb->ki_pos,
+				      (unsigned long) p - page, to);
 
 free_and_exit:
 	free_page(page);
@@ -238,12 +232,9 @@ mwifiex_getlog_read(struct file *file, char __user *ubuf,
  *      - Receive packet number of each nosie_flr
  *      - Receive packet number of each signal streath
  */
-static ssize_t
-mwifiex_histogram_read(struct file *file, char __user *ubuf,
-		       size_t count, loff_t *ppos)
+static ssize_t mwifiex_histogram_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mwifiex_private *priv =
-		(struct mwifiex_private *)file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	ssize_t ret;
 	struct mwifiex_histogram_data *phist_data;
 	int i, value;
@@ -309,8 +300,8 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 				i, value);
 	}
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
-				      (unsigned long)p - page);
+	ret = simple_copy_to_iter((char *)page, &iocb->ki_pos,
+				      (unsigned long)p - page, to);
 
 free_and_exit:
 	free_page(page);
@@ -318,10 +309,9 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 }
 
 static ssize_t
-mwifiex_histogram_write(struct file *file, const char __user *ubuf,
-			size_t count, loff_t *ppos)
+mwifiex_histogram_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mwifiex_private *priv = (void *)file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 
 	if (priv && priv->hist_data)
 		mwifiex_hist_data_reset(priv);
@@ -377,12 +367,9 @@ static struct mwifiex_debug_info info;
  *      - Tx BA stream table (TID, RA)
  *      - Rx reorder table (TID, TA, Start window, Window size, Buffer)
  */
-static ssize_t
-mwifiex_debug_read(struct file *file, char __user *ubuf,
-		   size_t count, loff_t *ppos)
+static ssize_t mwifiex_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mwifiex_private *priv =
-		(struct mwifiex_private *) file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	unsigned long page = get_zeroed_page(GFP_KERNEL);
 	char *p = (char *) page;
 	ssize_t ret;
@@ -396,8 +383,8 @@ mwifiex_debug_read(struct file *file, char __user *ubuf,
 
 	p += mwifiex_debug_info_to_buffer(priv, p, &info);
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, (char *) page,
-				      (unsigned long) p - page);
+	ret = simple_copy_to_iter((char *) page, &iocb->ki_pos,
+				      (unsigned long) p - page, to);
 
 free_and_exit:
 	free_page(page);
@@ -414,14 +401,14 @@ static u32 saved_reg_type, saved_reg_offset, saved_reg_value;
  * This function can be used to write to a register.
  */
 static ssize_t
-mwifiex_regrdwr_write(struct file *file,
-		      const char __user *ubuf, size_t count, loff_t *ppos)
+mwifiex_regrdwr_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char *buf;
 	int ret;
 	u32 reg_type = 0, reg_offset = 0, reg_value = UINT_MAX;
+	size_t count = iov_iter_count(from);
 
-	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	buf = iterdup_nul(from, min(count, (size_t)(PAGE_SIZE - 1)));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -451,12 +438,9 @@ mwifiex_regrdwr_write(struct file *file,
  *
  * This function can be used to read from a register.
  */
-static ssize_t
-mwifiex_regrdwr_read(struct file *file, char __user *ubuf,
-		     size_t count, loff_t *ppos)
+static ssize_t mwifiex_regrdwr_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mwifiex_private *priv =
-		(struct mwifiex_private *) file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	unsigned long addr = get_zeroed_page(GFP_KERNEL);
 	char *buf = (char *) addr;
 	int pos = 0, ret = 0;
@@ -479,7 +463,7 @@ mwifiex_regrdwr_read(struct file *file, char __user *ubuf,
 				saved_reg_type, saved_reg_offset,
 				saved_reg_value);
 
-		ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+		ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 
 		goto done;
 	}
@@ -494,7 +478,7 @@ mwifiex_regrdwr_read(struct file *file, char __user *ubuf,
 	pos += snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n", saved_reg_type,
 			saved_reg_offset, reg_value);
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 
 done:
 	free_page(addr);
@@ -506,11 +490,9 @@ mwifiex_regrdwr_read(struct file *file, char __user *ubuf,
  * This function can be used read driver debugging mask value.
  */
 static ssize_t
-mwifiex_debug_mask_read(struct file *file, char __user *ubuf,
-			size_t count, loff_t *ppos)
+mwifiex_debug_mask_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mwifiex_private *priv =
-		(struct mwifiex_private *)file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	unsigned long page = get_zeroed_page(GFP_KERNEL);
 	char *buf = (char *)page;
 	size_t ret = 0;
@@ -521,7 +503,7 @@ mwifiex_debug_mask_read(struct file *file, char __user *ubuf,
 
 	pos += snprintf(buf, PAGE_SIZE, "debug mask=0x%08x\n",
 			priv->adapter->debug_mask);
-	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 
 	free_page(page);
 	return ret;
@@ -532,15 +514,15 @@ mwifiex_debug_mask_read(struct file *file, char __user *ubuf,
  * This function can be used read driver debugging mask value.
  */
 static ssize_t
-mwifiex_debug_mask_write(struct file *file, const char __user *ubuf,
-			 size_t count, loff_t *ppos)
+mwifiex_debug_mask_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int ret;
 	unsigned long debug_mask;
-	struct mwifiex_private *priv = (void *)file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char *buf;
 
-	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	buf = iterdup_nul(from, min(count, (size_t)(PAGE_SIZE - 1)));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -559,15 +541,14 @@ mwifiex_debug_mask_write(struct file *file, const char __user *ubuf,
 /* debugfs verext file write handler.
  * This function is called when the 'verext' file is opened for write
  */
-static ssize_t
-mwifiex_verext_write(struct file *file, const char __user *ubuf,
-		     size_t count, loff_t *ppos)
+static ssize_t mwifiex_verext_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int ret;
 	u32 versionstrsel;
-	struct mwifiex_private *priv = (void *)file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
-	ret = kstrtou32_from_user(ubuf, count, 10, &versionstrsel);
+	ret = kstrtou32_from_iter(from, count, 10, &versionstrsel);
 	if (ret)
 		return ret;
 
@@ -581,11 +562,9 @@ mwifiex_verext_write(struct file *file, const char __user *ubuf,
  * This function can be used read driver exteneed verion string.
  */
 static ssize_t
-mwifiex_verext_read(struct file *file, char __user *ubuf,
-		    size_t count, loff_t *ppos)
+mwifiex_verext_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mwifiex_private *priv =
-		(struct mwifiex_private *)file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	char buf[256];
 	int ret;
 
@@ -593,25 +572,24 @@ mwifiex_verext_read(struct file *file, char __user *ubuf,
 	ret = snprintf(buf, sizeof(buf), "version string: %s\n",
 		       priv->version_str);
 
-	return simple_read_from_buffer(ubuf, count, ppos, buf, ret);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 }
 
 /* Proc memrw file write handler.
  * This function is called when the 'memrw' file is opened for writing
  * This function can be used to write to a memory location.
  */
-static ssize_t
-mwifiex_memrw_write(struct file *file, const char __user *ubuf, size_t count,
-		    loff_t *ppos)
+static ssize_t mwifiex_memrw_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int ret;
 	char cmd;
 	struct mwifiex_ds_mem_rw mem_rw;
 	u16 cmd_action;
-	struct mwifiex_private *priv = (void *)file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char *buf;
 
-	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	buf = iterdup_nul(from, min(count, (size_t)(PAGE_SIZE - 1)));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -647,11 +625,9 @@ mwifiex_memrw_write(struct file *file, const char __user *ubuf, size_t count,
  * This function is called when the 'memrw' file is opened for reading
  * This function can be used to read from a memory location.
  */
-static ssize_t
-mwifiex_memrw_read(struct file *file, char __user *ubuf,
-		   size_t count, loff_t *ppos)
+static ssize_t mwifiex_memrw_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mwifiex_private *priv = (void *)file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	unsigned long addr = get_zeroed_page(GFP_KERNEL);
 	char *buf = (char *)addr;
 	int ret, pos = 0;
@@ -661,7 +637,7 @@ mwifiex_memrw_read(struct file *file, char __user *ubuf,
 
 	pos += snprintf(buf, PAGE_SIZE, "0x%x 0x%x\n", priv->mem_rw.addr,
 			priv->mem_rw.value);
-	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 
 	free_page(addr);
 	return ret;
@@ -676,15 +652,14 @@ static u32 saved_offset = -1, saved_bytes = -1;
  *
  * This function can be used to write to a RDEEPROM location.
  */
-static ssize_t
-mwifiex_rdeeprom_write(struct file *file,
-		       const char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t mwifiex_rdeeprom_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char *buf;
 	int ret = 0;
 	int offset = -1, bytes = -1;
+	size_t count = iov_iter_count(from);
 
-	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	buf = iterdup_nul(from, min(count, (size_t)(PAGE_SIZE - 1)));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -713,12 +688,9 @@ mwifiex_rdeeprom_write(struct file *file,
  *
  * This function can be used to read from a RDEEPROM location.
  */
-static ssize_t
-mwifiex_rdeeprom_read(struct file *file, char __user *ubuf,
-		      size_t count, loff_t *ppos)
+static ssize_t mwifiex_rdeeprom_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mwifiex_private *priv =
-		(struct mwifiex_private *) file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	unsigned long addr = get_zeroed_page(GFP_KERNEL);
 	char *buf = (char *) addr;
 	int pos, ret, i;
@@ -747,7 +719,7 @@ mwifiex_rdeeprom_read(struct file *file, char __user *ubuf,
 		pos += scnprintf(buf + pos, PAGE_SIZE - pos, "%d ", value[i]);
 
 done:
-	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 out_free:
 	free_page(addr);
 	return ret;
@@ -756,18 +728,17 @@ mwifiex_rdeeprom_read(struct file *file, char __user *ubuf,
 /* Proc hscfg file write handler
  * This function can be used to configure the host sleep parameters.
  */
-static ssize_t
-mwifiex_hscfg_write(struct file *file, const char __user *ubuf,
-		    size_t count, loff_t *ppos)
+static ssize_t mwifiex_hscfg_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mwifiex_private *priv = (void *)file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char *buf;
 	int ret, arg_num;
 	struct mwifiex_ds_hs_cfg hscfg;
 	int conditions = HS_CFG_COND_DEF;
 	u32 gpio = HS_CFG_GPIO_DEF, gap = HS_CFG_GAP_DEF;
 
-	buf = memdup_user_nul(ubuf, min(count, (size_t)(PAGE_SIZE - 1)));
+	buf = iterdup_nul(from, min(count, (size_t)(PAGE_SIZE - 1)));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -815,11 +786,9 @@ mwifiex_hscfg_write(struct file *file, const char __user *ubuf,
  * This function can be used to read host sleep configuration
  * parameters from driver.
  */
-static ssize_t
-mwifiex_hscfg_read(struct file *file, char __user *ubuf,
-		   size_t count, loff_t *ppos)
+static ssize_t mwifiex_hscfg_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mwifiex_private *priv = (void *)file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	unsigned long addr = get_zeroed_page(GFP_KERNEL);
 	char *buf = (char *)addr;
 	int pos, ret;
@@ -834,17 +803,16 @@ mwifiex_hscfg_read(struct file *file, char __user *ubuf,
 	pos = snprintf(buf, PAGE_SIZE, "%u 0x%x 0x%x\n", hscfg.conditions,
 		       hscfg.gpio, hscfg.gap);
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, buf, pos);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, pos, to);
 
 	free_page(addr);
 	return ret;
 }
 
-static ssize_t
-mwifiex_timeshare_coex_read(struct file *file, char __user *ubuf,
-			    size_t count, loff_t *ppos)
+static ssize_t mwifiex_timeshare_coex_read(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct mwifiex_private *priv = file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
 	char buf[3];
 	bool timeshare_coex;
 	int ret;
@@ -859,21 +827,21 @@ mwifiex_timeshare_coex_read(struct file *file, char __user *ubuf,
 		return ret;
 
 	len = sprintf(buf, "%d\n", timeshare_coex);
-	return simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static ssize_t
-mwifiex_timeshare_coex_write(struct file *file, const char __user *ubuf,
-			     size_t count, loff_t *ppos)
+mwifiex_timeshare_coex_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	bool timeshare_coex;
-	struct mwifiex_private *priv = file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 
 	if (priv->adapter->fw_api_ver != MWIFIEX_FW_V15)
 		return -EOPNOTSUPP;
 
-	ret = kstrtobool_from_user(ubuf, count, &timeshare_coex);
+	ret = kstrtobool_from_iter(from, count, &timeshare_coex);
 	if (ret)
 		return ret;
 
@@ -885,16 +853,15 @@ mwifiex_timeshare_coex_write(struct file *file, const char __user *ubuf,
 		return count;
 }
 
-static ssize_t
-mwifiex_reset_write(struct file *file,
-		    const char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t mwifiex_reset_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mwifiex_private *priv = file->private_data;
+	struct mwifiex_private *priv = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct mwifiex_adapter *adapter = priv->adapter;
 	bool result;
 	int rc;
 
-	rc = kstrtobool_from_user(ubuf, count, &result);
+	rc = kstrtobool_from_iter(from, count, &result);
 	if (rc)
 		return rc;
 
@@ -916,20 +883,20 @@ mwifiex_reset_write(struct file *file,
 
 #define MWIFIEX_DFS_FILE_OPS(name)                                      \
 static const struct file_operations mwifiex_dfs_##name##_fops = {       \
-	.read = mwifiex_##name##_read,                                  \
-	.write = mwifiex_##name##_write,                                \
+	.read_iter = mwifiex_##name##_read,                             \
+	.write_iter = mwifiex_##name##_write,                           \
 	.open = simple_open,                                            \
 };
 
 #define MWIFIEX_DFS_FILE_READ_OPS(name)                                 \
 static const struct file_operations mwifiex_dfs_##name##_fops = {       \
-	.read = mwifiex_##name##_read,                                  \
+	.read_iter = mwifiex_##name##_read,                             \
 	.open = simple_open,                                            \
 };
 
 #define MWIFIEX_DFS_FILE_WRITE_OPS(name)                                \
 static const struct file_operations mwifiex_dfs_##name##_fops = {       \
-	.write = mwifiex_##name##_write,                                \
+	.write_iter = mwifiex_##name##_write,                           \
 	.open = simple_open,                                            \
 };
 
-- 
2.43.0


