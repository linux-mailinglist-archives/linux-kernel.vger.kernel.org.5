Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50CF7F1CFE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjKTS77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKTS76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:59:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59DFCF;
        Mon, 20 Nov 2023 10:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700506794; x=1732042794;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ye5Zm2pgA7I5UpHkkRalvaMuQWs3i6Zl+XGw5GrzJ/k=;
  b=VClgUoqeM4Q3xxaQkckQ3SrzIycsQGP276SLRaoOzt8oX2wGEzQ6eOil
   pjxS4GLSL4RlnpemqiJ8eCu4/d/R2bvoivgvut1SSitdEicd8BRCeNQNr
   Ebnqi1c1lyqqM+C9qxNUSiTOhZt2KfBjP7h7tq7xuO36OLC0xIwys6VKS
   ht2NFzbfykEQfBD3T2NwcPD1nIaX3UCnuIfzmKAe8FaSTHshxo33B4R9Y
   xD3Ix3TvZdu6CHZdRFyqQi0FS7mdWUR06EXabsMesp+I7wasUJ8afe1ot
   0CEWnJ2DZtmu7eSa093N82mLTWTI0u4sqcBqj3bxk8IURtKUSrYA0Pd3s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10354829"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="10354829"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 10:59:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1013672570"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="1013672570"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga006.fm.intel.com with ESMTP; 20 Nov 2023 10:59:53 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Allow firmware balance performance EPP without code change
Date:   Mon, 20 Nov 2023 10:59:42 -0800
Message-Id: <20231120185942.2320424-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware can specify balance performance EPP value by enabling HWP and
set EPP to a desired value. The current implementation requires code
change for every generation to add an entry to intel_epp_balance_perf
table.

Some distributions like Chrome, which uses old kernels should be able
to update balance performance EPP, without code change.

There is a check to avoid updating EPP when the balance performance
EPP is not changed and is power up default of 0x80. Move this check
after checking if the HWP is enabled by the firmware and there is
a valid EPP value set by the firmware.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a534a1f7f1ee..dd6d23e389f1 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1691,13 +1691,6 @@ static void intel_pstate_update_epp_defaults(struct cpudata *cpudata)
 {
 	cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
 
-	/*
-	 * If this CPU gen doesn't call for change in balance_perf
-	 * EPP return.
-	 */
-	if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] == HWP_EPP_BALANCE_PERFORMANCE)
-		return;
-
 	/*
 	 * If the EPP is set by firmware, which means that firmware enabled HWP
 	 * - Is equal or less than 0x80 (default balance_perf EPP)
@@ -1710,6 +1703,13 @@ static void intel_pstate_update_epp_defaults(struct cpudata *cpudata)
 		return;
 	}
 
+	/*
+	 * If this CPU gen doesn't call for change in balance_perf
+	 * EPP return.
+	 */
+	if (epp_values[EPP_INDEX_BALANCE_PERFORMANCE] == HWP_EPP_BALANCE_PERFORMANCE)
+		return;
+
 	/*
 	 * Use hard coded value per gen to update the balance_perf
 	 * and default EPP.
-- 
2.34.1

