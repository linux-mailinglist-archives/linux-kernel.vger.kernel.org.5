Return-Path: <linux-kernel+bounces-38225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C394483BCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2781F2D964
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE301BF52;
	Thu, 25 Jan 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h7tPYbWL"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB781BF42;
	Thu, 25 Jan 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173426; cv=none; b=qaLEv3c7vbYe25aB7XGo4vbQAGnEMi7TCrZz/vPaxdsiaQzoalNaNGTOL/9Ox8Dyp7AnJL0ZlC2KsqsM5CnkQsxft3x3WWbSNZvLg+aXdU/5JhLSW4qs/pdhmX3fl/L/tLXFcWwmK3EWysv2O20EJWeH7rC5w+FmDIrXPWmSdPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173426; c=relaxed/simple;
	bh=UGFyWFrK2eV09kMnnOtyw3NvYNaY880yvB/i7zyrohg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwKO/7E5uVdt7BlKP4ikELJ7qXEk7nlEe6K60IJjHQataFscaMzlM/PbCGWdMmhs0UnM/qd13mqwrRrGWv9x/9eFv4dhHC1v1slSd9NSKYMrlLTyut6OiqClG0TSmzC8fI5y8P3s9viUCxxipf0Umo8jZImdW5T3x9/4HebuLzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h7tPYbWL; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09E5FFF810;
	Thu, 25 Jan 2024 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706173415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amEwt+tQpUauBKOrLyvtckHhU3glK+LW1t8VaRaSQ+o=;
	b=h7tPYbWLx9Q7CrUiyrSIru3rmmC7ljqz9v4hecMN6We9lJHJt3ADOKT6wl2tVfCo/0p+AW
	K90922nu2/h2KHGXf3hDXz4zIjrh8zL9oj3Xf7ey77OyPp0WNCdpAkOC+A0FkPOdnC6O+T
	iVE0LDx57uNcC0hLpN2SjlnXJvNOaZLot3NqjZaFdtS10wTT+rCIYEjUwVCr1LTocEig1U
	sEtjySVDjU5UHzLu0eDKoh0FyNoW6TH6pdaKuj1ImWq3ANiRQpzMuUvNW5oYfBO5WphseI
	P2k2vnTN4jtiEP4j+DKFnGYoCk5Hp+M3e1D/geBkG5xFgOGRop3MCsKD3XgBxg==
Date: Thu, 25 Jan 2024 10:03:31 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Elad Nachman <enachman@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH net-next] net: marvell,prestera: Fix example PCI
 bus addressing
Message-ID: <20240125100331.5d3ce739@xps-13>
In-Reply-To: <20240123224324.GA2181680-robh@kernel.org>
References: <20240122173514.935742-1-robh@kernel.org>
	<BN9PR18MB4251944C1AE34057DACD7556DB742@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240123224324.GA2181680-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

> > > The example for PCI devices has some addressing errors. 'reg' is writ=
ten as if
> > > the parent bus is PCI, but the default bus for examples is 1 address =
and size
> > > cell. 'ranges' is defining config space with a size of 0. Generally, =
config space
> > > should not be defined in 'ranges', only PCI memory and I/O spaces. Fi=
x these
> > > issues by updating the values with made-up, but valid values.
> > >=20
> > > This was uncovered with recent dtschema changes.
> > >=20
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/net/marvell,prestera.yaml | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/marvell,prestera.y=
aml
> > > b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > > index 5ea8b73663a5..16ff892f7bbd 100644
> > > --- a/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > > +++ b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > > @@ -78,8 +78,8 @@ examples:
> > >      pcie@0 {
> > >          #address-cells =3D <3>;
> > >          #size-cells =3D <2>;
> > > -        ranges =3D <0x0 0x0 0x0 0x0 0x0 0x0>;
> > > -        reg =3D <0x0 0x0 0x0 0x0 0x0 0x0>;
> > > +        ranges =3D <0x02000000 0x0 0x100000 0x10000000 0x0 0x0>;
> > > +        reg =3D <0x0 0x1000>;
> > >          device_type =3D "pci";
> > >=20
> > >          switch@0,0 {
> > > --
> > > 2.43.0
> > >  =20
> >=20
> > This yaml has a mix-up of device P/N (belonging to AC3, BC2) and PCIe=20
> > IDs (belonging to AC3X, Aldrin2)
> > Looks like a part of the yaml was updated, and another part was not
> >=20
> > There is a reference here of actual usage of prestera switch device:
> > https://github.com/dentproject/linux/blob/dent-linux-5.15.y/arch/arm64/=
boot/dts/marvell/accton-as4564-26p.dts =20
>=20
> That doesn't match upstream at all...

Yes, the DTS there are not up to date. I actually took mine (see below)
from:
https://github.com/dentproject/linux/blob/dent-linux-5.15.105/arch/arm64/bo=
ot/dts/marvell/delta-tn48m.dts#L133
and fixed the Prestera representation (a root node does not make any
sense).

> > So actual ranges and reg could be used instead of made up ones.
> >=20
> > But the actual real life dts places the prestera at the top level of=20
> > the dts, not under pci.
> >=20
> > I am not aware of any dts/dtsi using such kind of switch node under=20
> > pcie node, similar to the example given in the yaml file, and did not=20
> > manage to find any under latest linux-next for both arm and arm64 dts=20
> > directories (please correct me here if I am wrong). =20
>=20
> Don't know. It seems plausible.

The DT where this is used is public but not upstream, it was derived
from the above link:
https://github.com/miquelraynal/linux/blob/onie/syseeprom-public/arch/arm64=
/boot/dts/marvell/armada-7040-tn48m.dts#L316

> > So the question here is if this pci example really necessary for the=20
> > prestera device, or can be removed altogether (which is what I think is=
 best to do). =20
>=20
> Miquel's commit adding indicates such devices exist. Why would he add=20
> them otherwise?
>=20
> Anyways, I'm just fixing boilerplate to make the PCI bus properties=20
> valid. Has nothing to do with this Marvell device really.

I can't remember why the example in the schema is slightly different
(must have seen an update) but here is the exact diff I used to get it
working. Maybe the reg/ranges are loose though, TBH I've always been
a bit lost by PCI DT properties.

+       pci@0,0 {
+               device_type =3D "pci";
+               reg =3D <0x0 0x0 0x0 0x0 0x0>;
+               ranges;
+               #address-cells =3D <3>;
+               #size-cells =3D <2>;
+               bus-range =3D <0x0 0x0>;
+
+               switch@0,0 {
+                       reg =3D <0x0 0x0 0x0 0x0 0x0>;
+                       compatible =3D "pci11ab,c80c";
..

Would something like this work better for the example?

FYI the pci@0,0 node is a child of

	CP11X_LABEL(pcie0): pcie@CP11X_PCIE0_BASE=20

from armada-cp11x.dtsi (which is upstream).

It defines the Prestera switch as attached through PCI on a TN48M
Marvell based switch. There was a "whish" to get this DT upstream in
the past but it needs to be updated a bit and no action like that was
ever triggered. The reason why we want to describe it is that it
exposes interesting NVMEM cells to the system (like MAC addresses).

Thanks,
Miqu=C3=A8l

