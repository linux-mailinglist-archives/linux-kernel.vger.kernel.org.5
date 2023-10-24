Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84527D4AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjJXIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjJXIwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:52:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84868D79;
        Tue, 24 Oct 2023 01:52:27 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:52:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698137545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MV81urpQ3LRyU/4L8q4jhj8B7X6eugmtFNGJsW0hsWk=;
        b=HrUmmlkhY6kO4eiYeSomRKrmFf6Hd+hM80kjajrBe0yyb5Qfrq+McNJyLSR3ETh8euzlli
        gkiuLwVWGZKN7iLPkOspckFHT+sUTCaxm7PPQjR/9omo3UXyu/mORcW0ZDYJWj9oyTjERQ
        0x+yCiFAyEvjbL8V7UiZiCwGKq4Xn5uMHp+NVa2nHTWiuZvE8wbs20uq17gzrJ4Y0CBQ1P
        B5+6FrTdtlyMY1ah1GaraG38UgQm4idq/U9vu301+hbJ6VfIvIpV8Uzt5TnM/u/1z3lk/0
        bf7q0MTvAMyUrRNIpRiR0blevWsXZLIytkHyGbTG/ALrTbEXWM6HNzwbZ2yDwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698137545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MV81urpQ3LRyU/4L8q4jhj8B7X6eugmtFNGJsW0hsWk=;
        b=2amR/kIPOGUCdjzwKroK33shpnbEC8klIQI0D+doTsXISEh0gJcQU90eGnZ78l9eosmNwg
        78+BJ1nyx4vqnmAg==
From:   "tip-bot2 for Yicong Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use candidate prev/recent_used CPU if
 scanning failed for cluster wakeup
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231019033323.54147-4-yangyicong@huawei.com>
References: <20231019033323.54147-4-yangyicong@huawei.com>
MIME-Version: 1.0
Message-ID: <169813754499.3135.5461462056301106670.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     22165f61d0c4092adf40f967c899e5d8b8a0d703
Gitweb:        https://git.kernel.org/tip/22165f61d0c4092adf40f967c899e5d8b8a0d703
Author:        Yicong Yang <yangyicong@hisilicon.com>
AuthorDate:    Thu, 19 Oct 2023 11:33:23 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Oct 2023 10:38:43 +02:00

sched/fair: Use candidate prev/recent_used CPU if scanning failed for cluster wakeup

Chen Yu reports a hackbench regression of cluster wakeup when
hackbench threads equal to the CPU number [1]. Analysis shows
it's because we wake up more on the target CPU even if the
prev_cpu is a good wakeup candidate and leads to the decrease
of the CPU utilization.

Generally if the task's prev_cpu is idle we'll wake up the task
on it without scanning. On cluster machines we'll try to wake up
the task in the same cluster of the target for better cache
affinity, so if the prev_cpu is idle but not sharing the same
cluster with the target we'll still try to find an idle CPU within
the cluster. This will improve the performance at low loads on
cluster machines. But in the issue above, if the prev_cpu is idle
but not in the cluster with the target CPU, we'll try to scan an
idle one in the cluster. But since the system is busy, we're
likely to fail the scanning and use target instead, even if
the prev_cpu is idle. Then leads to the regression.

This patch solves this in 2 steps:
o record the prev_cpu/recent_used_cpu if they're good wakeup
  candidates but not sharing the cluster with the target.
o on scanning failure use the prev_cpu/recent_used_cpu if
  they're recorded as idle

[1] https://lore.kernel.org/all/ZGzDLuVaHR1PAYDt@chenyu5-mobl1/

Closes: https://lore.kernel.org/all/ZGsLy83wPIpamy6x@chenyu5-mobl1/
Reported-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Tested-and-reviewed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20231019033323.54147-4-yangyicong@huawei.com
---
 kernel/sched/fair.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c47b38e..523b5ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7392,7 +7392,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	bool has_idle_core = false;
 	struct sched_domain *sd;
 	unsigned long task_util, util_min, util_max;
-	int i, recent_used_cpu;
+	int i, recent_used_cpu, prev_aff = -1;
 
 	/*
 	 * On asymmetric system, update task utilization because we will check
@@ -7424,6 +7424,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		if (!static_branch_unlikely(&sched_cluster_active) ||
 		    cpus_share_resources(prev, target))
 			return prev;
+
+		prev_aff = prev;
 	}
 
 	/*
@@ -7456,6 +7458,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		    cpus_share_resources(recent_used_cpu, target))
 			return recent_used_cpu;
 
+	} else {
+		recent_used_cpu = -1;
 	}
 
 	/*
@@ -7496,6 +7500,17 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	/*
+	 * For cluster machines which have lower sharing cache like L2 or
+	 * LLC Tag, we tend to find an idle CPU in the target's cluster
+	 * first. But prev_cpu or recent_used_cpu may also be a good candidate,
+	 * use them if possible when no idle CPU found in select_idle_cpu().
+	 */
+	if ((unsigned int)prev_aff < nr_cpumask_bits)
+		return prev_aff;
+	if ((unsigned int)recent_used_cpu < nr_cpumask_bits)
+		return recent_used_cpu;
+
 	return target;
 }
 
