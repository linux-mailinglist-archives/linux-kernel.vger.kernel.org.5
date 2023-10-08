Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BD7BD0D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344814AbjJHWX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:23:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BEFA3;
        Sun,  8 Oct 2023 15:23:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27648C433C8;
        Sun,  8 Oct 2023 22:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696803804;
        bh=rkgdAawlIj34svqn91frk1NZL12cc28ZYOTA1wfaCcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glxiyO+hsm8tbiC1OrW0oAB8T0EvLvgfJv2ICJ3rEYrxuLUZdEHB360xVPeYdjhYm
         XpNu7CqSkAbCbVeTjStYSCXNY1YAF5NEoWrp1fGv48XeFQkaafQwK+B6YV7j0f7syY
         0lOL8WTzSEQQzZybDiWJOrs8Ed/ixvOvGNTdmorsBGErue+TeB1h1V/JR96bbt1kRU
         VQMxMSOGOksucDrQUfCwbHp4QXLoUj3LDJj0IvX/bMPK8tw/pRe4iCeCEuQn96/HBR
         oQGjQblKD0Uy/R9gUqGQZbJUQLc6zWZBps2yaLCIircawk5s+8E9NR0i499zLYn+jj
         JDL6y3HnqOvLQ==
Date:   Mon, 9 Oct 2023 00:23:20 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ioctl_userfaultfd.2: document new UFFDIO_POISON
 ioctl
Message-ID: <ZSMr2P031R6hbYCE@debian>
References: <20231003194547.2237424-1-axelrasmussen@google.com>
 <20231003194547.2237424-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Kfpe6wlbD0Pas4S"
Content-Disposition: inline
In-Reply-To: <20231003194547.2237424-6-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Kfpe6wlbD0Pas4S
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 9 Oct 2023 00:23:20 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ioctl_userfaultfd.2: document new UFFDIO_POISON
 ioctl

Hi Axel,

On Tue, Oct 03, 2023 at 12:45:47PM -0700, Axel Rasmussen wrote:
> This is a new feature recently added to the kernel. So, document the new
> ioctl the same way we do other UFFDIO_* ioctls.
>=20
> Also note the corresponding new ioctl flag we can return in reponse to a
> UFFDIO_REGISTER call.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  man2/ioctl_userfaultfd.2 | 112 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>=20
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 95d69f773..6b6980d4a 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -380,6 +380,11 @@ operation is supported.
>  The
>  .B UFFDIO_CONTINUE
>  operation is supported.
> +.TP
> +.B 1 << _UFFDIO_POISON
> +The
> +.B UFFDIO_POISON
> +operation is supported.
>  .PP
>  This
>  .BR ioctl (2)
> @@ -890,6 +895,113 @@ The faulting process has exited at the time of a
>  .B UFFDIO_CONTINUE
>  operation.
>  .\"
> +.SS UFFDIO_POISON
> +(Since Linux 6.6.)
> +Mark an address range as "poisoned".
> +Future accesses to these addresses will raise a
> +.B SIGBUS
> +signal.
> +Unlike
> +.B MADV_HWPOISON
> +this works by installing page table entries,
> +rather than "really" poisoning the underlying physical pages.
> +This means it only affects this particular address space.
> +.PP
> +The
> +.I argp
> +argument is a pointer to a
> +.I uffdio_continue
> +structure as shown below:
> +.PP
> +.in +4n
> +.EX
> +struct uffdio_poison {
> +	struct uffdio_range range;
> +	                /* Range to install poison PTE markers in */
> +	__u64 mode;     /* Flags controlling the behavior of poison */
> +	__s64 updated;  /* Number of bytes poisoned, or negated error */
> +};
> +.EE
> +.in
> +.PP
> +The following value may be bitwise ORed in
> +.I mode
> +to change the behavior of the
> +.B UFFDIO_POISON
> +operation:
> +.TP
> +.B UFFDIO_POISON_MODE_DONTWAKE
> +Do not wake up the thread that waits for page-fault resolution.
> +.PP
> +The
> +.I updated
> +field is used by the kernel
> +to return the number of bytes that were actually poisoned,
> +or an error in the same manner as
> +.BR UFFDIO_COPY .
> +If the value returned in the
> +.I updated
> +field doesn't match the value that was specified in
> +.IR range.len ,
> +the operation fails with the error
> +.BR EAGAIN .
> +The
> +.I updated
> +field is output-only;
> +it is not read by the
> +.B UFFDIO_POISON
> +operation.
> +.PP
> +This
> +.BR ioctl (2)
> +operation returns 0 on success.
> +In this case,
> +the entire area was poisoned.
> +On error, \-1 is returned and
> +.I errno
> +is set to indicate the error.
> +Possible errors include:
> +.TP
> +.B EAGAIN
> +The number of bytes mapped
> +(i.e., the value returned in the
> +.I updated
> +field)
> +does not equal the value that was specified in the
> +.I range.len
> +field.
> +.TP
> +.B EINVAL
> +Either
> +.I range.start
> +or
> +.I range.len
> +was not a multiple of the system page size; or
> +.I range.len
> +was zero; or the range specified was invalid.
> +.TP
> +.B EINVAL
> +An invalid bit was specified in the
> +.I mode
> +field.
> +.TP
> +.B EEXIST

Any reasons for this order, or should we use alphabetic order?

Thanks,
Alex

> +One or more pages were already mapped in the given range.
> +.TP
> +.B ENOENT
> +The faulting process has changed its virtual memory layout simultaneousl=
y with
> +an outstanding
> +.B UFFDIO_POISON
> +operation.
> +.TP
> +.B ENOMEM
> +Allocating memory for page table entries failed.
> +.TP
> +.B ESRCH
> +The faulting process has exited at the time of a
> +.B UFFDIO_POISON
> +operation.
> +.\"
>  .SH RETURN VALUE
>  See descriptions of the individual operations, above.
>  .SH ERRORS
> --=20
> 2.42.0.609.gbb76f46606-goog
>=20

--=20
<https://www.alejandro-colomar.es/>

--1Kfpe6wlbD0Pas4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUjK9gACgkQnowa+77/
2zLzhhAAiXf9jyMvFOnEEfGZOVXVvSOtaicOOLxPFLJE8QhanJrGTwQRTrB/qeKE
TWwYkm234QaEwZxg4CgYf7P8eIRZc8PbcxMXvQX1fnym4myW9TMBIpiZmn8DpFDZ
Mxfy/pKkoz5tAlL2/QsDSTs8RDq5P3qhSen+D772xbV5VwE+Vt9Ggqk/I0V7lV57
2KmE17L0l0WY/KLiUuqf3c3mGQjKsLfz0GDxBHVAx5/OXqQhv5FtJN935E8UeNpR
yyUyo0KBhyc6xAliOyPTRyukIuRhSqhilEESYZrtpWlVrisBLXKsF6JfLE8nwYVK
0u7TLCA3/vfCQF69ejtXIg/GE4IS/S3dr8KaDyXFiOWcR9p2xRu40UNEqBMsrCB3
5VvHbz4Ekc2stpABJ7VFhMcWl7mRhNopioqXfks2X6dUTfEvGfe6v/fzayjUjNHk
WuZMZWSfpqKRXh6yBdp2KTAmByZwPszrmZBEDWzM2rKuoL39ssshInKmnRgNfUyO
sWYMf7mvVTXw3Rgo/wPTTntsL4BzSKp3ErIf4g/+/SKCfOkjKg2Z6FIcAIIxar9P
7p1nBdhgNPWrBgCFEmfjkAR8eMpB068ORneFLpY+eAHGur4hQ9fdraK1nlgDEIr/
XKDX76jy1RSJ0JE1MSXJZGMJ5AzU+Vin23kCzzOdDfX87537ARY=
=zIMJ
-----END PGP SIGNATURE-----

--1Kfpe6wlbD0Pas4S--
