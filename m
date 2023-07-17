Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D1D755D71
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGQHuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGQHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:49:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE00E4E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:49:51 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLIzA-0006dj-I5; Mon, 17 Jul 2023 09:49:36 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7CB481F310E;
        Mon, 17 Jul 2023 07:49:30 +0000 (UTC)
Date:   Mon, 17 Jul 2023 09:49:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michal Sojka <michal.sojka@cvut.cz>
Cc:     Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Dae R. Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: can: isotp: epoll breaks isotp_sendmsg
Message-ID: <20230717-disbelief-catalyst-bcff471e0433-mkl@pengutronix.de>
References: <11328958-453f-447f-9af8-3b5824dfb041@munic.io>
 <87cz1czihl.fsf@steelpick.2x.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mfssbwpjvgohqem3"
Content-Disposition: inline
In-Reply-To: <87cz1czihl.fsf@steelpick.2x.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mfssbwpjvgohqem3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2023 00:35:18, Michal Sojka wrote:
> Hi Maxime,
>=20
> On Fri, Jun 30 2023, Maxime Jayat wrote:
> > Hi,
> >
> > There is something not clear happening with the non-blocking behavior
> > of ISO-TP sockets in the TX path, but more importantly, using epoll now
> > completely breaks isotp_sendmsg.
> > I believe it is related to
> > 79e19fa79c ("can: isotp: isotp_ops: fix poll() to not report false=20
> > EPOLLOUT events"),
> > but actually is probably deeper than that.
> >
> > I don't completely understand what is exactly going on, so I am sharing
> > the problem I face:
> >
> > With an ISO-TP socket in non-blocking mode, using epoll seems to make
> > isotp_sendmsg always return -EAGAIN.
>=20
> That's definitely not expected behavior. I tested the patch only with
> poll, hoping that epoll would behave the same.
>=20
> [...]
>=20
> >
> > By reverting 79e19fa79c, I get better results but still incorrect:
>=20
> [...]
>=20
> > It is then possible to write on the socket but the write is blocking,
> > which is not the expected behavior for a non-blocking socket.
>=20
> Yes, incorrect behavior was why we made the commit in question, however
> we saw write() returning -EAGAIN when it shouldn't.
>=20
> > I don't know how to solve the problem. To me, using wq_has_sleeper seem=
s=20
> > weird.
>=20
> Agreed. I've never tried to understand how synchronization works here.
> Hopefully, Oliver knows more.
>=20
> > The implementation of isotp_poll feels weird too (calling both=20
> > datagram_poll and
> > poll_wait?). But I am not sure what would be the correct
> > implementation.
>=20
> I understand it as follows (which might be wrong - someone, please
> correct me), isotp_poll() should register the file with all waitqueues
> it can wait on. so->wait is one and sock->sq.wait (used by
> datagram_poll) is another. The former is definitely used for TX, the
> latter is probably used because skb_recv_datagram() is called for RX.
> But so->wait is also used for RX and there might proabbly be be some
> inconsistency between those.
>=20
> > My actual use-case is in Async Rust using tokio.
>=20
> Our initial motivation was also Rust and tokio however than I did
> testing only with simple C programs. I'm definitely interested in having
> this working.
>=20
> I'll try to look at this in more detail during the weekend. It's too
> late for me today.

Any progress on this issue?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mfssbwpjvgohqem3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS08oYACgkQvlAcSiqK
BOhHswf/SZj4m2DVNOkl8OLWL+ZJXTBoXd/S2pg2MLr7/+pO98wd8wbmGN5Kn6T9
cToBbnCaa6TEHzCROw0uQDM8BwoWxwPlcfaKpEFKdze1grV+lMYcSVI1nlaM19xR
es+jWh45mQnxhPjjDDNHowucfA7z+ivXYo46yf3LJsYVSfznf+/LIwlvKU4PMz0d
Vzwxar8/aStqGF1+i3vLNDnP99JwG2U3EqmjLGer80tP+n0qetxbuHkdShq05GpJ
4e5KS8/yXxvXgEJM1LNlhNh4W5oig+qivhE1pPIDAOt6fv4iptWjF3FEEMHsHdzC
x6fxKMIscbIL+6KmBwSt+7kz9iMoTA==
=uF3O
-----END PGP SIGNATURE-----

--mfssbwpjvgohqem3--
