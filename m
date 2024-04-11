Return-Path: <linux-kernel+bounces-140865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 469A88A19E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B64B2CD97
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2313CF94;
	Thu, 11 Apr 2024 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BqE6NsYW"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472B13AA4D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849677; cv=none; b=Z/iEBNKjmGW+rYsi6YRosztQHujMBRIGpcqvxJ0FhSZyWk2FlvFAB6Mwfdr5IH00I4lnjACuRbYDrwgtRcMpGaAVkWU/3mSNUaLy2/G9h82tzwIvDyDkSS6uv/dazhyeitW6eDBuMcNIwoJmbd6PFdD+lbASgldpLto2SSP4jxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849677; c=relaxed/simple;
	bh=TImSBsu87oNNrMhjQADeSmSxvW70po1cO4mAK4N58wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH8QwfPpsHn6scZ1Vh53yRxu9SkELO/rzUT5zF41ue/B0nj/RM0GzbCcEwOavo982XmxdAk4eIDiNQ0MIwESsmxJSGOQAvaP0FAy5ouBqOiZ7IJfg7AUuGYSqMy6Tdcjq2T+JTDKLyseQC7B1lalAPBfGoF9GcHinBfEOoPTLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BqE6NsYW; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58024239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849675; x=1713454475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78qhJxH7WL0nlMptGJcY4x6plz30gPKCEiGq2oEox8s=;
        b=BqE6NsYW0/XgKK8vUFnsZBR6zKeGBrBIPtjkgB8FlWHIzCQ29xoExGSpz1knAkdeF9
         saAZ8Daba5pHNGr8JYnPWhn2U90pvz+wju/g1HqfwXE1mf6pUd8AwZAOsOZ+Kcl05cIH
         COlvKRpFlg2LzjjAEyQY9+uVOgqhimf2aZEqZGuNm38TeykZuhcwDOkxzW3um9bMcUfR
         9fvchKAvqmhtBmvFt4S3DzjPmZr9m9MHSSzffzFO1iETqm4aghFvs41yE7oGCsNWZ8ct
         sA4rf3p1jvpgyxT5OAOeP8FoE8JszjNyNyOIkmn4i7/fhVlj6Ufaia9Ixr2EJs0OtGtZ
         ZvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849675; x=1713454475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78qhJxH7WL0nlMptGJcY4x6plz30gPKCEiGq2oEox8s=;
        b=gaTxCm4zoUB5p4PIQ2Mr8kwJSm8eKPIJpWbiEcXcfYNY2zJBj4tat5/5cA6/nJ7Q33
         ZvUzkZFd5g0zcz/+DRJNEuIzK/1HDcm8M5uIbpweZvz7sPF/Z0vpaWWzq+Fvo8vR3dpb
         OxpAYp9hAT2onpDLH9Ar0h9Ab2s43mGcLnErBNzrQd+LlwzF32do5ZP7XDlkdVt5KAjC
         LeCTtLE/OYHqR/J6zl1gKp3v48sva3SkNHvj10qRYjeZ1pmLNu24we4RS8boXmR0pRwb
         6KOHzoDhdgBQ0QUGRTPVv2/vH9yIPmknNtDKLVplWlvn/9OB8DAMnWe01I3B6x02EBIB
         8B5A==
X-Gm-Message-State: AOJu0YzAp3mOzyRbU4WZwKh1HNRPS2fAR2We7AKLTlDxJRqZOn725o5S
	lm8a8f+8ESaYQDo9E9JXo4xU2XnUT3tzSupmu62PnN7cjgIW/PtdLaRcNhpUfViu5+1oF1q2cwX
	J
X-Google-Smtp-Source: AGHT+IEQHa76hHPsIUmcAoVcXx5zdcGqu9b3gVGpY+Tq0t+KXO1xRDX40O3yy6m+zIhusbz7V/SwMw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr156663ioh.1.1712849675161;
        Thu, 11 Apr 2024 08:34:35 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 102/437] lib: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:02 -0600
Message-ID: <20240411153126.16201-103-axboe@kernel.dk>
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
 lib/dynamic_debug.c  |  5 +++--
 lib/kunit/debugfs.c  | 13 ++++++-------
 lib/test_firmware.c  | 10 ++++------
 lib/xz/xz_dec_test.c |  9 ++++-----
 4 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c78f335fa981..534ad9218557 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1022,6 +1022,7 @@ static ssize_t ddebug_proc_write(struct file *file, const char __user *ubuf,
 	*offp += len;
 	return len;
 }
+FOPS_WRITE_ITER_HELPER(ddebug_proc_write);
 
 /*
  * Set the iterator to point to the first _ddebug object
@@ -1182,10 +1183,10 @@ static int ddebug_proc_open(struct inode *inode, struct file *file)
 static const struct file_operations ddebug_proc_fops = {
 	.owner = THIS_MODULE,
 	.open = ddebug_proc_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
-	.write = ddebug_proc_write
+	.write_iter = ddebug_proc_write_iter
 };
 
 static const struct proc_ops proc_fops = {
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index d548750a325a..ea7be601cf9e 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -139,28 +139,27 @@ static int debugfs_run_open(struct inode *inode, struct file *file)
  *
  * Note: what is written to this file will not be saved.
  */
-static ssize_t debugfs_run(struct file *file,
-		const char __user *buf, size_t count, loff_t *ppos)
+static ssize_t debugfs_run(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *f_inode = file->f_inode;
+	struct inode *f_inode = iocb->ki_filp->f_inode;
 	struct kunit_suite *suite = (struct kunit_suite *) f_inode->i_private;
 
 	__kunit_test_suites_init(&suite, 1);
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations debugfs_results_fops = {
 	.open = debugfs_results_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = debugfs_release,
 };
 
 static const struct file_operations debugfs_run_fops = {
 	.open = debugfs_run_open,
-	.read = seq_read,
-	.write = debugfs_run,
+	.read_iter = seq_read_iter,
+	.write_iter = debugfs_run,
 	.llseek = seq_lseek,
 	.release = debugfs_release,
 };
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 9cfdcd6d21db..face875a52e2 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -147,23 +147,21 @@ static struct test_firmware_upload *upload_lookup_name(const char *name)
 	return NULL;
 }
 
-static ssize_t test_fw_misc_read(struct file *f, char __user *buf,
-				 size_t size, loff_t *offset)
+static ssize_t test_fw_misc_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t rc = 0;
 
 	mutex_lock(&test_fw_mutex);
 	if (test_firmware)
-		rc = simple_read_from_buffer(buf, size, offset,
-					     test_firmware->data,
-					     test_firmware->size);
+		rc = simple_copy_to_iter(test_firmware->data, &iocb->ki_pos,
+					     test_firmware->size, to);
 	mutex_unlock(&test_fw_mutex);
 	return rc;
 }
 
 static const struct file_operations test_fw_fops = {
 	.owner          = THIS_MODULE,
-	.read           = test_fw_misc_read,
+	.read_iter      = test_fw_misc_read,
 };
 
 static void __test_release_all_firmware(void)
diff --git a/lib/xz/xz_dec_test.c b/lib/xz/xz_dec_test.c
index da28a19d6c98..42dc077e247b 100644
--- a/lib/xz/xz_dec_test.c
+++ b/lib/xz/xz_dec_test.c
@@ -99,9 +99,9 @@ static int xz_dec_test_release(struct inode *i, struct file *f)
  * The .xz file must have exactly one Stream and no Stream Padding. The data
  * after the first Stream is considered to be garbage.
  */
-static ssize_t xz_dec_test_write(struct file *file, const char __user *buf,
-				 size_t size, loff_t *pos)
+static ssize_t xz_dec_test_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t size = iov_iter_count(from);
 	size_t remaining;
 
 	if (ret != XZ_OK) {
@@ -122,10 +122,9 @@ static ssize_t xz_dec_test_write(struct file *file, const char __user *buf,
 		if (buffers.in_pos == buffers.in_size) {
 			buffers.in_pos = 0;
 			buffers.in_size = min(remaining, sizeof(buffer_in));
-			if (copy_from_user(buffer_in, buf, buffers.in_size))
+			if (!copy_from_iter_full(buffer_in, buffers.in_size, from))
 				return -EFAULT;
 
-			buf += buffers.in_size;
 			remaining -= buffers.in_size;
 		}
 
@@ -179,7 +178,7 @@ static int __init xz_dec_test_init(void)
 		.owner = THIS_MODULE,
 		.open = &xz_dec_test_open,
 		.release = &xz_dec_test_release,
-		.write = &xz_dec_test_write
+		.write_iter = &xz_dec_test_write
 	};
 
 	state = xz_dec_init(XZ_PREALLOC, DICT_MAX);
-- 
2.43.0


