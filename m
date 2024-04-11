Return-Path: <linux-kernel+bounces-141113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBED08A1A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FF51C22A28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5D81E6F47;
	Thu, 11 Apr 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RbpCe+2K"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B25165FBF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850058; cv=none; b=mw3fk3F1zpDfr2Csmt9iGPpPiA4PH8ZkNtwgndYpb0azYrE09ZCUCeivKsHH1EsY4uHpqVW7jRFTI/t4kjeOEwQczR73LPMRMBcp9XwSFmEhx1zlF0sfPC+v+86gZ0q8jnMvA1DcImEVyJiXl4mFlKLdteFtM/kCciXrCkZnKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850058; c=relaxed/simple;
	bh=SrqEVaNHctKyAKzq1JOVvBEfJELcEnEL7VEjyNkB6v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqGr+5iT8SqtRb11U4LBdXYogxMgeOSKcQPY3yyULezFklF3UginT1+I6IY9Bz/xxaNQsPD3UDONVrVJTWbEo+y1nI7y93tWNzN/saC5JqQhW8YEPUuFLv79g3VGWBJZwsIsz0AMDuM3b5gxrpRy3r63ZjJwuI1ChdqCuXbUL9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RbpCe+2K; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9896639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850055; x=1713454855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RQXmYmV22R30FARm9BeOMN9CZR9Ay/0wkAfs/a4BtQ=;
        b=RbpCe+2KwmTayuISLOqjjYq7wfP68WsecLVGJcZHGHG3c52DLMNOktHIC5muegzCdq
         HyCxDt7VXEIYqruE4Fo5vKYBLShdQpbwYR3q+2WExM+qZZQw70hACFoXeziaDAKu/Arj
         EDlt4103onTc2W3y2xWKT0rD0f8bJ+7spwWBzs1vVXXjZqYI4IScyb/5/r576SJVS4J7
         CgttN368aYBUyIatBUpN09fPY7vmW+ac71u99evXsMfeFABuZSlsWtog5v5PuDj290+p
         bZcpQxNJAw2kcF3o7vVzfElyV7s8erUmD9mZAs/Xx3WnvLeXI+w107zGxMcwpEnSRc4M
         zOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850055; x=1713454855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RQXmYmV22R30FARm9BeOMN9CZR9Ay/0wkAfs/a4BtQ=;
        b=h66Fqz3RO3A2WUrya1g6DThLilnf/zxq7ZQibeIXKNUXIUEHZ9mfilamUONcWXWdgv
         yXZs6IthT6RxwaqrK6HtF9TORAKiA7o4HNdrk/f3M0gt6Y72PSbuoucdReBvozMu5fxD
         gjWyw5eM6uEgLTC2naaxpnGSfYNI4BYITr9tAVftLaDbzO+9LWB7aq5VjBJ77MKyRRcb
         v8AC9gmM//0Zh9ivhtbpHRClzWct3hvATzO5KJihJ5Q+1PFdKPCx8cCQXSYdWrZ4DC/J
         wLb08OEv+ykYMR5IWyscv9Q6BYe2LNUeRbhW8m0cVbppatcWxo4cpdbYyor8wQkx6e8W
         gsdg==
X-Gm-Message-State: AOJu0Yx1NulN5wwiioz0kegFXzFOd1woDWnHONd/I8HFbW90co9BNM7o
	dnWrYRLf+dSieGcJsdpbuTrAslNlaZ1PDSFY5qH8ZkR+s2a/vdKuXPxIzKeCz5emq6CVXiVr2Gt
	Y
X-Google-Smtp-Source: AGHT+IFgDgoSL+8Uyb7GE068C6hEcuCg2RSpwyvplgzi0ufjZ4zNBybC0lz+Hmaxot6tQGAzyGy9uQ==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr205435iop.1.1712850055476;
        Thu, 11 Apr 2024 08:40:55 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 335/437] parisc: eisa_eeprom: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:55 -0600
Message-ID: <20240411153126.16201-336-axboe@kernel.dk>
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
 drivers/parisc/eisa_eeprom.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/parisc/eisa_eeprom.c b/drivers/parisc/eisa_eeprom.c
index 443b15422fc1..87066c0cfc1d 100644
--- a/drivers/parisc/eisa_eeprom.c
+++ b/drivers/parisc/eisa_eeprom.c
@@ -22,23 +22,23 @@ static loff_t eisa_eeprom_llseek(struct file *file, loff_t offset, int origin)
 	return fixed_size_llseek(file, offset, origin, HPEE_MAX_LENGTH);
 }
 
-static ssize_t eisa_eeprom_read(struct file * file,
-			      char __user *buf, size_t count, loff_t *ppos )
+static ssize_t eisa_eeprom_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	unsigned char *tmp;
 	ssize_t ret;
 	int i;
 	
-	if (*ppos < 0 || *ppos >= HPEE_MAX_LENGTH)
+	if (iocb->ki_pos < 0 || iocb->ki_pos >= HPEE_MAX_LENGTH)
 		return 0;
 	
-	count = *ppos + count < HPEE_MAX_LENGTH ? count : HPEE_MAX_LENGTH - *ppos;
+	count = iocb->ki_pos + count < HPEE_MAX_LENGTH ? count : HPEE_MAX_LENGTH - iocb->ki_pos;
 	tmp = kmalloc(count, GFP_KERNEL);
 	if (tmp) {
 		for (i = 0; i < count; i++)
 			tmp[i] = readb(eisa_eeprom_addr+(*ppos)++);
 
-		if (copy_to_user (buf, tmp, count))
+		if (!copy_to_iter_full(tmp, count, to))
 			ret = -EFAULT;
 		else
 			ret = count;
@@ -68,7 +68,7 @@ static int eisa_eeprom_release(struct inode *inode, struct file *file)
 static const struct file_operations eisa_eeprom_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	eisa_eeprom_llseek,
-	.read =		eisa_eeprom_read,
+	.read_iter =	eisa_eeprom_read,
 	.open =		eisa_eeprom_open,
 	.release =	eisa_eeprom_release,
 };
-- 
2.43.0


