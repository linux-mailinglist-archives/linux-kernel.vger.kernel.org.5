Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323B3760221
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjGXWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjGXWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:20:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A79B10FD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690237242; x=1721773242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OatyZryBNY4xB7kd4cbR7STKN6zuyaLdEWJY1lw4WY0=;
  b=O6ySXO9Bq0pDP5aMruCabQGo1MRDhihkIrdjZ4VERiw8YbvWnVvwbfvK
   ikkytp/6hwNUlTIJCAJmSU8CFAvWhVaje6K8+9tyXRsbcvZ2gunNpAyeu
   Ly4ps1rX6vraR5sYUmip+dJ6zFRME7tBjiDHvEC6ilrUR5Xe2t4IqU+Pm
   2sIeXKOs8rImDUdVbBd5b6lWXbcdKNj+FT95TgM1ouSb8uQLNRTb6WFoE
   rN00dL5G02sQdsHqV2ACzw6KxFue41QBSomhlwCwNcadwv1VnkSrWZENI
   nVyvBH2XGWc/zAlLw/xgShv519WXl8xCArpppdcBCohOUK+mKcLR8AVO4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398476705"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="398476705"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 15:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="899675501"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="899675501"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2023 15:20:40 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, "Will Deacon" <will@kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v11 3/8] iommu/vt-d: Add domain_flush_pasid_iotlb()
Date:   Mon, 24 Jul 2023 15:25:33 -0700
Message-Id: <20230724222538.3902553-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
References: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

The VT-d spec requires to use PASID-based-IOTLB invalidation descriptor
to invalidate IOTLB and the paging-structure caches for a first-stage
page table. Add a generic helper to do this.

RID2PASID is used if the domain has been attached to a physical device,
otherwise real PASIDs that the domain has been attached to will be used.
The 'real' PASID attachment is handled in the subsequent change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 89013a2913af..bb8316fec1aa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1467,6 +1467,18 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
+static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
+				     struct dmar_domain *domain, u64 addr,
+				     unsigned long npages, bool ih)
+{
+	u16 did = domain_id_iommu(domain, iommu);
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
+	spin_unlock_irqrestore(&domain->lock, flags);
+}
+
 static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  struct dmar_domain *domain,
 				  unsigned long pfn, unsigned int pages,
@@ -1484,7 +1496,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		ih = 1 << 6;
 
 	if (domain->use_first_level) {
-		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, pages, ih);
+		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
 	} else {
 		unsigned long bitmask = aligned_pages - 1;
 
@@ -1554,7 +1566,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 		u16 did = domain_id_iommu(dmar_domain, iommu);
 
 		if (dmar_domain->use_first_level)
-			qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, 0, -1, 0);
+			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
 		else
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
-- 
2.25.1

