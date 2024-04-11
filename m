Return-Path: <linux-kernel+bounces-140825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E851F8A191F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0E21C21784
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5BB85639;
	Thu, 11 Apr 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LABjQUUP"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D084FB7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849615; cv=none; b=lR55NoTlQJ0XggAMjUlUxCHUXRi9X4IaOdq0ArQ8lIxueHUclx43ogP6Mxpe8LXuGaHZSDwkOzVFYS6Wy1M0XTldYkasRPUncq2WeuKhpCyw6t10wYP8Hd549bOZHATl+A3RJ16tBd8t8caB7ZSpzm6aSYK/eM3Z4IA1Ey/pcGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849615; c=relaxed/simple;
	bh=ho5BYy4kjaNliS0dta3eXDNM6tashxw66DjHd8RfcUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUtoFunElu/mxyz0gxA6M4mNdVcISYJujrKcuIPe2QSjN4XzF6MY+b3uNzvky4F4vlj1ToGxPdlwzCYlreKpEtC9wtTMzCyM+6+fEALp5hc7f1l6BwbCqU9cjwuktCRL8RPKZix2+FmT+rOfYPX7yxgBh9wqdx7yBDvctbmWun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LABjQUUP; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8886339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849613; x=1713454413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeXF07ow4/eUdAaHGHjqzj3DOsbnM3ucSWi9ZbxCRt4=;
        b=LABjQUUPGirHHTyR+91vudx0l0QgSNBxAuigGWXvmeO2PIQIGx/rCEEoM/3qgD0yCR
         MRxNX2f3rxzWfJYBmVd10NY5iRzCS1l5XACcC1y4R0B+JHm2ysTUIIf0wG5lCBTm/3Jp
         spDXCFTMr+Ech67QuP57gCu7VmkXx8s0CDlS2jC9rTfAljruEUotoPl7/40UBiSESC8R
         8pnmrsUO2SYGN29ey90C7OdrJy4s2/wzJXPO4IZK3py2jDr2li7GWSIEdNrZdySjzYHP
         DMSJ3Q9OADbzfX3CD9bGcB3ha0yogJp6L3F249hqWhTl1YsThjK+cP1qq00/ITT3+wYe
         4QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849613; x=1713454413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeXF07ow4/eUdAaHGHjqzj3DOsbnM3ucSWi9ZbxCRt4=;
        b=h1H0xL0Wmwx8vyqsKBVxkhvxWaKrMEN5K4QYIMizU4T2oqcbobrFnXaQ87wCJO90th
         B0xJ4ItG+2DFMSdhjuQXMk+W49IvkQsdAaJZQ53hULQfzoKiVtpicgZ5zxWWhVNwyVw4
         HQTwSWITJDVAm9FypNOU//w7or5HxVgS15aiTqWrwPqDlEFC5VGOHsosxXp0qv5zSBE5
         z5faQf/Lz2lTVck/+vKf82U7rblmnAewtAaW7SRDULowoZ7d7/ncU5n7lMD0UiCsJAZZ
         QXJYtOay1aIYjen7KxC1nBjtOnfO4/Pm8wyvfPu46+pgHECj6/e+QOhgf8XsJplXFz9J
         mniA==
X-Gm-Message-State: AOJu0Yyj3v6I2HhHp64HideGmWa6N1s1OtzovrNIQYuPoxEyyPxwaUFl
	VLLVwiSIix92Wb1IGLz0FX1hf6x6E8BV93rpdHhXAB5/za93cVpkREz6T2izOF4t3Xw3PFlrhol
	I
X-Google-Smtp-Source: AGHT+IFwbKV6QcKE6nqVwb1dWUEeMiR97kz3ImI6jz4Vk3g7S9cz4TZs43H+GmNOgQLLZHk3+hXRlA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr173742ioj.2.1712849612818;
        Thu, 11 Apr 2024 08:33:32 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 065/437] SoC: SOF: icp4: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:25 -0600
Message-ID: <20240411153126.16201-66-axboe@kernel.dk>
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
 sound/soc/sof/ipc4-mtrace.c    | 17 +++++++++--------
 sound/soc/sof/ipc4-telemetry.c | 14 +++++++-------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/sound/soc/sof/ipc4-mtrace.c b/sound/soc/sof/ipc4-mtrace.c
index 0e04bea9432d..976951a486b5 100644
--- a/sound/soc/sof/ipc4-mtrace.c
+++ b/sound/soc/sof/ipc4-mtrace.c
@@ -274,6 +274,7 @@ static ssize_t sof_ipc4_mtrace_dfs_read(struct file *file, char __user *buffer,
 
 	return count;
 }
+FOPS_READ_ITER_HELPER(sof_ipc4_mtrace_dfs_read);
 
 static int sof_ipc4_mtrace_dfs_release(struct inode *inode, struct file *file)
 {
@@ -291,17 +292,17 @@ static int sof_ipc4_mtrace_dfs_release(struct inode *inode, struct file *file)
 
 static const struct file_operations sof_dfs_mtrace_fops = {
 	.open = sof_ipc4_mtrace_dfs_open,
-	.read = sof_ipc4_mtrace_dfs_read,
+	.read_iter = sof_ipc4_mtrace_dfs_read_iter,
 	.llseek = default_llseek,
 	.release = sof_ipc4_mtrace_dfs_release,
 
 	.owner = THIS_MODULE,
 };
 
-static ssize_t sof_ipc4_priority_mask_dfs_read(struct file *file, char __user *to,
-					       size_t count, loff_t *ppos)
+static ssize_t sof_ipc4_priority_mask_dfs_read(struct kiocb *iocb,
+					       struct iov_iter *to)
 {
-	struct sof_mtrace_priv *priv = file->private_data;
+	struct sof_mtrace_priv *priv = iocb->ki_filp->private_data;
 	int i, ret, offset, remaining;
 	char *buf;
 
@@ -322,8 +323,7 @@ static ssize_t sof_ipc4_priority_mask_dfs_read(struct file *file, char __user *t
 			 priv->state_info.logs_priorities_mask[i]);
 	}
 
-	ret = simple_read_from_buffer(to, count, ppos, buf, strlen(buf));
-
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 	kfree(buf);
 	return ret;
 }
@@ -368,11 +368,12 @@ static ssize_t sof_ipc4_priority_mask_dfs_write(struct file *file,
 	kfree(buf);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(sof_ipc4_priority_mask_dfs_write);
 
 static const struct file_operations sof_dfs_priority_mask_fops = {
 	.open = simple_open,
-	.read = sof_ipc4_priority_mask_dfs_read,
-	.write = sof_ipc4_priority_mask_dfs_write,
+	.read_iter = sof_ipc4_priority_mask_dfs_read,
+	.write_iter = sof_ipc4_priority_mask_dfs_write_iter,
 	.llseek = default_llseek,
 
 	.owner = THIS_MODULE,
diff --git a/sound/soc/sof/ipc4-telemetry.c b/sound/soc/sof/ipc4-telemetry.c
index ec4ae9674364..8b4ef6ae8753 100644
--- a/sound/soc/sof/ipc4-telemetry.c
+++ b/sound/soc/sof/ipc4-telemetry.c
@@ -32,13 +32,13 @@ static void __iomem *sof_ipc4_query_exception_address(struct snd_sof_dev *sdev)
 	return sdev->bar[sdev->mailbox_bar] + offset;
 }
 
-static ssize_t sof_telemetry_entry_read(struct file *file, char __user *buffer,
-					size_t count, loff_t *ppos)
+static ssize_t sof_telemetry_entry_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_sof_dfsentry *dfse = file->private_data;
+	struct snd_sof_dfsentry *dfse = iocb->ki_filp->private_data;
 	struct snd_sof_dev *sdev = dfse->sdev;
+	size_t count = iov_iter_count(to);
 	void __iomem *io_addr;
-	loff_t pos = *ppos;
+	loff_t pos = iocb->ki_pos;
 	size_t size_ret;
 	u8 *buf;
 
@@ -59,13 +59,13 @@ static ssize_t sof_telemetry_entry_read(struct file *file, char __user *buffer,
 		return -ENOMEM;
 
 	memcpy_fromio(buf, io_addr, SOF_IPC4_DEBUG_SLOT_SIZE - 4);
-	size_ret = copy_to_user(buffer, buf + pos, count);
+	size_ret = !copy_to_iter_full(buf + pos, count, to);
 	if (size_ret) {
 		kfree(buf);
 		return -EFAULT;
 	}
 
-	*ppos = pos + count;
+	iocb->ki_pos = pos + count;
 	kfree(buf);
 
 	return count;
@@ -73,7 +73,7 @@ static ssize_t sof_telemetry_entry_read(struct file *file, char __user *buffer,
 
 static const struct file_operations sof_telemetry_fops = {
 	.open = simple_open,
-	.read = sof_telemetry_entry_read,
+	.read_iter = sof_telemetry_entry_read,
 };
 
 void sof_ipc4_create_exception_debugfs_node(struct snd_sof_dev *sdev)
-- 
2.43.0


