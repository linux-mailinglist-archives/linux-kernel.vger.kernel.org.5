Return-Path: <linux-kernel+bounces-9624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A0781C89F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C6F1C21B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA18156D3;
	Fri, 22 Dec 2023 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/SgMjaf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A55314A9A;
	Fri, 22 Dec 2023 10:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E80EC433C9;
	Fri, 22 Dec 2023 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703242702;
	bh=rx0yFkBMTzEKmeuPIJF0NkC0FcPPbYT0ES9Ktaas1Js=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e/SgMjafWtX7oFyc+/Edvx1ULuDrXO8dELE7z49a9UZelCttdzwMhmHJBIFeBoXK+
	 WWUCWWpIsQF1EPh/t+KMFXopc7/icNBdG9oXYqtkK7UVG6/+PhXdmM3AEP1Ne6qhen
	 U7yYbDdIKnzZQ736MPs78UDq2F7WLh+56H8BeLaGNPm53TTKQG4Zc0KEVOkrnMaS74
	 7vcEM556eH3SRnQ0wuPYo+wDdsQdyPW5qv4N8HZw0ehLjJ+LECgcSfSfDSutjMP2C9
	 gqamLZWDDkBDXs23z+XERbm0WrHAJ0zo7wIKXKtv6LdUBHo9QMufho3zOwUNZFVOme
	 n9pGSY5WMAW5w==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-552fba34d69so1933115a12.3;
        Fri, 22 Dec 2023 02:58:22 -0800 (PST)
X-Gm-Message-State: AOJu0YyvmCVukfuNGDmkGfLN7xBi/n7U52TFd5jP2Hr1hhaLaeaL/pWq
	orpfSa3nUs5M+R8ks5tCOjj7A3cgDoJjL6ApJas=
X-Google-Smtp-Source: AGHT+IElKKg9ui7lnL2gmCS7LtcXrm7B9npYlOycyGGC9DotVDc1J6zrzMmuubqPzV1joWM8riti1xMQhugUikKE/O0=
X-Received: by 2002:a05:6402:4410:b0:54a:f8e9:a9a8 with SMTP id
 y16-20020a056402441000b0054af8e9a9a8mr674023eda.20.1703242701023; Fri, 22 Dec
 2023 02:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-2-guoren@kernel.org>
 <ZYTriK9hjOFQou9Z@LeoBras> <CAJF2gTT=EQzsuYMHr3FLb82Gi325PqWMEOAzfc6fg=go+gKP_g@mail.gmail.com>
 <ZYUHg3kIMYdNSOSr@ghost>
In-Reply-To: <ZYUHg3kIMYdNSOSr@ghost>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 18:58:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS-Mbhyygw-iWOE7Wj51iOfgnN43az-7yOko1dDU_mj1w@mail.gmail.com>
Message-ID: <CAJF2gTS-Mbhyygw-iWOE7Wj51iOfgnN43az-7yOko1dDU_mj1w@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] riscv: mm: Fixup compat mode boot failure
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, alexghiti@rivosinc.com, 
	xiao.w.wang@intel.com, david@redhat.com, panqinglin2020@iscas.ac.cn, 
	rick.p.edgecombe@intel.com, willy@infradead.org, bjorn@rivosinc.com, 
	conor.dooley@microchip.com, cleger@rivosinc.com, 
	linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Charlie,

On Fri, Dec 22, 2023 at 11:50=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> On Fri, Dec 22, 2023 at 10:57:16AM +0800, Guo Ren wrote:
> > On Fri, Dec 22, 2023 at 9:51=E2=80=AFAM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >
> > > Hello Guo Ren,
> > >
> > > On Thu, Dec 21, 2023 at 10:46:58AM -0500, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > In COMPAT mode, the STACK_TOP is 0x80000000, but the TASK_SIZE is
> > > > 0x7fff000. When the user stack is upon 0x7fff000, it will cause a u=
ser
> > > > segment fault. Sometimes, it would cause boot failure when the whol=
e
> > > > rootfs is rv32.
> > >
> > > Checking if I get the scenario:
> > >
> > > In pgtable.h:
> > > #ifdef CONFIG_64BIT
> > > #define TASK_SIZE_64    (PGDIR_SIZE * PTRS_PER_PGD / 2)
> > > #define TASK_SIZE_MIN   (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> > >
> > > #ifdef CONFIG_COMPAT
> > > #define TASK_SIZE_32    (_AC(0x80000000, UL) - PAGE_SIZE)
> > > #define TASK_SIZE       (test_thread_flag(TIF_32BIT) ? \
> > >                          TASK_SIZE_32 : TASK_SIZE_64)
> > > #else
> > > [...]
> > >
> > > Meaning CONFIG_COMPAT is only available in CONFIG_64BIT, and TASK_SIZ=
E in
> > > compat mode is either TASK_SIZE_32 or TASK_SIZE_64 depending on the t=
hread_flag.
> > >
> > > from processor.h:
> > > #ifdef CONFIG_64BIT
> > > #define DEFAULT_MAP_WINDOW      (UL(1) << (MMAP_VA_BITS - 1))
> > > #define STACK_TOP_MAX           TASK_SIZE_64
> > > [...]
> > > #define STACK_TOP               DEFAULT_MAP_WINDOW
> > >
> > >
> > > where:
> > > #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_=
64)
> > > with MMAP_VA_BITS_64 being either 48 or 37.
> > >
> > > In compat mode,
> > > STACK_TOP =3D 1 << (32 - 1)       -> 0x80000000
> > > TASK_SIZE =3D 0x8000000 - 4k      -> 0x7ffff000
> > >
> > > IIUC, your suggestion is to make TASK_SIZE =3D STACK_TOP in compat mo=
de only.
> > Yes, it causes the problem, which causes the boot to fail.
>
> I think what Leonardo is getting at is that it is odd that it would
> cause boot issues if TASK_SIZE is not equal STACK_TOP. This seems
> indicative of a different problem. While this may fix the issue, it
> should be valid for TASK_SIZE to be less than STACK_TOP.
Sorry, I don't make sense here. Why do you think STACK_TOP could > TASK_SIZ=
E?
TASK_SIZE is the highest priority of the address limitation for
user-space address, right?

Do you mean:
STACK_TOP could > MMAP_END?

>
> - Charlie
>
> >
> > >
> > > Then why not:
> > > #ifdef CONFIG_COMPAT
> > > #define TASK_SIZE_32    STACK_TOP
> > Yes, it's the solution that I think at first. But I didn't find any
> > problem with 0x7ffff000 ~ 0x80000000, and then I removed this gap to
> > unify it with Sv39 and Sv48.
> >
> > >
> > > With some comments explaining why there is no need to reserve a PAGE_=
SIZE
> > > in the TASK_SIZE_32.
> > At first, I wanted to put a invalid page between the user & kernel
> > space, but it seems useless.
> >
> > >
> > > Does that make sense?
> > >
> > > Thanks!
> > > Leo
> > >
> > > >
> > > > Freeing unused kernel image (initmem) memory: 2236K
> > > > Run /sbin/init as init process
> > > > Starting init: /sbin/init exists but couldn't execute it (error -14=
)
> > > > Run /etc/init as init process
> > > > ...
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,s=
v48,sv57")
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >  arch/riscv/include/asm/pgtable.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/=
asm/pgtable.h
> > > > index ab00235b018f..74ffb2178f54 100644
> > > > --- a/arch/riscv/include/asm/pgtable.h
> > > > +++ b/arch/riscv/include/asm/pgtable.h
> > > > @@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(pte=
_t pte)
> > > >  #define TASK_SIZE_MIN        (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> > > >
> > > >  #ifdef CONFIG_COMPAT
> > > > -#define TASK_SIZE_32 (_AC(0x80000000, UL) - PAGE_SIZE)
> > > > +#define TASK_SIZE_32 (_AC(0x80000000, UL))
> > >
> > >
> > >
> > >
> > > >  #define TASK_SIZE    (test_thread_flag(TIF_32BIT) ? \
> > > >                        TASK_SIZE_32 : TASK_SIZE_64)
> > > >  #else
> > > > --
> > > > 2.40.1
> > > >
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren

