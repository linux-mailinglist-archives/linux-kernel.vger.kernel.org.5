Return-Path: <linux-kernel+bounces-48200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEEB84588D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695DF283C17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEFF53373;
	Thu,  1 Feb 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O716Seli"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA853366;
	Thu,  1 Feb 2024 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793036; cv=none; b=A0fSEbKF/185VaxGR50odD4Xrt2zDgqCDuuXRh5Oe1aCHNnsgvAt3eSX/FOOMwkIbF/I7ybXTfCSOjHvqQRylwtyKdspW62kuLip0KI+HiqLjn7LFnQ+rZoLH02NwLFaq2xutt9ftk6Z4nHp1WocGm6sRymPkoFV+/nRf1ZDvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793036; c=relaxed/simple;
	bh=ZJhq/a0ru1u/PCGz29gdCFIS3GlsWoUhfYVg1I8Q/fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KO31aksEIljf/SKSeFs3InZpaqpgY6SEj48pOzcJ2xgrlaLqBGY/8ZhjDmQR9q6mT3cWWZbHeAqWLbLbd+of2NGvmOZRIrnXJYSKUIA/XXJmEq/jjZ2c1TSnyr7Xy1vefS0SdwxzSRwdjUxvbg0F3/70m0NNqvdxTaJGscHUi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O716Seli; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d625a3ace6so316955241.0;
        Thu, 01 Feb 2024 05:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706793033; x=1707397833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwqkQIF71vpcy9N9j4GerjRpbbfKrzc/uUzrxwJJGYo=;
        b=O716Selih6X3rxS1os1aR88sizk+dZOd1kb3dWFnGusbk4gXW65m1MFB7nd0UVhUBq
         9Phlz5GEgD54uxyqfdRBij2uj9dAa3dwpK/mNGfZOoEUDJYNNN7hOC4xc0gphMfdCjbQ
         ZrwB7Pzfbaj3oHm7NsnIiG3qVbl7XofPTvaiJ3NCAZ2YDrZ+FpU4i/UptYUWe9OXxwYH
         czzTjtbTf40pGTajS/6rfHCnXCnSO3FcEyjG4J3fT8l/LYiuKGTSVR4IJhE8pXa8rPXd
         K3jaAEdVy7l4NdVkPakBjs1k3hDrZHblOT8yb+Qa8925R/En3PFz+ga3B5oMPXW7MJvt
         Bq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706793033; x=1707397833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwqkQIF71vpcy9N9j4GerjRpbbfKrzc/uUzrxwJJGYo=;
        b=vGDLpJTGagHst76adUXFULEmgFeR8lv4kRi0pzOMhSQ26DqQP4QuGPwmmQGHiLHwHG
         BDFTPklv6UXlsXvUS+1NdLHJFjXvCMvCSgFdZICTBr5q2WGqgJtySsID2MPCpBoiLRW6
         JwXBHjxEBuRYZ2LxF/DdEcXGVUDJ0wfKdEg5XWi9+Q+Ao2y96lBZWn4SfULUNOSrt+qm
         QmL4V0LKJBX1YYuyC6mrs7PaIMdJ5BCjMKd1zjq3h4Zi5Pzel6wagacGPNQg9RqyvFNO
         f4641KIwX4Wi9x+8ErHyqeO9phwI/0zZIjhfafwGM5GAupgiiyH6tBcyzgoSJgPvcSPq
         M3tg==
X-Gm-Message-State: AOJu0YymiH/ZbAqJiK5RSU4HhOKyrvG14NUft0q7+lbQVpIceX3BZYM2
	O2dWqpu5XhRnG4bjQx+Y+/OClvfz0el+YANqVem0A/Tz/LpiEKn1ldsf23MrliqoYpjYsy8gXwp
	RtMzgKrXQt5jB0xnB6mGMOR0MrSg=
X-Google-Smtp-Source: AGHT+IGsf+rRSEKnjNQAqd67Fb46xfvPvSc/YPD5cESPQuN63qNLUZEqMRkqhla21Oa+2++defXTos7E//YR0ZZoJDQ=
X-Received: by 2002:a05:6122:cb:b0:4b6:e3b6:41ea with SMTP id
 h11-20020a05612200cb00b004b6e3b641eamr2291081vkc.4.1706793033217; Thu, 01 Feb
 2024 05:10:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129151618.90922-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV=E5VDZn0QjiGQL73j135LiA1QNrYH-hCve1Yk0PqJ=A@mail.gmail.com>
In-Reply-To: <CAMuHMdV=E5VDZn0QjiGQL73j135LiA1QNrYH-hCve1Yk0PqJ=A@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 1 Feb 2024 13:09:58 +0000
Message-ID: <CA+V-a8tJfJTEOkSP-F1B3Q7EO6Cu9ij88ceGJcXCQjTFneWxUA@mail.gmail.com>
Subject: Re: [PATCH 3/5] riscv: dts: renesas: r9a07g043f: Add IRQC node to
 RZ/Five SoC DTSI
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Tue, Jan 30, 2024 at 11:25=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Jan 29, 2024 at 4:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add the IRQC node to RZ/Five (R9A07G043F) SoC DTSI.
>
> Thanks for your patch!
>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > --- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> > @@ -50,6 +50,82 @@ &soc {
> >         dma-noncoherent;
> >         interrupt-parent =3D <&plic>;
> >
> > +       irqc: interrupt-controller@110a0000 {
> > +               compatible =3D "renesas,r9a07g043f-irqc",
> > +                            "renesas,rzg2l-irqc";
> > +               reg =3D <0 0x110a0000 0 0x20000>;
> > +               #interrupt-cells =3D <2>;
> > +               #address-cells =3D <0>;
> > +               interrupt-controller;
> > +               interrupts =3D <SOC_PERIPHERAL_IRQ(0) IRQ_TYPE_LEVEL_HI=
GH>,
>
> As this is the RZ/Five-specific .dtsi file, and not the common base
> .dtsi, you could avoid using SOC_PERIPHERAL_IRQ() here.
> I am not sure what is most readable...
>
Ok, ill switch to the usual way here..

>+                            <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>=
,
In RZ/Five HW manual this is documented as LEVEL_HIGH and RZ/G2UL this
is documented as EDGE. I ve internally asked for clarification with
the HW team. If it's the same for both the SoCs I'll move this node to
common SoC dtsi and just update the compat string in rz/five specific
dtsi.

Cheers,
Prabhakar

> The rest LGTM (pending interrupt names review comments).
>
> Gr{oetje,eeting}s,
>
>                         Geert
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

