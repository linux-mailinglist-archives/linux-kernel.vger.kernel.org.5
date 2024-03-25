Return-Path: <linux-kernel+bounces-116416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A830889AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38281F34C36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B048149C65;
	Mon, 25 Mar 2024 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeEqZZyo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E333155387
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333105; cv=none; b=TzZaUjMGP7j+Wuv8sTVZiIgH+SYLooPVeNQG6bHx36ZL2ByO/FM0oKAf36gr+w9JcDhOUJ2Oe+H4Zy6Oh3iuSLa40Y+jfxCIEwxkZTvzngvX+I1e/FLBg2L5/aiHDBqoN0XkIHCanXXF/t/nVc+H9tI8IvqDkrOtxoGRe9J2RuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333105; c=relaxed/simple;
	bh=GRqfeV/YKXedxQfVodmQRhJEmBymUSTAs5i+B3DOhSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/8yuuObfnG0VwC9w4v14bCMm5vx3IB4568j3uU0TzTEgqlOvPlJ3E4/XHubwN4J3chgaHWkhz7XIBNphECu7tvyHt8jFGYoZ/YKvnEH21f3m8n7jUIFaL7ifexJUuN/TORceaBBJl/hLdhbwUUdkCtjDOPYzQyI+vtnk4O4Hxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeEqZZyo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333103; x=1742869103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GRqfeV/YKXedxQfVodmQRhJEmBymUSTAs5i+B3DOhSQ=;
  b=GeEqZZyotNUsS0tBN7Zix89M/XBFhO2RyxknBL49qCKPtqhKNgyRW/+e
   qV1AaOW+WVakmKebq2x6nu5xucea91DKQI6RotWa8Nn457qIs76iqiggN
   VFgfNGBMijH2Ulcuka9M4daxvjEFvW8ns5wUB6EhulWRqJIjOjSD6ZkKx
   798Q6zqC9TPr6E5bIbh7Tt6pbCUfa1Jf142/Dmi0KH9a3Pjl3pD8zjszw
   Mn32WWOSfFC2LzYHM3w4Tca9nG+aXoaeL4kSxAPm+wEYO4jHdiIaci9hV
   zhxt3P8s4pQcYP8VkZrosGLEZ+7pC7DMM/wUsaAaqVZnl3OS01SjygvY9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271409"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271409"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353986"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 08/12] iommu/vt-d: Use cache_tag_flush_range() in cache_invalidate_user
Date: Mon, 25 Mar 2024 10:17:01 +0800
Message-Id: <20240325021705.249769-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325021705.249769-1-baolu.lu@linux.intel.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cache_invalidate_user callback is called to invalidate a range
of caches for the affected user domain. Use cache_tag_flush_range()
in this callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/nested.c | 50 +++---------------------------------
 1 file changed, 3 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 85c744099558..e251507cfcc0 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -90,50 +90,6 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	kfree(dmar_domain);
 }
 
-static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
-				   unsigned int mask)
-{
-	struct device_domain_info *info;
-	unsigned long flags;
-	u16 sid, qdep;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		if (!info->ats_enabled)
-			continue;
-		sid = info->bus << 8 | info->devfn;
-		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				   qdep, addr, mask);
-		quirk_extra_dev_tlb_flush(info, addr, mask,
-					  IOMMU_NO_PASID, qdep);
-	}
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
-static void intel_nested_flush_cache(struct dmar_domain *domain, u64 addr,
-				     u64 npages, bool ih)
-{
-	struct iommu_domain_info *info;
-	unsigned int mask;
-	unsigned long i;
-
-	xa_for_each(&domain->iommu_array, i, info)
-		qi_flush_piotlb(info->iommu,
-				domain_id_iommu(domain, info->iommu),
-				IOMMU_NO_PASID, addr, npages, ih);
-
-	if (!domain->has_iotlb_device)
-		return;
-
-	if (npages == U64_MAX)
-		mask = 64 - VTD_PAGE_SHIFT;
-	else
-		mask = ilog2(__roundup_pow_of_two(npages));
-
-	nested_flush_dev_iotlb(domain, addr, mask);
-}
-
 static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 					      struct iommu_user_data_array *array)
 {
@@ -166,9 +122,9 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 			break;
 		}
 
-		intel_nested_flush_cache(dmar_domain, inv_entry.addr,
-					 inv_entry.npages,
-					 inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
+		cache_tag_flush_range(dmar_domain, inv_entry.addr,
+				      inv_entry.npages,
+				      inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
 		processed++;
 	}
 
-- 
2.34.1


