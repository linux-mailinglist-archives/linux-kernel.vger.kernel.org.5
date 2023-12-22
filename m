Return-Path: <linux-kernel+bounces-9341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB3381C453
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A741F24E20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EA3523C;
	Fri, 22 Dec 2023 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buDEjzPz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9B5390;
	Fri, 22 Dec 2023 04:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BE5C433CD;
	Fri, 22 Dec 2023 04:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703220657;
	bh=0LsfsZZzBusgIAD3qQmmUaG27xjYEQSKO7z6xMBhlSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=buDEjzPzJl2oOTCG4mR5hrq0Y5hBjbDkESelrGra7PVruT0KoN7WXmZfLmgG/pGo6
	 gO01+22n2/ktkp/IFnlDdlCkSqaFbtWbXPPkYBiu6eeE80rL5QVYNcNvA9jfU2KGq6
	 EU7Q6oo27Zm3n338viOKmNTfUKyULO6C1WpEXCJwVOh24KCDhrM5IW7jF1xar2CgWR
	 AbehwW4SSzEr21ppi49PQ4t+hWsGc/rMH2zD8RqastjxFe6+CkDHwq0AnSVqXwlF+j
	 2JCgvEMZEhw0zBZg70qUZBSHbsAMBCd9qZ5mj6rXCwZ/UKrgtxGC2lw9DsMTJVACX5
	 BxdmWvEWsu/Nw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso1562202a12.3;
        Thu, 21 Dec 2023 20:50:57 -0800 (PST)
X-Gm-Message-State: AOJu0YwxUWYog0366hfUij633lwBBYOzFw0p3hO8JHM1XmSMrE2KxYME
	0w1uZ2J5bm6sI/Sr7yivTqPNdYQrzCMKwTy+FIc=
X-Google-Smtp-Source: AGHT+IGWvwT64VgFovv+c7qqHAeH9Td6lUqhBKTKZF7USauEgYd1T/2cWvULuhrGCPCvy2nROY7kM+DKUTSU9Jfz6Q0=
X-Received: by 2002:a17:906:82:b0:a23:6fe5:affe with SMTP id
 2-20020a170906008200b00a236fe5affemr414814ejc.62.1703220656295; Thu, 21 Dec
 2023 20:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-3-guoren@kernel.org>
 <ZYUD4C1aXWt2oFJo@LeoBras> <CAJF2gTSiaNWkXS6rc+3OSZfnFqG2d7btzjrd-L1mBgAVu3ym3A@mail.gmail.com>
 <ZYUT22KmGJ1tJSWx@LeoBras>
In-Reply-To: <ZYUT22KmGJ1tJSWx@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 12:50:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRptBZyYbnY-mjn-AuQwVnekQtGY8nAOV7KVWLCY1WBcw@mail.gmail.com>
Message-ID: <CAJF2gTRptBZyYbnY-mjn-AuQwVnekQtGY8nAOV7KVWLCY1WBcw@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
To: Leonardo Bras <leobras@redhat.com>
Cc: linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	alexghiti@rivosinc.com, charlie@rivosinc.com, xiao.w.wang@intel.com, 
	david@redhat.com, panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com, 
	willy@infradead.org, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	cleger@rivosinc.com, linux-riscv@lists.infradead.org, 
	Guo Ren <guoren@linux.alibaba.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:43=E2=80=AFPM Leonardo Bras <leobras@redhat.com>=
 wrote:
>
> On Fri, Dec 22, 2023 at 12:26:19PM +0800, Guo Ren wrote:
> > On Fri, Dec 22, 2023 at 11:35=E2=80=AFAM Leonardo Bras <leobras@redhat.=
com> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 10:46:59AM -0500, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > When the task is in COMPAT mode, the arch_get_mmap_end should be 2G=
B,
> > > > not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
> > > > detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
> > > > directly.
> > >
> > > ok
> > >
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,s=
v48,sv57")
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >  arch/riscv/include/asm/processor.h | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/includ=
e/asm/processor.h
> > > > index f19f861cda54..1f538fc4448d 100644
> > > > --- a/arch/riscv/include/asm/processor.h
> > > > +++ b/arch/riscv/include/asm/processor.h
> > > > @@ -16,15 +16,13 @@
> > > >
> > > >  #ifdef CONFIG_64BIT
> > > >  #define DEFAULT_MAP_WINDOW   (UL(1) << (MMAP_VA_BITS - 1))
> > > > -#define STACK_TOP_MAX                TASK_SIZE_64
> > > > +#define STACK_TOP_MAX                TASK_SIZE
> > >
> > > It means STACK_TOP_MAX will be in 64BIT:
> > > - TASK_SIZE_32 if compat_mode=3Dy
> > > - TASK_SIZE_64 if compat_mode=3Dn
> > >
> > > Makes sense for me.
> > >
> > > >
> > > >  #define arch_get_mmap_end(addr, len, flags)                  \
> > > >  ({                                                           \
> > > >       unsigned long mmap_end;                                 \
> > > >       typeof(addr) _addr =3D (addr);                            \
> > > > -     if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_comp=
at_task())) \
> > > > -             mmap_end =3D STACK_TOP_MAX;                       \
> > > > -     else if ((_addr) >=3D VA_USER_SV57)                       \
> > > > +     if ((_addr) =3D=3D 0 || (_addr) >=3D VA_USER_SV57)           =
 \
> > > >               mmap_end =3D STACK_TOP_MAX;                       \
> > > >       else if ((((_addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D VA_BI=
TS_SV48)) \
> > > >               mmap_end =3D VA_USER_SV48;                        \
> > >
> > >
> > > I don't think I got this change, or how it's connected to the commit =
msg.
> > The above is just code simplification; if STACK_TOP_MAX is TASK_SIZE, t=
hen
> >
> >      if ((_addr) =3D=3D 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_ta=
sk())) \
> >              mmap_end =3D STACK_TOP_MAX;                       \
> >     else if ((_addr) >=3D VA_USER_SV57)                       \
> >
> > is equal to:
> >
> >      if ((_addr) =3D=3D 0 || (_addr) >=3D VA_USER_SV57)            \
>
> I am failing to understand exactly how are they equal.
> I mean, what in your STACK_TOP_MAX change made them equal?
#define STACK_TOP_MAX TASK_SIZE
#define TASK_SIZE       (is_compat_task() ? TASK_SIZE_32 : TASK_SIZE_64)

>
> See below, the behavior changed:
> >
> > >
> > > Before:
> > > - addr =3D=3D 0, or addr > 2^57, or compat: mmap_end =3D STACK_TOP_MA=
X
> > > - 2^48 < addr < 2^57: mmap_end =3D 2^48
> > > - 0 < addr < 2^48 : mmap_end =3D 2^39
> > >
> > > Now:
> > > - addr =3D=3D 0, or addr > 2^57: mmap_end =3D STACK_TOP_MAX
> > > - 2^48 < addr < 2^57: mmap_end =3D 2^48
> > > - 0 < addr < 2^48 : mmap_end =3D 2^39
> > >
> > > IIUC compat mode addr will be < 2^32, so will always have mmap_end =
=3D 2^39
> > > if addr !=3D 0. Is that desireable?
> > > (if not, above change is unneeded)
> > >
>
> ^
>
> With your change on STACK_TOP_MAX only (not changing arch_get_mmap_end),
> you would have:
>
> - compat_mode & (0 < addr < 2^32)       -> mmap_end =3D 2^32
compat_mode      -> mmap_end =3D 2^32

> - non-compat, addr =3D=3D 0, or addr > 2^57 -> mmap_end =3D TASK_SIZE_64
> - non-compat, (2^48 < addr < 2^57)      -> mmap_end =3D 2^48
> - non-compat, (0 < addr < 2^48)         -> mmap_end =3D 2^39
>
> Which seems more likely, based on Charlie comments.
>
> Thanks,
> Leo
>
> > > Also, unrelated to the change:
> > > - 2^48 < addr < 2^57: mmap_end =3D 2^48
> > > Is the above correct?
> > > It looks like it should be 2^57 instead, and a new if clause for
> > > 2^32 < addr < 2^48 should have mmap_end =3D 2^48.
> > >
> > > Do I get it wrong?
> > Maybe I should move this into the optimization part.
> >
> > >
> > > (I will send an RFC 'fixing' the code the way I am whinking it should=
 look
> > > like)
> > >
> > > Thanks,
> > > Leo
> > >
> > >
> > >
> > >
> > >
> > > > --
> > > > 2.40.1
> > > >
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

