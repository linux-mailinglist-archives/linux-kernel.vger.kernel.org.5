Return-Path: <linux-kernel+bounces-140920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98EB8A199E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D3828930C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1C19DF43;
	Thu, 11 Apr 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s3a8E0jE"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9FF199EAD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849761; cv=none; b=kg714TN5RTiHl+auvV4gTCy7DSrk2U4xKDcj+aUWUpUAtwzKF39hySEx4I1opsrG+nIafvsW6qsT6mvLgO904R1L4UyIoRWQspDjwaKIxrkESXNg4YLnEEhEnwFwcQy/EqDakYH1uR/OnCi96H6TrWyf2F9JWJCILBIYscJPIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849761; c=relaxed/simple;
	bh=2XaaQH06osAFD7r0uCj0RKanYh3XLyEaGHaVR+s/cWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WA/zIMH/XyaDlZvPZsEVUODvxQJKWFivuFsTk8ETYJPRYg4kzFRy/s/CGX32bVfcYiCLT52R/p8Qx9tSOGmyIV8Ho9IJELso4bp8+gvOO90HNQ7y0VURsrmCAa+cMa4PtL2o0zAcDOsk2+WEsoBvaXhfWWIqCuOXP7d92cUXKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s3a8E0jE; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69563839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849759; x=1713454559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76UESEO4u7xO90RDsYhk9AZfovqDmJOROL5iZe7HymY=;
        b=s3a8E0jEJl02fw5iWaue8eTbhWXNUi1CBqO5WRi7WTZnqMCKIp6cZ8scOOCf6UBXpY
         qr2XJ7vZUv1EATsK38n1H7tWeWDPUiuoGYbYulvS9agytzoQVd6qSSt9p2OVeyr6zuxd
         fLEE+1hEzsiwOk0NpxRXy02eDN8DtsUM7lS7KdOIF32GIbWBXUYECvYJhM4kc8Njo1y4
         oTvChUHo4cgBls3NNGKBzXUWbZNa+0u2VPSwhrSCEAkpwxnfDGU9SP/5kNEOPoPKDdNj
         F0aei60XnifkhU3mSym23OQRuDrKI3g4DXVM5xpcIp9heth07YgjzvpWPX+bg0kytV3Q
         IkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849759; x=1713454559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76UESEO4u7xO90RDsYhk9AZfovqDmJOROL5iZe7HymY=;
        b=QkmVwZwxsz8mXLg5yfIi6W4YDrRPHgkWkuh8WfBsgGEzJ+HJie+ZJF4+qBek/s+2ER
         Om9bf94hWt7Vb1pDCzDgyShGAROcJZMk722r0r/lUgZX0eTStmbpsH/jTXRV9ChayDfU
         GH9B0/Iv8t6zIHINNnE1DmunfdvNX7Fq6qoE3ogdP4kPUY9NP8oIdePoYt5g9HJ+whlG
         M7QXYgUKHQQPiRVnit4fXtIN2QuU/cJSgrKveU6Otsq6Mnt6500g9nQz3tX2vgRSk2Zd
         u8WzvWuwNuMYj7/4Qs5Z2fnsiQPOT9s+ITuiq5D2jX2AiNIQi0lVN0RoHlGTkNm0wOlA
         nAzA==
X-Gm-Message-State: AOJu0YyYFc/E5Gx1rBS4eaw4k3TVoQyH7Otd3Rmc6TaOvtYp/Jh3pI4u
	zxnldqMLFjp5+ab/oxGpcx8ellid42qenSynNZCRdbpUfnX0A5qol0l1o0MKb8EioQWewmLKt1y
	X
X-Google-Smtp-Source: AGHT+IGa47ZmDOUZy3qi7yrlEhtWgjELJ1OWC/pc27YISsw/gjUxTivXIFHsCPuqcafTZJOTL5ikUg==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr40983iob.2.1712849759420;
        Thu, 11 Apr 2024 08:35:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 153/437] drivers/dma: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:53 -0600
Message-ID: <20240411153126.16201-154-axboe@kernel.dk>
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
 drivers/dma/xilinx/xilinx_dpdma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index b82815e64d24..8a443cd0cd44 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -354,14 +354,14 @@ static struct xilinx_dpdma_debugfs_request dpdma_debugfs_reqs[] = {
 	},
 };
 
-static ssize_t xilinx_dpdma_debugfs_read(struct file *f, char __user *buf,
-					 size_t size, loff_t *pos)
+static ssize_t xilinx_dpdma_debugfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	enum xilinx_dpdma_testcases testcase;
+	size_t size = iov_iter_count(to);
 	char *kern_buff;
 	int ret = 0;
 
-	if (*pos != 0 || size <= 0)
+	if (iocb->ki_pos != 0 || size <= 0)
 		return -EINVAL;
 
 	kern_buff = kzalloc(XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE, GFP_KERNEL);
@@ -381,7 +381,7 @@ static ssize_t xilinx_dpdma_debugfs_read(struct file *f, char __user *buf,
 	}
 
 	size = min(size, strlen(kern_buff));
-	if (copy_to_user(buf, kern_buff, size))
+	if (!copy_to_iter_full(kern_buff, size, to))
 		ret = -EFAULT;
 
 done:
@@ -389,7 +389,7 @@ static ssize_t xilinx_dpdma_debugfs_read(struct file *f, char __user *buf,
 	if (ret)
 		return ret;
 
-	*pos = size + 1;
+	iocb->ki_pos = size + 1;
 	return size;
 }
 
@@ -441,11 +441,12 @@ static ssize_t xilinx_dpdma_debugfs_write(struct file *f,
 	kfree(kern_buff_start);
 	return ret;
 }
+FOPS_WRITE_ITER_HELPER(xilinx_dpdma_debugfs_write);
 
 static const struct file_operations fops_xilinx_dpdma_dbgfs = {
 	.owner = THIS_MODULE,
-	.read = xilinx_dpdma_debugfs_read,
-	.write = xilinx_dpdma_debugfs_write,
+	.read_iter = xilinx_dpdma_debugfs_read,
+	.write_iter = xilinx_dpdma_debugfs_write_iter,
 };
 
 static void xilinx_dpdma_debugfs_init(struct xilinx_dpdma_device *xdev)
-- 
2.43.0


