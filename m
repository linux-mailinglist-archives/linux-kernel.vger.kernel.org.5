Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23697820EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 02:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjHUA0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 20:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjHUA0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 20:26:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE1BB9;
        Sun, 20 Aug 2023 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692577562;
        bh=tilGyKmXUXB5PsrKdXmYPuo1AvUG36XhXAx0IXZ/DJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HCCAr2xZ1BVfWAX1tyTLZGihRq5dA0YtSZQT3gKBmWefXjd9LoXcjBYpLzuAt13x0
         HV7U0QgmK+h+qt9o1GSHTqw9C89VwJcPFjH03dCjJhsnFWvnyI74uOXAsJ7BDr+V/i
         lvim59/UItrYFKlqBs5WkOCFgZ7l6K6ybF7beQC55rro3wqu7J5LX2yrDQ662HBo4V
         Dk5UrmNBVybq02KgKxzU508eEIkTgBROduvxY2V9EzPH6OK99e0x/AKv8mcfJxOlli
         Mb4veAlJEf6e4uR2owQNMht2M+5mzx1/baTyV/phKEICghZ/q4pvxJYYbyruOgqveK
         lcsvMConHThhQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTYDS5Xlrz4x2G;
        Mon, 21 Aug 2023 10:26:00 +1000 (AEST)
Date:   Mon, 21 Aug 2023 10:25:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhang Yi <yi.zhang@huawei.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the ext4
 tree
Message-ID: <20230821102559.35c8ef51@canb.auug.org.au>
In-Reply-To: <20230821100744.29d369c5@canb.auug.org.au>
References: <20230821100744.29d369c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jXL_8qb7tHO+H+cyD.iW=Ag";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jXL_8qb7tHO+H+cyD.iW=Ag
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I missed a bit ...

On Mon, 21 Aug 2023 10:07:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   fs/ext4/super.c
>=20
> between commit:
>=20
>   e89c6fc9b191 ("ext4: cleanup ext4_get_dev_journal() and ext4_get_journa=
l()")
>=20
> from the ext4 tree and commits:
>=20
>   1489dffd51d7 ("ext4: close the external journal device in ->kill_sb")
>   6f5fc7de9885 ("ext4: drop s_umount over opening the log device")

Also

  8bed1783751f ("ext4: use fs_holder_ops for the log device")

> from the vfs-brauner tree.
>=20
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ext4/super.c
index 1873de52c26e,73547d2334fd..34f5406c08da
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
- 				 &ext4_holder_ops);
++				 &fs_holder_ops);
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

--Sig_/jXL_8qb7tHO+H+cyD.iW=Ag
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTirxcACgkQAVBC80lX
0GzZTAgAonnQ5CkKXz6em/tTYYdDlwfraQ3yNBve0NWxC2HpZtE8aEDSfci5XgSK
8jP18bo5PFqJjweNLP0MVrjrs7x1W/1RPKJZtEIHArH9qV0sh2WM6w0ADmEtW5/A
QtK65uFTb/UlXiFNYtTZ5yayfPNSIbsMvkCsFKD+/PXE6q+bixH36U6ck/e/ISTL
7WKN5m43ocRrW/hwlkziAALjWfzq1t6G3AwSWvj9ot7+Zf2UStclfoinUQP/a8yd
0vQogRGezBNpKnvZbci1LXsYIz79xE/KBpe39IhKw+ahNRAKxIl6+l361mVXBih0
zD/S3ir66xv/BwK9BoA7iuj2T8HNXQ==
=WKvS
-----END PGP SIGNATURE-----

--Sig_/jXL_8qb7tHO+H+cyD.iW=Ag--
