Return-Path: <linux-kernel+bounces-51619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89BD848D5B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790BD2825D9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543C422314;
	Sun,  4 Feb 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BW6p4JUK"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920322319
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048473; cv=none; b=Me+779FZ/HUPJkAqBUYfJo/zMCP09BcXgK76+YtK32JCnqAnpj2refuyE8bNM9241mLhqQ/clLTNyhLEGy6n56DJT3q6UT92gmEOe/oKY5pUSWJZeFBHnJ/GD7DIxQvK0GtsT8CJbK2tEJnk2xi/1BZjG0mvx5WMy3KQhOa/KIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048473; c=relaxed/simple;
	bh=gH0YOexU74969TTb6Ud/r+bxsDxSKYY6Gr8B0qkVmuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox7e3GjWof1LG5LSuAoWXA/txMfUcqKN1edPcu8PLJEbbp+A4GOYgbZ864spAXoZ3AdtyG7fA72wSFTq3FkREIGwohhiFCPSwtCk6gYz+YrYVhzU3tyHqLK0cKsKCTLvbGgcD/J2GvDw3jJ0DuKkKs5t1z6+3OvIrr59YPKy1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BW6p4JUK; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6869233d472so19393046d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 04:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707048469; x=1707653269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkBatnrVNJ4bM1n4KEdwNfQ5QXC1P1y/tW0B8XR/uz4=;
        b=BW6p4JUK3oI0dcRMwJsUGwq4OxnTX4WIuYGUue8zftnYhDKZksYxYw6uJPyRwzkBiO
         P5NLNGZAxjfGVV8WR4fJZ4W3CvIKERyoMOw9ZsR6WIUeJfLkq9cQfoeQ2sREU/PSrsgZ
         46EQtgXvNySdcboByEM29VvJvhpVDsbPLNjIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707048469; x=1707653269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkBatnrVNJ4bM1n4KEdwNfQ5QXC1P1y/tW0B8XR/uz4=;
        b=XR6g/+fy66niWT8tkw/HLUooippOHbNREUHA6AZb84C5ZXWqJmC3WyKgzSUC/e2Y8C
         4S4zSFjecY9PtUL1puj1AzlDmRkYMgVC94+aopojVd2jR5H8p88qSMg3DPwecyR7VFYn
         C8X75xLBGOzEwB3GTJ6q9LE4jbVlt7rRhWb3jtZVepgImhVTGq2URm7ETArpvdq+UXE1
         TRBe4UMVzW2uQ8M2ac4URqkzcECgqsNlQ98TAMR6r162FXf+cKj5pyj9Z1ebhOb3dljh
         i621ymxtgPOprN/J0t/kFR/bF5UY62iKLsALiFXEjGmScujLMonve3xBykX/U9JjAGRj
         NQRg==
X-Gm-Message-State: AOJu0YxglBJBHMU3HdMMjC3MrVzM/x6vqJeyh9IZEGttqitIOKO81/b3
	vkLcPURVmDKXE8/H1z2PeaP0IVNFK1oSTCHOtprqG9pqUoo5PshrCNq4ExK+VS0H2I7lpyaSpj2
	5h8ZCXTylUDmJ8AFUc/7gbiEtQWI5WmB9NKNm
X-Google-Smtp-Source: AGHT+IF8djEbUUZ1vMiKh3Q9Kt4JETg6OWQ/ChSwZjNA5IB/5h0hIaJU+P7YJgYYkYLpQ/EyD7NjClc7LDXpcSX+Qz8=
X-Received: by 2002:a0c:e441:0:b0:68c:9621:af25 with SMTP id
 d1-20020a0ce441000000b0068c9621af25mr2638553qvm.10.1707048469559; Sun, 04 Feb
 2024 04:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116172859.393744-1-sjg@chromium.org> <20231208150042.GA1278773-robh@kernel.org>
 <CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
 <CAL_Jsq+xMZ8yz4H9D59uCSyX4h5W+4ruGF++=wVA=msXz+Y01A@mail.gmail.com>
 <CAPnjgZ1uW8T6woXSqFUNm301=W3zBYOrADREkrz=DuwSW87qZg@mail.gmail.com>
 <20231214172702.GA617226-robh@kernel.org> <CAPnjgZ2oJSGPO91Y_aLbe+v250WFrND4n3T0mOvhERYidVu=eQ@mail.gmail.com>
 <CAFLszTizRRVbRO6_ygE2X-Lp5dENWSc4uMGL5GPJAFGAbRdCyQ@mail.gmail.com> <CAL_Jsq+j7_KZtQ2ENq9+vsw0LOZF=spu293_G=AxOmBM+m_f-g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+j7_KZtQ2ENq9+vsw0LOZF=spu293_G=AxOmBM+m_f-g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 4 Feb 2024 05:07:38 -0700
Message-ID: <CAFLszTimaFw9sf=JKvQXG4fS6V_2T=2n+pfvYLCiuG1o+7cHPA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
	Michael Walle <mwalle@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Wed, 17 Jan 2024 at 08:56, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jan 4, 2024 at 3:54=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Rob,
> >
> > On Thu, Dec 14, 2023 at 2:09=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Rob,
> > >
> > > On Thu, 14 Dec 2023 at 10:27, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Dec 08, 2023 at 03:58:10PM -0700, Simon Glass wrote:
> > > > > Hi Rob,
> > > > >
> > > > > On Fri, 8 Dec 2023 at 14:56, Rob Herring <robh@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Dec 8, 2023 at 11:47=E2=80=AFAM Simon Glass <sjg@chromi=
um.org> wrote:
> > > > > > >
> > > > > > > Hi Rob,
> > > > > > >
> > > > > > > On Fri, 8 Dec 2023 at 08:00, Rob Herring <robh@kernel.org> wr=
ote:
> > > > > > > >
> > > > > > > > On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass wrote=
:
> > > > > > > > > Add a compatible string for binman, so we can extend fixe=
d-partitions
> > > > > > > > > in various ways.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > (no changes since v5)
> > > > > > > > >
> > > > > > > > > Changes in v5:
> > > > > > > > > - Add #address/size-cells and parternProperties
> > > > > > > > > - Drop $ref to fixed-partitions.yaml
> > > > > > > > > - Drop 'select: false'
> > > > > > > > >
> > > > > > > > > Changes in v4:
> > > > > > > > > - Change subject line
> > > > > > > > >
> > > > > > > > > Changes in v3:
> > > > > > > > > - Drop fixed-partition additional compatible string
> > > > > > > > > - Drop fixed-partitions from the example
> > > > > > > > > - Mention use of compatible instead of label
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > > - Drop mention of 'enhanced features' in fixed-partitions=
yaml
> > > > > > > > > - Mention Binman input and output properties
> > > > > > > > > - Use plain partition@xxx for the node name
> > > > > > > > >
> > > > > > > > >  .../bindings/mtd/partitions/binman.yaml       | 68 +++++=
++++++++++++++
> > > > > > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > > > > > >  MAINTAINERS                                   |  5 ++
> > > > > > > > >  3 files changed, 74 insertions(+)
> > > > > > > > >  create mode 100644 Documentation/devicetree/bindings/mtd=
/partitions/binman.yaml
> > > > > > > > >
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/mtd/partit=
ions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.=
yaml
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..329217550a98
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/bi=
nman.yaml
> > > > > > > > > @@ -0,0 +1,68 @@
> > > > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > > > +# Copyright 2023 Google LLC
> > > > > > > > > +
> > > > > > > > > +%YAML 1.2
> > > > > > > > > +---
> > > > > > > > > +$id: http://devicetree.org/schemas/mtd/partitions/binman=
yaml#
> > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > > +
> > > > > > > > > +title: Binman firmware layout
> > > > > > > > > +
> > > > > > > > > +maintainers:
> > > > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > > > +
> > > > > > > > > +description: |
> > > > > > > > > +  The binman node provides a layout for firmware, used w=
hen packaging firmware
> > > > > > > > > +  from multiple projects. It is based on fixed-partition=
s, with some
> > > > > > > > > +  extensions, but uses 'compatible' to indicate the cont=
ents of the node, to
> > > > > > > > > +  avoid perturbing or confusing existing installations w=
hich use 'label' for a
> > > > > > > > > +  particular purpose.
> > > > > > > > > +
> > > > > > > > > +  Binman supports properties used as inputs to the firmw=
are-packaging process,
> > > > > > > > > +  such as those which control alignment of partitions. T=
his binding addresses
> > > > > > > > > +  these 'input' properties. For example, it is common fo=
r the 'reg' property
> > > > > > > > > +  (an 'output' property) to be set by Binman, based on t=
he alignment requested
> > > > > > > > > +  in the input.
> > > > > > > > > +
> > > > > > > > > +  Once processing is complete, input properties have mos=
tly served their
> > > > > > > > > +  purpose, at least until the firmware is repacked later=
, e.g. due to a
> > > > > > > > > +  firmware update. The 'fixed-partitions' binding should=
 provide enough
> > > > > > > > > +  information to read the firmware at runtime, including=
 decompression if
> > > > > > > > > +  needed.
> > > > > > > >
> > > > > > > > How is this going to work exactly? binman reads these nodes=
 and then
> > > > > > > > writes out 'fixed-partitions' nodes. But then you've lost t=
he binman
> > > > > > > > specifc parts needed for repacking.
> > > > > > >
> > > > > > > No, they are the same node. I do want the extra information t=
o stick
> > > > > > > around. So long as it is compatible with fixed-partition as w=
ell, this
> > > > > > > should work OK.
> > > > > >
> > > > > > How can it be both? The partitions node compatible can be eithe=
r
> > > > > > 'fixed-partitions' or 'binman'.
> > > > >
> > > > > Can we not allow it to be both? I have tried to adjust things in
> > > > > response to feedback but perhaps the feedback was leading me down=
 the
> > > > > wrong path?
> > > >
> > > > Sure, but then the schema has to and that means extending
> > > > fixed-partitions.
> > >
> > > Can we cross that bridge later? There might be resistance to it. I'm
> > > not sure. For now, perhaps just a binman compatible works well enough
> > > to make progress.
> >
> > Is there any way to make progress on this? I would like to have
> > software which doesn't understand the binman compatible to at least be
> > able to understand the fixed-partition compatible. Is that acceptable?
>
> There's only 2 ways that it can work. Either binman writes out
> fixed-partition nodes dropping/replacing anything only defined for
> binman or fixed-partition is extended to include what binman needs.

OK, then I suppose the best way is to add a new binman compatible, as
is done with this v6 series. People then need to choose it instead of
fixed-partition.

Should I resend this series, or is it OK as it is?

Regards,
Simon

