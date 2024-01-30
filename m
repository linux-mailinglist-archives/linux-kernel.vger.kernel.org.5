Return-Path: <linux-kernel+bounces-44666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793258425BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1812B2D10C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2796A355;
	Tue, 30 Jan 2024 13:01:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CCB6A337
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619714; cv=none; b=ToLcP9TGiw2TRDKuFjSZtfasPUocU97Vr9GS3CmR2A2KKAPGtqi3slfoCw6lD+/lQDn5T520TtQ8a+Vk8wDz1XCMWtUp7YumzSf6Op3IeJ/XchowE4gj2nuw4vyN+7UBeOJ9597G/ywmuZzJv+sYj4J7SJIgChNCEdrvZmUkojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619714; c=relaxed/simple;
	bh=A1ipchrz8gQoxwvqpWNrh58UUatxvyP9Y8B8dG0FZR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0PsYH1uSOma4y8ujZ21CDksaaViws6Z2/YjOgDIWnYw6vVLLxWB9kZgT+2zmFA9JN6Oht/H+hQaQ2VFrb7c//D6myxmSdCv1z0ZHs/VrivoMJn6OKT3Wz9xULmMAEDty+eaXIhEG4inTgawIvqVsq6suRLjb5Wn/cwejQ/7gkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rUnjk-0004RW-00; Tue, 30 Jan 2024 14:01:12 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rUnji-003Phu-6h; Tue, 30 Jan 2024 14:01:10 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B2018281751;
	Tue, 30 Jan 2024 13:01:09 +0000 (UTC)
Date: Tue, 30 Jan 2024 14:01:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Daire McNamara <daire.mcnamara@microchip.com>, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: can: mpfs: add missing required clock
Message-ID: <20240130-fragrance-disinfect-22cc1911bf48-mkl@pengutronix.de>
References: <20240122-catty-roast-d3625dbb02fe@spud>
 <20240122-breeder-lying-0d3668d98886@spud>
 <20240122-surely-crimp-ba4a8c55106d-mkl@pengutronix.de>
 <20240122-cruelly-dainty-002081f0beb2@spud>
 <20240122-smokeless-ion-63e4148c22e5-mkl@pengutronix.de>
 <20240122-uncoated-cherub-a29cba1c0035@spud>
 <20240122-pogo-reputable-b1d06ae1f1f1-mkl@pengutronix.de>
 <20240130-narrow-lyricism-8b25baac7bb2@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f4vw5ea6lcxcee4m"
Content-Disposition: inline
In-Reply-To: <20240130-narrow-lyricism-8b25baac7bb2@wendy>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--f4vw5ea6lcxcee4m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.01.2024 12:11:44, Conor Dooley wrote:
> On Mon, Jan 22, 2024 at 04:31:32PM +0100, Marc Kleine-Budde wrote:
> > On 22.01.2024 14:56:09, Conor Dooley wrote:
>=20
> > > I think we already had this discussion on v1, where I said that the
> > > binding requires the clocks to be in that order, regardless of whether
> > > or not clock-names is provided. You feel more strongly about it than I
> > > do, so I will add them when I get around to sending a v3.
> >=20
> > Yes, this discussion sounded very familiar to me, never mind. Keep it as
> > is, and let's get this binding and the CAN driver upstream!
>=20
> BTW, I didn't see an ack on this nor do I see it in linux-next (yet).
> Are you expecting the patch to go with the rest via the clock tree,
> via the DT tree or will you be taking it with CAN stuff via netdev?
>=20
> I can resend this one patch with a netdev appropriate subject prefix
> if you like.

Feel free to take the whole series via the clock tree.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--f4vw5ea6lcxcee4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmW48xIACgkQvlAcSiqK
BOh05ggAtrkirkvFxfCZmmZ3aogx7JpH2jGUD/uWcu+/to8Esew52WV5+k+a3PFY
yxF+BD27a4/qjz5d6+KlUy58RrTj18KJIT0PoLwfFTXPUrdqBVD7MYok3u3eWVkR
Y5CIFBKQTCVBOCsnOPaEjrI6SIqpgJedEJeEhRm8hObb5a9EZR82GkYW2NSojYZj
8bhFtoSuUlgZ5Qiqo1DIZct1verZ0pTjbFsDTtGzlrOKQ5zxalbZKgr+Qpofpbfz
aSBQCch6ZW+m3fxuJP4S6V6NQIwI14HQIbR1xysbciRy5hn4I+PczwLPhHx+VgQr
5nBdDcwbEHBxlsqMSPbp/65xsStnYw==
=foUg
-----END PGP SIGNATURE-----

--f4vw5ea6lcxcee4m--

