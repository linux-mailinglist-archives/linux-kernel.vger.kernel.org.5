Return-Path: <linux-kernel+bounces-141213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38A8A1B04
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4FF1F280CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23B202A56;
	Thu, 11 Apr 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eTY+R95V"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544C202206
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850217; cv=none; b=gE3VIR1scRaE2WEY91CAySUxbefltG9pZm8MT4zzG2NoYb9yzPaBcD/XbJxZTG39dAYHfPuC6UYJ9WeVIQo0dZzM8q45OFeiHmvzo9oJymTQa1yhx6dcP932NyFRzEkmsALSPuAoyDu41eiqEXZGfvECqMUVs1j7pwvoiRcSVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850217; c=relaxed/simple;
	bh=FWSFCkY8Lf1/0GBdZlqopQYrUyh891nmBgOIC5aP+dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8Cc/PNWIAJ6qOGIIW61g2oOZzdWDYVhDsm1RqWQ05rQCrtKazZPaRKGIIrV67UOk2+pYmZ8vjd6fUDfq8vQSE2JtzVDlr3iE7+4wN8MH7PU5u1YN5iSCs/TeCdQSSJXrtBNz6fhC8rEh+X3JmLdQChxw2W0hX1bUIGIgsx8QsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eTY+R95V; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58292939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850215; x=1713455015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLwLL88UefWixTIzrVWZHbHXvoOS4UC6DoIfisUbT74=;
        b=eTY+R95VgUI9hluxhFnuL+Ape4SLiUbpdDv64Blrre5TCc9xmrN2gmzuygrqpOf+FD
         GbHbwRBBLvoLIlDts/V0obP6ondUR4eyW0zZuJT2flcq++QILPUIZfCdscComDE+qdeB
         8ee8FZpidA0gqAEEtKvZJnEDgEVM4iPXvGRJitjiDDFX4V40xBvRrab4cxjzCYOgsTzN
         suuIwMLsKtdlsa5oLhNDhf4nG3xH+tqjK4daNg7w7kRYmIKJjj+m7as9+xJCSvWllYEv
         WzkeVgD86ym6x8C2W/sV128m8kQigz5BDWtOwdsV9dNpd6QEU2pGZ+GE+A0oiFRgNt6/
         lhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850215; x=1713455015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLwLL88UefWixTIzrVWZHbHXvoOS4UC6DoIfisUbT74=;
        b=eMct2nXZFPd6OxY+JLM5GssxQEopY2vR1DTYceEoQo+KUfTYkKDd/dz/LE6ql4bIHc
         husF18ikCYIK19X+6P4hGeD2zj+RRa2mMeZhJKosYXgASqhqOD5jEFxDVwI6FWtLE9Eg
         vVIc2ralDR9y6DBkllzaVq47XZncMiSq1czYF9g4HO3bg7P2HG5ZrL8BFTSYGekGzo2o
         0r0ht757jA7mm6579vREz6pkXArt9NgPUZ1RLHMTIGaFlALEb9Zuug/hyiB2ouOH17x2
         FHDKwKudJxsC3bQ7LUmhPNUImS7uEPB4heB6nJiIrhorN4bzKceh8raRVpNVFoKAgESu
         ZWgg==
X-Gm-Message-State: AOJu0Yy5sZuLCDwzrqJdR22vw+4Y8Hu07rI8sfW3oIPdkkg9dYZN8DpT
	qp0E65ev6uznIhN33RBkC7kI+jqI+7iFSbdpsqX4m8tUJzCz/hOKaqmCsLBcGLsL1eS5Ppuh7gR
	Z
X-Google-Smtp-Source: AGHT+IGAmBwhKjUn674xvySCfPS+s1FqB4el+9hJ7aOclyXvDi56BJ5HXEl35V+akvOD0aAsHxUXvg==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr215184iog.0.1712850215073;
        Thu, 11 Apr 2024 08:43:35 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 427/437] hwtracing: coresight: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:27 -0600
Message-ID: <20240411153126.16201-428-axboe@kernel.dk>
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
 .../hwtracing/coresight/coresight-cpu-debug.c  | 15 +++++++--------
 drivers/hwtracing/coresight/coresight-etb10.c  | 18 +++++++++---------
 .../hwtracing/coresight/coresight-tmc-core.c   | 14 +++++++-------
 drivers/hwtracing/coresight/ultrasoc-smb.c     | 12 ++++++------
 4 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 1874df7c6a73..5ee3dc600066 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -471,13 +471,13 @@ static int debug_disable_func(void)
 	return err;
 }
 
-static ssize_t debug_func_knob_write(struct file *f,
-		const char __user *buf, size_t count, loff_t *ppos)
+static ssize_t debug_func_knob_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	u8 val;
 	int ret;
 
-	ret = kstrtou8_from_user(buf, count, 2, &val);
+	ret = kstrtou8_from_iter(from, count, 2, &val);
 	if (ret)
 		return ret;
 
@@ -505,8 +505,7 @@ static ssize_t debug_func_knob_write(struct file *f,
 	return ret;
 }
 
-static ssize_t debug_func_knob_read(struct file *f,
-		char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t debug_func_knob_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret;
 	char buf[3];
@@ -515,14 +514,14 @@ static ssize_t debug_func_knob_read(struct file *f,
 	snprintf(buf, sizeof(buf), "%d\n", debug_enable);
 	mutex_unlock(&debug_lock);
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, buf, sizeof(buf));
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, sizeof(buf), to);
 	return ret;
 }
 
 static const struct file_operations debug_func_knob_fops = {
 	.open	= simple_open,
-	.read	= debug_func_knob_read,
-	.write	= debug_func_knob_write,
+	.read_iter	= debug_func_knob_read,
+	.write_iter	= debug_func_knob_write,
 };
 
 static int debug_func_init(void)
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 3aab182b562f..14735de16316 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -610,30 +610,30 @@ static int etb_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t etb_read(struct file *file, char __user *data,
-				size_t len, loff_t *ppos)
+static ssize_t etb_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t len = iov_iter_count(to);
 	u32 depth;
-	struct etb_drvdata *drvdata = container_of(file->private_data,
+	struct etb_drvdata *drvdata = container_of(iocb->ki_filp->private_data,
 						   struct etb_drvdata, miscdev);
 	struct device *dev = &drvdata->csdev->dev;
 
 	etb_dump(drvdata);
 
 	depth = drvdata->buffer_depth;
-	if (*ppos + len > depth * 4)
-		len = depth * 4 - *ppos;
+	if (iocb->ki_pos + len > depth * 4)
+		len = depth * 4 - iocb->ki_pos;
 
-	if (copy_to_user(data, drvdata->buf + *ppos, len)) {
+	if (!copy_to_iter_full(drvdata->buf + iocb->ki_pos, len, to)) {
 		dev_dbg(dev,
 			"%s: copy_to_user failed\n", __func__);
 		return -EFAULT;
 	}
 
-	*ppos += len;
+	iocb->ki_pos += len;
 
 	dev_dbg(dev, "%s: %zu bytes copied, %d bytes left\n",
-		__func__, len, (int)(depth * 4 - *ppos));
+		__func__, len, (int)(depth * 4 - iocb->ki_pos));
 	return len;
 }
 
@@ -650,7 +650,7 @@ static int etb_release(struct inode *inode, struct file *file)
 static const struct file_operations etb_fops = {
 	.owner		= THIS_MODULE,
 	.open		= etb_open,
-	.read		= etb_read,
+	.read_iter	= etb_read,
 	.release	= etb_release,
 	.llseek		= no_llseek,
 };
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 72005b0c633e..337599655242 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -176,24 +176,24 @@ static inline ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
 	return -EINVAL;
 }
 
-static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
-			loff_t *ppos)
+static ssize_t tmc_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t len = iov_iter_count(to);
 	char *bufp;
 	ssize_t actual;
-	struct tmc_drvdata *drvdata = container_of(file->private_data,
+	struct tmc_drvdata *drvdata = container_of(iocb->ki_filp->private_data,
 						   struct tmc_drvdata, miscdev);
-	actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
+	actual = tmc_get_sysfs_trace(drvdata, iocb->ki_pos, len, &bufp);
 	if (actual <= 0)
 		return 0;
 
-	if (copy_to_user(data, bufp, actual)) {
+	if (!copy_to_iter_full(bufp, actual, to)) {
 		dev_dbg(&drvdata->csdev->dev,
 			"%s: copy_to_user failed\n", __func__);
 		return -EFAULT;
 	}
 
-	*ppos += actual;
+	iocb->ki_pos += actual;
 	dev_dbg(&drvdata->csdev->dev, "%zu bytes copied\n", actual);
 
 	return actual;
@@ -216,7 +216,7 @@ static int tmc_release(struct inode *inode, struct file *file)
 static const struct file_operations tmc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= tmc_open,
-	.read		= tmc_read,
+	.read_iter	= tmc_read,
 	.release	= tmc_release,
 	.llseek		= no_llseek,
 };
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index f9ebf20c91e6..27e883e69ce6 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -112,13 +112,13 @@ static int smb_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t smb_read(struct file *file, char __user *data, size_t len,
-			loff_t *ppos)
+static ssize_t smb_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct smb_drv_data *drvdata = container_of(file->private_data,
+	struct smb_drv_data *drvdata = container_of(iocb->ki_filp->private_data,
 					struct smb_drv_data, miscdev);
 	struct smb_data_buffer *sdb = &drvdata->sdb;
 	struct device *dev = &drvdata->csdev->dev;
+	size_t len = iov_iter_count(to);
 	ssize_t to_copy = 0;
 
 	if (!len)
@@ -133,12 +133,12 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
 	if (sdb->buf_rdptr + to_copy > sdb->buf_size)
 		to_copy = sdb->buf_size - sdb->buf_rdptr;
 
-	if (copy_to_user(data, sdb->buf_base + sdb->buf_rdptr, to_copy)) {
+	if (!copy_to_iter_full(sdb->buf_base + sdb->buf_rdptr, to_copy, to)) {
 		dev_dbg(dev, "Failed to copy data to user\n");
 		return -EFAULT;
 	}
 
-	*ppos += to_copy;
+	iocb->ki_pos += to_copy;
 	smb_update_read_ptr(drvdata, to_copy);
 	if (!sdb->data_size)
 		smb_reset_buffer(drvdata);
@@ -161,7 +161,7 @@ static int smb_release(struct inode *inode, struct file *file)
 static const struct file_operations smb_fops = {
 	.owner		= THIS_MODULE,
 	.open		= smb_open,
-	.read		= smb_read,
+	.read_iter	= smb_read,
 	.release	= smb_release,
 	.llseek		= no_llseek,
 };
-- 
2.43.0


