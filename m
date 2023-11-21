Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6480F7F2503
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjKUFEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUFEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:04:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308E2E7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:04:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4D9C433C8;
        Tue, 21 Nov 2023 05:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700543068;
        bh=RbKIbUhk3SZI+F62STbLelz0E+yirHODppjTDpyDT2g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o6DMWnpx52ZhUHrg41Fy2My/p6Zt1f7Si7DR6XB79UrS1xLKfqSvW9L5viuHLx4q1
         lF/uoHRpysPlf8FxGGDQSWBWk6cJhEU6cOsZYSru9psW+v0SMHY8dmvDPVFpXa5UUY
         WJisoPLBDFa6Uj2AhyS2e/OonKxjXVwufTwSCM83k2c4rq0GhotGsu1Ni8Yu8TPurI
         ayqgukRJbYLv55H8eNu7cymmLSgoNJKyEwjCPfQrJmwJnZcd6D6C1lJ8+Tf+lTDQfG
         CABhS4yjRMmSFlWJhs29phBvx2th0oIVOc8TvsxSr//xyU3XzS0MRsFCDg64E8Oms/
         hYarkN90mouLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 39ED3CE1390; Mon, 20 Nov 2023 21:04:28 -0800 (PST)
Date:   Mon, 20 Nov 2023 21:04:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
Message-ID: <29984609-14e1-4ce4-864b-87932ba3245a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-48-ankur.a.arora@oracle.com>
 <20231107192703.1c493431@gandalf.local.home>
 <b8c1ae88-5c12-488c-a7af-42119ebd55d2@paulmck-laptop>
 <20231120224356.7e9e5423@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120224356.7e9e5423@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:43:56PM -0500, Steven Rostedt wrote:
> On Mon, 20 Nov 2023 16:28:50 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Tue, Nov 07, 2023 at 07:27:03PM -0500, Steven Rostedt wrote:
> > > On Tue,  7 Nov 2023 13:57:33 -0800
> > > Ankur Arora <ankur.a.arora@oracle.com> wrote:
> > >   
> > > > With PREEMPTION being always-on, some configurations might prefer
> > > > the stronger forward-progress guarantees provided by PREEMPT_RCU=n
> > > > as compared to PREEMPT_RCU=y.
> > > > 
> > > > So, select PREEMPT_RCU=n for PREEMPT_VOLUNTARY and PREEMPT_NONE and
> > > > enabling PREEMPT_RCU=y for PREEMPT or PREEMPT_RT.
> > > > 
> > > > Note that the preemption model can be changed at runtime (modulo
> > > > configurations with ARCH_NO_PREEMPT), but the RCU configuration
> > > > is statically compiled.  
> > > 
> > > I wonder if we should make this a separate patch, and allow PREEMPT_RCU=n
> > > when PREEMPT=y?  
> > 
> > You mean independent of this series?  If so, I am not all that excited
> > about allowing a new option due to the effect on testing.  With this full
> > series, the number of test scenarios is preserved.
> > 
> > Actually, that is not exactly true, is it?  It would be if we instead had
> > something like this:
> > 
> > config PREEMPT_RCU
> > 	bool
> > 	default y if PREEMPT || PREEMPT_RT
> > 	depends on !PREEMPT_NONE && !PREEMPT_VOLUNTARY
> > 	select TREE_RCU
> > 
> > Any reason why this would be a problem?
> 
> Yes, because with this series, there isn't going to be PREEMPT_NONE,
> PREEMPT_VOLUNTARY and PREEMPT as a config option. I mean, you could define
> the preference you want at boot up. But it could change at run time.

I applied the series, and there was still a PREEMPT_NONE.  Some might
consider the name to be a bit misleading, perhaps, but it was still there.

Ah, I missed patch 30/86.  The idea is to make CONFIG_PREEMPT_DYNAMIC
unconditional?  Why?  

> > Or to put it another way, do you know of anyone who really wants
> > a preemptible kernel (CONFIG_PREEMPT=y, CONFIG_PREEMPT_NONE=n
> > and CONFIG_PREEMPT_VOLUNTARY=n) but also non-preemptible RCU
> > (CONFIG_PREEMPT_RCU=y)?  If so, why?  I am having some difficulty seeing
> > how this combination could be at all helpful.  And if it is not helpful,
> > we should not allow people to shoot themselves in the foot with it.
> 
> With the new preemption model, NONE, VOLUNTARY and PREEMPT are now going to
> determine when NEED_RESCHED is set as supposed to NEED_RESCHED_LAZY. As
> NEED_RESCHED_LAZY only schedules at kernel / user space transaction, and
> NEED_RESCHED will schedule when possible (non-preempt disable section).

So NONE really is still supposed to be there.  ;-)

>  Key: L - NEED_RESCHED_LAZY - schedule only at kernel/user boundary
>       N - NEED_RESCHED - schedule whenever possible (like PREEMPT does today)
> 
> 			SCHED_OTHER	REAL-TIME/DL
> 			  Schedule	  Schedule
> 
> NONE:			      L		     L
> 
> VOLUNTARY:		      L		     N
> 
> PREEMPT:		      N		     N
> 
> 
> So on NONE, NEED_RESCHED_LAZY is set only on scheduling SCHED_OTHER and RT.
> Which means, it will not schedule until it goes into user space (*).
> 
> On VOLUNTARY, NEED_RESCHED is set on RT/DL tasks, and LAZY on SCHED_OTHER.
> So that RT and DL get scheduled just like PREEMPT does today.
> 
> On PREEMPT, NEED_RESCHED is always set on all scheduling.
> 
> (*) - caveat - After the next tick, if NEED_RESCHED_LAZY is set, then
> NEED_RESCHED will be set and the kernel will schedule at the next available
> moment, this is true for all three models!

OK, so I see that this is now a SCHED_FEAT, and is initialized based
on CONFIG_PREEMPT_* in kernel/sched/feature.h.  Huh.  OK, we can still
control this at build time, which is fine.  I don't see how to set it
at boot time, only at build time or from debugfs.  I will let those who
want to set this at boot time complain, should they choose to do so.

> There may be more details to work out, but the above is basically the gist
> of the idea. Now, what do you want to do with RCU_PREEMPT? At run time, we
> can go from NONE to PREEMPT full! But there may be use cases that do not
> want the overhead of always having RCU_PREEMPT, and will want RCU to be a
> preempt_disable() section no matter what.

Understood, actually.  And as noted in other replies, I am a bit concerned
about added latencies from too aggressively removing cond_resched().

More testing required.

> Unless we can switch between RCU_PREEMPT and !RCU_PREEMPT at run time, the
> dependency on RCU_PREEMPT tied to PREEMPT doesn't make sense anymore.

I strongly recommend against runtime switching of RCU's preemptibility,
just in case you were wondering.  ;-)

My question is different.

Would anyone want PREEMPT (N N above) in combination with non-preemptible
RCU?  I cannot see why anyone would want this.

> > > This could allow us to test this without this having to be part of this
> > > series.  
> > 
> > OK, if you mean for testing purposes but not to go to mainline without
> > the rest of the series, I am good with that idea.
> > 
> > And thank you to Ankur for preserving non-preemptible RCU for those of us
> > using system that are adequately but not generously endowed with memory!
> 
> Exactly. It sounds like having non-preempt RCU is agnostic to the
> preemption model of the system, which is why I think we need to make them
> disjoint.

How about like this, where "Y" means allowed and "N" means not allowed:

			Non-Preemptible RCU	Preemptible RCU

NONE:				Y			Y

VOLUNTARY:			Y			Y

PREEMPT:			N			Y

PREEMPT_RT:			N			Y


We need preemptible RCU for NONE and VOLUNTARY, as you say,
to allow CONFIG_PREEMPT_DYNAMIC to continue to work.  (OK, OK,
CONFIG_PREEMPT_DYNAMIC is no longer, but appears to be unconditional.)
But again, I don't see why anyone would want (much less need)
non-preemptible RCU in the PREEMPT and PREEMPT_RT cases.  And if it is
neither wanted nor needed, there is no point in enabling it, much less
testing it.

Or am I missing a use case in there somewhere?

							Thanx, Paul
