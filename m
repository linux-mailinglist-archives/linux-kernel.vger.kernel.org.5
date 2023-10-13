Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21197C8CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjJMSE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMSE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:04:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A983
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:04:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMWo-00083i-4x; Fri, 13 Oct 2023 20:04:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMWn-001Rlc-Hm; Fri, 13 Oct 2023 20:04:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMWn-00FjD1-8T; Fri, 13 Oct 2023 20:04:49 +0200
Date:   Fri, 13 Oct 2023 20:04:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <20231013180449.mcdmklbsz2rlymzz@pengutronix.de>
References: <cover.1697193646.git.sean@mess.org>
 <9c0f1616fca5b218336b9321bfefe7abb7e1749f.1697193646.git.sean@mess.org>
 <ZSkvTKr42sUZImiM@orome.fritz.box>
 <ZSlbFukZKGNpR5PM@gofer.mess.org>
 <ZSljioc2OfPfxVeB@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vcxtukqygxnpby24"
Content-Disposition: inline
In-Reply-To: <ZSljioc2OfPfxVeB@orome.fritz.box>
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


--vcxtukqygxnpby24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 13, 2023 at 05:34:34PM +0200, Thierry Reding wrote:
> On Fri, Oct 13, 2023 at 03:58:30PM +0100, Sean Young wrote:
> > On Fri, Oct 13, 2023 at 01:51:40PM +0200, Thierry Reding wrote:
> > > On Fri, Oct 13, 2023 at 11:46:14AM +0100, Sean Young wrote:
> > > [...]
> > > > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > > > index d2f9f690a9c1..93f166ab03c1 100644
> > > > --- a/include/linux/pwm.h
> > > > +++ b/include/linux/pwm.h
> > > > @@ -267,6 +267,7 @@ struct pwm_capture {
> > > >   * @get_state: get the current PWM state. This function is only
> > > >   *	       called once per PWM device when the PWM chip is
> > > >   *	       registered.
> > > > + * @atomic: can the driver execute pwm_apply_state in atomic conte=
xt
> > > >   * @owner: helps prevent removal of modules exporting active PWMs
> > > >   */
> > > >  struct pwm_ops {
> > > > @@ -278,6 +279,7 @@ struct pwm_ops {
> > > >  		     const struct pwm_state *state);
> > > >  	int (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
> > > >  			 struct pwm_state *state);
> > > > +	bool atomic;
> > > >  	struct module *owner;
> > > >  };
> > >=20
> > > As I mentioned earlier, this really belongs in struct pwm_chip rather
> > > than struct pwm_ops. I know that Uwe said this is unlikely to happen,
> > > and that may be true, but at the same time it's not like I'm asking
> > > much. Whether you put this in struct pwm_ops or struct pwm_chip is
> > > about the same amount of code, and putting it into pwm_chip is much
> > > more flexible, so it's really a no-brainer.
> >=20
> > Happy to change this of course. I changed it and then changed it back a=
fter
> > Uwe's comment, I'll fix this in the next version.
> >=20
> > One tiny advantage is that pwm_ops is static const while pwm_chip is
> > allocated per-pwm, so will need instructions for setting the value. Hav=
ing
> > said that, the difference is tiny, it's a single bool.
>=20
> Yeah, it's typically a single assignment, so from a code point of view
> it should be pretty much the same. I suppose from an instruction level
> point of view, yes, this might add a teeny-tiny bit of overhead.
>=20
> On the other hand it lets us do interesting things like initialize
> chip->atomic =3D !regmap_might_sleep() for those drivers that use regmap
> and then not worry about it any longer.
>=20
> Given that, I'm also wondering if we should try to keep the terminology
> a bit more consistent. "Atomic" is somewhat overloaded because ->apply()
> and ->get_state() are part of the "atomic" PWM API (in the sense that
> applying changes are done as a single, atomic operation, rather than in
> the sense of "non-sleeping" operation).
>=20
> So pwm_apply_state_atomic() is then doubly atomic, which is a bit weird.
> On the other hand it's a bit tedious to convert all existing users to
> pwm_apply_state_might_sleep().
>=20
> Perhaps as a compromise we can add pwm_apply_state_might_sleep() and
> make pwm_apply_state() a (deprecated) alias for that, so that existing
> drivers can be converted one by one.

To throw in my green for our bike shed: I'd pick

	pwm_apply_state_cansleep()

to match what gpio does (with gpiod_set_value_cansleep()). (Though I
have to admit that semantically Thierry's might_sleep is nicer as it
matches might_sleep().)

If we don't want to have an explicit indicator for the atomic/fast
variant (again similar to the gpio framework), maybe we can drop
"_state" which I think is somehow redundant and go for:

	pwm_apply (fast)
	pwm_apply_cansleep (sleeping)
	pwm_apply_state (compat alias for pwm_apply_cansleep())

(maybe replace cansleep with might_sleep). Similar for pwm_get_state()
we could use the opportunity and make

	pwm_get()

actually call ->get_state() and introduce

	pwm_get_lastapplied()

with the semantic of todays pwm_get_state(). Do we need a
pwm_get_cansleep/might_sleep()?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vcxtukqygxnpby24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUphsAACgkQj4D7WH0S
/k6Exgf/SslgJkq9wxqIrotIrMj9NqpF1D4hMBxPW0FePgl21tJ23I4t2YyHT2MW
x5S8hPckkkhVD+rKMbdTLO2J5ixU/ems11N+Cz5ScrA6JM9lX1UvXcm8VEppCbuf
upnqeEPb+lzyBgtD1/dBz72xJOQXkpCtfOTHjQatE4Uo05tf8ntYLmByvHmMnoIb
MkfKcDXQwmLJheS3pqG0RpBTtdWXhm+6BqCHR+fwHeHhpsUoFYzQCxVmWh+FX7LC
P1Yup1ajVGxDIJtM/+Q1HBAUw+OYq1YgQQnPy7zAljwh0mRA+r7t/6heFdZP1+9f
EdMtfXZAsOjYFAYqHoHd5FUBTynyfA==
=t7Yp
-----END PGP SIGNATURE-----

--vcxtukqygxnpby24--
