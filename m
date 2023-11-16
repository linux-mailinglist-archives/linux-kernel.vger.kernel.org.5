Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0977EDFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjKPLfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjKPLfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:35:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE84C2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:35:09 -0800 (PST)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73C026607345;
        Thu, 16 Nov 2023 11:35:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700134507;
        bh=ZkCMN22Pfne+/0TeFLcimZ/ud/HjRPqoFt++Epb08Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FF3mJEl/qKvpymt9cDt/LdA0zUcnFOodmmJL0CVtV08EfnEcczs7Iee58P6pSh/dZ
         18RXYdGnRzVmvsWhw6WPrWWhpBuYV4hj68UBrnAULz79wep+x5zaQaS2oQYimG21Mt
         3gR7Zu5YYt3zG7q837BpWHAc7tw31gp1L2Fu+NjumkarIDGz8Ugp5s4u1gpB5dyoFi
         XE8zalISeZdbBECxPBMaYOEdX/ooOwzUJibgGk5vQaUCCadTkD12Ff/IR9ymekbDLd
         dt/PKM9qAoymRcqy9zx1gbKQEO6/71zNtU8Nn4CVo7SEqEAomdmQjCpMev6xRnQ3/I
         BOU3lDHP8eAyA==
Received: by mercury (Postfix, from userid 1000)
        id 29CB51062B52; Thu, 16 Nov 2023 12:35:05 +0100 (CET)
Date:   Thu, 16 Nov 2023 12:35:05 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Adam Green <greena88@gmail.com>
Subject: Re: [PATCH] mfd: rk8xx: register devices again with
 PLATFORM_DEVID_NONE
Message-ID: <20231116113505.ay4kihy3u32smhbm@mercury.elektranox.org>
References: <20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v1-1-75fa43575ab7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ntqhzatzyhtpgybq"
Content-Disposition: inline
In-Reply-To: <20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v1-1-75fa43575ab7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ntqhzatzyhtpgybq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 16, 2023 at 09:53:05AM +0100, Neil Armstrong wrote:
> Since commit 210f418f8ace ("mfd: rk8xx: Add rk806 support"), devices are
> registered with "0" as id, causing devices to not have an automatic devic=
e id
> and prevents having multiple RK8xx PMICs on the same system.

They are not registered with "0" as ID - they are registered without
any ID at all, because their cells have PLATFORM_DEVID_NONE.

> This fixes a regression while booting the Odroid Go Ultra on v6.6.1:
> sysfs: cannot create duplicate filename '/bus/platform/devices/rk808-clko=
ut'

^ which you can see here. There is no ".0" suffix at the end of the
sysfs path.

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
> Lee, This is only a fix for the regression, as discussed with Sebastian a=
t [1],
> the driver would require some more cleanup to cleanly register all device=
s with
> PLATFORM_DEVID_AUTO. I plan to send this later on.
>=20
> [1] https://lore.kernel.org/all/20231115180050.5r5xukttz27vviyi@mercury.e=
lektranox.org/

NAK, this would break rk806. You can use PLATFORM_DEVID_AUTO instead,
since that has special handling in devm_mfd_add_devices and will
ignore the PLATFORM_DEVID_NONE specified by the cells.

Greetings,

-- Sebastian

> ---
>  drivers/mfd/rk8xx-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> index c47164a3ec1d..58d8dec7ac02 100644
> --- a/drivers/mfd/rk8xx-core.c
> +++ b/drivers/mfd/rk8xx-core.c
> @@ -684,7 +684,7 @@ int rk8xx_probe(struct device *dev, int variant, unsi=
gned int irq, struct regmap
>  					     pre_init_reg[i].addr);
>  	}
> =20
> -	ret =3D devm_mfd_add_devices(dev, 0, cells, nr_cells, NULL, 0,
> +	ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cells, nr_cells,=
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

--ntqhzatzyhtpgybq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmVV/mgACgkQ2O7X88g7
+poAbw//VYoTm6gyFJmEbA6/Aqp7qs7j8cR0hJsAGLZb5W/QVcH/xbO26CFDrk5G
Wkm7xstDUC6UqtBnDpvTo8kFOaCBMZPdb6Jn61uL0JivRa9LfMRG+qdUtLo7quru
6/VDl3N4DEwFu7BvYpUNoDeKsWRbqp9NiQUdzYlSYuR89Sp2u5Ok6u+NnEFKbUoF
7yXgttnpND7JlIZMQdYoKV1/vdreqt99nXPIm9X4VPHlPmiV1h46i5+SWD44ianO
DC4tKgoj+arlX9ZqWPUZblQhxlDXFuf2A8iTV3x/4JGS3wQolafDmjrXuu2YOZ92
kUhYMrVsyuDNTXisWiFLaWFvIlBfkSc1u6Li0+PDDAZj3IMo3lnxMJa0K61hCcqP
OfLN+jLtvbV4Yo2YmT7rd3PDqDBlrecmbzkAUkXuBLfCQmQtOlmRaXXb9QrYy7rf
p00Z8+l/y9xTMbvRLLGrzo6il7m8/tcg/A2m1RFX3ZwQ2PxFC2pZeSDbKRJoaNff
fPBkStKxZhpA9b9+CktIDAlM1KM8pXZUQ25j+q9SNzg6i1yCXPeM4yNdAscU4oYf
jP54RCDkVQda7kUlON7OYxvo3CeIfB0z+w6OyF93GXs5hhNpTnhLOCJjLftWVcpP
rxzobRSaHAHwsmriAbh/j/deKz5xMGEwwrFkHWEngf7E9HdDuUs=
=rQma
-----END PGP SIGNATURE-----

--ntqhzatzyhtpgybq--
