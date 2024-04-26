Return-Path: <linux-kernel+bounces-159556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 579298B303B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8993DB20B83
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F76813A86E;
	Fri, 26 Apr 2024 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="l+Fq2O0Y"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB113A410
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714112386; cv=none; b=CXMiai8Phl64LH6G52VOLaicRTHIrMrkquYYgV7MNPUEZKX3UhFaIp+meq5wzvpcW2KvGAK5pJUfp9uEj19i0VQfj7Y3Jgvxe4kLhC4zv1mqL0RC08i3AcXT1yk2cqWY/uP86d1jqW9enDjzlKnlcIwdvpPVKh2ny4I6Yzh5LuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714112386; c=relaxed/simple;
	bh=NakUqPs0Bx8BpxVRKcNGY6/dMld3fbtoSGn6XZzrows=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elhlluNobxtX7Cd0hnhaJc0G4UPcONqzdy0N8MOJh1qP9ZnvzW78DNoym+WCmyzSCPf1lfi0bnPITBNEJ2pf0IhVuNYgwC1UTPQb/SfZdyO57cS5eJHVxZ37Xb1gOWsKJc5lDlV6gXlbERazQpiEYvJ5Wn9MwYZAI4tcZ60DVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=l+Fq2O0Y; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=NakU
	qPs0Bx8BpxVRKcNGY6/dMld3fbtoSGn6XZzrows=; b=l+Fq2O0YuKoHpPGoFKUX
	OXhhEMBeOdUcM0Zwl/jupZTlpSw6mOyqIICctQOG8kO2OlPLv6AObmM5A+J0LCPk
	QoeBqcEX9czeKddaEGE7OfVx3RYLKyHoNAmg1+Qpasqq2AqgJtAm3AYn+oCJqoUG
	E4ZQtxgeW6efG4P17gT+95orJaFL0eEr+PiCYLNF3AqJzAok3rdAUMqTgkxleNSY
	kVvNNne31v7qg9ufxlDAhPGc1Z8Ke+ATtNySEEKGjIuTVWAidmgE05EOn07Kdbzl
	ZtcJm6bAMGixMaLJwfmQ61MZcPNRsFQT92yMosxWsH2kKZgTXoTLgHiHZX5Re5hs
	qg==
Received: (qmail 1197016 invoked from network); 26 Apr 2024 08:19:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Apr 2024 08:19:41 +0200
X-UD-Smtp-Session: l3s3148p1@hr+S4/kWKMUujnvp
Date: Fri, 26 Apr 2024 08:19:40 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Set the SDBUF after reset
Message-ID: <20240426061940.un6ezs3k4mdcalax@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>
References: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFovRYQOCM8UqFcsP+MiUd2ViKJhgHUMH6hgBiqtdBxmkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vevnq5ydnb3hx7dg"
Content-Disposition: inline
In-Reply-To: <CAPDyKFovRYQOCM8UqFcsP+MiUd2ViKJhgHUMH6hgBiqtdBxmkg@mail.gmail.com>


--vevnq5ydnb3hx7dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 07:08:10AM +0200, Ulf Hansson wrote:
> On Wed, 10 Apr 2024 at 15:54, Claudiu Beznea <claudiu.beznea@tuxon.dev> w=
rote:
> >
> > For development purpose, renesas_sdhi_probe() could be called w/
> > dma_ops =3D NULL to force the usage of PIO mode. In this case the
> > renesas_sdhi_enable_dma() will not be called before transferring data.
> >
> > If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
> > call from renesas_sdhi_probe() will configure SDBUF by calling the
> > renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
> > tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset(=
).
> > If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
> >
> > To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
> > renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
> > removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
> >
> > Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
> > Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Wolfram, when you have the time, can we get your opinion on this one?

Sure, I'll try to squeeze it in today. Thanks for the heads up!


--vevnq5ydnb3hx7dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYrR3wACgkQFA3kzBSg
KbZ8TQ//XcvAOylYC6tL3yAmwT3eiXpVg8Q0YiaF2QkrLHEM7U202OFUcYGcPl/h
0h5jYLGD7qX+MZ/HNL6wBKJakijdALpehMwMZMEqPNCTUMHgldjUxjnmB+WVr3Fz
wquaxnbNr4+kDrBhBGQgmoSwLerfWvBnV4moCrCX95JTP+Ze9ASyrYHpLg+TP/Dw
PbnA5RxZoCgBukA+hSs8NOUDNRSlX669Stt79v90UEuK/AuEbDTflUdGpRYZSaP9
elBQBCDxpWAuXDEhXohSkdUSsx8GBx1GNezhz1CuFJI5XeBdczq/y9M3c7BC3D9t
9AXRozdCTMFJY+njJYMTgi5D7fl2EcrVy8ix1iqDq9NMUswBOX0NFUcPnKN7JMay
qOI4c7C9Zx1Zjo8m4dfI+yR5vWThyxD0MpWkKXG0igNJv0yje8GrMn8l8/iqqbvi
M8JHVYjdeDR2JzT95cvfTw15wugqa6Da1m65vnQ5MPqV5jcdYh/e2qEjfb7AjkZN
9Z4yJa2bLgag2VYnD82PiymRJ1buz25XANMGuMiYeUy7CekGI3ljFRQk3d9KFjAW
kI3QcihUGNvjYrgxpdtnnE67XPv2p/Hacjr0QDbSQAgeaWBfvwvTG09xNI4bKLys
S4Bbq31DUyKeYrCElXIn10T9/Im4fi4sQwUPV77wif2j6Y4tacg=
=zYpH
-----END PGP SIGNATURE-----

--vevnq5ydnb3hx7dg--

