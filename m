Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224DD7E422E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjKGO5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjKGO5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:57:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71554101
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:57:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699369034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYAbt0HpEOqXO0Oqnb/B1i9Y8O9E/DsIaTOqrzvJNjI=;
        b=SOcqgjM6ixqNpkFpSmTy3QxgSHU/He2A2bySXKjY9Zf75Uz/PCsaWVXy/y3+4D/9S0ktNW
        OYJ9iB8ZJSBDw7iptmlpIFlXgJnMmynR4fSi2ZaQB76kt6CkdCQZeIadpEVYqYX+8SyMlQ
        yU4ElQUbSrbjAbaQGgd1ucfpUgeJK4IhdY+3TbtBwbGRNtDyHWVYRJoW4YLWdqTcv60E0v
        pNPANeZnrPVrvJjGxRsaSDgTUVWutRzflxw3igHlq6hT9m1LOdoIDkwAAzyHGx2y637VF7
        TpLnv0J5au+L8mf8dI1R1aAOgs97FF/PecqTF2LPr8nvwMeFBPJvgS8HOrSfvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699369034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYAbt0HpEOqXO0Oqnb/B1i9Y8O9E/DsIaTOqrzvJNjI=;
        b=llJs2tBJiUSgc3dFADOGJWomRMSba1VKXN+W63mO2WxOjGpPFAtbyKADmZzTSfaI/pPH8N
        YcrTmrktXQcCdBAg==
To:     Yu Liao <liaoyu15@huawei.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liwei (GF)" <liwei391@huawei.com>, xiafukun <xiafukun@huawei.com>,
        liutie4@huawei.com, Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Phil Auld <pauld@redhat.com>, vschneid@redhat.com,
        vdonnefort@google.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [Bug report] A variant deadlock issue of CPU hot-unplug
 operation vs. the CFS bandwidth timer
In-Reply-To: <6f0f3e42-ddf2-1bbf-ec80-bcbae41c700c@huawei.com>
References: <6f0f3e42-ddf2-1bbf-ec80-bcbae41c700c@huawei.com>
Date:   Tue, 07 Nov 2023 15:57:13 +0100
Message-ID: <87a5rphara.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07 2023 at 21:26, Yu Liao wrote:
> The patch [1] from tglx solved the deadlock issue reported by Xiongfeng [2],
> but recently we discovered a variant of the deadlock issue.
>
> [1] https://lore.kernel.org/all/87h6oqdq0i.ffs@tglx/
> [2] https://lore.kernel.org/all/8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com/
>
> (The following description is partially borrowed from the commit log of tglx)
> 	CPU1      			                 CPU2                      CPU3
>
> T1 sets cfs_quota
>    starts hrtimer cfs_bandwidth 'period_timer'
> T1 is migrated to CPU3
> 						T2(worker thread) initiates
> 						offlining of CPU1
> Hotplug operation starts
>   ...
> 'period_timer' expires and is
> re-enqueued on CPU1
>   ...
> take_cpu_down()
>   CPU1 shuts down and does not handle timers
>   anymore. They have to be migrated in the
>   post dead hotplug steps by the control task.
>
> 						T2(worker thread) runs the
> 						post dead offline operation
> 										T1 holds lockA
> 										T1 is scheduled out
> 										//throttled by CFS bandwidth control
> 										T1 waits for 'period_timer' to expire
> 						T2(worker thread) waits for lockA
>
> T1 waits there forever if it is scheduled out before it can execute the
> hrtimer offline callback hrtimers_dead_cpu().
> Thus T2 waits for lockA forever.
>
> We discovered several different 'lockA'. This is a real example that occurs on
> kernel 5.10, where 'lockA' is 'kernfs_mutex'.

Bah.

So we can actually migrate the hrtimers away from the outgoing CPU in
the dying callbacks. That's safe as nothing can queue an hrtimer remote
on the outgoing CPU because all other CPUs are spinwaiting with
interrupts disabled in stomp_machine() until the CPU marked itself
offline.

Survived a quick test, but needs some scrunity and probably a sanity
check in the post dead stage.

Thanks,

        tglx
---
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -195,6 +195,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
+	CPUHP_AP_HRTIMERS_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
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
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2116,7 +2116,7 @@ static struct cpuhp_step cpuhp_hp_states
 	[CPUHP_HRTIMERS_PREPARE] = {
 		.name			= "hrtimers:prepare",
 		.startup.single		= hrtimers_prepare_cpu,
-		.teardown.single	= hrtimers_dead_cpu,
+		.teardown.single	= NULL,
 	},
 	[CPUHP_SMPCFD_PREPARE] = {
 		.name			= "smpcfd:prepare",
@@ -2208,6 +2208,12 @@ static struct cpuhp_step cpuhp_hp_states
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
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2219,29 +2219,22 @@ static void migrate_hrtimer_list(struct
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
 
