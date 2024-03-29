Return-Path: <linux-kernel+bounces-125169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEFA892194
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4771F2665A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D77585942;
	Fri, 29 Mar 2024 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqjEwkC4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989785298;
	Fri, 29 Mar 2024 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729431; cv=none; b=OJcgGNGKWIgIoLdr2fkB+jw9uZN+t/VXLPeK51DWJetKcKL1kgCxw8gUQiUiOdWE/CjVV5bUNaG7kbHmmvuqh+1FcEla9W63khlnOEAeBVlkG8eU3i4OCKEb9G5CHAy5uQH5fcMXs2lzEtmMMuaSwKMSQSccHzRWH6FkXSBTu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729431; c=relaxed/simple;
	bh=xAIheBzeDFe9gAy7K03pZGAgl2K/WDJn0EzGeK10nsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQQeVFogo9kBlOF3ZeZGxbGSiQ0L1z56tmdtu+o4xUVqK6MrWWzswS9I2sbTv74XFg8jDCGBV3+lC9cE4fBjIX1Hw3InV18AOfuo1hujGmuKrftzgrFaTK7IyXuGhnh74tUlCCwrmcHfuRinR+jne33xxzL3gReUMRpC2JqFyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqjEwkC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C4EC433F1;
	Fri, 29 Mar 2024 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711729431;
	bh=xAIheBzeDFe9gAy7K03pZGAgl2K/WDJn0EzGeK10nsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VqjEwkC4s+9WKiWWBrbzPJwZvUjPGr1GsJssTW2nTPBB3UJHunb82vNyDdMrSnZDx
	 mVoAOuStXGPM9OMW57nu9ZkN8BS6nlBVoXr7ERJh4sA+KF5d7Gq0b8jkAzxveCIsSH
	 7Le0wZvz6aKeYK3oqEAZFrmrYl1DEIRdOCQB/RGtcjB6qeWSsz5o5Ifod8dRN34rrX
	 gzpU0La+Tj5I3RlQOdpsNBrHtfl9RsWyACCvr0UC2WAveSaNR3T+Biacmij3GE19/S
	 SSn/mIKegVbQeQqMbrPJTdlJDDmEJj6KXygFvmkmx4X3ychBnMPt9KhePJLQMGJ1ag
	 vQEGNuyN8hnQQ==
Received: by mercury (Postfix, from userid 1000)
	id 5A97510608D9; Fri, 29 Mar 2024 17:23:48 +0100 (CET)
Date: Fri, 29 Mar 2024 17:23:48 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	=?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 5/6] power: supply: power-supply-leds: Add
 charging_red_full_green trigger for RGB LED
Message-ID: <nakbogrilul6skiab5opfsqhhqfotfgmb47wyd3xbgbpf6hurc@6xshfz3obj7m>
References: <20240324150107.976025-1-hpa@redhat.com>
 <20240324150107.976025-6-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bnl5eqiu4mggmjza"
Content-Disposition: inline
In-Reply-To: <20240324150107.976025-6-hpa@redhat.com>


--bnl5eqiu4mggmjza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Kate,

On Sun, Mar 24, 2024 at 11:01:06PM +0800, Kate Hsuan wrote:
> Add a charging_red_full_green LED trigger and the trigger is based on
> led_mc_trigger_event() which can set an RGB LED when the trigger is
> triggered. The LED will show red when the battery status is charging.
> The LED will show green when the battery status is full.
>=20
> Link: https://lore.kernel.org/linux-leds/f40a0b1a-ceac-e269-c2dd-0158c5b4=
a1ad@gmail.com/T/#t
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---

Have you considered using orange instead of red? Using orange as
charging indicator seems to be more common nowadays and allows

green  =3D battery full
orange =3D battery charging
red    =3D battery empty / battery dead / error

Greetings,

-- Sebastian

>  drivers/power/supply/power_supply_leds.c | 25 ++++++++++++++++++++++++
>  include/linux/power_supply.h             |  2 ++
>  2 files changed, 27 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/sup=
ply/power_supply_leds.c
> index c7db29d5fcb8..bd9c8fec5870 100644
> --- a/drivers/power/supply/power_supply_leds.c
> +++ b/drivers/power/supply/power_supply_leds.c
> @@ -22,6 +22,8 @@
>  static void power_supply_update_bat_leds(struct power_supply *psy)
>  {
>  	union power_supply_propval status;
> +	unsigned int intensity_green[3] =3D {255, 0, 0};
> +	unsigned int intensity_red[3] =3D {0, 0, 255};
> =20
>  	if (power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS, &status))
>  		return;
> @@ -36,12 +38,20 @@ static void power_supply_update_bat_leds(struct power=
_supply *psy)
>  		/* Going from blink to LED on requires a LED_OFF event to stop blink */
>  		led_trigger_event(psy->charging_blink_full_solid_trig, LED_OFF);
>  		led_trigger_event(psy->charging_blink_full_solid_trig, LED_FULL);
> +		led_mc_trigger_event(psy->charging_red_full_green_trig,
> +				     intensity_green,
> +				     3,
> +				     LED_FULL);
>  		break;
>  	case POWER_SUPPLY_STATUS_CHARGING:
>  		led_trigger_event(psy->charging_full_trig, LED_FULL);
>  		led_trigger_event(psy->charging_trig, LED_FULL);
>  		led_trigger_event(psy->full_trig, LED_OFF);
>  		led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
> +		led_mc_trigger_event(psy->charging_red_full_green_trig,
> +				     intensity_red,
> +				     3,
> +				     LED_FULL);
>  		break;
>  	default:
>  		led_trigger_event(psy->charging_full_trig, LED_OFF);
> @@ -49,6 +59,10 @@ static void power_supply_update_bat_leds(struct power_=
supply *psy)
>  		led_trigger_event(psy->full_trig, LED_OFF);
>  		led_trigger_event(psy->charging_blink_full_solid_trig,
>  			LED_OFF);
> +		led_mc_trigger_event(psy->charging_red_full_green_trig,
> +				     intensity_red,
> +				     3,
> +				     LED_OFF);
>  		break;
>  	}
>  }
> @@ -74,6 +88,11 @@ static int power_supply_create_bat_triggers(struct pow=
er_supply *psy)
>  	if (!psy->charging_blink_full_solid_trig_name)
>  		goto charging_blink_full_solid_failed;
> =20
> +	psy->charging_red_full_green_trig_name =3D kasprintf(GFP_KERNEL,
> +		"%s-charging-red-full-green", psy->desc->name);
> +	if (!psy->charging_red_full_green_trig_name)
> +		goto charging_red_full_green_failed;
> +
>  	led_trigger_register_simple(psy->charging_full_trig_name,
>  				    &psy->charging_full_trig);
>  	led_trigger_register_simple(psy->charging_trig_name,
> @@ -82,9 +101,13 @@ static int power_supply_create_bat_triggers(struct po=
wer_supply *psy)
>  				    &psy->full_trig);
>  	led_trigger_register_simple(psy->charging_blink_full_solid_trig_name,
>  				    &psy->charging_blink_full_solid_trig);
> +	led_trigger_register_simple(psy->charging_red_full_green_trig_name,
> +				    &psy->charging_red_full_green_trig);
> =20
>  	return 0;
> =20
> +charging_red_full_green_failed:
> +	kfree(psy->charging_blink_full_solid_trig_name);
>  charging_blink_full_solid_failed:
>  	kfree(psy->full_trig_name);
>  full_failed:
> @@ -101,10 +124,12 @@ static void power_supply_remove_bat_triggers(struct=
 power_supply *psy)
>  	led_trigger_unregister_simple(psy->charging_trig);
>  	led_trigger_unregister_simple(psy->full_trig);
>  	led_trigger_unregister_simple(psy->charging_blink_full_solid_trig);
> +	led_trigger_unregister_simple(psy->charging_red_full_green_trig);
>  	kfree(psy->charging_blink_full_solid_trig_name);
>  	kfree(psy->full_trig_name);
>  	kfree(psy->charging_trig_name);
>  	kfree(psy->charging_full_trig_name);
> +	kfree(psy->charging_red_full_green_trig_name);
>  }
> =20
>  /* Generated power specific LEDs triggers. */
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index c0992a77feea..1d7c0b43070f 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -318,6 +318,8 @@ struct power_supply {
>  	char *online_trig_name;
>  	struct led_trigger *charging_blink_full_solid_trig;
>  	char *charging_blink_full_solid_trig_name;
> +	struct led_trigger *charging_red_full_green_trig;
> +	char *charging_red_full_green_trig_name;
>  #endif
>  };
> =20
> --=20
> 2.44.0
>=20
>=20

--bnl5eqiu4mggmjza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYG6woACgkQ2O7X88g7
+pphVQ/6A1+OXzjPuauzgsq0RMlPlWxqIS4j3Cg7r3vvo1ZxFjb2sMFGGzgBPAwP
n+zwP462szCeWuqdZCL62h9JSQvB4eUx0HdNqiLb6Z3GCJmCjdLjtUwnsgVPT3ny
6OPra4jyw1y+1UcwVePwhz23jphH+8CDk5VF7uZu4PUgNryyS2owID7CAKQgNdPp
56Mz/FRgJXPRb6iAEOqKFe0eveYeRDYWbve/GBZ9XkBObeJAQ+qb8ko8oL99BrlD
bubkvSRGXtaldkk7oUfhhMutZYowK86Gmc4zUkFFjMLIXVACUE1aR8zq0lPVIxfL
9FFP6kNwa47+hTU9/GyNRmF5bhukcaSQIdhucW2/vUFeu651V/Gou/z3NAe48PM+
40owjIPXLfMuvX08e/OKAOzvrwuVee7sg9K51L0s8r3xQ6xUzwRKXuLVuxa6nV61
OnLG6Rfblg3qaerClMk1v2vFdAsHZGhnN0oxoJDAndT8rJZ+ywGWiyehX0P91JwC
7PkBvOUXdf+QJn7S4Wy5yT5uwTMJm9x1GRYhzSUVVqq8UUVFXnFHioaqI+nLXewa
uqy59GzObqGnZuDAD6NNyRb+N8NVHMtqWG88PxxhGNq3Ep4+Vc92+M6cN55icG3X
TfZRlxBzsilyuq7Rte8YW0URiZIRY5zDfg/ib8UmPdyFHkMW4Bg=
=F8cp
-----END PGP SIGNATURE-----

--bnl5eqiu4mggmjza--

