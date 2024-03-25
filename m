Return-Path: <linux-kernel+bounces-116417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D91889AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385A81C339E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE39149C70;
	Mon, 25 Mar 2024 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IObLNW1W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE914AD0C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333096; cv=none; b=pYC+J14MtZ9QOb5+LsnRXydhrOkb82vOCGF3kDefVefuubr6XNncuPcbo5W+LXzm53UmaqtZxew+ZUIysOGx0VhEo0rJcytp1RFmoFfQl99sKFB/OO+I5GsR8oP5ywY0yTT9ZeqGSw4vQRBIM81wOd+YGAuXO+e0RLkmO5KE0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333096; c=relaxed/simple;
	bh=+OAkQ+xgV6iFnsM2Piz46SFV5ZnSYjQLnEdHmWb5riU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCnNwRRG8Ii6U9Ne+GzMUSHRNUfd/dFxxZJlMra8WKzFcy1iIt7um+pBBwI69YzxVI+VY3iK57g+sWbuxqcSLBih09l5ihtfwRMqYeK9ngcxWTQDbS4c3ptqc+/5/4NLkydw0EjKoEwmxvX565zVRPm9mXXFYUGYlSF1RPZiH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IObLNW1W; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333095; x=1742869095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+OAkQ+xgV6iFnsM2Piz46SFV5ZnSYjQLnEdHmWb5riU=;
  b=IObLNW1WvBAJ+42wjK5KEqoPieDvcdaCnOSKKoWd1KcRHnBxvDXkc8P5
   pjBM1LARWh8PEO1qiF7opp/eeyGSpzNeYn3mC7gVSvB68cJZxdOEms9+r
   2Im/AHKV5aR3Z4067EbD3fVKbCnCaQEsTeJa8TSe3twPkYsfyEAGwLCPX
   bjvDHP5as41xu6CqKg86ZcczRUdNChkPy4eoyFPRUx9AHuox6MIM5Dqo/
   YFAVbFlLWS8Y0O3MVYqyc0e+FJFBdvNKrzb0ac4DN8OPkLjBP5Di+Gakp
   pWv8CKGdcwR5fHwYORp49Ju78z1xyse7FzNdGxVPQFdFpYnZmC1HcvKwg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271356"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271356"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15353954"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:12 -0700
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
Subject: [PATCH 05/12] iommu/vt-d: Use cache_tag_flush_range() in tlb_sync
Date: Mon, 25 Mar 2024 10:16:58 +0800
Message-Id: <20240325021705.249769-6-baolu.lu@linux.intel.com>
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

The tlb_sync callback is called by the iommu core to flush a range of
caches for the affected domain. Use cache_tag_flush_range() in this
callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4ce98f23917c..1c03d2dafb9d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4112,25 +4112,8 @@ static size_t intel_iommu_unmap_pages(struct iommu_domain *domain,
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


