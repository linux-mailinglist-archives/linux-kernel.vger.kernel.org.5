Return-Path: <linux-kernel+bounces-151468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100768AAF47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28683B225A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0953127B7B;
	Fri, 19 Apr 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qZnu8DIG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93F12AAEB;
	Fri, 19 Apr 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533130; cv=none; b=VzuXS+DVCkxmXU0nsPKpo6daD9/tbg/IF3Q00OfeMHxmjvprIEilPejzqODi7N2sr/AWkW0v5gBLY40qHXbLP0dniGxvPAMzCFPItyXR4kFuIKpF+ocsbIa/C3PQiCgJXUKcTMXWLTnb64etmon0J2ryQ3faC03b7R6Ru997EIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533130; c=relaxed/simple;
	bh=N88JXv4IEgJGGdg4ExzP0hQMQcK9z1NkVdyG4OwVB3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dh7YdDy2b6Ek6ixbAIXHnf85iRFvmBepHB/kb2NeE3uiSjZLURYqAlQwAHmLWndPCpqBp0CnMr55z5iAumjStZEm3axToHWZ8wWAdtkt1uX2Yg6MwXyuYaQbWZzRLk6fnMTPjVuJo7sUAMgxOVM5LgUY2KRCZP7ktPtYNVZ/I1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qZnu8DIG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713533126;
	bh=N88JXv4IEgJGGdg4ExzP0hQMQcK9z1NkVdyG4OwVB3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZnu8DIGVckN5qmVu5OZqqnIpbOcGOUHkqeGi9R+zthuGdzLfARZ9mSGb8S66qRvT
	 9sUIVNrNodfyQCRddaHFaeF51xpYKKKJsivaaoq3Zhst1kuRq9ewQUsCYmdt3gBMQu
	 AWDrrs83Bw0hZWfK34wmEygmT0ninptA0BTptVhkK1j6wge1CnK1xB1jP/k7swJFKQ
	 JRlNkKgv8ixzMipohX0cjg6BoGq/8jCzAEpYts1jliFN311ylemCAtpGTcdk/I2vNi
	 CEMtFy/nOhGOjvSlNg+qaILhhq223NLWMUjDwj+GYgjPjIDQdt93qexxluROmup0jV
	 V1bKEaLr4FGvg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 68AE63781144;
	Fri, 19 Apr 2024 13:25:26 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 0E78F106139F; Fri, 19 Apr 2024 15:25:26 +0200 (CEST)
Date: Fri, 19 Apr 2024 15:25:26 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>, 
	kernel@collabora.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pin-yen Lin <treapking@chromium.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: Re: [PATCH v3] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Message-ID: <b3btqqoijplf4ezr4akbj3dd5nevlf2pzen47bzwbm424pwnci@gc3etymakduu>
References: <20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com>
 <f8c0bdd4-58fb-45a5-a70e-cc97f176222e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cydfw5cw3mawxhkn"
Content-Disposition: inline
In-Reply-To: <f8c0bdd4-58fb-45a5-a70e-cc97f176222e@collabora.com>


--cydfw5cw3mawxhkn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 19, 2024 at 09:26:41AM +0200, AngeloGioacchino Del Regno wrote:
> Il 18/04/24 19:34, N=EDcolas F. R. A. Prado ha scritto:
> > Despite the RunTimeToEmpty() (0x11) function being defined in the SBS
> > specification as required, it seems that not all batteries implement it.
> > On platforms with such batteries, reading the property will cause an
> > error to be printed:
> >=20
> > power_supply sbs-8-000b: driver failed to report `time_to_empty_now' pr=
operty: -5
> >=20
> > This not only pollutes the log, distracting from real problems on the
> > device, but also prevents the uevent file from being read since it
> > contains all properties, including the faulty one.
> >=20
> > The following table summarizes the findings for a handful of platforms:
> >=20
> > Platform                                Status  Manufacturer    Model
> > ------------------------------------------------------------------------
> > mt8186-corsola-steelix-sku131072        OK      BYD             L22B3PG0
> > mt8195-cherry-tomato-r2                 NOT OK  PANASON         AP16L5J
> > mt8192-asurada-spherion-r0              NOT OK  PANASON         AP15O5L
> > mt8183-kukui-jacuzzi-juniper-sku16      NOT OK  LGC KT0         AP16L8J
> > mt8173-elm-hana                         OK      Sunwoda         L18D3PG1
> > sc7180-trogdor-lazor-limozeen-nots-r5   NOT OK  Murata          AP18C4K
> > sc7180-trogdor-kingoftown               NOT OK  333-AC-0D-A     GG02047=
XL
> > rk3399-gru-kevin                        OK      SDI             4352D51
> >=20
> > Detect if this is one of the quirky batteries during presence update, so
> > that hot-plugging works as expected, and if so report -ENODATA for
> > POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW, which removes it from uevent and
> > prevents throwing errors.
> >=20
> > Signed-off-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
>=20
> N=EDcolas, please, I think that sending this commit to stable for backpor=
ting
> makes a lot of sense since you're actually fixing laptops (that does not
> really require a Fixes tag) that are supported upstream since .. lots of =
time
> ago.
>=20
> In any case, this LGTM.
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Considering we have a single commit adding TTE, it should be fine to
just add a Fixes tag for that:

Fixes: 6ea0126631b0 ("power: supply: sbs-battery: add support for time_to_e=
mpty_now attribute")

-- Sebastian

--cydfw5cw3mawxhkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYicMEACgkQ2O7X88g7
+prwSg//ZJvOpFl9Jz8TJ0tdJb6BXGy3zv4WAEvPZT8oJPsjaJMUC1Bm+R3uCNfD
vuVZdlRzou3EwLWyho1vN2iR8Oi7DmpfZTMUcjGkbIxul2ty4g1mc6gEkycPt/ku
MkNeD1XD4A+R88dR7x2oaGzcA4WxUbnQMqEwzy1t7D6wVSo5aDaenFFHCOAhHwAX
MbKn6oe+taewYosI8rkVBO/K9HdaEOczHb9ds1Dp3WfL/LvJarKUcS27Sk35GCfF
9VWT9PYXqheMnkqGmnwUqGxRwSMyQqUxRv60IzWg9RgA1iZv8C/vIvcdcixQNw0w
ObmltEPif2u7QA9kM1g+wOmhkbdeuf/Qvmloekja5y7zgZK9OQQdiqDjSUpJzK6k
tNMU9OlfRBHA38S6UUc131UidHvKSiODKbBjMzubqMcXdEo628iIWk8Inw90sF94
Z8YOwomDfFiur7oCW19gUOnNJS+fAmrUd85fRjuHLYldF5zPH+mixbWwqizFF6G/
IYyzPtCLPVRDbPl2msd2Ev2hlMyKfMgtPeh0tdQJJ37Qn7f1KkDZ2vunHIsbdS4Q
kXGj9yUkg5Zsz5mDsNyioBC6rd7WDDJuw43YAfz3JAZ6NSuKTRjilk3DDZW4tUoD
l08yAaC8ax90uizXdxwZvnPty1YZ3bqlBwHqu66r3YO0VsM6Tyw=
=1rQq
-----END PGP SIGNATURE-----

--cydfw5cw3mawxhkn--

