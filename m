Return-Path: <linux-kernel+bounces-76815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C21A85FCFE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44D0284630
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA114E2EA;
	Thu, 22 Feb 2024 15:50:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0A39FC7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617016; cv=none; b=qLEQlD7MOV4d4z71HFRhnChRcfhjNL/jxsBofgAOPnUPE/F/VJf7o813TAQ/ggZwe19hxIvIBehG70YmYXo4QCDlYMc6g0SIhXT84j50DEW4fAYT1RkfRJ5ueKnSyWFGb9tgcmN5RrrH04gwni3V/wurMRGRrbYzbh91d3I2cDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617016; c=relaxed/simple;
	bh=F5Lm3dTZGGzB2AupBbPbEA1PpVKFW7117BQantObeic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8Zxy2TxbdGKOcHKLw8LtoopZQMroOe8wmm5uAGc2fUS4c3R2ywo6Bzam5+4Ztee3OBlvsvj0c01IajzYcbfX3HiijrFuR0Wka1vl/9qEVvS7fIjddoPW4Kiku+3hF0iBLuAO1L69CXNIFrlBRdbGJg4JyYtfzobTFMyNm9DQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74905DA7;
	Thu, 22 Feb 2024 07:50:52 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.79.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 798DA3F762;
	Thu, 22 Feb 2024 07:50:09 -0800 (PST)
Date: Thu, 22 Feb 2024 15:50:02 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <ZddtKszRH5Ak5tZ7@FVFF77S0Q05N>
References: <87le7lkzj6.fsf@oracle.com>
 <4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>
 <0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
 <87r0hbkafi.fsf@oracle.com>
 <7db5c057-8bd4-4209-8484-3a0f9f3cd02d@paulmck-laptop>
 <2b735ba4-8081-4ddb-9397-4fe83143d97f@paulmck-laptop>
 <20240221131901.69c80c47@gandalf.local.home>
 <8f30ecd8-629b-414e-b6ea-b526b265b592@paulmck-laptop>
 <20240221151157.042c3291@gandalf.local.home>
 <53020731-e9a9-4561-97db-8848c78172c7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53020731-e9a9-4561-97db-8848c78172c7@paulmck-laptop>

On Wed, Feb 21, 2024 at 12:22:35PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 21, 2024 at 03:11:57PM -0500, Steven Rostedt wrote:
> > On Wed, 21 Feb 2024 11:41:47 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > > I wonder if we can just see if the instruction pointer at preemption is at
> > > > something that was allocated? That is, if it __is_kernel(addr) returns
> > > > false, then we need to do more work. Of course that means modules will also
> > > > trigger this. We could check __is_module_text() but that does a bit more
> > > > work and may cause too much overhead. But who knows, if the module check is
> > > > only done if the __is_kernel() check fails, maybe it's not that bad.  
> > > 
> > > I do like very much that idea, but it requires that we be able to identify
> > > this instruction pointer perfectly, no matter what.  It might also require
> > > that we be able to perfectly identify any IRQ return addresses as well,
> > > for example, if the preemption was triggered within an interrupt handler.
> > > And interrupts from softirq environments might require identifying an
> > > additional level of IRQ return address.  The original IRQ might have
> > > interrupted a trampoline, and then after transitioning into softirq,
> > > another IRQ might also interrupt a trampoline, and this last IRQ handler
> > > might have instigated a preemption.
> > 
> > Note, softirqs still require a real interrupt to happen in order to preempt
> > executing code. Otherwise it should never be running from a trampoline.
> 
> Yes, the first interrupt interrupted a trampoline.  Then, on return,
> that interrupt transitioned to softirq (as opposed to ksoftirqd).
> While a softirq handler was executing within a trampoline, we got
> another interrupt.  We thus have two interrupted trampolines.
> 
> Or am I missing something that prevents this?

Surely the problematic case is where the first interrupt is taken from a
trampoline, but the inner interrupt is taken from not-a-trampoline? If the
innermost interrupt context is a trampoline, that's the same as that without
any nesting.

We could handle nesting with a thread flag (e.g. TIF_IN_TRAMPOLINE) and a flag
in irqentry_state_t (which is on the stack, and so each nested IRQ gets its
own):

* At IRQ exception entry, if TIF_IN_TRAMPOLINE is clear and pt_regs::ip is a
  trampoline, set TIF_IN_TRAMPOLINE and irqentry_state_t::entered_trampoline.

* At IRQ exception exit, if irqentry_state_t::entered_trampoline is set, clear
  TIF_IN_TRAMPOLINE.

That naturally nests since the inner IRQ sees TIF_IN_TRAMPOLINE is already set
and does nothing on entry or exit, and anything imbetween can inspect
TIF_IN_TRAMPOLINE and see the right value.

On arm64 we don't dynamically allocate trampolines, *but* we potentially have a
similar problem when changing the active ftrace_ops for a callsite, as all
callsites share a common trampoline in the kernel text which reads a pointer to
an ftrace_ops out of the callsite, then reads ftrace_ops::func from that.

Since the ops could be dynamically allocated, we want to wait for reads of that
to complete before reusing the memory, and ideally we wouldn't have new
entryies into the func after we think we'd completed the transition. So Tasks
RCU might be preferable as it waits for both the trampoline *and* the func to
complete.

> > > Are there additional levels or mechanisms requiring identifying
> > > return addresses?
> > 
> > Hmm, could we add to irq_enter_rcu()
> > 
> > 	__this_cpu_write(__rcu_ip, instruction_pointer(get_irq_regs()));
> > 
> > That is to save off were the ip was when it was interrupted.
> > 
> > Hmm, but it looks like the get_irq_regs() is set up outside of
> > irq_enter_rcu() :-(
> > 
> > I wonder how hard it would be to change all the architectures to pass in
> > pt_regs to irq_enter_rcu()? All the places it is called, the regs should be
> > available.
> > 
> > Either way, it looks like it will be a bit of work around the trampoline or
> > around RCU to get this efficiently done.
> 
> One approach would be to make Tasks RCU be present for PREEMPT_AUTO
> kernels as well as PREEMPTIBLE kernels, and then, as architectures provide
> the needed return-address infrastructure, transition those architectures
> to something more precise.

FWIW, that sounds good to me.

Mark.

