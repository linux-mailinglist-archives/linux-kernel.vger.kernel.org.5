Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFB47CEBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjJRXRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjJRXQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F813128;
        Wed, 18 Oct 2023 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697670990; x=1729206990;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nIA54VODlA6cuxaaUaFCvZc22EZAk/2olF7xyeJddrs=;
  b=iTYgBMkQiRheIyOCgWeTeogtIWJoOalyKYlxrKnedGRjme292XoHILnd
   Sciywimc4Tx+8PvIU47WW1s48tlWiCbIKz7QKurc64EIK9R+5OZASolPW
   syXtblkXdy+o797pwMXE1x6NiWimo9eXR7ag8FXFGFhrtA/ZoLs3vtMal
   e33NqH1Wqj7s07ZrtrE2QDHD0AcXqA2Z8yNR/kPoc586r1G6ib0f+I0tO
   LLlzDKajSMHHG8vvG7AcuvVHmEW4VKV9qh9XShmT5YVvqSS7IHAsLqYB+
   q6nexuVOeY2kVm7aZA9LMRQNhoF5RP37lGnlFpMIX17Xhe6fbTmp6IkKA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452605966"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452605966"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756782186"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756782186"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:26 -0700
Received: from debox1-desk4.lan (unknown [10.209.71.91])
        by linux.intel.com (Postfix) with ESMTP id 4586C580DAE;
        Wed, 18 Oct 2023 16:16:26 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V4 13/17] platform/x86/intel/pmc: Display LPM requirements for multiple PMCs
Date:   Wed, 18 Oct 2023 16:16:20 -0700
Message-Id: <20231018231624.1044633-14-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018231624.1044633-1-david.e.box@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com>
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
V4 - No change

V3 - Add missing submitter signoff

V2 - no change

 drivers/platform/x86/intel/pmc/core.c | 129 ++++++++++++++------------
 1 file changed, 71 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3894119d61b0..fcb0dc702aea 100644
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

