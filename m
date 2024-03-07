Return-Path: <linux-kernel+bounces-96104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6860487571E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255FA284A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C1136663;
	Thu,  7 Mar 2024 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id5sNgCh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8310B13664B;
	Thu,  7 Mar 2024 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839664; cv=none; b=d2VpUvRUn5B7w3OicBS+6ZatStJBRnKk5DmqVDT7UwMenkexwkOVnGFUjpdhAlr16Du3/WW6lWkjM1F+a0F7tpB8tqcsDNKrTe6CEpEoxtMp+FTOa/xUb/OGlIqsZ9KsK1cKe6wt/wkRAcaMZFL2oAW0dxl/mT66Il8Dg3uhekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839664; c=relaxed/simple;
	bh=wSn0lMhiUdEJLAQ/CSKSPIkdVmeocFWCR58yeTReo/c=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLXn5DSpxc1LuiGM84L8OOXNpoWg36jnu3DR7/nCMJkmbskBji/gD0wnysmHTN7U/XVKB9AQ9QmGJs12U0fLMkziE/H0n+OMUFDxP9S/CoAglSCBtAiwCsIFd6hrhMjR7Kf8kF/6Ziz5foI453frwM3llKthYE4mdVW61L8Iafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id5sNgCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB9AC433C7;
	Thu,  7 Mar 2024 19:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709839664;
	bh=wSn0lMhiUdEJLAQ/CSKSPIkdVmeocFWCR58yeTReo/c=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=id5sNgChAhaoQLDntlupIrGJSiOWSOR4JIwhpsVeqDXWj/Dq+S2VSGsFNjQt6KOUr
	 Wqiv0QK+W7Wjx6WK3ab84PxhhP9xOLYhHqg+tEneqwFVsK7tIRESRyeEE9DOBmLORB
	 V9yZT0H+meLNW5IQ7oKJMIiRfove7Dv4nD/s/Pm+8+dHaA8O8nkYiiA9rraHhf/dPP
	 U3j5GPHj5WwIZ6Jif74NqUVF122MJFxZqrkcvfnyHBVdSVDaaLiFzdD4udnWQSvoe8
	 BjjX795BUeizOXtUNkfkfJL4y6jh0RBfMmKlzwGlkpRMVFC6hO5c5C4/5UvNQTMXWt
	 ael/BswBzXpPA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sami
 Tolvanen <samitolvanen@google.com>, Guo Ren <guoren@kernel.org>, Puranjay
 Mohan <puranjay12@gmail.com>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Song
 Shuai <suagrfillet@gmail.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@rivosinc.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
In-Reply-To: <20240306165904.108141-1-puranjay12@gmail.com>
References: <20240306165904.108141-1-puranjay12@gmail.com>
Date: Thu, 07 Mar 2024 20:27:40 +0100
Message-ID: <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay!

Puranjay Mohan <puranjay12@gmail.com> writes:

> This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
> This allows each ftrace callsite to provide an ftrace_ops to the common
> ftrace trampoline, allowing each callsite to invoke distinct tracer
> functions without the need to fall back to list processing or to
> allocate custom trampolines for each callsite. This significantly speeds
> up cases where multiple distinct trace functions are used and callsites
> are mostly traced by a single tracer.
>
> The idea and most of the implementation is taken from the ARM64's
> implementation of the same feature. The idea is to place a pointer to
> the ftrace_ops as a literal at a fixed offset from the function entry
> point, which can be recovered by the common ftrace trampoline.

Not really a review, but some more background; Another rationale (on-top
of the improved per-call performance!) for CALL_OPS was to use it to
build ftrace direct call support (which BPF uses a lot!). Mark, please
correct me if I'm lying here!

On Arm64, CALL_OPS makes it possible to implement direct calls, while
only patching one BL instruction -- nice!

On RISC-V we cannot use use the same ideas as Arm64 straight off,
because the range of jal (compare to BL) is simply too short (+/-1M).
So, on RISC-V we need to use a full auipc/jal pair (the text patching
story is another chapter, but let's leave that aside for now). Since we
have to patch multiple instructions, the cmodx situation doesn't really
improve with CALL_OPS.

Let's say that we continue building on your patch and implement direct
calls on CALL_OPS for RISC-V as well.

From Florent's commit message for direct calls:

  |    There are a few cases to distinguish:
  |    - If a direct call ops is the only one tracing a function:
  |      - If the direct called trampoline is within the reach of a BL
  |        instruction
  |         -> the ftrace patchsite jumps to the trampoline
  |      - Else
  |         -> the ftrace patchsite jumps to the ftrace_caller trampoline w=
hich
  |            reads the ops pointer in the patchsite and jumps to the dire=
ct
  |            call address stored in the ops
  |    - Else
  |      -> the ftrace patchsite jumps to the ftrace_caller trampoline and =
its
  |         ops literal points to ftrace_list_ops so it iterates over all
  |         registered ftrace ops, including the direct call ops and calls =
its
  |         call_direct_funcs handler which stores the direct called
  |         trampoline's address in the ftrace_regs and the ftrace_caller
  |         trampoline will return to that address instead of returning to =
the
  |         traced function

On RISC-V, where auipc/jalr is used, the direct called trampoline would
always be reachable, and then first Else-clause would never be entered.
This means the the performance for direct calls would be the same as the
one we have today (i.e. no regression!).

RISC-V does like x86 does (-ish) -- patch multiple instructions, long
reach.

Arm64 uses CALL_OPS and patch one instruction BL.

Now, with this background in mind, compared to what we have today,
CALL_OPS would give us (again assuming we're using it for direct calls):

* Better performance for tracer per-call (faster ops lookup) GOOD
* Larger text size (function alignment + extra nops) BAD
* Same direct call performance NEUTRAL
* Same complicated text patching required NEUTRAL

It would be interesting to see how the per-call performance would
improve on x86 with CALL_OPS! ;-)

I'm trying to wrap my head if it makes sense to have it on RISC-V, given
that we're a bit different from Arm64. Does the scale tip to the GOOD
side?

Oh, and we really need to see performance numbers on real HW! I have a
VF2 that I could try this series on.


Bj=C3=B6rn

