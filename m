Return-Path: <linux-kernel+bounces-134263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED2289AFC3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C0F1C21084
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BC1118E;
	Sun,  7 Apr 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="QRV3tyBA"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666E185E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479669; cv=none; b=Ktjfjkm7AN2WAMSonvm3CgecSXb57pF+sYXhn3+5sqa09FqMRtHodDMZ0wo68B5PBlnmF/XWpbM5WIEi5l64qRlMYDxrdccExXjzl9DCrP6V/YV88/ttxgPcJlM79ACZ6lohy8BQpIbdlOl6ieAA2teEUnLEfIFDC0nKLM4Ioco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479669; c=relaxed/simple;
	bh=rYrCpOYrsuLxCrKv8+ehL6FQpaHdNw4AcW39VkoMTxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwjq0r2+Ob/NeqKNBZwwYvjsXpOs/qPFWL2R3koTIRLys4n3B98kAOK7QF9+T76PC75EkWhgbw/sbuh4X05u75pAo4BsrUMco/SS58LhQgs6d+Va+uqhU5ms7XuXHJxDAmSuoic2CaoK8cwo404jp83XZ6z6OJgNF2HnoU2UPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=QRV3tyBA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a475bdd4a6so1294455a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1712479666; x=1713084466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8BgbMnq6VW+9RiAeIDAU8GdhTfZ4s9fXNgPZsg0Nnk=;
        b=QRV3tyBAxBggQ2ie0b8WbUR0432H8EtWyjMRwl5yZ6v4Xs6K8pT2YWbFG3qOG0XvJl
         dXdNbdWO7Ag7c8X9oq9jJZVghBpRwL602u7ri3TaZLuBjVymAqrNpaDDgO8tIgw7IZ2i
         J6UGN8iuyf/SSE4hD2IvfrS3qZRe8Q6eCwT/57NSYZSUSsf8BcmpG7qSaSlz/DpjWWzz
         ltF1oCOLB8jW+pqe/OrUMJAqxLRZW6nbpE1cNWVpgYomAktjsdI/CkM2mTX8xc5u5iIb
         CmDUsG2nTU+LYW1OAy7ScbqwUH11XoY4HFw8jBh70rbluiPg/xDTqFfvKPMV7Kb9lK0Z
         jRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712479666; x=1713084466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8BgbMnq6VW+9RiAeIDAU8GdhTfZ4s9fXNgPZsg0Nnk=;
        b=pX5YD6/IslXCglwrbjKJaPm928l+S0rLpUSUT2s81WBsmxgwj8AmK2Fq6I92yd55B+
         jyO1mtADFZYgy8errvJjxKHoT7Rud6wmgHUUowQvyWfG3CqU0Ineir2CYnr7chu8OwMz
         /C4V7Hg3A3lfVg6Q4VmZzHJEpiTCEN9LkIvfVx8WQGSbBSD3Amtbf7aQ6CHEjMsNN+3d
         /BvWOlcxhVb7Szrn3UlrKotALf46QlnhqZi8Isq5IrKo6xEcCPAkJu9Qj3EosJ/ScFmA
         pbsdL+Pabjt0qZ9oc955KuV6tYD5we03rMCq6eXx48fEililOaUoymABAqIBgaTAFXKv
         F6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUcsmx6ryQjHuQf1DcPQzpL+kKRgJyi/UgcOLM1GSGxmMJXV2TpohTr5r0KjCfdpzc41+8HH6R7RrcIJUbjdMyqxd6+KaKRcmFQV8ft
X-Gm-Message-State: AOJu0YzxHqDG3NqjMYBYvwtH/AEV41eqofwpW/r3qecr6wlVvNY1XyQw
	d1qyqZkvN8nCEboX+cZEzTmOfIfyzNrkgG/pu4VXxG4nPu+wujFtEi79lh77JlJ6odMlh6Qi/7o
	Ml9XyON9ey2+DhLmwPr0GpjDLVep7GeO2BUvFZA==
X-Google-Smtp-Source: AGHT+IETK8jKWfPmNm9lCZ0iZfNPS0YKHcp6Lt5hibVOcK3a5DupIIugl5491hzEq34YAewAphhrALCHcQtvoJdq00c=
X-Received: by 2002:a17:90b:3d8:b0:2a0:3d59:4632 with SMTP id
 go24-20020a17090b03d800b002a03d594632mr5237970pjb.15.1712479666428; Sun, 07
 Apr 2024 01:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329121414.688391-1-christoph.muellner@vrull.eu>
 <20240329121414.688391-2-christoph.muellner@vrull.eu> <0b817fa8-2a1c-4da4-b5d4-f36ac93dbfd9@sifive.com>
In-Reply-To: <0b817fa8-2a1c-4da4-b5d4-f36ac93dbfd9@sifive.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Sun, 7 Apr 2024 10:47:35 +0200
Message-ID: <CAEg0e7g+tRSG35pjQXemyao5OQtgiio5=nq1FGHE_5On_HZejQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: thead: Rename T-Head PBMT to MAEE
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Heiko Stuebner <heiko@sntech.de>, 
	Cooper Qu <cooper.qu@linux.alibaba.com>, Zhiwei Liu <zhiwei_liu@linux.alibaba.com>, 
	Huang Tao <eric.huang@linux.alibaba.com>, Alistair Francis <alistair.francis@wdc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>, 
	Qingfang Deng <dqfext@gmail.com>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 8:15=E2=80=AFPM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> Hi Christoph,
>
> On 2024-03-29 7:14 AM, Christoph M=C3=BCllner wrote:
> > T-Head's vendor extension to set page attributes has the name
> > MAEE (MMU address attribute extension).
> > Let's rename it, so it is clear what this referes to.
> >
> > See also:
> >   https://github.com/T-head-Semi/thead-extension-spec/blob/master/xthea=
dmaee.adoc
>
> My understanding is that MAEE is the name of the CSR bit and stands for "=
MMU (or
> Memory) Attribute Extension Enable", so the name for the extension itself=
 would
> be "MAE" (just one E). This is similar to THEADISAEE =3D> T-HEAD ISA Exte=
nsion
> Enable. Does that sound right?

Yes, you are right.
I noticed that before as well but did not care too much about it.
Now that I'm not the only one who sees it, I've created a PR for the spec
to rename the extension to XTheadMae:
  https://github.com/T-head-Semi/thead-extension-spec/pull/48
The PR has already been merged, so I'll provide a revised patch.

Thanks!

>
> Regards,
> Samuel
>
> > Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> > ---
> >  arch/riscv/Kconfig.errata            |  8 ++++----
> >  arch/riscv/errata/thead/errata.c     |  8 ++++----
> >  arch/riscv/include/asm/errata_list.h | 20 ++++++++++----------
> >  3 files changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > index 910ba8837add..2c24bef7e112 100644
> > --- a/arch/riscv/Kconfig.errata
> > +++ b/arch/riscv/Kconfig.errata
> > @@ -82,14 +82,14 @@ config ERRATA_THEAD
> >
> >         Otherwise, please say "N" here to avoid unnecessary overhead.
> >
> > -config ERRATA_THEAD_PBMT
> > -     bool "Apply T-Head memory type errata"
> > +config ERRATA_THEAD_MAEE
> > +     bool "Apply T-Head's MMU address attribute (MAEE)"
> >       depends on ERRATA_THEAD && 64BIT && MMU
> >       select RISCV_ALTERNATIVE_EARLY
> >       default y
> >       help
> > -       This will apply the memory type errata to handle the non-standa=
rd
> > -       memory type bits in page-table-entries on T-Head SoCs.
> > +       This will apply the memory type errata to handle T-Head's MMU a=
ddress
> > +       attribute extension (MAEE).
> >
> >         If you don't know what to do here, say "Y".
> >
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead=
/errata.c
> > index b1c410bbc1ae..8c8a8a4b0421 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -19,10 +19,10 @@
> >  #include <asm/patch.h>
> >  #include <asm/vendorid_list.h>
> >
> > -static bool errata_probe_pbmt(unsigned int stage,
> > +static bool errata_probe_maee(unsigned int stage,
> >                             unsigned long arch_id, unsigned long impid)
> >  {
> > -     if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PBMT))
> > +     if (!IS_ENABLED(CONFIG_ERRATA_THEAD_MAEE))
> >               return false;
> >
> >       if (arch_id !=3D 0 || impid !=3D 0)
> > @@ -140,8 +140,8 @@ static u32 thead_errata_probe(unsigned int stage,
> >  {
> >       u32 cpu_req_errata =3D 0;
> >
> > -     if (errata_probe_pbmt(stage, archid, impid))
> > -             cpu_req_errata |=3D BIT(ERRATA_THEAD_PBMT);
> > +     if (errata_probe_maee(stage, archid, impid))
> > +             cpu_req_errata |=3D BIT(ERRATA_THEAD_MAEE);
> >
> >       errata_probe_cmo(stage, archid, impid);
> >
> > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/=
asm/errata_list.h
> > index ea33288f8a25..7c377e137b41 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -23,7 +23,7 @@
> >  #endif
> >
> >  #ifdef CONFIG_ERRATA_THEAD
> > -#define      ERRATA_THEAD_PBMT 0
> > +#define      ERRATA_THEAD_MAEE 0
> >  #define      ERRATA_THEAD_PMU 1
> >  #define      ERRATA_THEAD_NUMBER 2
> >  #endif
> > @@ -53,20 +53,20 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFI=
VE_VENDOR_ID,  \
> >   * in the default case.
> >   */
> >  #define ALT_SVPBMT_SHIFT 61
> > -#define ALT_THEAD_PBMT_SHIFT 59
> > +#define ALT_THEAD_MAEE_SHIFT 59
> >  #define ALT_SVPBMT(_val, prot)                                        =
       \
> >  asm(ALTERNATIVE_2("li %0, 0\t\nnop",                                 \
> >                 "li %0, %1\t\nslli %0,%0,%3", 0,                      \
> >                       RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,  \
> >                 "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,        \
> > -                     ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)    \
> > +                     ERRATA_THEAD_MAEE, CONFIG_ERRATA_THEAD_MAEE)    \
> >               : "=3Dr"(_val)                                           =
 \
> >               : "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),               \
> > -               "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHIFT),            \
> > +               "I"(prot##_THEAD >> ALT_THEAD_MAEE_SHIFT),            \
> >                 "I"(ALT_SVPBMT_SHIFT),                                \
> > -               "I"(ALT_THEAD_PBMT_SHIFT))
> > +               "I"(ALT_THEAD_MAEE_SHIFT))
> >
> > -#ifdef CONFIG_ERRATA_THEAD_PBMT
> > +#ifdef CONFIG_ERRATA_THEAD_MAEE
> >  /*
> >   * IO/NOCACHE memory types are handled together with svpbmt,
> >   * so on T-Head chips, check if no other memory type is set,
> > @@ -83,11 +83,11 @@ asm volatile(ALTERNATIVE(                          =
               \
> >       "slli    t3, t3, %3\n\t"                                        \
> >       "or      %0, %0, t3\n\t"                                        \
> >       "2:",  THEAD_VENDOR_ID,                                         \
> > -             ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)            \
> > +             ERRATA_THEAD_MAEE, CONFIG_ERRATA_THEAD_MAEE)            \
> >       : "+r"(_val)                                                    \
> > -     : "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),              \
> > -       "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT),                 \
> > -       "I"(ALT_THEAD_PBMT_SHIFT)                                     \
> > +     : "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_MAEE_SHIFT),              \
> > +       "I"(_PAGE_PMA_THEAD >> ALT_THEAD_MAEE_SHIFT),                 \
> > +       "I"(ALT_THEAD_MAEE_SHIFT)                                     \
> >       : "t3")
> >  #else
> >  #define ALT_THEAD_PMA(_val)
>

