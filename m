Return-Path: <linux-kernel+bounces-67679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD32856F08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B2A1C21BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76DB13B2BF;
	Thu, 15 Feb 2024 21:03:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6641C61
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031024; cv=none; b=YysIsC8udOMSot2tzbNgbhW7gWWDtiLhj0HvYp7UiqlbHS3C4CW993nh17RDytrpqZgC7NGxNnJn9mTUjIN4dJJcyxEX4cNcVTerpKfH1psvyyqGelX0+K/Civ2EcRQyNfVIWsvMM6YAq7tmaAWtsEn99lhu+p7zi5em62WYmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031024; c=relaxed/simple;
	bh=VhdfpZDcEIsddO/EyQfKPvU+8LMInwZEs57nuX4AZrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsxzVBYmSxR1HXb1sd+uD2JiHxlvRer/QLxjXnaqx2bTaSYGt4Y7BXjbX0tBcRboaBHhL9Sz5Blh+KxSnpRJ8m7VVRl7zvyEVpgD7Jzw5WDOIF9XBincEgwH4rjbxdaWDJcsqAJvk+bbyuZB45g4VBT03Dd9Q/ffmyscPqrAR00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raitC-0000gM-7x; Thu, 15 Feb 2024 22:03:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rait9-000xGR-RU; Thu, 15 Feb 2024 22:03:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rait9-005eCw-2Q;
	Thu, 15 Feb 2024 22:03:23 +0100
Date: Thu, 15 Feb 2024 22:03:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-kernel@vger.kernel.org, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, patches@opensource.cirrus.com, 
	Fabio Estevam <festevam@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, 
	linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 00/13] irqchip: Convert to platform remove callback
 returning void
Message-ID: <knhwqxhouaiehmnnz5oxaxibhq7usokefztae4pplqypwuzgye@mke2irokres4>
References: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="543tsvzhxgimotst"
Content-Disposition: inline
In-Reply-To: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--543tsvzhxgimotst
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

On Fri, Dec 22, 2023 at 11:50:31PM +0100, Uwe Kleine-K=F6nig wrote:
> this series converts all drivers below drivers/irqchip to use
> .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
> callback that returns no value") for an extended explanation and the
> eventual goal. The TL;DR; is to make it harder for driver authors to
> leak resources.
>=20
> The drivers touched here are all fine though and don't return early in
> .remove(). So all conversions in this series are trivial.

I'm still waiting for this series to go in (or get review feedback). Is
this still on your radar? You're the right maintainer to take this
series, aren't you?

The series still applies to today's next.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--543tsvzhxgimotst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXOfBoACgkQj4D7WH0S
/k52nAgArzzUUBfYS1wZr/tKGMqABl7rtsR1xpM2V3NdiROGvaYALX1/ROABy83V
lo8pk8XNMuVzDEYFoMOjFhWeoT9jJ8qGk+emLXFs2gr1HwIDzptSP5nW3jSLgv1m
Y/CnadQn2wbIyxPPxPxPglktJ6kPrVcg4pllVjhi6VrwuhIi8dItD9WDuf+qVaVe
J0rHGiTF2iZvhcuIgIulliMcR9+5npsA14ZxonEQdHJ7f4Ew0LTijz14X8+rNZ4b
3Fe8/jB2MGtwxlwK6eFGEfH5SWnWqltMR4yPzGVHNIqUHrSB3BVFWzDyNnW2EAfx
d+1GXz634dPtW4JEgQNJRXcgS//+JQ==
=O3pv
-----END PGP SIGNATURE-----

--543tsvzhxgimotst--

