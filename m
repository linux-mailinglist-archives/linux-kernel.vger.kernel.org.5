Return-Path: <linux-kernel+bounces-30436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56623831EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB817B248C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D542D059;
	Thu, 18 Jan 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="D8YVA5Wu"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B892D03B;
	Thu, 18 Jan 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599942; cv=none; b=SJDmUQYshjd7ZSuHeCzea+5Wj3j0lSJloSydFfmQmgaNtZq6FSUFPPfMthUugHgdtpvNLUkDhjdi7s5E5zSYtRLI6FGEp1X/7zzz6ilQ6M+Ql/FuXveCFT3zNSOiyS1FlC17ay2J6NvALBmxmo8bZfBcj6MEswFo/B/u+n7YGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599942; c=relaxed/simple;
	bh=RyY3iug65fvKTAhGTPkBeOA+ALdT0Buumyxgvxot7Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3DxURNUPuxgV2spdDOexF14BDySi0qpmk/v7QnUAII7jYQILKSaEIt8YivD/5Teb/lmE+t9toJNpVVOUDHbVGR+NYwooNUKIDX821Zh/yRoOogztrn+9R/x+S/CMIB2+StO+SA9q/Ob4IjfDHq/YS8+Hrg/zm5H+SY9VZerSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=D8YVA5Wu; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1B4181C007B; Thu, 18 Jan 2024 18:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1705599937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s2decVdRnW3kcXYTXMhZ+4hppOm4DXM8+5MfDGDRqr0=;
	b=D8YVA5WuCkS7PJEvNxOIdAa/kR3li8rbSqVyqKK2zs7wjQsV8Yp/VEOyRtTkA+EN1vHW65
	h42g8hGwRL52WcKdxl9uzxBYVMIIne5rcj6FGkBAXn91gTkWsj8rKMcLuTsIZ4ltqcn+WL
	bQ/UOAGQXnRNJ7mcre5KkuxaHXR1Cv4=
Date: Thu, 18 Jan 2024 18:45:36 +0100
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
Message-ID: <ZaljwLe7P+dXHEHb@duo.ucw.cz>
References: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz>
 <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com>
 <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9D/I+LN93effYwNd"
Content-Disposition: inline
In-Reply-To: <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>


--9D/I+LN93effYwNd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We have an upcoming device that has a per-key keyboard backlight, but does
> the control completely via a wmi/acpi interface. So no usable hidraw here
> for a potential userspace driver implementation ...
>=20
> So a quick summary for the ideas floating in this thread so far:
>=20
> 1. Expand leds interface allowing arbitrary modes with semi arbitrary
> optional attributes:

> =A0=A0=A0 - Con:
>=20
> =A0=A0=A0 =A0=A0=A0 - Violates the simplicity paradigm of the leds interf=
ace (e.g. with
> this one leds entry controls possible multiple leds)

Let's not do this.

> 2. Implement per-key keyboards as auxdisplay
>=20
> =A0=A0=A0 - Pro:
>=20
> =A0=A0=A0 =A0=A0=A0 - Already has a concept for led positions
>=20
> =A0=A0=A0 =A0=A0=A0 - Is conceptually closer to "multiple leds forming a =
singular entity"
>=20
> =A0=A0=A0 - Con:
>=20
> =A0=A0=A0 =A0=A0=A0 - No preexisting UPower support
>=20
> =A0=A0=A0 =A0=A0=A0 - No concept for special hardware lightning modes
>=20
> =A0=A0=A0 =A0=A0=A0 - No support for arbitrary led outlines yet (e.g. ISO=
 style enter-key)

Please do this one.

> 3. Implement in input subsystem
>=20
> =A0=A0=A0 - Pro:
>=20
> =A0=A0=A0 =A0=A0=A0 - Preexisting concept for keys and key purpose
>=20
> =A0=A0=A0 - Con:
>=20
> =A0=A0=A0 =A0=A0=A0 - Not in scope for subsystem
>=20
> =A0=A0=A0 =A0=A0=A0 - No other preexisting light infrastructure

Or negotiate with input people to do this.

> 4. Implement a simple leds driver only supporting a small subset of the
> capabilities and make it disable-able for a userspace driver to take over

No. Kernel should abstract this away.

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--9D/I+LN93effYwNd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZaljwAAKCRAw5/Bqldv6
8t2rAJ0bXGLlIcltuLM/IFy7NcEBaumlcwCcCEGqrSVmOZCnA82+Y9Rt7Thq3Bw=
=6pEX
-----END PGP SIGNATURE-----

--9D/I+LN93effYwNd--

