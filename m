Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921C57C5871
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjJKPtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjJKPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:49:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217B8F;
        Wed, 11 Oct 2023 08:48:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01487C433C8;
        Wed, 11 Oct 2023 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697039339;
        bh=W/be6p+a+sytExHshYPl6x4UDwpZ/OVOY3r0BYpxXeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3JdgNchw9Y0E5naLf3AAVcBChZL9d80rV3amSRbgGxQs0EP8lc7x+UIxs1LwLEX2
         xD1draTzK6hdFIaX0G/hAwcqTnG7j79LE+TJnr46MPzBnGOnOFL8wh6QLMT9liPi64
         4GbQtERbJxy844eQeeRb909vmfPDDtI+gNibF4Uh+55KcC9gsB25uTF1noZjpC4fFB
         /D2T4K/6YaQkBnkd/KPVwERIztcMU8PAtB5sjkxi6GkgbV/2v7VhMwM2j44kIyE97q
         c8loHIrCjRHTy0MeRP8oaMwvlfz8kNI11/4ZtQIBiYhLGsgeTTtD2bE9xia5rHNytR
         GsCZJrB+PbTLw==
Date:   Wed, 11 Oct 2023 17:48:55 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-man@vger.kernel.org, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Matthew House <mattlloydhouse@gmail.com>
Subject: Re: [PATCH v2] execve.2: execve also returns E2BIG if a string is
 too long
Message-ID: <ZSbD59Y5y3zNGC1h@debian>
References: <20231011101134.709b8089@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g/fBSq8QREL4SK6R"
Content-Disposition: inline
In-Reply-To: <20231011101134.709b8089@imladris.surriel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g/fBSq8QREL4SK6R
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 17:48:55 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-man@vger.kernel.org, kernel-team@meta.com,
	LKML <linux-kernel@vger.kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Matthew House <mattlloydhouse@gmail.com>
Subject: Re: [PATCH v2] execve.2: execve also returns E2BIG if a string is
 too long

Hi Rik,

On Wed, Oct 11, 2023 at 10:11:34AM -0400, Rik van Riel wrote:
> The execve syscall returns -E2BIG in 3 cases:
> - The total length of the command line arguments and environment is too l=
arge.
> - An argument or environment string is longer than MAX_ARG_STRLEN.

Please mention that this includes the terminating NUL, as Matthew
confirmed.  Otherwise, to user-space programmers, this would usually be
interpreted as `strlen(p) > MAX_ARG_STRLEN`.

An example program that demonstrates the limit would be very interesting
here.

Thanks,
Alex

> - The full path to the executable exceeds MAX_ARG_STRLEN.
>=20
> Spell out all 3 cases in the -E2BIG section.
>=20
> Discovered by moving a too large commandline parameter to an environment
> variable, and finding that things still did not work. Examined the code
> in fs/exec.c to get the details.
>=20
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Matthew House <mattlloydhouse@gmail.com>
> ---
>  man2/execve.2 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/man2/execve.2 b/man2/execve.2
> index 0d9582492ad1..85c6ec15df3c 100644
> --- a/man2/execve.2
> +++ b/man2/execve.2
> @@ -449,7 +449,8 @@ The total number of bytes in the environment
>  .RI ( envp )
>  and argument list
>  .RI ( argv )
> -is too large.
> +is too large, an argument or environment string is too long, or
> +the full path name to the executable is too long.
>  .TP
>  .B EACCES
>  Search permission is denied on a component of the path prefix of
> --=20
> 2.41.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--g/fBSq8QREL4SK6R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUmw+cACgkQnowa+77/
2zLwNA//Sk90eRw0DvGnOnqxsPcwUAXNf+nl1y5Cqg+BH2MReSAnm+yawR6Wqxil
O522iQkFZp9+8xFADkzvvf/769p3YG/DyAtO8/5J4YOoIopbMRm8T/FyoD84eBeW
cLhJBcd47uAFQueDCzh2veTw8+ZDefkDY9TTulpvj9GVFA8F4xFxLiYKfFkRm4JF
4v060aAAE5DaSjrD7K4kmXTzLAnJim53FzNjK2y6VKd4stkyle4Ma8rZPcV3QTd/
2XaFNOayz/ER/R1aGvjECrCgACNvjJR2Fm3KvbKKKG5I+luxbuHqMkcpZq5dsi8m
R2E3n3KsTiBxxHsOOh0X1CbbxwOI74+v35wCW4Jssk5WPaxQWNfYjB86rQOY3RWY
uG0E+YZg9tRfLevBaX6mFP5Sag96qHCd5eOzaZXkweBXgm7FYOAjpEdANeikxQ/O
mwMcUVVvMUOjundI+kJBSGUIlWbpN8OT6f8V8b+7oDjEjvI7x03LEdy3JcQC/x/U
cgiIFDRfSs8UUQW3svYqzILALe49Ym+zcsjZ3ckfzHJQabJ9YEPHwdelp0FkwZ3L
TtJW9Ur7W27iGj6EwNtDhiMNz4CUNImuffzn3YcWftMdyUBZph1kbj9hsEfDBVgH
wpxdtfJ/GdcgkMc8l3n6y+aPHkbbCsHn5wnc6jD6wf0Vxzrpdd0=
=bumQ
-----END PGP SIGNATURE-----

--g/fBSq8QREL4SK6R--
