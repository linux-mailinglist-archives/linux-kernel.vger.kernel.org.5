Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760CC7C6139
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjJKXpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJKXpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:45:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC39E;
        Wed, 11 Oct 2023 16:45:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E73EC433C7;
        Wed, 11 Oct 2023 23:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697067919;
        bh=/HC7U5pVDv/9ep0iiqYi0TrXgK7iwfrCccR7NN9N6TA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yj2F59qgm/RoY6Qg2GZyMHwtebockxxv+Qjm8WPRSDXl8YpYJFz0TDndU8FByrsim
         CyvhlpWoDT2htk/mBZXT8CYAPnH1+5UzXIFanaRwGWRg+2Iwmu/Z8h95moxUILZ53Z
         oLrQ8N3HYhRuugUdHVGmLJy6qx0NFEz4SAimoyS3w3KkBpEtdaNS4bNl6R1RO8zM5G
         D+ygriwctjw6Gq7CMMAlcTXUO9JrtSSZkCM0sLMIQpKHSoTLdqjg1d9QCVm+AB0VxQ
         yVqldd7/mvOZyqjxElkpMi92Ejb3QmfKGc6E4Mr19BkoETClNWfTFnbKDaycr4p3tA
         4Agfo7cvSTZgQ==
Date:   Thu, 12 Oct 2023 01:45:15 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-man@vger.kernel.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org,
        Matthew House <mattlloydhouse@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4] execve.2: execve also returns E2BIG if a string is
 too long
Message-ID: <ZSczi_PJ2TX8RjZs@debian>
References: <20231011124301.4d93ea72@imladris.surriel.com>
 <20231011125330.13dfe148@imladris.surriel.com>
 <ZScCP2RqArDeixLz@debian>
 <b99cd99fb6758ceb4cf3152c038fda761d597bb6.camel@surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RS8szfeyc21P55+2"
Content-Disposition: inline
In-Reply-To: <b99cd99fb6758ceb4cf3152c038fda761d597bb6.camel@surriel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RS8szfeyc21P55+2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Oct 2023 01:45:15 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-man@vger.kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Matthew House <mattlloydhouse@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4] execve.2: execve also returns E2BIG if a string is
 too long

On Wed, Oct 11, 2023 at 04:53:20PM -0400, Rik van Riel wrote:
> On Wed, 2023-10-11 at 22:14 +0200, Alejandro Colomar wrote:
> > Hi Rik,
> >=20
> > On Wed, Oct 11, 2023 at 12:53:30PM -0400, Rik van Riel wrote:
> > > Sigh, once again I did a git commit --amend without the latest file
> > > change being
> > > included. The change below should be good. Working with both git
> > > and hg gets me sometimes :/
> > > ---8<---
> > >=20
> > > The execve syscall returns -E2BIG in 3 cases:
> > > - The total length of the command line arguments and environment is
> > > too large.
> > > - An argument or environment string is longer than MAX_ARG_STRLEN.
> >=20
> > I'm still concerned by the wording of this sentence (and the next
> > one).
> > When I (and any user-space programmer, I think) read "string is
> > longer
> > than FOO", I read `strlen(string) > FOO`.=C2=A0 Since it's rather
> > `strlen(string) >=3D FOO`, I think you should clarify.=C2=A0 How about =
this?
> >=20
> > -=C2=A0 An argument or environment string is longer (including the null
> > byte)
> > =C2=A0=C2=A0 than MAX_ARG_STRLEN.
>=20
> That works. Would you like me to re-send a v5, or do you
> want to massage the changelog when you apply the patch?
>=20
> I must admit I paid more attention to the wording in the
> man page than the wording in the changelog :)

I wouldn't mind doing it myself, but I'll ask you to resend, if you
don't mind.  I usually find that doing so helps catch other accidents
that I didn't catch.  :)

Cheers,
Alex

>=20
> --=20
> All Rights Reversed.

:)

--=20
<https://www.alejandro-colomar.es/>

--RS8szfeyc21P55+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUnM4sACgkQnowa+77/
2zJFMw/9Ey8pzmgHsCgpWvgq2zMsRSsb6jNUZERcdNJ5f7KsnXCIfXoSHN0LlF6S
fHtqMLL+zchtkDeWsro9LGIo+IRUnBVhiUIhsHV6hiT85PWchF0gEXEvE0rrJhun
5CMYbU0MpIGSseENN8MU6D+IXLUSorV3/BZ9dY1FNKAmsmx/Hk6tj3eNjvKlKuqt
k7FSccKkprFXR7qSZNLd1SGoGHLu6AuOeuNtBGvJ5/0JB4GhbSdneA862hEC3D+h
T1SQUBT55EzDbrLDGDuHizvSB891Vt4lRFnjlFZHmXcOM2nQn1bO97ThvjmCjZlg
1y1zcwN6VMx7UxALWFfnbCvkUcD9IGPQ21tMX5TYD0zigKepDZsWBFdrTq+NteaT
9gUCyOQV9DmYiv2ptAfB+i18rlyXxgQJg8DxFl4XxfCvMwnHzzkDH0b5LU3vGp7G
GzIYqR7MNPwHVFRcgaEKJ97k+Ke5uzvVQ/kC9APYRZheXtiRF2iSlKlF9u0qNP8l
BPR/gnKvwEWS9WqFQl92tNma0gib4gQ78Gbrh67jYPnnpYVUssVW8Ujrcbwwszxr
V2/emDY4qHtwOJsPRuzcVQWCicwCWG3hLKekWak9qWjuQ2YCz5WD6wp0NT6GyFEK
lxjMsZ23cT++ZouNAFpUplBiK/4h84dyy3CnAUPy2FTVNIqJgO4=
=RJf0
-----END PGP SIGNATURE-----

--RS8szfeyc21P55+2--
