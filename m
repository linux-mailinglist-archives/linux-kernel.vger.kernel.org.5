Return-Path: <linux-kernel+bounces-141170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C738A1AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97071F21352
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0101F593C;
	Thu, 11 Apr 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HHSgxvfl"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0681F4FDB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850153; cv=none; b=HJt094A6fcTcVHKWzJminVDTth2sv5eMueIE9UAbU3ySjgEdDgCpJtHfH7NuBxZm65mas16F0o4IFgP3njjMrQNRcllDsK5ZNc9p8cl3REgCd2QHEcG8/qdPOAQesGe/Bz7R7voL/PKMViUqb+dlapcm6cxOTVzcmRnXs4iHSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850153; c=relaxed/simple;
	bh=/TmKVj6QrFz5D6lqwelXnvkAyOg4q25RyrSZJGRCLVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC9dLWH1W56HIl/vLRC6+sdh3i3KDhrycX8q/9J5RL0fLIIjrCnjJoAmalBTn9CL2iLPNT0gms20Y4SJsjjDuytw5Fbl2D+W6Mn0Rmzkf3XY91K8KMOejCqXLmcQPKXlFR3dS8JIeoLZTEi1tu2ji0kRAQxR96e9KT+VUF7tRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HHSgxvfl; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170648739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850151; x=1713454951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBZc5uxf3CGdYoNH6FdAMCMGz4jF4JP+JkOREkCFKTQ=;
        b=HHSgxvflUUbm1HYXtnqsanQ9r2zkGsxD1CdElIQf4YWGUSla9WePyK/17JlAp2jBUU
         fI6VRSzD/GwVfG4PFNPsXvbIj1hd0L3fPGeKU12f6kaTdQ1QGwBN2ue0mFOPpZ9KOjTs
         nFE/14zlyH5kS9NEfcXyIv+o2myFyh0cazjWI/ckUw1sALkkbqtf3uyoAV/2hrzlVd/N
         7L7md/n1I9Y29EfZfzeKhVKm2KfRoquiROzEz0tZRGiC4rEd6jbrz6HadTOemkOMqomi
         XbKZRDZoV0M9zwf8b39P+bpWLAVJM5QzywSdKk24ls+nQn8dlzL6OM+qc7IGlfnGfIr6
         Qfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850151; x=1713454951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBZc5uxf3CGdYoNH6FdAMCMGz4jF4JP+JkOREkCFKTQ=;
        b=NZJ71vUbY/o0XYfkIL8GrhtmuT15gfY8RIlXcrh9gMqWScQrpl6nkRAZR0BCefRJUG
         upzLV30fwcncvQqGXhsdN6TMk4ZwVoBJdgzZBjv23tON4VMdcd7Qn1B9wIDihmt7kkOS
         /iTCZ0rwaWYVuPSUvWIRjLDtFJFAjLxBIZCiS5XMBfZKO5Ri5W29Jb87rxwihVBgafWh
         ZqiiCChARvrm2nSzm+Y9BEM+sBcS+tnDndyzQlXRLcIYIw75O/3MYH1+T0XtsRcJte+I
         KGwEFAOE29zKnd3Fl0OMxyJRLXbjnuuigKGlLMmfGra6EVP+Bj56ZrqVwfz23pVwyOAC
         PVow==
X-Gm-Message-State: AOJu0Yww+Gkr3ABO6TwE2jFk1Fh5tSRKv8/Aamqpz9pqfzXrjA4slvAc
	YiRAtqo5GYDLBHHIafEjlQ8lZV5vP6mgADUIAy7kFLPksJyJcXkx1x87l85fCZRZTIM2JJsNkNK
	H
X-Google-Smtp-Source: AGHT+IFD/76P5Aiy4i/eM7EiFFZZOKJHZtnaN20NiQPGPSKnDKg1/Jb+aYrVZY/2TRnZ4D2xSnxfJw==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr198122ioj.2.1712850150717;
        Thu, 11 Apr 2024 08:42:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 387/437] EDAC/xgene: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:47 -0600
Message-ID: <20240411153126.16201-388-axboe@kernel.dk>
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
 drivers/edac/xgene_edac.c | 43 ++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 1b50f8160013..deabb9743f9e 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -137,11 +137,10 @@ struct xgene_edac_mc_ctx {
 	u32			mcu_id;
 };
 
-static ssize_t xgene_edac_mc_err_inject_write(struct file *file,
-					      const char __user *data,
-					      size_t count, loff_t *ppos)
+static ssize_t xgene_edac_mc_err_inject_write(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct mem_ctl_info *mci = file->private_data;
+	struct mem_ctl_info *mci = iocb->ki_filp->private_data;
 	struct xgene_edac_mc_ctx *ctx = mci->pvt_info;
 	int i;
 
@@ -150,12 +149,12 @@ static ssize_t xgene_edac_mc_err_inject_write(struct file *file,
 		       MCU_ESRR_DEMANDUCERR_MASK | MCU_ESRR_CERR_MASK,
 		       ctx->mcu_csr + MCUESRRA0 + i * MCU_RANK_STRIDE);
 	}
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations xgene_edac_mc_debug_inject_fops = {
 	.open = simple_open,
-	.write = xgene_edac_mc_err_inject_write,
+	.write_iter = xgene_edac_mc_err_inject_write,
 	.llseek = generic_file_llseek,
 };
 
@@ -803,11 +802,10 @@ static void xgene_edac_pmd_hw_ctl(struct edac_device_ctl_info *edac_dev,
 	}
 }
 
-static ssize_t xgene_edac_pmd_l1_inject_ctrl_write(struct file *file,
-						   const char __user *data,
-						   size_t count, loff_t *ppos)
+static ssize_t xgene_edac_pmd_l1_inject_ctrl_write(struct kiocb *iocb,
+						   struct iov_iter *from)
 {
-	struct edac_device_ctl_info *edac_dev = file->private_data;
+	struct edac_device_ctl_info *edac_dev = iocb->ki_filp->private_data;
 	struct xgene_edac_pmd_ctx *ctx = edac_dev->pvt_info;
 	void __iomem *cpux_pg_f;
 	int i;
@@ -826,16 +824,16 @@ static ssize_t xgene_edac_pmd_l1_inject_ctrl_write(struct file *file,
 		       MEMERR_CPU_MMUESR_CERR_MASK,
 		       cpux_pg_f + MEMERR_CPU_MMUESRA_PAGE_OFFSET);
 	}
-	return count;
+	return iov_iter_count(from);
 }
 
-static ssize_t xgene_edac_pmd_l2_inject_ctrl_write(struct file *file,
-						   const char __user *data,
-						   size_t count, loff_t *ppos)
+static ssize_t xgene_edac_pmd_l2_inject_ctrl_write(struct kiocb *iocb,
+						   struct iov_iter *from)
 {
-	struct edac_device_ctl_info *edac_dev = file->private_data;
+	struct edac_device_ctl_info *edac_dev = iocb->ki_filp->private_data;
 	struct xgene_edac_pmd_ctx *ctx = edac_dev->pvt_info;
 	void __iomem *pg_e = ctx->pmd_csr + CPU_MEMERR_L2C_PAGE;
+	size_t count = iov_iter_count(from);
 
 	writel(MEMERR_L2C_L2ESR_MULTUCERR_MASK |
 	       MEMERR_L2C_L2ESR_MULTICERR_MASK |
@@ -848,11 +846,11 @@ static ssize_t xgene_edac_pmd_l2_inject_ctrl_write(struct file *file,
 static const struct file_operations xgene_edac_pmd_debug_inject_fops[] = {
 	{
 	.open = simple_open,
-	.write = xgene_edac_pmd_l1_inject_ctrl_write,
+	.write_iter = xgene_edac_pmd_l1_inject_ctrl_write,
 	.llseek = generic_file_llseek, },
 	{
 	.open = simple_open,
-	.write = xgene_edac_pmd_l2_inject_ctrl_write,
+	.write_iter = xgene_edac_pmd_l2_inject_ctrl_write,
 	.llseek = generic_file_llseek, },
 	{ }
 };
@@ -1143,21 +1141,20 @@ static void xgene_edac_l3_hw_init(struct edac_device_ctl_info *edac_dev,
 	}
 }
 
-static ssize_t xgene_edac_l3_inject_ctrl_write(struct file *file,
-					       const char __user *data,
-					       size_t count, loff_t *ppos)
+static ssize_t xgene_edac_l3_inject_ctrl_write(struct kiocb *iocb,
+					       struct iov_iter *from)
 {
-	struct edac_device_ctl_info *edac_dev = file->private_data;
+	struct edac_device_ctl_info *edac_dev = iocb->ki_filp->private_data;
 	struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
 
 	/* Generate all errors */
 	writel(0xFFFFFFFF, ctx->dev_csr + L3C_ESR);
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations xgene_edac_l3_debug_inject_fops = {
 	.open = simple_open,
-	.write = xgene_edac_l3_inject_ctrl_write,
+	.write_iter = xgene_edac_l3_inject_ctrl_write,
 	.llseek = generic_file_llseek
 };
 
-- 
2.43.0


