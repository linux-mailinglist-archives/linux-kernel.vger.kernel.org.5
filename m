Return-Path: <linux-kernel+bounces-37475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897A83B09C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12343285CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85B1129A8D;
	Wed, 24 Jan 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keq5e3oG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0D7765D;
	Wed, 24 Jan 2024 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119146; cv=none; b=iOULFCy4PKaeMuAPpEtoKCiSjNvhATpFx+BSBm18xG3yG+A9d3M/CjyoXo+nwwsTdRZ0dyPzKQsB5rR2DRYCN4KpqzhgLNV+q4wyi2bG7/MQOCzcWlk/C262OE0YMDQ+F+A12K61VYhKzyPhPMqNvdnz0FU+VSnaztHmFEAeQfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119146; c=relaxed/simple;
	bh=Cm7BUzwChHap3mEfOgJloaWrqZWdOhIAJHyy+U2xyWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqXkqhCMOuygIK9k6o+ocQTQEqzBN8Ahn96+iBDuPxPBx6SG1uG7A3p2j+v9R45jU2J3g2SHSjC0pVZJEro8OWCNR/w9r71Kgd5fRXygw237LWCYmHEjo3d4A+BNbtAYG3+c01wJaQLpAEOtHO2kR/PlvSoSkqtvbL/DvPm5GhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keq5e3oG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2925C433C7;
	Wed, 24 Jan 2024 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706119145;
	bh=Cm7BUzwChHap3mEfOgJloaWrqZWdOhIAJHyy+U2xyWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keq5e3oG7YzoqplhWADOaCbnPxZisQAEE8B8Sifw4trHPchjoYKZvIXFsxzs647Fy
	 ysA1MC8lyGQKGf662tm7oMMRvtDhDDqS4u84Ds+Sk+l5ORJ9deHw0RkgPJLPwLMpJZ
	 h05iQGZQWzgpiJNUZThPGNQYIgq7sjs1lWFhVPpRovXNC3PvLcb9A7p4RgUulCGrik
	 bemz4JzwY2hLA0wCM2AL4S1NJMfuduKPMyHjsqQEN/mFMwy0n89Z64nY/LrF7rLjdF
	 RkAcUcFtxj0gKU39Plq+/n+pv6u4k01huRkZqfgRD/BP9uBhb6MblNdozcWJQUJuC+
	 HJZabfG0Hk7tg==
Date: Wed, 24 Jan 2024 17:59:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: ran.wang_1@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, mark.rutland@arm.com,
	pku.leo@gmail.com, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches
 avoiding vbus glitch
Message-ID: <20240124-video-lumpiness-178c4e317f5a@spud>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240124-unclothed-dodgy-c78b1fffa752@spud>
 <ZbFNIvEaAJCxC2VB@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nhkkh/uTdZahtS4x"
Content-Disposition: inline
In-Reply-To: <ZbFNIvEaAJCxC2VB@lizhi-Precision-Tower-5810>


--nhkkh/uTdZahtS4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:47:14PM -0500, Frank Li wrote:
> On Wed, Jan 24, 2024 at 05:36:42PM +0000, Conor Dooley wrote:
> > On Fri, Jan 19, 2024 at 04:31:28PM -0500, Frank Li wrote:
> > > From: Ran Wang <ran.wang_1@nxp.com>
> > >=20
> > > When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> > > (or its control signal) will turn on immediately on related Root Hub
> > > ports. Then the VBUS will be de-asserted for a little while during xh=
ci
> > > reset (conducted by xhci driver) for a little while and back to norma=
l.
> > >=20
> > > This VBUS glitch might cause some USB devices emuration fail if kernel
> > > boot with them connected. One SW workaround which can fix this is to
> > > program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> > > host mode in DWC3 driver(per signal measurement result, it will be too
> > > late to do it in xhci-plat.c or xhci.c).
> > >=20
> > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/D=
ocumentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > index 203a1eb66691f..dbf272b76e0b5 100644
> > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > @@ -273,6 +273,13 @@ properties:
> > >        with an external supply.
> > >      type: boolean
> > > =20
> > > +  snps,host-vbus-glitches:
> > > +    description:
> > > +      When set, power off all Root Hub ports immediately after
> > > +      setting host mode to avoid vbus (negative) glitch happen in la=
ter
> > > +      xhci reset. And the vbus will back to 5V automatically when re=
set done.

nit: "will return to"

> > > +    type: boolean
> >=20
> > Why do we want to have a property for this at all? The commit message
> > seems to describe a problem that's limited to specific configurations
> > and appears to be somethng the driver should do unconditionally.
> >=20
> > Could you explain why this cannot be done unconditionally please?
>=20
> It depends on board design, not all system vbus can be controller by root
> hub port. If it is always on, it will not trigger this issue.

Okay, that seems reasonable to have a property for. Can you add that
info to the commit message please?

On another note, I like it when the property name explains why you would
add it, rather than the thing it is trying to solve.
Named after the disease, rather than the symptoms, if you get me. I
tried to come up with a name here, but could not really suggest
something good. If you can think of something, that'd be good, but don't
stress it.

Thanks,
Conor.


--nhkkh/uTdZahtS4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbFP5AAKCRB4tDGHoIJi
0jMAAQCp/21Q5979/sF3RN5s/2EsZasO9EBk6OMq7hWHKqQ6bQEAonMgZ+jJ1CwA
FychGYPa48OqMYsKeXJjFbuS92nlmQM=
=2AIU
-----END PGP SIGNATURE-----

--nhkkh/uTdZahtS4x--

