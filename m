Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B030C80FA6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377831AbjLLWXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377700AbjLLWXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:23:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0E3B3;
        Tue, 12 Dec 2023 14:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702419817; x=1733955817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=W4YA1C9BueESa8/SGirgrSDyXjHGqZ5rFE/K4wRbmoQ=;
  b=c2q54uVasS/9EyT+b0OVaBzSu05xzC9t1FaTFmvNfepSLsv48cHdpiM3
   g4MEphnlyQ61dqTZ9jn2SXeo+/r1iZX852SmMx8unUOyMw6S2gGB4RYed
   fcRNmerT5/ABz+xLfRmDaVD4MoU9bJjvrPLt5d4O0qvxi2RUhhCxSGvAt
   h/bEnh6phKgLcV+bFgYYy5jBU1wH54jmYDU5qbR/eylSOtfwqIBBSpmnM
   kB3xKKHAwdlEVNa6/5WuyBKtv/nqrIQmOAPnzdIvJVuHk3+FZd1j3idwx
   OXl8dP4MsJsc6Mq6HOCMWB8/tTCMI2/a6/71LtmGDRKMEbI/4siNsty28
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2049314"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2049314"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 14:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="802631188"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="802631188"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2023 14:23:36 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     x86@kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Radu Rendec <rrendec@redhat.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] cacheinfo: Allocate memory for memory if not done from the primary CPU
Date:   Tue, 12 Dec 2023 14:25:17 -0800
Message-Id: <20231212222519.12834-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
References: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
adds functionality that architectures can use to optionally allocate and
build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
arch specific early level initializer") lets secondary CPUs correct (and
reallocate memory) cacheinfo data if needed.

If the early build functionality is not used and cacheinfo does not need
correction, memory for cacheinfo is never allocated. x86 does not use the
early build functionality. Consequently, during the cacheinfo CPU hotplug
callback, last_level_cache_is_valid() attempts to dereference a NULL
pointer:

     BUG: kernel NULL pointer dereference, address: 0000000000000100
     #PF: supervisor read access in kernel mode
     #PF: error_code(0x0000) - not present page
     PGD 0 P4D 0
     Oops: 0000 [#1] PREEPMT SMP NOPTI
     CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
     RIP: 0010: last_level_cache_is_valid+0x95/0xe0a

Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
not done earlier.

Cc: Andreas Herrmann <aherrmann@suse.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Radu Rendec <rrendec@redhat.com>
Cc: Pierre Gondois <Pierre.Gondois@arm.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Reviewed-by: Radu Rendec <rrendec@redhat.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
The motivation for commit 5944ce092b97 was to prevent a BUG splat in
PREEMPT_RT kernels during memory allocation. This splat is not observed on
x86 because the memory allocation for cacheinfo happens in
detect_cache_attributes() from the cacheinfo CPU hotplug callback.

The dereference of a NULL pointer is not observed today because
cache_leaves(cpu) is zero until after init_cache_level() is called (also
during the CPU hotplug callback). A subsequent changeset will set the
number of cache leaves earlier and the NULL-pointer dereference will be
observed.
---
Changes since v3:
 * Added Reviewed-by tag from Radu and Sudeep. Thanks!

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 drivers/base/cacheinfo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 967c5cf3fb1d..735ccead190e 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -557,7 +557,11 @@ static inline int init_level_allocate_ci(unsigned int cpu)
 	 */
 	ci_cacheinfo(cpu)->early_ci_levels = false;
 
-	if (cache_leaves(cpu) <= early_leaves)
+	/*
+	 * Some architectures (e.g., x86) do not use early initialization.
+	 * Allocate memory now in such case.
+	 */
+	if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
 		return 0;
 
 	kfree(per_cpu_cacheinfo(cpu));
-- 
2.25.1

