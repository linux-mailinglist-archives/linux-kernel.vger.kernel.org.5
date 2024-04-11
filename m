Return-Path: <linux-kernel+bounces-140827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1C28A1922
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B90A1C21A85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2286259;
	Thu, 11 Apr 2024 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DZSmQ56/"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55E8564B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849618; cv=none; b=hQLJYoabU02Q6J08WMPMIf+wWJK+7DA4Z+ppt7rNq2qQtSUQXblsas5k4WQoNPqW0YjVXv9jTP0Z4TzuC0cfVQ4G/IOfdx/fWGEXTSskVEJy3bsjIC1MsL6U+zuuZeoR3N7WC4CxVwwTw5fTiLWCdUT8oKdGloHALp4n63F/p/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849618; c=relaxed/simple;
	bh=2Aknt2fNfmtfzyfGpCI3l2Vhz3PcTOKFW0stXt6FNXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HB/7lNt9ww4l6aZz88hn+Y6GEyVoBtEoHhm3wvw2Hw5FcxpmlDpZPD9hEddSeJbDCPohjsBNVXl0AybCPKWqc1wp0C3QRPFXr1rwbnGNqgthM0xTo0H8A0o6VwXfZFTObUMtS0lntrz8oSXSV/trQHKtOOXWMWMDntOuqZikezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DZSmQ56/; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16116439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849615; x=1713454415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp3aRaK4n7JQXsntmXRZLUnrNQ/JzYe0/RqCvU+dnYw=;
        b=DZSmQ56/iL0VGNCUbFx1cs8P/5frWn1JkaFKuygvBtYhe4YfksjA2PL8rw1ibZaIOS
         KGNB9u+0rX8HgZfNyOmiPLyCP2lHXbfdYbLk59C7Gaad5lMUOuuMTjLBuWQPlEELwzVq
         ++SG8SHkzdMQsgxikW+y9eCJuPkGoXBr93c7Xl4oGPerKat0h6yU+YyuravKFgXPcJcD
         8j8lMuayYBXjNuwSrAeUv3Z/YrC2cTzX+CcgDQhnx6OT08ne+h9+dSeGCLJz0CmDGC7h
         AA38k6QCNfeCYbl0gLn5Ug4+rtWHdsa84LlDl/kCVCH/5MMWboVJDw5QYhk5u9leGwUA
         2Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849615; x=1713454415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp3aRaK4n7JQXsntmXRZLUnrNQ/JzYe0/RqCvU+dnYw=;
        b=Z87Qjuwca14VecO+R85QOWxUag1M+KUhq4WpiVO/+x4Fsg/hc/RtowhjAH+Y8yljMc
         F8GYF6W9sYpaw2NXsBvkhgfA21n8BiGAa6cC9t9/CuAtwGN6CHLvU5Am4dEqoV9TX7FT
         tphx1zwnvFL9c9IulZsWWPsLKvRpl/AQ1sn1x7OSaNVGbCTxjz4vQ7gxHpgvJRdkH+cS
         qYLzivH9vyqrECNIx3219NhVDkbkQWV3htnX8Rh843V+MEXztTsJEdXyqVzqxYXBh1QS
         gjKcGoAUaaWc3TDM4iQwEkbJd0ZrHU5lDYYCrUn85VkgfBRot767Ufv4jzkkee/3UN+W
         agZw==
X-Gm-Message-State: AOJu0YzeayJBR8AVe9tMbym3uOBvQp52UhsKX2WfOCEbclnETFfmSzxy
	rUntqM1t/0ngk51tv9MX1emCAdj6u4pIP3KVt71Q/a1Z+hMxrdboBblN2O9j6f7AcnGP6v69XLa
	c
X-Google-Smtp-Source: AGHT+IFnhyUWht8mSxNssgi4UZlSmb/sZOn59BdTXEp/NBO46sQtt/hUJa/VkmagKdUGt7vfJVRqJQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr174825iov.2.1712849614653;
        Thu, 11 Apr 2024 08:33:34 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 066/437] ASoC: SOF: Core: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:26 -0600
Message-ID: <20240411153126.16201-67-axboe@kernel.dk>
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
 sound/soc/sof/debug.c                         | 34 +++++-----
 sound/soc/sof/sof-client-ipc-flood-test.c     | 19 +++---
 .../soc/sof/sof-client-ipc-kernel-injector.c  | 15 +++--
 sound/soc/sof/sof-client-ipc-msg-injector.c   | 67 +++++++++----------
 sound/soc/sof/sof-client-probes.c             | 31 +++++----
 5 files changed, 85 insertions(+), 81 deletions(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 7c8aafca8fde..c735af9a5f23 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -19,9 +19,9 @@
 #include "sof-priv.h"
 #include "ops.h"
 
-static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
-				  size_t count, loff_t *ppos)
+static ssize_t sof_dfsentry_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	size_t size;
 	char *string;
 	int ret;
@@ -30,19 +30,19 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
 	if (!string)
 		return -ENOMEM;
 
-	size = simple_write_to_buffer(string, count, ppos, buffer, count);
+	size = simple_copy_from_iter(string, &iocb->ki_pos, count, from);
 	ret = size;
 
 	kfree(string);
 	return ret;
 }
 
-static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
-				 size_t count, loff_t *ppos)
+static ssize_t sof_dfsentry_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_sof_dfsentry *dfse = file->private_data;
+	struct snd_sof_dfsentry *dfse = iocb->ki_filp->private_data;
 	struct snd_sof_dev *sdev = dfse->sdev;
-	loff_t pos = *ppos;
+	size_t count = iov_iter_count(to);
+	loff_t pos = iocb->ki_pos;
 	size_t size_ret;
 	int skip = 0;
 	int size;
@@ -66,8 +66,8 @@ static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
 	size = ALIGN(count, 4);
 
 	/* if start position is unaligned, read extra u32 */
-	if (unlikely(pos != *ppos)) {
-		skip = *ppos - pos;
+	if (unlikely(pos != iocb->ki_pos)) {
+		skip = iocb->ki_pos - pos;
 		if (pos + size + 4 < dfse->size)
 			size += 4;
 	}
@@ -109,7 +109,7 @@ static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
 	}
 
 	/* copy to userspace */
-	size_ret = copy_to_user(buffer, buf + skip, count);
+	size_ret = !copy_to_iter_full(buf + skip, count, to);
 
 	kfree(buf);
 
@@ -117,16 +117,15 @@ static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
 	if (size_ret)
 		return -EFAULT;
 
-	*ppos = pos + count;
-
+	iocb->ki_pos = pos + count;
 	return count;
 }
 
 static const struct file_operations sof_dfs_fops = {
 	.open = simple_open,
-	.read = sof_dfsentry_read,
+	.read_iter = sof_dfsentry_read,
 	.llseek = default_llseek,
-	.write = sof_dfsentry_write,
+	.write_iter = sof_dfsentry_write,
 };
 
 /* create FS entry for debug files that can expose DSP memories, registers */
@@ -284,6 +283,11 @@ static ssize_t memory_info_read(struct file *file, char __user *to, size_t count
 	return simple_read_from_buffer(to, count, ppos, dfse->buf, dfse->buf_data_size);
 }
 
+static ssize_t memory_info_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	return vfs_read_iter(iocb, to, memory_info_read);
+}
+
 static int memory_info_open(struct inode *inode, struct file *file)
 {
 	struct snd_sof_dfsentry *dfse = inode->i_private;
@@ -304,7 +308,7 @@ static int memory_info_open(struct inode *inode, struct file *file)
 
 static const struct file_operations memory_info_fops = {
 	.open = memory_info_open,
-	.read = memory_info_read,
+	.read_iter = memory_info_read_iter,
 	.llseek = default_llseek,
 };
 
diff --git a/sound/soc/sof/sof-client-ipc-flood-test.c b/sound/soc/sof/sof-client-ipc-flood-test.c
index c0d6723aed59..6e53d60975c9 100644
--- a/sound/soc/sof/sof-client-ipc-flood-test.c
+++ b/sound/soc/sof/sof-client-ipc-flood-test.c
@@ -238,29 +238,30 @@ static ssize_t sof_ipc_flood_dfs_write(struct file *file, const char __user *buf
 	kfree(string);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(sof_ipc_flood_dfs_write);
 
 /* return the result of the last IPC flood test */
-static ssize_t sof_ipc_flood_dfs_read(struct file *file, char __user *buffer,
-				      size_t count, loff_t *ppos)
+static ssize_t sof_ipc_flood_dfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct sof_client_dev *cdev = file->private_data;
+	struct sof_client_dev *cdev = iocb->ki_filp->private_data;
 	struct sof_ipc_flood_priv *priv = cdev->data;
+	size_t count = iov_iter_count(to);
 	size_t size_ret;
 
 	struct dentry *dentry;
 
-	dentry = file->f_path.dentry;
+	dentry = iocb->ki_filp->f_path.dentry;
 	if (!strcmp(dentry->d_name.name, DEBUGFS_IPC_FLOOD_COUNT) ||
 	    !strcmp(dentry->d_name.name, DEBUGFS_IPC_FLOOD_DURATION)) {
-		if (*ppos)
+		if (iocb->ki_pos)
 			return 0;
 
 		count = min_t(size_t, count, strlen(priv->buf));
-		size_ret = copy_to_user(buffer, priv->buf, count);
+		size_ret = !copy_to_iter_full(priv->buf, count, to);
 		if (size_ret)
 			return -EFAULT;
 
-		*ppos += count;
+		iocb->ki_pos += count;
 		return count;
 	}
 	return count;
@@ -275,9 +276,9 @@ static int sof_ipc_flood_dfs_release(struct inode *inode, struct file *file)
 
 static const struct file_operations sof_ipc_flood_fops = {
 	.open = sof_ipc_flood_dfs_open,
-	.read = sof_ipc_flood_dfs_read,
+	.read_iter = sof_ipc_flood_dfs_read,
 	.llseek = default_llseek,
-	.write = sof_ipc_flood_dfs_write,
+	.write_iter = sof_ipc_flood_dfs_write_iter,
 	.release = sof_ipc_flood_dfs_release,
 
 	.owner = THIS_MODULE,
diff --git a/sound/soc/sof/sof-client-ipc-kernel-injector.c b/sound/soc/sof/sof-client-ipc-kernel-injector.c
index ad0ed2d570a9..77f5d73a126e 100644
--- a/sound/soc/sof/sof-client-ipc-kernel-injector.c
+++ b/sound/soc/sof/sof-client-ipc-kernel-injector.c
@@ -37,21 +37,22 @@ static int sof_msg_inject_dfs_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static ssize_t sof_kernel_msg_inject_dfs_write(struct file *file, const char __user *buffer,
-					       size_t count, loff_t *ppos)
+static ssize_t sof_kernel_msg_inject_dfs_write(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct sof_client_dev *cdev = file->private_data;
+	struct sof_client_dev *cdev = iocb->ki_filp->private_data;
 	struct sof_msg_inject_priv *priv = cdev->data;
 	struct sof_ipc_cmd_hdr *hdr = priv->kernel_buffer;
 	struct device *dev = &cdev->auxdev.dev;
+	size_t count = iov_iter_count(from);
 	ssize_t size;
 	int ret;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
-	size = simple_write_to_buffer(priv->kernel_buffer, priv->max_msg_size,
-				      ppos, buffer, count);
+	size = simple_copy_from_iter(priv->kernel_buffer, &iocb->ki_pos,
+				      priv->max_msg_size, from);
 	if (size < 0)
 		return size;
 	if (size != count)
@@ -82,7 +83,7 @@ static int sof_msg_inject_dfs_release(struct inode *inode, struct file *file)
 
 static const struct file_operations sof_kernel_msg_inject_fops = {
 	.open = sof_msg_inject_dfs_open,
-	.write = sof_kernel_msg_inject_dfs_write,
+	.write_iter = sof_kernel_msg_inject_dfs_write,
 	.release = sof_msg_inject_dfs_release,
 
 	.owner = THIS_MODULE,
diff --git a/sound/soc/sof/sof-client-ipc-msg-injector.c b/sound/soc/sof/sof-client-ipc-msg-injector.c
index e249d3a9afb5..e13f867b4e1e 100644
--- a/sound/soc/sof/sof-client-ipc-msg-injector.c
+++ b/sound/soc/sof/sof-client-ipc-msg-injector.c
@@ -49,37 +49,37 @@ static int sof_msg_inject_dfs_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static ssize_t sof_msg_inject_dfs_read(struct file *file, char __user *buffer,
-				       size_t count, loff_t *ppos)
+static ssize_t sof_msg_inject_dfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct sof_client_dev *cdev = file->private_data;
+	struct sof_client_dev *cdev = iocb->ki_filp->private_data;
 	struct sof_msg_inject_priv *priv = cdev->data;
 	struct sof_ipc_reply *rhdr = priv->rx_buffer;
+	size_t count = iov_iter_count(to);
 
-	if (!rhdr->hdr.size || !count || *ppos)
+	if (!rhdr->hdr.size || !count || iocb->ki_pos)
 		return 0;
 
 	if (count > rhdr->hdr.size)
 		count = rhdr->hdr.size;
 
-	if (copy_to_user(buffer, priv->rx_buffer, count))
+	if (!copy_to_iter_full(priv->rx_buffer, count, to))
 		return -EFAULT;
 
-	*ppos += count;
+	iocb->ki_pos += count;
 	return count;
 }
 
-static ssize_t sof_msg_inject_ipc4_dfs_read(struct file *file,
-					    char __user *buffer,
-					    size_t count, loff_t *ppos)
+static ssize_t sof_msg_inject_ipc4_dfs_read(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct sof_client_dev *cdev = file->private_data;
+	struct sof_client_dev *cdev = iocb->ki_filp->private_data;
 	struct sof_msg_inject_priv *priv = cdev->data;
 	struct sof_ipc4_msg *ipc4_msg = priv->rx_buffer;
 	size_t header_size = sizeof(ipc4_msg->header_u64);
+	size_t count = iov_iter_count(to);
 	size_t remaining;
 
-	if (!ipc4_msg->header_u64 || !count || *ppos)
+	if (!ipc4_msg->header_u64 || !count || iocb->ki_pos)
 		return 0;
 
 	/* we need space for the header at minimum (u64) */
@@ -99,10 +99,10 @@ static ssize_t sof_msg_inject_ipc4_dfs_read(struct file *file,
 		remaining = count;
 
 	/* copy the header first */
-	if (copy_to_user(buffer, &ipc4_msg->header_u64, header_size))
+	if (!copy_to_iter_full(&ipc4_msg->header_u64, header_size, to))
 		return -EFAULT;
 
-	*ppos += header_size;
+	iocb->ki_pos += header_size;
 	remaining -= header_size;
 
 	if (!remaining)
@@ -112,10 +112,10 @@ static ssize_t sof_msg_inject_ipc4_dfs_read(struct file *file,
 		remaining = ipc4_msg->data_size;
 
 	/* Copy the payload */
-	if (copy_to_user(buffer + *ppos, ipc4_msg->data_ptr, remaining))
+	if (!copy_to_iter_full(ipc4_msg->data_ptr, remaining, to))
 		return -EFAULT;
 
-	*ppos += remaining;
+	iocb->ki_pos += remaining;
 	return count;
 }
 
@@ -145,19 +145,19 @@ static int sof_msg_inject_send_message(struct sof_client_dev *cdev)
 	return ret;
 }
 
-static ssize_t sof_msg_inject_dfs_write(struct file *file, const char __user *buffer,
-					size_t count, loff_t *ppos)
+static ssize_t sof_msg_inject_dfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct sof_client_dev *cdev = file->private_data;
+	struct sof_client_dev *cdev = iocb->ki_filp->private_data;
 	struct sof_msg_inject_priv *priv = cdev->data;
+	size_t count = iov_iter_count(from);
 	ssize_t size;
 	int ret;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
-	size = simple_write_to_buffer(priv->tx_buffer, priv->max_msg_size,
-				      ppos, buffer, count);
+	size = simple_copy_from_iter(priv->tx_buffer, &iocb->ki_pos,
+				     priv->max_msg_size, from);
 	if (size < 0)
 		return size;
 	if (size != count)
@@ -174,25 +174,25 @@ static ssize_t sof_msg_inject_dfs_write(struct file *file, const char __user *bu
 	return size;
 };
 
-static ssize_t sof_msg_inject_ipc4_dfs_write(struct file *file,
-					     const char __user *buffer,
-					     size_t count, loff_t *ppos)
+static ssize_t sof_msg_inject_ipc4_dfs_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct sof_client_dev *cdev = file->private_data;
+	struct sof_client_dev *cdev = iocb->ki_filp->private_data;
 	struct sof_msg_inject_priv *priv = cdev->data;
 	struct sof_ipc4_msg *ipc4_msg = priv->tx_buffer;
+	size_t count = iov_iter_count(from);
 	size_t data_size;
 	int ret;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	if (count < sizeof(ipc4_msg->header_u64))
 		return -EINVAL;
 
 	/* copy the header first */
-	if (copy_from_user(&ipc4_msg->header_u64, buffer,
-			   sizeof(ipc4_msg->header_u64)))
+	if (!copy_from_iter_full(&ipc4_msg->header_u64,
+				 sizeof(ipc4_msg->header_u64), from))
 		return -EFAULT;
 
 	data_size = count - sizeof(ipc4_msg->header_u64);
@@ -200,8 +200,7 @@ static ssize_t sof_msg_inject_ipc4_dfs_write(struct file *file,
 		return -EINVAL;
 
 	/* Copy the payload */
-	if (copy_from_user(ipc4_msg->data_ptr,
-			   buffer + sizeof(ipc4_msg->header_u64), data_size))
+	if (!copy_from_iter_full(ipc4_msg->data_ptr, data_size, from))
 		return -EFAULT;
 
 	ipc4_msg->data_size = data_size;
@@ -230,8 +229,8 @@ static int sof_msg_inject_dfs_release(struct inode *inode, struct file *file)
 
 static const struct file_operations sof_msg_inject_fops = {
 	.open = sof_msg_inject_dfs_open,
-	.read = sof_msg_inject_dfs_read,
-	.write = sof_msg_inject_dfs_write,
+	.read_iter = sof_msg_inject_dfs_read,
+	.write_iter = sof_msg_inject_dfs_write,
 	.llseek = default_llseek,
 	.release = sof_msg_inject_dfs_release,
 
@@ -240,8 +239,8 @@ static const struct file_operations sof_msg_inject_fops = {
 
 static const struct file_operations sof_msg_inject_ipc4_fops = {
 	.open = sof_msg_inject_dfs_open,
-	.read = sof_msg_inject_ipc4_dfs_read,
-	.write = sof_msg_inject_ipc4_dfs_write,
+	.read_iter = sof_msg_inject_ipc4_dfs_read,
+	.write_iter = sof_msg_inject_ipc4_dfs_write,
 	.llseek = default_llseek,
 	.release = sof_msg_inject_dfs_release,
 
diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index 30f771ac7bbf..d81da01b6d87 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -188,10 +188,10 @@ static const struct snd_compress_ops sof_probes_compressed_ops = {
 	.copy = sof_probes_compr_copy,
 };
 
-static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
-					  size_t count, loff_t *ppos)
+static ssize_t sof_probes_dfs_points_read(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct sof_client_dev *cdev = file->private_data;
+	struct sof_client_dev *cdev = iocb->ki_filp->private_data;
 	struct sof_probes_priv *priv = cdev->data;
 	struct device *dev = &cdev->auxdev.dev;
 	struct sof_probe_point_desc *desc;
@@ -233,8 +233,7 @@ static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 		}
 	}
 
-	ret = simple_read_from_buffer(to, count, ppos, buf, strlen(buf));
-
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 	kfree(desc);
 
 pm_error:
@@ -249,13 +248,13 @@ static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 }
 
 static ssize_t
-sof_probes_dfs_points_write(struct file *file, const char __user *from,
-			    size_t count, loff_t *ppos)
+sof_probes_dfs_points_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct sof_client_dev *cdev = file->private_data;
+	struct sof_client_dev *cdev = iocb->ki_filp->private_data;
 	struct sof_probes_priv *priv = cdev->data;
 	const struct sof_probes_ipc_ops *ipc = priv->ipc_ops;
 	struct device *dev = &cdev->auxdev.dev;
+	size_t count = iov_iter_count(from);
 	struct sof_probe_point_desc *desc;
 	u32 num_elems, *array;
 	size_t bytes;
@@ -266,7 +265,7 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 		return -ENOENT;
 	}
 
-	ret = parse_int_array_user(from, count, (int **)&array);
+	ret = parse_int_array_iter(from, (int **)&array);
 	if (ret < 0)
 		return ret;
 
@@ -300,21 +299,21 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 
 static const struct file_operations sof_probes_points_fops = {
 	.open = simple_open,
-	.read = sof_probes_dfs_points_read,
-	.write = sof_probes_dfs_points_write,
+	.read_iter = sof_probes_dfs_points_read,
+	.write_iter = sof_probes_dfs_points_write,
 	.llseek = default_llseek,
 
 	.owner = THIS_MODULE,
 };
 
 static ssize_t
-sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
-				   size_t count, loff_t *ppos)
+sof_probes_dfs_points_remove_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct sof_client_dev *cdev = file->private_data;
+	struct sof_client_dev *cdev = iocb->ki_filp->private_data;
 	struct sof_probes_priv *priv = cdev->data;
 	const struct sof_probes_ipc_ops *ipc = priv->ipc_ops;
 	struct device *dev = &cdev->auxdev.dev;
+	size_t count = iov_iter_count(from);
 	int ret, err;
 	u32 *array;
 
@@ -323,7 +322,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 		return -ENOENT;
 	}
 
-	ret = parse_int_array_user(from, count, (int **)&array);
+	ret = parse_int_array_iter(from, (int **)&array);
 	if (ret < 0)
 		return ret;
 
@@ -348,7 +347,7 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 
 static const struct file_operations sof_probes_points_remove_fops = {
 	.open = simple_open,
-	.write = sof_probes_dfs_points_remove_write,
+	.write_iter = sof_probes_dfs_points_remove_write,
 	.llseek = default_llseek,
 
 	.owner = THIS_MODULE,
-- 
2.43.0


