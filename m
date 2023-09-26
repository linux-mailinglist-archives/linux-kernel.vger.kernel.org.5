Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC57AE2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIZAZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZAY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:24:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C4F109;
        Mon, 25 Sep 2023 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695687887;
        bh=pSvZ/NDtT7o0Drx+hp/96icidCkoEPNzZVGN6gpyl14=;
        h=Date:From:To:Cc:Subject:From;
        b=rVFAUQZaTXU9BP04EctQ7WkQYV2DI3s/1T/no+YB4AgJDGu5ORgCV0Fa4PTNqJW0U
         xw3L8dLY48y75ejKNrtsO2aSBqK3yJo0PHKNty/tZ1+n3CTZ9Wzil1aqM5HsE9CSk3
         vK+Yk4yb2VXAoj85yB8CzntufW6qgwjMoZZx8pOlmGGypgbKj7780M9SaVfesxlH6/
         Wd7PoGramFsg/0GGBEq09gNwVZKc128VHGrehcuKF/7fWeDsTEkfL86065visMct6O
         55hyL8faueGT+FeLUjlsmeA7OwKsAx2hEyUzWhoyD3XnBY7wWZh1VS4b2cawe6WEeL
         3ENvnI0nJr2gg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RvgVQ0M2Bz4xM0;
        Tue, 26 Sep 2023 10:24:46 +1000 (AEST)
Date:   Tue, 26 Sep 2023 10:24:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the overlayfs
 tree
Message-ID: <20230926102444.096ce797@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CdGo+u/gTaxd1lgwMfNHq=5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CdGo+u/gTaxd1lgwMfNHq=5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/overlayfs/file.c

between commit:

  f8f29a49ec21 ("ovl: move ovl_file_accessed() to aio completion")
  e57757c5d874 ("ovl: use simpler function to convert iocb to rw flags")

from the overlayfs tree and commit:

  2d1b3bbc3dd5 ("ovl: disable IOCB_DIO_CALLER_COMP")

from the vfs-brauner tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/overlayfs/file.c
index 05ec614f7054,693971d20280..000000000000
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@@ -398,16 -389,22 +398,22 @@@ static ssize_t ovl_write_iter(struct ki
  		goto out_fdput;
 =20
  	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
 -		ifl &=3D ~(IOCB_DSYNC | IOCB_SYNC);
 +		flags &=3D ~(IOCB_DSYNC | IOCB_SYNC);
 =20
+ 	/*
+ 	 * Overlayfs doesn't support deferred completions, don't copy
+ 	 * this property in case it is set by the issuer.
+ 	 */
 -	ifl &=3D ~IOCB_DIO_CALLER_COMP;
++	flags &=3D ~IOCB_DIO_CALLER_COMP;
+=20
 -	old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
 +	old_cred =3D ovl_override_creds(inode->i_sb);
  	if (is_sync_kiocb(iocb)) {
 +		rwf_t rwf =3D iocb_to_rw_flags(flags);
 +
  		file_start_write(real.file);
 -		ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos,
 -				     ovl_iocb_to_rwf(ifl));
 +		ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos, rwf);
  		file_end_write(real.file);
 -		/* Update size */
 -		ovl_copyattr(inode);
 +		ovl_rw_complete(iocb);
  	} else {
  		struct ovl_aio_req *aio_req;
 =20

--Sig_/CdGo+u/gTaxd1lgwMfNHq=5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSJMwACgkQAVBC80lX
0GwzZwf9GA6CtWHhz1ChbDxw3n28GvANbI/wCb7+NvA6f1m2mt0jLxyf0Az4/vgh
Bk95/p3XWRpoVXDFG6TfGcpMs+atHeZvpABUCC5ywLqiXkdYQ9eIIhRbH+TxNmNO
KzuWUuJYxGlyYfTD6SZeNq7pQWvXZ1NFNzAYcAF1TiqUJJPZI4FnWlnYNVFBFjAH
oT4IE2ztUrmQhr+zPyeCT/3h22hJ4XA2vxoQhajknvzwQnl3q29xk5G4v6iXD+Nw
Srjuw/4+Jog1AgsYgAQZ9HtzkoCtldzayfSdHD/IdB5rkt3cEDMdgx2DGVERb0YM
2sUh2PCPkJQdA4oXUdCreSsP8xiFvw==
=Dc45
-----END PGP SIGNATURE-----

--Sig_/CdGo+u/gTaxd1lgwMfNHq=5--
