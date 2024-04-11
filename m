Return-Path: <linux-kernel+bounces-141131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33518A1A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E6D1F22ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F541EBAA8;
	Thu, 11 Apr 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CchsWpeA"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317FF1EBA8A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850089; cv=none; b=aT4qkkCCJuJllK1IsiogUpHqQ17ZXlQWpLQAiuqZReXMfrg1AklzrP7UMpJCU3CVWkNHHPi83G0rwiNd1wC4ZxovvzjV01tX1SuRkrGeuC0wVcaySfQ8Qc+MX8CCEFBSqM7bF2rvsVNFvebCVL61YM7cftSUW+55XBTFfRmXvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850089; c=relaxed/simple;
	bh=QJteW7i68cwnY3Y2bm+Ww6wE0YkpdTNZ3omi3GC4MsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZC0wS2UZNi8xUXCKudIKHJkiIFbZnr7thYXliHXptxRglqSTKw1wcgire4gYoEypyU4SoWpA1K4nx3N6z8XYiFHce6nbvBdmWDFQ/6wTTqp0uCyn37ucOjAK36OoyZTGMqDFmnJnrW/MOgP4voM5fsugFgCqSwOa1HBlSuX1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CchsWpeA; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9075639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850087; x=1713454887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kEvqhQ5LFfdp981O6GSEMdHofirq0cwf5eb9gFKuSk=;
        b=CchsWpeAYHy+y/f8Rf5+7XT9lPaN8JdfJmqDOV6Cjg8fmDP6UPMJ+FJ0hVJQf0Ici7
         co67/Q5GHlFUUd0rtaIha4Tsn4GltpCPDME8lNw2TjL0XdKPi5UEeRWkY2imZbRn2zBF
         RrSO31jzROUD+dSJcIBVGzZO2CM2iI40YrAwUIIxKtInn/+Q+XhVQbuJYjbeBMbkApyz
         oggXhZlAZILKfJgo5ukdwKx/E90c+/HvYqGvI+sW3XmxB9r8MF3frt/EXGMPlKZhsk2a
         hZX/VH+ugAZ+quh2QSOpbEQT1CLTYIl2y4mqMyqbL9gYjesGR1ZKJYyFt0ESVkI/ZMJD
         YI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850087; x=1713454887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kEvqhQ5LFfdp981O6GSEMdHofirq0cwf5eb9gFKuSk=;
        b=vKuCJz9NFZD59GudbL0YlHgePWSxHrUKUcP7J9xX9FCgHJ8S5rFTULrZGacp+J6+X3
         E6TA6geIc3Tc8hAOteGC+uOIENk6kYpt0c+VVQXXuCIgNb36GqAjBV2BcljHRHd5TWKm
         ij4+eqi+8xPQdXAUDlBGDIUvJ31nqbRgVGIw9t8yVM9937wQtRRK230Qn4MjruCYS0lh
         8ToSMROBpk8xLYiYh0uLi+XUrLAPCksWdvviivYqamDrGd37nSglDjDgR4GwyC3NYE2m
         FPelfLZfZ8vcM07KB3aj4OJhv0ldkx+jbs01HNS1uKgN49lV1v4k9VKAr6jeeep72ipY
         bj7g==
X-Gm-Message-State: AOJu0YynXl4zuAeFAl2MablPffc0tMBsELjMXlEou0H1X5+nC5p1zxCU
	CgDFypu/gA+UuDu0q7SoAP7K1+poAeqiBJGwxGbd0LgwjL7pX3Rstc4tvkPqoIE9ZBTe8V+5V5u
	c
X-Google-Smtp-Source: AGHT+IHEgLT0SJNBvnKplEIoBHnTZ1IMIm7R5VKqhvV7/ORgCuRvD0NHlsZ5jQ5Yw+S6fQ4PxM6IYA==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr30632ioc.1.1712850086829;
        Thu, 11 Apr 2024 08:41:26 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 353/437] arch/s390: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:13 -0600
Message-ID: <20240411153126.16201-354-axboe@kernel.dk>
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
 arch/s390/crypto/prng.c      | 18 ++++++++----------
 arch/s390/hypfs/hypfs_dbfs.c | 11 +++++------
 arch/s390/kernel/debug.c     | 29 +++++++++++++----------------
 arch/s390/kernel/sysinfo.c   |  6 +++---
 arch/s390/pci/pci_debug.c    | 12 ++++++------
 5 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index a077087bc6cc..472ff3fe73a9 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -509,9 +509,9 @@ static int prng_open(struct inode *inode, struct file *file)
 }
 
 
-static ssize_t prng_tdes_read(struct file *file, char __user *ubuf,
-			      size_t nbytes, loff_t *ppos)
+static ssize_t prng_tdes_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t nbytes = iov_iter_count(to);
 	int chunk, n, ret = 0;
 
 	/* lock prng_data struct */
@@ -570,14 +570,13 @@ static ssize_t prng_tdes_read(struct file *file, char __user *ubuf,
 		prng_data->prngws.byte_counter += n;
 		prng_data->prngws.reseed_counter += n;
 
-		if (copy_to_user(ubuf, prng_data->buf, chunk)) {
+		if (!copy_to_iter_full(prng_data->buf, chunk, to)) {
 			ret = -EFAULT;
 			break;
 		}
 
 		nbytes -= chunk;
 		ret += chunk;
-		ubuf += chunk;
 	}
 
 	/* unlock prng_data struct */
@@ -587,9 +586,9 @@ static ssize_t prng_tdes_read(struct file *file, char __user *ubuf,
 }
 
 
-static ssize_t prng_sha512_read(struct file *file, char __user *ubuf,
-				size_t nbytes, loff_t *ppos)
+static ssize_t prng_sha512_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t nbytes = iov_iter_count(to);
 	int n, ret = 0;
 	u8 *p;
 
@@ -640,12 +639,11 @@ static ssize_t prng_sha512_read(struct file *file, char __user *ubuf,
 				prng_data->rest = 0;
 			}
 		}
-		if (copy_to_user(ubuf, p, n)) {
+		if (!copy_to_iter_full(p, n, to)) {
 			ret = -EFAULT;
 			break;
 		}
 		memzero_explicit(p, n);
-		ubuf += n;
 		nbytes -= n;
 		ret += n;
 	}
@@ -663,14 +661,14 @@ static const struct file_operations prng_sha512_fops = {
 	.owner		= THIS_MODULE,
 	.open		= &prng_open,
 	.release	= NULL,
-	.read		= &prng_sha512_read,
+	.read_iter	= &prng_sha512_read,
 	.llseek		= noop_llseek,
 };
 static const struct file_operations prng_tdes_fops = {
 	.owner		= THIS_MODULE,
 	.open		= &prng_open,
 	.release	= NULL,
-	.read		= &prng_tdes_read,
+	.read_iter	= &prng_tdes_read,
 	.llseek		= noop_llseek,
 };
 
diff --git a/arch/s390/hypfs/hypfs_dbfs.c b/arch/s390/hypfs/hypfs_dbfs.c
index 4024599eb448..964247caf5fb 100644
--- a/arch/s390/hypfs/hypfs_dbfs.c
+++ b/arch/s390/hypfs/hypfs_dbfs.c
@@ -28,17 +28,16 @@ static void hypfs_dbfs_data_free(struct hypfs_dbfs_data *data)
 	kfree(data);
 }
 
-static ssize_t dbfs_read(struct file *file, char __user *buf,
-			 size_t size, loff_t *ppos)
+static ssize_t dbfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct hypfs_dbfs_data *data;
 	struct hypfs_dbfs_file *df;
 	ssize_t rc;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
-	df = file_inode(file)->i_private;
+	df = file_inode(iocb->ki_filp)->i_private;
 	mutex_lock(&df->lock);
 	data = hypfs_dbfs_data_alloc(df);
 	if (!data) {
@@ -53,7 +52,7 @@ static ssize_t dbfs_read(struct file *file, char __user *buf,
 	}
 	mutex_unlock(&df->lock);
 
-	rc = simple_read_from_buffer(buf, size, ppos, data->buf, data->size);
+	rc = simple_copy_to_iter(data->buf, &iocb->ki_pos, data->size, to);
 	hypfs_dbfs_data_free(data);
 	return rc;
 }
@@ -73,7 +72,7 @@ static long dbfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 
 static const struct file_operations dbfs_ops = {
-	.read		= dbfs_read,
+	.read_iter	= dbfs_read,
 	.llseek		= no_llseek,
 	.unlocked_ioctl = dbfs_ioctl,
 };
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 85328a0ef3b6..2ba1ee0a0f1d 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -66,10 +66,8 @@ typedef struct {
 /* internal function prototyes */
 
 static int debug_init(void);
-static ssize_t debug_output(struct file *file, char __user *user_buf,
-			    size_t user_len, loff_t *offset);
-static ssize_t debug_input(struct file *file, const char __user *user_buf,
-			   size_t user_len, loff_t *offset);
+static ssize_t debug_output(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t debug_input_iter(struct kiocb *iocb, struct iov_iter *from);
 static int debug_open(struct inode *inode, struct file *file);
 static int debug_close(struct inode *inode, struct file *file);
 static debug_info_t *debug_info_create(const char *name, int pages_per_area,
@@ -159,8 +157,8 @@ static int debug_critical;
 
 static const struct file_operations debug_file_ops = {
 	.owner	 = THIS_MODULE,
-	.read	 = debug_output,
-	.write	 = debug_input,
+	.read_iter	 = debug_output,
+	.write_iter	 = debug_input_iter,
 	.open	 = debug_open,
 	.release = debug_close,
 	.llseek  = no_llseek,
@@ -452,17 +450,15 @@ static inline int debug_next_entry(file_private_info_t *p_info)
  * - called for user read()
  * - copies formated debug entries to the user buffer
  */
-static ssize_t debug_output(struct file *file,		/* file descriptor */
-			    char __user *user_buf,	/* user buffer */
-			    size_t len,			/* length of buffer */
-			    loff_t *offset)		/* offset in the file */
+static ssize_t debug_output(struct kiocb *iocb, struct iov_iter *to)
 {
 	size_t count = 0;
 	size_t entry_offset;
 	file_private_info_t *p_info;
+	size_t len = iov_iter_count(to);
 
-	p_info = (file_private_info_t *) file->private_data;
-	if (*offset != p_info->offset)
+	p_info = (file_private_info_t *) iocb->ki_filp->private_data;
+	if (iocb->ki_pos != p_info->offset)
 		return -EPIPE;
 	if (p_info->act_area >= p_info->debug_info_snap->nr_areas)
 		return 0;
@@ -478,8 +474,8 @@ static ssize_t debug_output(struct file *file,		/* file descriptor */
 		user_buf_residue = len-count;
 		copy_size = min(user_buf_residue, formatted_line_residue);
 		if (copy_size) {
-			if (copy_to_user(user_buf + count, p_info->temp_buf
-					 + entry_offset, copy_size))
+			if (!copy_to_iter_full(p_info->temp_buf
+					 + entry_offset, copy_size, to))
 				return -EFAULT;
 			count += copy_size;
 			entry_offset += copy_size;
@@ -491,9 +487,9 @@ static ssize_t debug_output(struct file *file,		/* file descriptor */
 		}
 	}
 out:
-	p_info->offset		 = *offset + count;
+	p_info->offset		 = iocb->ki_pos + count;
 	p_info->act_entry_offset = entry_offset;
-	*offset = p_info->offset;
+	iocb->ki_pos = p_info->offset;
 	return count;
 }
 
@@ -520,6 +516,7 @@ static ssize_t debug_input(struct file *file, const char __user *user_buf,
 	mutex_unlock(&debug_mutex);
 	return rc; /* number of input characters */
 }
+FOPS_WRITE_ITER_HELPER(debug_input);
 
 /*
  * debug_open:
diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index 2be30a96696a..84cca91e86ff 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -497,7 +497,7 @@ static int stsi_open_##fc##_##s1##_##s2(struct inode *inode, struct file *file)\
 static const struct file_operations stsi_##fc##_##s1##_##s2##_fs_ops = {       \
 	.open		= stsi_open_##fc##_##s1##_##s2,			       \
 	.release	= stsi_release,					       \
-	.read		= stsi_read,					       \
+	.read_iter	= stsi_read,					       \
 	.llseek		= no_llseek,					       \
 };
 
@@ -507,9 +507,9 @@ static int stsi_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t stsi_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
+static ssize_t stsi_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(buf, size, ppos, file->private_data, PAGE_SIZE);
+	return simple_copy_to_iter(iocb->ki_filp->private_data, &iocb->ki_pos, PAGE_SIZE, to);
 }
 
 STSI_FILE( 1, 1, 1);
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 2cb5043a997d..9c4b1eb26103 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -134,17 +134,17 @@ static int pci_perf_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
-				  size_t count, loff_t *off)
+static ssize_t pci_perf_seq_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct zpci_dev *zdev = ((struct seq_file *) file->private_data)->private;
+	struct zpci_dev *zdev = ((struct seq_file *) iocb->ki_filp->private_data)->private;
+	size_t count = iov_iter_count(from);
 	unsigned long val;
 	int rc;
 
 	if (!zdev)
 		return 0;
 
-	rc = kstrtoul_from_user(ubuf, count, 10, &val);
+	rc = kstrtoul_from_iter(from, count, 10, &val);
 	if (rc)
 		return rc;
 
@@ -169,8 +169,8 @@ static int pci_perf_seq_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations debugfs_pci_perf_fops = {
 	.open	 = pci_perf_seq_open,
-	.read	 = seq_read,
-	.write	 = pci_perf_seq_write,
+	.read_iter = seq_read_iter,
+	.write_iter = pci_perf_seq_write,
 	.llseek  = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


