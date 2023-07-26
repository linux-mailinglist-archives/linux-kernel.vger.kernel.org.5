Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74600762B17
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjGZGFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGZGFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:05:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB2170D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:05:15 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qOXdY-0006Dv-Gs; Wed, 26 Jul 2023 08:04:40 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B74FB1FAD7A;
        Wed, 26 Jul 2023 06:04:37 +0000 (UTC)
Date:   Wed, 26 Jul 2023 08:04:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Johannes Zink <j.zink@pengutronix.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        kernel test robot <lkp@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, patchwork-jzi@pengutronix.de
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <20230726-dreamboat-cornhusk-1bd71d19d0d4-mkl@pengutronix.de>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org>
 <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xnhwr73ip5umpg2f"
Content-Disposition: inline
In-Reply-To: <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xnhwr73ip5umpg2f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.07.2023 20:22:53, Richard Cochran wrote:
> On Tue, Jul 25, 2023 at 08:06:06PM -0700, Jakub Kicinski wrote:
>=20
> > any opinion on this one?
>=20
> Yeah, I saw it, but I can't get excited about drivers trying to
> correct delays.  I don't think this can be done automatically in a
> reliable way,

At least the datasheet of the IP core tells to read the MAC delay from
the IP core (1), add the PHY delay (2) and the clock domain crossing
delay (3) and write it to the time stamp correction register.

(1) added in this patch
(2) future work
(3) already in the driver,
    though corrected manually when reading the timestamp

At least in our measurements the peer delay is better with this patch
(measured with ptp4linux) and the end-to-end delay (comparison of 2 PPS
signals on a scope) is also better.

> and so I expect that the few end users who are really
> getting into the microseconds and nanoseconds will calibrate their
> systems end to end, maybe even patching out this driver nonsense in
> their kernels.

What issues make you think this change/approach is counterproductive?

> Having said that, I won't stand in the way of such driver stuff.
> After all, who cares about a few microseconds time error one way or
> the other?

There are several companies that use or plan to use PTP in their
products and are striving to achieve sub-microsecond synchronization.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xnhwr73ip5umpg2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTAt3IACgkQvlAcSiqK
BOh0DAgAqG6sHE3eeulbdXpyxVkjVIcKYjN/Hdv69xC9upUFvYFR+OQx4UoUbqCj
cDnLoipaxlcGfUob+Qr9QYUKjVI9TVqY82sU6LJ2DsbRAXdE7v7Pp/cINSatJ0Vq
Sb7Srv7RG2Xh+4oLChZ7fm2BGfoTehVQh0W3VpVXhIeMmGWeNFankax+sPOwYPfK
/OIQ/OYKRW0EI2Hrhbb/wnGv8cUCUSj5ZxQsc2rNJptWwQE1Ps/ljCOCyeyP8Alu
OOjGHjN1pjzZKg5hnOeKTKmmN9r5e5mD0EuSIm5PCtAQnCu2FOkQh1C+uyjNLx6m
jibMx4NFgoCRMo76PJp1y4m6hzEtkw==
=4iaa
-----END PGP SIGNATURE-----

--xnhwr73ip5umpg2f--
