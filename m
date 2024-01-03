Return-Path: <linux-kernel+bounces-15202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD9582284A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD8F285051
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0B3179AA;
	Wed,  3 Jan 2024 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohAFyRsF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723E17998
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 06:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF02C433C9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 06:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704262559;
	bh=aISuBIPvlbjdRJQp1EvQGGxlNwVmVGu5wNaG6PYXKW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ohAFyRsFAMsRuWhgpjtVVyEX0rxljYHqbBiqZp07oThiUPqhjJMngZ2EPNGQsFVDJ
	 U4k5Wv3F80chaXU+07CONswhQm/ffQWI2/mHPkeVOhtAvoVnkPXKg7jxOyRfPD6Env
	 B+bWflRvzf6zEATvNPYwa01GoRraw8jgm7rJ53eFwWCLzC2VwzNyhvkWSy8FRRJCTY
	 MugXKtn7Lw62XaPfr4BhandButtX2UybxfZLba50Udh7firR0gLHMJ6o05Ju8bbxnp
	 fF9NK0Mhf4o0LrTeHBad6+Zc286+qkS55fH5AXSzz0ZWs48FnAkiOYsGgd+lvjsRb4
	 LRC8VDSKaOrRw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55676f1faa9so1657670a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 22:15:59 -0800 (PST)
X-Gm-Message-State: AOJu0YyDtJkqzlbTSzT8SP23cw4/V+iOIz+prAPgZE/LEJi5kh5EStR0
	zrdLLCX3pEajEyTopC7UZ3ixF16JGNdXz+ZccwM=
X-Google-Smtp-Source: AGHT+IGH3h1v0Bkgu0W/NqOIVERH6UhOcT+omf7z0qMfRbc6D1WwAIhExCpIJxP6Dy0kf8SRjb6cp8iojBx0SEi9a8I=
X-Received: by 2002:aa7:d304:0:b0:555:da15:23ab with SMTP id
 p4-20020aa7d304000000b00555da1523abmr4772991edq.62.1704262557607; Tue, 02 Jan
 2024 22:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-4-guoren@kernel.org>
 <20240102-81391283df04c430d76c0eb0@orel>
In-Reply-To: <20240102-81391283df04c430d76c0eb0@orel>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 3 Jan 2024 14:15:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ7Oo8UKdPRs0GAAUsh9mDCgGucS8g8kuPzByaWVOtigw@mail.gmail.com>
Message-ID: <CAJF2gTQ7Oo8UKdPRs0GAAUsh9mDCgGucS8g8kuPzByaWVOtigw@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] riscv: xchg: Prefetch the destination word for sc.w
To: Andrew Jones <ajones@ventanamicro.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, panqinglin2020@iscas.ac.cn, 
	bjorn@rivosinc.com, conor.dooley@microchip.com, leobras@redhat.com, 
	peterz@infradead.org, keescook@chromium.org, wuwei2016@iscas.ac.cn, 
	xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, 
	uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, atishp@atishpatra.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 7:19=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Sun, Dec 31, 2023 at 03:29:53AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The cost of changing a cacheline from shared to exclusive state can be
> > significant, especially when this is triggered by an exclusive store,
> > since it may result in having to retry the transaction.
> >
> > This patch makes use of prefetch.w to prefetch cachelines for write
> > prior to lr/sc loops when using the xchg_small atomic routine.
> >
> > This patch is inspired by commit: 0ea366f5e1b6 ("arm64: atomics:
> > prefetch the destination word for write prior to stxr").
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/cmpxchg.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index 26cea2395aae..d7b9d7951f08 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -10,6 +10,7 @@
> >
> >  #include <asm/barrier.h>
> >  #include <asm/fence.h>
> > +#include <asm/processor.h>
> >
> >  #define __arch_xchg_masked(prepend, append, r, p, n)                 \
>
> Are you sure this is based on v6.7-rc7? Because I don't see this macro.
Oh, it is based on Leobras' patches. I would remove it in the next of versi=
on.

>
> >  ({                                                                   \
> > @@ -23,6 +24,7 @@
> >                                                                       \
> >       __asm__ __volatile__ (                                          \
> >              prepend                                                  \
> > +            PREFETCHW_ASM(%5)                                        \
> >              "0:      lr.w %0, %2\n"                                  \
> >              "        and  %1, %0, %z4\n"                             \
> >              "        or   %1, %1, %z3\n"                             \
> > @@ -30,7 +32,7 @@
> >              "        bnez %1, 0b\n"                                  \
> >              append                                                   \
> >              : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__ptr32b))    =
   \
> > -            : "rJ" (__newx), "rJ" (~__mask)                          \
> > +            : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)         \
>
> I'm pretty sure we don't want to allow the J constraint for __ptr32b.
>
> >              : "memory");                                             \
> >                                                                       \
> >       r =3D (__typeof__(*(p)))((__retx & __mask) >> __s);              =
 \
> > --
> > 2.40.1
> >
>
> Thanks,
> drew



--=20
Best Regards
 Guo Ren

