Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBDE7BF54C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjJJIJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjJJIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:09:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4595CC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Uf08qN4MMqaXgQNdZMKbX8K1uA7l52yp3xz4+JLzueI=; b=DBkdKnY+Z18SGA7W+kr+zAgOTf
        YS1x3wmg5SbBdfgAyAHxGGMzV3CUHMlrRYa/iHk61RPpF6JJfif1AAzFv6e5Mo+6823HKUtMHavXq
        FPbtGpsa1QK6/+GjUxjfIJPCLxKLKruSnbDALpf5ifItlMRbAorsTTm1NA9t6bFwNf3ggxTQetwPe
        qRFzlbbv/W324aeJJWHzvXbsoeumqIPdCM0SLb2h+/aaEJxNIaUOW+UPm5wN72r7nufyzHrUHc2nP
        2epQSmy0TuFv86omX9RHlm3PunEzAJyij96rJF+toJvaIYjJiciSMOj+gsinPIf5E7FrGE/XIm8vp
        si7DuDLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qq7nD-00GhNQ-0i;
        Tue, 10 Oct 2023 08:08:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52183300392; Tue, 10 Oct 2023 10:08:40 +0200 (CEST)
Date:   Tue, 10 Oct 2023 10:08:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Youssef Esmat <youssefesmat@chromium.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
Message-ID: <20231010080840.GC377@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net>
 <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
 <20231002184136.GA1539@noisy.programming.kicks-ass.net>
 <20231005120557.GA743@noisy.programming.kicks-ass.net>
 <CA+q576MLvCwH2YQFx3V2tf3f4n6JUze7jkpqqTx97UPsOHewhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+q576MLvCwH2YQFx3V2tf3f4n6JUze7jkpqqTx97UPsOHewhg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 01:23:14PM -0500, Youssef Esmat wrote:
> On Thu, Oct 5, 2023 at 7:06 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > BAaaBCccccccccBBBAaaBBBAaaBB                            BBAaaBBBAaaBBBAaaBCccccccccB
> >
> >
> >
> > As I wrote before; EVDF has worse lag bounds, but this is not
> > insurmountable. The biggest problem that I can see is that of wakeup
> > preemption. Currently we allow to preempt when 'current' has reached V
> > (RUN_TO_PARITY in pick_eevdf()).
> >
> > With these rules, when EEVDF schedules C (our large slice task) at t=10
> > above, it is only a little behind C and can be reaily preempted after
> > about 2 time units.
> >
> > However, EVDF will delay scheduling C until much later, see how A and B
> > walk far ahead of V until t=36. Only when will we pick C. But this means
> > that we're firmly stuck with C for at least 11 time units. A newly
> > placed task will be around V and will have no chance to preempt.
> >
> 
> Thank you for the detailed analysis! I am still in the process of
> digesting everything.
> I do have a quick question, this will only be the case if we adjust
> C's runtime without adjusting nice value, correct? So it does not
> currently apply to the submitted code where the only way to change the
> deadline is to also change the nice value and thus how fast/slow
> vruntime accumulates. In other words without the sched_runtime
> patch[1] we should not run into this scenario, correct?
> 
> [1] https://lore.kernel.org/lkml/20230915124354.416936110@noisy.programming.kicks-ass.net/


Much harder to run into it, but you can still hit it using nice.

 d_i = v_i + r_i / w_i

So for very light tasks, the effective v_deadline goes out lots.

And as I wrote yesterday, by delaying scheduling (far) past 0-lag you
effectively open up a denial of service window, since new tasks are
placed around 0-lag.

Now, nobody will likely care much if very light tasks get horrific
treatment, but still, it's there.
