Return-Path: <linux-kernel+bounces-72127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D785AFBA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970191C21D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FED56771;
	Mon, 19 Feb 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n89XBpu8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9154F94;
	Mon, 19 Feb 2024 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708384807; cv=none; b=UkR4cYNzHoqYRjCA1H19sNT4X67pc2hs171RpvL9sV5OI3zmwq8ngC5myxLvIVXODGoB81MTY6QF/RRvHBDvi7UsHk065BItcUT1j21mx45SefxC381S95HwRZIqP2sl4pB7lt4AzCHC5QZ5yw/jg3ASu1Y9fUT5xfc1mMWhnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708384807; c=relaxed/simple;
	bh=XUc65of2cZOXL1PVY11hWmQBcj8Vz9jo6+rrkM2xMbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmwWr9xYgp2XmW0br59t0g+7IZkbL+OdcRatL9iNFMcMaeGgMDlzsSetTsjfXg8x4OTyFSNcURLnpXo7frzFh2vSHUfxCbZognzQyjV2XS1vLksAKNIuexgdzT8hbahtvNnoeOcbuy669yboWamJ8SMRHG4gNpTZz+bUA892zdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n89XBpu8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708384798;
	bh=XUc65of2cZOXL1PVY11hWmQBcj8Vz9jo6+rrkM2xMbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n89XBpu8LmeIlX/DvnppBAu40nnwLJCuYgls1uyeFtTMljsWglHgXHFTEBuEOAJ9K
	 HmEEFoNyAJtJwswTjLr3ts/jZMSppNlXcURB6HduO043esZhL8zaRPRa84QzRD/zeI
	 dNEZ7hSTRr/OXj6JxU3/SXIynQNnp9ReV7wDLzpGF1vaZmdWKNqL5kUTCfHfbw9MlK
	 mP8paSxgnkabE/HErVaEIrUmByN7tj60BhrDgeiutp1QdgArSERhQwDnyP9uMikKBc
	 mIbDchXIdDTNhznxL83NuDyaTzGdrcZxEfNmFdnrn/lWQd5dMGLZ12mAH42P27NGAY
	 C1mP9wamVUGnQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E4B123782081;
	Mon, 19 Feb 2024 23:19:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 580C11060E69; Tue, 20 Feb 2024 00:19:57 +0100 (CET)
Date: Tue, 20 Feb 2024 00:19:57 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] power: supply: core: fix charge_behaviour formatting
Message-ID: <jtdl3hxza3efjqxpb55tpsoglx4i633vctaf5fikfo2emxvy57@j4r44h4egggw>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
 <20240204-power_supply-charge_behaviour_prop-v1-1-06a20c958f96@weissschuh.net>
 <53082075-852f-4698-b354-ed30e7fd2683@redhat.com>
 <3d27029b-caef-45a1-88bf-98f78e6d6a61@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vpm6jqok5ze6m5w"
Content-Disposition: inline
In-Reply-To: <3d27029b-caef-45a1-88bf-98f78e6d6a61@redhat.com>


--2vpm6jqok5ze6m5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 05, 2024 at 12:43:54PM +0100, Hans de Goede wrote:
> On 2/5/24 10:52, Hans de Goede wrote:
> > Thank you for your patches for this.

Indeed, thanks for cleaning up this mess.

> > On 2/4/24 18:26, Thomas Wei=DFschuh wrote:
> >> This property is documented to have a special format which exposes all
> >> available behaviours and the currently active one at the same time.
> >> For this special format some helpers are provided.
> >>
> >> However the default property logic in power_supply_sysfs.c is not using
> >> the helper and the default logic only prints the currently active
> >> behaviour.
> >>
> >> Adjust power_supply_sysfs.c to follow the documented format.
> >>
> >> There are currently two in-tree drivers exposing charge behaviours:
> >> thinkpad_acpi and mm8013.
> >> thinkpad_acpi is not affected by the change, as it directly uses the
> >> helpers and does not use the power_supply_sysfs.c logic.
> >>
> >> As mm8013 does not implement POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILA=
BLE
> >> the new logic will preserve the simple output format in this case.
> >>
> >> Fixes: 1b0b6cc8030d ("power: supply: add charge_behaviour attributes")
> >> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> >> ---
> >>  drivers/power/supply/power_supply_sysfs.c | 32 ++++++++++++++++++++++=
+++++++++
> >>  include/linux/power_supply.h              |  1 +
> >>  2 files changed, 33 insertions(+)
> >>
> >> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power=
/supply/power_supply_sysfs.c
> >> index 977611e16373..3680cfc2e908 100644
> >> --- a/drivers/power/supply/power_supply_sysfs.c
> >> +++ b/drivers/power/supply/power_supply_sysfs.c
> >> @@ -271,6 +271,32 @@ static ssize_t power_supply_show_usb_type(struct =
device *dev,
> >>  	return count;
> >>  }
> >> =20
> >> +static ssize_t power_supply_show_charge_behaviour(struct device *dev,
> >> +						  struct power_supply *psy,
> >> +						  struct power_supply_attr *ps_attr,
> >> +						  union power_supply_propval *value,
> >> +						  char *buf)
> >> +{
> >> +	union power_supply_propval available;
> >> +	int ret;
> >> +
> >> +	ret =3D power_supply_get_property(psy,
> >> +					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> >> +					value);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret =3D power_supply_get_property(psy,
> >> +					POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
> >> +					&available);
> >> +	if (ret =3D=3D -EINVAL)
> >> +		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value->intval]);
> >> +	else if (ret < 0)
> >=20
> > No need for "else if" here since the if above does a return. So you can=
 just do:
> >=20
> > 	if (ret < 0)
> > 		return ret;
> >=20
> >=20
> >> +		return ret;
> >> +
> >> +	return power_supply_charge_behaviour_show(dev, available.intval, val=
ue->intval, buf);
> >> +}
> >> +
> >>  static ssize_t power_supply_show_property(struct device *dev,
> >>  					  struct device_attribute *attr,
> >>  					  char *buf) {
> >> @@ -282,6 +308,8 @@ static ssize_t power_supply_show_property(struct d=
evice *dev,
> >> =20
> >>  	if (psp =3D=3D POWER_SUPPLY_PROP_TYPE) {
> >>  		value.intval =3D psy->desc->type;
> >> +	} else if (psp =3D=3D POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR) {
> >> +		value.intval =3D -1;
> >>  	} else {
> >>  		ret =3D power_supply_get_property(psy, psp, &value);
> >> =20
> >=20
> > I'm not a fan of this, I guess that you are doing this because you do n=
ot
> > want to enter this if:
> >=20
> >         if (ps_attr->text_values_len > 0 &&
> >             value.intval < ps_attr->text_values_len && value.intval >=
=3D 0) {
> >                 return sysfs_emit(buf, "%s\n", ps_attr->text_values[val=
ue.intval]);
> >         }
> >=20
> > But by doing this you add both the special case of setting value.intval=
 =3D -1
> > here and you now need to do the power_supply_get_property() which is in=
 the else
> > manually in power_supply_show_charge_behaviour() and the error handling=
 / logging
> > of power_supply_get_property() in power_supply_show_charge_behaviour() =
is different.
> >=20
> > What I think you can (and should) do here instead is move:
> >=20
> >         if (ps_attr->text_values_len > 0 &&
> >             value.intval < ps_attr->text_values_len && value.intval >=
=3D 0) {
> >                 return sysfs_emit(buf, "%s\n", ps_attr->text_values[val=
ue.intval]);
> >         }
> >=20
> > into the default case of the switch (psp) {} below it in a preparation =
patch.
> >=20
> > This if is never entered for the 2 non default cases in that switch, so=
 it
> > is safe to move it into the default case, e.g. something like this:
> >=20
> > 	default:
> > 	        if (ps_attr->text_values_len > 0 &&
> >         	    value.intval < ps_attr->text_values_len && value.intval >=
=3D 0)
> >                 	ret =3D sysfs_emit(buf, "%s\n", ps_attr->text_values[v=
alue.intval]);
> > 		else
> > 			ret =3D sysfs_emit(buf, "%d\n", value.intval);
> >=20
> > I think that also actually makes things a bit cleaner then the current
> > early-exit for printing enum values.
> >=20
> > And then in the next patch you can just add:
> >=20
> > 	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> > 		ret =3D power_supply_show_charge_behaviour(dev, psy, ps_attr,
> > 							 &value, buf);
> > 		break;
> >=20
> > Without needing to set intval =3D -1 and without needing to get the val=
ue
> > inside power_supply_show_charge_behaviour() since that will already
> > be done for you then.
>=20
> One more note on this. With the suggested preparation patch to move
> the if checking for ps_attr->text_values into the default case,
> you can then also properly turn POWER_SUPPLY_PROP_USB_TYPE into an
> enum too:
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 977611e16373..768df64330f4 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -209,7 +209,7 @@ static struct power_supply_attr power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(TIME_TO_FULL_NOW),
>  	POWER_SUPPLY_ATTR(TIME_TO_FULL_AVG),
>  	POWER_SUPPLY_ENUM_ATTR(TYPE),
> -	POWER_SUPPLY_ATTR(USB_TYPE),
> +	POWER_SUPPLY_ENUM_ATTR(USB_TYPE),
>  	POWER_SUPPLY_ENUM_ATTR(SCOPE),
>  	POWER_SUPPLY_ATTR(PRECHARGE_CURRENT),
>  	POWER_SUPPLY_ATTR(CHARGE_TERM_CURRENT),
>=20
> IOW you can now set ps_attr->text_values* for POWER_SUPPLY_PROP_USB_TYPE
> too, without needing to worry this causing power_supply_show_usb_type()
> no longer to get called.
>=20
> The reason I'm mentioning this is because power_supply_show_usb_type()
> and power_supply_charge_behaviour_show() show a lot of code-duplication.
>=20
> And I think that we can have one generic function replacing both
> by using ps_attr->text_values* instead of hardcoding POWER_SUPPLY_USB_TYP=
E_TEXT
> resp. power_supply_charge_behaviour_show (and yes this contradicts
> my earlier comment on patch 4/4).
>=20
> Although at a closer look I see now that the usb-types code uses
> a list of supported type enum values in the power_supply_desc,
> where as the charge_behavior code uses a bitmask which you retrieve
> through a new property.
>=20
> Thinking more about this, I think that adding a fake
> POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE property as you do here
> might actually not be the best idea. All the other properties
> are visible in sysfs, so this one is a bit weird. I think it might
> be better to add this info to power_supply_desc like how this is
> done for the usb-types.
>=20
> And:
>         const enum power_supply_usb_type *usb_types;
>         size_t num_usb_types;
>=20
> Should probably be converted into a bitmask too. I checked
> and there are not that many users of this.
>=20
> Once we have that as a bitmask too, we can refactor
> power_supply_show_usb_type() and power_supply_charge_behaviour_show()
> into a single new helper.
>=20
> But I believe that refactoring:
>=20
>         const enum power_supply_usb_type *usb_types;
>         size_t num_usb_types;
>=20
> into a bitmask is out of scope for this series. So I guess
> that for now just add the bitmask of available charge behaviors
> to power_supply_desc rather then making it a fake property
> and then in the future we can do the refactor of usb-type
> to a bitmask and remove the code duplication between
> power_supply_show_usb_type() and power_supply_charge_behaviour_show()
>=20
> Sebastian, any comments ?

Sorry for the delay coming to this series; I fully agree with this.
Thanks for the thorough review.

-- Sebastian

--2vpm6jqok5ze6m5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXT4hIACgkQ2O7X88g7
+pprvQ//SCY8aD5ibel6ZxJ+mYgIwGFJeS/f2XUrehfyYonFoNOu01qAGOGYj/qi
EDgIHWZuYoz9Ocs/oeoj4aVidsRCIXBC5w0hs8gVUyEt8eMpHv8brlzYcPblLezt
B+VktTdMpk39RO5hKAkWEn4aicj9Xa91DGDRc3V/MZQpCpgaBepdit2b6/MdRlVZ
Lso3UA/kvazGPEosVgZoa7k+bm+MRKFMm/CRnTOwTPqASwlaDrD2SFcTz45nqFh+
BE+1cU0JCtabfkq9EKd6zJazJa1h0FpRiYg74IwMAgMFvVrJHR6XdmB/GcAuiden
2+qwvvRY9UyO4jPxWMhgy8SJO2UyyYA8OupuyPB3PDg4OOczBd9c9XbgqZT4qhot
MZOJciK7DD/WQTJfDejSA84MU9llCocjh8qwK+Ro4pxFBC7QFyVzHjumMtWGRn/c
8inbUfwRbESkZnennbuUZNtZbGTQ9nBJ7+aDnJTJ2g5Pq7kJIjugbJyDa/1mdBGA
kYBqJhkqxAJEo96D649Ag5QaJ9yo8++1OYjRFCnbuciU853Uus8+CxuO7biHVNi3
jxLogevSR8LP2oGM/1BmdmzoUxAowV8oY5/zA1uzGQUFMy7eadEcGksFxhvbxOrV
uGeS+ucc6Ok32ja4bZYIe+bWgeUGLr7nIve0pEmASKHkRmpdW+8=
=cyBh
-----END PGP SIGNATURE-----

--2vpm6jqok5ze6m5w--

