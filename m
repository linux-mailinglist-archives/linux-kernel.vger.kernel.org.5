Return-Path: <linux-kernel+bounces-25104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40E382C803
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86398286DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC3E1A70B;
	Fri, 12 Jan 2024 23:37:16 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CFE1A5AE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb53e20a43so5003517b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705102633; x=1705707433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnmSD5dxnU1WwAaH5fLVr5yJ8rSNa8AOKTOrmDoJ578=;
        b=bWJwrS6gGFDsVpdT6FhdgoEzr1yqWUCZpYykovSxDOFmfs9nPw4ZF30mV5XnLPyd1Y
         gm2jqseNPNbH5LpCnhSCeZL7zC8gBBfSJe4aL0NaebnWEMLa+j6qi6mlsRDTB7LM5KI5
         SV62bVyIugxFlztJKxuBzPLsf5ffq4RcdqcpoSq5R24eZhHk+SKMFDuTViIsMILpdgcr
         7Aza5tzKuzMf7Fl7+dI03/khLzaqZzfUp/v6d2fnfIx8JSv1geS+c1fVVhIb4a3iJeqR
         pZYOrx5sk2IXvUXfxoRO55zRynGErFAseYIu8G5EY5iRR8e8LlkGmV8wJV7xesUpoa78
         0L1A==
X-Gm-Message-State: AOJu0YypWSt/s+2e2qN9QyukvCmKjoCMouDcrBsb+MirbxAWY1QrwWvG
	YXzpAQOm7Sa2iUqv6E9S0iE=
X-Google-Smtp-Source: AGHT+IHPXgqSez2R+qOMrb7s54Bb8t+LL2MpfluYLQirkr16IsXNbTUrTocH36DT/iGKlbKL5BO7KQ==
X-Received: by 2002:a05:6808:1306:b0:3bb:cd5d:41b0 with SMTP id y6-20020a056808130600b003bbcd5d41b0mr2106600oiv.73.1705102632870;
        Fri, 12 Jan 2024 15:37:12 -0800 (PST)
Received: from snowbird.lan ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id x5-20020aa793a5000000b006d9b4171b20sm3676811pff.112.2024.01.12.15.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 15:37:12 -0800 (PST)
From: Dennis Zhou <dennis@kernel.org>
To: Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Ye Bin <yebin10@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 1/3] lib/percpu_counter: Fix CPU hotplug handling
Date: Fri, 12 Jan 2024 15:36:46 -0800
Message-Id: <d24c233041035d90c0c2c3685badbcccac57ba2c.1705101789.git.dennis@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1705101789.git.dennis@kernel.org>
References: <cover.1705101789.git.dennis@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") tried to
address a race condition between percpu_counter_sum() and a concurrent CPU
hotplug operation.

The race window is between the point where an un-plugged CPU removed itself
from the online_cpu_mask and the hotplug state callback which folds the per
CPU counters of the now dead CPU into the global count.

percpu_counter_sum() used for_each_online_cpu() to accumulate the per CPU
local counts, so during the race window it missed to account for the not
yet folded back local count of the offlined CPU.

The attempt to address this used the admittedly undocumented and
pointlessly public cpu_dying_mask by changing the loop iterator to take
both the cpu_online_mask and the cpu_dying_mask into account.

That works to some extent, but it is incorrect.

The cpu_dying_mask bits are sticky even after cpu_up()/cpu_down()
completes. That means that all offlined CPUs are always taken into
account. In the case of disabling SMT at boottime or runtime this results
in evaluating _all_ offlined SMT siblings counters forever.  Depending on
system size, that's a massive amount of cache-lines to be touched forever.

It might be argued, that the cpu_dying_mask bit could be cleared when
cpu_down() completes, but that's not possible under all circumstances.

Especially with partial hotplug the bit must be sticky in order to keep the
initial user, i.e. the scheduler correct. Partial hotplug which allows
explicit state transitions also can create a situation where the race
window gets recreated:

       cpu_down(target = CPUHP_PERCPU_CNT_DEAD + 1)

brings a CPU down to one state before the per CPU counter folding
callback. As this did not reach CPUHP_OFFLINE state the bit would stay set.
Now the next partial operation:

       cpu_up(target = CPUHP_PERCPU_CNT_DEAD + 2)

has to clear the bit and the race window is open again.

There are two ways to solve this:

  1) Maintain a local CPU mask in the per CPU counter code which
     gets the bit set when a CPU comes online and removed in the
     the CPUHP_PERCPU_CNT_DEAD state after folding.

     This adds more code and complexity.

  2) Move the folding hotplug state into the DYING callback section, which
     runs on the outgoing CPU immediatedly after it cleared its online bit.

     There is no concurrency vs. percpu_counter_sum() on another CPU
     because all still online CPUs are waiting in stop_machine() for the
     outgoing CPU to complete its shutdown. The raw spinlock held around
     the CPU mask iteration prevents that an online CPU reaches the stop
     machine thread while iterating, which implicitely prevents the
     outgoing CPU from clearing its online bit.

     This is way simpler than #1 and makes the hotplug calls symmetric for
     the price of a slightly longer wait time in stop_machine(), which is
     not the end of the world as CPU un-plug is already slow. The overall
     time for a cpu_down() operation stays exactly the same.

Implement #2 and plug the race completely.

percpu_counter_sum() is still inherently racy against a concurrent
percpu_counter_add_batch() fastpath unless externally serialized.  That's
completely independent of CPU hotplug though.

Fixes: 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[Dennis: Ported to v6.7-rc4. Updated percpu_counter.c for batch
 percpu_counter creation and _percpu_counter_limited_add().]
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 include/linux/cpuhotplug.h |  2 +-
 lib/percpu_counter.c       | 65 ++++++++++++++++----------------------
 2 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index efc0c0b07efb..1e11f3193398 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -90,7 +90,6 @@ enum cpuhp_state {
 	CPUHP_FS_BUFF_DEAD,
 	CPUHP_PRINTK_DEAD,
 	CPUHP_MM_MEMCQ_DEAD,
-	CPUHP_PERCPU_CNT_DEAD,
 	CPUHP_RADIX_DEAD,
 	CPUHP_PAGE_ALLOC,
 	CPUHP_NET_DEV_DEAD,
@@ -198,6 +197,7 @@ enum cpuhp_state {
 	CPUHP_AP_HRTIMERS_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
+	CPUHP_AP_PERCPU_COUNTER_STARTING,
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
 
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 44dd133594d4..6a1354661378 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -12,7 +12,7 @@
 
 #ifdef CONFIG_HOTPLUG_CPU
 static LIST_HEAD(percpu_counters);
-static DEFINE_SPINLOCK(percpu_counters_lock);
+static DEFINE_RAW_SPINLOCK(percpu_counters_lock);
 #endif
 
 #ifdef CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER
@@ -126,13 +126,8 @@ EXPORT_SYMBOL(percpu_counter_sync);
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive().
  *
- * We use the cpu mask of (cpu_online_mask | cpu_dying_mask) to capture sums
- * from CPUs that are in the process of being taken offline. Dying cpus have
- * been removed from the online mask, but may not have had the hotplug dead
- * notifier called to fold the percpu count back into the global counter sum.
- * By including dying CPUs in the iteration mask, we avoid this race condition
- * so __percpu_counter_sum() just does the right thing when CPUs are being taken
- * offline.
+ * Note: This function is inherently racy against the lockless fastpath of
+ * percpu_counter_add_batch() unless externaly serialized.
  */
 s64 __percpu_counter_sum(struct percpu_counter *fbc)
 {
@@ -142,10 +137,8 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
 
 	raw_spin_lock_irqsave(&fbc->lock, flags);
 	ret = fbc->count;
-	for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
-		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
-		ret += *pcount;
-	}
+	for_each_online_cpu(cpu)
+		ret += *per_cpu_ptr(fbc->counters, cpu);
 	raw_spin_unlock_irqrestore(&fbc->lock, flags);
 	return ret;
 }
@@ -181,10 +174,10 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
 	}
 
 #ifdef CONFIG_HOTPLUG_CPU
-	spin_lock_irqsave(&percpu_counters_lock, flags);
+	raw_spin_lock_irqsave(&percpu_counters_lock, flags);
 	for (i = 0; i < nr_counters; i++)
 		list_add(&fbc[i].list, &percpu_counters);
-	spin_unlock_irqrestore(&percpu_counters_lock, flags);
+	raw_spin_unlock_irqrestore(&percpu_counters_lock, flags);
 #endif
 	return 0;
 }
@@ -205,10 +198,10 @@ void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 nr_counters)
 		debug_percpu_counter_deactivate(&fbc[i]);
 
 #ifdef CONFIG_HOTPLUG_CPU
-	spin_lock_irqsave(&percpu_counters_lock, flags);
+	raw_spin_lock_irqsave(&percpu_counters_lock, flags);
 	for (i = 0; i < nr_counters; i++)
 		list_del(&fbc[i].list);
-	spin_unlock_irqrestore(&percpu_counters_lock, flags);
+	raw_spin_unlock_irqrestore(&percpu_counters_lock, flags);
 #endif
 
 	free_percpu(fbc[0].counters);
@@ -221,22 +214,29 @@ EXPORT_SYMBOL(percpu_counter_destroy_many);
 int percpu_counter_batch __read_mostly = 32;
 EXPORT_SYMBOL(percpu_counter_batch);
 
-static int compute_batch_value(unsigned int cpu)
+static void compute_batch_value(int offs)
 {
-	int nr = num_online_cpus();
+	int nr = num_online_cpus() + offs;
 
-	percpu_counter_batch = max(32, nr*2);
+	percpu_counter_batch = max(32, nr * 2);
+}
+
+static int percpu_counter_cpu_starting(unsigned int cpu)
+{
+	/* If invoked during hotplug @cpu is not yet marked online. */
+	compute_batch_value(cpu_online(cpu) ? 0 : 1);
 	return 0;
 }
 
-static int percpu_counter_cpu_dead(unsigned int cpu)
+static int percpu_counter_cpu_dying(unsigned int cpu)
 {
 #ifdef CONFIG_HOTPLUG_CPU
 	struct percpu_counter *fbc;
+	unsigned long flags;
 
-	compute_batch_value(cpu);
+	compute_batch_value(0);
 
-	spin_lock_irq(&percpu_counters_lock);
+	raw_spin_lock_irqsave(&percpu_counters_lock, flags);
 	list_for_each_entry(fbc, &percpu_counters, list) {
 		s32 *pcount;
 
@@ -246,7 +246,7 @@ static int percpu_counter_cpu_dead(unsigned int cpu)
 		*pcount = 0;
 		raw_spin_unlock(&fbc->lock);
 	}
-	spin_unlock_irq(&percpu_counters_lock);
+	raw_spin_unlock_irqrestore(&percpu_counters_lock, flags);
 #endif
 	return 0;
 }
@@ -331,13 +331,11 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 	}
 
 	if (!good) {
-		s32 *pcount;
 		int cpu;
 
-		for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
-			pcount = per_cpu_ptr(fbc->counters, cpu);
-			count += *pcount;
-		}
+		for_each_online_cpu(cpu)
+			count += *per_cpu_ptr(fbc->counters, cpu);
+
 		if (amount > 0) {
 			if (count > limit)
 				goto out;
@@ -359,15 +357,8 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 
 static int __init percpu_counter_startup(void)
 {
-	int ret;
-
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "lib/percpu_cnt:online",
-				compute_batch_value, NULL);
-	WARN_ON(ret < 0);
-	ret = cpuhp_setup_state_nocalls(CPUHP_PERCPU_CNT_DEAD,
-					"lib/percpu_cnt:dead", NULL,
-					percpu_counter_cpu_dead);
-	WARN_ON(ret < 0);
+	WARN_ON(cpuhp_setup_state(CPUHP_AP_PERCPU_COUNTER_STARTING, "lib/percpu_counter:starting",
+				  percpu_counter_cpu_starting, percpu_counter_cpu_dying));
 	return 0;
 }
 module_init(percpu_counter_startup);
-- 
2.39.1


