Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414D479959C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbjIIBhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjIIBhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:37:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D831FE3;
        Fri,  8 Sep 2023 18:37:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBB3C43215;
        Sat,  9 Sep 2023 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220009;
        bh=GEi9r/2z2/ylvso7cl9a4+GQmvjv9dVw5mho62slOWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYpAS7AGi1SmWQXj4/mBmAdq6jQJGcso8syvoa82G+Wn97tB2mWck2YDRQIvEaf9G
         e1KgX71eTZPjJs910MY+AvkaFo8frFA9iTL7Ms8OqMQXWKU3aI1Y7S0nqis01ZxmOA
         tRFBCnRCHQtSsd47HQmhvLggWCBfbeq0jrVyrj76LagpBGXEPbbhVF0XCjCngsP3Wu
         YnOcF9BsOAAD+4Jt6VpFiMAm/9OB3JKuAZmMICtN6uYWhILHk1OAuYoqF3psT0TKuK
         k33+xIi87THoa+eqqg7RQ7ZpBYwMrdqBUTM+SpFONjcysnFwxvULp1OMP1CgEafrYs
         qpNdr6atl91gQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 13/16] workqueue: Call wq_update_unbound_numa() on all CPUs in NUMA node on CPU hotplug
Date:   Fri,  8 Sep 2023 20:39:38 -0400
Message-Id: <20230909003941.3580631-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003941.3580631-1-sashal@kernel.org>
References: <20230909003941.3580631-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 4cbfd3de737b9d00544ff0f673cb75fc37bffb6a ]

When a CPU went online or offline, wq_update_unbound_numa() was called only
on the CPU which was going up or down. This works fine because all CPUs on
the same NUMA node share the same pool_workqueue slot - one CPU updating it
updates it for everyone in the node.

However, future changes will make each CPU use a separate pool_workqueue
even when they're sharing the same worker_pool, which requires updating
pool_workqueue's for all CPUs which may be sharing the same pool_workqueue
on hotplug.

To accommodate the planned changes, this patch updates
workqueue_on/offline_cpu() so that they call wq_update_unbound_numa() for
all CPUs sharing the same NUMA node as the CPU going up or down. In the
current code, the second+ calls would be noops and there shouldn't be any
behavior changes.

* As wq_update_unbound_numa() is now called on multiple CPUs per each
  hotplug event, @cpu is renamed to @hotplug_cpu and another @cpu argument
  is added. The former indicates the CPU being hot[un]plugged and the latter
  the CPU whose pool_workqueue is being updated.

* In wq_update_unbound_numa(), cpu_off is renamed to off_cpu for consistency
  with the new @hotplug_cpu.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fa0a0e59b3851..e60c4d6c7e49c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4093,7 +4093,8 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 /**
  * wq_update_unbound_numa - update NUMA affinity of a wq for CPU hot[un]plug
  * @wq: the target workqueue
- * @cpu: the CPU coming up or going down
+ * @cpu: the CPU to update pool association for
+ * @hotplug_cpu: the CPU coming up or going down
  * @online: whether @cpu is coming up or going down
  *
  * This function is to be called from %CPU_DOWN_PREPARE, %CPU_ONLINE and
@@ -4113,10 +4114,10 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * CPU_DOWN_PREPARE.
  */
 static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
-				   bool online)
+				   int hotplug_cpu, bool online)
 {
 	int node = cpu_to_node(cpu);
-	int cpu_off = online ? -1 : cpu;
+	int off_cpu = online ? -1 : hotplug_cpu;
 	struct pool_workqueue *old_pwq = NULL, *pwq;
 	struct workqueue_attrs *target_attrs;
 	cpumask_t *cpumask;
@@ -4144,7 +4145,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	 * and create a new one if they don't match.  If the target cpumask
 	 * equals the default pwq's, the default pwq should be used.
 	 */
-	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpu_off, cpumask)) {
+	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, off_cpu, cpumask)) {
 		if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
 			return;
 	} else {
@@ -5089,8 +5090,15 @@ int workqueue_online_cpu(unsigned int cpu)
 	}
 
 	/* update NUMA affinity of unbound workqueues */
-	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, true);
+	list_for_each_entry(wq, &workqueues, list) {
+		int tcpu;
+
+		for_each_possible_cpu(tcpu) {
+			if (cpu_to_node(tcpu) == cpu_to_node(cpu)) {
+				wq_update_unbound_numa(wq, tcpu, cpu, true);
+			}
+		}
+	}
 
 	mutex_unlock(&wq_pool_mutex);
 	return 0;
@@ -5108,8 +5116,15 @@ int workqueue_offline_cpu(unsigned int cpu)
 
 	/* update NUMA affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
-	list_for_each_entry(wq, &workqueues, list)
-		wq_update_unbound_numa(wq, cpu, false);
+	list_for_each_entry(wq, &workqueues, list) {
+		int tcpu;
+
+		for_each_possible_cpu(tcpu) {
+			if (cpu_to_node(tcpu) == cpu_to_node(cpu)) {
+				wq_update_unbound_numa(wq, tcpu, cpu, false);
+			}
+		}
+	}
 	mutex_unlock(&wq_pool_mutex);
 
 	return 0;
@@ -6058,7 +6073,8 @@ void __init workqueue_init(void)
 	}
 
 	list_for_each_entry(wq, &workqueues, list) {
-		wq_update_unbound_numa(wq, smp_processor_id(), true);
+		wq_update_unbound_numa(wq, smp_processor_id(), smp_processor_id(),
+				       true);
 		WARN(init_rescuer(wq),
 		     "workqueue: failed to create early rescuer for %s",
 		     wq->name);
-- 
2.40.1

