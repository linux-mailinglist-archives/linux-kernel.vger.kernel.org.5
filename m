Return-Path: <linux-kernel+bounces-94561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A987416C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20551C239A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F312B82;
	Wed,  6 Mar 2024 20:36:02 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A61179C4;
	Wed,  6 Mar 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709757362; cv=none; b=Pdx/6H7wBxVRoyhRC0kTjArlDpWuJNR8GkQhTSrFWrqQq5peOaq5kNlQSjWzOdrurWBQW7XDxn5Ht24e33/IxZlW6oSoI1vpimZ+9NeAYAe+lsJSP6PtQWYl/pdLGMa5BGSkGuHSjpMleTLZ6dW/NrcrMhShJ6jDRsAdvowmXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709757362; c=relaxed/simple;
	bh=j16xjI6QPrW8EJISbNkVYs9KIKkk0Nfa1UEjhyPd8SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H4zinlCMUKr4cww55zaJMHjitiWLucF4p5Vqe7dOcRHdUYCQktWsSDtoo1UzLytwNSJ2seoesEr9jTMZCC49l3TWmXAPyEQ+lhYjQueAqNR0XEBcSBlnkyF5sqN8taRDMWdCjwxDqZB6TKhl/NKH1mgscKyiPZk7GKHY7YNOKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A12AB240003;
	Wed,  6 Mar 2024 20:35:50 +0000 (UTC)
Message-ID: <34c9d54a-0f19-4671-8b05-9adf3b6c9a1a@ghiti.fr>
Date: Wed, 6 Mar 2024 21:35:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Sami Tolvanen <samitolvanen@google.com>, Guo Ren <guoren@kernel.org>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Deepak Gupta <debug@rivosinc.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Song Shuai <suagrfillet@gmail.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20240306165904.108141-1-puranjay12@gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240306165904.108141-1-puranjay12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Puranjay,

On 06/03/2024 17:59, Puranjay Mohan wrote:
> This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
> This allows each ftrace callsite to provide an ftrace_ops to the common
> ftrace trampoline, allowing each callsite to invoke distinct tracer
> functions without the need to fall back to list processing or to
> allocate custom trampolines for each callsite. This significantly speeds
> up cases where multiple distinct trace functions are used and callsites
> are mostly traced by a single tracer.
>
> The idea and most of the implementation is taken from the ARM64's
> implementation of the same feature. The idea is to place a pointer to
> the ftrace_ops as a literal at a fixed offset from the function entry
> point, which can be recovered by the common ftrace trampoline.
>
> We use -fpatchable-function-entry to reserve 8 bytes above the function
> entry by emitting 2 4 byte or 4 2 byte  nops depending on the presence of
> CONFIG_RISCV_ISA_C. These 8 bytes are patched at runtime with a pointer
> to the associated ftrace_ops for that callsite. Functions are aligned to
> 8 bytes to make sure that the accesses to this literal are atomic.
>
> This approach allows for directly invoking ftrace_ops::func even for
> ftrace_ops which are dynamically-allocated (or part of a module),
> without going via ftrace_ops_list_func.
>
> I've benchamrked this with the ftrace_ops sample module on Qemu, with
> the next version, I will provide benchmarks on real hardware:
>
> Without this patch:
>
> +-----------------------+-----------------+----------------------------+
> |  Number of tracers    | Total time (ns) | Per-call average time      |
> |-----------------------+-----------------+----------------------------|
> | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns) |
> |----------+------------+-----------------+------------+---------------|
> |        0 |          0 |        15615700 |        156 |             - |
> |        0 |          1 |        15917600 |        159 |             - |
> |        0 |          2 |        15668000 |        156 |             - |
> |        0 |         10 |        14971500 |        149 |             - |
> |        0 |        100 |        15417600 |        154 |             - |
> |        0 |        200 |        15387000 |        153 |             - |
> |----------+------------+-----------------+------------+---------------|
> |        1 |          0 |       119906800 |       1199 |          1043 |
> |        1 |          1 |       137428600 |       1374 |          1218 |
> |        1 |          2 |       159562400 |       1374 |          1218 |
> |        1 |         10 |       302099900 |       3020 |          2864 |
> |        1 |        100 |      2008785500 |      20087 |         19931 |
> |        1 |        200 |      3965221900 |      39652 |         39496 |
> |----------+------------+-----------------+------------+---------------|
> |        1 |          0 |       119166700 |       1191 |          1035 |
> |        2 |          0 |       157999900 |       1579 |          1423 |
> |       10 |          0 |       425370100 |       4253 |          4097 |
> |      100 |          0 |      3595252100 |      35952 |         35796 |
> |      200 |          0 |      7023485700 |      70234 |         70078 |
> +----------+------------+-----------------+------------+---------------+
>
> Note: per-call overhead is estimated relative to the baseline case with
> 0 relevant tracers and 0 irrelevant tracers.
>
> With this patch:
>
> +-----------------------+-----------------+----------------------------+
> |   Number of tracers   | Total time (ns) | Per-call average time      |
> |-----------------------+-----------------+----------------------------|
> | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns) |
> |----------+------------+-----------------+------------+---------------|
> |        0 |          0 |        15254600 |        152 |             - |
> |        0 |          1 |        16136700 |        161 |             - |
> |        0 |          2 |        15329500 |        153 |             - |
> |        0 |         10 |        15148800 |        151 |             - |
> |        0 |        100 |        15746900 |        157 |             - |
> |        0 |        200 |        15737400 |        157 |             - |
> |----------+------------+-----------------+------------+---------------|
> |        1 |          0 |        47909000 |        479 |           327 |
> |        1 |          1 |        48297400 |        482 |           330 |
> |        1 |          2 |        47314100 |        473 |           321 |
> |        1 |         10 |        47844900 |        478 |           326 |
> |        1 |        100 |        46591900 |        465 |           313 |
> |        1 |        200 |        47178900 |        471 |           319 |
> |----------+------------+-----------------+------------+---------------|
> |        1 |          0 |        46715800 |        467 |           315 |
> |        2 |          0 |       155134500 |       1551 |          1399 |
> |       10 |          0 |       442672800 |       4426 |          4274 |
> |      100 |          0 |      4092353900 |      40923 |         40771 |
> |      200 |          0 |      7135796400 |      71357 |         71205 |
> +----------+------------+-----------------+------------+---------------+
>
> Note: per-call overhead is estimated relative to the baseline case with
> 0 relevant tracers and 0 irrelevant tracers.
>
> As can be seen from the above:
>
>   a) Whenever there is a single relevant tracer function associated with a
>      tracee, the overhead of invoking the tracer is constant, and does not
>      scale with the number of tracers which are *not* associated with that
>      tracee.
>
>   b) The overhead for a single relevant tracer has dropped to ~1/3 of the
>      overhead prior to this series (from 1035ns to 315ns). This is largely
>      due to permitting calls to dynamically-allocated ftrace_ops without
>      going through ftrace_ops_list_func.
>
> Why is this patch a RFC patch:
>   1. I saw some rcu stalls on Qemu and need to debug them and see if they
>      were introduced by this patch.


FYI, I'm currently working on debugging such issues (and other) with the 
*current* ftrace implementation, so probably not caused by your 
patchset. But keep debugging too, maybe this introduces other issues or 
even better, you'll find the root cause :)


>   2. This needs to be tested thoroughly on real hardware.
>   3. Seeking reviews to fix any fundamental problems with this patch that I
>      might have missed due to my lack of RISC-V architecture knowledge.
>   4. I would like to benchmark this on real hardware and put the results in
>      the commit message.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>   arch/riscv/Kconfig              |  2 ++
>   arch/riscv/Makefile             |  8 +++++
>   arch/riscv/include/asm/ftrace.h |  3 ++
>   arch/riscv/kernel/asm-offsets.c |  3 ++
>   arch/riscv/kernel/ftrace.c      | 59 +++++++++++++++++++++++++++++++++
>   arch/riscv/kernel/mcount-dyn.S  | 42 ++++++++++++++++++++---
>   6 files changed, 112 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0bfcfec67ed5..e474742e23b2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -78,6 +78,7 @@ config RISCV
>   	select EDAC_SUPPORT
>   	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
>   	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
> +	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS


A recent discussion [1] states that -falign-functions cannot guarantee 
this alignment for all code and that gcc developers came up with a new 
option [2]: WDYT? I have added Andy and Evgenii in +cc to help on that.

[1] 
https://lore.kernel.org/linux-riscv/4fe4567b-96be-4102-952b-7d39109b2186@yadro.com/
[2] 
https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;h=0f5a9a00e3ab1fe96142f304cfbcf3f63b15f326


>   	select GENERIC_ARCH_TOPOLOGY
>   	select GENERIC_ATOMIC64 if !64BIT
>   	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> @@ -127,6 +128,7 @@ config RISCV
>   	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
>   	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>   	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> +	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_WITH_REGS && !CFI_CLANG)
>   	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>   	select HAVE_FUNCTION_GRAPH_TRACER
>   	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 252d63942f34..875ad5dc3d32 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -14,12 +14,20 @@ endif
>   ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>   	LDFLAGS_vmlinux += --no-relax
>   	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS), y)
> +ifeq ($(CONFIG_RISCV_ISA_C),y)
> +	CC_FLAGS_FTRACE := -fpatchable-function-entry=8,4
> +else
> +	CC_FLAGS_FTRACE := -fpatchable-function-entry=4,2
> +endif
> +else
>   ifeq ($(CONFIG_RISCV_ISA_C),y)
>   	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
>   else
>   	CC_FLAGS_FTRACE := -fpatchable-function-entry=2
>   endif
>   endif
> +endif
>   
>   ifeq ($(CONFIG_CMODEL_MEDLOW),y)
>   KBUILD_CFLAGS_MODULE += -mcmodel=medany
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 329172122952..c9a84222c9ea 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -28,6 +28,9 @@
>   void MCOUNT_NAME(void);
>   static inline unsigned long ftrace_call_adjust(unsigned long addr)
>   {
> +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> +		return addr + 8;
> +
>   	return addr;
>   }
>   
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index a03129f40c46..7d7c4b486852 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -488,4 +488,7 @@ void asm_offsets(void)
>   	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
>   	OFFSET(STACKFRAME_FP, stackframe, fp);
>   	OFFSET(STACKFRAME_RA, stackframe, ra);
> +#ifdef CONFIG_FUNCTION_TRACER
> +	DEFINE(FTRACE_OPS_FUNC,		offsetof(struct ftrace_ops, func));
> +#endif
>   }
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index f5aa24d9e1c1..e2e75e15d32e 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -82,9 +82,52 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> +static const struct ftrace_ops *riscv64_rec_get_ops(struct dyn_ftrace *rec)
> +{
> +	const struct ftrace_ops *ops = NULL;
> +
> +	if (rec->flags & FTRACE_FL_CALL_OPS_EN) {
> +		ops = ftrace_find_unique_ops(rec);
> +		WARN_ON_ONCE(!ops);
> +	}
> +
> +	if (!ops)
> +		ops = &ftrace_list_ops;
> +
> +	return ops;
> +}
> +
> +static int ftrace_rec_set_ops(const struct dyn_ftrace *rec,
> +			      const struct ftrace_ops *ops)
> +{
> +	unsigned long literal = rec->ip - 8;
> +
> +	return patch_text_nosync((void *)literal, &ops, sizeof(ops));
> +}
> +
> +static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec)
> +{
> +	return ftrace_rec_set_ops(rec, &ftrace_nop_ops);
> +}
> +
> +static int ftrace_rec_update_ops(struct dyn_ftrace *rec)
> +{
> +	return ftrace_rec_set_ops(rec, riscv64_rec_get_ops(rec));
> +}
> +#else
> +static int ftrace_rec_set_nop_ops(struct dyn_ftrace *rec) { return 0; }
> +static int ftrace_rec_update_ops(struct dyn_ftrace *rec) { return 0; }
> +#endif
> +
>   int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>   {
>   	unsigned int call[2];
> +	int ret;
> +
> +	ret = ftrace_rec_update_ops(rec);
> +	if (ret)
> +		return ret;
>   
>   	make_call_t0(rec->ip, addr, call);
>   
> @@ -98,6 +141,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>   		    unsigned long addr)
>   {
>   	unsigned int nops[2] = {NOP4, NOP4};
> +	int ret;
> +
> +	ret = ftrace_rec_set_nop_ops(rec);
> +	if (ret)
> +		return ret;
>   
>   	if (patch_text_nosync((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
>   		return -EPERM;
> @@ -125,6 +173,13 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>   
>   int ftrace_update_ftrace_func(ftrace_func_t func)
>   {
> +	/*
> +	 * When using CALL_OPS, the function to call is associated with the
> +	 * call site, and we don't have a global function pointer to update.
> +	 */
> +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> +		return 0;
> +
>   	int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
>   				       (unsigned long)func, true, true);
>   	if (!ret) {
> @@ -147,6 +202,10 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>   	make_call_t0(caller, old_addr, call);
>   	ret = ftrace_check_current_call(caller, call);
>   
> +	if (ret)
> +		return ret;
> +
> +	ret = ftrace_rec_update_ops(rec);
>   	if (ret)
>   		return ret;
>   
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index b7561288e8da..cb241e36e514 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -191,11 +191,35 @@
>   	.endm
>   
>   	.macro PREPARE_ARGS
> -	addi	a0, t0, -FENTRY_RA_OFFSET
> +	addi	a0, t0, -FENTRY_RA_OFFSET	// ip (callsite's auipc insn)
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> +	/*
> +	 * When CALL_OPS is enabled (2 or 4) nops [8B] are placed before the
> +	 * function entry, these are later overwritten with the pointer to the
> +	 * associated struct ftrace_ops.
> +	 *
> +	 * -8: &ftrace_ops of the associated tracer function.
> +	 *<ftrace enable>:
> +	 *  0: auipc  t0/ra, 0x?
> +	 *  4: jalr   t0/ra, ?(t0/ra)
> +	 *
> +	 * -8: &ftrace_nop_ops
> +	 *<ftrace disable>:
> +	 *  0: nop
> +	 *  4: nop
> +	 *
> +	 * t0 is set to ip+8 after the jalr is executed at the callsite,
> +	 * so we find the associated op at t0-16.
> +	 */
> +	mv 	a1, ra				// parent_ip
> +	REG_L   a2, -16(t0)			// op
> +	REG_L   ra, FTRACE_OPS_FUNC(a2)		// op->func
> +#else
>   	la	a1, function_trace_op
> -	REG_L	a2, 0(a1)
> -	mv	a1, ra
> -	mv	a3, sp
> +	REG_L	a2, 0(a1)			// op
> +	mv	a1, ra				// parent_ip
> +#endif
> +	mv	a3, sp				// regs
>   	.endm
>   
>   #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> @@ -233,8 +257,12 @@ SYM_FUNC_START(ftrace_regs_caller)
>   	SAVE_ABI_REGS 1
>   	PREPARE_ARGS
>   
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> +	jalr ra
> +#else
>   SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
>   	call	ftrace_stub
> +#endif
>   
>   	RESTORE_ABI_REGS 1
>   	bnez	t1, .Ldirect
> @@ -247,9 +275,13 @@ SYM_FUNC_START(ftrace_caller)
>   	SAVE_ABI_REGS 0
>   	PREPARE_ARGS
>   
> -SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
> +	jalr ra
> +#else
> +SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
>   	call	ftrace_stub
>   
> +#endif
>   	RESTORE_ABI_REGS 0
>   	jr	t0
>   SYM_FUNC_END(ftrace_caller)


As I'm diving into ftrace right now, I'll give a proper review soon. But 
as a note, I noticed that the function_graph tracer, when enabled, makes 
the whole system unresponsive (but still up, just very slow). A fix I 
sent recently seems to really improve that if you're interested in 
testing it (I am :)). You can find it here: 
https://lore.kernel.org/linux-riscv/20240229121056.203419-1-alexghiti@rivosinc.com/

Thanks,

Alex


