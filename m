Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDBC7CFF04
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346488AbjJSQFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbjJSQFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:05:21 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCC512F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697731517;
        bh=7KjakoOURxZ/nx5qRaNnouSfOxFpDE60GWEDDF8aPR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3ncLwrHo6ePWoeW8vT6xsQj3rEYaahoc+fCloRXoSnPqIR7kUE6m/IPavp/F9AmV
         6jBdiWZoWefRoaoAn8R/i61pbwou8jNFdpXZs2mu7wuXwO3sgSggfEarS9+thXzO1X
         nDEPH8IMO+JTFhoDA0kGQs2kY1x6XbSZdOCcwd5P2UNqAjZf4uI9JWenCOWcE55cI2
         8o2u4KYm1HPH4V74D9krsG/S5anR5aQHl0FwYX0ULoFhvO3DxF480SATejrPvfm/oN
         W21hL0LuEPnJDTARijYQEFqmm2/k8gSiWv4GoAZwUkO+46RrHA+R8Ga8qjCwyYeDmc
         1F8RkJv1NP9Dw==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SBCH05vxzz1Y9Q;
        Thu, 19 Oct 2023 12:05:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
Subject: [RFC PATCH v2 2/2] sched/fair: Introduce SELECT_BIAS_PREV to reduce migrations
Date:   Thu, 19 Oct 2023 12:05:23 -0400
Message-Id: <20231019160523.1582101-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the SELECT_BIAS_PREV scheduler feature to reduce the task
migration rate.

It needs to be used with the UTIL_FITS_CAPACITY scheduler feature to
show benchmark improvements.

For scenarios where the system is under-utilized (CPUs are partly idle),
eliminate frequent task migrations from CPUs with sufficient remaining
capacity left to completely idle CPUs by introducing a bias towards the
previous CPU if it is idle or has enough capacity left.

For scenarios where the system is fully or over-utilized (CPUs are
almost never idle), favor the previous CPU (rather than the target CPU)
if all CPUs are busy to minimize migrations. (suggested by Chen Yu)

The following benchmarks are performed on a v6.5.5 kernel with
mitigations=off.

This speeds up the following hackbench workload on a 192 cores AMD EPYC
9654 96-Core Processor (over 2 sockets):

hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

from 49s to 29s. (41% speedup)

Elapsed time comparison:

Baseline:                               48-49 s
UTIL_FITS_CAPACITY:                     39-40 s
SELECT_BIAS_PREV:                       48-50 s
UTIL_FITS_CAPACITY+SELECT_BIAS_PREV:    29-30 s

We can observe that the number of migrations is reduced significantly
(-80%) with this patch, which may explain the speedup:

Baseline:                               117M cpu-migrations  (9.355 K/sec)
UTIL_FITS_CAPACITY:                      48M cpu-migrations  (3.977 K/sec)
SELECT_BIAS_PREV:                        75M cpu-migrations  (5.674 K/sec)
UTIL_FITS_CAPACITY+SELECT_BIAS_PREV:     23M cpu-migrations  (2.316 K/sec)

The CPU utilization is also improved:

Baseline:                            253.275 CPUs utilized
UTIL_FITS_CAPACITY:                  271.367 CPUs utilized
SELECT_BIAS_PREV:                    276.526 CPUs utilized
UTIL_FITS_CAPACITY+SELECT_BIAS_PREV: 303.356 CPUs utilized

Interestingly, the rate of context switch increases with the patch, but
it does not appear to be an issue performance-wise:

Baseline:                               445M context-switches (35.516 K/sec)
UTIL_FITS_CAPACITY:                     586M context-switches (48.823 K/sec)
SELECT_BIAS_PREV:                       655M context-switches (49.074 K/sec)
UTIL_FITS_CAPACITY+SELECT_BIAS_PREV:    571M context-switches (57.714 K/sec)

This was developed as part of the investigation into a weird regression
reported by AMD where adding a raw spinlock in the scheduler context
switch accelerated hackbench. It turned out that changing this raw
spinlock for a loop of 10000x cpu_relax within do_idle() had similar
benefits.

This patch achieves a similar effect without the busy-waiting by
allowing select_task_rq to favor the previously used CPUs based on the
utilization of that CPU.

Feedback is welcome. I am especially interested to learn whether this
patch has positive or detrimental effects on performance of other
workloads.

Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
Link: https://lore.kernel.org/lkml/20230725193048.124796-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/f6dc1652-bc39-0b12-4b6b-29a2f9cd8484@amd.com/
Link: https://lore.kernel.org/lkml/20230822113133.643238-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20230823060832.454842-1-aaron.lu@intel.com/
Link: https://lore.kernel.org/lkml/20230905171105.1005672-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/cover.1695704179.git.yu.c.chen@intel.com/
Link: https://lore.kernel.org/lkml/20230929183350.239721-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20231012203626.1298944-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20231017221204.1535774-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20231018204511.1563390-1-mathieu.desnoyers@efficios.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Gautham R . Shenoy <gautham.shenoy@amd.com>
Cc: x86@kernel.org
---
 kernel/sched/fair.c     | 28 ++++++++++++++++++++++++++--
 kernel/sched/features.h |  6 ++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cc86d1ffeb27..0aae1f15cb0e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7164,15 +7164,30 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
+	/*
+	 * With the SELECT_BIAS_PREV feature, if the previous CPU is
+	 * cache affine and the task fits within the prev cpu capacity,
+	 * prefer the previous CPU to the target CPU to inhibit costly
+	 * task migration.
+	 */
+	if (sched_feat(SELECT_BIAS_PREV) &&
+	    (prev == target || cpus_share_cache(prev, target)) &&
+	    (available_idle_cpu(prev) || sched_idle_cpu(prev) ||
+	    task_fits_remaining_cpu_capacity(task_util, prev)) &&
+	    asym_fits_cpu(task_util, util_min, util_max, prev))
+		return prev;
+
 	if ((available_idle_cpu(target) || sched_idle_cpu(target) ||
 	    task_fits_remaining_cpu_capacity(task_util, target)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
 	/*
-	 * If the previous CPU is cache affine and idle, don't be stupid:
+	 * Without the SELECT_BIAS_PREV feature, use the previous CPU if
+	 * it is cache affine and idle if the target cpu is not idle.
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (!sched_feat(SELECT_BIAS_PREV) &&
+	    prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev) ||
 	    task_fits_remaining_cpu_capacity(task_util, prev)) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev))
@@ -7245,6 +7260,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	/*
+	 * With the SELECT_BIAS_PREV feature, if the previous CPU is
+	 * cache affine, prefer the previous CPU when all CPUs are busy
+	 * to inhibit migration.
+	 */
+	if (sched_feat(SELECT_BIAS_PREV) &&
+	    prev != target && cpus_share_cache(prev, target))
+		return prev;
+
 	return target;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 9a84a1401123..a56d6861c553 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -103,6 +103,12 @@ SCHED_FEAT(UTIL_EST_FASTUP, true)
  */
 SCHED_FEAT(UTIL_FITS_CAPACITY, true)
 
+/*
+ * Bias runqueue selection towards the previous runqueue over the target
+ * runqueue.
+ */
+SCHED_FEAT(SELECT_BIAS_PREV, true)
+
 SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
-- 
2.39.2

