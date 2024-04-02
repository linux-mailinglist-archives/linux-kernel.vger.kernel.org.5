Return-Path: <linux-kernel+bounces-127991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B32AE895427
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1799DB22F22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FB47F7FD;
	Tue,  2 Apr 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3f082nd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96F7E58A;
	Tue,  2 Apr 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062966; cv=none; b=lC0YGsumo+G6By1F9SoJtLVN+hagrx7+uVN5DMbXWndlRxWVJxyRraZOEW0CCw5V3FCpTCL22pSctTed7NpBrHST6RJC8vYgZvCdDuY0ukKQ+8mH/hOvf2sAoNwnLFuxXvk9GabkdH7XF6PGd5F7/2qPm6DwLuyaKx2+OEAEoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062966; c=relaxed/simple;
	bh=ADEIRg8/e8hohEcKMVMe7/LI4j5ei9yN1rtzdMjXREo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2O4j8yy+vzTx1QZowAV6/u7BE1tCC1Fb1fKWvyAB8ll7FqwBv3KUlOf0yVCa1MwqVOnwfrz6c+HgDewR+D9ie+ACUVe7ov0Ana+MHSO3rwBv7q3jvR/Ok3XwUq+xGXhQofJMgyF2SewJseyE+G6DirZpk2mknvz7Qqn0IE3s6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3f082nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E07C433F1;
	Tue,  2 Apr 2024 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712062965;
	bh=ADEIRg8/e8hohEcKMVMe7/LI4j5ei9yN1rtzdMjXREo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n3f082ndyzE8EBgCkP+EurYVCAdYvGKfdOlrmWwpwclVTr2Mh99hBM+y5+OQ3ol5c
	 dwBueAOAaljn9lI/8vF8FphljSAA/treQlT7hhmzDSZkbIkmXNfE0qSUSD26rF+YDS
	 79UwmIzYnKBRFG8DAX+zKg4QcSAybKv39GrWaGsMMNYrIMal5nCVlkZAcTCNEcj+pf
	 0FKI+Ii4b5FohuzfKG9klK2xb2Xilr8UrHGqSlOdS2LLu+EopemFfaqeRSCbDKk5Qa
	 nKVR6jAodnLGC06zfsy60CVqcGndcP113ymp40a8kdr+xd4NTQTPFqHXI1PwMIzPdo
	 fs/ML0EXiUxLw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sami
 Tolvanen <samitolvanen@google.com>, Guo Ren <guoren@kernel.org>, Ley Foon
 Tan <leyfoon.tan@starfivetech.com>, Deepak Gupta <debug@rivosinc.com>, Sia
 Jee Heng <jeeheng.sia@starfivetech.com>, Song Shuai
 <suagrfillet@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@rivosinc.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: Re: [RFC PATCH] ftrace: riscv: move from REGS to ARGS
In-Reply-To: <20240328141845.128645-1-puranjay12@gmail.com>
References: <20240328141845.128645-1-puranjay12@gmail.com>
Date: Tue, 02 Apr 2024 15:02:41 +0200
Message-ID: <87bk6rsyry.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> This commit replaces riscv's support for FTRACE_WITH_REGS with support
> for FTRACE_WITH_ARGS. This is required for the ongoing effort to stop
> relying on stop_machine() for RISCV's implementation of ftrace.
>
> The main relevant benefit that this change will bring for the above
> use-case is that now we don't have separate ftrace_caller and
> ftrace_regs_caller trampolines.  This will allow the callsite to call
> ftrace_caller by modifying a single instruction. Now the callsite can
> do something similar to:
>
> When not tracing:            |             When tracing:
>
> func:                                      func:
>   auipc t0, ftrace_caller_top                auipc t0, ftrace_caller_top
>   nop  <=3D=3D=3D=3D=3D=3D=3D=3D=3D<Enable/Disable>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D>  jalr  t0, ftrace_caller_bottom
>   [...]                                      [...]
>
> The above assumes that we are dropping the support of calling a direct
> trampoline from the callsite. We need to drop this as the callsite can't
> change the target address to call, it can only enable/disable a call to
> a preset target (ftrace_caller in the above diagram).
>
> Currently, ftrace_regs_caller saves all CPU registers in the format of
> struct pt_regs and allows the tracer to modify them. We don't need to
> save all of the CPU registers because at function entry only a subset of
> pt_regs is live:
>
> |----------+----------+---------------------------------------------|
> | Register | ABI Name | Description                                 |
> |----------+----------+---------------------------------------------|
> | x1       | ra       | Return address for traced function          |
> | x2       | sp       | Stack pointer                               |
> | x5       | t0       | Return address for ftrace_caller trampoline |
> | x8       | s0/fp    | Frame pointer                               |
> | x10-11   | a0-1     | Function arguments/return values            |
> | x12-17   | a2-7     | Function arguments                          |
> |----------+----------+---------------------------------------------|
>
> See RISCV calling convention[1] for the above table.
>
> Saving just the live registers decreases the amount of stack space
> required from 288 Bytes to 112 Bytes.
>
> Basic testing was done with this on the VisionFive 2 development board.
>
> Note:
>   - Moving from REGS to ARGS will mean that RISCV will stop supporting
>     KPROBES_ON_FTRACE as it requires full pt_regs to be saved.

..and FPROBES, but Masami is (still?) working on a series to address
that [1].

My perspective; This is following the work Mark et al has done for
arm64, and it does make sense for RISC-V as well. I'm in favor having
this change as part of the bigger call_ops/text patch change for RISC-V.

[...]

> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftr=
ace.h
> index 1276d7d9ca8b..1e95bf4ded6c 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -124,20 +124,87 @@ struct dyn_ftrace;
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>  #define ftrace_init_nop ftrace_init_nop
>=20=20
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> +#define arch_ftrace_get_regs(regs) NULL
>  struct ftrace_ops;
> -struct ftrace_regs;
> +struct ftrace_regs {
> +	unsigned long epc;
> +	unsigned long ra;
> +	unsigned long sp;
> +	unsigned long s0;
> +	unsigned long t1;
> +	union {
> +		unsigned long args[8];
> +		struct {
> +			unsigned long a0;
> +			unsigned long a1;
> +			unsigned long a2;
> +			unsigned long a3;
> +			unsigned long a4;
> +			unsigned long a5;
> +			unsigned long a6;
> +			unsigned long a7;
> +		};
> +	};
> +};
> +
> +static __always_inline unsigned long
> +ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
> +{
> +	return fregs->epc;
> +}
> +
> +static __always_inline void
> +ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
> +				    unsigned long pc)
> +{
> +	fregs->epc =3D pc;
> +}
> +
> +static __always_inline unsigned long
> +ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
> +{
> +	return fregs->sp;
> +}
> +
> +static __always_inline unsigned long
> +ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
> +{
> +	if (n < 8)
> +		return fregs->args[n];
> +	return 0;
> +}
> +
> +static __always_inline unsigned long
> +ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
> +{
> +	return fregs->a0;
> +}
> +
> +static __always_inline void
> +ftrace_regs_set_return_value(struct ftrace_regs *fregs,
> +			     unsigned long ret)
> +{
> +	fregs->a0 =3D ret;
> +}
> +
> +static __always_inline void
> +ftrace_override_function_with_return(struct ftrace_regs *fregs)
> +{
> +	fregs->epc =3D fregs->ra;
> +}

Style/nit: All above; Try to use the full 100 chars, and keep the
function name return value on the same line for grepability.


Bj=C3=B6rn

[1] https://lore.kernel.org/all/170887410337.564249.6360118840946697039.stg=
it@devnote2/

