Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC91808FB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443674AbjLGSRi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 13:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443464AbjLGSRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:17:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A6170C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:17:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1125C433C8;
        Thu,  7 Dec 2023 18:17:40 +0000 (UTC)
Date:   Thu, 7 Dec 2023 13:18:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yuanhan Zhang <zyhtheonly@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        zyhtheonly@yeah.net, tglx@linutronix.de, mingo@redhat.com,
        Venkatesh Pallipadi <venki@google.com>, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com
Subject: Re: [PATCH v3] sched/cputime: let ktimers align with ksoftirqd in
 accounting CPUTIME_SOFTIRQ
Message-ID: <20231207131811.08145840@gandalf.local.home>
In-Reply-To: <CAEQmJ=jceiVevd9d3i4h0BHCNc8FFONJqEaiKyN9p21rg0QdkQ@mail.gmail.com>
References: <20231201073240.T9bFNCkU@linutronix.de>
        <20231201080522.GA31309@didi-ThinkCentre-M930t-N000>
        <20231201161640.Z0cJLUi3@linutronix.de>
        <CAEQmJ=jbB5ag5HRMjZqjych_wj_v6wTMLQxJbnJsgwNdn37kbw@mail.gmail.com>
        <20231205153146.OSpCIs1G@linutronix.de>
        <CAEQmJ=iNVUuQQrm4bJgud=e7yhgwNb4Q1-BgOQF98D7NP9r29A@mail.gmail.com>
        <20231207103536.30ae05aa@gandalf.local.home>
        <CAEQmJ=jceiVevd9d3i4h0BHCNc8FFONJqEaiKyN9p21rg0QdkQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 12:19:28 -0500
Yuanhan Zhang <zyhtheonly@gmail.com> wrote:

> Hi,
> 
> Steven Rostedt <rostedt@goodmis.org> 于2023年12月7日周四 10:35写道：
> >
> > On Thu, 7 Dec 2023 18:43:47 +0800
> > Yuanhan Zhang <zyhtheonly@gmail.com> wrote:
> >  
> > > It results in if we do not handle ksoftirqd like this, we will have a
> > > bigger SYSTEM and less SOFTIRQ.  
> >
> > And honestly that's what we want. Interrupts and softirqs that execute in
> > interrupts and softirq context take away from the system. That is, if they
> > are not explicitly blocked (local_irq_disable/local_bh_disable) they
> > interrupt the current task and take up the time of the current task. We
> > need to differentiate this because this context has no "task" context to
> > measure.
> >
> > We do not want to add ksoftirqd or threaded interrupt handlers / softirqs
> > to this measurement. Sure, they are handling interrupt and softirq code,
> > but they have their own context that can be measured like any other task.
> >
> > If we blur this with real irqs and softirqs, then we will not know what
> > those real irqs and softirqs are measuring.  
> 
> Yes you say clearly enough and it makes some sense to me!
> So my understanding is that in PREEMPT_RT, it is better to put ksoftirqd's time
> into SYSTEM since they are just in their "task" context.
> 
> If my understanding is right, how about we just exclude ksoftirqd
> like what I do in the last email?
> (something like
>     else if (in_serving_softirq() &&
>                (IS_ENABLED(CONFIG_PREEMPT_RT) || curr != this_cpu_ksoftirqd()))
> 
> If this looks okay to you, I'm happy to send a new patch for this :)

Hmm, looking at the code in mainline, I may have misspoken. Although,
honestly, I don't know why we want this.

In irqtime_account_process_tick() there's:

	if (this_cpu_ksoftirqd() == p) {
		/*
		 * ksoftirqd time do not get accounted in cpu_softirq_time.
		 * So, we have to handle it separately here.
		 * Also, p->stime needs to be updated for ksoftirqd.
		 */
		account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);

Which to me looks like it is counting ksoftirqd for SOFTIRQ time. But
honestly, why do we care about that? What's the difference if ksoftirqd
were to run or softirqd were to pass work off to a workqueue?

ksoftirqd runs in vanilla Linux as SCHED_OTHER. The work it does doesn't
interrupt processes any more than any other kernel thread. I don't know why
we make it "special".

I guess the better question I need to ask is, what is this information used
for? I thought it was how much time was take away from tasks. As current
would be a task, and we do care if a real softirq is running, as we do not
want to add that to the current task accounting.

But for ksoftirqd, that's not the case, and I don't really care if it's
running a softirq or not. As that time isn't interrupting actual tasks. Not
to mention, one could simply look at the ksoftirqd tasks to see how much
time they take up.

> 
> >  
> > > So my point is if we do not align ktimers, ktimers would act like
> > > **observation on *not-excluded ksoftirq patched* kernel** part in the
> > > above example,
> > > and this might make SOFTIRQ less than expected, /proc/stat less accurate.  
> >
> > No it does not. When a softirq kicks off it's work to a thread (ksoftirq,
> > threaded softirqd, or simply a workqueue), it's no longer running in
> > softirq context, and should not be measured as such.
> >
> > The measurement is not about how much work the softirq is doing (otherwise
> > we need to add workqueues started by softirqs too), it's about measuring
> > the actual irq and softirq context. In PREEMPT_RT, we try to eliminate that
> > context as much as possible.  
> 
> Thanks anyway, I think I begin to learn a bit more about PREEMPT_RT...

Well, I may have been wrong in this information.

I would like to know who is using this information and for what purpose.
Ideally, I would love to make ksoftirqd *not* report its time as handling
SOFTIRQ.

-- Steve

