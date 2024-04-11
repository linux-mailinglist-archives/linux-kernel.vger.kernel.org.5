Return-Path: <linux-kernel+bounces-141096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2FD8A1A78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399492843D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A41F4A99C;
	Thu, 11 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kahhtQu0"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39EE50289
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850029; cv=none; b=orEw0H5cD4+EChJxzH1sCE/ppwo5Cf+5eEt6Gnqnqz0TK4K4BM+8aupKUMji2+04Mjk6Iq64GqTadMY1st7AkRWiTflHJ3eRss7vv6BLH/L7/waBkfp21OV4B49dCPY6PDi+ihqaO8f3nQQeUPktQxkMelwurBOArFyqy7r/q+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850029; c=relaxed/simple;
	bh=6GJX4jKcYnrQLhec09SPyB6dU9bM6RG9CFsRPlVxKc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBCU0Z0yAZRJnF6TwITN4zMW1y/lqx0gZ4his42JF0WWFLC+wZcZNRVkbQ9lSZUMdOPT8G1Ih+vKVHWn+GIjQPqa3s20yWk7985RV5UEBssyHk5wTC4hnvlpRP3X4Kb92NNc7GoBzQsWg8R6dfjWLq1RqeoS/NZKxtRDIQcQLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kahhtQu0; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9880339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850027; x=1713454827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qQP9837GS2jmEGGqO0pdJTQlW11xMsPELKOTlY0Grs=;
        b=kahhtQu0vk2hqQl1ZnlvJfAfGjX4fu34W994pmHdOvOs34kQKFbZWXP5Tsm8GCOIxu
         6ga4un5/04zi9XFdki0viFND+DFhYh3MZtNsnjngJUHUslaM8vkvxgaPcHkk1EBcH/Jw
         tXxET0mVvShiYOwfrQzyeilvQBOZkcwOq3XgE81hs8mRb//PFZnRmZzYi9GRihB3MsDC
         J6wr/BYiftYjbGOrgVsiyC3Jp+0soCmhU8xoaX0Y1QqCs+O11AX3qPVUfhz8ZRabla2v
         ORrO9037/JmzR0qjpNGl0M8LPObW0udndvc7ivJA9RKt5roTdbwxZNV9uRPmJz9XchEh
         1saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850027; x=1713454827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qQP9837GS2jmEGGqO0pdJTQlW11xMsPELKOTlY0Grs=;
        b=mLgYEeuHPCuYTk4rEDCbbVbBDNHiY4GLrC4/PWm7QjuaKKDOphuzmKUqGl1Xmx6avl
         FEYFuBbvhtzhlXdcVjLbP3OlgISFD3EPmDoLmBEWn7YBUH2zBXsg4IZQdSeBsNkFLMa8
         ud0/KxrsN+VJveWfCs9N4CJNFb4b+m0CgKQcj1iYr1PkbW5UtYdm4T64BJ2cWHslYwnR
         hXSdUSEaGN6HdorvPsUKLqIkLFFeUXrDEhSglZw9TDLIsSh0BgBiYGLcObbJuYnUo4kd
         k+qVXmX7ZLhj/5lx0UiqfXUYAhsNQBGvRkxWFNVmsULvM12hzt3xHyLFKKOPx8tIaZWc
         nO2g==
X-Gm-Message-State: AOJu0Ywt8IvN/RePcz5NEoCyfZHK9KbUfobxv7gkCSHsc6pq3cMKTDgj
	w5IkIRtLfjjUwvmNFJPm55rnHP/MkEfju6+7Sm9bhrBlyhBYmROQcENQebJgIyOM4dfccvkYoOK
	3
X-Google-Smtp-Source: AGHT+IE8Hy5vhJBE8OWwsWPTl/cqUj4Nxp6caI7Egwq5pEX341Jp99sT9Q3cTanIyPys45YXPjEjig==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr204204iop.1.1712850026932;
        Thu, 11 Apr 2024 08:40:26 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 318/437] drivers/net/xen-netback: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:38 -0600
Message-ID: <20240411153126.16201-319-axboe@kernel.dk>
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
 drivers/net/xen-netback/xenbus.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index a78a25b87240..5f2ef4d6bb17 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -102,26 +102,21 @@ static int xenvif_read_io_ring(struct seq_file *m, void *v)
 #define XENVIF_KICK_STR "kick"
 #define BUFFER_SIZE     32
 
-static ssize_t
-xenvif_write_io_ring(struct file *filp, const char __user *buf, size_t count,
-		     loff_t *ppos)
+static ssize_t xenvif_write_io_ring(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct xenvif_queue *queue =
-		((struct seq_file *)filp->private_data)->private;
+		((struct seq_file *)iocb->ki_filp->private_data)->private;
+	size_t count = iov_iter_count(from);
 	int len;
 	char write[BUFFER_SIZE];
 
 	/* don't allow partial writes and check the length */
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 	if (count >= sizeof(write))
 		return -ENOSPC;
 
-	len = simple_write_to_buffer(write,
-				     sizeof(write) - 1,
-				     ppos,
-				     buf,
-				     count);
+	len = simple_copy_from_iter(write, &iocb->ki_pos, sizeof(write) - 1, from);
 	if (len < 0)
 		return len;
 
@@ -152,10 +147,10 @@ static int xenvif_io_ring_open(struct inode *inode, struct file *filp)
 static const struct file_operations xenvif_dbg_io_ring_ops_fops = {
 	.owner = THIS_MODULE,
 	.open = xenvif_io_ring_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = xenvif_write_io_ring,
+	.write_iter = xenvif_write_io_ring,
 };
 
 static int xenvif_ctrl_show(struct seq_file *m, void *v)
-- 
2.43.0


