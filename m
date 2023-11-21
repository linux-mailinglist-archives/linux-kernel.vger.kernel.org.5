Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27297F2682
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjKUHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKUHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:40:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D044C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700552427; x=1732088427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qy5LvMXn9fulHhxgGbpRsXWBGv1kGPesnzfFG62n+wA=;
  b=Eg7ek/HmGcdGqBhTgzxU1+vRddlOkRs1CuUT5Kogro06N9JA6NxfIQRg
   y48hMLiO2k9pAdFTNgBCiU5OWc3tMx5rXejfHHvKKmOl+KKYHooFIyYJP
   FYR6Pg3Tqa+jOt5fsrMJaFSlP1HHhxwbN0G9W8UrTeMQsht0Vr1tNwczl
   xpf4lZcJ9AzwDeSF0Gd3HDyKCTIdJ6Qp4OUKiunCC7SqfGb6K1+1Jj9oy
   QRtNITH/gDnLfmtNTrBc9kpVWSOyn9DIju0ciufa/7TL+JfomeACWYCHS
   gduFI3Fih2GQvZ51yBsqKjuGTBSC4f5by8BY6LF9/e2+5Tp/yXf3OZv4L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376821651"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376821651"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884101975"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="884101975"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2023 23:40:22 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2 0/3] Introduce SIS_CACHE to choose previous CPU during task wakeup
Date:   Tue, 21 Nov 2023 15:39:14 +0800
Message-Id: <cover.1700548379.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1  -> v2:
- Move the task sleep duration from sched_entity to task_struct. (Aaron Lu)
- Refine the task sleep duration calculation based on task's previous running
  CPU. (Aaron Lu)
- Limit the cache-hot idle CPU scan depth to reduce the time spend on
  searching, to fix the regression. (K Prateek Nayak)
- Add test results of the real life workload per request from Ingo
    Daytrader on a power system. (Madadi Vineeth Reddy)
    OLTP workload on Xeon Sapphire Rapids.
- Refined the commit log, added Reviewed-by tag to PATCH 1/3
  (Mathieu Desnoyers).

RFC -> v1:
- drop RFC
- Only record the short sleeping time for each task, to better honor the
  burst sleeping tasks. (Mathieu Desnoyers)
- Keep the forward movement monotonic for runqueue's cache-hot timeout value.
  (Mathieu Desnoyers, Aaron Lu)
- Introduce a new helper function cache_hot_cpu() that considers
  rq->cache_hot_timeout. (Aaron Lu)
- Add analysis of why inhibiting task migration could bring better throughput
  for some benchmarks. (Gautham R. Shenoy)
- Choose the first cache-hot CPU, if all idle CPUs are cache-hot in
  select_idle_cpu(). To avoid possible task stacking on the waker's CPU.
  (K Prateek Nayak)

Thanks for the comments and tests!

----------------------------------------------------------------------

This series aims to continue the discussion of how to make the wakee
to choose its previous CPU easier.

When task p is woken up, the scheduler leverages select_idle_sibling()
to find an idle CPU for it. p's previous CPU is usually a preference
because it can improve cache locality. However in many cases, the
previous CPU has already been taken by other wakees, thus p has to
find another idle CPU.

Inhibit the task migration could benefit many workloads. Inspired by
Mathieu's proposal to limit the task migration ratio[1], introduce
the SIS_CACHE. It considers the sleep time of the task for better
task placement. Based on the task's short sleeping history, tag p's
previous CPU as cache-hot. Later when p is woken up, it can choose
its previous CPU in select_idle_sibling(). When other task is
woken up, skip this cache-hot idle CPU and try the next idle CPU
when possible. The idea of SIS_CACHE is to optimize the idle CPU
scan sequence. The extra scan time is minimized by restricting the
scan depth of cache-hot CPUs to 50% of the scan depth of SIS_UTIL.

This test is based on tip/sched/core, on top of
Commit ada87d23b734
("x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram")

This patch set has shown 15% ~ 70% improvements for client/server
workloads like netperf and tbench. It shows 0.7% improvement of
OLTP with 0.2% run-to-run variation on Xeon 240 CPUs system.
There is 2% improvement of another real life workload Daytrader
per the test of Madadi on a power system with 96 CPUs. Prateek
has helped check there is no obvious microbenchmark regression
of the v2 on a 3rd Generation EPYC System with 128 CPUs.

Link: https://lore.kernel.org/lkml/20230905171105.1005672-2-mathieu.desnoyers@efficios.com/ #1

Chen Yu (3):
  sched/fair: Record the task sleeping time as the cache hot duration
  sched/fair: Calculate the cache-hot time of the idle CPU
  sched/fair: skip the cache hot CPU in select_idle_cpu()

 include/linux/sched.h   |  4 ++
 kernel/sched/fair.c     | 88 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    |  1 +
 4 files changed, 91 insertions(+), 3 deletions(-)

-- 
2.25.1

