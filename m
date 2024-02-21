Return-Path: <linux-kernel+bounces-75448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5140D85E8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0737F281C99
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4407D86641;
	Wed, 21 Feb 2024 20:10:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA58664C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546213; cv=none; b=OWuN8N3PGacMzrikr4rtNRfVGPWiXYrdVDMXUpRTmobFInDhvz6OrVGCyuEChun9F6Y3VNkT2Al2rVsztg057ek2R97zVOV2mca68vjDi8p0GnPpb3FJGqoMMMK9R4xG6I6Yi3c9E8QIsfh8Q6qMtvvEgBhRLKQn9Bk7w52aE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546213; c=relaxed/simple;
	bh=L3FkPxtj10AZibYyxWDOcjvE6vH4PmYfFbcKLrD08oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHAGmBeF+3okjoAJiNF8nI4eJs5gPxRV9rstGxYsG30aotNztnH+ATfmb9tDHVrAJuV3NEuxkBebQ4m93tkq7LyxmzpLVF/LUoPRCT8PGiw9jQ+1lIWSOuD8EkTvh/XPpgLNerEiZxX4yKz/jgHwu1RShXhcKS7ZA7Buz15KTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF62BC433C7;
	Wed, 21 Feb 2024 20:10:09 +0000 (UTC)
Date: Wed, 21 Feb 2024 15:11:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
 anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
 krypton@ulrich-teichert.org, David.Laight@aculab.com, richard@nod.at,
 jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
Message-ID: <20240221151157.042c3291@gandalf.local.home>
In-Reply-To: <8f30ecd8-629b-414e-b6ea-b526b265b592@paulmck-laptop>
References: <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
	<871q9dmndg.fsf@oracle.com>
	<9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
	<87le7lkzj6.fsf@oracle.com>
	<4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>
	<0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
	<87r0hbkafi.fsf@oracle.com>
	<7db5c057-8bd4-4209-8484-3a0f9f3cd02d@paulmck-laptop>
	<2b735ba4-8081-4ddb-9397-4fe83143d97f@paulmck-laptop>
	<20240221131901.69c80c47@gandalf.local.home>
	<8f30ecd8-629b-414e-b6ea-b526b265b592@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 11:41:47 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > I wonder if we can just see if the instruction pointer at preemption is at
> > something that was allocated? That is, if it __is_kernel(addr) returns
> > false, then we need to do more work. Of course that means modules will also
> > trigger this. We could check __is_module_text() but that does a bit more
> > work and may cause too much overhead. But who knows, if the module check is
> > only done if the __is_kernel() check fails, maybe it's not that bad.  
> 
> I do like very much that idea, but it requires that we be able to identify
> this instruction pointer perfectly, no matter what.  It might also require
> that we be able to perfectly identify any IRQ return addresses as well,
> for example, if the preemption was triggered within an interrupt handler.
> And interrupts from softirq environments might require identifying an
> additional level of IRQ return address.  The original IRQ might have
> interrupted a trampoline, and then after transitioning into softirq,
> another IRQ might also interrupt a trampoline, and this last IRQ handler
> might have instigated a preemption.

Note, softirqs still require a real interrupt to happen in order to preempt
executing code. Otherwise it should never be running from a trampoline.

> 
> Are there additional levels or mechanisms requiring identifying
> return addresses?

Hmm, could we add to irq_enter_rcu()

	__this_cpu_write(__rcu_ip, instruction_pointer(get_irq_regs()));

That is to save off were the ip was when it was interrupted.

Hmm, but it looks like the get_irq_regs() is set up outside of
irq_enter_rcu() :-(

I wonder how hard it would be to change all the architectures to pass in
pt_regs to irq_enter_rcu()? All the places it is called, the regs should be
available.

Either way, it looks like it will be a bit of work around the trampoline or
around RCU to get this efficiently done.

-- Steve

