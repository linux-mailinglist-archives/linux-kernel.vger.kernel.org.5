Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31DE760224
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGXWVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGXWUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:20:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9A172D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690237243; x=1721773243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7pEMVnY38ePZ+dddDqL9MVthVOhVNl5Cd66gkfRILA=;
  b=QwEmCVRCoT7cpqEFZNgeFR8gzCMcqupNgYSH019rosh12IOIImGsYZE5
   6S3osSpkqUDygmZfJaCJnjAOp2KRuA6u6zJvPE4vrsJacpOBBUr7mNH6T
   XgNEErnAX5ZO3GDsHRIs2/wdGzOBrFzSTsUABWd8mn/ke8GL3uSQgud6K
   7x+e936HEI9H6GpCcgdhxhNxIWTLWROu1QihDGxyDi1sALsZ+U7hfZUds
   fTlIO/VNkK+/x0JeT3FS1ZHsFYs20thhgoMkB45q+31FI6Ue9Ilfj1vU5
   B3RUskHWwqLlM+moYhveYMUtWTZMnLg81VymPDIPD8ThXnXoKaR3b1ppr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398476725"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="398476725"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 15:20:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="899675512"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="899675512"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2023 15:20:41 -0700
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
Subject: [PATCH v11 6/8] iommu/vt-d: Prepare for set_dev_pasid callback
Date:   Mon, 24 Jul 2023 15:25:36 -0700
Message-Id: <20230724222538.3902553-7-jacob.jun.pan@linux.intel.com>
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

