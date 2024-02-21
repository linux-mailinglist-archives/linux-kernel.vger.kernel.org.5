Return-Path: <linux-kernel+bounces-75456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0595A85E8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375931C232EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106898663A;
	Wed, 21 Feb 2024 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmQ0CYQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B481213
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546956; cv=none; b=tzFzLSIJ/1YotnbC7WjlCG+65Nu+BFcmMxSBKJmHn1wmb1K7FER1YjiMZKRCEz7ksIKwqPgog3EKrEB+69NtqVx3ZwjDuruQ+8oH/AQYTGfNispsV7dERj1WM3zKDghe2Lt3rICKRnJ4iIjJgBb9cRfgtBuieEoURAQ8k1OqEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546956; c=relaxed/simple;
	bh=xKyQlbp2/ZXI/OUsXfTHW6S35m4spQpcmJXXQajdyOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emGcUpQlk33mI4YFxtHPPs3Uzgkt2IRgeMQkKoMxwYDGRdzXJAwkH4h4+wzKNIVFNey4K3rm4dcMTk4VbsSc0AkmVAmRwmVilHDx2bktiUIk/j3g87QJP4NwTDrLG4lWW0/MJ2XnbMusAREuY8h3KIUAQMDlq4TDsiUUs7FyV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmQ0CYQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F01C433F1;
	Wed, 21 Feb 2024 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708546955;
	bh=xKyQlbp2/ZXI/OUsXfTHW6S35m4spQpcmJXXQajdyOI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NmQ0CYQ6MobmJmLJQ4NhtxZo3JbKcAB2Epotsa/wuR1rYd4Yc4NOYD7PKQJbjoYPc
	 OBhQHPqcSJAUFtwhD4inJ0iU+IvdUswP6OQdctU9N9vjEtzL05GRlbixW1665eixmW
	 rAAZE3PKVxxuvIMK3Br51ZxMIdDbRLpt3Ke9o8eTQXBY+OFgHmunzd0lfcINBizeuz
	 HD13e8FxV9otfdNCJqTkM3JwLmfUfSX7dV4xhJUpsruhzKoP3FUg5iHgQi+JRTKgh7
	 CBzUil5sJBJSAWLO4Ov1eRQ59ZWy8MdgIQH/eU+DLgw1S26VPAqY2N8/rjo12FOtQo
	 Q86C5Rg0AtmKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6F89ECE189D; Wed, 21 Feb 2024 12:22:35 -0800 (PST)
Date: Wed, 21 Feb 2024 12:22:35 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
	jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
	andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, David.Laight@aculab.com,
	richard@nod.at, jon.grimm@amd.com, bharata@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Message-ID: <53020731-e9a9-4561-97db-8848c78172c7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
 <87le7lkzj6.fsf@oracle.com>
 <4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>
 <0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
 <87r0hbkafi.fsf@oracle.com>
 <7db5c057-8bd4-4209-8484-3a0f9f3cd02d@paulmck-laptop>
 <2b735ba4-8081-4ddb-9397-4fe83143d97f@paulmck-laptop>
 <20240221131901.69c80c47@gandalf.local.home>
 <8f30ecd8-629b-414e-b6ea-b526b265b592@paulmck-laptop>
 <20240221151157.042c3291@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221151157.042c3291@gandalf.local.home>

On Wed, Feb 21, 2024 at 03:11:57PM -0500, Steven Rostedt wrote:
> On Wed, 21 Feb 2024 11:41:47 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > I wonder if we can just see if the instruction pointer at preemption is at
> > > something that was allocated? That is, if it __is_kernel(addr) returns
> > > false, then we need to do more work. Of course that means modules will also
> > > trigger this. We could check __is_module_text() but that does a bit more
> > > work and may cause too much overhead. But who knows, if the module check is
> > > only done if the __is_kernel() check fails, maybe it's not that bad.  
> > 
> > I do like very much that idea, but it requires that we be able to identify
> > this instruction pointer perfectly, no matter what.  It might also require
> > that we be able to perfectly identify any IRQ return addresses as well,
> > for example, if the preemption was triggered within an interrupt handler.
> > And interrupts from softirq environments might require identifying an
> > additional level of IRQ return address.  The original IRQ might have
> > interrupted a trampoline, and then after transitioning into softirq,
> > another IRQ might also interrupt a trampoline, and this last IRQ handler
> > might have instigated a preemption.
> 
> Note, softirqs still require a real interrupt to happen in order to preempt
> executing code. Otherwise it should never be running from a trampoline.

Yes, the first interrupt interrupted a trampoline.  Then, on return,
that interrupt transitioned to softirq (as opposed to ksoftirqd).
While a softirq handler was executing within a trampoline, we got
another interrupt.  We thus have two interrupted trampolines.

Or am I missing something that prevents this?

> > Are there additional levels or mechanisms requiring identifying
> > return addresses?
> 
> Hmm, could we add to irq_enter_rcu()
> 
> 	__this_cpu_write(__rcu_ip, instruction_pointer(get_irq_regs()));
> 
> That is to save off were the ip was when it was interrupted.
> 
> Hmm, but it looks like the get_irq_regs() is set up outside of
> irq_enter_rcu() :-(
> 
> I wonder how hard it would be to change all the architectures to pass in
> pt_regs to irq_enter_rcu()? All the places it is called, the regs should be
> available.
> 
> Either way, it looks like it will be a bit of work around the trampoline or
> around RCU to get this efficiently done.

One approach would be to make Tasks RCU be present for PREEMPT_AUTO
kernels as well as PREEMPTIBLE kernels, and then, as architectures provide
the needed return-address infrastructure, transition those architectures
to something more precise.

Or maybe the workaround will prove to be good enough.  We did
inadvertently test it for a year or so at scale, so I am at least
confident that it works.  ;-)

							Thanx, Paul

