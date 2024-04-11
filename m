Return-Path: <linux-kernel+bounces-140979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50358A19E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5069B1F26A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D676117CBF5;
	Thu, 11 Apr 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lJEbol8m"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75911BC7DD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849853; cv=none; b=DojsWNaNqmA0RlbdifZ7COfCYphfmfyLXobQ8km4htjgvIbSBP8w9eq7aAnVVBEMAp6/AfIM0D/ZV5SYjH+e5/5BQmThtf0vfE2HlCjEJersEg/smiov6c4nXEOxCw7FjwobDXyibzIreFsjemWt5khrQOg00zaSg3+a2rglu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849853; c=relaxed/simple;
	bh=A/ARPEJgaL/gdbzluKeljTIFVTiT0oB/eqdxBeRSRHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsBlzQIKf6yB14EdZuSu1DOstywzO5h8bG3DuohD18zeaLnISniBpAT2hOt6667nWahzRU5rzSuV/bO4g3fxxtlyD3hnD2UnqTLg87vb15VydgrZUOectPomLzvfWQCz/APqNNZ6VGrd32vuiiWkCJyWTYTWZw+Txxq2vwvUNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lJEbol8m; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36a34b68277so112815ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849850; x=1713454650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYtTA9H+WWc32h2IwigD9uGXK3lgyvxGe6eHAhngjlc=;
        b=lJEbol8mJuS1rAPWvBEcj00JZG6O3XaKhyLZttYct2vIOApVPyX78gI54XGWyEPr09
         GH4quRtaLWr/4iJm5qseuUBwwtXjpDeRcxp2IWLxytHoYPXlREkToHeFgomKV3jEZJeT
         1dZRDxk+wFyqy/b0eE9YRrrPgx/w4LuaJCIOEPVWndbF0evlGBDC6wvWkB9zOWpzHMvl
         RNMDK2mvh4IAPKhoNy3eqmzbZAqqSZchhvOYJt844BRtW/fKW/ba6vHlW1zQUVFe3pQv
         RA1/CK0v9b/oshVKf9APIWNqP8Bb1g3uODHhGCK83yuLwhTxUPGyq3WxTrguWJPR7m8Q
         jJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849850; x=1713454650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYtTA9H+WWc32h2IwigD9uGXK3lgyvxGe6eHAhngjlc=;
        b=VKb5tmUuPwRcR86zxjDxGJHlrT0BpDc0TUimyH5RJOBZin6lLazDLoHHnfc+E6EBic
         lLqCAl++uRNb596uI5p0/XLyMy6i7pzea8+KppITQNLxsiUlM28qKCNF5inBhTV8P/eh
         AlfR6jXDL6Acb47qJpY6Mr1mtRo/ZQm3/lkpV4qwRWwt6oSAeycxqqiUgDK5F6lP2Ae/
         i+Rbpvy/cATEBJhc3+Ni2XsylIKcXI7o0WN/mfkqqEjS514osFerHUQU6G1iWqKEPWTN
         nKpATbn+v7OLLlfjbp/0aOxxlylbOsQNvRVZCKEnR4dJfki+8aL9kEnoDA8WZ1lCKgNq
         uvMA==
X-Gm-Message-State: AOJu0YxBYOGgEZNzi95+jGOVwTCo1Z3SsMUNeatlsA7hrlytfJQoofWm
	57TeyhdF8PAQBH++tKOwiWvgxDUqjKmVZkV5MCM5nFcqY+Iu3Lh4hGC1aKz1B2SdaUUvkl1a2yw
	D
X-Google-Smtp-Source: AGHT+IFdtxuOiVFxV1CiQJDAksC/DqZuXOp8FTKoUeJLrWQu6vnlea284iajxvCux8kswxmfgyGGiw==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr191166iob.1.1712849850636;
        Thu, 11 Apr 2024 08:37:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 209/437] video: fbdev: pxa3xx-gcu: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:49 -0600
Message-ID: <20240411153126.16201-210-axboe@kernel.dk>
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
 drivers/video/fbdev/pxa3xx-gcu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 43c80316d84b..0890cea32df4 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -372,15 +372,13 @@ static int pxa3xx_gcu_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t
-pxa3xx_gcu_write(struct file *file, const char *buff,
-		 size_t count, loff_t *offp)
+static ssize_t pxa3xx_gcu_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	int ret;
 	unsigned long flags;
 	struct pxa3xx_gcu_batch	*buffer;
-	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
-
+	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	size_t words = count / 4;
 
 	/* Does not need to be atomic. There's a lock in user space,
@@ -409,7 +407,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff,
 
 
 	/* Copy data from user into buffer */
-	ret = copy_from_user(buffer->ptr, buff, words * 4);
+	ret = !copy_from_iter_full(buffer->ptr, words * 4, from);
 	if (ret) {
 		spin_lock_irqsave(&priv->spinlock, flags);
 		buffer->next = priv->free;
@@ -569,7 +567,7 @@ pxa3xx_gcu_free_buffers(struct device *dev,
 static const struct file_operations pxa3xx_gcu_miscdev_fops = {
 	.owner =		THIS_MODULE,
 	.open =			pxa3xx_gcu_open,
-	.write =		pxa3xx_gcu_write,
+	.write_iter =		pxa3xx_gcu_write,
 	.unlocked_ioctl =	pxa3xx_gcu_ioctl,
 	.mmap =			pxa3xx_gcu_mmap,
 };
-- 
2.43.0


