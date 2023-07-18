Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED71757DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjGRNle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjGRNlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:41:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAF9E2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689687690; x=1721223690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nvZS1UeTg1f3Nu7ZuzhrPeCZgRbcpcqdKZqO5fLg/CQ=;
  b=jkntvIliG9zYN/c9GkllAWrh6JXgEjL6lpAEt4w8B0bm2h7pMjHwAvKL
   iqC/O2xMlEp3MEarEX4yxHoVkJtFsVJNVogQiILoAwL+EiOf2n0eayqZf
   VhDjLJuEk3CAw2/nzZsl8DHJZ9oaFgydTLxEt/UTm8IPZWuNTAI8930m1
   ZawJskMNayBf1EIVkreg2auUZ5FzzYvnr0QU5fFSVXXcjcR1UGmr0zdj8
   VCN63KDg1SCBrd61/HAYPxjKnXJct6Lg1tpdAzBanklg3GpHOOvrUYYvH
   aYm+tv1pzjMk0YfmGsL4M6QFUr+/v05et117tTOtrPV0wucRg6JDs06m2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345800634"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345800634"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847706510"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847706510"
Received: from ziqianlu-desk2.sh.intel.com ([10.239.159.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:41:26 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] Reduce cost of accessing tg->load_avg
Date:   Tue, 18 Jul 2023 21:41:16 +0800
Message-ID: <20230718134120.81199-1-aaron.lu@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nitin Tekchandani noticed some scheduler functions have high cost
according to perf/cycles while running postgres_sysbench workload.
I perf/annotated the high cost functions: update_cfs_group() and
update_load_avg() and found the costs were ~90% due to accessing to
tg->load_avg. This series is an attempt to reduce the cost of accessing
tg->load_avg.

The 1st patch is a bug fix. I probably should try PeterZ's SBRM which
should make things a lot cleaner but I'm not sure if this fix is stable
material and if so, writing in traditional way is easier for backport?

The 2nd patch is actually v2, the first version was sent here:
https://lore.kernel.org/lkml/20230327053955.GA570404@ziqianlu-desk2/
since it is part of this series, I didn't maintain its version. The idea
is from PeterZ: by making the hot variable per-node, at least, the write
side update_load_avg() will become local. The sad part is, the read side
is still global because it has to sum up each node's part and that hurts
performance. Also, update_cfs_group() is called very frequently, e.g. on
every en/dequeue_task_fair(). With this patch, postgres_sysbench on SPR
sees some improvement. hackbench/netperf also see some improvement on
SPR and Cascade Lake. For details, please see patch2.

While there are improvments from making tg->load_avg per node, the two
functions cost is still there while running postgres_sysbench on SPR: ~7%
for update_cfs_group() and ~5% for update_load_avg(). To further reduce
the cost of accessing tg->load_avg, the 3rd patch tried to reduce the
number of updates to tg->load_avg when a task migrates on wakeup: current
code will immediately update_tg_load_avg() once update_load_avg() found
cfs_rq has removed_load pending; patch3 changed this behaviour: it ignores
cfs_rq's pending removed_load and rely on following events like task
attaching so that to aggregate the process of tg->load_avg. For a wakeup
heavy workload, this can roughly reduce the call number to
update_tg_load_avg() by half.

After patch3, the cost of the two functions while running
postgres_sysbench on SPR dropped to ~1% but running netperf/UDP_RR on
SPR the two functions cost are still ~20% and ~10%. So patch4 tried to
reduce the number of calls to update_cfs_group() on en/dequeue path and
that made the two functions cost dropped to ~2% when running netperf/UDP_RR
on SPR.

One issue with patch3 and patch4 is, they both reduced the tracking
accuracy of task group's load_avg in favor of reducing cost of accessing
tg->load_avg. patch3 is probably better than patch4 in this regard,
because we already delay processing cfs_rq's removed_load although patch3
made the delay even longer; patch4 skipped some calls to
update_cfs_group() on en/dequeue path and that may affect things. I made
a test inspired by an old commit and result seem to suggest it's not bad
but I may miss some scenarios.

This series is based on v6.5-rc1 with one more patch applied that made
tg->load_avg stay in a dedicated cacheline to avoid any false sharing
issue as discovered by Deng Pan:
https://lore.kernel.org/lkml/20230621081425.420607-1-pan.deng@intel.com/

For performance data in each commit's changelog, node means patch2,
delay means patch3 and skip means patch4. All performance changes percent
are against base.

Comments are welcome.

Aaron Lu (4):
  sched/fair: free allocated memory on error in alloc_fair_sched_group()
  sched/fair: Make tg->load_avg per node
  sched/fair: delay update_tg_load_avg() for cfs_rq's removed load
  sched/fair: skip some update_cfs_group() on en/dequeue_entity()

 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 80 ++++++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h | 44 ++++++++++++++++++------
 3 files changed, 97 insertions(+), 29 deletions(-)

-- 
2.41.0

