Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05A87B7C3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbjJDJgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbjJDJgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:36:09 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBABB4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:36:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnyIR-0008EB-Mz; Wed, 04 Oct 2023 11:35:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnyIR-00AztC-AH; Wed, 04 Oct 2023 11:35:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnyIR-008tcd-0w; Wed, 04 Oct 2023 11:35:59 +0200
Date:   Wed, 4 Oct 2023 11:35:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
Message-ID: <20231004093558.bt7gf3m6erxxpaie@pengutronix.de>
References: <cover.1696156485.git.sean@mess.org>
 <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
 <5982681d-4fb5-0271-fdc5-712d6c8512e3@gmail.com>
 <ZRp9RE2jOZdL0+1/@gofer.mess.org>
 <7075cfd7-847e-8d28-72be-93761b36b0e0@gmail.com>
 <ZR0Xue8Mu8VZIxm5@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pe6ujpvp227ivopk"
Content-Disposition: inline
In-Reply-To: <ZR0Xue8Mu8VZIxm5@gofer.mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pe6ujpvp227ivopk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 04, 2023 at 08:43:53AM +0100, Sean Young wrote:
> On Mon, Oct 02, 2023 at 12:52:00PM +0300, Ivaylo Dimitrov wrote:
> > On 2.10.23 =D0=B3. 11:20 =D1=87., Sean Young wrote:
> > > Requires a copy of pwm_state in pwm_ir, not a huge difference (copy o=
f 28
> > > bytes vs keeping it around).
> >=20
> > see my previous comment re struct var. Also, look at the overhead:
> > https://elixir.bootlin.com/linux/v6.6-rc3/source/include/linux/pwm.h#L3=
49 -
> > you call pwm_get_state() for every edge.
>=20
> That's the 28 bytes copy I was talking about.

Note that pwm_get_state() also has (IMHO) confusing semantics. It gives
you (most of the time) the state that was last pwm_state_apply()d and
not the state the hardware is currently in. In my book keeping the
pwm_state around is the nicer approach that often is also simpler ...

> However keeping a pointer in struct pwm_ir is a good compromise and makes
> the rest of the code cleaner.

=2E.. which seems to apply here, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pe6ujpvp227ivopk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUdMf4ACgkQj4D7WH0S
/k4a8ggAg6OI8IGWfsLy664bxwFXr17DZ7mff8aWmCNyTuzenyyn1ztaclxH9LDA
90+B2fbt/XxWJzt5pX+OU6wcGDMMmsVQdv87X4ACZBkhQ0k89TJ40SbVNFXoDLUa
BTjQsYPqOxYUIS7AsGh2NRW1gIwL0ITcVdeaw/jZSc5gtYM/hc8HYzvPsL7V8Rom
IGRNU0saEMLKiIcXObvQMAoLG4S6YPE0GKiOQZee2BQiEtF0uvfhHRSDcaEybMIg
uyWqbJqS2i0dW6xsG+sp9ySpxPd9osh5LYhwxa9Xr/a0JPx+fjzTBt8RAefz1qWA
KyU5n3RpaHKDe3p7eXq8U9HhzEm66A==
=/8+M
-----END PGP SIGNATURE-----

--pe6ujpvp227ivopk--
