Return-Path: <linux-kernel+bounces-68994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64485831D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F74AB247FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983DF13172B;
	Fri, 16 Feb 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqUl15Kz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3382130E3C;
	Fri, 16 Feb 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102520; cv=none; b=oxCbgCSZ4oXKQAeXqYLkxnMgZ07i1ORV7MXQiOAg0DIsp248fRIZ4Ad+xnRW5YQzkM92PYJTKdR11YMJIy0ZUQERCCi68pi4GglesJ4zO5ITbs5K31EC5r+NUdve5bUZnnAA2S7EBU3ByDdGP3SCsAhiLustQyQa80o8plqCKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102520; c=relaxed/simple;
	bh=sNJdEIGh47IphekNJCjaQ5UZsjsSz4ZVXbDqYc2VR6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcIijasZ2/XjVlGtgrtmx0ZBQlBNEWYsTwpCEwI5QFJnKRDuD8YxYKfE0vtM237S5/DfhRbjHAvIubxPL3KoS4d1RMiF2hWU5311Y5dtnIELNQtb4x+3OwHCyF6mzDXcVYdI6U0jnREiw2vjirH27YsbXjuwIcp07trfZMeIWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqUl15Kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD21C433F1;
	Fri, 16 Feb 2024 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708102520;
	bh=sNJdEIGh47IphekNJCjaQ5UZsjsSz4ZVXbDqYc2VR6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqUl15KzESSt0lB7n73IA3wkyejg2GnTjA38qiDa4X/iSY2fJ7v9JDcY0XDU3NQyJ
	 qp9fbabgI4TLpKiWIJdLUfJcwFufO2o2bC3QXG09lwjAyHHaBsC+lXQVHB2qdRlz7T
	 PCjP4lCRNP8QZrCt260MEwJCH2DCEeBPimLahV767PyPDkGaYvfjvAYS61inzHeI62
	 4mDYO6FrnH6m+Vk5BQZ+hnhHc9fJjP0tuyUL+wM0oSGOgDOj8Pgm1WraHK12YOZ5m2
	 wBpcsCWM6/esX/skq2Lb2yeqNRffgJzPmF0CU124+qq68IaaE5yXyQawYRy3+uzNBy
	 T4roYJABL4D3Q==
Date: Fri, 16 Feb 2024 16:55:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com,
	davidm@egauge.net, linux-wireless@vger.kernel.org,
	claudiu.beznea@tuxon.dev, thomas.petazzoni@bootlin.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
Message-ID: <20240216-spinster-decade-e136ac3e72d0@spud>
References: <20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com>
 <2ff1c701f3443e1c612a81f4077b0280850f57c6.camel@egauge.net>
 <081bce96-f485-414c-8051-e1c14271f8cc@bootlin.com>
 <aac398e4-d870-4ba2-8877-b98afecb8d1b@microchip.com>
 <877cj4o0sv.fsf@kernel.org>
 <20240216-reckless-freedom-4768ce41e939@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7bS3SWgYAKyG5UJl"
Content-Disposition: inline
In-Reply-To: <20240216-reckless-freedom-4768ce41e939@spud>


--7bS3SWgYAKyG5UJl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 04:54:29PM +0000, Conor Dooley wrote:
> On Fri, Feb 16, 2024 at 06:01:52PM +0200, Kalle Valo wrote:
> > (Adding devicetree list for comments)
> >=20
> > <Ajay.Kathat@microchip.com> writes:
> >=20
> > > On 2/13/24 09:58, Alexis Lothor=E9 wrote:
> > >>=20
> > >> On 2/13/24 17:42, David Mosberger-Tang wrote:
> > >>> On Tue, 2024-02-13 at 16:22 +0100, Alexis Lothor=E9 wrote:
> > >>>> When using a wilc1000 chip over a spi bus, users can optionally de=
fine a
> > >>>> reset gpio and a chip enable gpio. The reset line of wilc1000 is a=
ctive
> > >>>> low, so to hold the chip in reset, a low (physical) value must be =
applied.
> > >>>>
> > >>>> The corresponding device tree binding documentation was introduced=
 by
> > >>>> commit f31ee3c0a555 ("wilc1000: Document enable-gpios and reset-gp=
ios
> > >>>> properties") and correctly indicates that the reset line is an act=
ive-low
> > >>>> signal. However, the corresponding driver part, brought by commit
> > >>>> ec031ac4792c ("wilc1000: Add reset/enable GPIO support to SPI driv=
er"), is
> > >>>> misusing the gpiod APIs and apply an inverted logic when powering =
up/down
> > >>>> the chip (for example, setting the reset line to a logic "1" durin=
g power
> > >>>> up, which in fact asserts the reset line when device tree describe=
s the
> > >>>> reset line as GPIO_ACTIVE_LOW).
> > >>>
> > >>> Note that commit ec031ac4792c is doing the right thing in regards t=
o an
> > >>> ACTIVE_LOW RESET pin and the binding documentation is consistent wi=
th that code.
> > >>>
> > >>> It was later on that commit fcf690b0 flipped the RESET line polarit=
y to treat it
> > >>> as GPIO_ACTIVE_HIGH.  I never understood why that was done and, as =
you noted, it
> > >>> introduced in inconsistency with the binding documentation.
> > >>=20
> > >> Ah, you are right, and I was wrong citing your GPIOs patch as faulty
> > >> (git-blaming too fast !), thanks for the clarification. I missed thi=
s patch from
> > >> Ajay (fcf690b0) flipping the reset logic. Maybe he had issues while =
missing
> > >> proper device tree configuration and then submitted this flip ?
> > >
> > > Indeed, it was done to align the code as per the DT entry suggested in
> > > WILC1000/3000 porting guide[1 -page 18], which is already used by most
> > > of the existing users. This change has impact on the users who are us=
ing
> > > DT entry from porting guide. One approach is to retain the current co=
de
> > > and document this if needed.
> >=20
> > So if I'm understanding the situation correctly Microchip's porting
> > guide[1] doesn't match with kernel.org documentation[2]? I'm not the
> > expert here but from my point of view the issue is clear: the code needs
> > to follow kernel.org documentation[2], not external documentation.
>=20
> My point of view would definitely be that drivers in the mainline kernel
> absolutely should respect the ABI defined in the dt-binding. What a vendor
> decides to do in their own tree I suppose is their problem, but I would
> advocate that vendor kernels would also respect the ABI from mainline.
>=20
> Looking a bit more closely at the porting guide, it contains other
> properties that are not present in the dt-binding - undocumented
> compatibles and a different enable gpio property for example.
> I guess it (and the vendor version of the driver) never got updated when
> wilc1000 supported landed in mainline?
>=20
> > I'll add devicetree list so hopefully people there can comment also,
> > full patch available in [3].
> >=20
> > Alexis, if there are no more comments I'm in favor submitting the revert
> > you mentioned.
>=20
> From a dt-bindings point of view, the aforementioned revert seems
> correct and would be
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Maybe an R-b is more suitable here, too used to acking trivial patches
that are dt related..

>=20
> Getting off my dt-binding maintainer high-horse, linux4microchip is going
> be updating to a 6.6 based kernel in the coming weeks - maybe that's a
> good time to update the vendor kernel wilc drivers (and therefore the
> porting guide?) to match the properties used by mainline Ajay?
>=20
> Cheers,
> Conor.



--7bS3SWgYAKyG5UJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc+TcwAKCRB4tDGHoIJi
0snwAQCPW30mRLhwRM6OGWxdq7BKSiI8nrYXqB0r/w1KcadwmwEA1PCfj6XX3FCc
y79qIG1+H9bjozbWYxMRtTlzNmeRnQA=
=YeuA
-----END PGP SIGNATURE-----

--7bS3SWgYAKyG5UJl--

