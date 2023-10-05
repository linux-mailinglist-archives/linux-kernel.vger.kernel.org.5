Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800577BA622
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjJEQ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbjJEQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:23:40 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026506098
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:17:38 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-352753fb42eso5139135ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696522657; x=1697127457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh8XUEMAE5d54Nrxpyy2HmngsV1jZcKsRa1rZEBsG8Y=;
        b=p2T3uLy1NjgJjotCR5fTJca7vigzQZFGgK8+7HjcgkYocVhbKeV5rui3N8E4uyNa3r
         XV+Yl8+VJRdHZiXOw0BDMV3Qph7BWz9fZEtDXK8E7Sah2CcLNO7myeE+55u9nEOHiA28
         9T5HZnTcAKjNDBK1tK2W06Vhe0EA+ZdVPLr1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522657; x=1697127457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qh8XUEMAE5d54Nrxpyy2HmngsV1jZcKsRa1rZEBsG8Y=;
        b=B2zQKPfJ8u6wTppVrtxp4hiZLsVrSsehQprv+5vfFXitArHEbdZ5w9IH2+8PjWK5qE
         OzXYlL1C0AdsnS3jz/PjB3bXbBYhJvwpwYpKe7zLYgTR4hws/8B7Cmuc1XdI6iq/KcVa
         Kvb87HBNFYmed559Vd0G4QzeSAEKtSprdsaw/TuNi5SAvhwZvMXpb/QBECDf4Vl0vg79
         gi1opIL40uFeq5Ncw1yCcdKCjIiw+ynH46dVVXRlLh7ncrnxmUzIyP2uqXaomYkETBdT
         TZNEmChRgCdLJpx08UGe5IqvfHTMrQzQHDUA07R6rpjVW20xJNQ/wZ1V59n9SfrqZGaZ
         j1Vw==
X-Gm-Message-State: AOJu0YwmS/z3Pler1NUfjeyF9sF+oJhfJ3/IR/cVEu28JXWR24MKcx6E
        2mP+B59Oyua3qVjGdxvc6psh3Cgtgpgj82iTcHg=
X-Google-Smtp-Source: AGHT+IHwEOrGhgvaWHegD4AQalEF5F8YwA1QpK5buHGRmqiokzsqzsBCbeKyG3p8uRewGc2HDVfYug==
X-Received: by 2002:a05:6e02:2143:b0:351:4b68:ec3b with SMTP id d3-20020a056e02214300b003514b68ec3bmr7099750ilv.10.1696522657564;
        Thu, 05 Oct 2023 09:17:37 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id a18-20020a927f12000000b0034aa175c9c3sm494294ild.87.2023.10.05.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:17:36 -0700 (PDT)
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
Cc:     Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
Date:   Thu,  5 Oct 2023 16:17:26 +0000
Message-ID: <20231005161727.1855004-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <vineethrp@google.com>

Whenever a CPU stops its tick, it now requires another idle CPU to handle the
balancing for it because it can't perform its own periodic load balancing.
This means it might need to update 'nohz.next_balance' to 'rq->next_balance' if
the upcoming nohz-idle load balancing is too distant in the future. This update
process is done by triggering an ILB, as the general ILB handler
(_nohz_idle_balance) that manages regular nohz balancing also refreshes
'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle CPUs
and selecting the smallest value.

Triggering this ILB can be achieved by setting the NOHZ_NEXT_KICK flag. This
primarily results in the ILB handler updating 'nohz.next_balance' while
possibly not doing any load balancing at all. However, sending an IPI merely to
refresh 'nohz.next_balance' seems excessive, and there ought to be a more
efficient method to update 'nohz.next_balance' from the local CPU.

Fortunately, there already exists a mechanism to directly invoke the ILB
handler (_nohz_idle_balance) without initiating an IPI. It's accomplished by
setting the NOHZ_NEWILB_KICK flag. This flag is set during regular "newly idle"
balancing and solely exists to update a CPU's blocked load if it couldn't pull
more tasks during regular "newly idle balancing" - and it does so without
having to send any IPIs. Once the flag is set, the ILB handler is called
directly from do_idle()-> nohz_run_idle_balance(). While its goal is to update
the blocked load without an IPI, in our situation, we aim to refresh
'nohz.next_balance' without an IPI but we can piggy back on this.

So in this patch, we reuse this mechanism by also setting the NOHZ_NEXT_KICK to
indicate nohz.next_balance needs an update via this direct call shortcut. Note
that we set this flag without knowledge that the tick is about to be stopped,
because at the point we do it, we have no way of knowing that. However we do
know that the CPU is about to enter idle. In our testing, the reduction in IPIs
is well worth updating nohz.next_balance a few more times.

Also just to note, without this patch we observe the following pattern:

1. A CPU is about to stop its tick.
2. It sets nohz.needs_update to 1.
3. It then stops its tick and goes idle.
4. The scheduler tick on another CPU checks this flag and decides an ILB kick is needed.
5. The ILB CPU ends up being the one that just stopped its tick!
6. This results in an IPI to the tick-stopped CPU which ends up waking it up
   and disturbing it!

Testing shows a considerable reduction in IPIs when doing this:

Running "cyclictest -i 100 -d 100 --latency=1000 -t -m" on a 4vcpu VM
the IPI call count profiled over 10s period is as follows:
without fix: ~10500
with fix: ~1000

Fixes: 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")

[ Joel: wrote commit messages, collaborated on fix, helped reproduce issue etc. ]

Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Hsin Yi <hsinyi@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Vineeth Pillai <vineethrp@google.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/fair.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cb225921bbca..2ece55f32782 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11786,13 +11786,12 @@ void nohz_balance_enter_idle(int cpu)
 	/*
 	 * Ensures that if nohz_idle_balance() fails to observe our
 	 * @idle_cpus_mask store, it must observe the @has_blocked
-	 * and @needs_update stores.
+	 * stores.
 	 */
 	smp_mb__after_atomic();
 
 	set_cpu_sd_state_idle(cpu);
 
-	WRITE_ONCE(nohz.needs_update, 1);
 out:
 	/*
 	 * Each time a cpu enter idle, we assume that it has blocked load and
@@ -11945,21 +11944,25 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 }
 
 /*
- * Check if we need to run the ILB for updating blocked load before entering
- * idle state.
+ * Check if we need to run the ILB for updating blocked load and/or updating
+ * nohz.next_balance before entering idle state.
  */
 void nohz_run_idle_balance(int cpu)
 {
 	unsigned int flags;
 
-	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
+	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK | NOHZ_NEXT_KICK, nohz_flags(cpu));
+
+	if (!flags)
+		return;
 
 	/*
 	 * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
 	 * (ie NOHZ_STATS_KICK set) and will do the same.
 	 */
-	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
-		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
+	if ((flags == (flags & (NOHZ_NEXT_KICK | NOHZ_NEWILB_KICK))) &&
+	    !need_resched())
+		_nohz_idle_balance(cpu_rq(cpu), flags);
 }
 
 static void nohz_newidle_balance(struct rq *this_rq)
@@ -11977,6 +11980,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	if (this_rq->avg_idle < sysctl_sched_migration_cost)
 		return;
 
+	/* If rq->next_balance before nohz.next_balance, trigger ILB */
+	if (time_before(this_rq->next_balance, READ_ONCE(nohz.next_balance)))
+		atomic_or(NOHZ_NEXT_KICK, nohz_flags(this_cpu));
+
 	/* Don't need to update blocked load of idle CPUs*/
 	if (!READ_ONCE(nohz.has_blocked) ||
 	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
-- 
2.42.0.609.gbb76f46606-goog

