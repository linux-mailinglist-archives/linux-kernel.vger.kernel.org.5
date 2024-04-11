Return-Path: <linux-kernel+bounces-141190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2311F8A1AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51C71F23BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76881FB092;
	Thu, 11 Apr 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MgRY62So"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63C1FB062
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850185; cv=none; b=EyXXmJMHo8UKibcwB+vcC5JUeM/csennW6bTqKDE3dETpWsM2b7eGC+GkrYRU1/rlKO270hyKpqZBTbSuXG+0X61Y1VDy5MYFY6HLt53N6n0EWp2yV6qMoqDOX+xXuNk5y6urtKAFJyoo1TNX1iWWpUph+l7lx2z6LI+xCZnZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850185; c=relaxed/simple;
	bh=1DciV3y8UGrC/lVqzO1pHnNbzoVj/m2ff/R35slerew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMC2sKErCs7EBI3PXlit+Xz9waCS4ktU7YtTOQabEK6c9JW+0wIQWHqXkzk3UqlrBJFBKyxAQ0IEp3+1OVOScodK04ka2cvcyPVPl0L5E61su4H5/dq2ykw8d7gCpDz+MvFtQ86xpXnGEvpBMmPKxT+BobWO582pH2/ykdKMP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MgRY62So; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58278339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850181; x=1713454981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrTxzfM+6WU2DAQS8Yib8wiNqJhwbvOzxcj5vKuDbIY=;
        b=MgRY62SoaEENZOCvYURqW8Hh0HfJmNSIBodhZLFNkgBBd1HL/3sWBvHYRcnU+XP/P4
         PpuYdo2Lig+6pKs7VyU04dPFqF9hJVJ9zGEpYXC+lrCeTnFn1dGeDqNakMsNuLeOnwzz
         EUgtRxlXTzMe3e0QWFUt9qKcrIxwKQn849f0GMMzLOXV6QX13cU9YP70skt6NOiA5B+o
         Rw60FPpkNUMzl5XyZjzqKsvN0eYIZEldv+d8GGCgWgwLlEljm0WYa/SGdjrNBZHkWLjU
         Cx8zRstocUpyKLqD5Oxujv3gG7uqJCi/jyefUVt09CEyBoM/5vQf6Vr6zaISCUgaoMuy
         UlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850182; x=1713454982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrTxzfM+6WU2DAQS8Yib8wiNqJhwbvOzxcj5vKuDbIY=;
        b=Quf6SkXtJxFnHgn4tZ0nXkpny3zlzf45CYLzMh8Agdregnue7dUy3wxQbJIT3DX6Bp
         i0QxCRnYAA9mUxvNk0ujcJ6GczGUoelWK2CL4471TZhidqj6MQZNfUKqLDaHnt3zy4e9
         n0b1ZRt3a7WGb9oSAlWXJ1DohvPVH+0LaL87slgLsuGZ8QFSp9gInGfAJhep0LB+FBX4
         YQ0NPjEd4z7wEH0RN/J8SUiB99MzsLfQlG6xSLVkoLmJE7lKO5P1C1wpdrVcyz6j85xa
         ENnujI4lW+Hh+ODk4Y+uQK9SWy0mF+wOXhzE09+dKxt5MW69KK2POZ+y7iryjh7sVV/P
         /gkQ==
X-Gm-Message-State: AOJu0Ywz6pmYRRX02sVlY0mP0aaTaH4AAh7NoYrkgLo22s3bLx9bxhm7
	3OEhtTMIl5VQzaLpHyRkiLyisTp4lzbjOdBkndxTTigDlfNbHYPKMUXm9HAVtYrGUlPYX3MEJHk
	K
X-Google-Smtp-Source: AGHT+IFocqbYhIMD5u6YKi83vIJBHBB03R6VEKuMuInFe3w9BcMj9k8y8hKgk0wluXb8oorDvN0rQg==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr214322iog.0.1712850181564;
        Thu, 11 Apr 2024 08:43:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 406/437] infiniband/hfi1: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:06 -0600
Message-ID: <20240411153126.16201-407-axboe@kernel.dk>
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
 drivers/infiniband/hw/hfi1/debugfs.c | 162 +++++++++++++--------------
 drivers/infiniband/hw/hfi1/debugfs.h |   6 +-
 drivers/infiniband/hw/hfi1/fault.c   |  27 +++--
 3 files changed, 91 insertions(+), 104 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index a1e01b447265..9b6c9d726c11 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -23,16 +23,15 @@
 static struct dentry *hfi1_dbg_root;
 
 /* wrappers to enforce srcu in seq file */
-ssize_t hfi1_seq_read(struct file *file, char __user *buf, size_t size,
-		      loff_t *ppos)
+ssize_t hfi1_seq_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dentry *d = file->f_path.dentry;
+	struct dentry *d = iocb->ki_filp->f_path.dentry;
 	ssize_t r;
 
 	r = debugfs_file_get(d);
 	if (unlikely(r))
 		return r;
-	r = seq_read(file, buf, size, ppos);
+	r = seq_read_iter(iocb, to);
 	debugfs_file_put(d);
 	return r;
 }
@@ -414,33 +413,27 @@ DEBUGFS_SEQ_FILE_OPEN(pios)
 DEBUGFS_FILE_OPS(pios);
 
 /* read the per-device counters */
-static ssize_t dev_counters_read(struct file *file, char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t dev_counters_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	u64 *counters;
 	size_t avail;
 	struct hfi1_devdata *dd;
-	ssize_t rval;
 
-	dd = private2dd(file);
+	dd = private2dd(iocb->ki_filp);
 	avail = hfi1_read_cntrs(dd, NULL, &counters);
-	rval =  simple_read_from_buffer(buf, count, ppos, counters, avail);
-	return rval;
+	return simple_copy_to_iter(counters, &iocb->ki_pos, avail, to);
 }
 
 /* read the per-device counters */
-static ssize_t dev_names_read(struct file *file, char __user *buf,
-			      size_t count, loff_t *ppos)
+static ssize_t dev_names_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *names;
 	size_t avail;
 	struct hfi1_devdata *dd;
-	ssize_t rval;
 
-	dd = private2dd(file);
+	dd = private2dd(iocb->ki_filp);
 	avail = hfi1_read_cntrs(dd, &names, NULL);
-	rval =  simple_read_from_buffer(buf, count, ppos, names, avail);
-	return rval;
+	return simple_copy_to_iter(names, &iocb->ki_pos, avail, to);
 }
 
 struct counter_info {
@@ -454,33 +447,27 @@ struct counter_info {
  */
 
 /* read the per-port names (same for each port) */
-static ssize_t portnames_read(struct file *file, char __user *buf,
-			      size_t count, loff_t *ppos)
+static ssize_t portnames_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *names;
 	size_t avail;
 	struct hfi1_devdata *dd;
-	ssize_t rval;
 
-	dd = private2dd(file);
+	dd = private2dd(iocb->ki_filp);
 	avail = hfi1_read_portcntrs(dd->pport, &names, NULL);
-	rval = simple_read_from_buffer(buf, count, ppos, names, avail);
-	return rval;
+	return simple_copy_to_iter(names, &iocb->ki_pos, avail, to);
 }
 
 /* read the per-port counters */
-static ssize_t portcntrs_debugfs_read(struct file *file, char __user *buf,
-				      size_t count, loff_t *ppos)
+static ssize_t portcntrs_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	u64 *counters;
 	size_t avail;
 	struct hfi1_pportdata *ppd;
-	ssize_t rval;
 
-	ppd = private2ppd(file);
+	ppd = private2ppd(iocb->ki_filp);
 	avail = hfi1_read_portcntrs(ppd, NULL, &counters);
-	rval = simple_read_from_buffer(buf, count, ppos, counters, avail);
-	return rval;
+	return simple_copy_to_iter(counters, &iocb->ki_pos, avail, to);
 }
 
 static void check_dyn_flag(u64 scratch0, char *p, int size, int *used,
@@ -497,8 +484,7 @@ static void check_dyn_flag(u64 scratch0, char *p, int size, int *used,
 	}
 }
 
-static ssize_t asic_flags_read(struct file *file, char __user *buf,
-			       size_t count, loff_t *ppos)
+static ssize_t asic_flags_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct hfi1_pportdata *ppd;
 	struct hfi1_devdata *dd;
@@ -509,7 +495,7 @@ static ssize_t asic_flags_read(struct file *file, char __user *buf,
 	int used;
 	int i;
 
-	ppd = private2ppd(file);
+	ppd = private2ppd(iocb->ki_filp);
 	dd = ppd->dd;
 	size = PAGE_SIZE;
 	used = 0;
@@ -541,14 +527,14 @@ static ssize_t asic_flags_read(struct file *file, char __user *buf,
 	}
 	used += scnprintf(tmp + used, size - used, "Write bits to clear\n");
 
-	ret = simple_read_from_buffer(buf, count, ppos, tmp, used);
+	ret = simple_copy_to_iter(tmp, &iocb->ki_pos, used, to);
 	kfree(tmp);
 	return ret;
 }
 
-static ssize_t asic_flags_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t asic_flags_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct hfi1_pportdata *ppd;
 	struct hfi1_devdata *dd;
 	char *buff;
@@ -557,11 +543,11 @@ static ssize_t asic_flags_write(struct file *file, const char __user *buf,
 	u64 scratch0;
 	u64 clear;
 
-	ppd = private2ppd(file);
+	ppd = private2ppd(iocb->ki_filp);
 	dd = ppd->dd;
 
 	/* zero terminate and read the expected integer */
-	buff = memdup_user_nul(buf, count);
+	buff = iterdup_nul(from, count);
 	if (IS_ERR(buff))
 		return PTR_ERR(buff);
 
@@ -592,16 +578,16 @@ static ssize_t asic_flags_write(struct file *file, const char __user *buf,
 }
 
 /* read the dc8051 memory */
-static ssize_t dc8051_memory_read(struct file *file, char __user *buf,
-				  size_t count, loff_t *ppos)
+static ssize_t dc8051_memory_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hfi1_pportdata *ppd = private2ppd(file);
+	struct hfi1_pportdata *ppd = private2ppd(iocb->ki_filp);
+	size_t count = iov_iter_count(to);
 	ssize_t rval;
 	void *tmp;
 	loff_t start, end;
 
 	/* the checks below expect the position to be positive */
-	if (*ppos < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 
 	tmp = kzalloc(DC8051_DATA_MEM_SIZE, GFP_KERNEL);
@@ -614,9 +600,9 @@ static ssize_t dc8051_memory_read(struct file *file, char __user *buf,
 	 * Adjust start and end to fit.  Skip reading anything if out of
 	 * range.
 	 */
-	start = *ppos & ~0x7;	/* round down */
+	start = iocb->ki_pos & ~0x7;	/* round down */
 	if (start < DC8051_DATA_MEM_SIZE) {
-		end = (*ppos + count + 7) & ~0x7; /* round up */
+		end = (iocb->ki_pos + count + 7) & ~0x7; /* round up */
 		if (end > DC8051_DATA_MEM_SIZE)
 			end = DC8051_DATA_MEM_SIZE;
 		rval = read_8051_data(ppd->dd, start, end - start,
@@ -625,98 +611,96 @@ static ssize_t dc8051_memory_read(struct file *file, char __user *buf,
 			goto done;
 	}
 
-	rval = simple_read_from_buffer(buf, count, ppos, tmp,
-				       DC8051_DATA_MEM_SIZE);
+	rval = simple_copy_to_iter(tmp, &iocb->ki_pos, DC8051_DATA_MEM_SIZE, to);
 done:
 	kfree(tmp);
 	return rval;
 }
 
-static ssize_t debugfs_lcb_read(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t debugfs_lcb_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hfi1_pportdata *ppd = private2ppd(file);
+	struct hfi1_pportdata *ppd = private2ppd(iocb->ki_filp);
+	size_t count = iov_iter_count(to);
 	struct hfi1_devdata *dd = ppd->dd;
 	unsigned long total, csr_off;
 	u64 data;
 
-	if (*ppos < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 	/* only read 8 byte quantities */
 	if ((count % 8) != 0)
 		return -EINVAL;
 	/* offset must be 8-byte aligned */
-	if ((*ppos % 8) != 0)
+	if ((iocb->ki_pos % 8) != 0)
 		return -EINVAL;
 	/* do nothing if out of range or zero count */
-	if (*ppos >= (LCB_END - LCB_START) || !count)
+	if (iocb->ki_pos >= (LCB_END - LCB_START) || !count)
 		return 0;
 	/* reduce count if needed */
-	if (*ppos + count > LCB_END - LCB_START)
-		count = (LCB_END - LCB_START) - *ppos;
+	if (iocb->ki_pos + count > LCB_END - LCB_START)
+		count = (LCB_END - LCB_START) - iocb->ki_pos;
 
-	csr_off = LCB_START + *ppos;
+	csr_off = LCB_START + iocb->ki_pos;
 	for (total = 0; total < count; total += 8, csr_off += 8) {
 		if (read_lcb_csr(dd, csr_off, (u64 *)&data))
 			break; /* failed */
-		if (put_user(data, (unsigned long __user *)(buf + total)))
+		if (!copy_to_iter_full(&data, sizeof(data), to))
 			break;
 	}
-	*ppos += total;
+	iocb->ki_pos += total;
 	return total;
 }
 
-static ssize_t debugfs_lcb_write(struct file *file, const char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t debugfs_lcb_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hfi1_pportdata *ppd = private2ppd(file);
+	struct hfi1_pportdata *ppd = private2ppd(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	struct hfi1_devdata *dd = ppd->dd;
 	unsigned long total, csr_off, data;
 
-	if (*ppos < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 	/* only write 8 byte quantities */
 	if ((count % 8) != 0)
 		return -EINVAL;
 	/* offset must be 8-byte aligned */
-	if ((*ppos % 8) != 0)
+	if ((iocb->ki_pos % 8) != 0)
 		return -EINVAL;
 	/* do nothing if out of range or zero count */
-	if (*ppos >= (LCB_END - LCB_START) || !count)
+	if (iocb->ki_pos >= (LCB_END - LCB_START) || !count)
 		return 0;
 	/* reduce count if needed */
-	if (*ppos + count > LCB_END - LCB_START)
-		count = (LCB_END - LCB_START) - *ppos;
+	if (iocb->ki_pos + count > LCB_END - LCB_START)
+		count = (LCB_END - LCB_START) - iocb->ki_pos;
 
-	csr_off = LCB_START + *ppos;
+	csr_off = LCB_START + iocb->ki_pos;
 	for (total = 0; total < count; total += 8, csr_off += 8) {
-		if (get_user(data, (unsigned long __user *)(buf + total)))
+		if (!copy_from_iter_full(&data, sizeof(data), from))
 			break;
 		if (write_lcb_csr(dd, csr_off, data))
 			break; /* failed */
 	}
-	*ppos += total;
+	iocb->ki_pos += total;
 	return total;
 }
 
 /*
  * read the per-port QSFP data for ppd
  */
-static ssize_t qsfp_debugfs_dump(struct file *file, char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t qsfp_debugfs_dump(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct hfi1_pportdata *ppd;
 	char *tmp;
 	int ret;
 
-	ppd = private2ppd(file);
+	ppd = private2ppd(iocb->ki_filp);
 	tmp = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!tmp)
 		return -ENOMEM;
 
 	ret = qsfp_dump(ppd, tmp, PAGE_SIZE);
 	if (ret > 0)
-		ret = simple_read_from_buffer(buf, count, ppos, tmp, ret);
+		ret = simple_copy_to_iter(tmp, &iocb->ki_pos, ret, to);
 	kfree(tmp);
 	return ret;
 }
@@ -767,6 +751,7 @@ static ssize_t i2c1_debugfs_write(struct file *file, const char __user *buf,
 {
 	return __i2c_debugfs_write(file, buf, count, ppos, 0);
 }
+FOPS_WRITE_ITER_HELPER(i2c1_debugfs_write);
 
 /* Do an i2c write operation on chain for HFI 1. */
 static ssize_t i2c2_debugfs_write(struct file *file, const char __user *buf,
@@ -774,6 +759,7 @@ static ssize_t i2c2_debugfs_write(struct file *file, const char __user *buf,
 {
 	return __i2c_debugfs_write(file, buf, count, ppos, 1);
 }
+FOPS_WRITE_ITER_HELPER(i2c2_debugfs_write);
 
 /* Do an i2c read operation on the chain for the given HFI. */
 static ssize_t __i2c_debugfs_read(struct file *file, char __user *buf,
@@ -827,6 +813,7 @@ static ssize_t i2c1_debugfs_read(struct file *file, char __user *buf,
 {
 	return __i2c_debugfs_read(file, buf, count, ppos, 0);
 }
+FOPS_READ_ITER_HELPER(i2c1_debugfs_read);
 
 /* Do an i2c read operation on chain for HFI 1. */
 static ssize_t i2c2_debugfs_read(struct file *file, char __user *buf,
@@ -834,6 +821,7 @@ static ssize_t i2c2_debugfs_read(struct file *file, char __user *buf,
 {
 	return __i2c_debugfs_read(file, buf, count, ppos, 1);
 }
+FOPS_READ_ITER_HELPER(i2c2_debugfs_read);
 
 /* Do a QSFP write operation on the i2c chain for the given HFI. */
 static ssize_t __qsfp_debugfs_write(struct file *file, const char __user *buf,
@@ -874,6 +862,7 @@ static ssize_t qsfp1_debugfs_write(struct file *file, const char __user *buf,
 {
 	return __qsfp_debugfs_write(file, buf, count, ppos, 0);
 }
+FOPS_WRITE_ITER_HELPER(qsfp1_debugfs_write);
 
 /* Do a QSFP write operation on i2c chain for HFI 1. */
 static ssize_t qsfp2_debugfs_write(struct file *file, const char __user *buf,
@@ -881,6 +870,7 @@ static ssize_t qsfp2_debugfs_write(struct file *file, const char __user *buf,
 {
 	return __qsfp_debugfs_write(file, buf, count, ppos, 1);
 }
+FOPS_WRITE_ITER_HELPER(qsfp2_debugfs_write);
 
 /* Do a QSFP read operation on the i2c chain for the given HFI. */
 static ssize_t __qsfp_debugfs_read(struct file *file, char __user *buf,
@@ -932,6 +922,7 @@ static ssize_t qsfp1_debugfs_read(struct file *file, char __user *buf,
 {
 	return __qsfp_debugfs_read(file, buf, count, ppos, 0);
 }
+FOPS_READ_ITER_HELPER(qsfp1_debugfs_read);
 
 /* Do a QSFP read operation on i2c chain for HFI 1. */
 static ssize_t qsfp2_debugfs_read(struct file *file, char __user *buf,
@@ -939,6 +930,7 @@ static ssize_t qsfp2_debugfs_read(struct file *file, char __user *buf,
 {
 	return __qsfp_debugfs_read(file, buf, count, ppos, 1);
 }
+FOPS_READ_ITER_HELPER(qsfp2_debugfs_read);
 
 static int __i2c_debugfs_open(struct inode *in, struct file *fp, u32 target)
 {
@@ -1043,22 +1035,20 @@ static int exprom_wp_set(struct hfi1_devdata *dd, bool disable)
 	return 0;
 }
 
-static ssize_t exprom_wp_debugfs_read(struct file *file, char __user *buf,
-				      size_t count, loff_t *ppos)
+static ssize_t exprom_wp_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
 
-static ssize_t exprom_wp_debugfs_write(struct file *file,
-				       const char __user *buf, size_t count,
-				       loff_t *ppos)
+static ssize_t exprom_wp_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hfi1_pportdata *ppd = private2ppd(file);
+	struct hfi1_pportdata *ppd = private2ppd(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	char cdata;
 
 	if (count != 1)
 		return -EINVAL;
-	if (get_user(cdata, buf))
+	if (get_iter(cdata, from))
 		return -EFAULT;
 	if (cdata == '0')
 		exprom_wp_set(ppd->dd, false);
@@ -1096,8 +1086,8 @@ static int exprom_wp_debugfs_release(struct inode *in, struct file *fp)
 	.name = nm, \
 	.ops = { \
 		.owner = THIS_MODULE, \
-		.read = readroutine, \
-		.write = writeroutine, \
+		.read_iter = readroutine, \
+		.write_iter = writeroutine, \
 		.llseek = generic_file_llseek, \
 	}, \
 }
@@ -1107,8 +1097,8 @@ static int exprom_wp_debugfs_release(struct inode *in, struct file *fp)
 	.name = nm, \
 	.ops = { \
 		.owner = THIS_MODULE, \
-		.read = readf, \
-		.write = writef, \
+		.read_iter = readf, \
+		.write_iter = writef, \
 		.llseek = generic_file_llseek, \
 		.open = openf, \
 		.release = releasef \
@@ -1123,14 +1113,14 @@ static const struct counter_info cntr_ops[] = {
 
 static const struct counter_info port_cntr_ops[] = {
 	DEBUGFS_OPS("port%dcounters", portcntrs_debugfs_read, NULL),
-	DEBUGFS_XOPS("i2c1", i2c1_debugfs_read, i2c1_debugfs_write,
+	DEBUGFS_XOPS("i2c1", i2c1_debugfs_read_iter, i2c1_debugfs_write_iter,
 		     i2c1_debugfs_open, i2c1_debugfs_release),
-	DEBUGFS_XOPS("i2c2", i2c2_debugfs_read, i2c2_debugfs_write,
+	DEBUGFS_XOPS("i2c2", i2c2_debugfs_read_iter, i2c2_debugfs_write_iter,
 		     i2c2_debugfs_open, i2c2_debugfs_release),
 	DEBUGFS_OPS("qsfp_dump%d", qsfp_debugfs_dump, NULL),
-	DEBUGFS_XOPS("qsfp1", qsfp1_debugfs_read, qsfp1_debugfs_write,
+	DEBUGFS_XOPS("qsfp1", qsfp1_debugfs_read_iter, qsfp1_debugfs_write_iter,
 		     qsfp1_debugfs_open, qsfp1_debugfs_release),
-	DEBUGFS_XOPS("qsfp2", qsfp2_debugfs_read, qsfp2_debugfs_write,
+	DEBUGFS_XOPS("qsfp2", qsfp2_debugfs_read_iter, qsfp2_debugfs_write_iter,
 		     qsfp2_debugfs_open, qsfp2_debugfs_release),
 	DEBUGFS_XOPS("exprom_wp", exprom_wp_debugfs_read,
 		     exprom_wp_debugfs_write, exprom_wp_debugfs_open,
@@ -1222,7 +1212,7 @@ void hfi1_dbg_ibdev_init(struct hfi1_ibdev *ibd)
 				 port_cntr_ops[i].name,
 				 j + 1);
 			debugfs_create_file(name,
-					    !port_cntr_ops[i].ops.write ?
+					    !port_cntr_ops[i].ops.write_iter ?
 						    S_IRUGO :
 						    S_IRUGO | S_IWUSR,
 					    root, ppd, &port_cntr_ops[i].ops);
diff --git a/drivers/infiniband/hw/hfi1/debugfs.h b/drivers/infiniband/hw/hfi1/debugfs.h
index 54d952a4016c..62f549a1adb4 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.h
+++ b/drivers/infiniband/hw/hfi1/debugfs.h
@@ -33,14 +33,12 @@ static int _##name##_open(struct inode *inode, struct file *s) \
 static const struct file_operations _##name##_file_ops = { \
 	.owner   = THIS_MODULE, \
 	.open    = _##name##_open, \
-	.read    = hfi1_seq_read, \
+	.read_iter = hfi1_seq_read, \
 	.llseek  = hfi1_seq_lseek, \
 	.release = seq_release \
 }
 
-
-ssize_t hfi1_seq_read(struct file *file, char __user *buf, size_t size,
-		      loff_t *ppos);
+ssize_t hfi1_seq_read(struct kiocb *iocb, struct iov_iter *to);
 loff_t hfi1_seq_lseek(struct file *file, loff_t offset, int whence);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index 35d2382ee618..0fe332245501 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -86,25 +86,25 @@ static int fault_opcodes_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
-static ssize_t fault_opcodes_write(struct file *file, const char __user *buf,
-				   size_t len, loff_t *pos)
+static ssize_t fault_opcodes_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	ssize_t ret = 0;
 	/* 1280 = 256 opcodes * 4 chars/opcode + 255 commas + NULL */
 	size_t copy, datalen = 1280;
 	char *data, *token, *ptr, *end;
-	struct fault *fault = file->private_data;
+	struct fault *fault = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 
 	data = kcalloc(datalen, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 	copy = min(len, datalen - 1);
-	if (copy_from_user(data, buf, copy)) {
+	if (!copy_from_iter_full(data, copy, from)) {
 		ret = -EFAULT;
 		goto free_data;
 	}
 
-	ret = debugfs_file_get(file->f_path.dentry);
+	ret = debugfs_file_get(iocb->ki_filp->f_path.dentry);
 	if (unlikely(ret))
 		goto free_data;
 	ptr = data;
@@ -154,26 +154,25 @@ static ssize_t fault_opcodes_write(struct file *file, const char __user *buf,
 	}
 	ret = len;
 
-	debugfs_file_put(file->f_path.dentry);
+	debugfs_file_put(iocb->ki_filp->f_path.dentry);
 free_data:
 	kfree(data);
 	return ret;
 }
 
-static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
-				  size_t len, loff_t *pos)
+static ssize_t fault_opcodes_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret = 0;
 	char *data;
 	size_t datalen = 1280, size = 0; /* see fault_opcodes_write() */
 	unsigned long bit = 0, zero = 0;
-	struct fault *fault = file->private_data;
+	struct fault *fault = iocb->ki_filp->private_data;
 	size_t bitsize = sizeof(fault->opcodes) * BITS_PER_BYTE;
 
 	data = kcalloc(datalen, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-	ret = debugfs_file_get(file->f_path.dentry);
+	ret = debugfs_file_get(iocb->ki_filp->f_path.dentry);
 	if (unlikely(ret))
 		goto free_data;
 	bit = find_first_bit(fault->opcodes, bitsize);
@@ -189,10 +188,10 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
 					 bit);
 		bit = find_next_bit(fault->opcodes, bitsize, zero);
 	}
-	debugfs_file_put(file->f_path.dentry);
+	debugfs_file_put(iocb->ki_filp->f_path.dentry);
 	data[size - 1] = '\n';
 	data[size] = '\0';
-	ret = simple_read_from_buffer(buf, len, pos, data, size);
+	ret = simple_copy_to_iter(data, &iocb->ki_pos, size, to);
 free_data:
 	kfree(data);
 	return ret;
@@ -201,8 +200,8 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
 static const struct file_operations __fault_opcodes_fops = {
 	.owner = THIS_MODULE,
 	.open = fault_opcodes_open,
-	.read = fault_opcodes_read,
-	.write = fault_opcodes_write,
+	.read_iter = fault_opcodes_read,
+	.write_iter = fault_opcodes_write,
 	.llseek = no_llseek
 };
 
-- 
2.43.0


