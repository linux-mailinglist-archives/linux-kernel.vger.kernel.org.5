Return-Path: <linux-kernel+bounces-141202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0BC8A1AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699811F26E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DDE1FEAAA;
	Thu, 11 Apr 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mJ5GRuPk"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD61FEA8B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850203; cv=none; b=czuIrBCHv4Ubnd4S3dXjN9b1pV/0URdAER/YbIGyEZdZo9fcVVZrQvcYkTEq2F1IDw/VCVVREDdu89GN6icjEG9C/K1JzQDkBGVL8tYnoS3cV8YcDtSb7gVPktWTGFeDRNTfsiyroo0XJYxvMyAzNLUqzAxECniJXzg9eO5tYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850203; c=relaxed/simple;
	bh=LLe2owETTjHLB6zFEn8zDNlAMKFC3Lr1NdWG9VKpl/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnKjCKeGTxngD5DtZSQh2Ak/EBEdQbuXE29CBrDCjHfYGBXdlszMp0sOoMcR1PxgT9XvdNdc3Ss8ALX1ICvUevuSjVGvFYCNSmxNJeEswqj9xrk7g6lQidWC2BQ6oyBAgRYBTsAer6pZGcZSzViltsv8Kwh9r9hAgg0/nJpvinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mJ5GRuPk; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36a224d7414so198775ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850201; x=1713455001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mll/uFEwjEuuliItVoF3OWwVds2lzB8vki7Rbk8j+i8=;
        b=mJ5GRuPkumMsRvLrXGy3ahu08zR8odrxZSVu3GLFR6Yo9m7Qx7WDIA6GpV8UpeZx8H
         8rjIun6Wx0HfSNhW/UXTiZRDRL2G95Gvh9JJkTdtWTlkVUfIg1GbwG/NWhgbTVLYCXf+
         3FAHq7Pwbb6vpbWGJPhrc2JPD/AgR6XDuU8+3GQfUF+9t9OomZPq/W69UcsOGMq1ZYtJ
         5m0okoWYl7WrzRP8ExPhScX8+Mc2CX9MFxiw/gw5xv6kAUkHXPFHf9JXtpqcHjUBSy8x
         fxkmS/KkY8zl/gJSSGgSZ4Ps3PatT+Rtzcf+TtmjnuB89FXaudP940rkzGX+wFqwE/Ya
         AbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850201; x=1713455001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mll/uFEwjEuuliItVoF3OWwVds2lzB8vki7Rbk8j+i8=;
        b=qEDhItkglrFpCvhBqC80KlhuoVRsubutPc0ANQet3lO3RPlJ/WN2kt+UNAW+yjptGU
         gdNFFTIBhsaYBBA6hB4JqU61vfmTRsJyrZhUGKD6qHa3KsP7WQY8JbI3HZm2rcWV4TnO
         +0Qu5H+tLABUPVjKnO2Az//ldRia/Ij/GP2eBF7GAdBUSHeMyNpyl7gkfcpn5Pd58n7N
         dOutnProQCXStMPSVXT5n0ejtn7fOOwuR6bVILB1BHXVigz4+oKNt2phsRfYWieo2prH
         yQt8i84qxVGOo40AN0FwrkToKk7WrTNR++kEHPUExw/LvB/xXM+/2lfHKKGIjD+FVBuF
         qN4A==
X-Gm-Message-State: AOJu0YztRbaE3XFTffSWA+6h/1tLoyXlTDBZ23HrvLmM6NpwNxl3mj8W
	J2eX/WnHy3JQxqmQHDmBx9SYcQE+vCdJOUN+3AjFhpwiqDsvNf6zxdPaEzmQz8Fw4u3leABB8A/
	y
X-Google-Smtp-Source: AGHT+IFrlNlH9N1gPnXi2g0rqEYCtgxC3JKm2eUEl9BxS78eS8fsaW462f0zzD9bQjESptwnUIf6nA==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr206532iob.1.1712850200430;
        Thu, 11 Apr 2024 08:43:20 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 418/437] media: cec: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:18 -0600
Message-ID: <20240411153126.16201-419-axboe@kernel.dk>
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
 drivers/media/cec/core/cec-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index 5a54db839e5d..307763fa251d 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -200,16 +200,16 @@ static void cec_devnode_unregister(struct cec_adapter *adap)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static ssize_t cec_error_inj_write(struct file *file,
-	const char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t cec_error_inj_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *sf = file->private_data;
+	struct seq_file *sf = iocb->ki_filp->private_data;
 	struct cec_adapter *adap = sf->private;
+	size_t count = iov_iter_count(from);
 	char *buf;
 	char *line;
 	char *p;
 
-	buf = memdup_user_nul(ubuf, min_t(size_t, PAGE_SIZE, count));
+	buf = iterdup_nul(from, min_t(size_t, PAGE_SIZE, count));
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 	p = buf;
@@ -241,8 +241,8 @@ static int cec_error_inj_open(struct inode *inode, struct file *file)
 
 static const struct file_operations cec_error_inj_fops = {
 	.open = cec_error_inj_open,
-	.write = cec_error_inj_write,
-	.read = seq_read,
+	.write_iter = cec_error_inj_write,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


