Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF035764924
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjG0HoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjG0HnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:43:13 -0400
Received: from wp534.webpack.hosteurope.de (wp534.webpack.hosteurope.de [80.237.130.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB2665AD;
        Thu, 27 Jul 2023 00:37:15 -0700 (PDT)
Received: from [2001:a61:6209:7f40:c80a:ff:fe00:4098] (helo=cs-office3.lan.local); authenticated
        by wp534.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qOvXU-0001KS-51; Thu, 27 Jul 2023 09:36:00 +0200
Date:   Thu, 27 Jul 2023 09:35:36 +0200
From:   Carsten =?UTF-8?B?U3BpZcOf?= <mail@carsten-spiess.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (isl28022) new driver for ISL28022 power
 monitor
Message-ID: <20230727093536.4cd2f84f.mail@carsten-spiess.de>
In-Reply-To: <206ad774-bf6f-aed3-81a7-3d9c8f80a69e@roeck-us.net>
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-2-mail@carsten-spiess.de>
 <206ad774-bf6f-aed3-81a7-3d9c8f80a69e@roeck-us.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MGGM_A8Q33sTV.cBcgYWC0E";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-bounce-key: webpack.hosteurope.de;mail@carsten-spiess.de;1690443436;b1c67de8;
X-HE-SMSGID: 1qOvXU-0001KS-51
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MGGM_A8Q33sTV.cBcgYWC0E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


On 7/26/23 18:14, Gueter Roeck wrote:
> On 7/26/23 08:22, Carsten Spie=C3=9F wrote:
> > +The shunt value in micro-ohms, shunt gain and averaging can be set
> > +via device tree at compile-time. =20
>=20
> At _compile-time_ ?
How to explain better that it isn't set at runtime?
Other drivers use the same term.

> I'd argue that shunt voltage is all but useless, but if you want to have =
it supported
> it _has_ to be in mV.
That's a problem.

In my case the ER-6P has a 8 milli Ohm (or 8000 micro Ohm) shunt and a powe=
rsupply with=20
max. 2.5 A. This gives a max shunt voltage of 20 mV at 2.5 A.
The device normaly consumes between 200 and 500 mA. (typ ~250 mA).
This results in shunt voltage of 1.6 to 4.0 mV (typ ~2mV).
Having no fractions will make it useless.=20

Unfortunately there is no possibility to give a scaling factor.
Or returning float values (i know, this can't and shouldn't be changed)

> Why not support limit attributes ?
Due to limited time, left for later enhancement.


> > +#define ISL28022_REG_SHUNT	0x01
> > +#define ISL28022_REG_BUS	0x02


> > +	switch (type) {
> > +	case hwmon_in:
> > +		switch (attr) {
> > +		case hwmon_in_input:
> > +			err =3D regmap_read(data->regmap,
> > +					  ISL28022_REG_SHUNT + channel, &regval); =20
>=20
> That never reads REG_BUS.
Hmm,=20
channel 0: ISL28022_REG_SHUNT + 0 =3D=3D 0x01
channel 1: ISL28022_REG_SHUNT + 1 =3D=3D 0x02 =3D=3D ISL28022_REG_BUS
or do i miss something?

> > +			if (err < 0)
> > +				return err;
> > +			*val =3D (channel =3D=3D 0) ?
> > +					(long)((s16)((u16)regval)) * 10 :
> > +					(long)(((u16)regval) & 0xFFFC); =20
>=20
> I don't think the sign extensions are correct based on the datasheet.
> This will have to use sign_extend.
=46rom my understading (see table 11 on page 16 of the ISL28022 datasheet)
shunt value is already sign extended, (D15-D12 is sign)
bus value (table 12 on page 16) is unsigned.

> > +			err =3D regmap_read(data->regmap,
> > +					  ISL28022_REG_CURRENT, &regval);
> > +			if (err < 0)
> > +				return err;
> > +			if (!data->shunt)
> > +				return -EINVAL; =20
>=20
> Getting an error message each time the "sensors" command is executed ?
> Unacceptable.
o.k., will change to set *val =3D 0;

> > +			err =3D regmap_read(data->regmap,
> > +					  ISL28022_REG_POWER, &regval);
> > +			if (err < 0)
> > +				return err;
> > +			if (!data->shunt)
> > +				return -EINVAL; =20
>=20
> Unacceptable.
o.k., as above

> > +			*val =3D ((long)regval * 409600000L * (long)data->gain) /
> > +				(long)(8 * data->shunt); =20
>=20
> I don't think this was checked for overflows.
Yes, i must first divide then multiply.
I have to think about how to keep accuracy on high shunt resistor values.

> > +static int isl28022_config(struct device *dev)
> > +{
> > +	struct isl28022_data *data =3D dev_get_drvdata(dev);
> > +
> > +	if (!dev || !data)
> > +		return -EINVAL; =20
>=20
> How would this ever happen ?
Shouldn't, but i'm carefully (i had it once during development due to an er=
ror
(using dev instead of hwmon_dev) on calling this function
=20
> > +	regmap_write(data->regmap, ISL28022_REG_CONFIG, data->config);
> > +	regmap_write(data->regmap, ISL28022_REG_CALIB, data->calib); =20
>=20
> Error checking needed.
o.k. will add.

> > +static int isl28022_probe(struct i2c_client *client)
> > +{

> > +	if (!i2c_check_functionality(client->adapter,
> > +				     I2C_FUNC_SMBUS_BYTE_DATA |
> > +				     I2C_FUNC_SMBUS_WORD_DATA))
> > +		return -EIO; =20
>=20
> This is not an IO error. Return -ENODEV as most other drivers do.
o.k.

> > +	of_property_read_u32(dev->of_node, "shunt-gain", &data->gain);
> > +	of_property_read_u32(dev->of_node, "average", &data->average); =20
>=20
> Check for errors and provide defaults if properties are not set.
o.k.

> Also please use device_property_read_u32() to enable use from non-devicet=
ree
> systems.
o.k. Never used this, have to look for an example on using it.
Many (old) drivers are using the of_property_* functions, is it intended to=
 replace it.
What about backporting this driver to e.g. 5.15, will it affect it?

> > +	status =3D isl28022_config(hwmon_dev);
> > +	if (status)
> > +		return status; =20
>=20
> That has to happen before the call to devm_hwmon_device_register_with_inf=
o()
> to avoid race conditions.
o.k.

> > +static struct i2c_driver isl28022_driver =3D {
> > +	.class		=3D I2C_CLASS_HWMON,
> > +	.driver =3D {
> > +		.name	=3D "isl28022",
> > +		.of_match_table =3D of_match_ptr(isl28022_of_match), =20
>=20
> Drop of_match_ptr()
Most drivers have this, why drop?

Regards, Carsten

--Sig_/MGGM_A8Q33sTV.cBcgYWC0E
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWM+MlUpz/bWsZllTM1JQzV9LKSwFAmTCHkgACgkQM1JQzV9L
KSz5HQ/+OiXavZXLAYOznmn73v48ib6qgiLne38B9LAumnmxcC6ble3uc5QSHkkB
wNZkfUu+Jf5397JNOIkWclzLYX470HrZCrV7LS5A9N8JnoQz1rTpU/Laoziw0Wu7
cT55f4wfdlipMh8yS1rVkEqSwes5key6fFwmQPgsdxUuJufrgpIONHvdmRSzA2mE
JGNCJADpFQ7HIrGuO/i8PlegsNviNyx4HZI2xTnIth0wYy/og9yfqMCXmFoGWgSM
2ltFKdV0/iwsP2K5cZucRyuPwM/D35Kv4wWgzbbstEzv0OuiADJnkiYkwBDpnObE
tYl/GXsk/jfFH1nXktomJjz4NW+0Sso5WaRO4SWw1cfWoa6vJyQ/6RVWxH6m20Ti
zs5r40WXavrp3RVgnShFuPD/dD45WtG09clWJvLsavQU83a+Dyvs6YdPESGxhlIq
8SLnbKdmIMarLtzmsmu1gRjqowQ1TPBgnQ3//7j6ahKxKpAE8JPFSZDHnVwIluKZ
6i/UdEzsmGOq7IEzG8m8uL8M7ZZRRFi7xnJOrim0ZdffWW8Sjxx39XyNSqYAEgh3
7Nu9bjfdJd7nHxO4tBzczGzQNrAS/JrSXJquojiG/DIPs81K34c60ZamVXmcU2FG
e3N9t/js5tuskS5qFYhF2T/yV/uSK90ppHklgkkVgROeiycQBik=
=3Ouh
-----END PGP SIGNATURE-----

--Sig_/MGGM_A8Q33sTV.cBcgYWC0E--
