Return-Path: <linux-kernel+bounces-42570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B94840338
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902542843CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228F5730C;
	Mon, 29 Jan 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SJl++oa8"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A85813B;
	Mon, 29 Jan 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525475; cv=none; b=MacYDzURij2R6nKJqiDnzQkuE3DcNya94EvqHMSpkoJw/6M4pEwvXTak6P+FBEl55jR+6/aRn/jsrQ8aZlb5anP6w7daI6L1phEbuN65HB9lPEPgdRG+78sWz1KNHVPNHzGwoTDUySNqGfbXHyNr3fpHTkiXrC5P7wTPjHnVh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525475; c=relaxed/simple;
	bh=ukOtAapMpcs3gouK76hfbz2OydKZ5yuDQXLgY5UudgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+T9uT4px6O1drZphrseMls+FrDSVJoT1WkTYIpSju6gQojAs//nJWOSbBA8zkAawXm0qpj66HuOs7RyXiXD1QpicDD5w4quy9Xta8dFBDWLdIwSeWvnSfti5DHYza+5rHq+OjH0cD9eWHQgpyDZkHB5G5Ljr0ZqvuINrEywGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SJl++oa8; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id EC356C061B;
	Mon, 29 Jan 2024 10:39:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29CF424000F;
	Mon, 29 Jan 2024 10:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706524753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SzZzw4d54XSo2ydsDnDCfH378ZIMyyvaH4KxDSlkAag=;
	b=SJl++oa8v7PhOHS89lnaWRvr3guWpxhsUXQyj7wSRvZjuHbZ0hx88qSKofzK6guGtgr4uC
	cE/38DDH8ONd54eB3CJ5AGc6mlcrsCE32HhRcFJVYazGxYv7PgEZB4F07sFtIyO9RB/sQQ
	T7/3X2VWL+yHMEQNzBFm+qhqmQAnxzML1B9GhB3onof3sXxYOTZ+sGDK8qhFc2A3HOgaBX
	9mPxHEsbtsTiJaE6FMd/dTL1c7YD2j2f5zKmN/+82jhvATutS6fZ6+t3EPdOWBsukQGW/t
	M07qAkO1HoUyFR+AnJW/xV2E7mxbdXelAuctglnxNR7vRiq9DD98hTg8RpIsYA==
Date: Mon, 29 Jan 2024 11:39:12 +0100
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
Message-ID: <20240129113912.0a29e30e@xps-13>
In-Reply-To: <CAL_JsqJcQgBY+o_rniMWmJ5=zA0aG1YSDCayQTp=Nw=xwRPMYg@mail.gmail.com>
References: <20240122173514.935742-1-robh@kernel.org>
	<BN9PR18MB4251944C1AE34057DACD7556DB742@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240123224324.GA2181680-robh@kernel.org>
	<20240125100331.5d3ce739@xps-13>
	<CAL_JsqJcQgBY+o_rniMWmJ5=zA0aG1YSDCayQTp=Nw=xwRPMYg@mail.gmail.com>
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

Hi Rob,

robh@kernel.org wrote on Fri, 26 Jan 2024 09:12:08 -0600:

> On Thu, Jan 25, 2024 at 3:03=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Hello,
> > =20
> > > > > The example for PCI devices has some addressing errors. 'reg' is =
written as if
> > > > > the parent bus is PCI, but the default bus for examples is 1 addr=
ess and size
> > > > > cell. 'ranges' is defining config space with a size of 0. General=
ly, config space
> > > > > should not be defined in 'ranges', only PCI memory and I/O spaces=
 Fix these
> > > > > issues by updating the values with made-up, but valid values.
> > > > >
> > > > > This was uncovered with recent dtschema changes.
> > > > >
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/net/marvell,prestera.yaml | 4 =
++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/net/marvell,preste=
ra.yaml
> > > > > b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > > > > index 5ea8b73663a5..16ff892f7bbd 100644
> > > > > --- a/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > > > > +++ b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > > > > @@ -78,8 +78,8 @@ examples:
> > > > >      pcie@0 {
> > > > >          #address-cells =3D <3>;
> > > > >          #size-cells =3D <2>;
> > > > > -        ranges =3D <0x0 0x0 0x0 0x0 0x0 0x0>;
> > > > > -        reg =3D <0x0 0x0 0x0 0x0 0x0 0x0>;
> > > > > +        ranges =3D <0x02000000 0x0 0x100000 0x10000000 0x0 0x0>;
> > > > > +        reg =3D <0x0 0x1000>;
> > > > >          device_type =3D "pci";
> > > > >
> > > > >          switch@0,0 {
> > > > > --
> > > > > 2.43.0
> > > > > =20
> > > >
> > > > This yaml has a mix-up of device P/N (belonging to AC3, BC2) and PC=
Ie
> > > > IDs (belonging to AC3X, Aldrin2)
> > > > Looks like a part of the yaml was updated, and another part was not
> > > >
> > > > There is a reference here of actual usage of prestera switch device:
> > > > https://github.com/dentproject/linux/blob/dent-linux-5.15.y/arch/ar=
m64/boot/dts/marvell/accton-as4564-26p.dts =20
> > >
> > > That doesn't match upstream at all... =20
> >
> > Yes, the DTS there are not up to date. I actually took mine (see below)
> > from:
> > https://github.com/dentproject/linux/blob/dent-linux-5.15.105/arch/arm6=
4/boot/dts/marvell/delta-tn48m.dts#L133
> > and fixed the Prestera representation (a root node does not make any
> > sense).
> > =20
> > > > So actual ranges and reg could be used instead of made up ones.
> > > >
> > > > But the actual real life dts places the prestera at the top level of
> > > > the dts, not under pci.
> > > >
> > > > I am not aware of any dts/dtsi using such kind of switch node under
> > > > pcie node, similar to the example given in the yaml file, and did n=
ot
> > > > manage to find any under latest linux-next for both arm and arm64 d=
ts
> > > > directories (please correct me here if I am wrong). =20
> > >
> > > Don't know. It seems plausible. =20
> >
> > The DT where this is used is public but not upstream, it was derived
> > from the above link:
> > https://github.com/miquelraynal/linux/blob/onie/syseeprom-public/arch/a=
rm64/boot/dts/marvell/armada-7040-tn48m.dts#L316
> > =20
> > > > So the question here is if this pci example really necessary for the
> > > > prestera device, or can be removed altogether (which is what I thin=
k is best to do). =20
> > >
> > > Miquel's commit adding indicates such devices exist. Why would he add
> > > them otherwise?
> > >
> > > Anyways, I'm just fixing boilerplate to make the PCI bus properties
> > > valid. Has nothing to do with this Marvell device really. =20
> >
> > I can't remember why the example in the schema is slightly different
> > (must have seen an update) but here is the exact diff I used to get it
> > working. Maybe the reg/ranges are loose though, TBH I've always been
> > a bit lost by PCI DT properties. =20
>=20
> Yeah, there aren't many examples to go on, but I'm trying to improve
> the schema to better constrain PCI nodes to be correct.
>=20
> >
> > +       pci@0,0 {
> > +               device_type =3D "pci";
> > +               reg =3D <0x0 0x0 0x0 0x0 0x0>;
> > +               ranges;
> > +               #address-cells =3D <3>;
> > +               #size-cells =3D <2>;
> > +               bus-range =3D <0x0 0x0>;
> > +
> > +               switch@0,0 {
> > +                       reg =3D <0x0 0x0 0x0 0x0 0x0>;
> > +                       compatible =3D "pci11ab,c80c";
> > ...
> >
> > Would something like this work better for the example? =20
>=20
> While this is valid on its own, it's not with the example template.
> The example has to have a host bridge node because the template is
> just the default bus addressing and there has to be translation to PCI
> addressing. To put it another way, we can only check 'reg' if the
> parent node is valid, but with the above the parent node is wrong.
>=20
> > FYI the pci@0,0 node is a child of
> >
> >         CP11X_LABEL(pcie0): pcie@CP11X_PCIE0_BASE
> >
> > from armada-cp11x.dtsi (which is upstream). =20
>=20
> Right, that's the host bridge and then the root port node and then the
> device. Whether there's a root port or not is outside the scope of
> this binding, but if you want to show it that's fine.

I don't have a strong opinion on that, I was just giving as much
information as I could. I prefer clean binding even though the examples
are not perfectly matching the reality, if all examples follow the same
pattern (which I believe is what you are currently working on).

Thanks,
Miqu=C3=A8l

