Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E44277C520
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjHOBe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjHOBeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:34:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2D9172C;
        Mon, 14 Aug 2023 18:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692063238;
        bh=dwQujICpAToHOIaSEj3kUnz20q8NG5o+A+iPqaTqq2E=;
        h=Date:From:To:Cc:Subject:From;
        b=e8l89W0NaX9NIdOeChc3codQ6zTVMKJCFxr2pwd2y0xXuZI5H4b4cLXrAfj0UUrWC
         UfdJzcSb3DcMSqI8cNWPUHNRXDUKLlA8zPMIbPVHG3WJZetxYBcdl3fksfm9muXqns
         OtWGfM9M05AxyTIej6cBLrh9TPcmaU9S7hbIqg++A+XhojXgtM23uihrnx5U2dzPRJ
         uFcW19OB17Ec0fgXBsSnWuVVUoQhxeOvVzXrzfvf6FJKLFOK6u5zML9jV1gzeQIj/M
         E4A6P3jCKdd0OepMPu0GuTvxU5s0H9lUsDcrD+DRVbd1ZBHALoY6epQH7KjA9QIl0r
         vtnjflDeY4Pzw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPv1f2F3Lz4wqX;
        Tue, 15 Aug 2023 11:33:58 +1000 (AEST)
Date:   Tue, 15 Aug 2023 11:33:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the f2fs tree
Message-ID: <20230815113357.11919e63@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2AkwP.=IT1VYugni3JqV6c6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2AkwP.=IT1VYugni3JqV6c6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/f2fs/xattr.c

between commit:

  8874ad7dae8d ("f2fs: fix to update i_ctime in __f2fs_setxattr()")

from the f2fs tree and commit:

  c62ebd3501cc ("f2fs: convert to ctime accessor functions")

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

diff --cc fs/f2fs/xattr.c
index 9cc1ca75b2da,4ae93e1df421..000000000000
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@@ -766,8 -767,7 +766,8 @@@ same
  		clear_inode_flag(inode, FI_ACL_MODE);
  	}
 =20
- 	inode->i_ctime =3D current_time(inode);
++	inode_set_ctime_current(inode);
 +	f2fs_mark_inode_dirty_sync(inode, true);
  exit:
  	kfree(base_addr);
  	return error;

--Sig_/2AkwP.=IT1VYugni3JqV6c6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa1gUACgkQAVBC80lX
0GyzBAf/SzfgyALjTZ1j/L5LS8hjw+BErVWph5WzKENz9hqC21BZQyOqRjcr/rQH
HIu94M9HjdrMDK678984FaWRcre3skatu4Nb2zcOBt5+k7A99Y+Vyfl8QqUK8hlt
jorlo/G4t6xCJg8UIVY1wFhHSxIgzu9UISLE3vvmbcjW06e70IE4+CRz5r5tD/dc
ktG3MrG65Kd8z562BZlCzSDcwCzRL9NDH8atc3sGP5hCqK5Qsr0pWjzcN3vh5X3U
0aFReX9EY0MwmHe04qpBxgcGGciO+U62dXgwGfVVIWo4qtNKXWwUI0UcXNc3Zgke
/FIHY5foWz+sGPpsET1+hDWA99ySqA==
=xTFB
-----END PGP SIGNATURE-----

--Sig_/2AkwP.=IT1VYugni3JqV6c6--
