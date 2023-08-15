Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAD077C51A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjHOBam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjHOBaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:30:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A948D1981;
        Mon, 14 Aug 2023 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692063015;
        bh=a7CqvDGi+e0s7j+oHUzDvydX0JI5ANvFzQi/BkcBQaU=;
        h=Date:From:To:Cc:Subject:From;
        b=q/HNMu6MNVpQCd0EAypLllEjYquYU7xqX7gYr3CqFObosd1LabGPXVolhCxaYScsa
         WOqTBhRtV6nThpFmfJsuQ+yKMrBiPQ7PnN5ykYoV2wcZ0AWu1A+XKu4PEUo42+UTOt
         h1RQWPEd4FOP+hlWJsZVb6aiNTyZLW1MNjV+s+ZQT7a/hdIhkR9OVHQ1XMoL1i7aLQ
         QWBsJKiuMe+hKB5zMfleBkhsssiTe0uu1LXcrRy+s7NhnXhuDDODLjjW5o3CL+ZDYy
         UmwIjbLrLEVtkFOGgPL2LXzeyN6gEaJQX6P0yC6flYVbmrw6LgC2mLd9oDwLnnSuHu
         MWj7bO/hDGfWQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPtxL4j43z4wqX;
        Tue, 15 Aug 2023 11:30:14 +1000 (AEST)
Date:   Tue, 15 Aug 2023 11:30:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the f2fs tree
Message-ID: <20230815113013.40cbf98a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KKtQ4DEIByincX7+rxMJmbW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KKtQ4DEIByincX7+rxMJmbW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/f2fs/super.c

between commit:

  51bf8d3c8199 ("f2fs: don't reopen the main block device in f2fs_scan_devi=
ces")

from the f2fs tree and commit:

  2ea6f68932f7 ("fs: use the super_block as holder when mounting file syste=
ms")

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

diff --cc fs/f2fs/super.c
index a067466a694c,aa1f9a3a8037..000000000000
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@@ -1561,8 -1561,7 +1561,8 @@@ static void destroy_device_list(struct=20
  	int i;
 =20
  	for (i =3D 0; i < sbi->s_ndevs; i++) {
 -		blkdev_put(FDEV(i).bdev, sbi->sb);
 +		if (i > 0)
- 			blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
++			blkdev_put(FDEV(i).bdev, sbi->sb);
  #ifdef CONFIG_BLK_DEV_ZONED
  		kvfree(FDEV(i).blkz_seq);
  #endif
@@@ -4218,9 -4215,9 +4218,9 @@@ static int f2fs_scan_devices(struct f2f
  				FDEV(i).end_blk =3D FDEV(i).start_blk +
  					(FDEV(i).total_segments <<
  					sbi->log_blocks_per_seg) - 1;
 +				FDEV(i).bdev =3D blkdev_get_by_path(FDEV(i).path,
- 					mode, sbi->sb->s_type, NULL);
++					mode, sbi->sb, NULL);
  			}
 -			FDEV(i).bdev =3D blkdev_get_by_path(FDEV(i).path, mode,
 -							  sbi->sb, NULL);
  		}
  		if (IS_ERR(FDEV(i).bdev))
  			return PTR_ERR(FDEV(i).bdev);

--Sig_/KKtQ4DEIByincX7+rxMJmbW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa1SUACgkQAVBC80lX
0GzGCwf/RKY0vW/CTPN3FjVvHzxwtqEb4wA/WZy04tqSEel2jdvXwpdxwJqAGQAz
gqfsKsMZCCdP1rt0EJ8mdbZ2fylGfuLoY0W8S0H2rzsJTBqWJ+XxO9US00kh7ZOv
O8SkzA9kKXVJybV2tttXFMLL/W7tSvR95Ndy3slbgiVhr2BosEl3hkr0txfVscuB
CH/R78ZZN+R1ARLL+qDx5G+cGf4dRWkSe3tDFRefVuAN+xyhzfrAk7t8rMvai4Le
ZvpWzUXroAukSIJj3x5yhmnlTKnePRcTrSURIT4mPB0Qli2akK5KKX05DottYNVq
1bMuyc+DsTVfLBx9f7a0bICmeIohwA==
=rTcP
-----END PGP SIGNATURE-----

--Sig_/KKtQ4DEIByincX7+rxMJmbW--
