Return-Path: <linux-kernel+bounces-141072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39F8A1A57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940C42846FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690551D636A;
	Thu, 11 Apr 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3C8PbngL"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897A1D4F10
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849997; cv=none; b=L5okwVxfB/Q9dbD8xYYBLFzndFlWkyIOb0P7G5G47PJ66JTrfS1qjiqcbBcoGHrpv5g+xRLbtmvkrbihkI5zCFdWrqkScl5rNGbJGTmYzm5xSIbI8oU7u7ko1RXHYDXzc03RcJeWPALqI05Iz8VZjd9B8fjo+x7x1l9BOa3/9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849997; c=relaxed/simple;
	bh=/LZAFyBz2OJAp6gm6I/UMuET8X2zjRlG7mzov9CE9fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1ezz4OGCR3Iad/j5p0XiOSPgiKWLXgOUUYBD4PiRcss+Ffih4A40KQIO/+R2I5qafLvZfZywljKwACMPMKh4Bqw45AvKLry5xH3VW/uescMYO6yygHvWhzozFLCn8L4u8uUrNc+EELd8Lk2GaJ7fA+PZTm9uHs02cxT0Wj2yg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3C8PbngL; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9033639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849994; x=1713454794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enTo/mQ1pweo1a8RhDYh+R6rp1ViKSzwVDf9GltQJ94=;
        b=3C8PbngL2yn3fRVgusewDLSy2kCEd3BYNbwsejl1sxg5U3Iauv430Ykf0/W/jHW/ms
         f/b9gy5b+YQwM7htv/gBzj0pFwPeLWtpi8dfU2tIE5iS8AR8h/SC4Sy9DlCoxqeOcQSs
         bltDxRa/ETSt6CddAdYAfM5lPBO+N80TR7ZXykG+i88Li1lbLPFCjxEpNLWWJp2gLrjl
         VWqDWSyvqt2OqC5MqEvWZ6poSuMTvGGXSXg7fz5pT9+4eTZYllqO5Pnwbyumy+uvH9R7
         ALhIwldLECoLIvpTShAudyH3pAvPVuJ7UTwZl84qeGzkLj1DMJ5SxMlKpppSEY0dH7IK
         pK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849994; x=1713454794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enTo/mQ1pweo1a8RhDYh+R6rp1ViKSzwVDf9GltQJ94=;
        b=JxEGDvqz0mJrV2qSZmVkQ5ekh5JyBkOLBiRXrw1LZlQEzrskXxRHg7Ee2Q8IxaxtRY
         R32J+h4GZA346UHOx1b0qtD17Lenavcwz5yCszLukZOxwVtRjwu2uvIIki5uCS0CGdoa
         JQEzmPtRjnyi1cGLA0vnfacvtEeYwhoju1GB1pla3MWiHNZceJfcp7f6WUljhVDp14xu
         oLYtSKAVQEx8fH3M31T1m+djvqQknJjm6EyPeLUa+Fte0Mjja3XmPDwWGkUkcuFnzVQe
         rLjJwJsYnrdP72ONV+G7gZkgx1WNbk3Ht8ExOmBdqEeMo3w6Hj1B+1UchNX5jiJG3qtH
         VCXA==
X-Gm-Message-State: AOJu0YyJsI43ZORT/YM/9Jk0hNtan0L3Q8tibPiyWEfrxm5ckEphKp8G
	2jS4ItgRk4drBr619eJrzTRwwqox308Lk/x8VgZJB+jOXHt2ooRTHT4jV6qdHWSNvjP1EaK/BPr
	F
X-Google-Smtp-Source: AGHT+IFqGXrofdgBmfAQfP9nXT6iHWuueflfmKgcvAN+1/5Di47qfYnEb8SQbmSQ4c1tcrOSOQzf/A==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr26444ioc.1.1712849993745;
        Thu, 11 Apr 2024 08:39:53 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 298/437] drivers/net/wireless/ath/ath5k: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:18 -0600
Message-ID: <20240411153126.16201-299-axboe@kernel.dk>
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
 drivers/net/wireless/ath/ath5k/debug.c | 148 +++++++++++--------------
 1 file changed, 66 insertions(+), 82 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index ec130510aeb2..22f19957887c 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -172,10 +172,9 @@ DEFINE_SEQ_ATTRIBUTE(registers);
 
 /* debugfs: beacons */
 
-static ssize_t read_file_beacon(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_beacon(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
 	char buf[500];
 	unsigned int len = 0;
 	unsigned int v;
@@ -217,18 +216,17 @@ static ssize_t read_file_beacon(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_beacon(struct file *file,
-				 const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t write_file_beacon(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[20];
 
 	count = min_t(size_t, count, sizeof(buf) - 1);
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	buf[count] = '\0';
@@ -243,8 +241,8 @@ static ssize_t write_file_beacon(struct file *file,
 }
 
 static const struct file_operations fops_beacon = {
-	.read = read_file_beacon,
-	.write = write_file_beacon,
+	.read_iter = read_file_beacon,
+	.write_iter = write_file_beacon,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -253,18 +251,16 @@ static const struct file_operations fops_beacon = {
 
 /* debugfs: reset */
 
-static ssize_t write_file_reset(struct file *file,
-				 const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t write_file_reset(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
 	ATH5K_DBG(ah, ATH5K_DEBUG_RESET, "debug file triggered reset\n");
 	ieee80211_queue_work(ah->hw, &ah->reset_work);
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations fops_reset = {
-	.write = write_file_reset,
+	.write_iter = write_file_reset,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
@@ -293,10 +289,9 @@ static const struct {
 	{ ATH5K_DEBUG_ANY,	"all",		"show all debug levels" },
 };
 
-static ssize_t read_file_debug(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_debug(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
 	char buf[700];
 	unsigned int len = 0;
 	unsigned int i;
@@ -318,19 +313,18 @@ static ssize_t read_file_debug(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_debug(struct file *file,
-				 const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t write_file_debug(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned int i;
 	char buf[20];
 
 	count = min_t(size_t, count, sizeof(buf) - 1);
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	buf[count] = '\0';
@@ -345,8 +339,8 @@ static ssize_t write_file_debug(struct file *file,
 }
 
 static const struct file_operations fops_debug = {
-	.read = read_file_debug,
-	.write = write_file_debug,
+	.read_iter = read_file_debug,
+	.write_iter = write_file_debug,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -355,10 +349,9 @@ static const struct file_operations fops_debug = {
 
 /* debugfs: antenna */
 
-static ssize_t read_file_antenna(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_antenna(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
 	char buf[700];
 	unsigned int len = 0;
 	unsigned int i;
@@ -423,19 +416,18 @@ static ssize_t read_file_antenna(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_antenna(struct file *file,
-				 const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t write_file_antenna(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned int i;
 	char buf[20];
 
 	count = min_t(size_t, count, sizeof(buf) - 1);
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	buf[count] = '\0';
@@ -459,8 +451,8 @@ static ssize_t write_file_antenna(struct file *file,
 }
 
 static const struct file_operations fops_antenna = {
-	.read = read_file_antenna,
-	.write = write_file_antenna,
+	.read_iter = read_file_antenna,
+	.write_iter = write_file_antenna,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -468,10 +460,9 @@ static const struct file_operations fops_antenna = {
 
 /* debugfs: misc */
 
-static ssize_t read_file_misc(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_misc(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
 	char buf[700];
 	unsigned int len = 0;
 	u32 filt = ath5k_hw_get_rx_filter(ah);
@@ -511,11 +502,11 @@ static ssize_t read_file_misc(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_misc = {
-	.read = read_file_misc,
+	.read_iter = read_file_misc,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 };
@@ -523,10 +514,9 @@ static const struct file_operations fops_misc = {
 
 /* debugfs: frameerrors */
 
-static ssize_t read_file_frameerrors(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_frameerrors(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
 	struct ath5k_statistics *st = &ah->stats;
 	char buf[700];
 	unsigned int len = 0;
@@ -596,19 +586,18 @@ static ssize_t read_file_frameerrors(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_frameerrors(struct file *file,
-				 const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t write_file_frameerrors(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath5k_statistics *st = &ah->stats;
 	char buf[20];
 
 	count = min_t(size_t, count, sizeof(buf) - 1);
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	buf[count] = '\0';
@@ -631,8 +620,8 @@ static ssize_t write_file_frameerrors(struct file *file,
 }
 
 static const struct file_operations fops_frameerrors = {
-	.read = read_file_frameerrors,
-	.write = write_file_frameerrors,
+	.read_iter = read_file_frameerrors,
+	.write_iter = write_file_frameerrors,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -641,10 +630,9 @@ static const struct file_operations fops_frameerrors = {
 
 /* debugfs: ani */
 
-static ssize_t read_file_ani(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_ani(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
 	struct ath5k_statistics *st = &ah->stats;
 	struct ath5k_ani_state *as = &ah->ani_state;
 
@@ -746,18 +734,17 @@ static ssize_t read_file_ani(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_ani(struct file *file,
-				 const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t write_file_ani(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[20];
 
 	count = min_t(size_t, count, sizeof(buf) - 1);
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	buf[count] = '\0';
@@ -796,8 +783,8 @@ static ssize_t write_file_ani(struct file *file,
 }
 
 static const struct file_operations fops_ani = {
-	.read = read_file_ani,
-	.write = write_file_ani,
+	.read_iter = read_file_ani,
+	.write_iter = write_file_ani,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -806,10 +793,9 @@ static const struct file_operations fops_ani = {
 
 /* debugfs: queues etc */
 
-static ssize_t read_file_queue(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_queue(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
 	char buf[700];
 	unsigned int len = 0;
 
@@ -844,18 +830,17 @@ static ssize_t read_file_queue(struct file *file, char __user *user_buf,
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t write_file_queue(struct file *file,
-				 const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t write_file_queue(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath5k_hw *ah = file->private_data;
+	struct ath5k_hw *ah = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[20];
 
 	count = min_t(size_t, count, sizeof(buf) - 1);
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	buf[count] = '\0';
@@ -869,8 +854,8 @@ static ssize_t write_file_queue(struct file *file,
 
 
 static const struct file_operations fops_queue = {
-	.read = read_file_queue,
-	.write = write_file_queue,
+	.read_iter = read_file_queue,
+	.write_iter = write_file_queue,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -948,12 +933,11 @@ static int open_file_eeprom(struct inode *inode, struct file *file)
 
 }
 
-static ssize_t read_file_eeprom(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_eeprom(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct eeprom_private *ep = file->private_data;
+	struct eeprom_private *ep = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(user_buf, count, ppos, ep->buf, ep->len);
+	return simple_copy_to_iter(ep->buf, &iocb->ki_pos, ep->len, to);
 }
 
 static int release_file_eeprom(struct inode *inode, struct file *file)
@@ -968,7 +952,7 @@ static int release_file_eeprom(struct inode *inode, struct file *file)
 
 static const struct file_operations fops_eeprom = {
 	.open = open_file_eeprom,
-	.read = read_file_eeprom,
+	.read_iter = read_file_eeprom,
 	.release = release_file_eeprom,
 	.owner = THIS_MODULE,
 };
-- 
2.43.0


