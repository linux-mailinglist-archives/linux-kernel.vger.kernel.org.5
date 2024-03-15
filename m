Return-Path: <linux-kernel+bounces-104417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79B87CD7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC87B22B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667A424B59;
	Fri, 15 Mar 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGnb9Dl2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB03D76
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507507; cv=none; b=D5ooa45H4a99o22eIJv6QFl5Dq6nsCxdanYkCBZJvOtoI78tSjnTDqqK+kwwZqwflRWbQEtQWpdyO2xK49MdO92/nZOho4PYH9ASuoNmoXvleD5E2MCo3799vzFUYYQKPBn50knxN2M7O68Q1ndV1Qwm2WJ4Srr/H1Z/imENK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507507; c=relaxed/simple;
	bh=C2vEoYvN011MhOPBagv4C5BXsNtI5wIkZbggybmzWfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JM/t+M2RS2SbFr3h/KmyNhWxs5IF0IXB2COQ1E2QE1YMEinhlzoi+wZvigsLOhR6pScOxe/1Qw9QGQk+gl5m0HaQV483+l1PfL4OB48IIxrCyqkXnihqfsNGgIuGN6LRem0XBhqAfkuk/bpjYpLOQK+MfGCxKybOpcydwbY1QkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGnb9Dl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3A3C433A6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710507507;
	bh=C2vEoYvN011MhOPBagv4C5BXsNtI5wIkZbggybmzWfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jGnb9Dl2virvstLv1WXG9LtlGRLf52Ew4t+8pC8Yl9c4Skn+96pkBwprkAJoZ5XU8
	 DNaUyxUAqtej8feXhq4igqAM9i/Np17R4vRfsnS8o9PZdO6UitBE1oTQx67ZJx6L6p
	 eyvHMp03naqK21H8LO7ubu1yWpsCZT4wjt85FNvP7mWmkZT0dp75903892jgeWW57s
	 zh9+JIxtQr5gZHs75Az1AHSPC1jhwM9OYdvf3S5kojy6FjUhfbwp/p1aqjJ+zpBJKY
	 wnGQrpJs/TjqXXIDA/RZDz45g4LJ5UIF4YLHennDkpdk+G1Cos+gvWwcKff9gcjPt8
	 OKBA0fInLHgSA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d41f33eb05so23853841fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:58:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsF81iV6DkrZtJTkvXy8Mvyf/rnuqTMSHVW5XEiNAIAC10OBTh2ZT+oV1qtv/YBLPPc22CyJKFjHTZ4Do6RB2XiM9Jl4awqEhjdhDf
X-Gm-Message-State: AOJu0YwfDlQb5bDjThrPpJpuQu1K6mruT4ZTgOFsjP6aILhjmAlN2UZx
	ZXWLRO6v7JoLAgTOElIjmAuYnlbnvxIiEvev+EzlX3uSHTKLHUvGS/zuCCnIgAb6YAeYYYIZD2a
	cIhFDGlsUN7/Dtf36qf4kDpLi+uU=
X-Google-Smtp-Source: AGHT+IFw8iN4nvDV6DFBrUyR2BTVsoJn/hZ5zmEYzcOqUsowI2E6R1sdQfEcyOn03/PU8ZZunw+acUK9jWml/357ir8=
X-Received: by 2002:a2e:981a:0:b0:2d4:5850:28e8 with SMTP id
 a26-20020a2e981a000000b002d4585028e8mr2127655ljj.26.1710507505460; Fri, 15
 Mar 2024 05:58:25 -0700 (PDT)
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
 <31f3a3fe-b16f-47a9-8c41-80fc0a236d52@huawei.com> <CAMj1kXEgQLizmzUwvw79DQ9zkq2L5ed5576MzmYX6uHA5QUh1Q@mail.gmail.com>
 <dc3dad0c-d444-4ea0-8d6f-0a0d850d948d@huawei.com>
In-Reply-To: <dc3dad0c-d444-4ea0-8d6f-0a0d850d948d@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 13:58:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEkd-MAN8x88DPTnkZzojg8TRbTgzujO+DZCpo58mZxaA@mail.gmail.com>
Message-ID: <CAMj1kXEkd-MAN8x88DPTnkZzojg8TRbTgzujO+DZCpo58mZxaA@mail.gmail.com>
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

On Fri, 15 Mar 2024 at 13:52, liuyuntao (F) <liuyuntao12@huawei.com> wrote:
>
>
>
> On 2024/3/15 20:46, Ard Biesheuvel wrote:
> > On Fri, 15 Mar 2024 at 13:22, liuyuntao (F) <liuyuntao12@huawei.com> wr=
ote:
> >>
> >>
> >>
> >> On 2024/3/15 20:13, Ard Biesheuvel wrote:
> >>> On Fri, 15 Mar 2024 at 13:10, liuyuntao (F) <liuyuntao12@huawei.com> =
wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024/3/15 19:51, Arnd Bergmann wrote:
> >>>>> On Fri, Mar 15, 2024, at 12:48, liuyuntao (F) wrote:
> >>>>>> On 2024/3/15 18:46, Ard Biesheuvel wrote:
> >>>>>>> @@ -28,6 +28,7 @@
> >>>>>>>                                        -DEFI_HAVE_MEMCHR -DEFI_HA=
VE_STRRCHR \
> >>>>>>>                                        -DEFI_HAVE_STRCMP -fno-bui=
ltin -fpic \
> >>>>>>>                                        $(call cc-option,-mno-sing=
le-pic-base)
> >>>>>>> +cflags-$(CONFIG_ARM)           :=3D $(filter-out -fdata-sections=
, $(CFLAGS-y))
> >>>>>>>      cflags-$(CONFIG_RISCV)         +=3D -fpic -DNO_ALTERNATIVE -=
mno-relax
> >>>>>>>      cflags-$(CONFIG_LOONGARCH)     +=3D -fpie
> >>>>>>
> >>>>>> Another error:
> >>>>>> cannot initialize array of =E2=80=98short unsigned int=E2=80=99 fr=
om a string literal
> >>>>>> with type array of =E2=80=98unsigned int=E2=80=99
> >>>>>>      17 | static const efi_char16_t shim_MokSBState_name[] =3D L"M=
okSBStateRT";
> >>>>>
> >>>>> The line sets cflags-y to an empty string.
> >>>>>
> >>>>> It probably should have been
> >>>>>
> >>>>> cflags-$(CONFIG_ARM)           :=3D $(filter-out -fdata-sections, $=
(cflags-y))
> >>>>>
> >>>>> (small cflags instead of CFLAGS).
> >>>>>
> >>>
> >>> Oops indeed.
> >>>
> >>>> Oh, my mistake, after fixed this bug, still this error:
> >>>>> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_loglevel' =
from `drivers/firmware/efi/libstub/printk.stub.o' being placed in section `=
data.efi_loglevel'
> >>>>> arm-linux-gnueabi-ld: warning: orphan section `.data.screen_info_gu=
id' from `drivers/firmware/efi/libstub/screen_info.stub.o' being placed in =
section `.data.screen_info_guid'
> >>>>> arm-linux-gnueabi-ld: warning: orphan section `.data.cpu_state_guid=
' from `drivers/firmware/efi/libstub/arm32-stub.stub.o' being placed in sec=
tion `.data.cpu_state_guid'
> >>>>> arm-linux-gnueabi-ld: warning: orphan section `.data.efi_nokaslr' f=
rom `drivers/firmware/efi/libstub/efi-stub-helper.stub.o' being placed in s=
ection `.data.efi_nokaslr'
> >>>>
> >>>> The -fdata-sections option is present in the KBUILD_CFLAGS_KERNEL
> >>>> variable; altering cflags-y only affect the KBUILD_CFLAGS variable.
> >>>> It seems that the -fdata-sections option needs to be removed from th=
e
> >>>> KBUILD_CFLAGS_KERNEL variable.
> >>>
> >>> Indeed.
> >>>
> >>> So
> >>>
> >>> KBUILD_CFLAGS_KERNEL :=3D $(filter-out -fdata-sections,$(KBUILD_CFLAG=
S_KERNEL))
> >>>
> >>> (assuming I got it right this time without build testing)
> >>
> >> Um, it not worked,too, same error.
> >
> > Aren't you missing a 'L' ?
> >
> >>> --- a/drivers/firmware/efi/libstub/Makefile
> >>> +++ b/drivers/firmware/efi/libstub/Makefile
> >>> @@ -28,6 +28,7 @@ cflags-$(CONFIG_ARM)          +=3D -DEFI_HAVE_STRLE=
N -DEFI_HAVE_STRNLEN \
> >>>                                     -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRR=
CHR \
> >>>
> >
> >>> ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> >>> KBUILD_CFLAGS_KERNEL +=3D -ffunction-sections -fdata-sections
> >>> KBUILD_RUSTFLAGS_KERNEL +=3D -Zfunction-sections=3Dy
> >>> LDFLAGS_vmlinux +=3D --gc-sections
> >>> endif
> >>
> >>                                    -DEFI_HAVE_STRCMP -fno-builtin -fpi=
c \
> >>>                                     $(call cc-option,-mno-single-pic-=
base)
> >>> +KBUILD_CFLAGS_KERNE            :=3D $(filter-out -fdata-sections, $(=
KBUILD_CFLAGS_KERNE))
> >>>   cflags-$(CONFIG_RISCV)         +=3D -fpic -DNO_ALTERNATIVE -mno-rel=
ax
> >>>   cflags-$(CONFIG_LOONGARCH)     +=3D -fpie
> >>
> >>
> Sorry, I was too careless.
> How about reset KBUILD_CFLAGS_KERNEL?
>

No, that is not the solution.

Either avoid setting -fdata-sections altogether, or filter it out.


> > +# KBUILD_CFLAGS_KERNEL is is set by CONFIG_LD_DEAD_CODE_DATA_ELIMINATI=
ON,
> > +# not need here, just reset it.
> > +KBUILD_CFLAGS_KERNEL :=3D
> > +
> >  # non-x86 reuses KBUILD_CFLAGS, x86 does not
> >  cflags-y                       :=3D $(KBUILD_CFLAGS)
>

