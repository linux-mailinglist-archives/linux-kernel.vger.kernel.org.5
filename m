Return-Path: <linux-kernel+bounces-140804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F678A1959
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87124B24DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A650243;
	Thu, 11 Apr 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YAMkj2Yg"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E15A0FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849569; cv=none; b=pevEB0hr55IJwUynyymQZH4wUqU//jjmzngNBFZ1JlG2KxBI3aaDja7H2NtcKGaZ76inVrt+qNGehokjS0JTGJfymX1/F55xp16rxmXooHBpPLqQcwkPm7/BOp4aAb5Kl3/JVqVLCORtxdOa55RG9Fk9kVwpKt9kZegC/mMPnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849569; c=relaxed/simple;
	bh=nDSvQRZm3ESKnp1OWc2Yl66wupKU+SqQNqmn/taElQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRV/MWka7w5Y4KAB1r2+bxxh6nN6CK0MoW5ilzIEiAKJjpPDnB8sD46TuNHa+TvHW6iauCRVIbSF2sE5LUhm7ILHgrun4vrNcZO7pIY/SOeMM7FQeN7LSLuELXJRaYFkzoSForSkZPy28t/1j0lN/hdoWT6ZTEXGrXcIe793PwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YAMkj2Yg; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69502039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849566; x=1713454366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ms/mRdLoOCdylV3gDCda45AmlfEDV+h5edfFw6pkhOE=;
        b=YAMkj2Yg9MeeWx1Js0KcPjsFwIQaZpnR7yUT6NXAqfg4aipmDbW8HbzAxmfxpXVUmm
         dSh51f2M0JLadAplsgprwqiHh2s/UNJcBIzOoLTI3oxaVecYi+J9Qax/DzmLhDwW95i3
         r0c23oUUMnneJEs97Ov6L+6D4W/aKKluEbIwUxVWXNXpp/KTfV2m4fv1RtfXZfCpgVE1
         hUdSqfM2dojA0wgOrCZHeVWj9diLriSogsjjhdOEBShM8m8zJO/PbkGGK54nBjmlT4iR
         FTMxebsrlGWFbLqho9fXpYELo+Y6k6JzKeNpBuyixRj4yRi+rri+Ox2s1coXTXzWkNKt
         Q7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849566; x=1713454366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms/mRdLoOCdylV3gDCda45AmlfEDV+h5edfFw6pkhOE=;
        b=kFtxEnTjwXKrjgGNPeYg7ZQs3qaeYLV2v9QDkRRiwRJUN2xVXqhrgREBS+p22DXuTm
         jqhLupy1zqOLtufw0+dspmrvC3b5cH9L/LBW5O7D7+VPPPRmZArEKQOBJZbgdHz7Dld0
         NBAb9i2iZYKXDHKmmqVcjfz5/7uZhnWWbxc0mft7hWr6ZTtPmpS3kqDZbb6FdXyK99ZU
         YNOnX13Z8zlKk3to8Dq8MG3JjxnBQxNUFymDKrcwEBsEmBlNwOgtm+Pc9u2iwA0bnqij
         limA5ERXiYgSoPEkQXlDO0XTa2BOQ2tcR1yxgN6Zv386cjY4XnIiWAXHAN/GB4r1HWhl
         bplQ==
X-Gm-Message-State: AOJu0YzVGHli+j1i37dGEHoaqecNB4R0Jzf7jtZHJ9n7dq8vK34iz3gh
	JeY13S7nY4pWrHx2+VXwZg/3zC786DOfGqBL5JTCGgQMUUjCC56D/3vlLXfOa+HBwSSd7j67O+c
	g
X-Google-Smtp-Source: AGHT+IFztRmV2DWVXZw83b7oBCtnqWL+v+PBOA3qdu07+9G2cS34zomuds+0REuLfc5kJHgBEpygAg==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr204893iof.0.1712849566391;
        Thu, 11 Apr 2024 08:32:46 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 044/437] ocfs2: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:04 -0600
Message-ID: <20240411153126.16201-45-axboe@kernel.dk>
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
 fs/ocfs2/cluster/heartbeat.c | 15 ++++++++-------
 fs/ocfs2/dlm/dlmdebug.c      | 16 +++++++++-------
 fs/ocfs2/stack_user.c        |  6 ++++--
 fs/ocfs2/super.c             | 15 ++++++++-------
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 1bde1281d514..6baff47a3a08 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1350,12 +1350,14 @@ static int o2hb_debug_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t o2hb_debug_read(struct file *file, char __user *buf,
-				 size_t nbytes, loff_t *ppos)
+static ssize_t o2hb_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(buf, nbytes, ppos, file->private_data,
-				       i_size_read(file->f_mapping->host));
+	struct file *file = iocb->ki_filp;
+
+	return simple_copy_to_iter(file->private_data, &iocb->ki_pos,
+				       i_size_read(file->f_mapping->host), to);
 }
+
 #else
 static int o2hb_debug_open(struct inode *inode, struct file *file)
 {
@@ -1365,8 +1367,7 @@ static int o2hb_debug_release(struct inode *inode, struct file *file)
 {
 	return 0;
 }
-static ssize_t o2hb_debug_read(struct file *file, char __user *buf,
-			       size_t nbytes, loff_t *ppos)
+static ssize_t o2hb_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
@@ -1375,7 +1376,7 @@ static ssize_t o2hb_debug_read(struct file *file, char __user *buf,
 static const struct file_operations o2hb_debug_fops = {
 	.open =		o2hb_debug_open,
 	.release =	o2hb_debug_release,
-	.read =		o2hb_debug_read,
+	.read_iter =	o2hb_debug_read,
 	.llseek =	generic_file_llseek,
 };
 
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index cd4857d5a44a..bad07f55bbf6 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -336,12 +336,14 @@ static int debug_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t debug_read(struct file *file, char __user *buf,
-			  size_t nbytes, loff_t *ppos)
+static ssize_t debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(buf, nbytes, ppos, file->private_data,
-				       i_size_read(file->f_mapping->host));
+	struct file *file = iocb->ki_filp;
+
+	return simple_copy_to_iter(file->private_data, &iocb->ki_pos,
+				       i_size_read(file->f_mapping->host), to);
 }
+
 /* end - util funcs */
 
 /* begin - purge list funcs */
@@ -395,7 +397,7 @@ static int debug_purgelist_open(struct inode *inode, struct file *file)
 static const struct file_operations debug_purgelist_fops = {
 	.open =		debug_purgelist_open,
 	.release =	debug_release,
-	.read =		debug_read,
+	.read_iter =	debug_read,
 	.llseek =	generic_file_llseek,
 };
 /* end - purge list funcs */
@@ -452,7 +454,7 @@ static int debug_mle_open(struct inode *inode, struct file *file)
 static const struct file_operations debug_mle_fops = {
 	.open =		debug_mle_open,
 	.release =	debug_release,
-	.read =		debug_read,
+	.read_iter =	debug_read,
 	.llseek =	generic_file_llseek,
 };
 
@@ -843,7 +845,7 @@ static int debug_state_open(struct inode *inode, struct file *file)
 static const struct file_operations debug_state_fops = {
 	.open =		debug_state_open,
 	.release =	debug_release,
-	.read =		debug_read,
+	.read_iter =	debug_read,
 	.llseek =	generic_file_llseek,
 };
 /* end  - debug state funcs */
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index c11406cd87a8..360fb8f35e43 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -534,6 +534,7 @@ static ssize_t ocfs2_control_write(struct file *file,
 
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(ocfs2_control_write);
 
 /*
  * This is a naive version.  If we ever have a new protocol, we'll expand
@@ -556,6 +557,7 @@ static ssize_t ocfs2_control_read(struct file *file,
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(ocfs2_control_read);
 
 static int ocfs2_control_release(struct inode *inode, struct file *file)
 {
@@ -616,8 +618,8 @@ static int ocfs2_control_open(struct inode *inode, struct file *file)
 static const struct file_operations ocfs2_control_fops = {
 	.open    = ocfs2_control_open,
 	.release = ocfs2_control_release,
-	.read    = ocfs2_control_read,
-	.write   = ocfs2_control_write,
+	.read_iter = ocfs2_control_read_iter,
+	.write_iter = ocfs2_control_write_iter,
 	.owner   = THIS_MODULE,
 	.llseek  = default_llseek,
 };
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 8aabaed2c1cb..6f7107ecd6c6 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -360,12 +360,14 @@ static int ocfs2_debug_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t ocfs2_debug_read(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+static ssize_t ocfs2_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(buf, nbytes, ppos, file->private_data,
-				       i_size_read(file->f_mapping->host));
+	struct file *file = iocb->ki_filp;
+
+	return simple_copy_to_iter(file->private_data, &iocb->ki_pos,
+				       i_size_read(file->f_mapping->host), to);
 }
+
 #else
 static int ocfs2_osb_debug_open(struct inode *inode, struct file *file)
 {
@@ -375,8 +377,7 @@ static int ocfs2_debug_release(struct inode *inode, struct file *file)
 {
 	return 0;
 }
-static ssize_t ocfs2_debug_read(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+static ssize_t ocfs2_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
@@ -385,7 +386,7 @@ static ssize_t ocfs2_debug_read(struct file *file, char __user *buf,
 static const struct file_operations ocfs2_osb_debug_fops = {
 	.open =		ocfs2_osb_debug_open,
 	.release =	ocfs2_debug_release,
-	.read =		ocfs2_debug_read,
+	.read_iter =	ocfs2_debug_read,
 	.llseek =	generic_file_llseek,
 };
 
-- 
2.43.0


