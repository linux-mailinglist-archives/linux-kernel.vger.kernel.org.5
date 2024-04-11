Return-Path: <linux-kernel+bounces-141092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB468A1A71
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8A1C22DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34C51DED98;
	Thu, 11 Apr 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HWbc4bOQ"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC21DDD1B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850023; cv=none; b=nn3VA2fsDQ5BwgYkuq3prEdP4CS56vLP+ZSzFCOAFy0cUTuv+nA4vybWKwzWTVmNobDFzQYwXvm5fiCFa5R2Xtki6CRjR5ugftMBdXkRjDmbEcO/9DOykAjNzCQucBhz8Qj3fHQA4IV0HClNT/rii2W4KOmJSMqwxaqJWduEU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850023; c=relaxed/simple;
	bh=Ts4z5nH+J3H3v3TlBYfnvZn++qcAj7pfsChb5zFTl2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYwrrcJI44IDMB5cscMmeIAAHkqcQX1FaC3q7uibW4eZtkaT3qMW/LLJSiJRzdN+MDpiXBEsQdx4eRz+o6yVo9M+ehZvnEX1bivaoc/Ty4UMcQ+hPJKYakDrwL19W9Ao4XMSa9YU6v3UE6y4bC3xF/wclWoXoKxVCxxF8z58Vg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HWbc4bOQ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9877439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850020; x=1713454820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJc/6DfGX1FnUExrryNCJXFJYeZyZzWO7T2H6Bi+Lw4=;
        b=HWbc4bOQroVSbTXEjMaMrhnYq3C63M0FQ38Y3ZkHd1IaULsN8VEW63+ysSUWSbienp
         qgX3FDUt0mhRJ+mNioaZC0sKBFKAc9bnM/ZWbXEm/HVxE0gRNxna8mt3oNGF91HgFupH
         V+qpA63uGK3wBzAx+cjoJYer2oOtveg7bvqwoLPRSRjimmEg2Pw/GrYC+MZP8D8QbfBa
         m3NQPH/8IMjgGtykOTPlrO6mheIoHLyB7SjInAKfAwG48Yvpm0nRcXXFa+xCUoFS97yz
         a3JQTUcCBMMSkBwHXefpg39mUa/L4c+oz66iZM/4g2Fq5x3YLZpkArvSskpdRHzvk9Fp
         oQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850020; x=1713454820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJc/6DfGX1FnUExrryNCJXFJYeZyZzWO7T2H6Bi+Lw4=;
        b=p9zppJyj7FFppMo9xpbAcKSb/HbixIoLC5uLo0jtMd4kDJHJGxvuyR8nuh8rGExT2l
         ke5DRpg4ZMRSPaIxCYb+fdV/jtk/ZhLmCdgzQAfz6C8nwLGRquuqQt8dWYZ1dwEcbvXn
         DaTXoI1r9Hw4b+lb/F5cZZID+rx0IMJeS/fFnRJJhtogLJSZo62mLBvDUtxSqEUK8rIs
         /QArqW0zxdPVQzXEo9rXkragbdiP09oe93jfcUgF11UbFfE4vdV6fIpHPeKg6N+yQL24
         ASTzCeGXX72yuJTvEGpVgc5q8qXGu/K659InAiYESfEbq+vz9e72ra5Zidk/EBFSPdYh
         7tOA==
X-Gm-Message-State: AOJu0YyxNr6Yn2H1xQJ715aCUNz88b2iRTn83INlfq6pMWCYof30HLu6
	GYJb7qWS4R/A8NTmKK1wPGNU8l5wCbKthrpOxiz+HqAf2+4WFIAJYyRcv+ty9AgJ615+1t/C19y
	s
X-Google-Smtp-Source: AGHT+IHV/bde4YDfxqKdE7euAUS0YNoCb0yDygzZUdQOkCQlaAbeKHGABEdy5f50MiblGbcrD2Phow==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr203893iop.1.1712850020323;
        Thu, 11 Apr 2024 08:40:20 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 314/437] drivers/net/ieee802154: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:34 -0600
Message-ID: <20240411153126.16201-315-axboe@kernel.dk>
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
 drivers/net/ieee802154/ca8210.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index e685a7f946f0..af2bf8c24572 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -2443,14 +2443,12 @@ static int ca8210_test_check_upstream(u8 *buf, void *device_ref)
  * Return: 0 or linux error code
  */
 static ssize_t ca8210_test_int_user_write(
-	struct file        *filp,
-	const char __user  *in_buf,
-	size_t              len,
-	loff_t             *off
-)
+	struct kiocb *iocb,
+	struct iov_iter *from)
 {
 	int ret;
-	struct ca8210_priv *priv = filp->private_data;
+	struct ca8210_priv *priv = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	u8 command[CA8210_SPI_BUF_SIZE];
 
 	memset(command, SPI_IDLE, 6);
@@ -2463,7 +2461,7 @@ static ssize_t ca8210_test_int_user_write(
 		return -EBADE;
 	}
 
-	ret = copy_from_user(command, in_buf, len);
+	ret = !copy_from_iter_full(command, len, from);
 	if (ret) {
 		dev_err(
 			&priv->spi->dev,
@@ -2518,18 +2516,15 @@ static ssize_t ca8210_test_int_user_write(
  * Return: number of bytes read
  */
 static ssize_t ca8210_test_int_user_read(
-	struct file  *filp,
-	char __user  *buf,
-	size_t        len,
-	loff_t       *offp
-)
+	struct kiocb *iocb,
+	struct iov_iter *to)
 {
 	int i, cmdlen;
-	struct ca8210_priv *priv = filp->private_data;
+	struct ca8210_priv *priv = iocb->ki_filp->private_data;
 	unsigned char *fifo_buffer;
 	unsigned long bytes_not_copied;
 
-	if (filp->f_flags & O_NONBLOCK) {
+	if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 		/* Non-blocking mode */
 		if (kfifo_is_empty(&priv->test.up_fifo))
 			return 0;
@@ -2551,7 +2546,7 @@ static ssize_t ca8210_test_int_user_read(
 	cmdlen = fifo_buffer[1];
 	bytes_not_copied = cmdlen + 2;
 
-	bytes_not_copied = copy_to_user(buf, fifo_buffer, bytes_not_copied);
+	bytes_not_copied = !copy_to_iter_full(fifo_buffer, bytes_not_copied, to);
 	if (bytes_not_copied > 0) {
 		dev_err(
 			&priv->spi->dev,
@@ -2626,8 +2621,8 @@ static __poll_t ca8210_test_int_poll(
 }
 
 static const struct file_operations test_int_fops = {
-	.read =           ca8210_test_int_user_read,
-	.write =          ca8210_test_int_user_write,
+	.read_iter =      ca8210_test_int_user_read,
+	.write_iter =     ca8210_test_int_user_write,
 	.open =           ca8210_test_int_open,
 	.release =        NULL,
 	.unlocked_ioctl = ca8210_test_int_ioctl,
-- 
2.43.0


