Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2742C783863
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjHVDPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjHVDPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:15:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71903185;
        Mon, 21 Aug 2023 20:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692674144;
        bh=Py5eH3QrPVteC/AOmqcFlGdxXXSdPEIePL9noQR/pR4=;
        h=Date:From:To:Cc:Subject:From;
        b=e4jmIYJOY59FfpOwg+ORmFl+aashUF7zERGLIDMRBoZokrBomITPrcLgxRDVkxgUR
         el/9cxN7w6h4qDqlV+7JiMyt7oxHY964uJGDDKwyKYz9rzwyAK7xHdbfQd10KoOMTx
         RsiwXN1PfenJev0QosW3U/MUkL7owpgzaHobkWNelWNSCYH1+vFQssXOneKT6aHGAv
         Bb1w+WOQn85h27SneGn1FlV8wa9Too4a+B5SCkN3RlIBdwuEK0qW7XRWV+cdQL84BD
         6GPIIuTJ9DAotzInn/c6JsmbY/jwr1MOqH//+2W/jv2piYBUvIyVDb36F36TAKxtgY
         tYbuAY1DOa7iw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVDxr2tzwz4wxN;
        Tue, 22 Aug 2023 13:15:43 +1000 (AEST)
Date:   Tue, 22 Aug 2023 13:15:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the djw-vfs,
 vfs-brauner trees
Message-ID: <20230822131541.7667f165@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wqu+jNTkMDyRpR5lTakfctO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wqu+jNTkMDyRpR5lTakfctO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/super.c

between commits:

  0ed33598ddf3 ("super: use locking helpers")
  5e8749141521 ("super: wait for nascent superblocks")
  880b9577855e ("fs: distinguish between user initiated freeze and kernel i=
nitiated freeze")

from the djw-vfs, vfs-brauner trees and commit:

  4a8b719f95c0 ("fs: remove emergency_thaw_bdev")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/super.c
index 5062ca612e0d,bc666e7ee1a9..000000000000
--- a/fs/super.c
+++ b/fs/super.c
@@@ -1196,13 -1027,14 +1196,15 @@@ void emergency_remount(void
 =20
  static void do_thaw_all_callback(struct super_block *sb)
  {
 -	down_write(&sb->s_umount);
 -	if (sb->s_root && sb->s_flags & SB_BORN) {
 +	bool born =3D super_lock_excl(sb);
 +
 +	if (born && sb->s_root) {
- 		emergency_thaw_bdev(sb);
+ 		if (IS_ENABLED(CONFIG_BLOCK))
+ 			while (sb->s_bdev && !thaw_bdev(sb->s_bdev))
+ 				pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
 -		thaw_super_locked(sb);
 +		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
  	} else {
 -		up_write(&sb->s_umount);
 +		super_unlock_excl(sb);
  	}
  }
 =20

--Sig_/Wqu+jNTkMDyRpR5lTakfctO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTkKF4ACgkQAVBC80lX
0Gx2uwf5AfM9q7tFbE3BDv8Z42VHsaqDKeD3XvZ2DT0k8yXDHrMDJqdJRY/KCX3V
jEg36vJOZrzhe3RHuDSHlCC3Ow+M6hcSPXvcENhc7I1I30NurSccun1skkdxAxSP
J8kcvjtVF68bm0oSq2sMD/xufwD+xQdztzZAuFu8uZfA0GkVRl9kyJ9+SS6IE8qF
MC9e7nINjRU45I6vqmxs9K+uPb1snRkRDPOgHzxVo87W7PS04De0gD44ArT25Rl4
IzLx1J+nUFU51QyR0MbowV955pWWKN3LN9g0rAHxvYp9f4yLHK2vMZxUJ+Mv0PYk
9cs13zbsn2RMLv9whAKsPkNoJVXDaQ==
=1Wsm
-----END PGP SIGNATURE-----

--Sig_/Wqu+jNTkMDyRpR5lTakfctO--
