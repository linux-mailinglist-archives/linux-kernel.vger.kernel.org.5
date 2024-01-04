Return-Path: <linux-kernel+bounces-16354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5671823D37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A86B1C21473
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4C6200C9;
	Thu,  4 Jan 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehLT8o6h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEDA1F926
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2E4C433C9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704356081;
	bh=jaE3szVj8MsgSxuSXcKLMpdQ+g8wxNLidI3HZVXMSME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ehLT8o6hejxcx5mGGMVy8W5S0ZLxpHLPpMUMMbL/goXddDJ6V55fJFc2UW+ITCUeY
	 UY/oddRCAMzoJvLnTweF/x4AX+Ysud1JOwZQkVYPCYp/9yrVIjoP18jjWtVhyXeLIj
	 eXvPtnOQmyIL25B1dJpVyJrzyJuyA/mMziJxtYlwyuBar99Q+dc3bmKvllhfL7/iFe
	 jOToFGtrc1yWPvbKfEQh6qwmcpIK29gRbndE3S480oCFYBESUnQG3Nq4c8QQDVGro/
	 SrXFBR1sbz4r7G0prMR+cHrcXLucW3mlEZdnXUqi8QlQM3usxovJo0w/U8RkclJAMu
	 wsnWC65ujJpUQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-555aa7fd668so291737a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:14:41 -0800 (PST)
X-Gm-Message-State: AOJu0YwdEs15JUc8WyheuK8JbTsA3hVUi4oTE8nMJI7jhhEQe4jJR6mi
	upIegUAbOGtYO2dIboq1ND4MNPmNxAOy8eDbLKk=
X-Google-Smtp-Source: AGHT+IGmofhqQh3VQmtq0uihHErWzzBwYu85d9ONV1s6wEWx4GEUpDzZopd0NKZnV1IjSKshZFnRZmNHJpurrD1UujU=
X-Received: by 2002:a17:906:4118:b0:a28:e5c9:79eb with SMTP id
 j24-20020a170906411800b00a28e5c979ebmr119219ejk.100.1704356079669; Thu, 04
 Jan 2024 00:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231082955.16516-1-guoren@kernel.org> <20231231082955.16516-4-guoren@kernel.org>
 <20240102-81391283df04c430d76c0eb0@orel> <CAJF2gTQ7Oo8UKdPRs0GAAUsh9mDCgGucS8g8kuPzByaWVOtigw@mail.gmail.com>
 <ZZW5Y85OdibCu58h@LeoBras> <CAJF2gTTpi5A+9KP5EyH9qhD_fwuZrWpx6zdCJyG+iv0Ez5q-gw@mail.gmail.com>
 <ZZYsdyKx8kmoDBGB@LeoBras>
In-Reply-To: <ZZYsdyKx8kmoDBGB@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 4 Jan 2024 16:14:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTT8QBEKtKOpriF=c8Y3g5MmM23MZxN7JCa65MbKeKNOQ@mail.gmail.com>
Message-ID: <CAJF2gTTT8QBEKtKOpriF=c8Y3g5MmM23MZxN7JCa65MbKeKNOQ@mail.gmail.com>
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

On Thu, Jan 4, 2024 at 11:56=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Thu, Jan 04, 2024 at 09:24:40AM +0800, Guo Ren wrote:
> > On Thu, Jan 4, 2024 at 3:45=E2=80=AFAM Leonardo Bras <leobras@redhat.co=
m> wrote:
> > >
> > > On Wed, Jan 03, 2024 at 02:15:45PM +0800, Guo Ren wrote:
> > > > On Tue, Jan 2, 2024 at 7:19=E2=80=AFPM Andrew Jones <ajones@ventana=
micro.com> wrote:
> > > > >
> > > > > On Sun, Dec 31, 2023 at 03:29:53AM -0500, guoren@kernel.org wrote=
:
> > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > >
> > > > > > The cost of changing a cacheline from shared to exclusive state=
 can be
> > > > > > significant, especially when this is triggered by an exclusive =
store,
> > > > > > since it may result in having to retry the transaction.
> > > > > >
> > > > > > This patch makes use of prefetch.w to prefetch cachelines for w=
rite
> > > > > > prior to lr/sc loops when using the xchg_small atomic routine.
> > > > > >
> > > > > > This patch is inspired by commit: 0ea366f5e1b6 ("arm64: atomics=
:
> > > > > > prefetch the destination word for write prior to stxr").
> > > > > >
> > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/cmpxchg.h | 4 +++-
> > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/incl=
ude/asm/cmpxchg.h
> > > > > > index 26cea2395aae..d7b9d7951f08 100644
> > > > > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > > > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > > > > @@ -10,6 +10,7 @@
> > > > > >
> > > > > >  #include <asm/barrier.h>
> > > > > >  #include <asm/fence.h>
> > > > > > +#include <asm/processor.h>
> > > > > >
> > > > > >  #define __arch_xchg_masked(prepend, append, r, p, n)          =
       \
> > > > >
> > > > > Are you sure this is based on v6.7-rc7? Because I don't see this =
macro.
> > > > Oh, it is based on Leobras' patches. I would remove it in the next =
of version.
> > >
> > > I would say this next :)
> > Thx for the grammar correction.
>
> Oh, I was not intending to correct grammar.
> I just meant the next thing I would mention is that it was based on top o=
f
> my patchset instead of v6.7-rc7:
>
> >
> > >
> > > >
> > > > >
> > > > > >  ({                                                            =
       \
> > > > > > @@ -23,6 +24,7 @@
> > > > > >                                                                =
       \
> > > > > >       __asm__ __volatile__ (                                   =
       \
> > > > > >              prepend                                           =
       \
> > > > > > +            PREFETCHW_ASM(%5)                                 =
       \
> > > > > >              "0:      lr.w %0, %2\n"                           =
       \
> > > > > >              "        and  %1, %0, %z4\n"                      =
       \
> > > > > >              "        or   %1, %1, %z3\n"                      =
       \
> > > > > > @@ -30,7 +32,7 @@
> > > > > >              "        bnez %1, 0b\n"                           =
       \
> > > > > >              append                                            =
       \
> > > > > >              : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__ptr3=
2b))       \
> > > > > > -            : "rJ" (__newx), "rJ" (~__mask)                   =
       \
> > > > > > +            : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)  =
       \
> > > > >
> > > > > I'm pretty sure we don't want to allow the J constraint for __ptr=
32b.
> > > > >
> > > > > >              : "memory");                                      =
       \
> > > > > >                                                                =
       \
> > > > > >       r =3D (__typeof__(*(p)))((__retx & __mask) >> __s);      =
         \
> > > > > > --
> > > > > > 2.40.1
> > > > > >
> > > > >
> > > > > Thanks,
> > > > > drew
> > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> > > >
> > >
> > > Nice patch :)
> > > Any reason it's not needed in __arch_cmpxchg_masked(), and __arch_cmp=
xchg() ?
> > CAS is a conditional AMO, unlike xchg (Stand AMO). Arm64 is wrong, or
> > they have a problem with the hardware.
>
> Sorry, I was unable to fully understand the reason here.
>
> You suggest that the PREFETCH.W was inserted on xchg_masked because it wi=
ll
> always switch the variable (no compare, blind CAS), but not on cmpxchg.
>
> Is this because cmpxchg will depend on a compare, and thus it does not
> garantee a write? so it would be unwise to always prefetch cacheline
Yes, it has a comparison, so a store may not exist there.

> exclusiveness for this cpu, where shared state would be enough.
> Is that correct?
Yes, exclusiveness would invalidate other harts' cache lines.

>
> Thanks!
> Leo
>
>
> >
> > >
> > > Thanks!
> > > Leo
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>


--=20
Best Regards
 Guo Ren

