Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80487BD069
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbjJHVxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHVxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:53:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A369D;
        Sun,  8 Oct 2023 14:53:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE02C433C7;
        Sun,  8 Oct 2023 21:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696801980;
        bh=ej6qPerfgZFriLCt1FOJ2SBffAjDi+XhXPfeurlTIS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vo0lYbMxYE1jZbuGiDMltJMLV0Pgv2mgTDphI5PciHHC96mK4tZ9LAnJtnEMSoIx6
         02Kz4WKhsLlGWxkOe2/DYc/7ML0J2M9S9sPYwcqI1KZFZwawu/nKPJ1Xd0n6Yj3FIV
         BL/u4mtE++faoS2T1v0g8jsALK4LcdWFB8jys7vhryvQPKCIIa5/dESzOIGPT7tk1n
         OVl9cMubf+kMWfIeYVcmXwa4zZGLJImH0RvQbh7fEds5hYBc4C06WkWgGZlZxYWVlK
         fnjdHOSKMFFj3/DMkbpvGdHr5hbt64102ipxZZDzTBNkGSlsyf8YlrhIQ9IlV0FgP4
         fUYwADfGASApg==
Date:   Sun, 8 Oct 2023 23:52:56 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ioctl_userfaultfd.2: clarify the state of the
 uffdio_api structure on error
Message-ID: <ZSMkuf3g5hGk1Kjk@debian>
References: <20231003194547.2237424-1-axelrasmussen@google.com>
 <20231003194547.2237424-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q07TwbX2z1RRAfBB"
Content-Disposition: inline
In-Reply-To: <20231003194547.2237424-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q07TwbX2z1RRAfBB
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 8 Oct 2023 23:52:56 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ioctl_userfaultfd.2: clarify the state of the
 uffdio_api structure on error

Hi Axel,

On Tue, Oct 03, 2023 at 12:45:45PM -0700, Axel Rasmussen wrote:
> The old FIXME noted that the zeroing was done to differentiate the two
> EINVAL cases. It's possible something like this was true historically,
> but in current Linux we zero it in *both* EINVAL cases, so this is at
> least no longer true.
>=20
> After reading the code, I can't determine any clear reason why we zero
> it in some cases but not in others. So, some simple advice we can give
> userspace is: if an error occurs, treat the contents of the structure as
> unspecified. Just re-initialize it before retrying UFFDIO_API again.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  man2/ioctl_userfaultfd.2 | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 28dd2fcdd..2ee6a0532 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -248,6 +248,14 @@ operation returns 0 on success.
>  On error, \-1 is returned and
>  .I errno
>  is set to indicate the error.
> +If an error occurs,
> +the kernel may zero the provided
> +.I uffdio_api
> +structure.
> +The caller should treat its contents as unspecified,
> +and reinitialize it before re-attempting another
> +.B UFFDIO_API
> +call.
>  Possible errors include:
>  .TP
>  .B EFAULT
> @@ -281,14 +289,6 @@ feature was enabled,
>  but the calling process doesn't have the
>  .B CAP_SYS_PTRACE
>  capability.
> -.\" FIXME In the above error case, the returned 'uffdio_api' structure is
> -.\" zeroed out. Why is this done? This should be explained in the manual=
 page.
> -.\"
> -.\" Mike Rapoport:
> -.\"     In my understanding the uffdio_api
> -.\"     structure is zeroed to allow the caller
> -.\"     to distinguish the reasons for -EINVAL.
> -.\"

I've added Mike to the thread in case he wants to comment.

Thanks,
Alex

>  .SS UFFDIO_REGISTER
>  (Since Linux 4.3.)
>  Register a memory address range with the userfaultfd object.
> --=20
> 2.42.0.609.gbb76f46606-goog
>=20

--=20
<https://www.alejandro-colomar.es/>

--q07TwbX2z1RRAfBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUjJLgACgkQnowa+77/
2zIvAA/9GYOyYYlNERqW/yXmh5Tg3E/gssJaue4y2SGAdTQzuSiyqiRu41V1fUbX
381Ma4SrFvhgGwREJc0xucH/Nj+WsJT1JtgCXjJjkFhT3S7+m4XRZBx2jt/9Hnhq
49GZHokw2As9MHioJ6k5Q5plrUN5451KbHEPL4yuvk6jD7JfeY9DhXZy+Hftye4A
gxIPOweAaXUkWbVJQQeDFX0GtK8yY2VO9TkoNkPI0Ec1cJjIWAQ1w7i9cdW3VIw5
Uy3IzdqW3ovZ3dx1FrGKLrtM/3NaI00N0BzXKOQz3EZ8vfpzga57+YOK+SJEDZIm
AgJ5zNkJPl+5wpQRdCv1A51X8EoYO+ZiN418i9mClP9IhMNvczOTZ4tKUcMlXMJn
i69i/0AWFoecCCVZqe/g7KVg0IiJUUE4HblyfsAhOiqz4XhUw69uCfqtaKzBGG34
bxttfeqm2I2WWGBe/pluAg1I8uQtcCBhog7/J1Mz20LPbFxrGzz/jpWT5UVaxuJP
QivbRf0yxsLy/mzAC70Vm0P6JndrfXGr5nTvWunco7y5/SSagA9QDmYfmodgTliG
eQh0ghyYx+wf5EXmdNS02KqH4+GPXW9/3XtypNLy3oLIqimmDWIQE2LQ4/MRPq69
knb/wWn6LkwA2Ta0TFF7QHYKPtFzgpFi1eBYI3ySuqUlYkOGE5U=
=tpHy
-----END PGP SIGNATURE-----

--q07TwbX2z1RRAfBB--
