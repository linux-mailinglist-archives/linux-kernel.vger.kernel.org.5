Return-Path: <linux-kernel+bounces-117513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0143288AC20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0E11F67626
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504095A0F0;
	Mon, 25 Mar 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzbCp7JI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A353DABF3;
	Mon, 25 Mar 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385589; cv=none; b=EbJjXYWpLEXmmXaVhOXsVGGEwBnoQsyc2CnlF3IDmTyuyAVvgHm11DuR0FBWtCbCRcZ77LH3emESr1LKa8HWAPR46ZUv0WpAVafKe8ojq6U41JE8eJU6xQlDKW7I2TUSXpSvwdrTwJyZ7BcbSHELgiEvFwd8msMi72mGfwEFJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385589; c=relaxed/simple;
	bh=TZW0H+CTcVkomLGdlmekNLlyTQcENG1CcK5sCMi0Ouc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kXyFl/CYYaYMqwCmRf0WpkrTaZfWS660qxa+McQVMF+9ewpULpCSrFQOhvaM4TJ3KP/aD0ZEt0RyVj8i2NkK7K/QS1noF/TsDtwJgMEOWjlvGN9jzEu+k+pHND/WsLq/id5qmHv6l8yoFnyGnsuvYhgrfpYi9Jtmg/juqsTUDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzbCp7JI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37540C433F1;
	Mon, 25 Mar 2024 16:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385588;
	bh=TZW0H+CTcVkomLGdlmekNLlyTQcENG1CcK5sCMi0Ouc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FzbCp7JIpQUlk/jEi8/FT2aO38/Jm/82QV/sio3VJqVz8P+BPwa+jyIDZYzLbZ63D
	 OtlFNovOAmkX9B1Gy7fKhQxxtwdZySq465C6d9yJMOCs8ZdC9Zwfsok+OHPVb2FR8O
	 Q+xX56G09Q9N8egt7NtZhjmRYqdHVClrRsQYY7dve/9C81z2Ebq2DorwL1y1irnPDv
	 KPLTs9wcdWY5TnC1vXOSum9pN6bWoVuu0+cX9xSCyb/JMMlhWE7n1CRTR7wz1Gh/Zg
	 4xHm93FAARwhvo0u6nHwpZzRLSgVZfwQI74WPQscD85D7Y+l+ADZb8KXEF+pVXqFkx
	 7Ut4EUjOndyVw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Pu Lehui
 <pulehui@huaweicloud.com>
Cc: puranjay12@gmail.com
Subject: Re: [PATCH bpf-next v2 1/2] bpf,riscv: Implement PROBE_MEM32 pseudo
 instructions
In-Reply-To: <20240325155434.65589-2-puranjay12@gmail.com>
References: <20240325155434.65589-1-puranjay12@gmail.com>
 <20240325155434.65589-2-puranjay12@gmail.com>
Date: Mon, 25 Mar 2024 17:53:04 +0100
Message-ID: <875xxafe33.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
> instructions.  They are similar to PROBE_MEM instructions with the
> following differences:
> - PROBE_MEM32 supports store.
> - PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
>   src/dst register
> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in S7
>   in the prologue). Due to bpf_arena constructions such S7 + reg +
>   off16 access is guaranteed to be within arena virtual range, so no
>   address check at run-time.
> - S7 is a free callee-saved register, so it is used to store kern_vm_start
> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
>   LDX faults the destination register is zeroed.
>
> To support these on riscv, we do tmp =3D S7 + src/dst reg and then use
> tmp2 as the new src/dst register. This allows us to reuse most of the
> code for normal [LDX | STX | ST].

Cool to see the RV BPF JIT keeping up with x86 features! ;-) Nice work!

A couple of minor comments below.

> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/riscv/net/bpf_jit.h        |   1 +
>  arch/riscv/net/bpf_jit_comp64.c | 193 +++++++++++++++++++++++++++++++-
>  arch/riscv/net/bpf_jit_core.c   |   1 +
>  3 files changed, 192 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index f4b6b3b9edda..8a47da08dd9c 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -81,6 +81,7 @@ struct rv_jit_context {
>  	int nexentries;
>  	unsigned long flags;
>  	int stack_size;
> +	u64 arena_vm_start;
>  };
>=20=20
>  /* Convert from ninsns to bytes. */
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 1adf2f39ce59..0c0588e327af 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -255,6 +255,10 @@ static void __build_epilogue(bool is_tail_call, stru=
ct rv_jit_context *ctx)
>  		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
>  		store_offset -=3D 8;
>  	}
> +	if (ctx->arena_vm_start) {
> +		emit_ld(RV_REG_S7, store_offset, RV_REG_SP, ctx);
> +		store_offset -=3D 8;
> +	}
>=20=20
>  	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
>  	/* Set return value. */
> @@ -548,6 +552,7 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 im=
m, bool is64,
>=20=20
>  #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
>  #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
> +#define DONT_CLEAR		17	/* RV_REG_A7 unused in pt_regmap */

Hmm, so this is just a a sentinel node, right? Isn't it more robust to
use, say REG_ZERO which will never be used? Maybe REG_DONT_CLEAR_MARKER
or smth, so it's obvious how it's used?


>  bool ex_handler_bpf(const struct exception_table_entry *ex,
>  		    struct pt_regs *regs)
> @@ -555,7 +560,8 @@ bool ex_handler_bpf(const struct exception_table_entr=
y *ex,
>  	off_t offset =3D FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
>  	int regs_offset =3D FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
>=20=20
> -	*(unsigned long *)((void *)regs + pt_regmap[regs_offset]) =3D 0;
> +	if (regs_offset !=3D DONT_CLEAR)
> +		*(unsigned long *)((void *)regs + pt_regmap[regs_offset]) =3D 0;
>  	regs->epc =3D (unsigned long)&ex->fixup - offset;
>=20=20
>  	return true;
> @@ -572,7 +578,8 @@ static int add_exception_handler(const struct bpf_ins=
n *insn,
>  	off_t fixup_offset;
>=20=20
>  	if (!ctx->insns || !ctx->ro_insns || !ctx->prog->aux->extable ||
> -	    (BPF_MODE(insn->code) !=3D BPF_PROBE_MEM && BPF_MODE(insn->code) !=
=3D BPF_PROBE_MEMSX))
> +	    (BPF_MODE(insn->code) !=3D BPF_PROBE_MEM && BPF_MODE(insn->code) !=
=3D BPF_PROBE_MEMSX &&
> +	     BPF_MODE(insn->code) !=3D BPF_PROBE_MEM32))
>  		return 0;
>=20=20
>  	if (WARN_ON_ONCE(ctx->nexentries >=3D ctx->prog->aux->num_exentries))
> @@ -622,6 +629,9 @@ static int add_exception_handler(const struct bpf_ins=
n *insn,
>=20=20
>  	ex->insn =3D ins_offset;
>=20=20
> +	if (BPF_CLASS(insn->code) !=3D BPF_LDX)
> +		dst_reg =3D DONT_CLEAR;
> +

Instead of having a side-effect, and passing a dummy dst_reg for the
probe_mem32, just explicitly add DONT_CLEAR when calling
add_exception_handler(). It's more obvious to me at least.

>  	ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
>  		FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
>  	ex->type =3D EX_TYPE_BPF;
> @@ -1063,7 +1073,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
>  		    BPF_CLASS(insn->code) =3D=3D BPF_JMP;
>  	int s, e, rvoff, ret, i =3D insn - ctx->prog->insnsi;
>  	struct bpf_prog_aux *aux =3D ctx->prog->aux;
> -	u8 rd =3D -1, rs =3D -1, code =3D insn->code;
> +	u8 rd =3D -1, rs =3D -1, code =3D insn->code, reg_arena_vm_start =3D RV=
_REG_S7;
>  	s16 off =3D insn->off;
>  	s32 imm =3D insn->imm;
>=20=20
> @@ -1539,6 +1549,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
>  	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>  	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
> +	/* LDX | PROBE_MEM32: dst =3D *(unsigned size *)(src + S7 + off)*/
> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
> +	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
>  	{
>  		int insn_len, insns_start;
>  		bool sign_ext;
> @@ -1546,6 +1561,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  		sign_ext =3D BPF_MODE(insn->code) =3D=3D BPF_MEMSX ||
>  			   BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX;
>=20=20
> +		if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32) {
> +			emit_add(RV_REG_T2, rs, reg_arena_vm_start, ctx);
> +			rs =3D RV_REG_T2;
> +		}
> +
>  		switch (BPF_SIZE(code)) {
>  		case BPF_B:
>  			if (is_12b_int(off)) {
> @@ -1682,6 +1702,87 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  		emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
>  		break;
>=20=20
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
> +	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
> +	{
> +		int insn_len, insns_start;
> +
> +		emit_add(RV_REG_T3, rd, reg_arena_vm_start, ctx);
> +		rd =3D RV_REG_T3;
> +
> +		/* Load imm to a register then store it */
> +		emit_imm(RV_REG_T1, imm, ctx);
> +
> +		switch (BPF_SIZE(code)) {
> +		case BPF_B:
> +			if (is_12b_int(off)) {
> +				insns_start =3D ctx->ninsns;
> +				emit(rv_sb(rd, off, RV_REG_T1), ctx);
> +				insn_len =3D ctx->ninsns - insns_start;
> +				break;
> +			}
> +
> +			emit_imm(RV_REG_T2, off, ctx);
> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
> +			insns_start =3D ctx->ninsns;
> +			emit(rv_sb(RV_REG_T2, 0, RV_REG_T1), ctx);
> +			insn_len =3D ctx->ninsns - insns_start;
> +
> +			break;
> +
> +		case BPF_H:
> +			if (is_12b_int(off)) {
> +				insns_start =3D ctx->ninsns;
> +				emit(rv_sh(rd, off, RV_REG_T1), ctx);
> +				insn_len =3D ctx->ninsns - insns_start;
> +				break;
> +			}
> +
> +			emit_imm(RV_REG_T2, off, ctx);
> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
> +			insns_start =3D ctx->ninsns;
> +			emit(rv_sh(RV_REG_T2, 0, RV_REG_T1), ctx);
> +			insn_len =3D ctx->ninsns - insns_start;
> +			break;
> +		case BPF_W:
> +			if (is_12b_int(off)) {
> +				insns_start =3D ctx->ninsns;
> +				emit_sw(rd, off, RV_REG_T1, ctx);
> +				insn_len =3D ctx->ninsns - insns_start;
> +				break;
> +			}
> +
> +			emit_imm(RV_REG_T2, off, ctx);
> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
> +			insns_start =3D ctx->ninsns;
> +			emit_sw(RV_REG_T2, 0, RV_REG_T1, ctx);
> +			insn_len =3D ctx->ninsns - insns_start;
> +			break;
> +		case BPF_DW:
> +			if (is_12b_int(off)) {
> +				insns_start =3D ctx->ninsns;
> +				emit_sd(rd, off, RV_REG_T1, ctx);
> +				insn_len =3D ctx->ninsns - insns_start;
> +				break;
> +			}
> +
> +			emit_imm(RV_REG_T2, off, ctx);
> +			emit_add(RV_REG_T2, RV_REG_T2, rd, ctx);
> +			insns_start =3D ctx->ninsns;
> +			emit_sd(RV_REG_T2, 0, RV_REG_T1, ctx);
> +			insn_len =3D ctx->ninsns - insns_start;
> +			break;
> +		}

A lot of similar code, with emit of different sizes. Possible to move
move out to a function, and wrap the emits? The main loop is hard read
already!

> +
> +		ret =3D add_exception_handler(insn, ctx, rd, insn_len);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	}
> +
>  	/* STX: *(size *)(dst + off) =3D src */
>  	case BPF_STX | BPF_MEM | BPF_B:
>  		if (is_12b_int(off)) {
> @@ -1728,6 +1829,83 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  		emit_atomic(rd, rs, off, imm,
>  			    BPF_SIZE(code) =3D=3D BPF_DW, ctx);
>  		break;
> +
> +	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
> +	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
> +	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
> +	case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
> +	{
> +		int insn_len, insns_start;
> +
> +		emit_add(RV_REG_T2, rd, reg_arena_vm_start, ctx);
> +		rd =3D RV_REG_T2;
> +
> +		switch (BPF_SIZE(code)) {
> +		case BPF_B:
> +			if (is_12b_int(off)) {
> +				insns_start =3D ctx->ninsns;
> +				emit(rv_sb(rd, off, rs), ctx);
> +				insn_len =3D ctx->ninsns - insns_start;
> +				break;
> +			}
> +
> +			emit_imm(RV_REG_T1, off, ctx);
> +			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
> +			insns_start =3D ctx->ninsns;
> +			emit(rv_sb(RV_REG_T1, 0, rs), ctx);
> +			insn_len =3D ctx->ninsns - insns_start;
> +			break;
> +		case BPF_H:
> +			if (is_12b_int(off)) {
> +				insns_start =3D ctx->ninsns;
> +				emit(rv_sh(rd, off, rs), ctx);
> +				insn_len =3D ctx->ninsns - insns_start;
> +				break;
> +			}
> +
> +			emit_imm(RV_REG_T1, off, ctx);
> +			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
> +			insns_start =3D ctx->ninsns;
> +			emit(rv_sh(RV_REG_T1, 0, rs), ctx);
> +			insn_len =3D ctx->ninsns - insns_start;
> +			break;
> +		case BPF_W:
> +			if (is_12b_int(off)) {
> +				insns_start =3D ctx->ninsns;
> +				emit_sw(rd, off, rs, ctx);
> +				insn_len =3D ctx->ninsns - insns_start;
> +				break;
> +			}
> +
> +			emit_imm(RV_REG_T1, off, ctx);
> +			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
> +			insns_start =3D ctx->ninsns;
> +			emit_sw(RV_REG_T1, 0, rs, ctx);
> +			insn_len =3D ctx->ninsns - insns_start;
> +			break;
> +		case BPF_DW:
> +			if (is_12b_int(off)) {
> +				insns_start =3D ctx->ninsns;
> +				emit_sd(rd, off, rs, ctx);
> +				insn_len =3D ctx->ninsns - insns_start;
> +				break;
> +			}
> +
> +			emit_imm(RV_REG_T1, off, ctx);
> +			emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
> +			insns_start =3D ctx->ninsns;
> +			emit_sd(RV_REG_T1, 0, rs, ctx);
> +			insn_len =3D ctx->ninsns - insns_start;
> +			break;
> +		}

Same comment as above.


Bj=C3=B6rn

