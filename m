Return-Path: <linux-kernel+bounces-37635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE083B2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3DFB22388
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE9D133431;
	Wed, 24 Jan 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ5rCX0S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E137133402;
	Wed, 24 Jan 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127197; cv=none; b=fgDH0Ump01ZC/JCFr5so1ynlldC7j6udllhuf2i9jKVbhIYoqSTVPfcmM+WVCuh5OAY6ddGLIiSpGTxX7Xzzr/pA8m5DuFFB7QfApegauEj+W6jrQDKrFZrXLY+/D0aDajzZSxnWBjcVXYu/vTHROFYU14evJJaOjMsbbwntq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127197; c=relaxed/simple;
	bh=Twdinh4ZzSq2XBDa62Pj66mxim/LoN3y8w5gfBuM//c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ6XK6I/EBe2MGP9Er5bY52JLzlFkX6xCkvXdUVF1vFzIx3H7Cb0LOdY1UR9DRWAsWuJL+4oKPVPf/A4OOBZkyZDNRbvzUd0Ks1CSWDRCsXIORgoEhxsmt4POmKkverbFuJEROxTNDSbqlKe7VfXNBZTnA5Xu1qCNiWz/Yp8Xjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ5rCX0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FB2C43394;
	Wed, 24 Jan 2024 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706127196;
	bh=Twdinh4ZzSq2XBDa62Pj66mxim/LoN3y8w5gfBuM//c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kJ5rCX0SFT9rgDc/fP3b8dpnnHH0VuOjTzPSMKMqnrOlNp8Svp3qWxgijE5XF3Cri
	 z8/7E8RTzSiKdrS52Ywyr3Sdv4C5mw1eV0bqrumWoFLyU8AH0uTL3kWPHD5aJYxrrc
	 OdC35+REDjzsqWXWKk/DczEkXaUojRFZauhQ9iNyB7TFiPDG1Pzm0g1Fbd0ncZ4lmt
	 bzUczuvI8yxYRGgh7NkNvt1aIhEUcxTIlSvC/Mwxn7ztbmwDwSClwXkzvMzqV16nn5
	 +DojygSfXlbb/aEWLgiVbY598+ewOxE4Qgkakdd6uypraeDtIWGyXyGb/aYOFBfGAe
	 Kk+fPDRR6MGmw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-20536d5c5c7so3466274fac.2;
        Wed, 24 Jan 2024 12:13:16 -0800 (PST)
X-Gm-Message-State: AOJu0YxraSA+RKNnDfl6cQO1MrDvaX4gnOd1bCxzASU7b46j0W50MmGW
	tTINYi3emtZ1ZXdnurL/yahS2BkDWCynXAVp2sVu/zQF/KJvIYxO7K+b+Fw+25vaN2AkfilAOsQ
	VRvk9l+L20Hn3Z/GPN8pHqYP1kWI=
X-Google-Smtp-Source: AGHT+IEdps2ft5aE/ugUSRWkMkgV1cw5E4uPkw16thd98JKnWBTqC1wgkBic5LGkzeA378Bf6idLQALhkgUKuDDKxTE=
X-Received: by 2002:a05:6870:2008:b0:210:8b33:2c95 with SMTP id
 o8-20020a056870200800b002108b332c95mr3514557oab.108.1706127195872; Wed, 24
 Jan 2024 12:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125163559.824210-1-masahiroy@kernel.org> <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
 <d21298d9-fed6-4e08-9780-dbcb388b9ccc@smile.fr> <CAK7LNASaG4DpHTb3YHMd8d8DJ5H3z0aiUcSqX+=7CZb99kRU8A@mail.gmail.com>
 <b65a68eb-6b96-41ff-bbb9-38cb2dee940e@smile.fr>
In-Reply-To: <b65a68eb-6b96-41ff-bbb9-38cb2dee940e@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 25 Jan 2024 05:12:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARVbjVkP=v7uQDB=Z+Ntcy9MiFa6WowTX9mA47YjS3zTg@mail.gmail.com>
Message-ID: <CAK7LNARVbjVkP=v7uQDB=Z+Ntcy9MiFa6WowTX9mA47YjS3zTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: remove unneeded symbol_empty variable
To: Yoann Congal <yoann.congal@smile.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:56=E2=80=AFPM Yoann Congal <yoann.congal@smile.fr=
> wrote:
>
>
>
> Le 24/01/2024 =C3=A0 09:09, Masahiro Yamada a =C3=A9crit :
> > On Wed, Jan 24, 2024 at 12:11=E2=80=AFAM Yoann Congal <yoann.congal@smi=
le.fr> wrote:
> >>
> >> Le 23/01/2024 =C3=A0 13:54, Geert Uytterhoeven a =C3=A9crit :
> >>> Hi Yamada-san,
> >>
> >> Hello,
> >>
> >>> On Sat, Nov 25, 2023 at 5:36=E2=80=AFPM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> >>>> This is used only for initializing other variables.
> >>>>
> >>>> Use the empty string "".
> >>>>
> >>>> Please note newval.tri is unused for S_INT/HEX/STRING.
> >>>>
> >>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >>>
> >>> Thanks for your patch, which is now commit 4e244c10eab345a7
> >>> ("kconfig: remove unneeded symbol_empty variable") in v6.8-rc1.
> >>>
> >>> When running "make <foo>_defconfig" with <foo>_defconfig an SMP
> >>> defconfig without explicit configuration of CONFIG_LOG_CPU_MAX_BUF_SH=
IFT,
> >>> the aforementioned commit causes a change in the generated .config:
> >>>
> >>> -CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> >>> +CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> >>>
> >>> It looks like CONFIG_BASE_SMALL=3D0 is treated as a string instead of
> >>> the integer number zero?
> >>>
> >>> init/Kconfig=3Dconfig LOG_CPU_MAX_BUF_SHIFT
> >>> init/Kconfig-   int "CPU kernel log buffer size contribution (13 =3D>=
 8
> >>> KB, 17 =3D> 128KB)"
> >>> init/Kconfig-   depends on SMP
> >>> init/Kconfig-   range 0 21
> >>> init/Kconfig:   default 12 if !BASE_SMALL
> >>> init/Kconfig:   default 0 if BASE_SMALL
> >>>
> >>> Note that reverting 4e244c10eab345a7 is not sufficient to fix the iss=
ue.
> >>> Also reverting commit 6262afa10ef7cc8f ("kconfig: default to zero if
> >>> int/hex symbol lacks default property") does fix it.
> >>
> >> (Since I'd really like 6262afa10ef7cc8f ("kconfig: default to zero if =
int/hex symbol lacks default property") to stay, allow me to try to help)
> >>
> >> The problem is quite easy to reproduce:
> >>   $ make x86_64_defconfig
> >>   $ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
> >>   CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> >>   CONFIG_BASE_FULL=3Dy
> >>   CONFIG_BASE_SMALL=3D0
> >> Here, CONFIG_LOG_CPU_MAX_BUF_SHIFT should be 12 not 0.
> >
> >
> >
> > I could not produce it in this way.
> > I ran the same commands as yours.
> >
> > CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12 for me.
> >
> >
> >
> > masahiro@zoe:~/ref/linux(master)$ git describe
> > v6.8-rc1-29-g615d30064886
> > masahiro@zoe:~/ref/linux(master)$ git diff
> > masahiro@zoe:~/ref/linux(master)$ make  x86_64_defconfig
> > #
> > # No change to .config
> > #
>
> You already had a .config with the correct value of LOG_CPU_MAX_BUF_SHIFT=
 (Maybe?)
>
> > masahiro@zoe:~/ref/linux(master)$ grep
> > 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
> > CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> > CONFIG_BASE_FULL=3Dy
> > CONFIG_BASE_SMALL=3D0
>
> Try to remove the existing .config:
>
>    $ git describe
>   v6.8-rc1
>    $ git diff
>    $ rm .config -f
>    $ make  x86_64_defconfig
>   #
>   # configuration written to .config
>   #
>    $ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
>   CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
>   CONFIG_BASE_FULL=3Dy
>   CONFIG_BASE_SMALL=3D0
>
> >>
> >> For what it is worth, CONFIG_BASE_SMALL is defined as an int but is on=
ly used as a bool :
> >>    $ git grep BASE_SMALL
> >>   arch/x86/include/asm/mpspec.h:#if CONFIG_BASE_SMALL =3D=3D 0
> >>   drivers/tty/vt/vc_screen.c:#define CON_BUF_SIZE (CONFIG_BASE_SMALL ?=
 256 : PAGE_SIZE)
> >>   include/linux/threads.h:#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ?=
 0x1000 : 0x8000)
> >>   include/linux/threads.h:#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? P=
AGE_SIZE * 8 : \
> >>   include/linux/udp.h:#define UDP_HTABLE_SIZE_MIN         (CONFIG_BASE=
_SMALL ? 128 : 256)
> >>   include/linux/xarray.h:#define XA_CHUNK_SHIFT           (CONFIG_BASE=
_SMALL ? 4 : 6)
> >>   init/Kconfig:   default 12 if !BASE_SMALL
> >>   init/Kconfig:   default 0 if BASE_SMALL
> >>   init/Kconfig:config BASE_SMALL
> >>   kernel/futex/core.c:#if CONFIG_BASE_SMALL
> >>   kernel/user.c:#define UIDHASH_BITS      (CONFIG_BASE_SMALL ? 3 : 7)
> >>
> >> Maybe we should change CONFIG_BASE_SMALL to the bool type?
>
> My first test shows that switching CONFIG_BASE_SMALL to bool type does fi=
x the LOG_CPU_MAX_BUF_SHIFT default value.
>
> >> I'll poke around to see if I can understand why a int=3D"0" is true fo=
r kconfig.
>
> Here's what I understood:
> To get the default value of LOG_CPU_MAX_BUF_SHIFT, kconfig calls sym_get_=
default_prop(LOG_CPU_MAX_BUF_SHIFT)
> -> expr_calc_value("BASE_SMALL" as an expr)
> -> sym_calc_value(BASE_SMALL as a symbol) and returns sym->curr.tri
>
> But, if I understood correctly, sym_calc_value() does not set sym->curr.t=
ri in case of a int type config.


Right.

The following will restore the original behavior.


--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -349,12 +349,15 @@ void sym_calc_value(struct symbol *sym)
        switch (sym->type) {
        case S_INT:
                newval.val =3D "0";
+               newval.tri =3D no;
                break;
        case S_HEX:
                newval.val =3D "0x0";
+               newval.tri =3D no;
                break;
        case S_STRING:
                newval.val =3D "";
+               newval.tri =3D no;
                break;
        case S_BOOLEAN:
        case S_TRISTATE:





But, I do not think that is the right thing to do.


Presumably, turning CONFIG_BASE_SMALL is correct.





>
> Regards,
> --
> Yoann Congal
> Smile ECS - Tech Expert



--=20
Best Regards
Masahiro Yamada

