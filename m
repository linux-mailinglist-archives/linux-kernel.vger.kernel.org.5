Return-Path: <linux-kernel+bounces-141074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5818A1A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2991C22D46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73FB1D7804;
	Thu, 11 Apr 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pgtUb0kD"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A23D994
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849999; cv=none; b=C6z8yqN/sAZYBhWBgC66/qHKcz9PVyHmUMt+lIURSvqQxcJnitmTl5En4kGWGF2s9oD9rFB6CCrqlLMUm33w0iGLGRF5ORVUFK6iXIc4CGJ6dFR+w8LxDEGeUp1hiHB4FjOSdDwE2ETxHOvxJ7Xq7GZfsouAG1jv+7oT0g9y7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849999; c=relaxed/simple;
	bh=PbdVf0K/1JPdqb+hLBCBRO0RlaNJgFCGXdvGnloyWdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJaH6yfXtRt7B0f8bpJjSZbhDsCLzUVAPUYXMZqzyO6qHmXy3k2xkUw2tI+IwHuSb0eF/URwGEQxsAN/IBu6rpEFjjtpxclaoY72R78B/XXBtU1g+DOOpDxPNZAz+Z+2nw62UIptNwdRD6tfRcynhSKAb8RzVU8tLQB3GU3Pud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pgtUb0kD; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16220039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849996; x=1713454796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pDARPBcElBGsSHm8QEfTMGjLKvFl8SxKd0i1UsOV8I=;
        b=pgtUb0kDTxLxOIsaMvslieI3WRVNY+mF4vXKlVQr4jLETLJvdpzpohzCpW7ZLNZ8j3
         TWdtCvXC+HERpUgBgtNLxiy0wEZfeNUm2VBfqBQsCdTl3xgldjRw/Cg+y85faCg62brM
         CbilYcXyw68H61XgLr3kjXjpp2LtWWr1WMYIFDQR4ffI3OOmot7RnLQrifEm32y+TlZW
         gbNhfDxd04HukURnXM6NQnwsDKL5teOQK+mxAA3uuBji/wObfa+eKF90HVCDV0FUnkzr
         DGzK4RA/BNyWNOnrhfiOaLYHwtAC3o4Vd0saGJ4nrRaofs8A25jR1k3afxEYjDag62sE
         Wz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849996; x=1713454796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pDARPBcElBGsSHm8QEfTMGjLKvFl8SxKd0i1UsOV8I=;
        b=Ls/xe8w5EVUeiMgEf+OA5cttFShMx1kJldkhjICVlmPqYbr9rk5gdrvVuoByRXlgJV
         39A80s/AhVNhT5YNF3VFqUc+E5m7B8KRuixglYAO9BgzKQDc12wYTeA6gg7DB1+z8T6T
         lC32LfPplop/+TmZloAtqf+UmwuaNACr7IKe9F8hqtA8b114ICb/LaFEmHmp9RvsZcZj
         /UQ1pdlhTUvBu2SV/YAqyHz/6T20ueR/Dctdyf4+jujFSJqv9GXQ4WBBsBlk3K4kpVtH
         8UPTfvU7he6aPGMhPU5HjuthTP9CWWq6sqqVkQOZIsAzT7Zp+3W//pKlWDTyOwxTsrPe
         kB6Q==
X-Gm-Message-State: AOJu0YxtZfZxkflO6eRaUlTcz3o6V0YRBzxs5LcBaz+sZUeTo74zaDGP
	MKPfrzn/QWU3iTDQMYIMog/Hf/vjHcPnixsGASzb49DdYM6Y/xasScT+vNcbX8kEw011egSiDgc
	8
X-Google-Smtp-Source: AGHT+IEAXgN5MwVFD82Eadbq74dT8IJrprZ0LXFpImQ3FnGZHeEAaaV0xxoY30FGXk3VabEtRzcmSA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr171405ioh.1.1712849995641;
        Thu, 11 Apr 2024 08:39:55 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 299/437] drivers/net/wireless/ath/ath6kl: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:19 -0600
Message-ID: <20240411153126.16201-300-axboe@kernel.dk>
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
 drivers/net/wireless/ath/ath6kl/debug.c | 312 +++++++++++-------------
 1 file changed, 144 insertions(+), 168 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/debug.c b/drivers/net/wireless/ath/ath6kl/debug.c
index b837d31416df..f3a7385cf7e5 100644
--- a/drivers/net/wireless/ath/ath6kl/debug.c
+++ b/drivers/net/wireless/ath/ath6kl/debug.c
@@ -297,10 +297,9 @@ void ath6kl_debug_war(struct ath6kl *ar, enum ath6kl_war war)
 	}
 }
 
-static ssize_t read_file_war_stats(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_war_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	char *buf;
 	unsigned int len = 0, buf_len = 1500;
 	ssize_t ret_cnt;
@@ -320,14 +319,14 @@ static ssize_t read_file_war_stats(struct file *file, char __user *user_buf,
 	if (WARN_ON(len > buf_len))
 		len = buf_len;
 
-	ret_cnt = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret_cnt = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 	kfree(buf);
 	return ret_cnt;
 }
 
 static const struct file_operations fops_war_stats = {
-	.read = read_file_war_stats,
+	.read_iter = read_file_war_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -395,10 +394,10 @@ static int ath6kl_fwlog_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ath6kl_fwlog_read(struct file *file, char __user *user_buf,
-				 size_t count, loff_t *ppos)
+static ssize_t ath6kl_fwlog_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct sk_buff *skb;
 	ssize_t ret_cnt;
 	size_t len = 0;
@@ -431,7 +430,7 @@ static ssize_t ath6kl_fwlog_read(struct file *file, char __user *user_buf,
 
 	/* FIXME: what to do if len == 0? */
 
-	ret_cnt = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret_cnt = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 	vfree(buf);
 
@@ -441,17 +440,15 @@ static ssize_t ath6kl_fwlog_read(struct file *file, char __user *user_buf,
 static const struct file_operations fops_fwlog = {
 	.open = ath6kl_fwlog_open,
 	.release = ath6kl_fwlog_release,
-	.read = ath6kl_fwlog_read,
+	.read_iter = ath6kl_fwlog_read,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_fwlog_block_read(struct file *file,
-				       char __user *user_buf,
-				       size_t count,
-				       loff_t *ppos)
+static ssize_t ath6kl_fwlog_block_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct sk_buff *skb;
 	ssize_t ret_cnt;
 	size_t len = 0, not_copied;
@@ -498,13 +495,13 @@ static ssize_t ath6kl_fwlog_block_read(struct file *file,
 
 	/* FIXME: what to do if len == 0? */
 
-	not_copied = copy_to_user(user_buf, buf, len);
+	not_copied = !copy_to_iter_full(buf, len, to);
 	if (not_copied != 0) {
 		ret_cnt = -EFAULT;
 		goto out;
 	}
 
-	*ppos = *ppos + len;
+	iocb->ki_pos += len;
 
 	ret_cnt = len;
 
@@ -517,31 +514,29 @@ static ssize_t ath6kl_fwlog_block_read(struct file *file,
 static const struct file_operations fops_fwlog_block = {
 	.open = ath6kl_fwlog_open,
 	.release = ath6kl_fwlog_release,
-	.read = ath6kl_fwlog_block_read,
+	.read_iter = ath6kl_fwlog_block_read,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_fwlog_mask_read(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath6kl_fwlog_mask_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	char buf[16];
 	int len;
 
 	len = snprintf(buf, sizeof(buf), "0x%x\n", ar->debug.fwlog_mask);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath6kl_fwlog_mask_write(struct file *file,
-				       const char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t ath6kl_fwlog_mask_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 
-	ret = kstrtou32_from_user(user_buf, count, 0, &ar->debug.fwlog_mask);
+	ret = kstrtou32_from_iter(from, count, 0, &ar->debug.fwlog_mask);
 	if (ret)
 		return ret;
 
@@ -556,16 +551,15 @@ static ssize_t ath6kl_fwlog_mask_write(struct file *file,
 
 static const struct file_operations fops_fwlog_mask = {
 	.open = simple_open,
-	.read = ath6kl_fwlog_mask_read,
-	.write = ath6kl_fwlog_mask_write,
+	.read_iter = ath6kl_fwlog_mask_read,
+	.write_iter = ath6kl_fwlog_mask_write,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t read_file_tgt_stats(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t read_file_tgt_stats(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	struct ath6kl_vif *vif;
 	struct target_stats *tgt_stats;
 	char *buf;
@@ -681,14 +675,14 @@ static ssize_t read_file_tgt_stats(struct file *file, char __user *user_buf,
 	if (len > buf_len)
 		len = buf_len;
 
-	ret_cnt = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret_cnt = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 	kfree(buf);
 	return ret_cnt;
 }
 
 static const struct file_operations fops_tgt_stats = {
-	.read = read_file_tgt_stats,
+	.read_iter = read_file_tgt_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -700,11 +694,10 @@ static const struct file_operations fops_tgt_stats = {
 #define CREDIT_INFO_DISPLAY_STRING_LEN	200
 #define CREDIT_INFO_LEN	128
 
-static ssize_t read_file_credit_dist_stats(struct file *file,
-					   char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t read_file_credit_dist_stats(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	struct htc_target *target = ar->htc_target;
 	struct htc_endpoint_credit_dist *ep_list;
 	char *buf;
@@ -747,13 +740,13 @@ static ssize_t read_file_credit_dist_stats(struct file *file,
 	if (len > buf_len)
 		len = buf_len;
 
-	ret_cnt = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret_cnt = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 	return ret_cnt;
 }
 
 static const struct file_operations fops_credit_dist_stats = {
-	.read = read_file_credit_dist_stats,
+	.read_iter = read_file_credit_dist_stats,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -778,11 +771,10 @@ static unsigned int print_endpoint_stat(struct htc_target *target, char *buf,
 	return len;
 }
 
-static ssize_t ath6kl_endpoint_stats_read(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ath6kl_endpoint_stats_read(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	struct htc_target *target = ar->htc_target;
 	char *buf;
 	unsigned int buf_len, len = 0;
@@ -828,22 +820,22 @@ static ssize_t ath6kl_endpoint_stats_read(struct file *file,
 	if (len > buf_len)
 		len = buf_len;
 
-	ret_cnt = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret_cnt = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 	kfree(buf);
 	return ret_cnt;
 }
 
-static ssize_t ath6kl_endpoint_stats_write(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t ath6kl_endpoint_stats_write(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	struct htc_target *target = ar->htc_target;
+	size_t count = iov_iter_count(from);
 	int ret, i;
 	u32 val;
 	struct htc_endpoint_stats *ep_st;
 
-	ret = kstrtou32_from_user(user_buf, count, 0, &val);
+	ret = kstrtou32_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 	if (val == 0) {
@@ -858,8 +850,8 @@ static ssize_t ath6kl_endpoint_stats_write(struct file *file,
 
 static const struct file_operations fops_endpoint_stats = {
 	.open = simple_open,
-	.read = ath6kl_endpoint_stats_read,
-	.write = ath6kl_endpoint_stats_write,
+	.read_iter = ath6kl_endpoint_stats_read,
+	.write_iter = ath6kl_endpoint_stats_write,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
@@ -889,10 +881,9 @@ static bool ath6kl_dbg_is_diag_reg_valid(u32 reg_addr)
 	return false;
 }
 
-static ssize_t ath6kl_regread_read(struct file *file, char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t ath6kl_regread_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	u8 buf[50];
 	unsigned int len = 0;
 
@@ -903,17 +894,16 @@ static ssize_t ath6kl_regread_read(struct file *file, char __user *user_buf,
 		len += scnprintf(buf + len, sizeof(buf) - len,
 				 "All diag registers\n");
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath6kl_regread_write(struct file *file,
-				    const char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t ath6kl_regread_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long reg_addr;
 
-	if (kstrtoul_from_user(user_buf, count, 0, &reg_addr))
+	if (kstrtoul_from_iter(from, count, 0, &reg_addr))
 		return -EINVAL;
 
 	if ((reg_addr % 4) != 0)
@@ -928,8 +918,8 @@ static ssize_t ath6kl_regread_write(struct file *file,
 }
 
 static const struct file_operations fops_diag_reg_read = {
-	.read = ath6kl_regread_read,
-	.write = ath6kl_regread_write,
+	.read_iter = ath6kl_regread_read,
+	.write_iter = ath6kl_regread_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1000,11 +990,10 @@ static int ath6kl_regdump_open(struct inode *inode, struct file *file)
 	return -EIO;
 }
 
-static ssize_t ath6kl_regdump_read(struct file *file, char __user *user_buf,
-				  size_t count, loff_t *ppos)
+static ssize_t ath6kl_regdump_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	u8 *buf = file->private_data;
-	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+	u8 *buf = iocb->ki_filp->private_data;
+	return simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 }
 
 static int ath6kl_regdump_release(struct inode *inode, struct file *file)
@@ -1015,21 +1004,21 @@ static int ath6kl_regdump_release(struct inode *inode, struct file *file)
 
 static const struct file_operations fops_reg_dump = {
 	.open = ath6kl_regdump_open,
-	.read = ath6kl_regdump_read,
+	.read_iter = ath6kl_regdump_read,
 	.release = ath6kl_regdump_release,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_lrssi_roam_write(struct file *file,
-				       const char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t ath6kl_lrssi_roam_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long lrssi_roam_threshold;
 	int ret;
 
-	if (kstrtoul_from_user(user_buf, count, 0, &lrssi_roam_threshold))
+	if (kstrtoul_from_iter(from, count, 0, &lrssi_roam_threshold))
 		return -EINVAL;
 
 	ar->lrssi_roam_threshold = lrssi_roam_threshold;
@@ -1041,53 +1030,48 @@ static ssize_t ath6kl_lrssi_roam_write(struct file *file,
 	return count;
 }
 
-static ssize_t ath6kl_lrssi_roam_read(struct file *file,
-				      char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath6kl_lrssi_roam_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	char buf[32];
 	unsigned int len;
 
 	len = snprintf(buf, sizeof(buf), "%u\n", ar->lrssi_roam_threshold);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_lrssi_roam_threshold = {
-	.read = ath6kl_lrssi_roam_read,
-	.write = ath6kl_lrssi_roam_write,
+	.read_iter = ath6kl_lrssi_roam_read,
+	.write_iter = ath6kl_lrssi_roam_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_regwrite_read(struct file *file,
-				    char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t ath6kl_regwrite_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	u8 buf[32];
 	unsigned int len = 0;
 
 	len = scnprintf(buf, sizeof(buf), "Addr: 0x%x Val: 0x%x\n",
 			ar->debug.diag_reg_addr_wr, ar->debug.diag_reg_val_wr);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath6kl_regwrite_write(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath6kl_regwrite_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[32];
 	char *sptr, *token;
 	unsigned int len = 0;
 	u32 reg_addr, reg_val;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -1117,8 +1101,8 @@ static ssize_t ath6kl_regwrite_write(struct file *file,
 }
 
 static const struct file_operations fops_diag_reg_write = {
-	.read = ath6kl_regwrite_read,
-	.write = ath6kl_regwrite_write,
+	.read_iter = ath6kl_regwrite_read,
+	.write_iter = ath6kl_regwrite_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1157,10 +1141,9 @@ int ath6kl_debug_roam_tbl_event(struct ath6kl *ar, const void *buf,
 	return 0;
 }
 
-static ssize_t ath6kl_roam_table_read(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath6kl_roam_table_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	int ret;
 	long left;
 	struct wmi_target_roam_tbl *tbl;
@@ -1215,31 +1198,31 @@ static ssize_t ath6kl_roam_table_read(struct file *file, char __user *user_buf,
 	if (len > buf_len)
 		len = buf_len;
 
-	ret_cnt = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	ret_cnt = simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 
 	kfree(buf);
 	return ret_cnt;
 }
 
 static const struct file_operations fops_roam_table = {
-	.read = ath6kl_roam_table_read,
+	.read_iter = ath6kl_roam_table_read,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_force_roam_write(struct file *file,
-				       const char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t ath6kl_force_roam_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 	char buf[20];
 	size_t len;
 	u8 bssid[ETH_ALEN];
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 	buf[len] = '\0';
 
@@ -1254,24 +1237,23 @@ static ssize_t ath6kl_force_roam_write(struct file *file,
 }
 
 static const struct file_operations fops_force_roam = {
-	.write = ath6kl_force_roam_write,
+	.write_iter = ath6kl_force_roam_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_roam_mode_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath6kl_roam_mode_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 	char buf[20];
 	size_t len;
 	enum wmi_roam_mode mode;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 	buf[len] = '\0';
 	if (len > 0 && buf[len - 1] == '\n')
@@ -1294,7 +1276,7 @@ static ssize_t ath6kl_roam_mode_write(struct file *file,
 }
 
 static const struct file_operations fops_roam_mode = {
-	.write = ath6kl_roam_mode_write,
+	.write_iter = ath6kl_roam_mode_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
@@ -1305,27 +1287,25 @@ void ath6kl_debug_set_keepalive(struct ath6kl *ar, u8 keepalive)
 	ar->debug.keepalive = keepalive;
 }
 
-static ssize_t ath6kl_keepalive_read(struct file *file, char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t ath6kl_keepalive_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	char buf[16];
 	int len;
 
 	len = snprintf(buf, sizeof(buf), "%u\n", ar->debug.keepalive);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath6kl_keepalive_write(struct file *file,
-				      const char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath6kl_keepalive_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 	u8 val;
 
-	ret = kstrtou8_from_user(user_buf, count, 0, &val);
+	ret = kstrtou8_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -1338,8 +1318,8 @@ static ssize_t ath6kl_keepalive_write(struct file *file,
 
 static const struct file_operations fops_keepalive = {
 	.open = simple_open,
-	.read = ath6kl_keepalive_read,
-	.write = ath6kl_keepalive_write,
+	.read_iter = ath6kl_keepalive_read,
+	.write_iter = ath6kl_keepalive_write,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
@@ -1349,28 +1329,27 @@ void ath6kl_debug_set_disconnect_timeout(struct ath6kl *ar, u8 timeout)
 	ar->debug.disc_timeout = timeout;
 }
 
-static ssize_t ath6kl_disconnect_timeout_read(struct file *file,
-					      char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t ath6kl_disconnect_timeout_read(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	char buf[16];
 	int len;
 
 	len = snprintf(buf, sizeof(buf), "%u\n", ar->debug.disc_timeout);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t ath6kl_disconnect_timeout_write(struct file *file,
-					       const char __user *user_buf,
-					       size_t count, loff_t *ppos)
+static ssize_t ath6kl_disconnect_timeout_write(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 	u8 val;
 
-	ret = kstrtou8_from_user(user_buf, count, 0, &val);
+	ret = kstrtou8_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -1383,17 +1362,17 @@ static ssize_t ath6kl_disconnect_timeout_write(struct file *file,
 
 static const struct file_operations fops_disconnect_timeout = {
 	.open = simple_open,
-	.read = ath6kl_disconnect_timeout_read,
-	.write = ath6kl_disconnect_timeout_write,
+	.read_iter = ath6kl_disconnect_timeout_read,
+	.write_iter = ath6kl_disconnect_timeout_write,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_create_qos_write(struct file *file,
-						const char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t ath6kl_create_qos_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath6kl_vif *vif;
 	char buf[200];
 	ssize_t len;
@@ -1407,7 +1386,7 @@ static ssize_t ath6kl_create_qos_write(struct file *file,
 		return -EIO;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 	buf[len] = '\0';
 	sptr = buf;
@@ -1561,17 +1540,17 @@ static ssize_t ath6kl_create_qos_write(struct file *file,
 }
 
 static const struct file_operations fops_create_qos = {
-	.write = ath6kl_create_qos_write,
+	.write_iter = ath6kl_create_qos_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_delete_qos_write(struct file *file,
-				const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t ath6kl_delete_qos_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath6kl_vif *vif;
 	char buf[100];
 	ssize_t len;
@@ -1584,7 +1563,7 @@ static ssize_t ath6kl_delete_qos_write(struct file *file,
 		return -EIO;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 	buf[len] = '\0';
 	sptr = buf;
@@ -1608,17 +1587,17 @@ static ssize_t ath6kl_delete_qos_write(struct file *file,
 }
 
 static const struct file_operations fops_delete_qos = {
-	.write = ath6kl_delete_qos_write,
+	.write_iter = ath6kl_delete_qos_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_bgscan_int_write(struct file *file,
-				const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t ath6kl_bgscan_int_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath6kl_vif *vif;
 	u16 bgscan_int;
 	char buf[32];
@@ -1629,7 +1608,7 @@ static ssize_t ath6kl_bgscan_int_write(struct file *file,
 		return -EIO;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -1648,17 +1627,16 @@ static ssize_t ath6kl_bgscan_int_write(struct file *file,
 }
 
 static const struct file_operations fops_bgscan_int = {
-	.write = ath6kl_bgscan_int_write,
+	.write_iter = ath6kl_bgscan_int_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_listen_int_write(struct file *file,
-				       const char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t ath6kl_listen_int_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ath6kl_vif *vif;
 	u16 listen_interval;
 	char buf[32];
@@ -1669,7 +1647,7 @@ static ssize_t ath6kl_listen_int_write(struct file *file,
 		return -EIO;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = '\0';
@@ -1686,11 +1664,9 @@ static ssize_t ath6kl_listen_int_write(struct file *file,
 	return count;
 }
 
-static ssize_t ath6kl_listen_int_read(struct file *file,
-				      char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t ath6kl_listen_int_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
 	struct ath6kl_vif *vif;
 	char buf[32];
 	int len;
@@ -1701,22 +1677,22 @@ static ssize_t ath6kl_listen_int_read(struct file *file,
 
 	len = scnprintf(buf, sizeof(buf), "%u\n", vif->listen_intvl_t);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations fops_listen_int = {
-	.read = ath6kl_listen_int_read,
-	.write = ath6kl_listen_int_write,
+	.read_iter = ath6kl_listen_int_read,
+	.write_iter = ath6kl_listen_int_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
 };
 
-static ssize_t ath6kl_power_params_write(struct file *file,
-						const char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t ath6kl_power_params_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct ath6kl *ar = file->private_data;
+	struct ath6kl *ar = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u8 buf[100];
 	unsigned int len = 0;
 	char *sptr, *token;
@@ -1724,7 +1700,7 @@ static ssize_t ath6kl_power_params_write(struct file *file,
 		tx_wakeup, num_tx;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 	buf[len] = '\0';
 	sptr = buf;
@@ -1766,7 +1742,7 @@ static ssize_t ath6kl_power_params_write(struct file *file,
 }
 
 static const struct file_operations fops_power_params = {
-	.write = ath6kl_power_params_write,
+	.write_iter = ath6kl_power_params_write,
 	.open = simple_open,
 	.owner = THIS_MODULE,
 	.llseek = default_llseek,
-- 
2.43.0


