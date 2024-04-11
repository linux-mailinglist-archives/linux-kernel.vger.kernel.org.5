Return-Path: <linux-kernel+bounces-140943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01A08A19BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CE0283450
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259820FA81;
	Thu, 11 Apr 2024 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JqSM9U3T"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624C20125C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849796; cv=none; b=UPDShu5FPPmAryEl9iuJi/s3AbLFmtcC4bV7ncNxQ50/kw8i9t4XNe3coBdAwdsQdKvHiCrjbSvAY/69mX7CZn+IjovC0WWGb8AIbn3LGnP9AYrbcSV5JTadYoBEfeOmeK2UL/JUhB+Eb1pXPe1ijIreeOea3sRk5j20VmVUuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849796; c=relaxed/simple;
	bh=QoRZQDp/masRxhA6PCvHdofG0tdjMZX4GzliI7/aVzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMLwe+bjOP210MdOXOVPw+M21F7W8x3qwtiASUGtCSFFAoCV7wWBpj4kseZhmdvxGdIipQzZZyJ0dF4XjYzcNqG7MlMNydWj/M2tOD9PxLV1qA/gA4vJTp5oyercmd41PuJ702eol9D8QF8KKTY7tY8nRkHvwxgBZNFm9QzQaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JqSM9U3T; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69576939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849794; x=1713454594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SNTwLx8Jm0YhaQgk0A8+JvzjJXzHU6OQ36V4qG+0l0=;
        b=JqSM9U3TeoB/614hvrF4NsxHYaXLs2+kGswTsIsUAdoYpbJ+8ZAepVHp5bma/9Fx81
         JV+BRTYuQEYHut9fw+ruIlJUrgKKkTDSpkTX1oTe2rgYh1nEkXS6RAQ0A6N8m/v9agXl
         FDxbvsfX0ZW7K8L7cbWh8ToigZkuGPjo+yK9WtAAbkhGKh2izZW0dqQwiJ6EKmUpy4l8
         hi1f0eWrkwSzgWEZN8C6XeiHMOiAUXfVslr3KCxWLjxFIOy8J/79ghdMrSsrdlWvH1Kv
         obAe5ThFQEi3VcPmWiP7ZSZwCa3g+p7QdqdRM5S8iGrBnkqBlyXANW5yKSzeNutlIt54
         K19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849794; x=1713454594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SNTwLx8Jm0YhaQgk0A8+JvzjJXzHU6OQ36V4qG+0l0=;
        b=dY3UJ+evrO+QTSOTvCSHmcvyW5k0YxP7z0Kz7sdM3gAXdr0Nw7C9jQQKJexYRniHfj
         jX4evwoPLc0ab+nPI297FBUqCshF2Idx+7WbDpaPToKtd6Fat4OZW5O4OT7L5Dy3cxsZ
         y5XduRC6DBFC0ofM4ngqcSHv9Dpoea2MG2iSiRZGhigDXg9Z1YKGT52BAH2JVd/b1GfU
         WBdNKBXnTq55oLf1rFAlh2w7fyYg3mFv3weCf8jgtt6qGXQPyA8oQxk92FCwj5XkXZB3
         V4KlZWKp97M0QhOnub2+dyy46gxcmzV1fRceTcHF8fRGoHZV4SzbW/bAjkeKWu8C7BD6
         DIsQ==
X-Gm-Message-State: AOJu0Yzc+gD6GE0K0MSK+XzA4+7iF842MDBzFw8FCmsv6YXnyLhi75J1
	g7DPqiQ4fLCVrXMEELVwbtrhcFnBiRq3f+BrcKZSjssVHqJFVK+A0UN3iUp1Vw1gRkQlo+2C4RB
	Q
X-Google-Smtp-Source: AGHT+IH6fLz8AbZCt6XOEm4orJmOLiLUM5ysZOxdu1+f4TK7uKUTEUUVa16soaa2QtJanzApO+pDpA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr194999iop.1.1712849793868;
        Thu, 11 Apr 2024 08:36:33 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 174/437] soc: qcom: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:14 -0600
Message-ID: <20240411153126.16201-175-axboe@kernel.dk>
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
 drivers/soc/qcom/cmd-db.c    |  2 +-
 drivers/soc/qcom/qcom_aoss.c | 14 ++++++-------
 drivers/soc/qcom/rmtfs_mem.c | 38 ++++++++++++++++++------------------
 drivers/soc/qcom/socinfo.c   |  4 ++--
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index a5fd68411bed..0589e63fdb0d 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -308,7 +308,7 @@ static const struct file_operations cmd_db_debugfs_ops = {
 #ifdef CONFIG_DEBUG_FS
 	.open = open_cmd_db_debugfs,
 #endif
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index ca2f6b7629ce..6ce5fdf96432 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -504,11 +504,11 @@ static const struct qmp_debugfs_entry qmp_debugfs_entries[QMP_DEBUGFS_FILES] = {
 	{ "prevent_ddr_collapse", "{class: ddr_mol, res: ddr, val: %s}", true, "mol", "off" },
 };
 
-static ssize_t qmp_debugfs_write(struct file *file, const char __user *user_buf,
-				 size_t count, loff_t *pos)
+static ssize_t qmp_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	const struct qmp_debugfs_entry *entry = NULL;
-	struct qmp *qmp = file->private_data;
+	struct qmp *qmp = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[QMP_MSG_LEN];
 	unsigned int uint_val;
 	const char *str_val;
@@ -517,7 +517,7 @@ static ssize_t qmp_debugfs_write(struct file *file, const char __user *user_buf,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qmp->debugfs_files); i++) {
-		if (qmp->debugfs_files[i] == file->f_path.dentry) {
+		if (qmp->debugfs_files[i] == iocb->ki_filp->f_path.dentry) {
 			entry = &qmp_debugfs_entries[i];
 			break;
 		}
@@ -526,7 +526,7 @@ static ssize_t qmp_debugfs_write(struct file *file, const char __user *user_buf,
 		return -EFAULT;
 
 	if (entry->is_bool) {
-		ret = kstrtobool_from_user(user_buf, count, &bool_val);
+		ret = kstrtobool_from_iter(from, count, &bool_val);
 		if (ret)
 			return ret;
 
@@ -536,7 +536,7 @@ static ssize_t qmp_debugfs_write(struct file *file, const char __user *user_buf,
 		if (ret >= sizeof(buf))
 			return -EINVAL;
 	} else {
-		ret = kstrtou32_from_user(user_buf, count, 0, &uint_val);
+		ret = kstrtou32_from_iter(from, count, 0, &uint_val);
 		if (ret)
 			return ret;
 
@@ -554,7 +554,7 @@ static ssize_t qmp_debugfs_write(struct file *file, const char __user *user_buf,
 
 static const struct file_operations qmp_debugfs_fops = {
 	.open = simple_open,
-	.write = qmp_debugfs_write,
+	.write_iter = qmp_debugfs_write,
 };
 
 static void qmp_debugfs_create(struct qmp *qmp)
diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index df850d073102..065faa808f49 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -15,6 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/uio.h>
 
 #define QCOM_RMTFS_MEM_DEV_MAX	(MINORMASK + 1)
 #define NUM_MAX_VMIDS		2
@@ -79,40 +80,39 @@ static int qcom_rmtfs_mem_open(struct inode *inode, struct file *filp)
 
 	return 0;
 }
-static ssize_t qcom_rmtfs_mem_read(struct file *filp,
-			      char __user *buf, size_t count, loff_t *f_pos)
+static ssize_t qcom_rmtfs_mem_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct qcom_rmtfs_mem *rmtfs_mem = filp->private_data;
+	struct qcom_rmtfs_mem *rmtfs_mem = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 
-	if (*f_pos >= rmtfs_mem->size)
+	if (iocb->ki_pos >= rmtfs_mem->size)
 		return 0;
 
-	if (*f_pos + count >= rmtfs_mem->size)
-		count = rmtfs_mem->size - *f_pos;
+	if (iocb->ki_pos + count >= rmtfs_mem->size)
+		count = rmtfs_mem->size - iocb->ki_pos;
 
-	if (copy_to_user(buf, rmtfs_mem->base + *f_pos, count))
+	if (!copy_to_iter_full(rmtfs_mem->base + iocb->ki_pos, count, to))
 		return -EFAULT;
 
-	*f_pos += count;
+	iocb->ki_pos += count;
 	return count;
 }
 
-static ssize_t qcom_rmtfs_mem_write(struct file *filp,
-			       const char __user *buf, size_t count,
-			       loff_t *f_pos)
+static ssize_t qcom_rmtfs_mem_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct qcom_rmtfs_mem *rmtfs_mem = filp->private_data;
+	struct qcom_rmtfs_mem *rmtfs_mem = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
-	if (*f_pos >= rmtfs_mem->size)
+	if (iocb->ki_pos >= rmtfs_mem->size)
 		return 0;
 
-	if (*f_pos + count >= rmtfs_mem->size)
-		count = rmtfs_mem->size - *f_pos;
+	if (iocb->ki_pos + count >= rmtfs_mem->size)
+		count = rmtfs_mem->size - iocb->ki_pos;
 
-	if (copy_from_user(rmtfs_mem->base + *f_pos, buf, count))
+	if (!copy_from_iter_full(rmtfs_mem->base + iocb->ki_pos, count, from))
 		return -EFAULT;
 
-	*f_pos += count;
+	iocb->ki_pos += count;
 	return count;
 }
 
@@ -152,8 +152,8 @@ static int qcom_rmtfs_mem_mmap(struct file *filep, struct vm_area_struct *vma)
 static const struct file_operations qcom_rmtfs_mem_fops = {
 	.owner = THIS_MODULE,
 	.open = qcom_rmtfs_mem_open,
-	.read = qcom_rmtfs_mem_read,
-	.write = qcom_rmtfs_mem_write,
+	.read_iter = qcom_rmtfs_mem_read,
+	.write_iter = qcom_rmtfs_mem_write,
 	.release = qcom_rmtfs_mem_release,
 	.llseek = default_llseek,
 	.mmap = qcom_rmtfs_mem_mmap,
diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index e8ff9819ac47..fbee271d4646 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -467,7 +467,7 @@ static int qcom_open_##name(struct inode *inode, struct file *file)	\
 									\
 static const struct file_operations qcom_ ##name## _ops = {		\
 	.open = qcom_open_##name,					\
-	.read = seq_read,						\
+	.read_iter = seq_read_iter,					\
 	.llseek = seq_lseek,						\
 	.release = single_release,					\
 }
@@ -570,7 +570,7 @@ static int open_image_##type(struct inode *inode, struct file *file)	  \
 									  \
 static const struct file_operations qcom_image_##type##_ops = {	  \
 	.open = open_image_##type,					  \
-	.read = seq_read,						  \
+	.read_iter = seq_read_iter,					  \
 	.llseek = seq_lseek,						  \
 	.release = single_release,					  \
 }
-- 
2.43.0


