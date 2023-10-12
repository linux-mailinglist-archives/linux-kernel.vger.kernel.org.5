Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA25E7C68F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjJLJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbjJLJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:03:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A24D78;
        Thu, 12 Oct 2023 02:03:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B782C433C8;
        Thu, 12 Oct 2023 09:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697101388;
        bh=2LFNmYaz8q0r7suirKqp0kd/VkNbxVAuyjGqOfQgAM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/0O8OecGGj2JQHB2btf/6uJ+3Nj/Bks+vol2sf4949CYefEQAWTYzKXVPqMu5MpV
         J5uMpVhokugoE9OkN3K0J+EmERS88/JfIx+LW99LqEfjzautfQAZFbwTFpDkZEnIEr
         SBtD0Lq9oRuwI5nXpTn4WPNQGl3nX2fiVpjHmvOcGJxXeB+FR4JYfS9tlfKrf0wmy0
         WgFlcHWgsGXhk+937tVd7iW8u03peW7yr4IITMd9DBl3DiL30MbMEPDef+Gx2evzBd
         wRMr8MqGIYbDUwTin1ixgbn00sd9z13O2E1XQ3hXfzuQZqBCFFWHfiYWZVONVzGEvG
         pD55CmOKrlSdg==
Date:   Thu, 12 Oct 2023 11:03:04 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-man@vger.kernel.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org,
        Matthew House <mattlloydhouse@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5] execve.2: execve also returns E2BIG if a string is
 too long
Message-ID: <ZSe2SNGy9dMWil3w@debian>
References: <20231011214652.1c4db8b7@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kK+/9NxjDycKoJ8Q"
Content-Disposition: inline
In-Reply-To: <20231011214652.1c4db8b7@imladris.surriel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kK+/9NxjDycKoJ8Q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Oct 2023 11:03:04 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-man@vger.kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Matthew House <mattlloydhouse@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5] execve.2: execve also returns E2BIG if a string is
 too long

Hi Rik,

On Wed, Oct 11, 2023 at 09:46:52PM -0400, Rik van Riel wrote:
> The execve syscall returns -E2BIG in 3 cases:
> - The total length of the command line arguments and environment is too l=
arge.
> - An argument or environment string (including the NUL byte) is longer th=
an MAX_ARG_STRLEN.
> - The full path to the executable (including the NUL byte) exceeds MAX_AR=
G_STRLEN.

I changed the above to fit in 72 columns.

>=20
> Spell out all 3 cases in the -E2BIG section.
>=20
> Discovered by moving a too large commandline parameter to an environment
> variable, and finding that things still did not work. Examined the code
> in fs/exec.c to get the details.
>=20
> This simple shell script starts failing at 2^17 on a system with 4kB
> page size:
> ./exec2big.sh: line 10: /bin/true: Argument list too long
> fork failed at loop 17

Moved this to after the script.

>=20
> #!/bin/sh

And indented the script to avoid issues with git and hashes in commit
messages.

> STRING=3D"a"
>=20
> for loop in `seq 20`; do
> 	STRING=3D"$STRING$STRING"
> 	export STRING
> 	if /bin/true ; then
> 		: # still under the limit
> 	else
> 		echo "fork failed at loop $loop"
> 	fi
> done
>=20
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Matthew House <mattlloydhouse@gmail.com>

And reordered this.

Patch applied.  :)
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D39a4ac5820cbdc8c9f7ebaad70f1adcc59955cbb>

> ---
>  man2/execve.2 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/man2/execve.2 b/man2/execve.2
> index 0d9582492ad1..b689101771e5 100644
> --- a/man2/execve.2
> +++ b/man2/execve.2
> @@ -449,7 +449,12 @@ The total number of bytes in the environment
>  .RI ( envp )
>  and argument list
>  .RI ( argv )
> -is too large.
> +is too large,
> +an argument or environment string is too long,
> +or the full
> +.I pathname
> +of the executable is too long.
> +The terminating NUL is counted as part of the string length.

I replaced s/NUL/null byte/

man-pages(7):

   NULL, NUL, null pointer, and null byte
       A null pointer is a pointer that points to nothing, and is nor=E2=80=
=90
       mally  indicated  by the constant NULL.  On the other hand, NUL
       is the null byte, a byte with the value 0, represented in C via
       the character constant '\0'.

       The preferred term for the pointer is "null pointer" or  simply
       "NULL"; avoid writing "NULL pointer".

       The  preferred term for the byte is "null byte".  Avoid writing
       "NUL", since it is too easily confused with "NULL".  Avoid also
       the terms "zero byte" and "null character".  The byte that ter=E2=80=
=90
       minates a C string should be described as "the terminating null
       byte"; strings may be described as "null=E2=80=90terminated", but av=
oid
       the use of "NUL=E2=80=90terminated".

I kept NUL in the commit message, because I actually like using NUL, but
Michael didn't, and for consistency, I keep that in the body of the
manual pages.  In the commit message, it's fine for me.

Cheers,
Alex

>  .TP
>  .B EACCES
>  Search permission is denied on a component of the path prefix of
> --=20
> 2.41.0
>=20

--=20
<https://www.alejandro-colomar.es/>

--kK+/9NxjDycKoJ8Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUntkgACgkQnowa+77/
2zLdOw/+O2hXqlbUjCfsLW7tqVikA6Fqmgs/JLaDGD7dBVofAFq/BJehVBK6v6lz
nft4MghOiMPgHjq/YM9Bxz5qNogT9Q0ci2Ak3gbaAbDt+jRP8ezlfSgSiuWdXQF+
zWaATb+lrBT/5RsF37SGcuStbYqSHO2/MCx2wZP0icF8mytSBP56GjYQx9BGZbue
7Gffb16RWzyrR3PdVNG/Pvq0L6ST6TLqBkOtUpSEzqXKrUDPRSycFjsBB8y2JONN
tsEUZdjnWHdnhmD1FIsqeWoE8vZrJWsX7OgiMW+8qZ4guqSg16P06Vj/ftRonFLq
IRqUGWFc1XMncjJNyiB+G3eZhV2Z/kh/SsT4R9V/U6f1EkRpXZOzXj/rKPbplJX8
vCmoPATW6/IRoSZyp6lTbz199vLiKBh9zuEm/CCDJEbqo7eAfDfxgl4Vb2L/Fwd5
BwSKXl8jl+wmoKR0azmv8bhN93e07t061obNiLooz4QiRuwavW9cIIaK4/YbFVcv
5RQEa/xcE2r8OWlcl5adgqI47CZr7VcOSmAMyKdMQI2PaWakwg1han8Q4bhLmj1i
/mA0QHuncm+gZ1Ko2DKSv2XI6HsL+fm0NOrpAFiMRpTQAgVfz77rL9dT8tYyuH1f
QorXQF897419cV5jZobW4P2kLMBVVWYNZEDj8agQTpFwvhkx0/Q=
=/LJK
-----END PGP SIGNATURE-----

--kK+/9NxjDycKoJ8Q--
