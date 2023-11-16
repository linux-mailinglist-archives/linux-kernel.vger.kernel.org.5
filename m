Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF727EE759
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbjKPTS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjKPTS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:18:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DC18D;
        Thu, 16 Nov 2023 11:18:20 -0800 (PST)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A7F2660734D;
        Thu, 16 Nov 2023 19:18:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700162299;
        bh=V7XuKmcHd8SUgcHpaXn+K9vIwqQimam3SlAKjUqfyTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNUh5LNTeuk1dSPSBKxKpqWHDqRe5XaLZK0dDFW8fvXzyj4tHv2finAs4OBTasHi8
         SpDsrzGe9DNv+kMG7TQWjZI78Z9IzgXa0ZNYfELIvAH9MGepNvjIIJvY7aBp27WpYM
         0aP1g56dnyqSvjmh3oQiCiPSQwoXX6CeGhdqXJoNS1/dzbXL5yds6/fEY1GViigap4
         WQAcD9pbGTRLH/0uj1safe5Xzru4DcrHYUrUBObOHhnuG49xbIQPUp1qprSXBVWIKL
         X3DDFjYEQbz67jFfl3faIFdMdkUKE3cnlBNPB4choN8HzNdlnmpXMDyqk2Ngt4ffv+
         c7Xb8drIt8JRQ==
Received: by mercury (Postfix, from userid 1000)
        id 4301B10613A1; Thu, 16 Nov 2023 20:18:15 +0100 (CET)
Date:   Thu, 16 Nov 2023 20:18:15 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermes Zhang <Hermes.Zhang@axis.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com,
        Hermes Zhang <chenhuiz@axis.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: bq24190_charger: Add support for
 BQ24296
Message-ID: <20231116191815.jrjwcw5nywtdpplk@mercury.elektranox.org>
References: <20231030084302.593864-1-Hermes.Zhang@axis.com>
 <20231030084302.593864-3-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rcfuox7jrzun6lqu"
Content-Disposition: inline
In-Reply-To: <20231030084302.593864-3-Hermes.Zhang@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rcfuox7jrzun6lqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 30, 2023 at 04:43:02PM +0800, Hermes Zhang wrote:
> The BQ24296 is most similar to the BQ24196, but the:
> 1. OTG config is split from CHG config (REG01)
> 2. ICHG (Fast Charge Current limit) range is smaller (<=3D3008mA)
> 3. NTC fault is simplified to 2 bits
>=20
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
>=20
> Notes:
>     v2: restructured the code to support bq24296 and add Acked-by tag
>         from Conor
>  drivers/power/supply/bq24190_charger.c | 437 +++++++++++++++++++------
>  1 file changed, 338 insertions(+), 99 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 3f99cb9590ba..5b60d924cf9f 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c

[...]

> +static const struct bq24190_chip_info bq24190_chip_info_tbl[] =3D {
> +	[BQ24190] =3D {
> +		.ichg_array_size =3D ARRAY_SIZE(bq24190_ccc_ichg_values),
> +		.vbus_desc =3D bq24190_vbus_desc,
> +		.check_chip =3D bq24190_check_chip,
> +		.set_chg_config =3D bq24190_battery_set_chg_config,
> +		.ntc_fault_mask =3D BQ24190_REG_F_NTC_FAULT_MASK,
> +		.get_ntc_status =3D bq24190_charger_get_ntc_status,
> +		.set_otg_vbus =3D bq24190_set_otg_vbus,
> +	},
> +	[BQ24192] =3D {
> +		.ichg_array_size =3D ARRAY_SIZE(bq24190_ccc_ichg_values),
> +		.vbus_desc =3D bq24190_vbus_desc,
> +		.check_chip =3D bq24190_check_chip,
> +		.set_chg_config =3D bq24190_battery_set_chg_config,
> +		.ntc_fault_mask =3D BQ24190_REG_F_NTC_FAULT_MASK,
> +		.get_ntc_status =3D bq24190_charger_get_ntc_status,
> +		.set_otg_vbus =3D bq24190_set_otg_vbus,
> +	},
> +	[BQ24192i] =3D {
> +		.ichg_array_size =3D ARRAY_SIZE(bq24190_ccc_ichg_values),
> +		.vbus_desc =3D bq24190_vbus_desc,
> +		.check_chip =3D bq24190_check_chip,
> +		.set_chg_config =3D bq24190_battery_set_chg_config,
> +		.ntc_fault_mask =3D BQ24190_REG_F_NTC_FAULT_MASK,
> +		.get_ntc_status =3D bq24190_charger_get_ntc_status,
> +		.set_otg_vbus =3D bq24190_set_otg_vbus,
> +	},
> +	[BQ24196] =3D {
> +		.ichg_array_size =3D ARRAY_SIZE(bq24190_ccc_ichg_values),
> +		.vbus_desc =3D bq24190_vbus_desc,
> +		.check_chip =3D bq24190_check_chip,
> +		.set_chg_config =3D bq24190_battery_set_chg_config,
> +		.ntc_fault_mask =3D BQ24190_REG_F_NTC_FAULT_MASK,
> +		.get_ntc_status =3D bq24190_charger_get_ntc_status,
> +		.set_otg_vbus =3D bq24190_set_otg_vbus,
> +	},
> +	[BQ24296] =3D {
> +		.ichg_array_size =3D BQ24296_CCC_ICHG_VALUES_LEN,
> +		.vbus_desc =3D bq24296_vbus_desc,
> +		.check_chip =3D bq24296_check_chip,
> +		.set_chg_config =3D bq24296_battery_set_chg_config,
> +		.ntc_fault_mask =3D BQ24296_REG_F_NTC_FAULT_MASK,
> +		.get_ntc_status =3D bq24296_charger_get_ntc_status,
> +		.set_otg_vbus =3D bq24296_set_otg_vbus,
> +	},
> +};
> +
>  static int bq24190_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
> @@ -1804,6 +2040,7 @@ static int bq24190_probe(struct i2c_client *client)
>  	bdi->client =3D client;
>  	bdi->dev =3D dev;
>  	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
> +	bdi->info =3D &bq24190_chip_info_tbl[id->driver_data];
>  	mutex_init(&bdi->f_reg_lock);
>  	bdi->charge_type =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
>  	bdi->f_reg =3D 0;
> @@ -1940,7 +2177,7 @@ static void bq24190_shutdown(struct i2c_client *cli=
ent)
>  	struct bq24190_dev_info *bdi =3D i2c_get_clientdata(client);
> =20
>  	/* Turn off 5V boost regulator on shutdown */
> -	bq24190_set_otg_vbus(bdi, false);
> +	bdi->info->set_otg_vbus(bdi, false);
>  }
> =20
>  static __maybe_unused int bq24190_runtime_suspend(struct device *dev)
> @@ -2029,10 +2266,11 @@ static const struct dev_pm_ops bq24190_pm_ops =3D=
 {
>  };
> =20
>  static const struct i2c_device_id bq24190_i2c_ids[] =3D {
> -	{ "bq24190" },
> -	{ "bq24192" },
> -	{ "bq24192i" },
> -	{ "bq24196" },
> +	{ "bq24190", BQ24190 },
> +	{ "bq24192", BQ24192 },
> +	{ "bq24192i", BQ24192i },
> +	{ "bq24196", BQ24196 },
> +	{ "bq24296", BQ24296 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
> @@ -2042,6 +2280,7 @@ static const struct of_device_id bq24190_of_match[]=
 =3D {
>  	{ .compatible =3D "ti,bq24192", },
>  	{ .compatible =3D "ti,bq24192i", },
>  	{ .compatible =3D "ti,bq24196", },
> +	{ .compatible =3D "ti,bq24296", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bq24190_of_match);

This looks better, but please handle the match_info in the modern
way, like e.g. bq256xx_charger.c, bq24257_charger.c, bq2515x_charger.c.
So instead of using an ID and using that to lookup a device struct
=66rom an array, just directly specify a pointer to the device struct.

Also make sure you specify the pointer in all device tables and use
i2c_get_match_data() in probe() to get the struct.

Thanks,

-- Sebastian

--rcfuox7jrzun6lqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmVWausACgkQ2O7X88g7
+ppMcg//ffklRJuh3frxFd4QrfLMJojE0H4+jIekhtyvZBcPVV+AvWZS8aH9q0mU
Rd7nw9KlrkejVBemO2tzWC+ZXjdzq4w8UAEeglZ/RhgyRXB9PlcZ47sEEEHCYczi
ukDzxhGgZmfKuiHCvs7BvBot7qngy6A7wEfPv9+hWVHDz4Z9WfEULKn2XPaI9uOo
V8osKaGMyZfUl4o4geJBrxVdTSFa16phlz1UtY9AeqjNoc4xtZy26Mzfpbp88F7c
i00eayFAcO/MoHamNrzRUN9C1Mn9R/Vyz2jU2uho3AE87L2+hSrE8BIGbCMle+ux
UbhhWbBgywW1UMRwW1xjCad2PkCh52ohmSf2gJJCzYnHPzGCclo+fBG/q659vIsu
AhAi6xGCrINF1mdML66g2rv4hk9qPxKttx78EzlBXAhUNMKeqYb6UjmXnsKsmPAY
HnU98W7MpRZPAejhueqIy+55l7dNnlkmUFZf/49J9hLzGI1VMHB24iwWAisV9aay
64dvQCmovzBiGyjRH/YyAoLMtCILd52b2cXqlHKbsJkCz6pLKqcQQV0eWIVAwp/T
CDMmPbApiJ8Knnyo4dEyQzugQgpgO8VNTvcgsm91hFIB+BtjNmB53GwnoziJh1yM
j+7Hz3czCZBEIzU2wrioZYUpmpEwQBoHdrx3+YoBL7Wmdvgm6XM=
=div5
-----END PGP SIGNATURE-----

--rcfuox7jrzun6lqu--
