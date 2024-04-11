Return-Path: <linux-kernel+bounces-141102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989A38A1A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F166D283D44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04631635B1;
	Thu, 11 Apr 2024 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="i943tt7p"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FBD4AEFD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850039; cv=none; b=DeIX7g1UExy7AXhtxxVbCgEglvF4gd6W4LcOsIikiKdj1ZpYaMvNms0vjaKZw7pHVV7vuxgV8JubPLEgEYdL3+L6cg7tjKpWxOzHnQDEymuyyaPB+/XO8LAkzEdNdK5A3+dEof/5rVBJtvyyD/gldzZlOWPWousr6Tf/nwndFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850039; c=relaxed/simple;
	bh=405uQ2rR/lcTUIgbmVA0LVxEMeerWkCm2zv42gtUQg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9kWXYxhqAIAo+XJXnx4pOQj9RGc03cEjBK9aLsppOk/0V2DgTHn1nBIqeCtClCG7PWwzEfcj0LS34M/V2MAEz9aAEJIUjM/ZI88ggBsIK+lAOjsRuli/tg3TWNMC8sFeePGLe5KY+4Mzo4AIwTodFYInCK1WUvlZ3w/XioXl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=i943tt7p; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16237739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850035; x=1713454835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdt71NQPxQDStZfuHnytDGqHTCr7sKvVymAo1oxe0Gk=;
        b=i943tt7pWTPp1Xce4VbsRblnykxVgAzOXHzDcXtk8iwbL5WzA+FIscq7DKWO21k8Au
         zNsUIs6ItTPON0Wnjw+CoGh/+CP2VbxTuMJr06x7xOtN33clCH2reeJhWWxrWix3cvWb
         lLvRLfzTObyFAZe2lizVUI2wh4HXEq40ECSi95/ihQSGf7+OujJxVzdIJeyIE7xnvm1D
         hpOZjS98HRVLUT1zSdaijw5gNfNHhmvFyMPLS8V7Xoux+P+ExYPGeg6O3iT4wDJGva/T
         S9+svDaSfrm8Y4e0j0irl6EABjjK9UpptODFIPEdaky7QPh5GeyJj9m1DoBGdSil9IBH
         5oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850035; x=1713454835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdt71NQPxQDStZfuHnytDGqHTCr7sKvVymAo1oxe0Gk=;
        b=hWK0qLnRYGDSDyyQ1bjmg8aLLK1TLvsWgAcZSD3Ve9Bh03Y7OaigkK9yA04Qtrlk9v
         0EUlJEhxb9gz8EmG8OKStFr1AL1Y8CURm2vNgF4QZPqNpAtUhp+wi1E7IZyj7YpkL2E8
         /dhjvb8auVePK2CRIVkqn0kdvVZqfWGXbA8jd0Wbhatpid2m+myG0BG/x4+BOUW9pqmX
         km79hJ3G7NUWpL8TNPlmbz9Qv8m+MlRd6d2OY/rUeKbtq1BL/usmCQlgj/s56mCZR4Ko
         dwWaE7u6RHGL4NbK6FLBcPxv82bwDuF1QPp0oR2OoWNssdZxsOBl6iYWLm4bmvmMHGXm
         3rRQ==
X-Gm-Message-State: AOJu0Yx3SDpJGyYFQUt6SSGQKA3VfnZh3DIb6e/kt8OfgGHUOXXFWoWy
	+/nOqHxOS8b8IumdggHfhl0Kok6FJ8+P53K/1h/JmmrHYCrcvBFuw8vXBvIKAuTcqJx8HgpyGXd
	e
X-Google-Smtp-Source: AGHT+IEbbEbiJE1PBIxF91ZwwL8HArlbBVGZ1yPnPGl2C4SwGJEeJp4D+lFe8n+Rhh6MemxAGJ2gNg==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr173491ioh.1.1712850035415;
        Thu, 11 Apr 2024 08:40:35 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 323/437] drivers/net/ethernet/intel: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:43 -0600
Message-ID: <20240411153126.16201-324-axboe@kernel.dk>
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
 .../net/ethernet/intel/fm10k/fm10k_debugfs.c  |  10 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 103 +++++-----
 drivers/net/ethernet/intel/ice/ice_debugfs.c  | 181 ++++++++----------
 .../net/ethernet/intel/ixgbe/ixgbe_debugfs.c  |  99 ++++------
 4 files changed, 173 insertions(+), 220 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index 5c77054d67c6..7995883a2c27 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -132,11 +132,11 @@ static int fm10k_dbg_desc_open(struct inode *inode, struct file *filep)
 }
 
 static const struct file_operations fm10k_dbg_desc_fops = {
-	.owner   = THIS_MODULE,
-	.open    = fm10k_dbg_desc_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
+	.owner     = THIS_MODULE,
+	.open      = fm10k_dbg_desc_open,
+	.read_iter = seq_read_iter,
+	.llseek    = seq_lseek,
+	.release   = seq_release,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index f9ba45f596c9..0afab111d1d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -43,23 +43,22 @@ static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
 static char i40e_dbg_command_buf[256] = "";
 
 /**
- * i40e_dbg_command_read - read for command datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
+ * i40e_dbg_command_read_iter - read for command datum
+ * @iocb: the kernel io callback (kiocb) struct
+ * @to: iovec iterator
  **/
-static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
-				     size_t count, loff_t *ppos)
+static ssize_t i40e_dbg_command_read_iter(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct i40e_pf *pf = filp->private_data;
-	int bytes_not_copied;
+	struct i40e_pf *pf = iocb->ki_filp->private_data;
 	int buf_size = 256;
 	char *buf;
 	int len;
+	size_t count = iov_iter_count(to);
+	bool ret;
 
 	/* don't allow partial reads */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 	if (count < buf_size)
 		return -ENOSPC;
@@ -72,13 +71,13 @@ static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
 		       pf->vsi[pf->lan_vsi]->netdev->name,
 		       i40e_dbg_command_buf);
 
-	bytes_not_copied = copy_to_user(buffer, buf, len);
+	ret = !copy_to_iter_full(buf, len, to);
 	kfree(buf);
 
-	if (bytes_not_copied)
+	if (ret)
 		return -EFAULT;
 
-	*ppos = len;
+	iocb->ki_pos = len;
 	return len;
 }
 
@@ -742,34 +741,30 @@ static void i40e_dbg_dump_vf_all(struct i40e_pf *pf)
 }
 
 /**
- * i40e_dbg_command_write - write into command datum
- * @filp: the opened file
- * @buffer: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
+ * i40e_dbg_command_write_iter - write into command datum
+ * @iocb: the kernel io callback (kiocb) struct
+ * @from: iovec iterator
  **/
-static ssize_t i40e_dbg_command_write(struct file *filp,
-				      const char __user *buffer,
-				      size_t count, loff_t *ppos)
+static ssize_t i40e_dbg_command_write_iter(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct i40e_pf *pf = filp->private_data;
+	struct i40e_pf *pf = iocb->ki_filp->private_data;
 	char *cmd_buf, *cmd_buf_tmp;
-	int bytes_not_copied;
 	struct i40e_vsi *vsi;
 	int vsi_seid;
 	int veb_seid;
 	int vf_id;
 	int cnt;
+	size_t count = iov_iter_count(from);
 
 	/* don't allow partial writes */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
 	if (!cmd_buf)
 		return count;
-	bytes_not_copied = copy_from_user(cmd_buf, buffer, count);
-	if (bytes_not_copied) {
+	if (!copy_from_iter_full(cmd_buf, count, from)) {
 		kfree(cmd_buf);
 		return -EFAULT;
 	}
@@ -1617,8 +1612,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 static const struct file_operations i40e_dbg_command_fops = {
 	.owner = THIS_MODULE,
 	.open =  simple_open,
-	.read =  i40e_dbg_command_read,
-	.write = i40e_dbg_command_write,
+	.read_iter =  i40e_dbg_command_read_iter,
+	.write_iter = i40e_dbg_command_write_iter,
 };
 
 /**************************************************************
@@ -1629,23 +1624,22 @@ static const struct file_operations i40e_dbg_command_fops = {
 static char i40e_dbg_netdev_ops_buf[256] = "";
 
 /**
- * i40e_dbg_netdev_ops_read - read for netdev_ops datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
+ * i40e_dbg_netdev_ops_read_iter - read for netdev_ops datum
+ * @iocb: the kernel io callback (kiocb) struct
+ * @to: iovec iterator
  **/
-static ssize_t i40e_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
-					size_t count, loff_t *ppos)
+static ssize_t i40e_dbg_netdev_ops_read_iter(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
-	struct i40e_pf *pf = filp->private_data;
-	int bytes_not_copied;
+	struct i40e_pf *pf = iocb->ki_filp->private_data;
 	int buf_size = 256;
 	char *buf;
 	int len;
+	bool ret;
+	size_t count = iov_iter_count(to);
 
 	/* don't allow partal reads */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 	if (count < buf_size)
 		return -ENOSPC;
@@ -1658,44 +1652,39 @@ static ssize_t i40e_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
 		       pf->vsi[pf->lan_vsi]->netdev->name,
 		       i40e_dbg_netdev_ops_buf);
 
-	bytes_not_copied = copy_to_user(buffer, buf, len);
+	ret = !copy_to_iter_full(buf, len, to);
 	kfree(buf);
 
-	if (bytes_not_copied)
+	if (ret)
 		return -EFAULT;
 
-	*ppos = len;
+	iocb->ki_pos = len;
 	return len;
 }
 
 /**
- * i40e_dbg_netdev_ops_write - write into netdev_ops datum
- * @filp: the opened file
- * @buffer: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
+ * i40e_dbg_netdev_ops_write_iter - write into netdev_ops datum
+ * @iocb: the kernel io callback (kiocb) struct
+ * @from: iovec iterator
  **/
-static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
-					 const char __user *buffer,
-					 size_t count, loff_t *ppos)
+static ssize_t i40e_dbg_netdev_ops_write_iter(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct i40e_pf *pf = filp->private_data;
-	int bytes_not_copied;
+	struct i40e_pf *pf = iocb->ki_filp->private_data;
 	struct i40e_vsi *vsi;
 	char *buf_tmp;
 	int vsi_seid;
 	int i, cnt;
+	size_t count = iov_iter_count(from);
 
 	/* don't allow partial writes */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 	if (count >= sizeof(i40e_dbg_netdev_ops_buf))
 		return -ENOSPC;
 
 	memset(i40e_dbg_netdev_ops_buf, 0, sizeof(i40e_dbg_netdev_ops_buf));
-	bytes_not_copied = copy_from_user(i40e_dbg_netdev_ops_buf,
-					  buffer, count);
-	if (bytes_not_copied)
+	if (!copy_from_iter_full(i40e_dbg_netdev_ops_buf, count, from))
 		return -EFAULT;
 	i40e_dbg_netdev_ops_buf[count] = '\0';
 
@@ -1784,8 +1773,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 static const struct file_operations i40e_dbg_netdev_ops_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = i40e_dbg_netdev_ops_read,
-	.write = i40e_dbg_netdev_ops_write,
+	.read_iter = i40e_dbg_netdev_ops_read_iter,
+	.write_iter = i40e_dbg_netdev_ops_write_iter,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 9fc0fd95a13d..6ec1e04972c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -151,27 +151,25 @@ static int ice_debugfs_module_open(struct inode *inode, struct file *filp)
 }
 
 /**
- * ice_debugfs_module_write - write into 'module' file
- * @filp: the opened file
- * @buf: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
+ * ice_debugfs_module_write_iter - write into 'module' file
+ * @iocb: the kernel io callback (kiocb) struct
+ * @from: iovec iterator
  */
 static ssize_t
-ice_debugfs_module_write(struct file *filp, const char __user *buf,
-			 size_t count, loff_t *ppos)
+ice_debugfs_module_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ice_pf *pf = file_inode(filp)->i_private;
-	struct dentry *dentry = file_dentry(filp);
+	struct ice_pf *pf = file_inode(iocb->ki_filp)->i_private;
+	struct dentry *dentry = file_dentry(iocb->ki_filp);
 	struct device *dev = ice_pf_to_dev(pf);
 	char user_val[16], *cmd_buf;
 	int module, log_level, cnt;
+	size_t count = iov_iter_count(from);
 
 	/* don't allow partial writes or invalid input */
-	if (*ppos != 0 || count > 8)
+	if (iocb->ki_pos != 0 || count > 8)
 		return -EINVAL;
 
-	cmd_buf = memdup_user_nul(buf, count);
+	cmd_buf = iterdup_nul(from, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
@@ -209,55 +207,50 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 static const struct file_operations ice_debugfs_module_fops = {
 	.owner = THIS_MODULE,
 	.open  = ice_debugfs_module_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.release = single_release,
-	.write = ice_debugfs_module_write,
+	.write_iter = ice_debugfs_module_write_iter,
 };
 
 /**
- * ice_debugfs_nr_messages_read - read from 'nr_messages' file
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
+ * ice_debugfs_nr_messages_read_iter - read from 'nr_messages' file
+ * @iocb: the kernel io callback (kiocb) struct
+ * @to: iovec iterator
  */
-static ssize_t ice_debugfs_nr_messages_read(struct file *filp,
-					    char __user *buffer, size_t count,
-					    loff_t *ppos)
+static ssize_t ice_debugfs_nr_messages_read_iter(struct kiocb *iocb,
+						 struct iov_iter *to)
 {
-	struct ice_pf *pf = filp->private_data;
+	struct ice_pf *pf = iocb->ki_filp->private_data;
 	struct ice_hw *hw = &pf->hw;
 	char buff[32] = {};
 
 	snprintf(buff, sizeof(buff), "%d\n",
 		 hw->fwlog_cfg.log_resolution);
 
-	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
+	return simple_copy_to_iter(buff, &iocb->ki_pos, strlen(buff), to);
 }
 
 /**
- * ice_debugfs_nr_messages_write - write into 'nr_messages' file
- * @filp: the opened file
- * @buf: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
+ * ice_debugfs_nr_messages_write_iter - write into 'nr_messages' file
+ * @iocb: the kernel io callback (kiocb) struct
+ * @from: iovec iterator
  */
 static ssize_t
-ice_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
-			      size_t count, loff_t *ppos)
+ice_debugfs_nr_messages_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ice_pf *pf = filp->private_data;
+	struct ice_pf *pf = iocb->ki_filp->private_data;
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	char user_val[8], *cmd_buf;
 	s16 nr_messages;
 	ssize_t ret;
+	size_t count = iov_iter_count(from);
 
 	/* don't allow partial writes or invalid input */
-	if (*ppos != 0 || count > 4)
+	if (iocb->ki_pos != 0 || count > 4)
 		return -EINVAL;
 
-	cmd_buf = memdup_user_nul(buf, count);
+	cmd_buf = iterdup_nul(from, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
@@ -285,22 +278,19 @@ ice_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
 static const struct file_operations ice_debugfs_nr_messages_fops = {
 	.owner = THIS_MODULE,
 	.open  = simple_open,
-	.read = ice_debugfs_nr_messages_read,
-	.write = ice_debugfs_nr_messages_write,
+	.read_iter = ice_debugfs_nr_messages_read_iter,
+	.write_iter = ice_debugfs_nr_messages_write_iter,
 };
 
 /**
- * ice_debugfs_enable_read - read from 'enable' file
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
+ * ice_debugfs_enable_read_iter - read from 'enable' file
+ * @iocb: the kernel io callback (kiocb) struct
+ * @to: iovec iterator
  */
-static ssize_t ice_debugfs_enable_read(struct file *filp,
-				       char __user *buffer, size_t count,
-				       loff_t *ppos)
+static ssize_t ice_debugfs_enable_read_iter(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct ice_pf *pf = filp->private_data;
+	struct ice_pf *pf = iocb->ki_filp->private_data;
 	struct ice_hw *hw = &pf->hw;
 	char buff[32] = {};
 
@@ -308,31 +298,29 @@ static ssize_t ice_debugfs_enable_read(struct file *filp,
 		 (u16)(hw->fwlog_cfg.options &
 		 ICE_FWLOG_OPTION_IS_REGISTERED) >> 3);
 
-	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
+	return simple_copy_to_iter(buff, &iocb->ki_pos, strlen(buff), to);
 }
 
 /**
- * ice_debugfs_enable_write - write into 'enable' file
- * @filp: the opened file
- * @buf: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
+ * ice_debugfs_enable_write_iter - write into 'enable' file
+ * @iocb: the kernel io callback (kiocb) struct
+ * @from: iovec iterator
  */
 static ssize_t
-ice_debugfs_enable_write(struct file *filp, const char __user *buf,
-			 size_t count, loff_t *ppos)
+ice_debugfs_enable_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ice_pf *pf = filp->private_data;
+	struct ice_pf *pf = iocb->ki_filp->private_data;
 	struct ice_hw *hw = &pf->hw;
 	char user_val[8], *cmd_buf;
 	bool enable;
 	ssize_t ret;
+	size_t count = iov_iter_count(from);
 
 	/* don't allow partial writes or invalid input */
-	if (*ppos != 0 || count > 2)
+	if (iocb->ki_pos != 0 || count > 2)
 		return -EINVAL;
 
-	cmd_buf = memdup_user_nul(buf, count);
+	cmd_buf = iterdup_nul(from, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
@@ -380,22 +368,19 @@ ice_debugfs_enable_write(struct file *filp, const char __user *buf,
 static const struct file_operations ice_debugfs_enable_fops = {
 	.owner = THIS_MODULE,
 	.open  = simple_open,
-	.read = ice_debugfs_enable_read,
-	.write = ice_debugfs_enable_write,
+	.read_iter = ice_debugfs_enable_read_iter,
+	.write_iter = ice_debugfs_enable_write_iter,
 };
 
 /**
- * ice_debugfs_log_size_read - read from 'log_size' file
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
+ * ice_debugfs_log_size_read_iter - read from 'log_size' file
+ * @iocb: the kernel io callback (kiocb) struct
+ * @to: iovec iterator
  */
-static ssize_t ice_debugfs_log_size_read(struct file *filp,
-					 char __user *buffer, size_t count,
-					 loff_t *ppos)
+static ssize_t ice_debugfs_log_size_read_iter(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	struct ice_pf *pf = filp->private_data;
+	struct ice_pf *pf = iocb->ki_filp->private_data;
 	struct ice_hw *hw = &pf->hw;
 	char buff[32] = {};
 	int index;
@@ -403,32 +388,30 @@ static ssize_t ice_debugfs_log_size_read(struct file *filp,
 	index = hw->fwlog_ring.index;
 	snprintf(buff, sizeof(buff), "%s\n", ice_fwlog_log_size[index]);
 
-	return simple_read_from_buffer(buffer, count, ppos, buff, strlen(buff));
+	return simple_copy_to_iter(buff, &iocb->ki_pos, strlen(buff), to);
 }
 
 /**
- * ice_debugfs_log_size_write - write into 'log_size' file
- * @filp: the opened file
- * @buf: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
+ * ice_debugfs_log_size_write_iter - write into 'log_size' file
+ * @iocb: the kernel io callback (kiocb) struct
+ * @from: iovec iterator
  */
 static ssize_t
-ice_debugfs_log_size_write(struct file *filp, const char __user *buf,
-			   size_t count, loff_t *ppos)
+ice_debugfs_log_size_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ice_pf *pf = filp->private_data;
+	struct ice_pf *pf = iocb->ki_filp->private_data;
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	char user_val[8], *cmd_buf;
 	ssize_t ret;
 	int index;
+	size_t count = iov_iter_count(from);
 
 	/* don't allow partial writes or invalid input */
-	if (*ppos != 0 || count > 5)
+	if (iocb->ki_pos != 0 || count > 5)
 		return -EINVAL;
 
-	cmd_buf = memdup_user_nul(buf, count);
+	cmd_buf = iterdup_nul(from, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
@@ -470,24 +453,23 @@ ice_debugfs_log_size_write(struct file *filp, const char __user *buf,
 static const struct file_operations ice_debugfs_log_size_fops = {
 	.owner = THIS_MODULE,
 	.open  = simple_open,
-	.read = ice_debugfs_log_size_read,
-	.write = ice_debugfs_log_size_write,
+	.read_iter = ice_debugfs_log_size_read_iter,
+	.write_iter = ice_debugfs_log_size_write_iter,
 };
 
 /**
- * ice_debugfs_data_read - read from 'data' file
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
+ * ice_debugfs_data_read_iter - read from 'data' file
+ * @iocb: the kernel io callback (kiocb) struct
+ * @to: iovec iterator
  */
-static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
-				     size_t count, loff_t *ppos)
+static ssize_t ice_debugfs_data_read_iter(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct ice_pf *pf = filp->private_data;
+	struct ice_pf *pf = iocb->ki_filp->private_data;
 	struct ice_hw *hw = &pf->hw;
 	int data_copied = 0;
 	bool done = false;
+	size_t count = iov_iter_count(to);
 
 	if (ice_fwlog_ring_empty(&hw->fwlog_ring))
 		return 0;
@@ -503,7 +485,7 @@ static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
 			continue;
 		}
 
-		if (copy_to_user(buffer, log->data, cur_buf_len)) {
+		if (!copy_to_iter_full(log->data, cur_buf_len, to)) {
 			/* if there is an error then bail and return whatever
 			 * the driver has copied so far
 			 */
@@ -512,9 +494,8 @@ static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
 		}
 
 		data_copied += cur_buf_len;
-		buffer += cur_buf_len;
 		count -= cur_buf_len;
-		*ppos += cur_buf_len;
+		iocb->ki_pos += cur_buf_len;
 		ice_fwlog_ring_increment(&hw->fwlog_ring.head,
 					 hw->fwlog_ring.size);
 	}
@@ -523,23 +504,21 @@ static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
 }
 
 /**
- * ice_debugfs_data_write - write into 'data' file
- * @filp: the opened file
- * @buf: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
+ * ice_debugfs_data_write_iter - write into 'data' file
+ * @iocb: the kernel io callback (kiocb) struct
+ * @from: iovec iterator
  */
 static ssize_t
-ice_debugfs_data_write(struct file *filp, const char __user *buf, size_t count,
-		       loff_t *ppos)
+ice_debugfs_data_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ice_pf *pf = filp->private_data;
+	struct ice_pf *pf = iocb->ki_filp->private_data;
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	ssize_t ret;
+	size_t count = iov_iter_count(from);
 
 	/* don't allow partial writes */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	/* any value is allowed to clear the buffer so no need to even look at
@@ -573,8 +552,8 @@ ice_debugfs_data_write(struct file *filp, const char __user *buf, size_t count,
 static const struct file_operations ice_debugfs_data_fops = {
 	.owner = THIS_MODULE,
 	.open  = simple_open,
-	.read = ice_debugfs_data_read,
-	.write = ice_debugfs_data_write,
+	.read_iter = ice_debugfs_data_read_iter,
+	.write_iter = ice_debugfs_data_write_iter,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
index 5b1cf49df3d3..077dd26e7079 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
@@ -10,16 +10,17 @@ static struct dentry *ixgbe_dbg_root;
 
 static char ixgbe_dbg_reg_ops_buf[256] = "";
 
-static ssize_t ixgbe_dbg_common_ops_read(struct file *filp, char __user *buffer,
-					 size_t count, loff_t *ppos,
+static ssize_t ixgbe_dbg_common_ops_read(struct kiocb *iocb,
+					 struct iov_iter *to,
 					 char *dbg_buf)
 {
-	struct ixgbe_adapter *adapter = filp->private_data;
+	struct ixgbe_adapter *adapter = iocb->ki_filp->private_data;
 	char *buf;
 	int len;
+	size_t count = iov_iter_count(to);
 
 	/* don't allow partial reads */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	buf = kasprintf(GFP_KERNEL, "%s: %s\n",
@@ -32,51 +33,43 @@ static ssize_t ixgbe_dbg_common_ops_read(struct file *filp, char __user *buffer,
 		return -ENOSPC;
 	}
 
-	len = simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
+	len = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 
 	kfree(buf);
 	return len;
 }
 
 /**
- * ixgbe_dbg_reg_ops_read - read for reg_ops datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
+ * ixgbe_dbg_reg_ops_read_iter - read for reg_ops datum
+ * @iocb: the kernel io callback (kiocb) struct
+ * @to: iovec iterator
  **/
-static ssize_t ixgbe_dbg_reg_ops_read(struct file *filp, char __user *buffer,
-				      size_t count, loff_t *ppos)
+static ssize_t ixgbe_dbg_reg_ops_read_iter(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	return ixgbe_dbg_common_ops_read(filp, buffer, count, ppos,
-					 ixgbe_dbg_reg_ops_buf);
+	return ixgbe_dbg_common_ops_read(iocb, to, ixgbe_dbg_reg_ops_buf);
 }
 
 /**
- * ixgbe_dbg_reg_ops_write - write into reg_ops datum
- * @filp: the opened file
- * @buffer: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
+ * ixgbe_dbg_reg_ops_write_iter - write into reg_ops datum
+ * @iocb: the kernel io callback (kiocb) struct
+ * @from: iovec iterator
  **/
-static ssize_t ixgbe_dbg_reg_ops_write(struct file *filp,
-				     const char __user *buffer,
-				     size_t count, loff_t *ppos)
+static ssize_t ixgbe_dbg_reg_ops_write_iter(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct ixgbe_adapter *adapter = filp->private_data;
+	struct ixgbe_adapter *adapter = iocb->ki_filp->private_data;
 	int len;
+	size_t count = iov_iter_count(from);
 
 	/* don't allow partial writes */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 	if (count >= sizeof(ixgbe_dbg_reg_ops_buf))
 		return -ENOSPC;
 
-	len = simple_write_to_buffer(ixgbe_dbg_reg_ops_buf,
-				     sizeof(ixgbe_dbg_reg_ops_buf)-1,
-				     ppos,
-				     buffer,
-				     count);
+	len = simple_copy_from_iter(ixgbe_dbg_reg_ops_buf, &iocb->ki_pos,
+				    sizeof(ixgbe_dbg_reg_ops_buf) - 1, from);
 	if (len < 0)
 		return len;
 
@@ -115,51 +108,43 @@ static ssize_t ixgbe_dbg_reg_ops_write(struct file *filp,
 static const struct file_operations ixgbe_dbg_reg_ops_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read =  ixgbe_dbg_reg_ops_read,
-	.write = ixgbe_dbg_reg_ops_write,
+	.read_iter = ixgbe_dbg_reg_ops_read_iter,
+	.write_iter = ixgbe_dbg_reg_ops_write_iter,
 };
 
 static char ixgbe_dbg_netdev_ops_buf[256] = "";
 
 /**
- * ixgbe_dbg_netdev_ops_read - read for netdev_ops datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
+ * ixgbe_dbg_netdev_ops_read_iter - read for netdev_ops datum
+ * @iocb: the kernel io callback (kiocb) struct
+ * @to: iovec iterator
  **/
-static ssize_t ixgbe_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
-					 size_t count, loff_t *ppos)
+static ssize_t ixgbe_dbg_netdev_ops_read_iter(struct kiocb *iocb,
+					      struct iov_iter *to)
 {
-	return ixgbe_dbg_common_ops_read(filp, buffer, count, ppos,
-					 ixgbe_dbg_netdev_ops_buf);
+	return ixgbe_dbg_common_ops_read(iocb, to, ixgbe_dbg_netdev_ops_buf);
 }
 
 /**
- * ixgbe_dbg_netdev_ops_write - write into netdev_ops datum
- * @filp: the opened file
- * @buffer: where to find the user's data
- * @count: the length of the user's data
- * @ppos: file position offset
+ * ixgbe_dbg_netdev_ops_write_iter - write into netdev_ops datum
+ * @iocb: the kernel io callback (kiocb) struct
+ * @from: iovec iterator
  **/
-static ssize_t ixgbe_dbg_netdev_ops_write(struct file *filp,
-					  const char __user *buffer,
-					  size_t count, loff_t *ppos)
+static ssize_t ixgbe_dbg_netdev_ops_write_iter(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct ixgbe_adapter *adapter = filp->private_data;
+	struct ixgbe_adapter *adapter = iocb->ki_filp->private_data;
 	int len;
+	size_t count = iov_iter_count(from);
 
 	/* don't allow partial writes */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 	if (count >= sizeof(ixgbe_dbg_netdev_ops_buf))
 		return -ENOSPC;
 
-	len = simple_write_to_buffer(ixgbe_dbg_netdev_ops_buf,
-				     sizeof(ixgbe_dbg_netdev_ops_buf)-1,
-				     ppos,
-				     buffer,
-				     count);
+	len = simple_copy_from_iter(ixgbe_dbg_netdev_ops_buf, &iocb->ki_pos,
+				    sizeof(ixgbe_dbg_netdev_ops_buf) - 1, from);
 	if (len < 0)
 		return len;
 
@@ -181,8 +166,8 @@ static ssize_t ixgbe_dbg_netdev_ops_write(struct file *filp,
 static const struct file_operations ixgbe_dbg_netdev_ops_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = ixgbe_dbg_netdev_ops_read,
-	.write = ixgbe_dbg_netdev_ops_write,
+	.read_iter = ixgbe_dbg_netdev_ops_read_iter,
+	.write_iter = ixgbe_dbg_netdev_ops_write_iter,
 };
 
 /**
-- 
2.43.0


