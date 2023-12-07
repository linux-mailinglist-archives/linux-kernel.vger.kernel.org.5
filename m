Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82932807F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjLGERY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLGERW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:17:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA862DD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 20:17:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB3DC433C7;
        Thu,  7 Dec 2023 04:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701922647;
        bh=T+v7xQvdCpJ6DcfwiigwsZNAAWWbz1JSdHy4eCuWWWw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jURRJuZ9+VEQSNiJ/mGla8BQv99HITnl1MpanDWFC2m9APywmIaCm1VQb5IBXnci7
         OUPfxAad85Y4t0bnci3B4FgmTeCGmMFBnMYAvDQZfuYDW38Tcgd+QjJTLik9bBPBzJ
         HsP1fK/y3SLK7zzyi/47+cmMVusOngCr5ILZ6MPSyvYWLtW4OYk3mJdv2jE5wk2Lp+
         jOudlCHnHXKjAFTN0qjFOA8d7czNjckrmNrOCTXg2qd0Jeo2L3Xy1SXJljfFPioNWQ
         tx7r5rq/RFBJVNAry21GXxX7LNfYZMMCRLs4+fFflB+EpSXrAIPFabnDn1pfVF6OdN
         4fh4qiHcD3bUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D7EBFCE0E88; Wed,  6 Dec 2023 20:17:26 -0800 (PST)
Date:   Wed, 6 Dec 2023 20:17:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
Message-ID: <b6dfa0bb-d598-446d-93b6-941bdb16df96@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87v89lzu5a.ffs@tglx>
 <209f0e89-7ebd-4759-9883-21d842d0d26c@paulmck-laptop>
 <875y1bwen9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y1bwen9.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 04:10:18PM +0100, Thomas Gleixner wrote:
> Paul!
> 
> On Mon, Dec 04 2023 at 17:33, Paul E. McKenney wrote:
> > On Tue, Nov 28, 2023 at 06:04:33PM +0100, Thomas Gleixner wrote:
> >> So:
> >> 
> >>     loop()
> >> 
> >>       preempt_disable();
> >> 
> >>       --> tick interrupt
> >>             rcu_flavor_sched_clock_irq()
> >>                 sets NEED_RESCHED
> >> 
> >>       preempt_enable()
> >>         preempt_schedule()
> >>           schedule()
> >>             report_QS()
> >> 
> >> See? No magic nonsense in preempt_enable(), no cond_resched(), nothing.
> >
> > Understood, but that does delay detection of that quiescent state by up
> > to one tick.
> 
> Sure, but does that really matter in practice?

It might, but yes, I would expect it to matter far less than the other
things I have been calling out.

> >> So if that turns out to matter in reality and not just by academic
> >> inspection, then we are far better off to annotate such code with:
> >> 
> >>     do {
> >>         preempt_lazy_disable();
> >>         mutex_lock();
> >>         do_stuff();
> >>         mutex_unlock();
> >>         preempt_lazy_enable();
> >>     }
> >> 
> >> and let preempt_lazy_enable() evaluate the NEED_RESCHED_LAZY bit.
> >
> > I am not exactly sure what semantics you are proposing with this pairing
> > as opposed to "this would be a good time to preempt in response to the
> > pending lazy request".  But I do agree that something like this could
> > replace at least a few more instance of cond_resched(), so that is good.
> > Not necessarily all of them, though.
> 
> The main semantic difference is that such a mechanism is properly
> nesting and can be eventually subsumed into the actual locking
> constructs.

OK, fair enough.

And noting that testing should include workloads that exercise things
like mutex_lock() and mutex_trylock() fastpaths.

> >> Just insisting that RCU_PREEMPT=n requires cond_resched() and whatsoever
> >> is not really getting us anywhere.
> >
> > Except that this is not what is happening, Thomas.  ;-)
> >
> > You are asserting that all of the cond_resched() calls can safely be
> > eliminated.  That might well be, but more than assertion is required.
> > You have come up with some good ways of getting rid of some classes of
> > them, which is a very good and very welcome thing.  But that is not the
> > same as having proved that all of them may be safely removed.
> 
> Neither have you proven that any of them will be required with the new
> PREEMPT_LAZY model. :)

True.  But nor have you proven them unnecessary.  That will need to
wait for larger-scale testing.

> Your experience and knowledge in this area is certainly appreciated, but
> under the changed semantics of LAZY it's debatable whether observations
> and assumptions which are based on PREEMPT_NONE behaviour still apply.
> 
> We'll see.

That we will!

							Thanx, Paul
