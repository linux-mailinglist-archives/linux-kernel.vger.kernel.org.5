Return-Path: <linux-kernel+bounces-112594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDAC887BC7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F51C20AFD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32E14012;
	Sun, 24 Mar 2024 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2PEyyg1"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AE1A38FF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711259050; cv=none; b=O2bVD49o7UXDnMdhwDMVuA8nuHKgL0D7EsEERG7/Ux16htHR/rvTa/d037sojWDUXgZB0ZsBL7EEenT5siwGlg68mWPQXN4xEQJHYTq7njSir9ReW6Jfgl+oArMNJRby4NWJzCxFo2ky8MDa9rRjaXSUfPeeSIDQx2ErOj0kHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711259050; c=relaxed/simple;
	bh=LdjO/QYrhKr81Llv0MVW7fpPVq4jZelsRbEppyAP1tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goiPrhoBNoFKFc7EEFbYZTa4n6rkc/cHN+QomiW9QID3m0VdR8QnGJcxGmSrivPPWz0pS5OoeeVzJTuBhWyCSqN7Phc8KX10jSO+EaVXFRhqQWuv/kK2aGmmgjkDLOVBNnZsNoym25UKioGcqWkqRFSm6UKwYfsw95Qv2xPNYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2PEyyg1; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso56730991fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711259047; x=1711863847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2dDY0p618pqyS1EUCvDFefCsVtBhB9nXq24B4ycSUs=;
        b=S2PEyyg17VAEoXBUQaYpKsUYClypReBVzhXejNuoVj7WaZA/lb0hcwIZ5pPXhA+TP7
         3wktSJguNVKQbbc9pFxJRGtWEw93v8u4E3m8JRbkppgysVfbu0Py+Nq9nI+qTiIqUs3U
         0+SOP4B+cg9usJCXlWxQ/7AhZBF3/qkNDLc4IzvTDI5i9dCPUN+PlXkeBn9Aoz3C6n78
         P2oflhb0uZEtnpngZdMb7u2PnVcbrkUDDzYnk+f1iLcNJxLhHPYs0W7Y46OGNjtmt3XL
         tHwEsTBt4NfTf9b1CcEiXzR8A+5zxrWokpeU7ncdAz5/ix1UZC7p5fXSwGmKGtnOKcgb
         OqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711259047; x=1711863847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2dDY0p618pqyS1EUCvDFefCsVtBhB9nXq24B4ycSUs=;
        b=BNQ1zBpZCm0K3u7PHFVZuP7bIGQj8MXF1FqG73ZdZbME9MMd59wRwghsyfYwCKuRLF
         zIUZnFDd5D0KMqHvr/3M15SBQrvZNbaYV4a0UeGQ6hF1gtuBhPlJaeJVFFPiap9PkXUk
         P9LyN7gJP6WOJ0OqYDqqPsadNuzayIgIr7PQ6NISM7RtEBqYlNkh2Kf+UXk8jWExEIHv
         kr0yiM590mL++RPrlJpn4m3cCkPgpbq60PyGNTu4k2ia9QbMGB4gf0vxDA6cUXtr38cK
         t/BZzD/Je8eBjGCLtM5YbiUBri8XabGBRQL2jwF+tTvDQAnudZ/qTwK9kTWrxO46KGO9
         gNiw==
X-Forwarded-Encrypted: i=1; AJvYcCXrax7TI3yPv1ljCHwUoqvZIzVsskoslbCNIfE4iG4Jz7dR788g0tpKshKpyCaV5vV7d24w/iAbwiAseGYkhlABjxptuT7CEMQ8RmJt
X-Gm-Message-State: AOJu0Yz3HQmmWamzzFoKjpgItibvNEZFykwbfFNyzn+v5zcvh0UEOz8p
	uXRwH90qgcF6KQ8MFfVsI/LjTHYYgpynQVlMxxXz1ZSdUJSVMy/6axNRc3WHWYpd0P8BtINTcE8
	h/bu88EiJ+oKt/TS03bRrjLpSkg==
X-Google-Smtp-Source: AGHT+IGzC/9x0mJCIBN7WFQPxP2BJMGSDq9vBZ+aqI9LB1nghL9hQCsxDlrP2xgVqep1X3f6PcSgKqiPzPuoo73kGIo=
X-Received: by 2002:a05:6512:e93:b0:515:a257:cbd with SMTP id
 bi19-20020a0565120e9300b00515a2570cbdmr2497707lfb.24.1711259046395; Sat, 23
 Mar 2024 22:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <Zf+PIYP4TyF6ZRVy@gmail.com> <CAMzpN2htOit94c-M+zHqEcLcGPOU2zTS6wM-r7xWwd9Ku8h3-Q@mail.gmail.com>
 <Zf+mjy49dG5ly9ka@gmail.com>
In-Reply-To: <Zf+mjy49dG5ly9ka@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sun, 24 Mar 2024 01:43:55 -0400
Message-ID: <CAMzpN2go9mmyWRb9vsg7O1aAtSKrW=HqcZYmddkq7eZQQHuM1Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, 
	David.Laight@aculab.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 12:05=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > On Sat, Mar 23, 2024 at 10:25=E2=80=AFPM Ingo Molnar <mingo@kernel.org>=
 wrote:
> > >
> > >
> > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > On Fri, Mar 22, 2024 at 5:52=E2=80=AFPM Brian Gerst <brgerst@gmail.=
com> wrote:
> > > > >
> > > > > Currently, x86-64 uses an unusual percpu layout, where the percpu=
 section
> > > > > is linked at absolute address 0.  The reason behind this is that =
older GCC
> > > > > versions placed the stack protector (if enabled) at a fixed offse=
t from the
> > > > > GS segment base.  Since the GS segement is also used for percpu v=
ariables,
> > > > > this forced the current layout.
> > > > >
> > > > > GCC since version 8.1 supports a configurable location for the st=
ack
> > > > > protector value, which allows removal of the restriction on how t=
he percpu
> > > > > section is linked.  This allows the percpu section to be linked n=
ormally,
> > > > > like other architectures.  In turn, this allows removal of code t=
hat was
> > > > > needed to support the zero-based percpu section.
> > > >
> > > > The number of simplifications throughout the code, enabled by this
> > > > patch set, is really impressive, and it reflects the number of
> > > > workarounds to enable the feature that was originally not designed =
for
> > > > the kernel usage. As noted above, this issue was recognized in the =
GCC
> > > > compiler and the stack protector support was generalized by adding
> > > > configurable location for the stack protector value [1,2].
> > > >
> > > > The improved stack protector support was implemented in gcc-8.1,
> > > > released on May 2, 2018, when linux 4.17 was in development. In lig=
ht
> > > > of this fact, and 5 (soon 6) GCC major releases later, I'd like to =
ask
> > > > if the objtool support to fixup earlier compilers is really necessa=
ry.
> > > > Please note that years ago x86_32 simply dropped stack protector
> > > > support with earlier compilers and IMO, we should follow this examp=
le
> > > > also with x86_64, because:
> > >
> > > Ack on raising the minimum version requirement for x86-64
> > > stackprotector to 8.1 or so - this causes no real pain on the distro
> > > side: when *this* new kernel of ours is picked by a distro, it almost
> > > always goes hand in hand with a compiler version upgrade.
> > >
> > > We should be careful with fixes marked for -stable backport, but othe=
r
> > > than that, new improvements like Brian's series are a fair game to
> > > tweak compiler version requirements.
> > >
> > > But please emit a (single) prominent build-time warning if a feature =
is
> > > disabled though, even if there are no functional side-effects, such a=
s
> > > for hardening features.
> >
> > Disabled for any reason or only if the compiler lacks support?
>
> Only if the user desires to have it enabled, but it's not possible due
> to compiler (or other build environment) reasons. Ie. if something
> unexpected happens from the user's perspective.
>
> The .config option is preserved even if the compiler doesn't support
> it, right?
>
> I suspect this should also cover features that get select-ed by a
> feature that the user enables. (Not sure about architecture level
> select-ed options.)
>
> Thanks,
>
>         Ingo

I could add something like:

comment "Stack protector is not supported by the architecture or compiler"
       depends on !HAVE_STACKPROTECTOR

But, "make oldconfig" will still silently disable stack protector if
the compiler doesn't support the new options.  It does put the comment
into the .config file though, so that may be enough.

Brian Gerst

