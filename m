Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976EC7AB4A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjIVPTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjIVPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:19:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63FC100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695395972; x=1726931972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lpncFO9EBL1O72rF23q9xrrFLTa4Sw3ZpdC9K4pRN7g=;
  b=BfOOt7818pmRpZ+9PZfwavJ1pO3jz+yViwdl+DQYR2HEHRs+KU+i5gK2
   sC/Avd7rIDDvtLFi6RDcRC73yJh7+xkbgl6IC2U+aOGBFbfenLSKLk91m
   kbwKRG5Q+OAs/8cFNlsXc7IpyU3LeQnxY5jJXnVgZWUsxP7TC4qbABLF0
   gMBXGZNY1HTCa9PRNb4wdB8xgUOm81V9zsBTsMTdKCS/WY/W4dV4P1+aw
   2wFp8aFPNprk6NxPswbiAhi4o+T/1/auId1JIc345VPC6OWgwZ7h8ynCg
   q+tsjPyD2HJtAyzozBg7ZoH7FNvzFb2YE89R5MFGRkyRBJT4sgw94lFF4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="360235278"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="360235278"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 08:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="741133159"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="741133159"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by orsmga007.jf.intel.com with ESMTP; 22 Sep 2023 08:19:30 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH v2 1/3] iommu/vt-d: debugfs: Dump entry pointing to huge page
Date:   Fri, 22 Sep 2023 23:16:34 +0800
Message-Id: <20230922151636.77139-2-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230922151636.77139-1-Jingqi.liu@intel.com>
References: <20230922151636.77139-1-Jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

