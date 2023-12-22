Return-Path: <linux-kernel+bounces-9656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0158581C904
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1708281E91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88548171B6;
	Fri, 22 Dec 2023 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/uUWFPk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27B168A2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBDDC433AD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703244049;
	bh=VyOf0Nbm3eElcobcOdq0RIskLo4Ccvqk/gGgSWsd0Ec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B/uUWFPkoXZAriI8VSvKQWlcAu38i2HNMHne6Q7pWbHNRtVu9hAkTWoomJtHF40gN
	 gkVKQGd84Ri994M8KJ3F58/CeFBkV2fxc8cS5KtX/dfVIFfvvPjWnfuRF3DYlFWIzb
	 3N7vgTiziO63zUTPlw9x2s3dNxPeKGPZRquRva77oA4X9UyXqjg+bEOWKEjEuKOT88
	 9H2vhUsSpuzdHjikz3ehvq9ltcCxulVphnYmjowwbQJqtfiCRAg5NPSjl91rZk+IQC
	 FsPX9IIlW7l0ifXpmG4wFP8tulZShu71fuJHBe5V4mipxu1zYrYdAzD7D4a/NpzA44
	 86Bnw/AwHZ+gQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a235e394758so193557366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:20:49 -0800 (PST)
X-Gm-Message-State: AOJu0Yy9Nn2KSLDZEUfkfYdqna4DnMbYfeMdbwwkDQVg2uuc8K2/zVfD
	jLMuGlDSqJohujbvr7mKeN7l+fclF8fYA4awZmg=
X-Google-Smtp-Source: AGHT+IH9Ax5gaGTljfFnsV4S+ecgjXZzoRp5b+AUpaKM3FR0Ld4GSciGJygXOpZXIE5wXJ5iU/9ljTazK/ew/Y/FecQ=
X-Received: by 2002:a17:906:51cf:b0:a19:a19b:78cf with SMTP id
 v15-20020a17090651cf00b00a19a19b78cfmr695212ejk.146.1703244047649; Fri, 22
 Dec 2023 03:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-4-leobras@redhat.com>
In-Reply-To: <20231222074605.452452-4-leobras@redhat.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 19:20:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSdrGhAihjYSn_9u8_Yup86GgLDELZSmHnYRc5K1BESBA@mail.gmail.com>
Message-ID: <CAJF2gTSdrGhAihjYSn_9u8_Yup86GgLDELZSmHnYRc5K1BESBA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] riscv: Introduce is_compat_thread() into compat.h
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

On Fri, Dec 22, 2023 at 3:47=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> task_user_regset_view() makes use of a function very similar to
> is_compat_task(), but pointing to a any thread.
>
> In arm64 asm/compat.h there is a function very similar to that:
> is_compat_thread(struct thread_info *thread)
>
> Copy this function to riscv asm/compat.h and make use of it into
> task_user_regset_view().
>
> Also, introduce a compile-time test for CONFIG_COMPAT and simplify the
> function code by removing the #ifdef.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/compat.h | 8 ++++++++
>  arch/riscv/kernel/ptrace.c      | 6 +++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/com=
pat.h
> index 91517b51b8e27..da4b28cd01a95 100644
> --- a/arch/riscv/include/asm/compat.h
> +++ b/arch/riscv/include/asm/compat.h
> @@ -20,6 +20,14 @@ static inline int is_compat_task(void)
>         return test_thread_flag(TIF_32BIT);
>  }
>
> +static inline int is_compat_thread(struct thread_info *thread)
> +{
> +       if (!IS_ENABLED(CONFIG_COMPAT))
> +               return 0;
We also could put this into is_compat_task().

> +
> +       return test_ti_thread_flag(thread, TIF_32BIT);
> +}
> +
>  struct compat_user_regs_struct {
>         compat_ulong_t pc;
>         compat_ulong_t ra;
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 2afe460de16a6..f362832123616 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -374,14 +374,14 @@ long compat_arch_ptrace(struct task_struct *child, =
compat_long_t request,
>
>         return ret;
>  }
> +#else
> +static const struct user_regset_view compat_riscv_user_native_view =3D {=
};
>  #endif /* CONFIG_COMPAT */
>
>  const struct user_regset_view *task_user_regset_view(struct task_struct =
*task)
>  {
> -#ifdef CONFIG_COMPAT
> -       if (test_tsk_thread_flag(task, TIF_32BIT))
> +       if (is_compat_thread(&task->thread_info))
>                 return &compat_riscv_user_native_view;
>         else
> -#endif
>                 return &riscv_user_native_view;
>  }
> --
> 2.43.0
>
LGTM

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

