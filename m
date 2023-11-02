Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784E87DF731
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376904AbjKBP5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347661AbjKBP5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B312E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698940614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RuVeVCv9mdnDfDJ0toCwOnHIeiEzNsOIusr8nhz3DvE=;
        b=ac2z0hG4X5ihN9xmsk+WmO9HEy4TLPPE/XfWNjHzDypBiDyvrXTSXmG6EFQsBVWFqNglgl
        ziSpRdHEpVbFMPc3htL/jwZ+EcHoKuzbB9k/gGQN10/swbCabbBHDeWKMuGArFG7539QfZ
        hFywnkh6kzXtfPtUs8/rFYsYwxeRoVo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-OHXQl7HOP26GmSTtpcJbCQ-1; Thu, 02 Nov 2023 11:56:51 -0400
X-MC-Unique: OHXQl7HOP26GmSTtpcJbCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 992AE85C1BA;
        Thu,  2 Nov 2023 15:56:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.103])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8604D40C6EBC;
        Thu,  2 Nov 2023 15:56:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  2 Nov 2023 16:55:48 +0100 (CET)
Date:   Thu, 2 Nov 2023 16:55:45 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] cleanup: Add conditional guard support
Message-ID: <20231102155545.GC9680@redhat.com>
References: <20231102104429.025835330@infradead.org>
 <20231102110706.460851167@infradead.org>
 <20231102144009.GA9680@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102144009.GA9680@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02, Oleg Nesterov wrote:
>
> On 11/02, Peter Zijlstra wrote:
> >
> >  include/linux/cleanup.h  |   52 ++++++++++++++++++++++++++++++++++++++++++++---
>
> interesting... I don't know anything about cleanup.h, will
> read this code and the patch later, but I guess I understand
> the idea.
>
> Stupid/offtopic question... Can't we change guard()
>
> 	-#define guard(_name) \
> 	-	CLASS(_name, __UNIQUE_ID(guard))
> 	+#define guard(_name, args...) \
> 	+	CLASS(_name, __UNIQUE_ID(guard))(args)
>
> and update the current users?
>
> To me
>
> 	guard(rcu);
> 	guard(spinlock, &lock);
>
> looks better than
>
> 	guard(rcu)();
> 	// doesn't match scoped_guard(spinlock, &lock)
> 	guard(spinlock)(&lock);
>
> And this will make guard() consistent with scoped_guard().

Just in case the kernel builds and botts with the patch below.
The .c files were changed by

	perl -wpi~ -e 's/\bguard\(\w+\K\)\( (\))?/$1 || ", "/ex' kernel/sched/core.c drivers/gpio/gpio-sim.c drivers/hv/hv_balloon.c lib/locking-selftest.c

Oleg.
---


diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 44bf1709a648..9f659a966ed9 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -70,7 +70,7 @@ static int gpio_sim_apply_pull(struct gpio_sim_chip *chip,
 	gc = &chip->gc;
 	desc = &gc->gpiodev->descs[offset];
 
-	guard(mutex)(&chip->lock);
+	guard(mutex, &chip->lock);
 
 	if (test_bit(FLAG_REQUESTED, &desc->flags) &&
 	    !test_bit(FLAG_IS_OUT, &desc->flags)) {
@@ -113,7 +113,7 @@ static int gpio_sim_get(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_sim_chip *chip = gpiochip_get_data(gc);
 
-	guard(mutex)(&chip->lock);
+	guard(mutex, &chip->lock);
 
 	return !!test_bit(offset, chip->value_map);
 }
@@ -663,7 +663,7 @@ static ssize_t gpio_sim_device_config_dev_name_show(struct config_item *item,
 	struct gpio_sim_device *dev = to_gpio_sim_device(item);
 	struct platform_device *pdev;
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	pdev = dev->pdev;
 	if (pdev)
@@ -965,7 +965,7 @@ gpio_sim_device_config_live_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	if (live == gpio_sim_device_is_live_unlocked(dev))
 		ret = -EPERM;
@@ -1011,7 +1011,7 @@ static ssize_t gpio_sim_bank_config_chip_name_show(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 	struct gpio_sim_chip_name_ctx ctx = { bank->swnode, page };
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	if (gpio_sim_device_is_live_unlocked(dev))
 		return device_for_each_child(&dev->pdev->dev, &ctx,
@@ -1028,7 +1028,7 @@ gpio_sim_bank_config_label_show(struct config_item *item, char *page)
 	struct gpio_sim_bank *bank = to_gpio_sim_bank(item);
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	return sprintf(page, "%s\n", bank->label ?: "");
 }
@@ -1040,7 +1040,7 @@ static ssize_t gpio_sim_bank_config_label_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 	char *trimmed;
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
@@ -1063,7 +1063,7 @@ gpio_sim_bank_config_num_lines_show(struct config_item *item, char *page)
 	struct gpio_sim_bank *bank = to_gpio_sim_bank(item);
 	struct gpio_sim_device *dev = gpio_sim_bank_get_device(bank);
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	return sprintf(page, "%u\n", bank->num_lines);
 }
@@ -1084,7 +1084,7 @@ gpio_sim_bank_config_num_lines_store(struct config_item *item,
 	if (num_lines == 0)
 		return -EINVAL;
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
@@ -1109,7 +1109,7 @@ gpio_sim_line_config_name_show(struct config_item *item, char *page)
 	struct gpio_sim_line *line = to_gpio_sim_line(item);
 	struct gpio_sim_device *dev = gpio_sim_line_get_device(line);
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	return sprintf(page, "%s\n", line->name ?: "");
 }
@@ -1121,7 +1121,7 @@ static ssize_t gpio_sim_line_config_name_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_line_get_device(line);
 	char *trimmed;
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
@@ -1149,7 +1149,7 @@ static ssize_t gpio_sim_hog_config_name_show(struct config_item *item,
 	struct gpio_sim_hog *hog = to_gpio_sim_hog(item);
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	return sprintf(page, "%s\n", hog->name ?: "");
 }
@@ -1161,7 +1161,7 @@ static ssize_t gpio_sim_hog_config_name_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
 	char *trimmed;
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
@@ -1216,7 +1216,7 @@ gpio_sim_hog_config_direction_store(struct config_item *item,
 	struct gpio_sim_device *dev = gpio_sim_hog_get_device(hog);
 	int dir;
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	if (gpio_sim_device_is_live_unlocked(dev))
 		return -EBUSY;
@@ -1276,7 +1276,7 @@ gpio_sim_line_config_make_hog_item(struct config_group *group, const char *name)
 	if (strcmp(name, "hog") != 0)
 		return ERR_PTR(-EINVAL);
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	hog = kzalloc(sizeof(*hog), GFP_KERNEL);
 	if (!hog)
@@ -1334,7 +1334,7 @@ gpio_sim_bank_config_make_line_group(struct config_group *group,
 	if (ret != 1 || nchar != strlen(name))
 		return ERR_PTR(-EINVAL);
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	if (gpio_sim_device_is_live_unlocked(dev))
 		return ERR_PTR(-EBUSY);
@@ -1387,7 +1387,7 @@ gpio_sim_device_config_make_bank_group(struct config_group *group,
 	struct gpio_sim_device *dev = to_gpio_sim_device(&group->cg_item);
 	struct gpio_sim_bank *bank;
 
-	guard(mutex)(&dev->lock);
+	guard(mutex, &dev->lock);
 
 	if (gpio_sim_device_is_live_unlocked(dev))
 		return ERR_PTR(-EBUSY);
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index e000fa3b9f97..a8954db4cb1c 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -784,7 +784,7 @@ static void hv_online_page(struct page *pg, unsigned int order)
 	struct hv_hotadd_state *has;
 	unsigned long pfn = page_to_pfn(pg);
 
-	guard(spinlock_irqsave)(&dm_device.ha_lock);
+	guard(spinlock_irqsave, &dm_device.ha_lock);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/* The page belongs to a different HAS. */
 		if ((pfn < has->start_pfn) ||
@@ -803,7 +803,7 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 	unsigned long residual, new_inc;
 	int ret = 0;
 
-	guard(spinlock_irqsave)(&dm_device.ha_lock);
+	guard(spinlock_irqsave, &dm_device.ha_lock);
 	list_for_each_entry(has, &dm_device.ha_region_list, list) {
 		/*
 		 * If the pfn range we are dealing with is not in the current
@@ -2068,7 +2068,7 @@ static void balloon_remove(struct hv_device *dev)
 #endif
 	}
 
-	guard(spinlock_irqsave)(&dm_device.ha_lock);
+	guard(spinlock_irqsave, &dm_device.ha_lock);
 	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
 		list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
 			list_del(&gap->list);
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 53f1a7a932b0..1d13792a3d85 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -105,8 +105,8 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, _unlock, ({ _lock; _T; }), _type _T)
 
-#define guard(_name) \
-	CLASS(_name, __UNIQUE_ID(guard))
+#define guard(_name, args...) \
+	CLASS(_name, __UNIQUE_ID(guard))(args)
 
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 802551e0009b..81acd7811db3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1097,7 +1097,7 @@ int get_nohz_timer_target(void)
 
 	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
 
-	guard(rcu)();
+	guard(rcu);
 
 	for_each_domain(cpu, sd) {
 		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
@@ -1827,7 +1827,7 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	int old_min, old_max, old_min_rt;
 	int result;
 
-	guard(mutex)(&uclamp_mutex);
+	guard(mutex, &uclamp_mutex);
 
 	old_min = sysctl_sched_uclamp_util_min;
 	old_max = sysctl_sched_uclamp_util_max;
@@ -3440,8 +3440,8 @@ static int migrate_swap_stop(void *data)
 	src_rq = cpu_rq(arg->src_cpu);
 	dst_rq = cpu_rq(arg->dst_cpu);
 
-	guard(double_raw_spinlock)(&arg->src_task->pi_lock, &arg->dst_task->pi_lock);
-	guard(double_rq_lock)(src_rq, dst_rq);
+	guard(double_raw_spinlock, &arg->src_task->pi_lock, &arg->dst_task->pi_lock);
+	guard(double_rq_lock, src_rq, dst_rq);
 
 	if (task_cpu(arg->dst_task) != arg->dst_cpu)
 		return -EAGAIN;
@@ -3734,7 +3734,7 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 
 		__schedstat_inc(p->stats.nr_wakeups_remote);
 
-		guard(rcu)();
+		guard(rcu);
 		for_each_domain(rq->cpu, sd) {
 			if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
 				__schedstat_inc(sd->ttwu_wake_remote);
@@ -3940,9 +3940,9 @@ void wake_up_if_idle(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	guard(rcu)();
+	guard(rcu);
 	if (is_idle_task(rcu_dereference(rq->curr))) {
-		guard(rq_lock_irqsave)(rq);
+		guard(rq_lock_irqsave, rq);
 		if (is_idle_task(rq->curr))
 			resched_curr(rq);
 	}
@@ -4198,7 +4198,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
  */
 int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
-	guard(preempt)();
+	guard(preempt);
 	int cpu, success = 0;
 
 	if (p == current) {
@@ -5730,7 +5730,7 @@ static void sched_tick_remote(struct work_struct *work)
 	 * of when exactly it is running.
 	 */
 	if (tick_nohz_tick_stopped_cpu(cpu)) {
-		guard(rq_lock_irq)(rq);
+		guard(rq_lock_irq, rq);
 		struct task_struct *curr = rq->curr;
 
 		if (cpu_online(cpu)) {
@@ -6297,8 +6297,8 @@ static bool try_steal_cookie(int this, int that)
 	unsigned long cookie;
 	bool success = false;
 
-	guard(irq)();
-	guard(double_rq_lock)(dst, src);
+	guard(irq);
+	guard(double_rq_lock, dst, src);
 
 	cookie = dst->core->core_cookie;
 	if (!cookie)
@@ -6410,7 +6410,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
 	int t;
 
-	guard(core_lock)(&cpu);
+	guard(core_lock, &cpu);
 
 	WARN_ON_ONCE(rq->core != rq);
 
@@ -6449,7 +6449,7 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
 	int t;
 
-	guard(core_lock)(&cpu);
+	guard(core_lock, &cpu);
 
 	/* if we're the last man standing, nothing to do */
 	if (cpumask_weight(smt_mask) == 1) {
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6f6a5fc85b42..724132f6109e 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2527,8 +2527,8 @@ DEFINE_LOCK_GUARD_0(RCU_SCHED, rcu_read_lock_sched(), rcu_read_unlock_sched())
 static void __maybe_unused inner##_in_##outer(void)				\
 {										\
 	/* Relies the reversed clean-up ordering: inner first */		\
-	guard(outer)(outer_lock);						\
-	guard(inner)(inner_lock);						\
+	guard(outer, outer_lock);						\
+	guard(inner, inner_lock);						\
 }
 
 /*

