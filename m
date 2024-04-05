Return-Path: <linux-kernel+bounces-132761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7878999D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538B11C21129
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8540B160862;
	Fri,  5 Apr 2024 09:50:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F51A26E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310614; cv=none; b=q0txXKBMoCWkIxfarV42ygFN6FLV8zoH1NG8Y0RfGp6GT+BJSCpQ6240mm87qgonVLweIT80rxEqLSEzwaEscohoAuGuPQs4/fgYU3e1axMHsHw2Y3b2uHqtghcsu8Ux5qdnG08sKOkUxybq34X5vpEGWz0ggbdJxTwOEsFP/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310614; c=relaxed/simple;
	bh=hSWXhZbD6PA6W0zh+ZqK9opYJ0KSx0CuUh2LDJVqsug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxBMhGaoJ3EfyGhPAFvwJyduJhCvgATX+1CDu9J1D63NQxtb/rgevQeEz8vY6Lc6czsjem3OOMDlCiaTEXdtnvD0BghWHMLpsp78LYEpGNCnSxDrEOegbwSXwHKg9ANFK4epkVkgwFvYyGV+j/H4CDpfbKs+bR+nxaW+F7I8v6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rsgCl-0003Gt-Rv; Fri, 05 Apr 2024 11:49:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rsgCl-00AXqP-3W; Fri, 05 Apr 2024 11:49:51 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AE6A52B282F;
	Fri,  5 Apr 2024 09:49:50 +0000 (UTC)
Date: Fri, 5 Apr 2024 11:49:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Esben Haabendal <esben@geanix.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] serial: imx: Introduce timeout when waiting on
 transmitter empty
Message-ID: <20240405-impurity-emerald-f67dc37adf9b-mkl@pengutronix.de>
References: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rhh7y57qqxw7exf"
Content-Disposition: inline
In-Reply-To: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6rhh7y57qqxw7exf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.04.2024 11:25:13, Esben Haabendal wrote:
> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potentital
> deadlock.
>=20
> In case of the timeout, there is not much we can do, so we simply ignore
> the transmitter state and optimistically try to continue.
>=20
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Where's the cover letter and patch 2/2? Have a look at b4 [1], it's a
great tool to help you with sending git patch series.

[1] https://b4.docs.kernel.org/en/latest/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6rhh7y57qqxw7exf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYPyTsACgkQKDiiPnot
vG8gsAf/fEGSFLsAsbgzZopYqja0FtibvbPZ1dlovaaUkpMAPJxw50RrvIK4/Nor
CQYR8XnT9GiH77IUOjNphjpvJJYNXWxkvsj1U9vAYziAV+fDRCzXxYWVmJf/7MNC
gJ2EOm2FCAmlOkiRcvzeoaIIodo2465NLn9WQaWj9qbrGslgQ996WZ6bl1wu6aZG
LS4/7FK9dbdAu8w6poagajePRAYZ9U5faIiBA5ZMSegB0dHHXgUbQAzRqvCZmWVY
3qbzsy+0uvN0lz4Z7jP6tQ/8YcKl5vz/HOdYAyN2qI3yJnB+ChB71ON3RwYSSHTO
pVA/zhZztk307ZmaTA7eeWnLFBAyFw==
=BAfU
-----END PGP SIGNATURE-----

--6rhh7y57qqxw7exf--

