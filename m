Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8846377D51C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbjHOV3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbjHOV3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC119A5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB7564F30
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 21:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94B0C433C8;
        Tue, 15 Aug 2023 21:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692134973;
        bh=vMoRI2FCgjgw9EgSaAQ8UFOcVszg2WD7sSc1PCCHh3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CS9RP2CI15lngUo6rOH1dH8j6gXLjy/iJ8l6KdcHxOCbXGyU8qsPS/aq0Y7V93BR+
         gppst5LArxyybEO8yMFcLrWYUo/I68adSO8rvZhkzqFivtjm5iL1ueEjx8oV+re29X
         3+ViLDEtUrG8n8htu3Do8MTSzVD7WfZXyBu5Pu2tYA0Y1dOz+zDtNqXZQca83+b/0r
         jon69RAOKgkH0b9iYVgxebUF0xMHjzoiiWM8MStIThZSQSMNRs2kC0tFhz8bXqjk09
         8Ih+ybDAZcxhWhWuhX7HBZ95/p4BVbjv5vpP6V4kdI+uUvwoL++7SRH0AftjZki2WT
         YqlyDQlnfof1A==
Date:   Tue, 15 Aug 2023 14:29:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 05/11] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230815212931.GA3863294@dev-arch.thelio-3990X>
References: <20230814114426.057251214@infradead.org>
 <20230814121148.842775684@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814121148.842775684@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Aug 14, 2023 at 01:44:31PM +0200, Peter Zijlstra wrote:

<snip>

>  arch/x86/include/asm/nospec-branch.h |    6 ++++
>  arch/x86/kernel/cpu/bugs.c           |    8 ++++--
>  arch/x86/kernel/vmlinux.lds.S        |    2 -
>  arch/x86/lib/retpoline.S             |   45 ++++++++++++++++++++++-------------
>  tools/objtool/arch/x86/decode.c      |    2 -
>  5 files changed, 43 insertions(+), 20 deletions(-)
> 
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -342,9 +342,15 @@ extern retpoline_thunk_t __x86_indirect_
>  extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
>  
>  extern void __x86_return_thunk(void);
> +
> +extern void zen_return_thunk(void);
> +extern void srso_return_thunk(void);
> +extern void srso_alias_return_thunk(void);
> +
>  extern void zen_untrain_ret(void);
>  extern void srso_untrain_ret(void);
>  extern void srso_untrain_ret_alias(void);
> +
>  extern void entry_ibpb(void);
>  
>  extern void (*x86_return_thunk)(void);
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1034,6 +1034,7 @@ static void __init retbleed_select_mitig
>  	case RETBLEED_MITIGATION_UNRET:
>  		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
>  		setup_force_cpu_cap(X86_FEATURE_UNRET);
> +		x86_return_thunk = zen_return_thunk;
>  
>  		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
>  		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
> @@ -2451,10 +2452,13 @@ static void __init srso_select_mitigatio
>  			 */
>  			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
>  
> -			if (boot_cpu_data.x86 == 0x19)
> +			if (boot_cpu_data.x86 == 0x19) {
>  				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
> -			else
> +				x86_return_thunk = srso_alias_return_thunk;
> +			} else {
>  				setup_force_cpu_cap(X86_FEATURE_SRSO);
> +				x86_return_thunk = srso_return_thunk;
> +			}
>  			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
>  		} else {
>  			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -521,7 +521,7 @@ INIT_PER_CPU(irq_stack_backing_store);
>  #endif
>  
>  #ifdef CONFIG_RETHUNK
> -. = ASSERT((__ret & 0x3f) == 0, "__ret not cacheline-aligned");
> +. = ASSERT((zen_return_thunk & 0x3f) == 0, "zen_return_thunk not cacheline-aligned");
>  . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
>  #endif
>  
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -151,22 +151,20 @@ SYM_CODE_END(__x86_indirect_jump_thunk_a
>  	.section .text..__x86.rethunk_untrain
>  
>  SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
> +	UNWIND_HINT_FUNC
>  	ANNOTATE_NOENDBR
>  	ASM_NOP2
>  	lfence
> -	jmp __x86_return_thunk
> +	jmp srso_alias_return_thunk
>  SYM_FUNC_END(srso_untrain_ret_alias)
>  __EXPORT_THUNK(srso_untrain_ret_alias)
>  
>  	.section .text..__x86.rethunk_safe
>  #endif
>  
> -/* Needs a definition for the __x86_return_thunk alternative below. */
>  SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
> -#ifdef CONFIG_CPU_SRSO
>  	lea 8(%_ASM_SP), %_ASM_SP
>  	UNWIND_HINT_FUNC
> -#endif
>  	ANNOTATE_UNRET_SAFE
>  	ret
>  	int3
> @@ -174,9 +172,16 @@ SYM_FUNC_END(srso_safe_ret_alias)
>  
>  	.section .text..__x86.return_thunk
>  
> +SYM_CODE_START(srso_alias_return_thunk)
> +	UNWIND_HINT_FUNC
> +	ANNOTATE_NOENDBR
> +	call srso_safe_ret_alias
> +	ud2
> +SYM_CODE_END(srso_alias_return_thunk)
> +
>  /*
>   * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
> - * 1) The RET at __x86_return_thunk must be on a 64 byte boundary, for
> + * 1) The RET at zen_return_thunk must be on a 64 byte boundary, for
>   *    alignment within the BTB.
>   * 2) The instruction at zen_untrain_ret must contain, and not
>   *    end with, the 0xc3 byte of the RET.
> @@ -184,7 +189,7 @@ SYM_FUNC_END(srso_safe_ret_alias)
>   *    from re-poisioning the BTB prediction.
>   */
>  	.align 64
> -	.skip 64 - (__ret - zen_untrain_ret), 0xcc
> +	.skip 64 - (zen_return_thunk - zen_untrain_ret), 0xcc
>  SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
>  	ANNOTATE_NOENDBR
>  	/*
> @@ -192,16 +197,16 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL,
>  	 *
>  	 *   TEST $0xcc, %bl
>  	 *   LFENCE
> -	 *   JMP __x86_return_thunk
> +	 *   JMP zen_return_thunk
>  	 *
>  	 * Executing the TEST instruction has a side effect of evicting any BTB
>  	 * prediction (potentially attacker controlled) attached to the RET, as
> -	 * __x86_return_thunk + 1 isn't an instruction boundary at the moment.
> +	 * zen_return_thunk + 1 isn't an instruction boundary at the moment.
>  	 */
>  	.byte	0xf6
>  
>  	/*
> -	 * As executed from __x86_return_thunk, this is a plain RET.
> +	 * As executed from zen_return_thunk, this is a plain RET.
>  	 *
>  	 * As part of the TEST above, RET is the ModRM byte, and INT3 the imm8.
>  	 *
> @@ -213,13 +218,13 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL,
>  	 * With SMT enabled and STIBP active, a sibling thread cannot poison
>  	 * RET's prediction to a type of its choice, but can evict the
>  	 * prediction due to competitive sharing. If the prediction is
> -	 * evicted, __x86_return_thunk will suffer Straight Line Speculation
> +	 * evicted, zen_return_thunk will suffer Straight Line Speculation
>  	 * which will be contained safely by the INT3.
>  	 */
> -SYM_INNER_LABEL(__ret, SYM_L_GLOBAL)
> +SYM_INNER_LABEL(zen_return_thunk, SYM_L_GLOBAL)
>  	ret
>  	int3
> -SYM_CODE_END(__ret)
> +SYM_CODE_END(zen_return_thunk)
>  
>  	/*
>  	 * Ensure the TEST decoding / BTB invalidation is complete.
> @@ -230,7 +235,7 @@ SYM_CODE_END(__ret)
>  	 * Jump back and execute the RET in the middle of the TEST instruction.
>  	 * INT3 is for SLS protection.
>  	 */
> -	jmp __ret
> +	jmp zen_return_thunk
>  	int3
>  SYM_FUNC_END(zen_untrain_ret)
>  __EXPORT_THUNK(zen_untrain_ret)
> @@ -256,6 +261,7 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLO
>  	ret
>  	int3
>  	int3
> +	/* end of movabs */
>  	lfence
>  	call srso_safe_ret
>  	ud2
> @@ -263,12 +269,19 @@ SYM_CODE_END(srso_safe_ret)
>  SYM_FUNC_END(srso_untrain_ret)
>  __EXPORT_THUNK(srso_untrain_ret)
>  
> -SYM_CODE_START(__x86_return_thunk)
> +SYM_CODE_START(srso_return_thunk)
>  	UNWIND_HINT_FUNC
>  	ANNOTATE_NOENDBR
> -	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
> -			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
> +	call srso_safe_ret
>  	ud2
> +SYM_CODE_END(srso_return_thunk)
> +
> +SYM_CODE_START(__x86_return_thunk)
> +	UNWIND_HINT_FUNC
> +	ANNOTATE_NOENDBR
> +	ANNOTATE_UNRET_SAFE
> +	ret
> +	int3
>  SYM_CODE_END(__x86_return_thunk)
>  EXPORT_SYMBOL(__x86_return_thunk)
>  
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -829,6 +829,6 @@ bool arch_is_rethunk(struct symbol *sym)
>  
>  bool arch_is_embedded_insn(struct symbol *sym)
>  {
> -	return !strcmp(sym->name, "__ret") ||
> +	return !strcmp(sym->name, "zen_return_thunk") ||
>  	       !strcmp(sym->name, "srso_safe_ret");
>  }
> 
> 

I applied this change on top of -tip master and linux-next, where it
appears to break i386_defconfig (I see this error in other
configurations too but defconfig is obviously a simple target) with both
GCC and LLVM:

  i386-linux-ld: arch/x86/kernel/cpu/bugs.o: in function `cpu_select_mitigations':
  bugs.c:(.init.text+0xe61): undefined reference to `zen_return_thunk'
  i386-linux-ld: bugs.c:(.init.text+0xe66): undefined reference to `x86_return_thunk'

  ld.lld: error: undefined symbol: x86_return_thunk
  >>> referenced by bugs.c
  >>>               arch/x86/kernel/cpu/bugs.o:(retbleed_select_mitigation) in archive vmlinux.a

  ld.lld: error: undefined symbol: zen_return_thunk
  >>> referenced by bugs.c
  >>>               arch/x86/kernel/cpu/bugs.o:(retbleed_select_mitigation) in archive vmlinux.a

It is still present at the head of the series, just with the function
rename.

  i386-linux-ld: arch/x86/kernel/cpu/bugs.o: in function `cpu_select_mitigations':
  bugs.c:(.init.text+0xe61): undefined reference to `retbleed_return_thunk'
  i386-linux-ld: bugs.c:(.init.text+0xe66): undefined reference to `x86_return_thunk'

  ld.lld: error: undefined symbol: x86_return_thunk
  >>> referenced by bugs.c
  >>>               arch/x86/kernel/cpu/bugs.o:(retbleed_select_mitigation) in archive vmlinux.a

  ld.lld: error: undefined symbol: retbleed_return_thunk
  >>> referenced by bugs.c
  >>>               arch/x86/kernel/cpu/bugs.o:(retbleed_select_mitigation) in archive vmlinux.a

This configuration does have

  # CONFIG_RETHUNK is not set

but turning it on does not resolve the x86_return_thunk error...

  i386-linux-ld: arch/x86/kernel/static_call.o: in function `__static_call_transform':
  static_call.c:(.ref.text+0x4a): undefined reference to `x86_return_thunk'
  i386-linux-ld: static_call.c:(.ref.text+0x137): undefined reference to `x86_return_thunk'
  i386-linux-ld: arch/x86/kernel/cpu/bugs.o: in function `cpu_select_mitigations':
  bugs.c:(.init.text+0xef2): undefined reference to `x86_return_thunk'

  ld.lld: error: undefined symbol: x86_return_thunk
  >>> referenced by static_call.c
  >>>               arch/x86/kernel/static_call.o:(__static_call_transform) in archive vmlinux.a
  >>> referenced by static_call.c
  >>>               arch/x86/kernel/static_call.o:(__static_call_transform) in archive vmlinux.a
  >>> referenced by bugs.c
  >>>               arch/x86/kernel/cpu/bugs.o:(retbleed_select_mitigation) in archive vmlinux.a

I'd keep digging but I am running out of time for the day, hence just
the report rather than a fix.

Cheers,
Nathan
