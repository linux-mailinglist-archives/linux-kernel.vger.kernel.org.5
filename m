Return-Path: <linux-kernel+bounces-100300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30F9879540
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132001C2194B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08077A15A;
	Tue, 12 Mar 2024 13:42:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA22AE66;
	Tue, 12 Mar 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250961; cv=none; b=rBQ9c+YnnrZ5t5FnX1jeqakkiocaE/6ae95tBa/0xCdr8NTa0ZvUPWvqfc/FhjuQQule7Wm5exNdpAhBIFkh7RT9FDL2IkMvrmo+42Qpl27hXPgg8nDzpI2CEwDjd5Khj9CX2BLAR67JP5EOc3mPMuZgZ3uuFihQebzBAIYZjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250961; c=relaxed/simple;
	bh=ObYGB8T5nuRNWsZgRFUd+ZoV0/TpnhIVjozczQJugAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDsSzfUmRjoaPAg4pEaRZrtLoVDiPn1vgTcfCi9mw6SdTxDxrWmSxNWmjl07KcNQrUyW1fEApSNw4jCxrJsoLZcjOWFtB5f4aBlsLnJLyKypEt4MTsXfZO5t7/T4SsslgLRxZICcKgf2M3Eu2TYnRVGgZOOoHzWIVfotfXbyj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31EAE1007;
	Tue, 12 Mar 2024 06:43:15 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.69.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E9313F762;
	Tue, 12 Mar 2024 06:42:34 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:42:28 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Bj\"orn T\"opel" <bjorn@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Guo Ren <guoren@kernel.org>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	"Bj\"orn T\"opel" <bjorn@rivosinc.com>,
	Song Shuai <suagrfillet@gmail.com>,
	Cl'ement L'eger <cleger@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>

Hi Bjorn

(apologies, my corporate mail server has butchered your name here).

There's a big info dump below; I realise this sounds like a sales pitch for
CALL_OPS, but my intent is more to say "here are some dragons you may not have
spotted".

On Thu, Mar 07, 2024 at 08:27:40PM +0100, Bj"orn T"opel wrote:
> Puranjay!
> 
> Puranjay Mohan <puranjay12@gmail.com> writes:
> 
> > This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
> > This allows each ftrace callsite to provide an ftrace_ops to the common
> > ftrace trampoline, allowing each callsite to invoke distinct tracer
> > functions without the need to fall back to list processing or to
> > allocate custom trampolines for each callsite. This significantly speeds
> > up cases where multiple distinct trace functions are used and callsites
> > are mostly traced by a single tracer.
> >
> > The idea and most of the implementation is taken from the ARM64's
> > implementation of the same feature. The idea is to place a pointer to
> > the ftrace_ops as a literal at a fixed offset from the function entry
> > point, which can be recovered by the common ftrace trampoline.
> 
> Not really a review, but some more background; Another rationale (on-top
> of the improved per-call performance!) for CALL_OPS was to use it to
> build ftrace direct call support (which BPF uses a lot!). Mark, please
> correct me if I'm lying here!

Yep; it gives us the ability to do a number of per-callsite things, including
direct calls.

> On Arm64, CALL_OPS makes it possible to implement direct calls, while
> only patching one BL instruction -- nice!

The key thing here isn't that we patch a single instruction (since we have ot
patch the ops pointer too!); it's that we can safely patch either of the ops
pointer or BL/NOP at any time while threads are concurrently executing.

If you have a multi-instruction sequence, then threads can be preempted
mid-sequence, and it's very painful/complex to handle all of the races that
entails.

For example, if your callsites use a sequence:

	AUIPC <tmp>, <funcptr>
	JALR <tmp2>, <funcptr>(<tmp>)

Using stop_machine() won't allow you to patch that safely as some threads
could be stuck mid-sequence, e.g.

	AUIPC <tmp>, <funcptr>
	[ preempted here ]
	JALR <tmp2>, <funcptr>(<tmp>)

.. and you can't update the JALR to use a new funcptr immediate until those
have completed the sequence.

There are ways around that, but they're complicated and/or expensive, e.g.

* Use a sequence of multiple patches, starting with replacing the JALR with an
  exception-generating instruction with a fixup handler, which is sort-of what
  x86 does with UD2. This may require multiple passes with
  synchronize_rcu_tasks() to make sure all threads have seen the latest
  instructions, and that cannot be done under stop_machine(), so if you need
  stop_machine() for CMODx reasons, you may need to use that several times with
  intervening calls to synchronize_rcu_tasks().

* Have the patching logic manually go over each thread and fix up the pt_regs
  for the interrupted thread. This is pretty horrid since you could have nested
  exceptions and a task could have several pt_regs which might require
  updating.

The CALL_OPS approach is a bit easier to deal with as we can patch the
per-callsite pointer atomically, then we can (possibly) enable/disable the
callsite's branch, then wait for threads to drain once. 

As a heads-up, there are some latent/generic issues with DYNAMIC_FTRACE
generally in this area (CALL_OPs happens to side-step those, but trampoline
usage is currently affected):

  https://lore.kernel.org/lkml/Zenx_Q0UiwMbSAdP@FVFF77S0Q05N/

.. I'm looking into fixing that at the moment, and it looks like that's likely
to require some per-architecture changes.

> On RISC-V we cannot use use the same ideas as Arm64 straight off,
> because the range of jal (compare to BL) is simply too short (+/-1M).
> So, on RISC-V we need to use a full auipc/jal pair (the text patching
> story is another chapter, but let's leave that aside for now). Since we
> have to patch multiple instructions, the cmodx situation doesn't really
> improve with CALL_OPS.

The branch range thing is annoying, but I think this boils down to the same
problem as arm64 has with needing a "MOV <tmp>, LR" instruction that we have to
patch in once at boot time. You could do the same and patch in the AUIPC once,
e.g. have

| 	NOP
| 	NOP 
| func:
| 	AUIPC <tmp>, <common_ftrace_caller>
| 	JALR <tmp2>, <common_ftrace_caller>(<tmp>) // patched with NOP

.. which'd look very similar to arm64's sequence:

| 	NOP
| 	NOP
| func:
| 	MOV X9, LR
| 	BL ftrace_caller // patched with NOP

.. which I think means it *might* be better from a cmodx perspective?

> Let's say that we continue building on your patch and implement direct
> calls on CALL_OPS for RISC-V as well.
> 
> From Florent's commit message for direct calls:
> 
>   |    There are a few cases to distinguish:
>   |    - If a direct call ops is the only one tracing a function:
>   |      - If the direct called trampoline is within the reach of a BL
>   |        instruction
>   |         -> the ftrace patchsite jumps to the trampoline
>   |      - Else
>   |         -> the ftrace patchsite jumps to the ftrace_caller trampoline which
>   |            reads the ops pointer in the patchsite and jumps to the direct
>   |            call address stored in the ops
>   |    - Else
>   |      -> the ftrace patchsite jumps to the ftrace_caller trampoline and its
>   |         ops literal points to ftrace_list_ops so it iterates over all
>   |         registered ftrace ops, including the direct call ops and calls its
>   |         call_direct_funcs handler which stores the direct called
>   |         trampoline's address in the ftrace_regs and the ftrace_caller
>   |         trampoline will return to that address instead of returning to the
>   |         traced function
> 
> On RISC-V, where auipc/jalr is used, the direct called trampoline would
> always be reachable, and then first Else-clause would never be entered.
> This means the the performance for direct calls would be the same as the
> one we have today (i.e. no regression!).
> 
> RISC-V does like x86 does (-ish) -- patch multiple instructions, long
> reach.
> 
> Arm64 uses CALL_OPS and patch one instruction BL.
> 
> Now, with this background in mind, compared to what we have today,
> CALL_OPS would give us (again assuming we're using it for direct calls):
> 
> * Better performance for tracer per-call (faster ops lookup) GOOD
> * Larger text size (function alignment + extra nops) BAD
> * Same direct call performance NEUTRAL
> * Same complicated text patching required NEUTRAL

Is your current sequence safe for preemptible kernels (i.e. with PREEMPT_FULL=y
or PREEMPT_DYNAMIC=y + "preempt=full" on the kernel cmdline) ?

Looking at v6.8, IIUC you have:

	// unpatched		//patched
	NOP			AUIPC
	NOP			JALR

What prevents a thread being preempted mid-sequence such that it executes:

	NOP
	[ preempted ]
	[ stop_machine() used to patch text ]
	[ restored ]
	JALR

.. ?

.. or when changing the call:

	AUIPC		// old funcptr
	[ preempted ]
	[ stop_machine() used to patch text ]
	[ restored ]
	JALR		// new funcptr
.. ?

I suspect those might both be broken, but it's difficult to hit the race and so
testing hasn't revealed that so far.

> It would be interesting to see how the per-call performance would
> improve on x86 with CALL_OPS! ;-)

Heh. ;)

> I'm trying to wrap my head if it makes sense to have it on RISC-V, given
> that we're a bit different from Arm64. Does the scale tip to the GOOD
> side?
>
> Oh, and we really need to see performance numbers on real HW! I have a
> VF2 that I could try this series on.

I'll have to leave those two to you. I suspect the preempt/stop_machine()
might just tip that from NEUTRAL to GOOD.

Mark.

