Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641847AE292
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjIYXpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYXpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:45:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D1010A;
        Mon, 25 Sep 2023 16:45:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAA0C433C8;
        Mon, 25 Sep 2023 23:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695685502;
        bh=5hXy8gXAnPDRA/xb8in5bDyRmvowKWkabeT+gdxcykY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=as8ca0R+9XP+3xiFd0abvvG0SUUSVmgd+ABk/M5q3hoWP807wRs3/6dR5+4btuG8X
         oIg57aaXW5Xqj3qTj6GZXdtfoJKIfFOnxU3vjrAgw554cmpUM/mc4u+3ggx9UOmO58
         y6Jq6ANkLSHoPIxFDSO2NTS2Yccg7VnhIUZsvMG23aG8tcRb9NIMIhPm8pxgUv04+4
         o4kHDfS/pk1oFJHvhXvfq2a9sa0b7Snj6hJUrVqZa6oI3UYUrhH2YhNURQztPYKGBD
         6Cfzh4WxVdKhBiHO8zzNvTIU1/uQSCP3KYm2+Ie+usUwua5vxOHs/JkGqNCS890dk5
         IviICiPANzP7Q==
Date:   Tue, 26 Sep 2023 01:44:58 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] ioctl_userfaultfd.2: describe two-step feature
 handshake
Message-ID: <zrrzgoxnywtilqpm3sumb4utdc5kkt5e5fjinshz7rhsd73gv4@454fgnmflmre>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2il7vkfavf2qb2o"
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-6-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2il7vkfavf2qb2o
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/10] ioctl_userfaultfd.2: describe two-step feature
 handshake
MIME-Version: 1.0

Hi Axel,

On Tue, Sep 19, 2023 at 12:02:01PM -0700, Axel Rasmussen wrote:
> Fully describe how UFFDIO_API can be used to perform a two-step feature
> handshake, and also note the case where this isn't necessary (programs
> which don't depend on any extra features).
>=20
> This lets us clean up an old FIXME asking for this to be described.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  man2/ioctl_userfaultfd.2 | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 339adf8fe..e91a1dfc8 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -83,7 +83,6 @@ struct uffdio_api {
>  The
>  .I api
>  field denotes the API version requested by the application.
> -.PP
>  The kernel verifies that it can support the requested API version,
>  and sets the
>  .I features
> @@ -93,6 +92,25 @@ fields to bit masks representing all the available fea=
tures and the generic
>  .BR ioctl (2)
>  operations available.
>  .PP
> +After Linux 4.11,

"After" to me means that you're not including 4.11.  You probably mean
"Since", which would be inclusive?  Or do you actually mean since 4.12?

In any case, "since" is more commonly used, so I prefer that wording,
for consistency.

Thanks,
Alex

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
> @@ -102,24 +120,11 @@ and zero (i.e., no feature bits) is placed in the
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
> 2.42.0.459.ge4e396fd5e-goog
>=20

--p2il7vkfavf2qb2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUSG3oACgkQnowa+77/
2zKFCA//b9J4YsNEWsxijeXSus+8OQkpMXymStaVl08Cn/oNjYqw6K87xf1KMpzJ
SlJvwchbRtGA1QNEJytTd1fp49ykSQqxeenktMvqhY5pLRi0PK6lrRkHf3rRST/F
6NxNqfTB7N56xze8qnzL+OLx49vsZoGaPO3GJnYej6WPyl9NOu0sB6nZf08b22gV
Fxiijitg6eSN2a0KcItYoXhvE+aH7a8sh6EBhnoaIIjk6qT/J9mKtppPSSxqQ8Bk
2ySSlb/R4DzEzXJoqNGPEIHkRBnJnMpg3wzkuenNSTUn1QwKqkIs4EevUMAWAs+V
CAA6/veM8DZgeN6hlVsadQogIxHCecRqgL5LyUvsTuAxs9kjNm1jrFgmS4iXywol
xDAaD3BS8Q7EhZAmkdZ0SPWDMr1+cM4RSUKF2wl1+zo423elCoBQK3J+QvijmdEZ
Wcj+QLt3T7FAeYDW2hMO0arFqfUaPA1g76AWdQ5vYTZDO+y4mPdSmHOhaY43kg+b
FPe5WPOuY6267g7L3GoZnv3zY6/B0rqytSa4JYhEAkXiNtqg+JJC2kGk9OwQFpZB
wpf6EgeJHYA42NxXtnRM1ZFOSj7q0T5y2Dch+w4Td7vPp8JYmwoiVs04JJX8sXfk
RZqiiOs0207xmydjIrP5oymj+7d1LmCqCJd/C9DKYdDE9bTHSGg=
=iKJ7
-----END PGP SIGNATURE-----

--p2il7vkfavf2qb2o--
