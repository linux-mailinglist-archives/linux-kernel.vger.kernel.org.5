Return-Path: <linux-kernel+bounces-39049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61B383CA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762F91F21B00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B512132C19;
	Thu, 25 Jan 2024 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmQDML8y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788F1E861;
	Thu, 25 Jan 2024 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204609; cv=none; b=XCZPSR/ByGaBg6LZkpnVI7DW8zXztxegvSD8MRVYBpQFgFQNwOOAM4bFYzBdl3QYFnaf5ReGaXYpVjfeC54WHlooYvgjKIzN1kRFuo2lDAjmf850iqqhQ91RfMnljIfrrZYL7L6Ty3U0bwaJWi9VDwGnPWaElgDMMuHDsTxNkFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204609; c=relaxed/simple;
	bh=H+OmZiH2ZIfXeBeTb+1jrdcr4KMaSl+7lR9ke+VrKy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJhew2Hf2w/qaxtfA2OBEspsUjDGIxpY2+sxP4BG8CO65N6F9DDzcfj4TglbNOU2RmIV/2oF8Zs/Nd1NX4OcQKIaxjbYKU702/4bcQFtINdz4nKwlVDJGcbA2GWHFuwueSfHfmYinikwmGFESlNmW1UflrLcN/xiN5z0uewz4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmQDML8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49925C433C7;
	Thu, 25 Jan 2024 17:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706204608;
	bh=H+OmZiH2ZIfXeBeTb+1jrdcr4KMaSl+7lR9ke+VrKy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmQDML8ylJ+AIeU/tofb9f8a/gvkWs/jTr4AGstTX0M58zZhpf8ERfvuDHai+1WfG
	 s1zRusVbvY7jrpEaSitbgN2mkLVMPzbsSxTlaVJv81SH7yqVREN2WhQWDb0M7V8ePv
	 ffYY816Mm+lVBnJ/4H6Wwez0uB02mFPfWkPgzFTognv1v0hWjVWX716xX/uJhYhnPn
	 5uAKfRPBFU5VhPbeA29PlUi+aT+hYsR8XdPSV2I4/58AolQqGktqcNuTW4AIDuVpre
	 /cZ3XuIwp+f8vEl5TMCkSiaTw15MOwNsQexNKij6QPaS1jJYCB/OV00lYJUo8MlS/1
	 gxssXUbkrTIiQ==
Date: Thu, 25 Jan 2024 17:43:22 +0000
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
Message-ID: <20240125-appear-unclog-7da879f946e8@spud>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240124-unclothed-dodgy-c78b1fffa752@spud>
 <ZbFNIvEaAJCxC2VB@lizhi-Precision-Tower-5810>
 <20240124-video-lumpiness-178c4e317f5a@spud>
 <ZbFiQmD1VRVzFSa+@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DYnLHzNM1BRheBXO"
Content-Disposition: inline
In-Reply-To: <ZbFiQmD1VRVzFSa+@lizhi-Precision-Tower-5810>


--DYnLHzNM1BRheBXO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 02:17:22PM -0500, Frank Li wrote:
> On Wed, Jan 24, 2024 at 05:59:00PM +0000, Conor Dooley wrote:
> > On Wed, Jan 24, 2024 at 12:47:14PM -0500, Frank Li wrote:
> > > On Wed, Jan 24, 2024 at 05:36:42PM +0000, Conor Dooley wrote:
> > > > On Fri, Jan 19, 2024 at 04:31:28PM -0500, Frank Li wrote:
> > > > > From: Ran Wang <ran.wang_1@nxp.com>
> > > > >=20
> > > > > When DWC3 is set to host mode by programming register DWC3_GCTL, =
VBUS
> > > > > (or its control signal) will turn on immediately on related Root =
Hub
> > > > > ports. Then the VBUS will be de-asserted for a little while durin=
g xhci
> > > > > reset (conducted by xhci driver) for a little while and back to n=
ormal.
> > > > >=20
> > > > > This VBUS glitch might cause some USB devices emuration fail if k=
ernel
> > > > > boot with them connected. One SW workaround which can fix this is=
 to
> > > > > program all PORTSC[PP] to 0 to turn off VBUS immediately after se=
tting
> > > > > host mode in DWC3 driver(per signal measurement result, it will b=
e too
> > > > > late to do it in xhci-plat.c or xhci.c).
> > > > >=20
> > > > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > > > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml=
 b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > index 203a1eb66691f..dbf272b76e0b5 100644
> > > > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > @@ -273,6 +273,13 @@ properties:
> > > > >        with an external supply.
> > > > >      type: boolean
> > > > > =20
> > > > > +  snps,host-vbus-glitches:
> > > > > +    description:
> > > > > +      When set, power off all Root Hub ports immediately after
> > > > > +      setting host mode to avoid vbus (negative) glitch happen i=
n later
> > > > > +      xhci reset. And the vbus will back to 5V automatically whe=
n reset done.
> >=20
> > nit: "will return to"
> >=20
> > > > > +    type: boolean
> > > >=20
> > > > Why do we want to have a property for this at all? The commit messa=
ge
> > > > seems to describe a problem that's limited to specific configuratio=
ns
> > > > and appears to be somethng the driver should do unconditionally.
> > > >=20
> > > > Could you explain why this cannot be done unconditionally please?
> > >=20
> > > It depends on board design, not all system vbus can be controller by =
root
> > > hub port. If it is always on, it will not trigger this issue.
> >=20
> > Okay, that seems reasonable to have a property for. Can you add that
> > info to the commit message please?
>=20
> By the way, I sent v4 at
> https://lore.kernel.org/imx/20240124152525.3910311-1-Frank.Li@nxp.com/T/#t

I see.

> How about add below sentence?
>=20
> This was only happen when PORTSC[PP} can control vbus. Needn't set it if
> vbus is always on.

"This can only happen when ... controls vbus, if vbus is always on, omit
this property".

Just a wee grammatical nitpicking.

> > On another note, I like it when the property name explains why you would
> > add it, rather than the thing it is trying to solve.
> > Named after the disease, rather than the symptoms, if you get me. I
> > tried to come up with a name here, but could not really suggest
> > something good. If you can think of something, that'd be good, but don't
> > stress it.
>=20
> snps,host-vbus-glitches change to snps,host-vbus-glitches-quirk.

I don't think adding "quirk" moves the needle.

> How about use below description:
>=20
> When set, power off all Root Hub ports immediately after
> setting host mode to avoid vbus (negative) glitch happen in later
> xhci reset. That may cause some USB devices emuration fail when kernel bo=
ot
> with device connected and PORTSC[PP] control vbus in board desgin.

"When set, all root hub ports should be powered off immediately after
enabling host mode, to avoid Vbus (negative) glitches that may happen
during xHCI reset. These glitches can cause enumeration of some USB
devices to fail when PORTSC[PP] controls Vbus. If Vbus is always on,
omit this property."

How's that?

--DYnLHzNM1BRheBXO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKdugAKCRB4tDGHoIJi
0rW6AP9mEQlUrIIosavfS3kjJIpwvgVbgjfh5fLTZ2BBHxvtcgEAsQ/t921axT9S
4B+qHdP7RqUk6gTi8US6ykZQjSheCgc=
=rgw9
-----END PGP SIGNATURE-----

--DYnLHzNM1BRheBXO--

