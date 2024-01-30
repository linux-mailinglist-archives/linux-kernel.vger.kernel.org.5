Return-Path: <linux-kernel+bounces-44891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 051CC842899
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74553B25EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA42D82D93;
	Tue, 30 Jan 2024 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en0V3sYq"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF885C5C;
	Tue, 30 Jan 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630463; cv=none; b=QYI31vxDIcOxOMJEHIU3cAY/E9BFzZhqlQsKygLWBqfm4OE6Kc03gRKiJOjjrrxK6IaSMbXep5JwpuZjDVdBWniVwMKw1pOhMtTJI/XGfk1HFecSO34oq8rsFgwikeqfLMWWhGhoUVGl0MRCDmWzxkWQ4S3RX75qbXSzi0XsBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630463; c=relaxed/simple;
	bh=psNUlzFWuQDc4vT0Ty8fJRic+D51qPm8Vrjk3S58n+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1j+JLAtBTWRLefmx7to+EqmUssZ/d1b58zwz+yq7OP0Z4MoydnnRwPqkTjLprFovPwcrbqxlT/MSiwFJ3Q+Fq31Bps1UsBnAkcQxoTl2Sbnu3jP7aqu6wwCF0A2LOvXiHiKDarN43+nG1Ydn1xkdXKvTAVDEfc3HTsff7N1p3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=en0V3sYq; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d317aafbd1so1651730241.2;
        Tue, 30 Jan 2024 08:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706630461; x=1707235261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8xU4bZ3PfIAed/M9W8X66NuCwYyPT1QQmLa1y80Xgc=;
        b=en0V3sYq70CZRKvKaMxj4utU2dCvIFtch0czgBZvT3m+gAgxQaewpX4OEEJxZDzV3y
         w/MjkfrsutEOI1UEqJjd5UHGuO8weoep3VMwTEFeoiRf4IzUzXOZtdzMgkdUm9GCoRtO
         PdX3axWZv/mrNxwxLA66fhlpUlb2roRVOu2pIeAsRVRnwKe4NU/Da+8MS5iwuiddd64R
         iEci5plcbm3adUU5TlJInIKPL2vjrSWWJoAe1W85PMN8SyFkO/XHzBoKk3YR/Qh2PyNs
         ElD7ZGW8ONGYYy299bzeIajEL9N2zZKCQ+uneBwc1Xr+uWTYWGWuyhhK4lGzO59H1P5/
         De4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630461; x=1707235261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8xU4bZ3PfIAed/M9W8X66NuCwYyPT1QQmLa1y80Xgc=;
        b=iLFbT4P6rE7bdw7afSFwOyLbz+2BzHyWFMw9AV6kk3aWecgyY9KWJ+HLAVUDZ06BRq
         9tSLCq+mjD4beh/VuCz/20r6yf3g+lIcEyUtaRLi6p4CM1N3o6/wruG9OwaoadEykvLa
         D+6KdZsEFdlNdKE6+HGid/8k9ELg/hH+oz4mFqkTGebQpkQCDtsiTdPH8OknOB2253/o
         SM8Db9ZgrZN2DQgwfekRs3HSZz7KBS7SY4Ct3qxH8i10fj9PbOn5L/oM3JU7v9TmX6rH
         MgZkptCaUwmhXxneDXXQ59m+RYpBbKaGa9rGasb539hlQbDop+PguJAwktRHflB1lydz
         0oJg==
X-Gm-Message-State: AOJu0YyzeYET8nLHm/YbX8Q1+r8xsCykvfVYREGKGGBCLJZZYMEg78IL
	ZIgpU1VMYt3YUTJDZdyjWc4iUcGNLG5KlD93LgFYmZYtUdPOX/FuSm7+EnZFEg5cpUNR44nppx9
	YNw4UICm/SoQBdpmIlXWJGeHE1T0=
X-Google-Smtp-Source: AGHT+IFxY/bjVN7x1nzWnlimAtCL47cP/CvQzpmRUgU9h7PfNyufHAQiBN6nyFGDIyEPsMFy8AJAN4wg/4Ve7rcZrUk=
X-Received: by 2002:a05:6122:4b1b:b0:4b6:c3ae:97f6 with SMTP id
 fc27-20020a0561224b1b00b004b6c3ae97f6mr4553861vkb.0.1706630460417; Tue, 30
 Jan 2024 08:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129151618.90922-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129-magical-unclaimed-e725e2491ccb@spud> <CAMuHMdVhXh_Cd8m00xfVRB9JA8Mfb9+qccu94iVpUMS2z5kmUQ@mail.gmail.com>
 <CA+V-a8v0tdr-xh__5rcK=xL-yYG1qLtSrAUjPcS_-ZVYy8p9pQ@mail.gmail.com> <CAMuHMdVu+VNW56VYkJs2w-S=1372_ZL6K2LQGKoR9vugpR+Z-w@mail.gmail.com>
In-Reply-To: <CAMuHMdVu+VNW56VYkJs2w-S=1372_ZL6K2LQGKoR9vugpR+Z-w@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 30 Jan 2024 16:00:29 +0000
Message-ID: <CA+V-a8vtqUP0M0A-UP1dXBb8Hwejyn39Ah_zd1bRKpEQreuLDw@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/Five SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Jan 30, 2024 at 1:06=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Jan 30, 2024 at 1:59=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, Jan 30, 2024 at 11:13=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, Jan 29, 2024 at 6:30=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > > On Mon, Jan 29, 2024 at 03:16:14PM +0000, Prabhakar wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on RZ=
/Five SoC
> > > > > is almost identical to one found on the RZ/G2L SoC with below dif=
ferences,
> > > > > * Additional BUS error interrupt
> > > > > * Additional ECCRAM error interrupt
> > > > > * Has additional mask control registers for NMI/IRQ/TINT
> > > > >
> > > > > Hence new compatible string "renesas,r9a07g043f-irqc" is added fo=
r RZ/Five
> > > > > SoC.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas=
com>
> > >
> > > > > --- a/Documentation/devicetree/bindings/interrupt-controller/rene=
sas,rzg2l-irqc.yaml
> > > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/rene=
sas,rzg2l-irqc.yaml
> > > > > @@ -134,6 +141,12 @@ properties:
> > > > >        - const: tint30
> > > > >        - const: tint31
> > > > >        - const: bus-err
> > > > > +      - const: eccram0-tie1
> > > > > +      - const: eccram0-tie2
> > > > > +      - const: eccram0-ovf
> > > > > +      - const: eccram1-tie1
> > > > > +      - const: eccram1-tie2
> > > > > +      - const: eccram1-ovf
> > >
> > > Why not use the naming from the docs (all 6 include "ti")?
> > > EC7TIE1_0, EC7TIE2_0, EC7TIOVF_0, EC7TIE1_1, EC7TIE2_1, EC7TIOVF_1
> > > =3D> ec7tie1-0, ec7tie2-0, ec7tiovf-0, ...?
> > >
> > Agreed.
> >
> > > > I think the restrictions already in the file become incorrect with =
this
> > > > patch:
> > > >   - if:
> > > >       properties:
> > > >         compatible:
> > > >           contains:
> > > >             enum:
> > > >               - renesas,r9a07g043u-irqc
> > > >               - renesas,r9a08g045-irqc
> > > >     then:
> > > >       properties:
> > > >         interrupts:
> > > >           minItems: 42
> > > >         interrupt-names:
> > > >           minItems: 42
> > > >       required:
> > > >         - interrupt-names
> > > >
> > > > This used to require all 42 interrupts for the two compatibles here
> > > > and at least the first 41 otherwise. Now you've increased the numbe=
r of
> > > > interrupts to 48 thereby removing the upper limits on the existing
> > > > devices.
> > >
> > > I'm gonna repeat (and extend) my question from [1]: How come we thoug=
ht
> > > RZ/G2L and RZ/V2L do not have the bus error and ECCRAM interrupts?
> > >
> > Hmm not sure how this was missed earlier.
> >
> > > Looks like most of the conditional handling can be removed (see below=
).
> > >
> > > > Given the commit message, I figure that providing 48 interrupts for
> > > > (at least some of) those devices would be incorrect?
> > >
> > > Looks like all of RZ/G2L{,C}, RZ/V2L, RZ/G2UL, and RZ/Five support
> > > all 48 interrupts.  RZ/G3S lacks the final three for ECCRAM1.
> > >
> > Agreed for RZ/G2L{,C}, RZ/V2L, RZ/G2UL, and RZ/Five, but for RZ/G3S it
> > becomes tricky the interrupts for ECCRAM0/1 are combined hence they
> > have just 3 interrupts. How do you propose the above interrupt naming?
>
> I guess it doesn't hurt to have an index 0 on a part that has only a
> single set?
>
Let's go with this option...

> Alternatives would be to
>   1. Drop the index completely on RZ/G3S, complicating bindings and
>      driver,
>   1. Drop the index for the first set, and use index 2 for the second set=
,
>      causing the names to differ even more on parts with 2 sets.
>
..instead of complicating.

Cheers,
Prabhakar

