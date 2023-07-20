Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAAF75B211
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjGTPKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjGTPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236FE26AE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E47261B2D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C411C433C7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689865827;
        bh=zfqatIf+XzwxG02Gh6dH9f+o1ykPSJ1cZvGX5Czv7d4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J1S/X+ihP5b2R2aGA0acWJmtxTj9OJQ83geyAIzAXNp4Qfpu0DcOwqG87gfv5L2SN
         YLIW1/Xa7hBfs43ABy/zqQlAOojac1lhdfRN+PbQE5O6oc6bmEn2GPFVruA6BUv2Lp
         PPnnHzHpkWny9iHlsVC3yS7g8sbMdurGKwxV0zdDbk7J0YaBCC9drQTwx6JohKvGE6
         u/cK2pP/vzp/PQyG09VOTUoTauENNKpat9x932D+YdJTjXHKrfRxJ3g10KTh146Ajq
         /vn7DWT+kQzvxzbvqux1/xbctfKwRSWcXvQqLJSTCakZZ5e4HCtAhWak/p0F2qENew
         nqQhEjBopHxmQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-98de21518fbso161816566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:10:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLZUHq4+x5xCw4uJfo+ssp7gkrOHiwjX3n/JNdOGSBwfYH+Tv9Jb
        58Du9fAxIZn1tS//VRuFGM59Jc0olnLdOxq0cU4=
X-Google-Smtp-Source: APBJJlEe9xtACr1O7tLAlYVbCUhLFogZdsQpFKwOeMrOX7sarZ1OGgx7VPFdi65NkIB0dEk98xgL1GXSpW4RZXIja3Y=
X-Received: by 2002:a17:906:21b:b0:98d:e696:de4f with SMTP id
 27-20020a170906021b00b0098de696de4fmr6014937ejd.26.1689865825216; Thu, 20 Jul
 2023 08:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221124094845.1907443-1-debug@rivosinc.com>
In-Reply-To: <20221124094845.1907443-1-debug@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 Jul 2023 23:10:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT_-_Q2hQWWbt=CiUV4a3xq4Cw3s9A308KfTx0i55WSuw@mail.gmail.com>
Message-ID: <CAJF2gTT_-_Q2hQWWbt=CiUV4a3xq4Cw3s9A308KfTx0i55WSuw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: VMAP_STACK overflow detection thread-safe
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 5:48=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> commit 31da94c25aea ("riscv: add VMAP_STACK overflow detection") added
> support for CONFIG_VMAP_STACK. If overflow is detected, CPU switches to
> `shadow_stack` temporarily before switching finally to per-cpu
> `overflow_stack`.
>
> If two CPUs/harts are racing and end up in over flowing kernel stack, one
> or both will end up corrupting each other state because `shadow_stack` is
> not per-cpu. This patch optimizes per-cpu overflow stack switch by
> directly picking per-cpu `overflow_stack` and gets rid of `shadow_stack`.
>
> Following are the changes in this patch
>
>  - Defines an asm macro to obtain per-cpu symbols in destination
>    register.
>  - In entry.S, when overflow is detected, per-cpu overflow stack is
>    located using per-cpu asm macro. Computing per-cpu symbol requires
>    a temporary register. x31 is saved away into CSR_SCRATCH
>    (CSR_SCRATCH is anyways zero since we're in kernel).
>
> Please see Links for additional relevant disccussion and alternative
> solution.
>
> Tested by `echo EXHAUST_STACK > /sys/kernel/debug/provoke-crash/DIRECT`
> Kernel crash log below
>
>  Insufficient stack space to handle exception!/debug/provoke-crash/DIRECT
>  Task stack:     [0xff20000010a98000..0xff20000010a9c000]
>  Overflow stack: [0xff600001f7d98370..0xff600001f7d99370]
>  CPU: 1 PID: 205 Comm: bash Not tainted 6.1.0-rc2-00001-g328a1f96f7b9 #34
>  Hardware name: riscv-virtio,qemu (DT)
>  epc : __memset+0x60/0xfc
>   ra : recursive_loop+0x48/0xc6 [lkdtm]
>  epc : ffffffff808de0e4 ra : ffffffff0163a752 sp : ff20000010a97e80
>   gp : ffffffff815c0330 tp : ff600000820ea280 t0 : ff20000010a97e88
>   t1 : 000000000000002e t2 : 3233206874706564 s0 : ff20000010a982b0
>   s1 : 0000000000000012 a0 : ff20000010a97e88 a1 : 0000000000000000
>   a2 : 0000000000000400 a3 : ff20000010a98288 a4 : 0000000000000000
>   a5 : 0000000000000000 a6 : fffffffffffe43f0 a7 : 00007fffffffffff
>   s2 : ff20000010a97e88 s3 : ffffffff01644680 s4 : ff20000010a9be90
>   s5 : ff600000842ba6c0 s6 : 00aaaaaac29e42b0 s7 : 00fffffff0aa3684
>   s8 : 00aaaaaac2978040 s9 : 0000000000000065 s10: 00ffffff8a7cad10
>   s11: 00ffffff8a76a4e0 t3 : ffffffff815dbaf4 t4 : ffffffff815dbaf4
>   t5 : ffffffff815dbab8 t6 : ff20000010a9bb48
>  status: 0000000200000120 badaddr: ff20000010a97e88 cause: 00000000000000=
0f
>  Kernel panic - not syncing: Kernel stack overflow
>  CPU: 1 PID: 205 Comm: bash Not tainted 6.1.0-rc2-00001-g328a1f96f7b9 #34
>  Hardware name: riscv-virtio,qemu (DT)
>  Call Trace:
>  [<ffffffff80006754>] dump_backtrace+0x30/0x38
>  [<ffffffff808de798>] show_stack+0x40/0x4c
>  [<ffffffff808ea2a8>] dump_stack_lvl+0x44/0x5c
>  [<ffffffff808ea2d8>] dump_stack+0x18/0x20
>  [<ffffffff808dec06>] panic+0x126/0x2fe
>  [<ffffffff800065ea>] walk_stackframe+0x0/0xf0
>  [<ffffffff0163a752>] recursive_loop+0x48/0xc6 [lkdtm]
>  SMP: stopping secondary CPUs
>  ---[ end Kernel panic - not syncing: Kernel stack overflow ]---
>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Jisheng Zhang <jszhang@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/Y347B0x4VUNOd6V7@xhacker/T/#t
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>
> ---
> v1 --> v2:
>  - asm macro to locate per-cpu symbol requires a temp reg.
>    When stack overflow happens, in trap handler we don't have spare regs
>    except sp.
>    v1 had a place holder in `thread_info` to spill a register.
>    v2 instead uses CSR_SCRATCH register because it's free to use.
>
>  - v2 made per-cpu macro more readable.
>  - v2 fixed a bug that would've broken 32bit support.
>
>  - v1 called it a fix over 31da94c25aea. v2 calls it alternative/
>    optimization solution
> ---
>  arch/riscv/include/asm/asm.h    | 17 ++++++++++
>  arch/riscv/kernel/asm-offsets.c |  1 +
>  arch/riscv/kernel/entry.S       | 57 ++++++---------------------------
>  arch/riscv/kernel/traps.c       | 12 +------
>  4 files changed, 29 insertions(+), 58 deletions(-)
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index 1b471ff73178..1eb479cb9ae4 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -69,6 +69,7 @@
>
>  #ifdef __ASSEMBLY__
>
> +#include <asm/asm-offsets.h>
>  /* Common assembly source macros */
>
>  /*
> @@ -80,6 +81,22 @@
>         .endr
>  .endm
>
> +#ifdef CONFIG_32BIT
> +#define PER_CPU_OFFSET_SHIFT 2
> +#else
> +#define PER_CPU_OFFSET_SHIFT 3
> +#endif
> +
> +.macro asm_per_cpu dst sym tmp
> +       REG_L \tmp, TASK_TI_CPU_NUM(tp)
> +       slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
> +       la    \dst, __per_cpu_offset
> +       add   \dst, \dst, \tmp
> +       REG_L \tmp, 0(\dst)
> +       la    \dst, \sym
> +       add   \dst, \dst, \tmp
> +.endm
It's a tricky implementation, and we can't maintain it here because it
depends on percpu design.

> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_ASM_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offs=
ets.c
> index df9444397908..a7da051159cf 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -38,6 +38,7 @@ void asm_offsets(void)
>         OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>         OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>
> +       OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>         OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>         OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>         OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index b9eda3fcbd6d..2e90d9ccddd0 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -10,9 +10,11 @@
>  #include <asm/asm.h>
>  #include <asm/csr.h>
>  #include <asm/unistd.h>
> +#include <asm/page.h>
>  #include <asm/thread_info.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/errata_list.h>
> +#include <linux/sizes.h>
>
>  #if !IS_ENABLED(CONFIG_PREEMPTION)
>  .set resume_kernel, restore_all
> @@ -404,54 +406,15 @@ handle_syscall_trace_exit:
>
>  #ifdef CONFIG_VMAP_STACK
>  handle_kernel_stack_overflow:
> -       la sp, shadow_stack
> -       addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
> +       /* we reach here from kernel context, sscratch must be 0 */
> +       csrrw x31, CSR_SCRATCH, x31
> +       asm_per_cpu sp, overflow_stack, x31
> +       li x31, OVERFLOW_STACK_SIZE
> +       add sp, sp, x31
> +       /* zero out x31 again and restore x31 */
> +       xor x31, x31, x31
> +       csrrw x31, CSR_SCRATCH, x31
>
> -       //save caller register to shadow stack
> -       addi sp, sp, -(PT_SIZE_ON_STACK)
> -       REG_S x1,  PT_RA(sp)
> -       REG_S x5,  PT_T0(sp)
> -       REG_S x6,  PT_T1(sp)
> -       REG_S x7,  PT_T2(sp)
> -       REG_S x10, PT_A0(sp)
> -       REG_S x11, PT_A1(sp)
> -       REG_S x12, PT_A2(sp)
> -       REG_S x13, PT_A3(sp)
> -       REG_S x14, PT_A4(sp)
> -       REG_S x15, PT_A5(sp)
> -       REG_S x16, PT_A6(sp)
> -       REG_S x17, PT_A7(sp)
> -       REG_S x28, PT_T3(sp)
> -       REG_S x29, PT_T4(sp)
> -       REG_S x30, PT_T5(sp)
> -       REG_S x31, PT_T6(sp)
> -
> -       la ra, restore_caller_reg
> -       tail get_overflow_stack
> -
> -restore_caller_reg:
> -       //save per-cpu overflow stack
> -       REG_S a0, -8(sp)
> -       //restore caller register from shadow_stack
> -       REG_L x1,  PT_RA(sp)
> -       REG_L x5,  PT_T0(sp)
> -       REG_L x6,  PT_T1(sp)
> -       REG_L x7,  PT_T2(sp)
> -       REG_L x10, PT_A0(sp)
> -       REG_L x11, PT_A1(sp)
> -       REG_L x12, PT_A2(sp)
> -       REG_L x13, PT_A3(sp)
> -       REG_L x14, PT_A4(sp)
> -       REG_L x15, PT_A5(sp)
> -       REG_L x16, PT_A6(sp)
> -       REG_L x17, PT_A7(sp)
> -       REG_L x28, PT_T3(sp)
> -       REG_L x29, PT_T4(sp)
> -       REG_L x30, PT_T5(sp)
> -       REG_L x31, PT_T6(sp)
> -
> -       //load per-cpu overflow stack
> -       REG_L sp, -8(sp)
>         addi sp, sp, -(PT_SIZE_ON_STACK)
>
>         //save context to overflow stack
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f3e96d60a2ff..eef3a87514c7 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -208,18 +208,8 @@ int is_valid_bugaddr(unsigned long pc)
>  #endif /* CONFIG_GENERIC_BUG */
>
>  #ifdef CONFIG_VMAP_STACK
> -static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
> +DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>                 overflow_stack)__aligned(16);
> -/*
> - * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is =
used
> - * to get per-cpu overflow stack(get_overflow_stack).
> - */
> -long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
> -asmlinkage unsigned long get_overflow_stack(void)
> -{
> -       return (unsigned long)this_cpu_ptr(overflow_stack) +
> -               OVERFLOW_STACK_SIZE;
> -}
>
>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
> --
> 2.25.1
>


--=20
Best Regards
 Guo Ren
