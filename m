Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C89C7B106B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjI1Bi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1Bi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:38:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E6AC;
        Wed, 27 Sep 2023 18:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695865133;
        bh=4W+f+ovUwsLwYCoWqlzJUOaeyo1Y7RbHKZd/nFecJsc=;
        h=Date:From:To:Cc:Subject:From;
        b=sHmfRKop1SLfuyaNmOCUBOr/Mug2foMiXa+vzAgnDhUN0pOmP4H13lamzM4dC5E9a
         aYRrJ7pk0b1WLs+DosPpvcWAeuD9o0qNF1LxCbOqxgTfnQ7/QISrafJ5m4VadB+mLG
         PxNa9DgYLNvbJHdUIEdlQCQ9s7HfxObz9bjU4pfwX4HFNr905qI0aIWoDt7wT1WhBh
         ijyoJuCrWrCNw+HRSfJrNrpJUJ/Wu7T64WCpXDwCZCyG/EaoqHgfGfd3Jua48UbvRn
         476pdDYYhMerxmbEQIfy2LlehWBzISBs/vdanNL06i4XFpPdU/oFhmDw0obN0yDBiT
         Rbkj5PL/bGSiQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rwx306MN2z4xQg;
        Thu, 28 Sep 2023 11:38:52 +1000 (AEST)
Date:   Thu, 28 Sep 2023 11:38:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: linux-next: manual merge of the rdma tree with the rdma-fixes tree
Message-ID: <20230928113851.5197a1ec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=fDGhJ7S8ak69Dru.Q2TNgK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=fDGhJ7S8ak69Dru.Q2TNgK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  drivers/infiniband/hw/mlx5/mr.c

between commit:

  374012b00457 ("RDMA/mlx5: Fix mkey cache possible deadlock on cleanup")

from the rdma-fixes tree and commit:

  57e7071683ef ("RDMA/mlx5: Implement mkeys management via LIFO queue")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/hw/mlx5/mr.c
index 433f96459246,b0fa2d644973..000000000000
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@@ -1025,21 -998,15 +999,21 @@@ void mlx5_mkey_cache_cleanup(struct mlx
  	if (!dev->cache.wq)
  		return;
 =20
 -	cancel_delayed_work_sync(&dev->cache.remove_ent_dwork);
  	mutex_lock(&dev->cache.rb_lock);
 +	dev->cache.disable =3D true;
  	for (node =3D rb_first(root); node; node =3D rb_next(node)) {
  		ent =3D rb_entry(node, struct mlx5_cache_ent, node);
- 		xa_lock_irq(&ent->mkeys);
+ 		spin_lock_irq(&ent->mkeys_queue.lock);
  		ent->disabled =3D true;
- 		xa_unlock_irq(&ent->mkeys);
+ 		spin_unlock_irq(&ent->mkeys_queue.lock);
 -		cancel_delayed_work_sync(&ent->dwork);
  	}
 +	mutex_unlock(&dev->cache.rb_lock);
 +
 +	/*
 +	 * After all entries are disabled and will not reschedule on WQ,
 +	 * flush it and all async commands.
 +	 */
 +	flush_workqueue(dev->cache.wq);
 =20
  	mlx5_mkey_cache_debugfs_cleanup(dev);
  	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);

--Sig_/=fDGhJ7S8ak69Dru.Q2TNgK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUU2SsACgkQAVBC80lX
0GxlKwf9GOM0/j7jLDM6oRP7xmR/7OTwq3Wqe0DCfc7my605pzw8TcAzxKmWECeG
3GQJ4+1DZ+ynWMONgTwLdJFdPadtlGzKkZK1augN6YunUtgddawRUUXNy/JTW70z
LwUTGrPbsLZGJC33UjehR4OymRspKENPisxT6klEgZ+ZWdZSNO7NTqCm3uhx5uiv
0pzVof94F44jxorl8ED0K8T3Gmui9y16vWQHDJo1/JiX+jpKl7WQERe7s+mMH89I
kaTQz/gR8Vmr2GfGCMFDhFdVdWK2ZtbZSkFYRyDCFQT2gUghzGAT2lpgEr+M7qTb
UKO+WbEwo1YkiuAYqrp/3Wc//OAWVA==
=7EBH
-----END PGP SIGNATURE-----

--Sig_/=fDGhJ7S8ak69Dru.Q2TNgK--
