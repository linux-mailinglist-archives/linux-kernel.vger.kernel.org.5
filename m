Return-Path: <linux-kernel+bounces-98187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7920877638
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B3A281449
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B3200B7;
	Sun, 10 Mar 2024 11:21:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC691EB23
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710069662; cv=none; b=tGqtWv59utmvE/TK833In0SeiI+fD+lMRH3BIvMdCy/nxmmmxoaJuRMJC/CxWw8DDWahxQ8HQUNojlYzVgOouPe0PxoLh9haOqb36iqDevXIkZQPjOQ8iYjror0J8QXwCBGWAhcRCH5qbPX+uA1T3f3Powk9AsOA9G3mo7C1tRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710069662; c=relaxed/simple;
	bh=1lo6Ufa9Y9sMpEkHeCVyy0nzTlREwq9VUjUqovb3NiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk70lhCljqqcHWQVhFvLq41W/6QoBmb8iHyg7cU8fKJEGNmSCB4Ji4Csoj6OFwlFPPlWd9mMehrjtGCR7lCHfBjEZ8o0HMpEZSfZExJ2f3WVdmKTOSSZlysieM4Wyuey0+vL84LuohhOJljVgWybJmc5/irzE7sZ1vq6CircGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjHEQ-0001CI-P0; Sun, 10 Mar 2024 12:20:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjHEP-005VO1-1y; Sun, 10 Mar 2024 12:20:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjHEO-003OnK-35;
	Sun, 10 Mar 2024 12:20:40 +0100
Date: Sun, 10 Mar 2024 12:20:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Roy Huang <roy.huang@analog.com>, Ash Aziz <ash.aziz@plxtech.com>, 
	Mike Frysinger <vapier@gentoo.org>, Seth Levy <seth.levy@plxtech.com>, linux-usb@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] usb: gadget: net2272: Use irqflags in the call
 to net2272_probe_fin
Message-ID: <hycmac4toie3uk7xvgrgqrcw5f2vi2sm4j45ca5coc4qs7orec@gtigekcag6d6>
References: <20240307181734.2034407-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nsvuqs7gnggucupu"
Content-Disposition: inline
In-Reply-To: <20240307181734.2034407-1-colin.i.king@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--nsvuqs7gnggucupu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 07, 2024 at 06:17:34PM +0000, Colin Ian King wrote:
> Currently the variable irqflags is being set but is not being used,
> it appears it should be used in the call to net2272_probe_fin
> rather than IRQF_TRIGGER_LOW being used. Kudos to Uwe Kleine-K=F6nig
> for suggesting the fix.
>=20
> Cleans up clang scan build warning:
> drivers/usb/gadget/udc/net2272.c:2610:15: warning: variable 'irqflags'
> set but not used [-Wunused-but-set-variable]
>=20
> Fixes: ceb80363b2ec ("USB: net2272: driver for PLX NET2272 USB device con=
troller")
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nsvuqs7gnggucupu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXtl4cACgkQj4D7WH0S
/k4YHQf8Dde9ohuB8pl8cPyQtzLgarlGSXTb6nDXSoQO1UA128zHw7Aj2rGHThMq
xeeodRSsqpQRLpz/ANWuDpCgBRSGcDagzYBDCKFj2oBfIzmNOkAGVFBq2Sf1K6Ai
Mj+lObCZFRG5vLAENcII3I2bghO8hPSnbZEwgvYbKaTdZwXKExf/oxJzb+KyxlpT
AS+FNRu/ZxYajiL9nZbWjSmMNVuzGdUFrYJP8IQmLCgGj6JYsf7ur7v1/dFy3S4G
E5SokdH9QlDoJyJ1Vx1sXsVVU6m//YGF0F/IOGpQuwhKwImjpF4tdy/zvbnlf9fh
5Ehlr5FfggTzLqNWnkWOrOOwuaJaFQ==
=POC+
-----END PGP SIGNATURE-----

--nsvuqs7gnggucupu--

