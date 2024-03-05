Return-Path: <linux-kernel+bounces-92330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A04871E95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60D91F254E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706975A11B;
	Tue,  5 Mar 2024 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="16TPWJKc"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E859B44
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640516; cv=none; b=twVhOfj/wCn0DNqm/crOh4Ri+ET4Sz/On8LywO0xwP8Idy50t+CrLDA6GhuPPelsAUxhoCG8xrGXz1+0Glq8dfg1CwMU1pYTe1pSrw939behOnroPn7f182XsBC3UytLI/i2Uoi+pnQz9HLHKZSI9vZNhakI0C3zSXa+b8mMbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640516; c=relaxed/simple;
	bh=HcK0l/BHXAgqHPymN9fB15z0EqjWog4wSbLUTN9ixjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT/C5sVJW0DgHm6U++S3xKzyNUtl1l6UBeh8kWeooA/JEd05QKT+y4jYlZ8i6EbndWYoEml2qNkkwCVrikfimXOKJYY1h/DT5SEeFla/frtYmpqOR9Wz41Pyk3U0GEUwPed5nUKH0kkQ4b6C5B3ZwimIS0ipE9SJmr1jmPRII6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=16TPWJKc; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7db1a2c1f96so2038285241.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 04:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709640514; x=1710245314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue0JJLooATJd4KIk6vsk/JW10lt7mv7VvgdOgn+vX8E=;
        b=16TPWJKcAuI0Abq7VndNv8Xa6dniCesiqzk26ySLiPFDzy5yfHmOFppQEgDbse/xzy
         UW/DqqqMIlMC7iUCAMFgxLBkRPBBMcRWhywIl70yoL3FcPIkSmnq4/vvsiUhxcXTbg2A
         T4qgI7XzuET+WmzPbl0IjYGKPtSMLPFOIH9t86ldrJpqQUifkMp7J/qrFSY1YGfBBkCf
         JZklGmuEpHRqbm9J0OTQDznqlQIObiuK7LpW15CohtN7yG7wbK6ym5DYhVjdrCsi1N+p
         ihluvnJBNippp2yZITtY2VnNCUeMSXkDebxCOChin8wLz0DICat/Tj09BKGrRHQLnV6i
         x26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640514; x=1710245314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue0JJLooATJd4KIk6vsk/JW10lt7mv7VvgdOgn+vX8E=;
        b=OXM7YfigG9zzDxzLLHdIDoQRBQ8a3HqiUOUMcf795ON0rnDcOECHwlzvYTCZWqiCuO
         l4PbehAJZXv0KD3okGOWUDdiizS0bh0bxV24HvQR6cZ0DulhCPCd94DtpPBuGsyGAJ1F
         ujVr1mP3daoJ4MaunOxNknyXPFQOTAV//nAbFs3pD2sh+A3NmjAuXZrkcHLAj/GR4X7o
         ip/kK+PsL/hpwScU00/gsUu02BNphFc5UXKYQCY/KeBR8ulpAtHc3qoheWEBdVBG+WeE
         4FNcJ/r9lECikrEEBG3RQIgvgv2xZN5kdUe0AtFK1GrAu+eLZjHa+9ByDDR5Y/c1ZZjt
         9FUg==
X-Forwarded-Encrypted: i=1; AJvYcCXZglN6W4eyd9i3hGOtccqVcf3ooi+t5SIoVyrd4Z7O7OINGO8jysAy9ZypwVAU+H0QHklXMLjrAzNsE9MDQvoElVBWniGPeonWghyg
X-Gm-Message-State: AOJu0YyRwUy9WHaRhPS7VYy879LSB1W6wh0hS9BYpcKrNwCl2+Arj7hZ
	FB3dH1aKmlCX9n3jZFBP0XVR+hGoTGHCkIKE4GQbPOaA0JctWZWOVjtzT8218Iwqvj/ssYwubvM
	eoLcW/poD7YeQxzAabg8S/Gtyl6mvTutTPBk0
X-Google-Smtp-Source: AGHT+IHbXJddAFtZgczMoWL38ASf21YaUKf6g2ubRMyi2RXEGet0mKq/ySvl6G/8eICpZnqJidkQWIm5ONtKFU97er4=
X-Received: by 2002:a05:6102:da:b0:470:576b:62f8 with SMTP id
 u26-20020a05610200da00b00470576b62f8mr1404722vsp.7.1709640513797; Tue, 05 Mar
 2024 04:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLgg0yGbuHnMbMB103Zssg4KSfXUR3kvhr0kuqTSah=6kWg@mail.gmail.com>
 <20240305112017.125061-1-kernel@valentinobst.de> <CAH5fLgis7Usg_cfWM5rBKjRKsB4857PkyuCMrCU6PmEqTOMFiw@mail.gmail.com>
 <CAH5fLgj=iuWNWy9jGvaD0SCcZg6GSj9XBgB0vZwL8EokobUPMg@mail.gmail.com>
In-Reply-To: <CAH5fLgj=iuWNWy9jGvaD0SCcZg6GSj9XBgB0vZwL8EokobUPMg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 5 Mar 2024 13:08:22 +0100
Message-ID: <CAH5fLggdR1UPNUa4R4CeJr+0cVRRr7cvyEQ3XhYaEqVD1cRtYA@mail.gmail.com>
Subject: Re: [PATCH] rust: add flags for shadow call stack sanitizer
To: Valentin Obst <kernel@valentinobst.de>
Cc: Jamie.Cunliffe@arm.com, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	ardb@kernel.org, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, broonie@kernel.org, catalin.marinas@arm.com, 
	gary@garyguo.net, keescook@chromium.org, linux-arm-kernel@lists.infradead.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, nicolas@fjasle.eu, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, samitolvanen@google.com, wedsonaf@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:31=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Tue, Mar 5, 2024 at 12:28=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Tue, Mar 5, 2024 at 12:20=E2=80=AFPM Valentin Obst <kernel@valentino=
bst.de> wrote:
> > >
> > > > >>> It's not 100% clear to me whether this patch is enough for full=
 SCS
> > > > >>> support in Rust. If there is some issue where this makes things=
 compile
> > > > >>> and work without actually applying SCS to the Rust code, please=
 let me
> > > > >>> know. Is there some way to verify that it is actually working?
> > > > >>
> > > > >> Perhaps you could write a Rust version of the CFI_BACKWARD test =
in LKDTM?
> > > > >>
> > > > >> Alternatively, the simplest way to verify this is to look at the
> > > > >> disassembly and verify that shadow stack instructions are emitte=
d to
> > > > >> Rust functions too. In case of dynamic SCS, you might need to du=
mp
> > > > >> function memory in a debugger to verify that PAC instructions we=
re
> > > > >> patched correctly. If they're not, the code will just quietly co=
ntinue
> > > > >> working without using shadow stacks.
> > > > >
> > > > > Was just in the process of doing that:
> > > > >
> > > > > - `paciasp`/`autiasp` pairs are emitted for functions in Rust mod=
ules.
> > > > > - Rust modules have no `.init.eh_frame` section, which implies th=
at
> > > > >   `module_finalize` is _not_ rewriting the pac insns when SCS is =
dynamic.
> > > > >   - Confirmed that behavior in the debugger (C modules and the C =
part of the
> > > > >     kernel are correctly rewritten, Rust modules execute with
> > > > >     `paciasp`/`autiasp` still in place).
> > > > > - Kernel boots just fine with Rust kunit tests, tested with and w=
ithout dynamic
> > > > >   SCS, i.e., on a CPU that supports PAC/BTI and one that does not=
.
> > > > > - Rust sample modules load and unload without problems as well.
> > > > > - `x18` is indeed not used in the codegen.
> > > > >
> > > > > I guess we might be able to get this working when we tweak the bu=
ild system
> > > > > to emit the missing section for Rust modules.
> > > >
> > > > I suppose the -Cforce-unwind-tables=3Dy flag will most likely do it=
.
> > >
> > > Yes, enabling this means that `.eh_frame` sections, which are convert=
ed to
> > > `.init.eh_frame` sections for loadable modules, are generated for Rus=
t
> > > objects.
> > >
> > > Tested booting, kunit tests, sample modules (as builtin and loadable)=
 for
> > > both, dynamic SCS active and inactive. Backtraces on Rust panicks als=
o look
> > > normal.
> > >
> > > Confirmed that in the debugger that builtin and external modules are
> > > rewritten (or not rewritten if no dynamic SCS). Did not check that th=
e
> > > `eh_frame` sections are exhaustive, i.e., cover all `paciasp`/`autias=
p`
> > > pairs, only verified a few functions (in init text and normal text).
> >
> > Thank you for checking that!
> >
> > > > There's also an use_sync_unwind option, but it defaults to no, so i=
t
> > > > doesn't seem like we need to set it.
> > >
> > > Are those defaults stable or will we notice if they change? If not it=
 might
> > > make sense to set it explicitly anyways to avoid surprises in the fut=
ure.
> >
> > The flag itself is unstable, so I imagine that nothing is promised abou=
t it.
> >
> > I tried it, but I wasn't actually able to find a way to set it. I can
> > see the flag in the rustc source code, but passing -Zuse-sync-unwind=3D=
n
> > results in "error: unknown unstable option: `use-sync-unwind`". Not
> > sure what the issue is.
>
> Oh, I understand now. It's really recent and not in 1.73.0, which is
> what I'm using in the Android build.

Sent v2 with what we have learned:
https://lore.kernel.org/rust-for-linux/20240305-shadow-call-stack-v2-1-c7b4=
a3f4d616@google.com/

Thanks!

