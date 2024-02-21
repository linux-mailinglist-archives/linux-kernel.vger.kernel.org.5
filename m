Return-Path: <linux-kernel+bounces-74885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C701C85DF13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6921C23D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F037BAF7;
	Wed, 21 Feb 2024 14:24:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1669E00
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525471; cv=none; b=iAF6w7juul4+XYXZv6C1mxRpajs9LUes+paJHnGAzEw23vWSFZ/MTelMyMU0aJQn7YZwI5tt/ME0KBK2Fep4tyDM8wpGfMNiFK9fPSFwP+U8DfncX/IC258cMtzavi9J7tqgPY2PjCTJVjCJEVh3cf+s8YD+4D41BL9Qe2BkvqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525471; c=relaxed/simple;
	bh=MSnOGaCDM31EFc3ia7dnG7DavW3wwAsIGBdVyjSyggQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq6SylcyjpMUu0TWkNlDh53x/jwo5uErRYM801wDybvbJk2HD0sKgsmh+0ioE9/IrDVJF5eozMsOYKrdZ4r5sQ/78Pw1LtJL/leT1LcoqAFWNz5qJ5WESUb7TgdJi0nMorhjggW8dDhu3hsmUqKLNLRTfwhla8fWFgqxUehwLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcnWL-0004zf-Tl; Wed, 21 Feb 2024 15:24:25 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcnWL-0023cE-AD; Wed, 21 Feb 2024 15:24:25 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EC589294BAD;
	Wed, 21 Feb 2024 14:24:24 +0000 (UTC)
Date: Wed, 21 Feb 2024 15:24:24 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
	Maxime Jayat <maxime.jayat@mobile-devices.fr>, Wolfgang Grandegger <wg@grandegger.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: netlink: Fix TDCO calculation using the old data
 bittiming
Message-ID: <20240221-garden-petted-789304a1b1a5-mkl@pengutronix.de>
References: <40579c18-63c0-43a4-8d4c-f3a6c1c0b417@munic.io>
 <CAMZ6Rq+10m=yQ9Cc9gZQegwD=6iCU=s1r78+ogJ4PV0f5_s+tQ@mail.gmail.com>
 <54afa5e8-fb5e-4d90-8897-8f3c5a684418@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="inlfg5asntdkuyns"
Content-Disposition: inline
In-Reply-To: <54afa5e8-fb5e-4d90-8897-8f3c5a684418@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--inlfg5asntdkuyns
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.02.2024 15:14:02, Oliver Hartkopp wrote:
> I have an old PCAN USB adapter (Classical CAN) which uses the pcan_usb
> driver and wanted to set a 50kbit/s bitrate:
>=20
> ip link set can0 up txqueuelen 500 type can bitrate 50000 sjw 4
>=20
> First it complained about the SJW having a higher value than some phase-s=
eg
> value which was 2.
>=20
> Error: sjw: 4 greater than phase-seg2: 2.
>=20
> I always thought the driver automatically adapts the SJW value to the
> highest possible and SJW=3D4 could always be set. Did this change at a ce=
rtain
> point?

Yes, that changed with b5a3d0864ee7 ("can: bittiming: can_sjw_check():
check that SJW is not longer than either Phase Buffer Segment")

See discussion in https://lore.kernel.org/all/20220907103845.3929288-3-mkl@=
pengutronix.de/

> Anyway, then I reduced the given SJW value and the ip command did not give
> any error message.
>=20
> But finally there was not CAN traffic possible with my "always working
> setup".
>=20
> I'm running 6.8.0-rc4-00433-g92a355464776 from Linus' tree.
>=20
> Reverting this patch fixed my issue.

But what has the tdco calculation to do with non CAN-FD controllers?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--inlfg5asntdkuyns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXWB5UACgkQKDiiPnot
vG8Sogf9GDTH+r+dpvL4+IwbOEdFwI4awCIUJ/mrGD+zql/rNCPxYWz6liDuKOJk
DnXqOSuPPBoDorLLWf58H/1pgwCu4Lo+TaJ9x1igrKpt0lFxBJ7a7FO0tcjFeE2N
jjlSukRzehY2Iqo4oL+y3ZdwQoeqFFCj/dNVISpZWDGDA3YieAyVQ2lsbd6TJVb1
Ft5eKJzNNNfuh+8uGkPQ0j9QYu7ptyTZorAKiZy5ucJYl+sRd22vXU2crIIByBtK
YuRclqXEm1aG45kQmNZB9tJsnXxFZHcFXdhnmxtrwpi23S67Fbk0DPPW0+U5mpW3
6g/I9/+HvqmGm5L1CKz+3PKQ7Wjt3g==
=7CLS
-----END PGP SIGNATURE-----

--inlfg5asntdkuyns--

