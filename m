Return-Path: <linux-kernel+bounces-106027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577CB87E7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B631C214C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9D836114;
	Mon, 18 Mar 2024 10:59:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3C92E65B;
	Mon, 18 Mar 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759547; cv=none; b=bac1KPB3QVs8hN352MKiYEesJVE34X7/aro8S+ApGUOp3gfl64jNbyFJk/WQWnI2VXvxX/JCTvhcADYKewBTDd3M2slS8fmnkagzYeCFOggIqD3sDR5ZcUM+o7sgN6kE+l6/XWCNGoPwLIOXSw4vc4J3YR0Rbhkyn6BV7ZF4qUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759547; c=relaxed/simple;
	bh=m4C7IJM/lBOjxxuMNRxJEzICHUkxmZPvIn8SOjuKfPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2CGz57JgDer6HWjbHrOezesVwithqzh+mVhTrPzX+TYEr4PjxP+RTCyK1Ru3UsCTl+tut1w2BABAZidacPNBtlsdRqlYZGdZUDeKjfw1PEwFFpZbZLHcNIR5VGdtiaE9AhX+zcFR17A3ak1Y1li2dUdFyfJI65Y42fjRSTpwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E971106F;
	Mon, 18 Mar 2024 03:59:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.71.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42E1B3F762;
	Mon, 18 Mar 2024 03:59:00 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:58:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH v4 net 1/3] rcu: add a helper to report consolidated
 flavor QS
Message-ID: <ZfgecVqd6p-ACSZ5@FVFF77S0Q05N>
References: <cover.1710525524.git.yan@cloudflare.com>
 <491d3af6c7d66dfb3b60b2f210f38e843dfe6ed2.1710525524.git.yan@cloudflare.com>
 <790ce7e7-a8fd-4d28-aaf3-1b991a898be2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <790ce7e7-a8fd-4d28-aaf3-1b991a898be2@paulmck-laptop>

On Fri, Mar 15, 2024 at 10:40:56PM -0700, Paul E. McKenney wrote:
> On Fri, Mar 15, 2024 at 12:55:03PM -0700, Yan Zhai wrote:
> > There are several scenario in network processing that can run
> > extensively under heavy traffic. In such situation, RCU synchronization
> > might not observe desired quiescent states for indefinitely long period.
> > Create a helper to safely raise the desired RCU quiescent states for
> > such scenario.
> > 
> > Currently the frequency is locked at HZ/10, i.e. 100ms, which is
> > sufficient to address existing problems around RCU tasks. It's unclear
> > yet if there is any future scenario for it to be further tuned down.
> 
> I suggest something like the following for the commit log:
> 
> ------------------------------------------------------------------------
> 
> When under heavy load, network processing can run CPU-bound for many tens
> of seconds.  Even in preemptible kernels, this can block RCU Tasks grace
> periods, which can cause trace-event removal to take more than a minute,
> which is unacceptably long.
> 
> This commit therefore creates a new helper function that passes
> through both RCU and RCU-Tasks quiescent states every 100 milliseconds.
> This hard-coded value suffices for current workloads.

FWIW, this sounds good to me.

> 
> ------------------------------------------------------------------------
> 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> > v3->v4: comment fixup
> > 
> > ---
> >  include/linux/rcupdate.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 0746b1b0b663..da224706323e 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -247,6 +247,30 @@ do { \
> >  	cond_resched(); \
> >  } while (0)
> >  
> > +/**
> > + * rcu_softirq_qs_periodic - Periodically report consolidated quiescent states
> > + * @old_ts: last jiffies when QS was reported. Might be modified in the macro.
> > + *
> > + * This helper is for network processing in non-RT kernels, where there could
> > + * be busy polling threads that block RCU synchronization indefinitely.  In
> > + * such context, simply calling cond_resched is insufficient, so give it a
> > + * stronger push to eliminate all potential blockage of all RCU types.
> > + *
> > + * NOTE: unless absolutely sure, this helper should in general be called
> > + * outside of bh lock section to avoid reporting a surprising QS to updaters,
> > + * who could be expecting RCU read critical section to end at local_bh_enable().
> > + */
> 
> How about something like this for the kernel-doc comment?
> 
> /**
>  * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
>  * @old_ts: jiffies at start of processing.
>  *
>  * This helper is for long-running softirq handlers, such as those
>  * in networking.  The caller should initialize the variable passed in
>  * as @old_ts at the beginning of the softirq handler.  When invoked
>  * frequently, this macro will invoke rcu_softirq_qs() every 100
>  * milliseconds thereafter, which will provide both RCU and RCU-Tasks
>  * quiescent states.  Note that this macro modifies its old_ts argument.
>  *
>  * Note that although cond_resched() provides RCU quiescent states,
>  * it does not provide RCU-Tasks quiescent states.
>  *
>  * Because regions of code that have disabled softirq act as RCU
>  * read-side critical sections, this macro should be invoked with softirq
>  * (and preemption) enabled.
>  *
>  * This macro has no effect in CONFIG_PREEMPT_RT kernels.
>  */

Considering the note about cond_resched(), does does cond_resched() actually
provide an RCU quiescent state for fully-preemptible kernels? IIUC for those
cond_resched() expands to:

	__might_resched();
	klp_sched_try_switch()

.. and AFAICT neither reports an RCU quiescent state.

So maybe it's worth dropping the note?

Seperately, what's the rationale for not doing this on PREEMPT_RT? Does that
avoid the problem through other means, or are people just not running effected
workloads on that?

Mark.

> 
> 							Thanx, Paul
> 
> > +#define rcu_softirq_qs_periodic(old_ts) \
> > +do { \
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
> > +	    time_after(jiffies, (old_ts) + HZ / 10)) { \
> > +		preempt_disable(); \
> > +		rcu_softirq_qs(); \
> > +		preempt_enable(); \
> > +		(old_ts) = jiffies; \
> > +	} \
> > +} while (0)
> > +
> >  /*
> >   * Infrastructure to implement the synchronize_() primitives in
> >   * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
> > -- 
> > 2.30.2
> > 
> > 

