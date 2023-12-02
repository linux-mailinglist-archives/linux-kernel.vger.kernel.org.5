Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9DC801BCF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjLBJsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjLBJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:48:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44B172A;
        Sat,  2 Dec 2023 01:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510502; x=1733046502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=VQNKqC4SiqPXJcfo/UghgDuOyfAhw8F6DULvr3iToMM=;
  b=QSQzl9EOyKhF+DQmNkW6v8gzChahCX1uo71w3nP8Xu6J3l25mC/LDsYI
   ct2r1JO5D5R4AhBjF4TfO4c1azhHMTzA6XCmiWFLHZ2EvXyQIy2IGI/cN
   MJ/JwdhktWJE8RfFCjXgsocv0I6BF7e7RdR0otX/HNQ0iZwbohS8FFqYh
   ZKel5jg873KEGJjFoe3tLJVhtN4RPcZ5SFReBl9+r/njaaqDQ1UGiCrOV
   mBNliID0ZSrswl9G2/am8snq9Kfsch3brJ8ittK0n1qPGhG22pg8mm6ge
   s2bPnYIGFwF9VKI7e/UWnQAlwxei2ihJIU7J9ZVS1jJMFdXNpUsSZL72o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="390756693"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="390756693"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="860818540"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="860818540"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:48:18 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 09/42] iommu: Add IOMMU_DOMAIN_KVM
Date:   Sat,  2 Dec 2023 17:19:24 +0800
Message-Id: <20231202091924.13947-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new domain type to share stage 2 mappings from KVM.

Paging strcture allocation/free of this new domain are managed by KVM.
IOMMU side just gets page table root address from KVM via parsing vendor
specific data passed in from KVM through IOMMUFD and sets it to the IOMMU
hardware.

This new domain can be allocated by domain_alloc_kvm op, and attached to
a device through the existing iommu_attach_device/group() interfaces.

Page mapping/unmapping are managed by KVM too, therefore map/unmap ops are
not implemented.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 include/linux/iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c79378833c758..9ecee72e2d6c4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -171,6 +171,8 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_NESTED	(1U << 6)  /* User-managed address space nested
 					      on a stage-2 translation        */
 
+#define __IOMMU_DOMAIN_KVM	(1U << 7)  /* KVM-managed stage-2 translation */
+
 #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
 /*
  * This are the possible domain-types
@@ -187,6 +189,7 @@ struct iommu_domain_geometry {
  *				  invalidation.
  *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process addresses
  *				  represented by mm_struct's.
+ *	IOMMU_DOMAIN_KVM	- DMA mappings on stage 2, managed by KVM.
  *	IOMMU_DOMAIN_PLATFORM	- Legacy domain for drivers that do their own
  *				  dma_api stuff. Do not use in new drivers.
  */
@@ -201,6 +204,7 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
 #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
 #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
+#define IOMMU_DOMAIN_KVM	(__IOMMU_DOMAIN_KVM)
 
 struct iommu_domain {
 	unsigned type;
-- 
2.17.1

