Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D86809F38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjLHJ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjLHJ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:26:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD401724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:26:19 -0800 (PST)
Date:   Fri, 8 Dec 2023 10:26:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702027577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4DgOoWa1HB6dItdgWMHpAy3z8gYpOLje3P7y/CYa1bw=;
        b=oqwRe8gNbpLeoXtX/+zD76UmRJlsoiWnOpajQWHr3GGOh1SlQo1cVL+bxNejnVul9XMIQ9
        UhQZIT2EhjvoBhzgeswXPvwcpA52hYJ3QMXmMVerHRh0q3Lx9J2LHCuhxPyKQUD78qbgy5
        YHjhV7DtwObg1vxbhCX+p2EcrMCe6csSMVdagOL6ieueoVWCR64S1irNJBWzdMaMZ3oljF
        XRzKxNK0xpoxR94+y7kwqIxedRDwWG0GTBmsrKW26NpjmI6U7wVwE+QB8/wP38w7a1ZlBa
        lvl68aekoLRtAfyyDfQWwEzALAKzMBCD6BjIoHtNmsS/zmlDtdgFcMkoxpaY9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702027577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4DgOoWa1HB6dItdgWMHpAy3z8gYpOLje3P7y/CYa1bw=;
        b=S189MftGDiVPnT8XycZFbbRpOZOl/SLnlYKKqLOinskSMhtIL8JWQGBuUdRlZWgWc89DTS
        tooQ/nECYpQzfQCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yuanhan Zhang <zyhtheonly@gmail.com>, zyhtheonly@yeah.net,
        tglx@linutronix.de, mingo@redhat.com,
        Venkatesh Pallipadi <venki@google.com>, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com
Subject: Re: [PATCH v3] sched/cputime: let ktimers align with ksoftirqd in
 accounting CPUTIME_SOFTIRQ
Message-ID: <20231208092616.LcwLlOyE@linutronix.de>
References: <20231201073240.T9bFNCkU@linutronix.de>
 <20231201080522.GA31309@didi-ThinkCentre-M930t-N000>
 <20231201161640.Z0cJLUi3@linutronix.de>
 <CAEQmJ=jbB5ag5HRMjZqjych_wj_v6wTMLQxJbnJsgwNdn37kbw@mail.gmail.com>
 <20231205153146.OSpCIs1G@linutronix.de>
 <CAEQmJ=iNVUuQQrm4bJgud=e7yhgwNb4Q1-BgOQF98D7NP9r29A@mail.gmail.com>
 <20231207103536.30ae05aa@gandalf.local.home>
 <CAEQmJ=jceiVevd9d3i4h0BHCNc8FFONJqEaiKyN9p21rg0QdkQ@mail.gmail.com>
 <20231207131811.08145840@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207131811.08145840@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-07 13:18:11 [-0500], Steven Rostedt wrote:
> On Thu, 7 Dec 2023 12:19:28 -0500
> Yuanhan Zhang <zyhtheonly@gmail.com> wrote:
> 
> In irqtime_account_process_tick() there's:
> 
> 	if (this_cpu_ksoftirqd() == p) {
> 		/*
> 		 * ksoftirqd time do not get accounted in cpu_softirq_time.
> 		 * So, we have to handle it separately here.
> 		 * Also, p->stime needs to be updated for ksoftirqd.
> 		 */
> 		account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
> 
> Which to me looks like it is counting ksoftirqd for SOFTIRQ time. But
> honestly, why do we care about that? What's the difference if ksoftirqd
> were to run or softirqd were to pass work off to a workqueue?
> 
> ksoftirqd runs in vanilla Linux as SCHED_OTHER. The work it does doesn't
> interrupt processes any more than any other kernel thread. I don't know why
> we make it "special".

The special part is that it runs with disabled preemption the whole time
and the scheduler can't do a thing about it. This is different on
PREEMPT_RT where the softirq is preemptible and scheduler can replace it
with another task if suited. It still runs as SCHED_OTHER. The ktimers/
thread runs as SCHED_FIFO 1. So accounting it (incl. ksoftirqd) on
SYSTEM is fine IMHO. 

> I guess the better question I need to ask is, what is this information used
> for? I thought it was how much time was take away from tasks. As current
> would be a task, and we do care if a real softirq is running, as we do not
> want to add that to the current task accounting.
> 
> But for ksoftirqd, that's not the case, and I don't really care if it's
> running a softirq or not. As that time isn't interrupting actual tasks. Not
> to mention, one could simply look at the ksoftirqd tasks to see how much
> time they take up.

The original argument was to have the softirq counters right in
/proc/stat. This is what I remember from the trip to the museum.

> -- Steve

Sebastian
