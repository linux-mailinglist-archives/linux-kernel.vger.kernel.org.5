Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D0F7E8BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 18:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjKKRQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 12:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKKRQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 12:16:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ACA3860;
        Sat, 11 Nov 2023 09:15:59 -0800 (PST)
Date:   Sat, 11 Nov 2023 17:15:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699722956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fuYw6Yw8P5UG7hC0IPK/bTBplg4curHKAyH4q79kCjg=;
        b=qpNphbABB8VL4S8xpJ48pPshd+QXg3MqJfgpyHRu9YV8PAVqW8fI/1OZ0W5rYWYfgz0rQ9
        au4bT2YoG0ONDA1dm8QUZwKSvGW5z+mzx64Ask3BQOqByZ4xKFzKBH7bd9KAUUEAgp5hxM
        vENmRftWCfU8H6ahKsbgLHaS/i3QifJHc2zTDBFdnhh0ME+RY1WlYESho2G6iPPwTDO0If
        ljmsPVNlw3K1XQA4VzFXhblE0xfewubRT6kTGVlOnPL9jD3JaeZ4Q9oBY/PzweRxtr+fRZ
        9gomuORhDW50P14R8tgQSOEOZf1P83n0mXzvVz0j5Co35Zg6+gYzyszG2Kpccg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699722956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fuYw6Yw8P5UG7hC0IPK/bTBplg4curHKAyH4q79kCjg=;
        b=Y2BLO1onnkWdKyUeKEJweM9PgdyXiNEtHDS4pl0I/+7xFetPVV9gIN9VZISKHm7nonZ5F9
        pCcq2+VYKPMpp0CQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimers: Push pending hrtimers away from
 outgoing CPU earlier
Cc:     Yu Liao <liaoyu15@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Liu Tie <liutie4@huawei.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87a5rphara.ffs@tglx>
References: <87a5rphara.ffs@tglx>
MIME-Version: 1.0
Message-ID: <169972295552.3135.1094880886431606890.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     5c0930ccaad5a74d74e8b18b648c5eb21ed2fe94
Gitweb:        https://git.kernel.org/tip/5c0930ccaad5a74d74e8b18b648c5eb21ed2fe94
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 07 Nov 2023 15:57:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 11 Nov 2023 18:06:42 +01:00

hrtimers: Push pending hrtimers away from outgoing CPU earlier

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
---
 include/linux/cpuhotplug.h |  1 +
 include/linux/hrtimer.h    |  4 ++--
 kernel/cpu.c               |  8 +++++++-
 kernel/time/hrtimer.c      | 33 ++++++++++++---------------------
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 068f773..448f5f9 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -193,6 +193,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
+	CPUHP_AP_HRTIMERS_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0ee1401..f2044d5 100644
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
index 6de7c6b..2e69a1d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2098,7 +2098,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_HRTIMERS_PREPARE] = {
 		.name			= "hrtimers:prepare",
 		.startup.single		= hrtimers_prepare_cpu,
-		.teardown.single	= hrtimers_dead_cpu,
+		.teardown.single	= NULL,
 	},
 	[CPUHP_SMPCFD_PREPARE] = {
 		.name			= "smpcfd:prepare",
@@ -2190,6 +2190,12 @@ static struct cpuhp_step cpuhp_hp_states[] = {
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
index 238262e..7607939 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2219,29 +2219,22 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
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
@@ -2252,15 +2245,13 @@ int hrtimers_dead_cpu(unsigned int scpu)
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
 
