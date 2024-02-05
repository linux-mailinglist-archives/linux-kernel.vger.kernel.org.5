Return-Path: <linux-kernel+bounces-52538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2306C849970
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB11F281383
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DFB19BCA;
	Mon,  5 Feb 2024 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BBf+9WAt"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCF1B7E1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134382; cv=none; b=I9tCLXm4lXHEZ+QJErHQZjKyRDcmldKoHv+v+08jTMz6D6yRq1frxHxDWPyjVpxOheushsNG3Woidhd0M/wNV9pZX7+1ca4n9ED5wLU57O5iVclHfgpargZoHmDF4Vzctehn4tHTH8Tbidor3EPcNS5A/hJ47CQrO+FiVt8UOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134382; c=relaxed/simple;
	bh=Qy/Kf4AdfmQ2E3bIRuxsy0p1W5xTu8x8RaZjnsESEWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnE/XdX7h1PRuyWPzhDG4rQM5yC2+3vmb0lOeyjF+/BQNKk/Pb+sMh7UOOfnx8SUqyVsmRZUCLlKLv4M0XfBHDwaEVPpsyaOLGoXxN7YsWPBz0cu298ywZ96DdO5K7nIJdf7Qv9dxaYoS52xOEbVYj866o9wZdZh04nM5nd/VGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BBf+9WAt; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6861538916cso25614636d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707134379; x=1707739179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd19UudtUta4YgE00lNWpRXLRxXDC1CL2JnJndHo4kM=;
        b=BBf+9WAtmPxyuPucGHihl2MY++EqOlcRbkrt+MSVK50qhRGTZdhpQEr9sWNeTp3gAP
         n4HIoVB+RnnMf4vfylpUrPA+HiaQbrEGjGhCgSzhOU3qJJle9Mhiu1+b2Wcj8MPzI2AL
         0oW/mxgE5GVQ/gNSmM3hrtoUfLCEDVxK4oIrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707134379; x=1707739179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dd19UudtUta4YgE00lNWpRXLRxXDC1CL2JnJndHo4kM=;
        b=kbWC3N+gH2TRYUfW9QzZIA95shLxUYXMwH+t4ZHAxG9XmNVqOdjrSAboHnHuWnjqnn
         699uzSyr4og0eOoF/33Cih+YFUY3iooBW4cVSnmfFSwO10o/8Y0KGmTVV7p1+OVtu0d0
         cIkvDP2EUkJ9P4C0ptuaGYyOQg+Ced9ddyE7KukpvX+FtCHtlc1958u8wGa9W2fJwnP9
         5gUIOG/2fxRK031He9xbjpdfNnypTO5tpMT5l0btcc4crYYPeYUVH3yT72eN64+BxEQs
         70PVqy63CcKXGQr49n2BdzMX0XJZzZyV4YIsBvi10K9iIbCqwRZKVP0kMiOtTzi2Fe0Q
         IxeA==
X-Gm-Message-State: AOJu0Yymkus5ajH3Vc3BhK1pzi8k4+5iMCgvUGK4VfbA9LP9twgVuD8A
	TL+WzLto34mSOqV07TyVl6FdO/MhXZM+Aw80u7Ky25Yk1/4n8Nk5GIHXcL4vtC4XdW8xbU+fAeh
	b1BcPYohUCNxkYpoMnKx8gsX6hSJsF/BjiMnb
X-Google-Smtp-Source: AGHT+IFjWKMmhCR7ryd5mUFrZeoW5VjXZFwefVLKCjiSO60UBKWaqicUaXM/D+cAJk0ueWOKWBzJ8moWvs0gXRm/Ku4=
X-Received: by 2002:a05:6214:e4f:b0:68c:539b:b493 with SMTP id
 o15-20020a0562140e4f00b0068c539bb493mr7522718qvc.20.1707134379670; Mon, 05
 Feb 2024 03:59:39 -0800 (PST)
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
 <CAL_Jsq+j7_KZtQ2ENq9+vsw0LOZF=spu293_G=AxOmBM+m_f-g@mail.gmail.com>
 <CAFLszTimaFw9sf=JKvQXG4fS6V_2T=2n+pfvYLCiuG1o+7cHPA@mail.gmail.com> <20240205085056.44278f2c@xps-13>
In-Reply-To: <20240205085056.44278f2c@xps-13>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Feb 2024 04:59:28 -0700
Message-ID: <CAFLszTi+8ygXOidnhxj7sdJwc6X5i+++QvnUyfe-kde5eSts_w@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
	Michael Walle <mwalle@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On Mon, 5 Feb 2024 at 00:50, Miquel Raynal <miquel.raynal@bootlin.com> wrot=
e:
>
> Hi Simon,
>
> sjg@chromium.org wrote on Sun, 4 Feb 2024 05:07:38 -0700:
>
> > Hi Rob,
> >
> > On Wed, 17 Jan 2024 at 08:56, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Jan 4, 2024 at 3:54=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > On Thu, Dec 14, 2023 at 2:09=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > On Thu, 14 Dec 2023 at 10:27, Rob Herring <robh@kernel.org> wrote=
:
> > > > > >
> > > > > > On Fri, Dec 08, 2023 at 03:58:10PM -0700, Simon Glass wrote:
> > > > > > > Hi Rob,
> > > > > > >
> > > > > > > On Fri, 8 Dec 2023 at 14:56, Rob Herring <robh@kernel.org> wr=
ote:
> > > > > > > >
> > > > > > > > On Fri, Dec 8, 2023 at 11:47=E2=80=AFAM Simon Glass <sjg@ch=
romium.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Rob,
> > > > > > > > >
> > > > > > > > > On Fri, 8 Dec 2023 at 08:00, Rob Herring <robh@kernel.org=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Nov 16, 2023 at 10:28:50AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Add a compatible string for binman, so we can extend =
fixed-partitions
> > > > > > > > > > > in various ways.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > (no changes since v5)
> > > > > > > > > > >
> > > > > > > > > > > Changes in v5:
> > > > > > > > > > > - Add #address/size-cells and parternProperties
> > > > > > > > > > > - Drop $ref to fixed-partitions.yaml
> > > > > > > > > > > - Drop 'select: false'
> > > > > > > > > > >
> > > > > > > > > > > Changes in v4:
> > > > > > > > > > > - Change subject line
> > > > > > > > > > >
> > > > > > > > > > > Changes in v3:
> > > > > > > > > > > - Drop fixed-partition additional compatible string
> > > > > > > > > > > - Drop fixed-partitions from the example
> > > > > > > > > > > - Mention use of compatible instead of label
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - Drop mention of 'enhanced features' in fixed-partit=
ions.yaml
> > > > > > > > > > > - Mention Binman input and output properties
> > > > > > > > > > > - Use plain partition@xxx for the node name
> > > > > > > > > > >
> > > > > > > > > > >  .../bindings/mtd/partitions/binman.yaml       | 68 +=
++++++++++++++++++
> > > > > > > > > > >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> > > > > > > > > > >  MAINTAINERS                                   |  5 +=
+
> > > > > > > > > > >  3 files changed, 74 insertions(+)
> > > > > > > > > > >  create mode 100644 Documentation/devicetree/bindings=
/mtd/partitions/binman.yaml
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/Documentation/devicetree/bindings/mtd/pa=
rtitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/bin=
man.yaml
> > > > > > > > > > > new file mode 100644
> > > > > > > > > > > index 000000000000..329217550a98
> > > > > > > > > > > --- /dev/null
> > > > > > > > > > > +++ b/Documentation/devicetree/bindings/mtd/partition=
s/binman.yaml
> > > > > > > > > > > @@ -0,0 +1,68 @@
> > > > > > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > > > > > > > +# Copyright 2023 Google LLC
> > > > > > > > > > > +
> > > > > > > > > > > +%YAML 1.2
> > > > > > > > > > > +---
> > > > > > > > > > > +$id: http://devicetree.org/schemas/mtd/partitions/bi=
nman.yaml#
> > > > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yam=
l#
> > > > > > > > > > > +
> > > > > > > > > > > +title: Binman firmware layout
> > > > > > > > > > > +
> > > > > > > > > > > +maintainers:
> > > > > > > > > > > +  - Simon Glass <sjg@chromium.org>
> > > > > > > > > > > +
> > > > > > > > > > > +description: |
> > > > > > > > > > > +  The binman node provides a layout for firmware, us=
ed when packaging firmware
> > > > > > > > > > > +  from multiple projects. It is based on fixed-parti=
tions, with some
> > > > > > > > > > > +  extensions, but uses 'compatible' to indicate the =
contents of the node, to
> > > > > > > > > > > +  avoid perturbing or confusing existing installatio=
ns which use 'label' for a
> > > > > > > > > > > +  particular purpose.
> > > > > > > > > > > +
> > > > > > > > > > > +  Binman supports properties used as inputs to the f=
irmware-packaging process,
> > > > > > > > > > > +  such as those which control alignment of partition=
s. This binding addresses
> > > > > > > > > > > +  these 'input' properties. For example, it is commo=
n for the 'reg' property
> > > > > > > > > > > +  (an 'output' property) to be set by Binman, based =
on the alignment requested
> > > > > > > > > > > +  in the input.
> > > > > > > > > > > +
> > > > > > > > > > > +  Once processing is complete, input properties have=
 mostly served their
> > > > > > > > > > > +  purpose, at least until the firmware is repacked l=
ater, e.g. due to a
> > > > > > > > > > > +  firmware update. The 'fixed-partitions' binding sh=
ould provide enough
> > > > > > > > > > > +  information to read the firmware at runtime, inclu=
ding decompression if
> > > > > > > > > > > +  needed.
> > > > > > > > > >
> > > > > > > > > > How is this going to work exactly? binman reads these n=
odes and then
> > > > > > > > > > writes out 'fixed-partitions' nodes. But then you've lo=
st the binman
> > > > > > > > > > specifc parts needed for repacking.
> > > > > > > > >
> > > > > > > > > No, they are the same node. I do want the extra informati=
on to stick
> > > > > > > > > around. So long as it is compatible with fixed-partition =
as well, this
> > > > > > > > > should work OK.
> > > > > > > >
> > > > > > > > How can it be both? The partitions node compatible can be e=
ither
> > > > > > > > 'fixed-partitions' or 'binman'.
> > > > > > >
> > > > > > > Can we not allow it to be both? I have tried to adjust things=
 in
> > > > > > > response to feedback but perhaps the feedback was leading me =
down the
> > > > > > > wrong path?
> > > > > >
> > > > > > Sure, but then the schema has to and that means extending
> > > > > > fixed-partitions.
> > > > >
> > > > > Can we cross that bridge later? There might be resistance to it. =
I'm
> > > > > not sure. For now, perhaps just a binman compatible works well en=
ough
> > > > > to make progress.
> > > >
> > > > Is there any way to make progress on this? I would like to have
> > > > software which doesn't understand the binman compatible to at least=
 be
> > > > able to understand the fixed-partition compatible. Is that acceptab=
le?
> > >
> > > There's only 2 ways that it can work. Either binman writes out
> > > fixed-partition nodes dropping/replacing anything only defined for
> > > binman or fixed-partition is extended to include what binman needs.
> >
> > OK, then I suppose the best way is to add a new binman compatible, as
> > is done with this v6 series. People then need to choose it instead of
> > fixed-partition.
>
> I'm sorry this is not at all what Rob suggested, or did I totally
> misunderstand his answer?
>
> In both cases the solution is to generate a "fixed-partition" node. Now
> up to you to decide whether binman should adapt the output to the
> current schema, or if the current schema should be extended to
> understand all binman's output.
>
> At least that is my understanding and also what I kind of agree with.

I do want to binman schema to include all the features of Binman.

So are you saying that there should not be a 'binman'  schema, but I
should just add all the binman properties to the fixed-partition
schema?

Regards,
Simon

