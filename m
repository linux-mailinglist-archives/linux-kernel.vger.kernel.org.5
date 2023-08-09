Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5900B775FBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjHIMut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjHIMuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:50:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA27D2113
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691585435; x=1723121435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BbJI+sqyl8iiSSnSlKYkiNQ2OWmfelGb3IWm5XO5axA=;
  b=gzvVl3Yg/lRvyJBrBIHmiS84O/yF9EKTNmJx2N9qNP5mD25ZDlM0rZ1I
   MfFQ4FUqAgyvKnH5s41Aq1kig7UT6GbbFo8HdUL3YCnfT5zXihu8YBrLq
   8rHTf34l03enm2jyBTkNSLh4DuEdLnSRhGPCtxoNGGETpb5RA1NUfcRRk
   Ww2v/LEpgpKaws9mPO7WeQKKCjPJAzJyQCTO7h2OmppZ1Y9Q6P+rZlnuM
   wuCpBTAwuMdUaUtc57gO4YjyZCEGfuAjpoXADbgETvzr1S9GZ5v8jAjOZ
   aAsrGCO2tqUsbWLq06B948oWI2krIJKBgjRHUmzZ1OkwlTnsghDTvK56G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374821717"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="374821717"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 05:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855521745"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="855521745"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 05:50:33 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Yanfei Xu <yanfei.xu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] iommu/vt-d: Prepare for set_dev_pasid callback
Date:   Wed,  9 Aug 2023 20:47:59 +0800
Message-Id: <20230809124806.45516-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124806.45516-1-baolu.lu@linux.intel.com>
References: <20230809124806.45516-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Link: https://lore.kernel.org/r/20230802212427.1497170-7-jacob.jun.pan@linux.intel.com
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
2.34.1

