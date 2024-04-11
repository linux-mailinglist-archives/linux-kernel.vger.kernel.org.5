Return-Path: <linux-kernel+bounces-140893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9528A196F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603E61F220A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FDB15B557;
	Thu, 11 Apr 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p7BRI9ay"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97315B13A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849721; cv=none; b=YbhuqJnZtLG0m3OmrmkNdqr4+B/odOiECJQ2OWEgg4Mb5LRdzSUoyaLQJNglVMnoJVbKySn/3sTDG8uqPSjBbilVKQxSp3JBis64Z1FHgo9LpgsZZvECB6kY8ncZfd3PqAmp4DOTehsVQLhTo39elH4e+bG9CIBaERd1/qZxTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849721; c=relaxed/simple;
	bh=CRdImgDwiatT8fZ4jwuwRrfo5E0CbUcIbc82giDTs5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tguaHJxE900GKaDsl+4YbqohIx9eJowOlYOPOS/SGTGSdregYzerzoPQ6cDCXK1LfLy1VAzxtySPklUVihJnN8T5kcg2PnBTk+25IhOF80z2R0FjP1onGyrDb+dGRYQBqOw/U2L+416OYATT4f0zfU+nQW6wl4IznMT2XQg+BCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p7BRI9ay; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58044439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849718; x=1713454518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z+6uScePAWvCM/TZ8oRqt5BfLN6MMBF6zA/HItezVw=;
        b=p7BRI9ayqHSWJzkixYqw0p4r9F3EcFaUroFvWjjbu04M+5Fn+d5Z8B62HPUTF6lLGJ
         EjyDUexftbUthZ36TJZIlq0qIGon2FTssQZznCtLBexRB7kDGvqVDzdtAe2Eor27ghEO
         PDf+ZPdw6+k6OWEvT7FbFtlsRnqyYoRxyEjwzNqy122hG3Ta62lNWowSh0pVhkD3RC7G
         TwgF+0d3w0dalW/4hIUr5k2fFGhCuEMIVwnepil/nbC1Cm4mLKEW+S8RoSR1cb4yxz62
         3XDnBJcsxnK8KXNMMmHT6k7VRZAmuyhU6Z8s+P/vcxQm/FoGjZSHe76Qh/kgeh2oIGKJ
         s7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849718; x=1713454518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z+6uScePAWvCM/TZ8oRqt5BfLN6MMBF6zA/HItezVw=;
        b=mRnAZCuhgoGajBdurlHmt4ysvUXNadpKRG2c57VPvNmjHIv4EE7WqYa9KdqJ0keszI
         QrOy1iMLrqw7FLO9yvM0cgTScwsfTeyPnDQxMHQZfEH7GxpO1GOnBVwHly7Q+NWV5Bqv
         8joAUzOddDmmVZkMpHM2Q3kCkFbkFosCZItRVZk0VhSXo7Czld4R3aoO+3xyNUjdBy0X
         azMZLsZ/B4XYNN042KjchAaz+ihRuX6ea2oEcprFC+TH3CiY+cf7ZEfXbHegMjiW7pX7
         MgTDNbP/IJd1hzVaFwqmKgw8b6Jp1HuHIt2mGgyCIAaPUk3PdUw5FR2ua22KdcPUCCEb
         eDPw==
X-Gm-Message-State: AOJu0YzjKbOG+4xPGCZzo6tutw8jO2rAvMonsNaZcf4yxsPcatIVbzNU
	zRIqHH7uyIQfwB7jsRsB+3FKSSpcSaSj7hDw+eHCiE1A+gl7L/iR93guusAdpSTCP6UuaHCgyOZ
	X
X-Google-Smtp-Source: AGHT+IHKnbEKqd4wYVpAQvCJArWHLSasc36WX1v6vCXROMV8aVZo+cmCWg/i0QMvvkvHsmQWZHcRxw==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr181111iov.2.1712849718326;
        Thu, 11 Apr 2024 08:35:18 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 129/437] firmware: tegra: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:29 -0600
Message-ID: <20240411153126.16201-130-axboe@kernel.dk>
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
 drivers/firmware/tegra/bpmp-debugfs.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index 4221fed70ad4..6ef756a2d638 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -363,21 +363,21 @@ static int bpmp_debug_show(struct seq_file *m, void *p)
 	return err;
 }
 
-static ssize_t bpmp_debug_store(struct file *file, const char __user *buf,
-		size_t count, loff_t *f_pos)
+static ssize_t bpmp_debug_store(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
 	struct tegra_bpmp *bpmp = inode->i_private;
+	size_t count = iov_iter_count(from);
 	char *databuf = NULL;
 	char fnamebuf[256];
 	const char *filename;
 	ssize_t err;
 
-	filename = get_filename(bpmp, file, fnamebuf, sizeof(fnamebuf));
+	filename = get_filename(bpmp, iocb->ki_filp, fnamebuf, sizeof(fnamebuf));
 	if (!filename)
 		return -ENOENT;
 
-	databuf = memdup_user(buf, count);
+	databuf = iterdup(from);
 	if (IS_ERR(databuf))
 		return PTR_ERR(databuf);
 
@@ -394,9 +394,9 @@ static int bpmp_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations bpmp_debug_fops = {
 	.open		= bpmp_debug_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
-	.write		= bpmp_debug_store,
+	.write_iter	= bpmp_debug_store,
 	.release	= single_release,
 };
 
@@ -630,11 +630,11 @@ static int debugfs_open(struct inode *inode, struct file *file)
 	return single_open_size(file, debugfs_show, file, SZ_128K);
 }
 
-static ssize_t debugfs_store(struct file *file, const char __user *buf,
-		size_t count, loff_t *f_pos)
+static ssize_t debugfs_store(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(iocb->ki_filp);
 	struct tegra_bpmp *bpmp = inode->i_private;
+	size_t count = iov_iter_count(from);
 	const size_t datasize = count;
 	const size_t namesize = SZ_256;
 	void *datavirt, *namevirt;
@@ -644,7 +644,7 @@ static ssize_t debugfs_store(struct file *file, const char __user *buf,
 	size_t len;
 	int err;
 
-	filename = get_filename(bpmp, file, fnamebuf, sizeof(fnamebuf));
+	filename = get_filename(bpmp, iocb->ki_filp, fnamebuf, sizeof(fnamebuf));
 	if (!filename)
 		return -ENOENT;
 
@@ -681,9 +681,9 @@ static ssize_t debugfs_store(struct file *file, const char __user *buf,
 
 static const struct file_operations debugfs_fops = {
 	.open		= debugfs_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
-	.write		= debugfs_store,
+	.write_iter	= debugfs_store,
 	.release	= single_release,
 };
 
-- 
2.43.0


