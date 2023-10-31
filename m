Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27C77DC392
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbjJaA0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbjJaA0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:26:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F885DD;
        Mon, 30 Oct 2023 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698711986;
        bh=1IePqRhmp+1YUFYLro87A5z7f9VYNCCPVr9wRpiz1SY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CpfZ/Bgj1mzWwMwsntJssHTZP4tGBA2jnp+syC7ilID2RNM3Mnz1Qu0orctA0F2yX
         P3Mj7f/f/xnSJxyNsMywkeXawcvEEQLjDVS64d5YcX5RFtspZDW0cWJ/nz7dB/TTBJ
         wu9qtKkSHrxZQvt1fpNhx7FGZvlcRdSDxLtiiMGJ4zqx/qTV6mc1GUFby+5neLpQ0H
         6dpF822dPUCvSiSK62SFr/Egy2lZ33WnabufmGJQuap9WjKVTW8M4Oi4uzDHy3f5/i
         +VXg4iNNCeA0hWI1YIY29bK3hVQxqh8jFd7jxoKUY53HVTkvKLsf6tNQd0+4HR5BDW
         kWAZMnD8QbrEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SK9tB07kcz4wd4;
        Tue, 31 Oct 2023 11:26:25 +1100 (AEDT)
Date:   Tue, 31 Oct 2023 11:26:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the ext3
 tree
Message-ID: <20231031112625.20c86e6f@canb.auug.org.au>
In-Reply-To: <20231027104356.3fda2bc9@canb.auug.org.au>
References: <20231027104356.3fda2bc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LG7MnJ4fZpzW=HFVvItzezV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LG7MnJ4fZpzW=HFVvItzezV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 Oct 2023 10:43:56 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   fs/ext2/dir.c
>=20
> between commits:
>=20
>   1de0736c3af9 ("ext2: Convert ext2_add_link() to use a folio")
>   7e56bbf15d95 ("ext2: Convert ext2_delete_entry() to use folios")
>   82dd620653b3 ("ext2: Convert ext2_prepare_chunk and ext2_commit_chunk t=
o folios")
>=20
> from the ext3 tree and commit:
>=20
>   5cdc59fce617 ("ext2: convert to new timestamp accessors")
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
> diff --cc fs/ext2/dir.c
> index 6807df637112,c7900868171b..000000000000
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@@ -463,9 -466,9 +463,9 @@@ int ext2_set_link(struct inode *dir, st
>   	}
>   	de->inode =3D cpu_to_le32(inode->i_ino);
>   	ext2_set_de_type(de, inode);
>  -	ext2_commit_chunk(page, pos, len);
>  +	ext2_commit_chunk(folio, pos, len);
>   	if (update_times)
> - 		dir->i_mtime =3D inode_set_ctime_current(dir);
> + 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>   	EXT2_I(dir)->i_flags &=3D ~EXT2_BTREE_FL;
>   	mark_inode_dirty(dir);
>   	return ext2_handle_dirsync(dir);
> @@@ -551,8 -554,8 +551,8 @@@ got_it
>   	memcpy(de->name, name, namelen);
>   	de->inode =3D cpu_to_le32(inode->i_ino);
>   	ext2_set_de_type (de, inode);
>  -	ext2_commit_chunk(page, pos, rec_len);
>  +	ext2_commit_chunk(folio, pos, rec_len);
> - 	dir->i_mtime =3D inode_set_ctime_current(dir);
> + 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>   	EXT2_I(dir)->i_flags &=3D ~EXT2_BTREE_FL;
>   	mark_inode_dirty(dir);
>   	err =3D ext2_handle_dirsync(dir);
> @@@ -605,8 -605,8 +605,8 @@@ int ext2_delete_entry(struct ext2_dir_e
>   	if (pde)
>   		pde->rec_len =3D ext2_rec_len_to_disk(to - from);
>   	dir->inode =3D 0;
>  -	ext2_commit_chunk(page, pos, to - from);
>  +	ext2_commit_chunk(folio, pos, to - from);
> - 	inode->i_mtime =3D inode_set_ctime_current(inode);
> + 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>   	EXT2_I(inode)->i_flags &=3D ~EXT2_BTREE_FL;
>   	mark_inode_dirty(inode);
>   	return ext2_handle_dirsync(inode);

This is now a conflict between the ext3 tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/LG7MnJ4fZpzW=HFVvItzezV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVASbEACgkQAVBC80lX
0GwtGAgAjAhatcpLEdk6kOJP5+j3FG7ZvkbMNGtuieYw+IbDnSRqPdmPm/4bZm0W
XzG/aw8xpHbMBSQ9jHsOnIrO9dwzaA4W/3aWSkVh5I9YIDSHpcZsW+iLsEGWAUnb
lFEXne7sbGjxdnc2hvkrYFgjpPpKAecc/GCe2uXNsZ+V01wSt71so5HUocRDO07+
q5SGhzFlEoCh7DoekujWoVZWYnwQYPc7E5kU8XujTnNCUfBiBtAaBUUoZiGoQXOw
vEqq4K9Irm8CajxlnoXFRoN0KsJCcehxybWN2kbJygjM8CgiCBaeCjBscuzpK0lL
1nAgfCj8VMiCXS7c/+QQFnpfXf9RQA==
=t8Hk
-----END PGP SIGNATURE-----

--Sig_/LG7MnJ4fZpzW=HFVvItzezV--
