Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E447DC395
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjJaAYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjJaAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:24:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF0AA9;
        Mon, 30 Oct 2023 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698711880;
        bh=TeSlqjbE4T8/9w6BkWEqBi/or+R2Kb6ZESw56Zd+cJs=;
        h=Date:From:To:Cc:Subject:From;
        b=IT70Y4Cg+4n51qyl/qrwuCQ16hQPZPn5zQFYSlNUlZuBfwRPbeiGs7H1iDiGm57fu
         sjLqn6P/Cqvzk5dTlwv+MTkKuncylXPIIZL150jI95C28pZ7Mlmxk8FlhpR8NxTL8A
         cNFll7QbUYTagSgaJeOSJKqY4ofGZuz50Xy82BTb0Bw7tlKLDNNtDbEA3x/LZOGgvO
         pazuwfo9/r/DikXfZBKvaPYnzpbmwxBj6RNNInDUKh/RM49bxhVSrfLyMMfn+Dz3eY
         XIyrqPsH3hq/GvZ4OEbsookKzi5UTTeq8ryMIPKBxpP8kOWpjnjZ03k2GQ2dgZgt9C
         GExsoP5mBqEPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SK9r84Qyjz4wdD;
        Tue, 31 Oct 2023 11:24:40 +1100 (AEDT)
Date:   Tue, 31 Oct 2023 11:24:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jan Cincera <hcincera@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the exfat tree with Linus' tree
Message-ID: <20231031112439.00d4eeab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xINdbKI//+JJ_dwwrnG73YU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xINdbKI//+JJ_dwwrnG73YU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the exfat tree got conflicts in:

  fs/exfat/inode.c
  fs/exfat/super.c

between commit:

  4c72a36edd54 ("exfat: convert to new timestamp accessors")

from Linus' tree and commit:

  d76271feecc1 ("exfat: add ioctls for accessing attributes")

from the exfat tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/exfat/inode.c
index a2185e6f0548,edcd8a5c38d1..000000000000
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@@ -400,9 -397,9 +400,9 @@@ static int exfat_write_end(struct file=20
  	if (err < len)
  		exfat_write_failed(mapping, pos+len);
 =20
- 	if (!(err < 0) && !(ei->attr & ATTR_ARCHIVE)) {
+ 	if (!(err < 0) && !(ei->attr & EXFAT_ATTR_ARCHIVE)) {
 -		inode->i_mtime =3D inode_set_ctime_current(inode);
 +		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
- 		ei->attr |=3D ATTR_ARCHIVE;
+ 		ei->attr |=3D EXFAT_ATTR_ARCHIVE;
  		mark_inode_dirty(inode);
  	}
 =20
diff --cc fs/exfat/super.c
index e919a68bf4a1,e7cba540c99e..000000000000
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@@ -369,9 -376,9 +376,9 @@@ static int exfat_read_root(struct inod
  	ei->i_size_aligned =3D i_size_read(inode);
  	ei->i_size_ondisk =3D i_size_read(inode);
 =20
- 	exfat_save_attr(inode, ATTR_SUBDIR);
+ 	exfat_save_attr(inode, EXFAT_ATTR_SUBDIR);
 -	inode->i_mtime =3D inode->i_atime =3D ei->i_crtime =3D inode_set_ctime_c=
urrent(inode);
 -	exfat_truncate_atime(&inode->i_atime);
 +	ei->i_crtime =3D simple_inode_init_ts(inode);
 +	exfat_truncate_inode_atime(inode);
  	return 0;
  }
 =20

--Sig_/xINdbKI//+JJ_dwwrnG73YU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVASUcACgkQAVBC80lX
0GxXjgf/Qaekmx9BIZ+CoKewRPzaVB7VnHaLSxSVpT218lfT5V4nQaULgT8vm6/C
Ku8Pyx5VqrYRTRTgKq4ul6efon6hEWdgaEwyUWo0tbj077rg+k23fOAkHjcQgISq
TEFZxh7pMMH2RI+1uyvJ1GDlqd4WGwFokNmFI902kyRIb2Tde9bYSnZOM9CQyevj
yZmfOK3ZanQ8B7ZvxJZxiKqDnx3/BHasxyvTOG73CIsbOpyoHYUsGXBz7vfgkHl9
ftanceEhmlPNh/QwtjacpaW9182bSsVbZXnwIzCxab5WNYAYi43RSTeWmsRLS8h6
dNqOWVMPO+vyfqCCmjcvDQ+qy10H1w==
=2NYM
-----END PGP SIGNATURE-----

--Sig_/xINdbKI//+JJ_dwwrnG73YU--
