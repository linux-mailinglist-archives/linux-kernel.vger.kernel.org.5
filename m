Return-Path: <linux-kernel+bounces-81554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD4867772
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9386E2920DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5ED129A9E;
	Mon, 26 Feb 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc1OsdpK"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8B129A67;
	Mon, 26 Feb 2024 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956073; cv=none; b=ui8k1QZox5fNCplood7xtCEK/Sb2d0NeUamcfvwSV0U8RDnak3HeQe8XaghSzMaBMBi7CBPkrJA1IvYI/n7NVN8QnJCuBZdaPQxlqG+dY3etJeSKZPGRiPcA9SvPPWuJdywOgPyDnkbZBgGLJ/2K0T+6uZ6MvMkSpX/jx+hzRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956073; c=relaxed/simple;
	bh=FoewpGzgpzpqtpCSQxjM1rucew+UpAWVAiJKuK/PiHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPT5+/kPLM39KvZeOQ306qOphe9VRUehh7p06A6PnAbYDXhChUibu515+CCHbDXuePLELUBuXScsM9ie4oUSaysTO7OCBxKjMiasKjAIWEs7VYPj48MzADc6cBVlUDK0bD1kQ+AOgwXlmdddjyWsDIuIGcHm/4YSqzDS96WE+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc1OsdpK; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d5c40f874aso1573997241.1;
        Mon, 26 Feb 2024 06:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708956070; x=1709560870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNHascdJNtuHgIE/f0tSQFcH6XfYn7+0/LouiuRBLL0=;
        b=Wc1OsdpKZNQ6EI2Ywd7cE6zdAafTxPnA6aw60pF1QbsW/4n/vvgRL5YIgeH/PjVrOs
         hXhu14jcDPf8yOocNbeDdmwYENhuasxJFt/0PDMJB3m3shoI7vLKJ9CsiSVEzWr4i3x1
         2JTDFHoh/vhhTXNpGvr7466RKovpn8KkXqvqyllPI0HG29MURgKNu//n94FSTWPeU2KY
         Jh1/NR6NdSQei0/CBPdPJJ+vLMhwX9lQD44YXdTPWpH62Sm9/SqyFD+Ih9xzpLKeA/pf
         5ilMl5D+p0zF/tcqiu4K5FWr5jSQ8kaorq6eHTMEBqxPNooqiCeiiw26XKddoKzRRxwL
         O+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708956070; x=1709560870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNHascdJNtuHgIE/f0tSQFcH6XfYn7+0/LouiuRBLL0=;
        b=k2Gd4lG1sMHvbp/IGlduDUWsFnLztolrW3cBHLSQvNye9pQ5SIvu43+T3FdpeLFC6H
         PKHdS6fRIDlPsLtlUwCMNgze3OMvgPymKw0VUa/7a3KOjKkwWEFRj7D4Tvrk/6BcK2aW
         /JrQZdRemAcJq/65MiTDnkLghkPplCYw0zNgRt0008pC1RtTunkFiCIMtuh1R1RjDDsG
         LHlVdbontbqk+mxNXZAOF0zt0YxjhuN12XVyIc9hz6dLJiZwBjGlAc1TeFCF2hJTX+er
         EHpkUmr5TBrUkGoB4wCELqtMDV/YOOPvUqW4+DOYdLkkSQ2J+8MUUjxEpE9e6WqcaHcj
         VolA==
X-Forwarded-Encrypted: i=1; AJvYcCUMUX6BeFsh03WZiBqzSuwoRfRtaPR1XqBH8Lb6G3233uCROpEH0vwYkGopdYkeGJeSOUDgA0g0vEZKmKriF7YeJUBxosZxeBwWolgx2U7BxkZBvR2/5KTqsCxWsPT7a5pFlZITQywubSxO2c2hOuOSP6hVrA2CuUt+F/97d2cIhz0U/qxkJu4NMsjP
X-Gm-Message-State: AOJu0YyQzdqnU57MDFJIDfHWSmX8JJQ6UXfyCm8WD9wGvX5/GfQAASoc
	/wqIHgE0BKkemuAHvtC0BDvB8WLAAkxFdlcy3xKCjQcx2N5ZuSBnhxb+qOMNV8DC7PFJhZeZ1yb
	6ihrNrAVXSVK3EYI24olY82Cvm0o=
X-Google-Smtp-Source: AGHT+IFzGlajTJ0dQr/ulfhaP/pnvD18+/XO56PkQbq4WgzboYwXFG5wzAYu9pqj2gZw3MoGS/OIf67vmQoXxetqckk=
X-Received: by 2002:a1f:ed41:0:b0:4c0:1bb6:322 with SMTP id
 l62-20020a1fed41000000b004c01bb60322mr3287871vkh.15.1708956070413; Mon, 26
 Feb 2024 06:01:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240219160912.1206647-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdV3eVTek9sYwXbqu98ta8wx197GMc-k3q1RZRb8ar=jFg@mail.gmail.com>
In-Reply-To: <CAMuHMdV3eVTek9sYwXbqu98ta8wx197GMc-k3q1RZRb8ar=jFg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 26 Feb 2024 14:00:20 +0000
Message-ID: <CA+V-a8uNaRL7wE0SmwmiCq3o798-2Kd-fegKJ2Tep5mZuS2O2w@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: arm: renesas: Document Renesas RZ/V2H{P}
 System Controller
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

On Mon, Feb 26, 2024 at 1:41=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Mon, Feb 19, 2024 at 5:10=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add DT binding documentation for System Controller (SYS) found on
> > RZ/V2H{P} ("R9A09G057") SoC's.
>
> RZ/V2H(P)
>
> >
> > SYS block contains the SYS_LSI_DEVID register which can be used to
> > retrieve SoC version information.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-s=
ys.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/renesas/renesas,r9a09g057-sys.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/V2H{P} System Controller (SYS)
> > +
> > +maintainers:
> > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> > +
> > +description:
> > +  The RZ/V2H{P} SYS (System Controller) controls the overall
>
> RZ/V2H(P)
>
OK.

> > +  configuration of the LSI and supports the following functions,
> > +  - Trust zone control
> > +  - Extend access by specific masters to address beyond 4GB space
> > +  - GBETH configuration
> > +  - Control of settings and states of SRAM/PCIe/CM33/CA55/CR8/xSPI/ADC=
/TSU
> > +  - LSI version
> > +  - WDT stop control
> > +  - General registers
> > +
> > +properties:
> > +  compatible:
> > +    const: renesas,r9a09g057-sys
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Clock from external oscillator
>
> Isn't this SYS_0_PCLK inside the CPG?
>
As per the block diagram (figure 4.4-3), if we follow the clock source
for SYS it traces back to 24MHz Oscillator. Let me know how you want
me to describe this please.

> > +
> > +  resets:
> > +    items:
> > +      - description: SYS_0_PRESETN reset signal
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - resets
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    extal_clk: extal-clk {
> > +        compatible =3D "fixed-clock";
> > +        #clock-cells =3D <0>;
> > +        clock-frequency =3D <24000000>;
> > +    };
> > +
> > +    sys: system-controller@10430000 {
> > +        compatible =3D "renesas,r9a09g057-sys";
> > +        reg =3D <0x10430000 0x10000>;
> > +        clocks =3D <&extal_clk>;
>
> clocks =3D <&cpg 1>;
>
> (I guess it will be 1 ;-)
>
Yep indeed ;)

Cheers,
Prabhakar

> > +        resets =3D <&cpg 1>;
> > +    };
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

