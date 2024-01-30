Return-Path: <linux-kernel+bounces-43763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50368418A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E37B24B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBF5374EB;
	Tue, 30 Jan 2024 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No102ObB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E42376EC;
	Tue, 30 Jan 2024 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706579116; cv=none; b=jauVcVN/zbpnPDgYncgqAl1O04MCaUW3cpOemNH2wK9NX5/kovV8qn4Do+sktvfBeMDHzSBhITrAhy1HNLUmv3skeROu02MB4PD7/SZ/P61k96ms+JNtuk6LffTa8pfcMcfbfx1Hk0tZnn2UcWQJNPkYtQmDOhKO6jkM8Jzh+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706579116; c=relaxed/simple;
	bh=zMZgNGNJ/4QrveRNN1bD0SiAaoebGVCPihzQ3ckTAvQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZwOC/+VN4tCYHBSnIuSMsWn/66wj9T5hWjuHHYVv9ntYfcA53NbVI5TPb/jxncHU6NwdgrvnTO4C6Bl+5qBZmw2ig4eBLos8tbddJ9gA90VkJ/kBJmuFkMXLJ9sTc2M3ClDVDRWOTYN3J7G57PMgG3O7b0+smhtTyyL+rcu9OH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No102ObB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081ABC433B2;
	Tue, 30 Jan 2024 01:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706579116;
	bh=zMZgNGNJ/4QrveRNN1bD0SiAaoebGVCPihzQ3ckTAvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=No102ObB6r8N7DQ9fAQhYJfI79g+Kc3QU1VptOU6IHr9lV0IP/ClEzkE6Y/zzwmxu
	 MoBdmemd9QzC0oOFOAWM+6wegLfySKFQFDjyvdqY3b0SyEmNSSfiIM9o0ccsinQoSP
	 8dvRYsQMenV0puzU46fwjb9S3Aa9gQ/pIPIObTQpX9R3sNtrgkDoPUI16OeBTD613c
	 XNKY+4dcDxImhO2VQqzZnfhyLKC3ud4VfLNsTQpgO6hmXRIQFM46OUPxWVRGwABJM3
	 StqqmQErm9rRBRvOhDcSlkbY3NBQOmrOFl0jgFIxIVKz3xNCF2i9qqg+6zf6tJ/uGu
	 C+xvfAj94xDZA==
Date: Tue, 30 Jan 2024 10:45:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] x86/kprobes: boost more instructions from
 grp2/3/4/5
Message-Id: <20240130104512.3b64056130ca6c47e0bceb19@kernel.org>
In-Reply-To: <9aace649-8a84-46ba-9092-0b74523147f0@illinois.edu>
References: <20240127044124.57594-1-jinghao7@illinois.edu>
	<20240127044124.57594-3-jinghao7@illinois.edu>
	<20240128112218.5501726d17ac2fde2502da44@kernel.org>
	<9aace649-8a84-46ba-9092-0b74523147f0@illinois.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 15:30:50 -0600
Jinghao Jia <jinghao7@illinois.edu> wrote:

> 
> 
> On 1/27/24 20:22, Masami Hiramatsu (Google) wrote:
> > On Fri, 26 Jan 2024 22:41:24 -0600
> > Jinghao Jia <jinghao7@illinois.edu> wrote:
> > 
> >> With the instruction decoder, we are now able to decode and recognize
> >> instructions with opcode extensions. There are more instructions in
> >> these groups that can be boosted:
> >>
> >> Group 2: ROL, ROR, RCL, RCR, SHL/SAL, SHR, SAR
> >> Group 3: TEST, NOT, NEG, MUL, IMUL, DIV, IDIV
> >> Group 4: INC, DEC (byte operation)
> >> Group 5: INC, DEC (word/doubleword/quadword operation)
> >>
> >> These instructions are not boosted previously because there are reserved
> >> opcodes within the groups, e.g., group 2 with ModR/M.nnn == 110 is
> >> unmapped. As a result, kprobes attached to them requires two int3 traps
> >> as being non-boostable also prevents jump-optimization.
> >>
> >> Some simple tests on QEMU show that after boosting and jump-optimization
> >> a single kprobe on these instructions with an empty pre-handler runs 10x
> >> faster (~1000 cycles vs. ~100 cycles).
> >>
> >> Since these instructions are mostly ALU operations and do not touch
> >> special registers like RIP, let's boost them so that we get the
> >> performance benefit.
> >>
> > 
> > As far as we check the ModR/M byte, I think we can safely run these
> > instructions on trampoline buffer without adjusting results (this
> > means it can be "boosted").
> > I just have a minor comment, but basically this looks good to me.
> > 
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> >> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> >> ---
> >>  arch/x86/kernel/kprobes/core.c | 21 +++++++++++++++------
> >>  1 file changed, 15 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> >> index 792b38d22126..f847bd9cc91b 100644
> >> --- a/arch/x86/kernel/kprobes/core.c
> >> +++ b/arch/x86/kernel/kprobes/core.c
> >> @@ -169,22 +169,31 @@ int can_boost(struct insn *insn, void *addr)
> >>  	case 0x62:		/* bound */
> >>  	case 0x70 ... 0x7f:	/* Conditional jumps */
> >>  	case 0x9a:		/* Call far */
> >> -	case 0xc0 ... 0xc1:	/* Grp2 */
> >>  	case 0xcc ... 0xce:	/* software exceptions */
> >> -	case 0xd0 ... 0xd3:	/* Grp2 */
> >>  	case 0xd6:		/* (UD) */
> >>  	case 0xd8 ... 0xdf:	/* ESC */
> >>  	case 0xe0 ... 0xe3:	/* LOOP*, JCXZ */
> >>  	case 0xe8 ... 0xe9:	/* near Call, JMP */
> >>  	case 0xeb:		/* Short JMP */
> >>  	case 0xf0 ... 0xf4:	/* LOCK/REP, HLT */
> >> -	case 0xf6 ... 0xf7:	/* Grp3 */
> >> -	case 0xfe:		/* Grp4 */
> >>  		/* ... are not boostable */
> >>  		return 0;
> >> +	case 0xc0 ... 0xc1:	/* Grp2 */
> >> +	case 0xd0 ... 0xd3:	/* Grp2 */
> >> +		/* ModR/M nnn == 110 is reserved */
> >> +		return X86_MODRM_REG(insn->modrm.bytes[0]) != 6;
> >> +	case 0xf6 ... 0xf7:	/* Grp3 */
> >> +		/* ModR/M nnn == 001 is reserved */
> > 
> > 		/* AMD uses nnn == 001 as TEST, but Intel makes it reserved. */
> > 
> 
> I will incorporate this into the v2. Since nnn == 001 is still considered
> reserved by Intel, we still need to prevent it from being boosted, don't
> we?
> 
> --Jinghao
> 
> >> +		return X86_MODRM_REG(insn->modrm.bytes[0]) != 1;
> >> +	case 0xfe:		/* Grp4 */
> >> +		/* Only inc and dec are boostable */
> >> +		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0 ||
> >> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 1;
> >>  	case 0xff:		/* Grp5 */
> >> -		/* Only indirect jmp is boostable */
> >> -		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
> >> +		/* Only inc, dec, and indirect jmp are boostable */
> >> +		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0 ||
> >> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 1 ||
> >> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
> >>  	default:
> >>  		return 1;
> >>  	}
> >> -- 
> >> 2.43.0
> >>
> > 
> > Thamnk you,
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

