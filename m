Return-Path: <linux-kernel+bounces-141120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857268A1A94
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B547C1C23544
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8EE1E8318;
	Thu, 11 Apr 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hFODbEsk"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620C1E82F9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850068; cv=none; b=b49TwGVuZQzIEo6G30dcZdZ5Sz+u9Rsk1q4jQloic9ZicTeUVNARl6vFkgsgHIy6jXpz/4b5FAcNFeaC9aAY2IORVBh/zw5aYhlZEbvG+P8OZ4sTs8Xggu/KSlhWr/NoYSwSoCl4uZbmlTsEfw9nLPa/keolu0bukUy2rpHElwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850068; c=relaxed/simple;
	bh=5EjmrqHPTVb1tcQjhIbfw/W8hV02faCwyAgLm9OOUsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHIZ3+II2ShcpLB1fxXw6lYpmmr6LcqHC+8k3zOXIW9IQHXI+E+e5mpWHGLxPBpRQZZ4nFWxwljIQTNOFGTfWybDa4TbrvEcgfwprKAN/ZNCbM1S+ddUrYfxkLIcuaECAbWrNclH+q+hN+7sK7hYInuFGcECwsqkpYlBir9UCk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hFODbEsk; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58225139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850066; x=1713454866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIM4TH/UmAjjcuOb7+hL3DbRPexG4VlEyKPnN1TCQJg=;
        b=hFODbEskJMWMscS7HUIqruDunvpiRku88rO9K+eHSSyiZCKhcUlbup5lPLOhkxZjLi
         9/4nqnTEeN3HgrKbi/2gJK97na8WHYamXj75+d8iYWbqxPLBz7GXYtv4d77iJnOPiIi3
         0Nmz1tcZhBgSzAsY1tr/Ubk2ZbZyINgHHQHul1pJKJsz69HpKUpVe8kSSo8luruUMVhp
         QNAIvg0dkBQOS4VGUEjhVnuUBl6ixJrW5eBEMFWz7pPbeWtvOyU6e21/MJkq39AaIEGv
         iNKsru3nnNzFS6+etk7GY/ABBg83NbouzFMuftatY0QDx2xDbqgRPg5aosVyb5kE6oPC
         bQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850066; x=1713454866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIM4TH/UmAjjcuOb7+hL3DbRPexG4VlEyKPnN1TCQJg=;
        b=tB1vHn5CwUpzd/YpqIpFUCPzPr30Jo9upxeD5Y83Y9TcGy0GqR0Zb+cax0RL417Bh9
         2QRK7HE405Ux2ibS6mqbHpOxtjWndD5fcqu0cR2/1o5cAyVGMcI6tP0SMyxdNXBg0b0I
         dY5MndtLeeMuBzFFPnujGB6VIe481BATLBPWuNASOs3Yk9IoSZmzHUtB4yvppo/G/oev
         78PJvC4XgIyq1M0GcsG+sxEWsjRCcyi8CU57qOxVoePUmN+KbKUtlMoHgjJ64f33ccQD
         75BDU/pDq8bkLYJT2MSO3Yd8gqfpqTRproFjvhKbH+ISoZACiMa5PnWtRBVKUZVyAOCq
         WRBg==
X-Gm-Message-State: AOJu0YySXQIp6P9W/Oql+vFUA+acRWyYiZSuP7tDecdvRGQ2P1qs3CGC
	Oz/65KoeIxVa4BeozVrJpoumZ55+ZY6j06pjiCVAL4hYt1sH0HCS1hAyaNi77Hoo4/XigATIc6L
	Z
X-Google-Smtp-Source: AGHT+IH7T0/YfkpRuptrZ6wrzHT/ZTE7vx2w0+u/BGcOoZ/Ain79aEPzsWjE40iCTz5rOJMPV8OzWA==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr200387iov.2.1712850065956;
        Thu, 11 Apr 2024 08:41:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 341/437] s390: cio: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:01 -0600
Message-ID: <20240411153126.16201-342-axboe@kernel.dk>
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
 drivers/s390/cio/cio_inject.c | 11 ++++++-----
 drivers/s390/cio/qdio_debug.c | 12 ++++++------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/cio/cio_inject.c b/drivers/s390/cio/cio_inject.c
index 8613fa937237..33ccd36098b3 100644
--- a/drivers/s390/cio/cio_inject.c
+++ b/drivers/s390/cio/cio_inject.c
@@ -123,15 +123,16 @@ static ssize_t crw_inject_write(struct file *file, const char __user *buf,
 
 	return lbuf;
 }
+FOPS_WRITE_ITER_HELPER(crw_inject_write);
 
 /* Debugfs write handler for inject_enable node*/
-static ssize_t enable_inject_write(struct file *file, const char __user *buf,
-				   size_t lbuf, loff_t *ppos)
+static ssize_t enable_inject_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t lbuf = iov_iter_count(from);
 	unsigned long en = 0;
 	int rc;
 
-	rc = kstrtoul_from_user(buf, lbuf, 10, &en);
+	rc = kstrtoul_from_iter(from, lbuf, 10, &en);
 	if (rc)
 		return rc;
 
@@ -149,12 +150,12 @@ static ssize_t enable_inject_write(struct file *file, const char __user *buf,
 
 static const struct file_operations crw_fops = {
 	.owner = THIS_MODULE,
-	.write = crw_inject_write,
+	.write_iter = crw_inject_write_iter,
 };
 
 static const struct file_operations cio_en_fops = {
 	.owner = THIS_MODULE,
-	.write = enable_inject_write,
+	.write_iter = enable_inject_write,
 };
 
 static int __init cio_inject_init(void)
diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
index 1a9714af51e4..0c9f84c5197f 100644
--- a/drivers/s390/cio/qdio_debug.c
+++ b/drivers/s390/cio/qdio_debug.c
@@ -234,11 +234,11 @@ static int qperf_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t qperf_seq_write(struct file *file, const char __user *ubuf,
-			       size_t count, loff_t *off)
+static ssize_t qperf_seq_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *seq = file->private_data;
+	struct seq_file *seq = iocb->ki_filp->private_data;
 	struct qdio_irq *irq_ptr = seq->private;
+	size_t count = iov_iter_count(from);
 	struct qdio_q *q;
 	unsigned long val;
 	int ret, i;
@@ -246,7 +246,7 @@ static ssize_t qperf_seq_write(struct file *file, const char __user *ubuf,
 	if (!irq_ptr)
 		return 0;
 
-	ret = kstrtoul_from_user(ubuf, count, 10, &val);
+	ret = kstrtoul_from_iter(from, count, 10, &val);
 	if (ret)
 		return ret;
 
@@ -275,8 +275,8 @@ static int qperf_seq_open(struct inode *inode, struct file *filp)
 static const struct file_operations debugfs_perf_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = qperf_seq_open,
-	.read	 = seq_read,
-	.write	 = qperf_seq_write,
+	.read_iter = seq_read_iter,
+	.write_iter = qperf_seq_write,
 	.llseek  = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


