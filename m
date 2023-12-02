Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C6801BE3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjLBJxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjLBJxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:53:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F7AD50;
        Sat,  2 Dec 2023 01:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510832; x=1733046832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DNvEQ5Df+enLLKlvPpgNl8iSMA8LDSmYdeB3/CStJvw=;
  b=eWHszJLNQJpKxhmd4cOBWfgH2FcceSsLHm0/+Eaq7DmcxmUaU6zWQ2q5
   TLTcyJ7S6IfQBGW7ZtE0dyHDUES+kgi6i7EJIEpB9zQCqz/yUIyjkWWzz
   6hh/V8edrecTCYxVNMcCUs9yFJz/ha51H6ZmgRVbVOEuAYkPXeP/lfFYt
   QUTOQIMyaynYXcfJ5pY3Eouv4Y7AOD1WTlQX55Pq7DqZ5ydrnF1vfnKl6
   PkZhw6+Qg9ZHBBb37EbYvdxo9iqKZLHfcbBeU9j7OuT40g8KyWXEkWokb
   OLVjRywITAeACNkHF06HGplHt263b+U5MPggfldLqw1osDXEW/YZxCoke
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="625567"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="625567"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="719780723"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="719780723"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:53:47 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 19/42] iommu/vt-d: Set bit PGSNP in PASIDTE if domain cache coherency is enforced
Date:   Sat,  2 Dec 2023 17:24:52 +0800
Message-Id: <20231202092452.14581-1-yan.y.zhao@intel.com>
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

Set bit PGSNP (Page Snoop, bit 88) in PASIDTE when attaching device to a
domain whose cache coherency is enforced.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/iommu/intel/pasid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 74e8e4c17e814..a42955b5e666f 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -679,10 +679,11 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_address_width(pte, agaw);
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_SL_ONLY);
 	pasid_set_fault_enable(pte);
+	if (domain->force_snooping)
+		pasid_set_pgsnp(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 	if (domain->dirty_tracking)
 		pasid_set_ssade(pte);
-
 	pasid_set_present(pte);
 	spin_unlock(&iommu->lock);
 
-- 
2.17.1

