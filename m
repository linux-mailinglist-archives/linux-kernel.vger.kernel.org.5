Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6B57F3C64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbjKVDaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343543AbjKVDae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:30:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B4490
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700623831; x=1732159831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=abHIAVCO67I12DlkhVd7oB9ud5ZE5PyjC/pWsosPfw4=;
  b=BzQ2mmjSZoZbiMhIyTTe1JAx9MXWsqIahXGRi2cz358Ya/thXd9WhLkX
   ahRxzuKEGDpmXgJJmI9auINpdP3x8mE33eWh7im6bqZFX9nZbFZyRW+Be
   iP6UuoXbGyHV91HZ8bbX3+WT6zhOBxLzAz+AwaLMi3ZkCSbyVAjq4A1Lz
   koHGwWioLIyQJQOCu2FOLvhEfk9uM/sEXlnDbzZDAiqtH1tWJP4aMOTsC
   fPmykcBB2xPXLdGp0CUvjZHy3tH1RZr4HZchPt7Bm9z5GAWGyqvimW7s7
   4WbLQEHme8b/ki99gj8MohhjdsXKoewWgnEivVLz4Rpesa5Q465LLR7c6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391742768"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="391742768"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:30:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8090161"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 19:30:30 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     mohd.syazwan.abdul.halim@intel.com,
        Kunwu Chan <chentao@kylinos.cn>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] iommu/vt-d: Support enforce_cache_coherency only for empty domains
Date:   Wed, 22 Nov 2023 11:26:02 +0800
Message-Id: <20231122032608.165144-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122032608.165144-1-baolu.lu@linux.intel.com>
References: <20231122032608.165144-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enforce_cache_coherency callback ensures DMA cache coherency for
devices attached to the domain.

Intel IOMMU supports enforced DMA cache coherency when the Snoop
Control bit in the IOMMU's extended capability register is set.
Supporting it differs between legacy and scalable modes.

In legacy mode, it's supported page-level by setting the SNP field
in second-stage page-table entries. In scalable mode, it's supported
in PASID-table granularity by setting the PGSNP field in PASID-table
entries.

In legacy mode, mappings before attaching to a device have SNP
fields cleared, while mappings after the callback have them set.
This means partial DMAs are cache coherent while others are not.

One possible fix is replaying mappings and flipping SNP bits when
attaching a domain to a device. But this seems to be over-engineered,
given that all real use cases just attach an empty domain to a device.

To meet practical needs while reducing mode differences, only support
enforce_cache_coherency on a domain without mappings if SNP field is
used.

Fixes: fc0051cb9590 ("iommu/vt-d: Check domain force_snooping against attached devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20231114011036.70142-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 3 +++
 drivers/iommu/intel/iommu.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 65d37a138c75..ce030c5b5772 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -602,6 +602,9 @@ struct dmar_domain {
 					 */
 	u8 dirty_tracking:1;		/* Dirty tracking is enabled */
 	u8 nested_parent:1;		/* Has other domains nested on it */
+	u8 has_mappings:1;		/* Has mappings configured through
+					 * iommu_map() interface.
+					 */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3531b956556c..11670cd812a3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2207,6 +2207,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			attr |= DMA_FL_PTE_DIRTY;
 	}
 
+	domain->has_mappings = true;
+
 	pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
 
 	while (nr_pages > 0) {
@@ -4360,7 +4362,8 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 		return true;
 
 	spin_lock_irqsave(&dmar_domain->lock, flags);
-	if (!domain_support_force_snooping(dmar_domain)) {
+	if (!domain_support_force_snooping(dmar_domain) ||
+	    (!dmar_domain->use_first_level && dmar_domain->has_mappings)) {
 		spin_unlock_irqrestore(&dmar_domain->lock, flags);
 		return false;
 	}
-- 
2.34.1

