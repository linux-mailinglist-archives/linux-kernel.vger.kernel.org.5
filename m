Return-Path: <linux-kernel+bounces-141088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DDB8A1AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78B9B31E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB71DDD03;
	Thu, 11 Apr 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QQ1xOCAd"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102711DB549
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850019; cv=none; b=I4+DP4wTY+pbhTShGzFSxRtFzwgvx0CR/fz6HbqkXcK67mavS8TONyft6AElcBKJujTSZk1vrgs4sGO93rrkBZIOm5Rvnkk3B0uqBpkULmDu61fM8lrEEhSBEJ7jyLx6rlFXHwuKnDxYlR3c4cpR8pqQLDBFSIWdqbHzlzCgHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850019; c=relaxed/simple;
	bh=ydDFYHQCrE+yYOCUiSx91nxhcZq5kswBMtxKFXnBmug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fszsQxPAplybX3fLQm6zGiVaFLEwgcQ2UiROERecTq9ShMWRQpmW37COqFzOnovhSSWl9RPxrc1RASRtRFxVjEgPbtOQQvqVzIl9FqNq+B5hdi18+Octjxm63Fkcm9N7AazKaHKBrog11aV15UILurGrHa5ORkOqlkm12BkKvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QQ1xOCAd; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36a224d7414so191955ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850015; x=1713454815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J4x+oZljRz6ipZRrygJdtdb+0cUV6nYtWbTKlirtqk=;
        b=QQ1xOCAdXJus+3F87Lyg6tr0KlErzgVc/4kzSM8vmzAP1pDmzEhpdj+/ahpWs+h7E/
         z1P3xQUcp6IJOPO92BWH5P5m2yb2jiuUgpCrZYkkM1G6twMRY33Om0k6Qo3pWAeVpPH/
         52F+cAxqViLdHszuzL6eEOohaC7B7qnl+37osF1c3beluB8/aCqkGJqjWhrsKJ+Ng2Jc
         oos0o+MbrHAAHIk1ZXqpROBBr3t+ZDFJqZ0ZWFGSLgi+HS/WmiD+FiUezjij51VNl/Hp
         yRHqAwQdvGFePtSMpJ4hr621f5N9mb8nGNbI46cBzjMwVNvNGGiI6+jWqrZCCTlkQ38g
         IKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850015; x=1713454815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J4x+oZljRz6ipZRrygJdtdb+0cUV6nYtWbTKlirtqk=;
        b=Ht0R/eGyKubluZ7lnbuuLbg/WGgy/szZ8Luqs25pzu/K11ZqBcZOOupl2DRGMrMD44
         MlxTLcCmpkr/Js3tZ0dVPDQtr57Gph2jD58TUVPdzDgs7vr3sJcPQsDwjtLpRcl29VFK
         3mfk8Gxmsw9uzLUtGKVHqZ6avHtTYCSpkt3Ig3jpj3Ii2yMzFNIvYqFdIKD8of3aqdRM
         0wsP64TdfatJe5GuGIXj+Zwik5yBUzi9OC5gEwLEmX3iNcnP9S/oCJEFLCZQbTNyA4ca
         XFqtkNCE6HxBkfEIOKixaxCoY+QzF0kj8ZZtcaA2+IjXZ5DMkanFjDG9zz756aK6TH9h
         mYZg==
X-Gm-Message-State: AOJu0Yx5tkdpncfksgxEdjdvnmWhAZazRtaqNfexG90KvGDcAGP2aXLQ
	dpSKsh6Y4NQOhSI6qRDrVqs9T3t5iv/Ht/tMKts0C/ebJMiUCvS8M7T64caJ0i9hn+BxC+R/jK8
	V
X-Google-Smtp-Source: AGHT+IHAHdvdgGNLsipQJG25g20Hquc4UX+rWy09TWebFgDGXLPlYP2ITL1Sx63XTpLPcISIEor7hg==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr198435iob.1.1712850015351;
        Thu, 11 Apr 2024 08:40:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 310/437] wifi: rtw89: convert debugfs helpers to read/write iterators
Date: Thu, 11 Apr 2024 09:17:30 -0600
Message-ID: <20240411153126.16201-311-axboe@kernel.dk>
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
 drivers/net/wireless/realtek/rtw89/debug.c | 155 ++++++++++-----------
 1 file changed, 74 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index affffc4092ba..20d8774f151a 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -24,8 +24,7 @@ MODULE_PARM_DESC(debug_mask, "Debugging mask");
 struct rtw89_debugfs_priv {
 	struct rtw89_dev *rtwdev;
 	int (*cb_read)(struct seq_file *m, void *v);
-	ssize_t (*cb_write)(struct file *filp, const char __user *buffer,
-			    size_t count, loff_t *loff);
+	ssize_t (*cb_write)(struct kiocb *, struct iov_iter *);
 	union {
 		u32 cb_data;
 		struct {
@@ -75,23 +74,21 @@ static int rtw89_debugfs_single_show(struct seq_file *m, void *v)
 	return debugfs_priv->cb_read(m, v);
 }
 
-static ssize_t rtw89_debugfs_single_write(struct file *filp,
-					  const char __user *buffer,
-					  size_t count, loff_t *loff)
+static ssize_t rtw89_debugfs_single_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = iocb->ki_filp->private_data;
 
-	return debugfs_priv->cb_write(filp, buffer, count, loff);
+	return debugfs_priv->cb_write(iocb, from);
 }
 
-static ssize_t rtw89_debugfs_seq_file_write(struct file *filp,
-					    const char __user *buffer,
-					    size_t count, loff_t *loff)
+static ssize_t rtw89_debugfs_seq_file_write(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct seq_file *seqpriv = iocb->ki_filp->private_data;
 	struct rtw89_debugfs_priv *debugfs_priv = seqpriv->private;
 
-	return debugfs_priv->cb_write(filp, buffer, count, loff);
+	return debugfs_priv->cb_write(iocb, from);
 }
 
 static int rtw89_debugfs_single_open(struct inode *inode, struct file *filp)
@@ -107,7 +104,7 @@ static int rtw89_debugfs_close(struct inode *inode, struct file *filp)
 static const struct file_operations file_ops_single_r = {
 	.owner = THIS_MODULE,
 	.open = rtw89_debugfs_single_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -116,33 +113,32 @@ static const struct file_operations file_ops_common_rw = {
 	.owner = THIS_MODULE,
 	.open = rtw89_debugfs_single_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
-	.write = rtw89_debugfs_seq_file_write,
+	.write_iter = rtw89_debugfs_seq_file_write,
 };
 
 static const struct file_operations file_ops_single_w = {
 	.owner = THIS_MODULE,
-	.write = rtw89_debugfs_single_write,
+	.write_iter = rtw89_debugfs_single_write,
 	.open = simple_open,
 	.release = rtw89_debugfs_close,
 };
 
 static ssize_t
-rtw89_debug_priv_read_reg_select(struct file *filp,
-				 const char __user *user_buf,
-				 size_t count, loff_t *loff)
+rtw89_debug_priv_read_reg_select(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	size_t buf_size;
 	u32 addr, len;
 	int num;
 
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -207,19 +203,19 @@ static int rtw89_debug_priv_read_reg_get(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t rtw89_debug_priv_write_reg_set(struct file *filp,
-					      const char __user *user_buf,
-					      size_t count, loff_t *loff)
+static ssize_t rtw89_debug_priv_write_reg_set(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = iocb->ki_filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	size_t buf_size;
 	u32 addr, val, len;
 	int num;
 
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -251,13 +247,12 @@ static ssize_t rtw89_debug_priv_write_reg_set(struct file *filp,
 }
 
 static ssize_t
-rtw89_debug_priv_read_rf_select(struct file *filp,
-				const char __user *user_buf,
-				size_t count, loff_t *loff)
+rtw89_debug_priv_read_rf_select(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	size_t buf_size;
 	u32 addr, mask;
@@ -265,7 +260,7 @@ rtw89_debug_priv_read_rf_select(struct file *filp,
 	int num;
 
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -306,12 +301,12 @@ static int rtw89_debug_priv_read_rf_get(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t rtw89_debug_priv_write_rf_set(struct file *filp,
-					     const char __user *user_buf,
-					     size_t count, loff_t *loff)
+static ssize_t rtw89_debug_priv_write_rf_set(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = iocb->ki_filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	size_t buf_size;
 	u32 addr, val, mask;
@@ -319,7 +314,7 @@ static ssize_t rtw89_debug_priv_write_rf_set(struct file *filp,
 	int num;
 
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -867,21 +862,20 @@ static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
 }
 
 static ssize_t
-rtw89_debug_priv_mac_reg_dump_select(struct file *filp,
-				     const char __user *user_buf,
-				     size_t count, loff_t *loff)
+rtw89_debug_priv_mac_reg_dump_select(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	size_t buf_size;
 	int sel;
 	int ret;
 
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -984,20 +978,19 @@ static int rtw89_debug_priv_mac_reg_dump_get(struct seq_file *m, void *v)
 }
 
 static ssize_t
-rtw89_debug_priv_mac_mem_dump_select(struct file *filp,
-				     const char __user *user_buf,
-				     size_t count, loff_t *loff)
+rtw89_debug_priv_mac_mem_dump_select(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	size_t buf_size;
 	u32 sel, start_addr, len;
 	int num;
 
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -1094,13 +1087,13 @@ rtw89_debug_priv_mac_mem_dump_get(struct seq_file *m, void *v)
 }
 
 static ssize_t
-rtw89_debug_priv_mac_dbg_port_dump_select(struct file *filp,
-					  const char __user *user_buf,
-					  size_t count, loff_t *loff)
+rtw89_debug_priv_mac_dbg_port_dump_select(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	size_t buf_size;
 	int sel, set;
@@ -1108,7 +1101,7 @@ rtw89_debug_priv_mac_dbg_port_dump_select(struct file *filp,
 	bool enable;
 
 	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -3222,15 +3215,15 @@ rtw89_debug_priv_mac_dbg_port_dump_get(struct seq_file *m, void *v)
 	return 0;
 };
 
-static u8 *rtw89_hex2bin_user(struct rtw89_dev *rtwdev,
-			      const char __user *user_buf, size_t count)
+static u8 *rtw89_hex2bin_user(struct rtw89_dev *rtwdev, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char *buf;
 	u8 *bin;
 	int num;
 	int err = 0;
 
-	buf = memdup_user(user_buf, count);
+	buf = iterdup(from, count);
 	if (IS_ERR(buf))
 		return buf;
 
@@ -3253,17 +3246,17 @@ static u8 *rtw89_hex2bin_user(struct rtw89_dev *rtwdev,
 	return err ? ERR_PTR(err) : bin;
 }
 
-static ssize_t rtw89_debug_priv_send_h2c_set(struct file *filp,
-					     const char __user *user_buf,
-					     size_t count, loff_t *loff)
+static ssize_t rtw89_debug_priv_send_h2c_set(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = iocb->ki_filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	u8 *h2c;
 	int ret;
 	u16 h2c_len = count / 2;
 
-	h2c = rtw89_hex2bin_user(rtwdev, user_buf, count);
+	h2c = rtw89_hex2bin_user(rtwdev, from);
 	if (IS_ERR(h2c))
 		return -EFAULT;
 
@@ -3291,17 +3284,17 @@ rtw89_debug_priv_early_h2c_get(struct seq_file *m, void *v)
 }
 
 static ssize_t
-rtw89_debug_priv_early_h2c_set(struct file *filp, const char __user *user_buf,
-			       size_t count, loff_t *loff)
+rtw89_debug_priv_early_h2c_set(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	size_t count = iov_iter_count(from);
 	struct rtw89_early_h2c *early_h2c;
 	u8 *h2c;
 	u16 h2c_len = count / 2;
 
-	h2c = rtw89_hex2bin_user(rtwdev, user_buf, count);
+	h2c = rtw89_hex2bin_user(rtwdev, from);
 	if (IS_ERR(h2c))
 		return -EFAULT;
 
@@ -3372,17 +3365,17 @@ enum rtw89_dbg_crash_simulation_type {
 };
 
 static ssize_t
-rtw89_debug_priv_fw_crash_set(struct file *filp, const char __user *user_buf,
-			      size_t count, loff_t *loff)
+rtw89_debug_priv_fw_crash_set(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	int (*sim)(struct rtw89_dev *rtwdev);
+	size_t count = iov_iter_count(from);
 	u8 crash_type;
 	int ret;
 
-	ret = kstrtou8_from_user(user_buf, count, 0, &crash_type);
+	ret = kstrtou8_from_iter(from, count, 0, &crash_type);
 	if (ret)
 		return -EINVAL;
 
@@ -3420,17 +3413,17 @@ static int rtw89_debug_priv_btc_info_get(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
-					       const char __user *user_buf,
-					       size_t count, loff_t *loff)
+static ssize_t rtw89_debug_priv_btc_manual_set(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = iocb->ki_filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
+	size_t count = iov_iter_count(from);
 	int ret;
 
-	ret = kstrtobool_from_user(user_buf, count, &btc->manual_ctrl);
+	ret = kstrtobool_from_iter(from, count, &btc->manual_ctrl);
 	if (ret)
 		return ret;
 
@@ -3442,16 +3435,16 @@ static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
 	return count;
 }
 
-static ssize_t rtw89_debug_fw_log_manual_set(struct file *filp,
-					     const char __user *user_buf,
-					     size_t count, loff_t *loff)
+static ssize_t rtw89_debug_fw_log_manual_set(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw89_debugfs_priv *debugfs_priv = iocb->ki_filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_fw_log *log = &rtwdev->fw.log;
+	size_t count = iov_iter_count(from);
 	bool fw_log_manual;
 
-	if (kstrtobool_from_user(user_buf, count, &fw_log_manual))
+	if (kstrtobool_from_iter(from, count, &fw_log_manual))
 		goto out;
 
 	mutex_lock(&rtwdev->mutex);
@@ -3807,17 +3800,17 @@ rtw89_debug_priv_disable_dm_get(struct seq_file *m, void *v)
 }
 
 static ssize_t
-rtw89_debug_priv_disable_dm_set(struct file *filp, const char __user *user_buf,
-				size_t count, loff_t *loff)
+rtw89_debug_priv_disable_dm_set(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = (struct seq_file *)filp->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_hal *hal = &rtwdev->hal;
+	size_t count = iov_iter_count(from);
 	u32 conf;
 	int ret;
 
-	ret = kstrtou32_from_user(user_buf, count, 0, &conf);
+	ret = kstrtou32_from_iter(from, count, 0, &conf);
 	if (ret)
 		return -EINVAL;
 
-- 
2.43.0


