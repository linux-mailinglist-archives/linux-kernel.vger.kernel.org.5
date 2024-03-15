Return-Path: <linux-kernel+bounces-104409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3CB87CD66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4111C283E50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9417B24B26;
	Fri, 15 Mar 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKA1JLl0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB527249F1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710506794; cv=none; b=a1pUEXOhgNBnX2kRieUzRc1Zug8vzKn7LwfBUCV6MH1R2v6Bun/qwazQ+iUqsq33M4OF/BT3qOjmBYlGFzhN6ZDzc4xWLj9kToymqE08Vb8Pzzs0ygVqdBTkNDZzVIOvmS5eaAj7vxAhAhPO6SDM83/yeAv+piVrWHNt2XdB3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710506794; c=relaxed/simple;
	bh=rqJ7R+Y+vyOPWW6w+w+qtUwG6Z3ku9AaPwFrCMaepeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esXjf36tGqGFCPHpqQYKKLq9UyQ/bv2j6QqQNVLHwp+klpxxJ+4YBHj9JdOWoCYcyr/nG8ZeddLOataswOPNHJFNDTr/haVkwzWFaDs10tFUC7bnyYq1zPgAbszcGjIUKa75XtqemcZYtV5U6NcsUQWpjSj+AbvjsLcWm/6qD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKA1JLl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755DCC433A6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710506794;
	bh=rqJ7R+Y+vyOPWW6w+w+qtUwG6Z3ku9AaPwFrCMaepeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HKA1JLl04VtUAP/1tVF8Qc4hpR5Y7kfbOwaZrC8xXJxKecqkTQhV4zxyCT1KQG84A
	 w4lEvEOdlwcYw07i+idIKophhkjtgolOk+BRI1NBrsAeUeptVgVV+T6fG3rJ/N8UDM
	 HLsprVIafz1lEZb41bccrKhqtnue40urqVwL+LxBf3eAbekHaWZntbGvGbPR6n42Bc
	 8MSoK9JbWHfFm2GP+e7Jik13DPHKRX66DHAua8OjqPEr6NVCutpa77M51LbYW6rNx/
	 7szTUsP9r+FMw75iEnsXuXsq+G1O9eCk+MnUBgQO7Ypq89ft4OS2Q0Mb5GmSz8xwfH
	 n5aBdOxXr9SUw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513dc9d6938so304388e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:46:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuBY0SQg3Wifz7qNZYoJr+Q6/d6rCqf34mZzgXEuvu1hblJozy0xMF194X3oiRe9LsD+nyCKRk2h/eL1ad1S33LiI/rxj1MD75JJwF
X-Gm-Message-State: AOJu0YxXYJHzqocbyP1/XV4gSS/a/yykbJ0FK7OJjdy3LfnR+rwAag0P
	AHrAqX/Sj4cAhrSE29JwayCvKpfuAsyXXmWWqC4o1j8VZMXo2zeAUTyg8J4a63oZZaOCpD2/i0f
	iLbhjqbsBK/cH9LS6d/gIq+pS9zI=
X-Google-Smtp-Source: AGHT+IGwm2Cno8Abyhg4N1QEhRv2p0C+1OFErIatshAFb78bPTlhIJ8lgTvr1ldQFB6xIi3mv5opGP+k2I6SSGiE+b0=
X-Received: by 2002:a19:f50f:0:b0:513:ce42:e2d0 with SMTP id
 j15-20020a19f50f000000b00513ce42e2d0mr3114680lfb.46.1710506792718; Fri, 15
 Mar 2024 05:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315063154.696633-1-liuyuntao12@huawei.com>
 <CAMj1kXH+FaddHV5--kqB_wVgw_M682MvchPB1BoCuDuA6vVyvg@mail.gmail.com>
 <d7a1996f-f558-4cea-b8ca-eb071d02c6d4@huawei.com> <CAMj1kXHP-M7hTsCmorgzvDiPB1jRXHciJrXjJR82zmkxUTD-5Q@mail.gmail.com>
 <b3e3f664-f8ad-41d7-b8d5-3c83818ff489@huawei.com> <d91cf190-e583-422f-884d-79552b674f72@app.fastmail.com>
 <baed1e49-d854-4517-8219-2a5bb0b3cd1b@huawei.com> <CAMj1kXG5dHsdGn0_hSv2vPyMJbe1zOf4HLprLUSKJ+Dy2e_DzQ@mail.gmail.com>
 <31f3a3fe-b16f-47a9-8c41-80fc0a236d52@huawei.com>
In-Reply-To: <31f3a3fe-b16f-47a9-8c41-80fc0a236d52@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 13:46:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEgQLizmzUwvw79DQ9zkq2L5ed5576MzmYX6uHA5QUh1Q@mail.gmail.com>
Message-ID: <CAMj1kXEgQLizmzUwvw79DQ9zkq2L5ed5576MzmYX6uHA5QUh1Q@mail.gmail.com>
Subject: Re: [PATCH-next v3] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To: "liuyuntao (F)" <liuyuntao12@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Russell King <linux@armlinux.org.uk>, Andrew Davis <afd@ti.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, 
	Mike Rapoport <rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Mar 2024 at 13:22, liuyuntao (F) <liuyuntao12@huawei.com> wrote:
>
>
>
> On 2024/3/15 20:13, Ard Biesheuvel wrote:
> > On Fri, 15 Mar 2024 at 13:10, liuyuntao (F) <liuyuntao12@huawei.com> wr=
ote:
> >>
> >>
> >>
> >> On 2024/3/15 19:51, Arnd Bergmann wrote:
> >>> On Fri, Mar 15, 2024, at 12:48, liuyuntao (F) wrote:
> >>>> On 2024/3/15 18:46, Ard Biesheuvel wrote:
> >>>>> @@ -28,6 +28,7 @@
> >>>>>                                       -DEFI_HAVE_MEMCHR -DEFI_HAVE_=
STRRCHR \
> >>>>>                                       -DEFI_HAVE_STRCMP -fno-builti=
n -fpic \
> >>>>>                                       $(call cc-option,-mno-single-=
pic-base)
> >>>>> +cflags-$(CONFIG_ARM)           :=3D $(filter-out -fdata-sections, =
$(CFLAGS-y))
> >>>>>     cflags-$(CONFIG_RISCV)         +=3D -fpic -DNO_ALTERNATIVE -mno=
-relax
> >>>>>     cflags-$(CONFIG_LOONGARCH)     +=3D -fpie
> >>>>
> >>>> Another error:
> >>>> cannot initialize array of =E2=80=98short unsigned int=E2=80=99 from=
 a string literal
> >>>> with type array of =E2=80=98unsigned int=E2=80=99
> >>>>     17 | static const efi_char16_t shim_MokSBState_name[] =3D L"MokS=
BStateRT";
> >>>
> >>> The line sets cflags-y to an empty string.
> >>>
> >>> It probably should have been
> >>>
> >>> cflags-$(CONFIG_ARM)           :=3D $(filter-out -fdata-sections, $(c=
flags-y))
> >>>
> >>> (small cflags instead of CFLAGS).
> >>>
> >
> > Oops indeed.
> >
> >> Oh, my mistake, after fixed this bug, still this error:
> >>> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_loglevel' fr=
om `drivers/firmware/efi/libstub/printk.stub.o' being placed in section `.d=
ata.efi_loglevel'
> >>> arm-linux-gnueabi-ld: warning: orphan section `.data.screen_info_guid=
' from `drivers/firmware/efi/libstub/screen_info.stub.o' being placed in se=
ction `.data.screen_info_guid'
> >>> arm-linux-gnueabi-ld: warning: orphan section `.data.cpu_state_guid' =
from `drivers/firmware/efi/libstub/arm32-stub.stub.o' being placed in secti=
on `.data.cpu_state_guid'
> >>> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_nokaslr' fro=
m `drivers/firmware/efi/libstub/efi-stub-helper.stub.o' being placed in sec=
tion `.data.efi_nokaslr'
> >>
> >> The -fdata-sections option is present in the KBUILD_CFLAGS_KERNEL
> >> variable; altering cflags-y only affect the KBUILD_CFLAGS variable.
> >> It seems that the -fdata-sections option needs to be removed from the
> >> KBUILD_CFLAGS_KERNEL variable.
> >
> > Indeed.
> >
> > So
> >
> > KBUILD_CFLAGS_KERNEL :=3D $(filter-out -fdata-sections,$(KBUILD_CFLAGS_=
KERNEL))
> >
> > (assuming I got it right this time without build testing)
>
> Um, it not worked,too, same error.

Aren't you missing a 'L' ?

> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -28,6 +28,7 @@ cflags-$(CONFIG_ARM)          +=3D -DEFI_HAVE_STRLEN =
-DEFI_HAVE_STRNLEN \
> >                                    -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR=
 \
> >

> > ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> > KBUILD_CFLAGS_KERNEL +=3D -ffunction-sections -fdata-sections
> > KBUILD_RUSTFLAGS_KERNEL +=3D -Zfunction-sections=3Dy
> > LDFLAGS_vmlinux +=3D --gc-sections
> > endif
>
>                                   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
> >                                    $(call cc-option,-mno-single-pic-bas=
e)
> > +KBUILD_CFLAGS_KERNE            :=3D $(filter-out -fdata-sections, $(KB=
UILD_CFLAGS_KERNE))
> >  cflags-$(CONFIG_RISCV)         +=3D -fpic -DNO_ALTERNATIVE -mno-relax
> >  cflags-$(CONFIG_LOONGARCH)     +=3D -fpie
>
>

