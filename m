Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4A7F3C66
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbjKVDak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343543AbjKVDai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:30:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA11197
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700623834; x=1732159834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p7LbYR2l9zkvd8N1/omkWM+xVFNd9JQUzHnkehfNbv0=;
  b=SjM8YVZEpDfiA3QDfYfXZkgqhHOqXC5TB/Bm/45dFiHapHU9YI5EHeBJ
   28RQG6QzlTeojxrSFCBpmfNqEzqy/r0XC9k49niUs53TotyIqldS3nl1w
   CpcI6rn8u3yyfRRHoiw/pjFX8Qg5DalI8sAefyyh9FtGRap2AsXri4XLW
   OCGaDNs3WqKe0+41w+akSFsEyEniGBevfMDeXzAcGL6SjSpVfNbbrSY7n
   mICsNEzWcVRNmp0ek8j7iA869m6o9XitNFSPE8z4moUIyUpUWoxZNv+rb
   f66DE+XKM1rdjwnGTF9hCXRpj3gEFbLMP7WvE6Yg1nwWnZeh9VEBWhvTc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391742778"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="391742778"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:30:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8090170"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 19:30:33 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     mohd.syazwan.abdul.halim@intel.com,
        Kunwu Chan <chentao@kylinos.cn>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] iommu/vt-d: Disable PCI ATS in legacy passthrough mode
Date:   Wed, 22 Nov 2023 11:26:04 +0800
Message-Id: <20231122032608.165144-4-baolu.lu@linux.intel.com>
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

When IOMMU hardware operates in legacy mode, the TT field of the context
entry determines the translation type, with three supported types (Section
9.3 Context Entry):

- DMA translation without device TLB support
- DMA translation with device TLB support
- Passthrough mode with translated and translation requests blocked

Device TLB support is absent when hardware is configured in passthrough
mode.

Disable the PCI ATS feature when IOMMU is configured for passthrough
translation type in legacy (non-scalable) mode.

Fixes: 0faa19a1515f ("iommu/vt-d: Decouple PASID & PRI enabling from SVA")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20231114011036.70142-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 11670cd812a3..9bddd4fbbdf8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2492,7 +2492,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		return ret;
 	}
 
-	iommu_enable_pci_caps(info);
+	if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
+		iommu_enable_pci_caps(info);
 
 	return 0;
 }
-- 
2.34.1

