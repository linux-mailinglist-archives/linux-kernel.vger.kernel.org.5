Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02480770D02
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjHEBWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjHEBWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:22:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961794EE1;
        Fri,  4 Aug 2023 18:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691198520; x=1722734520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HfpBXmQgyWwhKO4/HyLLANwpARjXDntGoaYnZredZVI=;
  b=ekri9UIUxd5e1wFmJ1vF0SEGuVCxM+wyikdrasv8iAdcd99e3iTBtC0V
   tUpgxnjCdmXxbMJ1NJPTw9SU9T+VqYCmBRMwKERyVWcX+Su2ibn6/d5Ms
   5dnOraTDjUEcULu/wEsdVXD0bmRDRqjHFd/dKbF1nfyHdPm2Bnupe5quN
   r9LSM/1vmr2dyv47L0wD7AvDjBoY7rjXZUv6zvUv25AxYYHO2rWOyYF/G
   drF5kwy7lMEWsDkdblXpl9+EAcJACfpdLjWShJ+RMIvaAtAIBQ0Z90GT5
   PAcxThCyeys8qa8v2v0aZgyB2hPiOPoorUlXSa4lh1HhEZ1gbrLKZbj5I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="367735762"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="367735762"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 18:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="844317617"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="844317617"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2023 18:21:58 -0700
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
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/3] cacheinfo: Allocate memory for memory if not done from the primary CPU
Date:   Fri,  4 Aug 2023 18:24:19 -0700
Message-Id: <20230805012421.7002-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Len Brown <len.brown@intel.com>
Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
The motivation for commit 5944ce092b97 was to prevent a BUG splat in
PREEMPT_RT kernels during memory allocation. This splat is not observed on
x86 because the memory allocation for cacheinfo happens in
detect_cache_attributes() from the cacheinfo CPU hotplug callback.

The dereference of a NULL pointer is not observed today because
cache_leaves(cpu) is zero until after init_cache_level() is called (also
during the CPU hotplug callback). Patch2 will set it earlier and the NULL-
pointer dereference will be observed.
---
Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 drivers/base/cacheinfo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index cbae8be1fe52..461a77ece4b0 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -554,7 +554,11 @@ static inline int init_level_allocate_ci(unsigned int cpu)
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

