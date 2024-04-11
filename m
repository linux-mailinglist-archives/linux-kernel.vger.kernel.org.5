Return-Path: <linux-kernel+bounces-140830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B88A1924
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85A8281624
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7602712A157;
	Thu, 11 Apr 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LsW/5tR1"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E886622
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849621; cv=none; b=Fd7AX+Rm43Kysp4MXo+wm0eCMcKfN9dxJ26RNqMvWpvSH/bF1b4/LwXvv0Z9n1ndehKFCetXTymisK8asu10pfpmmkk4l1KXnLMnEAkjjF9n7nf/uN27Zit5ne7hRCEW05XbP75K9ySYpSZE9YwneO+F+C6XSolRfyRAwnSzT30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849621; c=relaxed/simple;
	bh=M1yBKWFPsh8UjcS1TxiPSNkIkPKwtGPrveg4hdeWyT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdirZ1m5tsV0rGsiS1FiCLB6YlD9aipRl4Cd7+MHruKM/wy26gH8WqkXsWVVVvjwsHv3AU2nsGH8h3OpDzn8p6KPBXD5d+w/e5jhb/azGYVgWNgyXq6AJjbpzEJAfp/3DCUZGKWCqrwCZOmlkFxdOTj4Uuy4C/1/NH7mkzY8Yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LsW/5tR1; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8888939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849619; x=1713454419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yX8scuHFoGsccMxsL+ssPJRgE4pOVMRH5JWrmkuuark=;
        b=LsW/5tR1y3LC1mWAazjYA447c88IVi60RGG5+p1ioBjkpzw1kdByb8GUXZZjK2MxLd
         vRgV4+1m+WfCQ5I7sZThm8ITvrQK7iPAKoB3LDBETiVlLQEktvnwHvUvKKp4/hGld6UF
         Wmm9I7Aj761ikTUy25BVLeIhZ4ftWaqjShAQ4K3dVbBegO4vct+tmm47FwjTPL1yk7Fs
         ZdNbbEUYpBaGpQXfHxmJLinFc3eUZmBeC7PqY8np9vIbHz7WzbSVi9qFBzUhSDy84dXf
         bxZGvg8cHE0rAfrow4cBubsvcvdbrvo4XBd/dwJ7BfWdruqDcjkxv0PonANap9EiyGlo
         DoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849619; x=1713454419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yX8scuHFoGsccMxsL+ssPJRgE4pOVMRH5JWrmkuuark=;
        b=fLwlKWnvMR0Qa204S9fQ7u6VYr9CS75T47oABIJneiVn6Aj/qYSyKboKAwCKWABCiu
         pbnP2FUzR/+k5cHATu3E2PhjynC/3+K0trS81LgHBG+obZ4EGNOsLkvxX5MKEVs4a80M
         UP8PQhmYTBgj2F80r30PH4n91U3uHgMK5SeLFwEmjiL+YDKs41XfrMtVcZpRCN62Abyp
         CMCuWpF/KPgdUfDWsQA+DYVX+K1ULj/YlttRZIB+DtUSgEFnLtUi94fdwhu+wrqfPRxM
         dIp9s1EklIciHELmgZwn7AuEv0gC7q/jhF9qcMqIV0iPix62+ygu4NBy1q62yo4A7BBj
         VqaA==
X-Gm-Message-State: AOJu0YwgpLlpFNb4AQ6JhKjNFX8d3/SqgFdEOLViPhOpGjr0QU08G3yH
	IIRPDa5KaKhyEwzpX2dDcOF2iSsDapyzOOoywfff0aHUUY9fYlvpQx7o0eunAgL9YiDZ6u1bUUQ
	r
X-Google-Smtp-Source: AGHT+IFEbNc3hw/FJZNUKKlnMZ/E01TSqXu3r9QbYCsjxW4BvsFilorImtYb4IjvLHgldjhCLi1y4Q==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr215554ioh.0.1712849619094;
        Thu, 11 Apr 2024 08:33:39 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 069/437] bpf: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:29 -0600
Message-ID: <20240411153126.16201-70-axboe@kernel.dk>
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
 kernel/bpf/bpf_iter.c | 14 +++++++-------
 kernel/bpf/inode.c    |  2 +-
 kernel/bpf/syscall.c  | 18 ++++++++----------
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 112581cf97e7..f2bbe98234df 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -91,10 +91,10 @@ static bool bpf_iter_support_resched(struct seq_file *seq)
  *  . assuming NULL ->llseek()
  *  . stop() may call bpf program, handling potential overflow there
  */
-static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
-			    loff_t *ppos)
+static ssize_t bpf_seq_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct seq_file *seq = file->private_data;
+	struct seq_file *seq = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(to);
 	size_t n, offs, copied = 0;
 	int err = 0, num_objs = 0;
 	bool can_resched;
@@ -113,7 +113,7 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 
 	if (seq->count) {
 		n = min(seq->count, size);
-		err = copy_to_user(buf, seq->buf + seq->from, n);
+		err = !copy_to_iter_full(seq->buf + seq->from, n, to);
 		if (err) {
 			err = -EFAULT;
 			goto done;
@@ -222,7 +222,7 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 	}
 
 	n = min(seq->count, size);
-	err = copy_to_user(buf, seq->buf, n);
+	err = !copy_to_iter_full(seq->buf, n, to);
 	if (err) {
 		err = -EFAULT;
 		goto done;
@@ -234,7 +234,7 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 	if (!copied)
 		copied = err;
 	else
-		*ppos += copied;
+		iocb->ki_pos += copied;
 	mutex_unlock(&seq->lock);
 	return copied;
 }
@@ -284,7 +284,7 @@ static int iter_release(struct inode *inode, struct file *file)
 const struct file_operations bpf_iter_fops = {
 	.open		= iter_open,
 	.llseek		= no_llseek,
-	.read		= bpf_seq_read,
+	.read_iter	= bpf_seq_read_iter,
 	.release	= iter_release,
 };
 
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index af5d2ffadd70..5e35f1eb1dec 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -313,7 +313,7 @@ static int bpffs_map_release(struct inode *inode, struct file *file)
  */
 static const struct file_operations bpffs_map_fops = {
 	.open		= bpffs_map_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.release	= bpffs_map_release,
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c287925471f6..385995dc69a0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -872,8 +872,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 }
 #endif
 
-static ssize_t bpf_dummy_read(struct file *filp, char __user *buf, size_t siz,
-			      loff_t *ppos)
+static ssize_t bpf_dummy_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	/* We need this handler such that alloc_file() enables
 	 * f_mode with FMODE_CAN_READ.
@@ -881,8 +880,7 @@ static ssize_t bpf_dummy_read(struct file *filp, char __user *buf, size_t siz,
 	return -EINVAL;
 }
 
-static ssize_t bpf_dummy_write(struct file *filp, const char __user *buf,
-			       size_t siz, loff_t *ppos)
+static ssize_t bpf_dummy_write(struct kiocb *iocb, struct iov_iter *to)
 {
 	/* We need this handler such that alloc_file() enables
 	 * f_mode with FMODE_CAN_WRITE.
@@ -991,8 +989,8 @@ const struct file_operations bpf_map_fops = {
 	.show_fdinfo	= bpf_map_show_fdinfo,
 #endif
 	.release	= bpf_map_release,
-	.read		= bpf_dummy_read,
-	.write		= bpf_dummy_write,
+	.read_iter	= bpf_dummy_read,
+	.write_iter	= bpf_dummy_write,
 	.mmap		= bpf_map_mmap,
 	.poll		= bpf_map_poll,
 	.get_unmapped_area = bpf_get_unmapped_area,
@@ -2378,8 +2376,8 @@ const struct file_operations bpf_prog_fops = {
 	.show_fdinfo	= bpf_prog_show_fdinfo,
 #endif
 	.release	= bpf_prog_release,
-	.read		= bpf_dummy_read,
-	.write		= bpf_dummy_write,
+	.read_iter	= bpf_dummy_read,
+	.write_iter	= bpf_dummy_write,
 };
 
 int bpf_prog_new_fd(struct bpf_prog *prog)
@@ -3142,8 +3140,8 @@ static const struct file_operations bpf_link_fops = {
 	.show_fdinfo	= bpf_link_show_fdinfo,
 #endif
 	.release	= bpf_link_release,
-	.read		= bpf_dummy_read,
-	.write		= bpf_dummy_write,
+	.read_iter	= bpf_dummy_read,
+	.write_iter	= bpf_dummy_write,
 };
 
 static int bpf_link_alloc_id(struct bpf_link *link)
-- 
2.43.0


