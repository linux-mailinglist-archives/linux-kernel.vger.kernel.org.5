Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAA47E1AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjKFHOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFHOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:14:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A93D8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699254841; x=1730790841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c9GeMl676tMxuvRJHqXrxAMwFdaSUf5heq0NrXZPU0Q=;
  b=Yz3QYMGXBJaVza0EErGtDr++UqnzoYwipTPYBeeJZIjZITKxzCNvxyGV
   KKMiM9oe9bDJdynXu5iR4jDXxeE8W+vLpWHzrthCKCkcDOF1q8woWVMRT
   kyxVKLDI3dC5HsfrKiiElE4+lgelm0dCGwKJw5AWPpD1eXuiKUVAZl5i8
   OQprKUnp0uHtkv8jhE5TW13W7zobrb5UwfKAPRX69pMGcS41kg11Ysd8l
   PShFL+qPhrtR/6mf2KjT6eBw4SVKDTf0f00AJ2gvk9FRwqeLmSxBiNr6B
   jExKqBxZgF4P6i6w3y2B2P9wXUbivZW8Qbh8UuDFFVryElB5cA4we0pft
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10759042"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="10759042"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:14:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093690868"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="1093690868"
Received: from sqa-gate.sh.intel.com (HELO localhost.localdomain) ([10.239.48.212])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 23:13:57 -0800
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org, Yi Liu <yi.l.liu@intel.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [RFC PATCH 1/5] iommu/virtio-iommu: Correct the values of granule and nr_pages
Date:   Mon,  6 Nov 2023 02:12:22 -0500
Message-Id: <20231106071226.9656-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106071226.9656-1-tina.zhang@intel.com>
References: <20231106071226.9656-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of granule is ilog2(pgsize). When the value of pgsize isn't
a power of two, granule would make pgsize less than the actual size of
pgsize. E.g., if pgsize = 0x6000 and granule = ilog2(gather->pgsize), then
granule = 0xe. 2^0xe = 0x4000 makes the pgsize (0x4000) smaller than the
actual pgsize (0x6000). Invalidating IOTLB with smaller range would lead
to cache incoherence. So, roundup pgsize value to the nearest power of 2
to make sure the granule won't make pgsize less than the actual size. The
value of "gather->end - gather->start + 1" also needs similar adjustment.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/virtio-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08e310672e57..b1ceaac974e2 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1289,8 +1289,8 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
 		if (!gather->pgsize)
 			return;
 
-		granule = ilog2(gather->pgsize);
-		nr_pages = (gather->end - gather->start + 1) >> granule;
+		granule = ilog2(__roundup_pow_of_two(gather->pgsize));
+		nr_pages = __roundup_pow_of_two(gather->end - gather->start + 1) >> granule;
 		req = (struct virtio_iommu_req_invalidate) {
 			.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
 			.inv_gran	= cpu_to_le16(VIRTIO_IOMMU_INVAL_G_VA),
-- 
2.39.3

