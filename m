Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60877C4AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbjJKGwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbjJKGvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:51:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE49D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697007105; x=1728543105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GkJWDBRQ1jsnIIVUcbi2Qvjz1LAX/o3/l8N0hK1jUv8=;
  b=nFBmh0EtinaWdwQkOGT901L6mDj+/A4uLfCiH6CQzi7/QqfjL6Yooeo2
   qtvlesa65cDs6hFB8/z/fhefVCeerkYMgMHIxTVhHmviR7njSDzcVXB3y
   ZQb1OicsmNfoJwKI0MRBEUBrgMinkOgci8Mn3XdwASX3CHBDYEa9qepRh
   mccOyGyPOPdpoB5xwFfFQ7I+BP7PNle7F93L7G7eCI5dXOU2/casjfeL2
   gGD7U5P+6PBN7cuYbHvuDkH3sjW01wiu33i6yQgq0ishDWyVaoe8lfzKf
   oSp3hTUN0mCU4PMxOylDdjoXBljT6nIRQccJI5SpCZO+/caAMft/h+0gI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387436962"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387436962"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="824050259"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="824050259"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2023 23:51:42 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [v6 PATCH 3/5] mm: Add structure to keep sva information
Date:   Wed, 11 Oct 2023 14:51:30 +0800
Message-Id: <20231011065132.102676-4-tina.zhang@intel.com>
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

Introduce iommu_mm_data structure to keep sva information (pasid and the
related sva domains). Add iommu_mm pointer, pointing to an instance of
iommu_mm_data structure, to mm.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/iommu.h    | 5 +++++
 include/linux/mm_types.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a4eab6697fe1..dc1f98e12f4b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -670,6 +670,11 @@ struct iommu_sva {
 	struct iommu_domain		*domain;
 };
 
+struct iommu_mm_data {
+	u32			pasid;
+	struct list_head	sva_domains;
+};
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e6..9f4efed85f74 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -670,6 +670,7 @@ struct mm_cid {
 #endif
 
 struct kioctx_table;
+struct iommu_mm_data;
 struct mm_struct {
 	struct {
 		/*
@@ -883,6 +884,7 @@ struct mm_struct {
 
 #ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
+		struct iommu_mm_data *iommu_mm;
 #endif
 #ifdef CONFIG_KSM
 		/*
-- 
2.39.3

