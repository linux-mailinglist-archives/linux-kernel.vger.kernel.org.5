Return-Path: <linux-kernel+bounces-144307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2258A4467
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CB81C20CDD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4932C135A65;
	Sun, 14 Apr 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="htrnAf79"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C6134CD0;
	Sun, 14 Apr 2024 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713115803; cv=none; b=K45L3pFTl4YJSTEJ7X26QKDAHe6XiDYdadl1XVjC8bUalb6OfltyvzGn5SZoSBjm7t/3H7sldO2ry6YISE27FyCGvzObSGXgvEVnsrjmMwHy279bw3NFz2+m+MfCyQHEF8124pZvfDsQu0xuMvf6lraTeI1NMTbQGVwjw+EH9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713115803; c=relaxed/simple;
	bh=oGOHxDj4kfdOE/HzO5dKHC063UBWLzSiV7pAnYLyCPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcbQ7oIgj2Xg3Emx4iUG/Nznc3O9cIO24aspISl4wiLXvGsWUE6cFsB15beNePAoLQmpThdcSo/33//GKMPegXHroutLJDEASq7gTLlPS2w5pjgnbWRxPNiejEmGRdXe4DmsgysT5NiCvUkF2N9aJRtlb3ucEsAxHXWsM9zw3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=htrnAf79; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713115799;
	bh=oGOHxDj4kfdOE/HzO5dKHC063UBWLzSiV7pAnYLyCPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htrnAf79VM0ZqVqBR08Z4L/roRsBN2oX462GKbGRRZCjHSw8tqZdnPd1hHz+wYxbl
	 /tl8y0l56GgRwLTCezto6y9/FvEOuQ5wQPyUWM8WfvOA8XFMOsT1U+iAK8mRiS/gG5
	 CEWkTRLaVX4HKTOfAbbTxnYwE2VVn01DvVZnxImDkRQhXQf65BOYMqeBSnJ9QFwO/S
	 c7l8nps68U+5T/z3jfHnAeD+7tuVMyGSUbjRmf2mFkQa8weO/wQ76kugoIKLvqJO88
	 ihT0WrpcX5WwQwUrYsxOnyYKmPGvBJxP2yq7tvtmSaaxFrRzODLUl3MnvqJYwwMPg4
	 e+YmDDCZqXDIA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ADBE13780627;
	Sun, 14 Apr 2024 17:29:59 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 13DD010608FB; Sun, 14 Apr 2024 19:29:57 +0200 (CEST)
Date: Sun, 14 Apr 2024 19:29:56 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v3 2/2] power: supply: ltc3350-charger: Add driver
Message-ID: <lxxwadaf2mrghy2kygm3cucb7ygl5qu4dxnmpbancrm2hwjm4g@5eudactyudca>
References: <20240409135442.37732-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dab85cfc-973d-4930-8fea-324aa26b5801@emailsignatures365.codetwo.com>
 <20240409135442.37732-2-mike.looijmans@topic.nl>
 <5hpl2kspf667hmmxgg36ahiux5rs364qzrg2itpljspspa47vp@dsbnhdnq5s54>
 <efae4037-c22a-40be-8ba9-7c1c12ece042@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="empim7clzpnbt47x"
Content-Disposition: inline
In-Reply-To: <efae4037-c22a-40be-8ba9-7c1c12ece042@topic.nl>


--empim7clzpnbt47x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[+cc Nicolas]

Hello Mike,

On Fri, Apr 12, 2024 at 08:53:58AM +0200, Mike Looijmans wrote:
> > please share output of
> > ./tools/testing/selftests/power_supply/test_power_supply_properties.sh
> > below the fold with your next submission. It's useful for verifying,
> > that you got the unit scaling correct for the standard properties :)
>=20
> Will do. Did a quick run on the driver as it is now, that yields the
> following output:
>=20
> (Any thoughts on the "arithmetic syntax error" messages?)

The script contains some bash specific shell extensions and should
use /bin/bash instead of /bin/sh in the shebang. Just call it with
/bin/bash ./tools/testing/... and you should get rid of them :)

Nicolas, do you want to send a fix for that to Shuah with Reported-by
=66rom Mike?

[...]

> # Reported: '1' ()
> ok 6 ltc3350.sysfs.online

[...]

> # Reported: '711600' uA (711.6 mA)
> ok 24 ltc3350.sysfs.current_now

So it's full, but still getting charged with 0.7 Amps at ~23V
(i.e. 16W)? That seems quite high.

[...]

> > > +static ssize_t ltc3350_attr_show(struct device *dev,
> > > +				 struct device_attribute *attr, char *buf,
> > > +				 unsigned int reg, unsigned int scale)
> > > +{
> > > +	struct power_supply *psy =3D to_power_supply(dev);
> > > +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> > > +	unsigned int regval;
> > > +	int ret;
> > > +
> > > +	ret =3D regmap_read(info->regmap, reg, &regval);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	regval *=3D scale; /* Scale is in 10 =CE=BCV units */
> > please keep custom uAPI consistent with the general uAPI and use =C2=B5=
V.
>=20
> I'll amend the comment to clarify that this is about the scale factor pas=
sed
> into this method. This prevents overflow while keeping all calculations in
> 32 bits.

ack

[...]

> > > +/* Shunt voltage, 183.5=CE=BCV per LSB */
> > > +LTC3350_DEVICE_ATTR_RW(vshunt, LTC3350_REG_VSHUNT, 1835);
> > > +
> > > +/* Single capacitor voltages, 183.5=CE=BCV per LSB */
> > > +LTC3350_DEVICE_ATTR_RO(vcap1, LTC3350_REG_MEAS_VCAP1, 1835);
> > > +LTC3350_DEVICE_ATTR_RO(vcap2, LTC3350_REG_MEAS_VCAP2, 1835);
> > > +LTC3350_DEVICE_ATTR_RO(vcap3, LTC3350_REG_MEAS_VCAP3, 1835);
> > > +LTC3350_DEVICE_ATTR_RO(vcap4, LTC3350_REG_MEAS_VCAP4, 1835);
> > > +LTC3350_DEVICE_ATTR_RW(cap_uv, LTC3350_REG_CAP_UV_LVL, 1835);
> > > +LTC3350_DEVICE_ATTR_RW(cap_ov, LTC3350_REG_CAP_OV_LVL, 1835);
> > > +
> > > +/* General purpose input, 183.5=CE=BCV per LSB */
> > > +LTC3350_DEVICE_ATTR_RO(gpi, LTC3350_REG_MEAS_GPI, 1835);
> > > +LTC3350_DEVICE_ATTR_RW(gpi_uv, LTC3350_REG_GPI_UV_LVL, 1835);
> > > +LTC3350_DEVICE_ATTR_RW(gpi_ov, LTC3350_REG_GPI_OV_LVL, 1835);
> > > +
> > > +/* Input voltage, 2.21mV per LSB */
> > > +LTC3350_DEVICE_ATTR_RO(vin, LTC3350_REG_MEAS_VIN, 22100);
> > > +LTC3350_DEVICE_ATTR_RW(vin_uv, LTC3350_REG_VIN_UV_LVL, 22100);
> > > +LTC3350_DEVICE_ATTR_RW(vin_ov, LTC3350_REG_VIN_OV_LVL, 22100);
> > > +
> > > +/* Capacitor stack voltage, 1.476 mV per LSB */
> > > +LTC3350_DEVICE_ATTR_RO(vcap, LTC3350_REG_MEAS_VCAP, 14760);
> > > +LTC3350_DEVICE_ATTR_RW(vcap_uv, LTC3350_REG_VCAP_UV_LVL, 14760);
> > > +LTC3350_DEVICE_ATTR_RW(vcap_ov, LTC3350_REG_VCAP_OV_LVL, 14760);
> > I suppose it would be sensible to expose this as a second
> > power_supply device of type battery with ltc3350_config.supplied_to
> > set to this second power_supply device.
> >=20
> > Then you can map
> >=20
> > LTC3350_REG_MEAS_VCAP -> VOLTAGE_NOW
> > LTC3350_REG_VCAP_UV_LVL -> VOLTAGE_MIN
> > LTC3350_REG_VCAP_OV_LVL -> VOLTAGE_MAX
> > LTC3350_REG_VSHUNT -> CURRENT_NOW
> > TECHNOLOGY =3D POWER_SUPPLY_TECHNOLOGY_CAPACITOR (new)
>=20
> Makes sense.
>=20
> Should I create a separate patch that adds the new properties?

Yes, make it one extra patch adding POWER_SUPPLY_TECHNOLOGY_CAPACITOR
and one extra patch for the cell information properties. Also do not
forget to update all necessary files:

 * Documentation/ABI/testing/sysfs-class-power
 * include/linux/power_supply.h
 * drivers/power/supply/power_supply_sysfs.c

> > Also the single capacitor voltages are similar to per-cell voltage
> > information, so I think we should create generic properties for
> > that:
> >=20
> > LTC3350_REG_NUM_CAPS   -> NUMBER_OF_CELLS (new)
> > LTC3350_REG_MEAS_VCAP1 -> CELL1_VOLTAGE_NOW (new)
> > LTC3350_REG_MEAS_VCAP2 -> CELL2_VOLTAGE_NOW (new)
> > LTC3350_REG_MEAS_VCAP3 -> CELL3_VOLTAGE_NOW (new)
> > LTC3350_REG_MEAS_VCAP4 -> CELL4_VOLTAGE_NOW (new)
> > LTC3350_REG_CAP_UV_LVL -> CELL_VOLTAGE_MIN (new)
> > LTC3350_REG_CAP_OV_LVL -> CELL_VOLTAGE_MAX (new)
> >=20
> > ...

After re-reading it: This only works for serial cells, but not for
parallel ones. While it's technically not possible to measure
parallel cells, it might be desired to expose the exact
configuration at some point. Thus it should be
NUMBER_OF_SERIAL_CELLS. Also the documentation for
CELL<X>_VOLTAGE_NOW should mention that this might measure more than
one cell, if there are multiple cells connected in parallel.

[...]

> > > +
> > > +static int ltc3350_probe(struct i2c_client *client)
> > > +{
> > > +	struct i2c_adapter *adapter =3D client->adapter;
> > > +	struct device *dev =3D &client->dev;
> > > +	struct ltc3350_info *info;
> > > +	struct power_supply_config ltc3350_config =3D {};
> > > +	int ret;
> > > +
> > > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
> > > +		dev_err(dev, "No support for SMBUS_WORD_DATA\n");
> > > +		return -ENODEV;
> > > +	}
> > return dev_err_probe(dev, -ENODEV, "No support for SMBUS_WORD_DATA\n");
> >=20
> > But I think this can just be dropped. devm_regmap_init_i2c() should
> > generate an error, if the i2c adapter requirements are not met.
>=20
> It's quite interesting to see what other drivers do here. Most report a
> message, and there's no consensus on the value returned.

I checked and devm_regmap_init_i2c() calls into regmap_get_i2c_bus()
and that contains the same check. If it fails, the bus will not be
found and the function returns -ENOTSUPP. It should be fine to remove
the driver specific extra handling with the error being printed for
devm_regmap_init_i2c(). Considering this is mostly a hardware sanity
check, I would expect this error to only happen on developer
systems. A developer should be able to figure out what that means.

Greetings,

-- Sebastian

--empim7clzpnbt47x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYcEpAACgkQ2O7X88g7
+ppgJA/+IhLiJ3Q9ST7X5EasixJEnW6bG0DslSSvXUEw12PVjRSvZ1uJCzGtXMQ1
3b+C3ARCcVkVpr64dQDMmYwUDTCi8XAodgv1NX+eEe9QuxW4xnbRSxIsvtZ6Tclb
gPb9uLvwScTdrZX/zkwaWY3pcczimOzWLX3p+qymyd9+DNnFKZy88xWSLHyqCPVg
TPF8ZcsHpPaDfQyRtizg1N+HUtAfL7ZGGW2g9gR2ekIBo4cK1Soa6nSDe9y30+CR
fNd2X9/RSU2Dd+MEBOHje1ptBI7UMe2w1WxjS7duJl7oBj8cdRAyPlJ568UjekYK
o8pRg1GiJ0SnoodbyjQpQXfg3Lofauhn4AsQ0n+qNbZFgAZks4hzBrhB+mwIYrjb
/cr6MxwAU1J01Ch3b4nx7E8rtQx9sTk4f2hbw0WVj+ntj6hF1rIyKgNfsbHUl2kv
q/uNOlhMyYlb1QVBy6KVw71U2nLlVrtGTFffbnfSQ9cq8ZEkjpdWavdhrZHmXDiz
WAXR2rg68dU3xUP8AgQsAEaYFb9yklhQCHbpnbqUcCSqxF1UcCi2oFPyUpbKWWha
E98DfJv4Zi9oRCMc0NogY50moD47FkEyF7tQMKdKCSd6BQJV58C0C/dUS4PcVg/G
8siIqm9Vp2ElY7cASblwFxu89P17+0/UOmA634oTPZAz4VTE1BQ=
=gXIh
-----END PGP SIGNATURE-----

--empim7clzpnbt47x--

