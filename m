Return-Path: <linux-kernel+bounces-93173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86154872BD3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A011F2738B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18B6ABF;
	Wed,  6 Mar 2024 00:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yuY25cTV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896A6FAD;
	Wed,  6 Mar 2024 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685578; cv=none; b=DMP2mpacRLoZvd9cE0iy5IbL/h23g4/WYjI23MwJsqs/JxHsa9gr3W4ufYsXAEPB/8yDIAyfweoZUybOScKOwwMDfKm9fiyzkEH8tuwDbX8v6gRxG1QoyQdJRHsid5WxKNB8YpUBypwQ8Ivk0Gw7EjbxB4Oe4oiG/3r1EekU4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685578; c=relaxed/simple;
	bh=bOWzR8XghyOe5aPHPUVDP6xFazsPPhArmXtjefaKB08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwO9orKN3BP+8XaHat3et4fnBTbQ9ap2nxZRGMTlBqQQK9gme4o5jpNmW10SzYilsIIoiZ/3Jcsh4bs5xXlNQSI35rbj4gLft/903tIf+5lSoMebFoVvA5v4+UKB7pkqiNNzuDTbdwGUg4A6NSpX7dptf+iue8KdSjk+8TSdIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yuY25cTV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709685575;
	bh=bOWzR8XghyOe5aPHPUVDP6xFazsPPhArmXtjefaKB08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yuY25cTVwO7esko/gQb3NvL0qOEjt+bfU8JcFtxOyRhFHh6+FPMzZN/SwWVL5hu8P
	 8m7fT6MBmcOmHuVJ1If7gTJEJK1XCj1qtEf9QsWmGovrpNOKvVjLVl1nsSft9XXvXJ
	 XxR1S3x13Q/Zw4U7aO6muOf/fav/vk0U58fOzhON21k0Vurx2djdfZdzThrdOeg2ao
	 ZekyvzIkKin1UAAa5ionPvfA6pfkIHLT2QMUEdZpUIQb8kR974TpksCdva5oYCpWUi
	 hfR4wqIwnMhHSqVuSSsE7H9NyiXbVAZEz1kZlgmdtsFbIYyWtQVlE+Fd32ZEsBUm97
	 m6/BP6hO/o/mw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2D12B3781FDF;
	Wed,  6 Mar 2024 00:39:35 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 98E8D1061BCB; Wed,  6 Mar 2024 01:39:34 +0100 (CET)
Date: Wed, 6 Mar 2024 01:39:34 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] power: supply: test-power: implement
 charge_behaviour property
Message-ID: <v5cblrwp3ubum3cciiwqazeivkwws2phkocxsdwa7v3hpwxuf4@bea76hsomovd>
References: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
 <20240303-power_supply-charge_behaviour_prop-v2-4-8ebb0a7c2409@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bdnqhngrcjnbq5uu"
Content-Disposition: inline
In-Reply-To: <20240303-power_supply-charge_behaviour_prop-v2-4-8ebb0a7c2409@weissschuh.net>


--bdnqhngrcjnbq5uu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 03, 2024 at 04:31:16PM +0100, Thomas Wei=DFschuh wrote:
> To validate the special formatting of the "charge_behaviour" sysfs
> property add it to the example driver.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

Thanks for your patch.

>  drivers/power/supply/test_power.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20

[...]

> +static int test_power_set_battery_property(struct power_supply *psy,
> +					   enum power_supply_property psp,
> +					   const union power_supply_propval *val)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		battery_charge_behaviour =3D val->intval;
> +		break;

This should check if user supplied val->intval is valid, otherwise
LGTM.

-- Sebastian

--bdnqhngrcjnbq5uu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXnuz0ACgkQ2O7X88g7
+prxlw/+MZ7eBwygN9cFXZWBZu9B0eFeUfDek+fFVvWShalFLghtMR2ltdjagntC
hZv5MCqSKPkONEsZ9H9R9K0H0vlArdN1UL5/R9yll9vE6ym+Vohu0VocoxxjQFMy
W+ecSgV3mdeBe/OMIlgW9IKndo+VUQW4jDwLhTvj4FlNRaqEEQqa4uX+UlCACq3k
UFSriJqcAkGwHyXtS7/dLRfDSK8nebUgerf6puohc0MIYYCNrqJsEVNb1UMPBdy4
mTEjE/VIpU8VmbK31AfFvlcIEsTZcOJG/YcgN2Yje6GSleEYl/bAXdRQk30XQiTm
zUFNcfv5vK4bxmCuBOSFi+8PlW24A5e/oPTKDHWe01SWaYJFj6iUOi+Pnm4DOsAA
P7Ktr26rHFvq796UrAbEPyJL22+m17uS/mKrUKuoQTD9P1eNHE7RnRbBuq+SffzI
wyG7BdFWFFH0fPlK5oL3yKn7tPF4J5DF00ro6PjHkkiMQpVPCV7HU9g6Awjy2MuG
JHxA488cO4D9O3/NORGI5OtRi/rmAKXio4Cw4G2h6CBzuJnXWb0aHrmyk0VyTNwB
gfBRMm6xmNYhpmJK3/XbbWvglgRelD/t3BV0US2mmHRntZbAFCZaiW/wxK0F0mMo
F8qnlHjdNsjmBnlxjYMNPG3DfB39HZqxoRDfb/MgcmlgRmrWzso=
=D3ng
-----END PGP SIGNATURE-----

--bdnqhngrcjnbq5uu--

