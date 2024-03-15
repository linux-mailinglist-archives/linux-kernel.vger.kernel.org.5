Return-Path: <linux-kernel+bounces-104383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB3687CD13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73651C219EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C71C680;
	Fri, 15 Mar 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4FgGgfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1001C69D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504823; cv=none; b=Q2+XZZoVeLGr1MQT6MWy1VcfV507NiRpJx16S28yOZMg8MVY6oDZ4448SA98Sl7JXI0ZKXEKyIp1RwomBsAb8nRcE2f6mwNNrwT5a43maMiBYj3PMt+oSjrOA6l+ATaqfdd885w0s0CIzgvNUujhlUJ+IwtsRecc5Xb29kXm/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504823; c=relaxed/simple;
	bh=0Xts1YWMewo8r/sCZ48eoa+e7wWZz0fVFoU4An0cIIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw5juTavrk8iHbSRed3HIbEUCJwr942x+k6UfVjG4RDLznrc/XVmhqeAEdjY5DR8phZpAdrltkpCNGh8xLo7mzTg/vKTgW/7Oqz8ggtEjjC3qzPOiFqBCiaC/tt0B0t7FGMHylZUkCpwfhm7Y1kR1p2m0rXA8ejTM3EUNVN/GC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4FgGgfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC08C43394
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710504823;
	bh=0Xts1YWMewo8r/sCZ48eoa+e7wWZz0fVFoU4An0cIIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n4FgGgfIT47yYk2G2re8WWrpU16xwXJIcT+sEXSnZkAVkTjFEqyUVBUx01kJn4WiK
	 yynyugSH4WQNylmhd1K4Yq6Oxbg0/gvCcKoXt22lH+PpEzCwLSuhnGvDNOqMq2+0W7
	 o90/Hbm32bgJ4KOL6Ip1ekc1z71zEujCoF1tEGvoFNciaYTv0vfACzvQDX1xh0u9Sk
	 isKOft2VlgMEyITUG91KU7f2ePQTwpN1CFUNOSAF4hXbAdcJ0JfQeQ2r5hfnB1JL2q
	 RoRwzb2tlD4BlwQujUyJlNqhVajtfqqajS7JjBCjarjh3O/QTF1JtVIMsNKlB7ZSxA
	 UkvyRwMp6hZbg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5101cd91017so3224162e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:13:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoQlFnAFBqKRhelhGLsifaFTT43ALzJA710Qj4VC5H2FttyNdxCvaNHMderuGnazGapgYLEHA7+bOfQ29iyXtsmM7/7Ym4CPu9unpj
X-Gm-Message-State: AOJu0Yxt0YMPMTYIiazk5drAnqzvS+gApA/YisPgJZSAUlMNbQ/vQJ1l
	JxxBKo0Bqe2EdjjAXCjjUFc2BuqMy0u1x+yeeEqcrY2osc+cdHUQ14hctfSF37b66LJP7YHOUex
	bO3Olc2KVe0/sWSTFI8Sid/nNgcU=
X-Google-Smtp-Source: AGHT+IEJ0WpKTA7aOcY3lrlB4MIHfbaqAyQy58EJQlOcjn/Fv1+3BM2MnRyva21sr/4pPZ65dJWo7jfz0mMhg005RMg=
X-Received: by 2002:a05:6512:478:b0:513:dac5:ee22 with SMTP id
 x24-20020a056512047800b00513dac5ee22mr972160lfd.28.1710504821458; Fri, 15 Mar
 2024 05:13:41 -0700 (PDT)
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
 <baed1e49-d854-4517-8219-2a5bb0b3cd1b@huawei.com>
In-Reply-To: <baed1e49-d854-4517-8219-2a5bb0b3cd1b@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 13:13:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG5dHsdGn0_hSv2vPyMJbe1zOf4HLprLUSKJ+Dy2e_DzQ@mail.gmail.com>
Message-ID: <CAMj1kXG5dHsdGn0_hSv2vPyMJbe1zOf4HLprLUSKJ+Dy2e_DzQ@mail.gmail.com>
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

On Fri, 15 Mar 2024 at 13:10, liuyuntao (F) <liuyuntao12@huawei.com> wrote:
>
>
>
> On 2024/3/15 19:51, Arnd Bergmann wrote:
> > On Fri, Mar 15, 2024, at 12:48, liuyuntao (F) wrote:
> >> On 2024/3/15 18:46, Ard Biesheuvel wrote:
> >>> @@ -28,6 +28,7 @@
> >>>                                      -DEFI_HAVE_MEMCHR -DEFI_HAVE_STR=
RCHR \
> >>>                                      -DEFI_HAVE_STRCMP -fno-builtin -=
fpic \
> >>>                                      $(call cc-option,-mno-single-pic=
-base)
> >>> +cflags-$(CONFIG_ARM)           :=3D $(filter-out -fdata-sections, $(=
CFLAGS-y))
> >>>    cflags-$(CONFIG_RISCV)         +=3D -fpic -DNO_ALTERNATIVE -mno-re=
lax
> >>>    cflags-$(CONFIG_LOONGARCH)     +=3D -fpie
> >>
> >> Another error:
> >> cannot initialize array of =E2=80=98short unsigned int=E2=80=99 from a=
 string literal
> >> with type array of =E2=80=98unsigned int=E2=80=99
> >>    17 | static const efi_char16_t shim_MokSBState_name[] =3D L"MokSBSt=
ateRT";
> >
> > The line sets cflags-y to an empty string.
> >
> > It probably should have been
> >
> > cflags-$(CONFIG_ARM)           :=3D $(filter-out -fdata-sections, $(cfl=
ags-y))
> >
> > (small cflags instead of CFLAGS).
> >

Oops indeed.

> Oh, my mistake, after fixed this bug, still this error:
> > arm-linux-gnueabi-ld: warning: orphan section `.data.efi_loglevel' from=
 `drivers/firmware/efi/libstub/printk.stub.o' being placed in section `.dat=
a.efi_loglevel'
> > arm-linux-gnueabi-ld: warning: orphan section `.data.screen_info_guid' =
from `drivers/firmware/efi/libstub/screen_info.stub.o' being placed in sect=
ion `.data.screen_info_guid'
> > arm-linux-gnueabi-ld: warning: orphan section `.data.cpu_state_guid' fr=
om `drivers/firmware/efi/libstub/arm32-stub.stub.o' being placed in section=
 `.data.cpu_state_guid'
> > arm-linux-gnueabi-ld: warning: orphan section `.data.efi_nokaslr' from =
`drivers/firmware/efi/libstub/efi-stub-helper.stub.o' being placed in secti=
on `.data.efi_nokaslr'
>
> The -fdata-sections option is present in the KBUILD_CFLAGS_KERNEL
> variable; altering cflags-y only affect the KBUILD_CFLAGS variable.
> It seems that the -fdata-sections option needs to be removed from the
> KBUILD_CFLAGS_KERNEL variable.

Indeed.

So

KBUILD_CFLAGS_KERNEL :=3D $(filter-out -fdata-sections,$(KBUILD_CFLAGS_KERN=
EL))

(assuming I got it right this time without build testing)

