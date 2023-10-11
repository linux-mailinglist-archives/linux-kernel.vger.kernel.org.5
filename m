Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A396F7C5739
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346734AbjJKOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjJKOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:44:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0B39D;
        Wed, 11 Oct 2023 07:44:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFCEC433C8;
        Wed, 11 Oct 2023 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697035458;
        bh=+yR23TOJN+Xmz9Lb4zxvgkbSPWcLWaKrsKLjuBEPNzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mX7iLpEAk08MdoBBF+GxGElmoNo1IzYjHSOr3HjcdmOkdQdpZ0YUWGCpHVLlSBrwN
         gUpkhOXDWfaUBnJfBEWaUqIJ0CbNEdhPDTlSqYHh9KfYWQRj28Zbq2pA66bEtlDjOc
         jwa6ACSID0JMi7CzCyAZbdsuSrG9Z9So5TUYe6WlCJkCXncdykvYTL4HTHQHk7sESG
         VI0MrlvkHormwraSdBvdtUZZCLc0vcsFycICZFqrTG2u6qKdkTaPschD4NphQ2tb11
         kaF1jCRXY2uT6TJKU2sq5Wj5q2j8J+PE9VpU1qK2f2PYB5mMLMDY0+e+E7sfLb8aFV
         mmGRg+kn5BwAQ==
Date:   Wed, 11 Oct 2023 16:44:14 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-man@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long
Message-ID: <ZSa0v3zThnespb3c@debian>
References: <20231010234153.021826b1@imladris.surriel.com>
 <ZSZ7yXwYAg-xPC7P@debian>
 <60b4d916663ea31ae05a958b6dea8aa5bf740d0a.camel@surriel.com>
 <20231011134437.750422-1-mattlloydhouse@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w7jaJI5jMx6pA59R"
Content-Disposition: inline
In-Reply-To: <20231011134437.750422-1-mattlloydhouse@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w7jaJI5jMx6pA59R
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 16:44:14 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Matthew House <mattlloydhouse@gmail.com>
Cc: Rik van Riel <riel@surriel.com>, linux-man@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long

Hi Matthew,

On Wed, Oct 11, 2023 at 09:44:29AM -0400, Matthew House wrote:
>=20
> To expand on this, there are basically two separate byte limits in
> fs/exec.c, one for each individual argv/envp string, and another for all
> strings and all pointers to them as a whole. To put the whole thing in
> pseudocode, the checks work effectively like this, assuming I haven't made
> any errors:
>=20
> int argc, envc;
> unsigned long bytes, limit;
>=20
> /* assume that argv has already been adjusted to add an empty argv[0] */
> argc =3D 0, envc =3D 0, bytes =3D 0;
> for (char **a =3D argv; *a !=3D NULL; a++, argc++) {
>     if (strlen(*a) >=3D MAX_ARG_STRLEN)
>         return -E2BIG;
>     bytes +=3D strlen(*a) + 1;
> }
> for (char **e =3D envp; *e !=3D NULL; e++, envc++) {
>     if (strlen(*e) >=3D MAX_ARG_STRLEN)
>         return -E2BIG;
>     bytes +=3D strlen(*e) + 1;
> }
>=20
> if (argc > MAX_ARG_STRINGS || envc > MAX_ARG_STRINGS)
>     return -E2BIG;
> bytes +=3D (argc + envc) * sizeof(void *);
>=20
> limit =3D max(min(_STK_LIM / 4 * 3, rlim_stack.rlim_cur / 4), ARG_MAX);
> if (bytes > limit)
>     return -E2BIG;
>=20
> Thank you,
> Matthew House

Thanks!

This thing would be useful in the commit message.  An example program
demonstrating it would be even better.

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--w7jaJI5jMx6pA59R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUmtL4ACgkQnowa+77/
2zJjZxAAqrH8dlVZ8bDdOzaxordiMlVbUvj6UcexmDlle29byjFVQcjgJfmvHh18
6o+bIav3sizGh7ht1vhj7+x0673z6K5d8/QlhrBkqB5Qunx4YgpiaXrpOPOYt3gf
trS4lkbxrI9WU0ifT0A7HeVz3KQlNXmtyUlue4N4kH6b92KZnpdDtStnnHSWwuco
Uf+R66ir8+lWjhXNI5IpplYiQz3SFAo/9ztjwxHXesVSbpnqwCVD6oP6dL+dc0W1
B7PreIcJmn+HykjX1hk8Y4+FIqWdP0tJZ4Tv7JSeR653grEFsQhc9bzenNg2+kvd
ymz8gDoGwpgbEfLIH6G/MLXShU+7PGmcYEYjev1WBGEeZg1BY1DqUUi4VnZAWL4Y
0dno5do4fd0stjNL3vM7JBU6iCZ2reaoV6yMBbs4Wi4vsix19A+o0ds/aIMGF2iA
+z/ti1HEsm8lXs6D7U5nusj/F6ZeNMyQWpXV7K1CUX+vzZCMuEXx80vf1FeWNMEI
V/bOCYPd6AjQaQ/Ox4HBzi5gnATNvPhiLCkQnkKwZTi501sQhIIBU3IbnvT7z8dW
F7phHREEszDVQSAckPHsatmQ/LdLNtBpJA9JVlj1YavTlIORlTDmmOIQJtZNlgL6
F4XLvPvDMMFozKjIhBsAcoGI5sWXlhDKW5m1I2jdv+A31pUFDCg=
=zFqm
-----END PGP SIGNATURE-----

--w7jaJI5jMx6pA59R--
