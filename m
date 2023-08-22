Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF55784D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjHVXdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjHVXdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:33:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB1DCD2;
        Tue, 22 Aug 2023 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692747228;
        bh=q6j/KxtBlK4gZCeuVgntSaMDfxQEmnWvX0YkGGUDCAY=;
        h=Date:From:To:Cc:Subject:From;
        b=GUwF3YHg5chrxUcUnTKxJ3cuoPk9iwe8TGL2qF3qW2Q/tfDHxrezCJ4r7ZGUzdB3k
         mP8aZ4vop5aRrWpRAspAzO/4Us/TtnNfaojavKa5XoMHPikD5j2tnUneBbhT3B9Ctt
         maZ1YCS71Im2mCTYrikLAaYxODPhaIeJ5YD0Y6nDiNmgA4je33iHxI5EXeEDvc4UJh
         wdUsIy9bJhN0u7qNuudDdpRrgc+TvDB1piKzfBeOwNRd6OExyEJXMhUdpzmEL/YeJj
         N1d7YgXhdTz9+qsQ9aOye6Npxl/qfQ0QPe6MjRrLl/IxIHJv4aE5GHr5n7t16rVpGW
         YP6uoz4mgiYTQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVlzJ23cdz4wxn;
        Wed, 23 Aug 2023 09:33:48 +1000 (AEST)
Date:   Wed, 23 Aug 2023 09:33:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        David Chinner <david@fromorbit.com>
Cc:     <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the djw-vfs tree with the xfs tree
Message-ID: <20230823093347.775f3857@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xFkCDjDAs.qUiQTWOf8X9Td";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xFkCDjDAs.qUiQTWOf8X9Td
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the djw-vfs tree got a conflict in:

  fs/xfs/scrub/scrub.c

between commit:

  526aab5f5790 ("xfs: implement online scrubbing of rtsummary info")

from the xfs tree and commit:

  ce85a1e04645 ("xfs: stabilize fs summary counters for online fsck")

from the djw-vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/xfs/scrub/scrub.c
index e92129d74462,a0fffbcd022b..000000000000
--- a/fs/xfs/scrub/scrub.c
+++ b/fs/xfs/scrub/scrub.c
@@@ -178,16 -178,16 +178,18 @@@ xchk_teardown
  	}
  	if (sc->ip) {
  		if (sc->ilock_flags)
 -			xfs_iunlock(sc->ip, sc->ilock_flags);
 -		if (sc->ip !=3D ip_in &&
 -		    !xfs_internal_inum(sc->mp, sc->ip->i_ino))
 -			xchk_irele(sc, sc->ip);
 +			xchk_iunlock(sc, sc->ilock_flags);
 +		xchk_irele(sc, sc->ip);
  		sc->ip =3D NULL;
  	}
- 	if (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR)
+ 	if (sc->flags & XCHK_HAVE_FREEZE_PROT) {
+ 		sc->flags &=3D ~XCHK_HAVE_FREEZE_PROT;
  		mnt_drop_write_file(sc->file);
+ 	}
 +	if (sc->xfile) {
 +		xfile_destroy(sc->xfile);
 +		sc->xfile =3D NULL;
 +	}
  	if (sc->buf) {
  		if (sc->buf_cleanup)
  			sc->buf_cleanup(sc->buf);

--Sig_/xFkCDjDAs.qUiQTWOf8X9Td
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTlRdsACgkQAVBC80lX
0GyxZAf9FLxW8VzFXpiiWKWLD4grbiJxpnDi/04vF5nfRttt0ZDtPhKptY7DFxtU
zJM9YakVBUvF865qNcmTVkqU6UFHbEWTOmCf3RNVyWr0HdoJGhx5FUE5RsqAJqVc
Qa2azDfVYKmX7T6UZhgDR/OzRD5pDYyo1i8CcKOrwHsC46MCrm8iLZu3EzAQCVQg
txR6PEME6wgkGc/NbgOlI/9NSNumE+VTwLWicjPIUsmVqfvyxXPTbCZvAblejXq1
mHlkw7ICwNwY1EBNOiPsQ5hVnrPY+ie1dW6A2VTl/zTiiHa3V0nEmcJ38Z0cvBfm
JG3S1sK9/ivbHo7vPE/O3ScOZ1r+2g==
=iC7D
-----END PGP SIGNATURE-----

--Sig_/xFkCDjDAs.qUiQTWOf8X9Td--
