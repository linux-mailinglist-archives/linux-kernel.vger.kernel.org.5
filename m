Return-Path: <linux-kernel+bounces-101433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3055187A70A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553431C224FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D443FB01;
	Wed, 13 Mar 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBd4F6Yz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C33F9C3;
	Wed, 13 Mar 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329000; cv=none; b=BMbXTagCkgH3DrI5bzEBYghTWosrmK8vCiK451/atA7blV5OQibauqz8e+QG9TOUpwbFVDYNp8eaSNZypmHMdUOtobFAamk2O6VbeP0+5bS3UpgtPBVphwyJDLM4VENlfdTzTeqmsAahg4/rT+T68t9RAv119PC78WB3soHJ9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329000; c=relaxed/simple;
	bh=ky5paA1va6E/CB36kmKyUjj55I5Een4JO/KffX7kyUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RBI8vZe81zhnAhnRcPRDo1Ojhhm/7XKe0b7dvV4C66v5cso9gofXt670quGIwWxEhQn02ikX3vMbEjDvnibTb6eqT0exRa+WFfxgySlPnmezSoATJIjjvSP3nAyX3l0ck4aQI7NOGGIIDNyCU5CjC7+bLOYmoQ4JuHaTmYVb/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBd4F6Yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB280C43142;
	Wed, 13 Mar 2024 11:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710329000;
	bh=ky5paA1va6E/CB36kmKyUjj55I5Een4JO/KffX7kyUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fBd4F6YzojExJlnfzCYHDFtrR/a1ZSZmUkbTjObXd3K8AhMykeUsIoiXxW6pmSu4R
	 1ScK2MPSbm3BqIdwYBu0eCZmJP+P+r+xNLfWtsFneiOeC2L8BY6oHE1lVwYi6/gqs3
	 yANcB+zEVO6khJF/7W/gkb5jMFMq91QzOBneywVPWPp9E3ryWBRNx57HUjIa4OfAUz
	 hKMdyha3G7KcKATqDCtadxLFa4gS8au6cHxFOxA71VUwIKGoThcaaW+iKPL5J78qKd
	 8+oX6nBrhECAmqZG22RkOaTOgJm5FVwttpqsRwrYZCQksK08UIzmUfjLdWibmi2YcY
	 5s/mrfR62XSqA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Bj"orn T"opel <bjorn@rivosinc.com>, Song
 Shuai <suagrfillet@gmail.com>, Cl'ement L'eger <cleger@rivosinc.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
In-Reply-To: <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
Date: Wed, 13 Mar 2024 12:23:06 +0100
Message-ID: <8734suqsth.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mark Rutland <mark.rutland@arm.com> writes:

> Hi Bjorn
>
> (apologies, my corporate mail server has butchered your name here).

Ha! That's the price I have to pay for carrying double-umlauts
everywhere. Thanks for getting back with a really useful answer!

>> On Arm64, CALL_OPS makes it possible to implement direct calls, while
>> only patching one BL instruction -- nice!
>
> The key thing here isn't that we patch a single instruction (since we hav=
e ot
> patch the ops pointer too!); it's that we can safely patch either of the =
ops
> pointer or BL/NOP at any time while threads are concurrently executing.

..which indeed is a very nice property!

> If you have a multi-instruction sequence, then threads can be preempted
> mid-sequence, and it's very painful/complex to handle all of the races th=
at
> entails.

Oh yes. RISC-V is currently using auipc/jalr with stop_machine(), and
also requires that preemtion is off. Unusable to put it blunt.

> For example, if your callsites use a sequence:
>
> 	AUIPC <tmp>, <funcptr>
> 	JALR <tmp2>, <funcptr>(<tmp>)
>
> Using stop_machine() won't allow you to patch that safely as some threads
> could be stuck mid-sequence, e.g.
>
> 	AUIPC <tmp>, <funcptr>
> 	[ preempted here ]
> 	JALR <tmp2>, <funcptr>(<tmp>)
>
> ... and you can't update the JALR to use a new funcptr immediate until th=
ose
> have completed the sequence.
>
> There are ways around that, but they're complicated and/or expensive, e.g.
>
> * Use a sequence of multiple patches, starting with replacing the JALR wi=
th an
>   exception-generating instruction with a fixup handler, which is sort-of=
 what
>   x86 does with UD2. This may require multiple passes with
>   synchronize_rcu_tasks() to make sure all threads have seen the latest
>   instructions, and that cannot be done under stop_machine(), so if you n=
eed
>   stop_machine() for CMODx reasons, you may need to use that several time=
s with
>   intervening calls to synchronize_rcu_tasks().
>
> * Have the patching logic manually go over each thread and fix up the pt_=
regs
>   for the interrupted thread. This is pretty horrid since you could have =
nested
>   exceptions and a task could have several pt_regs which might require
>   updating.

Yup, and both of these have rather unplesant overhead.

> The CALL_OPS approach is a bit easier to deal with as we can patch the
> per-callsite pointer atomically, then we can (possibly) enable/disable the
> callsite's branch, then wait for threads to drain once.=20
>
> As a heads-up, there are some latent/generic issues with DYNAMIC_FTRACE
> generally in this area (CALL_OPs happens to side-step those, but trampoli=
ne
> usage is currently affected):
>
>   https://lore.kernel.org/lkml/Zenx_Q0UiwMbSAdP@FVFF77S0Q05N/
>
> ... I'm looking into fixing that at the moment, and it looks like that's =
likely
> to require some per-architecture changes.
>
>> On RISC-V we cannot use use the same ideas as Arm64 straight off,
>> because the range of jal (compare to BL) is simply too short (+/-1M).
>> So, on RISC-V we need to use a full auipc/jal pair (the text patching
>> story is another chapter, but let's leave that aside for now). Since we
>> have to patch multiple instructions, the cmodx situation doesn't really
>> improve with CALL_OPS.
>
> The branch range thing is annoying, but I think this boils down to the sa=
me
> problem as arm64 has with needing a "MOV <tmp>, LR" instruction that we h=
ave to
> patch in once at boot time. You could do the same and patch in the AUIPC =
once,
> e.g. have
>
> | 	NOP
> | 	NOP=20
> | func:
> | 	AUIPC <tmp>, <common_ftrace_caller>
> | 	JALR <tmp2>, <common_ftrace_caller>(<tmp>) // patched with NOP
>
> ... which'd look very similar to arm64's sequence:
>
> | 	NOP
> | 	NOP
> | func:
> | 	MOV X9, LR
> | 	BL ftrace_caller // patched with NOP
>
> ... which I think means it *might* be better from a cmodx perspective?
>
>> Let's say that we continue building on your patch and implement direct
>> calls on CALL_OPS for RISC-V as well.
>>=20
>> From Florent's commit message for direct calls:
>>=20
>>   |    There are a few cases to distinguish:
>>   |    - If a direct call ops is the only one tracing a function:
>>   |      - If the direct called trampoline is within the reach of a BL
>>   |        instruction
>>   |         -> the ftrace patchsite jumps to the trampoline
>>   |      - Else
>>   |         -> the ftrace patchsite jumps to the ftrace_caller trampolin=
e which
>>   |            reads the ops pointer in the patchsite and jumps to the d=
irect
>>   |            call address stored in the ops
>>   |    - Else
>>   |      -> the ftrace patchsite jumps to the ftrace_caller trampoline a=
nd its
>>   |         ops literal points to ftrace_list_ops so it iterates over all
>>   |         registered ftrace ops, including the direct call ops and cal=
ls its
>>   |         call_direct_funcs handler which stores the direct called
>>   |         trampoline's address in the ftrace_regs and the ftrace_caller
>>   |         trampoline will return to that address instead of returning =
to the
>>   |         traced function
>>=20
>> On RISC-V, where auipc/jalr is used, the direct called trampoline would
>> always be reachable, and then first Else-clause would never be entered.
>> This means the the performance for direct calls would be the same as the
>> one we have today (i.e. no regression!).
>>=20
>> RISC-V does like x86 does (-ish) -- patch multiple instructions, long
>> reach.
>>=20
>> Arm64 uses CALL_OPS and patch one instruction BL.
>>=20
>> Now, with this background in mind, compared to what we have today,
>> CALL_OPS would give us (again assuming we're using it for direct calls):
>>=20
>> * Better performance for tracer per-call (faster ops lookup) GOOD
>> * Larger text size (function alignment + extra nops) BAD
>> * Same direct call performance NEUTRAL
>> * Same complicated text patching required NEUTRAL
>
> Is your current sequence safe for preemptible kernels (i.e. with PREEMPT_=
FULL=3Dy
> or PREEMPT_DYNAMIC=3Dy + "preempt=3Dfull" on the kernel cmdline) ?

It's very much not, and was in-fact presented by Andy (Cc) discussed at
length at Plumbers two years back.

Hmm, depending on RISC-V's CMODX path, the pro/cons CALL_OPS vs dynamic
trampolines changes quite a bit.

The more I look at the pains of patching two instruction ("split
immediates"), the better "patch data" + one insn patching look.

I which we had longer instructions, that could fit a 48b address or
more! ;-)


Again, thanks for a thought provoking reply!
Bj=C3=B6rn

