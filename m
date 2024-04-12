Return-Path: <linux-kernel+bounces-143312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1978A3713
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E80285061
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0A199B8;
	Fri, 12 Apr 2024 20:30:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1AD27E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953829; cv=none; b=m0aaGMBZ/ketFxE2KJgAnTLjqIqnvAcUujlMBW3qjcIYXPDJ0Pt9VH9JB1JjNiFIFtt/WgldlMimfiwYjsGwCdyDclraJaSHRBF9ea26BVnNS28bYVUA1XSSisB/eUqSu8Wms4XpPk13I70kN5HuOL/f26ida4ji677eOiLhl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953829; c=relaxed/simple;
	bh=Cs1zT7/fjRjge6O3CNoa3M5uBsQMm5ploTrUE1rc1n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu8XDKCPLAiiLmu2rpM3/b27v2AViEdzacZr88iHk2t57KmFU85/xdpfdozAxRlGh43HKeNOPmROvVoXv2rtmYF0L3xCRS0JaQDskPrn8ursLW6PAnPOkqiJ7+CPHK1bFpwGgh9WtXieracyXIYyU0ctQ/8rjmYMkCE/dlRUcC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvNXM-00014Z-WC; Fri, 12 Apr 2024 22:30:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvNXL-00BwIK-JL; Fri, 12 Apr 2024 22:30:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvNXL-000N6u-1d;
	Fri, 12 Apr 2024 22:30:15 +0200
Date: Fri, 12 Apr 2024 22:30:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Make dev_err_probe() silent for -ENOMEM
Message-ID: <osr3czt5hnosryz67xqoai2fok2osronpb7ickfe3hfe6bn627@ekidtnmqu6qi>
References: <20240412164405.335657-2-u.kleine-koenig@pengutronix.de>
 <ZhlmpPNbEMRye2wZ@smile.fi.intel.com>
 <cl5fmton3n5ayzr7ondnw7lzjaxoppyqhnoervj2fn4et75ish@cyko4abxbslg>
 <ZhlqUdywIur4dzgE@smile.fi.intel.com>
 <zjk3vnydp2yip343khmkq7v5vqbib6d6eyee6tx6h5nph4blzn@c26yrw2cqrt7>
 <Zhl0_8whWU1ftFeJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="454j43ssc3prmpek"
Content-Disposition: inline
In-Reply-To: <Zhl0_8whWU1ftFeJ@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--454j43ssc3prmpek
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 12, 2024 at 08:53:03PM +0300, Andy Shevchenko wrote:
> Hmm, but why macro? Shouldn't compiler be clever enough to see it even for
> the exported function?

If it's in the .c file only, the compiler doesn't know about it when
compiling the dwc pwm driver ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--454j43ssc3prmpek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZmccACgkQj4D7WH0S
/k6jNAf/bVIC3/s1ikuJGlsCMDg2EYaVKxhXraHv68wJqqeakFnEcXYHEyWXBG2+
osmNIeBScDf13TL4JOjoXmXFlrP4vVNbwryKnKlMEmcgcPQdpY04Kbn1WMwnHlv7
F58+OeyDn0MC09Lwl5sUL+WaiOM+TLyfgDx543HyL/YhzzX/PxQn6YaXYAOHmJiF
XYgSfXlWkATetd7JCi/s9WyAzDAk1KK8zfZOg536E/fK1YDU7iqaoImgf50cITj6
jEcUwZJNg5DBQxOuFWMMp72fk5tVx2p8yVUsyYuDREkthHz1luWknfR5xj8cKwQd
g8Zam+eaRV1qHkq4sHmM3b16OsCcaA==
=rCYj
-----END PGP SIGNATURE-----

--454j43ssc3prmpek--

