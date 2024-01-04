Return-Path: <linux-kernel+bounces-16177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F4823A31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C85286C84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33D11878;
	Thu,  4 Jan 2024 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMrNfGBO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A531852
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 01:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0ECC4339A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 01:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704331493;
	bh=kdiz8o8d/7k1J0F+igL00Zui4dSZF0XFj1b7FGHQtiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tMrNfGBO3wHy4+Rjoro8wYszWNnfUkoML2TYONWJrvc2yNhclGP3TPSW4V5yCuzlb
	 SeCem0UKZN0Uz20PKrQ2Ch1YKSqr8vnCl1pxgGtGqiaXc4ha6p/ZAipQu4IauJcbhf
	 fgamOMFCveEszky6qY8IHTPUrTdT32SuV21n0UjCkrDazY5Dbkf6b2C96B8q2b/qSK
	 bbPMuw5C29OYTYedG7S3d5l2aIgepAiqbpHlXRf3y8IDEwc15YPITq4vvuE3N8+d8X
	 W7M04j3qjxhtpkyb0ggJEwU8T6HfgyWc23AiOrdr+hyb4St4v5VO5EHFMTAc7Ks6DZ
	 b5y4L+IXauqPw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-556aa7fe765so41595a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 17:24:53 -0800 (PST)
X-Gm-Message-State: AOJu0YxIcNJ9xjDVdyJF2eukWjdafIkYMg8w+cgWzXUqzHMTvS/qdvjC
	23nOH4LerdPnJo2HSD49eu8xnSux4Rkekz13wjw=
X-Google-Smtp-Source: AGHT+IFyflSadMBXsVfi2tQC8KfzFo0ziT4bMqARq1rdklWXKp3oTtWhmdLr1CzEBPxozr2h8pwAt5OUEPQQlobsxjU=
X-Received: by 2002:a50:c182:0:b0:556:db12:af4b with SMTP id
 m2-20020a50c182000000b00556db12af4bmr803567edf.54.1704331491922; Wed, 03 Jan
 2024 17:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-4-guoren@kernel.org>
 <20240102-81391283df04c430d76c0eb0@orel> <CAJF2gTQ7Oo8UKdPRs0GAAUsh9mDCgGucS8g8kuPzByaWVOtigw@mail.gmail.com>
 <ZZW5Y85OdibCu58h@LeoBras>
In-Reply-To: <ZZW5Y85OdibCu58h@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 4 Jan 2024 09:24:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTpi5A+9KP5EyH9qhD_fwuZrWpx6zdCJyG+iv0Ez5q-gw@mail.gmail.com>
Message-ID: <CAJF2gTTpi5A+9KP5EyH9qhD_fwuZrWpx6zdCJyG+iv0Ez5q-gw@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] riscv: xchg: Prefetch the destination word for sc.w
To: Leonardo Bras <leobras@redhat.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	peterz@infradead.org, keescook@chromium.org, wuwei2016@iscas.ac.cn, 
	xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, 
	uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, atishp@atishpatra.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:45=E2=80=AFAM Leonardo Bras <leobras@redhat.com> w=
rote:
>
> On Wed, Jan 03, 2024 at 02:15:45PM +0800, Guo Ren wrote:
> > On Tue, Jan 2, 2024 at 7:19=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
> > >
> > > On Sun, Dec 31, 2023 at 03:29:53AM -0500, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > The cost of changing a cacheline from shared to exclusive state can=
 be
> > > > significant, especially when this is triggered by an exclusive stor=
e,
> > > > since it may result in having to retry the transaction.
> > > >
> > > > This patch makes use of prefetch.w to prefetch cachelines for write
> > > > prior to lr/sc loops when using the xchg_small atomic routine.
> > > >
> > > > This patch is inspired by commit: 0ea366f5e1b6 ("arm64: atomics:
> > > > prefetch the destination word for write prior to stxr").
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >  arch/riscv/include/asm/cmpxchg.h | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/=
asm/cmpxchg.h
> > > > index 26cea2395aae..d7b9d7951f08 100644
> > > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > > @@ -10,6 +10,7 @@
> > > >
> > > >  #include <asm/barrier.h>
> > > >  #include <asm/fence.h>
> > > > +#include <asm/processor.h>
> > > >
> > > >  #define __arch_xchg_masked(prepend, append, r, p, n)              =
   \
> > >
> > > Are you sure this is based on v6.7-rc7? Because I don't see this macr=
o.
> > Oh, it is based on Leobras' patches. I would remove it in the next of v=
ersion.
>
> I would say this next :)
Thx for the grammar correction.

>
> >
> > >
> > > >  ({                                                                =
   \
> > > > @@ -23,6 +24,7 @@
> > > >                                                                    =
   \
> > > >       __asm__ __volatile__ (                                       =
   \
> > > >              prepend                                               =
   \
> > > > +            PREFETCHW_ASM(%5)                                     =
   \
> > > >              "0:      lr.w %0, %2\n"                               =
   \
> > > >              "        and  %1, %0, %z4\n"                          =
   \
> > > >              "        or   %1, %1, %z3\n"                          =
   \
> > > > @@ -30,7 +32,7 @@
> > > >              "        bnez %1, 0b\n"                               =
   \
> > > >              append                                                =
   \
> > > >              : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__ptr32b))=
       \
> > > > -            : "rJ" (__newx), "rJ" (~__mask)                       =
   \
> > > > +            : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)      =
   \
> > >
> > > I'm pretty sure we don't want to allow the J constraint for __ptr32b.
> > >
> > > >              : "memory");                                          =
   \
> > > >                                                                    =
   \
> > > >       r =3D (__typeof__(*(p)))((__retx & __mask) >> __s);          =
     \
> > > > --
> > > > 2.40.1
> > > >
> > >
> > > Thanks,
> > > drew
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>
> Nice patch :)
> Any reason it's not needed in __arch_cmpxchg_masked(), and __arch_cmpxchg=
() ?
CAS is a conditional AMO, unlike xchg (Stand AMO). Arm64 is wrong, or
they have a problem with the hardware.

>
> Thanks!
> Leo
>


--=20
Best Regards
 Guo Ren

