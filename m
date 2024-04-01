Return-Path: <linux-kernel+bounces-126839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44D893E14
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D302834F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C884779E;
	Mon,  1 Apr 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BLGT9jyv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9B47A6B;
	Mon,  1 Apr 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987142; cv=none; b=nZa5l+hOBOFWs7hYsogTlLvSoEvclKB1HU6ZYCEwfcIgD0WobwvxpXFJFnVMh1gdczkFEAXcwgfMMq/7Tl3AbWfIF46CnH24Ci+TEbyB0vFVuPp659yXmTYJLqvTZcLOVbvQGWdxGFuWGEJu7hKha3PgGgIVcHnq8mL9IMaWCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987142; c=relaxed/simple;
	bh=WH/JXSmbMU4r5V/wKzEcNwcuz6RWsNiYqocaGFrJddE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td82+oytYSbhft1UUI2n5U0OmI9OafhCvK9ZuWOpbdKfziJcLPL+PPU/opZBftnMFrDQNDSyflJx1XiUCZTPig+yYL+RjC+CdjOTc0x2scWuy1NUgfsrYodhTu/4+Ro8/t1axi7kCWCmqBVLxY0m36qNWqOfuv/TV98319gVfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BLGT9jyv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711987138;
	bh=WH/JXSmbMU4r5V/wKzEcNwcuz6RWsNiYqocaGFrJddE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLGT9jyvMZFJzmYyDJ+rJRKeiHQ8Ge7Yzl7Tl7lmQwwaWmH+l1yVXJDgU0UGlm8of
	 5ossgCh2uwY4RFWc6YCPDxXiLgwb7eUROX3kGbMKYCktzswJbAsHpnCDXKT78D4RDU
	 A7zUVyjWvnzjHILKPminlYbXW9fX3+sRtgz9FAIDWWBZFSKU/o8B0GI/yUgwkq3oTN
	 GnIVmLRny+e+gM8MNjeI/MgYeVNYsyxt6hFSDwaM0vUVr9tTuTIcYJWY95g2HRTQ1F
	 MFHXAleN0CDKzLV2CwC1QVAVL9s5JZlo+o8FU4MeJfTAaJYJikRWnWaGoznx3114E1
	 Xq0665YbHTjEQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B2063780480;
	Mon,  1 Apr 2024 15:58:58 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 02B0610608D9; Mon,  1 Apr 2024 17:58:57 +0200 (CEST)
Date: Mon, 1 Apr 2024 17:58:57 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Message-ID: <2emtfitxzs2suh4qsvz4vgwdrtlduarjbbtzrsebtjerzzkegf@46l2d3hpatgw>
References: <20240307-sbs-time-empty-now-error-v1-1-18d0f8702330@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bklrbywybkeid6t2"
Content-Disposition: inline
In-Reply-To: <20240307-sbs-time-empty-now-error-v1-1-18d0f8702330@collabora.com>


--bklrbywybkeid6t2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi N=EDcolas,

On Thu, Mar 07, 2024 at 05:05:10PM -0500, N=EDcolas F. R. A. Prado wrote:
> Despite the RunTimeToEmpty() (0x11) function being defined in the SBS
> specification as required, it seems that not all batteries implement it.
> On platforms with such batteries, reading the property will cause an
> error to be printed:
>=20
> power_supply sbs-8-000b: driver failed to report `time_to_empty_now' prop=
erty: -5
>=20
> This not only pollutes the log, distracting from real problems on the
> device, but also prevents the uevent file from being read since it
> contains all properties, including the faulty one.
>=20
> The following table summarizes the findings for a handful of platforms:
>=20
> Platform                                Status  Manufacturer    Model
> ------------------------------------------------------------------------
> mt8186-corsola-steelix-sku131072        OK      BYD             L22B3PG0
> mt8195-cherry-tomato-r2                 NOT OK  PANASON         AP16L5J
> mt8192-asurada-spherion-r0              NOT OK  PANASON         AP15O5L
> mt8183-kukui-jacuzzi-juniper-sku16      NOT OK  LGC KT0         AP16L8J
> mt8173-elm-hana                         OK      Sunwoda         L18D3PG1
> sc7180-trogdor-lazor-limozeen-nots-r5   NOT OK  Murata          AP18C4K
> sc7180-trogdor-kingoftown               NOT OK  333-AC-0D-A     GG02047XL
> rk3399-gru-kevin                        OK      SDI             4352D51
>=20
> Identify during probe, based on the battery model, if this is one of the
> quirky batteries, and if so, don't register the
> POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW property.
>=20
> Signed-off-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/power/supply/sbs-battery.c | 45 ++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index a6c204c08232..85ff331cf87a 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -1112,6 +1112,49 @@ static const struct power_supply_desc sbs_default_=
desc =3D {
>  	.external_power_changed =3D sbs_external_power_changed,
>  };
> =20
> +static const char * const unsupported_time_to_empty_now_models[] =3D {
> +	"AP16L5J", "AP15O5L", "AP16L8J", "AP18C4K", "GG02047XL"
> +};
> +
> +static void sbs_remove_unsupported_properties(struct power_supply_config=
 *psy_cfg,
> +					      struct power_supply_desc *sbs_desc)
> +{
> +	enum power_supply_property *new_properties;
> +	struct sbs_info *chip =3D psy_cfg->drv_data;
> +	bool missing_time_to_empty_now =3D false;
> +	const char *model_name;
> +	unsigned int new_num_properties;
> +	unsigned int i =3D 0, j =3D 0;
> +
> +	model_name =3D sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MODEL_NA=
ME);
> +	if (IS_ERR(model_name))
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(unsupported_time_to_empty_now_models); i++=
) {
> +		if (!strcmp(model_name, unsupported_time_to_empty_now_models[i])) {
> +			missing_time_to_empty_now =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (!missing_time_to_empty_now)
> +		return;
> +
> +	new_num_properties =3D ARRAY_SIZE(sbs_properties) - 1;
> +	new_properties =3D devm_kzalloc(&chip->client->dev, new_num_properties =
* sizeof(sbs_properties[0]), GFP_KERNEL);
> +
> +	for (i =3D 0; i < sbs_desc->num_properties; i++) {
> +		if (sbs_desc->properties[i] =3D=3D POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW)
> +			continue;
> +
> +		new_properties[j] =3D sbs_desc->properties[i];
> +		j++;
> +	}
> +
> +	sbs_desc->properties =3D new_properties;
> +	sbs_desc->num_properties =3D new_num_properties;
> +};
> +
>  static int sbs_probe(struct i2c_client *client)
>  {
>  	struct sbs_info *chip;
> @@ -1210,6 +1253,8 @@ static int sbs_probe(struct i2c_client *client)
>  	if (rc)
>  		return rc;
> =20
> +	sbs_remove_unsupported_properties(&psy_cfg, sbs_desc);
> +
>  	chip->power_supply =3D devm_power_supply_register(&client->dev, sbs_des=
c,
>  						   &psy_cfg);
>  	if (IS_ERR(chip->power_supply))
>=20
> ---

I think it makes sense to use a proper quirk infrastructure.
Something like this:

/* required by the spec, but missing in some implementations */
#define SBS_QUIRK_BROKEN_TTE_NOW    BIT(0)

struct sbs_quirk_entry {
    const char *manufacturer;
    const char *model;
    u32 flags;
};

static const struct sbs_quirk_entry sbs_quirks[] =3D {
    {"PANASON", "AP16L5J", SBS_QUIRK_BROKEN_TTE_NOW},
    {"PANASON", "AP15O5L", SBS_QUIRK_BROKEN_TTE_NOW},
    {"LGC KT0", "AP16L8J", SBS_QUIRK_BROKEN_TTE_NOW},
    ...
};

static void sbs_update_quirks(...) {
    ...
    manufacturer =3D sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MANUFA=
CTURER);
    model =3D sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MODEL_NAME);

    /* reset quirks from battery before the hot-plug event */
    chip->quirks =3D 0;

    for (i =3D 0; i < ARRAY_SIZE(sbs_quirks); i++) {
        if (strcmp(manufacturer, sbs_quirks[i].manufacturer))
            continue;
        if (strcmp(model, sbs_quirks[i].model))
            continue;
        chip->quirks |=3D sbs_quirks[i].flags;
    }

    if (chip->quirks & SBS_QUIRK_BROKEN_TTE_NOW)
        dev_info(dev, "Added quirk disabling TIME_TO_EMPTY_NOW\n");
}

Also I think instead of removing the property, it's better to return
-ENODATA for TIME_TO_EMPTY. That will remove it from the uevent file,
but still expose the sysfs property file. So it's slightly worse from
that aspect. But it means the quirk can be handled in sbs_update_presence()
and it can be added/removed dynamically when different battery models
are used with hot-plugging.

For that it should be enough to call the above sbs_update_quirks() in
sbs_update_presence() and add this at the beginning of
sbs_get_battery_property():

if (psp =3D=3D POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW &&
    chip->quirks =3D=3D SBS_QUIRK_BROKEN_TTE_NOW)
    return -ENODATA;

As a side-effect it fixes your struggling with keeping the
properties constant. Can you check, if that works?

Thanks,

-- Sebastian

--bklrbywybkeid6t2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYK2b0ACgkQ2O7X88g7
+po4Mw//b3nyCoqiuZlpx1Ti/bEK447G474277PtlVcsKhy5EZkg68Xj2jLJUpW5
LEt9GfYRWK9i/3IpWIhTP9KAwUlUjUcdgYvyFZrAgDuBsTb6pQ/dlpj3H8pRSN3t
KAlKnxX79bo0cMCXzxF6ChMWl0NFcpPndvYATL7sWIhFxLVTlaai9CLvW4E/+7Fz
AHws7vRYLDHxTfC8y3pY4hiZwH3hgEAe7dZcoaflrRwAPqi1CNF1rFuR5GrxlVMj
8gOAy87ae4Z2MW9TvM+i7CWVuSOS3nZo21/hHQxe257QoLO+fln3rrRfEwwu2mHM
krd4DlqXpoe3Z0w0adFkCK+G28hZhLnnhr9NNy7VhZ9+nzDeH6MhU29g4m1YQwWJ
63i0efoZ76/G5boNIwHigJJUIKVskw5A5u9LBZdNihT3O1fh9DyyX16qxSrDnJPU
KkGFAvubfB460cFqZ0B4aKUccIKAPSD9NM0lIt8jkItN5y2xDolczg6NKLAjYEke
OEaSp+wXhq5zk/wrgLMmnQlgIy6gWMIGBq7sM/acjpmmpmOX9Kkg22+sLDjjlEWp
Jh/bZvqJppvyirvVH33oX2opWbC9LA2g1jh4LWi7HzFBXz4I0VrBEZgv2CV5/ajm
Q+d9KzgK7UxaCSdPyVxJfnHGLq6oPBImNTQUTG2sU5JQjM46MdA=
=x46m
-----END PGP SIGNATURE-----

--bklrbywybkeid6t2--

