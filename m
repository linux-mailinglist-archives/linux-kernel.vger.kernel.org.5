Return-Path: <linux-kernel+bounces-140987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E38A19EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F161F27BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC21BED7F;
	Thu, 11 Apr 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Qv40WMGZ"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D951BED7B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849865; cv=none; b=du7A0y4P4FbJ3+S9nLZRelU7t1lfLadRhrZGluM71pVoab61Q1+fRyDPjyGgAzyCQnecXyLRSUeLmdEe5lYVUQj+QZVODOnbGhLMEcAkTSzkMRuP87d5r66Ir4Tllil8ds0nZqw6lggvi0hUD+HCY4vJ9zO/TRYwytaqT+LzO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849865; c=relaxed/simple;
	bh=myd+Daz97F2ut49cTnMTTS/WXIDFCLtYMyovDtiMPJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzPs1z4RAZOr8QWK6uIMtQxUh0K4FCx03n8IzCDBKgBXZdL6sna2XqIqDARSYKAruvTxkgnpn0e7/VOLqDhWYU16tzchE1983vAVPctvSFpcT7E+gbKySlvcneJz4lM2JxtVVBQnxCOmyFjl1U1NE1r2zJfLhrlGy+XQFid56AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Qv40WMGZ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36a34b68277so113155ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849863; x=1713454663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWM7bBVX/AOnqo7s8vRCNjIByq38EP8G7k94XlB2Tzo=;
        b=Qv40WMGZ0blJJBdZlXq3Qeu9umfuXmdhOTrblt08L1b33zlz8/m+9bKozTIO7ZN6Ic
         5bfuh8xmCJD0/6J8t+IKTMGcDUgMmBkXb5ZuAu1fER5kcIn4KGvADEHNydzHCBmXNJl5
         5pvJ1BWcBx9YbLCdnKskJ2GHBUYbRKHTITvGkNVSZKHb7KpCo2RgXdheebpPfmleAvHH
         BNnKTejhnGZ4hec47SGbhchZDMRcy07Pcw/vKtQVUe0h+/WVVsUCFRzotne+FvZ7MnTX
         GjwT3AFdwEwJEjbbSeoPjX+P0zSB3aY1ahKAhgYvg2XFQbn64b8haMfbk0Lovo/6/SNE
         WDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849863; x=1713454663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWM7bBVX/AOnqo7s8vRCNjIByq38EP8G7k94XlB2Tzo=;
        b=H1VJ/nUvdkLfCCh3pe4PWCd9WrmgprtZuMociXPDdZt3tLIMjLFw0TisQrbIqCmybB
         xIONoQ0kcvwB/C30v+JVixHeyCd6wX5gBr+YrfOs6SXdwb+OuWw1h32J2UIAlemudjeU
         7J1RvGB62r9mKMcRGmmezyMR8ueyiFnoVWlRI/jKOtjTYCk3URRP6yNe7rva6cRHI7u6
         B2gLWcSyISfJELTPbxa05z9oBPT3wrRuxDgOFIEeCbkDEkvQe5VYfzU1KSvAsTAeLg5E
         V833vW0DhCPZ2wZLYHryRJxR1tIcsTWkcFUsZv2wnNPFHtxRl13kWQ7K0TixMyIFtSWR
         BJwA==
X-Gm-Message-State: AOJu0Yxp9Bte6cROtZsfhYSlLT702PyHM+U7C/ruqOSZwLE05DQssWmr
	3HNwk2sBu9LulvAIkdQcohTmn4PmzCfYy+1QwAUrOuU9Q7UjSRYOZzptHGkK2oV7+uS3x2WPt+C
	B
X-Google-Smtp-Source: AGHT+IFnJhbCydeWVqztP5Nfh1oYFE624XpSmg9S+kK42TiXNmAxZXJRd6n/5jEqq/MpmI3wf9BsRw==
X-Received: by 2002:a92:d812:0:b0:369:bf80:e367 with SMTP id y18-20020a92d812000000b00369bf80e367mr6246145ilm.3.1712849863315;
        Thu, 11 Apr 2024 08:37:43 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 217/437] misc: open-dice: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:57 -0600
Message-ID: <20240411153126.16201-218-axboe@kernel.dk>
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
 drivers/misc/open-dice.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
index 1e3eb2aa44d9..0fe66a17f27d 100644
--- a/drivers/misc/open-dice.c
+++ b/drivers/misc/open-dice.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
+#include <linux/uio.h>
 
 #define DRIVER_NAME "open-dice"
 
@@ -61,26 +62,24 @@ static int open_dice_wipe(struct open_dice_drvdata *drvdata)
 /*
  * Copies the size of the reserved memory region to the user-provided buffer.
  */
-static ssize_t open_dice_read(struct file *filp, char __user *ptr, size_t len,
-			      loff_t *off)
+static ssize_t open_dice_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	unsigned long val = to_open_dice_drvdata(filp)->rmem->size;
+	unsigned long val = to_open_dice_drvdata(iocb->ki_filp)->rmem->size;
 
-	return simple_read_from_buffer(ptr, len, off, &val, sizeof(val));
+	return simple_copy_to_iter(&val, &iocb->ki_pos, sizeof(val), to);
 }
 
 /*
  * Triggers a wipe of the reserved memory region. The user-provided pointer
  * is never dereferenced.
  */
-static ssize_t open_dice_write(struct file *filp, const char __user *ptr,
-			       size_t len, loff_t *off)
+static ssize_t open_dice_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	if (open_dice_wipe(to_open_dice_drvdata(filp)))
+	if (open_dice_wipe(to_open_dice_drvdata(iocb->ki_filp)))
 		return -EIO;
 
 	/* Consume the input buffer. */
-	return len;
+	return iov_iter_count(from);
 }
 
 /*
@@ -106,8 +105,8 @@ static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
 
 static const struct file_operations open_dice_fops = {
 	.owner = THIS_MODULE,
-	.read = open_dice_read,
-	.write = open_dice_write,
+	.read_iter = open_dice_read,
+	.write_iter = open_dice_write,
 	.mmap = open_dice_mmap,
 };
 
-- 
2.43.0


