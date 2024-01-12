Return-Path: <linux-kernel+bounces-25106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04A82C805
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7380D286EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEC91B591;
	Fri, 12 Jan 2024 23:37:18 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5541A714
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9344f30caso4792811b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705102636; x=1705707436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifDoLpiNdOYTSQ47Pl1LromjALktxWcq8aIySdxMVro=;
        b=oy7aepg2JAjPAuMBeruOXYc8EChDDoFPz2AKad2TUGKL+5z43gN6Q86mN3kur6CaDY
         tJ0qTKr6iXP6ImeX2Ru4QxGGJbKTA2x4wJqYbyH5vgdzVqgQjcebdQutwLN0Sic6DOkQ
         XAz+514ITvMtP27BrWL7FgKMhIihICdNADbmaFUweJD1eo36Jdx2BJoo610V69f1XUeI
         N8NqYtTc+Za81zqJCI4u7RsUeht1/O1eBASYnNuIeLdfrhkwN+TrwfmWixihHBqqirmF
         5Zw3qJ4Mx+bFav/aNvXYM0Visi4o8P772pPVotEfj8xwsVBgzGsJBvf2JEka0YV4SnCX
         mwLA==
X-Gm-Message-State: AOJu0Yz+FDV4OwsIk/ohPNRZ8WZqltZw/Oyj8t5ZBXVPr7b2ntpb2xn2
	/sOAI+UuBsYTnv5O2RpBgps=
X-Google-Smtp-Source: AGHT+IETOzry7t2QrGyMY0qVE9zN8YF+Pj/G2WT9Tg51W3pV2fUxP0YtB8ryO5YxL+RNGUaJMSnd/Q==
X-Received: by 2002:a05:6a00:1822:b0:6da:56c:1019 with SMTP id y34-20020a056a00182200b006da056c1019mr2564523pfa.3.1705102636149;
        Fri, 12 Jan 2024 15:37:16 -0800 (PST)
Received: from snowbird.lan ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id x5-20020aa793a5000000b006d9b4171b20sm3676811pff.112.2024.01.12.15.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 15:37:15 -0800 (PST)
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
Subject: [PATCH 3/3] cpu/hotplug: Get rid of cpu_dying_mask
Date: Fri, 12 Jan 2024 15:36:48 -0800
Message-Id: <4aeddaa133df7c0b7795b7774d2222efedc3aa12.1705101789.git.dennis@kernel.org>
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

The cpu_dying_mask is not only undocumented but also to some extent a
misnomer. It's purpose is to capture the last direction of a cpu_up() or
cpu_down() operation taking eventual rollback operations into account.  The
name and the lack of documentation lured already someone to use it in the
wrong way.

The initial user is the scheduler code which needs to keep the decision
correct whether to schedule tasks on a CPU, which is between the
CPUHP_ONLINE and the CPUHP_ACTIVE state and has the balance_push() hook
installed.

cpu_dying mask is not really useful for general consumption. The
cpu_dying_mask bits are sticky even after cpu_up() or cpu_down()
completes.

It might be argued, that the cpu_dying_mask bit could be cleared when
cpu_down() completes, but that's not possible under all circumstances.

Especially not with partial hotplug operations. In that case the bit must
be sticky in order to keep the initial user, i.e. the scheduler correct.

Replace the cpumask completely by:

  - recording the direction internally in the CPU hotplug core state

  - exposing that state via a documented function to the scheduler

After that cpu_dying_mask is not longer in use and removed before the next
user trips over it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[Dennis: ported to v6.7-rc4, delete in cpumask.h didn't apply cleanly]
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 include/linux/cpumask.h | 21 --------------------
 kernel/cpu.c            | 43 +++++++++++++++++++++++++++++++++++------
 kernel/sched/core.c     |  4 ++--
 kernel/smpboot.h        |  2 ++
 4 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..b19b6fd29a0d 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -126,12 +126,10 @@ extern struct cpumask __cpu_possible_mask;
 extern struct cpumask __cpu_online_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
-extern struct cpumask __cpu_dying_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
-#define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
 
 extern atomic_t __num_online_cpus;
 
@@ -1035,15 +1033,6 @@ set_cpu_active(unsigned int cpu, bool active)
 		cpumask_clear_cpu(cpu, &__cpu_active_mask);
 }
 
-static inline void
-set_cpu_dying(unsigned int cpu, bool dying)
-{
-	if (dying)
-		cpumask_set_cpu(cpu, &__cpu_dying_mask);
-	else
-		cpumask_clear_cpu(cpu, &__cpu_dying_mask);
-}
-
 /**
  * to_cpumask - convert a NR_CPUS bitmap to a struct cpumask *
  * @bitmap: the bitmap
@@ -1119,11 +1108,6 @@ static inline bool cpu_active(unsigned int cpu)
 	return cpumask_test_cpu(cpu, cpu_active_mask);
 }
 
-static inline bool cpu_dying(unsigned int cpu)
-{
-	return cpumask_test_cpu(cpu, cpu_dying_mask);
-}
-
 #else
 
 #define num_online_cpus()	1U
@@ -1151,11 +1135,6 @@ static inline bool cpu_active(unsigned int cpu)
 	return cpu == 0;
 }
 
-static inline bool cpu_dying(unsigned int cpu)
-{
-	return false;
-}
-
 #endif /* NR_CPUS > 1 */
 
 #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
diff --git a/kernel/cpu.c b/kernel/cpu.c
index c4929e9cd9be..ce78757b7535 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -54,6 +54,9 @@
  * @rollback:	Perform a rollback
  * @single:	Single callback invocation
  * @bringup:	Single callback bringup or teardown selector
+ * @goes_down:	Indicator for direction of cpu_up()/cpu_down() operations
+ *		including eventual rollbacks. Not affected by state or
+ *		instance add/remove operations. See cpuhp_cpu_goes_down().
  * @cpu:	CPU number
  * @node:	Remote CPU node; for multi-instance, do a
  *		single entry callback for install/remove
@@ -74,6 +77,7 @@ struct cpuhp_cpu_state {
 	bool			rollback;
 	bool			single;
 	bool			bringup;
+	bool			goes_down;
 	struct hlist_node	*node;
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
@@ -474,6 +478,37 @@ void cpu_maps_update_done(void)
 	mutex_unlock(&cpu_add_remove_lock);
 }
 
+/**
+ * cpuhp_cpu_goes_down - Query the current/last CPU hotplug direction of a CPU
+ * @cpu:	The CPU to query
+ *
+ * The direction indicator is modified by the hotplug core on
+ * cpu_up()/cpu_down() operations including eventual rollback operations.
+ * The indicator is not affected by state or instance install/remove
+ * operations.
+ *
+ * The indicator is sticky after the hotplug operation completes, whether
+ * the operation was a full up/down or just a partial bringup/teardown.
+ *
+ *				goes_down
+ *   cpu_up(target) enter	-> False
+ *	rollback on fail	-> True
+ *   cpu_up(target) exit	Last state
+ *
+ *   cpu_down(target) enter	-> True
+ *	rollback on fail	-> False
+ *   cpu_down(target) exit	Last state
+ *
+ * The return value is a racy snapshot and not protected against concurrent
+ * CPU hotplug operations which modify the indicator.
+ *
+ * Returns: True if cached direction is down, false otherwise
+ */
+bool cpuhp_cpu_goes_down(unsigned int cpu)
+{
+	return data_race(per_cpu(cpuhp_state.goes_down, cpu));
+}
+
 /*
  * If set, cpu_up and cpu_down will return -EBUSY and do nothing.
  * Should always be manipulated under cpu_add_remove_lock
@@ -708,8 +743,7 @@ cpuhp_set_state(int cpu, struct cpuhp_cpu_state *st, enum cpuhp_state target)
 	st->target = target;
 	st->single = false;
 	st->bringup = bringup;
-	if (cpu_dying(cpu) != !bringup)
-		set_cpu_dying(cpu, !bringup);
+	st->goes_down = !bringup;
 
 	return prev_state;
 }
@@ -743,8 +777,7 @@ cpuhp_reset_state(int cpu, struct cpuhp_cpu_state *st,
 	}
 
 	st->bringup = bringup;
-	if (cpu_dying(cpu) != !bringup)
-		set_cpu_dying(cpu, !bringup);
+	st->goes_down = !bringup;
 }
 
 /* Regular hotplug invocation of the AP hotplug thread */
@@ -3127,8 +3160,6 @@ EXPORT_SYMBOL(__cpu_present_mask);
 
 struct cpumask __cpu_active_mask __read_mostly;
 
-struct cpumask __cpu_dying_mask __read_mostly;
-
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e..6d4f0cdad446 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2468,7 +2468,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 		return cpu_online(cpu);
 
 	/* Regular kernel threads don't get to stay during offline. */
-	if (cpu_dying(cpu))
+	if (cpuhp_cpu_goes_down(cpu))
 		return false;
 
 	/* But are allowed during online. */
@@ -9434,7 +9434,7 @@ static void balance_push(struct rq *rq)
 	 * Only active while going offline and when invoked on the outgoing
 	 * CPU.
 	 */
-	if (!cpu_dying(rq->cpu) || rq != this_rq())
+	if (!cpuhp_cpu_goes_down(rq->cpu) || rq != this_rq())
 		return;
 
 	/*
diff --git a/kernel/smpboot.h b/kernel/smpboot.h
index 34dd3d7ba40b..9d3b4d554411 100644
--- a/kernel/smpboot.h
+++ b/kernel/smpboot.h
@@ -20,4 +20,6 @@ int smpboot_unpark_threads(unsigned int cpu);
 
 void __init cpuhp_threads_init(void);
 
+bool cpuhp_cpu_goes_down(unsigned int cpu);
+
 #endif
-- 
2.39.1


