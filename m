Return-Path: <linux-kernel+bounces-119907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C39288CEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA80F1F33277
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543CB13DBA7;
	Tue, 26 Mar 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgwUbWwS"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF913DBA5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484722; cv=none; b=F35kdZvgHE0dWe0JmBs+ibMwlZgLbMPwJCjenJcuRKmAPyx2k7WxWnOxKnm9a344iUW1YMn/tWRxlFpF27zhakAaJr5rdorJVRnI18VrzES7vWHqTAQYZia5JXs7yMnD976hlrCWLbgXJFpWpeOeEMUpcPvnBumTL8FgUAY/TBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484722; c=relaxed/simple;
	bh=MEVM6KuktXIuyAG1KfiH2fzByR4I8+0IeY0y7RVjsUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFqkyzmEJktb6JCQNVg570hVgcoVKJSsTScz90uYKVoxGgY9wBTLG/WczyhliqILasD2m1HVcwOwgVdYN6IH/LJEwGB4T78vkJz0V9+bqNlAt4H+1UdU5CnaCsdzfaqqkXyMIcOuAymsPIiJcFHwBzlxAltFzwXWQW4Z5IjX+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgwUbWwS; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7e046990b6aso2160109241.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711484719; x=1712089519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lrTejwUO7gSf4EEEECNjtBUVn0RqW8Izhk85EDEe30=;
        b=QgwUbWwSIomRV2UdadPTmi4X9cbolj5+6gLMsV4TiWHmmuzdxAvBEVIYLQAOS+m6OO
         smKG8SH/wo76ffo1q2NnOteZbHdak59DvNhd+rLwaBYgiRUBwg/BIig4GPTVXz61/AUR
         GY+YA968WC6rcKgutEpqYp0tgLu03kSgFa68n+Bsc1XMLQbQ9rc0M2lscTpCkpYoEFIa
         eJYK6TYn/hW95db6VHhXfScnm1Az0SqOc5sXnRrmoDAyZjY0M5GHi4nLmf7bITyudRFF
         mWDetXKLFU//hS2XgQU7LyKZD4CGlNaWQLmHGo0d7ZpH1sRBL9G8J3TnOVOJ+bUBW89T
         305Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484719; x=1712089519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lrTejwUO7gSf4EEEECNjtBUVn0RqW8Izhk85EDEe30=;
        b=uvimrEk50NeBfqXwnFtauVOK4PKbJZvpREbx5+r2+G7aGxUbrBBQeAqNZry0hIRxI0
         iDLpca9bigZtjwJTGHgaIufR+MJPciC/uMydvyPjdP4/M6axPE3d9/VG/OiazZJnPLDf
         4r4c54CDG6joEaK4NxA2wJCaiyTzwFLoXfJ9F+WacWsViyS6E2CkCdX7hxVH7m+V4y6b
         YvP5x7BuZio69UqE6/O39zXjH0WFOBb3TUlOnteKXX01kAhRGmsBD9gBvitq/10QXcTR
         HQ2H4KoqpWttNpjKG60N1Jl2NeERoU9iGqliyMqk5qZDEitm/Vgbs32osJA5n3DILexr
         x5WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhCpIow0W4umoN+v51L79afzwBVuFAhn+28J24pnQXCswxkjML2q8s1njEXFdVcPW7F4fd8F9CY7YKXglib1jx/XKtDeYAWJUMUnsv
X-Gm-Message-State: AOJu0YyZHV3cCCnpA9AN84JCvMjeydvYFXVfBFcOjhCFy1iWEq0dj6jH
	8GqfVlQmqzhLI0EOU42fziwBnsj0MI+CoujC1jZg2eQCMMq2nG7w2O+v+8Z+KyLfHFTUXc1BEax
	WK0BnAwUFGba4/orejbqsX0oGuuk=
X-Google-Smtp-Source: AGHT+IGIHS+kBqSr20euVi3Yv8PWhLs+WmpCLWNT5DyowQ3IxTEGgzyjDhr+4ON8nLie8Gz5xQE5hNOKE/BqaIUONIQ=
X-Received: by 2002:a67:b602:0:b0:476:d9f2:f9aa with SMTP id
 d2-20020a67b602000000b00476d9f2f9aamr1057538vsm.0.1711484719349; Tue, 26 Mar
 2024 13:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49546e8-6749-4458-98da-67fd37b7df18@rivosinc.com>
 <mhng-a3b495e6-aca6-4137-a3c1-8fcacafd8596@palmer-ri-x1c9a>
 <ZfLxip96o5MVjHAF@xhacker> <ZfL1buKdDI-p5b9X@xhacker> <ZgGteKG_a3KGn5wV@xhacker>
In-Reply-To: <ZgGteKG_a3KGn5wV@xhacker>
From: Charles Lohr <lohr85@gmail.com>
Date: Tue, 26 Mar 2024 13:25:08 -0700
Message-ID: <CAGu26P_tUpSvXqdSz3pOdPNHbe6MyEYJ2XCHo8pD8jeE5pT+_Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, cleger@rivosinc.com, 
	Conor Dooley <conor@kernel.org>, samuel.holland@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com, dlemoal@kernel.org, 
	Bjorn Topel <bjorn@rivosinc.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jisheng, are you using musl or uclibc? I've been having difficulty
getting new versions of each working with the newer kernels with
system calls not lining up.

Also, is there a better place to ask questions about the more
user-spacy stuff?  That's really where I've been struggling to
maintain things, keeping buildroot working when targeting RV32 NOMMU.
Thankfully a lot of the stickiest problems have all been upstreamed.

Charles

On Mon, Mar 25, 2024 at 10:12=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org>=
 wrote:
>
> On Thu, Mar 14, 2024 at 09:02:43PM +0800, Jisheng Zhang wrote:
> > On Thu, Mar 14, 2024 at 08:46:21PM +0800, Jisheng Zhang wrote:
> > > On Tue, Feb 27, 2024 at 08:38:50AM -0800, Palmer Dabbelt wrote:
> > > > On Tue, 27 Feb 2024 01:11:41 PST (-0800), cleger@rivosinc.com wrote=
:
> > > > >
> > > > >
> > > > > On 26/02/2024 20:00, Charles Lohr wrote:
> > > > > > WOAH! Please DO NOT deprecate NOMMU. I use the NOMMU build cons=
tantly
> > > > > > and NOMMU Linux on RISC-V is the avenue used by many FPGA soft =
cores
> > > > > > for Linux, as well as some limited systems.
> > > >
> > > > OK.
> > > >
> > > > I just build test this stuff, as I don't really have a use for it
> > > > personally.  I figured if nobody's reporting bugs then probably it'=
s broken
> > > > and nobody's noticed because nobody's using it.
> > > >
> > > > > > I get new copies of the kernel when there are releases and test=
 them
> > > > > > frequently to make sure everything is still working as expected=
.
> > > >
> > > > I'd actually expected it to be broken, but I guess we managed to av=
oid
> > > > screwing things up ;)
> > > >
> > > > > > For us we just don't care about XIP. I mean if someone did push=
 it
> > >
> > > I don't care XIP either, and IMHO the XIP's maintenance effort is muc=
h
> > > bigger than NOMMU(just check the various XIP_FIXUP* or CONFIG_XIP_KER=
NEL
> > > macros around lowlevel pgtable.h, page.h). If we can remove XIP, the
> > > code readability will be much better.
> > >
> > > Or sending out a similar XIP deprecation patch to see whether there's
> > > any complain ? ;)
> > >
> > > > > > through to fruition, I'd also test and use it, but I urge you p=
lease
> > > > > > do not deprecate this.  While it's sometimes needed a bit of a
> > >
> > > +1 for urge the upstream please do not deprecate NOMMU.
> > >
> > > Besides the soft(FPGA) core mentioned by Charles, here is another rea=
l
> >
> > And I'd like to write more about soft core: riscv is a free and open
> > ISA, this make it really good for education, for simple riscv
> > implementation or emulator. Once riscv IMA is implemented(even if MMU,
> > cache, TLB stuff don't exist), it's not far away from making linux
> > running on the FPGA or emulator. If the gain is larger than the mainten=
ance
> > effort, I'd like to urge keeping the NOMMU support.
> >
> > Thanks a lot
> >
> > > usage case: As is known, Sophgo CV1800B platforms such as Milk Duo
> > > contains two C906 core, one(a.k.a big core) with MMU another(a.k.a sm=
all
> > > core)w/o MMU. The vendor sdk runs freertos on the small core, but it
> > > doesn't prevent users to run other OS such as threadx, zephyr or nomm=
u
> > > linux on the small core. In fact, I sucessfully brought up nommu linu=
x
> > > on the small core. I didn't just send out the patches in time during =
this
> > > dev window duo to my personal career reason(I spent the time on hunti=
ng
> > > for a new job)
> > >
> > > I plan to send out NOMMU related patches once 6.9-rc1 is out.
>
> As is promised, the NOMMU improvement patches are sent out
> https://lore.kernel.org/linux-riscv/20240325164021.3229-1-jszhang@kernel.=
org/T/#t
>
> Thanks
>
> > >
> > > > > > creative build to get everything working, I've never needed to =
patch
> > > > > > anything in the kernel beyond patching in a custom console for =
serial
> > > > > > output.
> > > > > >
> > > > >
> > > > > Hey Charles,
> > > > >
> > > > > No worries, we actually did not expected NOMMU to have *so many* =
users.
> > > > > I guess deprecating stuff is a good way to have immediate feedbac=
k ;).
> > > > > Having FDPIC psABI to be merged upstream could also probably be a
> > > > > positive point toward a better NOMMU support.
> > > >
> > > > Ya, that's probably the right way to do it.  Touching anything in t=
he psABI
> > > > is pretty miserable, though, so I don't really want to force people=
 to do
> > > > it...
> > > >
> > > > > > I am happy to discuss the possibility of me and or one of the o=
ther
> > > > > > RISC-V soft (FPGA) core people stepping up to try to be more ac=
tive,
> > > > > > but so far we've just been very well serviced by the current NO=
MMU
> > > > > > Linux setup.
> > > > >
> > > > > It could probably be nice to have some feedback/Tested-by: from N=
OMMU
> > > > > users for new releases then.
> > > >
> > > > Having more upstream interaction from users is always appreciated, =
that's
> > > > the best way to prove people are using the code.  If you guys have =
the time
> > > > it'd be great to get this into some sort of CI, ideally running on =
some real
> > > > platform.
> > >
> > > As above, I'd also like to step up on the NOMMU stuff, at least test
> > > nommu on milkv duo's small core. And can be seen from my git commit
> > > histotry, I was active, and I belive I will still be active on riscv =
linux
> > > kernel development.
> > >
> > > >
> > > > > Thanks,
> > > > >
> > > > > Cl=C3=A9ment
> > > > >
> > > > > >
> > > > > > Charles
> > > > > >
> > > > > >
> > > > > > On Mon, Feb 26, 2024 at 8:03=E2=80=AFAM Conor Dooley <conor@ker=
nel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 26, 2024 at 04:25:24PM +0100, Cl=C3=A9ment L=C3=
=A9ger wrote:
> > > > > > > > I guess I could also mark XIP as deprecated.
> > > > > > >
> > > > > > > I'm not so sure, people recently added XIP support to QEMU (a=
nd sent
> > > > > > > kernel fixes in December). XIP is also not nearly as much of =
a problem
> > > > > > > to support, there's far less that it does differently, the ma=
in barrier
> > > > > > > was the inability to test it which is no longer the case.
> > > > > > > That said, XIP is gonna kill itself off I feel as it does not=
 support
> > > > > > > runtime patching and therefore is extremely limited on extens=
ions, given
> > > > > > > we use alternatives for all of that (although I suppose if so=
meone has a
> > > > > > > usecase they could make nasty macros worse and implement a co=
mpiletime
> > > > > > > switch in the alternatives too).
> > > > > > >
> > > > > > > Cheers,
> > > > > > > Conor.
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > linux-riscv mailing list
> > > > > > > linux-riscv@lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv

