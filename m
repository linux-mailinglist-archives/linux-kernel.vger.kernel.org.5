Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC31770CFF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjHEBWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjHEBWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:22:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5874EE4;
        Fri,  4 Aug 2023 18:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691198518; x=1722734518;
  h=from:to:cc:subject:date:message-id;
  bh=8qZ03i3VQJk0gArG0C57L1TxXOVJULlo1Yez71dt/+g=;
  b=WgqSJepR8LX5soCYvNHkgW3wRTm/UmZXcOY1Qr/Jd4B12auYFeWv5fps
   nqNQ844Mrx+ZicoNEhyOCObEZVA6N8pw5O78t5layvK/bhUy1FtiXFdLu
   uNNmmIp6dNTqw7JpafxFmaQeVRwwJrUghupoFwgLM7uGuxtfdzEknG4Qx
   po12f4sdIUgwbIcpAC9q2j/ybP831APaHK8yDwzcpmISkuuoGatj5gZQM
   oAINgVp4OfKgnGbnkwmNxGO6uTkruFsFIICu9OtbjEjsTFUVWIrcREZ9h
   //KlFmNxyQBKfFeGg/aEosgJKAgSsCbe4S2QGKXJOD86KCMTuRNzTPs7o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="367735754"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="367735754"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 18:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="844317613"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="844317613"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2023 18:21:57 -0700
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v3 0/3] x86/cacheinfo: Set the number of leaves per CPU
Date:   Fri,  4 Aug 2023 18:24:18 -0700
Message-Id: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v3 of a patchset to set the number of cache leaves independently
for each CPU. v1 and v2 can be found here [1] and here [2].

Changes since v2:
  * This version uncovered a NULL-pointer dereference in recent changes to
    cacheinfo[3]. This dereference is observed when the system does not
    configure cacheinfo early during boot nor makes corrections later
    during CPU hotplug; as is the case in x86. Patch 1 fixes this issue.

Changes since v1:
  * Dave Hansen suggested to use the existing per-CPU ci_cpu_cacheinfo
    variable. Now the global variable num_cache_leaves became useless.
  * While here, I noticed that init_cache_level() also became useless:
    x86 does not need ci_cpu_cacheinfo::num_levels.

[1]. https://lore.kernel.org/lkml/20230314231658.30169-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/all/20230424001956.21434-1-ricardo.neri-calderon@linux.intel.com/
[3]. https://lore.kernel.org/all/20230412185759.755408-1-rrendec@redhat.com/

Ricardo Neri (3):
  cacheinfo: Allocate memory for memory if not done from the primary CPU
  x86/cacheinfo: Delete global num_cache_leaves
  x86/cacheinfo: Clean out init_cache_level()

 arch/x86/kernel/cpu/cacheinfo.c | 50 ++++++++++++++++-----------------
 drivers/base/cacheinfo.c        |  6 +++-
 2 files changed, 30 insertions(+), 26 deletions(-)

-- 
2.25.1

