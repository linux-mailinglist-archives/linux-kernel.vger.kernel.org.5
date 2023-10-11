Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2337C5887
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346262AbjJKPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjJKPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:50:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11EDA7;
        Wed, 11 Oct 2023 08:50:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46872C433C8;
        Wed, 11 Oct 2023 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697039448;
        bh=0KoZe/o25n7g9S/IHTRmmfvyEg7ufwfdpBEMAF+7uRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ia0mcaQtjuOaGRm/1iFBr8ctGb4pmJ6DW7PtNgbT/K//tvtKFcxcBXCcFzRd1P/l+
         FmJ43OzmfUDpHqm6yGuUFkdiWt73jDSOTXwyMDuZAdb8m54d3XcZZy38hDcL59F6AN
         9Fu3YDf8YODibpnf1WDVpcYWkyitSOQQdQlk80xEFkHS9SDAEZvQBPUmQh698CuPYc
         8u28vyvcDOiq378FgCoGhEtqKJmNKctU6EmaFQfoqmHrqLxRp/0RoNvtCT8UN1xXND
         m11DrQggAKRPlA3eyHYSE8yQ1j7jugVCrgOT1mpRXFKyIZRQTjKY4+KSPDuaenBblA
         3WF6VJOKPtK0A==
Date:   Wed, 11 Oct 2023 17:50:44 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-man@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long
Message-ID: <ZSbEVHeUSwdRwUoR@debian>
References: <20231010234153.021826b1@imladris.surriel.com>
 <ZSZ7yXwYAg-xPC7P@debian>
 <60b4d916663ea31ae05a958b6dea8aa5bf740d0a.camel@surriel.com>
 <20231011134437.750422-1-mattlloydhouse@gmail.com>
 <ZSa1duEmIvCb0-_w@debian>
 <20231011151126.754612-1-mattlloydhouse@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yLFm10IwJtFpGLdr"
Content-Disposition: inline
In-Reply-To: <20231011151126.754612-1-mattlloydhouse@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yLFm10IwJtFpGLdr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 17:50:44 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Matthew House <mattlloydhouse@gmail.com>
Cc: Rik van Riel <riel@surriel.com>, linux-man@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long

Hi Matthew,

On Wed, Oct 11, 2023 at 11:11:24AM -0400, Matthew House wrote:
> On Wed, Oct 11, 2023 at 10:47 AM Alejandro Colomar <alx@kernel.org> wrote:
> > On Wed, Oct 11, 2023 at 09:44:29AM -0400, Matthew House wrote:
> > > To expand on this, there are basically two separate byte limits in
> > > fs/exec.c, one for each individual argv/envp string, and another for =
all
> > > strings and all pointers to them as a whole. To put the whole thing in
> > > pseudocode, the checks work effectively like this, assuming I haven't=
 made
> > > any errors:
> > >
> > > int argc, envc;
> > > unsigned long bytes, limit;
> > >
> > > /* assume that argv has already been adjusted to add an empty argv[0]=
 */
> > > argc =3D 0, envc =3D 0, bytes =3D 0;
> > > for (char **a =3D argv; *a !=3D NULL; a++, argc++) {
> > >     if (strlen(*a) >=3D MAX_ARG_STRLEN)
> >
> > Are you sure this is >=3D and not > ?
>=20
> Yes. In general, the kernel's string limits tend to include the trailing
> null byte. There are two places where this limit is enforced, one for the
> pathname (or full pathname for execveat) and the other for the argv/envp
> strings. The pathname is handled by copy_string_kernel():
>=20
> 	int len =3D strnlen(arg, MAX_ARG_STRLEN) + 1 /* terminating NUL */;
>=20
> 	if (len =3D=3D 0)
> 		return -EFAULT;
> 	if (!valid_arg_len(bprm, len))
> 		return -E2BIG;
>=20
> where valid_arg_len(bprm, len) is just (len <=3D MAX_ARG_STRLEN). Here,
> strnlen() has the same behavior as the ordinary libc strnlen(3),
> effectively returning min(strlen(arg), MAX_ARG_STRLEN). Thus, the check
> succeeds iff strlen(arg) + 1 <=3D MAX_ARG_STRLEN, or equivalently, iff
> strlen(arg) < MAX_ARG_STRLEN.
>=20
> Next, each of the environment and argument strings is handled by
> copy_strings():
>=20
> 		len =3D strnlen_user(str, MAX_ARG_STRLEN);
> 		if (!len)
> 			goto out;
>=20
> 		ret =3D -E2BIG;
> 		if (!valid_arg_len(bprm, len))
> 			goto out;
>=20
> The strnlen_user() function, per its documentation, is explicitly inclusi=
ve
> of the trailing null byte:
>=20
>  * Returns the size of the string INCLUDING the terminating NUL.
>  * If the string is too long, returns a number larger than @count. User
>  * has to check the return value against "> count".
>  * On exception (or invalid count), returns 0.
>=20
> Thus, the check succeeds iff the size including the null byte is
> <=3D MAX_ARG_STRLEN, i.e., iff strlen(arg) + 1 <=3D MAX_ARG_STRLEN, or
> strlen(arg) < MAX_ARG_STRLEN.

Thanks!  It's a bit confusing to see the terms 'len' and '_STRLEN'
meaning length+1, but it makes sense now.

Cheers,
Alex

>=20
> Matthew House

--=20
<https://www.alejandro-colomar.es/>

--yLFm10IwJtFpGLdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUmxFQACgkQnowa+77/
2zIo/A/+MCdQlUc0LZMVJcl7FM1Y9obHaGHGH97PwjGjqeOgiHfbCc86zRdoNUSa
ezIIw1kq2s77sPT34LuN5Onc91crtT2qgfhgnhigz/R4bH8jCy20NEIaf1tOwsaG
fyID05AiXmkIOlIslQtFLGhoDYKs5ZCuo6NxO0hOxB0XaM/KBjgrEYwvgFuigeyf
JO3fO/eVuZuh5T4mP021nWfq4opNBkU7CTlbHkCDxsY3XK3m2ZE8FoqTBZulY8Hs
r+baHaKKCzojx+byoJa0TlwulkE5n+xYpJC2pBHcfgqw1bhRQusL01bEzFoyRr0q
sGQeGB3jv9IRgCSVoLMZljnfhhAVXxP0kM3pp7xE1OJlxy/CuOFVwmKld1qOozUi
5k0GgPh5W7/HV9wnve3tVE4gLK45ZdFCAeQMbSP9LHxpW1sXDduLGPCDlH9gwkZY
EVgyBRFpBcNxfmnkbWkcJK6/aS6N06EEmGTOyR7xQUMt19Y9NYEIWEX37YFtONcI
RmeFblV4yUGhiLzmAol8usmFFlBK6jcWgy+rItOrgEfDgU393rD9gDrddsxrAT8f
AzXhOltVMUoVnRZQHXYnEIwtpAYoJtreNQq2P+rCS0qtqlC7PxC4Y5gaZujy0G25
Td8CXtX+6CY5aKLEvRYa7C1CLSMi8ESyiR6jxeW/Xqt/t4qc1MA=
=nXhE
-----END PGP SIGNATURE-----

--yLFm10IwJtFpGLdr--
