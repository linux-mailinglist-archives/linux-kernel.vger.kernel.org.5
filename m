Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7682797DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbjIGVPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjIGVPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:15:17 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8417E92
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:15:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeMLD-0003S0-M5; Thu, 07 Sep 2023 23:15:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeMLB-004jmk-Oc; Thu, 07 Sep 2023 23:15:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qeMLA-00HHgS-VR; Thu, 07 Sep 2023 23:15:04 +0200
Date:   Thu, 7 Sep 2023 23:15:04 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v9 1/6] pwm: dwc: split pci out of core driver
Message-ID: <20230907211504.xfummvycltdj6bii@pengutronix.de>
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
 <20230907161242.67190-2-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4mbcshatni2opzdo"
Content-Disposition: inline
In-Reply-To: <20230907161242.67190-2-ben.dooks@codethink.co.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4mbcshatni2opzdo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 07, 2023 at 05:12:37PM +0100, Ben Dooks wrote:
> Moving towards adding non-pci support for the driver, move the pci
> parts out of the core into their own module. This is partly due to
> the module_driver() code only being allowed once in a module and also
> to avoid a number of #ifdef if we build a single file in a system
> without pci support.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Great you continue here even though your commercial interest already
ended!

This series conflicts with my lifetime series[1], but I guess we can
sort that one when at least one of these two series is applied.

[1] https://lore.kernel.org/linux-pwm/20230808171931.944154-1-u.kleine-koen=
ig@pengutronix.de/

> [...]
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index 3bbb26c862c3..bd9cadb497d7 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * DesignWare PWM Controller driver
> + * DesignWare PWM Controller driver (PCI part)
>   *
>   * Copyright (C) 2018-2020 Intel Corporation
>   *
> @@ -13,6 +13,8 @@
>   *   periods are one or more input clock periods long.
>   */
> =20
> +#define DEFAULT_MOUDLE_NAMESPACE dwc_pwm
> +

There is no exported symbol in this driver, so this #define is unused.

>  #include <linux/bitops.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>

Otherwise looks fine:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

(with or without dropping DEFAULT_MOUDLE_NAMESPACE from pwm-dwc.c)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4mbcshatni2opzdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT6PVgACgkQj4D7WH0S
/k5PYAf/YeQFqnvpoY7iWcuk9PXBxXqVrErEwC8OiNTb50bRykRsJZsT77jxmbyT
vzEQhNp/uqaX738pyzLrwrtoyj9UHxeyR0knrTcz8oNje5ilZQvkdVep5j17fuhP
UbkPIdqmQOVeu4YFARhbJwdgvy80Zajs/kUDP268mSBFLYZwZLHb3QOtr6JIaaLE
ccPveTHybu4sCma7dtleSjapPgOaKXKIfiy4tKqk9Joeps6O1VCzB/3NDgs1agHg
wDeVYGMGtTF+QbomZCfswxSYWcqIgOo3dEFzoRsYInA3l6VrToJMm9G7MmWoKTAj
3c82wRNAwt3YaUjVJwj3Pef5jFdIeQ==
=bYu6
-----END PGP SIGNATURE-----

--4mbcshatni2opzdo--
