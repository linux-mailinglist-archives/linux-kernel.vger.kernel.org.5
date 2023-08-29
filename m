Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749D78BD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjH2Dfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjH2Dfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88010110
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE3463602
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCDAC433CD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693280128;
        bh=iKPhNGsCL/Ygu2pp1A7Oz7Q5BwJOM7t42N7oX6j1hcc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EPvN6oKb2ozqhKwXfu2Q3lqyDo2gy67g8X6d6rAjEXIsdkDI6lgwZYYQ2/vcZyhJW
         cE6MMgHL/7N6jk+Igh/8OZ5nNwEdMn+rZ9zKe2pztkRYd9pxPTMu327v5b8QvePOxG
         oQkQU414P5ivtvhcQ3mSVV2eYoD0PWbPg3s/ml0CkFbKMGnhRepq423yKpNGTvZPaa
         w/aTbPMaXi7FwllFkbFF9suXpbvA6CGf8Q6Y6lhT9te4m/BeHG2OAoYLtxEb/jedbs
         48pbt2EnPYlTczuHS8W8NCZGJHQXTv3L/H5cbadVRJtOgQRCa4XqyoSTP780QLRsYm
         9uDXfhdc3VhLg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so5100885a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:35:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YzR1joL0zkyTM2mo1QgH49kR3pb8vRXBhFHSaXPZ+aUUVlgghJG
        SrV3lhwzdekPIIuS1WGSwbDA4xyElNUIJFbQRV0=
X-Google-Smtp-Source: AGHT+IFogORrIkVNKaIApsKdGJMvVvslXlT/2lRzZp/Uwa0P3GPm5dbqlCk8/vdnBCygmxeMeKCVxcAvJvJ7ZtZOPcE=
X-Received: by 2002:aa7:c04c:0:b0:522:3a89:a79d with SMTP id
 k12-20020aa7c04c000000b005223a89a79dmr19326892edo.2.1693280126664; Mon, 28
 Aug 2023 20:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230828195833.756747-8-samitolvanen@google.com> <20230828195833.756747-10-samitolvanen@google.com>
In-Reply-To: <20230828195833.756747-10-samitolvanen@google.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 29 Aug 2023 11:35:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTuwrKpYXLF2QR44PAz-Wk+2iE07M0UnhNHgPs0YNcQMQ@mail.gmail.com>
Message-ID: <CAJF2gTTuwrKpYXLF2QR44PAz-Wk+2iE07M0UnhNHgPs0YNcQMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] riscv: Deduplicate IRQ stack switching
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Clement Leger <cleger@rivosinc.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 3:58=E2=80=AFAM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> With CONFIG_IRQ_STACKS, we switch to a separate per-CPU IRQ stack
> before calling handle_riscv_irq or __do_softirq. We currently
> have duplicate inline assembly snippets for stack switching in
> both code paths. Now that we can access per-CPU variables in
> assembly, implement call_on_irq_stack in assembly, and use that
> instead of redudant inline assembly.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/riscv/include/asm/asm.h       |  5 +++++
>  arch/riscv/include/asm/irq_stack.h |  3 +++
>  arch/riscv/kernel/asm-offsets.c    |  5 +++++
>  arch/riscv/kernel/entry.S          | 30 +++++++++++++++++++++++++
>  arch/riscv/kernel/irq.c            | 35 +++++++-----------------------
>  arch/riscv/kernel/traps.c          | 32 ++++-----------------------
>  6 files changed, 55 insertions(+), 55 deletions(-)
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index bfb4c26f113c..8e446be2d57c 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -104,6 +104,11 @@
>  .endm
>  #endif /* CONFIG_SMP */
>
> +.macro load_per_cpu dst ptr tmp
> +       asm_per_cpu \dst \ptr \tmp
> +       REG_L \dst, 0(\dst)
> +.endm
> +
>         /* save all GPs except x1 ~ x5 */
>         .macro save_from_x6_to_x31
>         REG_S x6,  PT_T1(sp)
> diff --git a/arch/riscv/include/asm/irq_stack.h b/arch/riscv/include/asm/=
irq_stack.h
> index e4042d297580..6441ded3b0cf 100644
> --- a/arch/riscv/include/asm/irq_stack.h
> +++ b/arch/riscv/include/asm/irq_stack.h
> @@ -12,6 +12,9 @@
>
>  DECLARE_PER_CPU(ulong *, irq_stack_ptr);
>
> +asmlinkage void call_on_irq_stack(struct pt_regs *regs,
> +                                 void (*func)(struct pt_regs *));
> +
>  #ifdef CONFIG_VMAP_STACK
>  /*
>   * To ensure that VMAP'd stack overflow detection works correctly, all V=
MAP'd
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offs=
ets.c
> index 9f535d5de33f..0af8860f9d68 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -14,6 +14,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/ptrace.h>
>  #include <asm/cpu_ops_sbi.h>
> +#include <asm/stacktrace.h>
>  #include <asm/suspend.h>
>
>  void asm_offsets(void);
> @@ -480,4 +481,8 @@ void asm_offsets(void)
>         OFFSET(KERNEL_MAP_VIRT_ADDR, kernel_mapping, virt_addr);
>         OFFSET(SBI_HART_BOOT_TASK_PTR_OFFSET, sbi_hart_boot_data, task_pt=
r);
>         OFFSET(SBI_HART_BOOT_STACK_PTR_OFFSET, sbi_hart_boot_data, stack_=
ptr);
> +
> +       DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe),=
 STACK_ALIGN));
> +       OFFSET(STACKFRAME_FP, stackframe, fp);
> +       OFFSET(STACKFRAME_RA, stackframe, ra);
>  }
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 3d11aa3af105..a306562636e4 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -218,6 +218,36 @@ SYM_CODE_START(ret_from_fork)
>         tail syscall_exit_to_user_mode
>  SYM_CODE_END(ret_from_fork)
>
> +#ifdef CONFIG_IRQ_STACKS
> +/*
> + * void call_on_irq_stack(struct pt_regs *regs,
> + *                       void (*func)(struct pt_regs *));
> + *
> + * Calls func(regs) using the per-CPU IRQ stack.
> + */
> +SYM_FUNC_START(call_on_irq_stack)
> +       /* Create a frame record to save ra and s0 (fp) */
> +       addi    sp, sp, -STACKFRAME_SIZE_ON_STACK
> +       REG_S   ra, STACKFRAME_RA(sp)
> +       REG_S   s0, STACKFRAME_FP(sp)
> +       addi    s0, sp, STACKFRAME_SIZE_ON_STACK
> +
> +       /* Switch to the per-CPU IRQ stack and call the handler */
> +       load_per_cpu t0, irq_stack_ptr, t1
> +       li      t1, IRQ_STACK_SIZE
> +       add     sp, t0, t1
> +       jalr    a1
> +
> +       /* Switch back to the thread stack and restore ra and s0 */
> +       addi    sp, s0, -STACKFRAME_SIZE_ON_STACK
> +       REG_L   ra, STACKFRAME_RA(sp)
> +       REG_L   s0, STACKFRAME_FP(sp)
> +       addi    sp, sp, STACKFRAME_SIZE_ON_STACK
> +
> +       ret
> +SYM_FUNC_END(call_on_irq_stack)
> +#endif /* CONFIG_IRQ_STACKS */
> +
>  /*
>   * Integer register context switch
>   * The callee-saved registers must be saved and restored.
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index a8efa053c4a5..95dafdcbd135 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -61,35 +61,16 @@ static void init_irq_stacks(void)
>  #endif /* CONFIG_VMAP_STACK */
>
>  #ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
> +static void ___do_softirq(struct pt_regs *regs)
> +{
> +       __do_softirq();
> +}
> +
>  void do_softirq_own_stack(void)
>  {
> -#ifdef CONFIG_IRQ_STACKS
> -       if (on_thread_stack()) {
> -               ulong *sp =3D per_cpu(irq_stack_ptr, smp_processor_id())
> -                                       + IRQ_STACK_SIZE/sizeof(ulong);
> -               __asm__ __volatile(
> -               "addi   sp, sp, -"RISCV_SZPTR  "\n"
> -               REG_S"  ra, (sp)                \n"
> -               "addi   sp, sp, -"RISCV_SZPTR  "\n"
> -               REG_S"  s0, (sp)                \n"
> -               "addi   s0, sp, 2*"RISCV_SZPTR "\n"
> -               "move   sp, %[sp]               \n"
> -               "call   __do_softirq            \n"
> -               "addi   sp, s0, -2*"RISCV_SZPTR"\n"
> -               REG_L"  s0, (sp)                \n"
> -               "addi   sp, sp, "RISCV_SZPTR   "\n"
> -               REG_L"  ra, (sp)                \n"
> -               "addi   sp, sp, "RISCV_SZPTR   "\n"
> -               :
> -               : [sp] "r" (sp)
> -               : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
> -                 "t0", "t1", "t2", "t3", "t4", "t5", "t6",
> -#ifndef CONFIG_FRAME_POINTER
> -                 "s0",
> -#endif
> -                 "memory");
> -       } else
> -#endif
> +       if (on_thread_stack())
> +               call_on_irq_stack(NULL, ___do_softirq);
> +       else
>                 __do_softirq();
>  }
>  #endif /* CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK */
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index a05905d88802..1fe6b475cdfb 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -350,34 +350,10 @@ static void noinstr handle_riscv_irq(struct pt_regs=
 *regs)
>  asmlinkage void noinstr do_irq(struct pt_regs *regs)
>  {
>         irqentry_state_t state =3D irqentry_enter(regs);
> -#ifdef CONFIG_IRQ_STACKS
> -       if (on_thread_stack()) {
> -               ulong *sp =3D per_cpu(irq_stack_ptr, smp_processor_id())
> -                                       + IRQ_STACK_SIZE/sizeof(ulong);
> -               __asm__ __volatile(
> -               "addi   sp, sp, -"RISCV_SZPTR  "\n"
> -               REG_S"  ra, (sp)                \n"
> -               "addi   sp, sp, -"RISCV_SZPTR  "\n"
> -               REG_S"  s0, (sp)                \n"
> -               "addi   s0, sp, 2*"RISCV_SZPTR "\n"
> -               "move   sp, %[sp]               \n"
> -               "move   a0, %[regs]             \n"
> -               "call   handle_riscv_irq        \n"
> -               "addi   sp, s0, -2*"RISCV_SZPTR"\n"
> -               REG_L"  s0, (sp)                \n"
> -               "addi   sp, sp, "RISCV_SZPTR   "\n"
> -               REG_L"  ra, (sp)                \n"
> -               "addi   sp, sp, "RISCV_SZPTR   "\n"
> -               :
> -               : [sp] "r" (sp), [regs] "r" (regs)
> -               : "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
> -                 "t0", "t1", "t2", "t3", "t4", "t5", "t6",
> -#ifndef CONFIG_FRAME_POINTER
> -                 "s0",
> -#endif
> -                 "memory");
> -       } else
> -#endif
> +
> +       if (IS_ENABLED(CONFIG_IRQ_STACKS) && on_thread_stack())
> +               call_on_irq_stack(regs, handle_riscv_irq);
A good code optimization for maintenance.

Reviewed-by: Guo Ren <guoren@kernel.org>

> +       else
>                 handle_riscv_irq(regs);
>
>         irqentry_exit(regs, state);
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
>


--=20
Best Regards
 Guo Ren
