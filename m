Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76FD80FA56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377864AbjLLWXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377809AbjLLWXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:23:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C60E92;
        Tue, 12 Dec 2023 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702419818; x=1733955818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JjzpfRR25ptOiQcPUOjeLG2ZsPBSBKfEfUSAHzk+JdM=;
  b=Sj8CPCw/jtQ1aoS9mlpsEwWa85zo+88No/DMRjWqlpwrd85cvOhWlBDZ
   FkC4osGpS1y362a8kxmdpbm0nsMEMALzLjDWroBeURuc+FRqXDfDi27Ww
   4f++vhnZkj+FwVE4Td8SahppdxMHVrkSAB99UhYlriI7LEWdbFJAPjVdG
   fXTzexq2Rea9FTY4NSHyHKs0BkZbYB/F9A5bUW6i7U3JIB6ZzaLHBHAY8
   l8eJTTawhNyCXG/myzOKEXjgzjkFp4+HNnYRwvkXdSU8GKa9cU1+56EXe
   joY6XVruR3oswDAX/C7qkJ6cOqTZ87Cqk+dqq9xUe1we5PJETP5TkKi+c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2049331"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2049331"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 14:23:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="802631196"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="802631196"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2023 14:23:37 -0800
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
Subject: [PATCH v4 4/4] x86/cacheinfo: Clean out init_cache_level()
Date:   Tue, 12 Dec 2023 14:25:19 -0800
Message-Id: <20231212222519.12834-5-ricardo.neri-calderon@linux.intel.com>
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

init_cache_level() no longer has a purpose on x86. It no longer needs to
set num_leaves, and it never had to set num_levels, which was unnecessary
on x86.

Replace it with "return 0" simply to override the weak function, which
would return an error.

Cc: Andreas Herrmann <aherrmann@suse.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chen Yu <yu.c.chen@intel.com>
CC: Huang Ying <ying.huang@intel.com>
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
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Rebased on v6.7-rc5.

Changes since v2:
 * None

Changes since v1:
 * Introduced this patch.
---
 arch/x86/kernel/cpu/cacheinfo.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 4125e53a5ef7..1cfe0921ac67 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1002,11 +1002,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 
 int init_cache_level(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	if (!this_cpu_ci)
-		return -EINVAL;
-	this_cpu_ci->num_levels = 3;
 	return 0;
 }
 
-- 
2.25.1

