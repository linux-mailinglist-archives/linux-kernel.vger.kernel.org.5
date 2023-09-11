Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CA079B2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350164AbjIKVf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjIKJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:54:38 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFABE4A;
        Mon, 11 Sep 2023 02:54:34 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 530691C001B; Mon, 11 Sep 2023 11:54:33 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:54:32 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 20/22] block: Allow bio_iov_iter_get_pages()
 with bio->bi_bdev unset
Message-ID: <ZP7j2MA5Qk6RBtAd@duo.ucw.cz>
References: <20230908193407.3463368-1-sashal@kernel.org>
 <20230908193407.3463368-20-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mgro0ZBFUl3WnbXi"
Content-Disposition: inline
In-Reply-To: <20230908193407.3463368-20-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mgro0ZBFUl3WnbXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Kent Overstreet <kent.overstreet@linux.dev>
>=20
> [ Upstream commit 168145f617d57bf4e474901b7ffa869337a802e6 ]
>=20
> bio_iov_iter_get_pages() trims the IO based on the block size of the
> block device the IO will be issued to.
>=20
> However, bcachefs is a multi device filesystem; when we're creating the
> bio we don't yet know which block device the bio will be submitted to -
> we have to handle the alignment checks elsewhere.
>=20
> Thus this is needed to avoid a null ptr deref.

We are certainly not going to backport bcachefs to -stable. Please
drop.

BR,
								Pavel

> +++ b/block/bio.c
> @@ -1198,7 +1198,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
>  	struct page **pages =3D (struct page **)bv;
>  	ssize_t size, left;
>  	unsigned len, i =3D 0;
> -	size_t offset, trim;
> +	size_t offset;
>  	int ret =3D 0;
> =20
>  	/*
> @@ -1223,10 +1223,12 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter)
> =20
>  	nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
> =20
> -	trim =3D size & (bdev_logical_block_size(bio->bi_bdev) - 1);
> -	iov_iter_revert(iter, trim);
> +	if (bio->bi_bdev) {
> +		size_t trim =3D size & (bdev_logical_block_size(bio->bi_bdev) - 1);
> +		iov_iter_revert(iter, trim);
> +		size -=3D trim;
> +	}
> =20
> -	size -=3D trim;
>  	if (unlikely(!size)) {
>  		ret =3D -EFAULT;
>  		goto out;

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mgro0ZBFUl3WnbXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7j2AAKCRAw5/Bqldv6
8mz6AKCZZhS+0D2XqgucZC4njE71u5Xh0QCgjUcobY5ycb9e+dRiZToamT8H+xQ=
=sgaa
-----END PGP SIGNATURE-----

--mgro0ZBFUl3WnbXi--
