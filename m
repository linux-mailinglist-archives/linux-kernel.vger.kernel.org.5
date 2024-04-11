Return-Path: <linux-kernel+bounces-141183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD988A1AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428AF287E54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFF1F961F;
	Thu, 11 Apr 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JLqHJbcH"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1B1F8C9E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850172; cv=none; b=VPvt8U3fRdV/hYk1aglBDXaDjNvc4iP2jUxbSy3FUDXLx3Pd2DXM3dhXn2f1gskua2Tpxn7pYgZG465KXXqY5yNZFEnKCobfxTaYbXQJPByDCvh7L7pwI0++k2lLPZNA3TxXaIW6wYyh1moZoJVDPnQ09nVn1Y0ZBjG+iptgY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850172; c=relaxed/simple;
	bh=wvh7X9jHm1YYdCIGtPI1CoM0XslLw1AfgfG4j1VVmwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cv0EHLIA+/q3EUKg+g7R2/6CtziQitNl1trn1HGZxxIT7n2xg76ON6Jy30Ap/iaUB6SlzdXHqMBbV/xL1MtaWHemkSS72yG+//X5mEsw9w89Al9QhaH/RwdfFc899wQATrAa4wWUkvRleazWgjUUMrgkjjtoPKFHAv+yeTMb0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JLqHJbcH; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58274339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850170; x=1713454970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tES09aov9No9aquMq3lbtzo4K5QO+yzBuCHKjFykbiw=;
        b=JLqHJbcHkYvl+kxe5NnAPlP3+BVQ8GXC3nY/H265DXas2Otk3mTTFsnQ2PpcKKQM1j
         +MLenftJgpZGc2geu7hvaUQUUNZjGbH9/WqyO+sgNivTO/YP6l1qIFWDqoNavwol2lK7
         YCcuQWifH325K5dVikUMul96Su1pM/3XBbIpACAcGwfUfGTg7ta19grGBBrs12YGBjYu
         wVvFOXYZmC0DUd4RT+kFb3GgQLoChHkWnSAayYGytKjfOyuE2/WmDqtYdbnR2zRJvsUT
         BHlpL9U1MAHyHjQLwKa6/de3EqloHJQMqX/mWoDkad/S9TfTYi319EH/hoYpXSOzAsMy
         Rptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850170; x=1713454970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tES09aov9No9aquMq3lbtzo4K5QO+yzBuCHKjFykbiw=;
        b=lqXTPSX9rqVSf5cK0zzQGeWxgaEcfl/aE43YxHRQ9+AwdDIZxsJKM2vZsXEP39HaVA
         S7oIOoCzHJgz2OD82r8d7p9ItV72yuS3lfCEIDGoyAc8nC3EHhNZANzE/GUP2KF33sde
         RZjvQ80PN2LEpuAa6SE2f64bKxVLDOSQrL1TshRfndZ6SeDjUlGm9Uk2+u6vUbx6b2sA
         0irKr8omYFO+7i3ZdyaZcHvD+VMiXs82MwiVE5HLWqqZGcHkmTdmRIx1IErBkHUma22C
         I+Bn880VIlJrfgIHOtqAlMFr+Ld9sXgkQcGS1oB82U7+APnAyLZ1IOPtIa3ufTNhEuj9
         sthQ==
X-Gm-Message-State: AOJu0Yxs9YX3Kx5RaqyebuJXejRoYCKxcmGBqpjnqdXsBCN6zzIBZmCU
	le9u2byVm1Ni7DM2yFFJVHvmQTFAFn89uedhBtthBR7GShD6Chc9oDffVenjw0mxcHpivDPm/9x
	i
X-Google-Smtp-Source: AGHT+IHcYUQKgET7EBGT7n52uGjdKPE2kkzxWohOYkw8smpMgkGegAsVmLiR6TNOR/SFmuJv5Bh16Q==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr205336iov.2.1712850170106;
        Thu, 11 Apr 2024 08:42:50 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 399/437] macintosh: via-pmu: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:59 -0600
Message-ID: <20240411153126.16201-400-axboe@kernel.dk>
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
 drivers/macintosh/via-pmu.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 9d5703b60937..b7f11200949d 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2165,12 +2165,11 @@ pmu_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t 
-pmu_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t pmu_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct pmu_private *pp = file->private_data;
+	struct pmu_private *pp = iocb->ki_filp->private_data;
 	DECLARE_WAITQUEUE(wait, current);
+	size_t count = iov_iter_count(to);
 	unsigned long flags;
 	int ret = 0;
 
@@ -2190,7 +2189,7 @@ pmu_read(struct file *file, char __user *buf,
 			spin_unlock_irqrestore(&pp->lock, flags);
 			if (ret > count)
 				ret = count;
-			if (ret > 0 && copy_to_user(buf, rp->data, ret))
+			if (ret > 0 && !copy_to_iter_full(rp->data, ret, to))
 				ret = -EFAULT;
 			if (++i >= RB_SIZE)
 				i = 0;
@@ -2199,7 +2198,7 @@ pmu_read(struct file *file, char __user *buf,
 		}
 		if (ret >= 0)
 			break;
-		if (file->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			break;
 		ret = -ERESTARTSYS;
 		if (signal_pending(current))
@@ -2215,9 +2214,7 @@ pmu_read(struct file *file, char __user *buf,
 	return ret;
 }
 
-static ssize_t
-pmu_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t pmu_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return 0;
 }
@@ -2464,8 +2461,8 @@ static long compat_pmu_ioctl (struct file *filp, u_int cmd, u_long arg)
 #endif
 
 static const struct file_operations pmu_device_fops = {
-	.read		= pmu_read,
-	.write		= pmu_write,
+	.read_iter	= pmu_read,
+	.write_iter	= pmu_write,
 	.poll		= pmu_fpoll,
 	.unlocked_ioctl	= pmu_unlocked_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.43.0


