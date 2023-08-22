Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF765784D65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjHVXi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHVXi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:38:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A685CD7;
        Tue, 22 Aug 2023 16:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692747534;
        bh=yZs+o7fq+3ECzw1nBRtgOPe68rPMKRQ0lFhjxf9Nc5Q=;
        h=Date:From:To:Cc:Subject:From;
        b=o6tm0f2CCnCgPOlhxtk00vQ6IK9BhdJjQlUSQdxvNcest3kZIYf59Kh7c4scxSFJa
         Wf+TTmBxN/B0zMjpcGej4h4PX6YNMsKwCdXDg2ZhmIkt7Op9r0rysS8eP1OyS4mamY
         RNdEH+demzT+g5OFLQbg1+lI6+Apmb0LRWrcrNfjejEmSntux5XmCd1+Oxf1aV6prD
         BaIvmvLz863ztQ6c+wOfA48W6PTjlNHOaVpFVARJ5dx+Nco+xTH3ZHda/Kah/nYTyA
         zLTjid8WngMPIYGG7tuKgy4IEJfbLehYwGJFDMM9mjJcZ6GIHphOPjaM/5+qqTGLf9
         NdwV8ag10i3lQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVm595VC5z4wxW;
        Wed, 23 Aug 2023 09:38:53 +1000 (AEST)
Date:   Wed, 23 Aug 2023 09:38:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        David Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the xfs tree
Message-ID: <20230823093852.7bf03b7e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n5wKtoreezILvO5+.oog+Ed";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n5wKtoreezILvO5+.oog+Ed
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/xfs/xfs_super.c

between commit:

  a76dba3b248c ("xfs: create scaffolding for creating debugfs entries")

from the xfs tree and commit:

  35a93b148b03 ("xfs: close the external block devices in xfs_mount_free")

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

diff --cc fs/xfs/xfs_super.c
index 09638e8fb4ee,c79eac048456..000000000000
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@@ -760,7 -772,17 +774,18 @@@ static voi
  xfs_mount_free(
  	struct xfs_mount	*mp)
  {
+ 	/*
+ 	 * Free the buftargs here because blkdev_put needs to be called outside
+ 	 * of sb->s_umount, which is held around the call to ->put_super.
+ 	 */
+ 	if (mp->m_logdev_targp && mp->m_logdev_targp !=3D mp->m_ddev_targp)
+ 		xfs_free_buftarg(mp->m_logdev_targp);
+ 	if (mp->m_rtdev_targp)
+ 		xfs_free_buftarg(mp->m_rtdev_targp);
+ 	if (mp->m_ddev_targp)
+ 		xfs_free_buftarg(mp->m_ddev_targp);
+=20
 +	debugfs_remove(mp->m_debugfs);
  	kfree(mp->m_rtname);
  	kfree(mp->m_logname);
  	kmem_free(mp);
@@@ -1538,18 -1537,11 +1556,18 @@@ xfs_fs_fill_super
 =20
  	error =3D xfs_open_devices(mp);
  	if (error)
- 		goto out_free_names;
+ 		return error;
 =20
 +	if (xfs_debugfs) {
 +		mp->m_debugfs =3D xfs_debugfs_mkdir(mp->m_super->s_id,
 +						  xfs_debugfs);
 +	} else {
 +		mp->m_debugfs =3D NULL;
 +	}
 +
  	error =3D xfs_init_mount_workqueues(mp);
  	if (error)
- 		goto out_close_devices;
+ 		goto out_shutdown_devices;
 =20
  	error =3D xfs_init_percpu_counters(mp);
  	if (error)

--Sig_/n5wKtoreezILvO5+.oog+Ed
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTlRwwACgkQAVBC80lX
0Gz6gwf+KtMm/B6ztfqsX2qtt8tquwCNqAyDznpCY1BGycC/pG7kOkQO8U6Mi/pX
+7e32oEgfiGQ0PqngPdxyOk51FGpVrEVrJTYw/VDvERStnEDdIUcJXKbRHzNrH+F
HfH9lwySQZGMESO/kF3Xw6Z9l+eqHfkWwbRZBwUO73Vaz/LSHaSuLRABpCMA7aUA
BK3owTjhZTsybE7nHzdsDS+hbWILcvT6oMcLiW85kC30trNCR9cCVoNFByPbtiYI
jyz/ChtoK+z9OS871AeCwOSLeIqLO4vi+5eCiWlpy19h9zQD9JvIh4k0roISJF04
lMqLamBeg7rTGsZE9N+BZ9/AwZbC7w==
=8d5B
-----END PGP SIGNATURE-----

--Sig_/n5wKtoreezILvO5+.oog+Ed--
