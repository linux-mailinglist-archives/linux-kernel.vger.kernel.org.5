Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A044E7B9FFF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjJEOby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjJEO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:29:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3051BCE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513798; x=1728049798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GqBmdwk3PyLHKED6fQmN6GNYFOOxanulXD/wbm+aH4E=;
  b=R5OT80EJ0cfY4GUFNVunIrK0iYM7/2ua7qJuQeNwz5KtHyMq7ZJvGQmu
   HC8B6i2d8zWNkyk15fetA505VFO7aVa/vTWwv/ycfltIL4/AHo44wWsKK
   cEO5XgDNJOPLl48Z6xarQwO8YeA+ezgoIEj3HxvblFGT5nIC+EqeXVe5A
   sdMq9YxCfF7iMZz2FRrvZZY+wjAZsQYhq1joINQva0xNxZs/rDTSvT1J8
   TmUbNf3wYaM68JLEGKzDCxA3GRbf3iEd6VJ5GRovBJHbYLmTUbXEtOB/o
   b9CU3x9F4/EEfmR8sxondnfibxNoiAsuub38oFEbhWSELFTwzclVZZH5d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383339366"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="383339366"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="875476724"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="875476724"
Received: from lpopiela-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.13.229])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:15:56 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Newman <peternewman@google.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] x86/resctrl: Rename arch_has_sparse_bitmaps
Date:   Thu,  5 Oct 2023 10:15:36 +0200
Message-ID: <c05d9bab52da55fb98e98147cfe1a412a5089445.1696493034.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A later patch exposes the value of arch_has_sparse_bitmaps to
user space via the existing term of a bitmask. Rename
arch_has_sparse_bitmaps to arch_has_sparse_bitmasks to ensure
consistent terminology throughout resctrl.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changelog v4:
- Add Ilpo's reviewed-by tag.
- Add Reinette's reviewed-by tag.

Changelog v3:
- Add Peter's tested-by and reviewed-by tags.
- Make this patch first in the series. (Reinette)
- Change the patch message. (Reinette)
- Drop rmid_busy_llc comment name change. (Reinette)

Changelog v2:
- Create this patch.

 arch/x86/kernel/cpu/resctrl/core.c        | 4 ++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 include/linux/resctrl.h                   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 030d3b409768..c09e4fdded3c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -872,7 +872,7 @@ static __init void rdt_init_res_defs_intel(void)
 
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L2) {
-			r->cache.arch_has_sparse_bitmaps = false;
+			r->cache.arch_has_sparse_bitmasks = false;
 			r->cache.arch_has_per_cpu_cfg = false;
 			r->cache.min_cbm_bits = 1;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
@@ -892,7 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
 
 		if (r->rid == RDT_RESOURCE_L3 ||
 		    r->rid == RDT_RESOURCE_L2) {
-			r->cache.arch_has_sparse_bitmaps = true;
+			r->cache.arch_has_sparse_bitmasks = true;
 			r->cache.arch_has_per_cpu_cfg = true;
 			r->cache.min_cbm_bits = 0;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b44c487727d4..ab45012288bb 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -113,8 +113,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 	first_bit = find_first_bit(&val, cbm_len);
 	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
 
-	/* Are non-contiguous bitmaps allowed? */
-	if (!r->cache.arch_has_sparse_bitmaps &&
+	/* Are non-contiguous bitmasks allowed? */
+	if (!r->cache.arch_has_sparse_bitmasks &&
 	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
 		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
 		return false;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8334eeacfec5..66942d7fba7f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -94,7 +94,7 @@ struct rdt_domain {
  *			zero CBM.
  * @shareable_bits:	Bitmask of shareable resource with other
  *			executing entities
- * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
+ * @arch_has_sparse_bitmasks:	True if a bitmask like f00f is valid.
  * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
  *				level has CPU scope.
  */
@@ -102,7 +102,7 @@ struct resctrl_cache {
 	unsigned int	cbm_len;
 	unsigned int	min_cbm_bits;
 	unsigned int	shareable_bits;
-	bool		arch_has_sparse_bitmaps;
+	bool		arch_has_sparse_bitmasks;
 	bool		arch_has_per_cpu_cfg;
 };
 
-- 
2.42.0

