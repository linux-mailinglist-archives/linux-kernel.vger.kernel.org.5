Return-Path: <linux-kernel+bounces-140897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6389A8A1975
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D3C287CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0415D5A6;
	Thu, 11 Apr 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HRovyp0G"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23BE15CD66
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849728; cv=none; b=rzdXKZeq3vlbSEXmO8d2O9me/gpGkfVjBD9z/yTBF0BxUZPJh9eU8EcM6l63B3Bcub1vrLF0c7OSlZ/Ti52/ZqLYxLMtN+71IPnHnuqwDO56UUJSZ0bZjBb4LtLECgfWGiVsalZTOgdSzHDcCTkOla7hmAd/c5d+qLq5Wqyigm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849728; c=relaxed/simple;
	bh=A9OG430vw9/eqwPMXzB8R2JeVUlUleM+s0VO074Ik+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZYE+FFykknVmEO6dm+ALbIwxNg8HanV7jOe3NHEkM7pOC5jVJwAJiIdpz1/mM6e7xIBl51wWt4hPJ0gnLQ5veh+Ttd9aDFhvxeBL7HL8ImWLhanofEHvMKn+Vxp3VnZm0PgHWvp8ZQ14p3+OJkDIQf5tyQFc60r60P6JcjHAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HRovyp0G; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58048439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849725; x=1713454525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8yvvJiRfPdHRui8xzZtrVXgSKCPmJuTzPmtT1G+Irg=;
        b=HRovyp0G5EYqGKZaA2gPztbn67xJd2rhTAnEwIrmejp2evnQbVjrfdDY5ihPOcp74+
         Nb3Ar9dSX73vZEa99w/WqZI1Yog56XXvPjXXL0XdZoLH98uIbvWC+4ob1gKMA91ARNTh
         rRodM0NW7wtpQ6QbgIBkMRPtz/tkX6h3mWl6ziecguTMnFzj7xJarmIFQj9a8A6Cc+8T
         2eGoiMdG4H/zTi08Mo5nLej5YH0rexIOxNfe0+bllMjsJgXxw5smZ5BL4S+tgrX8dInk
         MkR7c+xfj54UKzm6lwD9XPbWMsddFa2BlLjohAbB94WflVNokES43D8VzcPSRjBmC4hS
         sAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849725; x=1713454525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8yvvJiRfPdHRui8xzZtrVXgSKCPmJuTzPmtT1G+Irg=;
        b=LdD/50I/iZqrq1ARS+fOPINJZMRs2f40uzwLRYy3cJtKpM5+3LbGze6+WFBbfcBVKg
         NNQwuwMSeiQCZaKbP2lqESbOOfzDqRvr2dRrDw/Q1c8IQvBuEQkpE3wai/jMu9CF7NjM
         73COqHjz42jwikgj0WK48xgSkejlYMOWWkYpBY671VMycyFmVaqKpz+5nbmU6IussEEJ
         stQ1s6p3xezkDg88xGlPdo2lg34R9X+xdH9w+S85y7LzGP+HtjP3j8Bd1tyBUKH8FvtK
         Pk6EMOxXWyRh2dtgAR60aZSx24wNw/FHXtXNqMybRwNVgL2SDLs/qTtWLHkd04QRyK3z
         XhRA==
X-Gm-Message-State: AOJu0Yy/1QvrLKDoHdmI4YyU4UN1/ZD/xDRX0A6xlce753G9V1TnwXLe
	zLjdQP0ctMUVQy7JVkl1LD3l/fxjAf2Y03JDtvJ4Qd4RaUnJVzpIZGUMJchAcaRkWk8YBJyIuuq
	l
X-Google-Smtp-Source: AGHT+IEgdJEWt4EmIobDCDVsGCNxgEnkChIfFPII1BTwAfTB1b66EZzUpP59MT12aAuwMiuvrjbVUQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr181497iov.2.1712849724972;
        Thu, 11 Apr 2024 08:35:24 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 133/437] drivers/bus: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:33 -0600
Message-ID: <20240411153126.16201-134-axboe@kernel.dk>
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
 drivers/bus/mhi/host/debugfs.c | 38 +++++++++++++++++-----------------
 drivers/bus/moxtet.c           | 30 +++++++++++++--------------
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/bus/mhi/host/debugfs.c b/drivers/bus/mhi/host/debugfs.c
index cfec7811dfbb..14d7a1132fca 100644
--- a/drivers/bus/mhi/host/debugfs.c
+++ b/drivers/bus/mhi/host/debugfs.c
@@ -245,17 +245,17 @@ static int mhi_debugfs_device_wake_show(struct seq_file *m, void *d)
 	return 0;
 }
 
-static ssize_t mhi_debugfs_device_wake_write(struct file *file,
-					     const char __user *ubuf,
-					     size_t count, loff_t *ppos)
+static ssize_t mhi_debugfs_device_wake_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct seq_file	*m = file->private_data;
+	struct seq_file	*m = iocb->ki_filp->private_data;
 	struct mhi_controller *mhi_cntrl = m->private;
 	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
+	size_t count = iov_iter_count(from);
 	char buf[16];
 	int ret = -EINVAL;
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	if (!strncmp(buf, "get", 3)) {
@@ -277,15 +277,15 @@ static int mhi_debugfs_timeout_ms_show(struct seq_file *m, void *d)
 	return 0;
 }
 
-static ssize_t mhi_debugfs_timeout_ms_write(struct file *file,
-					    const char __user *ubuf,
-					    size_t count, loff_t *ppos)
+static ssize_t mhi_debugfs_timeout_ms_write(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct seq_file	*m = file->private_data;
+	struct seq_file	*m = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct mhi_controller *mhi_cntrl = m->private;
 	u32 timeout_ms;
 
-	if (kstrtou32_from_user(ubuf, count, 0, &timeout_ms))
+	if (kstrtou32_from_iter(from, count, 0, &timeout_ms))
 		return -EINVAL;
 
 	mhi_cntrl->timeout_ms = timeout_ms;
@@ -331,45 +331,45 @@ static int mhi_debugfs_timeout_ms_open(struct inode *inode, struct file *fp)
 static const struct file_operations debugfs_states_fops = {
 	.open = mhi_debugfs_states_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 };
 
 static const struct file_operations debugfs_events_fops = {
 	.open = mhi_debugfs_events_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 };
 
 static const struct file_operations debugfs_channels_fops = {
 	.open = mhi_debugfs_channels_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 };
 
 static const struct file_operations debugfs_devices_fops = {
 	.open = mhi_debugfs_devices_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 };
 
 static const struct file_operations debugfs_regdump_fops = {
 	.open = mhi_debugfs_regdump_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 };
 
 static const struct file_operations debugfs_device_wake_fops = {
 	.open = mhi_debugfs_device_wake_open,
-	.write = mhi_debugfs_device_wake_write,
+	.write_iter = mhi_debugfs_device_wake_write,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 };
 
 static const struct file_operations debugfs_timeout_ms_fops = {
 	.open = mhi_debugfs_timeout_ms_open,
-	.write = mhi_debugfs_timeout_ms_write,
+	.write_iter = mhi_debugfs_timeout_ms_write,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 };
 
 static struct dentry *mhi_debugfs_root;
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 641c1a6adc8a..a6635cfc8490 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -15,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/spi/spi.h>
+#include <linux/uio.h>
 
 /*
  * @name:	module name for sysfs
@@ -460,10 +461,9 @@ static int moxtet_debug_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
-static ssize_t input_read(struct file *file, char __user *buf, size_t len,
-			  loff_t *ppos)
+static ssize_t input_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct moxtet *moxtet = file->private_data;
+	struct moxtet *moxtet = iocb->ki_filp->private_data;
 	u8 bin[TURRIS_MOX_MAX_MODULES];
 	u8 hex[sizeof(bin) * 2 + 1];
 	int ret, n;
@@ -477,20 +477,19 @@ static ssize_t input_read(struct file *file, char __user *buf, size_t len,
 
 	hex[2*n] = '\n';
 
-	return simple_read_from_buffer(buf, len, ppos, hex, 2*n + 1);
+	return simple_copy_to_iter(hex, &iocb->ki_pos, 2*n + 1, to);
 }
 
 static const struct file_operations input_fops = {
 	.owner	= THIS_MODULE,
 	.open	= moxtet_debug_open,
-	.read	= input_read,
+	.read_iter	= input_read,
 	.llseek	= no_llseek,
 };
 
-static ssize_t output_read(struct file *file, char __user *buf, size_t len,
-			   loff_t *ppos)
+static ssize_t output_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct moxtet *moxtet = file->private_data;
+	struct moxtet *moxtet = iocb->ki_filp->private_data;
 	u8 hex[TURRIS_MOX_MAX_MODULES * 2 + 1];
 	u8 *p = hex;
 	int i;
@@ -504,23 +503,22 @@ static ssize_t output_read(struct file *file, char __user *buf, size_t len,
 
 	*p++ = '\n';
 
-	return simple_read_from_buffer(buf, len, ppos, hex, p - hex);
+	return simple_copy_to_iter(hex, &iocb->ki_pos, p - hex, to);
 }
 
-static ssize_t output_write(struct file *file, const char __user *buf,
-			    size_t len, loff_t *ppos)
+static ssize_t output_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct moxtet *moxtet = file->private_data;
+	struct moxtet *moxtet = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	u8 bin[TURRIS_MOX_MAX_MODULES];
 	u8 hex[sizeof(bin) * 2 + 1];
 	ssize_t res;
-	loff_t dummy = 0;
 	int err, i;
 
 	if (len > 2 * moxtet->count + 1 || len < 2 * moxtet->count)
 		return -EINVAL;
 
-	res = simple_write_to_buffer(hex, sizeof(hex), &dummy, buf, len);
+	res = simple_copy_from_iter(hex, &iocb->ki_pos, sizeof(hex), from);
 	if (res < 0)
 		return res;
 
@@ -547,8 +545,8 @@ static ssize_t output_write(struct file *file, const char __user *buf,
 static const struct file_operations output_fops = {
 	.owner	= THIS_MODULE,
 	.open	= moxtet_debug_open,
-	.read	= output_read,
-	.write	= output_write,
+	.read_iter	= output_read,
+	.write_iter	= output_write,
 	.llseek	= no_llseek,
 };
 
-- 
2.43.0


