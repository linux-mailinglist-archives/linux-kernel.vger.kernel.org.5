Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F467C62F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376949AbjJLCjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376785AbjJLCiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:38:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630B5B8;
        Wed, 11 Oct 2023 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697078326; x=1728614326;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mBii77f6Tub8OeZTcO0T88l7WLLb4F5mDZGSeHY9/WM=;
  b=X1s/txOpv3H2o21tsvpq6iRNVJKL6YFsLWbQO80/kcjqPr9dp3S13kuR
   SpQJbmV3Tp33WIhVIDUKZVFqKTkggwgaUtZN/7bysXlYXhWuIH1stOgD5
   J3jaHzM7T7QScp6F/CWFOLdSUBkFxDOleiMrCJwY41qVPvaolg7f7dlp8
   Ae4FQ+PihOeJlB9zuOHw00bJdBacL+xZDp8EKwpzL09w6kUgDlmWG+8mk
   Esg46nPNYPZ8dj6yYKQcsalfRBJ5AeXBVm82AuAP89G2lQe9VkJm/bVn5
   lsj8Q9yYfHqHY+EvXMHyaYztU3WEVHLMd7Gm/uspN25Hl/aUbC2UCAkdP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3402633"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3402633"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783507868"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783507868"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:42 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.105.238])
        by linux.intel.com (Postfix) with ESMTP id 98A2D580DBE;
        Wed, 11 Oct 2023 19:38:42 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V3 12/16] platform/x86/intel/pmc: Display LPM requirements for multiple PMCs
Date:   Wed, 11 Oct 2023 19:38:36 -0700
Message-Id: <20231012023840.3845703-13-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012023840.3845703-1-david.e.box@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>
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

From: Rajvi Jingar <rajvi.jingar@linux.intel.com>

Update the substate_requirements attribute to display the requirements for
all the PMCs on a package.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V3 - Add missing submitter signoff

V2 - no change

 drivers/platform/x86/intel/pmc/core.c | 129 ++++++++++++++------------
 1 file changed, 71 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e58c8cc286a3..df2bcead1723 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -728,7 +728,7 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
 
-static void pmc_core_substate_req_header_show(struct seq_file *s)
+static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
 {
 	struct pmc_dev *pmcdev = s->private;
 	int i, mode;
@@ -743,68 +743,81 @@ static void pmc_core_substate_req_header_show(struct seq_file *s)
 static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	const struct pmc_bit_map **maps = pmc->map->lpm_sts;
-	const struct pmc_bit_map *map;
-	const int num_maps = pmc->map->lpm_num_maps;
-	u32 sts_offset = pmc->map->lpm_status_offset;
-	u32 *lpm_req_regs = pmc->lpm_req_regs;
-	int mp;
-
-	/* Display the header */
-	pmc_core_substate_req_header_show(s);
-
-	/* Loop over maps */
-	for (mp = 0; mp < num_maps; mp++) {
-		u32 req_mask = 0;
-		u32 lpm_status;
-		int mode, idx, i, len = 32;
-
-		/*
-		 * Capture the requirements and create a mask so that we only
-		 * show an element if it's required for at least one of the
-		 * enabled low power modes
-		 */
-		pmc_for_each_mode(idx, mode, pmcdev)
-			req_mask |= lpm_req_regs[mp + (mode * num_maps)];
-
-		/* Get the last latched status for this map */
-		lpm_status = pmc_core_reg_read(pmc, sts_offset + (mp * 4));
-
-		/*  Loop over elements in this map */
-		map = maps[mp];
-		for (i = 0; map[i].name && i < len; i++) {
-			u32 bit_mask = map[i].bit_mask;
-
-			if (!(bit_mask & req_mask))
-				/*
-				 * Not required for any enabled states
-				 * so don't display
-				 */
-				continue;
-
-			/* Display the element name in the first column */
-			seq_printf(s, "%30s |", map[i].name);
-
-			/* Loop over the enabled states and display if required */
-			pmc_for_each_mode(idx, mode, pmcdev) {
-				if (lpm_req_regs[mp + (mode * num_maps)] & bit_mask)
-					seq_printf(s, " %9s |",
-						   "Required");
+	u32 sts_offset;
+	u32 *lpm_req_regs;
+	int num_maps, mp, pmc_index;
+
+	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs); ++pmc_index) {
+		struct pmc *pmc = pmcdev->pmcs[pmc_index];
+		const struct pmc_bit_map **maps;
+
+		if (!pmc)
+			continue;
+
+		maps = pmc->map->lpm_sts;
+		num_maps = pmc->map->lpm_num_maps;
+		sts_offset = pmc->map->lpm_status_offset;
+		lpm_req_regs = pmc->lpm_req_regs;
+
+		if (!lpm_req_regs)
+			continue;
+
+		/* Display the header */
+		pmc_core_substate_req_header_show(s, pmc_index);
+
+		/* Loop over maps */
+		for (mp = 0; mp < num_maps; mp++) {
+			u32 req_mask = 0;
+			u32 lpm_status;
+			const struct pmc_bit_map *map;
+			int mode, idx, i, len = 32;
+
+			/*
+			 * Capture the requirements and create a mask so that we only
+			 * show an element if it's required for at least one of the
+			 * enabled low power modes
+			 */
+			pmc_for_each_mode(idx, mode, pmcdev)
+				req_mask |= lpm_req_regs[mp + (mode * num_maps)];
+
+			/* Get the last latched status for this map */
+			lpm_status = pmc_core_reg_read(pmc, sts_offset + (mp * 4));
+
+			/*  Loop over elements in this map */
+			map = maps[mp];
+			for (i = 0; map[i].name && i < len; i++) {
+				u32 bit_mask = map[i].bit_mask;
+
+				if (!(bit_mask & req_mask)) {
+					/*
+					 * Not required for any enabled states
+					 * so don't display
+					 */
+					continue;
+				}
+
+				/* Display the element name in the first column */
+				seq_printf(s, "pmc%d: %26s |", pmc_index, map[i].name);
+
+				/* Loop over the enabled states and display if required */
+				pmc_for_each_mode(idx, mode, pmcdev) {
+					if (lpm_req_regs[mp + (mode * num_maps)] & bit_mask)
+						seq_printf(s, " %9s |",
+							   "Required");
+					else
+						seq_printf(s, " %9s |", " ");
+				}
+
+				/* In Status column, show the last captured state of this agent */
+				if (lpm_status & bit_mask)
+					seq_printf(s, " %9s |", "Yes");
 				else
 					seq_printf(s, " %9s |", " ");
+
+				seq_puts(s, "\n");
 			}
-
-			/* In Status column, show the last captured state of this agent */
-			if (lpm_status & bit_mask)
-				seq_printf(s, " %9s |", "Yes");
-			else
-				seq_printf(s, " %9s |", " ");
-
-			seq_puts(s, "\n");
 		}
 	}
-
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_req_regs);
-- 
2.34.1

