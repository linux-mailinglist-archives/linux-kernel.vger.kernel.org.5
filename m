Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7827AE2D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjIZAR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:17:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EF410A;
        Mon, 25 Sep 2023 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695687440;
        bh=6pA/zaPvex5yELwVfoOjyd303wllUNzvBUF8400bCWo=;
        h=Date:From:To:Cc:Subject:From;
        b=pTNyKe50ZmrVhi1KeLlFt+dD/+nQn+4vhUD3Tj6LF44QXfBdQMtHl+7dII8tQbUaD
         zCBUiFCW5Uh7kMSUK0cyY5oOAGQl6Vy/Ho+73lqtZI5Ri2LVn270RhZauNVf0q4alw
         E87ZHx7gPsOOEqlzSYPUDq5Xm2jhSnprw0TKjLA78VtGkofDtS/0WICkHcwBlR9VBQ
         91wfoOKK1YPgoSHQe9wA8O0jtbz9FcAMnuZT1RM1/pBK+2pJSZonxMWGdyTXbnpGg6
         0lRCRJhfR4aFnb4iat8KOq66w6SPX54nVQ5oWQT5/ZRgGVTBH/DvaUL2fmjs3yW67W
         6xuGxWP0bIZng==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RvgKq33jSz4xGC;
        Tue, 26 Sep 2023 10:17:19 +1000 (AEST)
Date:   Tue, 26 Sep 2023 10:17:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: linux-next: manual merge of the btrfs tree with the mm tree
Message-ID: <20230926101717.0237a18a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_id7ysS3XdMqtj_gQ9I9Q9R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_id7ysS3XdMqtj_gQ9I9Q9R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/super.c

between commit:

  a95330e8e416 ("fs: super: dynamically allocate the s_shrink")

from the mm tree and commit:

  dd99b78be273 ("btrfs: open block devices after superblock creation")

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

diff --cc fs/btrfs/super.c
index b1798bed68f2,c41ed5a78ea4..000000000000
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@@ -1518,10 -1457,24 +1457,24 @@@ static struct dentry *btrfs_mount_root(
  		if ((flags ^ s->s_flags) & SB_RDONLY)
  			error =3D -EBUSY;
  	} else {
- 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
+ 		struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
+=20
+ 		mutex_lock(&uuid_mutex);
+ 		error =3D btrfs_open_devices(fs_devices, sb_open_mode(flags), s);
+ 		mutex_unlock(&uuid_mutex);
+ 		if (error)
+ 			goto error_deactivate;
+=20
+ 		if (!(flags & SB_RDONLY) && fs_devices->rw_devices =3D=3D 0) {
+ 			error =3D -EACCES;
+ 			goto error_deactivate;
+ 		}
+=20
+ 		snprintf(s->s_id, sizeof(s->s_id), "%pg",
+ 			 fs_devices->latest_dev->bdev);
 -		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
 +		shrinker_debugfs_rename(s->s_shrink, "sb-%s:%s", fs_type->name,
  					s->s_id);
- 		btrfs_sb(s)->bdev_holder =3D fs_type;
+ 		btrfs_sb(s)->bdev_holder =3D s;
  		error =3D btrfs_fill_super(s, fs_devices, data);
  	}
  	if (!error)

--Sig_/_id7ysS3XdMqtj_gQ9I9Q9R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSIw0ACgkQAVBC80lX
0GxkBwf/aelgXOkPAHAzzfOSFStjrMFp13Fxem/Furtxm+TRrr2dKzKhIbdUjVLP
I8yZsjxmHsOog50iLMakPRzWUSSkUUNWKxaDYgOHMyfzSINUqc55D5flmnOdz6ds
YVguGbZlLefjTei9Uc2Yzo+nVVdS3C+cExTPLQHgW6tMG8nqupagb5NU/w7oakyU
ERFgQ/1cOV/43UsXQKnuQdVAv0QHcZGOx8s3DOfA0h2kQuoYT6C03yNvkOSmBO5O
ouKX1DCtPfmvYkUFhVjlTbeBGJU6wQqR8IawPtwTG6Pudu7n2LuePlx242ktVkTe
7CzuN94mVgFUxJQ4y/Iq1+T79vulFQ==
=gsGP
-----END PGP SIGNATURE-----

--Sig_/_id7ysS3XdMqtj_gQ9I9Q9R--
