Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA77E6746
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjKIKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKIKC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:02:59 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A252D6B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:02:57 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a68d1698adso17828539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1699524176; x=1700128976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+0aBa2aDD/vZsGpLaRrk0V0Z80uuvVs4og5Gbkc/VY=;
        b=xSFcTMPvhFEkokChjDXfgAPyA1vSAUBAFiZ3yShKszWcpbzsnVJIuHSrS9sbD3TW5X
         joMJhIStePY7dR67wer7Ie2SgQS8oRKrkom4IVQCa6+Tn7vej7tfW82f9sodifQIx7mo
         nArG/D0SAeqmaC+sH37O4HuuOe+GA9ESglocY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524176; x=1700128976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+0aBa2aDD/vZsGpLaRrk0V0Z80uuvVs4og5Gbkc/VY=;
        b=ch3yDwJWZt/poDt0Rq4WaluDOEWqXTLS2z1OMbWaI7XfAtRVvaaYKZFB7Ajd4ZZeRi
         eEnozjK04RkLj+NCkkpsaqjeDCd0xb9hosePj3tsxNXlvh60eH/vruDns6VyYD0pNEGd
         e9jsfv8qA9qx/jMf6q7ZN5JJvctvZ6pkvJOOPR9PzxV7sGSZGJQB/V6r4ozqsysAcxU+
         Ifp69ehKWT66Nl3HxpmY9vDv9gFwckHmflXothtOXscgXgNOavVr5UsK+krzOt1w3xYA
         tp8s4mTCKU9DpjkcpslVpM+CPYbXnWSJn+1Ey0J6n47YKDjVaz+W1V5t6GIgIMAT/lJC
         8Imw==
X-Gm-Message-State: AOJu0YzY3gB2cKO2lgSTme0BuaSHkhpE9oWjQWfAx5vPqOfYQMqNIUt7
        G9fAEkPoKYd0NJsvtnXGri1k9Q==
X-Google-Smtp-Source: AGHT+IFkCqEs61f+tRQLK7Uo4YV5L3bHBpZWRQf9SyXamJgp0Wxkn0PUSKNO8VvuLRZ8KqGlTbC75w==
X-Received: by 2002:a5e:8909:0:b0:795:d33:861f with SMTP id k9-20020a5e8909000000b007950d33861fmr954233ioj.6.1699524176551;
        Thu, 09 Nov 2023 02:02:56 -0800 (PST)
Received: from localhost (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id m18-20020a6bf312000000b00786fd8e764bsm4026339ioh.0.2023.11.09.02.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:02:55 -0800 (PST)
Date:   Thu, 9 Nov 2023 10:02:54 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during
 newidle balance
Message-ID: <20231109100254.GA111915@google.com>
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-3-joel@joelfernandes.org>
 <CAKfTPtDk+awL2RxrRL_4-epj069-iXRbUeSwPH5NYz7ncpVzHA@mail.gmail.com>
 <20231022002805.GA3219395@google.com>
 <CAKfTPtCAbMERMkD9h1QRLUti0nPVW_u9N1Vr7W4ONbu_rEjTtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCAbMERMkD9h1QRLUti0nPVW_u9N1Vr7W4ONbu_rEjTtw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Sorry for late reply, I was in Tokyo all these days and was waiting to get to
writing a proper reply. See my replies below:

On Thu, Oct 26, 2023 at 04:23:35PM +0200, Vincent Guittot wrote:
> On Sun, 22 Oct 2023 at 02:28, Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Fri, Oct 20, 2023 at 03:40:14PM +0200, Vincent Guittot wrote:
> > > On Fri, 20 Oct 2023 at 03:40, Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
> > > >
> > > > When newidle balancing triggers, we see that it constantly clobbers
> > > > rq->next_balance even when there is no newidle balance happening due to
> > > > the cost estimates.  Due to this, we see that periodic load balance
> > > > (rebalance_domains) may trigger way more often when the CPU is going in
> > > > and out of idle at a high rate but is no really idle. Repeatedly
> > > > triggering load balance there is a bad idea as it is a heavy operation.
> > > > It also causes increases in softirq.
> > >
> > > we have 2 balance intervals:
> > > - one when idle based on the sd->balance_interval = sd_weight
> > > - one when busy which increases the period by multiplying it with
> > > busy_factor = 16
> >
> > On my production system I see load balance triggering every 4 jiffies! In a
> 
> Which kind of system do you have? sd->balance_interval is in ms

Yes, sorry I meant it triggers every jiffies which is extreme sometimes. It
is an ADL SoC (12th gen Intel, 4 P cores 8 E cores) get_sd_balance_interval()
returns 4 jiffies there. On my Qemu system, I see 8 jiffies.

[...]
> > > > Another issue is ->last_balance is not updated after newidle balance
> > > > causing mistakes in the ->next_balance calculations.
> > >
> > > newly idle load balance is not equal to idle load balance. It's a
> > > light load balance trying to pull one  task and you can't really
> > > consider it to the normal load balance
> >
> > True. However the point is that it is coupled with the other load balance
> > mechanism and the two are not independent. As you can see below, modifying
> > rq->next_balance in newidle also causes the periodic balance to happen more
> > aggressively as well if there is a high transition from busy to idle and
> > viceversa.
> 
> As mentioned, rq->next_balance is updated whenever cpu enters idle
> (i.e. in newidle_balance() but it's not related with doing a newly
> idle load balance.

Yes, I understand that. But my point was that the update of rq->next_balance
from the newidle path is itself buggy and interferes with the load balance
happening from the tick (trigger_load_balance -> run_rebalance_domains).

> But your problem is more related with the fact that
> nohz.needs_update is set when stopping cpu timer in order to update
> nohz.next_balance which is then used to kick a "real" idle load
> balance

Well, independent of nohz idle balance, I think we need to fix this issue as
mentioned above. This effect the periodic one as mentioned in the commit log.

See here another trace I collected this time dumping the 'interval'. There is
a tug of war happening between the newidle balance and the periodic balance.

The periodic one sets rq->next_balance for cpu 0 to 760,143 and then the
newidle comes in pulls it back a 118 jiffies to 760,024. This is actually in
the past because jiffies is currently 760,045 !!

This triggers the periodic balance againwhich sets rq->next_balance back to
760,143.

Rinse and repeat. End result is you have periodic balance every jiffies. With
this patch the issue goes away but we could fix it differently as you
mentioned, we need to pull newidle balance back but perhaps not so
aggressively. How about something like the untested diff I enclosed at the
end of this email?

<idle>-0   [000]  13.081781: rebalance_domains: rq[cpu=0]->next_balance: 760,024 -> 760,143 (jiffies=760,045)
cyclictest-120   [000]  13.081806: update_next_balance: sd->next_balance: 761,045 -> 760,024 (jiffies=760,045, interval=8)
cyclictest-120   [000]  13.081807: newidle_balance: this_rq[cpu=0]->next_balance: 760,143 -> 760,024 (jiffies=760,045)
cyclictest-120   [000]  13.082130: update_next_balance: sd->next_balance: 761,045 -> 760,024 (jiffies=760,045, interval=8)
cyclictest-120   [000]  13.082338: update_next_balance: sd->next_balance: 761,045 -> 760,024 (jiffies=760,045, interval=8)
cyclictest-120   [000]  13.082636: update_next_balance: sd->next_balance: 761,045 -> 760,024 (jiffies=760,045, interval=8)
<idle>-0   [000]  13.082823: trigger_load_balance: time_after_eq(jiffies=760,046, rq->next_balance=760,024) = 1
<idle>-0   [000]  13.082823: softirq_raise: vec=7 [action=SCHED]
<idle>-0   [000]  13.082871: rebalance_domains: rq[cpu=0]->next_balance: 760,024 -> 760,143 (jiffies=760,046)
trace-cmd-114   [000]  13.082876: update_next_balance: sd->next_balance: 761,046 -> 760,024 (jiffies=760,046, interval=8)
trace-cmd-114   [000]  13.082876: newidle_balance: this_rq[cpu=0]->next_balance: 760,143 -> 760,024 (jiffies=760,046)
cyclictest-120   [000]  13.083333: update_next_balance: sd->next_balance: 761,046 -> 760,024 (jiffies=760,046, interval=8)
cyclictest-120   [000]  13.083633: update_next_balance: sd->next_balance: 761,046 -> 760,024 (jiffies=760,046, interval=8)
<idle>-0   [000]  13.083656: trigger_load_balance: time_after_eq(jiffies=760,047, rq->next_balance=760,024) = 1
<idle>-0   [000]  13.083656: softirq_raise: vec=7 [action=SCHED]
<idle>-0   [000]  13.083702: rebalance_domains: rq[cpu=0]->next_balance: 760,024 -> 760,143 (jiffies=760,047)
cyclictest-120   [000]  13.083729: update_next_balance: sd->next_balance: 761,047 -> 760,024 (jiffies=760,047, interval=8)
cyclictest-120   [000]  13.083730: newidle_balance: this_rq[cpu=0]->next_balance: 760,143 -> 760,024 (jiffies=760,047)
cyclictest-120   [000]  13.083960: update_next_balance: sd->next_balance: 761,047 -> 760,024 (jiffies=760,047, interval=8)
cyclictest-120   [000]  13.084069: update_next_balance: sd->next_balance: 761,047 -> 760,024 (jiffies=760,047, interval=8)
cyclictest-120   [000]  13.084423: update_next_balance: sd->next_balance: 761,047 -> 760,024 (jiffies=760,047, interval=8)
cyclictest-120   [000]  13.084633: trigger_load_balance: time_after_eq(jiffies=760,048, rq->next_balance=760,024) = 1
cyclictest-120   [000]  13.084633: softirq_raise: vec=7 [action=SCHED]
cyclictest-120   [000]  13.084678: rebalance_domains: rq[cpu=0]->next_balance:

> > > > Fix by updating last_balance when a newidle load balance actually
> > > > happens and then updating next_balance. This is also how it is done in
> > > > other load balance paths.
> > > >
> > > > Testing shows a significant drop in softirqs when running:
> > > > cyclictest -i 100 -d 100 --latency=1000 -D 5 -t -m  -q
> > > >
> > > > Goes from ~6k to ~800.
> > >
> > > Even if your figures look interesting, your patch adds regression in
> > > the load balance and the fairness.
> >
> > Yes I see that now. However it does illustrate the problem IMO.
> >
> > > We can probably do improve the current behavior for decreasing number
> > > of ILB but your proposal is not the right solution IMO
> >
> > One of the problems is if you have task goes idle a lot, then the
> > newidle_balance mechanism triggers the periodic balance every jiffie (once
> > per millisecond on HZ=1000).
> 
> every msec seems quite a lot.

Yeah!

> >
> > Following are some traces I collected.
> >
> > cyclictest-123   [003]   522.650574  newidle_balance: this_rq[cpu=3]->next_balance: 221,264 -> 221,145 (jiffies=221,157)
> >    <idle>-0      [003]   522.651443  trigger_load_balance: time_after_eq(jiffies=221,158, rq->next_balance=221,145) = 1
> >    <idle>-0      [003]   522.651461  rebalance_domains: rq[cpu=3]->next_balance: 221,145 -> 221,264 (jiffies=221,158)
> > cyclictest-123   [003]   522.651494  newidle_balance: this_rq[cpu=3]->next_balance: 221,264 -> 221,145 (jiffies=221,158)
> >    <idle>-0      [003]   522.652522  trigger_load_balance: time_after_eq(jiffies=221,159, rq->next_balance=221,145) = 1
> >    <idle>-0      [003]   522.652560  rebalance_domains: rq[cpu=3]->next_balance: 221,145 -> 221,264 (jiffies=221,159)
> > cyclictest-124   [003]   522.652586  newidle_balance: this_rq[cpu=3]->next_balance: 221,264 -> 221,145 (jiffies=221,159)
> >    <idle>-0      [003]   522.654492  trigger_load_balance: time_after_eq(jiffies=221,161, rq->next_balance=221,145) = 1
> >    <idle>-0      [003]   522.654534  rebalance_domains: rq[cpu=3]->next_balance: 221,145 -> 221,264 (jiffies=221,161)
> 
> Ok, so IIUC your trace above, this happens because the tick is not
> stop after entering idle so it continues to fire and triggers a load
> balance without checking if there is a need like what is done for nohz
> mode

The tick is normally not stopped if the CPU is awakened too soon by a timer.
That's pretty normal AFAIK. As you can see in the traces above, cyclictest
keeps waking up.

> > things worse for power on ARM where you have uclamp stuff happening in the
> > load balance paths which is quite heavy when I last traced that..
> >
> > Further, we have observed in our tracing on real device that the update of
> > rq->next_balance from the newidle path is itself buggy... we observed that
> > because newidle balance may not update rq->last_balance, it is possible that
> > rq->next_balance when updated by update_next_balance() will be updated to a
> > value that is in the past and it will be stuck there for a long time! Perhaps
> > we should investigate more and fix that bug separately. Vineeth could provide
> > more details on the "getting stuck in the past" behavior as well.
> 
> sd->last_balance reflects last time an idle/busy load_balance happened
> (newly idle is out of the scope for the points that I mentioned
> previously).  So if no load balance happens for a while, the
> rq->next_balance can be in the past but I don't see a problem here. It
> just means that a load balance hasn't happened for a while. It can
> even move backward if it has been set when busy but the cpu is now
> idle

Sure, but I think it should at least set it by get_sd_balance_interval() into
the future. Like so (untested)? Let me know what you think and thanks!

---8<-----------------------

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a3318aeff9e8..0d6667d31c51 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11314,6 +11314,30 @@ get_sd_balance_interval(struct sched_domain *sd, int cpu_busy)
 	return interval;
 }
 
+/*
+ * Update the next balance from newidle balance.
+ * The update of next_balance from newidle balance tries to make sure that
+ * we don't trigger periodic balance too far in the future on a now-idle
+ * system.  This is just like update_next_balance except that since
+ * sd->last_balance may not have been updated for a while, we're careful to
+ * not set next_balance in the past.
+ */
+static inline void
+update_next_balance_newidle(struct sched_domain *sd, unsigned long *next_balance)
+{
+	unsigned long interval, next;
+
+	/* used by new idle balance, so cpu_busy = 0 */
+	interval = get_sd_balance_interval(sd, 0);
+	next = sd->last_balance + interval;
+
+	next = max(next, jiffies + interval);
+
+	if (time_after(*next_balance, next)) {
+		*next_balance = next;
+	}
+}
+
 static inline void
 update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
 {
@@ -12107,7 +12131,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
 		if (sd)
-			update_next_balance(sd, &next_balance);
+			update_next_balance_newidle(sd, &next_balance);
 		rcu_read_unlock();
 
 		goto out;
@@ -12124,7 +12148,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		int continue_balancing = 1;
 		u64 domain_cost;
 
-		update_next_balance(sd, &next_balance);
+		update_next_balance_newidle(sd, &next_balance);
 
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
 			break;
