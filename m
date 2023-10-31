Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C377DC389
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjJaASs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbjJaASq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:18:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EACB3;
        Mon, 30 Oct 2023 17:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698711519;
        bh=SSWBNWsb7c7zs1jWr8xla2C0vOE4NNYy9+dLWpLpJUo=;
        h=Date:From:To:Cc:Subject:From;
        b=hQEZGycVkuiJHEKX/Am4aFwLqvAxLwJldYQVCw1TCF5rI9LF4BH63O2AymAQD9VDl
         bys2hTUKZhXeecxY6pfFUnihd8wYTNz3yfr7Q1NYQx6Vhel0FyDupUEgq+tfqjHE3Z
         oEQZ9u2Ez7HiOlluYCzdFZ+D08FtfIt/8fEaDxqkzfv43m4YlVI9gTMJ5e5JK0hnoQ
         hWTLrCVVJUwshQY3QdS8J1GmnPhv3IyQ4U9yO5B+I3GxLobotgTM5wKNyxGg2cFBCe
         ejfzt8c3ySIV0wVMUPlONnqKtBb5HzvSaVLAr7YpdbfZy9B1xYNUZ3itKhxoQ4YTyO
         /C3efDc4qufYA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SK9jB65Mnz4x1R;
        Tue, 31 Oct 2023 11:18:38 +1100 (AEDT)
Date:   Tue, 31 Oct 2023 11:18:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the btrfs tree with Linus' tree
Message-ID: <20231031111836.0ac433a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gWi202lvPM50NaZ=WqgHMHq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gWi202lvPM50NaZ=WqgHMHq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got conflicts in:

  fs/btrfs/file.c
  fs/btrfs/inode.c
  fs/btrfs/transaction.c

between commit:

  b1c38a1338c9 ("btrfs: convert to new timestamp accessors")

from Linus' tree and commits:

  8b9d032225be ("btrfs: remove redundant root argument from btrfs_update_in=
ode()")
  0a5d0dc55fcb ("btrfs: remove redundant root argument from btrfs_update_in=
ode_fallback()")
  8b9d032225be ("btrfs: remove redundant root argument from btrfs_update_in=
ode()")
  c6e8f898f56f ("btrfs: open code timespec64 in struct btrfs_inode")

from the btrfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/file.c
index 278a4ea651e1,92419cb8508a..000000000000
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@@ -2474,10 -2476,9 +2477,10 @@@ int btrfs_replace_file_extents(struct b
  		inode_inc_iversion(&inode->vfs_inode);
 =20
  		if (!extent_info || extent_info->update_times)
 -			inode->vfs_inode.i_mtime =3D inode_set_ctime_current(&inode->vfs_inode=
);
 +			inode_set_mtime_to_ts(&inode->vfs_inode,
 +					      inode_set_ctime_current(&inode->vfs_inode));
 =20
- 		ret =3D btrfs_update_inode(trans, root, inode);
+ 		ret =3D btrfs_update_inode(trans, inode);
  		if (ret)
  			break;
 =20
@@@ -2716,8 -2717,8 +2719,8 @@@ static int btrfs_punch_hole(struct fil
 =20
  	ASSERT(trans !=3D NULL);
  	inode_inc_iversion(inode);
 -	inode->i_mtime =3D inode_set_ctime_current(inode);
 +	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
- 	ret =3D btrfs_update_inode(trans, root, BTRFS_I(inode));
+ 	ret =3D btrfs_update_inode(trans, BTRFS_I(inode));
  	updated_inode =3D true;
  	btrfs_end_transaction(trans);
  	btrfs_btree_balance_dirty(fs_info);
diff --cc fs/btrfs/inode.c
index 6e3ce1aecb6e,b388505c91cc..000000000000
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@@ -3922,24 -3928,22 +3928,22 @@@ static void fill_inode_item(struct btrf
  	btrfs_set_token_inode_nlink(&token, item, inode->i_nlink);
 =20
  	btrfs_set_token_timespec_sec(&token, &item->atime,
 -				     inode->i_atime.tv_sec);
 +				     inode_get_atime_sec(inode));
  	btrfs_set_token_timespec_nsec(&token, &item->atime,
 -				      inode->i_atime.tv_nsec);
 +				      inode_get_atime_nsec(inode));
 =20
  	btrfs_set_token_timespec_sec(&token, &item->mtime,
 -				     inode->i_mtime.tv_sec);
 +				     inode_get_mtime_sec(inode));
  	btrfs_set_token_timespec_nsec(&token, &item->mtime,
 -				      inode->i_mtime.tv_nsec);
 +				      inode_get_mtime_nsec(inode));
 =20
  	btrfs_set_token_timespec_sec(&token, &item->ctime,
 -				     inode_get_ctime(inode).tv_sec);
 +				     inode_get_ctime_sec(inode));
  	btrfs_set_token_timespec_nsec(&token, &item->ctime,
 -				      inode_get_ctime(inode).tv_nsec);
 +				      inode_get_ctime_nsec(inode));
 =20
- 	btrfs_set_token_timespec_sec(&token, &item->otime,
- 				     BTRFS_I(inode)->i_otime.tv_sec);
- 	btrfs_set_token_timespec_nsec(&token, &item->otime,
- 				      BTRFS_I(inode)->i_otime.tv_nsec);
+ 	btrfs_set_token_timespec_sec(&token, &item->otime, BTRFS_I(inode)->i_oti=
me_sec);
+ 	btrfs_set_token_timespec_nsec(&token, &item->otime, BTRFS_I(inode)->i_ot=
ime_nsec);
 =20
  	btrfs_set_token_inode_nbytes(&token, item, inode_get_bytes(inode));
  	btrfs_set_token_inode_generation(&token, item,
@@@ -4132,8 -4135,9 +4135,8 @@@ err
  	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
  	inode_inc_iversion(&inode->vfs_inode);
  	inode_inc_iversion(&dir->vfs_inode);
 -	inode_set_ctime_current(&inode->vfs_inode);
 -	dir->vfs_inode.i_mtime =3D inode_set_ctime_current(&dir->vfs_inode);
 + 	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vf=
s_inode));
- 	ret =3D btrfs_update_inode(trans, root, dir);
+ 	ret =3D btrfs_update_inode(trans, dir);
  out:
  	return ret;
  }
@@@ -4305,8 -4309,8 +4308,8 @@@ static int btrfs_unlink_subvol(struct b
 =20
  	btrfs_i_size_write(dir, dir->vfs_inode.i_size - fname.disk_name.len * 2);
  	inode_inc_iversion(&dir->vfs_inode);
 -	dir->vfs_inode.i_mtime =3D inode_set_ctime_current(&dir->vfs_inode);
 +	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs=
_inode));
- 	ret =3D btrfs_update_inode_fallback(trans, root, dir);
+ 	ret =3D btrfs_update_inode_fallback(trans, dir);
  	if (ret)
  		btrfs_abort_transaction(trans, ret);
  out:
@@@ -5583,6 -5586,6 +5586,7 @@@ static struct inode *new_simple_dir(str
  				    struct btrfs_root *root)
  {
  	struct inode *inode =3D new_inode(dir->i_sb);
++	struct timespec64 mtime;
 =20
  	if (!inode)
  		return ERR_PTR(-ENOMEM);
@@@ -5600,9 -5603,10 +5604,11 @@@
  	inode->i_opflags &=3D ~IOP_XATTR;
  	inode->i_fop =3D &simple_dir_operations;
  	inode->i_mode =3D S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
 -	inode->i_mtime =3D inode_set_ctime_current(inode);
 -	inode->i_atime =3D dir->i_atime;
 -	BTRFS_I(inode)->i_otime_sec =3D inode->i_mtime.tv_sec;
 -	BTRFS_I(inode)->i_otime_nsec =3D inode->i_mtime.tv_nsec;
 +	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 +	inode_set_atime_to_ts(inode, inode_get_atime(dir));
- 	BTRFS_I(inode)->i_otime =3D inode_get_mtime(inode);
++	mtime =3D inode_get_mtime(inode);
++	BTRFS_I(inode)->i_otime_sec =3D mtime.tv_sec;
++	BTRFS_I(inode)->i_otime_nsec =3D mtime.tv_nsec;
  	inode->i_uid =3D dir->i_uid;
  	inode->i_gid =3D dir->i_gid;
 =20
@@@ -6173,6 -6177,6 +6179,7 @@@ int btrfs_create_new_inode(struct btrfs
  	struct btrfs_key key[2];
  	u32 sizes[2];
  	struct btrfs_item_batch batch;
++	struct timespec64 otime;
  	unsigned long ptr;
  	int ret;
 =20
@@@ -6277,8 -6281,10 +6284,10 @@@
  		goto discard;
  	}
 =20
 -	inode->i_mtime =3D inode_set_ctime_current(inode);
 -	inode->i_atime =3D inode->i_mtime;
 -	BTRFS_I(inode)->i_otime_sec =3D inode->i_mtime.tv_sec;
 -	BTRFS_I(inode)->i_otime_nsec =3D inode->i_mtime.tv_nsec;
 +	simple_inode_init_ts(inode);
- 	BTRFS_I(inode)->i_otime =3D inode_get_mtime(inode);
++	otime =3D inode_get_mtime(inode);
++	BTRFS_I(inode)->i_otime_sec =3D otime.tv_sec;
++	BTRFS_I(inode)->i_otime_nsec =3D otime.tv_nsec;
 =20
  	/*
  	 * We're going to fill the inode item now, so at this point the inode
@@@ -6443,10 -6449,10 +6452,10 @@@ int btrfs_add_link(struct btrfs_trans_h
  	 * values (the ones it had when the fsync was done).
  	 */
  	if (!test_bit(BTRFS_FS_LOG_RECOVERING, &root->fs_info->flags))
 -		parent_inode->vfs_inode.i_mtime =3D
 -			inode_set_ctime_current(&parent_inode->vfs_inode);
 +		inode_set_mtime_to_ts(&parent_inode->vfs_inode,
 +				      inode_set_ctime_current(&parent_inode->vfs_inode));
 =20
- 	ret =3D btrfs_update_inode(trans, root, parent_inode);
+ 	ret =3D btrfs_update_inode(trans, parent_inode);
  	if (ret)
  		btrfs_abort_transaction(trans, ret);
  	return ret;
diff --cc fs/btrfs/transaction.c
index 38a2775c5c7b,9694a3ca1739..000000000000
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@@ -1860,9 -1911,8 +1911,9 @@@ static noinline int create_pending_snap
 =20
  	btrfs_i_size_write(BTRFS_I(parent_inode), parent_inode->i_size +
  						  fname.disk_name.len * 2);
 -	parent_inode->i_mtime =3D inode_set_ctime_current(parent_inode);
 +	inode_set_mtime_to_ts(parent_inode,
 +			      inode_set_ctime_current(parent_inode));
- 	ret =3D btrfs_update_inode_fallback(trans, parent_root, BTRFS_I(parent_i=
node));
+ 	ret =3D btrfs_update_inode_fallback(trans, BTRFS_I(parent_inode));
  	if (ret) {
  		btrfs_abort_transaction(trans, ret);
  		goto fail;

--Sig_/gWi202lvPM50NaZ=WqgHMHq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVAR9wACgkQAVBC80lX
0GxZoAf9GRhjnqzD32tkLtFJs9vKjtt/skhPKvn6MG9oM3J725h/tmhF5s4K3atm
r90Q1om1LUZocAVzd3g1MDnF+HQJQZAiD2axpHJDI6daPbQA4QZKN6X6UhDUtx+q
MmiaGECIxfEXQtM1BRW1VmNY7tbGz9Rk5+Hr7MFCUQqE+X46Y2yAc+bgieG2jJvB
t0ujXSFJsZRT2GjJ2uo9iI6doNQTtYvZfcRJEyyL/HWyr46HhJ5YOViPglTV3Ueq
0i44GfDbEeNzsboEnjAGCvyntWEZTqeV2HNxHBoorbDMlftMwMKQxjmJQJg+Ymqd
6+rI+UwuJNdo/49oWp6xZLBM4v7GGw==
=r+qD
-----END PGP SIGNATURE-----

--Sig_/gWi202lvPM50NaZ=WqgHMHq--
