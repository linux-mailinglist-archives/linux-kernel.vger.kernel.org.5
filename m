Return-Path: <linux-kernel+bounces-137822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C206489E809
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824581F24345
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9F217557;
	Wed, 10 Apr 2024 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKqjgZbq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C8134DE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715019; cv=none; b=kxuCQ3DWqqUM1PJvEAavEr0JirOVKM/59WOLX4+O6YAlkRTRW5m6lCVhyhubGnBN0uveo3HvBdvo+pzuDZuT8vPL9eSTzaJahpCwXd4dZNclfKPmlCLN+LzVw4XA8vESoaISxwtY0erNS2KWzCigElzTgZFpLgoFBwVaeqELkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715019; c=relaxed/simple;
	bh=dO88KW9d3p1OgtVTAKsTq/85V6RpBoSSDsD9RVywS+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRLC3piLmRQrrOJPFMViHT9TZSkiBPS4mU6rWCeH+tKq/KtXNL9Ol/CKZ6pyqKuDCucxtzWqDx5FKVzY3B0A6CWKWoraZ+32xXekwzXBZVtJFCea9kWQ7Wt+Yg3jJ7gF6+hpbOy3XqDljxEPRVlNQxZ7Dy+pyc36qHEbs3Z1L5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKqjgZbq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712715018; x=1744251018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dO88KW9d3p1OgtVTAKsTq/85V6RpBoSSDsD9RVywS+w=;
  b=OKqjgZbqf4JRlx0MXZZXFSl4NdTTuC9casBc5cT27k3voNBuwUF1/0Rz
   2zTnjwxw7AkDtCq1PvZVfV3AWlVNam4GqtJucVOZjqPUi6J8v3A2wjvXo
   +sxLTziG4HlDj7KTQGepVb6iACOQ8NVkbLX5UTpn61vz75TyduvqO3/FY
   RPlM+jTymlOVdFpvamhGiisOS5WebQIGEBz0r/jJW2dYQ98JlCDDpj7O8
   L2R/va1G7W5eeccpPNF/uGqgh/GGdbnx52ZNyVIGNq/Gl82w68/hRwfvt
   YAlUzWuied1BP9hE8EFIxWH453g5CusKfoEoxskYj3ZvMOH2PH2ISHlLW
   g==;
X-CSE-ConnectionGUID: tCLe/U9HTxaDINWafyV8fA==
X-CSE-MsgGUID: +kmxrH8nRvSQfP9HFwbySw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7918585"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7918585"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:10:18 -0700
X-CSE-ConnectionGUID: PcONbFTAQq6ptB1lvuQtGQ==
X-CSE-MsgGUID: Z8KDwvKsRM+sCncRQ7g32w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20478902"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2024 19:10:15 -0700
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
Subject: [PATCH v2 06/12] iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map
Date: Wed, 10 Apr 2024 10:08:38 +0800
Message-Id: <20240410020844.253535-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410020844.253535-1-baolu.lu@linux.intel.com>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8ec69f09935d..ee5cac6ce4af 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1500,20 +1500,6 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
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
@@ -4538,14 +4524,8 @@ static bool risky_device(struct pci_dev *pdev)
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


