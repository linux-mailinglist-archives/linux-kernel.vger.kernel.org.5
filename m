Return-Path: <linux-kernel+bounces-140965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7848A19D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDED28787F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0461B9D90;
	Thu, 11 Apr 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zGSNUL5M"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045FB1B9056
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849831; cv=none; b=t5Nk07sm826p5z2GeI7TQuL55m7rgfr4OYGKeavLcHpI2ViiEpvZP5dSzDeLfXQr4lQveMNkhNpQdT/k6sMv1wPtDmfXwjmWZgSABpynHbRtaa6UJufXaGkTWv8migY56OrJ0T0oAWppJNjttdjT1hlWCNFdgAEMhI6S5GSdsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849831; c=relaxed/simple;
	bh=Uk4/86u1sZgKhsnKac3qE3uZAA6Tz/ktGLA/Cdn3h5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiQ4F5SYQ8lBe9c+2o+jWYZRGiKqm36g6RGbyUzPfxjn223k2LS26KS1YDssdug7YW8AwC0V1GQyZ3+a5t6n835RXvXPgAjCxU0h6/t95KFnSYnygtYwOnZmke8YNawcnYI5bIW+QEq2Pjg6nzJdkI3Sfd18Hj12HDkOS03R8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zGSNUL5M; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170536239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849828; x=1713454628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNykTdc7WZM+SzzuWbUSY8jvBIjU+7Q2NKSdoeCiC58=;
        b=zGSNUL5MieZMAbKtjeuL3ZODUqwZn/P8BYBFP3hia1Iv8TetDdhIq2TCHxRJ4gzEhV
         3VVQlW/22e6g5wHDNw+qocJU9FX/4gc4stP1TmhOPOMzM4kWNgev5UQ8yq5XtUmD473w
         DIoUdKQBop1FeUFetVczFMYmafl04ffqph4cRsNncB6T6uI3S8I3lqt54EXWSePpkEvu
         /Pgp9bkG4tJt7M7iMcF3qMky2pUNQHHyT40Ujm3V4fjJqql66Xjvw11ryQRasALImfU/
         Oj2slSOPRd+2wj+SvgBbf1SGX1x+J3NQLUV8IctPQW6QJNjWoVH/4fcvXkP0EiIRYL/H
         9lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849828; x=1713454628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNykTdc7WZM+SzzuWbUSY8jvBIjU+7Q2NKSdoeCiC58=;
        b=OEa7v/3nV9LuSokjvmRkKB3q1cWS5Du+mWs4GRuLTfHufvoTTMZgLBvMm2I46k9f6t
         UoGZU/AqNL1D2+U/6ZSDHdMqLEbOMDmc75JmC7AyP8CNHnsxM8Xsl6bH0H0XcJ++/QYi
         xFQZaAKJ+JB9Y4C4IlNrqMsXjw8V4xaB8OGW7Ddv62QjW3DpIv1zLCcqyw3RlOiYihG5
         eMULstIjSPoYJvUvIUVwwaalrMLRawZQeEVkvrxKeh2nTHmZUa7Xh/t9BMhVw8qDCKk3
         66FRan67MPHUOjSQQXz4YTNNrz9mZLuU3ELJ/fYLKckEYTDPweDgqDg8ggVA0h+XMmVn
         1Qxw==
X-Gm-Message-State: AOJu0YxII7IhNKCn31Ea1qQoXRNmkwomFGKcwncXKbxFOpIhSVgfZkx0
	PcEHyV/1XpQ21LzsiRBTYOhFSbCQQBSgGSJYtmwhHoL0iritC9JEcOoGhVBXkvcAQjxwC+UFUFO
	r
X-Google-Smtp-Source: AGHT+IGS251v9Pgq8R4wYhXyf84XOvrPXCbac6DUOzrSkdm2I1gAQZUkKxVYmjsLS6uM/ybcf1M6zg==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr224337ioh.0.1712849828107;
        Thu, 11 Apr 2024 08:37:08 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 196/437] scsi: cxlflash: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:36 -0600
Message-ID: <20240411153126.16201-197-axboe@kernel.dk>
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
 drivers/scsi/cxlflash/ocxl_hw.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 6542818e595a..40fef6f919db 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -1010,10 +1010,9 @@ static unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
  *
  * Return: size of the data read on success, -errno on failure
  */
-static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
-			loff_t *off)
+static ssize_t afu_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ocxlflash_context *ctx = file->private_data;
+	struct ocxlflash_context *ctx = iocb->ki_filp->private_data;
 	struct device *dev = ctx->hw_afu->dev;
 	struct cxl_event event;
 	ulong lock_flags;
@@ -1022,9 +1021,9 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 	int bit;
 	DEFINE_WAIT(event_wait);
 
-	if (*off != 0) {
+	if (iocb->ki_pos != 0) {
 		dev_err(dev, "%s: Non-zero offset not supported, off=%lld\n",
-			__func__, *off);
+			__func__, iocb->ki_pos);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -1037,7 +1036,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 		if (ctx_event_pending(ctx) || (ctx->state == CLOSED))
 			break;
 
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			dev_err(dev, "%s: File cannot be blocked on I/O\n",
 				__func__);
 			rc = -EAGAIN;
@@ -1081,7 +1080,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 
 	spin_unlock_irqrestore(&ctx->slock, lock_flags);
 
-	if (copy_to_user(buf, &event, event.header.size)) {
+	if (!copy_to_iter_full(&event, event.header.size, to)) {
 		dev_err(dev, "%s: copy_to_user failed\n", __func__);
 		rc = -EFAULT;
 		goto out;
@@ -1176,7 +1175,7 @@ static int afu_mmap(struct file *file, struct vm_area_struct *vma)
 static const struct file_operations ocxl_afu_fops = {
 	.owner		= THIS_MODULE,
 	.poll		= afu_poll,
-	.read		= afu_read,
+	.read_iter	= afu_read,
 	.release	= afu_release,
 	.mmap		= afu_mmap,
 };
@@ -1224,7 +1223,7 @@ static struct file *ocxlflash_get_fd(void *ctx_cookie,
 	/* Patch the file ops that are not defined */
 	if (fops) {
 		PATCH_FOPS(poll);
-		PATCH_FOPS(read);
+		PATCH_FOPS(read_iter);
 		PATCH_FOPS(release);
 		PATCH_FOPS(mmap);
 	} else /* Use default ops */
-- 
2.43.0


