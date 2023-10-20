Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8997D182E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjJTVbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjJTVbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:31:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12C6D73;
        Fri, 20 Oct 2023 14:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697837496; x=1729373496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xNCVDrNwRTmzxZ0+yJhMv6NIK8MY44N5sibNmWvRsgQ=;
  b=fT7dMFV7B3VrZnbDssjHztLkKASpivPsU0Jf7DwFBCmn5uXXppYdN/oQ
   6gkiEF6fWNJRIS+Yit6zm5ZspUDf7u/j6ZFKBEmOatEQaRuEBXPeNvcaU
   dF8UnWN+Di5tSzgAIir3PxJQldnLKLe3Ae2Ya+c9sGLMWAT6WcntJoVHq
   hDgrRQgjlI0zgRNQ1oZjCnqA00Us8ngsBhfyQFXP4NAwx6BX14mcAxJ+J
   DsLWI/ohILuVqbdwL1J+qUN/UkvRMReAKUISrGlhl0ZjE0dNZyt7ayF6K
   wJcAHWRe+VTvCG2cMbzjXhRKAUMRttXiembc5jf8l58t8z62RvORU0/nC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="371647075"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="371647075"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:31:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="881184458"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="881184458"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:31:06 -0700
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
Subject: [PATCH v9 0/8] Add support for Sub-NUMA cluster (SNC) systems
Date:   Fri, 20 Oct 2023 14:30:52 -0700
Message-ID: <20231020213100.123598-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003213043.13565-1-tony.luck@intel.com>
References: <20231003213043.13565-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v6 (see individual patches for specifics):

v7 -	had some git format-patch disaster and one of the patches couldn't
	be applied.

v8 -	Was rushed. Somehow I booted the wrong kernel while testing and
	let escape a brown-paper-bag bug that crashed duing boot.
	Sincere apologies to all who wasted time reading this series,
	or trying to boot it.

v9 -	Tested (Really! I checked timestamps in dmesg, and all sorts of
	other checks to make sure I was really looking at a kernel built
	with these patches).

	Rebased to tip/master October 20th since that has several other
	resctrl changes staged resdy for next merge window. No
	significant collisions, just noise where "git am" would not
	automatically apply. New base is:

	3300447612b2 ("Merge branch into tip/master: 'x86/tdx'")

	Fixed the brown-paper-bag bug from v8.

	Added Peter's "Reviewed-by" where offered (except on patch 3
	which had the aforementioned bug).

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
 include/linux/resctrl.h                   |  85 +++--
 arch/x86/include/asm/msr-index.h          |   1 +
 arch/x86/kernel/cpu/resctrl/internal.h    |  66 ++--
 arch/x86/kernel/cpu/resctrl/core.c        | 402 +++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  58 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  58 ++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  14 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 132 +++----
 9 files changed, 592 insertions(+), 247 deletions(-)


base-commit: 3300447612b2adbc05cbb90e5d1cb288f19c40c6
-- 
2.41.0

