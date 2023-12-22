Return-Path: <linux-kernel+bounces-9455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0025F81C5DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C66B1F23B16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E082C2F0;
	Fri, 22 Dec 2023 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNctBg06"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE23241F3;
	Fri, 22 Dec 2023 07:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9EAC4339A;
	Fri, 22 Dec 2023 07:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703230431;
	bh=Js9mFxTjdS4RHFZpNBXtXK6UQmUyniFDMRqPYxNV2eg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RNctBg06iYouMH4L4/MssBF3378c6afk5bZldsSRRoGlhTLtifHs32uP1W+jh5hqp
	 PHpNMllnYSSRYxfQteW3ai3iZFEseY5ykq8srZcdMbQPVNtrJZ/xRRHfFBbZ095lFb
	 JmABN870GsH9dg0bomEMIiOH/G5rDevKUnQClH5jH2T8refPqxiLBUpMoqtS3EY4tV
	 QWEyROR86b8FIFZOuiYKCCCo6o637d9YNLsn2sskt8PRPABS4sLPD7JdeZBia8M6Ks
	 GeeA88ntPVZvPAhq/E0PVeFDgyv/Gb7LGDRgSTcKhkDJmTmg90r55yeebiQhkwDqgr
	 ntE1rSaaMNcYA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5534abbc637so1816249a12.0;
        Thu, 21 Dec 2023 23:33:51 -0800 (PST)
X-Gm-Message-State: AOJu0YzYrF0yS5cB54Me1Dw72wW9S8SD5Q2GFwkuzf8R+7L/frGRWmj1
	pDB/3qvkPJwruMm1c9OofeLVUgwauQehtm5p3Z8=
X-Google-Smtp-Source: AGHT+IE2yNM9a0cZI0Nm4o6zCMPlXO4o3RDUDZJLeKMQNH/z94tua866L0WRp1To+KH5fA5/N9922XwtnwbyxYIZYCo=
X-Received: by 2002:a17:906:b3a4:b0:a1d:7792:cdbe with SMTP id
 uh36-20020a170906b3a400b00a1d7792cdbemr438891ejc.146.1703230429499; Thu, 21
 Dec 2023 23:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-2-guoren@kernel.org>
 <ZYTriK9hjOFQou9Z@LeoBras> <CAJF2gTT=EQzsuYMHr3FLb82Gi325PqWMEOAzfc6fg=go+gKP_g@mail.gmail.com>
 <ZYUHg3kIMYdNSOSr@ghost> <ZYUReEZWcZVv1kxP@LeoBras>
In-Reply-To: <ZYUReEZWcZVv1kxP@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 15:33:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS6MntY1sa+VqQ-hXbrGRaXOKqSY86xwe1-G1fVZHn7gQ@mail.gmail.com>
Message-ID: <CAJF2gTS6MntY1sa+VqQ-hXbrGRaXOKqSY86xwe1-G1fVZHn7gQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] riscv: mm: Fixup compat mode boot failure
To: Leonardo Bras <leobras@redhat.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, linux-kernel@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, alexghiti@rivosinc.com, 
	xiao.w.wang@intel.com, david@redhat.com, panqinglin2020@iscas.ac.cn, 
	rick.p.edgecombe@intel.com, willy@infradead.org, bjorn@rivosinc.com, 
	conor.dooley@microchip.com, cleger@rivosinc.com, 
	linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:33=E2=80=AFPM Leonardo Bras <leobras@redhat.com>=
 wrote:
>
> On Thu, Dec 21, 2023 at 07:50:27PM -0800, Charlie Jenkins wrote:
> > On Fri, Dec 22, 2023 at 10:57:16AM +0800, Guo Ren wrote:
> > > On Fri, Dec 22, 2023 at 9:51=E2=80=AFAM Leonardo Bras <leobras@redhat=
.com> wrote:
> > > >
> > > > Hello Guo Ren,
> > > >
> > > > On Thu, Dec 21, 2023 at 10:46:58AM -0500, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > In COMPAT mode, the STACK_TOP is 0x80000000, but the TASK_SIZE is
> > > > > 0x7fff000. When the user stack is upon 0x7fff000, it will cause a=
 user
> > > > > segment fault. Sometimes, it would cause boot failure when the wh=
ole
> > > > > rootfs is rv32.
> > > >
> > > > Checking if I get the scenario:
> > > >
> > > > In pgtable.h:
> > > > #ifdef CONFIG_64BIT
> > > > #define TASK_SIZE_64    (PGDIR_SIZE * PTRS_PER_PGD / 2)
> > > > #define TASK_SIZE_MIN   (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> > > >
> > > > #ifdef CONFIG_COMPAT
> > > > #define TASK_SIZE_32    (_AC(0x80000000, UL) - PAGE_SIZE)
> > > > #define TASK_SIZE       (test_thread_flag(TIF_32BIT) ? \
> > > >                          TASK_SIZE_32 : TASK_SIZE_64)
> > > > #else
> > > > [...]
> > > >
> > > > Meaning CONFIG_COMPAT is only available in CONFIG_64BIT, and TASK_S=
IZE in
> > > > compat mode is either TASK_SIZE_32 or TASK_SIZE_64 depending on the=
 thread_flag.
> > > >
> > > > from processor.h:
> > > > #ifdef CONFIG_64BIT
> > > > #define DEFAULT_MAP_WINDOW      (UL(1) << (MMAP_VA_BITS - 1))
> > > > #define STACK_TOP_MAX           TASK_SIZE_64
> > > > [...]
> > > > #define STACK_TOP               DEFAULT_MAP_WINDOW
> > > >
> > > >
> > > > where:
> > > > #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BIT=
S_64)
> > > > with MMAP_VA_BITS_64 being either 48 or 37.
> > > >
> > > > In compat mode,
> > > > STACK_TOP =3D 1 << (32 - 1)       -> 0x80000000
> > > > TASK_SIZE =3D 0x8000000 - 4k      -> 0x7ffff000
> > > >
> > > > IIUC, your suggestion is to make TASK_SIZE =3D STACK_TOP in compat =
mode only.
> > > Yes, it causes the problem, which causes the boot to fail.
> >
> > I think what Leonardo is getting at is that it is odd that it would
> > cause boot issues if TASK_SIZE is not equal STACK_TOP. This seems
> > indicative of a different problem. While this may fix the issue, it
> > should be valid for TASK_SIZE to be less than STACK_TOP.
> >
> > - Charlie
> >
>
> That is also a good point, but I am not that acquainted to this to
> actually propose this.
>
> I was thinking more on these questions:
> Is TASK_SIZE and STACK_TOP related somehow?
> If so, would not be better to describe one in terms of the other, like
> #define TASK_SIZE (STACK_TOP - PAGE_SIZE)
TASK_SIZE means the maximum user address space, so it's the limitation
to any kind of mmap or stack ...
So STACK_TOP <=3D TASK_SIZE

Follow your idea. The question is:
#define TASK_SIZE ((UL(1) << (VA_BITS - 1)) - PAGE_SIZE)

Do we need to reserve one page between userspace & kernel?


>
> Or the other way around.
>
> I mean, if they have any relation it would be much easier to represent th=
em
> that way, and it would avoid having two magical numbers.
>
> Thanks!
> Leo
>
> > >
> > > >
> > > > Then why not:
> > > > #ifdef CONFIG_COMPAT
> > > > #define TASK_SIZE_32    STACK_TOP
> > > Yes, it's the solution that I think at first. But I didn't find any
> > > problem with 0x7ffff000 ~ 0x80000000, and then I removed this gap to
> > > unify it with Sv39 and Sv48.
> > >
> > > >
> > > > With some comments explaining why there is no need to reserve a PAG=
E_SIZE
> > > > in the TASK_SIZE_32.
> > > At first, I wanted to put a invalid page between the user & kernel
> > > space, but it seems useless.
> > >
> > > >
> > > > Does that make sense?
> > > >
> > > > Thanks!
> > > > Leo
> > > >
> > > > >
> > > > > Freeing unused kernel image (initmem) memory: 2236K
> > > > > Run /sbin/init as init process
> > > > > Starting init: /sbin/init exists but couldn't execute it (error -=
14)
> > > > > Run /etc/init as init process
> > > > > ...
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39=
,sv48,sv57")
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > ---
> > > > >  arch/riscv/include/asm/pgtable.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/includ=
e/asm/pgtable.h
> > > > > index ab00235b018f..74ffb2178f54 100644
> > > > > --- a/arch/riscv/include/asm/pgtable.h
> > > > > +++ b/arch/riscv/include/asm/pgtable.h
> > > > > @@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(p=
te_t pte)
> > > > >  #define TASK_SIZE_MIN        (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> > > > >
> > > > >  #ifdef CONFIG_COMPAT
> > > > > -#define TASK_SIZE_32 (_AC(0x80000000, UL) - PAGE_SIZE)
> > > > > +#define TASK_SIZE_32 (_AC(0x80000000, UL))
> > > >
> > > >
> > > >
> > > >
> > > > >  #define TASK_SIZE    (test_thread_flag(TIF_32BIT) ? \
> > > > >                        TASK_SIZE_32 : TASK_SIZE_64)
> > > > >  #else
> > > > > --
> > > > > 2.40.1
> > > > >
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> >
>


--
Best Regards
 Guo Ren

