Return-Path: <linux-kernel+bounces-140809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156308A190D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9A62812B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF356A34F;
	Thu, 11 Apr 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="21wII/8A"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8702633FE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849587; cv=none; b=Qaj5sxjRz7HTgT/m2GR295sp7lC9kzPSUofSk4Tke2gJbmgLiUzCiY4FGsWmii3pGHFSyt5Pqq+wTR6VYZVFWcNLLZ+2yZwebCOZbZlcK0SCzoQKApDHdVfJNyBZ0hIIj5zq+QCu8iNpoD18cozr8SdnB/rr2hC3ZURGR75y8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849587; c=relaxed/simple;
	bh=r61+X9nse5GdL0xP9XGOtlPPjs63tdsfCiTgWIm731w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5Qedsv2X9erWYudKfImDwaYfyN4ReBteSH/PXwy4Fxfo5HWvECHsHRJJ0js4aK/xLavxJuMqvZlMveZBfDocdVMH9l2GB7q7Iu1lCjGLuvoLXMr4Yc44QmmJg7luyiPVb/ULAqsuD2Pz+nb71Chygtz/KsMjbBnmC4saUQYErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=21wII/8A; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso57965939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849585; x=1713454385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+csp6tEDNXsIebOPAwRBqaO3HCxKbRxFbSXk6qUvjbo=;
        b=21wII/8AuLr8iyExh2r1kL2wON+g1QY7kBac1gxON45nWakgr+EAB4dK0TTInmyaNY
         C3ODAOpq2NV8QjCDP6NQrQrz2QN1N7MiRT5HO39Gsw9xZMC9V6fdOe2AVTJktV3p80Uc
         JqKceH2DrD3T29yg2/KdPhatcfdUwyXfAh0exw/qLnreh5bv2FWqSHFRPCN2x1hpHBgA
         LK/HE1JDQSwOKQv3645l6unsHR4KM3EEPVwPtaxJNrTbIzHTGtieJwYPPwVdh9Totdse
         3UbDUWtZia5ny+cg6NVqOCvGfPCi4az587pcZgwdWaMfSq89WFWpO+MD1+7Tj8Mdr/be
         mdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849585; x=1713454385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+csp6tEDNXsIebOPAwRBqaO3HCxKbRxFbSXk6qUvjbo=;
        b=NlCV4g1US1qfL/+YS/gWl4s3Ss1qlDj6o8ehYoPK8EB4TOQGNrkVaNsw9QbtOz4fKY
         FoFK8blfE6Pxz9MrMd19BVTt2RBOzTEsS9OCeHsKXRfx7HGTgHDB7h4cho83Q64NgKcx
         HG+K/hZ3jGmm6izZHQs04E36nJqEA02ixsvhFhURCghXeUREF5mEBHszScRWjE5Q4tYF
         sRe2CZGmEOPwD6bekKgsuc7m57S0KzEwYcR+YgEtzzXcp2hqPjAtLOclMuo4ODcn1gdo
         no7KqepmGeUzSkhEnE8L472bpc1/HIDsN1P+U29za/Uc67/jJcl3NO8n7tzkE7C5FDl3
         cf2A==
X-Gm-Message-State: AOJu0YzDrem3NEnvmvaNNhUvVGiUTf/ehmFgmWgiic//rePW01VRO9jp
	PmJqIr8/xDeF+KdGuEx8S1/j0E8RgYg13BhHR+sWWVoJElgsbFR0zTOOXiL9HvnKQvGolbYD2iZ
	O
X-Google-Smtp-Source: AGHT+IHG18/kk79JizQ//D+b9px4T+FMYpKl4FiYs/5UZkHrTVH3YIMS5jdDfV5tx9WvSRrPpHLeAg==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr172846iov.2.1712849584825;
        Thu, 11 Apr 2024 08:33:04 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 049/437] fuse: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:09 -0600
Message-ID: <20240411153126.16201-50-axboe@kernel.dk>
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
 fs/fuse/control.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 97ac994ff78f..0ca1d1f418c3 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -31,37 +31,36 @@ static struct fuse_conn *fuse_ctl_file_conn_get(struct file *file)
 	return fc;
 }
 
-static ssize_t fuse_conn_abort_write(struct file *file, const char __user *buf,
-				     size_t count, loff_t *ppos)
+static ssize_t fuse_conn_abort_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
+	struct fuse_conn *fc = fuse_ctl_file_conn_get(iocb->ki_filp);
 	if (fc) {
 		if (fc->abort_err)
 			fc->aborted = true;
 		fuse_abort_conn(fc);
 		fuse_conn_put(fc);
 	}
-	return count;
+	return iov_iter_count(from);
 }
 
-static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
-				      size_t len, loff_t *ppos)
+static ssize_t fuse_conn_waiting_read_iter(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
 	char tmp[32];
 	size_t size;
 
-	if (!*ppos) {
+	if (!iocb->ki_pos) {
 		long value;
-		struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
+		struct fuse_conn *fc = fuse_ctl_file_conn_get(iocb->ki_filp);
 		if (!fc)
 			return 0;
 
 		value = atomic_read(&fc->num_waiting);
-		file->private_data = (void *)value;
+		iocb->ki_filp->private_data = (void *)value;
 		fuse_conn_put(fc);
 	}
-	size = sprintf(tmp, "%ld\n", (long)file->private_data);
-	return simple_read_from_buffer(buf, len, ppos, tmp, size);
+	size = sprintf(tmp, "%ld\n", (long)iocb->ki_filp->private_data);
+	return simple_copy_to_iter(tmp, &iocb->ki_pos, size, to);
 }
 
 static ssize_t fuse_conn_limit_read(struct file *file, char __user *buf,
@@ -115,6 +114,7 @@ static ssize_t fuse_conn_max_background_read(struct file *file,
 
 	return fuse_conn_limit_read(file, buf, len, ppos, val);
 }
+FOPS_READ_ITER_HELPER(fuse_conn_max_background_read);
 
 static ssize_t fuse_conn_max_background_write(struct file *file,
 					      const char __user *buf,
@@ -140,6 +140,7 @@ static ssize_t fuse_conn_max_background_write(struct file *file,
 
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(fuse_conn_max_background_write);
 
 static ssize_t fuse_conn_congestion_threshold_read(struct file *file,
 						   char __user *buf, size_t len,
@@ -179,30 +180,31 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 out:
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(fuse_conn_congestion_threshold_write);
 
 static const struct file_operations fuse_ctl_abort_ops = {
 	.open = nonseekable_open,
-	.write = fuse_conn_abort_write,
+	.write_iter = fuse_conn_abort_write,
 	.llseek = no_llseek,
 };
 
 static const struct file_operations fuse_ctl_waiting_ops = {
 	.open = nonseekable_open,
-	.read = fuse_conn_waiting_read,
+	.read_iter = fuse_conn_waiting_read_iter,
 	.llseek = no_llseek,
 };
 
 static const struct file_operations fuse_conn_max_background_ops = {
 	.open = nonseekable_open,
-	.read = fuse_conn_max_background_read,
-	.write = fuse_conn_max_background_write,
+	.read_iter = fuse_conn_max_background_read_iter,
+	.write_iter = fuse_conn_max_background_write_iter,
 	.llseek = no_llseek,
 };
 
 static const struct file_operations fuse_conn_congestion_threshold_ops = {
 	.open = nonseekable_open,
 	.read = fuse_conn_congestion_threshold_read,
-	.write = fuse_conn_congestion_threshold_write,
+	.write_iter = fuse_conn_congestion_threshold_write_iter,
 	.llseek = no_llseek,
 };
 
-- 
2.43.0


