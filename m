Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6093576D95D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjHBVTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjHBVT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:19:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B0273C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691011165; x=1722547165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QTcWjAJeCsBne8ZdeKn434F2uIWuBkEgxK9GMvAl9eo=;
  b=MV7GYAbY5bGXxM7FZ2bOVQ1I8wBJKnYCHm0R9k+xuSmbEb7IeyIyKNvr
   5tosKMpmhz/fRN77O0FwQtnZ97q8r7eau6ax6VlINopgOb8J6R4yjdHZT
   r1tUhy6KH2Norxl+QZr3QDKcOdHZfcmpJrBJ1cWm3MjR29sMN8T+FS1qk
   nHyNsUPuT00n6O9/7oYNeSZYDBtDTKWLf8zu9uYzEXSj6VFfPWXvvA9dj
   Uzb3IP5lEcH4a0neCh1RIRZuMnID4UdazPuBaAqmgjZ32VNQ/Vw1x0mlC
   UosCaAyNjaJUB+Ok1QC6+XMUgUvwj+RmLd/LrPW4Yu5WiAIBkieYEJ0st
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372436170"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372436170"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729290796"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="729290796"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 14:19:22 -0700
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
Subject: [PATCH v12 6/8] iommu/vt-d: Prepare for set_dev_pasid callback
Date:   Wed,  2 Aug 2023 14:24:25 -0700
Message-Id: <20230802212427.1497170-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
References: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

The domain_flush_pasid_iotlb() helper function is used to flush the IOTLB
entries for a given PASID. Previously, this function assumed that
RID2PASID was only used for the first-level DMA translation. However, with
the introduction of the set_dev_pasid callback, this assumption is no
longer valid.

Add a check before using the RID2PASID for PASID invalidation. This check
ensures that the domain has been attached to a physical device before
using RID2PASID.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bdde38a5e43a..4a41aca6a2ba 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1475,7 +1475,8 @@ static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
 	unsigned long flags;
 
 	spin_lock_irqsave(&domain->lock, flags);
-	qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
+	if (!list_empty(&domain->devices))
+		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
-- 
2.25.1

