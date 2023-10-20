Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D87D1226
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377620AbjJTPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377577AbjJTPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:05:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCAAA3;
        Fri, 20 Oct 2023 08:05:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8341C433C8;
        Fri, 20 Oct 2023 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697814307;
        bh=clURIbd52HeyK7bdD03xC8cdh8ODd+8QDODz7a5HBio=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UxRGt00VgsDzFi8PZH2yIs7xXNx62brRbiGWVS/Tz6mA2E8V8w8QHriOTpIYFoZhC
         EZC8eBJaeQFt4tckWmUU5Hq8EOEtzNLOz0lEKKNSz32eLng/mdUNQ1GSL3SPyJ+w9o
         AELOinTuPoalffgVUSxD+JQtzJsSYS7nivXgxpbkRmnTh6wqnTRj1c3Kr/DjYIiwPn
         mmxwyNVaCAG6tnZXORbElubGZC+O8f2x8w/SGYJ0ukBbotdiPlzAJ2fBHsLyeNuPEU
         A7x7BA1ZbCfTpHMtrh7gBO64vrzXpz2Cv5oBXlqH2m4tBKbhqqOAuMrSnnmTT9xaCu
         c69NQN2PoVUOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 86DDACE059F; Fri, 20 Oct 2023 08:05:06 -0700 (PDT)
Date:   Fri, 20 Oct 2023 08:05:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/4] Revert "kernel/sched: Modify initial boot task idle
 setup"
Message-ID: <6fdfe084-866a-4ab4-ac03-a8e0e5b5a35e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231019233543.1243121-1-frederic@kernel.org>
 <20231019233543.1243121-5-frederic@kernel.org>
 <20231020082531.GS33217@noisy.programming.kicks-ass.net>
 <ZTJzEVkVfSMGumWU@lothringen>
 <20231020134836.GE33965@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020134836.GE33965@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 03:48:36PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 20, 2023 at 02:31:13PM +0200, Frederic Weisbecker wrote:
> 
> > Yeah I can't say I really like the old coverage of PF_IDLE either. The new one
> > (after Liam's patch) is only halfway better defined though: it makes the boot
> > CPU's idle behave quite well: PF_IDLE is set on idle entry. And secondary
> > CPU's idle behave quite well also except when they go offline and then online
> > again. And then the secondary boot code becomes PF_IDLE.
> 
> Bah offline, yeah, we should just not do that :-)
> 
> > We probably need something like this:
> > 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 3b9d5c7eb4a2..b24d7937b989 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1394,7 +1394,9 @@ void cpuhp_report_idle_dead(void)
> >  {
> >  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> >  
> > +	current->flags &= ~PF_IDLE;
> >  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> > +
> >  	rcutree_report_cpu_dead();
> >  	st->state = CPUHP_AP_IDLE_DEAD;
> >  	/*
> > @@ -1642,6 +1644,8 @@ void cpuhp_online_idle(enum cpuhp_state state)
> >  {
> >  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> >  
> > +	current->flags |= PF_IDLE;
> > +
> >  	/* Happens for the boot cpu */
> >  	if (state != CPUHP_AP_ONLINE_IDLE)
> >  		return;
> 
> Yeah that works I suppose.

Booting up kernels being what it is, there might not be a completely
pretty solution.  Not that I would say "no" to such a solution should
it appear, mind you!  ;-)

							Thanx, Paul
