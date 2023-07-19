Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7604F75A180
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGSWNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGSWNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:13:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC431BCF;
        Wed, 19 Jul 2023 15:13:15 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F3416607058;
        Wed, 19 Jul 2023 23:13:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689804794;
        bh=4wqdNSX9wNybCZxff7444C8uT2sNtfc0g+td0eQpgI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aiXz364rvyXX/UVEKiGgmuz6zV4KHRUpdVl07ZQrLlDN9bH/Zcn0VhhIZMancz3dP
         Cha1sGFSYIxpdhEvPhZ6zMLhwvL0YplUf8w3PT/LCTcHMZHN436wyr/w9oOedpLF9s
         UsFS6MYgl/B2eHpgTvgrg7IEhuxvQ3DJFWjRn7KqsJx32fqgmeZ9StglgSHJcGUV2t
         4gX3HTTSqf9z7xFzqeri8jEN07tpZ2w7Uny6NJvpH5VTc4lbjKd1qIaz1pWniZtl/7
         I2KdsF0SiDSlIl8/hiTndaZZdd7X+QLlSpwd6p6I+0NlwiM7UwSyysEeb9kWCHo59L
         FIAy+xHi2EN6g==
Received: by mercury (Postfix, from userid 1000)
        id 836221062877; Thu, 20 Jul 2023 00:13:11 +0200 (CEST)
Date:   Thu, 20 Jul 2023 00:13:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: Avoid duplicate hwmon device from
 thermal framework
Message-ID: <20230719221311.a3esxsykojkxmyzw@mercury.elektranox.org>
References: <20230613090726.1358199-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rucyhb2ezh5winuw"
Content-Disposition: inline
In-Reply-To: <20230613090726.1358199-1-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rucyhb2ezh5winuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 13, 2023 at 05:07:23PM +0800, Chen-Yu Tsai wrote:
> When the power supply device being registered supports a temperature
> readout, the core registers a thermal zone for it. The thermal core
> would register a hwmon device for that unless told otherwise.
>=20
> When CONFIG_POWER_SUPPLY_HWMON is enabled, the power supply core creates
> a hwmon device. This results in a second entry, one which has a better
> name than the one registered through the thermal framework. It could
> potentially have readouts other than temperature.
>=20
> To simplify the result, tell the thermal framework to not register a
> hwmon device if CONFIG_POWER_SUPPLY_HWMON is enabled. The result is
> one hwmon device with all the readings the device supports.

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 3791aec69ddc..4aa466c945e2 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1305,8 +1305,12 @@ static int psy_register_thermal(struct power_suppl=
y *psy)
> =20
>  	/* Register battery zone device psy reports temperature */
>  	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> +		/* Prefer our hwmon device and avoid duplicates */
> +		struct thermal_zone_params tzp =3D {
> +			.no_hwmon =3D IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
> +		};
>  		psy->tzd =3D thermal_zone_device_register(psy->desc->name,
> -				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
> +				0, 0, psy, &psy_tzd_ops, &tzp, 0, 0);
>  		if (IS_ERR(psy->tzd))
>  			return PTR_ERR(psy->tzd);
>  		ret =3D thermal_zone_device_enable(psy->tzd);
> --=20
> 2.41.0.162.gfafddb0af9-goog
>=20

--rucyhb2ezh5winuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS4X/MACgkQ2O7X88g7
+pqJfRAAjHNNKuLGpBOVv5IMxKWPj26BmYVQkXIJmTWRDN4JjarIjYP7wvsugOtt
lgvSzEjk5F1yvoKFSB+snP5z0Ti+rtIUQ/hyERmAu+fGPiOxXdl9u9OFwd6Hq3Pi
ujNsW58KCIOb7im58OcFKCoWLmRxCIGiRT/pznVOBVVUDVSng9xGNGLnL6xUwYKd
OXoZ9hI2wdKQq6YDWLY2Q/EcAJRoA/A/NI0Urz45FO21gHFPOXsLMDHBTI1qHIXt
zF2GEbHBFlWUkll4Zi1A94uXM/t+QloKeeP7WJpyA8rgniVkiiqK2Vw6/wxALW1L
f/kJ+e3elCWiQwJ0zAfSnpbPWDXTHqA1IEeA8Sah5/Z1ByxSqaJ0qN55uJBpKhFU
1zwMi+1dGu7Yy/2X5VQ64bMrnxDFa3bcVNFqKZTRn4et9KjMtQazvRuEyebWUG22
4FuV1VADBEhwoombXlsov/EtogjQmRCSyTyxclSE4vNo4fnSco5WMgjnNsZFsEYa
JsAj6FTEijRDE8TOiQErCRvdYPBjlVqx/JXWtgRk32Ax+oKFB7LjW2Ocxn0kntKO
/g/RolkLS21qK1o0DCmuFQdIUZelXtSiP82hGZJKsRySDKNnEhb+U2YTCRp/mH8P
6QWMy0Bn40WJHB5zOYyqu1fkzBjv91ZmyQ578eA/j6rWsNz4TXY=
=BfNy
-----END PGP SIGNATURE-----

--rucyhb2ezh5winuw--
