Return-Path: <linux-kernel+bounces-143098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1D8A342F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB5D1F23057
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D96D14B093;
	Fri, 12 Apr 2024 16:57:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0F14A09E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941045; cv=none; b=AePfqMM04RbhLvu1/Z+DyPJ3kIxvT0nQVw486UCci7jT92lnkiBOCAL/lh+EYo0jt8bcDmhVzD6vSCodm6L790uoVo0uHtrCTObqZjRrOfM7TmiMAaiWD16mKwWv8tirsWtlUrltC9k4x49PSPjtSRf2X8I4ONCP4ORGJcBQX/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941045; c=relaxed/simple;
	bh=i2Z9fAFvOda3bJQ96U5BgCIGm8zg4hWmqFq3u3tJpJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5DcFDBp1yEK+Ubgffzz9TYASj1hMqnlq13eRo18GyRc7JUgH2ykEoBFd0Cbi0cG3/walsM334+TaEDhUDuOHjMhfWKy7jMPeMmfT8VJwF1xTgT/oIkFNsTm77de2Lvl9ZYZoq/kuDd7zeLKcv8zv51U5fnwktFed6gW+9gmEAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvKDF-0003e0-5Q; Fri, 12 Apr 2024 18:57:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvKDD-00BuVS-Vy; Fri, 12 Apr 2024 18:57:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvKDD-000ICp-2v;
	Fri, 12 Apr 2024 18:57:15 +0200
Date: Fri, 12 Apr 2024 18:57:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Raag Jadav <raag.jadav@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <drz5rhytvwjpsywdspdr3q6vqeo2g5icq3th3cx5awbvqcr6bt@quxusf4jafc2>
References: <20240412060812.20412-1-raag.jadav@intel.com>
 <zf74jdjza2kfgmiecmlwlws46fmy3rtxvcocmkwewgx64oewpm@xfyq2zt6ts5u>
 <ZhlUFZDTQum5-AIR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pzdbva5yjpjhd3hq"
Content-Disposition: inline
In-Reply-To: <ZhlUFZDTQum5-AIR@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--pzdbva5yjpjhd3hq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 12, 2024 at 06:32:37PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 12, 2024 at 01:12:48PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Apr 12, 2024 at 11:38:12AM +0530, Raag Jadav wrote:
>=20
> ...
>=20
> > > +struct dwc_pwm_drvdata {
> > > +	const struct dwc_pwm_info *info;
> > > +	void __iomem *io_base;
> >=20
> > .io_base is only used during init time and so doesn't need to be tracked
> > in driver data.
>=20
> It's me who asked for this specific change and I think it's still benefic=
ial
> as it allows to simplify the code.

Ok then, feel free to keep it for v2 then.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pzdbva5yjpjhd3hq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZZ+oACgkQj4D7WH0S
/k73Cwf+KsGOLSfnUd/wJy4xv7VEgN6qzyjbD9djHVctd2ocVTXFBsx/vHoFplcF
8JBf9d7Hzn/K1RMg1f39cgcIJo6UFvTJvZ75S1vIHpY5b5yQLpkOOpUEqI1zPbd0
W1pphxiIFNkhp7ZWVycyNubNbN7zbAhvzJrdRszq3lKr1DioEs076eVPkp/eAxB9
v2JXzPvh5b5cg/VbyE8pZ0RKA/EEsc6ZnjGGP+0DyTix0GDm3ShSlof8KNy8D4yp
rykZ5aSuh3weldZhXCWRJDR5U0wSpTt3mjmQKokoEXD4JEXxtJJmC68hU1IeRGvu
kXkcQLUGulEdyybpNIqu8wbqxiPqIw==
=7TW/
-----END PGP SIGNATURE-----

--pzdbva5yjpjhd3hq--

