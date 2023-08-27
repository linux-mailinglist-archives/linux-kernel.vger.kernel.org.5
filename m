Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56464789C46
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjH0Iox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjH0IoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:44:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A3BF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693125861; x=1724661861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vcs7iit32/oFn+7o+m4hBLaWyhJquQoYWn/5bok0fDw=;
  b=iQIWkaXU2VSpJLyPcx3e2cctXliFe4YqcDXbQyhRRqqkcIoZ70ThbASV
   Hir2yM8edmHHCE3WMZC8NJDeiUUYbdkWGu0hAagkfdMwy+H5WyE7V0gIQ
   tADnovZzC5AcIQTGSVOjnNpF4qqT+B0wOLlU6N3OeZT/LRRDWP8ugwOv4
   ZvyI/Kdq3ElU5ci+LMSeGJhePa5VDZU9QAHiAVE/3IJFgiHu6hBt64mRe
   fMQC6z5dlFJ0e5EddYWa5UiNW3HhBnh6cHkBvkMFp2vw3vEgbPZ4O4LRr
   nnqFLcJXm+lr5aKx8EQjyLoGcy9IDBlmUrjCp34bRMk+RgxozQxkuinPX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="359919892"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="359919892"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 01:44:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="984561794"
X-IronPort-AV: E=Sophos;i="6.02,204,1688454000"; 
   d="scan'208";a="984561794"
Received: from yzhu-ivm3.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.254.213.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 01:44:19 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 1/5] iommu: Add mm_get_enqcmd_pasid() helper function
Date:   Sun, 27 Aug 2023 16:43:57 +0800
Message-Id: <20230827084401.819852-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827084401.819852-1-tina.zhang@intel.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_get_enqcmd_pasid() is for getting enqcmd pasid value.

The motivation is to replace mm->pasid with an iommu private data
structure that is introduced in a later patch.

v2: change mm_get_pasid() to mm_get_enqcmd_pasid()

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 arch/x86/kernel/traps.c | 2 +-
 include/linux/iommu.h   | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4a817d20ce3bb..d9034b1bbfdd6 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -678,7 +678,7 @@ static bool try_fixup_enqcmd_gp(void)
 	if (!mm_valid_pasid(current->mm))
 		return false;
 
-	pasid = current->mm->pasid;
+	pasid = mm_get_enqcmd_pasid(current->mm);
 
 	/*
 	 * Did this thread already have its PASID activated?
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d316425966759..ab9919746fd33 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1180,6 +1180,10 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
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
@@ -1202,6 +1206,10 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
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

