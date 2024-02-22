Return-Path: <linux-kernel+bounces-77229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E95860322
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2DF4B2EF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906D6AF92;
	Thu, 22 Feb 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLQGKyqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E114B806
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629095; cv=none; b=dqUrBnydqy6NZ25o/+99jfipGYIsBkGQFOAkKFlA/X6vmB+GYb09v9Ajnuuei3qn/0XwF4Xs7Mwd1jaDaH/vusAw74cwYG2f03+anbLH5QO8s+cV1YjVy4BhI18gEN4MhEUIwI7uw/ChJvpImsoapt8QhKiurDJ9XP1IbTZI05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629095; c=relaxed/simple;
	bh=aFALfvo5MCBYaiRrAHjbsVKQ7Pu5EKpW+Z376eQGKc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jn3wnMric500pgLK/4EGbMoMmhNhi8SiTyKwGdsFjFP/7zF1zVFQcwuyo2X5+Z6sKEMGcLCGVvjOIBE/hE/9EthNu5yVjZ+nVaT9OYOI8aJlbrEQh8rBnuPabH1X13IbvpHs48TVSWkMlyG0rLlw7zu4IGcvsAeThCK69mIGcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLQGKyqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973F2C433F1;
	Thu, 22 Feb 2024 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708629094;
	bh=aFALfvo5MCBYaiRrAHjbsVKQ7Pu5EKpW+Z376eQGKc4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HLQGKyqwy9rfFn+0850civH9tKYc3I97W6iSfjJFT9m3TfBRQjhCxL7Nh2PoBzgc6
	 gQSNtQlAeOi7h/kxEwtjQ1HHNHE83ErHmP10MmBKKLweaIaKQd9CJ5l/U/fChrYYUc
	 uU3GHtQCIAoQRScvX9O6jqWdig4rd8lcRavJIj85BSHbZwwc20bbuwgEd+K5lsVwtt
	 TTGijhgL+c/8yVtvv9Fk6CulM6fDdO5B3wKN4HaXUgA1YV0lazheThplLxG9eAMo7V
	 SEdk675ZZ5MJfMjuikMVBGPguL/F4Eg2BN0yyc6B19XSAx4Q3p2n3vy2rp9xQOPivT
	 fKbnro+2GzojA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3A6B5CE0D11; Thu, 22 Feb 2024 11:11:34 -0800 (PST)
Date: Thu, 22 Feb 2024 11:11:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	peterz@infradead.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, David.Laight@aculab.com,
	richard@nod.at, jon.grimm@amd.com, bharata@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Message-ID: <1ec4dc29-8868-4d82-8c5e-c17ad025bc22@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>
 <0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
 <87r0hbkafi.fsf@oracle.com>
 <7db5c057-8bd4-4209-8484-3a0f9f3cd02d@paulmck-laptop>
 <2b735ba4-8081-4ddb-9397-4fe83143d97f@paulmck-laptop>
 <20240221131901.69c80c47@gandalf.local.home>
 <8f30ecd8-629b-414e-b6ea-b526b265b592@paulmck-laptop>
 <20240221151157.042c3291@gandalf.local.home>
 <53020731-e9a9-4561-97db-8848c78172c7@paulmck-laptop>
 <ZddtKszRH5Ak5tZ7@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZddtKszRH5Ak5tZ7@FVFF77S0Q05N>

On Thu, Feb 22, 2024 at 03:50:02PM +0000, Mark Rutland wrote:
> On Wed, Feb 21, 2024 at 12:22:35PM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 21, 2024 at 03:11:57PM -0500, Steven Rostedt wrote:
> > > On Wed, 21 Feb 2024 11:41:47 -0800
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > > I wonder if we can just see if the instruction pointer at preemption is at
> > > > > something that was allocated? That is, if it __is_kernel(addr) returns
> > > > > false, then we need to do more work. Of course that means modules will also
> > > > > trigger this. We could check __is_module_text() but that does a bit more
> > > > > work and may cause too much overhead. But who knows, if the module check is
> > > > > only done if the __is_kernel() check fails, maybe it's not that bad.  
> > > > 
> > > > I do like very much that idea, but it requires that we be able to identify
> > > > this instruction pointer perfectly, no matter what.  It might also require
> > > > that we be able to perfectly identify any IRQ return addresses as well,
> > > > for example, if the preemption was triggered within an interrupt handler.
> > > > And interrupts from softirq environments might require identifying an
> > > > additional level of IRQ return address.  The original IRQ might have
> > > > interrupted a trampoline, and then after transitioning into softirq,
> > > > another IRQ might also interrupt a trampoline, and this last IRQ handler
> > > > might have instigated a preemption.
> > > 
> > > Note, softirqs still require a real interrupt to happen in order to preempt
> > > executing code. Otherwise it should never be running from a trampoline.
> > 
> > Yes, the first interrupt interrupted a trampoline.  Then, on return,
> > that interrupt transitioned to softirq (as opposed to ksoftirqd).
> > While a softirq handler was executing within a trampoline, we got
> > another interrupt.  We thus have two interrupted trampolines.
> > 
> > Or am I missing something that prevents this?
> 
> Surely the problematic case is where the first interrupt is taken from a
> trampoline, but the inner interrupt is taken from not-a-trampoline? If the
> innermost interrupt context is a trampoline, that's the same as that without
> any nesting.

It depends.  If we wait for each task to not have a trampoline in effect
then yes, we only need to know whether or not a given task has at least
one trampoline in use.  One concern with this approach is that a given
task might have at least one trampoline in effect every time it is
checked, unlikely though that might seem.

If this is a problem, one way around it is to instead ask whether the
current task still has a reference to one of a set of trampolines that
has recently been removed.  This avoids the problem of a task always
being one some trampoline or another, but requires exact identification
of any and all trampolines a given task is currently using.

Either way, we need some way of determining whether or not a given
PC value resides in a trampoline.  This likely requires some data
structure (hash table?  tree?  something else?) that must be traversed
in order to carry out that determination.  Depending on the traversal
overhead, it might (or might not) be necessary to make sure that the
traversal is not on the entry/exit/scheduler fast paths.  It is also
necessary to keep the trampoline-use overhead low and the trampoline
call points small.

> We could handle nesting with a thread flag (e.g. TIF_IN_TRAMPOLINE) and a flag
> in irqentry_state_t (which is on the stack, and so each nested IRQ gets its
> own):
> 
> * At IRQ exception entry, if TIF_IN_TRAMPOLINE is clear and pt_regs::ip is a
>   trampoline, set TIF_IN_TRAMPOLINE and irqentry_state_t::entered_trampoline.
> 
> * At IRQ exception exit, if irqentry_state_t::entered_trampoline is set, clear
>   TIF_IN_TRAMPOLINE.
> 
> That naturally nests since the inner IRQ sees TIF_IN_TRAMPOLINE is already set
> and does nothing on entry or exit, and anything imbetween can inspect
> TIF_IN_TRAMPOLINE and see the right value.

If the overhead of determining whether pt_regs::ip is a trampoline
is sufficiently low, sounds good to me!  I suppose that different
architectures might have different answers to this question, just to
keep things entertaining.  ;-)

> On arm64 we don't dynamically allocate trampolines, *but* we potentially have a
> similar problem when changing the active ftrace_ops for a callsite, as all
> callsites share a common trampoline in the kernel text which reads a pointer to
> an ftrace_ops out of the callsite, then reads ftrace_ops::func from that.
> 
> Since the ops could be dynamically allocated, we want to wait for reads of that
> to complete before reusing the memory, and ideally we wouldn't have new
> entryies into the func after we think we'd completed the transition. So Tasks
> RCU might be preferable as it waits for both the trampoline *and* the func to
> complete.

OK, I am guessing that it is easier to work out whether pt_regs::ip is
a trampoline than cases involving dyanamic allocation of trampolines.

> > > > Are there additional levels or mechanisms requiring identifying
> > > > return addresses?
> > > 
> > > Hmm, could we add to irq_enter_rcu()
> > > 
> > > 	__this_cpu_write(__rcu_ip, instruction_pointer(get_irq_regs()));
> > > 
> > > That is to save off were the ip was when it was interrupted.
> > > 
> > > Hmm, but it looks like the get_irq_regs() is set up outside of
> > > irq_enter_rcu() :-(
> > > 
> > > I wonder how hard it would be to change all the architectures to pass in
> > > pt_regs to irq_enter_rcu()? All the places it is called, the regs should be
> > > available.
> > > 
> > > Either way, it looks like it will be a bit of work around the trampoline or
> > > around RCU to get this efficiently done.
> > 
> > One approach would be to make Tasks RCU be present for PREEMPT_AUTO
> > kernels as well as PREEMPTIBLE kernels, and then, as architectures provide
> > the needed return-address infrastructure, transition those architectures
> > to something more precise.
> 
> FWIW, that sounds good to me.

Thank you, and I will Cc you on the patches.

							Thanx, Paul

