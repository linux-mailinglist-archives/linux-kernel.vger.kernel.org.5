Return-Path: <linux-kernel+bounces-76690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE0685FB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628E22833F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E371474B7;
	Thu, 22 Feb 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rf9CDZxY"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC54131722
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611671; cv=none; b=Qas1x3X1lznKJWJ6/8vMeKOQKb0G22yvBCgba0zvwFz/hir1ETx+H39BOWRSnXnk6qL8rJqNRgxUW7NBzw/z2CUA0erdD796mQ0ZcFErAPc5Cq3cPyl0hsr9FpORQitQJtdEyEejSlReZeZK3bIzsC1SOpk2asHUc2xrn7sVRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611671; c=relaxed/simple;
	bh=hFxpO4GR/5iMVaBmn/Zdsep3uTI5ZDGWU8zbkKC466w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSLFNk5pP/b+/1yiujZ8GsUObcMUVYcoqRnGB7pA3hD5BqdVTva/vnH/zAlivT13N+nnNxllEvScM3UUSqUpEHf2KgNUOh4w6704Dq4MRX+/WchADfer4xl1S9eL+MQKSusWG+vJ9gFiErmViBHRjjDE501qUr/5uzFBQ4Z/l7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rf9CDZxY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so10626a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708611667; x=1709216467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vx+iIJOibgjuFOgHi+q08iZ0cH0L6N2QcJGYqxk3vE=;
        b=rf9CDZxYLY0qWujKH3BaC7/dNczl4JLUISuUXXyZjQxdLXAGAptzfwA0ge4rDoLJsz
         DEDFEFEBUybo7qyo1E6V28+QSjX8r6cks4IhUMeH9oZ4SbG6iWokJiS/1I4vFKzSpOQn
         xpIxgMZalZ7bC7KKP+IFhrXHxzT6ACMANmrkWvsfQ7vz4bJxaEvTkACmaSpuSmPji5Bc
         uhu+pk6U25KQ3qAsOymX8zH8zJYZqZDdLHMSp7rqreaazNpbocQaJMP59s/D+xAwQqZ+
         9CsIMuWYq0C0pX2/7zo3+6fXBqyxXFm2IXqhOkD7yxSapxxrFcxjiA+BF8XB1ehDoxgC
         lnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708611667; x=1709216467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Vx+iIJOibgjuFOgHi+q08iZ0cH0L6N2QcJGYqxk3vE=;
        b=U/D1eemqj2DeR02IwkKPK+1qxrYg60+3Uc0+iR6pdyeJIaLhQ9PjLBwgkHUzH7Itzi
         lBRqRA022LNAXxuGYjmDQB5yG4TgH1vSL8gMJF9Y0DukFvF1A4CkHiO5v4I39TPUCEJz
         X75IjOjCSZP9mbAmyivlzfT3BMo90RJ7w2oSrQ6S+HlhQm2tcBonFW3HVvY1bh+C89wz
         C+lGowWQQqxaeKQRmqQjQHz6Fx2m5kCqlMO6dnsqYsZyTtpyIIgEQr3fD0Qf8R1Gorjn
         zhx/di0QtHovxWmG4rPjrGhIPEw9NJiI7rd1HKmu0v1WBQI+FP8z4LF5ydlh6juz/+sZ
         RNnw==
X-Forwarded-Encrypted: i=1; AJvYcCV2GRS+MXwcSw7PphxDOrMvCg6AMU3lqj1L9QJMI0SzHeb3tzZ1zZSFEN0aQwXtinZpPGTJe3tlCdYrcr8Z0V9xwwDiwS4D8Y4xe9Df
X-Gm-Message-State: AOJu0Yy4ZBIrvien4hEO613OSKQwigNGFfLmG3BOfFXUNe5MIXSOQTfO
	t1uUvmfrt2QzalicYsIDPVmBCOKc4/OGagRVeCHu3w8urcpVmg/OToE9tqaYRGkjrbP0b+lL4/6
	Drol9KNUT0CNw19o/jLgOxRqFZIcRpQEefl81
X-Google-Smtp-Source: AGHT+IHVGxHYsEDLLDJ5B8FFld4SJKQTByDcf75uzuv9zbFVq+0gVolRPjYeXJRQtHTAq0Dvp+p9nEQBaaoV8WpHX9o=
X-Received: by 2002:a50:d5d9:0:b0:563:f48f:a5bc with SMTP id
 g25-20020a50d5d9000000b00563f48fa5bcmr363612edj.5.1708611667435; Thu, 22 Feb
 2024 06:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221202655.2423854-1-jannh@google.com> <20240221202655.2423854-2-jannh@google.com>
 <CAK7LNAQG_dX8p0Lch-wg8cOVRQzaJUh2zFJL+3tgpcT8_iSTow@mail.gmail.com> <CAG48ez3Kg+BPsf_gWhm9E3QwOOw_CbTnHJ828Df41i1_EYrxnw@mail.gmail.com>
In-Reply-To: <CAG48ez3Kg+BPsf_gWhm9E3QwOOw_CbTnHJ828Df41i1_EYrxnw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Feb 2024 15:20:29 +0100
Message-ID: <CAG48ez39zR+Um-9HMX2GgbOZrvQFjA=bN_dsZBJPvmnqtyg+VA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kallsyms: build faster by using .incbin
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:20=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> On Thu, Feb 22, 2024 at 5:07=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> > On Thu, Feb 22, 2024 at 5:27=E2=80=AFAM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > Currently, kallsyms builds a big assembly file (~19M with a normal
> > > kernel config), and then the assembler has to turn that big assembly
> > > file back into binary data, which takes around a second per kallsyms
> > > invocation. (Normally there are two kallsyms invocations per build.)
> > >
> > > It is much faster to instead directly output binary data, which can
> > > be imported in an assembly file using ".incbin". This is also the
> > > approach taken by arch/x86/boot/compressed/mkpiggy.c.
> >
> >
> > Yes, that is a sensible case because it just wraps the binary
> > without any modification.
> >
> >
> >
> >
> > > So this patch switches kallsyms to that approach.
> > >
> > > A complication with this is that the endianness of numbers between
> > > host and target might not match (for example, when cross-compiling);
> > > and there seems to be no kconfig symbol that tells us what endianness
> > > the target has.
> >
> >
> >
> > CONFIG_CPU_BIG_ENDIAN is it.
> >
> >
> >
> > You could do this:
> >
> > if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> >         kallsymopt=3D"${kallsymopt} --big-endian"
> > fi
> >
> > if is_enabled CONFIG_64BIT; then
> >         kallsymopt=3D"${kallsymopt} --64bit"
> > fi
>
> Aah, nice, thanks, I searched for endianness kconfig flags but somehow
> missed that one.
>
> Though actually, I think further optimizations might make it necessary
> to directly operate on ELF files anyway, in which case it would
> probably be easier to keep using the ELF header...
>
> > > So pass the path to the intermediate vmlinux ELF file to the kallsyms
> > > tool, and let it parse the ELF header to figure out the target's
> > > endianness.
> > >
> > > I have verified that running kallsyms without these changes and
> > > kallsyms with these changes on the same input System.map results
> > > in identical object files.
> > >
> > > This change reduces the time for an incremental kernel rebuild
> > > (touch fs/ioctl.c, then re-run make) from 27.7s to 24.1s (medians
> > > over 16 runs each) on my machine - saving around 3.6 seconds.
> >
> >
> >
> >
> > This reverts bea5b74504742f1b51b815bcaf9a70bddbc49ce3
> >
> > Somebody might struggle with debugging again, but I am not sure.
> >
> > Arnd?
> >
> >
> >
> > If the effort were "I invented a way to do kallsyms in
> > one pass instead of three", it would be so much more attractive.
>
> Actually, I was chatting with someone about this yesterday, and I
> think I have an idea on how to get rid of two link steps... I might
> try out some stuff and then come back with another version of this
> series afterwards.

I think basically we could change kallsyms so that on the second run,
it checks if the kallsyms layout is the same as on the first run, and
if yes, directly overwrite the relevant part of vmlinux. (And adjust
the relative_base.) That would save us the final link... does that
sound like a reasonable idea?

I don't really have any good ideas for saving more than that, given
that we want to squeeze the kallsyms in between the data and bss
sections, so we can't just append it at the end of vmlinux... we could
get the symbol list from vmlinux.o instead of linking
".tmp_vmlinux.kallsyms1", but the comments in link-vmlinux.sh say that
extra linker-generated symbols might appear, and I guess we probably
don't want to miss those...

