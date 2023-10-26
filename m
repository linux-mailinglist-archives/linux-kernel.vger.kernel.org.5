Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F87D8C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjJZXoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:44:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2211A5;
        Thu, 26 Oct 2023 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698363839;
        bh=9AxyxxmHXdbO5SNsKyyhZSNxBDzNn97yGu6BGF+CUgM=;
        h=Date:From:To:Cc:Subject:From;
        b=I6JrqRh5Pr63FZUzHpJRqPcbEDwJjSRJ649/Ldpb94Uqgpv4eS8geM2IZosgQNBMo
         K78Kvc2bt+QLakq/PRo5SbVjJ6vSytFnEidHExLeohyYMNpVHvL1Rnq7v4KIFuPWME
         kzHwR4drbzfdopjrO1scA585Gj8LqPhGM1o4ZAuy7XcAw2VucE9v21CNdFeg8r18qB
         tnVVRCZugUNym5YLpmtWK8twNutlL7vHe99Ed5+bgE2z2baaB5iWd6nEHYqGPP5AV2
         7B19GC2nZGcNgj6Lcdoiw6KOyy6y6Qu4QtnHBm4VSyuI9eMI3IZppPDxoVVrYH3p0L
         8oCveFMlITBeA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGj722xnQz4wcJ;
        Fri, 27 Oct 2023 10:43:58 +1100 (AEDT)
Date:   Fri, 27 Oct 2023 10:43:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the ext3 tree
Message-ID: <20231027104356.3fda2bc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1gttALp7lCzLNJrtvkxRZ9u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1gttALp7lCzLNJrtvkxRZ9u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/ext2/dir.c

between commits:

  1de0736c3af9 ("ext2: Convert ext2_add_link() to use a folio")
  7e56bbf15d95 ("ext2: Convert ext2_delete_entry() to use folios")
  82dd620653b3 ("ext2: Convert ext2_prepare_chunk and ext2_commit_chunk to =
folios")

from the ext3 tree and commit:

  5cdc59fce617 ("ext2: convert to new timestamp accessors")

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

diff --cc fs/ext2/dir.c
index 6807df637112,c7900868171b..000000000000
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@@ -463,9 -466,9 +463,9 @@@ int ext2_set_link(struct inode *dir, st
  	}
  	de->inode =3D cpu_to_le32(inode->i_ino);
  	ext2_set_de_type(de, inode);
 -	ext2_commit_chunk(page, pos, len);
 +	ext2_commit_chunk(folio, pos, len);
  	if (update_times)
- 		dir->i_mtime =3D inode_set_ctime_current(dir);
+ 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
  	EXT2_I(dir)->i_flags &=3D ~EXT2_BTREE_FL;
  	mark_inode_dirty(dir);
  	return ext2_handle_dirsync(dir);
@@@ -551,8 -554,8 +551,8 @@@ got_it
  	memcpy(de->name, name, namelen);
  	de->inode =3D cpu_to_le32(inode->i_ino);
  	ext2_set_de_type (de, inode);
 -	ext2_commit_chunk(page, pos, rec_len);
 +	ext2_commit_chunk(folio, pos, rec_len);
- 	dir->i_mtime =3D inode_set_ctime_current(dir);
+ 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
  	EXT2_I(dir)->i_flags &=3D ~EXT2_BTREE_FL;
  	mark_inode_dirty(dir);
  	err =3D ext2_handle_dirsync(dir);
@@@ -605,8 -605,8 +605,8 @@@ int ext2_delete_entry(struct ext2_dir_e
  	if (pde)
  		pde->rec_len =3D ext2_rec_len_to_disk(to - from);
  	dir->inode =3D 0;
 -	ext2_commit_chunk(page, pos, to - from);
 +	ext2_commit_chunk(folio, pos, to - from);
- 	inode->i_mtime =3D inode_set_ctime_current(inode);
+ 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
  	EXT2_I(inode)->i_flags &=3D ~EXT2_BTREE_FL;
  	mark_inode_dirty(inode);
  	return ext2_handle_dirsync(inode);

--Sig_/1gttALp7lCzLNJrtvkxRZ9u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU6+bwACgkQAVBC80lX
0GxqoAf9ECxr/N3mWIhN5Di+UAAU2GuJ02GkTu5zSppn8CBtag7Ks0jJECQCj3Wy
ZczUxNNLuLqyz4lRrGduIVbgplWal16kjdV3mdIH01mZV5dWPKX5OW3y8uRajWZh
Woyalhm6OiDAEPBZhu06egQt/T1vsrhyIKCdaZGzJTVnEWc8DqqhAWCXj8f7Ms39
NzDyyWHm7wEIpTqWYyUsx/wIH3q6e4F+thullQPSTyAy8cazH1U2AoBWXwiK5EM+
rkw+t7KLH4vczRtG030iOo4TdsOg7poMiVgvYssMN+dhjlG8T/OzKA67bAZKbH41
EHNh6TjQQBBSdNgQq9UdBBmaRtwH1Q==
=KNbG
-----END PGP SIGNATURE-----

--Sig_/1gttALp7lCzLNJrtvkxRZ9u--
