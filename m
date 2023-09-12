Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7AF79D17D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjILM74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjILM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:59:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A9310CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694523590; x=1726059590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UkPWO7fE+y65rWaaiU51i7SbuwuOUve8DJxS805k7Cc=;
  b=N00++X9zH/0nN6kfLAvBgu1HD7US1jwF4ZJPVkFO66iwnf5EawzvFGNp
   5c6LA1gRLXmB++JakeSO1PlWwD6LAPDZhqJ//AlUIYqdlpBMgqZ646w7X
   v0DirHzDrBun73YR/5yeAzis9/M9EgCOL30IasVWCMr1efYgq3Q+p/1Q3
   YnPXEj8piU5CZhDUjO2qNQjs0fq5nHT7nh81G+Gs8C2/x5B24g7NV1kNJ
   fo8hctZA+OGC/+SWXKxzgU7oQ1zUKUputRglXziE0X6Q9B7sEvZSh+WK4
   ygyfUqarcxlDe0YbQEX0ME0vmClxRhU+3+AJJSbEhoMf+81ROccLIi3Tk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378277303"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378277303"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858799246"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858799246"
Received: from tongshi-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.255.28.214])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:59:48 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v4 1/6] iommu: Add mm_get_enqcmd_pasid() helper function
Date:   Tue, 12 Sep 2023 20:59:31 +0800
Message-Id: <20230912125936.722348-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912125936.722348-1-tina.zhang@intel.com>
References: <20230912125936.722348-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_get_enqcmd_pasid() is for getting enqcmd pasid value.

The motivation is to replace mm->pasid with an iommu private data
structure that is introduced in a later patch.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---

Changes in v2:
- Change mm_get_pasid() to mm_get_enqcmd_pasid()

 arch/x86/kernel/traps.c | 2 +-
 include/linux/iommu.h   | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d36a81..832f4413d96a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -591,7 +591,7 @@ static bool try_fixup_enqcmd_gp(void)
 	if (!mm_valid_pasid(current->mm))
 		return false;
 
-	pasid = current->mm->pasid;
+	pasid = mm_get_enqcmd_pasid(current->mm);
 
 	/*
 	 * Did this thread already have its PASID activated?
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c50a769d569a..a4eab6697fe1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1189,6 +1189,10 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
 	return mm->pasid != IOMMU_PASID_INVALID;
 }
+static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
+{
+	return mm->pasid;
+}
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
@@ -1211,6 +1215,10 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
+static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
+{
+	return IOMMU_PASID_INVALID;
+}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
 
-- 
2.34.1

