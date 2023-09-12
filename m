Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C5D79D968
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjILTO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjILTOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:14:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1798E189;
        Tue, 12 Sep 2023 12:14:21 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C369166072FE;
        Tue, 12 Sep 2023 20:14:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694546059;
        bh=/fJbT61tks33SfamqyMRWAFhKbNaDeidExucjC94Ro0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9uOeccny6w8Rrgpe7su62PFaV6Pj247XrRdkm+mx2UmsOlPYHdeBNYEL2gdx1Uh2
         zSxN+aC8sKMAXXJCUyHj9nHEZOhymPyI6inDy6+aos1UFDGEfsXchEMrmtjBfQkfrN
         bUwLE+qTu+3CrvX3IFdl6wO9CtXr+gxOUS9N59ihoaGiiRHzgE/oL6l/vVyE3Rvggj
         XkXOyQN+RDtY43AVl9eSuie9JYOuZl5mnPvGD6GbbaPIRzsAELFtmvQeXxoYvaPzby
         HJkA5EdH4QmgabuLoYrl5E+ieApcEPPfLwddSnmHSQ1i6T9SduQNHC6UqJaHG7ukNK
         26bOpY5EWsP4Q==
Received: by mercury (Postfix, from userid 1000)
        id 0B61D106098A; Tue, 12 Sep 2023 21:14:17 +0200 (CEST)
Date:   Tue, 12 Sep 2023 21:14:16 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] power: supply: bq24190_charger: Export current
 regulator
Message-ID: <20230912191416.j6rqwx2vsisu47nl@mercury.elektranox.org>
References: <20230824131342.206784-1-linkmauve@linkmauve.fr>
 <20230824131342.206784-4-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2kfue3755npbb3he"
Content-Disposition: inline
In-Reply-To: <20230824131342.206784-4-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2kfue3755npbb3he
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 24, 2023 at 03:13:31PM +0200, Emmanuel Gil Peyrot wrote:
> From: Alexandre Courbot <acourbot@nvidia.com>
>=20
> This prevents the charger from ever going over the current limit.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---

This would need to be documented in the DT binding, but it
duplicates control for POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT
anyways. Please introduce DT property "input-current-limit-microamp"
for this driver, just like e.g. bq2515x_charger.c (and update the DT
binding accordingly).

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 82 ++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index a56122b39687..cc1bd87f4982 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -530,6 +530,79 @@ static int bq24190_set_otg_vbus(struct bq24190_dev_i=
nfo *bdi, bool enable)
>  }
> =20
>  #ifdef CONFIG_REGULATOR
> +static int bq24190_set_charging_current(struct regulator_dev *dev,
> +			int min_uA, int max_uA)
> +{
> +	struct bq24190_dev_info *bdi =3D rdev_get_drvdata(dev);
> +	u8 ss_reg;
> +	int in_current_limit;
> +	int ret =3D 0;
> +
> +	ret =3D bq24190_read(bdi, BQ24190_REG_SS, &ss_reg);
> +	if (ret < 0)
> +		goto error;
> +
> +	if (max_uA =3D=3D 0 && ss_reg !=3D 0)
> +		return ret;
> +
> +	if (!(ss_reg & BQ24190_REG_SS_VBUS_STAT_MASK))
> +		in_current_limit =3D 500;
> +	else
> +		in_current_limit =3D max_uA / 1000;
> +
> +	return bq24190_set_field_val(bdi, BQ24190_REG_ISC,
> +			BQ24190_REG_ISC_IINLIM_MASK,
> +			BQ24190_REG_ISC_IINLIM_SHIFT,
> +			bq24190_isc_iinlim_values,
> +			ARRAY_SIZE(bq24190_isc_iinlim_values),
> +			in_current_limit);
> +error:
> +	dev_err(bdi->dev, "Charger enable failed, err =3D %d\n", ret);
> +	return ret;
> +}
> +
> +static const struct regulator_ops bq24190_chrg_ops =3D {
> +	.set_current_limit =3D bq24190_set_charging_current,
> +};
> +
> +static const struct regulator_desc bq24190_chrg_desc =3D {
> +	.name =3D "charger",
> +	.of_match =3D "charger",
> +	.type =3D REGULATOR_CURRENT,
> +	.owner =3D THIS_MODULE,
> +	.ops =3D &bq24190_chrg_ops,
> +};
> +
> +static const struct regulator_init_data bq24190_chrg_init_data =3D {
> +	.constraints =3D {
> +		.valid_ops_mask =3D REGULATOR_CHANGE_STATUS | REGULATOR_CHANGE_CURRENT,
> +		.min_uA =3D 0,
> +		.max_uA =3D 3000000,
> +	},
> +};
> +
> +static int bq24190_register_chrg_regulator(struct bq24190_dev_info *bdi)
> +{
> +	struct bq24190_platform_data *pdata =3D bdi->dev->platform_data;
> +	struct regulator_config cfg =3D { };
> +	struct regulator_dev *reg;
> +	int ret =3D 0;
> +
> +	cfg.dev =3D bdi->dev;
> +	if (pdata && pdata->regulator_init_data)
> +		cfg.init_data =3D pdata->regulator_init_data;
> +	else
> +		cfg.init_data =3D &bq24190_chrg_init_data;
> +	cfg.driver_data =3D bdi;
> +	reg =3D devm_regulator_register(bdi->dev, &bq24190_chrg_desc, &cfg);
> +	if (IS_ERR(reg)) {
> +		ret =3D PTR_ERR(reg);
> +		dev_err(bdi->dev, "Can't register regulator: %d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
>  static int bq24190_vbus_enable(struct regulator_dev *dev)
>  {
>  	return bq24190_set_otg_vbus(rdev_get_drvdata(dev), true);
> @@ -611,6 +684,11 @@ static int bq24190_register_vbus_regulator(struct bq=
24190_dev_info *bdi)
>  	return ret;
>  }
>  #else
> +static int bq24190_register_chrg_regulator(struct bq24190_dev_info *bdi)
> +{
> +	return 0;
> +}
> +
>  static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
>  {
>  	return 0;
> @@ -1879,6 +1957,10 @@ static int bq24190_probe(struct i2c_client *client)
>  		goto out_charger;
>  	}
> =20
> +	ret =3D bq24190_register_chrg_regulator(bdi);
> +	if (ret < 0)
> +		goto out_charger;
> +
>  	ret =3D bq24190_register_vbus_regulator(bdi);
>  	if (ret < 0)
>  		goto out_charger;
> --=20
> 2.42.0
>=20

--2kfue3755npbb3he
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUAuHwACgkQ2O7X88g7
+prPAhAAjBH96YIU058xt3NUESRXpx0XGE//BxFYdfX3LGk63hYWd8DDm2FHyyrQ
MgTysNchxJrHCH1OVGgPNK37HNGgXMe+Z6WiZFMgOa0q6Mq57YqTwMyEoOgT2SYK
RMtSRS7SLXYQMr5K+Xb+mmS6z5jnqswRY1YAiuOdyJJPIrr9XgSVid4EDI4MLK2Y
TcBuC7vWevmPqLbLqJdGGMLiEIKZCDpNwW8FXlgHsDP/4K27+PtJhXfoPeIfXcB2
pvdcTqxJm/hrfRPmdTs3hhAZdF55ff+rnfeL9PDEBs7ebRBsXVHCy2oixbpYEnys
yiFkPchhvUhieEnTNDlBXUjGwgTgzUplP+Txy4DWPsMSaCWI3WV0Tpvn24v4i4Kt
aD7ACqbjYwEilJcKSqId03A+Yeud6fzGFW7MAaIJQtXmuqnNDSekEcG7+lCXTjUw
YoI2WYnNnlqkEdcUHbyXv9dQ5xKt0cHtuMwqXD0rRltjOeNfYPMnHbPglWSb7aJe
QVclYRnQ9ZPKE6N7t3ipZTWQNKMHqiFQoVPy8CWVcTZDakIRpf5/TLtu23CaVMNn
P7BfDvs6/xeu7XzJUfz7mZLrDcKVRsT7sqipnsY59xtSr3lmg2QSs9LNzLftF/wV
Tyq4ZSB4H3JJmCdB+dpXxrP61lSS75TLfnlw7w64K21+MYxzbwY=
=d1sz
-----END PGP SIGNATURE-----

--2kfue3755npbb3he--
