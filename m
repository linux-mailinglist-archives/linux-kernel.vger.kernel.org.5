Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921D8752E46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjGNAZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 20:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGNAY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:24:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E7B7;
        Thu, 13 Jul 2023 17:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689294295;
        bh=ZTS627h4WMNjCWOzP3MLK0RMweGInem4XpdDyBIq//0=;
        h=Date:From:To:Cc:Subject:From;
        b=l5DKcJXeYke+n6b6c0Qe66/ixYSzCkGjiA+OYenB/KjD2aK3NcKYZ65ZRVNexVG7J
         GNQRwBtV5Z/lyviFx8loM4MoQ/gNEFSP2+LhNEPzsSa7PpveRlhqDY5ikn99/2UZWu
         RlTMnCgSL62TnQNuwtnIOrLxBZ8U4zbtf2Z94N1MMzJfWHbMwsshqG+vqduWTw0338
         +vruYj8cPSclbvIPZNiqq5SSGNVx68zvxqbQrnRFSJ+OmguATC5DBuULHtG8iMq75R
         9jldWHUfrtvp6k9oUz3qjf13qh6sCMX9/wGiHWe9kSZtw8fce/ibbPfd6aB4ViVqZW
         4MtbETJ1gfeSw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R2C0l0Gnpz4whq;
        Fri, 14 Jul 2023 10:24:55 +1000 (AEST)
Date:   Fri, 14 Jul 2023 10:24:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Carlos Maiolino <cem@kernel.org>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Czerner <lczerner@redhat.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the mm tree
Message-ID: <20230714102453.4399f059@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UOry.mrWJAqD+NOCCZero8/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UOry.mrWJAqD+NOCCZero8/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  mm/shmem.c

between commits:

  3c37c527bbf9 ("shmem: make shmem_get_inode() return ERR_PTR instead of NU=
LL")
  1a93dd24f1be ("shmem: quota support")

from the mm tree and commits:

  ad9717ca487a ("shmem: stable directory offsets")
  fa6c36fb3f24 ("shmem: convert to ctime accessor functions")

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

diff --cc mm/shmem.c
index c35717763dcc,310b0544eae3..000000000000
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@@ -2445,83 -2355,81 +2445,89 @@@ static void shmem_set_inode_flags(struc
  #define shmem_initxattrs NULL
  #endif
 =20
+ static struct offset_ctx *shmem_get_offset_ctx(struct inode *inode)
+ {
+ 	return &SHMEM_I(inode)->dir_offsets;
+ }
+=20
 -static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct supe=
r_block *sb,
 -				     struct inode *dir, umode_t mode, dev_t dev,
 -				     unsigned long flags)
 +static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 +					     struct super_block *sb,
 +					     struct inode *dir, umode_t mode,
 +					     dev_t dev, unsigned long flags)
  {
  	struct inode *inode;
  	struct shmem_inode_info *info;
  	struct shmem_sb_info *sbinfo =3D SHMEM_SB(sb);
  	ino_t ino;
 +	int err;
 +
 +	err =3D shmem_reserve_inode(sb, &ino);
 +	if (err)
 +		return ERR_PTR(err);
 =20
 -	if (shmem_reserve_inode(sb, &ino))
 -		return NULL;
 =20
  	inode =3D new_inode(sb);
 -	if (inode) {
 -		inode->i_ino =3D ino;
 -		inode_init_owner(idmap, inode, dir, mode);
 -		inode->i_blocks =3D 0;
 -		inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(inode);
 -		inode->i_generation =3D get_random_u32();
 -		info =3D SHMEM_I(inode);
 -		memset(info, 0, (char *)inode - (char *)info);
 -		spin_lock_init(&info->lock);
 -		atomic_set(&info->stop_eviction, 0);
 -		info->seals =3D F_SEAL_SEAL;
 -		info->flags =3D flags & VM_NORESERVE;
 -		info->i_crtime =3D inode->i_mtime;
 -		info->fsflags =3D (dir =3D=3D NULL) ? 0 :
 -			SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
 -		if (info->fsflags)
 -			shmem_set_inode_flags(inode, info->fsflags);
 -		INIT_LIST_HEAD(&info->shrinklist);
 -		INIT_LIST_HEAD(&info->swaplist);
 -		if (sbinfo->noswap)
 -			mapping_set_unevictable(inode->i_mapping);
 -		simple_xattrs_init(&info->xattrs);
 -		cache_no_acl(inode);
 -		mapping_set_large_folios(inode->i_mapping);
 =20
 -		switch (mode & S_IFMT) {
 -		default:
 -			inode->i_op =3D &shmem_special_inode_operations;
 -			init_special_inode(inode, mode, dev);
 -			break;
 -		case S_IFREG:
 -			inode->i_mapping->a_ops =3D &shmem_aops;
 -			inode->i_op =3D &shmem_inode_operations;
 -			inode->i_fop =3D &shmem_file_operations;
 -			mpol_shared_policy_init(&info->policy,
 -						 shmem_get_sbmpol(sbinfo));
 -			break;
 -		case S_IFDIR:
 -			inc_nlink(inode);
 -			/* Some things misbehave if size =3D=3D 0 on a directory */
 -			inode->i_size =3D 2 * BOGO_DIRENT_SIZE;
 -			inode->i_op =3D &shmem_dir_inode_operations;
 -			inode->i_fop =3D &simple_offset_dir_operations;
 -			simple_offset_init(shmem_get_offset_ctx(inode));
 -			break;
 -		case S_IFLNK:
 -			/*
 -			 * Must not load anything in the rbtree,
 -			 * mpol_free_shared_policy will not be called.
 -			 */
 -			mpol_shared_policy_init(&info->policy, NULL);
 -			break;
 -		}
 -
 -		lockdep_annotate_inode_mutex_key(inode);
 -	} else
 +	if (!inode) {
  		shmem_free_inode(sb);
 +		return ERR_PTR(-ENOSPC);
 +	}
 +
 +	inode->i_ino =3D ino;
 +	inode_init_owner(idmap, inode, dir, mode);
 +	inode->i_blocks =3D 0;
- 	inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(in=
ode);
++	inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(inode);
 +	inode->i_generation =3D get_random_u32();
 +	info =3D SHMEM_I(inode);
 +	memset(info, 0, (char *)inode - (char *)info);
 +	spin_lock_init(&info->lock);
 +	atomic_set(&info->stop_eviction, 0);
 +	info->seals =3D F_SEAL_SEAL;
 +	info->flags =3D flags & VM_NORESERVE;
 +	info->i_crtime =3D inode->i_mtime;
 +	info->fsflags =3D (dir =3D=3D NULL) ? 0 :
 +		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
 +	if (info->fsflags)
 +		shmem_set_inode_flags(inode, info->fsflags);
 +	INIT_LIST_HEAD(&info->shrinklist);
 +	INIT_LIST_HEAD(&info->swaplist);
 +	INIT_LIST_HEAD(&info->swaplist);
 +	if (sbinfo->noswap)
 +		mapping_set_unevictable(inode->i_mapping);
 +	simple_xattrs_init(&info->xattrs);
 +	cache_no_acl(inode);
 +	mapping_set_large_folios(inode->i_mapping);
 +
 +	switch (mode & S_IFMT) {
 +	default:
 +		inode->i_op =3D &shmem_special_inode_operations;
 +		init_special_inode(inode, mode, dev);
 +		break;
 +	case S_IFREG:
 +		inode->i_mapping->a_ops =3D &shmem_aops;
 +		inode->i_op =3D &shmem_inode_operations;
 +		inode->i_fop =3D &shmem_file_operations;
 +		mpol_shared_policy_init(&info->policy,
 +					 shmem_get_sbmpol(sbinfo));
 +		break;
 +	case S_IFDIR:
 +		inc_nlink(inode);
 +		/* Some things misbehave if size =3D=3D 0 on a directory */
 +		inode->i_size =3D 2 * BOGO_DIRENT_SIZE;
 +		inode->i_op =3D &shmem_dir_inode_operations;
- 		inode->i_fop =3D &simple_dir_operations;
++		inode->i_fop =3D &simple_offset_dir_operations;
++		simple_offset_init(shmem_get_offset_ctx(inode));
 +		break;
 +	case S_IFLNK:
 +		/*
 +		 * Must not load anything in the rbtree,
 +		 * mpol_free_shared_policy will not be called.
 +		 */
 +		mpol_shared_policy_init(&info->policy, NULL);
 +		break;
 +	}
 +
 +	lockdep_annotate_inode_mutex_key(inode);
  	return inode;
  }
 =20
@@@ -3203,30 -3075,30 +3209,33 @@@ shmem_mknod(struct mnt_idmap *idmap, st
  	    struct dentry *dentry, umode_t mode, dev_t dev)
  {
  	struct inode *inode;
 -	int error =3D -ENOSPC;
 +	int error;
 =20
  	inode =3D shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, VM_NORESERVE=
);
 -	if (inode) {
 -		error =3D simple_acl_create(dir, inode);
 -		if (error)
 -			goto out_iput;
 -		error =3D security_inode_init_security(inode, dir,
 -						     &dentry->d_name,
 -						     shmem_initxattrs, NULL);
 -		if (error && error !=3D -EOPNOTSUPP)
 -			goto out_iput;
 =20
 -		error =3D simple_offset_add(shmem_get_offset_ctx(dir), dentry);
 -		if (error)
 -			goto out_iput;
 +	if (IS_ERR(inode))
 +		return PTR_ERR(inode);
 =20
 -		dir->i_size +=3D BOGO_DIRENT_SIZE;
 -		dir->i_mtime =3D inode_set_ctime_current(dir);
 -		inode_inc_iversion(dir);
 -		d_instantiate(dentry, inode);
 -		dget(dentry); /* Extra count - pin the dentry in core */
 -	}
 +	error =3D simple_acl_create(dir, inode);
 +	if (error)
 +		goto out_iput;
 +	error =3D security_inode_init_security(inode, dir,
 +					     &dentry->d_name,
 +					     shmem_initxattrs, NULL);
 +	if (error && error !=3D -EOPNOTSUPP)
 +		goto out_iput;
 +
- 	error =3D 0;
++	error =3D simple_offset_add(shmem_get_offset_ctx(dir), dentry);
++	if (error)
++		goto out_iput;
++
 +	dir->i_size +=3D BOGO_DIRENT_SIZE;
- 	dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
++	dir->i_mtime =3D inode_set_ctime_current(dir);
 +	inode_inc_iversion(dir);
 +	d_instantiate(dentry, inode);
 +	dget(dentry); /* Extra count - pin the dentry in core */
  	return error;
 +
  out_iput:
  	iput(inode);
  	return error;

--Sig_/UOry.mrWJAqD+NOCCZero8/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSwldUACgkQAVBC80lX
0GwJuggApQnnJZyeEQTbLULEik8RAetfFB/ejdjqjmuYu7M++Qls3rRY/frNg5Im
YJcgrHx9bo03DWm5neHAEwe0BLM1KBB340k1zm2nNarF1z17AE3NYv2VDqWXEcTE
OHXqel4BZPFL5+X1t4hhd6zTKvLRNju+Kb+xKnEQo64dQKNTzg4oQ+ld0Ibjh0/Q
4ZbpRdU4fYs3Vn31LFdQnxLjKxfkEUxDQvz3MWpVLE7NfD9pX3XhvRnTEqeRGU5n
X7L7cF/AbRIY/j5e46mLmM4KbABcX78usK3H/m0gqXi7c92e+j2TjoKPaDHMrDZU
vHpkLfnlWcpZRp8MeLkZya/+u04Bqw==
=QTwM
-----END PGP SIGNATURE-----

--Sig_/UOry.mrWJAqD+NOCCZero8/--
