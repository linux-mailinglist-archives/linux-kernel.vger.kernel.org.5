Return-Path: <linux-kernel+bounces-140837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 663508A1940
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9B4B259FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C379130E47;
	Thu, 11 Apr 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JGSGDOyW"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379B1304AB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849633; cv=none; b=un/AS00niKyR0/09qPJDYsITDPg8mqqaX/CK7z6ErFLH0Ow4wV+sCxJMVy8zPMYFfRBweWmO5y9CVmhUye+yWhzzFdAF89+UqRwsoWKHU7BeRMX33k593B7sPfp8xtwDxj0sBgAZujwjDNMduQwXyDukjwmsBQyCqrqgYx85xOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849633; c=relaxed/simple;
	bh=Cbl6SuG6VXstprKz7lY7zYC7sNNSA7NadduTO0RsMDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2AvJVkOxIXlricy6SgDz3shzDNLjKqywieCEkHOxJkRsOTMdrOprWJd0jMm0NUDSA/iKthBMjoBujtVoJ/kRcYC+9Y01IA2ipKE1i+xlYPb4aMPTuTFyQACJx0T7NrehsN57smOyAQpQZQ4l9BrDFO98MA9tQdTvTPLYh/MtZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JGSGDOyW; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58000239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849631; x=1713454431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDtnQXRZeSewjVOftnOwVESefv8KfxTozh1XXf4q1XQ=;
        b=JGSGDOyWMtKx5vs+Z+7tw1ndRzhWfRCTpuP4TLBn7pdkMH2W5lbBKDAcQPd3ljOvwe
         NSBOf7fK8Im8pzQZI39mqnipWRaH/1qWJeWWq37DBLWXWaivEkydSPWJHB7865pMUY/G
         DlYOl4op8iizjr9suxyU2PHS5zW0z7x1UkkGpbUm1EsZaI+waDTls8rXLplQz02cdFYv
         wUaSbMUoHeNElPhzWo/urMYgi/3kxBs00EzeIB5dLmbNg1ei+4TLDbvSWaRVpY7tsDGf
         AioTjUreM+xR33Rx9gvA6kih9dRiWhN0lWkwwftdTburJtCKAVO39kwyK+VofHq3Pnf0
         Ub6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849631; x=1713454431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDtnQXRZeSewjVOftnOwVESefv8KfxTozh1XXf4q1XQ=;
        b=TaC0t1MTY21nEaHac+ZfhfBpp1xs+fUO5UDuSdiLZU+ZaH0lCgYQJ+FdCu1GFzkR67
         jsoiSuXHZbmw03qhSo7fillXRrMh5ADxa99DmG8FULyKjj2DtEpVKwaNo/LmUfbafD0X
         wgRJFnwjHu6wNUApwUaZvBKRquLVcRXptOu1a78CJ7wktSypLg63EXDUgXZBcU/MLH0R
         1gk20DZxDjX15TBzdd5Ob1EtSx3D7Ar5Tzk5Dfxk5GBFdJpkhIwirov1gsAJ+hk8Zteb
         kOTwi3SZ45pRIw7Jt+yRtQtfSy2Fj9PxzSUjdOtlDO0svvwnKAp6XDdC67JxBUBl12g0
         AAGA==
X-Gm-Message-State: AOJu0YyoP1AWNfmSTFVo4fC7x59jDTrFTNwuG/A5EUL1ssZZriyjSXF+
	0H0mGvYzsKcju7TBIRXEAnuBTOkLlfhMr9/1uqs1+EoRVnTWt9CasQs2XS5Wk3g/BOOojjSK4VI
	f
X-Google-Smtp-Source: AGHT+IEDFyRB474jWVqI0kY3jMqptX7/xPpobGuhync8skNj40tl8NgOOnuSVnwBeb2XgvMQKNOldQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr176221iov.2.1712849631343;
        Thu, 11 Apr 2024 08:33:51 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 076/437] printk: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:36 -0600
Message-ID: <20240411153126.16201-77-axboe@kernel.dk>
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
 kernel/printk/printk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index adf99c05adca..a383f92915e3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -787,11 +787,11 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 
-static ssize_t devkmsg_read(struct file *file, char __user *buf,
-			    size_t count, loff_t *ppos)
+static ssize_t devkmsg_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct devkmsg_user *user = file->private_data;
+	struct devkmsg_user *user = iocb->ki_filp->private_data;
 	char *outbuf = &user->pbufs.outbuf[0];
+	size_t count = iov_iter_count(to);
 	struct printk_message pmsg = {
 		.pbufs = &user->pbufs,
 	};
@@ -802,7 +802,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		return ret;
 
 	if (!printk_get_next_message(&pmsg, atomic64_read(&user->seq), true, false)) {
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto out;
 		}
@@ -838,7 +838,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		goto out;
 	}
 
-	if (copy_to_user(buf, outbuf, pmsg.outbuf_len)) {
+	if (!copy_to_iter_full(outbuf, pmsg.outbuf_len, to)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -950,7 +950,7 @@ static int devkmsg_release(struct inode *inode, struct file *file)
 
 const struct file_operations kmsg_fops = {
 	.open = devkmsg_open,
-	.read = devkmsg_read,
+	.read_iter = devkmsg_read,
 	.write_iter = devkmsg_write,
 	.llseek = devkmsg_llseek,
 	.poll = devkmsg_poll,
-- 
2.43.0


