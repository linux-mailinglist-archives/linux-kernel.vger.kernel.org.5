Return-Path: <linux-kernel+bounces-143105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93578A3443
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162681C22B84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6674714BF8F;
	Fri, 12 Apr 2024 17:03:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DE54F87
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941392; cv=none; b=mwHC/YLC93rpWa6femO52ymXwu2MQMHMEnA0kSb75lD6e5WOlPZT5GCJbYI6tfujVJSjvr5TUVPUwU3IA6nKKBjPWiDTlDiaRUrRomsenPBFPDme7dHBMJxBuB1MzDYtj58LwSCLLwRxAGkt+GyJj6Em5r4uumJZCYg4z1bCGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941392; c=relaxed/simple;
	bh=kvgwigRCzWl/oJfx3mNb9b+3moYHyvu3QMTPl2ZCd9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owTOdMteszfzTqd1dtzVIY5PEjWXnj6A3zMDFnh0fjtA2bgyGOLTocDg6mwot011rLudYfG9OUsVzXdY9fmRQCo4zeMiu/AVxIo8s5+JZfsHRCYKXcFCRD3MMpvO/rgEbgZjo1mNiSBSK1T3hsxZ0XafL2laWm+tMddVyupPt1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvKIp-0006Qk-M0; Fri, 12 Apr 2024 19:03:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvKIn-00BuW1-W9; Fri, 12 Apr 2024 19:03:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvKIn-000IJ5-2v;
	Fri, 12 Apr 2024 19:03:01 +0200
Date: Fri, 12 Apr 2024 19:03:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Make dev_err_probe() silent for -ENOMEM
Message-ID: <cl5fmton3n5ayzr7ondnw7lzjaxoppyqhnoervj2fn4et75ish@cyko4abxbslg>
References: <20240412164405.335657-2-u.kleine-koenig@pengutronix.de>
 <ZhlmpPNbEMRye2wZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sbcagtoynlrbogwn"
Content-Disposition: inline
In-Reply-To: <ZhlmpPNbEMRye2wZ@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--sbcagtoynlrbogwn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Fri, Apr 12, 2024 at 07:51:48PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 12, 2024 at 06:44:05PM +0200, Uwe Kleine-K=F6nig wrote:
> > For an out-of-memory error there should be no additional output. Adapt
> > dev_err_probe() to not emit the error message when err is -ENOMEM.
> > This simplifies handling errors that might among others be -ENOMEM.
>=20
> ...
>=20
> 	BUILD_BUG_ON(err =3D=3D -ENOMEM);
>=20
> Done!

Well no, that doesn't do the trick. Consider for example device_add().
That function can return (at least) -EINVAL and -ENOMEM. To properly
ensure that the error handling is silent with the current
dev_err_probe(), we'd need to do:

	ret =3D device_add(...);
	if (ret) {
		if (ret !=3D -ENOMEM)
			return dev_err_probe(...);
		else
			return ret;
	}

With my suggested patch this can be reduced to:

	ret =3D device_add(...);
	if (ret)
		return dev_err_probe(...);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sbcagtoynlrbogwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZaUQACgkQj4D7WH0S
/k7xKgf/bGWGnsRqI5M+8/OsjvL4w+mkTlZASk12eq2pnL/pK4gZsvRC3W5CtxJ9
9b60Jdc0dSiWQ9lUUe7Eb7olo/IEfMu6AQIDUoZo0w7prNBAVHcNF8LdJe6Utaw/
gJR9Pot2y4i7Syon4CngwgJOPGLXThFDjdhpmXS2nwYnwI4ANUJSVqCLdFhe5dmp
qJYFhGmbjhtPspH13xpXNnT5dH18gjiBo0dnZ72WrcJZxpASgp1vFqvsjtAHKeGk
rd51u+3UR3le0z/YA251Ttk9igIFbMEtdP6/EQyJ40PhQx1ByFFaDQNCbIe+FN5E
ly1RhW18ChECmGRG4ZLE2hIpHHOqZw==
=1TOJ
-----END PGP SIGNATURE-----

--sbcagtoynlrbogwn--

