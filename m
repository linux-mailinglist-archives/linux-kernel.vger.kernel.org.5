Return-Path: <linux-kernel+bounces-133139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1637899F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCB31C2284D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB316EC00;
	Fri,  5 Apr 2024 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLcxvN8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B116EBE7;
	Fri,  5 Apr 2024 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326614; cv=none; b=dRSh12XzcWHE05/19wA4h8QYCPFxqS5ED7x0w9ZzEkx12VAA3NkixJZggucSA10/GxpXCr1ARjlDRrao7bHFC8Q0suNn5oaEpTT1Xo2gPxtJ05ZbK0A1yy8RaFgontFegBERcqw2wG965PVcfZThIld2pj2WCnJFcRu2V74aIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326614; c=relaxed/simple;
	bh=Hw+KO3P+18sZHmzC74dpfmnZvcgIJNwH7PxzRg8kCyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZP1gtl251Y5fagcCCYW1zga/0jfcDuwW1cgvYYgFvOqsHU6cQ29zQiF1LWsJF2WVkYbw3Fegi1t0U4Pz88Wu52EO0NqpU2irwVNU5XqFy5XFQCVzE/Mclkp56yld33lm3+Nvgvi6WxWj/hh7DOFnBFkfIKzGcGa4nPJw6k0GigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLcxvN8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D8CC433F1;
	Fri,  5 Apr 2024 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712326613;
	bh=Hw+KO3P+18sZHmzC74dpfmnZvcgIJNwH7PxzRg8kCyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NLcxvN8DTCyS38Wo2c8q90q/2MoZExiascd6YXu8KFmC45GJekv4kw9UWrhP5O+n0
	 T4xoLBCSAvDVEYvlrPQBTILTQwRgV33CHfTCNI7qRQM7BYrkuE03OQOLgno/wn77Hr
	 PESugZv29avchfZsAMS7s+RgIUgsP4Oo55AJ5wVwthZ7azQ+bkK9VOK4bnmL9SeDKc
	 1DW+tMTj256yPD6wXa43Wc+15PNllkAGj03SBSKmJkJyZ4+hPiynM7vGxR5en1wli/
	 jky8B6fJI7vZ5nZqRQjLt+hBOkkkZ2VwAF70r1CsG/RVx+y3YKum8iJy4svQONVsyM
	 VcZaxRzX6q6pg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Pu Lehui
 <pulehui@huawei.com>
Cc: puranjay12@gmail.com
Subject: Re: [PATCH bpf-next] riscv, bpf: add internal-only MOV instruction
 to resolve per-CPU addrs
In-Reply-To: <20240405124348.27644-1-puranjay12@gmail.com>
References: <20240405124348.27644-1-puranjay12@gmail.com>
Date: Fri, 05 Apr 2024 16:16:49 +0200
Message-ID: <87wmpbnbce.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> Support an instruction for resolving absolute addresses of per-CPU
> data from their per-CPU offsets. This instruction is internal-only and
> users are not allowed to use them directly. They will only be used for
> internal inlining optimizations for now between BPF verifier and BPF
> JITs.
>
> RISC-V uses generic per-cpu implementation where the offsets for CPUs
> are kept in an array called __per_cpu_offset[cpu_number]. RISCV stores
> the address of the task_struct in TP register. The first element in
> tast_struct is struct thread_info, and we can get the cpu number by
     ^
     k ;-)
> reading from the TP register + offsetof(struct thread_info, cpu).
>
> Once we have the cpu number in a register we read the offset for that
> cpu from address: &__per_cpu_offset + cpu_number << 3. Then we add this
> offset to the destination register.

Just to clarify for readers; BPF programs are run with migrate disable,
which means that on RT we can be preempted, which means that per-cpu
operations are trickier (disabling interrupts/preemption).

However, this BPF instruction is about calculating the per-cpu address,
so the look up can be inlined.

It's not a per-cpu *operation*.

> To measure the improvement from this change, the benchmark in [1] was
> used on Qemu:
>
> Before:
> glob-arr-inc   :    1.127 =C2=B1 0.013M/s
> arr-inc        :    1.121 =C2=B1 0.004M/s
> hash-inc       :    0.681 =C2=B1 0.052M/s
>
> After:
> glob-arr-inc   :    1.138 =C2=B1 0.011M/s
> arr-inc        :    1.366 =C2=B1 0.006M/s
> hash-inc       :    0.676 =C2=B1 0.001M/s
>
> [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 15e482f2c657..e95bd1d459a4 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -12,6 +12,7 @@
>  #include <linux/stop_machine.h>
>  #include <asm/patch.h>
>  #include <asm/cfi.h>
> +#include <asm/percpu.h>
>  #include "bpf_jit.h"
>=20=20
>  #define RV_FENTRY_NINSNS 2
> @@ -1089,6 +1090,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  			emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
>  			emit_mv(rd, RV_REG_T1, ctx);
>  			break;
> +		} else if (insn_is_mov_percpu_addr(insn)) {
> +			if (rd !=3D rs)
> +				emit_mv(rd, rs, ctx);
> +#ifdef CONFIG_SMP
> +				/* Load current CPU number in T1 */
> +				emit_ld(RV_REG_T1, offsetof(struct thread_info, cpu), RV_REG_TP,
> +					ctx);
> +				/* << 3 because offsets are 8 bytes */
> +				emit_slli(RV_REG_T1, RV_REG_T1, 3, ctx);
> +				/* Load address of __per_cpu_offset array in T2 */
> +				emit_imm(RV_REG_T2, (u64)&__per_cpu_offset, ctx);

Did you try using emit_addr() here? I'd guess that'll be fewer
instructions, no?


Bj=C3=B6rn

