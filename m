Return-Path: <linux-kernel+bounces-141207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404358A1AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DC81C21EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5B1FFC4E;
	Thu, 11 Apr 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TT+WWE69"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E21FFC2F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850210; cv=none; b=Nc9rLYD80ZStz9zHRTXLt5b7rMncM89E8D8uboEdM4RP+0xb7W9pl2WcRfGGALilhCMxKq+/Sy2f99SLEPJ8+/512te9kLvvvRyRIqr3dAIPKlcJmsivxeE1hrhvfmEbaUwlvLNcRbLmqqDXg/BpAEShKTScD7nz63RL60a6vKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850210; c=relaxed/simple;
	bh=HFTmnKylzPQwNXAAPpfS4aP5WV7Bkkzueob2mHtK75o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATlok7o/ijEySn5HbrDSALEMuALtisD0kNvKYDjykeS2f9RI8k90fNTX2SG8sYJ8vXzKlU7QZIybC3ooENbrB5Jh+l/5w+a/DUYnWkGnLgAPk0iMaX3icz+ROOks1OTOfqzoSYXz4kIbWgesgpSGKL2N+L63BjGvU3ke2e+D+0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TT+WWE69; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9116439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850208; x=1713455008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxRhhQb6flOdBY7pA0oqcPyu7EgP/zuEEveEvFRgBG8=;
        b=TT+WWE69e2CUz/TXX5yz10VMnImfWdJBBKNkmU2nDCLk6VRXitHo+hzCTbtzWrN77D
         NMFkkqN7K5T7hRottWEeFjw3SVvePaB8AHv4tGls5syukUpCO19VN2NrJPPZUAZy5oKA
         jucTc6Ofg2gs80WXCMT4AwVABJuW1e8pSOxa8x2zl6S10ewSYbfP8Ck1TnJu/Cf9Aucr
         xPEP9mZHP9JrtBlIC7WKC+vtJjbsJDR/+yoXZIBOSPr1gxEyYX5Aw85YUDthM6c6fdqv
         Bt0cG+VbAdqcdmwPsmGnB7VZAqo2qfdr14figsIGKIeGDCsyA7FhmzjKh9A7TWqgg03r
         RDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850208; x=1713455008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxRhhQb6flOdBY7pA0oqcPyu7EgP/zuEEveEvFRgBG8=;
        b=XsfQL2O3YXCRQySyPfL4z6/XRRdsxGKGOCT9SpKFsOkf6bikfDuVFaHvN4F1IbZJud
         B+zn2BNPS56u7WXeSomXyYeIH+C5uGt9//jrfAZiC/gtktfJynKlpc3jRJH5PlMcsWeM
         b6yhApdpC8UmdHguBxpScDSaV0goqZ9OjK5znX9rq5koqTTpI1UUXcnf90xMen/plPm7
         1PbVyItaFzS6IgcOzwAxlYOdnvu1n0TirRIXitXs/mgbhQehOuq2UyNLBGP6cECzH9nD
         AQZeJIyCCnGGIg7/Y+TpbNQ42z93LAchWkc5xo5FlNqKSIb3kdcM6XL9KYSUqAp9bWE7
         ShmA==
X-Gm-Message-State: AOJu0Yz9jCb1FQGIgt4VSytZH9vp5p7EXGSSczGos1DP+kVYniF1PwdM
	ZB6FUV/huSIwuZ3Umqyq8KYvLpQzYVvpPLyAi298WLZBs1DBkAk1+5KB6RHDFCOGkw1iREsfXCj
	m
X-Google-Smtp-Source: AGHT+IGiU6sMCdlNcu6qZwESg3GfbZJcWuLFytN8FT65wr/8E83rkepbFfxBHTtZy1jrH8apzogCDA==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr241178ioh.0.1712850208384;
        Thu, 11 Apr 2024 08:43:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 423/437] media: radio-si476x: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:23 -0600
Message-ID: <20240411153126.16201-424-axboe@kernel.dk>
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
 drivers/media/radio/radio-si476x.c | 60 +++++++++++++-----------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/media/radio/radio-si476x.c b/drivers/media/radio/radio-si476x.c
index b2c5809a8bc7..fcc330d6dc75 100644
--- a/drivers/media/radio/radio-si476x.c
+++ b/drivers/media/radio/radio-si476x.c
@@ -1178,12 +1178,11 @@ static const struct video_device si476x_viddev_template = {
 
 
 
-static ssize_t si476x_radio_read_acf_blob(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t si476x_radio_read_acf_blob(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
 	int err;
-	struct si476x_radio *radio = file->private_data;
+	struct si476x_radio *radio = iocb->ki_filp->private_data;
 	struct si476x_acf_status_report report;
 
 	si476x_core_lock(radio->core);
@@ -1196,22 +1195,20 @@ static ssize_t si476x_radio_read_acf_blob(struct file *file,
 	if (err < 0)
 		return err;
 
-	return simple_read_from_buffer(user_buf, count, ppos, &report,
-				       sizeof(report));
+	return simple_copy_to_iter(&report, &iocb->ki_pos, sizeof(report), to);
 }
 
 static const struct file_operations radio_acf_fops = {
 	.open	= simple_open,
 	.llseek = default_llseek,
-	.read	= si476x_radio_read_acf_blob,
+	.read_iter = si476x_radio_read_acf_blob,
 };
 
-static ssize_t si476x_radio_read_rds_blckcnt_blob(struct file *file,
-						  char __user *user_buf,
-						  size_t count, loff_t *ppos)
+static ssize_t si476x_radio_read_rds_blckcnt_blob(struct kiocb *iocb,
+						  struct iov_iter *to)
 {
 	int err;
-	struct si476x_radio *radio = file->private_data;
+	struct si476x_radio *radio = iocb->ki_filp->private_data;
 	struct si476x_rds_blockcount_report report;
 
 	si476x_core_lock(radio->core);
@@ -1225,22 +1222,20 @@ static ssize_t si476x_radio_read_rds_blckcnt_blob(struct file *file,
 	if (err < 0)
 		return err;
 
-	return simple_read_from_buffer(user_buf, count, ppos, &report,
-				       sizeof(report));
+	return simple_copy_to_iter(&report, &iocb->ki_pos, sizeof(report), to);
 }
 
 static const struct file_operations radio_rds_blckcnt_fops = {
 	.open	= simple_open,
 	.llseek = default_llseek,
-	.read	= si476x_radio_read_rds_blckcnt_blob,
+	.read_iter = si476x_radio_read_rds_blckcnt_blob,
 };
 
-static ssize_t si476x_radio_read_agc_blob(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t si476x_radio_read_agc_blob(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
 	int err;
-	struct si476x_radio *radio = file->private_data;
+	struct si476x_radio *radio = iocb->ki_filp->private_data;
 	struct si476x_agc_status_report report;
 
 	si476x_core_lock(radio->core);
@@ -1253,22 +1248,20 @@ static ssize_t si476x_radio_read_agc_blob(struct file *file,
 	if (err < 0)
 		return err;
 
-	return simple_read_from_buffer(user_buf, count, ppos, &report,
-				       sizeof(report));
+	return simple_copy_to_iter(&report, &iocb->ki_pos, sizeof(report), to);
 }
 
 static const struct file_operations radio_agc_fops = {
 	.open	= simple_open,
 	.llseek = default_llseek,
-	.read	= si476x_radio_read_agc_blob,
+	.read_iter = si476x_radio_read_agc_blob,
 };
 
-static ssize_t si476x_radio_read_rsq_blob(struct file *file,
-					  char __user *user_buf,
-					  size_t count, loff_t *ppos)
+static ssize_t si476x_radio_read_rsq_blob(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
 	int err;
-	struct si476x_radio *radio = file->private_data;
+	struct si476x_radio *radio = iocb->ki_filp->private_data;
 	struct si476x_rsq_status_report report;
 	struct si476x_rsq_status_args args = {
 		.primary	= false,
@@ -1288,22 +1281,20 @@ static ssize_t si476x_radio_read_rsq_blob(struct file *file,
 	if (err < 0)
 		return err;
 
-	return simple_read_from_buffer(user_buf, count, ppos, &report,
-				       sizeof(report));
+	return simple_copy_to_iter(&report, &iocb->ki_pos, sizeof(report), to);
 }
 
 static const struct file_operations radio_rsq_fops = {
 	.open	= simple_open,
 	.llseek = default_llseek,
-	.read	= si476x_radio_read_rsq_blob,
+	.read_iter = si476x_radio_read_rsq_blob,
 };
 
-static ssize_t si476x_radio_read_rsq_primary_blob(struct file *file,
-						  char __user *user_buf,
-						  size_t count, loff_t *ppos)
+static ssize_t si476x_radio_read_rsq_primary_blob(struct kiocb *iocb,
+						  struct iov_iter *to)
 {
 	int err;
-	struct si476x_radio *radio = file->private_data;
+	struct si476x_radio *radio = iocb->ki_filp->private_data;
 	struct si476x_rsq_status_report report;
 	struct si476x_rsq_status_args args = {
 		.primary	= true,
@@ -1323,14 +1314,13 @@ static ssize_t si476x_radio_read_rsq_primary_blob(struct file *file,
 	if (err < 0)
 		return err;
 
-	return simple_read_from_buffer(user_buf, count, ppos, &report,
-				       sizeof(report));
+	return simple_copy_to_iter(&report, &iocb->ki_pos, sizeof(report), to);
 }
 
 static const struct file_operations radio_rsq_primary_fops = {
 	.open	= simple_open,
 	.llseek = default_llseek,
-	.read	= si476x_radio_read_rsq_primary_blob,
+	.read_iter = si476x_radio_read_rsq_primary_blob,
 };
 
 
-- 
2.43.0


