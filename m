Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D6380FA61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377795AbjLLWXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377782AbjLLWXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:23:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465DBCF;
        Tue, 12 Dec 2023 14:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702419816; x=1733955816;
  h=from:to:cc:subject:date:message-id;
  bh=bs2Pt5v1W0sFAFjRahx11+5bS/VM2UK4YvQBDFDNmSA=;
  b=nLOX+AKsZ9ddRAP3cZ+wrq8Sta8VL4MLnZt/uGqi5zGkL5VgaRSJiXhy
   VdZ37btXCMJIbn43K1nIjEnDpcnJ63I60K0VhuGu2g2YsFCF1xqxPzKhh
   z7fWt/hQPIkccfrQr9R24EPPCHPTLc/cRHfcDwZ078pXzcr5IHbBnTXUI
   QXGZttfamn6c0wlpMD7eLRj4UzowL4cBrbeZVU7AoTqGFi/3khrxbM5an
   mFLxeJM0JE5VSdjo0nJNeFMwSd3SjKNfldQTdXkhB1Th5iTZZMcX04qrP
   El23mOcUumrxwmbNsFQNbyxFOkVxdm6NoMcWmItfSr//yrEu2NxszsEi3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2049297"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2049297"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 14:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="802631179"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="802631179"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2023 14:23:35 -0800
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v4 0/4] x86/cacheinfo: Set the number of leaves per CPU
Date:   Tue, 12 Dec 2023 14:25:15 -0800
Message-Id: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The interface /sys/devices/system/cpu/cpuX/cache is broken (not populated)
if CPUs have different numbers of subleaves in CPUID 4. This is the case
of Intel Meteor Lake.

This is v4 of a patchset to fix the cache sysfs interface by setting the
number of cache leaves independently for each CPU.

v1, v2, and v3 can be found here[1], here[2], and here[3].

All the tests described in [4] passed.

Changes since v3:
  * Fixed another NULL-pointer dereference when checking the validity of
    the last-level cache info.
  * Added the Reviewed-by tags from Radu and Sudeep. Thanks!
  * Rebased on v6.7-rc5.

Changes since v2:
  * This version uncovered a NULL-pointer dereference in recent changes to
    cacheinfo[5]. This dereference is observed when the system does not
    configure cacheinfo early during boot nor makes corrections later
    during CPU hotplug; as is the case in x86. Patch 1 fixes this issue.

Changes since v1:
  * Dave Hansen suggested to use the existing per-CPU ci_cpu_cacheinfo
    variable. Now the global variable num_cache_leaves became useless.
  * While here, I noticed that init_cache_level() also became useless:
    x86 does not need ci_cpu_cacheinfo::num_levels.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20230314231658.30169-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/all/20230424001956.21434-1-ricardo.neri-calderon@linux.intel.com/
[3]. https://lore.kernel.org/lkml/20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com/
[4]. https://lore.kernel.org/lkml/20230912032350.GA17008@ranerica-svr.sc.intel.com/
[5]. https://lore.kernel.org/all/20230412185759.755408-1-rrendec@redhat.com/

Ricardo Neri (4):
  cacheinfo: Check for null last-level cache info
  cacheinfo: Allocate memory for memory if not done from the primary CPU
  x86/cacheinfo: Delete global num_cache_leaves
  x86/cacheinfo: Clean out init_cache_level()

 arch/x86/kernel/cpu/cacheinfo.c | 49 +++++++++++++++++----------------
 drivers/base/cacheinfo.c        |  9 +++++-
 2 files changed, 34 insertions(+), 24 deletions(-)

-- 
2.25.1

