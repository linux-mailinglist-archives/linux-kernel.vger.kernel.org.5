Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4615D792A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjIEQhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354710AbjIENmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:42:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C877198
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693921371; x=1725457371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EWdhTqXSo+oa3EFntk55iAJ91XkrSEBljVCp6FB3sFo=;
  b=IGVPk075PJTle56XYAo31Ot3utu7vrkxW/CfU2Ge9GC/9ZyUpmtjNYQB
   wtOCmUyeSMeburtwXWW7M/qGr9kPdMFnGI5TFPnGwukHhvxo443YE+Imp
   tbYoocEgacgmWxybW/WGNvFwPW8389hvGde7DyZ5G4hk3zPxdRHlp3nl6
   GLiefVfb+1IAhdsMC+sySrIshjYMZlCFKneeOMXgHscnZPaF1nKAgJLc/
   hckxXGA4zJY5UFhEZShUMkNLWmnOaWna8dKF7WDHI1+RoONYPkCmcCK03
   vKoj4bpUYpMxOKTO76a+RZ4RxKPvXslN7FFNvdIsrWSkOL1WGBLymX8ME
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443191720"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="443191720"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 06:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="864696429"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="864696429"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 05 Sep 2023 06:42:37 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Yunying Sun <yunying.sun@intel.com>
Subject: [PATCH V2] perf/x86/uncore: Correct the number of CHAs on EMR
Date:   Tue,  5 Sep 2023 06:42:48 -0700
Message-Id: <20230905134248.496114-1-kan.liang@linux.intel.com>
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

Starting from SPR, the basic uncore PMON information is retrieved from
the discovery table (resides in an MMIO space populated by BIOS). It is
called the discovery method. The existing value of the type->num_boxes
is from the discovery table.

On some SPR variants, there is a firmware bug. So the value from the
discovery table is incorrect. We use the value from the
SPR_MSR_UNC_CBO_CONFIG to replace the one from the discovery table.
Commit 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")

Unfortunately, the SPR_MSR_UNC_CBO_CONFIG isn't available for the EMR
XCC (Always returns 0). But the above firmware bug
doesn't impact the EMR XCC. Don't let the value from the MSR replace
the existing value from the discovery table.

Fixes: 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
Reported-by: Stephane Eranian <eranian@google.com>
Reported-by: Yunying Sun <yunying.sun@intel.com>
Tested-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 4d349986f76a..8250f0f59c2b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6474,8 +6474,18 @@ void spr_uncore_cpu_init(void)
 
 	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
 	if (type) {
+		/*
+		 * The value from the discovery table (stored in the type->num_boxes
+		 * of UNCORE_SPR_CHA) is incorrect on some SPR variants because of a
+		 * firmware bug. Using the value from SPR_MSR_UNC_CBO_CONFIG to replace it.
+		 */
 		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
-		type->num_boxes = num_cbo;
+		/*
+		 * The MSR doesn't work on the EMR XCC, but the firmware bug doesn't impact
+		 * the EMR XCC. Don't let the value from the MSR replace the existing value.
+		 */
+		if (num_cbo)
+			type->num_boxes = num_cbo;
 	}
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }
-- 
2.35.1

