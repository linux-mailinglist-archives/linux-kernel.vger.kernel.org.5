Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830D87B9890
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbjJDXJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjJDXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:09:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99261C0;
        Wed,  4 Oct 2023 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696460986;
        bh=mCF3g0jquxEL+pwxpJMLbfQmMd435GQolk4LT94nhT8=;
        h=Date:From:To:Cc:Subject:From;
        b=nQn2tPl+5GuHnR89ZLjroihIy1eSaqjG1tSqI1FfAnH+wiYPjl8/kma2GYtsCaMUN
         F1liNxo9BXYcr+MD3tPnzaR33yd8shuCWkzpc8zhBRa7SzhU0UwGjZkEYfXdtAfF8m
         tDrKCohOP7HJReYR2jod54jek/yvRzVqbfJ6nVuPHU8tcm+Ayy6xCPXpj71ERxqK5j
         SPz5o6Yww8KNetwpFhKLM8vwpFg77HRjdDnjxtzSgU+5godHB+PqsaoPqp7Ff5Mm/h
         6iqzYQqlFSUyYP5lIB/ezlpCgki1IlDRUd1xN7Rk+A67uAxXPWzaGMt3kYiwQweEvj
         ajgS/uzzUe4Pg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S19Pk09rWz4xLy;
        Thu,  5 Oct 2023 10:09:45 +1100 (AEDT)
Date:   Thu, 5 Oct 2023 10:09:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the btrfs tree with the btrfs-fixes
 tree
Message-ID: <20231005100932.53c35f2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H93Sqh0F6fw6Oc5b84TQeVD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H93Sqh0F6fw6Oc5b84TQeVD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/transaction.h

between commit:

  f8d1b011ca8c ("btrfs: always print transaction aborted messages with an e=
rror level")

from the btrfs-fixes tree and commit:

  5483af73c851 ("btrfs: rename errno identifiers to error")

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

diff --cc fs/btrfs/transaction.h
index 93869cda6af9,de58776de307..000000000000
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@@ -213,15 -216,15 +216,15 @@@ do {							=09
  	if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,	\
  			&((trans)->fs_info->fs_state))) {	\
  		first =3D true;					\
- 		if (WARN(abort_should_print_stack(errno),	\
+ 		if (WARN(abort_should_print_stack(error),	\
  			KERN_ERR				\
  			"BTRFS: Transaction aborted (error %d)\n",	\
- 			(errno))) {					\
+ 			(error))) {					\
  			/* Stack trace printed. */			\
  		} else {						\
 -			btrfs_debug((trans)->fs_info,			\
 -				    "Transaction aborted (error %d)", \
 +			btrfs_err((trans)->fs_info,			\
 +				  "Transaction aborted (error %d)",	\
- 				  (errno));			\
+ 				  (error));			\
  		}						\
  	}							\
  	__btrfs_abort_transaction((trans), __func__,		\

--Sig_/H93Sqh0F6fw6Oc5b84TQeVD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUd8KwACgkQAVBC80lX
0GyY2gf/cFoHnUUaAoG++VOskX/gdqgV2nTtk5H5fQWf2uN+yfYSLCp0eofjmT5n
wpeVYzWxvAc8h/cy9gpU1zf7fCoGKKhqHQjOXGxWqXK+odcsCG2aW7U+idEb1kxb
YHAye6G6QVo1l8wtMtk68b/+9StY+hpBjXQ21cu5WhcBA7ZjkxOtLKDjoPAA1jj6
KwM8RqCrDwwhu5D7ywH4vfDudMUyEZnZoOHqwwO1toOBSQrV4wvMpna7nqXL1nUg
99TJV6bO1VrkhbAP06k/CiOV/a7v+cKFDoq0tJ0EEMJnndOCLrbtbWPuI7FsYj5h
mAjAk1TR8a2ijCskygxZzvuDV1CH/Q==
=uhFb
-----END PGP SIGNATURE-----

--Sig_/H93Sqh0F6fw6Oc5b84TQeVD--
