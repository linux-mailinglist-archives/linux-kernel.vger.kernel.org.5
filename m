Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F983773F16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjHHQmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjHHQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:42:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648093DE36
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510112; x=1723046112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=A507Xs1crKDCNKJRmv5uCTlfgOCIAdl3cBwBkuALTds=;
  b=d8sCkdvSY+2/5Jy7IBlrAmH2+4Cw9hlFN+PUTfW/9L0pc8mX19/S59QN
   X01IxFeOJ5FYTXhjsv+/rJfAbTzFpvE4r7suXYs4p4VZYUIkvW6qp9Sap
   ascA4T+w9nKZtqBPj8tP+em5betumioyaTAD5jbf0x5HFJe5dxUy+QTUf
   ykk0xdeunqRzBTEYebnDctk/5m5baL/ojifz9wmy8D8+6+QSErJfE97oz
   1dGQ55OcGsjVXUjcYSEUBWrLi/y9RYS+ekLvdy0YRrrrWEtNbSG54UVTj
   C2GfamrHQUWpkikVKq8DYRDwK5z1oz+12JhIN/rpiBLdCbXBlWMOnFPbp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437078656"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437078656"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 00:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681146272"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="681146272"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.156.126])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 00:49:51 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 1/5] iommu: Add mm_get_pasid() helper function
Date:   Tue,  8 Aug 2023 15:49:40 +0800
Message-Id: <20230808074944.7825-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808074944.7825-1-tina.zhang@intel.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_get_pasid() is for getting mm pasid value.

The motivation is to replace mm->pasid with an iommu private data
structure that is introduced in a later patch.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 arch/x86/kernel/traps.c | 2 +-
 include/linux/iommu.h   | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4a817d20ce3b..6e259b11cd87 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -678,7 +678,7 @@ static bool try_fixup_enqcmd_gp(void)
 	if (!mm_valid_pasid(current->mm))
 		return false;
 
-	pasid = current->mm->pasid;
+	pasid = mm_get_pasid(current->mm);
 
 	/*
 	 * Did this thread already have its PASID activated?
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d31642596675..30e4d1ca39b5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1180,6 +1180,10 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
 	return mm->pasid != IOMMU_PASID_INVALID;
 }
+static inline u32 mm_get_pasid(struct mm_struct *mm)
+{
+	return mm->pasid;
+}
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
@@ -1202,6 +1206,10 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
+static inline u32 mm_get_pasid(struct mm_struct *mm)
+{
+	return IOMMU_PASID_INVALID;
+}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
 
-- 
2.17.1

