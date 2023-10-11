Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126947C4B02
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjJKGwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344920AbjJKGv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:51:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13591D9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697007110; x=1728543110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/TKSJz2uqhYSu+kqp+Wq9KnZNxzR/1bl8TV8gHaytgw=;
  b=HXGIOgIY84TYSAaK01wSTCJBstLaSesSkQAZlvV/P11Lnzc+vuhBKHd2
   ITPSjyH3IZ4br+/MNsEbNwl3SnOjSkrthUA4SyaRb0QRgUkIjozBTQ4jP
   hyygv6PRy3zbgV7GozOl3B774FonmgNEEPpPVvYuQ4WGVxeMlw2949Tyq
   eAE9FwcKiMwb2WQyooNQQYr/c5QvvAgWusXSlds2a9KsLA/Ug71v877ZU
   ieJDvKsoDqnuP03sohiVwr2yZxRlHZmajnVCVWUNaBzrmqltCllXqvGpf
   OiNvGWvGozRUqVWWlpE9GSYW4JslSGSVBduPwFM3zbV3lldpYEZX3ZX08
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387436975"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387436975"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="824050289"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="824050289"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2023 23:51:47 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [v6 PATCH 5/5] mm: Deprecate pasid field
Date:   Wed, 11 Oct 2023 14:51:32 +0800
Message-Id: <20231011065132.102676-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231011065132.102676-1-tina.zhang@intel.com>
References: <20231011065132.102676-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the pasid field, as all the information needed for sva domain
management has been moved to the newly added iommu_mm field.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/mm_types.h | 1 -
 mm/init-mm.c             | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9f4efed85f74..37f049c4b059 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -883,7 +883,6 @@ struct mm_struct {
 		struct work_struct async_put_work;
 
 #ifdef CONFIG_IOMMU_SVA
-		u32 pasid;
 		struct iommu_mm_data *iommu_mm;
 #endif
 #ifdef CONFIG_KSM
diff --git a/mm/init-mm.c b/mm/init-mm.c
index cfd367822cdd..24c809379274 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -44,9 +44,6 @@ struct mm_struct init_mm = {
 #endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
-#ifdef CONFIG_IOMMU_SVA
-	.pasid		= IOMMU_PASID_INVALID,
-#endif
 	INIT_MM_CONTEXT(init_mm)
 };
 
-- 
2.39.3

