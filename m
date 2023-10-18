Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E17A7CD359
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjJRFHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJRFHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:07:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1A103
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697605631; x=1729141631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D8FloSWnsd/4uIpu7aqdGVx2PMFIFcWQFmckzLsY9KE=;
  b=LFP1f7H44A0P80fp/CcDugVTyNpo2wkD6Ap99VovTLRLQjKzfEnu6nb1
   5IhhomA7KHjZ5KkDqp+3NBQ7gNoxjxep4+r8JNYhZHVldafIuCpmZW1oP
   1xHf52newRZHeMiJU/NbWHmhkcM1EqRd9909o5yS5bsJNh+goeLA8Tinr
   U6R+hgse4BeLEqGlPmZCuHKJGk3bWRXFKj6ZB1JMwvcuhUkPKlQk6f3zZ
   /aNh6RI0qy02GU/rlkH/6kJSXAkOCab/sgDa0GOnjzRQ5gMbFBuULfDhE
   XahOnpcd+y6FEooh+AqPFMnI1Zie47m+NlCPFJ0MnHI1j5ZOa74nVt/Td
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388802436"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="388802436"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 22:07:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822288653"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="822288653"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2023 22:07:07 -0700
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
Subject: [PATCH v9 3/5] mm: Add structure to keep sva information
Date:   Wed, 18 Oct 2023 13:06:38 +0800
Message-Id: <20231018050640.24936-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231018050640.24936-1-tina.zhang@intel.com>
References: <20231018050640.24936-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/iommu.h    | 5 +++++
 include/linux/mm_types.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8aa5910190d1..b581d8d02afe 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -679,6 +679,11 @@ struct iommu_sva {
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

