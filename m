Return-Path: <linux-kernel+bounces-81555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8C1867778
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3400D292798
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C3F129A90;
	Mon, 26 Feb 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UESxDFN2"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFFE1292D2;
	Mon, 26 Feb 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956130; cv=none; b=d1dXXqBZyeXBFcz9+mNH6zSWk3wTX4CBSIdtDZCKJQ3sC0QKbQ3lCECiGN+L5Htr1jMIX0/gnqWmcqVO7J+NvQxlsqAaDE0wuoIPWYHu/o/RT/pENsQE4CpTOzlqclPzSi3zpF1mXmYYMhVNM3NUb4BvQC6M+RPIbB53IgaLkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956130; c=relaxed/simple;
	bh=OMB7dZq6cPa5qQ4YdCKTe3uzrqL9kMMlODdKMhKINfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYihcIGmO9UngfMggihcyuU2jiDnahTM5MMVsaDMIQM9N4a32abLE7MGYk/uYz3i1KtoORSfKh2cZR9IZJdSpov6eUkhLrzWnVsnoIL/mPpKdyuxBdTlmZ7mp1lKs7P5Mz44d+i95kjkJnzPyNxxNGnQbO7sOj3KhykpXmKvIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UESxDFN2; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-787be5d999aso218520385a.1;
        Mon, 26 Feb 2024 06:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708956128; x=1709560928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkHIa4NTuFZ4uyfsALAZFpoXtdVoaK/9XR+HrylrmQ0=;
        b=UESxDFN2OB06oSqgF5ywERwja1W61du5CKJgEVY0uPePg1gE4dQHMm25W7K+OryXUf
         w9/+iKOS1AfH2UpM4/tgiJmUhW7pug62Wt/ZyQse3av+WOmKk//HmxnHz7fPn2WnqAHt
         FhLDgF3XfqaHe5Pdo2wZy/SU/xiv8tAcTdKbdJwVS2hZ1nQ8DbvhZ99tCLJyItgxs48u
         gRixpo2BjAmuHbczBKrOXeePclj3KqxBJf4B+uAivxiOgf3GCO2YBqqQFVjWkupKApz7
         hJg24Yj8GR4MmW31beE2GIeS/+2oiLvNBtoq2tFOdAmBL7+d/b7Szqyut/WWX2cMRvRh
         GLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708956128; x=1709560928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkHIa4NTuFZ4uyfsALAZFpoXtdVoaK/9XR+HrylrmQ0=;
        b=phg+75jqZ+fspQbv8Ya61gjWbqY814R4Tzv9EawvAwCGsyXCtWvAGzCbn9QMmgESZt
         lUPr9WYQ9o66ajYwIXwrDmLsDGSAxg8Ckldzokta3/HAq6kXextd4v8Y8FHOTWvjY1l/
         HaimBBh5b93RRrqFVJNsOi32FT2ff2aC4dPHNfTYl4dhPrhfyPX9RUPrqktnb/4jtzJM
         i2UcOXKprGpVa0Wo71CaycO5hJw8aJCtp3XtX9GVwZqzPYFlbODcJ9gdZyxSq4hoGQQG
         y7Nh3rn1ES5zzorT7TdoRWc6fg0HaHpoyUvsytobK53MDSDSAok0dHaN+/i6uRw1mG0g
         kOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm+9pVYtRUst6BRKU7rKdF4kqV7DnI//EYJfUbhnh307VMMo4q2ZFZ4QcNwHevSR9EIEUqa4oqynZb+v+1XQciQ/PAMk1NGpsbNGwcFQ0ONAK4MX3g68DYJnIrGsSuVHZWKA5PmetULzx/Xf1giCNyoCConEFy5pyrl64dOhEKd27h9ow018FdFmZn
X-Gm-Message-State: AOJu0Yws3FhnSG/nHoxss3jDBz0KG6+fMCMywtzm74db/PbbLJASLiSn
	JTxcySLUn1J8yF4X7u5NEktfSWC5svqLGMs3hoy56Gom6B/XEl3BCm1fRQ7LVBmzCt9H+SmhOFB
	N05RFv5kM4/3A5AZPGUUrWW6k+co=
X-Google-Smtp-Source: AGHT+IFZ4zWTwbiN2ySv4y28Cs5SfSDLpUGukBL/L0bkeAf6/ClmYQ8afbkSogS3IYG+IuGJXwFD28wMdpnA8JpxcLI=
X-Received: by 2002:a05:620a:4092:b0:787:a0d2:460e with SMTP id
 f18-20020a05620a409200b00787a0d2460emr9959859qko.35.1708956128264; Mon, 26
 Feb 2024 06:02:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240219160912.1206647-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVVUpq3+O298s=2V95T5Ub4MgM9kj=mQ-fHL8KUgD0Uug@mail.gmail.com>
In-Reply-To: <CAMuHMdVVUpq3+O298s=2V95T5Ub4MgM9kj=mQ-fHL8KUgD0Uug@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 26 Feb 2024 14:01:18 +0000
Message-ID: <CA+V-a8txfk42fu+crxetA6vP+45N69F0JovzJ7Je+kqLZkcyaw@mail.gmail.com>
Subject: Re: [PATCH 3/4] soc: renesas: Add identification support for RZ/V2H SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Mon, Feb 26, 2024 at 1:43=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Feb 19, 2024 at 5:10=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Add support to identify the RZ/V2H (R9A09G057) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/soc/renesas/Kconfig
> > +++ b/drivers/soc/renesas/Kconfig
> > @@ -344,6 +344,11 @@ config ARCH_R9A09G011
> >         help
> >           This enables support for the Renesas RZ/V2M SoC.
> >
> > +config ARCH_R9A09G057
> > +       bool "ARM64 Platform support for RZ/V2H{P}"
> > +       help
> > +         This enables support for the Renesas RZ/V2H{P} SoC variants.
>
> "RZ/V2H(P)" (everywhere).
>
OK.

> > +
> >  endif # ARM64
>
> > --- a/drivers/soc/renesas/renesas-soc.c
> > +++ b/drivers/soc/renesas/renesas-soc.c
>
> > @@ -177,6 +181,11 @@ static const struct renesas_soc soc_rz_g3s __initc=
onst __maybe_unused =3D {
> >         .id     =3D 0x85e0447,
> >  };
> >
> > +static const struct renesas_soc soc_rz_v2h __initconst __maybe_unused =
=3D {
> > +       .family =3D &fam_rzv2h,
> > +       .id     =3D 0x847A447,
>
> Lower case hex please.
>
sure, I will update this in v2.

Cheers,
Prabhakar

> > +};
>
> The rest LGTM.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

