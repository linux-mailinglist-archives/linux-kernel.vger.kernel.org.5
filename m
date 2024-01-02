Return-Path: <linux-kernel+bounces-13985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C40A821683
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247F1281D29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A3EC0;
	Tue,  2 Jan 2024 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAq+UmQU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18820FA;
	Tue,  2 Jan 2024 02:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98914C433C7;
	Tue,  2 Jan 2024 02:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704162954;
	bh=ZhAg8cEhA9V7L/7YYOZ6JdvIjt4Ry3wwoHqVbwQfZWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iAq+UmQUrSx9rQnSm+xqSvRleqSTxUMuo3yht6ib8b62Ar9qgWFwJYN3qekQY8Buo
	 Ei1jZm6flswE7Z4NDY6yb6Z3WyXvMc0+r8ew6GjVZ9Xzpl8c3MmEGApxIrF88PxnpH
	 I1sBRhqvgLuG979h9on3nSck+rfgK3TA0tECaePe4AQE+mlehSRsS6XMKbgEuhxIzn
	 B86aCbS4fhsH3jbW7+5elzW3nLjRYnia5jngU6iy5Gll5zSswTyF1bnivZ2DKmTvY7
	 TemtdX3q+goj01pdLNhUYoTEZF/YOd3fqb7OURMvpf6Mv5hKcLJCuLMz+lCxWN4zaK
	 hJfb/WI6K6tLA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55642663ac4so982096a12.1;
        Mon, 01 Jan 2024 18:35:54 -0800 (PST)
X-Gm-Message-State: AOJu0Ywt0/Q0KjRapDI6b7GGVN+cdibu8creF9Z0+DbutuHUWYfOQ61o
	CRBSmiv2nJC1Bp5KJUjeny4DQuEuUwwsQ6Di9DA=
X-Google-Smtp-Source: AGHT+IFAVD2FH+f4K3Xyk11X3m3CIqFMlFJ3wxkjaKJ9zKWxklVWjtclPRzUdnr8ou7wWDNJe5KOmAg1SEYP0qatG+g=
X-Received: by 2002:a17:906:190a:b0:a28:7b6:db55 with SMTP id
 a10-20020a170906190a00b00a2807b6db55mr793940eje.78.1704162953028; Mon, 01 Jan
 2024 18:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101172143.14530-2-xry111@xry111.site>
In-Reply-To: <20240101172143.14530-2-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 2 Jan 2024 10:35:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6dJtc3ZpEBnJzKdh691KQck771KOR0Lj41VLZ-Rc1ZwQ@mail.gmail.com>
Message-ID: <CAAhV-H6dJtc3ZpEBnJzKdh691KQck771KOR0Lj41VLZ-Rc1ZwQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix and simplify fcsr initialization on execve
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Jinyang He <hejinyang@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	loongarch@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ruoyao,

On Tue, Jan 2, 2024 at 1:23=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> There has been a lingering bug in LoongArch Linux systems causing some
> GCC tests to intermittently fail (see Closes link).  I've made a minimal
> reproducer:
>
>     zsh% cat measure.s
>     .align 4
>     .globl _start
>     _start:
>         movfcsr2gr  $a0, $fcsr0
>         bstrpick.w  $a0, $a0, 16, 16
>         beqz        $a0, .ok
>         break       0
>     .ok:
>         li.w        $a7, 93
>         syscall     0
>     zsh% cc mesaure.s -o measure -nostdlib
>     zsh% echo $((1.0/3))
>     0.33333333333333331
>     zsh% while ./measure; do ; done
>
> This while loop should not stop as POSIX is clear that execve must set
> fenv to the default, where FCSR should be zero.  But in fact it will
> just stop after running for a while (normally less than 30 seconds).
> Note that "$((1.0/3))" is needed to reproduce the issue because it
> raises FE_INVALID and makes fcsr0 non-zero.
>
> The problem is we are relying on SET_PERSONALITY2 to reset
> current->thread.fpu.fcsr.  But SET_PERSONALITY2 is executed before
> start_thread which calls lose_fpu(0).  We can see if kernel preempt is
> enabled, we may switch to another thread after SET_PERSONALITY2 but
> before lose_fpu(0).  Then bad thing happens: during the thread switch
> the value of the fcsr0 register is stored into current->thread.fpu.fcsr,
> making it dirty again.
>
> The issue can be fixed by setting current->thread.fpu.fcsr after
> lose_fpu(0) because lose_fpu clears TIF_USEDFPU, then the thread
> switch won't touch current->thread.fpu.fcsr.
>
> The only other architecture setting FCSR in SET_PERSONALITY2 is MIPS.
> They do this for supporting different FP flavors (NaN encodings etc).
> which do not exist on LoongArch.  I'm not sure how MIPS evades the issue
> (or maybe it's just buggy too) as I don't have a running MIPS hardware
> now.
I think you can use QEMU. :)

>
> So for LoongArch, just remove the current->thread.fpu.fcsr setting from
> SET_PERSONALITY2 and do it in start_thread, after lose_fpu(0).  And we
> just set it to 0, instead of boot_cpu_data.fpu_csr0 (because we should
> provide the userspace a consistent configuration, no matter how hardware
> and firmware behave).
I still prefer to set fcsr to boot_cpu_data.fpu_csr0, because we will
add LoongArch32 later, not sure whether something will change.

Huacai

>
> The while loop failing with the mainline kernel has survived one hour
> after this change.
>
> Closes: https://github.com/loongson-community/discussions/issues/7
> Fixes: 803b0fc5c3f2 ("LoongArch: Add process management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/include/asm/elf.h | 5 -----
>  arch/loongarch/kernel/elf.c      | 5 -----
>  arch/loongarch/kernel/process.c  | 1 +
>  3 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/as=
m/elf.h
> index 9b16a3b8e706..f16bd42456e4 100644
> --- a/arch/loongarch/include/asm/elf.h
> +++ b/arch/loongarch/include/asm/elf.h
> @@ -241,8 +241,6 @@ void loongarch_dump_regs64(u64 *uregs, const struct p=
t_regs *regs);
>  do {                                                                   \
>         current->thread.vdso =3D &vdso_info;                             =
 \
>                                                                         \
> -       loongarch_set_personality_fcsr(state);                          \
> -                                                                       \
>         if (personality(current->personality) !=3D PER_LINUX)            =
 \
>                 set_personality(PER_LINUX);                             \
>  } while (0)
> @@ -259,7 +257,6 @@ do {                                                 =
                       \
>         clear_thread_flag(TIF_32BIT_ADDR);                              \
>                                                                         \
>         current->thread.vdso =3D &vdso_info;                             =
 \
> -       loongarch_set_personality_fcsr(state);                          \
>                                                                         \
>         p =3D personality(current->personality);                         =
 \
>         if (p !=3D PER_LINUX32 && p !=3D PER_LINUX)                      =
   \
> @@ -340,6 +337,4 @@ extern int arch_elf_pt_proc(void *ehdr, void *phdr, s=
truct file *elf,
>  extern int arch_check_elf(void *ehdr, bool has_interpreter, void *interp=
_ehdr,
>                           struct arch_elf_state *state);
>
> -extern void loongarch_set_personality_fcsr(struct arch_elf_state *state)=
;
> -
>  #endif /* _ASM_ELF_H */
> diff --git a/arch/loongarch/kernel/elf.c b/arch/loongarch/kernel/elf.c
> index 183e94fc9c69..0fa81ced28dc 100644
> --- a/arch/loongarch/kernel/elf.c
> +++ b/arch/loongarch/kernel/elf.c
> @@ -23,8 +23,3 @@ int arch_check_elf(void *_ehdr, bool has_interpreter, v=
oid *_interp_ehdr,
>  {
>         return 0;
>  }
> -
> -void loongarch_set_personality_fcsr(struct arch_elf_state *state)
> -{
> -       current->thread.fpu.fcsr =3D boot_cpu_data.fpu_csr0;
> -}
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/proc=
ess.c
> index 767d94cce0de..caed58770650 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -92,6 +92,7 @@ void start_thread(struct pt_regs *regs, unsigned long p=
c, unsigned long sp)
>         clear_used_math();
>         regs->csr_era =3D pc;
>         regs->regs[3] =3D sp;
> +       current->thread.fpu.fcsr =3D 0;
>  }
>
>  void flush_thread(void)
> --
> 2.43.0
>
>

