Return-Path: <linux-kernel+bounces-31544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F460832FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825CE1C24184
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E76556B67;
	Fri, 19 Jan 2024 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="NinSCgGW"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335D1E4A5;
	Fri, 19 Jan 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696365; cv=none; b=X+fHP4NmzXOpwgZSNY9i2syp1aSuWCT403IpM5lV3fP+Di5wjxkGbqGQxZbCOdvuNKpWcNQ0pdpBKNEIBHo9BokhMVb273Zg8PlvKsRO+24fjtpV3e4WFeDR0DjR9IqN6UyoQQoXpnFEwdgC+CcgfZP027yz9q6TzekWDgchLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696365; c=relaxed/simple;
	bh=+T57t4scphjXmREAryQ2RC2KLCJQWNQkLcAGX8d3N2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMw5I8DqpSFx7FKvKz7yRc1Di0bv1wEAFY/wL7DNFRnjknWtgh8TqQqFWsy5N5ohnqUr8AmQUgJQbChAX/2/1Xua/f7OktN0UMUZosXSQPfpx+YBz/xO3utBR0C54UMDsYtU/YV6qOK1x9SkVnSy2KliP0lMrTOzlDEHXp60tRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=NinSCgGW; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4A3841C0071; Fri, 19 Jan 2024 21:32:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1705696360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Z4zR8u3nm1rRi0zh1NzLoJEZgyLkftEGi5YnT+0UVA=;
	b=NinSCgGWEItpLCFK8x0Plbr7ic7jnW5Xg2ZYjXsM9w+gtEy+UAh0BsWBQQmUsCq0s1Gcrb
	FOduxoV6A0sLjTsiMplEkepm1nA1DYNxTGdAr5mftTcmZ2Sv1lYCUFw8kVsfLir6lEm9Eq
	t4D01rdmcjk2BoWgz1riHNWdItpC4+Q=
Date: Fri, 19 Jan 2024 21:32:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>, jikos@kernel.org,
	Jelle van der Waa <jelle@vdwaa.nl>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linux-input@vger.kernel.org, ojeda@kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
Message-ID: <ZarcZwQd/2EXjgZP@duo.ucw.cz>
References: <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
 <ZaljwLe7P+dXHEHb@duo.ucw.cz>
 <6bbfdd62-e663-4a45-82f4-445069a8d690@redhat.com>
 <ZarYSkzISyS+wuYR@duo.ucw.cz>
 <36973f9d-bf67-417d-998c-ce24c38322c3@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/ZMJYiWSABC/ttn2"
Content-Disposition: inline
In-Reply-To: <36973f9d-bf67-417d-998c-ce24c38322c3@tuxedocomputers.com>


--/ZMJYiWSABC/ttn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > And then storing RGB in separate bytes, so userspace will then
> > > always send a buffer of 192 bytes per line (64x3) x 14 rows
> > > =3D 3072 bytes. With the kernel driver ignoring parts of
> > > the buffer where there are no actual keys.
> > That's really really weird interface. If you are doing RGB888 64x14,
> > lets make it a ... display? :-).
> >=20
> > ioctl always sending 3072 bytes is really a hack.
> >=20
> > Small displays exist and are quite common, surely we'd handle this as
> > a display:
> > https://pajenicko.cz/displeje/graficky-oled-displej-0-66-64x48-i2c-bily=
-wemos-d1-mini
> > It is 64x48.
> >=20
> > And then there's this:
> > https://pajenicko.cz/displeje/maticovy-8x8-led-displej-s-radicem-max7219
> > and this:
> > https://pajenicko.cz/displeje/maticovy-8x32-led-displej-s-radicem-max72=
19
> >=20
> > One of them is 8x8.
> >=20
> > Surely those should be displays, too?
>=20
> But what about a light bar with, lets say, 3 zones. Is that a 3x1 display?
>=20
> And what about a mouse having lit mousebuttons and a single led light bar=
 at
> the wrist: a 2x2 display, but one is thin but long and one is not used?

So indeed LEDs can arranged into various shapes. Like a ring, or this:

 * *
* * *
 * *

https://pajenicko.cz/led-moduly?page=3D2

Dunno. Sounds like a display is still a best match for them. Some of
modules are RGB, some are single-color only, I'm sure there will be
various bit depths.

I guess we can do 3x1 and 2x2 displays. Or we could try to solve
keyboards and ignore those for now.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--/ZMJYiWSABC/ttn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZarcZwAKCRAw5/Bqldv6
8vorAJ44jwibpMssWa1IOTj5wgRqgYAdpACgsblb5qNdHeBKVZp9qFNQLdR24uQ=
=Qwmz
-----END PGP SIGNATURE-----

--/ZMJYiWSABC/ttn2--

