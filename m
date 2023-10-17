Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0957CB79D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjJQAtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjJQAsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:48:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AA2134
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697503730; x=1729039730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/TKSJz2uqhYSu+kqp+Wq9KnZNxzR/1bl8TV8gHaytgw=;
  b=Wb2YZt8B8HaguTNwmBa6Ic4iiQcoaCDSsUevmElbIJolLKzx+aGIozbj
   QB4HGJFLNhfyJaV2PhXqnzYIn+ZeGamK57BnqGTbt8mOIpn0QOBPdydPJ
   aoyvB6b301C7DoZ9Aru49J+1vMtcVhV0fx4J11VdQnHsQl7c4kdafti2g
   yp7c4cR5itDfg69RYvbOdaBTxb5kPVhcK9t+0Dk9Ist886N/DRyJOxRl5
   ZtTti7f2pzEDAU/4bPkrW5Ca26mthuYC5irdoKdnQphJ/1ibaLwtQqDDe
   7u+gTt+rjB2vWfyYqo2ebmfG9tksQrngYAJMzi2pW8GtP8sIkYrRJA3Wb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="382893373"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="382893373"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 17:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="705793803"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="705793803"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by orsmga003.jf.intel.com with ESMTP; 16 Oct 2023 17:48:46 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tina Zhang <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 5/5] mm: Deprecate pasid field
Date:   Tue, 17 Oct 2023 08:48:02 +0800
Message-Id: <20231017004802.109618-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017004802.109618-1-tina.zhang@intel.com>
References: <20231017004802.109618-1-tina.zhang@intel.com>
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

