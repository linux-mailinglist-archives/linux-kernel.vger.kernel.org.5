Return-Path: <linux-kernel+bounces-98082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A738774D0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EC41C20992
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D01D1115;
	Sun, 10 Mar 2024 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI3jRqHX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D856EC5;
	Sun, 10 Mar 2024 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710034681; cv=none; b=QHq0tVGHB6IzYbD70rpGhlqcCqtE5NLoP8J+kLo7JCdN/Q4P8SIRGoEiSqPRHN4cHiMi2eZ8sRYzLUY8QxnwRcWDd9pVVbYXFqfCp4hMkMLm8K14+rcnvYfJ9PaIUM+UVVIwMt9jFJV0D4r1rBM46b7CC5K3KJ4JRt4wQQHWTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710034681; c=relaxed/simple;
	bh=mLysYKJMnp+csqFKfyy0BM0x56EkfLIUO0ZrRPScLJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw1AFhlLFUVXnlWpzOcJzbXrJ/V+bg2RHVt7QCdTe6YG8y86vI22/Oqly9WfRAOsN149gpWAmpCAypFVGO8ZbxNvchL9BYRQ9fJp0Eph6AdXKENNtWiXB7MvJIY9/ohMPX+dtnKHfJMxNeaAydcMRw2oKMVdWyYGpSoTxhUOTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI3jRqHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC111C433F1;
	Sun, 10 Mar 2024 01:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710034680;
	bh=mLysYKJMnp+csqFKfyy0BM0x56EkfLIUO0ZrRPScLJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VI3jRqHX/kHfxrP0VnhRu3y7u0mu3xQ8TIoyJmBFZNx941GnzQV8toeJaP36FC+DH
	 HEueSM7E64MbMnMr60kH22/WYUmzgioKEc/Nck9e5kAsV61lW2RiuCH/50nyRVMpcU
	 znIT/4zIf/62xcCXme/FgoGoeQskQG4fvKXX79W9trkq69ZwsdfINM7xfySEoWrzmV
	 z+dhzvqVLAGAGt6UV2HfoRBlb9oNXl+ocV/hT5MoXiN33gD9bgnzIeRrJjPQ2+dtQx
	 qGH+rfFK4oaBpurYC0XVJDase4EAC8qoDeegclHz0svqH6+rftsXciktdh5Vn6vXCf
	 bTWzAWA/P6V9A==
Date: Sat, 9 Mar 2024 20:37:51 -0500
From: Guo Ren <guoren@kernel.org>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Song Shuai <suagrfillet@gmail.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <Ze0O77ze56DGffzD@gmail.com>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <CANk7y0gbQdYw0V+CEv-z8wFGXnki8KSn4c8+i0iZ1UFNCg7wJQ@mail.gmail.com>
 <CABgGipUJU_joVOjPi4WZ4JJM72zaSrCA1QUAaP8hob3+LXkS0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgGipUJU_joVOjPi4WZ4JJM72zaSrCA1QUAaP8hob3+LXkS0g@mail.gmail.com>

On Fri, Mar 08, 2024 at 05:18:21PM +0800, Andy Chiu wrote:
> Hi Puranjay,
> 
> On Fri, Mar 8, 2024 at 3:53 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >
> > Hi Björn,
> >
> > On Thu, Mar 7, 2024 at 8:27 PM Björn Töpel <bjorn@kernel.org> wrote:
> > >
> > > Puranjay!
> > >
> > > Puranjay Mohan <puranjay12@gmail.com> writes:
> > >
> > > > This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
> > > > This allows each ftrace callsite to provide an ftrace_ops to the common
> > > > ftrace trampoline, allowing each callsite to invoke distinct tracer
> > > > functions without the need to fall back to list processing or to
> > > > allocate custom trampolines for each callsite. This significantly speeds
> > > > up cases where multiple distinct trace functions are used and callsites
> > > > are mostly traced by a single tracer.
> > > >
> > > > The idea and most of the implementation is taken from the ARM64's
> > > > implementation of the same feature. The idea is to place a pointer to
> > > > the ftrace_ops as a literal at a fixed offset from the function entry
> > > > point, which can be recovered by the common ftrace trampoline.
> > >
> > > Not really a review, but some more background; Another rationale (on-top
> > > of the improved per-call performance!) for CALL_OPS was to use it to
> > > build ftrace direct call support (which BPF uses a lot!). Mark, please
> > > correct me if I'm lying here!
> > >
> > > On Arm64, CALL_OPS makes it possible to implement direct calls, while
> > > only patching one BL instruction -- nice!
> > >
> > > On RISC-V we cannot use use the same ideas as Arm64 straight off,
> > > because the range of jal (compare to BL) is simply too short (+/-1M).
> > > So, on RISC-V we need to use a full auipc/jal pair (the text patching
> > > story is another chapter, but let's leave that aside for now). Since we
> > > have to patch multiple instructions, the cmodx situation doesn't really
> > > improve with CALL_OPS.
> > >
> > > Let's say that we continue building on your patch and implement direct
> > > calls on CALL_OPS for RISC-V as well.
> > >
> > > From Florent's commit message for direct calls:
> > >
> > >   |    There are a few cases to distinguish:
> > >   |    - If a direct call ops is the only one tracing a function:
> > >   |      - If the direct called trampoline is within the reach of a BL
> > >   |        instruction
> > >   |         -> the ftrace patchsite jumps to the trampoline
> > >   |      - Else
> > >   |         -> the ftrace patchsite jumps to the ftrace_caller trampoline which
> > >   |            reads the ops pointer in the patchsite and jumps to the direct
> > >   |            call address stored in the ops
> > >   |    - Else
> > >   |      -> the ftrace patchsite jumps to the ftrace_caller trampoline and its
> > >   |         ops literal points to ftrace_list_ops so it iterates over all
> > >   |         registered ftrace ops, including the direct call ops and calls its
> > >   |         call_direct_funcs handler which stores the direct called
> > >   |         trampoline's address in the ftrace_regs and the ftrace_caller
> > >   |         trampoline will return to that address instead of returning to the
> > >   |         traced function
> > >
> > > On RISC-V, where auipc/jalr is used, the direct called trampoline would
> > > always be reachable, and then first Else-clause would never be entered.
> > > This means the the performance for direct calls would be the same as the
> > > one we have today (i.e. no regression!).
> > >
> > > RISC-V does like x86 does (-ish) -- patch multiple instructions, long
> > > reach.
> > >
> > > Arm64 uses CALL_OPS and patch one instruction BL.
> > >
> > > Now, with this background in mind, compared to what we have today,
> > > CALL_OPS would give us (again assuming we're using it for direct calls):
> > >
> > > * Better performance for tracer per-call (faster ops lookup) GOOD
> >
> > ^ this was the only motivation for me to implement this patch.
> >
> > I don't think implementing direct calls over call ops is fruitful for
> > RISC-V because once
> > the auipc/jalr can be patched atomically, the direct call trampoline
> > is always reachable.
> 
> Yes, the auipc/jalr instruction pair can be patched atomically just as
> long as their size is naturally aligned on. However, we cannot prevent
> 2 instructions from being fetched atomically :P
There are some micro-arch optimization methods here, such as:
 - Disable interrupt when auipc retired.
 - When auipc -> auipc, the second one still could cause an
   interruption.

> 
> > Solving the atomic text patching problem would be fun!! I am eager to
> > see how it will be
> > solved.
> 
> I have a patch series to solve the atomic code patching issue, which I
> am about to respin [1]. The idea is to solve it with yet another layer
> of indirection. We add a 8-B aligned space at each function entry. The
> space is a pointer to the ftrace entry. During boot, each function
> entry code is updated to perform a load and then take the jump from
> the 8-B space. When ftrace is disabled, we patch the first 4B-aligned
> instruction to a jump so as to skip the ftrace entry.
> 
> We are still discussing with Alex to see if we have a better way to do
> it. If not then I'd update the patchset and re-send it. There's a
> pending improvement in the series to reduce complexity. The 8-B
> aligned space can be added before the function entry (just like your
> patch).
> 
> >
> > > * Larger text size (function alignment + extra nops) BAD
> > > * Same direct call performance NEUTRAL
> > > * Same complicated text patching required NEUTRAL
> > >
> > > It would be interesting to see how the per-call performance would
> > > improve on x86 with CALL_OPS! ;-)
> >
> > If I remember from Steven's talk, x86 uses dynamically allocated trampolines
> > for per callsite tracers, would CALL_OPS provide better performance than that?
> >
> > >
> > > I'm trying to wrap my head if it makes sense to have it on RISC-V, given
> > > that we're a bit different from Arm64. Does the scale tip to the GOOD
> > > side?
> > >
> > > Oh, and we really need to see performance numbers on real HW! I have a
> > > VF2 that I could try this series on.
> >
> > It would be great if you can do it :D.
> >
> > Thanks,
> > Puranjay
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> - [1] https://yhbt.net/lore/all/CAJF2gTSn3_cDYsF9D8dt-br2Wf_M8y02A09xgRq8kXi91sN3Aw@mail.gmail.com/T/
> 
> Regards,
> Andy
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

