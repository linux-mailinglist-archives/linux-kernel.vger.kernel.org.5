Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC69E7ED95F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbjKPC2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjKPC2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:28:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF5118D;
        Wed, 15 Nov 2023 18:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700101684; x=1731637684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i4SZmEyT6wpW2/7XS8XAzK1oS3JdmZRckxrVbhm4i0k=;
  b=fnV2fO9WltwBbIoA9VVdcnXAQz7rWOYVTOqtN0/VJfq1ntan630+gpQj
   EX/SYaFH8kis3N7JFtok19yOYmJY49Gv5yxttWRFisjTYMR4VWlsFqMmY
   4jdGXOwL7KTy72CHVmO+1Z/e9xjB9N19fQmRU0uTSReN5wn5+ZKpT88XK
   ulv17qau/VVqPdue4weu9Dypxhata8AK3Is3H4q+C6cLN9ioJYbw+lDvD
   uVXRczA+Rr9Jaoj//nkwZZrHpiYDmSKPLxaTVqQgA3ZD6uSuLJeQjvtvB
   F//fJoowl3aYeI9W4gEqhfe4rJ3wbgWhmIrKCY80iByQLRB0yKDLCu1wO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381393618"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="381393618"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 18:28:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="13403588"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 15 Nov 2023 18:27:59 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Abdul Halim, Mohd Syazwan" <mohd.syazwan.abdul.halim@intel.com>,
        stable@vger.kernel.org, Abdul@vger.kernel.org,
        Halim@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Add MTL to quirk list to skip TE disabling
Date:   Thu, 16 Nov 2023 10:23:24 +0800
Message-Id: <20231116022324.30120-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Abdul Halim, Mohd Syazwan" <mohd.syazwan.abdul.halim@intel.com>

The VT-d spec requires (10.4.4 Global Command Register, TE field) that:

Hardware implementations supporting DMA draining must drain any in-flight
DMA read/write requests queued within the Root-Complex before completing
the translation enable command and reflecting the status of the command
through the TES field in the Global Status register.

Unfortunately, some integrated graphic devices fail to do so after some
kind of power state transition. As the result, the system might stuck in
iommu_disable_translation(), waiting for the completion of TE transition.

Add MTL to the quirk list for those devices and skips TE disabling if the
qurik hits.

Fixes: b1012ca8dc4f ("iommu/vt-d: Skip TE disabling on quirky gfx dedicated iommu")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Halim, Mohd Syazwan <mohd.syazwan.abdul.halim@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 061df1b68ff7..22cadcefadaa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5080,7 +5080,7 @@ static void quirk_igfx_skip_te_disable(struct pci_dev *dev)
 	ver = (dev->device >> 8) & 0xff;
 	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
 	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
-	    ver != 0x9a && ver != 0xa7)
+	    ver != 0x9a && ver != 0xa7 && ver != 0x7d)
 		return;
 
 	if (risky_device(dev))
-- 
2.34.1

