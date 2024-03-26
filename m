Return-Path: <linux-kernel+bounces-119735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9964888CC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC124B23E58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4813CA93;
	Tue, 26 Mar 2024 18:59:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3A14265;
	Tue, 26 Mar 2024 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479587; cv=none; b=DKLWpVzPr7vEFbVg5f4C0UzWzRXVb7+3bG4lLBem0bk0QHsLbNg30/jE7OYq05wW2w3GS1gcQ1iwDdlATWHxWPy3roazxOpiCzIP6c/8lEYwvIkl9PZtQmFKkrv7fnzndJi/QcjG6OqA1YVST3WCz6tlSYEv6HJHhi+iqlraEMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479587; c=relaxed/simple;
	bh=2HjFY0yw0cSUnGd0uidraidATyozNzx0CSvEuLWgRbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upDuR1LCvA8noQLYVmhiYOIHky69JBJhoTbyZEyKZJUoMEka3mAZbLT5E0BLA7Qc/vA3QMe8RhMj9tJU+6Px6/RyJE3r7g16CwPerfdnQH1qi1TC4Qa7wsrBT76qKJ7gYXzYBns9CPgL+w3oMudL34KuegYdFLOg418BWN9pJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 342FE2F4;
	Tue, 26 Mar 2024 12:00:17 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD7703F64C;
	Tue, 26 Mar 2024 11:59:40 -0700 (PDT)
Date: Tue, 26 Mar 2024 18:59:34 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/1] arm64/cfi,bpf: Support kCFI + BPF on
 arm64
Message-ID: <ZgMbFqWpmZgahiV6@FVFF77S0Q05N.cambridge.arm.com>
References: <20240324211518.93892-1-puranjay12@gmail.com>
 <20240324211518.93892-2-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324211518.93892-2-puranjay12@gmail.com>

Hi Puranjay,

On Sun, Mar 24, 2024 at 09:15:18PM +0000, Puranjay Mohan wrote:
> Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
> calling BPF programs from this interface doesn't cause CFI warnings.
> 
> When BPF programs are called directly from C: from BPF helpers or
> struct_ops, CFI warnings are generated.
> 
> Implement proper CFI prologues for the BPF programs and callbacks and
> drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
> prologue when a struct_ops trampoline is being prepared.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Presumably this'll need a Cc stable and a Fixes tag?

> ---
>  arch/arm64/include/asm/cfi.h    | 23 ++++++++++++++
>  arch/arm64/kernel/alternative.c | 54 +++++++++++++++++++++++++++++++++
>  arch/arm64/net/bpf_jit_comp.c   | 28 +++++++++++++----
>  3 files changed, 99 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm64/include/asm/cfi.h
> 
> diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
> new file mode 100644
> index 000000000000..670e191f8628
> --- /dev/null
> +++ b/arch/arm64/include/asm/cfi.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_CFI_H
> +#define _ASM_ARM64_CFI_H
> +
> +#ifdef CONFIG_CFI_CLANG
> +#define __bpfcall
> +static inline int cfi_get_offset(void)
> +{
> +	return 4;
> +}
> +#define cfi_get_offset cfi_get_offset
> +extern u32 cfi_bpf_hash;
> +extern u32 cfi_bpf_subprog_hash;
> +extern u32 cfi_get_func_hash(void *func);
> +#else
> +#define cfi_bpf_hash 0U
> +#define cfi_bpf_subprog_hash 0U
> +static inline u32 cfi_get_func_hash(void *func)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_CFI_CLANG */
> +#endif /* _ASM_ARM64_CFI_H */
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index 8ff6610af496..1715da7df137 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -13,6 +13,7 @@
>  #include <linux/elf.h>
>  #include <asm/cacheflush.h>
>  #include <asm/alternative.h>
> +#include <asm/cfi.h>
>  #include <asm/cpufeature.h>
>  #include <asm/insn.h>
>  #include <asm/module.h>
> @@ -298,3 +299,56 @@ noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
>  		updptr[i] = cpu_to_le32(aarch64_insn_gen_nop());
>  }
>  EXPORT_SYMBOL(alt_cb_patch_nops);
> +
> +#ifdef CONFIG_CFI_CLANG
> +struct bpf_insn;
> +
> +/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
> +extern unsigned int __bpf_prog_runX(const void *ctx,
> +				    const struct bpf_insn *insn);
> +
> +/*
> + * Force a reference to the external symbol so the compiler generates
> + * __kcfi_typid.
> + */
> +__ADDRESSABLE(__bpf_prog_runX);
> +
> +/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
> +asm (
> +"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
> +"	.type	cfi_bpf_hash,@object				\n"
> +"	.globl	cfi_bpf_hash					\n"
> +"	.p2align	2, 0x0					\n"
> +"cfi_bpf_hash:							\n"
> +"	.word	__kcfi_typeid___bpf_prog_runX			\n"
> +"	.size	cfi_bpf_hash, 4					\n"
> +"	.popsection						\n"
> +);
> +
> +/* Must match bpf_callback_t */
> +extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
> +
> +__ADDRESSABLE(__bpf_callback_fn);
> +
> +/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
> +asm (
> +"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
> +"	.type	cfi_bpf_subprog_hash,@object			\n"
> +"	.globl	cfi_bpf_subprog_hash				\n"
> +"	.p2align	2, 0x0					\n"
> +"cfi_bpf_subprog_hash:						\n"
> +"	.word	__kcfi_typeid___bpf_callback_fn			\n"
> +"	.size	cfi_bpf_subprog_hash, 4				\n"
> +"	.popsection						\n"
> +);
> +
> +u32 cfi_get_func_hash(void *func)
> +{
> +	u32 hash;
> +
> +	if (get_kernel_nofault(hash, func - cfi_get_offset()))
> +		return 0;
> +
> +	return hash;
> +}
> +#endif

I realise this is following the example of x86, but this has nothing to do with
alternatives, so could we please place it elsewhere? e.g. add a new
arch/arm64/net/bpf_cfi.c?

Which functions is cfi_get_func_hash() used against? The comment in the code
below says:

	if (flags & BPF_TRAMP_F_INDIRECT) {
		/*
		 * Indirect call for bpf_struct_ops
		 */
		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
	}

.. but it's not clear to me which functions specifically would be in that
'func_addr', not why returning 0 is fine -- surely we should fail compilation
if the provided function pointer causes a fault and we don't have a valid
typeid?

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index bc16eb694657..2372812bb47c 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -17,6 +17,7 @@
>  #include <asm/asm-extable.h>
>  #include <asm/byteorder.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cfi.h>
>  #include <asm/debug-monitors.h>
>  #include <asm/insn.h>
>  #include <asm/patching.h>
> @@ -158,6 +159,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
>  		emit(insn, ctx);
>  }
>  
> +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
> +{
> +	if (IS_ENABLED(CONFIG_CFI_CLANG))
> +		emit(hash, ctx);
> +}
> +
>  /*
>   * Kernel addresses in the vmalloc space use at most 48 bits, and the
>   * remaining bits are guaranteed to be 0x1. So we can compose the address
> @@ -295,7 +302,7 @@ static bool is_lsi_offset(int offset, int scale)
>  #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
>  
>  static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
> -			  bool is_exception_cb)
> +			  bool is_exception_cb, bool is_subprog)
>  {
>  	const struct bpf_prog *prog = ctx->prog;
>  	const bool is_main_prog = !bpf_is_subprog(prog);
> @@ -306,7 +313,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
>  	const u8 fp = bpf2a64[BPF_REG_FP];
>  	const u8 tcc = bpf2a64[TCALL_CNT];
>  	const u8 fpb = bpf2a64[FP_BOTTOM];
> -	const int idx0 = ctx->idx;
>  	int cur_offset;
>  
>  	/*
> @@ -332,6 +338,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
>  	 *
>  	 */
>  
> +	emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
> +	const int idx0 = ctx->idx;
>  	/* bpf function may be invoked by 3 instruction types:
>  	 * 1. bl, attached via freplace to bpf prog via short jump
>  	 * 2. br, attached via freplace to bpf prog via long jump
> @@ -1648,7 +1656,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	 * BPF line info needs ctx->offset[i] to be the offset of
>  	 * instruction[i] in jited image, so build prologue first.
>  	 */
> -	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb)) {
> +	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb,
> +			   bpf_is_subprog(prog))) {
>  		prog = orig_prog;
>  		goto out_off;
>  	}
> @@ -1696,7 +1705,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	ctx.idx = 0;
>  	ctx.exentry_idx = 0;
>  
> -	build_prologue(&ctx, was_classic, prog->aux->exception_cb);
> +	build_prologue(&ctx, was_classic, prog->aux->exception_cb,
> +		       bpf_is_subprog(prog));
>  
>  	if (build_body(&ctx, extra_pass)) {
>  		prog = orig_prog;
> @@ -1745,9 +1755,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		jit_data->ro_header = ro_header;
>  	}
>  
> -	prog->bpf_func = (void *)ctx.ro_image;
> +	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
>  	prog->jited = 1;
> -	prog->jited_len = prog_size;
> +	prog->jited_len = prog_size - cfi_get_offset();
>  
>  	if (!prog->is_func || extra_pass) {
>  		int i;
> @@ -2011,6 +2021,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>  	/* return address locates above FP */
>  	retaddr_off = stack_size + 8;
>  
> +	if (flags & BPF_TRAMP_F_INDIRECT) {
> +		/*
> +		 * Indirect call for bpf_struct_ops
> +		 */
> +		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
> +	}

I'm confused; why does the trampoline need this?

The code that branches to the trampoline doesn't check the type hash: either
the callsite branches directly (hence no check), or the common ftrace
trampoline does so indirectly, and the latter doesn't know the expected typeid,
so it cannot check.

If we wanted a tpyeid here, that should probably be distinct from the original
function tpyeid, since the trampoline calling convention is different.

IIUC this isn't reachable today regardless since CALL_OPS and KCFI are
currently mutually exclusive.

Either I've misunderstood what's going on here, or this can be removed.

Thanks,
Mark.

