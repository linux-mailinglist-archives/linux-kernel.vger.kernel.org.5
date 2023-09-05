Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD856791FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 02:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbjIEAKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 20:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242816AbjIEAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 20:10:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA69CE2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693872616; x=1725408616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=69SRzUQvDZdG00nzwrRDO1edksKrqqQn3DhViP1IvTM=;
  b=KLBVbLhP/a9JXT+Hh+jHn4cv8fmrkRKoePjj1tYZcoZsZYaYSrcJ2Ai4
   wRn59DFQ2j2h+T1RR3bzQQRtA/K7nIihXDNFshSKi5GUgZY40ag83oeFs
   HR0CrHRB8xigdaEBKRjxSZdO1mPfB5E42fRaDhyjwKkeMzYhAj9ZFbVP1
   a4nYtIG3kbKhmfmpZcfEpHc1pBTy2335g3oITmNUfNk3YGDTUR1JYtYua
   SJhNrUqsDwLaCYzbDheLUIHfwcmnrah16SRhEuSNbvkd6LVdxpvxxvDbC
   ZkbCrrVKS/3Tl9P5GTSdHwxx8f++FRgVZIsoKSND/2/fKwzzLAmf+UP4c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="463039975"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="463039975"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 17:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="884125137"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="884125137"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2023 17:09:55 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v3 4/6] mm: Add structure to keep sva information
Date:   Tue,  5 Sep 2023 08:09:28 +0800
Message-Id: <20230905000930.24515-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230905000930.24515-1-tina.zhang@intel.com>
References: <20230905000930.24515-1-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce iommu_mm_data structure to keep sva information (pasid and the
related sva domains). Add iommu_mm pointer, pointing to an instance of
iommu_mm_data structure, to mm.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/linux/iommu.h    | 5 +++++
 include/linux/mm_types.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ab8784dfdbd9..937f3abc26f2 100644
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
index 7d30dc4ff0ff..b486f521afee 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -595,6 +595,7 @@ struct mm_cid {
 #endif
 
 struct kioctx_table;
+struct iommu_mm_data;
 struct mm_struct {
 	struct {
 		/*
@@ -808,6 +809,7 @@ struct mm_struct {
 
 #ifdef CONFIG_IOMMU_SVA
 		u32 pasid;
+		struct iommu_mm_data *iommu_mm;
 #endif
 #ifdef CONFIG_KSM
 		/*
-- 
2.17.1

