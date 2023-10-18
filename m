Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED17CD632
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjJRIRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjJRIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:17:35 -0400
Received: from out-194.mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4648FB6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:17:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697617051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zy9fCLbPUi1k7I58SOVdMfFxEcUzWTJduGQe7dU0lhM=;
        b=V7UUY9fYnMYUrI7HTAKqUnv8vta2FjvG4b4iEezqly4j9H/tCTnclqeth87vfr/Zr8iNZh
        j+LhXB9jAox5w5tXgOmiWFuWSL1ovhPuXHaK8z/EqkN0Uys+PuPoR6aqGGjmct6VWFW4Ln
        /us3zhaqmPTZXMPBmv8pWZb88wCzsGU=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] sched/rt: Redefine RR_TIMESLICE to 100 msecs
Date:   Wed, 18 Oct 2023 16:17:09 +0800
Message-Id: <20231018081709.2289264-1-yajun.deng@linux.dev>
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

The RR_TIMESLICE is currently defined as the jiffies corresponding to
100 msecs. And then sysctl_sched_rr_timeslice will convert RR_TIMESLICE
to 100 msecs. These are opposite calculations.

There are msecs_to_jiffies and jiffies_to_msecs in sched_rr_handler.
These are also opposite calculations.

Redefine RR_TIMESLICE to 100 msecs, only sched_rr_timeslice needs to
convert RR_TIMESLICE to jiffies.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/sched/rt.h |  2 +-
 init/init_task.c         |  2 +-
 kernel/sched/rt.c        | 12 +++++-------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index b2b9e6eb9683..74f8f456a804 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -58,6 +58,6 @@ extern void normalize_rt_tasks(void);
  * default timeslice is 100 msecs (used only for SCHED_RR tasks).
  * Timeslices get refilled after they expire.
  */
-#define RR_TIMESLICE		(100 * HZ / 1000)
+#define RR_TIMESLICE		(100)
 
 #endif /* _LINUX_SCHED_RT_H */
diff --git a/init/init_task.c b/init/init_task.c
index 5727d42149c3..86619a425342 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -94,7 +94,7 @@ struct task_struct init_task
 	},
 	.rt		= {
 		.run_list	= LIST_HEAD_INIT(init_task.rt.run_list),
-		.time_slice	= RR_TIMESLICE,
+		.time_slice	= (RR_TIMESLICE * HZ) / MSEC_PER_SEC,
 	},
 	.tasks		= LIST_HEAD_INIT(init_task.tasks),
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..7c0e912094a9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -4,7 +4,7 @@
  * policies)
  */
 
-int sched_rr_timeslice = RR_TIMESLICE;
+int sched_rr_timeslice = (RR_TIMESLICE * HZ) / MSEC_PER_SEC;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
@@ -25,7 +25,7 @@ int sysctl_sched_rt_period = 1000000;
 int sysctl_sched_rt_runtime = 950000;
 
 #ifdef CONFIG_SYSCTL
-static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC * RR_TIMESLICE) / HZ;
+static int sysctl_sched_rr_timeslice = RR_TIMESLICE;
 static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
@@ -3014,12 +3014,10 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 	 * Also, writing zero resets the timeslice to default:
 	 */
 	if (!ret && write) {
-		sched_rr_timeslice =
-			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
-			msecs_to_jiffies(sysctl_sched_rr_timeslice);
-
 		if (sysctl_sched_rr_timeslice <= 0)
-			sysctl_sched_rr_timeslice = jiffies_to_msecs(RR_TIMESLICE);
+			sysctl_sched_rr_timeslice = RR_TIMESLICE;
+
+		sched_rr_timeslice = msecs_to_jiffies(sysctl_sched_rr_timeslice);
 	}
 	mutex_unlock(&mutex);
 
-- 
2.25.1

