Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F967EF659
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbjKQQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjKQQjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:39:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E359DA4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700239190; x=1731775190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/0Udwl92A8XLCPRNOLdJd6f4FOmxfC3B2MzsdWYYuXI=;
  b=W0YS32EHiPKV5XJXlGVSDo0p7/7PlOzmDsWYcomi0M+p5spoVshp2MBG
   5Rt2bID/91b+15BEh5ILmKKfeamPkRfcqEWZZF6s5uVwhskAn6KUX/QCk
   WwpfI9prAGq8JJNPM26lHX1DEaO5Fp4DrkuZ/xUTfRMR9wBU+YeoPs0sD
   ElV5myKyQuC2DGVhNb0YWv1JC7dt5WUNtH7GtAzmhuuqLz9vs1cbnuaBh
   ZaCfKXutoUq1bJ1wnUscArampQcBpPBMTtuV6zjcs9aXz35XwkwgO4IC3
   UWk9u6ODTjVvD0GZ+osiZWJxmN1gws4odX1yi0Y06+qvhuGSL9Z7gb51H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390185871"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390185871"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 08:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097146187"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1097146187"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2023 08:39:49 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH V2 1/5] perf/x86/intel/uncore: Generic uncore_get_uncores and MMIO format of SPR
Date:   Fri, 17 Nov 2023 08:39:35 -0800
Message-Id: <20231117163939.2468007-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Tested-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Add Tested-by tag

 arch/x86/events/intel/uncore_snbep.c | 34 +++++++++++++++++++---------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 8250f0f59c2b..fc6587016af7 100644
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
@@ -6552,7 +6558,9 @@ int spr_uncore_pci_init(void)
 	spr_update_device_location(UNCORE_SPR_M3UPI);
 	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI,
 						UNCORE_SPR_PCI_EXTRA_UNCORES,
-						spr_pci_uncores);
+						spr_pci_uncores,
+						UNCORE_SPR_NUM_UNCORE_TYPES,
+						spr_uncores);
 	return 0;
 }
 
@@ -6560,12 +6568,16 @@ void spr_uncore_mmio_init(void)
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

