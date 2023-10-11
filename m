Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5D67C5E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376321AbjJKUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjJKUPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:15:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EC1A9;
        Wed, 11 Oct 2023 13:15:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26478C433C8;
        Wed, 11 Oct 2023 20:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697055306;
        bh=7rI5K23nHUYB8QrWcVJMkRhk6dpeW9+5+hV2Br9vIXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0Mb35yahXR8BIcciRBkftV86dHySP8qtE25zU41q3wm8HagsHJ3AXU8aMURfP3AS
         BMuzEeXqGGOxIieozq1BTvP6ei5rQyYKv50B0J2COL8HVxc3R59jCvWBEf7TbSB9hY
         X4ZI3P+qlDErU/raCu6OL4LFISwVeHynRTi1SOe8Nj2uiBkNOi2jgBf1WZmzxcJGYh
         gppTeVz1N9AGLL+1J/JXCN5rKjE6w2BaqQbxhDbnd4c82T5IIOnk80Xd0H/EiHhfpZ
         i06DfbsmHyVnzMm0RNPHVm7qUH26NtQrn6RTouuELtt3oFUtAgR9wPOctuXHlkQiw0
         WZ1z1G+4fSBCA==
Date:   Wed, 11 Oct 2023 22:14:55 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-man@vger.kernel.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org,
        Matthew House <mattlloydhouse@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4] execve.2: execve also returns E2BIG if a string is
 too long
Message-ID: <ZScCP2RqArDeixLz@debian>
References: <20231011124301.4d93ea72@imladris.surriel.com>
 <20231011125330.13dfe148@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kIbR5WHOxHuCy4ke"
Content-Disposition: inline
In-Reply-To: <20231011125330.13dfe148@imladris.surriel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kIbR5WHOxHuCy4ke
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 22:14:55 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-man@vger.kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Matthew House <mattlloydhouse@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4] execve.2: execve also returns E2BIG if a string is
 too long

Hi Rik,

On Wed, Oct 11, 2023 at 12:53:30PM -0400, Rik van Riel wrote:
> Sigh, once again I did a git commit --amend without the latest file chang=
e being
> included. The change below should be good. Working with both git and hg g=
ets me sometimes :/
> ---8<---
>=20
> The execve syscall returns -E2BIG in 3 cases:
> - The total length of the command line arguments and environment is too l=
arge.
> - An argument or environment string is longer than MAX_ARG_STRLEN.

I'm still concerned by the wording of this sentence (and the next one).
When I (and any user-space programmer, I think) read "string is longer
than FOO", I read `strlen(string) > FOO`.  Since it's rather
`strlen(string) >=3D FOO`, I think you should clarify.  How about this?

-  An argument or environment string is longer (including the null byte)
   than MAX_ARG_STRLEN.

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
> This simple shell script starts failing at 2^17 on a system with 4kB
> page size:
> ./exec2big.sh: line 10: /bin/true: Argument list too long
> fork failed at loop 17
>=20
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

Thank you very much!

>=20
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Matthew House <mattlloydhouse@gmail.com>
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
>  .TP
>  .B EACCES
>  Search permission is denied on a component of the path prefix of
> --=20
> 2.41.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--kIbR5WHOxHuCy4ke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUnAj8ACgkQnowa+77/
2zJZAA/+IZ5SqRkxDnu/FCav0QtXCHltjqi/VsTI+CJ7fmCtii3akFQ9TWNYeZBO
xyc0jiSbCaFfhF+frMJIglcwvPlFNEnwoToYbUllkhWQy8wfHrj965jgchUTP1FL
DJYlIvn4p2RUmnFi1HiwfqdObCMKKlTQJ61Nnj+piztaPZ33RvQuLRdpRcou6ehL
vgf6kKPuYwPMG43Kii6rcfSXkSnPJu++Shr95anNzKbUG6rNNsXtY7ugPjBs6iop
MjQdT/PjDs3S1zTvAsQfJEc0N1B16kW1tRriRKE3HH310/u7Q4qG9xGRrfl5W+8G
4lZK7jqLWZN0PcFM7x8yNOYMaQo2BHKqHnjYlxpAfabcZmGUfm5b01zcxOsqx0IH
RFM6NOEkaA0YTJAM7puOOx4bR/806iK69eTxaavz+25W1YbfglYb1kB8bBLILLTa
Lx+Gynd6QMdx0Juyj8mH4gUdjprjOTx4NO5TkM0lSBgqXilUE5kYpJqDvfmjE12e
fXS2w/fLH5j0hixziUk/zxYbyLa/FbDdnG1NU7z5ZOAQ8FR+CeqE1p9rOAf3nBbb
hjIGT+oc1qEZ/fTtE1IkJFQVOCJhHmVFGNICoBJxppZPTthMfnMegcR/BWcBGVtQ
xaS7mGOPK8l4d4Jo+S7dFHsHvksbAmPxnF8VXHR2wAQMRUduo10=
=tFhL
-----END PGP SIGNATURE-----

--kIbR5WHOxHuCy4ke--
