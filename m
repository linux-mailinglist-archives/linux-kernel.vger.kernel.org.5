Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030CC7D0FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377297AbjJTMbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377175AbjJTMbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:31:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E37FD49;
        Fri, 20 Oct 2023 05:31:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3265FC433C8;
        Fri, 20 Oct 2023 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697805076;
        bh=TnUgXdqyGtzm8E1Kiu/VhELFbSOgtUP7stBuM+IFdbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N23TIUJ50sdcWqGuvqgGgxOoWMcPoC5Pq+hCwlWiyIVRvsS8bioPRqK8R8+KbmmHj
         gNldSrh5NACFIiv34hQjzNoAowwu3qZbggcJS1A9N2/ylAG2emIzf+biLPqX3AcPrx
         vAB8bzguJ3uOdElGCHnHuLqLwTMAXtZ5JNhqhbtD4VgYvZ2m4P3IX5KBsHtL6sj1cR
         wNA1qggl//7dWMWzkJAncnI/6kjl7hZ+2dGySIWbKEczuNc2x6CRmAv/1dPsIYNMvP
         fv+T4KIq6qsv0i3ipnvRstP70fZiBfEHbA6NgKGV3fvsigZldyKPFGYFuiiAVhWgsD
         1KSHNgLEBQC8g==
Date:   Fri, 20 Oct 2023 14:31:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/4] Revert "kernel/sched: Modify initial boot task idle
 setup"
Message-ID: <ZTJzEVkVfSMGumWU@lothringen>
References: <20231019233543.1243121-1-frederic@kernel.org>
 <20231019233543.1243121-5-frederic@kernel.org>
 <20231020082531.GS33217@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020082531.GS33217@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:25:31AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 20, 2023 at 01:35:43AM +0200, Frederic Weisbecker wrote:
> > Now that rcutiny can deal with early boot PF_IDLE setting, revert
> > commit cff9b2332ab762b7e0586c793c431a8f2ea4db04.
> > 
> > This fixes several subtle issues introduced on RCU-tasks(-trace):
> > 
> > 1) RCU-tasks stalls when:
> > 
> >    1.1 Grace period is started before init/0 had a chance to set PF_IDLE,
> >        keeping it stuck in the holdout list until idle ever schedules.
> > 
> >    1.2 Grace period is started when some possible CPUs have never been
> >        online, keeping their idle tasks stuck in the holdout list until
> >        the CPU ever boots up.
> > 
> >    1.3 Similar to 1.1 but with secondary CPUs: Grace period is started
> >        concurrently with secondary CPU booting, putting its idle task in
> >        the holdout list because PF_IDLE isn't yet observed on it. It
> >        stays then stuck in the holdout list until that CPU ever
> >        schedules. The effect is mitigated here by all the smpboot
> >        kthreads and the hotplug AP thread that must run to bring the
> >        CPU up.
> > 
> > 2) Spurious warning on RCU task trace that assumes offline CPU's idle
> >    task is always PF_IDLE.
> > 
> > More issues have been found in RCU-tasks related to PF_IDLE which should
> > be fixed with later changes as those are not regressions:
> > 
> > 3) The RCU-Tasks semantics consider the idle loop as a quiescent state,
> >    however:
> > 
> >    3.1 The boot code preceding the idle entry is included in this
> >        quiescent state. Especially after the completion of kthreadd_done
> >        after which init/1 can launch userspace concurrently. The window
> >        is tiny before PF_IDLE is set but it exists.
> > 
> >    3.2 Similarly, the boot code preceding the idle entry on secondary
> >        CPUs is wrongly accounted as RCU tasks quiescent state.
> > 
> 
> Urgh... so the plan is to fix RCU-tasks for all of the above to not rely
> on PF_IDLE ? Because I rather like the more strict PF_IDLE and
> subsequently don't much like this revert.

Yeah I can't say I really like the old coverage of PF_IDLE either. The new one
(after Liam's patch) is only halfway better defined though: it makes the boot
CPU's idle behave quite well: PF_IDLE is set on idle entry. And secondary
CPU's idle behave quite well also except when they go offline and then online
again. And then the secondary boot code becomes PF_IDLE.

We probably need something like this:

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3b9d5c7eb4a2..b24d7937b989 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1394,7 +1394,9 @@ void cpuhp_report_idle_dead(void)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
+	current->flags &= ~PF_IDLE;
 	BUG_ON(st->state != CPUHP_AP_OFFLINE);
+
 	rcutree_report_cpu_dead();
 	st->state = CPUHP_AP_IDLE_DEAD;
 	/*
@@ -1642,6 +1644,8 @@ void cpuhp_online_idle(enum cpuhp_state state)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
+	current->flags |= PF_IDLE;
+
 	/* Happens for the boot cpu */
 	if (state != CPUHP_AP_ONLINE_IDLE)
 		return;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 5007b25c5bc6..342f58a329f5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,7 +373,6 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
-	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)


And then RCU-tasks can better rely on it as it really draws correctly
the idle coverage. As for working on top of that, we have thought about
solutions, lemme try to make them proper.

Thanks.
