Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8D075DE2B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjGVTHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGVTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:07:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D800E65;
        Sat, 22 Jul 2023 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690052872; x=1721588872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WfglSuPJmhsRxrO7QtQ35doaK6hJqVdmUu6AK9ShvRg=;
  b=V40/dOrmtlwkX5xbwxPhN3QijWaRXxOQdtZbQWA+FNMpCFB2JxwsWaSM
   mtdTBzCKAdJRtjfAnx/nwlsLb1U40FkdvvEPfrETgzZv020BozHuHqPzf
   K9DhA8nsT7FRil8mbih8zyrrA4LIU3qoJIdp4zpT1ulGOpXoVDwmASfP/
   FeiXW577Ftr/7l68W6qwxMq9L8QqlTOojlVhdyU4KnmIPI1n36oqOluAI
   QjCWxecTW1XedBmLmiFNFNLEUhdG933q7rDIZjsVa4LCSBM6/EuPtK1rx
   8MuDVI7g0J4kVc5iElQFqqI+1gW5h+EvH1zHkwjQfLwpQtrONOH/LOlLx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="346823957"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="346823957"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="815368074"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="815368074"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:51 -0700
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
Subject: [PATCH v4 0/7] Add support for Sub-NUMA cluster (SNC) systems
Date:   Sat, 22 Jul 2023 12:07:33 -0700
Message-Id: <20230722190740.326190-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713163207.219710-1-tony.luck@intel.com>
References: <20230713163207.219710-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Changes since v3:

Reinette provided the most excellent suggestion that this series
could better achieve its objective if it enabled separate domain
lists for control & monitoring within a resource, rather than
creating a whole new resource to support separte node scope needed
for SNC monitoring. Thus all the pre-amble patches from the previous
version have gone, replaced by patches 1-4 of this new series.

Note to anyone backporting this to some older Linux kernel version.
You may be able to skip parts 2-4. These provide separate domain
structures for control and monitor with just the fields needed for
each. But this is largely cosmetic.

Of the code from v3 that survived to v4 the following changes have
been made (also from Reinette's review of v3).

1) Rename "snc_ways" to "snc_nodes_per_l3_cache" to avoid the confusing
use of "ways" which means something entirely different when talking
about caches.
2) Move the #define for MSR_RMID_SNC_CONFIG to <asm/msr-index.h> along
with all the other RDT MSRs.
3) Don't use a per-CPU variable "rmid_offset". Just calculate value
needed at the one place where it is used.
4) Don't create an entire resource structure with package scoped domains
just to set the SNC MSR.
5) Add comment in the commit message about adjusting the value shown in
the "size" files in each resctrl ctrl_mon directory.

This one not from Reinette:
6) Prevent mounting in "mba_MBps" mode when SNC mode is enabled. This
would just be confusing since monitoring is done at the node scope while
control is still at package scope.

Tony Luck (7):
  x86/resctrl: Create separate domains for control and monitoring
  x86/resctrl: Split the rdt_domain structures
  x86/resctrl: Change monitor code to use rdt_mondomain
  x86/resctrl: Delete unused fields from struct rdt_domain
  x86/resctrl: Determine if Sub-NUMA Cluster is enabled and initialize.
  x86/resctrl: Update documentation with Sub-NUMA cluster changes
  selftests/resctrl: Adjust effective L3 cache size when SNC enabled

 Documentation/arch/x86/resctrl.rst          |  10 +-
 include/linux/resctrl.h                     |  50 +++-
 arch/x86/include/asm/msr-index.h            |   1 +
 arch/x86/kernel/cpu/resctrl/internal.h      |  40 ++-
 tools/testing/selftests/resctrl/resctrl.h   |   1 +
 arch/x86/kernel/cpu/resctrl/core.c          | 289 ++++++++++++++++----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c   |   6 +-
 arch/x86/kernel/cpu/resctrl/monitor.c       |  58 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c      |  54 ++--
 tools/testing/selftests/resctrl/resctrlfs.c |  57 ++++
 10 files changed, 427 insertions(+), 139 deletions(-)


base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.40.1

