Return-Path: <linux-kernel+bounces-141119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBF68A1A93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F852873D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643571E8307;
	Thu, 11 Apr 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u/QTzRtU"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A11E6F5F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850067; cv=none; b=igBMCrWQDBclzes6WtYUDpq+JucGnyak+qHRi9efkDp2Piip1ll4rXNTtGxy5Exg16p87ie0MIvGy/RBwtl28Ph0hgoEkItvDetBFNAnwVA+37n3Vw8KH5IF+tsmi4vOIsqJLfJMeGFoecwYPe6C0GicwMwDYS4Wq9lQpgz5Ht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850067; c=relaxed/simple;
	bh=NcCey28QxJieT+UjRuZ77X2FGjw1+do6lFFpsmJ0A9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pI0aWzYCC51rJiwSD3Cyhomn49lz86c+Shl+qzGl/cC6fSFs1rU1267s7Ao/evlLKIbvUANlbjiFmAMHHjCr/2LJA1VHHWs30wBtHxCF3dWHuE1VEV7UiRn54zBr1vnDusRS1iDVLEMJVYcijtrHFOixy/UK6+2y85bnq91+5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u/QTzRtU; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170620539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850064; x=1713454864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+H2jBq3RtSTJ6hQiTl82f8Q+bNLXTmf8hg8XWogEvuU=;
        b=u/QTzRtUPqqBcNN0jzn3/j5lYTsPyXr3oezPXC8Dxyt+6SX3mK3C5NfCYBnNqNYZD0
         ypinCKIvzQdX9hWZmXkcEJB0cg89D4TWdulJtuLlR6845KUVKKIeZgFi3aPuco3G+/fp
         yh4Vnn9Ehx0LGniyOkbkCnFlcWTN0D6GnvtqMMrvt18gvgemiNq+yE/9EotGoePaAfym
         glzQZtSvCNAbayz9YrLV/Fch0yeuSaYCivpLF6mK/h9AsgczN7bPlNEvP2J+eNZTr3/d
         2tLRu+het22kXAeih0D+RK9jJ7KvTRuYRzTdrjV/bpfgJKw2krG9A76HSG9O2uKnqYM3
         fjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850064; x=1713454864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+H2jBq3RtSTJ6hQiTl82f8Q+bNLXTmf8hg8XWogEvuU=;
        b=cW6niOx9E3kK9Lh90VaWydD3EqqP04WI3z3IDG8if59FA3I42LV0oZRMhg0rZO6vrW
         zz8PLkknhYVYFAVeZxwXCg7UUD0WxzUtX2udL+SWoGAZPf9Q55GUasnHcdWXa5D3DykC
         S/ycPxiMKBV6+Ia+UEZlmlh7E2k5Bl6cLOY8K3bF+fCgeam95JxFf8FMx4xoXN3vsynG
         7f4xPXaWZVu14E9Mb8SBHYNt7yY5qNW9aiYtzE9GTZgruJuzdEJ3EnfIO1MUD59+diSZ
         RlzhJGasmoU+lSy1WwrutgYvOH0P7YegHOQYl4Cl0yNUSEsndGRfOHmV1YYiHL9WXjC9
         7i9A==
X-Gm-Message-State: AOJu0YzLB8yyKG+gyAdClWLbbqz4Z0Y8HF6ldWvnjbO8wuYA2Tx1hx5l
	MDCvNyU7yX0sVXANxx8znMfJmlZayb9Hcxxa/XEkCLlbwLV9+3pQpYXPG0qc9lGOQEFDYZ6OGiz
	j
X-Google-Smtp-Source: AGHT+IFElkIuhoDFYWg9yDYuBEX+eR1w5zIysNG+tkoHI4PQkkkvz5fZEdaKdO6cHBXmU/8jhTUTCQ==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr193503ioj.2.1712850063990;
        Thu, 11 Apr 2024 08:41:03 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 340/437] powerpc/platforms: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:00 -0600
Message-ID: <20240411153126.16201-341-axboe@kernel.dk>
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
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c    |  7 ++---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 11 ++++---
 arch/powerpc/platforms/powernv/memtrace.c    |  9 +++---
 arch/powerpc/platforms/powernv/opal-lpc.c    |  6 ++--
 arch/powerpc/platforms/powernv/opal-prd.c    | 22 +++++++-------
 arch/powerpc/platforms/powernv/opal-xscom.c  | 30 +++++++++-----------
 arch/powerpc/platforms/pseries/dtl.c         | 16 +++++------
 arch/powerpc/platforms/pseries/lpar.c        | 11 ++++---
 arch/powerpc/platforms/pseries/papr-vpd.c    |  8 +++---
 9 files changed, 57 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 581059527c36..d166f153ad12 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -530,10 +530,9 @@ static inline void mpc52xx_gpt_wdt_ping(struct mpc52xx_gpt_priv *gpt_wdt)
 }
 
 /* wdt misc device api */
-static ssize_t mpc52xx_wdt_write(struct file *file, const char __user *data,
-				 size_t len, loff_t *ppos)
+static ssize_t mpc52xx_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mpc52xx_gpt_priv *gpt_wdt = file->private_data;
+	struct mpc52xx_gpt_priv *gpt_wdt = iocb->ki_filp->private_data;
 	mpc52xx_gpt_wdt_ping(gpt_wdt);
 	return 0;
 }
@@ -645,7 +644,7 @@ static int mpc52xx_wdt_release(struct inode *inode, struct file *file)
 static const struct file_operations mpc52xx_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= mpc52xx_wdt_write,
+	.write_iter	= mpc52xx_wdt_write,
 	.unlocked_ioctl = mpc52xx_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= mpc52xx_wdt_open,
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index af3a5d37a149..c2a6081fed1d 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -62,11 +62,10 @@ static irqreturn_t pnv_eeh_event(int irq, void *data)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static ssize_t pnv_eeh_ei_write(struct file *filp,
-				const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t pnv_eeh_ei_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct pci_controller *hose = filp->private_data;
+	struct pci_controller *hose = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct eeh_pe *pe;
 	int pe_no, type, func;
 	unsigned long addr, mask;
@@ -77,7 +76,7 @@ static ssize_t pnv_eeh_ei_write(struct file *filp,
 		return -ENXIO;
 
 	/* Copy over argument buffer */
-	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, sizeof(buf), from);
 	if (!ret)
 		return -EFAULT;
 
@@ -100,7 +99,7 @@ static ssize_t pnv_eeh_ei_write(struct file *filp,
 static const struct file_operations pnv_eeh_ei_fops = {
 	.open	= simple_open,
 	.llseek	= no_llseek,
-	.write	= pnv_eeh_ei_write,
+	.write_iter	= pnv_eeh_ei_write,
 };
 
 static int pnv_eeh_dbgfs_set(void *data, int offset, u64 val)
diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index 877720c64515..366da300e605 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -37,12 +37,11 @@ static struct memtrace_entry *memtrace_array;
 static unsigned int memtrace_array_nr;
 
 
-static ssize_t memtrace_read(struct file *filp, char __user *ubuf,
-			     size_t count, loff_t *ppos)
+static ssize_t memtrace_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct memtrace_entry *ent = filp->private_data;
+	struct memtrace_entry *ent = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(ubuf, count, ppos, ent->mem, ent->size);
+	return simple_copy_to_iter(ent->mem, &iocb->ki_pos, ent->size, to);
 }
 
 static int memtrace_mmap(struct file *filp, struct vm_area_struct *vma)
@@ -62,7 +61,7 @@ static int memtrace_mmap(struct file *filp, struct vm_area_struct *vma)
 
 static const struct file_operations memtrace_fops = {
 	.llseek = default_llseek,
-	.read	= memtrace_read,
+	.read_iter = memtrace_read,
 	.open	= simple_open,
 	.mmap   = memtrace_mmap,
 };
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index a16f07cdab26..e2f18ed6af17 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -271,6 +271,7 @@ static ssize_t lpc_debug_read(struct file *filp, char __user *ubuf,
 
 	return count;
 }
+FOPS_READ_ITER_HELPER(lpc_debug_read);
 
 static ssize_t lpc_debug_write(struct file *filp, const char __user *ubuf,
 			       size_t count, loff_t *ppos)
@@ -342,10 +343,11 @@ static ssize_t lpc_debug_write(struct file *filp, const char __user *ubuf,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(lpc_debug_write);
 
 static const struct file_operations lpc_fops = {
-	.read =		lpc_debug_read,
-	.write =	lpc_debug_write,
+	.read_iter =	lpc_debug_read_iter,
+	.write_iter =	lpc_debug_write_iter,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
index 24f04f20d3e8..ac760ad1e46d 100644
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -156,10 +156,10 @@ static __poll_t opal_prd_poll(struct file *file,
 	return 0;
 }
 
-static ssize_t opal_prd_read(struct file *file, char __user *buf,
-		size_t count, loff_t *ppos)
+static ssize_t opal_prd_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct opal_prd_msg_queue_item *item;
+	size_t count = iov_iter_count(to);
 	unsigned long flags;
 	ssize_t size, err;
 	int rc;
@@ -168,7 +168,7 @@ static ssize_t opal_prd_read(struct file *file, char __user *buf,
 	if (count < sizeof(item->msg.header))
 		return -EINVAL;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return -ESPIPE;
 
 	item = NULL;
@@ -186,7 +186,7 @@ static ssize_t opal_prd_read(struct file *file, char __user *buf,
 		if (item)
 			break;
 
-		if (file->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
 		rc = wait_event_interruptible(opal_prd_msg_wait,
@@ -201,7 +201,7 @@ static ssize_t opal_prd_read(struct file *file, char __user *buf,
 		goto err_requeue;
 	}
 
-	rc = copy_to_user(buf, &item->msg, size);
+	rc = !copy_to_iter_full(&item->msg, size, to);
 	if (rc) {
 		err = -EFAULT;
 		goto err_requeue;
@@ -219,9 +219,9 @@ static ssize_t opal_prd_read(struct file *file, char __user *buf,
 	return err;
 }
 
-static ssize_t opal_prd_write(struct file *file, const char __user *buf,
-		size_t count, loff_t *ppos)
+static ssize_t opal_prd_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct opal_prd_msg_header hdr;
 	struct opal_prd_msg *msg;
 	ssize_t size;
@@ -233,13 +233,13 @@ static ssize_t opal_prd_write(struct file *file, const char __user *buf,
 		return -EINVAL;
 
 	/* grab the header */
-	rc = copy_from_user(&hdr, buf, sizeof(hdr));
+	rc = !copy_from_iter_full(&hdr, sizeof(hdr), from);
 	if (rc)
 		return -EFAULT;
 
 	size = be16_to_cpu(hdr.size);
 
-	msg = memdup_user(buf, size);
+	msg = iterdup(from, size);
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
@@ -325,8 +325,8 @@ static const struct file_operations opal_prd_fops = {
 	.open		= opal_prd_open,
 	.mmap		= opal_prd_mmap,
 	.poll		= opal_prd_poll,
-	.read		= opal_prd_read,
-	.write		= opal_prd_write,
+	.read_iter	= opal_prd_read,
+	.write_iter	= opal_prd_write,
 	.unlocked_ioctl	= opal_prd_ioctl,
 	.release	= opal_prd_release,
 	.owner		= THIS_MODULE,
diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 748c2b97fa53..344bc747f576 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -84,12 +84,11 @@ struct scom_debug_entry {
 	char name[16];
 };
 
-static ssize_t scom_debug_read(struct file *filp, char __user *ubuf,
-			       size_t count, loff_t *ppos)
+static ssize_t scom_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct scom_debug_entry *ent = filp->private_data;
-	u64 __user *ubuf64 = (u64 __user *)ubuf;
-	loff_t off = *ppos;
+	struct scom_debug_entry *ent = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
+	loff_t off = iocb->ki_pos;
 	ssize_t done = 0;
 	u64 reg, reg_base, reg_cnt, val;
 	int rc;
@@ -102,25 +101,23 @@ static ssize_t scom_debug_read(struct file *filp, char __user *ubuf,
 	for (reg = 0; reg < reg_cnt; reg++) {
 		rc = opal_scom_read(ent->chip, reg_base, reg, &val);
 		if (!rc)
-			rc = put_user(val, ubuf64);
+			rc = put_iter(val, to);
 		if (rc) {
 			if (!done)
 				done = rc;
 			break;
 		}
-		ubuf64++;
-		*ppos += 8;
+		iocb->ki_pos += 8;
 		done += 8;
 	}
 	return done;
 }
 
-static ssize_t scom_debug_write(struct file *filp, const char __user *ubuf,
-				size_t count, loff_t *ppos)
+static ssize_t scom_debug_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct scom_debug_entry *ent = filp->private_data;
-	u64 __user *ubuf64 = (u64 __user *)ubuf;
-	loff_t off = *ppos;
+	struct scom_debug_entry *ent = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
+	loff_t off = iocb->ki_pos;
 	ssize_t done = 0;
 	u64 reg, reg_base, reg_cnt, val;
 	int rc;
@@ -131,7 +128,7 @@ static ssize_t scom_debug_write(struct file *filp, const char __user *ubuf,
 	reg_cnt = count >> 3;
 
 	for (reg = 0; reg < reg_cnt; reg++) {
-		rc = get_user(val, ubuf64);
+		rc = get_iter(val, from);
 		if (!rc)
 			rc = opal_scom_write(ent->chip, reg_base, reg,  val);
 		if (rc) {
@@ -139,15 +136,14 @@ static ssize_t scom_debug_write(struct file *filp, const char __user *ubuf,
 				done = rc;
 			break;
 		}
-		ubuf64++;
 		done += 8;
 	}
 	return done;
 }
 
 static const struct file_operations scom_debug_fops = {
-	.read =		scom_debug_read,
-	.write =	scom_debug_write,
+	.read_iter =	scom_debug_read,
+	.write_iter =	scom_debug_write,
 	.open =		simple_open,
 	.llseek =	default_llseek,
 };
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 3f1cdccebc9c..3efb00703b43 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -257,17 +257,17 @@ static int dtl_file_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t dtl_file_read(struct file *filp, char __user *buf, size_t len,
-		loff_t *pos)
+static ssize_t dtl_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	long int rc, n_read, n_req, read_size;
+	size_t len = iov_iter_count(to);
 	struct dtl *dtl;
 	u64 cur_idx, last_idx, i;
 
 	if ((len % sizeof(struct dtl_entry)) != 0)
 		return -EINVAL;
 
-	dtl = filp->private_data;
+	dtl = iocb->ki_filp->private_data;
 
 	/* requested number of entries to read */
 	n_req = len / sizeof(struct dtl_entry);
@@ -300,19 +300,19 @@ static ssize_t dtl_file_read(struct file *filp, char __user *buf, size_t len,
 	if (i + n_req > dtl->buf_entries) {
 		read_size = dtl->buf_entries - i;
 
-		rc = copy_to_user(buf, &dtl->buf[i],
-				read_size * sizeof(struct dtl_entry));
+		rc = !copy_to_iter_full(&dtl->buf[i],
+				read_size * sizeof(struct dtl_entry), to);
 		if (rc)
 			return -EFAULT;
 
 		i = 0;
 		n_req -= read_size;
 		n_read += read_size;
-		buf += read_size * sizeof(struct dtl_entry);
 	}
 
 	/* .. and now the head */
-	rc = copy_to_user(buf, &dtl->buf[i], n_req * sizeof(struct dtl_entry));
+	rc = !copy_to_iter_full(&dtl->buf[i], n_req * sizeof(struct dtl_entry),
+				to);
 	if (rc)
 		return -EFAULT;
 
@@ -324,7 +324,7 @@ static ssize_t dtl_file_read(struct file *filp, char __user *buf, size_t len,
 static const struct file_operations dtl_fops = {
 	.open		= dtl_file_open,
 	.release	= dtl_file_release,
-	.read		= dtl_file_read,
+	.read_iter	= dtl_file_read,
 	.llseek		= no_llseek,
 };
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 4e9916bb03d7..2ccbcf9f295a 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1991,19 +1991,18 @@ machine_device_initcall(pseries, reserve_vrma_context_id);
 
 #ifdef CONFIG_DEBUG_FS
 /* debugfs file interface for vpa data */
-static ssize_t vpa_file_read(struct file *filp, char __user *buf, size_t len,
-			      loff_t *pos)
+static ssize_t vpa_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	int cpu = (long)filp->private_data;
+	int cpu = (long)iocb->ki_filp->private_data;
 	struct lppaca *lppaca = &lppaca_of(cpu);
 
-	return simple_read_from_buffer(buf, len, pos, lppaca,
-				sizeof(struct lppaca));
+	return simple_copy_to_iter(lppaca, &iocb->ki_pos, sizeof(struct lppaca),
+					to);
 }
 
 static const struct file_operations vpa_fops = {
 	.open		= simple_open,
-	.read		= vpa_file_read,
+	.read_iter	= vpa_file_read,
 	.llseek		= default_llseek,
 };
 
diff --git a/arch/powerpc/platforms/pseries/papr-vpd.c b/arch/powerpc/platforms/pseries/papr-vpd.c
index c29e85db5f35..bab048029ed5 100644
--- a/arch/powerpc/platforms/pseries/papr-vpd.c
+++ b/arch/powerpc/platforms/pseries/papr-vpd.c
@@ -408,9 +408,9 @@ static const struct vpd_blob *papr_vpd_retrieve(const struct papr_location_code
 	return blob;
 }
 
-static ssize_t papr_vpd_handle_read(struct file *file, char __user *buf, size_t size, loff_t *off)
+static ssize_t papr_vpd_handle_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	const struct vpd_blob *blob = file->private_data;
+	const struct vpd_blob *blob = iocb->ki_filp->private_data;
 
 	/* bug: we should not instantiate a handle without any data attached. */
 	if (!vpd_blob_has_data(blob)) {
@@ -418,7 +418,7 @@ static ssize_t papr_vpd_handle_read(struct file *file, char __user *buf, size_t
 		return -EIO;
 	}
 
-	return simple_read_from_buffer(buf, size, off, blob->data, blob->len);
+	return simple_copy_to_iter(blob->data, &iocb->ki_pos, blob->len, to);
 }
 
 static int papr_vpd_handle_release(struct inode *inode, struct file *file)
@@ -439,7 +439,7 @@ static loff_t papr_vpd_handle_seek(struct file *file, loff_t off, int whence)
 
 
 static const struct file_operations papr_vpd_handle_ops = {
-	.read = papr_vpd_handle_read,
+	.read_iter = papr_vpd_handle_read,
 	.llseek = papr_vpd_handle_seek,
 	.release = papr_vpd_handle_release,
 };
-- 
2.43.0


