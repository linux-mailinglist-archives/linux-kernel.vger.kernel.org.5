Return-Path: <linux-kernel+bounces-140868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E28A1949
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FB41C20D18
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AFE14F125;
	Thu, 11 Apr 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qAHnMrBR"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860014C587
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849682; cv=none; b=c7Z6kteCEOrUeNI7CojNue+6/TStMiViMaw6djWBScwH7k5rbiM2STKueD8GouUZ+nbdxoHXjr265fAadEIsdR3veV3n6okeMyeW5PK4lTy0+kKov5anmFxFeIuo1qHRoeb+Sdw16ZUmrQhHFckUK9vzX6i2uOfpbgvf2274fos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849682; c=relaxed/simple;
	bh=NhSfXW2oABhTNdGwOFnliqKjszqjriReAcun5frS664=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bV7rmcbD8I7r2La2QC7oG+vda+s2lIwLBDENjiUZ1V8+GO8i+Gv+nFyxdk9fJnjdwirsMHjcMVMoyqcrrI9WJp7UGCEAhY24YCXqi3hQ8iK2oBOSlRh+vnoEHCgWl47m7lF1rUfDbIFaJ8W6DBQTo1GpOnqiM/wUz9rkeoi5D4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qAHnMrBR; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9761239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849678; x=1713454478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UYMuWg323QkzNbb/c+w4UB/Y3iWyfQoEJqm+Hdo/Ls=;
        b=qAHnMrBREJw87IwRrcQyKW253vPAH7NEjPQ7h3EeRkdc6Edw6oOnvonZRxP9egv8IL
         IASI5axYe4CZ8xvCcgT/EqnCfp5aQTQZLfu9EQfD7IbprEHN1UzC++VH1ACaLBhyrD01
         gy6eqDhgkJmLt1DKQUdlK3FRBcS0QkTpHDOC3eYsFnkw/9/Z6r0kNeYJ5UHFlYl3fK2+
         3SVN5rPuu8N5Yq5tPp/E5XdipAJ1JTx3b+KVHFjxZFhKHuOdFmMQbq2dZN0p4rhkh2Yu
         dPezArGyW0G+7qtz6qjDQ57VHjRbT4AFWlzabW8r/pslWTin2ijInDo3Vb2jm95vzeBv
         xXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849678; x=1713454478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UYMuWg323QkzNbb/c+w4UB/Y3iWyfQoEJqm+Hdo/Ls=;
        b=IJUqcnEFZxe70QIqqu6eyt3m9icXh9Q0hEyQnw8UKOzxqGaRc0LZv8F1TQADEyrPNX
         bhlKvMc9ngEUFqTpDqOzdizTcs5UhLZuy8cGa23CCaX84JDyW8JZmdcT3goPnPeLE094
         z2qnZwvlK/ZUv3SQzvJRnzGM/Hj7k0dVVSZZw0aRmiXpMeojnyLYJgd/Eou8ihESlUZ8
         R3blc34yL8yiQU6a88XsuUaiJdvxt248I+imfUlPf+WpAliyXU8aBBS+GIOYLzQq1s6s
         e0BrFOpnCuo0fs65CXhHMsJ8axzZAq0VkVnRwE23wPlVER0r1E8+3i4iRjM0V7r7GQ1k
         w2fQ==
X-Gm-Message-State: AOJu0YzNQ1VmEERv8ZwYVyLF0VD6TbrccCJz/MFKKUK7CZq1Aam5DK/u
	l8cutb8m5dlxvdOBDUSX3q+wKuq16JTxVb34P0CdmbbPACfh8xBIFFMdeNNAyDc62Lut/++GiH5
	l
X-Google-Smtp-Source: AGHT+IHKQRgZDmFHIxQT9xgOjB9yiXbS/c6/gQxIipFMUDyIeccdzYFCSfRvvdOI5NdoeIkwuyiw4w==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr189975iop.1.1712849677928;
        Thu, 11 Apr 2024 08:34:37 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 104/437] drivers/accel: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:04 -0600
Message-ID: <20240411153126.16201-105-axboe@kernel.dk>
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
 drivers/accel/habanalabs/common/debugfs.c    | 307 +++++++++----------
 drivers/accel/habanalabs/common/habanalabs.h |   3 +-
 drivers/accel/ivpu/ivpu_debugfs.c            |  84 +++--
 3 files changed, 183 insertions(+), 211 deletions(-)

diff --git a/drivers/accel/habanalabs/common/debugfs.c b/drivers/accel/habanalabs/common/debugfs.c
index b1c88d1837d9..350dcfc5300e 100644
--- a/drivers/accel/habanalabs/common/debugfs.c
+++ b/drivers/accel/habanalabs/common/debugfs.c
@@ -403,16 +403,16 @@ static int userptr_lookup_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static ssize_t userptr_lookup_write(struct file *file, const char __user *buf,
-		size_t count, loff_t *f_pos)
+static ssize_t userptr_lookup_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
 	struct hl_debugfs_entry *entry = s->private;
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
+	size_t count = iov_iter_count(from);
 	ssize_t rc;
 	u64 value;
 
-	rc = kstrtoull_from_user(buf, count, 16, &value);
+	rc = kstrtoull_from_iter(from, count, 16, &value);
 	if (rc)
 		return rc;
 
@@ -477,20 +477,20 @@ static int mmu_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static ssize_t mmu_asid_va_write(struct file *file, const char __user *buf,
-		size_t count, loff_t *f_pos)
+static ssize_t mmu_asid_va_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
 	struct hl_debugfs_entry *entry = s->private;
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
+	size_t count = iov_iter_count(from);
 	char kbuf[MMU_KBUF_SIZE] = {0};
 	char *c;
 	ssize_t rc;
 
 	if (count > sizeof(kbuf) - 1)
 		goto err;
-	if (copy_from_user(kbuf, buf, count))
+	if (!copy_from_iter_full(kbuf, count, from))
 		goto err;
 	kbuf[count] = 0;
 
@@ -538,21 +538,21 @@ static int mmu_ack_error(struct seq_file *s, void *data)
 	return -EINVAL;
 }
 
-static ssize_t mmu_ack_error_value_write(struct file *file,
-		const char __user *buf,
-		size_t count, loff_t *f_pos)
+static ssize_t mmu_ack_error_value_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
 	struct hl_debugfs_entry *entry = s->private;
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
+	size_t count = iov_iter_count(from);
 	char kbuf[MMU_KBUF_SIZE] = {0};
 	ssize_t rc;
 
 	if (count > sizeof(kbuf) - 1)
 		goto err;
 
-	if (copy_from_user(kbuf, buf, count))
+	if (!copy_from_iter(kbuf, count, from))
 		goto err;
 
 	kbuf[count] = 0;
@@ -607,10 +607,9 @@ static int engines_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static ssize_t hl_memory_scrub(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_memory_scrub(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	u64 val = hdev->memory_scrub_val;
 	int rc;
@@ -637,7 +636,7 @@ static ssize_t hl_memory_scrub(struct file *f, const char __user *buf,
 
 	if (rc)
 		return rc;
-	return count;
+	return iov_iter_count(from);
 }
 
 static bool hl_is_device_va(struct hl_device *hdev, u64 addr)
@@ -839,10 +838,9 @@ static int hl_access_mem(struct hl_device *hdev, u64 addr, u64 *val,
 	return rc;
 }
 
-static ssize_t hl_data_read32(struct file *f, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_data_read32(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	u64 value64, addr = entry->addr;
 	char tmp_buf[32];
@@ -854,7 +852,7 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
 		return 0;
 	}
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	rc = hl_access_mem(hdev, addr, &value64, DEBUGFS_READ32);
@@ -864,14 +862,13 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
 	val = value64; /* downcast back to 32 */
 
 	sprintf(tmp_buf, "0x%08x\n", val);
-	return simple_read_from_buffer(buf, count, ppos, tmp_buf,
-			strlen(tmp_buf));
+	return simple_copy_to_iter(tmp_buf, &iocb->ki_pos, strlen(tmp_buf), to);
 }
 
-static ssize_t hl_data_write32(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_data_write32(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u64 value64, addr = entry->addr;
 	u32 value;
@@ -882,7 +879,7 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 		return 0;
 	}
 
-	rc = kstrtouint_from_user(buf, count, 16, &value);
+	rc = kstrtouint_from_iter(from, count, 16, &value);
 	if (rc)
 		return rc;
 
@@ -894,10 +891,9 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_data_read64(struct file *f, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_data_read64(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	u64 addr = entry->addr;
 	char tmp_buf[32];
@@ -909,7 +905,7 @@ static ssize_t hl_data_read64(struct file *f, char __user *buf,
 		return 0;
 	}
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	rc = hl_access_mem(hdev, addr, &val, DEBUGFS_READ64);
@@ -917,14 +913,13 @@ static ssize_t hl_data_read64(struct file *f, char __user *buf,
 		return rc;
 
 	sprintf(tmp_buf, "0x%016llx\n", val);
-	return simple_read_from_buffer(buf, count, ppos, tmp_buf,
-			strlen(tmp_buf));
+	return simple_copy_to_iter(tmp_buf, &iocb->ki_pos, strlen(tmp_buf), to);
 }
 
-static ssize_t hl_data_write64(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_data_write64(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u64 addr = entry->addr;
 	u64 value;
@@ -935,7 +930,7 @@ static ssize_t hl_data_write64(struct file *f, const char __user *buf,
 		return 0;
 	}
 
-	rc = kstrtoull_from_user(buf, count, 16, &value);
+	rc = kstrtoull_from_iter(from, count, 16, &value);
 	if (rc)
 		return rc;
 
@@ -946,10 +941,10 @@ static ssize_t hl_data_write64(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_dma_size_write(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_dma_size_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u64 addr = entry->addr;
 	ssize_t rc;
@@ -959,7 +954,7 @@ static ssize_t hl_dma_size_write(struct file *f, const char __user *buf,
 		dev_warn_ratelimited(hdev->dev, "Can't DMA during reset\n");
 		return 0;
 	}
-	rc = kstrtouint_from_user(buf, count, 16, &size);
+	rc = kstrtouint_from_iter(from, count, 16, &size);
 	if (rc)
 		return rc;
 
@@ -1003,10 +998,11 @@ static ssize_t hl_dma_size_write(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_monitor_dump_trigger(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_monitor_dump_trigger(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u32 size, trig;
 	ssize_t rc;
@@ -1015,7 +1011,7 @@ static ssize_t hl_monitor_dump_trigger(struct file *f, const char __user *buf,
 		dev_warn_ratelimited(hdev->dev, "Can't dump monitors during reset\n");
 		return 0;
 	}
-	rc = kstrtouint_from_user(buf, count, 10, &trig);
+	rc = kstrtouint_from_iter(from, count, 10, &trig);
 	if (rc)
 		return rc;
 
@@ -1047,15 +1043,14 @@ static ssize_t hl_monitor_dump_trigger(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_get_power_state(struct file *f, char __user *buf,
-		size_t count, loff_t *ppos)
+static ssize_t hl_get_power_state(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	char tmp_buf[200];
 	int i;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	if (hdev->pdev->current_state == PCI_D0)
@@ -1067,19 +1062,18 @@ static ssize_t hl_get_power_state(struct file *f, char __user *buf,
 
 	sprintf(tmp_buf,
 		"current power state: %d\n1 - D0\n2 - D3hot\n3 - Unknown\n", i);
-	return simple_read_from_buffer(buf, count, ppos, tmp_buf,
-			strlen(tmp_buf));
+	return simple_copy_to_iter(tmp_buf, &iocb->ki_pos, strlen(tmp_buf), to);
 }
 
-static ssize_t hl_set_power_state(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_set_power_state(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u32 value;
 	ssize_t rc;
 
-	rc = kstrtouint_from_user(buf, count, 10, &value);
+	rc = kstrtouint_from_iter(from, count, 10, &value);
 	if (rc)
 		return rc;
 
@@ -1101,16 +1095,15 @@ static ssize_t hl_set_power_state(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_i2c_data_read(struct file *f, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_i2c_data_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	char tmp_buf[32];
 	u64 val;
 	ssize_t rc;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	rc = hl_debugfs_i2c_read(hdev, entry->i2c_bus, entry->i2c_addr,
@@ -1123,21 +1116,18 @@ static ssize_t hl_i2c_data_read(struct file *f, char __user *buf,
 	}
 
 	sprintf(tmp_buf, "%#02llx\n", val);
-	rc = simple_read_from_buffer(buf, count, ppos, tmp_buf,
-			strlen(tmp_buf));
-
-	return rc;
+	return simple_copy_to_iter(tmp_buf, &iocb->ki_pos, strlen(tmp_buf), to);
 }
 
-static ssize_t hl_i2c_data_write(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_i2c_data_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u64 value;
 	ssize_t rc;
 
-	rc = kstrtou64_from_user(buf, count, 16, &value);
+	rc = kstrtou64_from_iter(from, count, 16, &value);
 	if (rc)
 		return rc;
 
@@ -1153,15 +1143,15 @@ static ssize_t hl_i2c_data_write(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_led0_write(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_led0_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u32 value;
 	ssize_t rc;
 
-	rc = kstrtouint_from_user(buf, count, 10, &value);
+	rc = kstrtouint_from_iter(from, count, 10, &value);
 	if (rc)
 		return rc;
 
@@ -1172,15 +1162,15 @@ static ssize_t hl_led0_write(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_led1_write(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_led1_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u32 value;
 	ssize_t rc;
 
-	rc = kstrtouint_from_user(buf, count, 10, &value);
+	rc = kstrtouint_from_iter(from, count, 10, &value);
 	if (rc)
 		return rc;
 
@@ -1191,15 +1181,15 @@ static ssize_t hl_led1_write(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_led2_write(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_led2_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u32 value;
 	ssize_t rc;
 
-	rc = kstrtouint_from_user(buf, count, 10, &value);
+	rc = kstrtouint_from_iter(from, count, 10, &value);
 	if (rc)
 		return rc;
 
@@ -1210,26 +1200,25 @@ static ssize_t hl_led2_write(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_device_read(struct file *f, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_device_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	static const char *help =
 		"Valid values: disable, enable, suspend, resume, cpu_timeout\n";
-	return simple_read_from_buffer(buf, count, ppos, help, strlen(help));
+	return simple_copy_to_iter(help, &iocb->ki_pos, strlen(help), to);
 }
 
-static ssize_t hl_device_write(struct file *f, const char __user *buf,
-				     size_t count, loff_t *ppos)
+static ssize_t hl_device_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	struct hl_device *hdev = entry->hdev;
+	size_t count = iov_iter_count(from);
 	char data[30] = {0};
 
 	/* don't allow partial writes */
-	if (*ppos != 0)
+	if (iocb->ki_pos)
 		return 0;
 
-	simple_write_to_buffer(data, 29, ppos, buf, count);
+	simple_copy_from_iter(data, &iocb->ki_pos, 29, from);
 
 	if (strncmp("disable", data, strlen("disable")) == 0) {
 		hdev->disabled = true;
@@ -1250,43 +1239,36 @@ static ssize_t hl_device_write(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_clk_gate_read(struct file *f, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_clk_gate_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
 
-static ssize_t hl_clk_gate_write(struct file *f, const char __user *buf,
-				     size_t count, loff_t *ppos)
+static ssize_t hl_clk_gate_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	return count;
+	return iov_iter_count(from);
 }
 
-static ssize_t hl_stop_on_err_read(struct file *f, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_stop_on_err_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	char tmp_buf[200];
-	ssize_t rc;
 
 	if (!hdev->asic_prop.configurable_stop_on_err)
 		return -EOPNOTSUPP;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	sprintf(tmp_buf, "%d\n", hdev->stop_on_err);
-	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
-			strlen(tmp_buf) + 1);
-
-	return rc;
+	return simple_copy_to_iter(tmp_buf, &iocb->ki_pos, strlen(tmp_buf) + 1, to);
 }
 
-static ssize_t hl_stop_on_err_write(struct file *f, const char __user *buf,
-				     size_t count, loff_t *ppos)
+static ssize_t hl_stop_on_err_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u32 value;
 	ssize_t rc;
@@ -1300,7 +1282,7 @@ static ssize_t hl_stop_on_err_write(struct file *f, const char __user *buf,
 		return 0;
 	}
 
-	rc = kstrtouint_from_user(buf, count, 10, &value);
+	rc = kstrtouint_from_iter(from, count, 10, &value);
 	if (rc)
 		return rc;
 
@@ -1311,10 +1293,10 @@ static ssize_t hl_stop_on_err_write(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_security_violations_read(struct file *f, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_security_violations_read(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	struct hl_device *hdev = entry->hdev;
 
 	hdev->asic_funcs->ack_protection_bits_errors(hdev);
@@ -1322,35 +1304,34 @@ static ssize_t hl_security_violations_read(struct file *f, char __user *buf,
 	return 0;
 }
 
-static ssize_t hl_state_dump_read(struct file *f, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_state_dump_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	ssize_t rc;
 
 	down_read(&entry->state_dump_sem);
 	if (!entry->state_dump[entry->state_dump_head])
 		rc = 0;
 	else
-		rc = simple_read_from_buffer(
-			buf, count, ppos,
+		rc = simple_copy_to_iter(
 			entry->state_dump[entry->state_dump_head],
-			strlen(entry->state_dump[entry->state_dump_head]));
+			&iocb->ki_pos,
+			strlen(entry->state_dump[entry->state_dump_head]), to);
 	up_read(&entry->state_dump_sem);
 
 	return rc;
 }
 
-static ssize_t hl_state_dump_write(struct file *f, const char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_state_dump_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	ssize_t rc;
 	u32 size;
 	int i;
 
-	rc = kstrtouint_from_user(buf, count, 10, &size);
+	rc = kstrtouint_from_iter(from, count, 10, &size);
 	if (rc)
 		return rc;
 
@@ -1376,34 +1357,30 @@ static ssize_t hl_state_dump_write(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_timeout_locked_read(struct file *f, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_timeout_locked_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	char tmp_buf[200];
-	ssize_t rc;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return 0;
 
 	sprintf(tmp_buf, "%d\n",
 		jiffies_to_msecs(hdev->timeout_jiffies) / 1000);
-	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
-			strlen(tmp_buf) + 1);
-
-	return rc;
+	return simple_copy_to_iter(tmp_buf, &iocb->ki_pos, strlen(tmp_buf) + 1, to);
 }
 
-static ssize_t hl_timeout_locked_write(struct file *f, const char __user *buf,
-				     size_t count, loff_t *ppos)
+static ssize_t hl_timeout_locked_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
+	size_t count = iov_iter_count(from);
 	struct hl_device *hdev = entry->hdev;
 	u32 value;
 	ssize_t rc;
 
-	rc = kstrtouint_from_user(buf, count, 10, &value);
+	rc = kstrtouint_from_iter(from, count, 10, &value);
 	if (rc)
 		return rc;
 
@@ -1415,10 +1392,9 @@ static ssize_t hl_timeout_locked_write(struct file *f, const char __user *buf,
 	return count;
 }
 
-static ssize_t hl_check_razwi_happened(struct file *f, char __user *buf,
-					size_t count, loff_t *ppos)
+static ssize_t hl_check_razwi_happened(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_dbg_device_entry *entry = file_inode(iocb->ki_filp)->i_private;
 	struct hl_device *hdev = entry->hdev;
 
 	hdev->asic_funcs->check_if_razwi_happened(hdev);
@@ -1428,96 +1404,96 @@ static ssize_t hl_check_razwi_happened(struct file *f, char __user *buf,
 
 static const struct file_operations hl_mem_scrub_fops = {
 	.owner = THIS_MODULE,
-	.write = hl_memory_scrub,
+	.write_iter = hl_memory_scrub
 };
 
 static const struct file_operations hl_data32b_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_data_read32,
-	.write = hl_data_write32
+	.read_iter = hl_data_read32,
+	.write_iter = hl_data_write32
 };
 
 static const struct file_operations hl_data64b_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_data_read64,
-	.write = hl_data_write64
+	.read_iter = hl_data_read64,
+	.write_iter = hl_data_write64
 };
 
 static const struct file_operations hl_dma_size_fops = {
 	.owner = THIS_MODULE,
-	.write = hl_dma_size_write
+	.write_iter = hl_dma_size_write
 };
 
 static const struct file_operations hl_monitor_dump_fops = {
 	.owner = THIS_MODULE,
-	.write = hl_monitor_dump_trigger
+	.write_iter = hl_monitor_dump_trigger
 };
 
 static const struct file_operations hl_i2c_data_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_i2c_data_read,
-	.write = hl_i2c_data_write
+	.read_iter = hl_i2c_data_read,
+	.write_iter = hl_i2c_data_write
 };
 
 static const struct file_operations hl_power_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_get_power_state,
-	.write = hl_set_power_state
+	.read_iter = hl_get_power_state,
+	.write_iter = hl_set_power_state
 };
 
 static const struct file_operations hl_led0_fops = {
 	.owner = THIS_MODULE,
-	.write = hl_led0_write
+	.write_iter = hl_led0_write
 };
 
 static const struct file_operations hl_led1_fops = {
 	.owner = THIS_MODULE,
-	.write = hl_led1_write
+	.write_iter = hl_led1_write
 };
 
 static const struct file_operations hl_led2_fops = {
 	.owner = THIS_MODULE,
-	.write = hl_led2_write
+	.write_iter = hl_led2_write
 };
 
 static const struct file_operations hl_device_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_device_read,
-	.write = hl_device_write
+	.read_iter = hl_device_read,
+	.write_iter = hl_device_write
 };
 
 static const struct file_operations hl_clk_gate_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_clk_gate_read,
-	.write = hl_clk_gate_write
+	.read_iter = hl_clk_gate_read,
+	.write_iter = hl_clk_gate_write
 };
 
 static const struct file_operations hl_stop_on_err_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_stop_on_err_read,
-	.write = hl_stop_on_err_write
+	.read_iter = hl_stop_on_err_read,
+	.write_iter = hl_stop_on_err_write
 };
 
 static const struct file_operations hl_security_violations_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_security_violations_read
+	.read_iter = hl_security_violations_read
 };
 
 static const struct file_operations hl_state_dump_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_state_dump_read,
-	.write = hl_state_dump_write
+	.read_iter = hl_state_dump_read,
+	.write_iter = hl_state_dump_write
 };
 
 static const struct file_operations hl_timeout_locked_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_timeout_locked_read,
-	.write = hl_timeout_locked_write
+	.read_iter = hl_timeout_locked_read,
+	.write_iter = hl_timeout_locked_write
 };
 
 static const struct file_operations hl_razwi_check_fops = {
 	.owner = THIS_MODULE,
-	.read = hl_check_razwi_happened
+	.read_iter = hl_check_razwi_happened
 };
 
 static const struct hl_info_list hl_debugfs_list[] = {
@@ -1539,13 +1515,12 @@ static int hl_debugfs_open(struct inode *inode, struct file *file)
 	return single_open(file, node->info_ent->show, node);
 }
 
-static ssize_t hl_debugfs_write(struct file *file, const char __user *buf,
-		size_t count, loff_t *f_pos)
+static ssize_t hl_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct hl_debugfs_entry *node = file->f_inode->i_private;
+	struct hl_debugfs_entry *node = iocb->ki_filp->f_inode->i_private;
 
 	if (node->info_ent->write)
-		return node->info_ent->write(file, buf, count, f_pos);
+		return node->info_ent->write(iocb, from);
 	else
 		return -EINVAL;
 
@@ -1554,8 +1529,8 @@ static ssize_t hl_debugfs_write(struct file *file, const char __user *buf,
 static const struct file_operations hl_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = hl_debugfs_open,
-	.read = seq_read,
-	.write = hl_debugfs_write,
+	.read_iter = seq_read_iter,
+	.write_iter = hl_debugfs_write,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 48f0f3eea1ef..ccf329c83f30 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -2338,8 +2338,7 @@ struct hl_fpriv {
 struct hl_info_list {
 	const char	*name;
 	int		(*show)(struct seq_file *s, void *data);
-	ssize_t		(*write)(struct file *file, const char __user *buf,
-				size_t count, loff_t *f_pos);
+	ssize_t		(*write)(struct kiocb *, struct iov_iter *);
 };
 
 /**
diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index d09d29775b3f..c2db7689437c 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -116,15 +116,15 @@ static const struct drm_debugfs_info vdev_debugfs_list[] = {
 	{"reset_pending", reset_pending_show, 0},
 };
 
-static ssize_t
-dvfs_mode_fops_write(struct file *file, const char __user *user_buf, size_t size, loff_t *pos)
+static ssize_t dvfs_mode_fops_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ivpu_device *vdev = file->private_data;
+	struct ivpu_device *vdev = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	struct ivpu_fw_info *fw = vdev->fw;
 	u32 dvfs_mode;
 	int ret;
 
-	ret = kstrtou32_from_user(user_buf, size, 0, &dvfs_mode);
+	ret = kstrtou32_from_iter(from, size, 0, &dvfs_mode);
 	if (ret < 0)
 		return ret;
 
@@ -140,7 +140,7 @@ dvfs_mode_fops_write(struct file *file, const char __user *user_buf, size_t size
 static const struct file_operations dvfs_mode_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = dvfs_mode_fops_write,
+	.write_iter = dvfs_mode_fops_write,
 };
 
 static int fw_log_show(struct seq_file *s, void *v)
@@ -157,37 +157,36 @@ static int fw_log_fops_open(struct inode *inode, struct file *file)
 	return single_open(file, fw_log_show, inode->i_private);
 }
 
-static ssize_t
-fw_log_fops_write(struct file *file, const char __user *user_buf, size_t size, loff_t *pos)
+static ssize_t fw_log_fops_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
 	struct ivpu_device *vdev = s->private;
 
-	if (!size)
+	if (!iov_iter_count(from))
 		return -EINVAL;
 
 	ivpu_fw_log_clear(vdev);
-	return size;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations fw_log_fops = {
 	.owner = THIS_MODULE,
 	.open = fw_log_fops_open,
-	.write = fw_log_fops_write,
-	.read = seq_read,
+	.write_iter = fw_log_fops_write,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
 
 static ssize_t
-fw_profiling_freq_fops_write(struct file *file, const char __user *user_buf,
-			     size_t size, loff_t *pos)
+fw_profiling_freq_fops_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ivpu_device *vdev = file->private_data;
+	struct ivpu_device *vdev = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	bool enable;
 	int ret;
 
-	ret = kstrtobool_from_user(user_buf, size, &enable);
+	ret = kstrtobool_from_iter(from, size, &enable);
 	if (ret < 0)
 		return ret;
 
@@ -203,19 +202,19 @@ fw_profiling_freq_fops_write(struct file *file, const char __user *user_buf,
 static const struct file_operations fw_profiling_freq_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = fw_profiling_freq_fops_write,
+	.write_iter = fw_profiling_freq_fops_write,
 };
 
 static ssize_t
-fw_trace_destination_mask_fops_write(struct file *file, const char __user *user_buf,
-				     size_t size, loff_t *pos)
+fw_trace_destination_mask_fops_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ivpu_device *vdev = file->private_data;
+	struct ivpu_device *vdev = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	struct ivpu_fw_info *fw = vdev->fw;
 	u32 trace_destination_mask;
 	int ret;
 
-	ret = kstrtou32_from_user(user_buf, size, 0, &trace_destination_mask);
+	ret = kstrtou32_from_iter(from, size, 0, &trace_destination_mask);
 	if (ret < 0)
 		return ret;
 
@@ -230,19 +229,19 @@ fw_trace_destination_mask_fops_write(struct file *file, const char __user *user_
 static const struct file_operations fw_trace_destination_mask_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = fw_trace_destination_mask_fops_write,
+	.write_iter = fw_trace_destination_mask_fops_write,
 };
 
 static ssize_t
-fw_trace_hw_comp_mask_fops_write(struct file *file, const char __user *user_buf,
-				 size_t size, loff_t *pos)
+fw_trace_hw_comp_mask_fops_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ivpu_device *vdev = file->private_data;
+	struct ivpu_device *vdev = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	struct ivpu_fw_info *fw = vdev->fw;
 	u64 trace_hw_component_mask;
 	int ret;
 
-	ret = kstrtou64_from_user(user_buf, size, 0, &trace_hw_component_mask);
+	ret = kstrtou64_from_iter(from, size, 0, &trace_hw_component_mask);
 	if (ret < 0)
 		return ret;
 
@@ -257,18 +256,19 @@ fw_trace_hw_comp_mask_fops_write(struct file *file, const char __user *user_buf,
 static const struct file_operations fw_trace_hw_comp_mask_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = fw_trace_hw_comp_mask_fops_write,
+	.write_iter = fw_trace_hw_comp_mask_fops_write,
 };
 
 static ssize_t
-fw_trace_level_fops_write(struct file *file, const char __user *user_buf, size_t size, loff_t *pos)
+fw_trace_level_fops_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ivpu_device *vdev = file->private_data;
+	struct ivpu_device *vdev = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(from);
 	struct ivpu_fw_info *fw = vdev->fw;
 	u32 trace_level;
 	int ret;
 
-	ret = kstrtou32_from_user(user_buf, size, 0, &trace_level);
+	ret = kstrtou32_from_iter(from, size, 0, &trace_level);
 	if (ret < 0)
 		return ret;
 
@@ -283,16 +283,15 @@ fw_trace_level_fops_write(struct file *file, const char __user *user_buf, size_t
 static const struct file_operations fw_trace_level_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = fw_trace_level_fops_write,
+	.write_iter = fw_trace_level_fops_write,
 };
 
-static ssize_t
-ivpu_force_recovery_fn(struct file *file, const char __user *user_buf, size_t size, loff_t *pos)
+static ssize_t ivpu_force_recovery_fn(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ivpu_device *vdev = file->private_data;
+	struct ivpu_device *vdev = iocb->ki_filp->private_data;
 	int ret;
 
-	if (!size)
+	if (!iov_iter_count(from))
 		return -EINVAL;
 
 	ret = ivpu_rpm_get(vdev);
@@ -302,21 +301,20 @@ ivpu_force_recovery_fn(struct file *file, const char __user *user_buf, size_t si
 	ivpu_pm_trigger_recovery(vdev, "debugfs");
 	flush_work(&vdev->pm->recovery_work);
 	ivpu_rpm_put(vdev);
-	return size;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations ivpu_force_recovery_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = ivpu_force_recovery_fn,
+	.write_iter = ivpu_force_recovery_fn,
 };
 
-static ssize_t
-ivpu_reset_engine_fn(struct file *file, const char __user *user_buf, size_t size, loff_t *pos)
+static ssize_t ivpu_reset_engine_fn(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ivpu_device *vdev = file->private_data;
+	struct ivpu_device *vdev = iocb->ki_filp->private_data;
 
-	if (!size)
+	if (!iov_iter_count(from))
 		return -EINVAL;
 
 	if (ivpu_jsm_reset_engine(vdev, DRM_IVPU_ENGINE_COMPUTE))
@@ -324,13 +322,13 @@ ivpu_reset_engine_fn(struct file *file, const char __user *user_buf, size_t size
 	if (ivpu_jsm_reset_engine(vdev, DRM_IVPU_ENGINE_COPY))
 		return -ENODEV;
 
-	return size;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations ivpu_reset_engine_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.write = ivpu_reset_engine_fn,
+	.write_iter = ivpu_reset_engine_fn,
 };
 
 void ivpu_debugfs_init(struct ivpu_device *vdev)
-- 
2.43.0


