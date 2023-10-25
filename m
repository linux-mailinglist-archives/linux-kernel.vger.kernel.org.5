Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655527D726F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjJYRgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjJYRgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:36:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24F1182;
        Wed, 25 Oct 2023 10:36:10 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 70F1E6607349;
        Wed, 25 Oct 2023 18:36:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698255369;
        bh=R1j0yF7ON9HljamXpo4RStWWAUzHA+3I02cIzDZbN+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Js86oV2d5JuhzHjZBL0v0OkFlQkw+AifCEvxM/t9mTYki5BalgXOkp5gmI8wV83Xd
         8iWv5m+l4CNyIRFgNK8Nsb5i06jR/fuClZUAwKicSAnGcWEede9YyhanVMfva7PGOS
         lhU4lLIzi2tGr2CrX7qmUqI0XeMxPNN85z6BOF+GzV4S956EqmhkR1tWVWKZTsLabz
         gbFyGDN2swhB+M9lmdy5v7bQBrfaj8+MZrLBCWpOmPq3+24UAB8u97orvp0ZHfZaqg
         hYbxzEX8O995BF6niTasSFM2cSZxtlOI0NfH6X07aCrtz5sV6jgrr3ogLl8yubPtOB
         zWonJwi33UgSg==
Received: by mercury (Postfix, from userid 1000)
        id 873DD106057B; Wed, 25 Oct 2023 19:36:06 +0200 (CEST)
Date:   Wed, 25 Oct 2023 19:36:06 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, kernel@collabora.com
Subject: Re: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Message-ID: <20231025173606.i2e74tfpbo6as5u4@mercury.elektranox.org>
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com>
 <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
 <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3xdyay7hajk67vjt"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3xdyay7hajk67vjt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 24, 2023 at 12:53:03PM -1000, Linus Torvalds wrote:
> On Tue, 24 Oct 2023 at 09:32, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I would really prefer to just make our regular DIV_ROUND_UP() DTRT.  Bu=
t:
> >
> >  - people do use it with complex first arguments (ie function calls
> > etc) that we don't want to evaluate twice
> >
> >  - we can't make it an inline function, because the types aren't fixed
> >
> >  - we can't even use a statement expression and __auto_type, because
> > these things are used in type definitions etc and need to be constant
> > expressions
>=20
> Ok. I have a potential beginning of a solution.
>=20
> It is unbelievably disgustingly complicated. But it might approach
> being correct.
>=20
> And by that "it might approach being correct" I obviously mean "this
> is untested, but builds at least some kernel code".
>=20
> I'm almost certain it will fail on more complex cases, because I
> already found a lot of questionable stuff that was simply hidden by
> the old macro just silently doing the C arithmetic type conversions,
> and this thing does type handling manually.
>=20
> I'm hoping that somebody will go "Linus, you're just being
> *completely* silly, it's much easier to do XYZ".

I think your new __div_round_up_ull() should also be used by
DIV_ROUND_UP_ULL, which is defined in linux/math.h.

-- Sebastian

--3xdyay7hajk67vjt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmU5UgYACgkQ2O7X88g7
+pr6lxAAney3xsyWL9nxuzXlOqg2Bt+J+bDxMLJpjmNnsXbt3UjeyNOkBd1GBaaF
4rkeE1wVapAmWMdt+zoNmX+1A/r0gF6So80qAf622+Ae2L+78h36M1cnb4KPoBoD
ffNmWVaf7lJeuNfwbYfOs/ymXx2b0abs7Pf8IbrKl04ER+oCzWlaeaxzsMocyvw2
0CKoYw/jyWDnFhREC0qOJTb8oiUQHfSAa5mo61jBzjMErtdizF0rBG389W6GGgXA
N8pMZg502VAAOqxQRke3XS5Zk8IEHBj/aKrGRUvKDd5IbqwYWJT74p3/TionUs06
Z/TEr3X8NW4TElNRyxCqgudNXWqs7KYDB4tj7cDWHktPysw65Ow60M8BHExSKWc0
hfSbbdnN88DRhP8KP6m//dArD7cN+EVmLUmfNNzJ8GKxVdOGWvLbOUDCWq2+/Vzg
lsnv9CkWGjkCwzz8fzATkMfB0SW9SeCtAz1/9QGfWsV5M7rVWalkUyd1DCKSmtgG
G3V0+tTVJunazyhKBxzY1Y40HZB7BCfABuHTNwnWsu7yNQi52o1+GpkbSf9ieRD+
NmW4jgxqJzp8wzxpGhlHm1/R59vLSaTXWHP7UvaUQD/Jp4adik45m++iykv0XkTW
ErDfEJPQWkxVjybb6RIKdl9I1qQfbBVgOUzgOa1tb298xc8Ngys=
=jhkV
-----END PGP SIGNATURE-----

--3xdyay7hajk67vjt--
