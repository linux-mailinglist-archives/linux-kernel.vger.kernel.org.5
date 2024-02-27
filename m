Return-Path: <linux-kernel+bounces-82914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D45868BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453CF1F26704
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CC7135A76;
	Tue, 27 Feb 2024 09:08:40 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1D130E48
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024919; cv=none; b=WVZHhxGhsxi+tDUN/eYuSOSohchfKx6fPvOM1nqYgKa6fMZfaK6039wTccJY1bLJybK2W/bi6gIVF6b7m95PRmjkNYCt75I9bcU1sEsvAC51QCZEPtq0mUSWUNIutlO6IiK1VBQya7pWrSJwBRMOJ3CxhE4ACumu5MVEZvqwnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024919; c=relaxed/simple;
	bh=4y3auR9ZFQJVKaWZhm/jQx73STqxJwt0TCa3O86c7wg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fNEOl76UOW1Q57IcbdAjOvNY/zE3XRY0/PUVXmB03rK+Y40V5krC6aiCco8nknN9iGdGInGRB2DQF0nmfohUgOP/wAXrC5tSCCpi6WJw7Yvc5nuJyU8fQgxmvTk8HVKmRev4qYVvZ1K9sRkhya8XT42koL3d84er+d0fGpvfRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 578ce892ad7f4978a22c0a79f4683b34-20240227
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a86c1dd0-e596-489f-8b24-d35778460107,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.37,REQID:a86c1dd0-e596-489f-8b24-d35778460107,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:0c5943ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:240227170833P4X2TS94,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 578ce892ad7f4978a22c0a79f4683b34-20240227
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1177903341; Tue, 27 Feb 2024 17:08:29 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Cong Liu <liucong2@kylinos.cn>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/fsl_pamu: Simplify IOVA cache allocation with KMEM_CACHE() in fsl_pamu_domain.c
Date: Tue, 27 Feb 2024 17:08:25 +0800
Message-Id: <20240227090826.82475-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 drivers/iommu/fsl_pamu_domain.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index e9d2bff4659b..61c47ecfe6b0 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -31,21 +31,13 @@ static struct fsl_dma_domain *to_fsl_dma_domain(struct iommu_domain *dom)
 
 static int __init iommu_init_mempool(void)
 {
-	fsl_pamu_domain_cache = kmem_cache_create("fsl_pamu_domain",
-						  sizeof(struct fsl_dma_domain),
-						  0,
-						  SLAB_HWCACHE_ALIGN,
-						  NULL);
+	fsl_pamu_domain_cache = KMEM_CACHE(fsl_dma_domain, SLAB_HWCACHE_ALIGN);
 	if (!fsl_pamu_domain_cache) {
 		pr_debug("Couldn't create fsl iommu_domain cache\n");
 		return -ENOMEM;
 	}
 
-	iommu_devinfo_cache = kmem_cache_create("iommu_devinfo",
-						sizeof(struct device_domain_info),
-						0,
-						SLAB_HWCACHE_ALIGN,
-						NULL);
+	iommu_devinfo_cache = KMEM_CACHE(device_domain_info, SLAB_HWCACHE_ALIGN);
 	if (!iommu_devinfo_cache) {
 		pr_debug("Couldn't create devinfo cache\n");
 		kmem_cache_destroy(fsl_pamu_domain_cache);
-- 
2.34.1


