Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8757932CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbjIFAHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjIFAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:07:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566431B4;
        Tue,  5 Sep 2023 17:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693958822; x=1725494822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1x+98I6W75YklJUUnjenc5YlfMOD4nUpx0ccD0PvGnA=;
  b=K/IZQYIaW/py1JY1alPDfCIZep4mn6zen52qawKPF78Xm9nNlYMTV1Z9
   t7oTVkNoQvt/5CVCrZPQdUio3sMtY7Ea/iaYSvraG6VDe1zODUK/BSYgI
   mG0feNjcGw0de9MsDkCBmHymibHe+QigiO2rdXMSKHjUtbWhT1w98q46D
   elxrjzfj1+TrudCsgn2WIKzhOsgy1gSvsIRUXBmeZGGSt0FEpGM/c/5Lb
   stU6rOWKTsVFKTI9DCSIDLwQrtiebdanhn1fnM/0TVbWeIQxRzCw4Ult4
   YkKyIdhZJw4f7pfdUZVcPJwvrKI5xTcV3VblVAUyPJIe57/i3WqGolfK1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374324904"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="374324904"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 17:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="776374246"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="776374246"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2023 17:06:42 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, sumeet.r.pawnikar@intel.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] powercap: intel_rapl: Fix setting of Power Limit 4 to 0
Date:   Tue,  5 Sep 2023 17:06:40 -0700
Message-Id: <20230906000640.2919607-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System runs at minimum performance, once powercap RAPL package domain
"enabled" flag is toggled.

Setting RAPL package domain enabled flag to 0, results in setting of
power limit 4 (PL4) MSR 0x601 to 0. This implies disabling PL4 limit.
The PL4 limit controls the peak power. This can significantly change
the performance. Even worse, when the enabled flag is set to 1 again.
This will set PL4 MSR value to 0x01, which means reduce peak power to
0.125W. This will force the system to run at the lowest possible
performance.

This is caused by a change which assumes that there is an enable bit
in the PL4 MSR like other power limits.

In functions set_floor_freq_default() and rapl_remove_package(), call
rapl_write_pl_data with PL_ENABLE and PL_CLAMP for only power limit 1
and 2. Similarly don't read PL_ENABLE for PL4 to check the presence of
power limit 4. Power limit 4 support is based on CPU model in this
driver. No additional checks can be done.

Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits support")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org # v6.5+
---
 drivers/powercap/intel_rapl_common.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 5c2e6d5eea2a..0afedf7ad872 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -184,8 +184,6 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 	case POWER_LIMIT4:
 		if (prim == PL_LIMIT)
 			return POWER_LIMIT4;
-		if (prim == PL_ENABLE)
-			return PL4_ENABLE;
 		/* PL4 would be around two times PL2, use same prim as PL2. */
 		if (prim == PL_MAX_POWER)
 			return MAX_POWER;
@@ -1033,17 +1031,13 @@ static void package_power_limit_irq_restore(struct rapl_package *rp)
 
 static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
 {
-	int i;
-
 	/* always enable clamp such that p-state can go below OS requested
 	 * range. power capping priority over guranteed frequency.
 	 */
 	rapl_write_pl_data(rd, POWER_LIMIT1, PL_CLAMP, mode);
 
-	for (i = POWER_LIMIT2; i < NR_POWER_LIMITS; i++) {
-		rapl_write_pl_data(rd, i, PL_ENABLE, mode);
-		rapl_write_pl_data(rd, i, PL_CLAMP, mode);
-	}
+	rapl_write_pl_data(rd, POWER_LIMIT2, PL_ENABLE, mode);
+	rapl_write_pl_data(rd, POWER_LIMIT2, PL_CLAMP, mode);
 }
 
 static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
@@ -1458,7 +1452,7 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
 			}
 		}
 
-		if (rapl_read_pl_data(rd, i, PL_ENABLE, false, &val64))
+		if (i != POWER_LIMIT4 && rapl_read_pl_data(rd, i, PL_ENABLE, false, &val64))
 			rd->rpl[i].name = NULL;
 	}
 }
@@ -1510,7 +1504,7 @@ void rapl_remove_package(struct rapl_package *rp)
 	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
 		int i;
 
-		for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
+		for (i = POWER_LIMIT1; i <= POWER_LIMIT2; i++) {
 			rapl_write_pl_data(rd, i, PL_ENABLE, 0);
 			rapl_write_pl_data(rd, i, PL_CLAMP, 0);
 		}
-- 
2.34.1

