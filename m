Return-Path: <linux-kernel+bounces-140981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D28A1A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B69B2CBC3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ED682496;
	Thu, 11 Apr 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="j3hkh06g"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7543BBC7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849855; cv=none; b=Lx4MJ8v4/h9A+AbznfRKFPjfblVbDoLu23PoN/Mf5hdvIJuE6KgfxiGO99wXa2x7x7foZZ2Mvy1vYKAwi8FDd5t2AC8n7vcVdW7hseFv2LI4i/YsMIS0OvQzFFZxe/OwI0avS70SZyjCUsbc7MzGUV2lxpwNadoDrX02BLdCYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849855; c=relaxed/simple;
	bh=Jj/NcxDqsb3ke7CqA5w00fJhJUeMhJsECJ2fjtlkHS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9UC9AUO8JowJiSOELuknWLpwatsNGL0qI4mfoWk63Nfw9NLOHqshFUHz1+hpEusRu91ujBUN/ZUCv8qUOWKQVTKLBiXCF+DwCAdbzo3/1tycA5oM1soGOoNhlpKB8G3/f2mUx5Bm9KYSQlCKJt8uvDPgIxx2VXmWDdLNFTDbEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=j3hkh06g; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8975039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849853; x=1713454653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnCvDuWCdqbx45susY4lKXAhNpbfLhWCqwRwbKGo0sM=;
        b=j3hkh06gB1K16vvNeTGw35z4a4FteMe8rQBdc1aCAr2HaSM2JolvR3Zn3QySJdRIM3
         FroRnDJPlzr8s63o6Ye8ujfdxPGz3sE1gExYQlepRgrOLu29S6Bg9i+jQTPXnuVo+pcG
         FCNSYky3VJvRljPjdpdBJUpum0GDGcyg/FIPHmqPJlfeqagEiOiT3Dp+3uQydlyGsBaM
         F/haa/BdY3hkpu4veaCtBg6piyt8nBu2a3dO3JTdc9GlTq4tWbsz9yg/bcPruELfm5qc
         sfqa4sjJ59C9PrHJ7ab5bffSA7pe9NeEL8EcxidOblSUGap1AS4QrMGOAwYLXu+yFewp
         k7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849853; x=1713454653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnCvDuWCdqbx45susY4lKXAhNpbfLhWCqwRwbKGo0sM=;
        b=lUDB8C8LmIwOMbLqp67gweZYdkiJyJI3QYiwWazpDHutcPv68IRKZM06cdiKHpg8gB
         HLDSH+YX5jMXDtg1oOfVZVo3myE8V24T8O7+NHVK+L54AU110YwUjHPzziVSQz1K9qsj
         LocBOy3WmP2bjSFXLE5TdcstN2CySMwjbM2o9VxFv3Fnizn5ekG7yKfWSeHIgi11XLxI
         9VtsKyD7OOcy8VB29KuRpQ2AFTKag7BPKU4mdJWmErR+bZBCN57+S6M5DZq1UNpoF1Zq
         QFALgS4v23XHmwysspkA9X9TSm5XIPgFHSEGlsRLF56MchoYQFw9pcE/gn4PRd04oxTE
         TTxg==
X-Gm-Message-State: AOJu0Yy02OLeXH+am4a+VrTTAkcfYayCoTW2bqqYuLOVbblyO+gNgopm
	8++BcaqQzxlr4bz8HVk3CP0cwhMI+dNBHdOfNecwIkzVpiUSY78hKvQiERXIewEBa7rAnuHRxTy
	X
X-Google-Smtp-Source: AGHT+IFP88+t14a0gCZ4AAPs0EFTnm4sLMkslOZbEiO0AB3P/WW3J3e5pySiphlIuoPzja9E1UjhrQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr19999ioc.1.1712849853069;
        Thu, 11 Apr 2024 08:37:33 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 211/437] drivers/iommu: convert omap to read/write iterators
Date: Thu, 11 Apr 2024 09:15:51 -0600
Message-ID: <20240411153126.16201-212-axboe@kernel.dk>
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
 drivers/iommu/omap-iommu-debug.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 259f65291d90..46798b7584b5 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <linux/pm_runtime.h>
 #include <linux/debugfs.h>
 #include <linux/platform_data/iommu-omap.h>
@@ -80,10 +81,10 @@ static ssize_t omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf,
 	return bytes;
 }
 
-static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
-			       size_t count, loff_t *ppos)
+static ssize_t debug_read_regs(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct omap_iommu *obj = file->private_data;
+	struct omap_iommu *obj = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	char *p, *buf;
 	ssize_t bytes;
 
@@ -100,7 +101,7 @@ static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 	bytes = omap_iommu_dump_ctx(obj, p, count);
 	if (bytes < 0)
 		goto err;
-	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, bytes);
+	bytes = simple_copy_to_iter(buf, &iocb->ki_pos, bytes, to);
 
 err:
 	mutex_unlock(&iommu_debug_lock);
@@ -231,7 +232,7 @@ static int pagetable_show(struct seq_file *s, void *data)
 #define DEBUG_FOPS_RO(name)						\
 	static const struct file_operations name##_fops = {	        \
 		.open = simple_open,					\
-		.read = debug_read_##name,				\
+		.read_iter = debug_read_##name,				\
 		.llseek = generic_file_llseek,				\
 	}
 
-- 
2.43.0


