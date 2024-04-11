Return-Path: <linux-kernel+bounces-140812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C603D8A1910
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FF01F219C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA87A224D8;
	Thu, 11 Apr 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CoyOtEg3"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB0762C9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849594; cv=none; b=SmXGxDmeHbvL7DzneL26GvbugfKU3Dmfk38AP8xjho2ZHYOhWl5sa6HfWxNyRLXOYmkZqDYYJRhy2gH1HyUyoS06KYEv38hkSoDSuMWSmnD+okz7NcnYvHUw6gdGcUPJS3wRo9fQZTo04bKMP5h3SNPFRTGIBxLdebFu218JM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849594; c=relaxed/simple;
	bh=Y7yxPNMsHeeEN7x7zk15KFsI8XPx8XUqJo6bdqm38Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7rbOm2kYiRKSWBHZ3cdYmonINZpP9wJ1TgZ0k+duALi6oa4gKsT93lchOFYWkUQKHjxAnA10aGmqPXtEkHny0KnfLonqvPochvh60ZYCa3igG1Uwuz0aQzsXk5mih+MLNSCRoVMGJjF6UlMbZIlzTm3k3UcSeejlHVkl0KBbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CoyOtEg3; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69510239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849591; x=1713454391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZc4928Cn1er2j7QruCFdaei2Tt3S7FPwfD/sFuj1EE=;
        b=CoyOtEg3GfOJElkWHOAz1PUKG4HapgcLfAAjmiGr9zF+8/Q4zMzS5fWzoSOxCVmihu
         ddiqBbyQUYrrDWBuCrO7liSDQ4D5+X2hbBhDnfKIjGwIgDu8dkVgbr+tc7tiknkhHjqV
         T47QmM0deVQ/ypCiLgFV+wnI5zUbytNaZBwzFJgj+E+U444ESClTjaAaaNhnDFpLI9rv
         dL6uILeH77nQncd/HteTy93sCDG0PCQd4VlyJE5svXg1PZn1s7/w9QoqHfMlOWJ3r+xZ
         f0blZtHL7+qxRjp3UmBh99kayG5lzBnoKX9cm7tyvfZdACLwSgJZPuP8+iam2NeCahK5
         tEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849591; x=1713454391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZc4928Cn1er2j7QruCFdaei2Tt3S7FPwfD/sFuj1EE=;
        b=omPQVaJZktIsduxwahh9gRfJHZrmwXV3tsTg7JBQjOsvBZB3F8sk5mvQCTlu4WqdeT
         Ifcf+uWse9ScAflBvmsxhZFdYHUbaucJPpMp6OJngBnwyph2xltd9r+Oid/3bdjfcZST
         3obhwPOHsfacFDvQ9ab1aHl4g8zPi/N6yKucy31i1Iyy5UXwOj8SD6+akWOcoPfqeSJt
         JJOwSJUhTuO2NKXUptDks2ZKy7tZl8usNGkw1B6GaJJXEDxp5j5BEJ1z0dCNZGXttYdQ
         E0RHt9AJSVms6/XN1lWaiW/aSDYFiA8Mnq7t/1anCO1vdKCsdSnp0qPu3WMN9mwDNTGX
         AUDg==
X-Gm-Message-State: AOJu0Yxh+LUChExh/L3zSYo+kAv5luca/bo3FdHmvTe5EfKtdBE6OyAd
	XXeZoMaAsI/u2TuV28lvIZeTp0H0QO7lP2z5zQCAWTEA4SBx0LEoASQpl+Lyd14pkTQ2RS9r8N3
	Q
X-Google-Smtp-Source: AGHT+IFWz2/WPLla8ZQB3YzCzEKLaUjG1wN4SJIOEp3HKhZn/MkCWpXOMF4ZSx7JVeVPN4dtUjR6dQ==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr186333iop.1.1712849591426;
        Thu, 11 Apr 2024 08:33:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 053/437] net: 6lowpan: convert debugfs to read/write iterators
Date: Thu, 11 Apr 2024 09:13:13 -0600
Message-ID: <20240411153126.16201-54-axboe@kernel.dk>
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
 net/6lowpan/debugfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 600b9563bfc5..0ec0da78c39c 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -120,20 +120,18 @@ static int lowpan_ctx_pfx_open(struct inode *inode, struct file *file)
 	return single_open(file, lowpan_ctx_pfx_show, inode->i_private);
 }
 
-static ssize_t lowpan_ctx_pfx_write(struct file *fp,
-				    const char __user *user_buf, size_t count,
-				    loff_t *ppos)
+static ssize_t lowpan_ctx_pfx_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char buf[128] = {};
-	struct seq_file *file = fp->private_data;
+	struct seq_file *file = iocb->ki_filp->private_data;
 	struct lowpan_iphc_ctx *ctx = file->private;
 	struct lowpan_iphc_ctx_table *t =
 		container_of(ctx, struct lowpan_iphc_ctx_table, table[ctx->id]);
+	size_t count = iov_iter_count(from);
 	int status = count, n, i;
 	unsigned int addr[8];
 
-	if (copy_from_user(&buf, user_buf, min_t(size_t, sizeof(buf) - 1,
-						 count))) {
+	if (!copy_from_iter_full(&buf, count, from)) {
 		status = -EFAULT;
 		goto out;
 	}
@@ -157,8 +155,8 @@ static ssize_t lowpan_ctx_pfx_write(struct file *fp,
 
 static const struct file_operations lowpan_ctx_pfx_fops = {
 	.open		= lowpan_ctx_pfx_open,
-	.read		= seq_read,
-	.write		= lowpan_ctx_pfx_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= lowpan_ctx_pfx_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


