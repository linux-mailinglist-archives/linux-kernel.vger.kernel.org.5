Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9EE7C5067
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346498AbjJKKlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjJKKlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:41:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A076FBA;
        Wed, 11 Oct 2023 03:41:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BECEC433C7;
        Wed, 11 Oct 2023 10:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697020877;
        bh=anlzUPl7ZpZUKXtz2bt3SGpGSz5+2RISrv6OvPdB5VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqeuOLMx4e1yNDzaxqpQm0RlWgrkKGCg3FPPuJ7chlHlfgONlgqxysH/VcSait1I+
         En6ItSF6hsZN0B9iCwOe8Szwy8spTC2yBOCUGBKS4RGyrOAhmx8M4wHNsm+Rs4uvYq
         jHXnBZXqQZ1dUlFc7QzAdxdQiqqNk+U58DqEoMXfT9yynAK3+jw80vXlWYLLNJDJ9c
         /WmsCuJUQ6Yll3vqUvitMKtIp7mINQ64WK5V+RGkxWnTP//3YWjTKXeWw4B3gcI0z9
         s0/o5p0PGPemUkU5r3lwsMJL3rFwfyuYKqdqwTZMS2Yb2zZMb29MTAMElpn/1P+796
         GDsUc1j3KS75A==
Date:   Wed, 11 Oct 2023 12:41:13 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@meta.com, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long
Message-ID: <ZSZ7yXwYAg-xPC7P@debian>
References: <20231010234153.021826b1@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZwlcAQNhET8ZExSa"
Content-Disposition: inline
In-Reply-To: <20231010234153.021826b1@imladris.surriel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwlcAQNhET8ZExSa
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 12:41:13 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	kernel-team@meta.com, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long

Hi Rik,

On Tue, Oct 10, 2023 at 11:41:53PM -0400, Rik van Riel wrote:
> Document that if a command line or environment string is too long (> MAX_=
ARG_STRLEN), execve will also return E2BIG.

That's already implied by the current text:

       E2BIG  The total number of bytes in the environment (envp) and argum=
ent
              list (argv) is too large.

That means that

size_t  bytes;

bytes =3D 0;
for (char *e =3D envp; e !=3D NULL; e++)
	bytes +=3D strlen(e) + 1;  // I have doubts about the +1
for (char *a =3D argv; a !=3D NULL; a++)
	bytes +=3D strlen(a) + 1;  // Same doubts

if (bytes > MAX_ARG_STRLEN)  // Maybe >=3D ?
	return -E2BIG;

>=20
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  man2/execve.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/man2/execve.2 b/man2/execve.2
> index 0d9582492ad1..c1a359d01872 100644
> --- a/man2/execve.2
> +++ b/man2/execve.2
> @@ -449,7 +449,7 @@ The total number of bytes in the environment
>  .RI ( envp )
>  and argument list
>  .RI ( argv )
> -is too large.
> +is too large, or an argument or environment string is too long.

Please use semantic newlines:

$ MANWIDTH=3D72 man man-pages | sed -n '/Use semantic newlines/,/^$/p'
   Use semantic newlines
       In the source of a manual page, new sentences should be started
       on  new  lines,  long  sentences  should be split into lines at
       clause breaks (commas, semicolons, colons, and so on), and long
       clauses should be split at phrase boundaries.  This convention,
       sometimes known as "semantic newlines", makes it easier to  see
       the  effect of patches, which often operate at the level of in=E2=80=
=90
       dividual sentences, clauses, or phrases.


Thanks,
Alex

>  .TP
>  .B EACCES
>  Search permission is denied on a component of the path prefix of
> --=20
> 2.41.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--ZwlcAQNhET8ZExSa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUme8kACgkQnowa+77/
2zLKiw//ZOA7Nq0uA05ugaXbCPWN/txWsn+y9oxApUHLy1RygRjiPCsRK8XhNvde
AueRu+yXv+OGAbOTGCDJNJqp0smMiCParVtLGwr8hxp9l1J3GPbFBGSsTUSlXUwy
y9LgkfY3ZiGT419unGJI0Mbep/koSYBl+X7kLyWQYz6I+lpFGZAFAmLj7fpqGNpq
mcH1M6cTPB7ip1HdseTptBoJ3yI3JEIPPf8GF9+HdcubfVaYoXQ/qw9xRy5coh7H
emgFrcu4UD1L6/WOmLenPZ6mkOSqTi1AiERZIpGtkxksJLgBZPUY3jV+bqKUuOtS
M8TCwTbnM8EiPdQQlK4lE425Eymzla2vVRilY7+s6rsLKGdZRDla6Plm3Q23xxa9
2+mjAgLZURFadQIhj6GRH/0+cSUFRTDEkw7mt00RES8/9h0oTxVmpnV0+slQMqjf
P5zAznodF9rcyq7s/T7MVZwJNnRUEixz+B+JfqCnoE8Id2Eh1Oo9GAyuZ6C3v28R
5m6MflH9HBtjzNUgWTm69UxdMAtPhcCp5orD6cnrlEDX4jpVRbZ0NORcbxesyxo/
n+LDCtakCJsZks6GJZOsfZqChcEjLeutzR96T8HZWiMfiKJJOOeW5lNebWHxmr9d
yVdFwPWLfL4Gk8JScIO7JhVmGCnQn6UbCxam7c7AQpZFSrisIo8=
=jOsU
-----END PGP SIGNATURE-----

--ZwlcAQNhET8ZExSa--
