Return-Path: <linux-kernel+bounces-42742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EFC8405EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860421C22018
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70866281A;
	Mon, 29 Jan 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="euLWzzu0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C66168A;
	Mon, 29 Jan 2024 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533398; cv=none; b=VQdinqyBD/XHTQK552xe8oyBHTzTWjbclCHc6pqWVyDZEGrp4iGlPS6zZAHp7BXTO2MbsaGkhRPpfHQYXC5cI7sJrIl7AjGiA6ZBXRa/IljUtP5DNJHcaHSFNmK0M5un+a2URTNLD8R4biB/l4DE9uvTHuQtN1fk1rAGS4CN5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533398; c=relaxed/simple;
	bh=En+o/ta0oprAiI0bv2E8pNpWVrmO8oSUm1ARJDHKlQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc15PRWFAR5GNiL/lF/gDxQuZoJmdVyhXFCE9qsItQQ93JPrXK7k9td6pjhrhSluwxo+5EEdoSsjQFaSgWdkcckqctYg0t/zCnO1aao9smjx5jj+Odv8eBJYXyec0KOnO5DFFaMLOjEebIS0rm2B6gD8khWr1F/cNr7VkvRJmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=euLWzzu0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706533394;
	bh=En+o/ta0oprAiI0bv2E8pNpWVrmO8oSUm1ARJDHKlQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euLWzzu0h9883PFM9+Z7VZSJVKTi0XUrhG47g3Cf6xKbrRrt2dUIFBGfzb11aH4Gw
	 Tb+RCmfX6qrSi2d+e4ZX12cFt+igISObDjGihrKyu7LA+bX0fY0fhOVn++irF0MnG8
	 nwFpIaZ/DZCMcWNaoF7RLTSAV0Xb831OgxYy+pa32eRNvW0F8lIQsbLQGWQY+JLnVu
	 EtWimpSorwB9TNmoqIU5JSVA2koGxQnwEM1+gjOJ9QQFvc3dlPXivvn5+zOcADZnd8
	 QfSLCfUzadmIO7Sswa/5qmYerDMHr3RR7WL0Ga42W3HQFb3Mn1LG6tTETeRb85g+DF
	 uqsa5IHj4ZzkQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8DEA0378003D;
	Mon, 29 Jan 2024 13:03:14 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 28A471063ADA; Mon, 29 Jan 2024 14:03:14 +0100 (CET)
Date: Mon, 29 Jan 2024 14:03:14 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Luca Weiss <luca.weiss@fairphone.com>, andersson@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH AUTOSEL 6.7 15/39] power: supply: qcom_battmgr: Register
 the power supplies after PDR is up
Message-ID: <rtghydsz532x6atjeshexkgevqlfxmw5owjexmnczwepeefvlb@gxinnf23tzij>
References: <20240128161130.200783-1-sashal@kernel.org>
 <20240128161130.200783-15-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mqekvd7hqabcdj2t"
Content-Disposition: inline
In-Reply-To: <20240128161130.200783-15-sashal@kernel.org>


--mqekvd7hqabcdj2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 28, 2024 at 11:10:35AM -0500, Sasha Levin wrote:
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

Please drop it, I have a patch queued reverting this patch.=20

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

--mqekvd7hqabcdj2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmW3ogoACgkQ2O7X88g7
+pr3VhAAoFg3dDtbbHT5MDapdkU7KcQ+brvQC+RcR+iftwUusNtNBZaqhatssI6q
silJgqzKQyHJGMsWyY4vnz9J1ukcvtt1ydQc5J80AEPogFUdOdu2Sm5uyUc3pVHg
cW5bwZK/Y3Hnzn5n2vyKstLBwM8XtZf38hIZ75+5VtUxnrfrETAAwmCXe2/5qCeO
55bRNOoiylfqjGDXDTIU9xR2e1LIqneq+PFWeYR333fXcdQ2+dTRGiL6qeP6MtsT
FtKvr+PcYlgLwX+AtQS2/GF6W7WTmN3ldYCbGlY07pfptfmAdE38p5FOvZM88aZb
7Lt1qKpwl3hZ2CJiV0r0SDbnMyPsPoQ8RyFoIzuqYPiVeJBw2sBAa1Ax65//po0I
JCgsv6Xilxt6sPr5SdXMqJ7EaNeqqS7wcsUosUq5aLx+/y1rEZluZC/Q9qB9nswT
+L758Nvyk444LmNOvS3OmmPGW5VPuGl3EpBAsmFJm3OHLSfwrpFZ9wyPQEck+mPG
b+ov0rqU89+5WpDQR2KML1aGzLNULisGO+F95vtYgWABFChJ+quFe6XlmIyxKomA
XSHIVerxec78nqTxybcnoP4TG97psejfcSs1T90efIR6i8O5PlEF82azHScTbO56
ygKk5RM7oCJw3ifhzg7U0SMzkgA4dz9wZnZ7lSJrjTAiRKbRRkA=
=Ik1F
-----END PGP SIGNATURE-----

--mqekvd7hqabcdj2t--

