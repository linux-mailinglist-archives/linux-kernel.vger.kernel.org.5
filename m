Return-Path: <linux-kernel+bounces-104042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD76C87C839
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8C51C221A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD09FC1C;
	Fri, 15 Mar 2024 04:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdZuayU5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128E6FBEF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710475608; cv=none; b=sbI46B7oQpfVv5+lBEHd0uK0xYJRj657WcDMWIABmDW41DjuGUIbFMNbse+vJYTUogFqsrEm8gN0LdZAlEoJcVQ560yPTBBTL/Cshjrl1SY+lF87los5/QejvGqM/CBEz8+Ke+eSdWgpVAzKd43iLDk1/F2Ui35inMFhvGcGZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710475608; c=relaxed/simple;
	bh=aEszL1eYHuUQrRaWbEMqIqLr91Z5i2VPp0C2t0X6KIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCmdOuVPMDk4niKL3zwGEUiyQtzdmJvGeshHZmJgVMqr0B0mpNmCSx4ZtrIRVg0BEMaTVijUViP0Sde8qIfqQbfxAF/XWUHzIqSm8OnolPHUtDfFvOp1S1x0m3jsnzUq2XoE3GfrtHaintpT6vlivHxiNSrcIQ/reJvvuh1wG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdZuayU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE1AC433C7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710475607;
	bh=aEszL1eYHuUQrRaWbEMqIqLr91Z5i2VPp0C2t0X6KIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FdZuayU5mkzcBq/o+O+0IZyudM7OKwyweH0it1sejpPBugKMVqqri4q9bwe0MmHK0
	 XPpuDD35pQUqHdlIyT1iUm/b6FMWBtkh6MxbEZmbGqwidjLzrB6hihLLUZv0HR0FuO
	 /TZktOdUbUxm2AeJhrtEzjwPxIqAQsncwJcNN6ZX1PMNnj4fP1sDwYV56kUVn9h9Os
	 kC+v1AmuxkXnep0siUaQP9PkR4xD0Pc4j2RunHMJcyjBnf5svyeJAHqUVN+Oipiqfe
	 MiUzDbz/tFcDeO23546JZBIvJF7gtU+fYK4pojYtKiKNn4pGW/Z3ws0Bw5nJDdtZVU
	 ywXwN1vvsCCAA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d220e39907so23784081fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:06:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLwVouyVy1E4iJi8+W6Hz78rxadk1Fp4S3QTMqf8S4DRi0XkwAiXDa4RUUq28sHHEoyCY40g5gSItkgYUHqefVp7EbMGXKiq7PIBIt
X-Gm-Message-State: AOJu0YyMY1fEgNvH74dCWudJBQ1QT5Sz+7RQT9bY4a8D7g081tyi5lwk
	EXrHZDACuwVsoe02pzfP95gVHoux0rnL+6ivQGsOO5xZ/8zw7fwuy4bGR98q+ghAqbsJxKMe0QI
	ifuD3RFDXt0DADueuK1iMGKsg/7M=
X-Google-Smtp-Source: AGHT+IHvMoXiS87S0gUMxFt23So/Yzo5cCR8QxVV+JTA0NOy2me1SReKl03MODdud8gY1g5pnw9EN7ncy20C6SJJUEI=
X-Received: by 2002:a05:651c:615:b0:2d4:992:3cb0 with SMTP id
 k21-20020a05651c061500b002d409923cb0mr2093037lje.6.1710475606307; Thu, 14 Mar
 2024 21:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117125807.1058477-1-masahiroy@kernel.org>
 <CAK7LNAStoCja1gnoFmsKikbzGZmKTcTu+Vc7v9zg8B9hwsH+iQ@mail.gmail.com>
 <CAK7LNATVAcj-pa_G-NGBTr9doCACGk1nKCNbxM50-M0mi9q=7w@mail.gmail.com> <ca097f2a-59ec-4945-9860-5e380e1665e4@ghiti.fr>
In-Reply-To: <ca097f2a-59ec-4945-9860-5e380e1665e4@ghiti.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 15 Mar 2024 13:06:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNARShVA953-U+p6=wzq3GFsKx4GwpRiqmqftjQz3VkE2VA@mail.gmail.com>
Message-ID: <CAK7LNARShVA953-U+p6=wzq3GFsKx4GwpRiqmqftjQz3VkE2VA@mail.gmail.com>
Subject: Re: [PATCH] riscv: compat_vdso: install compat_vdso.so.dbg to /lib/modules/*/vdso/
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:12=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
> Hi Masahiro,
>
> On 24/02/2024 04:37, Masahiro Yamada wrote:
> > Ping x 2 ?
> >
> >
> >
> >
> >
> > On Sun, Jan 21, 2024 at 6:48=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> >> On Fri, Nov 17, 2023 at 9:58=E2=80=AFPM Masahiro Yamada <masahiroy@ker=
nel.org> wrote:
> >>> 'make vdso_install' installs debug vdso files to /lib/modules/*/vdso/=
.
> >>>
> >>> Only for the compat vdso on riscv, the installation destination diffe=
rs;
> >>> compat_vdso.so.dbg is installed to /lib/module/*/compat_vdso/.
> >>>
> >>> To follow the standard install destination and simplify the vdso_inst=
all
> >>> logic, change the install destination to standard /lib/modules/*/vdso=
/.
> >>>
> >>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >>> ---
> >>
> >> Ping?
> >> (in case "yet more RISC-V updates" happens)
> >>
> >>
> >>
> >>
> >>>   arch/riscv/Makefile | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> >>> index a74be78678eb..5cbe596345c1 100644
> >>> --- a/arch/riscv/Makefile
> >>> +++ b/arch/riscv/Makefile
> >>> @@ -146,7 +146,7 @@ endif
> >>>   endif
> >>>
> >>>   vdso-install-y                 +=3D arch/riscv/kernel/vdso/vdso.so.=
dbg
> >>> -vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/co=
mpat_vdso.so.dbg:../compat_vdso/compat_vdso.so
> >>> +vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/co=
mpat_vdso.so.dbg
> >>>
> >>>   ifneq ($(CONFIG_XIP_KERNEL),y)
> >>>   ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> >>> --
> >>> 2.40.1
> >>>
> >>
> >> --
> >> Best Regards
> >> Masahiro Yamada
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
> Couldn't changing this library install path break some existing
> application? I mean it kind of breaks where the library is expected to
> be right?


Do you have a particular library in mind?


RISV-V is the only architecture that installs a debug vdso
to a different location than the
standard lib/modules/*/vdso/.


I regard this as a fix.





--=20
Best Regards
Masahiro Yamada

