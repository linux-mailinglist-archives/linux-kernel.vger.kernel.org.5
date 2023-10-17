Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4171B7CB79B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjJQAsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjJQAsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:48:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35518115
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697503722; x=1729039722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0DTtg53Mry+bx0RWv8c9JmmtiJF5A7k4iMPvgpVkaoA=;
  b=XDx0ZyM09D5cAU7IFhQon+D2/rpP2/wtAsqnwTn4E288KRWmkL5cRGI9
   rAUh8rSjPkPd44Xds5H73EMAKv/IqHh0tqD+bwJWLaiPMaXPiQq8wGIjT
   e7PK/RsxljI9DgS9l7XdwJmWWOFf+rv//p8jbTlbidNDRF21gK1x+aPfR
   66OeUCE8FxoxAElAKzTpBletalaC3L20dBrGAMWhJwRwk/SYItzwUS8PZ
   KsMrqiAjmgPCut9U91HRmAye5YBOFulyhoeXWQEv1xEI2HooVudzcus1x
   VLUxWw5y+qRJVtd0W1GAQiIARKPfu8+WDVTZFFlW9R1xNDwdefMRFpAGP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="382893318"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="382893318"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 17:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="705793755"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="705793755"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by orsmga003.jf.intel.com with ESMTP; 16 Oct 2023 17:48:37 -0700
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
Subject: [PATCH v8 3/5] mm: Add structure to keep sva information
Date:   Tue, 17 Oct 2023 08:48:00 +0800
Message-Id: <20231017004802.109618-4-tina.zhang@intel.com>
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
index 074b98f9e5dc..e350520e3a35 100644
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

