Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB17D4FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJXMkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjJXMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:40:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678C3123
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:40:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso6927212a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698151203; x=1698756003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNeDAm67bVqR5ZuVcxBebip5vczn3fVpHDQR33oUAVo=;
        b=fLfgbWO5O+SNH2GpL/BUCsJrQna9jR66467leW44Cr+KI00Mrmg+iiLOBHs8iZvcnV
         wVhJXIme4TK+2hG/GYyZacK5RO8W6jQnsg8O+ykx43VMFcEQtY5vn13IQSIpB8oPSkiX
         Os8AlkGIn9FKubzXlqwiP2/iHaMPCrEaxaIvAbbLexbvzDHkwJL+92oR5bsVwS6viq0C
         YPZIs6N1fCtNHmpTy3drcVanu4vgTcHY69ZHiBihrDO0SHDwWtidcwyNbzQ/3QB0W0bE
         qRFWuxsjVDITurAvHe9IY3tCcikdofmA8quXQzRx3RkKyeyIlO6t9kndrA2itYW40G9q
         N6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698151203; x=1698756003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNeDAm67bVqR5ZuVcxBebip5vczn3fVpHDQR33oUAVo=;
        b=Hviaw6WHneC7Rd+PdX4K3qsUpV62LS7xMNbYoz7ZdNJDlVh6lyQNSVrdzISI+c6V/a
         TIFva/GKLtHkFF9Za6HIKoMsP0ZkCJAR6kZgNUowiT6pOreKGbSCf6JznoKLNOuFnUgE
         waNIkWMXeCdQTxJsKLvazyDkMbOzM6gfqccyioWPDHgq0B4d+o97Gc+RMpaZftNg7SfR
         Qqy4C6yzrujYZXUuD/vlPph1bssoKd7jPp5wnj2d4MiQvGpCxByTfvFmt8yQzp+LRpD9
         zQPA80azjxBMGHIz75QeTY13eoLwbD+bcMYvg6o025IscKunfQoDZtet2y8+O5T8kYZZ
         PbPA==
X-Gm-Message-State: AOJu0Yz0tZ0WefajI3LRLkeshqdi6I+PBoSFP9HJc6Jgo43iWGQ+JMtC
        oVXfNURJU7Jhg+SGI+hyWdh+dZ/5EUjvAoS3wxc=
X-Google-Smtp-Source: AGHT+IEQ+8YE/18wOPQQFUjWwYYyRJUhfP7rqGdIpQi569XvyrYGqbBkWlwOAt3Up3f7IhcGBzZ1l9KHvrG30EtQmmg=
X-Received: by 2002:a05:6402:27d4:b0:540:88ad:11a1 with SMTP id
 c20-20020a05640227d400b0054088ad11a1mr2649983ede.39.1698151202414; Tue, 24
 Oct 2023 05:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231023211730.40566-1-brgerst@gmail.com> <20231023211730.40566-4-brgerst@gmail.com>
In-Reply-To: <20231023211730.40566-4-brgerst@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 24 Oct 2023 14:39:51 +0200
Message-ID: <CAFULd4bGtZJorhUn7C-G9nMh4OsFtwcyo6eoHuN62nn0p4anrQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] x86/stackprotector/64: Convert stack protector to
 normal percpu variable
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:17=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wr=
ote:
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
> ---
>  arch/x86/Kconfig                          |  5 ++-
>  arch/x86/Makefile                         | 19 +++++++-----
>  arch/x86/entry/entry_64.S                 |  2 +-
>  arch/x86/include/asm/processor.h          | 15 +--------
>  arch/x86/include/asm/stackprotector.h     | 37 +++++------------------
>  arch/x86/kernel/asm-offsets_64.c          |  6 ----
>  arch/x86/kernel/cpu/common.c              |  4 +--
>  scripts/gcc-x86_64-has-stack-protector.sh |  4 ---
>  8 files changed, 24 insertions(+), 68 deletions(-)
>  delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 039872be1630..c95e0ce557da 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -410,12 +410,11 @@ config PGTABLE_LEVELS
>
>  config CC_HAS_SANE_STACKPROTECTOR
>         bool
> -       default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protect=
or.sh $(CC) $(CLANG_FLAGS)) if 64BIT
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

All compilers that support -mstack-protector-guard-reg=3Dgs
-mstack-protector-guard-symbol=3D__stack_chk_guard correctly emit
segment prefix register, so checking for broken code here is indeed
overkill. gcc-x86_64-has-stack-protector.sh can rightfully be removed.

>
>  menu "Processor type and features"
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 22e41d9dbc23..169f086997ec 100644
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
_seg) \
> +                                -mstack-protector-guard-symbol=3D__stack=
_chk_guard

Maybe use here:

KBUILD_CFLAGS +=3D -mstack-protector-guard-reg=3D$(percpu_seg)
KBUILD_CFLAGS +=3D -mstack-protector-guard-symbol=3D__stack_chk_guard

Looks nicer...

Uros.

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
> index ae81a7191c1c..04371f60e3c6 100644
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
> index b14fc8c1c953..f9c8bd27b642 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2103,15 +2103,13 @@ void syscall_init(void)
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
> diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_=
64-has-stack-protector.sh
> deleted file mode 100755
> index 75e4e22b986a..000000000000
> --- a/scripts/gcc-x86_64-has-stack-protector.sh
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0=
 -mcmodel=3Dkernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q=
 "%gs"
> --
> 2.41.0
>
