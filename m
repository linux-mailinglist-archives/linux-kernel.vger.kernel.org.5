Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1527DC27D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjJ3Wae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3Wab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:30:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA9C6;
        Mon, 30 Oct 2023 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698705027;
        bh=0Of9tZvFowweJWV+CTG/WRqfnFIflVViNiJij/cINKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IlbgbVgNc6MgX1sde9uNof38MP+NGjUbcaMaYzFh6ukLgn7tYCl+vKeZrlmzz667x
         X79022OU3E+BWIi6XrG1PhvbUvUiQyfCeUqux0vTBEdVqD1o4jyHoU3KBo/WH+/n/o
         6qYwzvl7tkMoGrynSthiwiojBsh3Ll/pe2CzMbHgPedA9IYQpRWv/jQ3DpkMRN6HmI
         k63gQ/3Gu+0o9eM9lRD6FipQDv92G0zxu2eQlp6qM6Ktce4k4P0IeDp9L50AqpaHeY
         HftwUsFOkwv7bDQmZtteRRDzDE20icRuLOKQLOGkmHl+qOyRk3zmYiD/9UY4ke4cnK
         cF2f5C90juWFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SK7JL4VcWz4wc2;
        Tue, 31 Oct 2023 09:30:26 +1100 (AEDT)
Date:   Tue, 31 Oct 2023 09:30:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the mm
 tree
Message-ID: <20231031093024.41459c83@canb.auug.org.au>
In-Reply-To: <20230928102504.5c751249@canb.auug.org.au>
References: <20230928102504.5c751249@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A=gKF+pmu7kzhZ+KQC3sxpE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A=gKF+pmu7kzhZ+KQC3sxpE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 28 Sep 2023 10:25:04 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   fs/xfs/xfs_buf.c
>=20
> between commit:
>=20
>   5c7b459f9f1d ("xfs: dynamically allocate the xfs-buf shrinker")
>=20
> from the mm tree and commit:
>=20
>   176ccb99e207 ("xfs: Convert to bdev_open_by_path()")
>=20
> from the vfs-brauner tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/xfs/xfs_buf.c
> index 9e7ba04572db,003e157241da..000000000000
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@@ -1943,9 -1945,7 +1943,7 @@@ voi
>   xfs_free_buftarg(
>   	struct xfs_buftarg	*btp)
>   {
> - 	struct block_device	*bdev =3D btp->bt_bdev;
> -=20
>  -	unregister_shrinker(&btp->bt_shrinker);
>  +	shrinker_free(btp->bt_shrinker);
>   	ASSERT(percpu_counter_sum(&btp->bt_io_count) =3D=3D 0);
>   	percpu_counter_destroy(&btp->bt_io_count);
>   	list_lru_destroy(&btp->bt_lru);

This is now a conflict between the mm-stable tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/A=gKF+pmu7kzhZ+KQC3sxpE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVALoAACgkQAVBC80lX
0GweFAf/X6IJ8X0vn60BNOI0BSiXlyapEjmKkz5kSnRpTcP6PvZQaJ53AGjNU7xj
ZgShM00vIlx8j2mMtnFxJrhJobSk0aSIfRN/vFHXiXZquLE4C61A8K70rx7NiO5T
/APL7kBBB0LvgLLWr2BKZMjE/RaIbvS31P8moAmags7dHACRw07EGuz97vsKcTwf
EMqrUNMlYAOhtG/p3N2Yt0bDxFjc96UET8FFR+g++G7ZsX/F3QLbvLEZa3KgTr6Y
z7tnHjhLzx9t1i3nGnlQCATtnkAWVseNYxW6Yi8qFACIF2LghhGkUHfLygxPNYOm
fEEdM85hwDvStknLO68YRq8nT5PXlw==
=FxN2
-----END PGP SIGNATURE-----

--Sig_/A=gKF+pmu7kzhZ+KQC3sxpE--
