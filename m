Return-Path: <linux-kernel+bounces-29178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECC5830A22
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8216A2876E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2A422301;
	Wed, 17 Jan 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRiBZ2Es"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3820307;
	Wed, 17 Jan 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506997; cv=none; b=Z4mWQswt3DxQo1JN5c0aQMDMqT7j+vL4vIU2DT+iF5MARLlTpILb3Zd6V+npXipks6Q4fuK52qtOtdIWH/bJTHL3vVN84xVeZiLrj6CGOTDFEXd1mxMjifXpSaTrkTjZqXEW/uYgqH4Y8WkVNUS5hAcNjuJAenShfbAk3ic0gUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506997; c=relaxed/simple;
	bh=ptXYt1hCdovZz/ffSWT9gyAHt7rRwgYj2ew+MlFtyNY=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=sVnndRH+Hq+Ry+Rox91iKmcIBCOwK6TRiGM7xKjXq/H9lCS0EV/b9g9+EO4/iNnzG4G5q0SxyYMSpxFuC3nwTxNSk9Hu8YbZHdRYne7Eqh9oLYSfHQt7FidAEhG2xnt8j4Vrmxyv9G4fu3ZxZa4IE5tQNxfS11QnSLFrqVUcRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRiBZ2Es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650B9C43601;
	Wed, 17 Jan 2024 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705506997;
	bh=ptXYt1hCdovZz/ffSWT9gyAHt7rRwgYj2ew+MlFtyNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cRiBZ2Es/hp4k2N4q8iUn7Gg6G7WRx6Enx6NzwR0pvs1Uo+PJaPHaN7erZz9hslNv
	 oJ7sqEw1Gm4XNo9zvyHyBuflt9WlyERaBGdNjvStedufPMloODdbHhUJirOzDWC+8X
	 zVp4JrJ/gaV0VdW1ge5sqw0homVaw3Vc/e2SizUHaye7MACpqpVvpFCg/vFe6MBz1u
	 bgnYht1IvQbsvC5pfXFx6HqJc0SdU7EZMACNFbDBzeekUAJ687dDajvzJw2G1QTSiI
	 bwYUDUdmE4eHB+SBxhjQhqYhK29d3CioXGWhhlWOuEMZFh0a6Eu7tsz6DzSkSNNYQr
	 KPpk+usdP0Kqg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50ec948ad31so11276732e87.2;
        Wed, 17 Jan 2024 07:56:37 -0800 (PST)
X-Gm-Message-State: AOJu0YzWD9/Dct5pest4iAUijEa90G58xOFRaUsuO6kR0Y1rO4pFgJCT
	ZJlfroB3Gt/d/gCXKG5Ek4bq8c3VIvyjTDpKmA==
X-Google-Smtp-Source: AGHT+IGaf7OO/QIwbRtFIzzCYIwu/CbtDrVi9rgtHOA0Oa7uryO/EzrtchbYZmaVI0oi/aGjQ3nl2bIJQVjlGNvIzlI=
X-Received: by 2002:a05:6512:b87:b0:50e:a9db:9b89 with SMTP id
 b7-20020a0565120b8700b0050ea9db9b89mr5288051lfv.13.1705506995412; Wed, 17 Jan
 2024 07:56:35 -0800 (PST)
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
 <CAFLszTizRRVbRO6_ygE2X-Lp5dENWSc4uMGL5GPJAFGAbRdCyQ@mail.gmail.com>
In-Reply-To: <CAFLszTizRRVbRO6_ygE2X-Lp5dENWSc4uMGL5GPJAFGAbRdCyQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 17 Jan 2024 09:56:22 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+j7_KZtQ2ENq9+vsw0LOZF=spu293_G=AxOmBM+m_f-g@mail.gmail.com>
Message-ID: <CAL_Jsq+j7_KZtQ2ENq9+vsw0LOZF=spu293_G=AxOmBM+m_f-g@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
	Michael Walle <mwalle@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:54=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Rob,
>
> On Thu, Dec 14, 2023 at 2:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Rob,
> >
> > On Thu, 14 Dec 2023 at 10:27, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Dec 08, 2023 at 03:58:10PM -0700, Simon Glass wrote:
> > > > Hi Rob,
> > > >
> > > > On Fri, 8 Dec 2023 at 14:56, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Fri, Dec 8, 2023 at 11:47=E2=80=AFAM Simon Glass <sjg@chromium=
org> wrote:
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > On Fri, 8 Dec 2023 at 08:00, Rob Herring <robh@kernel.org> wrot=
e:
> > > > > > >
> > > > > > > On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass wrote:
> > > > > > > > Add a compatible string for binman, so we can extend fixed-=
partitions
> > > > > > > > in various ways.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v5)
> > > > > > > >
> > > > > > > > Changes in v5:
> > > > > > > > - Add #address/size-cells and parternProperties
> > > > > > > > - Drop $ref to fixed-partitions.yaml
> > > > > > > > - Drop 'select: false'
> > > > > > > >
> > > > > > > > Changes in v4:
> > > > > > > > - Change subject line
> > > > > > > >
> > > > > > > > Changes in v3:
> > > > > > > > - Drop fixed-partition additional compatible string
> > > > > > > > - Drop fixed-partitions from the example
> > > > > > > > - Mention use of compatible instead of label
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Drop mention of 'enhanced features' in fixed-partitions.y=
aml
> > > > > > > > - Mention Binman input and output properties
> > > > > > > > - Use plain partition@xxx for the node name
> > > > > > > >
> > > > > > > >  .../bindings/mtd/partitions/binman.yaml       | 68 +++++++=
++++++++++++
> > > > > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > > > > >  MAINTAINERS                                   |  5 ++
> > > > > > > >  3 files changed, 74 insertions(+)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/p=
artitions/binman.yaml
> > > > > > > >
> > > > > > > > diff --git a/Documentation/devicetree/bindings/mtd/partitio=
ns/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.ya=
ml
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..329217550a98
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/mtd/partitions/binm=
an.yaml
> > > > > > > > @@ -0,0 +1,68 @@
> > > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > > +# Copyright 2023 Google LLC
> > > > > > > > +
> > > > > > > > +%YAML 1.2
> > > > > > > > +---
> > > > > > > > +$id: http://devicetree.org/schemas/mtd/partitions/binman.y=
aml#
> > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > +
> > > > > > > > +title: Binman firmware layout
> > > > > > > > +
> > > > > > > > +maintainers:
> > > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > > +
> > > > > > > > +description: |
> > > > > > > > +  The binman node provides a layout for firmware, used whe=
n packaging firmware
> > > > > > > > +  from multiple projects. It is based on fixed-partitions,=
 with some
> > > > > > > > +  extensions, but uses 'compatible' to indicate the conten=
ts of the node, to
> > > > > > > > +  avoid perturbing or confusing existing installations whi=
ch use 'label' for a
> > > > > > > > +  particular purpose.
> > > > > > > > +
> > > > > > > > +  Binman supports properties used as inputs to the firmwar=
e-packaging process,
> > > > > > > > +  such as those which control alignment of partitions. Thi=
s binding addresses
> > > > > > > > +  these 'input' properties. For example, it is common for =
the 'reg' property
> > > > > > > > +  (an 'output' property) to be set by Binman, based on the=
 alignment requested
> > > > > > > > +  in the input.
> > > > > > > > +
> > > > > > > > +  Once processing is complete, input properties have mostl=
y served their
> > > > > > > > +  purpose, at least until the firmware is repacked later, =
e.g. due to a
> > > > > > > > +  firmware update. The 'fixed-partitions' binding should p=
rovide enough
> > > > > > > > +  information to read the firmware at runtime, including d=
ecompression if
> > > > > > > > +  needed.
> > > > > > >
> > > > > > > How is this going to work exactly? binman reads these nodes a=
nd then
> > > > > > > writes out 'fixed-partitions' nodes. But then you've lost the=
 binman
> > > > > > > specifc parts needed for repacking.
> > > > > >
> > > > > > No, they are the same node. I do want the extra information to =
stick
> > > > > > around. So long as it is compatible with fixed-partition as wel=
l, this
> > > > > > should work OK.
> > > > >
> > > > > How can it be both? The partitions node compatible can be either
> > > > > 'fixed-partitions' or 'binman'.
> > > >
> > > > Can we not allow it to be both? I have tried to adjust things in
> > > > response to feedback but perhaps the feedback was leading me down t=
he
> > > > wrong path?
> > >
> > > Sure, but then the schema has to and that means extending
> > > fixed-partitions.
> >
> > Can we cross that bridge later? There might be resistance to it. I'm
> > not sure. For now, perhaps just a binman compatible works well enough
> > to make progress.
>
> Is there any way to make progress on this? I would like to have
> software which doesn't understand the binman compatible to at least be
> able to understand the fixed-partition compatible. Is that acceptable?

There's only 2 ways that it can work. Either binman writes out
fixed-partition nodes dropping/replacing anything only defined for
binman or fixed-partition is extended to include what binman needs.

Rob

