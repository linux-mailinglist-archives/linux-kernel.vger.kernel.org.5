Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8044780C321
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjLKI2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjLKI2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:28:38 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F4E5;
        Mon, 11 Dec 2023 00:28:43 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1E6ED1C0050; Mon, 11 Dec 2023 09:28:41 +0100 (CET)
Date:   Mon, 11 Dec 2023 09:28:40 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Jan Kara <jack@suse.cz>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        chrubis@suse.cz, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>
Subject: Re: ext4 data corruption in 6.1 stable tree (was Re: [PATCH 5.15
 000/297] 5.15.140-rc1 review)
Message-ID: <ZXbIONRdDQx+mDwI@duo.ucw.cz>
References: <20231124172000.087816911@linuxfoundation.org>
 <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
 <20231127155557.xv5ljrdxcfcigjfa@quack3>
 <CAEUSe7_PUdRgJpY36jZxy84CbNX5TTnynqU8derf0ZBSDtUOqw@mail.gmail.com>
 <20231205122122.dfhhoaswsfscuhc3@quack3>
 <4118ca20-fb7d-4e49-b08c-68fee0522d3d@roeck-us.net>
 <2023120643-evade-legal-ee74@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sxUy6yRUZNOMIQt4"
Content-Disposition: inline
In-Reply-To: <2023120643-evade-legal-ee74@gregkh>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sxUy6yRUZNOMIQt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > So I've got back to this and the failure is a subtle interaction betw=
een
> > > iomap code and ext4 code. In particular that fact that commit 936e114=
a245b6
> > > ("iomap: update ki_pos a little later in iomap_dio_complete") is not =
in
> > > stable causes that file position is not updated after direct IO write=
 and
> > > thus we direct IO writes are ending in wrong locations effectively
> > > corrupting data. The subtle detail is that before this commit if ->en=
d_io
> > > handler returns non-zero value (which the new ext4 ->end_io handler d=
oes),
> > > file pos doesn't get updated, after this commit it doesn't get update=
d only
> > > if the return value is < 0.
> > >=20
> > > The commit got merged in 6.5-rc1 so all stable kernels that have
> > > 91562895f803 ("ext4: properly sync file size update after O_SYNC dire=
ct
> > > IO") before 6.5 are corrupting data - I've noticed at least 6.1 is st=
ill
> > > carrying the problematic commit. Greg, please take out the commit fro=
m all
> > > stable kernels before 6.5 as soon as possible, we'll figure out proper
> > > backport once user data are not being corrupted anymore. Thanks!
> > >=20
> >=20
> > Thanks a lot for the update.
> >=20
> > Turns out this is causing a regression in chromeos-6.1, and reverting t=
he
> > offending patch fixes the problem. I suspect anyone running v6.1.64+ may
> > have a problem.
>=20
> Jan, thanks for the report, and Guenter, thanks for letting me know as
> well.  I'll go queue up the fix now and push out new -rc releases.

Would someone have a brief summary here? I see 6.1.66 is out but I
don't see any "Fixes: 91562895f803" tags.

Plus, what is the severity of this? It is "data being corrupted when
using O_SYNC|O_DIRECT" or does metadata somehow get corrupted, too?

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sxUy6yRUZNOMIQt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXbIOAAKCRAw5/Bqldv6
8vAxAKCOJ3K0As4al5/2B9XBlV2nphZEGACeNMdfkQaFtWLePBti91xTjEsPsio=
=qZ/a
-----END PGP SIGNATURE-----

--sxUy6yRUZNOMIQt4--
