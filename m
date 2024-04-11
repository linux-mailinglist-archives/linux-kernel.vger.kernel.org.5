Return-Path: <linux-kernel+bounces-140940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DE78A1A08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51338B28C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D13200117;
	Thu, 11 Apr 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CHWC4cpG"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B44A1CB32D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849791; cv=none; b=X1pibssqzykZEyI9slv71/k9//rG+Txe49piPkhHVFHMc53FFluNgtkSIHDEwBhYxG5nNByg8bM74PBodIAHtBAAwxmABGQY8rZf7IyFyc4FkvQYiaVQswP8zJz2TbXnq0d2TnHFOWr5AwF5hftdKPqlBiXycD0TXf2DY1iJM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849791; c=relaxed/simple;
	bh=yAlklZvm5IMk94Jc/uHUPXnqrGtZbsp5ztM657QTPcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSL0s8V27XZuLajp7V9y9cNrdFgEjEp5lhbkaauN9hnC3YaIp+YjjBhEZtgSPk7hB7nRo/QFbYUa/76/D9OkYrbaadLSf+EdbReIJZ+orhXD6/O2EMiNJpL/EduO7tcom5g3ZE4IVb6b4GcpSYgrgYQ2WfVr6fJ9krFSzy+CZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CHWC4cpG; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a224d7414so183625ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849789; x=1713454589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/G2gJus1LipzD215iHOXz0vCf2GXt4cDzWEUVHBzac=;
        b=CHWC4cpGM6kCnas0d/OIPwbr/oeqxSqZDzmavxPaWoCDgrRp0ubT/kLx3zjhAxIIEN
         xo8hbp1ZjAvXdptVcfBZb0NbFsdRgMvK+OlPAAj8O8aGfHyq3bxQ1vm4A0VSysjRqOrQ
         U7O8IUYRQgfwqk2Mhh5QRzrzvkW9ulQel7kw1EBsHgLhv4u4PpRnPlYPVl20WfKWzFsk
         ELr1khblhG5gX85bIwQgnEXdcNivhTy7zFYVbEcozfVWFrLarCjLMcAQoqnU4GZKH+sq
         rHi9moSHViW4v3AxAlTeFOmc1mk+4Czq4NmiIQ+zjPo9ARF1pDHl6QgKKE+7bUN6QIHB
         dB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849789; x=1713454589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/G2gJus1LipzD215iHOXz0vCf2GXt4cDzWEUVHBzac=;
        b=OirEOqSni7j4ygz+jreLh1HP1QSIhzZbbPjn8bnmcIzk745m3RoYbPKuIpzBLleVJl
         XfI0Ae+jRn3Bx2Ou9fWrceBrSj1kDgdoUp8mcCicEwNAzEM9rf5Wcy5iIswe3m5UOqXv
         05l3ho/I4UPB1/6S4cXrO7m9arJ42Xtt2o9KU6wM9dD9LLIAld+Dg/16Ppre6KLiHSUP
         2Mv6xT4Bf/XLAp1w/ZFfowHG/50Ha6WDRk5xpedTgUgi8RYvucpL93MaDXH5q2EQojH9
         3iXj4nas1Y+mgUeF6/jyEH9SkUK5lP8bMRqA2wDfSk0QZMP+awl3/xHfdyesVaOK7NKX
         Ld3g==
X-Gm-Message-State: AOJu0YwUVTKNBcTjy7BG+Spjt8HpW6ijZyujP5CDsHooegdcKg4PIDWK
	UjWYORqsSRbCcs39AVurL8c/XYP9nlBWXa5SfrKIn/hCOy8eyktS00jVGja8Z5wiqsS9u1b4JO4
	L
X-Google-Smtp-Source: AGHT+IHe1W1ut2MKfhQ2cMLuEkp6FSV1gVB5sVkdoQo/b4IucPuAfmgD35JFXZCz8/NfHkRq1RNz5g==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr187701iob.1.1712849788913;
        Thu, 11 Apr 2024 08:36:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 171/437] usb: musb: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:11 -0600
Message-ID: <20240411153126.16201-172-axboe@kernel.dk>
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
 drivers/usb/musb/musb_debugfs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 2d623284edf6..7123057d12f7 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -160,17 +160,17 @@ static int musb_test_mode_open(struct inode *inode, struct file *file)
 	return single_open(file, musb_test_mode_show, inode->i_private);
 }
 
-static ssize_t musb_test_mode_write(struct file *file,
-		const char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t musb_test_mode_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file		*s = file->private_data;
+	struct seq_file		*s = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(from);
 	struct musb		*musb = s->private;
 	u8			test;
 	char			buf[24];
 
 	memset(buf, 0x00, sizeof(buf));
 
-	if (copy_from_user(buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	pm_runtime_get_sync(musb->controller);
@@ -223,8 +223,8 @@ static ssize_t musb_test_mode_write(struct file *file,
 
 static const struct file_operations musb_test_mode_fops = {
 	.open			= musb_test_mode_open,
-	.write			= musb_test_mode_write,
-	.read			= seq_read,
+	.write_iter		= musb_test_mode_write,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -260,17 +260,17 @@ static int musb_softconnect_open(struct inode *inode, struct file *file)
 	return single_open(file, musb_softconnect_show, inode->i_private);
 }
 
-static ssize_t musb_softconnect_write(struct file *file,
-		const char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t musb_softconnect_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file		*s = file->private_data;
+	struct seq_file		*s = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(from);
 	struct musb		*musb = s->private;
 	char			buf[2];
 	u8			reg;
 
 	memset(buf, 0x00, sizeof(buf));
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	pm_runtime_get_sync(musb->controller);
@@ -315,8 +315,8 @@ static ssize_t musb_softconnect_write(struct file *file,
  */
 static const struct file_operations musb_softconnect_fops = {
 	.open			= musb_softconnect_open,
-	.write			= musb_softconnect_write,
-	.read			= seq_read,
+	.write_iter		= musb_softconnect_write,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
-- 
2.43.0


