Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5137B569A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbjJBPD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbjJBPDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:03:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8213FAC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696259002; x=1727795002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b81D1JINHi5ibUTtiEbFI9DrxQMJ+q3uFxu+iVHcAlI=;
  b=IkYBynFMHZPtgFbRc3Im95Oy6RPvwMzrn67pfNzlY5S/7mYkjRkqIYKQ
   k8mCV/6nVJgk0l9ZMCupJFjRz09B1dMtL7CTKm81+sXcxSiE0p3rjTy/7
   K4SXTfYFy+jXnhA80jVD3YQzgljHLZI/cQ18ZfhVjXI6SKPwaJtnUFu4e
   KOVNV3CHZGmqOE1nZfqK5F/xmSrw00xFB79FwPZMdCJQ44WRnSIDh6oqx
   4YJ9LMq+2AOkhWFZ46HDNpFzojEvzS/ty514NCBUkBTLdis2qWkSSPzYI
   aF8Kk1NQOGrpuxj5k1uX3yze7usTpYtKiVW/TLrosFIZhB0fJMFPT+Pgm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362033035"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362033035"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 08:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="820904658"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="820904658"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 02 Oct 2023 08:03:19 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/5] perf/x86/intel/uncore: Generic uncore_get_uncores and MMIO format of SPR
Date:   Mon,  2 Oct 2023 08:03:21 -0700
Message-Id: <20231002150325.2025749-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Factor out SPR_UNCORE_MMIO_COMMON_FORMAT which can be reused by
Granite Rapids in the following patch.

Granite Rapids have more uncore units than Sapphire Rapids. Add new
parameters to support adjustable uncore units.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 34 +++++++++++++++++++---------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index d49e90dc04a4..cef51b83410a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6079,13 +6079,16 @@ static struct uncore_event_desc spr_uncore_imc_events[] = {
 	{ /* end: all zeroes */ },
 };
 
+#define SPR_UNCORE_MMIO_COMMON_FORMAT()				\
+	SPR_UNCORE_COMMON_FORMAT(),				\
+	.ops			= &spr_uncore_mmio_ops
+
 static struct intel_uncore_type spr_uncore_imc = {
-	SPR_UNCORE_COMMON_FORMAT(),
+	SPR_UNCORE_MMIO_COMMON_FORMAT(),
 	.name			= "imc",
 	.fixed_ctr_bits		= 48,
 	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
 	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
-	.ops			= &spr_uncore_mmio_ops,
 	.event_descs		= spr_uncore_imc_events,
 };
 
@@ -6412,7 +6415,8 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 
 static struct intel_uncore_type **
 uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
-		    struct intel_uncore_type **extra)
+		   struct intel_uncore_type **extra, int max_num_types,
+		   struct intel_uncore_type **uncores)
 {
 	struct intel_uncore_type **types, **start_types;
 	int i;
@@ -6421,9 +6425,9 @@ uncore_get_uncores(enum uncore_access_type type_id, int num_extra,
 
 	/* Only copy the customized features */
 	for (; *types; types++) {
-		if ((*types)->type_id >= UNCORE_SPR_NUM_UNCORE_TYPES)
+		if ((*types)->type_id >= max_num_types)
 			continue;
-		uncore_type_customized_copy(*types, spr_uncores[(*types)->type_id]);
+		uncore_type_customized_copy(*types, uncores[(*types)->type_id]);
 	}
 
 	for (i = 0; i < num_extra; i++, types++)
@@ -6470,7 +6474,9 @@ void spr_uncore_cpu_init(void)
 
 	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
 						UNCORE_SPR_MSR_EXTRA_UNCORES,
-						spr_msr_uncores);
+						spr_msr_uncores,
+						UNCORE_SPR_NUM_UNCORE_TYPES,
+						spr_uncores);
 
 	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
 	if (type) {
@@ -6542,7 +6548,9 @@ int spr_uncore_pci_init(void)
 	spr_update_device_location(UNCORE_SPR_M3UPI);
 	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI,
 						UNCORE_SPR_PCI_EXTRA_UNCORES,
-						spr_pci_uncores);
+						spr_pci_uncores,
+						UNCORE_SPR_NUM_UNCORE_TYPES,
+						spr_uncores);
 	return 0;
 }
 
@@ -6550,12 +6558,16 @@ void spr_uncore_mmio_init(void)
 {
 	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
 
-	if (ret)
-		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL);
-	else {
+	if (ret) {
+		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+							 UNCORE_SPR_NUM_UNCORE_TYPES,
+							 spr_uncores);
+	} else {
 		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
 							 UNCORE_SPR_MMIO_EXTRA_UNCORES,
-							 spr_mmio_uncores);
+							 spr_mmio_uncores,
+							 UNCORE_SPR_NUM_UNCORE_TYPES,
+							 spr_uncores);
 
 		spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;
 	}
-- 
2.35.1

