Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67B7C5741
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346618AbjJKOqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjJKOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:46:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69BCA;
        Wed, 11 Oct 2023 07:46:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12D1C433C8;
        Wed, 11 Oct 2023 14:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697035589;
        bh=3f/l3JEoa5vkWJC1x5ot+HLUbRXrf4VNCPeowf+BznE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/Vs9ZdHEFalrdIj4t6JF1E74Sj895t7cxlZuAZx8pERBppimLf/m4/ueBWPv1vlH
         g8uVvhXuc3CpRk6Tw2CO+jjNdNGCfGccWkF0krkGfvxlkIoYG2Vno6W79fqTjdA6VU
         LRyHMfWATrPwQnK099Df50wxkgPFHfxR5fgFHFVRrYZCHMwlZlpp4+1u66F7tfFDcs
         WcpQaK+JZGMGqEFFRR60UEh1yeFq0PCG7Kq0mKQxOmme7ImfIVYoJBLHUZy/8nYNYX
         pKGFxmqYvuEWQ6NGBM01ezMSqgVtCddTJ3da/KHOtmS8A7e/AeoiMdrmM/RvjfivST
         2J04jYd4ILLQw==
Date:   Wed, 11 Oct 2023 16:46:25 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-man@vger.kernel.org, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Matthew House <mattlloydhouse@gmail.com>
Subject: Re: [PATCH v2] execve.2: execve also returns E2BIG if a string is
 too long
Message-ID: <ZSa1QciAqMl80-OS@debian>
References: <20231011101134.709b8089@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R95+DEmzFPiTA5rT"
Content-Disposition: inline
In-Reply-To: <20231011101134.709b8089@imladris.surriel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R95+DEmzFPiTA5rT
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 16:46:25 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-man@vger.kernel.org, kernel-team@meta.com,
	LKML <linux-kernel@vger.kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Matthew House <mattlloydhouse@gmail.com>
Subject: Re: [PATCH v2] execve.2: execve also returns E2BIG if a string is
 too long

On Wed, Oct 11, 2023 at 10:11:34AM -0400, Rik van Riel wrote:
> The execve syscall returns -E2BIG in 3 cases:
> - The total length of the command line arguments and environment is too l=
arge.
> - An argument or environment string is longer than MAX_ARG_STRLEN.
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

Please break lines after commas.

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

--R95+DEmzFPiTA5rT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUmtUEACgkQnowa+77/
2zJRHA//VoMS9aHC07bHzN8t5blkZg+m++DOlAzv/6Ty8zcap0EdAnHFols3ZzQy
dVzhydAlz3ulZ8r7ghWfvutdgdBDlYNQlLSFNPIaIvP7LDCFe3AZLBSMERguvXG4
G9TD1gsR5K52cdryIP9bko913L3MUDZzF92Lu7ybH/h9tV5eSVSYcgNSC7oSXt57
Bmp/7KJUV62JZLWaCqm3qsf/6CZpijL4SzwdgkASCU8VYU1/ZfwtRnp207IMm4Zp
0ja5crQtnnPP4EiEWMbNQQnRgD+TX6NUxMKbklTE4YmoOLP8V1h5cqtY98gAfid7
/U/WwGnEBpcXnx/GrqdOK432dAW0I6AR9xoOMj0J463dK+1RhkJvRT0D/n923ny2
p4ElyY7T4fDfO15V/6QxIGNKe6vwNZqXf/7Nv0fsqOHCs6jCcYlXrPrG7Z9NIl6v
LX89/cigNnb1zI8EmiV3pDVaKvlW4+PhmkF0/VQVmY0pWKezrJZB3aHd6Rde0y05
Fxk8CEUtrc6gN7UNmuUkoWT2IYwsFihjmBXboEHO0YI7vybllJwF17zF+x35Txu5
48Qz6MW4xAtP9yPcYkR3EewqqW9A3kJxAxpaqxh86ynzzfNU4I+UUcuHdkQJGl8W
BgtbMW1EgnB5Liod9dxSnMHnmLt+8g0+6qVeYushssUSzEwE8lM=
=cCsy
-----END PGP SIGNATURE-----

--R95+DEmzFPiTA5rT--
