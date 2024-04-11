Return-Path: <linux-kernel+bounces-140887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D5E8A1962
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F47F1F21E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C8115A49D;
	Thu, 11 Apr 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="frpYVgdW"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035A15990F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849711; cv=none; b=VUnh5mIomsBz0ha6ytQNWTR59M/pzzZ/R+IfOqRWV2b3B0Ul7ulTUF8i2WivZmwfIVoMu9JQapVE04WQq7Ra8Ze1v2FD9tOHaZQSgX4RqfDSIomz/13+/dT8mDQBSFIfUMVphgpx5EcqF0aQScYzRye7gDdSK5rOP+TRzqQa8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849711; c=relaxed/simple;
	bh=2jpgqsaRNnfM5RlyfhsLchALqZkLfgI9lutsTG6mMOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEkJujCbQuhPWEtiTUNBRVdWYsN7xLsf6keOsiCrQ9RKTwFRGlyAIDS5YLEKfQESXm9FILephnGEgNMiA253QbMT43eWZb/MASWY5dOxHT+AqE6vvhMCEvyzmhA8uW7kGkCG4i792nc1fxWoWw/3lLiSD9kjOtQ0VrTJCi6Qtlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=frpYVgdW; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170492239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849709; x=1713454509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P11kmzenZH0wLpPwDrZo3WxQIM4domjvSQ3qEPqaXb0=;
        b=frpYVgdWM9AGpuHLHROq2S3HXrUGvirwYldEu+WH/pNz4EPREODat0rKgQDDfoLR2h
         ERH+/ovJ2XxiNqIWXAxY4B9w/C/LbHY9onsrvrO/lsnj9IwulvzzgI+X1MatIqDdwSZt
         mi44FUdiAlba7d4mk9/E7FG5jIeTo7xaEMjetmm5PVySy7UGCBcyr8fr/qWI+pVkunep
         1q9oPy8N3/VCEMYn3ouhluHIXwok3pdLBc+zBirf8Dg5Motv2gSqzj6r6lcY4PMb9IYt
         gRLlpoxaWTVzAmO6NcaE1Y4pgtnJyXPokFXaGrEDn2iD87PX1ZH8fjNQ97BhopL2/Hjm
         /Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849709; x=1713454509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P11kmzenZH0wLpPwDrZo3WxQIM4domjvSQ3qEPqaXb0=;
        b=YGMwNWEDLOG8whvxDDR6P/1pDXBGFC5noi964gmjcEiKASxi7xW3jp+ZBho34jOHCC
         UcpaKXWWsWK2efaPKEWLh48yBylRZmW+OYvlHQJ41qVo96BN32fRggYGBPZg4ilxyrCR
         wTXWezFwflzGNdQD3SPte+CP/gTFsrC/jCoTzBB0opkHB1qI/UN6ryOpIP5GpLk0aUEi
         5tCg/xcpPAp7ae6o/gPBT06QaMV7llgniWPDy9Sg83qHNAfxqFxVxDCnPg/ytgYmYszQ
         s1C+uH5l0JPvts5WYWoAyf06sdepkjaeQ/JY1JI03bvaTVpEYoRy+xnL5/nH7Cjjv3sk
         33qA==
X-Gm-Message-State: AOJu0YxrXD7uibhEnxsz+4/qLR8ee2Bc3ZEizkYtFLhyK8br4bDAJwRQ
	+LmBt3NVrR31BM+kKxOs5uhXBGog7TxcdT+GbyP8lsA8pMhC6QqIYc9Rdt5KDcSQ8AlPxnj3QN5
	z
X-Google-Smtp-Source: AGHT+IFukpgdzcNWpSIoHYUcXeStn0qs+nfuEHZIgD4pc8FP+snAfV+Dv4NT61aX+yZoPyfOE8wuOA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr178447ioj.2.1712849708683;
        Thu, 11 Apr 2024 08:35:08 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 123/437] fs/fuse: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:23 -0600
Message-ID: <20240411153126.16201-124-axboe@kernel.dk>
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
 fs/fuse/control.c | 70 ++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 0ca1d1f418c3..e572013d345e 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -43,8 +43,7 @@ static ssize_t fuse_conn_abort_write(struct kiocb *iocb, struct iov_iter *from)
 	return iov_iter_count(from);
 }
 
-static ssize_t fuse_conn_waiting_read_iter(struct kiocb *iocb,
-					   struct iov_iter *to)
+static ssize_t fuse_conn_waiting_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char tmp[32];
 	size_t size;
@@ -63,27 +62,27 @@ static ssize_t fuse_conn_waiting_read_iter(struct kiocb *iocb,
 	return simple_copy_to_iter(tmp, &iocb->ki_pos, size, to);
 }
 
-static ssize_t fuse_conn_limit_read(struct file *file, char __user *buf,
-				    size_t len, loff_t *ppos, unsigned val)
+static ssize_t fuse_conn_limit_read(struct kiocb *iocb, struct iov_iter *to,
+				    unsigned val)
 {
 	char tmp[32];
 	size_t size = sprintf(tmp, "%u\n", val);
 
-	return simple_read_from_buffer(buf, len, ppos, tmp, size);
+	return simple_copy_to_iter(tmp, &iocb->ki_pos, size, to);
 }
 
-static ssize_t fuse_conn_limit_write(struct file *file, const char __user *buf,
-				     size_t count, loff_t *ppos, unsigned *val,
-				     unsigned global_limit)
+static ssize_t fuse_conn_limit_write(struct kiocb *iocb, struct iov_iter *from,
+				     unsigned *val, unsigned global_limit)
 {
 	unsigned long t;
 	unsigned limit = (1 << 16) - 1;
+	size_t count = iov_iter_count(from);
 	int err;
 
-	if (*ppos)
+	if (iocb->ki_pos)
 		return -EINVAL;
 
-	err = kstrtoul_from_user(buf, count, 0, &t);
+	err = kstrtoul_from_iter(from, count, 0, &t);
 	if (err)
 		return err;
 
@@ -98,35 +97,31 @@ static ssize_t fuse_conn_limit_write(struct file *file, const char __user *buf,
 	return count;
 }
 
-static ssize_t fuse_conn_max_background_read(struct file *file,
-					     char __user *buf, size_t len,
-					     loff_t *ppos)
+static ssize_t fuse_conn_max_background_read(struct kiocb *iocb,
+					     struct iov_iter *to)
 {
 	struct fuse_conn *fc;
 	unsigned val;
 
-	fc = fuse_ctl_file_conn_get(file);
+	fc = fuse_ctl_file_conn_get(iocb->ki_filp);
 	if (!fc)
 		return 0;
 
 	val = READ_ONCE(fc->max_background);
 	fuse_conn_put(fc);
 
-	return fuse_conn_limit_read(file, buf, len, ppos, val);
+	return fuse_conn_limit_read(iocb, to, val);
 }
-FOPS_READ_ITER_HELPER(fuse_conn_max_background_read);
 
-static ssize_t fuse_conn_max_background_write(struct file *file,
-					      const char __user *buf,
-					      size_t count, loff_t *ppos)
+static ssize_t fuse_conn_max_background_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
 	unsigned val;
 	ssize_t ret;
 
-	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
-				    max_user_bgreq);
+	ret = fuse_conn_limit_write(iocb, from, &val, max_user_bgreq);
 	if (ret > 0) {
-		struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
+		struct fuse_conn *fc = fuse_ctl_file_conn_get(iocb->ki_filp);
 		if (fc) {
 			spin_lock(&fc->bg_lock);
 			fc->max_background = val;
@@ -140,38 +135,34 @@ static ssize_t fuse_conn_max_background_write(struct file *file,
 
 	return ret;
 }
-FOPS_WRITE_ITER_HELPER(fuse_conn_max_background_write);
 
-static ssize_t fuse_conn_congestion_threshold_read(struct file *file,
-						   char __user *buf, size_t len,
-						   loff_t *ppos)
+static ssize_t fuse_conn_congestion_threshold_read(struct kiocb *iocb,
+						   struct iov_iter *to)
 {
 	struct fuse_conn *fc;
 	unsigned val;
 
-	fc = fuse_ctl_file_conn_get(file);
+	fc = fuse_ctl_file_conn_get(iocb->ki_filp);
 	if (!fc)
 		return 0;
 
 	val = READ_ONCE(fc->congestion_threshold);
 	fuse_conn_put(fc);
 
-	return fuse_conn_limit_read(file, buf, len, ppos, val);
+	return fuse_conn_limit_read(iocb, to, val);
 }
 
-static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
-						    const char __user *buf,
-						    size_t count, loff_t *ppos)
+static ssize_t fuse_conn_congestion_threshold_write(struct kiocb *iocb,
+						    struct iov_iter *from)
 {
 	unsigned val;
 	struct fuse_conn *fc;
 	ssize_t ret;
 
-	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
-				    max_user_congthresh);
+	ret = fuse_conn_limit_write(iocb, from, &val, max_user_congthresh);
 	if (ret <= 0)
 		goto out;
-	fc = fuse_ctl_file_conn_get(file);
+	fc = fuse_ctl_file_conn_get(iocb->ki_filp);
 	if (!fc)
 		goto out;
 
@@ -180,7 +171,6 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 out:
 	return ret;
 }
-FOPS_WRITE_ITER_HELPER(fuse_conn_congestion_threshold_write);
 
 static const struct file_operations fuse_ctl_abort_ops = {
 	.open = nonseekable_open,
@@ -190,21 +180,21 @@ static const struct file_operations fuse_ctl_abort_ops = {
 
 static const struct file_operations fuse_ctl_waiting_ops = {
 	.open = nonseekable_open,
-	.read_iter = fuse_conn_waiting_read_iter,
+	.read_iter = fuse_conn_waiting_read,
 	.llseek = no_llseek,
 };
 
 static const struct file_operations fuse_conn_max_background_ops = {
 	.open = nonseekable_open,
-	.read_iter = fuse_conn_max_background_read_iter,
-	.write_iter = fuse_conn_max_background_write_iter,
+	.read_iter = fuse_conn_max_background_read,
+	.write_iter = fuse_conn_max_background_write,
 	.llseek = no_llseek,
 };
 
 static const struct file_operations fuse_conn_congestion_threshold_ops = {
 	.open = nonseekable_open,
-	.read = fuse_conn_congestion_threshold_read,
-	.write_iter = fuse_conn_congestion_threshold_write_iter,
+	.read_iter = fuse_conn_congestion_threshold_read,
+	.write_iter = fuse_conn_congestion_threshold_write,
 	.llseek = no_llseek,
 };
 
-- 
2.43.0


