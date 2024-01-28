Return-Path: <linux-kernel+bounces-41511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C39C83F2FE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9101CB20F45
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7C1D527;
	Sun, 28 Jan 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRwawFlS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73ED50F;
	Sun, 28 Jan 2024 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408543; cv=none; b=TV2ObwjKNCl7Izg06/OOBiv+Kl4fcGpw622LduvkYUxkwF2vHoxnHDRVuDm728DMDbIBo3qSfa5hYVgB5ccEhOUOjQ7vEK/XeL6qYHNbe3KEe0gyUWHfbIsfz80ookG/Td5KagKYIEl9V+lfaAhrBA/nWRYRKj72x0W30p0X/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408543; c=relaxed/simple;
	bh=fmpywCD1VwV5A7MN7G8XJu/ucLi0MClww0i57yZt/Wo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=usFH9Tiz60rQsaWI8K1/+02Vur2SdS1q/WeXb8ehPCUQB3gIkb7LUfOuSyzSgfs2lAH0oPW5Z1Wt5N9LM8lAeyeGs1HE1FFXZZMR2zLbwS1mnJPrVAJ+YMcvBqVXHgWSyExb76S49SmYuKdCO0DU9ZiICV2ig77vW9FuOWtDhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRwawFlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828BBC433C7;
	Sun, 28 Jan 2024 02:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706408543;
	bh=fmpywCD1VwV5A7MN7G8XJu/ucLi0MClww0i57yZt/Wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hRwawFlSEhrC1j7FlEsG1+1Cb/nAbSliSYlnPdDkoPMf0dnOQruOjOpJ/zuVN9VIN
	 G0eQREik3zrYXqDuxKkyvLsB7TA8u7ef/AbhYBsCzuyw0xD6rRtFO0UCk9Rh2nr1Li
	 xzkotVVPPqSOSX04hNqjVVrf2nTZCFQjy9ENiuRQaVDCRW38hFZonG4TI4NrNTdXui
	 PwmLKAL0dYrgcNffrPP6deDBgmTPthHtgJ7uJBitNLCM7naZdDq5JdEeWLs97WoMze
	 MwYjRpB/VjDg2nOHpmnPXlMRUUzAZoXH5R5mkJ0bqU6R4PpUHRF4Q7HeadqKWjkNc3
	 VcqHP2jpwqWxg==
Date: Sun, 28 Jan 2024 11:22:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] x86/kprobes: boost more instructions from
 grp2/3/4/5
Message-Id: <20240128112218.5501726d17ac2fde2502da44@kernel.org>
In-Reply-To: <20240127044124.57594-3-jinghao7@illinois.edu>
References: <20240127044124.57594-1-jinghao7@illinois.edu>
	<20240127044124.57594-3-jinghao7@illinois.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 22:41:24 -0600
Jinghao Jia <jinghao7@illinois.edu> wrote:

> With the instruction decoder, we are now able to decode and recognize
> instructions with opcode extensions. There are more instructions in
> these groups that can be boosted:
> 
> Group 2: ROL, ROR, RCL, RCR, SHL/SAL, SHR, SAR
> Group 3: TEST, NOT, NEG, MUL, IMUL, DIV, IDIV
> Group 4: INC, DEC (byte operation)
> Group 5: INC, DEC (word/doubleword/quadword operation)
> 
> These instructions are not boosted previously because there are reserved
> opcodes within the groups, e.g., group 2 with ModR/M.nnn == 110 is
> unmapped. As a result, kprobes attached to them requires two int3 traps
> as being non-boostable also prevents jump-optimization.
> 
> Some simple tests on QEMU show that after boosting and jump-optimization
> a single kprobe on these instructions with an empty pre-handler runs 10x
> faster (~1000 cycles vs. ~100 cycles).
> 
> Since these instructions are mostly ALU operations and do not touch
> special registers like RIP, let's boost them so that we get the
> performance benefit.
> 

As far as we check the ModR/M byte, I think we can safely run these
instructions on trampoline buffer without adjusting results (this
means it can be "boosted").
I just have a minor comment, but basically this looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>  arch/x86/kernel/kprobes/core.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 792b38d22126..f847bd9cc91b 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -169,22 +169,31 @@ int can_boost(struct insn *insn, void *addr)
>  	case 0x62:		/* bound */
>  	case 0x70 ... 0x7f:	/* Conditional jumps */
>  	case 0x9a:		/* Call far */
> -	case 0xc0 ... 0xc1:	/* Grp2 */
>  	case 0xcc ... 0xce:	/* software exceptions */
> -	case 0xd0 ... 0xd3:	/* Grp2 */
>  	case 0xd6:		/* (UD) */
>  	case 0xd8 ... 0xdf:	/* ESC */
>  	case 0xe0 ... 0xe3:	/* LOOP*, JCXZ */
>  	case 0xe8 ... 0xe9:	/* near Call, JMP */
>  	case 0xeb:		/* Short JMP */
>  	case 0xf0 ... 0xf4:	/* LOCK/REP, HLT */
> -	case 0xf6 ... 0xf7:	/* Grp3 */
> -	case 0xfe:		/* Grp4 */
>  		/* ... are not boostable */
>  		return 0;
> +	case 0xc0 ... 0xc1:	/* Grp2 */
> +	case 0xd0 ... 0xd3:	/* Grp2 */
> +		/* ModR/M nnn == 110 is reserved */
> +		return X86_MODRM_REG(insn->modrm.bytes[0]) != 6;
> +	case 0xf6 ... 0xf7:	/* Grp3 */
> +		/* ModR/M nnn == 001 is reserved */

		/* AMD uses nnn == 001 as TEST, but Intel makes it reserved. */

> +		return X86_MODRM_REG(insn->modrm.bytes[0]) != 1;
> +	case 0xfe:		/* Grp4 */
> +		/* Only inc and dec are boostable */
> +		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0 ||
> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 1;
>  	case 0xff:		/* Grp5 */
> -		/* Only indirect jmp is boostable */
> -		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
> +		/* Only inc, dec, and indirect jmp are boostable */
> +		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0 ||
> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 1 ||
> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
>  	default:
>  		return 1;
>  	}
> -- 
> 2.43.0
> 

Thamnk you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

