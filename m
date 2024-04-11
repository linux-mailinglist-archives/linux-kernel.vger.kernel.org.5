Return-Path: <linux-kernel+bounces-141215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3862D8A1B25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9BCB2CC41
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D1B203585;
	Thu, 11 Apr 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y2yOq3TC"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD40202A4A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850220; cv=none; b=mfW+AuICGi9iUJCHT1CzyQQdWICy0O56RJloT09qq2zqmpX1wtm7aY3q85OMrPigEt6oXfju0BWIBiF5NXYd+iR6yZcXy4wR2R4jpNUeAw9qh7rkPOR2g9p8OvbYiJyN4PAGBvBvQWUlwdEdwQZheuuLtoXmRkBCUdohFCcKxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850220; c=relaxed/simple;
	bh=MPi21D3v7l1uMh2oBQjBBGPb6q6SBmZSpJISeTLNUGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYpashNBhthh4+uB5A4wwUQqVOeopHYDo1Gcn7JQ82afgdvO2INq7PO8aRI4yLgiyS9fLKiY9pyI+Hbf0I/WSiHk4F8f0VYgY9CuvCRK0ddZNl1t0M9yHC0XWl0c0r9J1orEmpTDy65ldnZ5TOAFBsyxa3wQZmEFc/0DS9vIfmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y2yOq3TC; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36a34b68277so125265ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850217; x=1713455017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJUrvBrg1uBEhpi3T9qcRw20xiWZs8OJrCgKCAskMk0=;
        b=y2yOq3TCsW29oKemslwHMIUtga9to9FFjJlcKkTsPOO43QVKyrKT55cS/RDqBWkkz9
         epEsoUyJawoIBOWDdabnkar1ffTkeiLulMD+FjOQSEhiy4/+uzpMNMSq21aqkhvwl2qN
         VskVAItGGPGj1/e15ORLrfcYSox8joouJciXH2GQa9dFZQHh9iA981BIaSWwJmxEEDJo
         fLfCNr45L8v/38GiPDBxGO9s3GGGRE9lwGFuADp5GXHcsYtpQX/A3ktVObPgMDyDc91X
         EMV1V5S5X9amrWgnqVH4v1IBDs92I49nYVBpcsIgqMlXYZ8ZbbPigPRJKk00QxG3fNR8
         9yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850217; x=1713455017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJUrvBrg1uBEhpi3T9qcRw20xiWZs8OJrCgKCAskMk0=;
        b=ZohXnXQk+fYTSa/m9S29RuB8b2a0Mdjc3jmOI8wVwfAXyKmkeOd79oq81V8+s1XXlO
         V9BAz2zetjAyROvYvfhvyffkXUBnBmdujaqaY3TefYKBD425SD9nQWd9w+XSb4wWdJut
         GxFBNl5DZyUUNnol40fq1CucAeMKluPP6hSnUx3SbS8ssAO8GT1AjgbKHR8lqI6M6GPz
         311+YWCoCsr7wNlEVqj3hBvIfeTNj8tjzxo8uBCKNlmQAdhHgM0ra6V/61XsiGqQui1x
         CS4Jx5RqIkhT8rh64DUuZ4CANvLvbvQNHHIbbrcG1kQ4C6vhqi8588jVgbSpbDodpCiC
         yxPQ==
X-Gm-Message-State: AOJu0Yx8kDzXoZnYZVa9bUHkiIERzGa5XXJ+dKIncHZsbiq3lFsHFYzi
	HLzj9smicJGTJvxmoxIKBqXkrZZercVSRRuUifCZFNdoDaI1w4CWOxFuIYHAcq4352pLpDj5T8m
	X
X-Google-Smtp-Source: AGHT+IEWtLzIbB5s+X5ORDtbVgk3C9Qkf46xI+U1Dp+Az/FGndwmkq2RiCFUvuVfLl+kJjscG4P+XQ==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr205864iob.0.1712850216723;
        Thu, 11 Apr 2024 08:43:36 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 428/437] sbus: oradax: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:28 -0600
Message-ID: <20240411153126.16201-429-axboe@kernel.dk>
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
 drivers/sbus/char/oradax.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index a536dd6f4f7c..2e99e25b4b50 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -204,24 +204,21 @@ struct dax_ctx {
 
 /* driver public entry points */
 static int dax_open(struct inode *inode, struct file *file);
-static ssize_t dax_read(struct file *filp, char __user *buf,
-			size_t count, loff_t *ppos);
-static ssize_t dax_write(struct file *filp, const char __user *buf,
-			 size_t count, loff_t *ppos);
+static ssize_t dax_read(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t dax_write(struct kiocb *iocb, struct iov_iter *from);
 static int dax_devmap(struct file *f, struct vm_area_struct *vma);
 static int dax_close(struct inode *i, struct file *f);
 
 static const struct file_operations dax_fops = {
 	.owner	=	THIS_MODULE,
 	.open	=	dax_open,
-	.read	=	dax_read,
-	.write	=	dax_write,
+	.read_iter	=	dax_read,
+	.write_iter	=	dax_write,
 	.mmap	=	dax_devmap,
 	.release =	dax_close,
 };
 
-static int dax_ccb_exec(struct dax_ctx *ctx, const char __user *buf,
-			size_t count, loff_t *ppos);
+static int dax_ccb_exec(struct dax_ctx *ctx, loff_t *ppos, struct iov_iter *from);
 static int dax_ccb_info(u64 ca, struct ccb_info_result *info);
 static int dax_ccb_kill(u64 ca, u16 *kill_res);
 
@@ -541,10 +538,10 @@ static int dax_close(struct inode *ino, struct file *f)
 	return 0;
 }
 
-static ssize_t dax_read(struct file *f, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t dax_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dax_ctx *ctx = f->private_data;
+	struct dax_ctx *ctx = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 
 	if (ctx->client != current)
 		return -EUSERS;
@@ -553,15 +550,15 @@ static ssize_t dax_read(struct file *f, char __user *buf,
 
 	if (count != sizeof(union ccb_result))
 		return -EINVAL;
-	if (copy_to_user(buf, &ctx->result, sizeof(union ccb_result)))
+	if (!copy_to_iter_full(&ctx->result, sizeof(union ccb_result), to))
 		return -EFAULT;
 	return count;
 }
 
-static ssize_t dax_write(struct file *f, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t dax_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct dax_ctx *ctx = f->private_data;
+	struct dax_ctx *ctx = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct dax_command hdr;
 	unsigned long ca;
 	int i, idx, ret;
@@ -573,7 +570,7 @@ static ssize_t dax_write(struct file *f, const char __user *buf,
 		return -EINVAL;
 
 	if (count % sizeof(struct dax_ccb) == 0)
-		return dax_ccb_exec(ctx, buf, count, ppos); /* CCB EXEC */
+		return dax_ccb_exec(ctx, &iocb->ki_pos, from); /* CCB EXEC */
 
 	if (count != sizeof(struct dax_command))
 		return -EINVAL;
@@ -582,7 +579,7 @@ static ssize_t dax_write(struct file *f, const char __user *buf,
 	if (ctx->owner != current)
 		return -EUSERS;
 
-	if (copy_from_user(&hdr, buf, sizeof(hdr)))
+	if (!copy_from_iter_full(&hdr, sizeof(hdr), from))
 		return -EFAULT;
 
 	ca = ctx->ca_buf_ra + hdr.ca_offset;
@@ -846,9 +843,9 @@ static int dax_preprocess_usr_ccbs(struct dax_ctx *ctx, int idx, int nelem)
 	return DAX_SUBMIT_OK;
 }
 
-static int dax_ccb_exec(struct dax_ctx *ctx, const char __user *buf,
-			size_t count, loff_t *ppos)
+static int dax_ccb_exec(struct dax_ctx *ctx, loff_t *ppos, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	unsigned long accepted_len, hv_rv;
 	int i, idx, nccbs, naccepted;
 
@@ -873,7 +870,7 @@ static int dax_ccb_exec(struct dax_ctx *ctx, const char __user *buf,
 	 * Copy CCBs into kernel buffer to prevent modification by the
 	 * user in between validation and submission.
 	 */
-	if (copy_from_user(ctx->ccb_buf, buf, count)) {
+	if (!copy_from_iter_full(ctx->ccb_buf, count, from)) {
 		dax_dbg("copyin of user CCB buffer failed");
 		ctx->result.exec.status = DAX_SUBMIT_ERR_CCB_ARR_MMU_MISS;
 		return 0;
-- 
2.43.0


