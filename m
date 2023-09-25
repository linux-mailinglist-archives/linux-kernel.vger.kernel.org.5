Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF317AE29A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjIYXwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjIYXwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:52:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15E124;
        Mon, 25 Sep 2023 16:52:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E90EC433C8;
        Mon, 25 Sep 2023 23:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695685957;
        bh=+IaHrNrOxLOD1YS6ga2A3hF6ROVR2Bld68y96OWaFR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5+tF4bilx1bDbrjbn6CjV2Jqd8sexFYVppGHx6VERRComb8mTSbKMSa+s7qJb6m2
         FJD9Qg1j9hspw/4/DyBucE7S1ICBuZeEahGTp1I3Ej1iO+g+844hOO0hBJ8HsCvL2G
         743Ugzp9YtGG9hV+03SZ83ObmNqIMT8uYyVYTUBcdUhyyRCOLIZyMGrGM04+Cq2/Hd
         JLHBZZNS53F+L65kG1qH62Pqca9OlzZP+KW6ByUIW78xvnXDrAQ9/D92oU0x55F4fC
         8TiyY4WRpGsa9iKSweKnA1Y1jGBwiKsomM924syyCqWdCev8dLoNvrDwj7q4iINOIy
         GS3hc1yyhf3xw==
Date:   Tue, 26 Sep 2023 01:52:34 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] ioctl_userfaultfd.2: correct and update UFFDIO_API
 ioctl error codes
Message-ID: <5ddepg57wqnidtvsio2pse44dot6pvr3rcmhwld6ml3sflwcz3@ijd3h4teqblr>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-8-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sfquo6rq2unvsafx"
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-8-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sfquo6rq2unvsafx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 07/10] ioctl_userfaultfd.2: correct and update UFFDIO_API
 ioctl error codes
MIME-Version: 1.0

Hi Axel,

On Tue, Sep 19, 2023 at 12:02:03PM -0700, Axel Rasmussen wrote:
> First, it is not correct that repeated UFFDIO_API calls result in
> EINVAL. This is true *if both calls enable features*, but in the case
> where we're doing a two-step feature detection handshake, the kernel
> explicitly expects 2 calls (one with no features set). So, correct this
> description.
>=20
> Then, some new error cases have been added to the kernel recently, and
> the man page wasn't updated to note these. So, add in descriptions of
> these new error cases.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  man2/ioctl_userfaultfd.2 | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 53b1f473f..1aa9654be 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -280,17 +280,31 @@ refers to an address that is outside the calling pr=
ocess's
>  accessible address space.
>  .TP
>  .B EINVAL
> -The userfaultfd has already been enabled by a previous
> -.B UFFDIO_API
> -operation.
> -.TP
> -.B EINVAL
>  The API version requested in the
>  .I api
>  field is not supported by this kernel, or the
>  .I features
>  field passed to the kernel includes feature bits that are not supported
>  by the current kernel version.
> +.TP
> +.B EPERM

This EPERM should probably be at the end.  Unless you have a good reason
to break alphabetic order.

Thanks,
Alex

> +The
> +.B UFFD_FEATURE_EVENT_FORK
> +feature was enabled,
> +but the calling process doesn't have the
> +.B CAP_SYS_PTRACE
> +capability.
> +.TP
> +.B EINVAL
> +A previous
> +.B UFFDIO_API
> +call already enabled one or more features for this userfaultfd.
> +Calling
> +.B UFFDIO_API
> +twice,
> +the first time with no features set,
> +is explicitly allowed
> +as per the two-step feature detection handshake.
>  .\" FIXME In the above error case, the returned 'uffdio_api' structure is
>  .\" zeroed out. Why is this done? This should be explained in the manual=
 page.
>  .\"
> --=20
> 2.42.0.459.ge4e396fd5e-goog
>=20

--sfquo6rq2unvsafx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUSHUIACgkQnowa+77/
2zJvng/+MbsU5MfmXIe0erS8L+2Cfzvvt85W8o6bTu7AEasSaESg7NtFhZ6wyQSk
tJcmVIh4F9UeVBwvs77EOapbDrcZuw0MfExT66INr0bxhCcZDEar3sKW6V9IDMYf
EgOaB83nGebwIkIU0nQNCZoBwnlnlGhPygmOl10IFwdSYV+Q/hkUFOY/5vLlSvdI
/kOSyq1S7r99I5EydbmZRzxlYtGlCoIiL8PuFtZuDv1JzpxkqL9gFDHIkkINfEcG
MhmMLi00ERAgWA3QQcREXnx7wI39mWthNHPTXGxkpdIDTVFfWJQ6uJdLpPAblU6z
/bnmX1ESYvOxBv/JgXExFu6dTZ2IeqncdOjwWdwrF3+E8lTkaMC+6S24QLYO7OBx
PESaaXkSdAIkTg+sgQQSdDdWIJJKlh5b9f5fUMIZaUpMhWkf2D9xK2aqvfYUP7od
2wV8iLjO/AGH3jopaHX+91lablgztxQSwGegH6X83PQSGpy946farEiYU0CT7j3y
gUk8UY5p4g2OIJqvQoPEkvTeU+bx1aWwPNJ4YdrlQh5oQaVNlHSMzqa+HxONJ9G1
K8WFVJyoMpiryQf49Gpvp8MBzmlilNB1zox2mTx/cDqJJPwKt/qE1/0ON0xaLJ+i
gp2ra6xS4+a8EjbPLjfbFQSU7GBJJje8/yoxKB7nTVGwYEdomh8=
=I/3k
-----END PGP SIGNATURE-----

--sfquo6rq2unvsafx--
