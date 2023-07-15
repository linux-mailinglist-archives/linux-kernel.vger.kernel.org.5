Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56324754BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 21:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjGOT2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOT2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:28:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A12690
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 12:28:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKkwY-0001t8-C1; Sat, 15 Jul 2023 21:28:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKkwV-00EdcS-BW; Sat, 15 Jul 2023 21:28:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKkwU-0058Ql-CI; Sat, 15 Jul 2023 21:28:34 +0200
Date:   Sat, 15 Jul 2023 21:28:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.dooks@codethink.co.uk,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v8 1/5] pwm: dwc: split pci out of core driver
Message-ID: <20230715192832.hczmcchn4svzilnd@pengutronix.de>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
 <20230614171457.69191-2-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kaoi7uz2snnuqkvk"
Content-Disposition: inline
In-Reply-To: <20230614171457.69191-2-ben.dooks@sifive.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kaoi7uz2snnuqkvk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 06:14:53PM +0100, Ben Dooks wrote:
> Moving towards adding non-pci support for the driver, move the pci
> parts out of the core into their own module. This is partly due to
> the module_driver() code only being allowed once in a module and also
> to avoid a number of #ifdef if we build a single file in a system
> without pci support.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v8:
>  - add module namespace
>  - remove compile-test for pci case, doesn't make sense
>  - fix makefile, missed config symbol changes
> v7:
>  - re-order kconfig to make dwc core be selected by PCI driver
> v6:
>  - put DWC_PERIOD_NS back to avoid bisect issues
> v4:
>  - removed DWC_PERIOD_NS as not needed
> ---
>  drivers/pwm/Kconfig        |  14 ++-
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-dwc-core.c | 176 +++++++++++++++++++++++++++++++++
>  drivers/pwm/pwm-dwc.c      | 197 +------------------------------------
>  drivers/pwm/pwm-dwc.h      |  60 +++++++++++
>  5 files changed, 253 insertions(+), 195 deletions(-)
>  create mode 100644 drivers/pwm/pwm-dwc-core.c
>  create mode 100644 drivers/pwm/pwm-dwc.h
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8df861b1f4a3..7c54cdcb97a0 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -186,9 +186,19 @@ config PWM_CROS_EC
>  	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
>  	  Controller.
> =20
> +config PWM_DWC_CORE
> +	tristate
> +	depends on HAS_IOMEM
> +	help
> +	  PWM driver for Synopsys DWC PWM Controller.
> +
> +	  To compile this driver as a module, build the dependecies as
> +	  modules, this will be called pwm-dwc-core.
> +
>  config PWM_DWC
> -	tristate "DesignWare PWM Controller"
> -	depends on PCI
> +	tristate "DesignWare PWM Controller (PCI bus)"
> +	depends on HAS_IOMEM && PCI
> +	select PWM_DWC_CORE
>  	help
>  	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
> =20
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 19899b912e00..de3ed77e8d7c 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLK)		+=3D pwm-clk.o
>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
> +obj-$(CONFIG_PWM_DWC_CORE)	+=3D pwm-dwc-core.o
>  obj-$(CONFIG_PWM_DWC)		+=3D pwm-dwc.o

Would it make sense to call this pwm-dwc-pci.o? And the symbol
CONFIG_PWM_DWC_PCI? (The latter would break make oldconfig. Hmm, I'm
unsure myself.)

I didn't check all the details, but assuming that this is a split
without further changes it looks ok to me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kaoi7uz2snnuqkvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSy818ACgkQj4D7WH0S
/k5M9Qf9FU4HEfgzUrmnQmRqs/AwUWg3x41pPEByc0bFrVrYg6c/SI2vkvShqprW
aZs8J1HK80eJiOOHpSE9GCFyR9yofrH8agutPRvh/cGJ6oQz6DPD774ChLP70HaL
/CHd/QBoDWaBM/3MK7flgHT+0ahecNJzaz7xNEnWuszyEkT0LojynAXmtFnUl/g2
ZBK5EjvV2nET+obLOywGlXclvtGHhruWZLrNoyrF1RtndBO7mbJRC5tBe7B6POXT
HY8VzHEaZ2+ya6jGZpVoi/rPKcT4vsWqn0gSCNGPSOGE+Uc3YGnzU20IvFOfD/cg
7+uyZYfYU5yKx7FI01KB00nc5z2okA==
=okW2
-----END PGP SIGNATURE-----

--kaoi7uz2snnuqkvk--
