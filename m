Return-Path: <linux-kernel+bounces-75402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E97A85E818
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524AD1C21E50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383414A083;
	Wed, 21 Feb 2024 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3we+J+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B3714E2DC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544508; cv=none; b=GWyysSuuaq5lgl/TBKzwuh/HQzyz6fY4sfynchrN3Sm3RLJvd/aCHuNnI3U9fzWZfib1ibmCl3efG82zCmHxT6zoLmyIrQ79/WrTOgLq44ZrwDSBAbcoJWpY3DCcpsHblloRwAnLNZwj6deWzQNeweMZLEYkNXVY/mhgjI9xTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544508; c=relaxed/simple;
	bh=KvycW41l5hs3WMNOB3jqOs6KhN61fVWubFcPSBZ24Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwCqENK5QlIjrc3ittpMKL9VXBFuvwMaum/3PFtBKlMlallYaqhSivZBnZ98iP7GLOMWy0Lv3O9xvUezeYkjT03Tn2ZlaYz0zDsoNlw445ccAtSzaGCLUZGBisi9I/h4hI6sBd4V4IelH1C0UmYtx0zAA+LjaRJfDQVm2hl5DGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3we+J+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFCBC4E666;
	Wed, 21 Feb 2024 19:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708544507;
	bh=KvycW41l5hs3WMNOB3jqOs6KhN61fVWubFcPSBZ24Hk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=D3we+J+OctBBT3pdo2Weg0iFV12xVA2R5+TfO4UUOi9kHWvuVBfIo/4v2h11NVVqf
	 Sr80xTAhru+5i5LJ77DdVwHJqwE1aEqwWnH+jSHNswTpjXpRGJzKlCKCKVbWmALgoV
	 c5kelZ0bNKR2c/Kuwg6geWrvK8YPZRhNVGb1z+i+/MK5kYx3ar861LBnIa0bntxOXb
	 1JlfP4PFWk7Pm4hrsRUS6wZof/xLZP9RmYy2J5k2RCyD+DHw5+BqPJEFxF5K6Y8l8j
	 Ih+joySTSTFv0napa7G8sjavFMt8X+UEiyS+JkdYTCcCt5J0PEinJn/YKow/aG2d15
	 rB4kMkdMVsaTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 12DFACE189D; Wed, 21 Feb 2024 11:41:47 -0800 (PST)
Date: Wed, 21 Feb 2024 11:41:47 -0800
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
Message-ID: <8f30ecd8-629b-414e-b6ea-b526b265b592@paulmck-laptop>
Reply-To: paulmck@kernel.org
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221131901.69c80c47@gandalf.local.home>

On Wed, Feb 21, 2024 at 01:19:01PM -0500, Steven Rostedt wrote:
> On Mon, 19 Feb 2024 08:48:20 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > I will look again -- it is quite possible that I was confused by earlier
> > > in-fleet setups that had Tasks RCU enabled even when preemption was
> > > disabled.  (We don't do that anymore, and, had I been paying sufficient
> > > attention, would not have been doing it to start with.  Back in the day,
> > > enabling rcutorture, even as a module, had the side effect of enabling
> > > Tasks RCU.  How else to test it, right?  Well...)  
> > 
> > OK, I got my head straight on this one...
> > 
> > And the problem is in fact that Tasks RCU isn't normally present
> > in non-preemptible kernels.  This is because normal RCU will wait
> > for preemption-disabled regions of code, and in PREMPT_NONE and
> > PREEMPT_VOLUNTARY kernels, that includes pretty much any region of code
> > lacking an explicit schedule() or similar.  And as I understand it,
> > tracing trampolines rely on this implicit lack of preemption.
> > 
> > So, with lazy preemption, we could preempt in the middle of a
> > trampoline, and synchronize_rcu() won't save us.
> > 
> > Steve and Mathieu will correct me if I am wrong.
> > 
> > If I do understand this correctly, one workaround is to remove the
> > "if PREEMPTIBLE" on all occurrences of "select TASKS_RCU".  That way,
> > all kernels would use synchronize_rcu_tasks(), which would wait for
> > a voluntary context switch.
> > 
> > This workaround does increase the overhead and tracepoint-removal
> > latency on non-preemptible kernels, so it might be time to revisit the
> > synchronization of trampolines.  Unfortunately, the things I have come
> > up with thus far have disadvantages:
> > 
> > o	Keep a set of permanent trampolines that enter and exit
> > 	some sort of explicit RCU read-side critical section.
> > 	If the address for this trampoline to call is in a register,
> > 	then these permanent trampolines remain constant so that
> > 	no synchronization of them is required.  The selected
> > 	flavor of RCU can then be used to deal with the non-permanent
> > 	trampolines.
> > 
> > 	The disadvantage here is a significant increase in the complexity
> > 	and overhead of trampoline code and the code that invokes the
> > 	trampolines.  This overhead limits where tracing may be used
> > 	in the kernel, which is of course undesirable.
> 
> I wonder if we can just see if the instruction pointer at preemption is at
> something that was allocated? That is, if it __is_kernel(addr) returns
> false, then we need to do more work. Of course that means modules will also
> trigger this. We could check __is_module_text() but that does a bit more
> work and may cause too much overhead. But who knows, if the module check is
> only done if the __is_kernel() check fails, maybe it's not that bad.

I do like very much that idea, but it requires that we be able to identify
this instruction pointer perfectly, no matter what.  It might also require
that we be able to perfectly identify any IRQ return addresses as well,
for example, if the preemption was triggered within an interrupt handler.
And interrupts from softirq environments might require identifying an
additional level of IRQ return address.  The original IRQ might have
interrupted a trampoline, and then after transitioning into softirq,
another IRQ might also interrupt a trampoline, and this last IRQ handler
might have instigated a preemption.

Are there additional levels or mechanisms requiring identifying
return addresses?

For whatever it is worth, and in case it should prove necessary,
I have added a sneak preview of the Kconfig workaround at the end of
this message.

							Thanx, Paul

> -- Steve
> 
> > 
> > o	Check for being preempted within a trampoline, and track this
> > 	within the tasks structure.  The disadvantage here is that this
> > 	requires keeping track of all of the trampolines and adding a
> > 	check for being in one on a scheduler fast path.
> > 
> > o	Have a variant of Tasks RCU which checks the stack of preempted
> > 	tasks, waiting until all have been seen without being preempted
> > 	in a trampoline.  This still requires keeping track of all the
> > 	trampolines in an easy-to-search manner, but gets the overhead
> > 	of searching off of the scheduler fastpaths.
> > 
> > 	It is also necessary to check running tasks, which might have
> > 	been interrupted from within a trampoline.
> > 
> > 	I would have a hard time convincing myself that these return
> > 	addresses were unconditionally reliable.  But maybe they are?
> > 
> > o	Your idea here!
> > 
> > Again, the short-term workaround is to remove the "if PREEMPTIBLE" from
> > all of the "select TASKS_RCU" clauses.
> > 
> > > > > My next step is to try this on bare metal on a system configured as
> > > > > is the fleet.  But good progress for a week!!!  
> > > > 
> > > > Yeah this is great. Fingers crossed for the wider set of tests.  
> > > 
> > > I got what might be a one-off when hitting rcutorture and KASAN harder.
> > > I am running 320*TRACE01 to see if it reproduces.  
> > 
> > [ . . . ]
> > 
> > > So, first see if it is reproducible, second enable more diagnostics,
> > > third make more grace-period sequence numbers available to rcutorture,
> > > fourth recheck the diagnostics code, and then see where we go from there.
> > > It might be that lazy preemption needs adjustment, or it might be that
> > > it just tickled latent diagnostic issues in rcutorture.
> > > 
> > > (I rarely hit this WARN_ON() except in early development, when the
> > > problem is usually glaringly obvious, hence all the uncertainty.)  
> > 
> > And it is eminently reproducible.  Digging into it...

diff --git a/arch/Kconfig b/arch/Kconfig
index c91917b508736..154f994547632 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -55,7 +55,7 @@ config KPROBES
 	depends on MODULES
 	depends on HAVE_KPROBES
 	select KALLSYMS
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
@@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
 config OPTPROBES
 	def_bool y
 	depends on KPROBES && HAVE_OPTPROBES
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 
 config KPROBES_ON_FTRACE
 	def_bool y
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 6a906ff930065..ce9fbc3b27ecf 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -27,7 +27,7 @@ config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
 	select IRQ_WORK
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 	select TASKS_TRACE_RCU
 	select BINARY_PRINTF
 	select NET_SOCK_MSG if NET
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 7dca0138260c3..3e079de0f5b43 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -85,9 +85,13 @@ config FORCE_TASKS_RCU
 	  idle, and user-mode execution as quiescent states.  Not for
 	  manual selection in most cases.
 
-config TASKS_RCU
+config NEED_TASKS_RCU
 	bool
 	default n
+
+config TASKS_RCU
+	bool
+	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
 	select IRQ_WORK
 
 config FORCE_TASKS_RUDE_RCU
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596d..6cdc5ff919b09 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -163,7 +163,7 @@ config TRACING
 	select BINARY_PRINTF
 	select EVENT_TRACING
 	select TRACE_CLOCK
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 
 config GENERIC_TRACER
 	bool
@@ -204,7 +204,7 @@ config FUNCTION_TRACER
 	select GENERIC_TRACER
 	select CONTEXT_SWITCH_TRACER
 	select GLOB
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 	select TASKS_RUDE_RCU
 	help
 	  Enable the kernel to trace every kernel function. This is done

