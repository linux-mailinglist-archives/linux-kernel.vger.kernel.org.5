Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB77D6D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjJYNWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjJYNWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:22:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1D1111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698240170; x=1729776170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VCsAR60EOLjvkvfdhGiMeRwZV7/SoJUu/p67SJIwIzA=;
  b=K6zF4434XbhZwHWesSWnINFp+4N2W77Jf4l60qjvfFVcDzsKWCWwS45N
   GVSWzt89ZsmR10mtm7ts+BIL/nrdmqf7V12ffrK/e4osiG39k+i1NGO4o
   mVGIrZOrYIowS0OPLZ4TPqamKvFWHw10xzOIpRpghtrgpti+e//ehRsZG
   /nT6xagU2TnhePHHOv74iH4y8FUajWI4Ojxnizsw/hg+RHGlCbTuoOwRa
   jm7odeb2v7vvhM8JJ9cgN1X95hf4ySYOR9GMrV+LiO/xLasNM5Fx3l9p9
   hVmcBDeQbdicRQDPLsKhEdbkEbLVL+FElQuHsQ3y0FrRETHR5WRvqFQXT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418427491"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="418427491"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 06:22:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1090220714"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="1090220714"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 25 Oct 2023 06:22:48 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] Revert "iommu/vt-d: Remove unused function"
Date:   Wed, 25 Oct 2023 21:18:54 +0800
Message-Id: <20231025131854.375388-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c61c255e114c52682546447ed44d3470b5708134.

The pasid_set_wpe() helper, which was removed by the reverted commit,
is still used by the nesting translation support in the iommufd tree.
To avoid a merge conflict, revert the commit.

Link: https://lore.kernel.org/linux-kernel/20231025153455.283c5b12@canb.auug.org.au/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 06ddb3c927f5..8f92b92f3d2a 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -335,6 +335,15 @@ static inline void pasid_set_fault_enable(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[0], 1 << 1, 0);
 }
 
+/*
+ * Setup the WPE(Write Protect Enable) field (Bit 132) of a
+ * scalable mode PASID entry.
+ */
+static inline void pasid_set_wpe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
+}
+
 /*
  * Setup the P(Present) field (Bit 0) of a scalable mode PASID
  * entry.
-- 
2.34.1

