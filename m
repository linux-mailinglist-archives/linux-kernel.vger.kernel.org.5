Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829567BCBB0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 04:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbjJHCQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 22:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344249AbjJHCQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 22:16:01 -0400
Received: from out-208.mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A2BB9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 19:15:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696731355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GKh09dwIHSZXs0/OglyxLBStxYXOe4hyzNoRqfAtIFw=;
        b=QcXbAuy/yj6jmA70nZBJhmO0lKL0Meriu/+PCHme6D1DuYMx8m3bKfWL4vwuzP0YmsXgyf
        FkoWDVTMgJ8n2NNbvMvKL8injeKHt1+xFI9JiR8a/QmH9HAW6qOS1DhBPN79Mho+cMsn+L
        Zf1+iqqF8qpZJQrFwJ5tN49NMXp9OtI=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] sched/rt: case sysctl_sched_rt_period to integer
Date:   Sun,  8 Oct 2023 10:15:38 +0800
Message-Id: <20231008021538.3063250-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_dointvec_minmax is for integer, but sysctl_sched_rt_period is an
unsigned integer. And sysctl_sched_rt_period takes values from 1 to
INT_MAX, so sysctl_sched_rt_period doesn't have to be an unsigned integer.

Case sysctl_sched_rt_period to integer. Also, change the maximum value
of sysctl_sched_rt_runtime to sysctl_sched_rt_period.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/rt.c    | 6 +++---
 kernel/sched/sched.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 88fc98601413..76d82a096e03 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -16,7 +16,7 @@ struct rt_bandwidth def_rt_bandwidth;
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
  */
-unsigned int sysctl_sched_rt_period = 1000000;
+int sysctl_sched_rt_period = 1000000;
 
 /*
  * part of the period that we allow rt tasks to run in us.
@@ -34,7 +34,7 @@ static struct ctl_table sched_rt_sysctls[] = {
 	{
 		.procname       = "sched_rt_period_us",
 		.data           = &sysctl_sched_rt_period,
-		.maxlen         = sizeof(unsigned int),
+		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
 		.extra1         = SYSCTL_ONE,
@@ -47,7 +47,7 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
 		.extra1         = SYSCTL_NEG_ONE,
-		.extra2         = SYSCTL_INT_MAX,
+		.extra2         = (void *)&sysctl_sched_rt_period,
 	},
 	{
 		.procname       = "sched_rr_timeslice_ms",
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 649eb9ec0657..515eb4cffd5e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -105,7 +105,7 @@ extern long calc_load_fold_active(struct rq *this_rq, long adjust);
 
 extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
 
-extern unsigned int sysctl_sched_rt_period;
+extern int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 extern int sched_rr_timeslice;
 
-- 
2.25.1

