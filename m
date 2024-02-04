Return-Path: <linux-kernel+bounces-51621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537B848D5F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02321C20F55
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6BA2232B;
	Sun,  4 Feb 2024 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8ogO4RQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F92230C;
	Sun,  4 Feb 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048577; cv=none; b=LlP45nZ9VfI7xlNys13e2K9L9rgwzWDYFromVf+78xo2+xinTC6dTb9F3Tu0ib7rrlbBcfJhwEaM5ghzzCi1LuYhly2D9eVFOOAGxhtm02W/RVD2C/FJVwwzmAilq0MWD/i5H7ky6HfVc2wt+lgREGFFcMH+14J3kT3qOgl7y0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048577; c=relaxed/simple;
	bh=1oX+987QSLgHiJKrbV64gz3eFSMyM4D/Fvphc6DYZIw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CETHvYje2sc3GWFTvXbUjHeRaAj7AsNu/euBKFQqVC2svw/5hpi45XShTdKND8j48NUUPGVT+NtgBeo+jdAjlsIedsyEY95qdJs7FcgtD9uTvNAQ8x2rWpKJkMXZFxAVJukYpUiUydYGU9bGbWjcPvl7sBexq9CPmijn/Tn0HoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8ogO4RQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31815C433F1;
	Sun,  4 Feb 2024 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707048577;
	bh=1oX+987QSLgHiJKrbV64gz3eFSMyM4D/Fvphc6DYZIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8ogO4RQnF4nhyTx7Kew2UE2KFs6K/s3+XxgSQEv5L87Lp+nB0yhbuTCt9uh6gkqp
	 jRDxzPOZcyJqBg3M5hn4YufhP/fEObw1O4nirrO/U4l74CTUrdATGrb5ZwJfnueFVt
	 RgrHM6Pm1XRJdj9sF9gUFDuVpjVGcHtkYISzTfztjRJ5EV+AZ4/+Eq+OarnfSdGBsi
	 Db9sCXtFobGi5O5iHYW2SKi/6FyxeKXcVD+FS9munkn+k/IIXZf5DtF2BLbAIF8y9u
	 LJgVm9y6aWU0ljy14Zg06m/x+KPN9Nd1Z7n+H268kKF0INisy9tubRfkWoj5ivxs1J
	 v7UfnofQSHx5Q==
Date: Sun, 4 Feb 2024 21:09:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, Xin Li <xin@zytor.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/kprobes: Boost more instructions from
 grp2/3/4/5
Message-Id: <20240204210932.bd112a37dd3c276b046f6b16@kernel.org>
In-Reply-To: <20240204031300.830475-4-jinghao7@illinois.edu>
References: <20240204031300.830475-1-jinghao7@illinois.edu>
	<20240204031300.830475-4-jinghao7@illinois.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Feb 2024 21:13:00 -0600
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

This looks good to me. And can you check how many instructions in the
vmlinux will be covered by this change typically?

Thank you,

> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>  arch/x86/kernel/kprobes/core.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 7a08d6a486c8..530f6d4b34f4 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -169,22 +169,33 @@ bool can_boost(struct insn *insn, void *addr)
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
>  		return false;
> +	case 0xc0 ... 0xc1:	/* Grp2 */
> +	case 0xd0 ... 0xd3:	/* Grp2 */
> +		/*
> +		 * AMD uses nnn == 110 as SHL/SAL, but Intel makes it reserved.
> +		 */
> +		return X86_MODRM_REG(insn->modrm.bytes[0]) != 0b110;
> +	case 0xf6 ... 0xf7:	/* Grp3 */
> +		/* AMD uses nnn == 001 as TEST, but Intel makes it reserved. */
> +		return X86_MODRM_REG(insn->modrm.bytes[0]) != 0b001;
> +	case 0xfe:		/* Grp4 */
> +		/* Only INC and DEC are boostable */
> +		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0b000 ||
> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 0b001;
>  	case 0xff:		/* Grp5 */
> -		/* Only indirect jmp is boostable */
> -		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
> +		/* Only INC, DEC, and indirect JMP are boostable */
> +		return X86_MODRM_REG(insn->modrm.bytes[0]) == 0b000 ||
> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 0b001 ||
> +		       X86_MODRM_REG(insn->modrm.bytes[0]) == 0b100;
>  	default:
>  		return true;
>  	}
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

