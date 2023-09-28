Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB84F7B25B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjI1TOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1TOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:14:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9301A7;
        Thu, 28 Sep 2023 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695928441; x=1727464441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=10vGzZXf8lhncYI1MROfTO1wzd14J2xXaiWn996fOio=;
  b=W4h3AV1V7Rmq1pOSOAYyDIUB/acTFrnMgFaA4I39UfYBjJWSN1uUFsNC
   7vnGrB4NPUzn/hur0akhq6ZcBHD063v++Y+mfMN7XeKr39ZWIM6LyG/K4
   gcSnZSHZZou7A7SZxuFYYKXJrUFPO1wfiTLsTsmXg3Jj7CAZZl/Ll/iXB
   pCaIpHHQUuGIM3emo/wiJYUtqmqUgA4joyYCwodFr8mDqY7NCe2jsbpYy
   99YbU/A/hHm+iKRE+ARP4rayzc2k5Q2zoLPv8vQ6Kg/WDpJ+UOwDRizxp
   Pcq36m1VDb+m+MicwZoXFf+TXgjop8vJi9VJC8R69QuZ4x6lx/3pcoCLg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="367213859"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="367213859"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="779020016"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="779020016"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:13:57 -0700
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
Subject: [PATCH v6 0/8] Add support for Sub-NUMA cluster (SNC) systems
Date:   Thu, 28 Sep 2023 12:13:41 -0700
Message-ID: <20230928191350.205703-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829234426.64421-1-tony.luck@intel.com>
References: <20230829234426.64421-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sub-NUMA cluster feature on some Intel processors partitions
the CPUs that share an L3 cache into two or more sets. This plays
havoc with the Resource Director Technology (RDT) monitoring features.
Prior to this patch Intel has advised that SNC and RDT are incompatible.

Some of these CPU support an MSR that can partition the RMID
counters in the same way. This allows for monitoring features
to be used (with the caveat that memory accesses between different
SNC NUMA nodes may still not be counted accuratlely.

Note that this patch series improves resctrl reporting considerably
on systems with SNC enabled, but there will still be some anomalies
for processes accessing memory from other sub-NUMA nodes.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Summary of changes since v5 - see each patch commit for more specifics

Rebased to v6.6-rc3

0001	Define "scope" enum with values 2, 3 for caches to simplify some
	code (but sanity check before each such usage).
	Better warning messages when scope lookup fails

0002	New patch so that some code can be shared between looking up
	control and monitor domains

0003	Spell "mondomains" as "mon_domains" and be consistent with all
	the other "mon" identifiers also having similar "_".
	Don't leave control stuff with old names, change those too
	so now have ctrl_scope, ctrl_domains, etc.

0004	Use infrastructure from 0002 to have a common rdt_find_domain()
	function for both types of domain structure.
	0003 was using same "rdt_domain" structure for both control
	and monitor domains. Divide it into rdt_ctrl_domain and
	rdt_mon_domain structures with just the fields they need.
	Ditto for rdt_hw_domain. Also split and rename many support
	functions and macros.
	Lots of "fir tree local declaration order" changes because
	lengths of typenames changed.

0005	Better commit description

0006	Better commit and code comments

0007	More explanations in commit and code comments.
	Use consistent naming for "snc_*()" functions.

Patch to update selftests dropped from this series. Someone else
has taken over that work.

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

 Documentation/arch/x86/resctrl.rst        |  34 +-
 include/linux/resctrl.h                   |  78 +++--
 arch/x86/include/asm/msr-index.h          |   1 +
 arch/x86/kernel/cpu/resctrl/internal.h    |  66 ++--
 arch/x86/kernel/cpu/resctrl/core.c        | 380 +++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  52 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  58 ++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  14 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 131 ++++----
 9 files changed, 567 insertions(+), 247 deletions(-)


base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.41.0

