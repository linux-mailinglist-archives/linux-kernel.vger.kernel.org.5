Return-Path: <linux-kernel+bounces-123393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F08907DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205032A59E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51875131BDC;
	Thu, 28 Mar 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTHB7ySp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2F3BBC5;
	Thu, 28 Mar 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648875; cv=none; b=TjG1Tx8FnEr3aFUhtaZp1C4fF99nltJEdQicuREzFZ5xkH9z9JgbWK70GZ3P2ow6riSh+BX8vqqMurc7/T632GXPSVspozZo1vN+tRVp3mvl8GXENTbUCLOXdFIJTMkRa6Q7Y3H4g59gKb9it46LsPOuuEieCbAWUIs/kAGml1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648875; c=relaxed/simple;
	bh=4phPWnWO8U4B+6/tBTg6onrt6txt5QrNdPVtLs0pEDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXKa09+QARqTJr0MrxA+MrzndOzjebvmDzIDDnOBUrBFXEcOTAGdT46okt1wekF2hP+6bVb6ySCVEJbgLW5e16qj/TSPjFnAwOH8EMz947vOCPqvO2XYE/FfzHu1+sZCY+02PLEisQ5MQeIBe+e5E2XEfGu3OFoHBsKPyUuVfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTHB7ySp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCBBC433C7;
	Thu, 28 Mar 2024 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711648875;
	bh=4phPWnWO8U4B+6/tBTg6onrt6txt5QrNdPVtLs0pEDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTHB7ySpnSsjWLu+d154b3fd84Utt8K81WByU29Xe3bUphIcvK390k1jGFjvAua5Z
	 7SKYtrvWfSkCIdR3LkiUos2WstAbh+N7vyzUqY+8ZxVlO3z0Yd+pqPcnA1H5yCrh11
	 CnbF3bPD6RgCjKDvXuxMkaDK8vS+LeyZSRL8YzNsMXkt2g8/ji8cqHtWlV10VI2843
	 UVNb+TpojYuVYqzBqsMTKWuBR53awurPsxp3DPQGvnLMXXlqJF36xukiu4gUShLtla
	 kD44XW1mgkhd+z9i83+af/HBfFnL5TWj1lFlwp8rTDNFC/OkYPdG/SaenG+h6eTkBR
	 sZnQGqT/S8ykA==
Date: Thu, 28 Mar 2024 18:01:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Alban Browaeys <alban.browaeys@gmail.com>
Cc: dev@folker-schwesinger.de, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Jensen Huang <jensenhuang@friendlyarm.com>,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] phy: rockchip: emmc: Enable pulldown for strobe line
Message-ID: <20240328-unnatural-unsorted-e53a13f5e87e@spud>
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
 <20240326-rk-default-enable-strobe-pulldown-v1-1-f410c71605c0@folker-schwesinger.de>
 <20240326-tactical-onlooker-3df8d2352dc2@spud>
 <871f0b24a38208d9c5d6abc87d83b067162c103e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8F3JqEr12hAqS6Zr"
Content-Disposition: inline
In-Reply-To: <871f0b24a38208d9c5d6abc87d83b067162c103e.camel@gmail.com>


--8F3JqEr12hAqS6Zr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 06:00:03PM +0100, Alban Browaeys wrote:
> Le mardi 26 mars 2024 =E0 19:46 +0000, Conor Dooley a =E9crit=A0:
> > On Tue, Mar 26, 2024 at 07:54:35PM +0100, Folker Schwesinger via B4
> > Relay wrote:
> > > From: Folker Schwesinger <dev@folker-schwesinger.de>
> > > -	if (of_property_read_bool(dev->of_node, "rockchip,enable-
> > > strobe-pulldown"))
> > > -		rk_phy->enable_strobe_pulldown =3D
> > > PHYCTRL_REN_STRB_ENABLE;
> > > +	if (of_property_read_bool(dev->of_node, "rockchip,disable-
> > > strobe-pulldown"))
> > > +		rk_phy->enable_strobe_pulldown =3D
> > > PHYCTRL_REN_STRB_DISABLE;
> >=20
> > Unfortunately you cannot do this.
> > Previously no property at all meant disabled and a property was
> > required
> > to enable it. With this change the absence of a property means that
> > it
> > will be enabled.
> > An old devicetree is that wanted this to be disabled would have no
> > property and will now end up with it enabled. This is an ABI break
> > and is
> > clearly not backwards compatible, that's a NAK unless it is
> > demonstrable
> > that noone actually wants to disable it at all.
>=20
>=20
> But the patch that introduced the new default to disable the pulldown
> explicitely introduced a regression for at least 4 boards.
> It took time to sort out that the default to disable pulldown was the
> culprit but still.
> Will we carry this new behavor that breaks the default design for
> rk3399 because since the regression was introduced new board definition
> might have expceted this new behavior.
>=20
> Could the best option be to revert to =E9not set a default enable/disable
> pulldown" (as before the commit that introduced the regression) and
> allow one to force the pulldown via the enable/disable pulldown
> property?
> I mean the commit that introduced a default value for the pulldown did
> not seem to be about fixing anything. But it broke a lot. ANd it was
> really really hard to find the description of this commit to understand
> that one had to enable pulldown to restore hs400.
>=20
> In more than 3 years, only one board maintainer noticed that this
> property was required to get back HS400  and thanks to a user telling
> me that this board was working I found from this board that this
> property was "missing" from most board definitions (while it was not
> required before).
>=20
>=20
> I am all for not breaking ABI. But what about not reverting a patch
> that already broke ABI because this patch introduced a new ABI that we
> don't want to break?
> I mean shouldn't a new commit with a new ABI that regressed the kernel
> be reverted?

I think I said it after OP replied to me yesterday, but this is a pretty
shitty situation in that the original default picked for the property
was actually incorrect. Given it's been like this for four years before
anyone noticed, and others probably depend on the current behaviour,
that's hard to justify.

> Mind fixing the initial regression 8b5c2b45b8f0 "phy: rockchip: set
> pulldown for strobe line in dts" does not necessarily mean changing the
> default to the opposite value but could also be reverting to not
> setting a default.

That's also problematic, as the only way to do this is make setting
one of the enabled or disabled properties required, which is also an ABI
break, since you'd then be rejecting probe if one is not present.

> Though I don't know if there are pros to setting a default.

What you probably have to weigh up is the cons of each side. If what you
lose is HS400 mode with what's in the kernel right now but switching to
what's been proposed would entirely break some boards, I know which
I think the lesser of two evils is.

It's probably up to the platform maintainer to weigh in at this point.

Hope that helps?
Conor.

--8F3JqEr12hAqS6Zr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgWwZQAKCRB4tDGHoIJi
0jB0AQC8/xsQZ9aSVUyDP+TLrTxN1T6WpnZxDmZ0RytuJJKcagEAs1IkEDW1WV+R
Vn4E8r+DK3CUYvmFu6xKJKaLOoafAwY=
=YhMf
-----END PGP SIGNATURE-----

--8F3JqEr12hAqS6Zr--

