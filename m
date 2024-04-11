Return-Path: <linux-kernel+bounces-140995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A945D8A1A03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5962824A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4FE1C126D;
	Thu, 11 Apr 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2iiqG55b"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2C84E0C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849878; cv=none; b=lBbxn3ZcNpOrDmBSHa/XdTbF9e7DB4bGytTMifwSBM/MBVyLAnUBuLIJMZSY+5ol3NRNEVvz9L16VO9xRGEmHHE1mj132gvu0D5f0oqWzPbVVcEwQ7bpfRAAk42xaEzCnHIbjLM7UKJ8G3uPub5bjCInAm/rzQmP4cEuqzaa7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849878; c=relaxed/simple;
	bh=dKegfD9inuQjrfp8V5zNelclZEXv78SMco6P6shv3uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpI87EAqwFcdBvbxzWwSRZKRIt8XyGLYF8zBgzerHb1mie8Q/llO/fxeVrivW7lkVRkB4DqH8bds9rmgD9C/3NBrrMI3WNcyHzBynzBgfs9X1C2TJ1heRcAKGsq5iPfSfUlXPnSYIEAhcal7FH3sTc0ivuL0q0NQNsffWrz9foc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2iiqG55b; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a34b68277so113435ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849876; x=1713454676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw+QYykvlRHgH9Je+PZEWfmF+Zqn65SJAhuGyu3q7/0=;
        b=2iiqG55bBKXRyYrMZIiYjpvt+Hj7vNBfesFwbQxHCYzMKExIUPm2XY/F/WYhtY8vcD
         SgEh888IZnZoCEV4i1q9CCe5A7cIPOxOUYfFpSuRH+pS7ainGGfejnbn1ITHonkSqNcp
         2nG0DIqaVXb5QwGchGqdoFBzO7Lh1zwncJLvEhZscCb3hJ1RjlDw9mCXWisdt5tG7T8o
         ULGeMYXgcRBFJp5q2zUDbdzL1vl5CCYcpJTLSiQ+byqhsq6xhfmbv/guMZ7RQn235bp3
         WX0HGejstNMITuP7FdwPv4zoULudiqQv0O8HqQ62+M4Fa/xfr4gJNBSQpaXbg93N8DS3
         0MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849876; x=1713454676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xw+QYykvlRHgH9Je+PZEWfmF+Zqn65SJAhuGyu3q7/0=;
        b=QgcPHIZqRTt3AT+vp1TsTDttyq8QAq4tLblBeSGKBCaRsHQCNF1kuLPm0hg0J4oiZi
         cQYipurwPE+gjno16T3r03YKznUMARK7WqHd7wS1f1oKkTloKi6TyBZsHpISOf5hE5rU
         b9F/Y2+XcSRHIMjfTdS+NVw9fcxj29Pk7nsI37AUie1NTRMNpIyv5rQkZwnSER1H8dIC
         UOmZjJG6JakXfh2qe4xvfTIh3a5zGDE0uf6qntDOkjpApmbGlrtcC3NQL5IMyIC4eKhE
         ppRtYk8Dt2aQGBrUknIQG+Mxvu6+48bno1hILwY6BILwOwyMFgaFVqIinxsBoZ8Z3olw
         OrGA==
X-Gm-Message-State: AOJu0YwrOlB2C5spGYUdFDeHITj9oF6cZyE4P24fdl1M19u8ZyeSIxE2
	e3mtrhZ2sfyTmYgmH411gdKR2bJJkbkPkjAKcKOfsBJV0yZf661/oThe7P/c67Nu44F0r2plWxc
	T
X-Google-Smtp-Source: AGHT+IEHOoJy72rxpyg1edLQH4yXh7NVot/7LS01gHyKrcefNPzq4rE7DULR2F+phC4pmh28+DGK+w==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr192416iob.1.1712849875805;
        Thu, 11 Apr 2024 08:37:55 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 224/437] drivers/mailbox: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:04 -0600
Message-ID: <20240411153126.16201-225-axboe@kernel.dk>
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
 drivers/mailbox/bcm-pdc-mailbox.c |  9 ++++----
 drivers/mailbox/mailbox-test.c    | 37 ++++++++++++++-----------------
 2 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 1768d3d5aaa0..4fd840cd7193 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -420,8 +420,7 @@ static struct pdc_globals pdcg;
 /* top level debug FS directory for PDC driver */
 static struct dentry *debugfs_dir;
 
-static ssize_t pdc_debugfs_read(struct file *filp, char __user *ubuf,
-				size_t count, loff_t *offp)
+static ssize_t pdc_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct pdc_state *pdcs;
 	char *buf;
@@ -433,7 +432,7 @@ static ssize_t pdc_debugfs_read(struct file *filp, char __user *ubuf,
 	if (!buf)
 		return -ENOMEM;
 
-	pdcs = filp->private_data;
+	pdcs = iocb->ki_filp->private_data;
 	out_offset = 0;
 	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "SPU %u stats:\n", pdcs->pdc_idx);
@@ -469,7 +468,7 @@ static ssize_t pdc_debugfs_read(struct file *filp, char __user *ubuf,
 	if (out_offset > out_count)
 		out_offset = out_count;
 
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, out_offset, to);
 	kfree(buf);
 	return ret;
 }
@@ -477,7 +476,7 @@ static ssize_t pdc_debugfs_read(struct file *filp, char __user *ubuf,
 static const struct file_operations pdc_debugfs_stats = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = pdc_debugfs_read,
+	.read_iter = pdc_debugfs_read,
 };
 
 /**
diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 3386b4e72551..27176797770b 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -46,11 +46,10 @@ struct mbox_test_device {
 	struct dentry		*root_debugfs_dir;
 };
 
-static ssize_t mbox_test_signal_write(struct file *filp,
-				       const char __user *userbuf,
-				       size_t count, loff_t *ppos)
+static ssize_t mbox_test_signal_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mbox_test_device *tdev = filp->private_data;
+	struct mbox_test_device *tdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
 	if (!tdev->tx_channel) {
 		dev_err(tdev->dev, "Channel cannot do Tx\n");
@@ -71,7 +70,7 @@ static ssize_t mbox_test_signal_write(struct file *filp,
 			return -ENOMEM;
 	}
 
-	if (copy_from_user(tdev->signal, userbuf, count)) {
+	if (!copy_from_iter_full(tdev->signal, count, from)) {
 		kfree(tdev->signal);
 		tdev->signal = NULL;
 		return -EFAULT;
@@ -81,7 +80,7 @@ static ssize_t mbox_test_signal_write(struct file *filp,
 }
 
 static const struct file_operations mbox_test_signal_ops = {
-	.write	= mbox_test_signal_write,
+	.write_iter	= mbox_test_signal_write,
 	.open	= simple_open,
 	.llseek	= generic_file_llseek,
 };
@@ -93,11 +92,11 @@ static int mbox_test_message_fasync(int fd, struct file *filp, int on)
 	return fasync_helper(fd, filp, on, &tdev->async_queue);
 }
 
-static ssize_t mbox_test_message_write(struct file *filp,
-				       const char __user *userbuf,
-				       size_t count, loff_t *ppos)
+static ssize_t mbox_test_message_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
-	struct mbox_test_device *tdev = filp->private_data;
+	struct mbox_test_device *tdev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char *message;
 	void *data;
 	int ret;
@@ -121,7 +120,7 @@ static ssize_t mbox_test_message_write(struct file *filp,
 	mutex_lock(&tdev->mutex);
 
 	tdev->message = message;
-	ret = copy_from_user(tdev->message, userbuf, count);
+	ret = !copy_from_iter_full(tdev->message, count, from);
 	if (ret) {
 		ret = -EFAULT;
 		goto out;
@@ -168,10 +167,9 @@ static bool mbox_test_message_data_ready(struct mbox_test_device *tdev)
 	return data_ready;
 }
 
-static ssize_t mbox_test_message_read(struct file *filp, char __user *userbuf,
-				      size_t count, loff_t *ppos)
+static ssize_t mbox_test_message_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mbox_test_device *tdev = filp->private_data;
+	struct mbox_test_device *tdev = iocb->ki_filp->private_data;
 	unsigned long flags;
 	char *touser, *ptr;
 	int l = 0;
@@ -185,8 +183,7 @@ static ssize_t mbox_test_message_read(struct file *filp, char __user *userbuf,
 
 	if (!tdev->rx_channel) {
 		ret = snprintf(touser, 20, "<NO RX CAPABILITY>\n");
-		ret = simple_read_from_buffer(userbuf, count, ppos,
-					      touser, ret);
+		ret = simple_copy_to_iter(touser, &iocb->ki_pos, ret, to);
 		goto kfree_err;
 	}
 
@@ -198,7 +195,7 @@ static ssize_t mbox_test_message_read(struct file *filp, char __user *userbuf,
 		if (mbox_test_message_data_ready(tdev))
 			break;
 
-		if (filp->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto waitq_err;
 		}
@@ -231,7 +228,7 @@ static ssize_t mbox_test_message_read(struct file *filp, char __user *userbuf,
 
 	spin_unlock_irqrestore(&tdev->lock, flags);
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, touser, MBOX_HEXDUMP_MAX_LEN);
+	ret = simple_copy_to_iter(touser, &iocb->ki_pos, MBOX_HEXDUMP_MAX_LEN, to);
 waitq_err:
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tdev->waitq, &wait);
@@ -253,8 +250,8 @@ mbox_test_message_poll(struct file *filp, struct poll_table_struct *wait)
 }
 
 static const struct file_operations mbox_test_message_ops = {
-	.write	= mbox_test_message_write,
-	.read	= mbox_test_message_read,
+	.write_iter	= mbox_test_message_write,
+	.read_iter	= mbox_test_message_read,
 	.fasync	= mbox_test_message_fasync,
 	.poll	= mbox_test_message_poll,
 	.open	= simple_open,
-- 
2.43.0


