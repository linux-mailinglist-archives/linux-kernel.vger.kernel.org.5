Return-Path: <linux-kernel+bounces-141107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85F8A1A84
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C321F2199D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F204D584;
	Thu, 11 Apr 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sVgxSy4j"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0AE1E4988
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850049; cv=none; b=a0wldWrTQpM5m1PGFz17w2OVIPIKpNxBJIMUY8Cm1t6RqhCcrT1SYWPz/dsdnQQ+hWPZOHBNafGY6onOSH1V4+9iVr48oonJOioQQKDktUHAIjyqYN8ck0y/p7Yb+VZEfa55nMbvOMjAd/FddQ7Tqvm+CO5YBdjGKHc8qRLO9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850049; c=relaxed/simple;
	bh=GH5C7Q8Nylvc+7im/FUXVIy9mBwai9l8JAoYCIyN0XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsOtV6fn7Ehg4VwPZT+vBdcVK/e4w2/po0Kf9IU9q2/1G9+nDDdhu0fvZBo9VgKuUtFQrT9UGL8djL9B+Rf6QKQl4A7pMfrpJLb+PD3BQp+6K/Ni0GUWBu2d0HIPGVSmwWQ02m/Z8dbInA0+e/m9PHEtBOEc5MiBU7GsYe5RzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sVgxSy4j; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16240439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850046; x=1713454846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hshnkl01c0BziUyf4evDZWs+mKErvhNG3KYBvzjNMIg=;
        b=sVgxSy4jXQBGyCEfBf2Z+MbMdzv+uvXbhoyRGsr1eT1fFzmQ0wD2J6z+zVF5IaD2y9
         2R8L4cKMqk9soF9KqDecx31BvKwk3FYIBVMU3LgajXnYnNgRwaCEq2p5XZdSnxVoL1v3
         utmXj6FBf1mqJouRmGcBLxvdY4qrJP1Ke0OCHrVHWXDvSCKNSSBk9KVFgl6pcFPC7eip
         YQr6HAV33KGva/jQX7IDs4EB83xTm/UJQqfWnwPYWKsO3T9PPQkvGywpO4HAXIHxJ6H3
         U7WJDP348Plv8h0V3jqTtgIwisbQvDgFy0LWcYHOUhqvyTDNRMha0kiSobAD1jmwW5wP
         2H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850046; x=1713454846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hshnkl01c0BziUyf4evDZWs+mKErvhNG3KYBvzjNMIg=;
        b=ezk09op34FJcsKOR3nrON8EE7tls0pS8SxQWN3StZokuKJxGlZpxsoJOZK+xLB03MP
         U++x+lNFUR5c/y956yZhM6tpT/MfSZ46E+fC3mMF9xvLesUd4byQdaEkcHNBRAVJ3zh0
         XaJYzfJ/V21TffrJ2bggNdoadIAa96nroPQ4B9NIUAZH+dEzCWfsGftijYjgrGKcSEJt
         1q71knW2nN6KBsMLapLrdK2k5QnOWZr2LVQV/W9eV1r1tkH4T5tVseKmrz493BsV/oAq
         w1ogDccquMYQL0JZkpBf3qx5JHJqaCsBCplFrzgQKCopTFpcImGqypjXfnlnt3JRwO0r
         k+NQ==
X-Gm-Message-State: AOJu0YzggcLjCUssMH6oT3mL1/2QQKFOMCbOkxlOAOPpyA0Bz0EQM5FF
	0GsmhRuMdeiSskvVrTwNTIfbbDWAbsd1mEVcsc7xsbvydvkpi4NHwm9QznuP0rpOKJbUO9Anh3T
	M
X-Google-Smtp-Source: AGHT+IF6PZVmq5jfNH6WAhjxQKNF2FTgX8qJtJCrLbQjShiCOGn6Ps2HxJV7ammRghSjl0Z2e34k1w==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr199522iov.2.1712850046289;
        Thu, 11 Apr 2024 08:40:46 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 329/437] drivers/net/ethernet/mellanox/mlx5/core: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:49 -0600
Message-ID: <20240411153126.16201-330-axboe@kernel.dk>
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 78 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/debugfs.c | 49 ++++++------
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 13 ++--
 3 files changed, 69 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 4957412ff1f6..fecd1553fac5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1246,13 +1246,13 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 	return err ? : status;
 }
 
-static ssize_t dbg_write(struct file *filp, const char __user *buf,
-			 size_t count, loff_t *pos)
+static ssize_t dbg_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mlx5_core_dev *dev = filp->private_data;
+	struct mlx5_core_dev *dev = iocb->ki_filp->private_data;
 	struct mlx5_cmd_debug *dbg = &dev->cmd.dbg;
 	char lbuf[3];
 	int err;
+	size_t count = iov_iter_count(from);
 
 	if (!dbg->in_msg || !dbg->out_msg)
 		return -ENOMEM;
@@ -1260,7 +1260,7 @@ static ssize_t dbg_write(struct file *filp, const char __user *buf,
 	if (count < sizeof(lbuf) - 1)
 		return -EINVAL;
 
-	if (copy_from_user(lbuf, buf, sizeof(lbuf) - 1))
+	if (!copy_from_iter_full(lbuf, sizeof(lbuf) - 1, from))
 		return -EFAULT;
 
 	lbuf[sizeof(lbuf) - 1] = 0;
@@ -1274,9 +1274,9 @@ static ssize_t dbg_write(struct file *filp, const char __user *buf,
 }
 
 static const struct file_operations fops = {
-	.owner	= THIS_MODULE,
-	.open	= simple_open,
-	.write	= dbg_write,
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.write_iter	= dbg_write_iter,
 };
 
 static int mlx5_copy_to_msg(struct mlx5_cmd_msg *to, void *from, int size,
@@ -1435,54 +1435,56 @@ static void mlx5_free_cmd_msg(struct mlx5_core_dev *dev,
 	kfree(msg);
 }
 
-static ssize_t data_write(struct file *filp, const char __user *buf,
-			  size_t count, loff_t *pos)
+static ssize_t data_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mlx5_core_dev *dev = filp->private_data;
+	struct mlx5_core_dev *dev = iocb->ki_filp->private_data;
 	struct mlx5_cmd_debug *dbg = &dev->cmd.dbg;
 	void *ptr;
+	size_t count = iov_iter_count(from);
 
-	if (*pos != 0)
+	if (iocb->ki_pos != 0)
 		return -EINVAL;
 
 	kfree(dbg->in_msg);
 	dbg->in_msg = NULL;
 	dbg->inlen = 0;
-	ptr = memdup_user(buf, count);
-	if (IS_ERR(ptr))
-		return PTR_ERR(ptr);
+	ptr = kmalloc(count, GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	if (!copy_from_iter_full(ptr, count, from))
+		return -EFAULT;
+
 	dbg->in_msg = ptr;
 	dbg->inlen = count;
 
-	*pos = count;
+	iocb->ki_pos = count;
 
 	return count;
 }
 
-static ssize_t data_read(struct file *filp, char __user *buf, size_t count,
-			 loff_t *pos)
+static ssize_t data_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mlx5_core_dev *dev = filp->private_data;
+	struct mlx5_core_dev *dev = iocb->ki_filp->private_data;
 	struct mlx5_cmd_debug *dbg = &dev->cmd.dbg;
 
 	if (!dbg->out_msg)
 		return -ENOMEM;
 
-	return simple_read_from_buffer(buf, count, pos, dbg->out_msg,
-				       dbg->outlen);
+	return simple_copy_to_iter(dbg->out_msg, &iocb->ki_pos,
+				   dbg->outlen, to);
 }
 
 static const struct file_operations dfops = {
-	.owner	= THIS_MODULE,
-	.open	= simple_open,
-	.write	= data_write,
-	.read	= data_read,
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.write_iter	= data_write_iter,
+	.read_iter	= data_read_iter,
 };
 
-static ssize_t outlen_read(struct file *filp, char __user *buf, size_t count,
-			   loff_t *pos)
+static ssize_t outlen_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mlx5_core_dev *dev = filp->private_data;
+	struct mlx5_core_dev *dev = iocb->ki_filp->private_data;
 	struct mlx5_cmd_debug *dbg = &dev->cmd.dbg;
 	char outlen[8];
 	int err;
@@ -1491,27 +1493,27 @@ static ssize_t outlen_read(struct file *filp, char __user *buf, size_t count,
 	if (err < 0)
 		return err;
 
-	return simple_read_from_buffer(buf, count, pos, outlen, err);
+	return simple_copy_to_iter(outlen, &iocb->ki_pos, err, to);
 }
 
-static ssize_t outlen_write(struct file *filp, const char __user *buf,
-			    size_t count, loff_t *pos)
+static ssize_t outlen_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mlx5_core_dev *dev = filp->private_data;
+	struct mlx5_core_dev *dev = iocb->ki_filp->private_data;
 	struct mlx5_cmd_debug *dbg = &dev->cmd.dbg;
 	char outlen_str[8] = {0};
 	int outlen;
 	void *ptr;
 	int err;
+	size_t count = iov_iter_count(from);
 
-	if (*pos != 0 || count > 6)
+	if (iocb->ki_pos != 0 || count > 6)
 		return -EINVAL;
 
 	kfree(dbg->out_msg);
 	dbg->out_msg = NULL;
 	dbg->outlen = 0;
 
-	if (copy_from_user(outlen_str, buf, count))
+	if (!copy_from_iter_full(outlen_str, count, from))
 		return -EFAULT;
 
 	err = sscanf(outlen_str, "%d", &outlen);
@@ -1525,16 +1527,16 @@ static ssize_t outlen_write(struct file *filp, const char __user *buf,
 	dbg->out_msg = ptr;
 	dbg->outlen = outlen;
 
-	*pos = count;
+	iocb->ki_pos = count;
 
 	return count;
 }
 
 static const struct file_operations olfops = {
-	.owner	= THIS_MODULE,
-	.open	= simple_open,
-	.write	= outlen_write,
-	.read	= outlen_read,
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.write_iter	= outlen_write_iter,
+	.read_iter	= outlen_read_iter,
 };
 
 static void set_wqname(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 09652dc89115..090b5b5d0acd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -126,48 +126,46 @@ void mlx5_eq_debugfs_cleanup(struct mlx5_core_dev *dev)
 	debugfs_remove_recursive(dev->priv.dbg.eq_debugfs);
 }
 
-static ssize_t average_read(struct file *filp, char __user *buf, size_t count,
-			    loff_t *pos)
+static ssize_t average_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct mlx5_cmd_stats *stats;
 	u64 field = 0;
 	int ret;
 	char tbuf[22];
 
-	stats = filp->private_data;
+	stats = iocb->ki_filp->private_data;
 	spin_lock_irq(&stats->lock);
 	if (stats->n)
 		field = div64_u64(stats->sum, stats->n);
 	spin_unlock_irq(&stats->lock);
 	ret = snprintf(tbuf, sizeof(tbuf), "%llu\n", field);
-	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+	return simple_copy_to_iter(tbuf, &iocb->ki_pos, ret, to);
 }
 
-static ssize_t average_write(struct file *filp, const char __user *buf,
-			     size_t count, loff_t *pos)
+static ssize_t average_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct mlx5_cmd_stats *stats;
+	size_t count = iov_iter_count(from);
 
-	stats = filp->private_data;
+	stats = iocb->ki_filp->private_data;
 	spin_lock_irq(&stats->lock);
 	stats->sum = 0;
 	stats->n = 0;
 	spin_unlock_irq(&stats->lock);
 
-	*pos += count;
+	iocb->ki_pos += count;
 
 	return count;
 }
 
 static const struct file_operations stats_fops = {
-	.owner	= THIS_MODULE,
-	.open	= simple_open,
-	.read	= average_read,
-	.write	= average_write,
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.read_iter	= average_read_iter,
+	.write_iter	= average_write_iter,
 };
 
-static ssize_t slots_read(struct file *filp, char __user *buf, size_t count,
-			  loff_t *pos)
+static ssize_t slots_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct mlx5_cmd *cmd;
 	char tbuf[6];
@@ -175,17 +173,17 @@ static ssize_t slots_read(struct file *filp, char __user *buf, size_t count,
 	int field;
 	int ret;
 
-	cmd = filp->private_data;
+	cmd = iocb->ki_filp->private_data;
 	weight = bitmap_weight(&cmd->vars.bitmask, cmd->vars.max_reg_cmds);
 	field = cmd->vars.max_reg_cmds - weight;
 	ret = snprintf(tbuf, sizeof(tbuf), "%d\n", field);
-	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+	return simple_copy_to_iter(tbuf, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations slots_fops = {
-	.owner	= THIS_MODULE,
-	.open	= simple_open,
-	.read	= slots_read,
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.read_iter	= slots_read_iter,
 };
 
 static struct mlx5_cmd_stats *
@@ -445,8 +443,7 @@ static u64 cq_read_field(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
 	return param;
 }
 
-static ssize_t dbg_read(struct file *filp, char __user *buf, size_t count,
-			loff_t *pos)
+static ssize_t dbg_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct mlx5_field_desc *desc;
 	struct mlx5_rsc_debug *d;
@@ -455,7 +452,7 @@ static ssize_t dbg_read(struct file *filp, char __user *buf, size_t count,
 	u64 field;
 	int ret;
 
-	desc = filp->private_data;
+	desc = iocb->ki_filp->private_data;
 	d = (void *)(desc - desc->i) - sizeof(*d);
 	switch (d->type) {
 	case MLX5_DBG_RSC_QP:
@@ -480,13 +477,13 @@ static ssize_t dbg_read(struct file *filp, char __user *buf, size_t count,
 	else
 		ret = snprintf(tbuf, sizeof(tbuf), "0x%llx\n", field);
 
-	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+	return simple_copy_to_iter(tbuf, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations fops = {
-	.owner	= THIS_MODULE,
-	.open	= simple_open,
-	.read	= dbg_read,
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.read_iter	= dbg_read_iter,
 };
 
 static int add_res_tree(struct mlx5_core_dev *dev, enum dbg_rsc_type type,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 5b28084e8a03..09429b069c20 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -393,24 +393,23 @@ static void sd_print_group(struct mlx5_core_dev *primary)
 			MLX5_CAP_GEN(pos, vhca_id));
 }
 
-static ssize_t dev_read(struct file *filp, char __user *buf, size_t count,
-			loff_t *pos)
+static ssize_t dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct mlx5_core_dev *dev;
 	char tbuf[32];
 	int ret;
 
-	dev = filp->private_data;
+	dev = iocb->ki_filp->private_data;
 	ret = snprintf(tbuf, sizeof(tbuf), "%s vhca %#x\n", pci_name(dev->pdev),
 		       MLX5_CAP_GEN(dev, vhca_id));
 
-	return simple_read_from_buffer(buf, count, pos, tbuf, ret);
+	return simple_copy_to_iter(tbuf, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations dev_fops = {
-	.owner	= THIS_MODULE,
-	.open	= simple_open,
-	.read	= dev_read,
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.read_iter	= dev_read_iter,
 };
 
 int mlx5_sd_init(struct mlx5_core_dev *dev)
-- 
2.43.0


