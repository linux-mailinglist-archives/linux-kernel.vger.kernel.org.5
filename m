Return-Path: <linux-kernel+bounces-75259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4527985E55E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E531C21726
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361885276;
	Wed, 21 Feb 2024 18:17:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3D42A8B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539437; cv=none; b=UjIUsP1/C/aaU1pqvl6CzwMKNlj/j7hxAFWuuBxv42O+xi6doYbV3Enepq909RlwV0OVYpgEsUh+HXAumEm/KcyfZatdQyRYzmsAxn1CxroTG2mEyAIzptompcUDklFW+zslQsgy8XVg+cKXREh4WkdKE5sIvbeCm0Xl2bQVw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539437; c=relaxed/simple;
	bh=XaMobFpXAK8tIXrf0/UQugdaVpU+uyKO0rivX2fVDtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWybEEloO9mJY3m9S/ZpOEREYr1N7Mn8XoSaSxrh5EArBRnFj09QFxA4EV8Pk1Kdbq68FgWFn75DDdVh6eBCbiaiTbc+hJuzmM+7eHL8Auok3PfdV8VI/EzxzODsPn6Tqw3qF+lpYXCU5oGqmZw7l+OmMKKv3xbOrcwvrkuMjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64274C433F1;
	Wed, 21 Feb 2024 18:17:13 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:19:01 -0500
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
Message-ID: <20240221131901.69c80c47@gandalf.local.home>
In-Reply-To: <2b735ba4-8081-4ddb-9397-4fe83143d97f@paulmck-laptop>
References: <87le7mpjpr.fsf@oracle.com>
	<4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
	<0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
	<871q9dmndg.fsf@oracle.com>
	<9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
	<87le7lkzj6.fsf@oracle.com>
	<4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>
	<0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
	<87r0hbkafi.fsf@oracle.com>
	<7db5c057-8bd4-4209-8484-3a0f9f3cd02d@paulmck-laptop>
	<2b735ba4-8081-4ddb-9397-4fe83143d97f@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 08:48:20 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > I will look again -- it is quite possible that I was confused by earlier
> > in-fleet setups that had Tasks RCU enabled even when preemption was
> > disabled.  (We don't do that anymore, and, had I been paying sufficient
> > attention, would not have been doing it to start with.  Back in the day,
> > enabling rcutorture, even as a module, had the side effect of enabling
> > Tasks RCU.  How else to test it, right?  Well...)  
> 
> OK, I got my head straight on this one...
> 
> And the problem is in fact that Tasks RCU isn't normally present
> in non-preemptible kernels.  This is because normal RCU will wait
> for preemption-disabled regions of code, and in PREMPT_NONE and
> PREEMPT_VOLUNTARY kernels, that includes pretty much any region of code
> lacking an explicit schedule() or similar.  And as I understand it,
> tracing trampolines rely on this implicit lack of preemption.
> 
> So, with lazy preemption, we could preempt in the middle of a
> trampoline, and synchronize_rcu() won't save us.
> 
> Steve and Mathieu will correct me if I am wrong.
> 
> If I do understand this correctly, one workaround is to remove the
> "if PREEMPTIBLE" on all occurrences of "select TASKS_RCU".  That way,
> all kernels would use synchronize_rcu_tasks(), which would wait for
> a voluntary context switch.
> 
> This workaround does increase the overhead and tracepoint-removal
> latency on non-preemptible kernels, so it might be time to revisit the
> synchronization of trampolines.  Unfortunately, the things I have come
> up with thus far have disadvantages:
> 
> o	Keep a set of permanent trampolines that enter and exit
> 	some sort of explicit RCU read-side critical section.
> 	If the address for this trampoline to call is in a register,
> 	then these permanent trampolines remain constant so that
> 	no synchronization of them is required.  The selected
> 	flavor of RCU can then be used to deal with the non-permanent
> 	trampolines.
> 
> 	The disadvantage here is a significant increase in the complexity
> 	and overhead of trampoline code and the code that invokes the
> 	trampolines.  This overhead limits where tracing may be used
> 	in the kernel, which is of course undesirable.

I wonder if we can just see if the instruction pointer at preemption is at
something that was allocated? That is, if it __is_kernel(addr) returns
false, then we need to do more work. Of course that means modules will also
trigger this. We could check __is_module_text() but that does a bit more
work and may cause too much overhead. But who knows, if the module check is
only done if the __is_kernel() check fails, maybe it's not that bad.

-- Steve

> 
> o	Check for being preempted within a trampoline, and track this
> 	within the tasks structure.  The disadvantage here is that this
> 	requires keeping track of all of the trampolines and adding a
> 	check for being in one on a scheduler fast path.
> 
> o	Have a variant of Tasks RCU which checks the stack of preempted
> 	tasks, waiting until all have been seen without being preempted
> 	in a trampoline.  This still requires keeping track of all the
> 	trampolines in an easy-to-search manner, but gets the overhead
> 	of searching off of the scheduler fastpaths.
> 
> 	It is also necessary to check running tasks, which might have
> 	been interrupted from within a trampoline.
> 
> 	I would have a hard time convincing myself that these return
> 	addresses were unconditionally reliable.  But maybe they are?
> 
> o	Your idea here!
> 
> Again, the short-term workaround is to remove the "if PREEMPTIBLE" from
> all of the "select TASKS_RCU" clauses.
> 
> > > > My next step is to try this on bare metal on a system configured as
> > > > is the fleet.  But good progress for a week!!!  
> > > 
> > > Yeah this is great. Fingers crossed for the wider set of tests.  
> > 
> > I got what might be a one-off when hitting rcutorture and KASAN harder.
> > I am running 320*TRACE01 to see if it reproduces.  
> 
> [ . . . ]
> 
> > So, first see if it is reproducible, second enable more diagnostics,
> > third make more grace-period sequence numbers available to rcutorture,
> > fourth recheck the diagnostics code, and then see where we go from there.
> > It might be that lazy preemption needs adjustment, or it might be that
> > it just tickled latent diagnostic issues in rcutorture.
> > 
> > (I rarely hit this WARN_ON() except in early development, when the
> > problem is usually glaringly obvious, hence all the uncertainty.)  
> 
> And it is eminently reproducible.  Digging into it...

