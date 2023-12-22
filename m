Return-Path: <linux-kernel+bounces-9481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D913E81C647
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB8DB23023
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C21D306;
	Fri, 22 Dec 2023 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThJHIAWS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37748C8D4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CF4C433CA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703232683;
	bh=xlvrw1s0T46Tz1knGooTW4HgxuEaVE6Yt4gVH7KsSNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ThJHIAWScS67tO4MPkBAG639WxhdKDyUoCbBibMIwOUCJSm4eLx5TYNjMlPfj2Euu
	 EZZnLtFeL/Vz0lhk12fZaMNiHJLD5uIN47v8qoOS9iemaIwTaQkpzKExUBNRIHy4nv
	 s4Jgd6KWl6FeJMwvuW/P+N4QQxpZnfiojXLU9BrQRcrO27M7kXtfGAenghgNeH6NRi
	 c0NuJM835BWWVGTGNChon2OX+8Ifb7UfIIzWBKh/tzF2905e2gt4q1MfBTAFZY1u3w
	 OV6Arg0gB3HvO3ovldS4JPJxJQV0jOhxwtJzGJ/DgFROvm0vwEXlkfUpxV76Qt2/uW
	 AROH4os7cmJAg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso4901890a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:11:23 -0800 (PST)
X-Gm-Message-State: AOJu0YydP80pbZl0P2A4EubRg5YjNCn37S2z2x0C5Lx7UDxCax6ZCVPb
	1jg6FQegNC7NlZldHaJI/PBnVtXzcAmuKDE5Xc8=
X-Google-Smtp-Source: AGHT+IG2QDqYm9J7T4aV4Gi9QMXZcNjKi+BwCgA9nxbLz37NE8zlLTmwMUaMZL0C8EpuHRmgEsm9wh+mRbWDQIvom3M=
X-Received: by 2002:a17:907:9392:b0:a25:a0c6:ebf5 with SMTP id
 cm18-20020a170907939200b00a25a0c6ebf5mr762193ejc.21.1703232682173; Fri, 22
 Dec 2023 00:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222074605.452452-1-leobras@redhat.com> <20231222074605.452452-5-leobras@redhat.com>
In-Reply-To: <20231222074605.452452-5-leobras@redhat.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 16:11:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTzOS+16d2sqLnRnw_bxVnE9Gudtf4nu69XbSsvcsQCfw@mail.gmail.com>
Message-ID: <CAJF2gTTzOS+16d2sqLnRnw_bxVnE9Gudtf4nu69XbSsvcsQCfw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] riscv: Introduce set_compat_task() in asm/compat.h
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
> In order to have all task compat bit access directly in compat.h, introdu=
ce
> set_compat_task() to set/reset those when needed.
>
> Also, since it's only used on an if/else scenario, simplify the macro usi=
ng
> it.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/compat.h | 8 ++++++++
>  arch/riscv/include/asm/elf.h    | 5 +----
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/com=
pat.h
> index da4b28cd01a95..aa103530a5c83 100644
> --- a/arch/riscv/include/asm/compat.h
> +++ b/arch/riscv/include/asm/compat.h
> @@ -28,6 +28,14 @@ static inline int is_compat_thread(struct thread_info =
*thread)
>         return test_ti_thread_flag(thread, TIF_32BIT);
>  }
>
> +static inline void set_compat_task(bool is_compat)
> +{
> +       if (is_compat)
> +               set_thread_flag(TIF_32BIT);
> +       else
> +               clear_thread_flag(TIF_32BIT);
> +}
> +
>  struct compat_user_regs_struct {
>         compat_ulong_t pc;
>         compat_ulong_t ra;
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index 2e88257cafaea..c7aea7886d22a 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -135,10 +135,7 @@ do {                                                =
       \
>  #ifdef CONFIG_COMPAT
>
>  #define SET_PERSONALITY(ex)                                    \
> -do {    if ((ex).e_ident[EI_CLASS] =3D=3D ELFCLASS32)              \
> -               set_thread_flag(TIF_32BIT);                     \
> -       else                                                    \
> -               clear_thread_flag(TIF_32BIT);                   \
> +do {   set_compat_task((ex).e_ident[EI_CLASS] =3D=3D ELFCLASS32);  \
>         if (personality(current->personality) !=3D PER_LINUX32)   \
>                 set_personality(PER_LINUX |                     \
>                         (current->personality & (~PER_MASK)));  \
> --
> 2.43.0
>
LGTM

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

