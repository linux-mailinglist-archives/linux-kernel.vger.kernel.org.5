Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D77EE51F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344264AbjKPQZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjKPQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:25:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7714C192
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:25:01 -0800 (PST)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C18F6607351;
        Thu, 16 Nov 2023 16:25:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700151900;
        bh=YpAunOGqpfgbEEM5AokVOHm+a/t0CygzPOeK2kDHpXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqKPvIEXVqiBcQQWZaxhVu5ymVz/Co8pUzI1ckAKfdWs0N+g4z207aBtG5vkEqB4x
         dQBdambstTq+szjbn+RM2gMz2bpOf8QsyUmHlMV+zvpsCyc+O1WeiP/L6HKWoYzKfM
         GmGgsAq7SS1ECh2qf37Oh5Lbjk4WeTDnzczjGlYI7HSYyUhkdyPeQCsFnFKv1aMxck
         1K2qGpXcaHE9a9a7UE4dZKkP3Nh43B/QIEjfUXDy5NnT7LaqV0g1RBx9SLJpm9NObq
         mTHa+hoEK12QFL6qRxd/az9qvLPrjCE4HIb8RHZvEGJLUiJsxIxHHi6Wo7ga/+T4dL
         pXJ4+tuT/s4pw==
Received: by mercury (Postfix, from userid 1000)
        id D521E10613A1; Thu, 16 Nov 2023 17:24:57 +0100 (CET)
Date:   Thu, 16 Nov 2023 17:24:57 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Adam Green <greena88@gmail.com>
Subject: Re: [PATCH v2] mfd: rk8xx: fixup devices registration with
 PLATFORM_DEVID_AUTO
Message-ID: <20231116162457.v4k5aydq44r5sekz@mercury.elektranox.org>
References: <20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v2-1-3f1bad68ab9d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3s6ynmf6too6drvs"
Content-Disposition: inline
In-Reply-To: <20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v2-1-3f1bad68ab9d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3s6ynmf6too6drvs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 16, 2023 at 03:05:13PM +0100, Neil Armstrong wrote:
> Since commit 210f418f8ace ("mfd: rk8xx: Add rk806 support"), devices are
> registered with "0" as id, causing devices to not have an automatic devic=
e id
> and prevents having multiple RK8xx PMICs on the same system.
>=20
> Properly pass PLATFORM_DEVID_AUTO to devm_mfd_add_devices() and since
> it will ignore the cells .id with this special value, also cleanup
> by removing all now ignored cells .id values.
>=20
> Now we have the same behaviour as before rk806 introduction and rk806
> retains the intented behavior.
>=20
> This fixes a regression while booting the Odroid Go Ultra on v6.6.1:
> sysfs: cannot create duplicate filename '/bus/platform/devices/rk808-clko=
ut'
> CPU: 3 PID: 97 Comm: kworker/u12:2 Not tainted 6.6.1 #1
> Hardware name: Hardkernel ODROID-GO-Ultra (DT)
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
> dump_backtrace+0x9c/0x11c
> show_stack+0x18/0x24
> dump_stack_lvl+0x78/0xc4
> dump_stack+0x18/0x24
> sysfs_warn_dup+0x64/0x80
> sysfs_do_create_link_sd+0xf0/0xf8
> sysfs_create_link+0x20/0x40
> bus_add_device+0x114/0x160
> device_add+0x3f0/0x7cc
> platform_device_add+0x180/0x270
> mfd_add_device+0x390/0x4a8
> devm_mfd_add_devices+0xb0/0x150
> rk8xx_probe+0x26c/0x410
> rk8xx_i2c_probe+0x64/0x98
> i2c_device_probe+0x104/0x2e8
> really_probe+0x184/0x3c8
> __driver_probe_device+0x7c/0x16c
> driver_probe_device+0x3c/0x10c
> __device_attach_driver+0xbc/0x158
> bus_for_each_drv+0x80/0xdc
> __device_attach+0x9c/0x1ac
> device_initial_probe+0x14/0x20
> bus_probe_device+0xac/0xb0
> deferred_probe_work_func+0xa0/0xf4
> process_one_work+0x1bc/0x378
> worker_thread+0x1dc/0x3d4
> kthread+0x104/0x118
> ret_from_fork+0x10/0x20
> rk8xx-i2c 0-001c: error -EEXIST: failed to add MFD devices
> rk8xx-i2c: probe of 0-001c failed with error -17
>=20
> Fixes: 210f418f8ace ("mfd: rk8xx: Add rk806 support")
> Reported-by: Adam Green <greena88@gmail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Finally a full cleanup is required to fix the regression because rk806 had
> a special treatment still allowing DEVID_AUTO while all the other cells
> regressed to DEVID_NONE.
>=20
> [1] https://lore.kernel.org/all/20231115180050.5r5xukttz27vviyi@mercury.e=
lektranox.org/
> ---

LGTM

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes in v2:
> - Do a full cleanup instead of simply changing the id value passed to reg=
ister
> - Link to v1: https://lore.kernel.org/r/20231116-topic-amlogic-upstream-f=
ix-rk8xx-devid-auto-v1-1-75fa43575ab7@linaro.org
> ---
>  drivers/mfd/rk8xx-core.c | 34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> index c47164a3ec1d..b1ffc3b9e2be 100644
> --- a/drivers/mfd/rk8xx-core.c
> +++ b/drivers/mfd/rk8xx-core.c
> @@ -53,76 +53,68 @@ static const struct resource rk817_charger_resources[=
] =3D {
>  };
> =20
>  static const struct mfd_cell rk805s[] =3D {
> -	{ .name =3D "rk808-clkout", .id =3D PLATFORM_DEVID_NONE, },
> -	{ .name =3D "rk808-regulator", .id =3D PLATFORM_DEVID_NONE, },
> -	{ .name =3D "rk805-pinctrl", .id =3D PLATFORM_DEVID_NONE, },
> +	{ .name =3D "rk808-clkout", },
> +	{ .name =3D "rk808-regulator", },
> +	{ .name =3D "rk805-pinctrl", },
>  	{
>  		.name =3D "rk808-rtc",
>  		.num_resources =3D ARRAY_SIZE(rtc_resources),
>  		.resources =3D &rtc_resources[0],
> -		.id =3D PLATFORM_DEVID_NONE,
>  	},
>  	{	.name =3D "rk805-pwrkey",
>  		.num_resources =3D ARRAY_SIZE(rk805_key_resources),
>  		.resources =3D &rk805_key_resources[0],
> -		.id =3D PLATFORM_DEVID_NONE,
>  	},
>  };
> =20
>  static const struct mfd_cell rk806s[] =3D {
> -	{ .name =3D "rk805-pinctrl", .id =3D PLATFORM_DEVID_AUTO, },
> -	{ .name =3D "rk808-regulator", .id =3D PLATFORM_DEVID_AUTO, },
> +	{ .name =3D "rk805-pinctrl", },
> +	{ .name =3D "rk808-regulator", },
>  	{
>  		.name =3D "rk805-pwrkey",
>  		.resources =3D rk806_pwrkey_resources,
>  		.num_resources =3D ARRAY_SIZE(rk806_pwrkey_resources),
> -		.id =3D PLATFORM_DEVID_AUTO,
>  	},
>  };
> =20
>  static const struct mfd_cell rk808s[] =3D {
> -	{ .name =3D "rk808-clkout", .id =3D PLATFORM_DEVID_NONE, },
> -	{ .name =3D "rk808-regulator", .id =3D PLATFORM_DEVID_NONE, },
> +	{ .name =3D "rk808-clkout", },
> +	{ .name =3D "rk808-regulator", },
>  	{
>  		.name =3D "rk808-rtc",
>  		.num_resources =3D ARRAY_SIZE(rtc_resources),
>  		.resources =3D rtc_resources,
> -		.id =3D PLATFORM_DEVID_NONE,
>  	},
>  };
> =20
>  static const struct mfd_cell rk817s[] =3D {
> -	{ .name =3D "rk808-clkout", .id =3D PLATFORM_DEVID_NONE, },
> -	{ .name =3D "rk808-regulator", .id =3D PLATFORM_DEVID_NONE, },
> +	{ .name =3D "rk808-clkout", },
> +	{ .name =3D "rk808-regulator", },
>  	{
>  		.name =3D "rk805-pwrkey",
>  		.num_resources =3D ARRAY_SIZE(rk817_pwrkey_resources),
>  		.resources =3D &rk817_pwrkey_resources[0],
> -		.id =3D PLATFORM_DEVID_NONE,
>  	},
>  	{
>  		.name =3D "rk808-rtc",
>  		.num_resources =3D ARRAY_SIZE(rk817_rtc_resources),
>  		.resources =3D &rk817_rtc_resources[0],
> -		.id =3D PLATFORM_DEVID_NONE,
>  	},
> -	{ .name =3D "rk817-codec", .id =3D PLATFORM_DEVID_NONE, },
> +	{ .name =3D "rk817-codec", },
>  	{
>  		.name =3D "rk817-charger",
>  		.num_resources =3D ARRAY_SIZE(rk817_charger_resources),
>  		.resources =3D &rk817_charger_resources[0],
> -		.id =3D PLATFORM_DEVID_NONE,
>  	},
>  };
> =20
>  static const struct mfd_cell rk818s[] =3D {
> -	{ .name =3D "rk808-clkout", .id =3D PLATFORM_DEVID_NONE, },
> -	{ .name =3D "rk808-regulator", .id =3D PLATFORM_DEVID_NONE, },
> +	{ .name =3D "rk808-clkout", },
> +	{ .name =3D "rk808-regulator", },
>  	{
>  		.name =3D "rk808-rtc",
>  		.num_resources =3D ARRAY_SIZE(rtc_resources),
>  		.resources =3D rtc_resources,
> -		.id =3D PLATFORM_DEVID_NONE,
>  	},
>  };
> =20
> @@ -684,7 +676,7 @@ int rk8xx_probe(struct device *dev, int variant, unsi=
gned int irq, struct regmap
>  					     pre_init_reg[i].addr);
>  	}
> =20
> -	ret =3D devm_mfd_add_devices(dev, 0, cells, nr_cells, NULL, 0,
> +	ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, nr_cells,=
 NULL, 0,
>  			      regmap_irq_get_domain(rk808->irq_data));
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
>=20
> ---
> base-commit: f31817cbcf48d191faee7cebfb59197d2048cd64
> change-id: 20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-59ce0d1b7=
38a
>=20
> Best regards,
> --=20
> Neil Armstrong <neil.armstrong@linaro.org>
>=20

--3s6ynmf6too6drvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmVWQkwACgkQ2O7X88g7
+prNlA/9GJzjR4o0qjT26mQbftor1X7jG8XP+VbivZIXwCwoWZDSaFzZeRMZasTM
fPBXMRerkZYeJl5j6flSMPIN+dF2vFLtvaa/TJu30ZbBlqlawNSEd6E3b8YCnpeh
4CvJMMAnWCeEWbbKMRpPIbqlGDoeybbUBS/2kTQzM6pVQcMkxl+5Juu+kW80AX1E
hZPbmGv55OIjcm6EQVMEs/x6U77DQ3KUZtImJ382biRVOR2n/WjiPsblQOXi8eSm
tBcm7sqa0Nqvfq9F9vd8ZngsZqCjhCoX0GM3Q6enP0wHQa9oIMPQmI5h9OXRXhFq
Ru4OnVhZHMUTvfQyvBoR3ejAOktOEmUpSQ/IzVE82v8nQLAq1EI83/nUsMU+kOrB
XEr3ACiifrTsLrE7423bJ5vXIcw/oFZ7t7NbpsKgTTxaBpBrdX5osDVCZ6Rpl9Le
S7levrFlla7upDWl5CJCDEw2Rs6uohNkrrWoZucG0H99OS0EosnpdV9ySQaka6+U
hD/VyttOj6q6QwANtwp1z36bYriA9RF/hRoMcCJdBuXtWFiP/7QLmFmOFJHok60H
2KxTF+Bd3JujNUWeKR1qTtIqO+ZPBSAhRpKoRVN7TEu3M9u0QHlWdyOHVay84Xi7
m1qrQ1dPwEbIu+sc/JuwUGYmGNhvl6cnBbTHsHok5nRMH7twtP8=
=pfzF
-----END PGP SIGNATURE-----

--3s6ynmf6too6drvs--
