Return-Path: <linux-kernel+bounces-141117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C68A1AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5ACB28570
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21E61E82E6;
	Thu, 11 Apr 2024 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XBmfMfVM"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE4C1E7951
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850064; cv=none; b=KLTQ2TB6LxvPbI2xvhXsfp6t8R1t9PGGrUWinkbMLTmDmtDrieHB9pHdkTwEL7EdoIOgeSAz5jyhEc/xBQ3ShRgrPgqEG0OWGijTzcOk5hUKPs8RMGHR/mNZrrRTTE9Q+iUtLUQf0GnuS0XzdiBdN/0bP0n433WszO5a4w9ajiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850064; c=relaxed/simple;
	bh=9jW6lrprrj1HA+2f2gC3Sd1+mMD7DmMEMcCnFIEuglI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJtzr9Qm/bJgouV+v/YZf4XAL6gwPwzAQ9RYVZLjTc+3MPgf8NFONZT6wm1QMz08PnANeFpq6qjQm9C/JlHl4jOIfRRdJVj+J4UgXeIR6D66TP4hxheB7QxepOzldnkeGxoj9XTLEzOttEtD4TOyf/ps0yfMmdrO359gVMbML0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XBmfMfVM; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a224d7414so194165ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850062; x=1713454862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pKslmHBks9Vf7/ET2nkKT6N6HYCbV1INzf0XN948lw=;
        b=XBmfMfVM8s5WFz7Hb+6vwv2A319y+m6TjYixylruHP+yxL4bhWZFjougU5txFc+Z+8
         4Wx6cv14j1zokL1gprbN/+GQNBU9+FRyDadC6xOMSwqCQ0HUNyzVCQYxxG3ERKjuqS1U
         jsxDM3DbClu5YCPzZhBEeqmFXu2z325+nnkcdmC18qbw8rylw3q5AAiG+bDLFunALDLK
         oRsu9eRBd3r3XWD4KMfOw0HanzBSV7SJDZj3VwQ4fvwzHYbDY6t4mnD8VRiWoi9+YwrJ
         CCmYtkIjdM1RxYWDJmsUYSwxEYhBl1kLrsJH68GjrV/Tq4WFZSusVkpgG51ter2HVM5Z
         31sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850062; x=1713454862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pKslmHBks9Vf7/ET2nkKT6N6HYCbV1INzf0XN948lw=;
        b=GQF+29Y1uN7Hg+2Kt4TbH1DifRwMj76JZ2Bz6TrQaPIYeyyFindLZ0D9oBFkRyTxct
         yn1R+0GI0ILgP6DVvc1EiY0R0j/QwWnLtuhlG/L5QYRmyOsBrDbSlztiY2jZ6RyMvoQg
         J5IaiQgjFe5e+6yB96GksnDADJ1h2XI1IeehJyxP+h83nuahZx8DbdZB5V2JvNH/iH7q
         nL50HN6aTGWOyGXmNc8jaDb0k7Aa9kYDjgvFM365rulmfezSDhMW5uH5rW/cqvPCEchw
         tHORJzn07zNcmzeOHOONrcBcVAnJDLXdjbv7amTpnFONcTPxWUGDPulIXl/vPjzXyDGQ
         VNpw==
X-Gm-Message-State: AOJu0Ywi1fmDKdrnShH8jfMJfxAuOrLpcwNBMy3fi3aI/t2KYZbZxhoM
	mgBGu7ibH3pJXrsGTRn6VsdiU8obg2bGHiNJt/nckArTY88OdEne91XISg9hUg+ZqOSplE3jqz2
	t
X-Google-Smtp-Source: AGHT+IF/XQZXykrePYOBwiuvLl7lFDDE2Q8xwGP44PSvcqreH8eH80rXHjcy817ze45s2ph83hkbug==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr160541ioc.2.1712850061714;
        Thu, 11 Apr 2024 08:41:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 338/437] powerpc/kvm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:58 -0600
Message-ID: <20240411153126.16201-339-axboe@kernel.dk>
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
 arch/powerpc/kvm/book3s_64_mmu_hv.c    | 25 ++++++++++++-------------
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 19 ++++++++-----------
 arch/powerpc/kvm/book3s_hv.c           | 26 +++++++++++---------------
 arch/powerpc/kvm/timing.c              | 14 +++++++-------
 4 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2b1f0cdd8c18..254a267cac6f 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1820,6 +1820,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 
 	return nb;
 }
+FOPS_READ_ITER_HELPER(kvm_htab_read);
 
 static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
@@ -1943,6 +1944,7 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 		return err;
 	return nb;
 }
+FOPS_WRITE_ITER_HELPER(kvm_htab_write);
 
 static int kvm_htab_release(struct inode *inode, struct file *filp)
 {
@@ -1957,8 +1959,8 @@ static int kvm_htab_release(struct inode *inode, struct file *filp)
 }
 
 static const struct file_operations kvm_htab_fops = {
-	.read		= kvm_htab_read,
-	.write		= kvm_htab_write,
+	.read_iter	= kvm_htab_read_iter,
+	.write_iter	= kvm_htab_write_iter,
 	.llseek		= default_llseek,
 	.release	= kvm_htab_release,
 };
@@ -2035,10 +2037,10 @@ static int debugfs_htab_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
-				 size_t len, loff_t *ppos)
+static ssize_t debugfs_htab_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct debugfs_htab_state *p = file->private_data;
+	struct debugfs_htab_state *p = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	ssize_t ret, r;
 	unsigned long i, n;
 	unsigned long v, hr, gr;
@@ -2057,11 +2059,10 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
 		n = p->chars_left;
 		if (n > len)
 			n = len;
-		r = copy_to_user(buf, p->buf + p->buf_index, n);
+		r = copy_to_iter(p->buf + p->buf_index, n, to);
 		n -= r;
 		p->chars_left -= n;
 		p->buf_index += n;
-		buf += n;
 		len -= n;
 		ret = n;
 		if (r) {
@@ -2097,11 +2098,10 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
 		p->chars_left = n;
 		if (n > len)
 			n = len;
-		r = copy_to_user(buf, p->buf, n);
+		r = copy_to_iter(p->buf, n, to);
 		n -= r;
 		p->chars_left -= n;
 		p->buf_index = n;
-		buf += n;
 		len -= n;
 		ret += n;
 		if (r) {
@@ -2117,8 +2117,7 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
 	return ret;
 }
 
-static ssize_t debugfs_htab_write(struct file *file, const char __user *buf,
-			   size_t len, loff_t *ppos)
+static ssize_t debugfs_htab_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return -EACCES;
 }
@@ -2127,8 +2126,8 @@ static const struct file_operations debugfs_htab_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = debugfs_htab_open,
 	.release = debugfs_htab_release,
-	.read	 = debugfs_htab_read,
-	.write	 = debugfs_htab_write,
+	.read_iter  = debugfs_htab_read,
+	.write_iter = debugfs_htab_write,
 	.llseek	 = generic_file_llseek,
 };
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 408d98f8a514..d33c92bbe6f2 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -1298,10 +1298,10 @@ static int debugfs_radix_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
-				 size_t len, loff_t *ppos)
+static ssize_t debugfs_radix_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct debugfs_radix_state *p = file->private_data;
+	struct debugfs_radix_state *p = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	ssize_t ret, r;
 	unsigned long n;
 	struct kvm *kvm;
@@ -1328,11 +1328,10 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 		n = p->chars_left;
 		if (n > len)
 			n = len;
-		r = copy_to_user(buf, p->buf + p->buf_index, n);
+		r = copy_to_iter(p->buf + p->buf_index, n, to);
 		n -= r;
 		p->chars_left -= n;
 		p->buf_index += n;
-		buf += n;
 		len -= n;
 		ret = n;
 		if (r) {
@@ -1428,11 +1427,10 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 		p->chars_left = n;
 		if (n > len)
 			n = len;
-		r = copy_to_user(buf, p->buf, n);
+		r = copy_to_iter(p->buf, n, to);
 		n -= r;
 		p->chars_left -= n;
 		p->buf_index = n;
-		buf += n;
 		len -= n;
 		ret += n;
 		if (r) {
@@ -1450,8 +1448,7 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
 	return ret;
 }
 
-static ssize_t debugfs_radix_write(struct file *file, const char __user *buf,
-			   size_t len, loff_t *ppos)
+static ssize_t debugfs_radix_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return -EACCES;
 }
@@ -1460,8 +1457,8 @@ static const struct file_operations debugfs_radix_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = debugfs_radix_open,
 	.release = debugfs_radix_release,
-	.read	 = debugfs_radix_read,
-	.write	 = debugfs_radix_write,
+	.read_iter  = debugfs_radix_read,
+	.write_iter = debugfs_radix_write,
 	.llseek	 = generic_file_llseek,
 };
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8e86eb577eb8..33ccdf765395 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2860,10 +2860,10 @@ static int debugfs_timings_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t debugfs_timings_read(struct file *file, char __user *buf,
-				    size_t len, loff_t *ppos)
+static ssize_t debugfs_timings_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct debugfs_timings_state *p = file->private_data;
+	struct debugfs_timings_state *p = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	struct kvm_vcpu *vcpu = p->vcpu;
 	char *s, *buf_end;
 	struct kvmhv_tb_accumulator tb;
@@ -2910,23 +2910,19 @@ static ssize_t debugfs_timings_read(struct file *file, char __user *buf,
 		p->buflen = s - p->buf;
 	}
 
-	pos = *ppos;
+	pos = iocb->ki_pos;
 	if (pos >= p->buflen)
 		return 0;
 	if (len > p->buflen - pos)
 		len = p->buflen - pos;
-	n = copy_to_user(buf, p->buf + pos, len);
-	if (n) {
-		if (n == len)
-			return -EFAULT;
-		len -= n;
-	}
-	*ppos = pos + len;
+	n = !copy_to_iter_full(p->buf + pos, len, to);
+	if (n)
+		return -EFAULT;
+	iocb->ki_pos = pos + len;
 	return len;
 }
 
-static ssize_t debugfs_timings_write(struct file *file, const char __user *buf,
-				     size_t len, loff_t *ppos)
+static ssize_t debugfs_timings_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return -EACCES;
 }
@@ -2935,8 +2931,8 @@ static const struct file_operations debugfs_timings_ops = {
 	.owner	 = THIS_MODULE,
 	.open	 = debugfs_timings_open,
 	.release = debugfs_timings_release,
-	.read	 = debugfs_timings_read,
-	.write	 = debugfs_timings_write,
+	.read_iter = debugfs_timings_read,
+	.write_iter = debugfs_timings_write,
 	.llseek	 = generic_file_llseek,
 };
 
diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
index 25071331f8c1..1281aaef2b44 100644
--- a/arch/powerpc/kvm/timing.c
+++ b/arch/powerpc/kvm/timing.c
@@ -158,10 +158,10 @@ static int kvmppc_exit_timing_show(struct seq_file *m, void *private)
 }
 
 /* Write 'c' to clear the timing statistics. */
-static ssize_t kvmppc_exit_timing_write(struct file *file,
-				       const char __user *user_buf,
-				       size_t count, loff_t *ppos)
+static ssize_t kvmppc_exit_timing_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	int err = -EINVAL;
 	char c;
 
@@ -169,13 +169,13 @@ static ssize_t kvmppc_exit_timing_write(struct file *file,
 		goto done;
 	}
 
-	if (get_user(c, user_buf)) {
+	if (get_iter(&c, from)) {
 		err = -EFAULT;
 		goto done;
 	}
 
 	if (c == 'c') {
-		struct seq_file *seqf = file->private_data;
+		struct seq_file *seqf = iocb->ki_filp->private_data;
 		struct kvm_vcpu *vcpu = seqf->private;
 		/* Write does not affect our buffers previously generated with
 		 * show. seq_file is locked here to prevent races of init with
@@ -198,8 +198,8 @@ static int kvmppc_exit_timing_open(struct inode *inode, struct file *file)
 static const struct file_operations kvmppc_exit_timing_fops = {
 	.owner   = THIS_MODULE,
 	.open    = kvmppc_exit_timing_open,
-	.read    = seq_read,
-	.write   = kvmppc_exit_timing_write,
+	.read_iter = seq_read_iter,
+	.write_iter = kvmppc_exit_timing_write,
 	.llseek  = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


