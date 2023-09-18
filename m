Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E969E7A4C44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjIRP37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjIRP3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:29:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A6E173B;
        Mon, 18 Sep 2023 08:26:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76177C32792;
        Mon, 18 Sep 2023 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695049481;
        bh=4MLreeIO68p1hnvnQV5lOUn5ZmB/PhzS9DxiBUzViFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhsBVkdg/byvdPZ+3BzMPtkX0Y4n7DBY+mSzruJLGshA8a9VuV8F2PZMhXJh44Nx+
         eOqPP3VhTw+FJjSTupoLpVj+jKT2Hh9zNgQoYPYZhsn5phWf/tkvj06H205BmdTs6U
         mIupbRmIQzihk55JKcoTxWhAsPNE02mMKbAu/0SCrXE+6ieh4bReZW8DG2oa3C7ZnG
         3D8TViND9HIy73DQkS2WOkstvDAJ0cg9LefZizSCE8zbQo6mrM8HcUgoNpbuWgVroa
         5But5lnTMO8EeFwDfvjccNgytpBf7BU3F6/UfVMn5v50MUaxaixkZqz49CSUB3CkLH
         3aUdMO4VJ2UlQ==
Received: by mercury (Postfix, from userid 1000)
        id D7DCA10604BC; Mon, 18 Sep 2023 17:04:38 +0200 (CEST)
Date:   Mon, 18 Sep 2023 17:04:38 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH] power: supply: Fix info use-after-free
Message-ID: <20230918150438.4pliix4fhbpjld3l@mercury.elektranox.org>
References: <20230918-power-uaf-v1-1-73c397178c42@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaghlg4vvcp2xwwj"
Content-Disposition: inline
In-Reply-To: <20230918-power-uaf-v1-1-73c397178c42@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kaghlg4vvcp2xwwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Mon, Sep 18, 2023 at 09:33:26AM +0200, Vincent Whitchurch wrote:
> power_supply_uevent() which is called to emit a udev event on device
> deletion attempts to use the info structure which is device-managed and
> has been freed before this point.  The use-after-free is triggered since
> commit 699fb50d99039 ("drivers: base: Free devm resources when
> unregistering a device").
>=20
> Fix this by associating the devm resource with the parent device
> instead, similar to recent fixes done in the input subsystem, such as
> commit dd613a4e45f8 ("HID: uclogic: Correct devm device reference for
> hidinput input_dev").
>=20
> Note that the power supply subsystem allows drivers to register a device
> without a parent (with a warning), in this case there is still a risk of
> use-after-free since we have no other device to attach the devm to.

Thanks for the bug report with a potential fix already included :)
I think in case of power-supply this might be enough?

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supp=
ly/power_supply_sysfs.c
index 06e5b6b0e255..d483a81560ab 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -482,6 +482,13 @@ int power_supply_uevent(const struct device *dev, stru=
ct kobj_uevent_env *env)
        if (ret)
                return ret;
=20
+       /*
+        * Kernel generates KOBJ_REMOVE uevent in device removal path, after
+        * resources have been freed. Exit early to avoid use-after-free.
+        */
+       if (psy->removing)
+               return 0;
+
        prop_buf =3D (char *)get_zeroed_page(GFP_KERNEL);
        if (!prop_buf)
                return -ENOMEM;

That would also cover the no-parent-device part and avoid the
device(s) being queried for data at device removal time, which
wouldn't work if the device removal happens due to a hot-unplug.

-- Sebastian

>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  BUG: KASAN: slab-use-after-free in power_supply_battery_info_has_prop (p=
ower_supply_core.c:872)
>  Read of size 4 at addr 0000000062e59028 by task python3/27
>=20
>  Call Trace:
>   power_supply_battery_info_has_prop (power_supply_core.c:872)
>   power_supply_uevent (power_supply_sysfs.c:504)
>   dev_uevent (drivers/base/core.c:2590)
>   kobject_uevent_env (lib/kobject_uevent.c:558)
>   kobject_uevent (lib/kobject_uevent.c:643)
>   device_del (drivers/base/core.c:3266 drivers/base/core.c:3831)
>   device_unregister (drivers/base/core.c:3730 drivers/base/core.c:3854)
>   power_supply_unregister (power_supply_core.c:1608)
>   devm_power_supply_release (power_supply_core.c:1515)
>   release_nodes (drivers/base/devres.c:506)
>   devres_release_group (drivers/base/devres.c:669)
>   i2c_device_remove (drivers/i2c/i2c-core-base.c:629)
>   device_remove (drivers/base/dd.c:570)
>   device_release_driver_internal (drivers/base/dd.c:1274 drivers/base/dd.=
c:1295)
>   device_driver_detach (drivers/base/dd.c:1332)
>   unbind_store (drivers/base/bus.c:247)
>   ...
>=20
>  Allocated by task 27:
>   devm_kmalloc (drivers/base/devres.c:119 drivers/base/devres.c:829)
>   power_supply_get_battery_info (include/linux/device.h:316 power_supply_=
core.c:626)
>   __power_supply_register (power_supply_core.c:1408)
>   devm_power_supply_register (power_supply_core.c:1544)
>   bq256xx_probe (bq256xx_charger.c:1539 bq256xx_charger.c:1727) bq256xx_c=
harger
>   i2c_device_probe (drivers/i2c/i2c-core-base.c:584)
>   really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
>   __driver_probe_device (drivers/base/dd.c:800)
>   device_driver_attach (drivers/base/dd.c:1128)
>   bind_store (drivers/base/bus.c:273)
>   ...
>=20
>  Freed by task 27:
>   kfree (mm/slab_common.c:1073)
>   release_nodes (drivers/base/devres.c:503)
>   devres_release_all (drivers/base/devres.c:536)
>   device_del (drivers/base/core.c:3829)
>   device_unregister (drivers/base/core.c:3730 drivers/base/core.c:3854)
>   power_supply_unregister (power_supply_core.c:1608)
>   devm_power_supply_release (power_supply_core.c:1515)
>   release_nodes (drivers/base/devres.c:506)
>   devres_release_group (drivers/base/devres.c:669)
>   i2c_device_remove (drivers/i2c/i2c-core-base.c:629)
>   device_remove (drivers/base/dd.c:570)
>   device_release_driver_internal (drivers/base/dd.c:1274 drivers/base/dd.=
c:1295)
>   device_driver_detach (drivers/base/dd.c:1332)
>   unbind_store (drivers/base/bus.c:247)
>   ...
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Fixes: 27a2195efa8d ("power: supply: core: auto-exposure of simple-batter=
y data")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/power/supply/power_supply_core.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 0b69fb7bafd8..2863b0a4dfc7 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -573,6 +573,7 @@ EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
>  int power_supply_get_battery_info(struct power_supply *psy,
>  				  struct power_supply_battery_info **info_out)
>  {
> +	struct device *allocdev =3D psy->dev.parent ?: &psy->dev;
>  	struct power_supply_resistance_temp_table *resist_table;
>  	struct power_supply_battery_info *info;
>  	struct device_node *battery_np =3D NULL;
> @@ -623,7 +624,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		goto out_put_node;
>  	}
> =20
> -	info =3D devm_kzalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
> +	info =3D devm_kzalloc(allocdev, sizeof(*info), GFP_KERNEL);
>  	if (!info) {
>  		err =3D -ENOMEM;
>  		goto out_put_node;
> @@ -776,7 +777,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		info->ocv_table_size[index] =3D tab_len;
> =20
>  		table =3D info->ocv_table[index] =3D
> -			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
> +			devm_kcalloc(allocdev, tab_len, sizeof(*table), GFP_KERNEL);
>  		if (!info->ocv_table[index]) {
>  			power_supply_put_battery_info(psy, info);
>  			err =3D -ENOMEM;
> @@ -796,7 +797,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  		goto out_ret_pointer;
> =20
>  	info->resist_table_size =3D len / (2 * sizeof(__be32));
> -	resist_table =3D info->resist_table =3D devm_kcalloc(&psy->dev,
> +	resist_table =3D info->resist_table =3D devm_kcalloc(allocdev,
>  							 info->resist_table_size,
>  							 sizeof(*resist_table),
>  							 GFP_KERNEL);
> @@ -825,17 +826,18 @@ EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
>  void power_supply_put_battery_info(struct power_supply *psy,
>  				   struct power_supply_battery_info *info)
>  {
> +	struct device *allocdev =3D psy->dev.parent ?: &psy->dev;
>  	int i;
> =20
>  	for (i =3D 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
>  		if (info->ocv_table[i])
> -			devm_kfree(&psy->dev, info->ocv_table[i]);
> +			devm_kfree(allocdev, info->ocv_table[i]);
>  	}
> =20
>  	if (info->resist_table)
> -		devm_kfree(&psy->dev, info->resist_table);
> +		devm_kfree(allocdev, info->resist_table);
> =20
> -	devm_kfree(&psy->dev, info);
> +	devm_kfree(allocdev, info);
>  }
>  EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
> =20
>=20
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20230918-power-uaf-6f7f1b585ec5
>=20
> Best regards,
> --=20
> Vincent Whitchurch <vincent.whitchurch@axis.com>
>=20

--kaghlg4vvcp2xwwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUIZvcACgkQ2O7X88g7
+prThQ//T85vagGhjO10u1TdO4dZDH3WweRz1YmdNdtujCddadUH72t4RyJhVFGw
RWKgoL7gQD18uC+tbmPpCDFuKWBq6sDdUXHbde7YM8vgC1ttuTeJhyjQ/pZKJErp
eI50oU2Wkr17qefBt841vbHyyN2DnSyswipmU/EsGHTvi/AicWzvXXvNK0S5F3w7
G18HzCacqnMjJomccKx4tKOsVFpkQEEga8/aZ9ks3v2qJqZsDb1Mw2p9RrNlrfuj
coVmPzCmDeColzquLhGExMYx1q6VRb3lfMF28ROiTpjBobUqf2nos4DAItvphiRB
7BdLvW2kxBp/PaK65ttBFnXwnF1Pf33LfdzK0jZm59JIo2UP/GOR6Qyjc2Wl3EKN
mZHaw7DUUtubrcx9zhEYR/eMbeRU2jCQb9mswVo+2qVjUQeeEQ9WFVTAafaCT6n4
7EFhdLebccb5c+7szzMbTrt7THpt0cWLwRstt0OMaDKOsf7CGqILx45Zx1+f2J8A
GCH6TjL5h8S7A7GZmmEJox+oOGX9A/mEHqUXFYT2MHtxAHIINuIUmpc3TcZNuTjI
7GzdZ3M98ttdifSqHyfF62ttIEuDxNuseOPHAj4EbFwiNB9OP/vxXdmH/M9CxH+X
5AFnLmac7tWRO/H+NHJ+MBoqmktgdLlpPeSn29/I9gAlyy9gnPM=
=wDXC
-----END PGP SIGNATURE-----

--kaghlg4vvcp2xwwj--
