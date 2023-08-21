Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4582C7820C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 02:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjHUAH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 20:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjHUAHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 20:07:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04E9B;
        Sun, 20 Aug 2023 17:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692576468;
        bh=u8b0Y/3cE/m+rF/cr+BDg1nZiSptR7ceZIkn4pn7waU=;
        h=Date:From:To:Cc:Subject:From;
        b=ZcK5MqXJdfBKxa9MEL/OV+Vbwj2YxLegYoThIh0mUvLIV9dbf32ukEpnipVG5oEH7
         8GawgCh8PrjlE9x4fXrHf1t/0rJaQJS3uKdPrDb1oSFH4ZFEyl1dPsno21xRLNWX/H
         yu73A5mDO+LBOhbRGsDFNg+TJPlp3MHJPfFFBo1/jKvysYvG6fWVJulCRpxP97EDID
         ELTDSEcpK1DA9/EEW6ZFRoFLy1a3Q1GWHD3hgwYV95oZMYePzu/CdxsAa1g5snAhIf
         GscZ9p8NZr/fjt7I/eo4rXU/4jDv6uxlNHGwR/kh0+vPmt4su44QgYFqSjQu1ZbiuD
         HXU9hHie29uAw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTXqQ5hTqz4wxy;
        Mon, 21 Aug 2023 10:07:46 +1000 (AEST)
Date:   Mon, 21 Aug 2023 10:07:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhang Yi <yi.zhang@huawei.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the ext4 tree
Message-ID: <20230821100744.29d369c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1AFDpfDqZykOfPE5juSwsAl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1AFDpfDqZykOfPE5juSwsAl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/ext4/super.c

between commit:

  e89c6fc9b191 ("ext4: cleanup ext4_get_dev_journal() and ext4_get_journal(=
)")

from the ext4 tree and commits:

  1489dffd51d7 ("ext4: close the external journal device in ->kill_sb")
  6f5fc7de9885 ("ext4: drop s_umount over opening the log device")

from the vfs-brauner tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ext4/super.c
index 1873de52c26e,73547d2334fd..000000000000
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@@ -1096,34 -1097,26 +1097,6 @@@ void ext4_update_dynamic_rev(struct sup
  	 */
  }
 =20
- static void ext4_bdev_mark_dead(struct block_device *bdev)
- {
- 	ext4_force_shutdown(bdev->bd_holder, EXT4_GOING_FLAGS_NOLOGFLUSH);
- }
-=20
- static const struct blk_holder_ops ext4_holder_ops =3D {
- 	.mark_dead		=3D ext4_bdev_mark_dead,
- };
-=20
--/*
-  * Release the journal device
 - * Open the external journal device
-- */
- static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 -static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block=
 *sb)
--{
--	struct block_device *bdev;
- 	bdev =3D sbi->s_journal_bdev;
- 	if (bdev) {
- 		/*
- 		 * Invalidate the journal device's buffers.  We don't want them
- 		 * floating about in memory - the physical journal device may
- 		 * hotswapped, and it breaks the `ro-after' testing code.
- 		 */
- 		invalidate_bdev(bdev);
- 		blkdev_put(bdev, sbi->s_sb);
- 		sbi->s_journal_bdev =3D NULL;
- 	}
 -
 -	bdev =3D blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
 -				 &fs_holder_ops);
 -	if (IS_ERR(bdev))
 -		goto fail;
 -	return bdev;
 -
 -fail:
 -	ext4_msg(sb, KERN_ERR,
 -		 "failed to open journal device unknown-block(%u,%u) %ld",
 -		 MAJOR(dev), MINOR(dev), PTR_ERR(bdev));
 -	return NULL;
--}
--
  static inline struct inode *orphan_list_entry(struct list_head *l)
  {
  	return &list_entry(l, struct ext4_inode_info, i_orphan)->vfs_inode;
@@@ -5813,16 -5828,17 +5792,19 @@@ static struct block_device *ext4_get_jo
  	ext4_fsblk_t sb_block;
  	unsigned long offset;
  	struct ext4_super_block *es;
 -	struct block_device *bdev;
 -
 -	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
 -		return NULL;
 +	int errno;
 =20
+ 	/* see get_tree_bdev why this is needed and safe */
+ 	up_write(&sb->s_umount);
 -	bdev =3D ext4_blkdev_get(j_dev, sb);
 +	bdev =3D blkdev_get_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
 +				 &ext4_holder_ops);
+ 	down_write(&sb->s_umount);
 -	if (bdev =3D=3D NULL)
 -		return NULL;
 +	if (IS_ERR(bdev)) {
 +		ext4_msg(sb, KERN_ERR,
 +			 "failed to open journal device unknown-block(%u,%u) %ld",
 +			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev));
 +		return ERR_CAST(bdev);
 +	}
 =20
  	blocksize =3D sb->s_blocksize;
  	hblock =3D bdev_logical_block_size(bdev);

--Sig_/1AFDpfDqZykOfPE5juSwsAl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTiqtAACgkQAVBC80lX
0Gzq1ggAn+KYGrCUklj+r4loERXy2Jy8n1Bt04ZzsMHJZyuhTNczLEjFis/muC9r
/IQ8u0jdztI8fLhawWvyFUmpTxwuzMZMhFSsEz1LPYIKJcWJk4Lgq2xHwsEQ7MIH
FOZDGcbCF+G9SFcjDG//pLqGU6Oeyh1CmGcM1Vu+aD3RaHlyWdZ+aop0JuZj1vvj
WnTMzXWlaktvUOT5T8n4he5XaGnZdayrucJ0cKryFaS9AyMDhjMF0uwaIoGhv1Sg
VsOE/KH8U17kdqh5iZyx60CMgDduZ3iZZxQWFoBBcs+wcqNglkb0BD2O8Alyf80+
FHClyXN5e/pgB71/KU8CQs32XTXXsQ==
=3x62
-----END PGP SIGNATURE-----

--Sig_/1AFDpfDqZykOfPE5juSwsAl--
