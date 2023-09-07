Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECABE797B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbjIGSDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245688AbjIGSDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:03:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AEF135;
        Thu,  7 Sep 2023 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109776; x=1725645776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u0dkGJgRvb007oo4gHle5cfoOoPHiOeV5c7Xd+Hdbcw=;
  b=EqUi3tjYKQBYrFpQCCKcCpjyQq6cGu+vXDkhdB3tAiPe4eVPjXkh4yQO
   63ycJ2TH/sFfLxO1dpQQkbJcgvPgxTAa/Y3V+zeDSJ98fvlQ3FBQAvlzI
   uais1KXNVUfxhQW4LvwkUEDPoGSIdcCpM8/wMNLEhp6oNIcEHjl8PAaCX
   fXVuB4Txg0IhOlrl1zN2AX8V0Htx3GqDTpdwoapEtj8mqC4JXGlixl5P2
   ASzeFPgaT7Js6/DHa/ts6wBZNC0Yc/ZjwPccEdHu3IhoJiVUBKzUuJUBh
   IPjViyWW2CfpQzIRKthyE7EZZkxYEuZTJeMDfrOgxEcYxWl319kSvj2gf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="376340246"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="376340246"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 11:02:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="691883886"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="691883886"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2023 11:02:24 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix global turbo disable check
Date:   Thu,  7 Sep 2023 11:02:07 -0700
Message-Id: <20230907180207.3274207-1-srinivas.pandruvada@linux.intel.com>
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

Setting global turbo flag based on CPU 0 P-state limits is problematic
as it limits max P-state request on every CPU on the system just based
on its P-state limits.

There are two cases in which global.turbo_disabled flag is set:
- When the MSR_IA32_MISC_ENABLE_TURBO_DISABLE bit is set to 1
in the MSR MSR_IA32_MISC_ENABLE. This bit can be only changed by
the system BIOS before power up.
- When the max non turbo P-state is same as max turbo P-state for CPU 0.

The second check is not a valid to decide global turbo state based on
the CPU 0. CPU 0 max turbo P-state can be same as max non turbo P-state,
but for other CPUs this may not be true.

There is no guarantee that max P-state limits are same for every CPU. This
is possible that during fusing max P-state for a CPU is constrained. Also
with the Intel Speed Select performance profile, CPU 0 may not be present
in all profiles. In this case the max non turbo and turbo P-state can be
set to the lowest possible P-state by the hardware when switched to
such profile. Since max non turbo and turbo P-state is same,
global.turbo_disabled flag will be set.

Once global.turbo_disabled is set, any scaling max and min frequency
update for any CPU will result in its max P-state constrained to the max
non turbo P-state.

Hence remove the check of max non turbo P-state equal to max turbo P-state
of CPU 0 to set global turbo disabled flag.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dc50c9fb488d..a534a1f7f1ee 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -571,13 +571,9 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 static inline void update_turbo_state(void)
 {
 	u64 misc_en;
-	struct cpudata *cpu;
 
-	cpu = all_cpu_data[0];
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
-	global.turbo_disabled =
-		(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
-		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
+	global.turbo_disabled = misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
 }
 
 static int min_perf_pct_min(void)
-- 
2.34.1

