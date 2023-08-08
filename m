Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489F5773F39
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjHHQof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjHHQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:43:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3D91A3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510153; x=1723046153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=G2jQdPpYRftTNVodh55koMoZtJhLjKxrlqOJq+ORzpU=;
  b=A1Rd1L7bR1BPzaq/aBMbePLUqBcwgb3AkeaYIqKCAX8A3uybvplC2HuT
   RIywbjKTXRyCMphmRLSF3Qb/OcrmplT7cWt1Z0sPPCVroZD32211E8wfQ
   vc1+SbtS9e6pQKh3wfuxa4Jb6EDqrbCV9IJ6k/QEBWISiMgT5IKt/hH3f
   qrulmnzymJ3K7NEH5rQ+f9pebtozqANSHqQCH9O4MFvbcZyUf34lidwYi
   DR/E4OkYXjlxDSE/Ro1gDGKkbyF4o8D+xiwbbaN77CSl3WrC4Krndql24
   cQxc33VHT3VtaJEnFvHcJOzfw7nFnq4HtQwCYRD/JAElMTBWZBqs6QNxM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437078719"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437078719"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 00:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681146448"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="681146448"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.156.126])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 00:50:05 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 5/5] mm: Deprecate pasid field
Date:   Tue,  8 Aug 2023 15:49:44 +0800
Message-Id: <20230808074944.7825-6-tina.zhang@intel.com>
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

Drop the pasid field, as all the information needed for sva domain
management has been moved to the newly added iommu_mm field.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/mm_types.h | 1 -
 mm/init-mm.c             | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3fd65b7537f0..6cb5cc53c480 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -808,7 +808,6 @@ struct mm_struct {
 		struct work_struct async_put_work;
 
 #ifdef CONFIG_IOMMU_SVA
-		u32 pasid;
 		struct iommu_mm_data *iommu_mm;
 #endif
 #ifdef CONFIG_KSM
diff --git a/mm/init-mm.c b/mm/init-mm.c
index efa97b57acfd..69719291463e 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -42,9 +42,6 @@ struct mm_struct init_mm = {
 #endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
-#ifdef CONFIG_IOMMU_SVA
-	.pasid		= IOMMU_PASID_INVALID,
-#endif
 	INIT_MM_CONTEXT(init_mm)
 };
 
-- 
2.17.1

