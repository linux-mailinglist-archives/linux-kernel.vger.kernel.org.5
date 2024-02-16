Return-Path: <linux-kernel+bounces-68992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA4858318
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57285B24663
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B78131E22;
	Fri, 16 Feb 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ8DQvJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BB912FB1E;
	Fri, 16 Feb 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102469; cv=none; b=YUGghwRG/avm5vuJ5p3YIJHNzSZ/3rFHQIcYEzcqk41qUNUptDK0o70k9aKfgC0vkQC3QL6mB3HoVY+QVSiz6rzP+HNXswpEU7cLFT7TqpFK334X/0I5K2g511Pek6KLJA0Bel+wiUy3+iA8laQxrqeMpk64FMuxcC9THj3TKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102469; c=relaxed/simple;
	bh=8OddoM/5Z/IMvsCA4MEbtq8hH+VVAaz1jere2rqeK4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLwmuPV43xAfJs1SwzgBvK5lot3a2Cb3RcHCG8BlyEl6FE7OuQ6s9U+/QmVtgQOedVedKZykgRdUMJIOQU/WQzwKyqkSd4Zw4EL9vMacspyCUyKlX8AzqsQo77lrIoza6eDqRocOxupdmrjmQSK3MUrIHEyvNTrKP4qwuk2zkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ8DQvJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CC0C433F1;
	Fri, 16 Feb 2024 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708102468;
	bh=8OddoM/5Z/IMvsCA4MEbtq8hH+VVAaz1jere2rqeK4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJ8DQvJbxtRhr01ZEId0k89q7dwWlxrtj2nDvJRjNH+HzFC71g1N1MPug2HxVBfGf
	 +IpgYCo7u7cWxTPn/lR+LVeoU7tMMMZFH587CV6KMK3m4Hc05zEKXXzciAkT0yt/De
	 s3AhOjbjQdAfcJFmh8XVuy9grwYk0gzoT23IH0DLkr0igwOys/E+yvUGEZOJHRZmb0
	 2LzpX2sHpnGESSwEZpIvASKgwRTNxF0x+jA2vtKqHw0t5Az+/k3BK2dSQBcX5t2mhY
	 FkmXwScH9gr2jrSUQFcn9mtMC4mjkP88NSh6PgUvY5ZLO1if4K8euZdTvrN6XP9CYa
	 rnHwIn4WNmG7A==
Date: Fri, 16 Feb 2024 16:54:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Ajay.Kathat@microchip.com, alexis.lothore@bootlin.com,
	davidm@egauge.net, linux-wireless@vger.kernel.org,
	claudiu.beznea@tuxon.dev, thomas.petazzoni@bootlin.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
Message-ID: <20240216-reckless-freedom-4768ce41e939@spud>
References: <20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com>
 <2ff1c701f3443e1c612a81f4077b0280850f57c6.camel@egauge.net>
 <081bce96-f485-414c-8051-e1c14271f8cc@bootlin.com>
 <aac398e4-d870-4ba2-8877-b98afecb8d1b@microchip.com>
 <877cj4o0sv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vP5ooK5Cnuawf+D0"
Content-Disposition: inline
In-Reply-To: <877cj4o0sv.fsf@kernel.org>


--vP5ooK5Cnuawf+D0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 06:01:52PM +0200, Kalle Valo wrote:
> (Adding devicetree list for comments)
>=20
> <Ajay.Kathat@microchip.com> writes:
>=20
> > On 2/13/24 09:58, Alexis Lothor=E9 wrote:
> >>=20
> >> On 2/13/24 17:42, David Mosberger-Tang wrote:
> >>> On Tue, 2024-02-13 at 16:22 +0100, Alexis Lothor=E9 wrote:
> >>>> When using a wilc1000 chip over a spi bus, users can optionally defi=
ne a
> >>>> reset gpio and a chip enable gpio. The reset line of wilc1000 is act=
ive
> >>>> low, so to hold the chip in reset, a low (physical) value must be ap=
plied.
> >>>>
> >>>> The corresponding device tree binding documentation was introduced by
> >>>> commit f31ee3c0a555 ("wilc1000: Document enable-gpios and reset-gpios
> >>>> properties") and correctly indicates that the reset line is an activ=
e-low
> >>>> signal. However, the corresponding driver part, brought by commit
> >>>> ec031ac4792c ("wilc1000: Add reset/enable GPIO support to SPI driver=
"), is
> >>>> misusing the gpiod APIs and apply an inverted logic when powering up=
/down
> >>>> the chip (for example, setting the reset line to a logic "1" during =
power
> >>>> up, which in fact asserts the reset line when device tree describes =
the
> >>>> reset line as GPIO_ACTIVE_LOW).
> >>>
> >>> Note that commit ec031ac4792c is doing the right thing in regards to =
an
> >>> ACTIVE_LOW RESET pin and the binding documentation is consistent with=
 that code.
> >>>
> >>> It was later on that commit fcf690b0 flipped the RESET line polarity =
to treat it
> >>> as GPIO_ACTIVE_HIGH.  I never understood why that was done and, as yo=
u noted, it
> >>> introduced in inconsistency with the binding documentation.
> >>=20
> >> Ah, you are right, and I was wrong citing your GPIOs patch as faulty
> >> (git-blaming too fast !), thanks for the clarification. I missed this =
patch from
> >> Ajay (fcf690b0) flipping the reset logic. Maybe he had issues while mi=
ssing
> >> proper device tree configuration and then submitted this flip ?
> >
> > Indeed, it was done to align the code as per the DT entry suggested in
> > WILC1000/3000 porting guide[1 -page 18], which is already used by most
> > of the existing users. This change has impact on the users who are using
> > DT entry from porting guide. One approach is to retain the current code
> > and document this if needed.
>=20
> So if I'm understanding the situation correctly Microchip's porting
> guide[1] doesn't match with kernel.org documentation[2]? I'm not the
> expert here but from my point of view the issue is clear: the code needs
> to follow kernel.org documentation[2], not external documentation.

My point of view would definitely be that drivers in the mainline kernel
absolutely should respect the ABI defined in the dt-binding. What a vendor
decides to do in their own tree I suppose is their problem, but I would
advocate that vendor kernels would also respect the ABI from mainline.

Looking a bit more closely at the porting guide, it contains other
properties that are not present in the dt-binding - undocumented
compatibles and a different enable gpio property for example.
I guess it (and the vendor version of the driver) never got updated when
wilc1000 supported landed in mainline?

> I'll add devicetree list so hopefully people there can comment also,
> full patch available in [3].
>=20
> Alexis, if there are no more comments I'm in favor submitting the revert
> you mentioned.

=46rom a dt-bindings point of view, the aforementioned revert seems
correct and would be
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Getting off my dt-binding maintainer high-horse, linux4microchip is going
be updating to a 6.6 based kernel in the coming weeks - maybe that's a
good time to update the vendor kernel wilc drivers (and therefore the
porting guide?) to match the properties used by mainline Ajay?

Cheers,
Conor.

--vP5ooK5Cnuawf+D0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc+TQAAKCRB4tDGHoIJi
0mwWAQCVgXlcuztMUaj+vUYBVR0Uq5Xq2C4jK/ao24lMy8wEIQD+JiJQQoX+cszP
esUPn0KXW8gNd8xDXqQrm0+EQRNtdgY=
=hxLt
-----END PGP SIGNATURE-----

--vP5ooK5Cnuawf+D0--

