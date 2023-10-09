Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58A7BE339
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjJIOm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjJIOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:42:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD718AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hGwBYnmpWZpb2H7rgyQsD4rWY/WMeWNNj7R1Yf/CQpU=; b=kkSH0wVeLP89GD6irJs2ynnayn
        noeoONBD/kCdjZNAgTmIjVnzEvj0J76XpECuFrTWVOCRbH0qRJavMnnfBWYv6aenrO7MkynnQc8bQ
        iMxpvyFUY1kmoMBIpl8kybhGFfYSWhf4x5jpQc3qNgxvodDurrurlyyqkzC67wCkT3QQjvl1g2Lj0
        WhPMoAsfQlf42XHdLooK9bYWzyX3omKjQar16u6262y1hCDh9meI47qtSPA1BcpX2p3XBN+ucYzMa
        JjXe5meeeXbdIL0R1WIYREcGpT3SOhhVjV6+co3OWpnFfDzbj5YgJnqR0KpuncgnL8uG+h3IRbnr7
        hRTGugwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qprRk-00Fvra-1B;
        Mon, 09 Oct 2023 14:41:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AC29300454; Mon,  9 Oct 2023 16:41:25 +0200 (CEST)
Date:   Mon, 9 Oct 2023 16:41:25 +0200
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
Message-ID: <20231009144125.GC6337@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net>
 <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
 <20231002184136.GA1539@noisy.programming.kicks-ass.net>
 <20231005120557.GA743@noisy.programming.kicks-ass.net>
 <20231007220400.GA5581@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007220400.GA5581@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 12:04:00AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 05, 2023 at 02:05:57PM +0200, Peter Zijlstra wrote:
> 
> > t=10 V=4                                                t=10 V=4
> >  A       |----<                                          A       |----<
> >  B      |<                                              >B      |<
> > >C   |----------------<                                  C   |----------------<
> >    |---*-----|---------|---------|---------|----           |---*-----|---------|---------|---------|----
> >                                                         
> 
> >                                                         
> > t=52 V=18                                               t=36 V=13
> >  A                   |----<                              A                   |----<
> > >B                  |<                                   B                    |<
> >  C                     |----------------<               >C   |----------------<
> >    |---------|-------*-|---------|---------|----           |---------|--*------|---------|---------|----
> >                                                         
> 
> >                                                         
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
> 
> Playing around with it a little:
> 
> EEVDF					EVDF
> 
> slice 30000000				slice 30000000
> # Min Latencies: 00014                  # Min Latencies: 00048
> # Avg Latencies: 00692                  # Avg Latencies: 188239
> # Max Latencies: 94633                  # Max Latencies: 961241
>                                         
> slice 3000000                           slice 3000000
> # Min Latencies: 00054                  # Min Latencies: 00055
> # Avg Latencies: 00522                  # Avg Latencies: 00673
> # Max Latencies: 41475                  # Max Latencies: 13297
>                                         
> slice 300000                            slice 300000
> # Min Latencies: 00018                  # Min Latencies: 00024
> # Avg Latencies: 00344                  # Avg Latencies: 00056
> # Max Latencies: 20061                  # Max Latencies: 00860
> 
> 
> So while it improves the short slices, it completely blows up the large
> slices -- utterly slaughters the large slices in fact.
> 
> And all the many variants of BIAS_ELIGIBLE that I've tried so far only
> manage to murder the high end while simultaneously not actually helping
> the low end -- so that's a complete write off.
> 
> 
> By far the sanest option so far is PLACE_SLEEPER -- and that is very
> much not a nice option either :-(

And this can be easily explained by the fact that we insert tasks around
0-lag, so if we delay execution past this point we create an effective
DoS window.
