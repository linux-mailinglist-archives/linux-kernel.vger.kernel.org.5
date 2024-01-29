Return-Path: <linux-kernel+bounces-42745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F0D8405F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D79B212C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AB1629FF;
	Mon, 29 Jan 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G02VFL5d"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05866627F6;
	Mon, 29 Jan 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533446; cv=none; b=lEYtt80EXAPS2Mm35ErG3vwRSun005YuY6Hl1kz6WE8X0xZ0WvNaaKbG0h38OY0Jl5TcxrB8fXv6knpLgsZDugk+UV0o2JSUOg1sSCqdqNa3BqUdFa4jb2QuXMZH1I77CAzZ5vwREL2P92wr01FjmXJG6kYNeGw/5VhBHEs95tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533446; c=relaxed/simple;
	bh=27JOn8pMPLxrkKswcEytxNvifYEawTPWb/P+SH4Wzlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaswHZia6DGSUPDTg4+AXnTbE3I3FWEssOaxUTdtwngTA9cagwA4HKfG0QeX9uKRO5ZAzGHHXCImFHkuyTtd5KH9bFfcWt42y+V8V8Tx4xLmKO7Nh++N2frZgH5eLorv/dJapZwCppFHXsxu7Wsiu2Xy6pQvMzYzhVKVwCWhO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G02VFL5d; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706533443;
	bh=27JOn8pMPLxrkKswcEytxNvifYEawTPWb/P+SH4Wzlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G02VFL5dsxDBMfml0ydsZpY7Kk9QshJxGmTO7apRcr+KB5hSL5GNDSk9+ZudJXzOH
	 bQS7M2E0uW0QVNbB8MdOvWe6wQO1dLhPrLEPTcV1pZfjr0OMfWU3wtGRtwBdndNXSE
	 7i0Z6dEJBkaiaVydPd8rR8u0a7C5F4yCHX1u4HYH2IWOQAUpJX/ScvMWbH5RKJBHnJ
	 HJWGNPzDTjj6Po/NJFOD6S5APQat0FBc+6xxOWd0051Mf0/SyB4Lc68lhAXanD4JB1
	 Y+T4xYC8DlYDDMSzsNrpQMlFV45UI0HkRQcWr8zYOgrBs4Qw0o+qcG8F7G/xoIv6/D
	 4eYlGWDVH/sGA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5D030378003D;
	Mon, 29 Jan 2024 13:04:03 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 081221063ADA; Mon, 29 Jan 2024 14:04:02 +0100 (CET)
Date: Mon, 29 Jan 2024 14:04:02 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Luca Weiss <luca.weiss@fairphone.com>, andersson@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH AUTOSEL 6.6 12/31] power: supply: qcom_battmgr: Register
 the power supplies after PDR is up
Message-ID: <wqq4ga5m5qvhvzebdl5p7ecwhhbtgyil4isjx7htq6zto3yoex@dqi75okjckob>
References: <20240128161315.201999-1-sashal@kernel.org>
 <20240128161315.201999-12-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ejjavpsvnbuzsgx4"
Content-Disposition: inline
In-Reply-To: <20240128161315.201999-12-sashal@kernel.org>


--ejjavpsvnbuzsgx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 28, 2024 at 11:12:42AM -0500, Sasha Levin wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>=20
> [ Upstream commit b43f7ddc2b7a5a90447d96cb4d3c6d142dd4a810 ]
>=20
> Currently, a not-yet-entirely-initialized battmgr (e.g. with pd-mapper
> not having yet started or ADSP not being up etc.) results in a couple of
> zombie power supply devices hanging around.
>=20
> This is particularly noticeable when trying to suspend the device (even
> s2idle): the PSY-internal thermal zone is inaccessible and returns
> -ENODEV, which causes log spam.
>=20
> Register the power supplies only after we received some notification
> indicating battmgr is ready to take off.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> Link: https://lore.kernel.org/r/20231218-topic-battmgr_fixture_attempt-v1=
-1-6145745f34fe@linaro.org
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Please drop. I have a patch queued reverting this patch.

-- Sebastian

>  drivers/power/supply/qcom_battmgr.c | 109 +++++++++++++++-------------
>  1 file changed, 60 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/q=
com_battmgr.c
> index ec163d1bcd18..a12e2a66d516 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -282,6 +282,7 @@ struct qcom_battmgr_wireless {
> =20
>  struct qcom_battmgr {
>  	struct device *dev;
> +	struct auxiliary_device *adev;
>  	struct pmic_glink_client *client;
> =20
>  	enum qcom_battmgr_variant variant;
> @@ -1293,11 +1294,69 @@ static void qcom_battmgr_enable_worker(struct wor=
k_struct *work)
>  		dev_err(battmgr->dev, "failed to request power notifications\n");
>  }
> =20
> +static char *qcom_battmgr_battery[] =3D { "battery" };
> +
> +static void qcom_battmgr_register_psy(struct qcom_battmgr *battmgr)
> +{
> +	struct power_supply_config psy_cfg_supply =3D {};
> +	struct auxiliary_device *adev =3D battmgr->adev;
> +	struct power_supply_config psy_cfg =3D {};
> +	struct device *dev =3D &adev->dev;
> +
> +	psy_cfg.drv_data =3D battmgr;
> +	psy_cfg.of_node =3D adev->dev.of_node;
> +
> +	psy_cfg_supply.drv_data =3D battmgr;
> +	psy_cfg_supply.of_node =3D adev->dev.of_node;
> +	psy_cfg_supply.supplied_to =3D qcom_battmgr_battery;
> +	psy_cfg_supply.num_supplicants =3D 1;
> +
> +	if (battmgr->variant =3D=3D QCOM_BATTMGR_SC8280XP) {
> +		battmgr->bat_psy =3D devm_power_supply_register(dev, &sc8280xp_bat_psy=
_desc, &psy_cfg);
> +		if (IS_ERR(battmgr->bat_psy))
> +			dev_err(dev, "failed to register battery power supply (%ld)\n",
> +				PTR_ERR(battmgr->bat_psy));
> +
> +		battmgr->ac_psy =3D devm_power_supply_register(dev, &sc8280xp_ac_psy_d=
esc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->ac_psy))
> +			dev_err(dev, "failed to register AC power supply (%ld)\n",
> +				PTR_ERR(battmgr->ac_psy));
> +
> +		battmgr->usb_psy =3D devm_power_supply_register(dev, &sc8280xp_usb_psy=
_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->usb_psy))
> +			dev_err(dev, "failed to register USB power supply (%ld)\n",
> +				PTR_ERR(battmgr->usb_psy));
> +
> +		battmgr->wls_psy =3D devm_power_supply_register(dev, &sc8280xp_wls_psy=
_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->wls_psy))
> +			dev_err(dev, "failed to register wireless charing power supply (%ld)\=
n",
> +				PTR_ERR(battmgr->wls_psy));
> +	} else {
> +		battmgr->bat_psy =3D devm_power_supply_register(dev, &sm8350_bat_psy_d=
esc, &psy_cfg);
> +		if (IS_ERR(battmgr->bat_psy))
> +			dev_err(dev, "failed to register battery power supply (%ld)\n",
> +				PTR_ERR(battmgr->bat_psy));
> +
> +		battmgr->usb_psy =3D devm_power_supply_register(dev, &sm8350_usb_psy_d=
esc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->usb_psy))
> +			dev_err(dev, "failed to register USB power supply (%ld)\n",
> +				PTR_ERR(battmgr->usb_psy));
> +
> +		battmgr->wls_psy =3D devm_power_supply_register(dev, &sm8350_wls_psy_d=
esc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->wls_psy))
> +			dev_err(dev, "failed to register wireless charing power supply (%ld)\=
n",
> +				PTR_ERR(battmgr->wls_psy));
> +	}
> +}
> +
>  static void qcom_battmgr_pdr_notify(void *priv, int state)
>  {
>  	struct qcom_battmgr *battmgr =3D priv;
> =20
>  	if (state =3D=3D SERVREG_SERVICE_STATE_UP) {
> +		if (!battmgr->bat_psy)
> +			qcom_battmgr_register_psy(battmgr);
> +
>  		battmgr->service_up =3D true;
>  		schedule_work(&battmgr->enable_work);
>  	} else {
> @@ -1312,13 +1371,9 @@ static const struct of_device_id qcom_battmgr_of_v=
ariants[] =3D {
>  	{}
>  };
> =20
> -static char *qcom_battmgr_battery[] =3D { "battery" };
> -
>  static int qcom_battmgr_probe(struct auxiliary_device *adev,
>  			      const struct auxiliary_device_id *id)
>  {
> -	struct power_supply_config psy_cfg_supply =3D {};
> -	struct power_supply_config psy_cfg =3D {};
>  	const struct of_device_id *match;
>  	struct qcom_battmgr *battmgr;
>  	struct device *dev =3D &adev->dev;
> @@ -1328,14 +1383,7 @@ static int qcom_battmgr_probe(struct auxiliary_dev=
ice *adev,
>  		return -ENOMEM;
> =20
>  	battmgr->dev =3D dev;
> -
> -	psy_cfg.drv_data =3D battmgr;
> -	psy_cfg.of_node =3D adev->dev.of_node;
> -
> -	psy_cfg_supply.drv_data =3D battmgr;
> -	psy_cfg_supply.of_node =3D adev->dev.of_node;
> -	psy_cfg_supply.supplied_to =3D qcom_battmgr_battery;
> -	psy_cfg_supply.num_supplicants =3D 1;
> +	battmgr->adev =3D adev;
> =20
>  	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
>  	mutex_init(&battmgr->lock);
> @@ -1347,43 +1395,6 @@ static int qcom_battmgr_probe(struct auxiliary_dev=
ice *adev,
>  	else
>  		battmgr->variant =3D QCOM_BATTMGR_SM8350;
> =20
> -	if (battmgr->variant =3D=3D QCOM_BATTMGR_SC8280XP) {
> -		battmgr->bat_psy =3D devm_power_supply_register(dev, &sc8280xp_bat_psy=
_desc, &psy_cfg);
> -		if (IS_ERR(battmgr->bat_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
> -					     "failed to register battery power supply\n");
> -
> -		battmgr->ac_psy =3D devm_power_supply_register(dev, &sc8280xp_ac_psy_d=
esc, &psy_cfg_supply);
> -		if (IS_ERR(battmgr->ac_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->ac_psy),
> -					     "failed to register AC power supply\n");
> -
> -		battmgr->usb_psy =3D devm_power_supply_register(dev, &sc8280xp_usb_psy=
_desc, &psy_cfg_supply);
> -		if (IS_ERR(battmgr->usb_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
> -					     "failed to register USB power supply\n");
> -
> -		battmgr->wls_psy =3D devm_power_supply_register(dev, &sc8280xp_wls_psy=
_desc, &psy_cfg_supply);
> -		if (IS_ERR(battmgr->wls_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
> -					     "failed to register wireless charing power supply\n");
> -	} else {
> -		battmgr->bat_psy =3D devm_power_supply_register(dev, &sm8350_bat_psy_d=
esc, &psy_cfg);
> -		if (IS_ERR(battmgr->bat_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
> -					     "failed to register battery power supply\n");
> -
> -		battmgr->usb_psy =3D devm_power_supply_register(dev, &sm8350_usb_psy_d=
esc, &psy_cfg_supply);
> -		if (IS_ERR(battmgr->usb_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
> -					     "failed to register USB power supply\n");
> -
> -		battmgr->wls_psy =3D devm_power_supply_register(dev, &sm8350_wls_psy_d=
esc, &psy_cfg_supply);
> -		if (IS_ERR(battmgr->wls_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
> -					     "failed to register wireless charing power supply\n");
> -	}
> -
>  	battmgr->client =3D devm_pmic_glink_register_client(dev,
>  							  PMIC_GLINK_OWNER_BATTMGR,
>  							  qcom_battmgr_callback,
> --=20
> 2.43.0
>=20

--ejjavpsvnbuzsgx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmW3okIACgkQ2O7X88g7
+poDwA/9GUhI/yZTzwvrtYOc5qnHAJvS+H8dTwX/Qp5VHVUxpBLeVuqyg1jqh4a+
b5ji6+2LsZCWiJ/EJPcNp3Xviv/5lf0KWkuOCKA/4skWwvR7Aw3kdRUVcRD3LHUJ
jh6ZjTh1nzbIY72z8x846KKHX3G+EXjVcikgdh52L/CQbOt/pN+teK3YctHqSBfd
8Lpo5ZzhDi+P3ki9vNtn9MY7bQx/mLbO669TY6cDa7OvYH55sZ8G6ICeyeR0X0oF
oi8ZsH2S7tj0JiQX40Ku9VxiuM+ONelqqr2SGiErcLYICRwNDe+OTJp8yJVAoMiV
HXk1I2oxiEeG8so3sH+9C7CHR6xqcZS3bNhff9SxWx9SROtmOZFwhmuchefoV+gt
s/xkh0zpL9r0Iuq5eECnoaLNbRd7TGGVeseZZ6qqMb/fPKO49diI5zFSHGRlwgWv
CyzBql0gvm8ZRrkcLEH2ggqP8uwrTJF4VWjsPZE6d0ldc2Ckigj1GnY0S6kbChtH
vDwOhwSLzNcrK4KsgGsq4mkFC4Ezitg+TJ5INcxf8PGhruIQO5k+5HWEwhgZCox2
gQM0qlNwW5CE9HAb/EpxjSCouceklITmu7kVCbA6cvubnyTpZX/eOCyMmYqhB3C+
jlxZ9fEcRqdWvm7xu6IkgSk/KVBldINRZR+aWW2hSzVLfg48NsA=
=O+nP
-----END PGP SIGNATURE-----

--ejjavpsvnbuzsgx4--

