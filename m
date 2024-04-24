Return-Path: <linux-kernel+bounces-156466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB28B0304
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F64C1C238EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D23159206;
	Wed, 24 Apr 2024 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJertrqk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3A5158DD0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943115; cv=none; b=FmI/2x1MpZQukpekAs1kIpj9VduEBgdIKB97vFErmR5sIWkn36YKuPAxkvHuK8ACeCw422Tv0DT+5ysKCv9uU+qA+fpGY5xtVxmMZ5i6jvyD59nKv8zVc5FLuQ6UbdDVBsYRT/lOLdOz+Dkh1k0+Bxj6fsrH7kxEY6Y0QUmo6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943115; c=relaxed/simple;
	bh=KoReSuUGTuTcwo+VoCABrE1YCpjucTFHTudUH9B6IJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyAYfHEK7WEBaP4QuZ4ghoOOWkv5IDcij7fnETAdVQnudydF1lXiAfQR0D2tY6RxAlsKXK8t9RSyyTRvUTRQqCjN4wjCtuE6Drxs61N7hNnpk/CjKnMl1LiG1xt+VWMc75VxqCldzXbwMRZcqlvEbd2+H8Pw1XF64TrHOFaBCgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJertrqk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943113; x=1745479113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoReSuUGTuTcwo+VoCABrE1YCpjucTFHTudUH9B6IJ8=;
  b=QJertrqkLVIpxb6AYhgoVp2u47zLUkzLki701wU8Cv2Y3ozTrdgF0eMJ
   BiwOjX44dIu4ybRK+R2qz/sYG3g6Kx1Bi5HD+96dBhzBv5zw5Jn3GF5l7
   SiKIykw+ni2R8yB9GrSlzWLnUj5A7v7LKw1I/W0J1L71Lt6OIWajqt1xC
   lpGutAmWHFge6/hay+0dWy2D1+kVYRK7ObLaKL3eVqIBGq3r/Rni5ibFa
   irSFLub7IxX8C+Apx8XLL5Pq4y/PKL5zRDl+Wt3Wg0NVrilaMmgPRu3Vn
   8Is1h+cI4yR4ntvcJDfnxW3hfRXqPtH67BqVEEyp2AFBxEIjZ7YcpgZDS
   Q==;
X-CSE-ConnectionGUID: Rg3am7jeQCiPft+beOtl9g==
X-CSE-MsgGUID: ZMW7J2n4RAKpif8kSWRfoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073188"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073188"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:33 -0700
X-CSE-ConnectionGUID: Fw4NHd7KTcGeXH3lfoK7Bw==
X-CSE-MsgGUID: kVFbLdaHSpWoyBQ4XfyhTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665360"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/18] iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
Date: Wed, 24 Apr 2024 15:16:36 +0800
Message-Id: <20240424071644.178250-11-baolu.lu@linux.intel.com>
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

The flush_iotlb_all callback is called by the iommu core to flush
all caches for the affected domain. Use cache_tag_flush_all() in
this callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 473df7cd1672..a268e2a51f4d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1557,25 +1557,7 @@ static void parent_domain_flush(struct dmar_domain *domain,
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct iommu_domain_info *info;
-	unsigned long idx;
-
-	xa_for_each(&dmar_domain->iommu_array, idx, info) {
-		struct intel_iommu *iommu = info->iommu;
-		u16 did = domain_id_iommu(dmar_domain, iommu);
-
-		if (dmar_domain->use_first_level)
-			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
-		else
-			iommu->flush.flush_iotlb(iommu, did, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
-
-		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
-	}
-
-	if (dmar_domain->nested_parent)
-		parent_domain_flush(dmar_domain, 0, -1, 0);
+	cache_tag_flush_all(to_dmar_domain(domain));
 }
 
 static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
-- 
2.34.1


