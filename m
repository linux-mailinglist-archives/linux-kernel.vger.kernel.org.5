Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C307E9D26
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjKMNai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMNag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:30:36 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610C4171A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:30:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1r2X14-00042D-9d; Mon, 13 Nov 2023 14:30:14 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1r2X12-008kZa-Ex; Mon, 13 Nov 2023 14:30:12 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 115B124B7DC;
        Mon, 13 Nov 2023 13:30:12 +0000 (UTC)
Date:   Mon, 13 Nov 2023 14:30:11 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 00/14] can: m_can: Optimizations for m_can/tcan part 2
Message-ID: <20231113-mastiff-confetti-955bda37a458-mkl@pengutronix.de>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <0c14d3d4372a29a9733c83af4c4254d5dfaf17c2.camel@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ltv4sn6fykivt4dn"
Content-Disposition: inline
In-Reply-To: <0c14d3d4372a29a9733c83af4c4254d5dfaf17c2.camel@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ltv4sn6fykivt4dn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.11.2023 14:25:37, Martin Hundeb=C3=B8ll wrote:
> On Fri, 2023-09-29 at 16:12 +0200, Markus Schneider-Pargmann wrote:
> > Hi Marc, Simon, Martin and everyone,
> >=20
> > v6 is a rebase on v6.6. As there was a conflicting change merged for
> > v6.6 which introduced irq polling, I had to modify the patches that
> > touch the hrtimer.
> >=20
> > @Simon: I removed a couple of your reviewed-by tags because of the
> > changes.
> >=20
> > @Martin: as the functionality changed, I did not apply your Tested-by
> > tag as I may have introduced new bugs with the changes.
> >=20
> > The series implements many small and bigger throughput improvements
> > and
> > adds rx/tx coalescing at the end.
> >=20
> > Based on v6.6-rc2. Also available at
> > https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v=
6.6?ref_type=3Dheads
>=20
> For the whole series:
> Tested-by: Martin Hundeb=C3=B8ll <martin@geanix.com>

On which hardware? On an mmio mapped m_can or the tcan4x5x?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ltv4sn6fykivt4dn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmVSJOAACgkQvlAcSiqK
BOgMLwf/fMwdMSII3RkS4eHnUFAhQ9qmXwNx+2h7M8cmFhx7wY+5N8whN6GJw8lu
aNDZ0cHXjKErd53GkXfLWwVojBAxuzfj4SYgW9oJGCpbJ4kudXK3XqZWQfqNQxY9
jdaLg0bPbXUY45VYZKHzTvUdyzFF5DW6ErY4Vc+AGqWp6g7h5ssjxcqAVPQsU9eF
Q+L/44D6auw9BmljR90mXVKPxx+TuTt1xCnDpqWPEtqvIcVUXrP6LBxhqFa6WxPH
x+Ue1xHfIMQa48LRqVmIypEeQVTfyToQHUpg2xmAl8F7YJiP4gW76VLD7FYXzo5k
Iwcgh3D3r/Hu6i+spguZGlV9Koeg0A==
=O2Cr
-----END PGP SIGNATURE-----

--ltv4sn6fykivt4dn--
