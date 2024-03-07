Return-Path: <linux-kernel+bounces-96071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CFD8756C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589C61F2229A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D12135A75;
	Thu,  7 Mar 2024 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJdJRGZy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2548D13664E;
	Thu,  7 Mar 2024 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838484; cv=none; b=j5jKBpmNXUySKeIFtA6KVJSSa6e6uBvqFj8Gz0GMW52+xElwUvKOgp+CUVe/OUisiWN8Vzl54Z7IK2PbDKmJe5KOHOOWLaEUsXxTj+f2zNdr2aK0EIrZpMv43q46a97rIKoS5DIsWsqzVteonqrpElJmp5lqvbrPkKIZOZ+R938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838484; c=relaxed/simple;
	bh=yEOL18TbJDjwRAvn0qMrkNVx3ik8b1Q3Htm6MzV8i3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaJvuN2L8FuKxuBWqvVjVuFyhaNl/2ybpkTzPjHh1Ud9I+ryXLpoVZAF7BqKrjK2aCUVWTozBeu3Os692X/+6EACrUlXNQJx5zMMk0BAjuHxoWYa+qbXSa8H/BhFQDRg5OG3peA6IyPatgxYviv+SG/1Owv1jacqTNzKWARSzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJdJRGZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3B2C433F1;
	Thu,  7 Mar 2024 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709838483;
	bh=yEOL18TbJDjwRAvn0qMrkNVx3ik8b1Q3Htm6MzV8i3g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HJdJRGZyCRDcTmI2TLf3a9RuWEcViwOMyY5mYI8cUh4obB220U/FeLuF6A99W6Jvl
	 IKETLpXHZRcZyURy8yqsf6OmsvNBgr9CIh1JLB/VeNgPsQEepgKeKp1k3KasNIFMTE
	 gc2nFFC0XmEkQtCT/A0OvPJy6/IexoQ4MTIK77sd644Cr1sWSVuUul7BTX1aYYIqYj
	 h39f+hu2ko9FYrvSgw9xSofJhBdAVTsn6Ua/Fo18pFWIvke5sk6aRFjpjEwiw4MQE1
	 YmThMAWMyONtTKEEwJknndwrxu+9UAIh1vuf/BC8wpJhqc7ZGWB1NshLN2yC3qePgF
	 v0wRqUtJRk/1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 21FD9CE0716; Thu,  7 Mar 2024 11:08:03 -0800 (PST)
Date: Thu, 7 Mar 2024 11:08:03 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Stefan Wiehler <stefan.wiehler@nokia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
Message-ID: <293fbcc5-0c2d-4937-9026-a05236e1fc40@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <49792f54-fa11-4984-8611-84ba640a2b86@paulmck-laptop>
 <ZeoNbjTCAWYHgi4u@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeoNbjTCAWYHgi4u@shell.armlinux.org.uk>

On Thu, Mar 07, 2024 at 06:54:38PM +0000, Russell King (Oracle) wrote:
> On Thu, Mar 07, 2024 at 09:45:36AM -0800, Paul E. McKenney wrote:
> > > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > > index 3431c0553f45..6875e2c5dd50 100644
> > > --- a/arch/arm/kernel/smp.c
> > > +++ b/arch/arm/kernel/smp.c
> > > @@ -319,7 +319,14 @@ void __noreturn arch_cpu_idle_dead(void)
> > >  {
> > >  	unsigned int cpu = smp_processor_id();
> > >  
> > > +	/*
> > > +	 * Briefly report CPU as online again to avoid false positive
> > > +	 * Lockdep-RCU splat when check_and_switch_context() acquires ASID
> > > +	 * spinlock.
> > > +	 */
> > > +	rcutree_report_cpu_starting(cpu);
> > >  	idle_task_exit();
> > > +	rcutree_report_cpu_dead();
> > >  
> > >  	local_irq_disable();
> > 
> > Both rcutree_report_cpu_starting() and rcutree_report_cpu_dead() complain
> > bitterly via lockdep if interrupts are enabled.  And the call sites have
> > interrupts disabled.  So I don't understand what this local_irq_disable()
> > is needed for.
> 
> I think that's a question for this commit:
> 
> commit e78a7614f3876ac649b3df608789cb6ef74d0480
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Wed Jun 5 07:46:43 2019 -0700
> 
> Before this commit, arch_cpu_idle_dead() was called with IRQs enabled.
> This commit moved the local_irq_disable() before calling
> arch_cpu_idle_dead() but it seems no one looked at the various arch
> implementations to clean those up. Quite how arch people are supposed
> to spot this and clean up after such a commit, I'm not sure.

Telepathy?  ;-)

> The local_irq_disable() that you're asking about has been there ever
> since the inception of SMP on 32-bit ARM in this commit:
> 
> commit a054a811597a17ffbe92bc4db04a4dc2f1b1ea55
> Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
> Date:   Wed Nov 2 22:24:33 2005 +0000
> 
> Where cpu_die() was later renamed to arch_cpu_idle_dead(). So it's
> purely a case of a change being made to core code and arch code not
> receiving any fixups for it.

Thank you for the info!

							Thanx, Paul

