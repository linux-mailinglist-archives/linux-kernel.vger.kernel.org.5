Return-Path: <linux-kernel+bounces-9548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BE881C759
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB5F287275
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E25F9ED;
	Fri, 22 Dec 2023 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP5rlVgp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C6DF42
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC30C4339A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703237734;
	bh=jZzdwoHT2kuZ2oo2BcVo/dRZz8kMowfuO8XWw6Jy+aQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GP5rlVgpsY3gf41iBrWBR4PLFsSSpt1cwhq0UZGWW6D9fMZSfNHAbDFsae+n9TPnm
	 RXbcB/gLI0Cpe6u4lWuu/0/6JGamdELFyme9j9YYAZoEbEm8aCrqWZL/aVIPGR3cvN
	 +VyPRYH08FzJokPuJd0sb5gJKt8UuIIuT14MPVQ6fPHtC2fFwn4NJrA0I4nBrvsYnf
	 P/zJZubL/Wme1lBZ6W98okrOSqrjHFSeJFsFTfiR4zr5LWfIYIOwG3nAApXO0xCPbK
	 NS3BNUGa19SLVjR+PbDK5XdshLte8R/6CovgVosy+zmgzlhNbuHt/fxGYKn/+Fd7UE
	 JlFnT5B+CgRUA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so22039401fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 01:35:33 -0800 (PST)
X-Gm-Message-State: AOJu0YydO5KKvnAfVVAeIYes+pGVANz1KlC82OZ5GnPJUEvTHJLAbaDF
	rTKFUvfe0iuMzH67DDw5qZ2Xgj0cvwO2Jo6NrAk=
X-Google-Smtp-Source: AGHT+IFBolUEPY720dl+czfO4qrssPxC1JJ7OwVqlpuBUwcp3tL3lhllAYTVKtUab1jFGi/GhzBcG2KsIGCJdxQjS+s=
X-Received: by 2002:a19:384e:0:b0:50e:384c:6982 with SMTP id
 d14-20020a19384e000000b0050e384c6982mr452303lfj.42.1703237732207; Fri, 22 Dec
 2023 01:35:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-3-leobras@redhat.com>
In-Reply-To: <20231222074605.452452-3-leobras@redhat.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 17:35:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQNE7OQiAbkvVNzo9PCV=Xr8KQD0_=s-G56QMZJiZnjvA@mail.gmail.com>
Message-ID: <CAJF2gTQNE7OQiAbkvVNzo9PCV=Xr8KQD0_=s-G56QMZJiZnjvA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] riscv: add compile-time test into is_compat_task()
To: Leonardo Bras <leobras@redhat.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Greg Ungerer <gerg@kernel.org>, Vincent Chen <vincent.chen@sifive.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Qinglin Pan <panqinglin2020@iscas.ac.cn>, 
	Greentime Hu <greentime.hu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 5:02=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> Currently several places will test for CONFIG_COMPAT before testing
> is_compat_task(), probably in order to avoid a run-time test into the tas=
k
> structure.
>
> Since is_compat_task() is an inlined function, it would be helpful to add=
 a
> compile-time test of CONFIG_COMPAT, making sure it always returns zero wh=
en
> the option is not enabled during the kernel build.
>
> With this, the compiler is able to understand in build-time that
> is_compat_task() will always return 0, and optimize-out some of the extra
> code introduced by the option.
>
> This will also allow removing a lot #ifdefs that were introduced, and mak=
e
> the code more clean.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/compat.h    | 3 +++
>  arch/riscv/include/asm/elf.h       | 4 ----
>  arch/riscv/include/asm/pgtable.h   | 6 ------
>  arch/riscv/include/asm/processor.h | 4 ++--
>  4 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/com=
pat.h
> index 2ac955b51148f..91517b51b8e27 100644
> --- a/arch/riscv/include/asm/compat.h
> +++ b/arch/riscv/include/asm/compat.h
> @@ -14,6 +14,9 @@
>
>  static inline int is_compat_task(void)
>  {
> +       if (!IS_ENABLED(CONFIG_COMPAT))
> +               return 0;
> +
>         return test_thread_flag(TIF_32BIT);
>  }
>
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index 59a08367fddd7..2e88257cafaea 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -53,13 +53,9 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
>  #define ELF_ET_DYN_BASE                ((DEFAULT_MAP_WINDOW / 3) * 2)
>
>  #ifdef CONFIG_64BIT
> -#ifdef CONFIG_COMPAT
>  #define STACK_RND_MASK         (is_compat_task() ? \
>                                  0x7ff >> (PAGE_SHIFT - 12) : \
>                                  0x3ffff >> (PAGE_SHIFT - 12))
> -#else
> -#define STACK_RND_MASK         (0x3ffff >> (PAGE_SHIFT - 12))
> -#endif
>  #endif
>
>  /*
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 1d472b31e0cfe..ea5b269be223a 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -127,16 +127,10 @@
>  #define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
>  #define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
>
> -#ifdef CONFIG_COMPAT
>  #define MMAP_VA_BITS_64 ((VA_BITS >=3D VA_BITS_SV48) ? VA_BITS_SV48 : VA=
_BITS)
>  #define MMAP_MIN_VA_BITS_64 (VA_BITS_SV39)
>  #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_64)
>  #define MMAP_MIN_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_MIN_VA_=
BITS_64)
> -#else
> -#define MMAP_VA_BITS ((VA_BITS >=3D VA_BITS_SV48) ? VA_BITS_SV48 : VA_BI=
TS)
> -#define MMAP_MIN_VA_BITS (VA_BITS_SV39)
> -#endif /* CONFIG_COMPAT */
> -
>  #else
>  #include <asm/pgtable-32.h>
>  #endif /* CONFIG_64BIT */
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index f19f861cda549..ed32e53e55999 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -22,7 +22,7 @@
>  ({                                                             \
>         unsigned long mmap_end;                                 \
>         typeof(addr) _addr =3D (addr);                            \
> -       if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_t=
ask())) \
> +       if ((_addr) =3D=3D 0 || is_compat_task())                   \
>                 mmap_end =3D STACK_TOP_MAX;                       \
>         else if ((_addr) >=3D VA_USER_SV57)                       \
>                 mmap_end =3D STACK_TOP_MAX;                       \
> @@ -39,7 +39,7 @@
>         typeof(addr) _addr =3D (addr);                            \
>         typeof(base) _base =3D (base);                            \
>         unsigned long rnd_gap =3D DEFAULT_MAP_WINDOW - (_base);   \
> -       if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_t=
ask())) \
> +       if ((_addr) =3D=3D 0 || is_compat_task())                   \
>                 mmap_base =3D (_base);                            \
>         else if (((_addr) >=3D VA_USER_SV57) && (VA_BITS >=3D VA_BITS_SV5=
7)) \
>                 mmap_base =3D VA_USER_SV57 - rnd_gap;             \
> --
> 2.43.0
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

