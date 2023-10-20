Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D217D0632
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346793AbjJTBkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346767AbjJTBko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:40:44 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B945114
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:40:42 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35135b79b6aso1114165ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1697766041; x=1698370841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nR2o8TcR34USlB3A1w+r6NomFEotH136iyhtq4t1qlA=;
        b=NqYlplqs+/Z7j2ad/reXxwB7OpvGEhEeb3bUywE/dhBGdk9ViE0NuD1Jhz93p1TQoS
         WAS/kE3F+uPCi8lnYWfYiokYBWR3WNoSGin3QKMp5nntr20xaj4XRI0pWwAM3ZA09kDX
         yHlOezGreQU7kU42tZQp7OW2rCnt+3c51Ey3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697766041; x=1698370841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nR2o8TcR34USlB3A1w+r6NomFEotH136iyhtq4t1qlA=;
        b=rFVyBQVQzLnJzVZV/s2YFijaGayxUZj7eJFAD7pjORy8RnzUXQTdxfK5J8rylCSu+J
         M25ysmJyY228qZn075DKTPILKTB5Q3fdniGFKqxM2OXBH9QEwt1mp3lV+Rewhs+hFoGo
         XKXuJq9DzwrB8S22PhG3x6mK64eU4OCgiQiAr3ZztzzRXmBN2AhVmc8CmRExq5pELbUc
         Q7EuZW6g2eY/B6Km+9atNH495ba01R6DsebXrfBJ4AhLgNyFO/JBSfHn+tWhZPp1Z7cx
         ta8sUAyuyqkFwKzrP2d+IiQMDfiXIGVPhl5Umdkm4e9Tn+HtGK44Gt9gDokQGJdFjCyz
         lbXg==
X-Gm-Message-State: AOJu0YwzeUmrwNrkIjMWJURNd4fYe29HbTlMLm/hf94KUsImrbAw/AGe
        WTAsvxGU4BvPW+lM5Zb7MTXRn1jxuu6UjOh7lf1tuQ==
X-Google-Smtp-Source: AGHT+IEFL3VshgWVLNYvBB6sehYwUkAOVjePWjPzAlmKavKU3GZKQtZUuoN/L5xLKoXDKyyBFTUvmg==
X-Received: by 2002:a92:c906:0:b0:34f:77bc:8d49 with SMTP id t6-20020a92c906000000b0034f77bc8d49mr683100ilp.23.1697766041302;
        Thu, 19 Oct 2023 18:40:41 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id h9-20020a056e020d4900b00350f5584876sm270394ilj.27.2023.10.19.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 18:40:40 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: [PATCH 1/3] sched/nohz: Update nohz.next_balance directly without IPIs (v2)
Date:   Fri, 20 Oct 2023 01:40:26 +0000
Message-ID: <20231020014031.919742-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever a CPU stops its tick, it now requires another idle CPU to handle the
balancing for it because it can't perform its own periodic load balancing.
This means it might need to update 'nohz.next_balance' to 'rq->next_balance' if
the upcoming nohz-idle load balancing is too distant in the future. This update
process is done by triggering an ILB, as the general ILB handler
(_nohz_idle_balance) that manages regular nohz balancing also refreshes
'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle CPUs
and selecting the smallest value.

Triggering this ILB is achieved in current mainline by setting the
NOHZ_NEXT_KICK flag. This primarily results in the ILB handler updating
'nohz.next_balance' while possibly not doing any load balancing at all.
However, sending an IPI merely to refresh 'nohz.next_balance' seems
excessive. This patch therefore directly sets nohz.next_balance from the
CPU stopping the tick.

Testing shows a considerable reduction in IPIs when doing this:

Running "cyclictest -i 100 -d 100 --latency=1000 -t -m" on a 4vcpu VM
the IPI call count profiled over 10s period is as follows:
without fix: ~10500
with fix: ~1000

Also just to note, without this patch we observe the following pattern:

1. A CPU is about to stop its tick.
2. It sets nohz.needs_update to 1.
3. It then stops its tick and goes idle.
4. The scheduler tick on another CPU checks this flag and decides an ILB kick
   is needed.
5. The ILB CPU ends up being the one that just stopped its tick!
6. This results in an IPI to the tick-stopped CPU which ends up waking it up
   and disturbing it!

Finally, this patch also avoids having to go through all the idle CPUs
just to update nohz.next_balance when the tick is stopped.

Previous version of patch had some issues which are addressed now:
https://lore.kernel.org/all/20231005161727.1855004-1-joel@joelfernandes.org/

Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")
Co-developed-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/fair.c  | 44 +++++++++++++++++++++++++++++---------------
 kernel/sched/sched.h |  5 +----
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cb225921bbca..965c30fbbe5c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6627,7 +6627,6 @@ static struct {
 	cpumask_var_t idle_cpus_mask;
 	atomic_t nr_cpus;
 	int has_blocked;		/* Idle CPUS has blocked load */
-	int needs_update;		/* Newly idle CPUs need their next_balance collated */
 	unsigned long next_balance;     /* in jiffy units */
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
 } nohz ____cacheline_aligned;
@@ -11687,9 +11686,6 @@ static void nohz_balancer_kick(struct rq *rq)
 unlock:
 	rcu_read_unlock();
 out:
-	if (READ_ONCE(nohz.needs_update))
-		flags |= NOHZ_NEXT_KICK;
-
 	if (flags)
 		kick_ilb(flags);
 }
@@ -11740,6 +11736,20 @@ static void set_cpu_sd_state_idle(int cpu)
 	rcu_read_unlock();
 }
 
+static inline void
+update_nohz_next_balance(unsigned long next_balance)
+{
+	unsigned long nohz_next_balance;
+
+	/* In event of a race, only update with the earliest next_balance. */
+	do {
+		nohz_next_balance = READ_ONCE(nohz.next_balance);
+		if (!time_after(nohz_next_balance, next_balance))
+			break;
+	} while (!try_cmpxchg(&nohz.next_balance, &nohz_next_balance,
+			     next_balance));
+}
+
 /*
  * This routine will record that the CPU is going idle with tick stopped.
  * This info will be used in performing idle load balancing in the future.
@@ -11786,13 +11796,13 @@ void nohz_balance_enter_idle(int cpu)
 	/*
 	 * Ensures that if nohz_idle_balance() fails to observe our
 	 * @idle_cpus_mask store, it must observe the @has_blocked
-	 * and @needs_update stores.
+	 * store.
 	 */
 	smp_mb__after_atomic();
 
 	set_cpu_sd_state_idle(cpu);
 
-	WRITE_ONCE(nohz.needs_update, 1);
+	update_nohz_next_balance(rq->next_balance);
 out:
 	/*
 	 * Each time a cpu enter idle, we assume that it has blocked load and
@@ -11829,6 +11839,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
 	unsigned long next_balance = now + 60*HZ;
+	unsigned long old_nohz_next_balance;
 	bool has_blocked_load = false;
 	int update_next_balance = 0;
 	int this_cpu = this_rq->cpu;
@@ -11837,6 +11848,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 
 	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
 
+	old_nohz_next_balance = READ_ONCE(nohz.next_balance);
+
 	/*
 	 * We assume there will be no idle load after this update and clear
 	 * the has_blocked flag. If a cpu enters idle in the mean time, it will
@@ -11844,13 +11857,9 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
 	 * setting the flag, we are sure to not clear the state and not
 	 * check the load of an idle cpu.
-	 *
-	 * Same applies to idle_cpus_mask vs needs_update.
 	 */
 	if (flags & NOHZ_STATS_KICK)
 		WRITE_ONCE(nohz.has_blocked, 0);
-	if (flags & NOHZ_NEXT_KICK)
-		WRITE_ONCE(nohz.needs_update, 0);
 
 	/*
 	 * Ensures that if we miss the CPU, we must see the has_blocked
@@ -11874,8 +11883,6 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 		if (need_resched()) {
 			if (flags & NOHZ_STATS_KICK)
 				has_blocked_load = true;
-			if (flags & NOHZ_NEXT_KICK)
-				WRITE_ONCE(nohz.needs_update, 1);
 			goto abort;
 		}
 
@@ -11906,12 +11913,19 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 	}
 
 	/*
-	 * next_balance will be updated only when there is a need.
+	 * nohz.next_balance will be updated only when there is a need.
 	 * When the CPU is attached to null domain for ex, it will not be
 	 * updated.
+	 *
+	 * Also, if it changed since we scanned the nohz CPUs above, do nothing as:
+	 * 1. A concurrent call to _nohz_idle_balance() moved nohz.next_balance forward.
+	 * 2. nohz_balance_enter_idle moved it backward.
 	 */
-	if (likely(update_next_balance))
-		nohz.next_balance = next_balance;
+	if (likely(update_next_balance)) {
+		/* Pairs with the smp_mb() above. */
+		cmpxchg_release(&nohz.next_balance, old_nohz_next_balance,
+				next_balance);
+	}
 
 	if (flags & NOHZ_STATS_KICK)
 		WRITE_ONCE(nohz.next_blocked,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04846272409c..cf3597d91977 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2874,7 +2874,6 @@ extern void cfs_bandwidth_usage_dec(void);
 #define NOHZ_BALANCE_KICK_BIT	0
 #define NOHZ_STATS_KICK_BIT	1
 #define NOHZ_NEWILB_KICK_BIT	2
-#define NOHZ_NEXT_KICK_BIT	3
 
 /* Run rebalance_domains() */
 #define NOHZ_BALANCE_KICK	BIT(NOHZ_BALANCE_KICK_BIT)
@@ -2882,10 +2881,8 @@ extern void cfs_bandwidth_usage_dec(void);
 #define NOHZ_STATS_KICK		BIT(NOHZ_STATS_KICK_BIT)
 /* Update blocked load when entering idle */
 #define NOHZ_NEWILB_KICK	BIT(NOHZ_NEWILB_KICK_BIT)
-/* Update nohz.next_balance */
-#define NOHZ_NEXT_KICK		BIT(NOHZ_NEXT_KICK_BIT)
 
-#define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK | NOHZ_NEXT_KICK)
+#define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK)
 
 #define nohz_flags(cpu)	(&cpu_rq(cpu)->nohz_flags)
 
-- 
2.42.0.655.g421f12c284-goog

