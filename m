Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9ED7F4B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbjKVPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344793AbjKVPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:45:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C184035B1;
        Wed, 22 Nov 2023 07:35:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67D4C433C7;
        Wed, 22 Nov 2023 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667350;
        bh=2wf790NikfN3qQ4sBFHtT2Zowr+y/fPSqCcB8Ds/zys=;
        h=From:To:Cc:Subject:Date:From;
        b=q9qV2xheffN/KU0SA9hrW57rNZaq1h7aHPnVy+IFRXw/GF8R3Hq0KUjtlNdaRja7s
         BdLQLwQ0gU6qN62sqVwwSykdpLK4E4Ifsb6mp4Ha2/VXdU4p7WIDPA+coCQ4F6v7g8
         Ac9U2vZMFUsVgYnjUPWH4WxhE/AcB+PttbUCr5zp9YJC5PspJOQRD0cHOsjXJ3KOLJ
         t/yTWeCirprx6aqNfkTt8+LROEKywPC0HHuVgGAIMOW6TQG4qwnPnBAnjgpUDfX5Yk
         DRrQvz9McNTS5qgc4vv2j1P8AiUbWi5FGrXmnLYs/p0adlESe42eLcICQcX6vS2C+H
         1jjUAsOzZXLFQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, Liu Tie <liutie4@huawei.com>,
        Sasha Levin <sashal@kernel.org>, peterz@infradead.org
Subject: [PATCH AUTOSEL 5.10 1/7] hrtimers: Push pending hrtimers away from outgoing CPU earlier
Date:   Wed, 22 Nov 2023 10:35:29 -0500
Message-ID: <20231122153541.853179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.201
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
index 7cc2889608e0f..f5a5df3a8cfd1 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -149,6 +149,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
+	CPUHP_AP_HRTIMERS_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 7f1b8549ebcee..a88be8bd4e1d1 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -526,9 +526,9 @@ extern void sysrq_timer_list_show(void);
 
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
index 008b50da22246..abf717c4f57c2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1595,7 +1595,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_HRTIMERS_PREPARE] = {
 		.name			= "hrtimers:prepare",
 		.startup.single		= hrtimers_prepare_cpu,
-		.teardown.single	= hrtimers_dead_cpu,
+		.teardown.single	= NULL,
 	},
 	[CPUHP_SMPCFD_PREPARE] = {
 		.name			= "smpcfd:prepare",
@@ -1662,6 +1662,12 @@ static struct cpuhp_step cpuhp_hp_states[] = {
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
index 70deb2f01e97a..ede09dda36e90 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2114,29 +2114,22 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
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
@@ -2147,15 +2140,13 @@ int hrtimers_dead_cpu(unsigned int scpu)
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

