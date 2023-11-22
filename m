Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9217F3C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343635AbjKVDar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343631AbjKVDak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:30:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A31AC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700623836; x=1732159836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HNzfhWQdyUFZ+2JhkpASHOjsLgru+N06mUEX2ecKBAw=;
  b=BjaR7wRyYoc/uxaECAiHjC3y7cvSPpiVfOSwyCdam/FLcH9TZHodU9rV
   0sBQJZ7Q5g5M3jLPN2nOH/0LqbCgZr7WxdHDrPRoGrJu4aInTU9uSo6gJ
   6qcnKL/xFE8IAvTlszVONB0qLVJLzH/kBr2uvFPPcgcXkU1aHjzpFms1q
   xOgGAeqx81q/kYrri3UfxGPN8T5F93hNE1Zv5MHXPEqgk0l0DmAxMzMoJ
   dLiIvSC9aNewwTdI0+4jYhxqyrXc9XAKOCroZ97OdsUjXV/V+BHfqHvaf
   TB6yu0ru3NJNQETadN2detsFA01d4Wi2u1cbUzDAW2rm8UN93RjkWi15u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391742785"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="391742785"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:30:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8090181"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 19:30:35 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     mohd.syazwan.abdul.halim@intel.com,
        Kunwu Chan <chentao@kylinos.cn>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] iommu/vt-d: Make context clearing consistent with context mapping
Date:   Wed, 22 Nov 2023 11:26:05 +0800
Message-Id: <20231122032608.165144-5-baolu.lu@linux.intel.com>
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

In the iommu probe_device path, domain_context_mapping() allows setting
up the context entry for a non-PCI device. However, in the iommu
release_device path, domain_context_clear() only clears context entries
for PCI devices.

Make domain_context_clear() behave consistently with
domain_context_mapping() by clearing context entries for both PCI and
non-PCI devices.

Fixes: 579305f75d34 ("iommu/vt-d: Update to use PCI DMA aliases")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20231114011036.70142-4-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9bddd4fbbdf8..4c257ccf9dc3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3928,8 +3928,8 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  */
 static void domain_context_clear(struct device_domain_info *info)
 {
-	if (!info->iommu || !info->dev || !dev_is_pci(info->dev))
-		return;
+	if (!dev_is_pci(info->dev))
+		domain_context_clear_one(info, info->bus, info->devfn);
 
 	pci_for_each_dma_alias(to_pci_dev(info->dev),
 			       &domain_context_clear_one_cb, info);
-- 
2.34.1

