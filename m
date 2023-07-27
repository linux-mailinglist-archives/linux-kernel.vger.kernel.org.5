Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E7F7646F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjG0Gii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjG0Gi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:38:29 -0400
Received: from mgamail.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E639E2118
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690439904; x=1721975904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PuJ6p7ob0/oeLqh2rqrD1SAuaphCtCcMkAe2jrFWxik=;
  b=Tqnn3FrkBVfjx5kXD8exYGYpEZ/wVwlBy3Za3wIa+qWmpeQsL+DzRFdS
   ap4SqGw5EdYzucVZrgvltnvyzLnBfCa7qOXm87i0OYAZJ96IYtisAy00M
   /kReuEG8KSM/XBljqiQ3k9o2L6q2qstXAoz/8m0QP5rki3ZZ8Ig78eDYY
   B2WwVjU5pMEHva7lf7XrxE1oB7s1LS9hoOOhN1CxjfZu5GOk/Q6aUtFnB
   kQN5Q6OvODnQVzBFoOeEg5h25mPr2ve7ndihwavqeTF97li+lak57k8Kg
   OCfNKEEsEdMDiLxh1xBi2hLox0DoleKHtzFBZ3L2qg2gJJ182Vvj/JnOA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="370896315"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="370896315"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 23:38:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="762047502"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="762047502"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2023 23:38:20 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 0/7] Optimization to reduce the cost of newidle balance
Date:   Thu, 27 Jul 2023 22:33:58 +0800
Message-Id: <cover.1690273854.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second version of the newidle balance optimization[1].
It aims to reduce the cost of newidle balance which is found to
occupy noticeable CPU cycles on some high-core count systems.

For example, when running sqlite on Intel Sapphire Rapids, which has
2 x 56C/112T = 224 CPUs:

6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats

To mitigate this cost, the optimization is inspired by the question
raised by Tim:
Do we always have to find the busiest group and pull from it? Would
a relatively busy group be enough?

There are two proposals in this patch set.
The first one is ILB_UTIL. It was proposed to limit the scan
depth in update_sd_lb_stats(). The scan depth is based on the
overall utilization of this sched domain. The higher the utilization
is, the less update_sd_lb_stats() scans. Vice versa.

The second one is ILB_FAST. Instead of always finding the busiest
group in update_sd_lb_stats(), lower the bar and try to find a
relatively busy group. ILB_FAST takes effect when the local group
is group_has_spare. Because when there are many CPUs running
newidle_balance() concurrently, the sched groups should have a
high idle percentage.

Compared between ILB_UTIL and ILB_FAST, the former inhibits the
sched group scan when the system is busy. While the latter
chooses a compromised busy group when the system is not busy.
So they are complementary to each other and work independently.

patch 1/7 and patch 2/7 are preparation for ILB_UTIL.

patch 3/7 is a preparation for both ILB_UTIL and ILB_FAST.

patch 4/7 is part of ILB_UTIL. It calculates the scan depth
          of sched groups which will be used by
          update_sd_lb_stats(). The depth is calculated by the
          periodic load balance.

patch 5/7 introduces the ILB_UTIL.

patch 6/7 introduces the ILB_FAST.

patch 7/7 is a debug patch to print more sched statistics, inspired
          by Prateek's test report.

In the previous version, Prateek found some regressions[2].
This is probably caused by:
1. Cross Numa access to sched_domain_shared. So this version removed
   the sched_domain_shared for Numa domain.
2. newidle balance did not try so hard to scan for the busiest
   group. This version still keeps the linear scan function. If
   the regression is still there, we can try to leverage the result
   of SIS_UTIL. Because SIS_UTIL is a quadratic function which
   could help scan the domain harder when the system is not
   overloaded.

Changes since the previous version:
1. For all levels except for NUMA, connect a sched_domain_shared
   instance. This makes the newidle balance optimization more
   generic, and not only for LLC domain. (Peter, Gautham)
2. Introduce ILB_FAST, which terminates the sched group scan
   earlier, if it finds a proper group rather than the busiest
   one (Tim).


Peter has suggested reusing the statistics of the sched group
if multiple CPUs trigger newidle balance concurrently[3]. I created
a prototype[4] based on this direction. According to the test, there
are some regressions. The bottlenecks are a spin_trylock() and the
memory load from the 'cached' shared region. It is still under
investigation so I did not include that change into this patch set.

Any comments would be appreciated.

[1] https://lore.kernel.org/lkml/cover.1686554037.git.yu.c.chen@intel.com/
[2] https://lore.kernel.org/lkml/7e31ad34-ce2c-f64b-a852-f88f8a5749a6@amd.com/
[3] https://lore.kernel.org/lkml/20230621111721.GA2053369@hirez.programming.kicks-ass.net/
[4] https://github.com/chen-yu-surf/linux/commit/a6b33df883b972d6aaab5fceeddb11c34cc59059.patch

Chen Yu (7):
  sched/topology: Assign sd_share for all non NUMA sched domains
  sched/topology: Introduce nr_groups in sched_domain to indicate the
    number of groups
  sched/fair: Save a snapshot of sched domain total_load and
    total_capacity
  sched/fair: Calculate the scan depth for idle balance based on system
    utilization
  sched/fair: Adjust the busiest group scanning depth in idle load
    balance
  sched/fair: Pull from a relatively busy group during newidle balance
  sched/stats: Track the scan number of groups during load balance

 include/linux/sched/topology.h |   5 ++
 kernel/sched/fair.c            | 114 ++++++++++++++++++++++++++++++++-
 kernel/sched/features.h        |   4 ++
 kernel/sched/stats.c           |   5 +-
 kernel/sched/topology.c        |  14 ++--
 5 files changed, 135 insertions(+), 7 deletions(-)

-- 
2.25.1

