Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD4A7D8818
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjJZSQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZSQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:16:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E246192
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:16:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so2074324a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698344192; x=1698948992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYfLSAQQG2e4i194EsulolqwB4lRPQJWolEkKqUp6IM=;
        b=b819SCFkLRcUjroNaj7bKJqg/168brWxfFTq63wLDgyhA5hbNmoVvub/1/SVhgRkjW
         9SGhglom8vJHUfvuMYHUU6fDn9hdIhlrSMgWGD0vVJ6Jfu0UM2MTozV608iDxQLjkMGa
         CANu3yJeeM/k2cTR69Yvex0MiZbUXfADkGE8dlA9+aCfHnmCSKDzeVp4OfQ4n1S4Z+0z
         ga2XEMFMjcTC4eCbsqndt9ovpYbWfLDZnTLTJv5Aw6BPeSjziSDq5Di9W0L5K3IwIq9D
         6dk6gYq+jBpqcAWum6lf6gTsj5uW2LnnKN4rTTtr2OjIdLcnXeOduZBp2rdoFc0B6djB
         Re3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698344192; x=1698948992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYfLSAQQG2e4i194EsulolqwB4lRPQJWolEkKqUp6IM=;
        b=BqzVPuMEBEibZFXu2XQpkCn0mpkkpOcdZG1bqiI8F585QkTElHRSfr4v50mG1/Nufg
         jiW2GsO52D+AwDJaVIFANo/Nl5wsVCgjzUD1jaoKQaMGYEHPJj6upNOwoLXWza2PuCA3
         MeY+jSo6BeeB1pwlzUnMiUNdriQwXZXfU0W/UngAudnDK50U3mmIniDQt3Ky5zN+cEeS
         FUuNAxwAAH4e3t7UJ7zPmqxOPmjZVVQPQs3mXIuD4zzLBkHGFwdTtDUGynBxwLgKuEh/
         cmPCfB/FFZyQ2R4ny2ERDoA7iYo3AT6/fACTFSVsYFZIrUkfau/bbqlkZIuhSCyzzPRm
         x5CA==
X-Gm-Message-State: AOJu0YyNBiioKy/4EkZstOrWof/Fxh89R9ZafwtmCXnXhvXd6NZ02CQJ
        j7T8TVu269QOTWEg3O8lb5nILQB1Hce8eFEr+aQ=
X-Google-Smtp-Source: AGHT+IGZXDqn8/AaIlLOW9NvSLM99GXWYj3NPXGpkTEebmzTAbyN5Z53/YUG++L0r/4r47neb5RB5U1iYpJLUdQ3mS4=
X-Received: by 2002:aa7:d5c3:0:b0:532:e71b:5ead with SMTP id
 d3-20020aa7d5c3000000b00532e71b5eadmr450942eds.32.1698344190877; Thu, 26 Oct
 2023 11:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <20231026160100.195099-6-brgerst@gmail.com>
In-Reply-To: <20231026160100.195099-6-brgerst@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 26 Oct 2023 20:16:20 +0200
Message-ID: <CAFULd4atfV+oAWjb+NeAtoxpjUDevyPMAUf-Ff0H39+Jj=aR2g@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] x86/stackprotector/64: Convert stack protector
 to normal percpu variable
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 6:01=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> Older versions of GCC fixed the location of the stack protector canary
> at %gs:40.  This constraint forced the percpu section to be linked at
> virtual address 0 so that the canary could be the first data object in
> the percpu section.  Supporting the zero-based percpu section requires
> additional code to handle relocations for RIP-relative references to
> percpu data, extra complexity to kallsyms, and workarounds for linker
> bugs due to the use of absolute symbols.
>
> Since version 8.1, GCC has options to configure the location of the
> canary value.  This allows the canary to be turned into a normal
> percpu variable and removes the constraint that the percpu section
> be zero-based.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/Kconfig                      |  5 ++--
>  arch/x86/Makefile                     | 19 +++++++++-----
>  arch/x86/entry/entry_64.S             |  2 +-
>  arch/x86/include/asm/processor.h      | 15 +----------
>  arch/x86/include/asm/stackprotector.h | 37 +++++----------------------
>  arch/x86/kernel/asm-offsets_64.c      |  6 -----
>  arch/x86/kernel/cpu/common.c          |  4 +--
>  arch/x86/kernel/head_64.S             |  3 +--
>  arch/x86/xen/xen-head.S               |  3 +--
>  9 files changed, 26 insertions(+), 68 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 92144c6f26d2..c95e0ce557da 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -410,12 +410,11 @@ config PGTABLE_LEVELS
>
>  config CC_HAS_SANE_STACKPROTECTOR
>         bool
> -       default y if 64BIT
> +       default $(cc-option,-mstack-protector-guard-reg=3Dgs -mstack-prot=
ector-guard-symbol=3D__stack_chk_guard) if 64BIT
>         default $(cc-option,-mstack-protector-guard-reg=3Dfs -mstack-prot=
ector-guard-symbol=3D__stack_chk_guard)
>         help
>           We have to make sure stack protector is unconditionally disable=
d if
> -         the compiler produces broken code or if it does not let us cont=
rol
> -         the segment on 32-bit kernels.
> +         the compiler does not allow control of the segment and symbol.
>
>  menu "Processor type and features"
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 22e41d9dbc23..6ab8b4419f41 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -111,13 +111,7 @@ ifeq ($(CONFIG_X86_32),y)
>          # temporary until string.h is fixed
>          KBUILD_CFLAGS +=3D -ffreestanding
>
> -       ifeq ($(CONFIG_STACKPROTECTOR),y)
> -               ifeq ($(CONFIG_SMP),y)
> -                       KBUILD_CFLAGS +=3D -mstack-protector-guard-reg=3D=
fs -mstack-protector-guard-symbol=3D__stack_chk_guard
> -               else
> -                       KBUILD_CFLAGS +=3D -mstack-protector-guard=3Dglob=
al
> -               endif
> -       endif
> +       percpu_seg :=3D fs
>  else
>          BITS :=3D 64
>          UTS_MACHINE :=3D x86_64
> @@ -167,6 +161,17 @@ else
>          KBUILD_CFLAGS +=3D -mcmodel=3Dkernel
>          KBUILD_RUSTFLAGS +=3D -Cno-redzone=3Dy
>          KBUILD_RUSTFLAGS +=3D -Ccode-model=3Dkernel
> +
> +       percpu_seg :=3D gs
> +endif
> +
> +ifeq ($(CONFIG_STACKPROTECTOR),y)
> +       ifeq ($(CONFIG_SMP),y)
> +               KBUILD_CFLAGS +=3D -mstack-protector-guard-reg=3D$(percpu=
_seg)
> +               KBUILD_CFLAGS +=3D -mstack-protector-guard-symbol=3D__sta=
ck_chk_guard
> +       else
> +               KBUILD_CFLAGS +=3D -mstack-protector-guard=3Dglobal
> +       endif
>  endif
>
>  #
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 1a88ad8a7b48..cddcc236aaae 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -190,7 +190,7 @@ SYM_FUNC_START(__switch_to_asm)
>
>  #ifdef CONFIG_STACKPROTECTOR
>         movq    TASK_stack_canary(%rsi), %rbx
> -       movq    %rbx, PER_CPU_VAR(fixed_percpu_data + FIXED_stack_canary)
> +       movq    %rbx, PER_CPU_VAR(__stack_chk_guard)
>  #endif
>
>         /*
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 4b130d894cb6..2b6531d90273 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -394,16 +394,7 @@ struct irq_stack {
>
>  #ifdef CONFIG_X86_64
>  struct fixed_percpu_data {
> -       /*
> -        * GCC hardcodes the stack canary as %gs:40.  Since the
> -        * irq_stack is the object at %gs:0, we reserve the bottom
> -        * 48 bytes of the irq stack for the canary.
> -        *
> -        * Once we are willing to require -mstack-protector-guard-symbol=
=3D
> -        * support for x86_64 stackprotector, we can get rid of this.
> -        */
>         char            gs_base[40];
> -       unsigned long   stack_canary;
>  };
>
>  DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __vis=
ible;
> @@ -418,11 +409,7 @@ extern asmlinkage void entry_SYSCALL32_ignore(void);
>
>  /* Save actual FS/GS selectors and bases to current->thread */
>  void current_save_fsgs(void);
> -#else  /* X86_64 */
> -#ifdef CONFIG_STACKPROTECTOR
> -DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
> -#endif
> -#endif /* !X86_64 */
> +#endif /* X86_64 */
>
>  struct perf_event;
>
> diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm=
/stackprotector.h
> index 00473a650f51..33abbd29ea26 100644
> --- a/arch/x86/include/asm/stackprotector.h
> +++ b/arch/x86/include/asm/stackprotector.h
> @@ -2,26 +2,13 @@
>  /*
>   * GCC stack protector support.
>   *
> - * Stack protector works by putting predefined pattern at the start of
> + * Stack protector works by putting a predefined pattern at the start of
>   * the stack frame and verifying that it hasn't been overwritten when
> - * returning from the function.  The pattern is called stack canary
> - * and unfortunately gcc historically required it to be at a fixed offse=
t
> - * from the percpu segment base.  On x86_64, the offset is 40 bytes.
> + * returning from the function.  The pattern is called the stack canary
> + * and is a unique value for each task.
>   *
> - * The same segment is shared by percpu area and stack canary.  On
> - * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
> - * base of percpu area.  The first occupant of the percpu area is always
> - * fixed_percpu_data which contains stack_canary at the appropriate
> - * offset.  On x86_32, the stack canary is just a regular percpu
> - * variable.
> - *
> - * Putting percpu data in %fs on 32-bit is a minor optimization compared=
 to
> - * using %gs.  Since 32-bit userspace normally has %fs =3D=3D 0, we are =
likely
> - * to load 0 into %fs on exit to usermode, whereas with percpu data in
> - * %gs, we are likely to load a non-null %gs on return to user mode.
> - *
> - * Once we are willing to require GCC 8.1 or better for 64-bit stackprot=
ector
> - * support, we can remove some of this complexity.
> + * GCC is configured to read the stack canary value from the __stack_chk=
_guard
> + * per-cpu variable, which is changed on task switch.
>   */
>
>  #ifndef _ASM_STACKPROTECTOR_H
> @@ -36,6 +23,8 @@
>
>  #include <linux/sched.h>
>
> +DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
> +
>  /*
>   * Initialize the stackprotector canary value.
>   *
> @@ -51,25 +40,13 @@ static __always_inline void boot_init_stack_canary(vo=
id)
>  {
>         unsigned long canary =3D get_random_canary();
>
> -#ifdef CONFIG_X86_64
> -       BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) !=
=3D 40);
> -#endif
> -
>         current->stack_canary =3D canary;
> -#ifdef CONFIG_X86_64
> -       this_cpu_write(fixed_percpu_data.stack_canary, canary);
> -#else
>         this_cpu_write(__stack_chk_guard, canary);
> -#endif
>  }
>
>  static inline void cpu_init_stack_canary(int cpu, struct task_struct *id=
le)
>  {
> -#ifdef CONFIG_X86_64
> -       per_cpu(fixed_percpu_data.stack_canary, cpu) =3D idle->stack_cana=
ry;
> -#else
>         per_cpu(__stack_chk_guard, cpu) =3D idle->stack_canary;
> -#endif
>  }
>
>  #else  /* STACKPROTECTOR */
> diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offse=
ts_64.c
> index bb65371ea9df..590b6cd0eac0 100644
> --- a/arch/x86/kernel/asm-offsets_64.c
> +++ b/arch/x86/kernel/asm-offsets_64.c
> @@ -54,11 +54,5 @@ int main(void)
>         BLANK();
>  #undef ENTRY
>
> -       BLANK();
> -
> -#ifdef CONFIG_STACKPROTECTOR
> -       OFFSET(FIXED_stack_canary, fixed_percpu_data, stack_canary);
> -       BLANK();
> -#endif
>         return 0;
>  }
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 9058da9ae011..fb8f0371ffc3 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2104,15 +2104,13 @@ void syscall_init(void)
>                X86_EFLAGS_AC|X86_EFLAGS_ID);
>  }
>
> -#else  /* CONFIG_X86_64 */
> +#endif /* CONFIG_X86_64 */
>
>  #ifdef CONFIG_STACKPROTECTOR
>  DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
>  EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
>  #endif
>
> -#endif /* CONFIG_X86_64 */
> -
>  /*
>   * Clear all 6 debug registers:
>   */
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 3dcabbc49149..0d94d2a091fe 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -345,8 +345,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L=
_GLOBAL)
>
>         /* Set up %gs.
>          *
> -        * The base of %gs always points to fixed_percpu_data. If the
> -        * stack protector canary is enabled, it is located at %gs:40.
> +        * The base of %gs always points to fixed_percpu_data.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index a0ea285878db..30f27e757354 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -53,8 +53,7 @@ SYM_CODE_START(startup_xen)
>
>         /* Set up %gs.
>          *
> -        * The base of %gs always points to fixed_percpu_data.  If the
> -        * stack protector canary is enabled, it is located at %gs:40.
> +        * The base of %gs always points to fixed_percpu_data.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
> --
> 2.41.0
>
