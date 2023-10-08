Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0829B7BD0D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344828AbjJHWX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:23:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB88A6;
        Sun,  8 Oct 2023 15:23:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1183BC433C8;
        Sun,  8 Oct 2023 22:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696803833;
        bh=xnpzq4wUBG/q3NOSKI83ekFwJTD3ZZprq8GYkFyKFUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKXgdQRzxz98aBdg4Lu6qe11VhTNIeyrgVUmZMIZ2tm8BujGs4Pwd3iI8w5KO9dur
         U/kHZbKiae+9ZE8wKBaAtWHmP/7swn20fYA0ByglqLQ3RJE+DpxozNNxVa/GuXt0n3
         qWg99YOGA6LJKEKNmktIL27OIuLXqyslNf4E3WhctIMgBNGJ4q8Xkgizny5HiG9dnU
         YcdcXrgXLpwmZaBDqpgKSXC6hFEF7j69svBwQtioD4BYondUv9QjBi9Z8Pw9WcDmRA
         lsVV3lY2ESMlJIVfbUCXDco+v+xgEdq+KDHrbxKZWfpoQeQpf47++uSCg4Fg7F8lIg
         wqfgWGztaCCNQ==
Date:   Mon, 9 Oct 2023 00:23:49 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ioctl_userfaultfd.2: describe two-step feature
 handshake
Message-ID: <ZSMr9QtZmv0dwiLr@debian>
References: <20231003194547.2237424-1-axelrasmussen@google.com>
 <20231003194547.2237424-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IEa6GDqAgBshCuXi"
Content-Disposition: inline
In-Reply-To: <20231003194547.2237424-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IEa6GDqAgBshCuXi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 9 Oct 2023 00:23:49 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ioctl_userfaultfd.2: describe two-step feature
 handshake

On Tue, Oct 03, 2023 at 12:45:43PM -0700, Axel Rasmussen wrote:
> Fully describe how UFFDIO_API can be used to perform a two-step feature
> handshake, and also note the case where this isn't necessary (programs
> which don't depend on any extra features).
>=20
> This lets us clean up an old FIXME asking for this to be described.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Patch applied.

Thanks,
Alex

> ---
>  man2/ioctl_userfaultfd.2 | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index b5281ec4c..ef352a69d 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -82,7 +82,6 @@ struct uffdio_api {
>  The
>  .I api
>  field denotes the API version requested by the application.
> -.PP
>  The kernel verifies that it can support the requested API version,
>  and sets the
>  .I features
> @@ -92,6 +91,25 @@ fields to bit masks representing all the available fea=
tures and the generic
>  .BR ioctl (2)
>  operations available.
>  .PP
> +Since Linux 4.11,
> +applications should use the
> +.I features
> +field to perform a two-step handshake.
> +First,
> +.BR UFFDIO_API
> +is called with the
> +.I features
> +field set to zero.
> +The kernel responsds by setting all supported feature bits.
> +.PP
> +Applications which do not require any specific features
> +can begin using the userfaultfd immediately.
> +Applications which do need specific features
> +should call
> +.BR UFFDIO_API
> +again with a subset of the reported feature bits set
> +to enable those features.
> +.PP
>  Before Linux 4.11, the
>  .I features
>  field must be initialized to zero before the call to
> @@ -101,24 +119,11 @@ and zero (i.e., no feature bits) is placed in the
>  field by the kernel upon return from
>  .BR ioctl (2).
>  .PP
> -Starting from Linux 4.11, the
> -.I features
> -field can be used to ask whether particular features are supported
> -and explicitly enable userfaultfd features that are disabled by default.
> -The kernel always reports all the available features in the
> -.I features
> -field.
> -.PP
> -To enable userfaultfd features the application should set
> -a bit corresponding to each feature it wants to enable in the
> -.I features
> -field.
> -If the kernel supports all the requested features it will enable them.
> -Otherwise it will zero out the returned
> +If the application sets unsupported feature bits,
> +the kernel will zero out the returned
>  .I uffdio_api
>  structure and return
>  .BR EINVAL .
> -.\" FIXME add more details about feature negotiation and enablement
>  .PP
>  The following feature bits may be set:
>  .TP
> --=20
> 2.42.0.609.gbb76f46606-goog
>=20

--=20
<https://www.alejandro-colomar.es/>

--IEa6GDqAgBshCuXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUjK/UACgkQnowa+77/
2zLptg/+P9U2SpowseEvKRg0lV7o/eyhXKRhaPF4TSMq3GLRcTCcSGj/VGCew/nO
bz/9ClFGKbXgPf1eyRMwds14/3NhCMf6I6GlCvbhs2dKgXf2xiMYaCZ0L0AtDg/W
a9VK6k6BO58V/WEbIQgf3ckY7wJpLpIlcF9FQDSe/5az4DARKxEqhdKoP0OvAIbQ
bkBl/BGwaOlJTc/ByTzxJvFZYyUUjp1t0Ae92ydSlFdYSe61Q1QdvxVbVV7c9sUO
WXW0Osn3eVe5XjlAttZ60Q+iQO3bnGNOX8gLTZlsTBp52stvmpt+YipmkVqTSE0Q
wXNjcgqfgWtkZbvpuWTiQ3YnhWn0WPaQ0EO9KQacIaQnRS654AK6tQZoBUgwO+Nh
jiZjvroZ8Fj5QYvzB5KSlsVRL1HHITd0mIc1xA1elks693jDwkH2QjJjUZS+EkZx
9p9ZGbYdGxrZiM5fUoML2GsAEtFDQODorER8FzzzaOoobjsWCQudfUJ9BfmhDrPC
Do5cHT8J9ARZJes+Z4yBF8xqPaXRP++QLs7jln3vhr3R5yvQSGVRGb3SoyIiO9Js
uDXOdS5GrQhVtXECJVGTL0GXk/NPvj7YAa5/jeU0oYSm6A2b0tnLhY9z4slexLbV
mTqiDNna3dTumwPAuGYVY6d2x5QdN4Wql2jhn4roOaONH5W4qPw=
=bV+4
-----END PGP SIGNATURE-----

--IEa6GDqAgBshCuXi--
