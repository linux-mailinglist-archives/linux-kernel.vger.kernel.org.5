Return-Path: <linux-kernel+bounces-9275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA781C33C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9371F254C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1143C15A4;
	Fri, 22 Dec 2023 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU5kvvyY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0A5390;
	Fri, 22 Dec 2023 02:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C97C433CC;
	Fri, 22 Dec 2023 02:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703213849;
	bh=B7WoB0gREyq2eeosBDTUvV5rdLVfhJVD/gu6y94sIZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TU5kvvyY9FjchZxkY2Up3GEEdfwcnibMZQYJjo1X/r0stFqxzMjMypKJkGZtZwNwI
	 SPEWkk6GfFcQZ/HWjmGdBIo2WmVuAujlmtr+R47w/zBXGTehIF3vOXPB0JUNi/GFvu
	 pOTyJqU8/S6JmiufabOiPHux09JctA0Lhe5X9wUMON8NL0916TSmeTX38VySlIyh+V
	 /pABlywq41C/J4uJvgIlcUFvgWAYdeHHfpIZAfEfYDf3nObym4Bposr0tOEq07v/1L
	 0ROPnXnaqmlr+J1nIvkEqUdLyq0+7SuMw/7J+n/uGuMa933m2fnSc3wcFhjO0jxGGI
	 IRUMPugAABjlg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2343c31c4bso174619466b.1;
        Thu, 21 Dec 2023 18:57:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yz5NievQ65DnApjRcVQKijQ7qD6x3NuqjI9aKAYMotAGq11JZyX
	xURcsXLCq0RJHDqzyWH3i3dJWrPEqsbNMViOxyU=
X-Google-Smtp-Source: AGHT+IEtKuQYt0eKcYcGXNsbYd6L6zfQChg70xnlZIIepptITPMCZeUaD/4I8okkksMp3jbxyzTgLyGXO2AURgMebyg=
X-Received: by 2002:a17:906:af93:b0:a26:86d8:ff54 with SMTP id
 mj19-20020a170906af9300b00a2686d8ff54mr275692ejb.5.1703213848210; Thu, 21 Dec
 2023 18:57:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-2-guoren@kernel.org>
 <ZYTriK9hjOFQou9Z@LeoBras>
In-Reply-To: <ZYTriK9hjOFQou9Z@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 10:57:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT=EQzsuYMHr3FLb82Gi325PqWMEOAzfc6fg=go+gKP_g@mail.gmail.com>
Message-ID: <CAJF2gTT=EQzsuYMHr3FLb82Gi325PqWMEOAzfc6fg=go+gKP_g@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] riscv: mm: Fixup compat mode boot failure
To: Leonardo Bras <leobras@redhat.com>
Cc: linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	alexghiti@rivosinc.com, charlie@rivosinc.com, xiao.w.wang@intel.com, 
	david@redhat.com, panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com, 
	willy@infradead.org, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	cleger@rivosinc.com, linux-riscv@lists.infradead.org, 
	Guo Ren <guoren@linux.alibaba.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 9:51=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> Hello Guo Ren,
>
> On Thu, Dec 21, 2023 at 10:46:58AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > In COMPAT mode, the STACK_TOP is 0x80000000, but the TASK_SIZE is
> > 0x7fff000. When the user stack is upon 0x7fff000, it will cause a user
> > segment fault. Sometimes, it would cause boot failure when the whole
> > rootfs is rv32.
>
> Checking if I get the scenario:
>
> In pgtable.h:
> #ifdef CONFIG_64BIT
> #define TASK_SIZE_64    (PGDIR_SIZE * PTRS_PER_PGD / 2)
> #define TASK_SIZE_MIN   (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
>
> #ifdef CONFIG_COMPAT
> #define TASK_SIZE_32    (_AC(0x80000000, UL) - PAGE_SIZE)
> #define TASK_SIZE       (test_thread_flag(TIF_32BIT) ? \
>                          TASK_SIZE_32 : TASK_SIZE_64)
> #else
> [...]
>
> Meaning CONFIG_COMPAT is only available in CONFIG_64BIT, and TASK_SIZE in
> compat mode is either TASK_SIZE_32 or TASK_SIZE_64 depending on the threa=
d_flag.
>
> from processor.h:
> #ifdef CONFIG_64BIT
> #define DEFAULT_MAP_WINDOW      (UL(1) << (MMAP_VA_BITS - 1))
> #define STACK_TOP_MAX           TASK_SIZE_64
> [...]
> #define STACK_TOP               DEFAULT_MAP_WINDOW
>
>
> where:
> #define MMAP_VA_BITS (is_compat_task() ? VA_BITS_SV32 : MMAP_VA_BITS_64)
> with MMAP_VA_BITS_64 being either 48 or 37.
>
> In compat mode,
> STACK_TOP =3D 1 << (32 - 1)       -> 0x80000000
> TASK_SIZE =3D 0x8000000 - 4k      -> 0x7ffff000
>
> IIUC, your suggestion is to make TASK_SIZE =3D STACK_TOP in compat mode o=
nly.
Yes, it causes the problem, which causes the boot to fail.

>
> Then why not:
> #ifdef CONFIG_COMPAT
> #define TASK_SIZE_32    STACK_TOP
Yes, it's the solution that I think at first. But I didn't find any
problem with 0x7ffff000 ~ 0x80000000, and then I removed this gap to
unify it with Sv39 and Sv48.

>
> With some comments explaining why there is no need to reserve a PAGE_SIZE
> in the TASK_SIZE_32.
At first, I wanted to put a invalid page between the user & kernel
space, but it seems useless.

>
> Does that make sense?
>
> Thanks!
> Leo
>
> >
> > Freeing unused kernel image (initmem) memory: 2236K
> > Run /sbin/init as init process
> > Starting init: /sbin/init exists but couldn't execute it (error -14)
> > Run /etc/init as init process
> > ...
> >
> > Cc: stable@vger.kernel.org
> > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,=
sv57")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index ab00235b018f..74ffb2178f54 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t p=
te)
> >  #define TASK_SIZE_MIN        (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> >
> >  #ifdef CONFIG_COMPAT
> > -#define TASK_SIZE_32 (_AC(0x80000000, UL) - PAGE_SIZE)
> > +#define TASK_SIZE_32 (_AC(0x80000000, UL))
>
>
>
>
> >  #define TASK_SIZE    (test_thread_flag(TIF_32BIT) ? \
> >                        TASK_SIZE_32 : TASK_SIZE_64)
> >  #else
> > --
> > 2.40.1
> >
>


--=20
Best Regards
 Guo Ren

