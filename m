Return-Path: <linux-kernel+bounces-9810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F365581CBB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220541C21556
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F22374E;
	Fri, 22 Dec 2023 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJjtql6P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB523747
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A02EC433C8;
	Fri, 22 Dec 2023 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703257493;
	bh=ff+11cBpb6fDBCxthTcpJKSANtb1FArJ8elQvMrgPHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJjtql6PY7v6wiyIpT1yxgYQQM+rkvq9l3L6YsVK2NGidGNbRyV32izlJirpUJ5Tn
	 +FlAIcWePB4Yg3H0zzXhOxLiXt9MXu4r48TlKwyaGn/JNhEFBj7YmJBxPSZvSvbDoz
	 OGW+BmTczlUXrUlGmyXvce7cCOFGeMJ2Q7H5PTIIIACi5/4v3wI5RVHVJ15GptOja3
	 a9rOLTCI3cxUPLzhskaMnahbEZv1rijKeduZTxiGR5KP8N5NKC3+DJOWTtuz4D1q6E
	 MSEmspMVzdkejDwf1tovy5x6EetYjUbxAnI1NEmlEv/CHXqJJtp3OXYn1WOovA2V1T
	 ox3pcwQ+09U4Q==
Date: Fri, 22 Dec 2023 20:31:08 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Florent Revest <revest@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 6/9] powerpc/ftrace: Update and move function profile
 instructions out-of-line
Message-ID: <thjuqdsy6a6oinxciztpao7nobop3j4pnd6xktnioriofad7lz@ue6bdz7wlqba>
References: <cover.1702045299.git.naveen@kernel.org>
 <39363eb6b1857f26f9fa51808ad48b0121899b84.1702045299.git.naveen@kernel.org>
 <e2e467a3-7283-4f22-8cd9-2d1875f60e92@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2e467a3-7283-4f22-8cd9-2d1875f60e92@csgroup.eu>

On Thu, Dec 21, 2023 at 10:46:08AM +0000, Christophe Leroy wrote:
> 
> 
> Le 08/12/2023 à 17:30, Naveen N Rao a écrit :
> > Function profile sequence on powerpc includes two instructions at the
> > beginning of each function:
> > 
> > 	mflr	r0
> > 	bl	ftrace_caller
> > 
> > The call to ftrace_caller() gets nop'ed out during kernel boot and is
> > patched in when ftrace is enabled.
> > 
> > There are two issues with this:
> > 1. The 'mflr r0' instruction at the beginning of each function remains
> >     even though ftrace is not being used.
> > 2. When ftrace is activated, we return from ftrace_caller() with a bctr
> >     instruction to preserve r0 and LR, resulting in the link stack
> >     becoming unbalanced.
> > 
> > To address (1), we have tried to nop'out the 'mflr r0' instruction when
> > nop'ing out the call to ftrace_caller() and restoring it when enabling
> > ftrace. But, that required additional synchronization slowing down
> > ftrace activation. It also left an additional nop instruction at the
> > beginning of each function and that wasn't desirable on 32-bit powerpc.
> > 
> > Instead of that, move the function profile sequence out-of-line leaving
> > a single nop at function entry. On ftrace activation, the nop is changed
> > to an unconditional branch to the out-of-line sequence that in turn
> > calls ftrace_caller(). This removes the need for complex synchronization
> > during ftrace activation and simplifies the code. More importantly, this
> > improves performance of the kernel when ftrace is not in use.
> > 
> > To address (2), change the ftrace trampoline to return with a 'blr'
> > instruction with the original return address in r0 intact. Then, an
> > additional 'mtlr r0' instruction in the function profile sequence can
> > move the correct return address back to LR.
> > 
> > With the above two changes, the function profile sequence now looks like
> > the following:
> > 
> >   [func:		# GEP -- 64-bit powerpc, optional
> > 	addis	r2,r12,imm1
> > 	addi	r2,r2,imm2]
> >    tramp:
> > 	mflr	r0
> > 	bl	ftrace_caller
> > 	mtlr	r0
> > 	b	func
> > 	nop
> > 	[nop]	# 64-bit powerpc only
> >    func:		# LEP
> > 	nop
> > 
> > On 32-bit powerpc, the ftrace mcount trampoline is now completely
> > outside the function. This is also the case on 64-bit powerpc for
> > functions that do not need a GEP. However, for functions that need a
> > GEP, the additional instructions are inserted between the GEP and the
> > LEP. Since we can only have a fixed number of instructions between GEP
> > and LEP, we choose to emit 6 instructions. Four of those instructions
> > are used for the function profile sequence and two instruction slots are
> > reserved for implementing support for DYNAMIC_FTRACE_WITH_CALL_OPS. On
> > 32-bit powerpc, we emit one additional nop for this purpose resulting in
> > a total of 5 nops before function entry.
> > 
> > To enable ftrace, the nop at function entry is changed to an
> > unconditional branch to 'tramp'. The call to ftrace_caller() may be
> > updated to ftrace_regs_caller() depending on the registered ftrace ops.
> > On 64-bit powerpc, we additionally change the instruction at 'tramp' to
> > 'mflr r0' from an unconditional branch back to func+4. This is so that
> > functions entered through the GEP can skip the function profile sequence
> > unless ftrace is enabled.
> > 
> > With the context_switch microbenchmark on a P9 machine, there is a
> > performance improvement of ~6% with this patch applied, going from 650k
> > context switches to 690k context switches without ftrace enabled. With
> > ftrace enabled, the performance was similar at 86k context switches.
> 
> Wondering how significant that context_switch micorbenchmark is.
> 
> I ran it on both mpc885 and mpc8321 and I'm a bit puzzled by some of the 
> results:
> # ./context_switch --no-fp
> Using threads with yield on cpus 0/0 touching FP:no altivec:no vector:no 
> vdso:no
> 
> On 885, I get the following results before and after your patch.
> 
> CONFIG_FTRACE not selected : 44,9k
> CONFIG_FTRACE selected, before : 32,8k
> CONFIG_FTRACE selected, after : 33,6k
> 
> All this is with CONFIG_INIT_STACK_ALL_ZERO which is the default. But 
> when I select CONFIG_INIT_STACK_NONE, the CONFIG_FTRACE not selected 
> result is only 34,4.
> 
> On 8321:
> 
> CONFIG_FTRACE not selected : 100,3k
> CONFIG_FTRACE selected, before : 72,5k
> CONFIG_FTRACE selected, after : 116k
> 
> So the results look odd to me.

That's indeed odd, though it looks to be showing good improvement. Are 
those numbers with/without the function tracer enabled?

Do you see more reasonable numbers if you use a different 
FUNCTION_ALIGNMENT?

> 
> > 
> > The downside of this approach is the increase in vmlinux size,
> > especially on 32-bit powerpc. We now emit 3 additional instructions for
> > each function (excluding the one or two instructions for supporting
> > DYNAMIC_FTRACE_WITH_CALL_OPS). On 64-bit powerpc with the current
> > implementation of -fpatchable-function-entry though, this is not
> > avoidable since we are forced to emit 6 instructions between the GEP and
> > the LEP even if we are to only support DYNAMIC_FTRACE_WITH_CALL_OPS.
> 
> The increase is almost 5% on the few 32 bits defconfig I have tested.  
> That's a lot.

Indeed. Note that one of those nops is for DYN_FTRACE_WITH_CALL_OPS, 
which we will need regardless.

Moving the ftrace mcount sequence out of line will alone need 2 
additional nops. 'mtlr r0' for balancing the link stack costs us one 
more nop.

> 
> On 32 bits powerpc, only the e500 has a link stack that could end up 
> being unbalanced. Could we keep the bctr and avoid the mtlr and the jump 
> in the trampoline ?
> 
> On 8xx a NOP is one cycle, a taken branch is 2 cycles, but the second 
> cycle is a bubble that most of the time gets filled by following 
> operations. On the 83xx, branches and NOPs are supposed to be seamless.
> 
> So is that out-of-line trampoline really worth it ? Maybe keeping the 
> ftrace instructions at the begining and just replacing the mflr by an 
> jump when ftrace is off would help reduce the ftrace insns by one more 
> instruction.

I was looking forward to your feedback w.r.t 32-bit powerpc since I 
couldn't test that.

We can certainly retain the existing behavior for ppc32, though it might 
make it harder to share the code base with ppc64.

The primary downside with the 'mflr r0' at function entry is that 
patching it out (or replacing it with a branch) will need additional
synchronization.

I'm out on vacation till end of the year. I plan on doing more tests 
once I am back to understand if the performance benefit is worth the 
increase in vmlinux size.


Thanks,
Naveen


