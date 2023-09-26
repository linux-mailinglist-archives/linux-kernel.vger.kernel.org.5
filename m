Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CDD7AE4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjIZFLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjIZFLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:11:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C806B0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 22:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695705060; x=1727241060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IURD6yOAQKSnGHG4SzFBtCW0lCI8dfJfDlDAE12p3e0=;
  b=a/W2+AjdHdZBv2CAB8QeLbkWHTSdgmCnyIiJ6pUCh9AQw2hEAc7lXoB6
   dgI/ECMWtql37uhGmqLihOw5/d31N216qdZ7d9Bzmcnco07PQyDQ+aJy4
   313NGjcEttW47tjd9Wpiq2kOHQ2BrR8ltt7n87o+AoTDDr5v2y2UHOIND
   JafA0zFjFN0IUOlXV+R3tW0BylIU4YE3ecdzGFzY3ZBDkDF2hn7DL72N4
   88tTew5xKJchkF136vibJC8cvwfq1ViOAE1QTH46TtkvKpVuOcw3cBDZE
   wVg+Xi9IjpI9O3Nt2GdWigWL+rka+F0T2ZZAP+hXLeCEWCVy6XcUcOANm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380351347"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="380351347"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:10:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="742222883"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="742222883"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga007.jf.intel.com with ESMTP; 25 Sep 2023 22:10:53 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] Introduce SIS_CACHE to choose previous CPU during task wakeup
Date:   Tue, 26 Sep 2023 13:10:21 +0800
Message-Id: <cover.1695704179.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
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

Thanks for your comments and review!

----------------------------------------------------------------------

When task p is woken up, the scheduler leverages select_idle_sibling()
to find an idle CPU for it. p's previous CPU is usually a preference
because it can improve cache locality. However in many cases, the
previous CPU has already been taken by other wakees, thus p has to
find another idle CPU.

Inhibit the task migration while keeping the work conservation of
scheduler could benefit many workloads. Inspired by Mathieu's
proposal to limit the task migration ratio[1], this patch considers
the task average sleep duration. If the task is a short sleeping one,
then tag its previous CPU as cache hot for a short while. During this
reservation period, other wakees are not allowed to pick this idle CPU
until a timeout. Later if the task is woken up again, it can find its
previous CPU still idle, and choose it in select_idle_sibling().

This test is based on tip/sched/core, on top of
Commit afc1996859a2
("sched/fair: Ratelimit update to tg->load_avg")

patch afc1996859a2 has significantly reduced the cost of task migration,
the SIS_CACHE further reduces that cost. SIS_CACHE shows noticeable
throughput improvement of netperf/tbench around 100% load.

[patch 1/2] records the task's average short sleeping time in
its per sched_entity structure.
[patch 2/2] introduces the SIS_CACHE to skip the cache-hot
idle CPU during wakeup.

Link: https://lore.kernel.org/lkml/20230905171105.1005672-2-mathieu.desnoyers@efficios.com/ #1

Chen Yu (2):
  sched/fair: Record the short sleeping time of a task
  sched/fair: skip the cache hot CPU in select_idle_cpu()

 include/linux/sched.h   |  3 ++
 kernel/sched/fair.c     | 86 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    |  1 +
 4 files changed, 87 insertions(+), 4 deletions(-)

-- 
2.25.1

