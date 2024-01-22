Return-Path: <linux-kernel+bounces-34179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A1B837546
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010461F281C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD947F73;
	Mon, 22 Jan 2024 21:29:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4447F64
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958958; cv=none; b=teZ+txve78jJka8ZnIiBSY3l4KBHBxgcJRsq+Uo+qx2Uw/t2wtxYTxHKYkl8Vr4EFTJfh5FW60jzfOJvtoHZfUgc4BpPP/zzpSVR4+1BbqoRbiGo1n1tdiw8hxrWgYprxF6Sna6xxFUUKpDO0hO14wq1b4GKvScUVbby1LIZ0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958958; c=relaxed/simple;
	bh=q2ZzATdMD+D7lCgML0/NsVHxerbvCAXMrcJCKifmWVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTca82AqSr3YXxiMU+aZYIboD7eMYj3f51ZcH5vp02r1ZWxqMOEvkBIFPyRu3sIElgi1rDv80zTbW2AeVo9PbMrzuucvFJgVudJ5MXVID9kh7I+JRYUPYb4+sG7wbDfrTgwUBUWVDNnxULVUztffQN/fV1PixthfQUTNzFh5kek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rS1qv-0000Ho-PR; Mon, 22 Jan 2024 22:29:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rS1qt-001ga9-T1; Mon, 22 Jan 2024 22:29:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rS1qt-005hn7-2b;
	Mon, 22 Jan 2024 22:29:07 +0100
Date: Mon, 22 Jan 2024 22:29:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, kernel@pengutronix.de, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 13/33] mtd: rawnand: fsl_elbc: Let .probe retry if
 local bus is missing
Message-ID: <33kxj5ij25bzkyhuww5kane2sb2f3euyq3uoudlgegfks3xs4f@ru24kc6z55je>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
 <41a042207ef791c4c5bcb46f09f63c40c6aa321b.1705944943.git.u.kleine-koenig@pengutronix.de>
 <20240122191931.17807644@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wpw5yp3sgfojkufj"
Content-Disposition: inline
In-Reply-To: <20240122191931.17807644@xps-13>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--wpw5yp3sgfojkufj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Miqu=E8l,

On Mon, Jan 22, 2024 at 07:19:44PM +0100, Miquel Raynal wrote:
> u.kleine-koenig@pengutronix.de wrote on Mon, 22 Jan 2024 19:07:08 +0100:
>=20
> > If during probe fsl_lbc_ctrl_dev is NULL that might just be because the
> > fsl_lbc driver didn't bind yet. So return -EPROBE_DEFER in this case to
> > make the driver core retry probing later.
>=20
> Despite the probable usefulness of this change, I don't see any
> relationship with the current series. So unless there is a good reason
> I might take this one through the nand tree.

This patch indeed doesn't belong into this series. It just happend to be
in my tree and shuffled into the middle when I sorted the patches by
subsystem. Note I already sent it separately at

	https://lore.kernel.org/linux-mtd/20240115141245.3415035-2-u.kleine-koenig=
@pengutronix.de

> Also, what about a Fixes/Cc: stable tag here?

The problem exists since

	3ab8f2a2e701 ("P4080/eLBC: Make Freescale elbc interrupt common to elbc de=
vices")

which was included in v2.6.37-rc1. At that time there was no
EPROBE_DEFER yet. I think I wouldn't add a Fixes: line for that, but
feel free to add one if you think there should be one.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wpw5yp3sgfojkufj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWu3iIACgkQj4D7WH0S
/k46Fgf+LprTnc7f6tqg7kcdC7LeG2KTK7vIZ1pjmaQZRz1lnlpCnTrHGPFgCHuz
CA50m2x1CNkDqx46qG60SaYDCk0/+/7HzBEhlfOt8DP+8U+qmF/aTkigmWrX6o1r
uF8FpRxF+Wf5sr32sPV98njmq9Z3rZBHJ3f9vN44TN92xlRvwSSWT/TwqL6clpuw
wV+dOL8KOmE+6jFkp5qsG9x5IRs6fvssMcLchkxuf2nHSAF5rh7NgY7TRFo7QZn6
b96c8ttoIn08z8Yl7StEnB5qhFCF2SB3YR2QRMnpGLR0p1H/f6VYncn10/pEFbu2
Nke5eCouKGSKTpSfwWDJ3LjplrnZNA==
=QV09
-----END PGP SIGNATURE-----

--wpw5yp3sgfojkufj--

