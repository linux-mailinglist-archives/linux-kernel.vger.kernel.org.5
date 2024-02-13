Return-Path: <linux-kernel+bounces-63977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B6853750
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A749C1C25D86
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72255FEFF;
	Tue, 13 Feb 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK4klttw"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711BF5FBB5;
	Tue, 13 Feb 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845037; cv=none; b=LAepyukHRI1EK9eFu8yvvdIis/WTnOrAwjknEInK1VNt6qef/SzK0tEcVy4LFSwrMeGXHFqGkb+71W687vMwnjuBjbcy5FV+Im+nxiXa8NQR40qZaFCVnWcHBAmB6+Bi8mL9Zv7fFSbPpXLnYAqH0vfig4CL1boJ5IjCEfzWBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845037; c=relaxed/simple;
	bh=dDpCLvWQKOk3BjtpUjlDBZpyD2zOJJDETC/CzEEyr0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOdYBMxmUs04PEpabJlysQq3/YaN5v9cDqkvyrIgRIJpPOvs3y9vHBCq7PvbhrO0N+e3Av4ruM3Pc5r636NhT3dnpxuyxXkUc7SxkOKgQ3Kmt2JfwHpdLg58CtQoLsDCLXyXU2g8bSZRhZOtItKhP0Hno85gI7BK/jsAUOMSBZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK4klttw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d746856d85so34470335ad.0;
        Tue, 13 Feb 2024 09:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707845036; x=1708449836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLsvLF6QUYIuVDvvapHTNMgjuAm/e6T5t1iBfk2PvVA=;
        b=dK4klttwb+EYPPLDqBEsqX9jvSq+9mt/xie3lNOB9ZcudJPCSNiN/L5QVA5pooqINf
         szP6+o1qo6LNK4e6B4/LUFEwJHIS5tBeaDvbIYHxaccsXgX0z72pdSgQYQd0hgL8zRCh
         Oga5t0cZVSD9V/F7dL8j3n/WSBvZffqZd1taKZ6UOv4oOHaVOa7/eAY7BkV3WJA72k0A
         FuSfS/sa5E8XE4M58TO64nHfnCUDN6PwASs9Hk02IJ2miYDwR7Zd1/ROWEM0sBKvfIzX
         F0SpR6ZWtP9X5swHiCkCgD/ls9l4i0E2/gQVC/s9baJDYN7L2HFjOjBlhMIfPsaFympl
         b/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845036; x=1708449836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLsvLF6QUYIuVDvvapHTNMgjuAm/e6T5t1iBfk2PvVA=;
        b=xKTheJG5/bEjryS8e3rtb+9X8dnnqZ85AZhmL7zi1Ytf9+JJ6iU98eJTf9dtE45JYM
         NhOvG+BCzvY4xMKD7a+MiiOXPzeHgYsNH4E1oR8ddPoLRu70/3dCA4/RJ2aYQcmigqXf
         KGbvImMjYoD7wz0zjbuRxAHOVXgZd8124cfPBgxV8q8+VewJ1RMio6h2BoZYREnbzpnB
         JS/WTCji07a3IpO8hK85gi3k23DFL8NjlQoZjxRrT0OkgxRj3FS1Tvr+nKsipEOs0l2X
         12UIFAg+nQrFVbJwkm57VUObL/ndFyVhqnLDvEEwvVjeBq0Ry2qMk9kxIkHj2/Tx/rAO
         znzA==
X-Forwarded-Encrypted: i=1; AJvYcCUWzz5V5TCdp3P0R+HZxXglzcN51sO2TseB3rOSMMLSvKaSKZc+06uVtQE0uN5rH0UDRhxJpVnXdXlksZjq13QdBFmioySlpAH1GN0RbB15XSjCGuKxtBKYaYL4TPCpDLL9TyvwSrPT68+kDw==
X-Gm-Message-State: AOJu0YzMWjTWTrdM1WKyUJ7hLgPs0JYULyI7lHPlddUogI7UjOBieJj3
	pF7YUgoH6BmUnAOnb6xVXbBZxQ/PFjAb/jk9blsSbIEaBiBzVPBL
X-Google-Smtp-Source: AGHT+IFdCtLRJdOgW5lz/LKUTdPO1GdknYEPgh4plB438nRYmiTFekiGe0mNbi1gtuZvBC3Wkqh5tg==
X-Received: by 2002:a17:902:a513:b0:1d9:95c5:2975 with SMTP id s19-20020a170902a51300b001d995c52975mr125039plq.26.1707845035585;
        Tue, 13 Feb 2024 09:23:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAFLBoxwayfeJdOdJaLCxj9/95+M2cVx1lDK2IAY9ThXhNwuF4KeCLrS4JDMp0iqN6EfuCmO7l9e8PHQAgmy3E0INegBYNWJgFxtaMPbuNpnhagHlEdJ6w8MAWCkocA6iKwrLBZ/wa4OVpGCszewOZbb4FxAaqYzYPZ3V3r9UTPEA2r14cjRHEWiHjD1tJnIU0AET3h7j8BUGrmfH6ob9zZdonbDEw6/SvphIu1Q3gf3efi0ZbAa/6w3sTHtJOBigYsnFgwURz0IFUQ/oJ0Wul/6JAduUtId73OTDJzZO6P4Uz2X/ax7dQ16lTv6Warszu7FYFcFBH7NX0fO2BL4cDh2jcFpFGTj+PRNM8l6n8GeO7lHnyd/kFm5wgX95qfYF8FkrsTLG9KLVz7V0KgSpteOgN/js64aATrk/3gZgiCOEPtlWY+TfgePm25yXld+liWX9G/TeIIfpiWyK1doIj/kptuDHMSI9srQ==
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902bd8200b001d9fc826522sm2321775pls.239.2024.02.13.09.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:23:55 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <andersson@kernel.org>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Wire up tlb ops
Date: Tue, 13 Feb 2024 09:23:40 -0800
Message-ID: <20240213172340.228314-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

The brute force iommu_flush_iotlb_all() was good enough for unmap, but
in some cases a map operation could require removing a table pte entry
to replace with a block entry.  This also requires tlb invalidation.
Missing this was resulting an obscure iova fault on what should be a
valid buffer address.

Thanks to Robin Murphy for helping me understand the cause of the fault.

Cc: Robin Murphy <robin.murphy@arm.com>
Fixes: b145c6e65eb0 ("drm/msm: Add support to create a local pagetable")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 5cc8d358cc97..d5512037c38b 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -21,6 +21,8 @@ struct msm_iommu_pagetable {
 	struct msm_mmu base;
 	struct msm_mmu *parent;
 	struct io_pgtable_ops *pgtbl_ops;
+	const struct iommu_flush_ops *tlb;
+	struct device *iommu_dev;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	phys_addr_t ttbr;
 	u32 asid;
@@ -201,11 +203,33 @@ static const struct msm_mmu_funcs pagetable_funcs = {
 
 static void msm_iommu_tlb_flush_all(void *cookie)
 {
+	struct msm_iommu_pagetable *pagetable = cookie;
+	struct adreno_smmu_priv *adreno_smmu;
+
+	if (!pm_runtime_get_if_in_use(pagetable->iommu_dev))
+		return;
+
+	adreno_smmu = dev_get_drvdata(pagetable->parent->dev);
+
+	pagetable->tlb->tlb_flush_all((void *)adreno_smmu->cookie);
+
+	pm_runtime_put_autosuspend(pagetable->iommu_dev);
 }
 
 static void msm_iommu_tlb_flush_walk(unsigned long iova, size_t size,
 		size_t granule, void *cookie)
 {
+	struct msm_iommu_pagetable *pagetable = cookie;
+	struct adreno_smmu_priv *adreno_smmu;
+
+	if (!pm_runtime_get_if_in_use(pagetable->iommu_dev))
+		return;
+
+	adreno_smmu = dev_get_drvdata(pagetable->parent->dev);
+
+	pagetable->tlb->tlb_flush_walk(iova, size, granule, (void *)adreno_smmu->cookie);
+
+	pm_runtime_put_autosuspend(pagetable->iommu_dev);
 }
 
 static void msm_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
@@ -213,7 +237,7 @@ static void msm_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
 {
 }
 
-static const struct iommu_flush_ops null_tlb_ops = {
+static const struct iommu_flush_ops tlb_ops = {
 	.tlb_flush_all = msm_iommu_tlb_flush_all,
 	.tlb_flush_walk = msm_iommu_tlb_flush_walk,
 	.tlb_add_page = msm_iommu_tlb_add_page,
@@ -254,10 +278,10 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 
 	/* The incoming cfg will have the TTBR1 quirk enabled */
 	ttbr0_cfg.quirks &= ~IO_PGTABLE_QUIRK_ARM_TTBR1;
-	ttbr0_cfg.tlb = &null_tlb_ops;
+	ttbr0_cfg.tlb = &tlb_ops;
 
 	pagetable->pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1,
-		&ttbr0_cfg, iommu->domain);
+		&ttbr0_cfg, pagetable);
 
 	if (!pagetable->pgtbl_ops) {
 		kfree(pagetable);
@@ -279,6 +303,8 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 
 	/* Needed later for TLB flush */
 	pagetable->parent = parent;
+	pagetable->tlb = ttbr1_cfg->tlb;
+	pagetable->iommu_dev = ttbr1_cfg->iommu_dev;
 	pagetable->pgsize_bitmap = ttbr0_cfg.pgsize_bitmap;
 	pagetable->ttbr = ttbr0_cfg.arm_lpae_s1_cfg.ttbr;
 
-- 
2.43.0


