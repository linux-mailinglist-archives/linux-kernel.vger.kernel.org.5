Return-Path: <linux-kernel+bounces-128057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B3989557F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37046287F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D748684A4B;
	Tue,  2 Apr 2024 13:35:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35460DE9;
	Tue,  2 Apr 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064958; cv=none; b=D0KCRGV/VKURrEom1zalAFxRDfxVm02frMYYqR+8WpLBKGrW566wL2zxRP++mBn6rnmwpWKYTdvtG1e2KomFQ4u1tLnhWG9Fj6eaq5+CELuAIX+i7mI46xY/Fw2qIqqPR1tMRr5OqbOPvpQ9+Zm2Uj87++NvmfmmfO73jPiQ28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064958; c=relaxed/simple;
	bh=W9Akjb1Ge7CkOTaOHcq6o7jMt/E6hNknct9z20sHbus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuAKabOmDfAcgqtSaJemAeXKdaPdYgMOlo2kUGZPcfESlopXwlo4cc6TGsVBAow7KyMto/c+YNGnp1Vt0ty4uTtEKp9DIXRJOErRsrKWTs4GJD6fbU8qJR+Wq+MuXWNGWY9Cibe2PkS7WIyc9DvdPY4aW+iO4ALIJQBUVzLJclA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A35FC1007;
	Tue,  2 Apr 2024 06:36:26 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.18.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BA3E3F766;
	Tue,  2 Apr 2024 06:35:50 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:35:44 +0100
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
Message-ID: <ZgwJsJPUyPVNdpZb@FVFF77S0Q05N>
References: <20240324211518.93892-1-puranjay12@gmail.com>
 <20240324211518.93892-2-puranjay12@gmail.com>
 <ZgMbFqWpmZgahiV6@FVFF77S0Q05N.cambridge.arm.com>
 <mb61pv858vdah.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61pv858vdah.fsf@gmail.com>

On Tue, Mar 26, 2024 at 10:28:06PM +0000, Puranjay Mohan wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > Hi Puranjay,
> >
> > On Sun, Mar 24, 2024 at 09:15:18PM +0000, Puranjay Mohan wrote:
> >> Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
> >> calling BPF programs from this interface doesn't cause CFI warnings.
> >> 
> >> When BPF programs are called directly from C: from BPF helpers or
> >> struct_ops, CFI warnings are generated.
> >> 
> >> Implement proper CFI prologues for the BPF programs and callbacks and
> >> drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
> >> prologue when a struct_ops trampoline is being prepared.
> >> 
> >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >
> > Presumably this'll need a Cc stable and a Fixes tag?
> 
> Thanks for mentioning, I will find out from what commit this is broken.
> 
> >
> >> ---
> >>  arch/arm64/include/asm/cfi.h    | 23 ++++++++++++++
> >>  arch/arm64/kernel/alternative.c | 54 +++++++++++++++++++++++++++++++++
> >>  arch/arm64/net/bpf_jit_comp.c   | 28 +++++++++++++----
> >>  3 files changed, 99 insertions(+), 6 deletions(-)
> >>  create mode 100644 arch/arm64/include/asm/cfi.h
> >> 
> >> diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
> >> new file mode 100644
> >> index 000000000000..670e191f8628
> >> --- /dev/null
> >> +++ b/arch/arm64/include/asm/cfi.h
> >> @@ -0,0 +1,23 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef _ASM_ARM64_CFI_H
> >> +#define _ASM_ARM64_CFI_H
> >> +
> >> +#ifdef CONFIG_CFI_CLANG
> >> +#define __bpfcall
> >> +static inline int cfi_get_offset(void)
> >> +{
> >> +	return 4;
> >> +}
> >> +#define cfi_get_offset cfi_get_offset
> >> +extern u32 cfi_bpf_hash;
> >> +extern u32 cfi_bpf_subprog_hash;
> >> +extern u32 cfi_get_func_hash(void *func);
> >> +#else
> >> +#define cfi_bpf_hash 0U
> >> +#define cfi_bpf_subprog_hash 0U
> >> +static inline u32 cfi_get_func_hash(void *func)
> >> +{
> >> +	return 0;
> >> +}
> >> +#endif /* CONFIG_CFI_CLANG */
> >> +#endif /* _ASM_ARM64_CFI_H */
> >> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> >> index 8ff6610af496..1715da7df137 100644
> >> --- a/arch/arm64/kernel/alternative.c
> >> +++ b/arch/arm64/kernel/alternative.c
> >> @@ -13,6 +13,7 @@
> >>  #include <linux/elf.h>
> >>  #include <asm/cacheflush.h>
> >>  #include <asm/alternative.h>
> >> +#include <asm/cfi.h>
> >>  #include <asm/cpufeature.h>
> >>  #include <asm/insn.h>
> >>  #include <asm/module.h>
> >> @@ -298,3 +299,56 @@ noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
> >>  		updptr[i] = cpu_to_le32(aarch64_insn_gen_nop());
> >>  }
> >>  EXPORT_SYMBOL(alt_cb_patch_nops);
> >> +
> >> +#ifdef CONFIG_CFI_CLANG
> >> +struct bpf_insn;
> >> +
> >> +/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
> >> +extern unsigned int __bpf_prog_runX(const void *ctx,
> >> +				    const struct bpf_insn *insn);
> >> +
> >> +/*
> >> + * Force a reference to the external symbol so the compiler generates
> >> + * __kcfi_typid.
> >> + */
> >> +__ADDRESSABLE(__bpf_prog_runX);
> >> +
> >> +/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
> >> +asm (
> >> +"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
> >> +"	.type	cfi_bpf_hash,@object				\n"
> >> +"	.globl	cfi_bpf_hash					\n"
> >> +"	.p2align	2, 0x0					\n"
> >> +"cfi_bpf_hash:							\n"
> >> +"	.word	__kcfi_typeid___bpf_prog_runX			\n"
> >> +"	.size	cfi_bpf_hash, 4					\n"
> >> +"	.popsection						\n"
> >> +);
> >> +
> >> +/* Must match bpf_callback_t */
> >> +extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
> >> +
> >> +__ADDRESSABLE(__bpf_callback_fn);
> >> +
> >> +/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
> >> +asm (
> >> +"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
> >> +"	.type	cfi_bpf_subprog_hash,@object			\n"
> >> +"	.globl	cfi_bpf_subprog_hash				\n"
> >> +"	.p2align	2, 0x0					\n"
> >> +"cfi_bpf_subprog_hash:						\n"
> >> +"	.word	__kcfi_typeid___bpf_callback_fn			\n"
> >> +"	.size	cfi_bpf_subprog_hash, 4				\n"
> >> +"	.popsection						\n"
> >> +);
> >> +
> >> +u32 cfi_get_func_hash(void *func)
> >> +{
> >> +	u32 hash;
> >> +
> >> +	if (get_kernel_nofault(hash, func - cfi_get_offset()))
> >> +		return 0;
> >> +
> >> +	return hash;
> >> +}
> >> +#endif
> >
> > I realise this is following the example of x86, but this has nothing to do with
> > alternatives, so could we please place it elsewhere? e.g. add a new
> > arch/arm64/net/bpf_cfi.c?
> 
> Sure, a new file would work.
> How about: arch/arm64/kernel/cfi.c

Looking again, I don't think we actually need a new file. We should:

(1) Add a generic macro to define a variable with a KCFI type, and migrate
    existing code to this. See the patch at the end of this email.

(2) Use that macro within arch/arm64/net/bpf_jit_comp.c, which also avoids the
    need to define cfi_bpf_hash or cfi_bpf_subprog_hash in the asm/cfi.h
    header.

(3) Place cfi_get_func_hash() in the asm/cfi.h header for now.

> > Which functions is cfi_get_func_hash() used against? The comment in the code
> > below says:
> >
> > 	if (flags & BPF_TRAMP_F_INDIRECT) {
> > 		/*
> > 		 * Indirect call for bpf_struct_ops
> > 		 */
> > 		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
> > 	}
> >
> > ... but it's not clear to me which functions specifically would be in that
> > 'func_addr', not why returning 0 is fine -- surely we should fail compilation
> > if the provided function pointer causes a fault and we don't have a valid
> > typeid?
> 
> 'func_addr' will have one of the cfi_stubs like in net/ipv4/bpf_tcp_ca.c
> Explained in more detail below:

I see, so this is a stub function which will branch to the trampoline.

That explains which functions this'll be used for, but it doesn't explain why
we'd expect those to fault, not we why try to handle that by returning 0.

For CFI to work at all those should *never* fault, so we should be able to
write:

u32 cfi_get_func_hash(void *func)
{
	u32 *hashp = func - cfi_get_offset();
	return READ_ONCE(*hashp);
}

.. right? Or do we expect some of the stubs to be NULL?

> >> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> >> index bc16eb694657..2372812bb47c 100644
> >> --- a/arch/arm64/net/bpf_jit_comp.c
> >> +++ b/arch/arm64/net/bpf_jit_comp.c
> >> @@ -17,6 +17,7 @@
> >>  #include <asm/asm-extable.h>
> >>  #include <asm/byteorder.h>
> >>  #include <asm/cacheflush.h>
> >> +#include <asm/cfi.h>
> >>  #include <asm/debug-monitors.h>
> >>  #include <asm/insn.h>
> >>  #include <asm/patching.h>
> >> @@ -158,6 +159,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
> >>  		emit(insn, ctx);
> >>  }
> >>  
> >> +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
> >> +{
> >> +	if (IS_ENABLED(CONFIG_CFI_CLANG))
> >> +		emit(hash, ctx);
> >> +}
> >> +
> >>  /*
> >>   * Kernel addresses in the vmalloc space use at most 48 bits, and the
> >>   * remaining bits are guaranteed to be 0x1. So we can compose the address
> >> @@ -295,7 +302,7 @@ static bool is_lsi_offset(int offset, int scale)
> >>  #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
> >>  
> >>  static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
> >> -			  bool is_exception_cb)
> >> +			  bool is_exception_cb, bool is_subprog)
> >>  {
> >>  	const struct bpf_prog *prog = ctx->prog;
> >>  	const bool is_main_prog = !bpf_is_subprog(prog);
> >> @@ -306,7 +313,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
> >>  	const u8 fp = bpf2a64[BPF_REG_FP];
> >>  	const u8 tcc = bpf2a64[TCALL_CNT];
> >>  	const u8 fpb = bpf2a64[FP_BOTTOM];
> >> -	const int idx0 = ctx->idx;
> >>  	int cur_offset;
> >>  
> >>  	/*
> >> @@ -332,6 +338,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
> >>  	 *
> >>  	 */
> >>  
> >> +	emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
> >> +	const int idx0 = ctx->idx;
> >>  	/* bpf function may be invoked by 3 instruction types:
> >>  	 * 1. bl, attached via freplace to bpf prog via short jump
> >>  	 * 2. br, attached via freplace to bpf prog via long jump
> >> @@ -1648,7 +1656,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >>  	 * BPF line info needs ctx->offset[i] to be the offset of
> >>  	 * instruction[i] in jited image, so build prologue first.
> >>  	 */
> >> -	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb)) {
> >> +	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb,
> >> +			   bpf_is_subprog(prog))) {
> >>  		prog = orig_prog;
> >>  		goto out_off;
> >>  	}
> >> @@ -1696,7 +1705,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >>  	ctx.idx = 0;
> >>  	ctx.exentry_idx = 0;
> >>  
> >> -	build_prologue(&ctx, was_classic, prog->aux->exception_cb);
> >> +	build_prologue(&ctx, was_classic, prog->aux->exception_cb,
> >> +		       bpf_is_subprog(prog));
> >>  
> >>  	if (build_body(&ctx, extra_pass)) {
> >>  		prog = orig_prog;
> >> @@ -1745,9 +1755,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >>  		jit_data->ro_header = ro_header;
> >>  	}
> >>  
> >> -	prog->bpf_func = (void *)ctx.ro_image;
> >> +	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
> >>  	prog->jited = 1;
> >> -	prog->jited_len = prog_size;
> >> +	prog->jited_len = prog_size - cfi_get_offset();
> >>  
> >>  	if (!prog->is_func || extra_pass) {
> >>  		int i;
> >> @@ -2011,6 +2021,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
> >>  	/* return address locates above FP */
> >>  	retaddr_off = stack_size + 8;
> >>  
> >> +	if (flags & BPF_TRAMP_F_INDIRECT) {
> >> +		/*
> >> +		 * Indirect call for bpf_struct_ops
> >> +		 */
> >> +		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
> >> +	}
> >
> > I'm confused; why does the trampoline need this?
> >
> > The code that branches to the trampoline doesn't check the type hash: either
> > the callsite branches directly (hence no check), or the common ftrace
> > trampoline does so indirectly, and the latter doesn't know the expected typeid,
> > so it cannot check.
> 
> This is not used when the trampoline is attached to the entry of a
> kernel function and called through a direct call or from ftrace_caller.
> 
> This is only used when we are building a trampoline for bpf_struct_ops.
> 
> Here a kernel subsystem can call this trampoline through a function
> pointer.
> 
> See: tools/testing/selftests/bpf/progs/bpf_dctcp.c
> 
> Here tcp_congestion_ops functions are implemented in BPF and
> registered with the networking subsystem.
> 
> So, the networking subsystem will call them directly for example like:
> 
> struct tcp_congestion_ops *ca_ops = ....
> 
> ca_ops->cwnd_event(sk, event);
> 
> cwnd_event() is implemented in BPF and this call will land on a
> trampoline. Because this is being called from the kernel through a
> function pointer, type_id will be checked. So, the landing location in
> the trampoline should have a type_id above it.
> 
> In the above example kernel is calling a function of type
> void cwnd_event(struct sock *sk, enum tcp_ca_event ev);
> 
> so the calling code will fetch the type_id from above the destination
> and compare it with the type_id of the above prototype.
> 
> To make this work with BPF trampolines, we define stubs while
> registering these struct_ops with the BPF subsystem.
> 
> Like in net/ipv4/bpf_tcp_ca.c
> a stub is defined like following:
> 
> static void bpf_tcp_ca_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
> {
> }
> 
> This is what `func_addr` will have in the prepare_trampoline() function
> and we use cfi_get_func_hash() to fetch the type_id and put it above the
> landing location in the trampoline.

Thanks, that makes sense.

Mark.
---->8----
From 90fe9fa0850216e86daa37c430a3878462ba3e88 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 2 Apr 2024 13:56:44 +0100
Subject: [PATCH] cfi: add C CFI type macro

Currently x86 and riscv open-code 4 instances of the same logic to
define a u32 variable with the KCFI typeid of a given function.

Replace the duplicate logic with a common macro.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/riscv/kernel/cfi.c       | 34 ++--------------------------------
 arch/x86/kernel/alternative.c | 35 +++--------------------------------
 include/linux/cfi_types.h     | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+), 64 deletions(-)

diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
index 64bdd3e1ab8ca..b78a6f41df22d 100644
--- a/arch/riscv/kernel/cfi.c
+++ b/arch/riscv/kernel/cfi.c
@@ -82,41 +82,11 @@ struct bpf_insn;
 /* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
 extern unsigned int __bpf_prog_runX(const void *ctx,
 				    const struct bpf_insn *insn);
-
-/*
- * Force a reference to the external symbol so the compiler generates
- * __kcfi_typid.
- */
-__ADDRESSABLE(__bpf_prog_runX);
-
-/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_hash,@object				\n"
-"	.globl	cfi_bpf_hash					\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_hash:							\n"
-"	.word	__kcfi_typeid___bpf_prog_runX			\n"
-"	.size	cfi_bpf_hash, 4					\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
 
 /* Must match bpf_callback_t */
 extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-
-__ADDRESSABLE(__bpf_callback_fn);
-
-/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_subprog_hash,@object			\n"
-"	.globl	cfi_bpf_subprog_hash				\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_subprog_hash:						\n"
-"	.word	__kcfi_typeid___bpf_callback_fn			\n"
-"	.size	cfi_bpf_subprog_hash, 4				\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
 
 u32 cfi_get_func_hash(void *func)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 45a280f2161cd..a822699a40ddd 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #define pr_fmt(fmt) "SMP alternatives: " fmt
 
+#include <linux/cfi_types.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/perf_event.h>
@@ -918,41 +919,11 @@ struct bpf_insn;
 /* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
 extern unsigned int __bpf_prog_runX(const void *ctx,
 				    const struct bpf_insn *insn);
-
-/*
- * Force a reference to the external symbol so the compiler generates
- * __kcfi_typid.
- */
-__ADDRESSABLE(__bpf_prog_runX);
-
-/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_hash,@object				\n"
-"	.globl	cfi_bpf_hash					\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_hash:							\n"
-"	.long	__kcfi_typeid___bpf_prog_runX			\n"
-"	.size	cfi_bpf_hash, 4					\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
 
 /* Must match bpf_callback_t */
 extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
-
-__ADDRESSABLE(__bpf_callback_fn);
-
-/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
-asm (
-"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
-"	.type	cfi_bpf_subprog_hash,@object			\n"
-"	.globl	cfi_bpf_subprog_hash				\n"
-"	.p2align	2, 0x0					\n"
-"cfi_bpf_subprog_hash:						\n"
-"	.long	__kcfi_typeid___bpf_callback_fn			\n"
-"	.size	cfi_bpf_subprog_hash, 4				\n"
-"	.popsection						\n"
-);
+DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
 
 u32 cfi_get_func_hash(void *func)
 {
diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
index 6b87136757655..f510e62ca8b18 100644
--- a/include/linux/cfi_types.h
+++ b/include/linux/cfi_types.h
@@ -41,5 +41,28 @@
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_CFI_CLANG
+#define DEFINE_CFI_TYPE(name, func)						\
+	/*									\
+	 * Force a reference to the function so the compiler generates		\
+	 * __kcfi_typeid_<func>.						\
+	 */									\
+	__ADDRESSABLE(func);							\
+	/* u32 name = __kcfi_typeid_<func> */					\
+	extern u32 name;							\
+	asm (									\
+	"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"	\
+	"	.type	" #name ",@object				\n"	\
+	"	.globl	" #name "					\n"	\
+	"	.p2align	2, 0x0					\n"	\
+	#name ":							\n"	\
+	"	.long	__kcfi_typeid_" #func "				\n"	\
+	"	.size	" #name ", 4					\n"	\
+	"	.popsection						\n"	\
+	);
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* _LINUX_CFI_TYPES_H */
-- 
2.30.2


