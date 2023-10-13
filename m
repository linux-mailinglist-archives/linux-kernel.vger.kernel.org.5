Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346457C8C99
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMRv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMRvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:51:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA30883
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:51:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMK5-0006CR-OY; Fri, 13 Oct 2023 19:51:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMK5-001RiD-AW; Fri, 13 Oct 2023 19:51:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMK5-00Fiwn-16; Fri, 13 Oct 2023 19:51:41 +0200
Date:   Fri, 13 Oct 2023 19:51:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Message-ID: <20231013175140.dzlz4grrgngoyxbc@pengutronix.de>
References: <cover.1697193646.git.sean@mess.org>
 <6ce73b2688f059e7169935699044104cf37b2425.1697193646.git.sean@mess.org>
 <84429d39-aa54-462d-85cd-c5d06a614a0e@gmx.net>
 <5203415.ElGaqSPkdT@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ssu5t4hquxq747is"
Content-Disposition: inline
In-Reply-To: <5203415.ElGaqSPkdT@steina-w>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ssu5t4hquxq747is
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 13, 2023 at 01:13:50PM +0200, Alexander Stein wrote:
> Am Freitag, 13. Oktober 2023, 13:04:48 CEST schrieb Stefan Wahren:
> > Am 13.10.23 um 12:46 schrieb Sean Young:
> > > clk_get_rate() may do a mutex lock. Since the clock rate cannot chang=
e on
> > > an rpi, simply fetch it once.
> >=20
> > does it mean you checked all possible SoCs (BCM2835, BCM2836, BCM2837,
> > BCM2711, BCM2712) for this change?
> >=20
> > Is it impossible that the real clock can never be influenced by turbo
> > mode like SPI?
>=20
> Assuming the clock can change, which I would, then a clock notifier seems=
=20
> appropriate. See [1] for an example.

I'm not a fan. If the clock changes, the output also changes. With a
clock notifier you can soften the issue and reconfigure to something
similar as the original wave form, but a glitch happens for sure.

I already toyed with the thought to add clk_rate_exclusive_get() to all
PWM drivers, but didn't come around it yet.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ssu5t4hquxq747is
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUpg6wACgkQj4D7WH0S
/k6zXAf8CLxtrbWX3bu/WNzhyWl92SzyhIaU0UrVF1cyUmSvSccu/9afnKYtgPfZ
2lsWg4a1AVndcN2OoIZ8Fqf6eKdMNqSnxc1cyOH3rL7o+6wYPACNRQ907zK44Ah9
FYPytiBMKZq+xXTBU1Qbm6Vrn2dQxXBv0/mOIz6pLI2mcdN66Ad1a2Bf2avkddd5
NoU5DJhuRI8ywHb34lexulqMdCQqjNZhcj46TFks3bk3FVT76aBRXhwOesaJnmy8
hSg84cJn8TiQzgsOkP5Px580mOQQ0eYFGB8DZm7tlljXRhEgiuRwcrOXeFfaITI4
lI87RD2C73qZIV7fLaOKCHWr3GQraw==
=x/eO
-----END PGP SIGNATURE-----

--ssu5t4hquxq747is--
