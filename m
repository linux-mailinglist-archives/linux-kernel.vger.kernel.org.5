Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BEF8098EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572950AbjLHB5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572924AbjLHB5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:57:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811E21AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702000675; x=1733536675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=un4XPFTzO6AWHemPtM6XczKOhQkrLlZxvkBGsGhl8F8=;
  b=e94+XG1ieN5kA1n0WdPt85tbl6JLm9A/vIaezWPpG+Ww0hewnCYOWHu8
   CEIvxnRNSAuVlOIknxG73sBJqAXfvlMNRxqSBPxNgkU8QsDBm+gAb3JJz
   odRcYjGJ/JRmche81JD/dRXTthCsopy1G7WZOPfzZNv1a82+CKiZrZlcq
   9+z6KbioXuprSDfensSztWMsrTbeE5MiE01UXOWJetxcY2t4ZM3yIMdpC
   bbeqq6NxcrHKadgMwGopn0dXcCh1P/ahSU/fiqOG9e+7IlNrZSMSS6639
   tiooFt62pKFKWskodpZQgzL4mF3cn9+c87dtxDQx1T6HlYGPyy/cYoa2+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397131259"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="397131259"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="945266198"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="945266198"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2023 17:57:52 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2] iommu: Set owner token to SVA domain
Date:   Fri,  8 Dec 2023 09:53:14 +0800
Message-Id: <20231208015314.320663-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a9c362db3920 ("iommu: Validate that devices match domains") added
an owner token to the iommu_domain. This token is checked during domain
attachment to RID or PASID through the generic iommu interfaces.

The SVA domains are attached to PASIDs through those iommu interfaces.
Therefore, they require the owner token to be set during allocation.
Otherwise, they fail to attach.

Set the owner token for SVA domains.

Fixes: a9c362db3920 ("iommu: Validate that devices match domains")
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

Change log:
v2:
- The user domain allocation path does the right thing. Hence no need
  to fix anything.
v1:
- https://lore.kernel.org/linux-iommu/20231207021938.306738-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0d25468d53a6..d0a28667479a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3617,6 +3617,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
 	domain->mm = mm;
+	domain->owner = ops;
 	domain->iopf_handler = iommu_sva_handle_iopf;
 	domain->fault_data = mm;
 
-- 
2.34.1

