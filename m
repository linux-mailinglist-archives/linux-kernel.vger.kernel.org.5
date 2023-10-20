Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D47D0F72
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377155AbjJTMMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376941AbjJTML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:11:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306CA9F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:11:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtoM1-0007gt-ST; Fri, 20 Oct 2023 14:11:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtoM0-0031Pm-WD; Fri, 20 Oct 2023 14:11:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtoM0-002VMF-Mo; Fri, 20 Oct 2023 14:11:48 +0200
Date:   Fri, 20 Oct 2023 14:11:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] backlight: pwm_bl: Avoid backlight flicker applying
 initial PWM state
Message-ID: <20231020121148.3g6t3v5uuyubifpb@pengutronix.de>
References: <20230608-backlight-pwm-avoid-flicker-v1-1-afd380d50174@pengutronix.de>
 <20231018210741.6t3yfj6qgmpwhhlo@pengutronix.de>
 <20231020112727.GF23755@aspen.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ujggu4vg72aghiu"
Content-Disposition: inline
In-Reply-To: <20231020112727.GF23755@aspen.lan>
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


--4ujggu4vg72aghiu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Daniel,

On Fri, Oct 20, 2023 at 12:27:27PM +0100, Daniel Thompson wrote:
> On Wed, Oct 18, 2023 at 11:07:41PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Philipp,
> >
> > On Thu, Jun 08, 2023 at 04:11:14PM +0200, Philipp Zabel wrote:
> > > The initial PWM state returned by pwm_init_state() has a duty cycle
> > > of 0 ns.
> >
> > This is only true for drivers without a .get_state() callback, isn't it?
>=20
> pwm_init_state() explicitly zeros the duty-cycle in order to avoid
> problems when the default args have a different period to the currently
> applied config:
> https://elixir.bootlin.com/linux/latest/source/include/linux/pwm.h#L174

Ah right, pwm_init_state() is strange in a different way than I
remembered :-) pwm_get_state() is only called to get .enabled set
appropriately.

Looking at the callers:

 - drivers/gpu/drm/solomon/ssd130x.c
   It does:
 	pwm_init_state(ssd130x->pwm, &pwmstate);
	pwm_set_relative_duty_cycle(&pwmstate, 50, 100);
	pwm_apply_state(ssd130x->pwm, &pwmstate);
	pwm_enable(ssd130x->pwm);

   A probably better result can be reached quicker using:
 	pwm_init_state(ssd130x->pwm, &pwmstate);
	pwm_set_relative_duty_cycle(&pwmstate, 50, 100);
	pwmstate.enabled =3D true;
	pwm_apply_state(ssd130x->pwm, &pwmstate);
 - drivers/hwmon/pwm-fan.c
   __set_pwm should probably explicitly set .enabled.
   All other calls to pwm_apply_state set .enabled explicitly.

 - drivers/input/misc/da7280.c
   explicitly sets .enabled after calling pwm_init_state()

 - drivers/input/misc/pwm-beeper.c
   explicitly sets .enabled after calling pwm_init_state()

 - drivers/input/misc/pwm-vibra.c
   explicitly sets .enabled after calling pwm_init_state()

 - drivers/leds/leds-pwm.c
   explictily sets .enabled before calling pwm_apply_state()

 - drivers/leds/rgb/leds-pwm-multicolor.c
   explictily sets .enabled before calling pwm_apply_state()

 - drivers/media/rc/ir-rx51.c
   explictily sets .enabled before calling pwm_apply_state()

 - drivers/media/rc/pwm-ir-tx.c
   explictily sets .enabled before calling pwm_apply_state()

 - drivers/regulator/pwm-regulator.c
   never sets .enabled, probably a bug

 - drivers/video/backlight/lm3630a_bl.c
   explictily sets .enabled before calling pwm_apply_state()

 - drivers/video/backlight/lp855x_bl.c
   explictily sets .enabled before calling pwm_apply_state()

 - drivers/video/backlight/pwm_bl.c
   This is the one we currently discuss. I think even with the patch
   applied it uses the .enabled value returned by pwm_init_state() but
   it shouldn't.

 - drivers/video/fbdev/ssd1307fb.c
   Similar to drivers/gpu/drm/solomon/ssd130x.c. Probably the one was
   copied to the other given that it seems to handle the same hardware.

So all consumers using pwm_init_state() either don't use the .enabled
value returned by pwm_init_state() or at least shouldn't do that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4ujggu4vg72aghiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUyboMACgkQj4D7WH0S
/k6z8QgAk0g406vvpJ815Hdz5BSVMclVmbygCKOIROSOKowNrW6WOgrFvaXeUqyi
qBw06fdMe3EB3Ak9xeZ0EwZ2TWFvol0KsTcHC/B0NPv3naRvXdcnhQylYtlxNFSN
Ra677iflQiqyYV/UcOf7bvDm0d6cj8W7PpatbZ+NJLh+qXepNDlZgl7cUgtVWw5u
N04OLkaAtWtfb3lWyT0fnOTTATCkm8x9qrqxHrSilR4+Xf43PAHSbi/427a9mNv6
vzIWS7HNi9xdirUsXfQbyP8pJhfhEbJjvwhAubqMlS0xPHujsYJcZ7dquVTmu6tb
Suaayp81cFoCFdHmtCsA6bTorRVi4Q==
=yuK5
-----END PGP SIGNATURE-----

--4ujggu4vg72aghiu--
