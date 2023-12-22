Return-Path: <linux-kernel+bounces-9671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7B081C95C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277AD1F23547
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B3617753;
	Fri, 22 Dec 2023 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjoCFLnh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4CA17735
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEF1C433D9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703245729;
	bh=FlymK5LbClRXOG+RMjxFM72ReopkCVFd1+LDQ+0t1YY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jjoCFLnhQ/qGJLo1/8ryvMufpSmX2GhHRSB+/0FZc2sk+oC5OJmOZpUGFZ97LuZ9U
	 obInLRJbXMkEIFMKG4NMMKYRgBtAwiBbVcWRigaocvdv+an9uipppRxF02R+Z9FiFo
	 3hATmjgg05oZryViEo8/pO+6dlFcVw1cy1JaAhaCwvuaKaqkDFsPvme+Z3f+1fTt/G
	 bg3ri4Nisj7jo+ErsnzkgRP25kZdrXHLmfGSqhOMldQUwbrBSKL7EEeizcsRY7JaoQ
	 h2354IbPKTil8mmsvKtLki+xetoJkoCvUSUIJoytYzFgF6U0inm8b2xgtvqov6DcvO
	 ZK7VgBAvR9ZPg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2698eae0a9so219231466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:48:49 -0800 (PST)
X-Gm-Message-State: AOJu0YxF7CKBA160jHXjjWqs3cSoQZCJyorrp9dsu/jgQWRQFmReeyJb
	t0H/7NgR+xg7HOCKdupKzlch4jpRpJjB9IEESbY=
X-Google-Smtp-Source: AGHT+IFVPZzCzb0xj985HwrmUbmW0Jq/RmEvvv5I4UCX5tEPPTVnITvPcvviXuNJYC8itOiyOacSZhaOtRLR4+P+3u0=
X-Received: by 2002:a17:906:4698:b0:a23:f50:6cff with SMTP id
 a24-20020a170906469800b00a230f506cffmr782485ejr.111.1703245728046; Fri, 22
 Dec 2023 03:48:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222082711.454374-1-leobras@redhat.com>
In-Reply-To: <20231222082711.454374-1-leobras@redhat.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 19:48:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTShV+xBjHwQKGEQG-JgEUVa6S8egZNcN7xt_2rPucph9Q@mail.gmail.com>
Message-ID: <CAJF2gTShV+xBjHwQKGEQG-JgEUVa6S8egZNcN7xt_2rPucph9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] riscv: Improve arch_get_mmap_end() macro
To: Leonardo Bras <leobras@redhat.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Vincent Chen <vincent.chen@sifive.com>, 
	Andy Chiu <andy.chiu@sifive.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 4:27=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> This macro caused me some confusion, which took some reviewer's time to
> make it clear, so I propose adding a short comment in code to avoid
> confusion in the future.
>
> Also, added some improvements to the macro, such as removing the
> assumption of VA_USER_SV57 being the largest address space.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/processor.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index f19f861cda549..2278e2a8362af 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -18,15 +18,21 @@
>  #define DEFAULT_MAP_WINDOW     (UL(1) << (MMAP_VA_BITS - 1))
>  #define STACK_TOP_MAX          TASK_SIZE_64
>
> +/*
> + * addr is a hint to the maximum userspace address that mmap should prov=
ide, so
> + * this macro needs to return the largest address space available so tha=
t
> + * mmap_end < addr, being mmap_end the top of that address space.
> + * See Documentation/arch/riscv/vm-layout.rst for more details.
> + */
>  #define arch_get_mmap_end(addr, len, flags)                    \
>  ({                                                             \
>         unsigned long mmap_end;                                 \
>         typeof(addr) _addr =3D (addr);                            \
>         if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_t=
ask())) \
>                 mmap_end =3D STACK_TOP_MAX;                       \
> -       else if ((_addr) >=3D VA_USER_SV57)                       \
> -               mmap_end =3D STACK_TOP_MAX;                       \
> -       else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D VA_BITS_S=
V48)) \
> +       else if (((_addr) >=3D VA_USER_SV57) && (VA_BITS >=3D VA_BITS_SV5=
7)) \
> +               mmap_end =3D VA_USER_SV57;                        \
It's clearer.

LGTM.
Reviewed-by: Guo Ren <guoren@kernel.org>

> +       else if (((_addr) >=3D VA_USER_SV48) && (VA_BITS >=3D VA_BITS_SV4=
8)) \
>                 mmap_end =3D VA_USER_SV48;                        \
>         else                                                    \
>                 mmap_end =3D VA_USER_SV39;                        \
> --
> 2.43.0
>


--=20
Best Regards
 Guo Ren

