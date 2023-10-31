Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A6D7DD79A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344722AbjJaVRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJaVRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:17:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7D3E4;
        Tue, 31 Oct 2023 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698787037; x=1730323037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4IsjhjVYSNBncvjiDxuNC4YOnUBnAGYPBdW4HBXImVc=;
  b=f7XqiRFvAeOu0uZWstFYtfMpTX5w+ciwdTAMpECewu2c+uIBF9ZkJJCc
   fGA9PcV+W69BVe/D1Q7b5EnX4uoaIMm42XanIDRzSiaya0RWqMCXau9V3
   K94QaCTZjX1sYVE13qcGqQKPGVp1rneOhhiggGVt5DNUJxreNIQatExLZ
   4lX6bkmM79fbJAEim7ktdEng3kWVf34jvZplWb8CTs+8lsiZMXuR4o5Sq
   BWGwh+rCX5LF35IrxQbRJfJ+GiFu+dYUR/75cElaKT5Z0x85VLcnRO4pK
   xsmr0W89Pk79FvmSXkiXCatM0iW7uR0aNPibtoPqTLrY9VtWG8PZEDIKp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="388197060"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="388197060"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 14:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="884334986"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="884334986"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 14:17:15 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v10 0/8] Add support for Sub-NUMA cluster (SNC) systems
Date:   Tue, 31 Oct 2023 14:17:00 -0700
Message-ID: <20231031211708.37390-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020213100.123598-1-tony.luck@intel.com>
References: <20231020213100.123598-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sub-NUMA cluster feature on some Intel processors partitions the CPUs
that share an L3 cache into two or more sets. This plays havoc with the
Resource Director Technology (RDT) monitoring features.  Prior to this
patch Intel has advised that SNC and RDT are incompatible.

Some of these CPU support an MSR that can partition the RMID counters in
the same way. This allows monitoring features to be used. With the caveat
that users must be aware that Linux may migrate tasks more frequently
between SNC nodes than between "regular" NUMA nodes, so reading counters
from all SNC nodes may be needed to get a complete picture of activity
for tasks.

Cache and memory bandwidth allocation features continue to operate at
the scope of the L3 cache.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Dropped Peter's "Reviewed-by" from all but parts 5 & 8 since there
have been many changes since he provided those.

Other changes since v9 (all from Reinette's comments)

global s/cpu/CPU/ in commit messages and code comments

#1
New test for invalid domain id before calling rdt_find_domain() means that
error handling in that function and at all call-sites can be simplified.
In pseudo_lock_region_init() use the new enum resctrl_scope for local variable.

#2
Include *all* common fields in the rdt_domain_hdr. Defer adding "type" until it is
used later in part #3.

#3
Fix commit to be specific the only the RDT_RESOURCE_L3 resource is going
to have different monitor and control scope.
Rename get_domain_from_cpu() -> get_ctrl_domain_from_cpu()
Rewrite comment for rdt_find_domains().
Add "type" field to rdt_domain_hdr structure.
Delete the /* RDT_RESOURCE_MBA is never mon_capable */ comment.

#4
Comment against patch 4, but now fixed in patch #2. cpu_mask
is included in common header.

#5
No comments. No changes.

#6
Fixed missing word s/monitoring on Intel/monitoring on an Intel/
Deleted "A later patch" paragraph.
Expanded description how how values are "adjusted" for mon_scale
and cache size.
Changed type of "snc_nodes_per_l3_cache" to "unsigned int".

#7
Expand h/w to hardware (commit and code comments)
Remove "earlier commit" reference
s/counnter/counter/
Check for offline CPUs and warn user SNC detection may be broken.

#8
No comments. No changes.

Tony Luck (8):
  x86/resctrl: Prepare for new domain scope
  x86/resctrl: Prepare to split rdt_domain structure
  x86/resctrl: Prepare for different scope for control/monitor
    operations
  x86/resctrl: Split the rdt_domain and rdt_hw_domain structures
  x86/resctrl: Add node-scope to the options for feature scope
  x86/resctrl: Introduce snc_nodes_per_l3_cache
  x86/resctrl: Sub NUMA Cluster detection and enable
  x86/resctrl: Update documentation with Sub-NUMA cluster changes

 Documentation/arch/x86/resctrl.rst        |  23 +-
 include/linux/resctrl.h                   |  87 +++--
 arch/x86/include/asm/msr-index.h          |   1 +
 arch/x86/kernel/cpu/resctrl/internal.h    |  66 ++--
 arch/x86/kernel/cpu/resctrl/core.c        | 411 +++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  58 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  68 ++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  26 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 149 ++++----
 9 files changed, 607 insertions(+), 282 deletions(-)


base-commit: 5a6a09e97199d6600d31383055f9d43fbbcbe86f
-- 
2.41.0

