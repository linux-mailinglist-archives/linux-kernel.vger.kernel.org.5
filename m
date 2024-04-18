Return-Path: <linux-kernel+bounces-150066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED688A99ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C918C1F21839
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5DC22F19;
	Thu, 18 Apr 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HaYZpKgd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749E6FC3;
	Thu, 18 Apr 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443662; cv=none; b=AdE1l3rcdUcBnSwkTs/yHVNbtP4Fc/T6CxVmaOeXJbn/obKd+dCDJzrKwYX+CXPHbL4JZ8ObVzk4Lx2F9iuRTKklvbZhak3KYwkIblf9AFSZAa074nxBVQDHx8dyRDAo36ueiueXtVySKX/QdOcLG25K0HqYR32gmhljCMzzSeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443662; c=relaxed/simple;
	bh=9nrO80FRTuJXMuwoaTwMR7mzXbtEaRk4icXUo6sWJXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL+o4Crf+3GKHCYu6pND2K2P+LwjrFpFmhPtQqiu6XEblcajSWcxmKtlLr913diJdinM5JfK+/SXqNfPkq0uIWWCmlGF77D1Dqk/X/OiFCYDqeSBMqaRpxPMtA6FW73S7QE4yceRxDWwzysrWO/Nfu32xBPsAh30VuYNePNHDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HaYZpKgd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713443655;
	bh=9nrO80FRTuJXMuwoaTwMR7mzXbtEaRk4icXUo6sWJXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaYZpKgdNFUdHkfAcsARDN6AXW4gxCFkHK6jY2fTv8nDN53OqOyhSjzpAHXORAVJ3
	 lddss/S96/oRtugpzT0eEUkMnOwv6hB64H+/UuUtYLltujwMWlqpO0Dl/9Bz+3+tk7
	 tQ9vroTmxaCya/ZCHLdrFd1qU1tPWLNjqa70tGyPvHjjPqaktDJMZ0V8gZzy9VpeKt
	 eygdvspEX9yI52Gf1aY2ZhT0wYABhcPPoHCo+y0oxG53TZJNsNi45UavBH7s5zytuR
	 m5GgUTSDWoWev3XQrBjN7fdV1J7Uv+ip7bH/HT/1hrVwF/JXoUHkrTbFLHh51yDEQn
	 j1kB16xP5U5ZQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 238373781116;
	Thu, 18 Apr 2024 12:34:15 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id C3714106071D; Thu, 18 Apr 2024 14:34:14 +0200 (CEST)
Date: Thu, 18 Apr 2024 14:34:14 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	=?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/5] power: supply: power-supply-leds: Add
 charging_orange_full_green trigger for RGB LED
Message-ID: <sjhe7jvzvrlthf42lipnsnooh3z7vczdcruupsbstmpiujprze@jxwc3lquzvki>
References: <20240416053909.256319-1-hpa@redhat.com>
 <20240416053909.256319-5-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rjak7nyqoe7bx2om"
Content-Disposition: inline
In-Reply-To: <20240416053909.256319-5-hpa@redhat.com>


--rjak7nyqoe7bx2om
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 16, 2024 at 01:39:08PM +0800, Kate Hsuan wrote:
> Add a charging_orange_full_green LED trigger and the trigger is based on
> led_mc_trigger_event() which can set an RGB LED when the trigger is
> triggered. The LED will show orange when the battery status is charging.
> The LED will show green when the battery status is full.
>=20
> Link: https://lore.kernel.org/linux-leds/f40a0b1a-ceac-e269-c2dd-0158c5b4=
a1ad@gmail.com/
>=20
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/power_supply_leds.c | 26 ++++++++++++++++++++++++
>  include/linux/power_supply.h             |  2 ++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/sup=
ply/power_supply_leds.c
> index c7db29d5fcb8..8dd99199c65b 100644
> --- a/drivers/power/supply/power_supply_leds.c
> +++ b/drivers/power/supply/power_supply_leds.c
> @@ -22,6 +22,9 @@
>  static void power_supply_update_bat_leds(struct power_supply *psy)
>  {
>  	union power_supply_propval status;
> +	unsigned int intensity_green[3] =3D {255, 0, 0};
> +	unsigned int intensity_orange[3] =3D {128, 0, 255};
> +	unsigned int intensity_red[3] =3D {0, 0, 255};
> =20
>  	if (power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS, &status))
>  		return;
> @@ -36,12 +39,20 @@ static void power_supply_update_bat_leds(struct power=
_supply *psy)
>  		/* Going from blink to LED on requires a LED_OFF event to stop blink */
>  		led_trigger_event(psy->charging_blink_full_solid_trig, LED_OFF);
>  		led_trigger_event(psy->charging_blink_full_solid_trig, LED_FULL);
> +		led_mc_trigger_event(psy->charging_orange_full_green_trig,
> +				     intensity_green,
> +				     ARRAY_SIZE(intensity_green),
> +				     LED_FULL);
>  		break;
>  	case POWER_SUPPLY_STATUS_CHARGING:
>  		led_trigger_event(psy->charging_full_trig, LED_FULL);
>  		led_trigger_event(psy->charging_trig, LED_FULL);
>  		led_trigger_event(psy->full_trig, LED_OFF);
>  		led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
> +		led_mc_trigger_event(psy->charging_orange_full_green_trig,
> +				     intensity_orange,
> +				     ARRAY_SIZE(intensity_orange),
> +				     LED_FULL);
>  		break;
>  	default:
>  		led_trigger_event(psy->charging_full_trig, LED_OFF);
> @@ -49,6 +60,10 @@ static void power_supply_update_bat_leds(struct power_=
supply *psy)
>  		led_trigger_event(psy->full_trig, LED_OFF);
>  		led_trigger_event(psy->charging_blink_full_solid_trig,
>  			LED_OFF);
> +		led_mc_trigger_event(psy->charging_orange_full_green_trig,
> +				     intensity_red,
> +				     ARRAY_SIZE(intensity_red),
> +				     LED_OFF);
>  		break;
>  	}
>  }
> @@ -74,6 +89,11 @@ static int power_supply_create_bat_triggers(struct pow=
er_supply *psy)
>  	if (!psy->charging_blink_full_solid_trig_name)
>  		goto charging_blink_full_solid_failed;
> =20
> +	psy->charging_orange_full_green_trig_name =3D kasprintf(GFP_KERNEL,
> +		"%s-charging-orange-full-green", psy->desc->name);
> +	if (!psy->charging_orange_full_green_trig_name)
> +		goto charging_red_full_green_failed;
> +
>  	led_trigger_register_simple(psy->charging_full_trig_name,
>  				    &psy->charging_full_trig);
>  	led_trigger_register_simple(psy->charging_trig_name,
> @@ -82,9 +102,13 @@ static int power_supply_create_bat_triggers(struct po=
wer_supply *psy)
>  				    &psy->full_trig);
>  	led_trigger_register_simple(psy->charging_blink_full_solid_trig_name,
>  				    &psy->charging_blink_full_solid_trig);
> +	led_trigger_register_simple(psy->charging_orange_full_green_trig_name,
> +				    &psy->charging_orange_full_green_trig);
> =20
>  	return 0;
> =20
> +charging_red_full_green_failed:
> +	kfree(psy->charging_blink_full_solid_trig_name);
>  charging_blink_full_solid_failed:
>  	kfree(psy->full_trig_name);
>  full_failed:
> @@ -101,10 +125,12 @@ static void power_supply_remove_bat_triggers(struct=
 power_supply *psy)
>  	led_trigger_unregister_simple(psy->charging_trig);
>  	led_trigger_unregister_simple(psy->full_trig);
>  	led_trigger_unregister_simple(psy->charging_blink_full_solid_trig);
> +	led_trigger_unregister_simple(psy->charging_orange_full_green_trig);
>  	kfree(psy->charging_blink_full_solid_trig_name);
>  	kfree(psy->full_trig_name);
>  	kfree(psy->charging_trig_name);
>  	kfree(psy->charging_full_trig_name);
> +	kfree(psy->charging_orange_full_green_trig_name);
>  }
> =20
>  /* Generated power specific LEDs triggers. */
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index c0992a77feea..9b6898085224 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -318,6 +318,8 @@ struct power_supply {
>  	char *online_trig_name;
>  	struct led_trigger *charging_blink_full_solid_trig;
>  	char *charging_blink_full_solid_trig_name;
> +	struct led_trigger *charging_orange_full_green_trig;
> +	char *charging_orange_full_green_trig_name;
>  #endif
>  };
> =20
> --=20
> 2.44.0
>=20
>=20

--rjak7nyqoe7bx2om
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYhEzsACgkQ2O7X88g7
+prC0Q//Rb0bzJmGZkOxFWmxv+IBe9q++qbxCWIjBwwb4XT6VSj0i9LdMdJ5NKr3
nwqUL2LT7NZ7xjQJ7tq60AwEvmCB/okPOGDmB6zdwHcgWDtVV/vJjjWvtv0G9goz
2szdOTQfPx7B8RcM+2TEe1YX+N4aVvx+OOY7eWiZlvf6Oec8UcnstUU9Oei/BHod
WL5Hvy1fbf2TZdIOW/HuXFgORaiC1JJ3uPjNI4DfH7vuHUiMSHxHHuAhvAGl7Vst
LlLLXIHgEgrFsAnlWa750e6VqvWLcK0INRuh/N7BzDz8kNuJe8PX4TDsdwOZgYTO
1EleCSYoElW4C/CDTeJeYu1g9810F09jsnM4DEAwnWhWsg1hrb3cfdhnViunDpVU
eJt/6iwHCVtBx10hJAQEaKCY5GIZ3UKUCGa37DkndO23Bv0LOy7AKmbwefaE1FCf
lp8NPFXM1Wvlwfh4fr+casBzwKem5e6JTsy+DXnm9ogfBgUxldzw5um8+DEBc+Jl
LDVQqsSGPlIxb7N/GUSzimWj86GTJwsIhFcqedmi5t0nI68kDNYXBlEYccgm6JiA
wOJZ0Km2yVEa+NYkUGxTxEW453G2ycZTRVB3494Tt379JwW161woDC+ko5eMEbXA
McOywM0Z+Yciiinx/G9RnAkdge/bL/hZiaMBwUdEkm8kD/X3tFs=
=En/T
-----END PGP SIGNATURE-----

--rjak7nyqoe7bx2om--

