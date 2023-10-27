Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A427D8D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbjJ0CLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0CLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:11:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42365187;
        Thu, 26 Oct 2023 19:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698372698;
        bh=L78u6ap4IGUMhTaeDopMfUlGi1+u64G74GttUwfHGC4=;
        h=Date:From:To:Cc:Subject:From;
        b=pspNjo0VUBXf1sFlBOxDrYRzea7YBDPoy7qWhgjrR/z36gEIGu9yENhTrmNvFDbOH
         R8+QYPHO3wb1cFwt4tbldu3A4Ab7SoYU9D5gpkgRzb2Oy+f1Lgh6p9ky7CA/RFmqw7
         ayOZQtIGYoVDWYH1eubptW/NJEKw0jxRFjAyoxIyuDKreLRA4g850ztGRVvvZu7qJ7
         YBej6iKRha2ysxEmqeWqS2dk05TSo37M/QI+uIk0t+Aca+QfCy9mHClhaQz51KaYda
         AAb12n3GVaxrazWpy7PLGxCmHhahc0xpDPdtqSydCcIDyqbEB6ncSDgAmtfSe4Th90
         cuTi8UzgY1Gdg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGmPQ1P7jz4wbh;
        Fri, 27 Oct 2023 13:11:37 +1100 (AEDT)
Date:   Fri, 27 Oct 2023 13:11:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: linux-next: manual merge of the integrity tree with the vfs-brauner
 tree
Message-ID: <20231027131137.3051da98@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TDUVDSA/+dZm.nsderLExk6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TDUVDSA/+dZm.nsderLExk6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the integrity tree got a conflict in:

  fs/overlayfs/super.c

between commit:

  2bc5e5e8167f ("ovl: rely on SB_I_NOUMASK")

from the vfs-brauner tree and commit:

  bc4532e9cd3b ("ima: detect changes to the backing overlay file")

from the integrity tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/overlayfs/super.c
index 1a95ee237fa9,c71d185980c0..000000000000
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@@ -1439,18 -1485,11 +1439,18 @@@ int ovl_fill_super(struct super_block *
  	cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
 =20
  	sb->s_magic =3D OVERLAYFS_SUPER_MAGIC;
 -	sb->s_xattr =3D ofs->config.userxattr ? ovl_user_xattr_handlers :
 -		ovl_trusted_xattr_handlers;
 +	sb->s_xattr =3D ovl_xattr_handlers(ofs);
  	sb->s_fs_info =3D ofs;
 +#ifdef CONFIG_FS_POSIX_ACL
  	sb->s_flags |=3D SB_POSIXACL;
 +#endif
- 	sb->s_iflags |=3D SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+ 	sb->s_iflags |=3D SB_I_SKIP_SYNC;
 +	/*
 +	 * Ensure that umask handling is done by the filesystems used
 +	 * for the the upper layer instead of overlayfs as that would
 +	 * lead to unexpected results.
 +	 */
 +	sb->s_iflags |=3D SB_I_NOUMASK;
 =20
  	err =3D -ENOMEM;
  	root_dentry =3D ovl_get_root(sb, ctx->upper.dentry, oe);

--Sig_/TDUVDSA/+dZm.nsderLExk6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU7HFkACgkQAVBC80lX
0Gx2EAf/ThJ94etqm5kPvaq7pnE0Q/0qH5SkHT+ZMKtplyK749RMLmYHCe+2Lp0k
VZJ+fmp3iRG5gWcY/wx/tzO1QZno/SkX7usCXbM9dII1jDLsHefI+rQ/9KEnTiIa
bWb199D9SZgeHFH05SKOHMldVbgDpha1JU2rg+OidOvkUgePa3VwmOAHoCFUuzdo
e34YYEH6KYUh9YpGDWzam7m87ikalIuWDgxIx3T6F85zflxN9sz9TzpXkJLmfVws
D9Xp0lKzap7dsU7JNXdd3SyPzaVF7Ma2F7FFqB5ubuU/fSUs0nwMNQKpGPdTgD6Y
xl8ICC7MeFcWkuq8iZti79ItRCsBtg==
=8Xfg
-----END PGP SIGNATURE-----

--Sig_/TDUVDSA/+dZm.nsderLExk6--
