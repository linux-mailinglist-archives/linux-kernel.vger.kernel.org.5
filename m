Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03277C692
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 06:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjHOEAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjHOD5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 23:57:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F360F30C8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692071759; x=1723607759;
  h=from:to:cc:subject:date:message-id;
  bh=jt9YzsZ2I4wM2fxk8/y9oZSOxe/K7GqCQ2Ekca7eW5g=;
  b=C9+zq4IsLwV+77Hd6iL820M3tOh+UOmivB95QrogEY+QSwZgrnSD1Y93
   7124bXJQe51RdWcAIyXQj7Gk6GZn709Tvm6LffjrnS1X66Yk1gULHIyQ+
   S0grtqfjlgNtlLtYZBopiepcog1KJZw0memHoUnzvlWBtF0jWUUzHFO6h
   mQk3CCAhoBl6QCcpkDtT4V1nP/uzF/IdxN+BTXpPrVFLGDQ60wjFb810z
   5FkS5cQ5M6j6PdwqFVh1kd0JG+BfedLWucoxVhRgyPkNFPnpLrD5Zt8FH
   PwP/z++ecl4JwxDl1/WQWrBSi9aAIAAefzpDwo/ktI/YMklawHx84pgm4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372192256"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="372192256"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 20:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683522705"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="683522705"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2023 20:55:56 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ben Segall <bsegall@google.com>,
        Caleb Callaway <caleb.callaway@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/sched: Restore the SD_ASYM_PACKING flag in the DIE domain
Date:   Mon, 14 Aug 2023 20:57:47 -0700
Message-Id: <20230815035747.11529-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8f2d6c41e5a6 ("x86/sched: Rewrite topology setup") dropped the
SD_ASYM_PACKING flag in the DIE domain added in commit 044f0e27dec6
("x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid
processors"). Restore it on hybrid processors.

The die-level domain does not depend on any build configuration and now
x86_sched_itmt_flags() is always needed. Remove the build dependency on
CONFIG_SCHED_[SMT|CLUSTER|MC].

Cc: Ben Segall <bsegall@google.com>
Cc: Caleb Callaway <caleb.callaway@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: 8f2d6c41e5a6 ("x86/sched: Rewrite topology setup")
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Caleb Callaway <caleb.callaway@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d7667a29acf3..944008c72754 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -579,7 +579,6 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 }
 
 
-#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
 	return sysctl_sched_itmt_enabled ? SD_ASYM_PACKING : 0;
@@ -603,7 +602,12 @@ static int x86_cluster_flags(void)
 	return cpu_cluster_flags() | x86_sched_itmt_flags();
 }
 #endif
-#endif
+
+static int x86_die_flags(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ?
+	       x86_sched_itmt_flags() : 0;
+}
 
 /*
  * Set if a package/die has multiple NUMA nodes inside.
@@ -640,7 +644,7 @@ static void __init build_sched_topology(void)
 	 */
 	if (!x86_has_numa_in_package) {
 		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, SD_INIT_NAME(DIE)
+			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(DIE)
 		};
 	}
 
-- 
2.25.1

