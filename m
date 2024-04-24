Return-Path: <linux-kernel+bounces-156467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE48B0306
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012111F24DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6778159567;
	Wed, 24 Apr 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0Oga4dI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B7159202
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943117; cv=none; b=aSqMVtRr3LGdAABT5VkD1RWX3Pxn2NpMNM2PQCsjJA/uCfiS6w0nnz91MsY8TAMtPfSaL09c14VH+gDWhmijJB3VDr/QvUl6P/LFW/qIQ6wuiiL2shpLXamPim1Pyxf4mMgLGLKKye5rZpNfFLGTurbQLqLOLyHRvwswUCvwbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943117; c=relaxed/simple;
	bh=oqkcmCX1A6p5o2yU3X0awkOf1RKckejFpDUFJkLa09U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxnrWA5j3ynlfGM0lYZXhqtuoZb0cYl8iA81wseEk8CshCOMkF5gAk+KHHdn/CV75AZ3ULNF/pbpIYXXcbzLDyRvwyOe0InqC6TmiNYIb8olh5MBesjJWTeULOE67gmfsdpI/Vd+Pgw0VFPNhZmee2CphUV2rXXqQT30WQCli3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0Oga4dI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943116; x=1745479116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oqkcmCX1A6p5o2yU3X0awkOf1RKckejFpDUFJkLa09U=;
  b=S0Oga4dIX2Jn878oewNDCyMN0Ecio6Ka2kcF9UO7lHrKYuLXgMf2UfK2
   rS/PHxYgptX54CtF9zpeKGqRCjIb3VJRGxUjat6CxgCGyUMcIR4piBwqh
   I4oGhu9z40xxJ5yBwz0HjlUx6jk/Rly19+KkXJmqZEXLKxdeiNg9npxOb
   kExs93ozd9k3oghDOKSSNUvKiC2lBUnITYrZxD6Sx0wTwZahAjyGNg/3h
   68MhTHYpIdT9GbQzaMZ66If3nnjF0v+v6PmR9YusOVINF+OiAANnljzkI
   o70uEU9gP6shcLVtNIfHb2zS5dN/YH3mnmQquv4CGbh89c3qEnFv7FNO1
   g==;
X-CSE-ConnectionGUID: ugOKc82WTtedPm6wx0q2zg==
X-CSE-MsgGUID: f/+ryPqNQEKiEKSW0Tu/mw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073198"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073198"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:36 -0700
X-CSE-ConnectionGUID: 1ZD7LDKdQZmI5lD3Fgtk3Q==
X-CSE-MsgGUID: 3j1U8U/ZSTiTdogONF1DlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665441"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:33 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] iommu/vt-d: Use cache_tag_flush_range() in tlb_sync
Date: Wed, 24 Apr 2024 15:16:37 +0800
Message-Id: <20240424071644.178250-12-baolu.lu@linux.intel.com>
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

The tlb_sync callback is called by the iommu core to flush a range of
caches for the affected domain. Use cache_tag_flush_range() in this
callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a268e2a51f4d..f3926ad7d737 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4104,25 +4104,8 @@ static size_t intel_iommu_unmap_pages(struct iommu_domain *domain,
 static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long iova_pfn = IOVA_PFN(gather->start);
-	size_t size = gather->end - gather->start;
-	struct iommu_domain_info *info;
-	unsigned long start_pfn;
-	unsigned long nrpages;
-	unsigned long i;
-
-	nrpages = aligned_nrpages(gather->start, size);
-	start_pfn = mm_to_dma_pfn_start(iova_pfn);
-
-	xa_for_each(&dmar_domain->iommu_array, i, info)
-		iommu_flush_iotlb_psi(info->iommu, dmar_domain,
-				      start_pfn, nrpages,
-				      list_empty(&gather->freelist), 0);
-
-	if (dmar_domain->nested_parent)
-		parent_domain_flush(dmar_domain, start_pfn, nrpages,
-				    list_empty(&gather->freelist));
+	cache_tag_flush_range(to_dmar_domain(domain), gather->start,
+			      gather->end, list_empty(&gather->freelist));
 	put_pages_list(&gather->freelist);
 }
 
-- 
2.34.1


