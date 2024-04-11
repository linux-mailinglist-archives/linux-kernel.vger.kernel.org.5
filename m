Return-Path: <linux-kernel+bounces-141086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823168A1A69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F2E285099
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB61DCA1A;
	Thu, 11 Apr 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NkLXF3FM"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF147F6F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850017; cv=none; b=s/1B9h/0PfTcDCJKeqcBSi3GE75I4KOGXmsF68nxHpAHja2RRALvQ5ihEqW8iNSlktoTTSOnWmhKzEL2EgsRsLU0hiZW5UolmGLa7UpH8v6su81pUpZLyeeuEEy6xTsBRqkHoeJF7Cz8540XaUxs97ryXjKlkM2Rq8tIdHC3cC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850017; c=relaxed/simple;
	bh=ebydvELdjKLIZ1e4qhBZw6sHskTD7aEPmZkpHHq5Osk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VS6hYIM3TODTjgczrA5GvDNXsaxK1Nfgp1us0YiqZmYMAR+tbPrG/kClVstp6Sb1iWz0bHZmICbrtJm4rc82KUxZEXZRIrEhAMzmoObGMJvt/NZy/JnayhH1h7iHxOWOxxUKork1kmLzaonnoJa6E64y5XPD03WIablzno8RyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NkLXF3FM; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9875239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850013; x=1713454813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhxnY18WOWtqTzCSkiBfYas/33+nq68jO/ej5bJH0BM=;
        b=NkLXF3FMDBAAR8XsQG+dFJa07Q2lI89IZ9sWKNJLxb0gaSPDgRCTijvnqdd9zZTJdV
         XCmxMte5QFJzDKllMJYBju6EHorvHip0QYrR4UdgRSjs0XsTCSutLsbHxQN0KDuV0oZ9
         nQbPhsofQ386Pce7656Hhf4BUDUNcEMYEmFXYOTiqcUrcB9l+vQ9fv/UF3FSnQSHAjNS
         0f6Z+rtGlJjars+KZjmYHRfvl1KinTAqd4TxfXCXHH7Zi4ds2u4kWdPAYf9u71SkZhSk
         Wkgu+514oer/B0EYDYcJ77+ITSKBPdmVU5X+koIVZeu+PHbqESMkzJCNkCKBUqiby3Bt
         lpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850013; x=1713454813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhxnY18WOWtqTzCSkiBfYas/33+nq68jO/ej5bJH0BM=;
        b=drM3aky4awrWSIs/XBuSCqR5oyFx/j9yqATLH1cjoTEtKmpIs+MiFLLnlzFKlCOGyn
         nwX7MuyWEQ3ZFCbfYkcW6dDgBW+lG2dy2sQlwgVDyQBw6TBxuKCv2Czd7WEJrZDLeqfI
         tnGwVr22hPqQr8Ut5M6Q+E+kbOYkd3c2fcWZxhTGJs1Y46m7qDpDAXvpVLJDVipTOzAe
         lj638W2GGPhJT3/tNLfQO3BsiGOsDkxtdDXYO+i6ZFw7vfdkkcU+pRTsp2HlGs6mRuC5
         vC7xi/KhslpZdTui4RVaefoZz1hAnGX1wW1jIEehZteBqmLSBcsYKBQmIiDJsiVUHX+q
         l9ng==
X-Gm-Message-State: AOJu0YyVdTnmKf8WBDDq+8ug0DNg2GGcv2KwKVwfXGPnt1EZ+az6wc0v
	UX4iZFHWBoQPYL4bClDPfTZEtFZSWxIYF9wMeyeYKjE18db7ZvKr0jHuC4CytwfMiPYynthoZmJ
	g
X-Google-Smtp-Source: AGHT+IFGIUvFRuadL7cG34B2/e83S1YwxJRTxtw4XhgFYGXw72KuOxKltka6sB4mLMZ515lrEOjDew==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr51054iob.2.1712850013541;
        Thu, 11 Apr 2024 08:40:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 309/437] wifi: rtw88: convert debugfs helpers to read/write iterators
Date: Thu, 11 Apr 2024 09:17:29 -0600
Message-ID: <20240411153126.16201-310-axboe@kernel.dk>
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
 drivers/net/wireless/realtek/rtw88/debug.c | 163 ++++++++++-----------
 1 file changed, 79 insertions(+), 84 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 5b2036798159..2a44bbc06a02 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -19,8 +19,7 @@
 struct rtw_debugfs_priv {
 	struct rtw_dev *rtwdev;
 	int (*cb_read)(struct seq_file *m, void *v);
-	ssize_t (*cb_write)(struct file *filp, const char __user *buffer,
-			    size_t count, loff_t *loff);
+	ssize_t (*cb_write)(struct kiocb *, struct iov_iter *);
 	union {
 		u32 cb_data;
 		u8 *buf;
@@ -55,23 +54,21 @@ static int rtw_debugfs_single_show(struct seq_file *m, void *v)
 	return debugfs_priv->cb_read(m, v);
 }
 
-static ssize_t rtw_debugfs_common_write(struct file *filp,
-					const char __user *buffer,
-					size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_common_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct rtw_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = iocb->ki_filp->private_data;
 
-	return debugfs_priv->cb_write(filp, buffer, count, loff);
+	return debugfs_priv->cb_write(iocb, from);
 }
 
-static ssize_t rtw_debugfs_single_write(struct file *filp,
-					const char __user *buffer,
-					size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_single_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 
-	return debugfs_priv->cb_write(filp, buffer, count, loff);
+	return debugfs_priv->cb_write(iocb, from);
 }
 
 static int rtw_debugfs_single_open_rw(struct inode *inode, struct file *filp)
@@ -87,7 +84,7 @@ static int rtw_debugfs_close(struct inode *inode, struct file *filp)
 static const struct file_operations file_ops_single_r = {
 	.owner = THIS_MODULE,
 	.open = rtw_debugfs_single_open_rw,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -96,14 +93,14 @@ static const struct file_operations file_ops_single_rw = {
 	.owner = THIS_MODULE,
 	.open = rtw_debugfs_single_open_rw,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
-	.write = rtw_debugfs_single_write,
+	.write_iter = rtw_debugfs_single_write,
 };
 
 static const struct file_operations file_ops_common_write = {
 	.owner = THIS_MODULE,
-	.write = rtw_debugfs_common_write,
+	.write_iter = rtw_debugfs_common_write,
 	.open = simple_open,
 	.release = rtw_debugfs_close,
 };
@@ -171,9 +168,9 @@ static int rtw_debugfs_get_fix_rate(struct seq_file *m, void *v)
 }
 
 static int rtw_debugfs_copy_from_user(char tmp[], int size,
-				      const char __user *buffer, size_t count,
-				      int num)
+				      struct iov_iter *from, int num)
 {
+	size_t count = iov_iter_count(from);
 	int tmp_len;
 
 	memset(tmp, 0, size);
@@ -183,7 +180,7 @@ static int rtw_debugfs_copy_from_user(char tmp[], int size,
 
 	tmp_len = (count > size - 1 ? size - 1 : count);
 
-	if (copy_from_user(tmp, buffer, tmp_len))
+	if (!copy_from_iter_full(tmp, tmp_len, from))
 		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
@@ -191,19 +188,19 @@ static int rtw_debugfs_copy_from_user(char tmp[], int size,
 	return 0;
 }
 
-static ssize_t rtw_debugfs_set_read_reg(struct file *filp,
-					const char __user *buffer,
-					size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_read_reg(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char tmp[32 + 1];
 	u32 addr, len;
 	int num;
 	int ret;
 
-	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 2);
+	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), from, 2);
 	if (ret)
 		return ret;
 
@@ -281,19 +278,19 @@ static int rtw_debugfs_get_rsvd_page(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t rtw_debugfs_set_rsvd_page(struct file *filp,
-					 const char __user *buffer,
-					 size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_rsvd_page(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char tmp[32 + 1];
 	u32 offset, page_num;
 	int num;
 	int ret;
 
-	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 2);
+	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), from, 2);
 	if (ret)
 		return ret;
 
@@ -310,16 +307,16 @@ static ssize_t rtw_debugfs_set_rsvd_page(struct file *filp,
 	return count;
 }
 
-static ssize_t rtw_debugfs_set_single_input(struct file *filp,
-					    const char __user *buffer,
-					    size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_single_input(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
+	size_t count = iov_iter_count(from);
 	u32 input;
 	int ret;
 
-	ret = kstrtou32_from_user(buffer, count, 0, &input);
+	ret = kstrtou32_from_iter(from, count, 0, &input);
 	if (ret)
 		return ret;
 
@@ -328,18 +325,18 @@ static ssize_t rtw_debugfs_set_single_input(struct file *filp,
 	return count;
 }
 
-static ssize_t rtw_debugfs_set_write_reg(struct file *filp,
-					 const char __user *buffer,
-					 size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_write_reg(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct rtw_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = iocb->ki_filp->private_data;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char tmp[32 + 1];
 	u32 addr, val, len;
 	int num;
 	int ret;
 
-	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 3);
+	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), from, 3);
 	if (ret)
 		return ret;
 
@@ -374,18 +371,17 @@ static ssize_t rtw_debugfs_set_write_reg(struct file *filp,
 	return count;
 }
 
-static ssize_t rtw_debugfs_set_h2c(struct file *filp,
-				   const char __user *buffer,
-				   size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_h2c(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct rtw_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = iocb->ki_filp->private_data;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char tmp[32 + 1];
 	u8 param[8];
 	int num;
 	int ret;
 
-	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 3);
+	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), from, 3);
 	if (ret)
 		return ret;
 
@@ -404,18 +400,18 @@ static ssize_t rtw_debugfs_set_h2c(struct file *filp,
 	return count;
 }
 
-static ssize_t rtw_debugfs_set_rf_write(struct file *filp,
-					const char __user *buffer,
-					size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_rf_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct rtw_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = iocb->ki_filp->private_data;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char tmp[32 + 1];
 	u32 path, addr, mask, val;
 	int num;
 	int ret;
 
-	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 4);
+	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), from, 4);
 	if (ret)
 		return ret;
 
@@ -436,19 +432,18 @@ static ssize_t rtw_debugfs_set_rf_write(struct file *filp,
 	return count;
 }
 
-static ssize_t rtw_debugfs_set_rf_read(struct file *filp,
-				       const char __user *buffer,
-				       size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_rf_read(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char tmp[32 + 1];
 	u32 path, addr, mask;
 	int num;
 	int ret;
 
-	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 3);
+	ret = rtw_debugfs_copy_from_user(tmp, sizeof(tmp), from, 3);
 	if (ret)
 		return ret;
 
@@ -466,18 +461,18 @@ static ssize_t rtw_debugfs_set_rf_read(struct file *filp,
 	return count;
 }
 
-static ssize_t rtw_debugfs_set_fix_rate(struct file *filp,
-					const char __user *buffer,
-					size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_fix_rate(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	size_t count = iov_iter_count(from);
 	u8 fix_rate;
 	int ret;
 
-	ret = kstrtou8_from_user(buffer, count, 0, &fix_rate);
+	ret = kstrtou8_from_iter(from, count, 0, &fix_rate);
 	if (ret)
 		return ret;
 
@@ -854,18 +849,18 @@ static int rtw_debugfs_get_coex_info(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t rtw_debugfs_set_coex_enable(struct file *filp,
-					   const char __user *buffer,
-					   size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_coex_enable(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw_coex *coex = &rtwdev->coex;
+	size_t count = iov_iter_count(from);
 	bool enable;
 	int ret;
 
-	ret = kstrtobool_from_user(buffer, count, &enable);
+	ret = kstrtobool_from_iter(from, count, &enable);
 	if (ret)
 		return ret;
 
@@ -888,17 +883,17 @@ static int rtw_debugfs_get_coex_enable(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t rtw_debugfs_set_edcca_enable(struct file *filp,
-					    const char __user *buffer,
-					    size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_edcca_enable(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	bool input;
 	int err;
 
-	err = kstrtobool_from_user(buffer, count, &input);
+	err = kstrtobool_from_iter(from, count, &input);
 	if (err)
 		return err;
 
@@ -920,17 +915,17 @@ static int rtw_debugfs_get_edcca_enable(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t rtw_debugfs_set_fw_crash(struct file *filp,
-					const char __user *buffer,
-					size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_fw_crash(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	bool input;
 	int ret;
 
-	ret = kstrtobool_from_user(buffer, count, &input);
+	ret = kstrtobool_from_iter(from, count, &input);
 	if (ret)
 		return ret;
 
@@ -960,17 +955,17 @@ static int rtw_debugfs_get_fw_crash(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t rtw_debugfs_set_force_lowest_basic_rate(struct file *filp,
-						       const char __user *buffer,
-						       size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_force_lowest_basic_rate(struct kiocb *iocb,
+						       struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	bool input;
 	int err;
 
-	err = kstrtobool_from_user(buffer, count, &input);
+	err = kstrtobool_from_iter(from, count, &input);
 	if (err)
 		return err;
 
@@ -993,18 +988,18 @@ static int rtw_debugfs_get_force_lowest_basic_rate(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t rtw_debugfs_set_dm_cap(struct file *filp,
-				      const char __user *buffer,
-				      size_t count, loff_t *loff)
+static ssize_t rtw_debugfs_set_dm_cap(struct kiocb *iocb,
+				      struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	size_t count = iov_iter_count(from);
 	int ret, bit;
 	bool en;
 
-	ret = kstrtoint_from_user(buffer, count, 10, &bit);
+	ret = kstrtoint_from_iter(from, count, 10, &bit);
 	if (ret)
 		return ret;
 
-- 
2.43.0


