Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59C75D122
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGUSNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGUSND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:13:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F905E68
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:13:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMucY-0006yR-Rj; Fri, 21 Jul 2023 20:12:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMucW-0017uJ-PC; Fri, 21 Jul 2023 20:12:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMucW-006hjB-0e; Fri, 21 Jul 2023 20:12:52 +0200
Date:   Fri, 21 Jul 2023 20:12:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/8] iio: core: Add opaque_struct_size() helper and
 use it
Message-ID: <20230721181248.s7dnkcdhn3hb6ihh@pengutronix.de>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
 <20230721170022.3461-2-andriy.shevchenko@linux.intel.com>
 <ZLq+2+9q6To3uAkf@smile.fi.intel.com>
 <ZLq/eDDSblr2vlSA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vqci25cadv3smgnc"
Content-Disposition: inline
In-Reply-To: <ZLq/eDDSblr2vlSA@smile.fi.intel.com>
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


--vqci25cadv3smgnc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Fri, Jul 21, 2023 at 08:25:12PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 08:22:35PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 21, 2023 at 08:00:15PM +0300, Andy Shevchenko wrote:
> > > Introduce opaque_struct_size() helper, which may be moved
> > > to overflow.h in the future, and use it in the IIO core.
>=20
> ...
>=20
> > > +#define opaque_struct_size(p, a, s)	({		\
> > > +	size_t _psize =3D sizeof(*(p));			\
> > > +	size_t _asize =3D ALIGN(_psize, (a));		\
> > > +	size_t _ssize =3D s;				\
> > > +	_ssize ? size_add(_asize, _ssize) : _psize;	\
> > > +})
> > > +
> > > +#define opaque_struct_data(p, a)			\
> > > +	((void *)(p) + ALIGN(sizeof(*(p)), (a)))
> >=20
> > Hmm... This can potentially evaluate p twice.

I don't think sizeof evaluates its parameter? It should only defer its
type and then calculate the respective size.

> > Perhaps this variant is better:
> >=20
> > #define opaque_struct_data(p, a)	ALIGN((p) + 1, (a)))

Still I like this better.

> > Besides, I don't think we should worry about @s evaluation in the main =
macro
> > which may be simplified to
> >=20
> > #define opaque_struct_size(p, a, s)					\
> > 	((s) ? size_add(ALIGN(sizeof(*(p)), (a)), (s)) : sizeof(*(p)))
> >=20
> > Thoughts?
>=20
> Also we may leave the struct always be aligned which makes the above even
> simpler (but might waste bytes if @s =3D 0).

Depending on the value of a, the bytes "wasted" here might not be saved
anyhow because the memory allocator will round up the allocation size to
a multiple of some chunk size anyhow.

> #define opaque_struct_size(p, a, s)	size_add(ALIGN(sizeof(*(p)), (a)), (s=
))
>=20
> (with the respective documentation update).

That would be my favourite.

Possible users of this helper include:

	__spi_alloc_controller() in drivers/spi/spi.c
	alloc_netdev_mqs in net/core/dev.c

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vqci25cadv3smgnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS6yp8ACgkQj4D7WH0S
/k4b/Af/bOZKh7RLxGz97/75WJitObqG1QfkZK6kewg7rQVXSgBIIOlvS2Ed/lhl
UU6dNG9OpTomId/xyAh0gdo2UGwjAn95WH1n2ysrBOt0K5aWVrbnmNE4nkrNcd0K
knPG4/5J4bBjf5jYDgeiUmJhxRUkqj8BG1LyyoT6JKgssMG1NI8/bEL3zwAh6k2E
+gyNYlbcsAnE8HJZutMlVyJ3EmL51cVPuVGvyqGXJ7SDyoHVmkwS5N0gCvMw2uuG
TM/LVZ92GVI3QeSUnYvxlJZwpNcSvzx0FBDVI9O0rk1wSdxEHNreN0CXI2vRMEJ/
uSmSMNSAVIXklWQ1+qGCuudasvCHqw==
=8CCO
-----END PGP SIGNATURE-----

--vqci25cadv3smgnc--
