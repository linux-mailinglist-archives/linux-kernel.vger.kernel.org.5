Return-Path: <linux-kernel+bounces-141212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64608A1B03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F1E285E16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775DF20220B;
	Thu, 11 Apr 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oh/kgCfV"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8F2019A9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850215; cv=none; b=TN3u0CMcy36+jCX3Uk21NmCFkcO/sADkkIIkfzzd172IEXwJrMwVbrwMBZ69cnM9aGtwZyn8VzofLlMMvfpMw1D5+J+DhgMXs5T6c8iNzK0nlf4C6sgQjwhzOfhqMDcXC3JreQ/goxNDBmYOQ/6LBoyO1eIxFPPacVYnEb6RQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850215; c=relaxed/simple;
	bh=+6tNeSPg3Y15gIAEvwu8sSoeBUZil0as6nCBC30vAPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+Jg2B+nxHV4yq85OGCz7QM0iwkgVmsHVybmzENaU6fksAXJOB+KQUGyDyaGQbpA7I4EIaAljDMia27oYjjI3thhkxDhDfEmykRf1e941rmN/169Nlq9G0Wlos7X5h2HATWWU83W6kp2dRoPgaR6GTq/PlpOd1pZ5nuxfM+GAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oh/kgCfV; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58291939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850213; x=1713455013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWpKjosyo1TmsrpvFjZE6WmxsY3pkaGviBwPxsRKgBk=;
        b=oh/kgCfVvNpWm/giQqL0H7Iz7/J137QyNuHe1BMEZWU+cSxweurTuiBuS5xtu3bQ5b
         PdavSIZuLSfjqjzYglVICYzrRRPFaN0mgDlyZrr4ILbQX4JPGBt9h1DiSVDjBPgIPk3D
         +UOckoQ2ojvzTRKpDsHLWP4Ym2aZHjfB0oiAaUN/Jtr455SKeCm2WycCkqCdMxYPn3tM
         sDlU6ad3oxdow+w9+Jn2+BgXlpTnEFoDEfV9hb3PitnqSmK50OVsX/FHbjodZ5VwQ2h5
         qK3iy6ohQBRnFEiLKTOR4/66Ekew3gOqNbJJwrUSLY8QpfWmLCFJp4CCgOfBfddM4+GX
         yI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850213; x=1713455013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWpKjosyo1TmsrpvFjZE6WmxsY3pkaGviBwPxsRKgBk=;
        b=vVDpDyHg7VenCQwpr0Cm942qf1XXXQo+enSUE1Fkyt6870SAnvuEU/2CNwXfjpwEDR
         W3cSMaiF/8ZnA/YVa9X60qTTa6gW19n15uq4/2ilokcRS0UlUhA4lr0wiDRR3VIOQlqW
         kdt8S6mU2KCm2mFiFk27qpAGF30r99FXaterO7NFT+04SKYoTOxGOZIQfuErZn3KCeOC
         U/We3RNvN7a8kC6LYfDXgq61eY05lWGvYbpPEJuwIG5taezsDbpythinR90qwc7pkSe0
         17FpedZAUda/oq8cq3ngrwxnXxRDdzKFzf8WVmMWSnkDfhgi42CqiM1M+bPETJiMaOD/
         zlMA==
X-Gm-Message-State: AOJu0YyflIoYwSOjHd0T9RFaX/WMWQErQ5HP2gbCCMDAtxiz3aUMhCRl
	z3/YWE+hyuuB/tz8NkaKmh3eE576o4ooI8hOyvYqC6F1+I8x/ROlEqrn3dzIuiLckvtxOLhcHcM
	2
X-Google-Smtp-Source: AGHT+IEGKLNJ1dO6qNxwEC+7lDLZqiDjdFDdGDsfsHCG5vPWdyVrLLt1tEXx1q021tnftfJ+0tegdQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr207456iov.2.1712850213403;
        Thu, 11 Apr 2024 08:43:33 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 426/437] firmware: xilinx: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:26 -0600
Message-ID: <20240411153126.16201-427-axboe@kernel.dk>
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
 drivers/firmware/xilinx/zynqmp-debug.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 8528850af889..8d64bffd1890 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -143,9 +143,8 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
  * Return: Number of bytes copied if PM-API request succeeds,
  *	   the corresponding error code otherwise
  */
-static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
-					   const char __user *ptr, size_t len,
-					   loff_t *off)
+static ssize_t zynqmp_pm_debugfs_api_write(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
 	char *kern_buff, *tmp_buff;
 	char *pm_api_req;
@@ -153,16 +152,17 @@ static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
 	u64 pm_api_arg[4] = {0, 0, 0, 0};
 	/* Return values from PM APIs calls */
 	u32 pm_api_ret[4] = {0, 0, 0, 0};
+	size_t len = iov_iter_count(from);
 
 	int ret;
 	int i = 0;
 
 	strcpy(debugfs_buf, "");
 
-	if (*off != 0 || len <= 1 || len > PAGE_SIZE - 1)
+	if (iocb->ki_pos != 0 || len <= 1 || len > PAGE_SIZE - 1)
 		return -EINVAL;
 
-	kern_buff = memdup_user_nul(ptr, len);
+	kern_buff = iterdup_user(from, len);
 	if (IS_ERR(kern_buff))
 		return PTR_ERR(kern_buff);
 	tmp_buff = kern_buff;
@@ -201,18 +201,18 @@ static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
  * Return: Length of the version string on success
  *	   else error code
  */
-static ssize_t zynqmp_pm_debugfs_api_read(struct file *file, char __user *ptr,
-					  size_t len, loff_t *off)
+static ssize_t zynqmp_pm_debugfs_api_read(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	return simple_read_from_buffer(ptr, len, off, debugfs_buf,
-				       strlen(debugfs_buf));
+	return simple_copy_to_iter(debugfs_buf, &iocb->ki_pos,
+				       strlen(debugfs_buf), to);
 }
 
 /* Setup debugfs fops */
 static const struct file_operations fops_zynqmp_pm_dbgfs = {
 	.owner = THIS_MODULE,
-	.write = zynqmp_pm_debugfs_api_write,
-	.read = zynqmp_pm_debugfs_api_read,
+	.write_iter = zynqmp_pm_debugfs_api_write,
+	.read_iter = zynqmp_pm_debugfs_api_read,
 };
 
 /**
-- 
2.43.0


