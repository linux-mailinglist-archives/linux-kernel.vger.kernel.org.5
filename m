Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726C47F4AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344575AbjKVPgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbjKVPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:36:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3C719B4;
        Wed, 22 Nov 2023 07:34:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6E3C4167E;
        Wed, 22 Nov 2023 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667288;
        bh=J0s9FKLxyCw5WD+rqF9CAvXOqCbF6O1wEYES7Dv8ANQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jolo0Ao6HQZldlRUYD+uchrxDTzKNcrAu9hxxXWj4Qp2vnzDmXU0+BhTP/Nu/IEVX
         FwyvxlP3f/c0RniGGD0VS3HT/x+HCaStfBAP+N/87/vl8hi3NxXRZ2LfLst4Ej17vS
         fMW5NynZECxHFVwRI0SGbUv4w8RvLF60k1bSH7sJAXvSLvIMAUbsx8ewzYsGcQhq3z
         TTub8/98L8gE6FWzB5mScsEJrbFRHNAOVYxSxj/Aky64juBqo3g2NAs5vt4kjmf+PS
         QVTVkpTG9Mnh/E8Egzp2I3hJRJ4VagvCTr8E76NK4PTRH2AoHFTDPkFGNKlF7DWgE4
         aO4D/54CXJL+g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, Liu Tie <liutie4@huawei.com>,
        Sasha Levin <sashal@kernel.org>, peterz@infradead.org
Subject: [PATCH AUTOSEL 6.1 2/9] hrtimers: Push pending hrtimers away from outgoing CPU earlier
Date:   Wed, 22 Nov 2023 10:34:26 -0500
Message-ID: <20231122153440.852807-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153440.852807-1-sashal@kernel.org>
References: <20231122153440.852807-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.63
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 5c0930ccaad5a74d74e8b18b648c5eb21ed2fe94 ]

2b8272ff4a70 ("cpu/hotplug: Prevent self deadlock on CPU hot-unplug")
solved the straight forward CPU hotplug deadlock vs. the scheduler
bandwidth timer. Yu discovered a more involved variant where a task which
has a bandwidth timer started on the outgoing CPU holds a lock and then
gets throttled. If the lock required by one of the CPU hotplug callbacks
the hotplug operation deadlocks because the unthrottling timer event is not
handled on the dying CPU and can only be recovered once the control CPU
reaches the hotplug state which pulls the pending hrtimers from the dead
CPU.

Solve this by pushing the hrtimers away from the dying CPU in the dying
callbacks. Nothing can queue a hrtimer on the dying CPU at that point because
all other CPUs spin in stop_machine() with interrupts disabled and once the
operation is finished the CPU is marked offline.

Reported-by: Yu Liao <liaoyu15@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Liu Tie <liutie4@huawei.com>
Link: https://lore.kernel.org/r/87a5rphara.ffs@tglx
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cpuhotplug.h |  1 +
 include/linux/hrtimer.h    |  4 ++--
 kernel/cpu.c               |  8 +++++++-
 kernel/time/hrtimer.c      | 33 ++++++++++++---------------------
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index c7e0d80dbf6a5..67575bc8a7e29 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -196,6 +196,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
+	CPUHP_AP_HRTIMERS_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0ee140176f102..f2044d5a652b5 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -531,9 +531,9 @@ extern void sysrq_timer_list_show(void);
 
 int hrtimers_prepare_cpu(unsigned int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
-int hrtimers_dead_cpu(unsigned int cpu);
+int hrtimers_cpu_dying(unsigned int cpu);
 #else
-#define hrtimers_dead_cpu	NULL
+#define hrtimers_cpu_dying	NULL
 #endif
 
 #endif
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f8eb1825f704f..ca861e545f34e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1730,7 +1730,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_HRTIMERS_PREPARE] = {
 		.name			= "hrtimers:prepare",
 		.startup.single		= hrtimers_prepare_cpu,
-		.teardown.single	= hrtimers_dead_cpu,
+		.teardown.single	= NULL,
 	},
 	[CPUHP_SMPCFD_PREPARE] = {
 		.name			= "smpcfd:prepare",
@@ -1797,6 +1797,12 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= NULL,
 		.teardown.single	= smpcfd_dying_cpu,
 	},
+	[CPUHP_AP_HRTIMERS_DYING] = {
+		.name			= "hrtimers:dying",
+		.startup.single		= NULL,
+		.teardown.single	= hrtimers_cpu_dying,
+	},
+
 	/* Entry state on starting. Interrupts enabled from here on. Transient
 	 * state for synchronsization */
 	[CPUHP_AP_ONLINE] = {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e4f0e3b0c4f4f..5561dabc9b225 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2216,29 +2216,22 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 	}
 }
 
-int hrtimers_dead_cpu(unsigned int scpu)
+int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i;
+	int i, ncpu = cpumask_first(cpu_active_mask);
 
-	BUG_ON(cpu_online(scpu));
-	tick_cancel_sched_timer(scpu);
+	tick_cancel_sched_timer(dying_cpu);
+
+	old_base = this_cpu_ptr(&hrtimer_bases);
+	new_base = &per_cpu(hrtimer_bases, ncpu);
 
-	/*
-	 * this BH disable ensures that raise_softirq_irqoff() does
-	 * not wakeup ksoftirqd (and acquire the pi-lock) while
-	 * holding the cpu_base lock
-	 */
-	local_bh_disable();
-	local_irq_disable();
-	old_base = &per_cpu(hrtimer_bases, scpu);
-	new_base = this_cpu_ptr(&hrtimer_bases);
 	/*
 	 * The caller is globally serialized and nobody else
 	 * takes two locks at once, deadlock is not possible.
 	 */
-	raw_spin_lock(&new_base->lock);
-	raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
+	raw_spin_lock(&old_base->lock);
+	raw_spin_lock_nested(&new_base->lock, SINGLE_DEPTH_NESTING);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
 		migrate_hrtimer_list(&old_base->clock_base[i],
@@ -2249,15 +2242,13 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	 * The migration might have changed the first expiring softirq
 	 * timer on this CPU. Update it.
 	 */
-	hrtimer_update_softirq_timer(new_base, false);
+	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
+	/* Tell the other CPU to retrigger the next event */
+	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
-	raw_spin_unlock(&old_base->lock);
 	raw_spin_unlock(&new_base->lock);
+	raw_spin_unlock(&old_base->lock);
 
-	/* Check, if we got expired work to do */
-	__hrtimer_peek_ahead_timers();
-	local_irq_enable();
-	local_bh_enable();
 	return 0;
 }
 
-- 
2.42.0

