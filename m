Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0146F7B0FED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjI1AZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI1AZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:25:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C9FBF;
        Wed, 27 Sep 2023 17:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695860707;
        bh=WNfoadDuufEuRBv0tZgBUq317Tu+fzjqQuaRCyQaqoY=;
        h=Date:From:To:Cc:Subject:From;
        b=YSU+ECyvLmZHO74h3p72tRoPFUA8WxxG7KMqJG+/XI7u5i+2edS5umBotQHPTLlAW
         zPymgKN85Q4+eh+s6eA8mqaiUzoGzlUmULJXqudXODxIVMxW4tt+aZMUdj8wx+g/UM
         pURT8irwJ88xnE6goBZqAM8SCauaYCU3jjJMj+sCbIGepO70xxOVCM4dkSgJJOpoXM
         8uArPrsRCDhTkGoKmCCTH4mzgfM1xSaJUojLSMCrFRsuUCfqNtV05wBFAzwuyBLmCb
         Qd1RYgqbTus1/XXm9Baf1ENh0wjb5AB4ZukD5Z133MuvhwG+7bVsENKjq7sdET5Na9
         bzma44nz2UbNw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RwvPs6KFKz4x3F;
        Thu, 28 Sep 2023 10:25:05 +1000 (AEST)
Date:   Thu, 28 Sep 2023 10:25:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the mm tree
Message-ID: <20230928102504.5c751249@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SMcVosCLCqUTMl3H.Dxy.HK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SMcVosCLCqUTMl3H.Dxy.HK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/xfs/xfs_buf.c

between commit:

  5c7b459f9f1d ("xfs: dynamically allocate the xfs-buf shrinker")

from the mm tree and commit:

  176ccb99e207 ("xfs: Convert to bdev_open_by_path()")

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

diff --cc fs/xfs/xfs_buf.c
index 9e7ba04572db,003e157241da..000000000000
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@@ -1943,9 -1945,7 +1943,7 @@@ voi
  xfs_free_buftarg(
  	struct xfs_buftarg	*btp)
  {
- 	struct block_device	*bdev =3D btp->bt_bdev;
-=20
 -	unregister_shrinker(&btp->bt_shrinker);
 +	shrinker_free(btp->bt_shrinker);
  	ASSERT(percpu_counter_sum(&btp->bt_io_count) =3D=3D 0);
  	percpu_counter_destroy(&btp->bt_io_count);
  	list_lru_destroy(&btp->bt_lru);

--Sig_/SMcVosCLCqUTMl3H.Dxy.HK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUUx+AACgkQAVBC80lX
0GwEGQgAo9qwNqhpNWmvZNqJFQ13fHE2YhTPOEVqTkSle/ksWeaiz7hChiXk9iUY
YYTKMzpBplapPKsWy6UWJ1Gely7Q5HHMmDs8ZVFUqiZ7o6daPT4uFCpcEKCo4Sgl
rn1+Ng96iKpKwEqS1ESL/7QlYoj1ffMo+0a8dQSHc9xhKkaSkSmt6n8130gqIvOH
uM+lDV/duHeLblRP1x5ic2XddEFKEk4M8t40dlw8F6vGplbDSS2+lahrCpV5LmRC
2Ex/YNwjDnMl40UinvNzvdCUQV5LyWv5Ht8fVczc2A2xqSkVDHqqpjQA4wdMmkHr
JLdTjjLAeDR2IumGut+DiGSignVo6g==
=zbYj
-----END PGP SIGNATURE-----

--Sig_/SMcVosCLCqUTMl3H.Dxy.HK--
