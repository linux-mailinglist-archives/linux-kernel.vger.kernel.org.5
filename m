Return-Path: <linux-kernel+bounces-72622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324D85B655
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08027B26159
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129495F465;
	Tue, 20 Feb 2024 08:55:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAD5D758
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419332; cv=none; b=i8PL56XFnMv2QOBuxxixdw5BDunbnvsxKei6M02LhlUdqorGchf2WiPrR+oYXHKjntmC3F0mNFRgQDj3Da4ZY4s48EFydiKnMLWg2XpEY1wIUqRdCwHapjbf2R0cvRRfc2AQ1aQdh0+6N43VvM+DJ/NhFj/8JbuIjfuAo8E7SJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419332; c=relaxed/simple;
	bh=saIJiiXqg1gft1yqsE9WJd4aKBYgkGy99q4iLko4Hzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THMOu1g9sBffYYKptVXgPum0C5gxiPd1zrKOP64ZzqSmzIuVK/UV/MC2xm8pz5NTPStS/jP/TnEyGV6cwk/8Nt+1kRTCwzsU6VeZdV3zYziEgs2CYa2kZQKbKFIPSt3IU60Z47jE9rhWXABGURrjk9ZbYCWRJKaK+/KmEz6UVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLuO-0002zB-0W; Tue, 20 Feb 2024 09:55:24 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLuN-001oHi-AU; Tue, 20 Feb 2024 09:55:23 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ED82C292F85;
	Tue, 20 Feb 2024 08:55:22 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:55:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: raw: raw_getsockopt(): reduce scope of err
Message-ID: <20240220-demotion-upcountry-1929fa096489-mkl@pengutronix.de>
References: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
 <CANn89iL7N-1zvBBLoz0qhCApVJRF1LKu=jSyC0yz-wHa3JLGNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zu7rus2awvrtgxvo"
Content-Disposition: inline
In-Reply-To: <CANn89iL7N-1zvBBLoz0qhCApVJRF1LKu=jSyC0yz-wHa3JLGNg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--zu7rus2awvrtgxvo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.02.2024 09:25:58, Eric Dumazet wrote:
> In net-next tree, syzbot complained about a bug added in
>=20
> commit c83c22ec1493c0b7cc77327bedbd387e295872b6
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> Date:   Mon Feb 12 22:35:50 2024 +0100
>=20
>     can: canxl: add virtual CAN network identifier support
>=20
> Patch to fix the issue has not been sent yet ?

Done, it's part of this PR:

| https://lore.kernel.org/all/20240220085130.2936533-9-mkl@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zu7rus2awvrtgxvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXUaPcACgkQKDiiPnot
vG+u/Qf6ArlJZ8OXjNG1q4O9+Vl+n3A0ODtuOnj0lSuHdh4YVwpf0yNkZrMyKmqe
Z+9tYR3rz46Iii2um+DB9tsARVQxvjkP3bqVR4LWuuTOQTOj1rSEV1VQd2ljR/+i
Cum8LOvRkLsmE9AS2/QWSsnZhc0reXN5XKW2fcOZAXtj75x6dhAXFCC0SnuYouG8
vm5K39P1owWj6wsNX/IfGZ4C61k/MdG4rMUxP4jLi5BwIw2QxADAs3WTSPZNOCfB
Y88zQPSR7tceDdmSNJuImmS2bixcbm0cuNr6ENjC/vMAUTPVpVyLLqEGDrdUyr+3
RXrTlxozY1XNkFVDiXDTs3PgVhk2NQ==
=jrOD
-----END PGP SIGNATURE-----

--zu7rus2awvrtgxvo--

