Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9DA757DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjGRNl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjGRNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:41:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCCB10CB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689687705; x=1721223705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RlvrBHFv6Du1879kI3EewacCpf6aQLiFMk7QITrDmtI=;
  b=nMby4OYaq5z4sAqoYkF7fAxD+rCs82nCNQZ37ezW1tsU3sCqUI5qgKbI
   d40NPZQeZ67rfWrZ1cU3yqLBNKG/uuos/9kREzD33CQlwVQZSLuFG9Cw1
   Dju5Hk5m9FwOD1ATHrYFZl/AYJ9g65ggsh1uKnFsJo4sWTJPhCtqYyLNF
   TggZAVw1/AEvoaTwh9bclrb5t0yENWZApvPpj76u6melQzVVyjGZD4M6k
   avAwnEm2a/2igRB0Bc75/fSo7fb2o3bnu8vJ/jPesoC+TuvX5Y1mk44KG
   oM/8shn33G+n/5fqW8kt0noqIXUdKaQS6iGl+0KfcOqwnrCJr2CHBuJtU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345800745"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345800745"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847706545"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847706545"
Received: from ziqianlu-desk2.sh.intel.com ([10.239.159.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:41:41 -0700
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
Subject: [RFC PATCH 4/4] sched/fair: skip some update_cfs_group() on en/dequeue_entity()
Date:   Tue, 18 Jul 2023 21:41:20 +0800
Message-ID: <20230718134120.81199-5-aaron.lu@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718134120.81199-1-aaron.lu@intel.com>
References: <20230718134120.81199-1-aaron.lu@intel.com>
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

After the previous patch, the cost of update_cfs_group() and
update_load_avg() has dropped to around 1% for postgres_sysbench on SPR
but netperf/UDP_RR on SPR still saw ~20% update_cfs_group() and ~10%
update_load_avg() so this patch is another attempt to further reduce the
two functions' cost from read side.

The observation is: if an entity is dequeued, updating its weight isn't
useful, except that the current code will also update its cfs_rq's
load_avg using the updated weight...so removing update_cfs_group() on
dequeue path can reduce cost of accessing tg->load_avg, but it also will
reduce the tracking accuracy.

Another hint I got from an ancient commit 17bc14b767cf("Revert "sched:
Update_cfs_shares at period edge") is: if an entity is enqueued and it's
the only entity of its cfs_rq, we do not need immediately update its
weight since it's not needed to decide if it can preempt curr.

commit 17bc14b767cf mentioned a latency problem when reducing calling
frequency of update_cfs_group(): doing a make -j32 in one terminal
window will cause browsing experience worse. To see how things are now,
I did a test: two cgroups were created under root and in one group, I did
"make -j32" and in the meantime, I did "./schbench -m 1 -t 6 -r 300" in
another group on a 6core/12cpus Intel i7-8700T Coffee lake cpu and the
wakeup latency reported by schbench for base and this series doesn't look
much different:

base:
schbench -m 1 -t 6 -r 300:
Latency percentiles (usec) runtime 300 (s) (18534 total samples)
        50.0th: 20 (9491 samples)
        75.0th: 25 (4768 samples)
        90.0th: 29 (2552 samples)
        95.0th: 62 (809 samples)
        *99.0th: 20320 (730 samples)
        99.5th: 23392 (92 samples)
        99.9th: 31392 (74 samples)
        min=6, max=32032

make -j32:
real    5m35.950s
user    47m33.814s
sys     4m45.470s

this series:
schbench -m 1 -t 6 -r 300:
Latency percentiles (usec) runtime 300 (s) (18528 total samples)
        50.0th: 21 (9920 samples)
        75.0th: 26 (4756 samples)
        90.0th: 30 (2100 samples)
        95.0th: 63 (846 samples)
        *99.0th: 19040 (722 samples)
        99.5th: 21920 (92 samples)
        99.9th: 30048 (81 samples)
        min=6, max=34873

make -j32:
real    5m35.185s
user    47m28.528s
sys     4m44.705s

As for netperf/UDP_RR/nr_thread=100% on SPR: after this change, the two
functions' cost dropped to ~2%.

Other test results:
================================================
postgres_sysbench(transaction, higher is better)
nr_thread=100%/75%/50% were tested on 2 sockets SPR and Icelake and
results that have a measuable difference are:

nr_thread=100% on SPR:
base:   90569.11±1.15%
node:  104152.26±0.34%  +15.0%
delay: 127309.46±4.25%  +40.6%
skip:  125501.96±1.83%  +38.6%

nr_thread=75% on SPR:
base:  100803.96±0.57%
node:  107333.58±0.44%   +6.5%
delay: 124332.39±0.51%  +23.3%
skip:  127676.55±0.03%  +26.7%

nr_thread=75% on ICL:
base:  61961.26±0.41%
node:  61585.45±0.50%
delay: 72420.52±0.14%  +16.9%
skip:  72413.23±0.30%  +16.9%

=======================================================================
hackbench/pipe/threads/fd=20/loop=1000000 (throughput, higher is better)
group=1/4/8/16 were tested on 2 sockets SPR and Cascade lake and the
results that have a measuable difference are:

group=8 on SPR:
base:  437163±2.6%
node:  471203±1.2%   +7.8%
delay: 490780±0.9%  +12.3%
skip:  493062±1.9%  +12.8%

group=16 on SPR:
base:  468279±1.9%
node:  580385±1.7%  +23.9%
delay: 664422±0.2%  +41.9%
skip:  697387±0.2%  +48.9%

================================================
netperf/TCP_STRAM (throughput, higher is better)
nr_thread=1/25%/50%/75%/100% were tested on 2 sockets SPR and Cascade
Lake and results that have measuable difference are:

nr_thread=50% on SPR:
base:  16258±0.7%
node:  16172±2.9%
delay: 17729±0.7%  +9.0%
skip:  17823±1.3%  +9.6%

nr_thread=75% on CSL:
base:  12923±1.2%
node:  13011±2.2%
delay: 15452±1.6%  +19.6%
skip:  15302±1.7%  +18.4%

nr_thread=75% on SPR:
base:  16232±11.9%
node:  13962±5.1%
delay: 21089±0.8%  +29.9%
skip:  21251±0.4%  +30.9%

nr_thread=100% on SPR:
base:  13220±0.6%
node:  13113±0.0%
delay: 18258±11.3% +38.1%
skip:  16974±12.7% +28.4%

=============================================
netperf/UDP_RR (throughput, higher is better)
nr_thread=1/25%/50%/75%/100% were tested on 2 sockets SPR and Cascade
Lake and results that have measuable difference are:

nr_thread=25% on CSL:
base:  107269±0.3%
node:  107226±0.2%
delay: 106978±0.3%
skip:  109652±0.3%  +2.2%

nr_thread=50% on CSL:
base:  74854±0.1%
node:  74521±0.4%
delay: 74438±0.2%
skip:  76431±0.1%  +2.1%

nr_thread=75% on CSL:
base:  36701±1.7%
node:  39949±1.4%   +8.8%
delay: 42516±0.3%  +15.8%
skip:  45044±0.5%  +22.7%

nr_thread=75% on SPR:
base:  14249±3.8%
node:  19890±2.0%   +39.6%
delay: 31331±0.5%  +119.9%
skip:  33688±3.5%  +136.4%

nr_thread=100% on CSL:
base:  52275±0.6%
node:  53827±0.4%   +3.0%
delay: 78386±0.7%  +49.9%
skip:  76926±2.3%  +47.2%

nr_thread=100% on SPR:
base:   9560±1.6%
node:  14186±3.9%   +48.4%
delay: 20779±2.8%  +117.4%
skip:  32125±2.5%  +236.0%

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 564ffe3e59c1..0dbbb92302ad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4862,7 +4862,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	se_update_runnable(se);
-	update_cfs_group(se);
+	if (cfs_rq->nr_running > 0)
+		update_cfs_group(se);
 	account_entity_enqueue(cfs_rq, se);
 
 	if (flags & ENQUEUE_WAKEUP)
@@ -4978,8 +4979,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
 
-	update_cfs_group(se);
-
 	/*
 	 * Now advance min_vruntime if @se was the entity holding it back,
 	 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
-- 
2.41.0

