Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377097BFAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjJJMFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjJJMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:05:48 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843DB99;
        Tue, 10 Oct 2023 05:05:46 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 152EE1C006D; Tue, 10 Oct 2023 14:05:45 +0200 (CEST)
Date:   Tue, 10 Oct 2023 14:05:44 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Pavel Machek <pavel@denx.de>
Cc:     wsa+renesas@sang-engineering.com,
        niklas.soderlund+renesas@ragnatech.se,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        biju.das.jz@bp.renesas.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris.Paterson2@renesas.com, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: renesas_sdhi problems in 5.10-stable was Re: [PATCH 5.10
 000/226] 5.10.198-rc1 review
Message-ID: <ZSU+GHl1q7T/TBp5@duo.ucw.cz>
References: <20231009130126.697995596@linuxfoundation.org>
 <ZSRVgj5AqJbDXqZU@duo.ucw.cz>
 <ZSRe78MAQwbBdyFP@duo.ucw.cz>
 <ZSUy+zA0+Chm6dFb@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kmt4faAXz7TCbez6"
Content-Disposition: inline
In-Reply-To: <ZSUy+zA0+Chm6dFb@duo.ucw.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kmt4faAXz7TCbez6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> > > > This is the start of the stable review cycle for the 5.10.198 relea=
se.
> > > > There are 226 patches in this series, all will be posted as a respo=
nse
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >=20
> > > > Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> > > > Anything received after that time might be too late.
> > >=20
> > > 4.14, 4.19 and 6.1 tests ok, 5.10 seems to have problems:
> >=20
> > Guessing from stack traces, these may be relevant:
>=20
> So bisection reveals these are relevant:
>=20
>   |e10d3d256 b161d8 o: 5.10| mmc: renesas_sdhi: probe into TMIO after   S=
CC parameters have been setup
>=20
> Ok
>=20
>  |493b70c48 d14ac6 o: 5.10| mmc: renesas_sdhi: populate SCC pointer at  t=
he proper place
>=20
> Testing now: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipeli=
nes/1031822035

And testing failed. So

commit f5799b4e142884c2e7aa99f813113af4a3395ffb
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Tue Nov 10 15:20:57 2020 +0100

    mmc: renesas_sdhi: populate SCC pointer at the proper place
   =20
    [ Upstream commit d14ac691bb6f6ebaa7eeec21ca04dd47300ff5b6 ]

seems to be the buggy commit that breaks renesas boards in 5.10.

>  |c508545f4 0d856c o: 5.10| mmc: tmio: support custom irq masks

Testing too: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipeline=
s/1031834627

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kmt4faAXz7TCbez6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSU+GAAKCRAw5/Bqldv6
8haIAJkBZWNo+fR9/jsfeG3zeswyYC7fOQCgogoTt5zPNc6+2mGK+jsCbp1Rf9w=
=FWgd
-----END PGP SIGNATURE-----

--kmt4faAXz7TCbez6--
