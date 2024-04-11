Return-Path: <linux-kernel+bounces-141181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A178A1ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995491F221F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6A1F9600;
	Thu, 11 Apr 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lb+Gc39g"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE21F8C8B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850170; cv=none; b=Aw4iCk4DXRbFWJHJ5qTpOpH/UIwpFQOuqHVok0W4Hdhtig8Fj3tt3UIrU6vu1ThCJhQ887B60A2ce3p6LdKaCKJ/B5ZhFBlIHwMEinpIgT043kBQLtJGjqFgGrpSF7qbhcaoDD2m9RI2btnIvtYPSZluyesnvY4kI98mli9SUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850170; c=relaxed/simple;
	bh=J3HK+5lJfSKCKc0lDEk1efpE8AfVOn7JExlKKuiGZL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKXpuJonW9XhQ3O7lD0tvosSPaxavt/6MAkfA9RL/FMg/hjcVxsEqFwny2tg/BfUYNJlDdDxerm6uI1r8AlZhkXeIHa3a5iefNagzpV1Zta5+CHtpcJZayx7d7CpEpmKJqnHs+tDPhiM02NAHOn2dECGPSihsAUnR//nji/e+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lb+Gc39g; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69692739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850168; x=1713454968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0pjSwlST/pb+6otTxlVrZ7C6+JrJhQPui1daNpu1XY=;
        b=lb+Gc39g0c2ecrwWzgO1jnidWSa7gIJH49NXDbcK9W2UbnWr/z9ubOCyWOEjCPeWCW
         7WWaoLkg4LT5SCP5sv5Fe2W2NhfBVv7RRYamcDWP7k2Rs2CAqNziEYdrYdT+Oy8KjUYa
         +HMTcIdq57bDrqlg88k8un+GGY53XgWnmQCz1xNWdU/MNoBCHEIZK4CUAY3h3jQbGFrC
         hfOjZmfNAKcW4MLCbNua3zTS2PnULMJUWO2k7tXdBZBlMx44GOtaohldwL0ei/A5owkZ
         J9y/TgIXxe8wNd2MJYpH/LaGybhh2uQicU4GLVUbEPSTlGSNjdEH0ug8qT3dUs97GqXT
         FWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850168; x=1713454968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0pjSwlST/pb+6otTxlVrZ7C6+JrJhQPui1daNpu1XY=;
        b=PoIQNuDdjoXx+wrsuIXIioafnD3LtLEe3ELY96T1pPx2ZHhixS12ZDPD6HF4B0zeUi
         +TXRJcnC/dvih66cBluKeZ8ZJd9t5EbSEiliQYAg+RNmYoGNA7Ch3z++dsr/tG6pdCK5
         cFOzoCbaQ/z2CsXIcZ8+QQaazge8dXdh0S0ewI6jQPtA8RPNSsz5vKA6UOKmeGuCYD3E
         MOHD77a8c/SMlX8Ymy1UI6Jbg4+wW8NmkraPgWVPS3Kvrre8B6CpeFIJhM5/UUkMy3HM
         9509D3PANi3mCQNfxq9ot6RLELvRyMS7TbxscEAuMXJYheHOCsAY2MLgrcoEgbdbnYll
         m7JQ==
X-Gm-Message-State: AOJu0YzVBuBSoCKhbc9pX2ctv44f5jfwteXXdidf2jPzoiCp/CMHTUwt
	a777b9JLDBFITS5GHFcbNhgXBVUKf/SKDJBs4ZJKoc28cHElosyJV9nbIcF3/thpSYfUy02iJWN
	e
X-Google-Smtp-Source: AGHT+IEiUhZCeulYQWpPxHfOxMDjPka8vG0Xbe/n90W2JKD1IeNZ88ljkzpqJKHivDBhNLzEdtnigw==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr237775iof.0.1712850168043;
        Thu, 11 Apr 2024 08:42:48 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 398/437] macintosh: smu: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:58 -0600
Message-ID: <20240411153126.16201-399-axboe@kernel.dk>
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
 drivers/macintosh/smu.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index b2b78a53e532..c66fcb746123 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -1111,17 +1111,17 @@ static void smu_user_cmd_done(struct smu_cmd *cmd, void *misc)
 }
 
 
-static ssize_t smu_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t smu_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct smu_private *pp = file->private_data;
+	struct smu_private *pp = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	unsigned long flags;
 	struct smu_user_cmd_hdr hdr;
 	int rc = 0;
 
 	if (pp->busy)
 		return -EBUSY;
-	else if (copy_from_user(&hdr, buf, sizeof(hdr)))
+	else if (!copy_from_iter_full(&hdr, sizeof(hdr), from))
 		return -EFAULT;
 	else if (hdr.cmdtype == SMU_CMDTYPE_WANTS_EVENTS) {
 		pp->mode = smu_file_events;
@@ -1150,7 +1150,7 @@ static ssize_t smu_write(struct file *file, const char __user *buf,
 	pp->cmd.status = 1;
 	spin_unlock_irqrestore(&pp->lock, flags);
 
-	if (copy_from_user(pp->buffer, buf + sizeof(hdr), hdr.data_len)) {
+	if (!copy_from_iter_full(pp->buffer, hdr.data_len, from)) {
 		pp->busy = 0;
 		return -EFAULT;
 	}
@@ -1168,10 +1168,10 @@ static ssize_t smu_write(struct file *file, const char __user *buf,
 	return count;
 }
 
-
-static ssize_t smu_read_command(struct file *file, struct smu_private *pp,
-				char __user *buf, size_t count)
+static ssize_t smu_read_command(struct smu_private *pp, struct kiocb *iocb,
+				struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	DECLARE_WAITQUEUE(wait, current);
 	struct smu_user_reply_hdr hdr;
 	unsigned long flags;
@@ -1183,7 +1183,7 @@ static ssize_t smu_read_command(struct file *file, struct smu_private *pp,
 		return -EOVERFLOW;
 	spin_lock_irqsave(&pp->lock, flags);
 	if (pp->cmd.status == 1) {
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			spin_unlock_irqrestore(&pp->lock, flags);
 			return -EAGAIN;
 		}
@@ -1214,35 +1214,31 @@ static ssize_t smu_read_command(struct file *file, struct smu_private *pp,
 	rc = size;
 	hdr.status = pp->cmd.status;
 	hdr.reply_len = pp->cmd.reply_len;
-	if (copy_to_user(buf, &hdr, sizeof(hdr)))
+	if (!copy_to_iter_full(&hdr, sizeof(hdr), to))
 		return -EFAULT;
 	size -= sizeof(hdr);
-	if (size && copy_to_user(buf + sizeof(hdr), pp->buffer, size))
+	if (size && !copy_to_iter_full(pp->buffer, size, to))
 		return -EFAULT;
 	pp->busy = 0;
 
 	return rc;
 }
 
-
-static ssize_t smu_read_events(struct file *file, struct smu_private *pp,
-			       char __user *buf, size_t count)
+static ssize_t smu_read_events(void)
 {
 	/* Not implemented */
 	msleep_interruptible(1000);
 	return 0;
 }
 
-
-static ssize_t smu_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t smu_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct smu_private *pp = file->private_data;
+	struct smu_private *pp = iocb->ki_filp->private_data;
 
 	if (pp->mode == smu_file_commands)
-		return smu_read_command(file, pp, buf, count);
+		return smu_read_command(pp, iocb, to);
 	if (pp->mode == smu_file_events)
-		return smu_read_events(file, pp, buf, count);
+		return smu_read_events();
 
 	return -EBADFD;
 }
@@ -1315,8 +1311,8 @@ static int smu_release(struct inode *inode, struct file *file)
 
 static const struct file_operations smu_device_fops = {
 	.llseek		= no_llseek,
-	.read		= smu_read,
-	.write		= smu_write,
+	.read_iter	= smu_read,
+	.write_iter	= smu_write,
 	.poll		= smu_fpoll,
 	.open		= smu_open,
 	.release	= smu_release,
-- 
2.43.0


