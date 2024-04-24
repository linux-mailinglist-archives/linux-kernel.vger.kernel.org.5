Return-Path: <linux-kernel+bounces-156468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7608B0308
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDE3287069
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3613A159581;
	Wed, 24 Apr 2024 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/aXbAwH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8D15921D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943118; cv=none; b=tZ+WMjD64+Za19NHdqlJkAUzfnnazRwAAAVtQLnew8aEPpqdMZdSmTL7kGml3XzwQkOvwJPXhOAvlq2mOwXPz1E1xwBzX2teGaUeJvDANjjFc0bI4QDlLIyfjhfC0OwBcrHAfRwsj0r4m+0invsArZPL+F1EKLPljRRxZyOrKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943118; c=relaxed/simple;
	bh=/1o0n4Ebp46skvfPhfQVbRqVGbg2E5kjrPg92uVgV3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OvVQgiidxZVld6O9WHVQwUJNoQ3e6m5+SDNJ9EWhAztP1TBL+fyn58eVCQ+tmeSOyfdkvMPxDx/Ny4bNwQUgeErhEs4m5mOWHe78qxve/llFhrjHrlOwD4r0HGokYgVupykf0YKwK8erv9BzlfkxERyAJ9nJJEwYGJ9pnUBhD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/aXbAwH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943117; x=1745479117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/1o0n4Ebp46skvfPhfQVbRqVGbg2E5kjrPg92uVgV3s=;
  b=F/aXbAwHH7XqUc7rlRYWXvD/CmDw4yky37A4dF6SC69rXRCV7aM2wl+c
   b0xFCVQPNczNG61DXY3c6WQUNw4tVHasXAk+iB60pjwaD+kWsnmMACyu+
   t4/xIUWSJ9gN8XO0CFZIid3LJF1Xte9uN5Y9zTXoIh0hAPBl/b9z4oK16
   b4mLVmjwvBKIatC03lkNxbt23Thw9hHUuZig9aL0FGcDxL75NMpFW5rbN
   ymVG7Ua9+a9U974qp+mhPH3Ngsqcr1IZ0L3+iHt+1sdNemhOpxvTYoDGN
   bVQ1dyPll5aK6zI7zR5Ytaf3HtIOZW+5iqUshe/4f7ZqZx5MHCLy8w2iP
   w==;
X-CSE-ConnectionGUID: U0qdYfGGRleklqch74TW8g==
X-CSE-MsgGUID: 3h9Ch/AdSfWw15/sYM/6ow==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073207"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073207"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:37 -0700
X-CSE-ConnectionGUID: i7sjaFeKSJSoYuE4+8mGrA==
X-CSE-MsgGUID: F6BQhTMMRO+cs0MKhuSuDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665518"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/18] iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map
Date: Wed, 24 Apr 2024 15:16:38 +0800
Message-Id: <20240424071644.178250-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iotlb_sync_map callback is called by the iommu core after non-present
to present mappings are created. The iommu driver uses this callback to
invalidate caches if IOMMU is working in caching mode and second-only
translation is used for the domain. Use cache_tag_flush_range_np() in this
callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-7-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f3926ad7d737..c9ac8a1b635f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1501,20 +1501,6 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
-/* Notification for newly created mappings */
-static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *domain,
-				 unsigned long pfn, unsigned int pages)
-{
-	/*
-	 * It's a non-present to present mapping. Only flush if caching mode
-	 * and second level.
-	 */
-	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
-		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
-	else
-		iommu_flush_write_buffer(iommu);
-}
-
 /*
  * Flush the relevant caches in nested translation if the domain
  * also serves as a parent
@@ -4544,14 +4530,8 @@ static bool risky_device(struct pci_dev *pdev)
 static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				      unsigned long iova, size_t size)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long pages = aligned_nrpages(iova, size);
-	unsigned long pfn = iova >> VTD_PAGE_SHIFT;
-	struct iommu_domain_info *info;
-	unsigned long i;
+	cache_tag_flush_range_np(to_dmar_domain(domain), iova, iova + size - 1);
 
-	xa_for_each(&dmar_domain->iommu_array, i, info)
-		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
 	return 0;
 }
 
-- 
2.34.1


