Return-Path: <linux-kernel+bounces-75672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B7885ED35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A53282983
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A609012C526;
	Wed, 21 Feb 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1sMr8aT3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C381726;
	Wed, 21 Feb 2024 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558898; cv=none; b=JXBgzLaXk8/zhmqK0O/70Le/QQ6e/8HJ6dmtDeJ0NLqS5zPtT2kT8JuhLlhPGG53oe3+EwLXjMdUaJKlTxaKne0mLInfGSX919u9RrKm3smPPN/5ORedlLzMU5cH0YMDFJd3G0W7SqiNSFLqKzUAz2dH4SzrpxnFcmHTwWHVUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558898; c=relaxed/simple;
	bh=iQaEr7S3VpVXo/LTfo0BTyUn3+bsPhj9s7jvrhfynZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMeyT+FrywafKq5chJxPxzh8B5X23O00SLuhxButT4B47cbGj3fFxZm+9rvQesct+rd9egiCFvC+BArW9fnK7AMA8PgATRR477Sfct8S/XJBcL+68ddFLid6GRlXE/gZM5BGMFmNggeOt74uxji0DkfadBcfuaa5xa7LFqTbgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1sMr8aT3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708558895;
	bh=iQaEr7S3VpVXo/LTfo0BTyUn3+bsPhj9s7jvrhfynZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1sMr8aT3mWNWbsBwlqmia8bEG592+tCdO/2HLfrb5QjlY+o3byLY7hkJl+HTs1juc
	 LFYaj8MvJM7FSo74UjgYJ1M7uBinz8JcacJ7/JtqTNEhhKMSEWtsnuj3AyZs31d2TT
	 HsnKsERttVu/EKpgPnYgoJ/zURsd+3ltmtw0C5eCNviaiwOuLWllC3Q8ZQYLdZmkN9
	 1nH7n+jt0k969brjBjMAHMX70Hnjz94hOOn7f/ZyuuLjQPsfYmpk3OdZi8bOgK5MfY
	 kekzOZRByL6KjVM3K1DC6nk0KgxOBAxy6VXjtOiqBvidpMj4rfdAJIiSx9RzkU3l03
	 Iwic1dbD5/w2g==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 394943782082;
	Wed, 21 Feb 2024 23:41:35 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A5A2D106B79D; Thu, 22 Feb 2024 00:41:34 +0100 (CET)
Date: Thu, 22 Feb 2024 00:41:34 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Nikita Travkin <nikita@trvn.ru>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] power: supply: Add Acer Aspire 1 embedded
 controller driver
Message-ID: <qoidm5wujjbeoc2hlraky26wuwmuaxi2atyl6ehovhvffdbfeh@g5gunqdei45m>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
 <20240220-aspire1-ec-v3-2-02cb139a4931@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5pumrq45zgvzlhw7"
Content-Disposition: inline
In-Reply-To: <20240220-aspire1-ec-v3-2-02cb139a4931@trvn.ru>


--5pumrq45zgvzlhw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 20, 2024 at 04:57:13PM +0500, Nikita Travkin wrote:
> Acer Aspire 1 is a Snapdragon 7c based laptop. It uses an embedded
> controller to control the charging and battery management, as well as to
> perform a set of misc functions.
>=20
> Unfortunately, while all this functionality is implemented in ACPI, it's
> currently not possible to use ACPI to boot Linux on such Qualcomm
> devices. To allow Linux to still support the features provided by EC,
> this driver reimplments the relevant ACPI parts. This allows us to boot
> the laptop with Device Tree and retain all the features.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  drivers/power/supply/Kconfig           |  14 +
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/acer-aspire1-ec.c | 453 +++++++++++++++++++++++++++=
++++++

I think this belongs into drivers/platform, as it handles all bits of
the EC.

[...]

>  3 files changed, 468 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 3e31375491d5..e91a3acecb41 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -985,4 +985,18 @@ config FUEL_GAUGE_MM8013
>  	  the state of charge, temperature, cycle count, actual and design
>  	  capacity, etc.
> =20
> +config EC_ACER_ASPIRE1
> +	tristate "Acer Aspire 1 Emedded Controller driver"
> +	depends on I2C
> +	depends on DRM
> +	help
> +	  Say Y here to enable the EC driver for the (Snapdragon-based)
> +	  Acer Aspire 1 laptop. The EC handles battery and charging
> +	  monitoring as well as some misc functions like the lid sensor
> +	  and USB Type-C DP HPD events.
> +
> +	  This driver provides battery and AC status support for the mentioned

I did not see any AC status bits?

> [...]

> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D 1;

You have an unused ASPIRE_EC_FG_FLAG_PRESENT, that looks like it
should be used here?

> [...]

Otherwise the power-supply bits LGTM.

-- Sebastian

--5pumrq45zgvzlhw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXWiicACgkQ2O7X88g7
+pphEQ//QfRfqFF/XjDaJi9b+8RjH14PfIoll6uD3p5mDEZNt2uUHj0OD6amERqW
f/oEuh3OIdGda/XOQAVsF3hB6R0odh1oU9g2h5O5ibcITedbJylsuMKXxn27OmCg
6pStiMBuNB9RQjrhqjF3THVfqkcyqilW0seTVoqXNq2B1UT2fOT+KKgUaUMt2dj3
jYdAyiza9GywL+bPk2fnEjygNH2tU6YpEDO7p2BYHu4jG066S+sCntaAfS9GYlOm
DRfXUxmWlQuV2J9eJto1dbKaqgCCVl5aHmK16no5kpJy1YaStzi/c4ZebHJkVfUz
/SRFPXUWySirture+1EAL5jj8d52eBJOa9Bm7Nn6VhWnNmrZ+3tLjUK9MQY6Adn3
yCcFi/kmK+rDxBOqzC3FFjQACpH7TYe6cXREqjH45ItqClPOghvPXJNYs0B/RjKv
ZWERkRZKqP0GfDNZhhYWvmNxNBlX9/psgWfGdOQauvmi99jdIDy9rOGvuqBvMoG2
M6wFQBnp/hjVJqbuFZhWTHx5dq1Bnz6TRUsd0Lk6xwWs04bzEaD/dND7WE0JGO6W
VZBqdLdcFO7UvyyQAAY4BB4qqhORN5kwucm3dZQOtHQqrtmJ8JkC0Ysmyyvp3wJZ
fJYww9pNBQ7sV3nylsuvpFd2ocziNoesdhIp2Phkd5p0Pdk1Z+c=
=5HBY
-----END PGP SIGNATURE-----

--5pumrq45zgvzlhw7--

