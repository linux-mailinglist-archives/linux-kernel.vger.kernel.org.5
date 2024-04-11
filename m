Return-Path: <linux-kernel+bounces-141002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F98A1A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74895B25700
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D663EA98;
	Thu, 11 Apr 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="unaqoQ3s"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475BC1C2FD7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849886; cv=none; b=pCgAB2cdShGbt7CTXN1NOcwikU1f/EsqVabNOWPe06u7+OkdY/ONciaPveqRDpWrEb8DTnhaAdPFoAmY8fgxHoL6bkZkKsgzDcKOpmawVq/VDKRPRooWGAoXq75asbM8jftNyEvfYtF0/nYTp0djB4ioO7J7s/YcXn3iah32Lug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849886; c=relaxed/simple;
	bh=4JJm/KkWl0SukclIW9s5cbvCHsQQU5brbMVnKTM3pFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1GVul9fTYKB4HwWDeg2SM9rccXNIdQjv/jINnMOzpkL0YcFhFuhVejuYG+6SLMSXhdECrT443YYWlHGRZobz0b5SVC7zoZKJ67In3+pQAQfE3Ym/7b/NZ9cyWJOcnOaW9USnkvvQ46AawFHwxFeZHFUXZmkN7Q2lN5exHRDfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=unaqoQ3s; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8985139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849884; x=1713454684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsVADeoU1kD62gaq96AoIhBA124QCFXfr0s9DkU4GEs=;
        b=unaqoQ3sdM41LPBN5EX/frsCxxzA+23eZyMYJx/IWmdm9yhsrNaOA5p7j/jfaxV7dp
         uKXvSCph7eE7jFcgEK2Uwwht72u000mxgoeCKSULlySr1R8rtLodiJ3QmsbNqiaagVET
         wWgExgVgS4EeTffGX2dYa4Ur2/Hbh7gOyV6UQFS7hlM6tIziaRgec/0bz5/qb4TrE0Ef
         sD/ABSs48vCUnLzpOuMU+p6Gbpecw8BPmkAZf5+Sw12v1gFlZJrL4IUnOgZb7SOUKhQx
         huhnVPV8ckV+uvyzMtZTSAoTKMqhITHS1O1TG+xGzLDMapff4ZDl4w6XutGDBsATFQtk
         Hc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849884; x=1713454684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsVADeoU1kD62gaq96AoIhBA124QCFXfr0s9DkU4GEs=;
        b=eeIDHFqM3iBDx2isuQbjO7rHckcl0ELcAJV47VdRW1ErM44Vizs1tEycpayIsc78hH
         OSGW3zKBfC2iKd0iczp99B8Z9DqMaKvTFZ/E7fM57mknj4cOcL8adrG+aKfaU3ym9FP6
         gmZThq7/VXDscHLu4ZAlhY9FEGFSMkZje5j2b2DSA4Z6uxmwaLOxiH0dCPp3aZztsD0o
         0CRzHfne41LLlEnfFKi5OxKFL76j0zKAZTlEbShPAY9s2eLMLyfDjZQB1uErAC97tosm
         asBfyxHJEgcGNbMiu/KW4LmCezJAWZXvmSjrcFrVenO/AB2/Rpe1va/0uBN4A8l/ZrpD
         h5EQ==
X-Gm-Message-State: AOJu0YzdZJxuCYiVlTyIYqDffGNtXwiN96wgHy2W51sJzcGG1DlxQDTg
	qhxclUlFdiWzN4reaNjtpdetDVsxCx40X3xgCmntBR52fBi+K170DTtj5qZpFBgf1xqOw20Y/gr
	L
X-Google-Smtp-Source: AGHT+IHDSpoAbZf1SRKbRPzle5GLUkotYkc6rMb00ZnzIGzvK1hgjO5I2IFY0xWDRDs4OHy+ev1LDQ==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr185850ioj.2.1712849883882;
        Thu, 11 Apr 2024 08:38:03 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 230/437] drivers/nvme: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:10 -0600
Message-ID: <20240411153126.16201-231-axboe@kernel.dk>
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
 drivers/nvme/host/fabrics.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1f0ea1f32d22..6d0251cc4bf3 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1326,10 +1326,10 @@ static const struct class nvmf_class = {
 static struct device *nvmf_device;
 static DEFINE_MUTEX(nvmf_dev_mutex);
 
-static ssize_t nvmf_dev_write(struct file *file, const char __user *ubuf,
-		size_t count, loff_t *pos)
+static ssize_t nvmf_dev_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *seq_file = file->private_data;
+	struct seq_file *seq_file = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct nvme_ctrl *ctrl;
 	const char *buf;
 	int ret = 0;
@@ -1337,7 +1337,7 @@ static ssize_t nvmf_dev_write(struct file *file, const char __user *ubuf,
 	if (count > PAGE_SIZE)
 		return -ENOMEM;
 
-	buf = memdup_user_nul(ubuf, count);
+	buf = iterdup_nul(from, count);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -1422,8 +1422,8 @@ static int nvmf_dev_release(struct inode *inode, struct file *file)
 
 static const struct file_operations nvmf_dev_fops = {
 	.owner		= THIS_MODULE,
-	.write		= nvmf_dev_write,
-	.read		= seq_read,
+	.write_iter	= nvmf_dev_write,
+	.read_iter	= seq_read_iter,
 	.open		= nvmf_dev_open,
 	.release	= nvmf_dev_release,
 };
-- 
2.43.0


