Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FABD7B07FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjI0PTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjI0PTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:19:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E69A136
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695827953; x=1727363953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lpncFO9EBL1O72rF23q9xrrFLTa4Sw3ZpdC9K4pRN7g=;
  b=N6YDpCLB72dXEHUnTYck8Jy11GsmWtuNCt4V4TRVjU9EjouAdeuGkGIb
   RTApJS9jookRSpVZkOcb7Q4dgTs7wPiM/GQnOqWx27XZ5ZIT2KlwL5+3B
   LJnGT8Ews88QLcQePHSmfrsHx/Yc9P24g8foAeiBO/ZjaK53cHvHZcGQU
   sAKsrbwDgK2fNuoMtuZOj6xChhaOCuuDxTmHT/RsknLwfmRyk0sNA11WC
   /8SSDDvTATu1VhS1aM7HRseko1mbZ3rC3jsthTR7VLCLE+I552oA5qzr2
   ec8h8STe0uhRFRiDm06MHHXctiXi57lNPUHePMRZSN2CpC56sfJC6Bvxw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="362098905"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="362098905"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 08:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="819461120"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="819461120"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2023 08:19:11 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATH v3 1/3] iommu/vt-d: debugfs: Dump entry pointing to huge page
Date:   Wed, 27 Sep 2023 23:15:34 +0800
Message-Id: <20230927151536.67319-2-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230927151536.67319-1-Jingqi.liu@intel.com>
References: <20230927151536.67319-1-Jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the page table entry pointing to a huge page, the data below the
level of the huge page is meaningless and does not need to be dumped.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 0255c4a23269..e2a3c37943a0 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -311,9 +311,14 @@ static inline unsigned long level_to_directory_size(int level)
 static inline void
 dump_page_info(struct seq_file *m, unsigned long iova, u64 *path)
 {
-	seq_printf(m, "0x%013lx |\t0x%016llx\t0x%016llx\t0x%016llx\t0x%016llx\t0x%016llx\n",
-		   iova >> VTD_PAGE_SHIFT, path[5], path[4],
-		   path[3], path[2], path[1]);
+	seq_printf(m, "0x%013lx |\t0x%016llx\t0x%016llx\t0x%016llx",
+		   iova >> VTD_PAGE_SHIFT, path[5], path[4], path[3]);
+	if (path[2]) {
+		seq_printf(m, "\t0x%016llx", path[2]);
+		if (path[1])
+			seq_printf(m, "\t0x%016llx", path[1]);
+	}
+	seq_putc(m, '\n');
 }
 
 static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
-- 
2.21.3

