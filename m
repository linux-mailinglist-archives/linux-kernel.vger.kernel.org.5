Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02727D9A28
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbjJ0Nie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345931AbjJ0Nid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:38:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECCC9D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:38:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qwN2b-000444-ST; Fri, 27 Oct 2023 15:38:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qwN2Z-004eap-CE; Fri, 27 Oct 2023 15:38:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qwN2Z-007Lz1-2l; Fri, 27 Oct 2023 15:38:19 +0200
Date:   Fri, 27 Oct 2023 15:38:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Message-ID: <20231027133818.f5zpeqxfw7ghs7sk@pengutronix.de>
References: <cover.1698398004.git.sean@mess.org>
 <0b35ca65d6f4d53d3beb1411a64970ea5f969060.1698398004.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iiuhlc2f5sp65et"
Content-Disposition: inline
In-Reply-To: <0b35ca65d6f4d53d3beb1411a64970ea5f969060.1698398004.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2iiuhlc2f5sp65et
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Fri, Oct 27, 2023 at 10:20:46AM +0100, Sean Young wrote:
> +	pc->rate =3D clk_get_rate(pc->clk);
> +	if (!pc->rate) {
> +		dev_err(pc->dev, "failed to get clock rate\n");
> +		ret =3D -EINVAL;

Other error paths in this driver use dev_err_probe(). The most compact
way here would be:

	ret =3D dev_err_probe(pc->dev, -EINVAL, "....");

but maybe

	ret =3D -EINVAL;
	dev_err_probe(pc->dev, ret, "...");

is a bit easier to parse for a human?!

Otherwise looks reasonable.

Thanks,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2iiuhlc2f5sp65et
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU7vUoACgkQj4D7WH0S
/k47IAgApc4G3nyl4kSKMOLLW/jy5u3nlGR3Cbn/NFdCUikfU5kiiAfpFpgsLz8C
BMmJCw3XmK78YqMX+1v3Zg1MiCCkTfuLFWIFtZWe3BUunh2fVkKtzNuFpZBq7nrd
D7YHl08Ph2teuVbMYQbGEzpTzQFgHMTJmHZIGDj7VTSkv/TV2nmrX02kzSh6rYnJ
iAyqRTGH2HTeMDj4vpbqmki2rEJT+lIOR3bMAyoMiWVlcvv4nZdFKZOWPl8OAZ11
Ci+Uh66I/G+crBuxNBmpISvc0xTP3v0ab5nei1rcl5cNJZRRAk5TlPiUvooKhnTX
aNZkwf1ewQ17Khp1W4V4XTnI1+nv5Q==
=oHUW
-----END PGP SIGNATURE-----

--2iiuhlc2f5sp65et--
