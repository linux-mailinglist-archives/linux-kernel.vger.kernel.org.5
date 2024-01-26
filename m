Return-Path: <linux-kernel+bounces-40370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB1F83DF1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313FFB25F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDBA1DDC9;
	Fri, 26 Jan 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1v1bGxK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2D17565;
	Fri, 26 Jan 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287614; cv=none; b=ZawTxJDSTl3lTEQacppHqJlG1Uec76HcTeHxr3n0Z13ml3MGtimv2WI9xwaF5hRo6w0TGe8o0l+WSJxneOv66mLtJIHOLzTTZ9y3Slo3pjiDeBFHTQpU6jnNzupAWRyKrk6pmOTjlSbzAJ9m8rdod4BpFf7Y8BIl+eH7fhjvpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287614; c=relaxed/simple;
	bh=S8uf1+3V/6CW8VnPFT58PDMnQ3a9uAWN2UFFule9amg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrhinyNoxJaPf/M4bAkFzHvoPTqxieDlyUnl5aRFzF/1pl+dHP+V/9BcEr78+fuJVRg2pnbY25rvW2z+RrZN4AEyl6dwhkKf47pHg4VlXqZQqr6oHjifO/7wgrshDn3x6CHvafbUEUZjNEf8j1ZZ7yF5WtEOgADByZBzfqGuPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1v1bGxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCA3C43399;
	Fri, 26 Jan 2024 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706287614;
	bh=S8uf1+3V/6CW8VnPFT58PDMnQ3a9uAWN2UFFule9amg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1v1bGxKRtJl7chLLI5Khywi90YT0KiB8pRqdlmslf41IEqCKjxk7TwbhGYXeWOwU
	 R93sgnK3R2Auw7XBu8lZyiNBynOxGqH5w20hMhscfxiJ2FuydO7jXQEFWeUNwTwY5U
	 0mftxsnVjqTrs3U4vWsLhmJ9CiYW10H7V1C15G3HkkHKP2kK4xc4BJ+KLGj91Cuj+9
	 bFwmj72/MqgahU8bdCEEyiAtvosqYQnZpE17hzHW5gsCcY4Htm6grpr8edc6E4sOm8
	 p+0oisAdpas+KQsm6NWTuySmSfweECES8qIZiXMi+S4gYkh0Oht3IrIcWf00WMMlG/
	 33CwBPDV/bOmA==
Date: Fri, 26 Jan 2024 16:46:46 +0000
From: Conor Dooley <conor@kernel.org>
To: William Zhang <william.zhang@broadcom.com>
Cc: David Regan <dregan@broadcom.com>, dregan@mail.com,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, computersforpeace@gmail.com,
	kdasu.kdev@gmail.com, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com, anand.gore@broadcom.com,
	kursad.oney@broadcom.com, florian.fainelli@broadcom.com,
	rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	andre.przywara@arm.com, baruch@tkos.co.il,
	linux-arm-kernel@lists.infradead.org, dan.carpenter@linaro.org
Subject: Re: [PATCH v3 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca
 SoCs
Message-ID: <20240126-armadillo-clean-e3509ed23ed5@spud>
References: <20240124030458.98408-1-dregan@broadcom.com>
 <20240124030458.98408-2-dregan@broadcom.com>
 <20240124-direness-outpost-bbc22550a161@spud>
 <451151f3-33df-4de8-ab62-a683ad4b7cb1@broadcom.com>
 <20240125-drove-undiluted-5d822b7fd4fa@spud>
 <b2bc0948-7039-4dbd-8152-08a51e744c59@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iKGIjVp4UK6D/Mn9"
Content-Disposition: inline
In-Reply-To: <b2bc0948-7039-4dbd-8152-08a51e744c59@broadcom.com>


--iKGIjVp4UK6D/Mn9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 05:55:29PM -0800, William Zhang wrote:
> On 1/25/24 11:51, Conor Dooley wrote:
> > On Wed, Jan 24, 2024 at 07:01:48PM -0800, William Zhang wrote:
> > > On 1/24/24 09:24, Conor Dooley wrote:
> > > > On Tue, Jan 23, 2024 at 07:04:49PM -0800, David Regan wrote:
> > > > > From: William Zhang <william.zhang@broadcom.com>

> > > And the reason I keep it as int is because there could be a potential=
 value
> > > of 2 for another mode that the current driver could set the wp_on to.
> >=20
> > Can you explain, in driver independent terms, what this other mode has
> > to do with how the WP is connected?
> > Either you've got the standard scenario where apparently "NAND_WPb" and
> > "WP_L" are connected and another situation where they are not.
> > Is there another pin configuration in addition to that, that this 3rd
> > mode represents?
> >=20
> The 3rd mode is WP pin connected but wp feature is disabled in the
> controller.

What does "disabled" mean? The controller itself is not capable of using
the WP pin because of hardware modifications? Or there's a bit in a
register that disables it and that bit has been set by software?

If it is a hardware difference for that controller, why does it not have
a dedicated compatible? If it's a software decision, then it shouldn't
be in the DT in the first place ;)

We've gone back here a bunch trying to figure stuff out, and you give me
a vague one sentence answer. Please.

> > > I
> > > don't see it is being used in BCMBCA product but I am not sure about =
other
> > > SoC family. So I don't want to completely close the door here just in=
 case.
> >=20
> > If you ever need it, you could have a "brcm,wp-in-wacky-configuration"
> > property that indicates that the hardware is configured in that way
> > (providing that this hardware configuration is not just "NAND_WPb" and
> > "WP_L" pins connected. The property can very easily be made mutually
> > exclusive with "brcm,wp-not-connected" iff it ever comes to be.
> Yes we could have a new property but if we can have a single int property=
 to
> cover all, IMHO it is better to just have one property as these three mod=
es
> are related. I would really like to have it as an int property to keep
> things simple.

It is "better" because it is easier for you perhaps, but ripe for abuse.

> But if you think this is absolutely against the dts rule,  I will switch =
to
> the "brcm,wp-not-connected" boolean property as you suggested.

I'll answer this when you describe the mode better, right now I cannot
really comment, but I have not yet seen a justification for the non-flag
version of the property. Even if there's a justification for documenting
that other mode in the DT, I'm likely to still think boolean properties
are a better fit.

> > > > > If ecc
> > > > > +          strength and spare area size are set by nand-ecc-stren=
gth
> > > > > +          and brcm,nand-oob-sector-size in the dts, these settin=
gs
> > > > > +          have precedence and override this flag.
> > > >=20
> > > > Again, IMO, this is not for the binding to decide. That is a decisi=
on
> > > > for the operating system to make.
> > > >=20
> > > Again this is just for historic reason and BCMBCA as late player does=
 not
> > > want to break any existing dts setting.  So I thought it is useful to
> > > explain here.  I can remove this text if you don't think it should be=
 in the
> > > binding document.
> >=20
> > I don't, at least not in that form. I think it is reasonable to explain
> > why these values are better though.
> I understand the decision is for OS/driver to make. If we were to write
> another driver for other OS, the same precedence will apply too so the
> binding works the same way across all the OS. So I am not sure what better
> explanation or form I can put up here. I am open to any suggestion or I j=
ust
> delete it.

I would just delete it tbh.

Thanks,
Conor.

--iKGIjVp4UK6D/Mn9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbPh9gAKCRB4tDGHoIJi
0hw3AP4gQkWoZ3hipO7MVsw7nqCAhwk93HFqEigAirONBQpwwwD/b5a1m+W+ot8F
ksyesbSb6mDLyHd0R8xEtvEhcp0UrAs=
=xuth
-----END PGP SIGNATURE-----

--iKGIjVp4UK6D/Mn9--

