Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B475799530
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbjIIAvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbjIIAvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:51:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029EE44B7;
        Fri,  8 Sep 2023 17:41:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB707C116AE;
        Sat,  9 Sep 2023 00:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220072;
        bh=qTGrG/4JaeqgSoo84qlJqZ3mukGoHBWMkFM49gwhkVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AttgGqgRdDlNMNEDljOcw8QnFAAqB/IVFXE6wHx25+jZKu97aitwL37gbq8fPoeDN
         1hazpUu12BjG3020HH4+ThSCIfxv+fZwBxxSIMhuwK74FG7tov34CPU1EqpRIsemu/
         FVA/HdTi0Uu5rNza1i1U/2Nhqd8vKJzfLIeURCbHyzHkAb1wk7DV92JlUIbcp5Apta
         /Kf7qvqwNtMChpjqUbmsyh+nMablZOlRgIrng4XK9yOMl3dgbl1BKXD4/C56avpWYa
         IXdcupZcUSp88pKT+gRCufCF7HpmzmJQdhEgxhk1J3uHuk+ZrjfJ6vhS2NQK2wCndd
         GbCkBj8wrZjTg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 12/14] workqueue: Call wq_update_unbound_numa() on all CPUs in NUMA node on CPU hotplug
Date:   Fri,  8 Sep 2023 20:40:43 -0400
Message-Id: <20230909004045.3581014-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909004045.3581014-1-sashal@kernel.org>
References: <20230909004045.3581014-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.294
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 5533206cb6f48..c994b06f60f2f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3907,7 +3907,8 @@ EXPORT_SYMBOL_GPL(apply_workqueue_attrs);
 /**
  * wq_update_unbound_numa - update NUMA affinity of a wq for CPU hot[un]plug
  * @wq: the target workqueue
- * @cpu: the CPU coming up or going down
+ * @cpu: the CPU to update pool association for
+ * @hotplug_cpu: the CPU coming up or going down
  * @online: whether @cpu is coming up or going down
  *
  * This function is to be called from %CPU_DOWN_PREPARE, %CPU_ONLINE and
@@ -3927,10 +3928,10 @@ EXPORT_SYMBOL_GPL(apply_workqueue_attrs);
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
@@ -3958,7 +3959,7 @@ static void wq_update_unbound_numa(struct workqueue_struct *wq, int cpu,
 	 * and create a new one if they don't match.  If the target cpumask
 	 * equals the default pwq's, the default pwq should be used.
 	 */
-	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, cpu_off, cpumask)) {
+	if (wq_calc_node_cpumask(wq->dfl_pwq->pool->attrs, node, off_cpu, cpumask)) {
 		if (cpumask_equal(cpumask, pwq->pool->attrs->cpumask))
 			return;
 	} else {
@@ -4876,8 +4877,15 @@ int workqueue_online_cpu(unsigned int cpu)
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
@@ -4895,8 +4903,15 @@ int workqueue_offline_cpu(unsigned int cpu)
 
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
@@ -5843,7 +5858,8 @@ int __init workqueue_init(void)
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

