Return-Path: <linux-kernel+bounces-141189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86198A1AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364761F2200F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54F1FB065;
	Thu, 11 Apr 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2iBwLfWR"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA31FA5D1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850182; cv=none; b=Cx3tm/5B+5J2HCT1QfUGFsrpRJk9D5KxP60vUUk9kBZzBI4JUL5s55hXBU4Zy1SE6+7d3/Vau4SSoMOB+5qul3p5t6tvWqgfa8xDocvHSJDicEJHXZbSWUmi4dkX1Ha+xKaSc68u18FU9r4g1JFvaiBsr+UMQJ6wTmG/U4uAIeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850182; c=relaxed/simple;
	bh=/PHVbYRe7ULJUe0a7DqCc3HFS1XHgYfx9hgpPJNT4s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An6C8++x7QQVmtpNDTgBDwsMA21YCjm5avAdSA2r9IxMvzq1CgKPyGNimGsDS8NOHDyX/E4a8y6IhHjnVSmAPUCCqtjy5bvOro99c1HU4/rGhiT0ZFumcJciNVHPQB2UaG//eGtVJMhKn/T/v6V7MY/AVbDFbDya3RIwMKJeq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2iBwLfWR; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58276939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850180; x=1713454980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxnU8WvBkTK5Q8G8trncRTnTHAOpohq3pTRi4Clg2tg=;
        b=2iBwLfWRh+gPEZutGlF8tZ2hxlzzPwMcEXaSYi9k6RMNwym5BMfDJGSTSUjGQSEkP7
         aZafIGKOxs/KLlHopXIOdLxuuhDG2GOnLLavML5fF1j2IcE2ZTox4demMNurvzsodzC7
         uWq8UUnmaqHzxRFiLj4sxCNjp0ELMO/bqoLwGlNpZHOZt8c1gHrlxFqm2fAdocwp3o+Y
         aLpKZn7EMEgAGu03tNocXhhtUNYpsPdLozcmBh8s9GxMm68KLpHDr3M2meClfV/BZiB5
         P4nd9uWqhh1QR53P8t6Ovx1GS4ssJa556jG9y8RH9tBokRb3eCYcxkevyaBOKo9W1oqR
         /ymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850180; x=1713454980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxnU8WvBkTK5Q8G8trncRTnTHAOpohq3pTRi4Clg2tg=;
        b=C90mK7D/QlMMy44Ctkz+Txu5JzgMTmPolJmRtH2pCU/kLLawXgJxnHpzeS5gy44njW
         n1Qqv5gZqUm6hhy2JbLbYzLxdrIt3BDn1cNlCoZ2HUXmrjwxDR2cr5qi2DpnYDFfn0bv
         hrm5A0kmB8jmsIKUsrMyBpenc/PQped3cbwCFzF6GaZgAEcRbPrYg/TtDJqWWQJYMh7w
         i1G65ClM4xL1hjCX6ov6EdMwYa1jp9E+HQtUOvc7gEgdatBfQ8a5yPVZs5kpg2IZoCMR
         cJCuHnB2qY0iRNzow/Tx5Pnw/BJDMXdFuEGRkXB4fdYW7jnp9hDHnpH5ngk7ddsC0C14
         5h1Q==
X-Gm-Message-State: AOJu0YzIIVqEZlYS9uY5lMI91I1J9IDBHKWI0siVoFqU4aINsGFynWbb
	VkOJo2JcbLsZU1Z1Amqp9ZkJejQxH5dslp/Qm9N66avjWlwu+R+UAD2hHaO1SAj4XIoJereEApJ
	3
X-Google-Smtp-Source: AGHT+IH4y+66PGwYj2jvwy/olMzPZqI+GVYDVLWkmihu+/8UmpEjE2l6PymSN0+AWkVK9BIOUtnIsA==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr205785iov.2.1712850179986;
        Thu, 11 Apr 2024 08:42:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 405/437] infiniband/cxgb4: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:05 -0600
Message-ID: <20240411153126.16201-406-axboe@kernel.dk>
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
 drivers/infiniband/hw/cxgb4/device.c | 35 +++++++++++++---------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 80970a1738f8..7067ecc4f9e6 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -81,12 +81,11 @@ struct c4iw_debugfs_data {
 	int pos;
 };
 
-static ssize_t debugfs_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
+static ssize_t debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct c4iw_debugfs_data *d = file->private_data;
+	struct c4iw_debugfs_data *d = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(buf, count, ppos, d->buf, d->pos);
+	return simple_copy_to_iter(d->buf, &iocb->ki_pos, d->pos, to);
 }
 
 void c4iw_log_wr_stats(struct t4_wq *wq, struct t4_cqe *cqe)
@@ -175,25 +174,24 @@ static int wr_log_open(struct inode *inode, struct file *file)
 	return single_open(file, wr_log_show, inode->i_private);
 }
 
-static ssize_t wr_log_clear(struct file *file, const char __user *buf,
-			    size_t count, loff_t *pos)
+static ssize_t wr_log_clear(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct c4iw_dev *dev = ((struct seq_file *)file->private_data)->private;
+	struct c4iw_dev *dev = ((struct seq_file *)iocb->ki_filp->private_data)->private;
 	int i;
 
 	if (dev->rdev.wr_log)
 		for (i = 0; i < dev->rdev.wr_log_size; i++)
 			dev->rdev.wr_log[i].valid = 0;
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations wr_log_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = wr_log_open,
 	.release = single_release,
-	.read    = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek  = seq_lseek,
-	.write   = wr_log_clear,
+	.write_iter = wr_log_clear,
 };
 
 static struct sockaddr_in zero_sin = {
@@ -365,7 +363,7 @@ static const struct file_operations qp_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = qp_open,
 	.release = qp_release,
-	.read    = debugfs_read,
+	.read_iter = debugfs_read,
 	.llseek  = default_llseek,
 };
 
@@ -460,7 +458,7 @@ static const struct file_operations stag_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = stag_open,
 	.release = stag_release,
-	.read    = debugfs_read,
+	.read_iter = debugfs_read,
 	.llseek  = default_llseek,
 };
 
@@ -515,10 +513,9 @@ static int stats_open(struct inode *inode, struct file *file)
 	return single_open(file, stats_show, inode->i_private);
 }
 
-static ssize_t stats_clear(struct file *file, const char __user *buf,
-		size_t count, loff_t *pos)
+static ssize_t stats_clear(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct c4iw_dev *dev = ((struct seq_file *)file->private_data)->private;
+	struct c4iw_dev *dev = ((struct seq_file *)iocb->ki_filp->private_data)->private;
 
 	mutex_lock(&dev->rdev.stats.lock);
 	dev->rdev.stats.pd.max = 0;
@@ -543,16 +540,16 @@ static ssize_t stats_clear(struct file *file, const char __user *buf,
 	dev->rdev.stats.act_ofld_conn_fails = 0;
 	dev->rdev.stats.pas_ofld_conn_fails = 0;
 	mutex_unlock(&dev->rdev.stats.lock);
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations stats_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = stats_open,
 	.release = single_release,
-	.read    = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek  = seq_lseek,
-	.write   = stats_clear,
+	.write_iter = stats_clear,
 };
 
 static int dump_ep(struct c4iw_ep *ep, struct c4iw_debugfs_data *epd)
@@ -722,7 +719,7 @@ static const struct file_operations ep_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = ep_open,
 	.release = ep_release,
-	.read    = debugfs_read,
+	.read_iter = debugfs_read,
 };
 
 static void setup_debugfs(struct c4iw_dev *devp)
-- 
2.43.0


