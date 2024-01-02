Return-Path: <linux-kernel+bounces-14277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DB2821AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1892283147
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF465DF51;
	Tue,  2 Jan 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKmx+O3G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B68DDC7;
	Tue,  2 Jan 2024 11:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC65FC43391;
	Tue,  2 Jan 2024 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704194212;
	bh=wH3UN+QEBeHo1CxZ6/L0nHaYUK8LzrtPCHlYvTqoAPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rKmx+O3G4u6tD/av1MVTGyVxCkd2s7aCJQMOAf5BmsZGJ2kac2aZZOirU3ltVF+xU
	 BY2I1h4URbBV3ME3JYpYc/Lk7bneh1cTHtl6Qjv0k9fveNELZ6dSabLVupVUgQi3Hm
	 sMXBGCCQsdVSeBQyp7+t9TNe9aI6HfuXY7p/xYhIwrJ6crJV6QVhWkeTMuJQqbkz5q
	 sNLGt01zACtu7LZBl3P9NyS6Shd9TJ938UU64KsL9R/gGuwdsjdxkjo2BMlmmEtZxT
	 PcdBKIAk2mDsoUuSm9isVjYr0aLeufNAyB6JCuGJSB7EoKW1+QfFl/s3toWaFJeDEr
	 ubPjbOhP1PLVw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a282cb36d37so74783266b.3;
        Tue, 02 Jan 2024 03:16:52 -0800 (PST)
X-Gm-Message-State: AOJu0YxbnANKJ+Uu1fCx+3omXVbBJGyz4w1+EbkBTROfOCcMo2hH1mhx
	udbmg2rggF8M5Am6D015zbh2zZUMgnvfpGTsDpc=
X-Google-Smtp-Source: AGHT+IGz8iOixHSCpJ0lYL7fIB2qzRVNbPRM/W2vZAG0Y741XUSxrPBDI1OQCXvTMipu+vnICAmP15DLX+1P3yL2QZM=
X-Received: by 2002:a17:907:61a2:b0:a26:8ee9:9b31 with SMTP id
 mt34-20020a17090761a200b00a268ee99b31mr708210ejc.4.1704194211016; Tue, 02 Jan
 2024 03:16:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102101711.10872-2-xry111@xry111.site>
In-Reply-To: <20240102101711.10872-2-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 2 Jan 2024 19:16:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H45oORgBPF0g4hqJB=dqtEuHCh1o4mKZELrvRNfrS5FEw@mail.gmail.com>
Message-ID: <CAAhV-H45oORgBPF0g4hqJB=dqtEuHCh1o4mKZELrvRNfrS5FEw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Fix and simplify fcsr initialization on execve
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Jinyang He <hejinyang@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	loongarch@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 6:17=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
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
> (or maybe it's just buggy too) but I'll investigate it later.
You have already investigated it, so should this message be updated?

Huacai

>
> For LoongArch, just remove the current->thread.fpu.fcsr setting from
> SET_PERSONALITY2 and do it in start_thread, after lose_fpu(0).
>
> The while loop failing with the mainline kernel has survived one hour
> after this change.
>
> Closes: https://github.com/loongson-community/discussions/issues/7
> Fixes: 803b0fc5c3f2 ("LoongArch: Add process management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>
> v1 -> v2:
> - Still set current->thread.fpu.fcsr to boot_cpu_data.fpu_csr0 instead
>   of constant 0.
>
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
> index 767d94cce0de..3f9cae615f52 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -92,6 +92,7 @@ void start_thread(struct pt_regs *regs, unsigned long p=
c, unsigned long sp)
>         clear_used_math();
>         regs->csr_era =3D pc;
>         regs->regs[3] =3D sp;
> +       current->thread.fpu.fcsr =3D boot_cpu_data.fpu_csr0;
>  }
>
>  void flush_thread(void)
> --
> 2.43.0
>

