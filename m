Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0529A802904
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 00:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjLCXfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 18:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjLCXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 18:35:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E058D7;
        Sun,  3 Dec 2023 15:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701646514;
        bh=4SeuYyjE6NX5ofJ9uaA1W0ZgO2sJUY+tLHUi7w+Ap5c=;
        h=Date:From:To:Cc:Subject:From;
        b=IrDTteuUcrRsDwpYS7m9X6E0gy4gLyJ1QefQD54VPqI4TlhtstRBi/MagkhYWjiUA
         HiR90IP0SZhNuOXscpwB2CqKOkEk/f6ctdrtOY5e9W7cVKiU/Pm5z8Vt4BOlDq5VFH
         z/5bFeTx6Ie4SaHAbNxSTbqIHplNp7Acppxn2XxX1iYPRqmWghA36X8Eh4ol76e+4m
         CrqwGsee+SmG7Rylz3VuS4EOh8S2Vy+F0X7WbRIkwi0xF3a1ussrknXuhwxQLefAzn
         R8TRW5f4MCzt27Wrtd4Nop83aWdHi8cjqazsy26vU96h5kFTnUFAJjo2iugkJAidJJ
         5QMhO9v0EJ9NA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sk37M2YYyz4xKZ;
        Mon,  4 Dec 2023 10:35:11 +1100 (AEDT)
Date:   Mon, 4 Dec 2023 10:35:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yu Kuai <yukuai3@huawei.com>
Subject: linux-next: manual merge of the vfs-brauner tree with Linus' tree
Message-ID: <20231204103510.0eb5ea5f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pWxTEZ4vOXMwEmPh+.KR_n5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pWxTEZ4vOXMwEmPh+.KR_n5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  include/linux/blk_types.h

between commit:

  67d995e06953 ("block: warn once for each partition in bio_check_ro()")

from Linus' tree and commit:

  ed5cc702d311 ("block: Add config option to not allow writing to mounted d=
evices")

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

diff --cc include/linux/blk_types.h
index b29ebd53417d,52e264d5a830..000000000000
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@@ -70,7 -66,7 +67,8 @@@ struct block_device=20
  #ifdef CONFIG_FAIL_MAKE_REQUEST
  	bool			bd_make_it_fail;
  #endif
 +	bool			bd_ro_warned;
+ 	int			bd_writers;
  	/*
  	 * keep this out-of-line as it's both big and not needed in the fast
  	 * path

--Sig_/pWxTEZ4vOXMwEmPh+.KR_n5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVtEK4ACgkQAVBC80lX
0GzeLQf9GK26ZpgubASvbXlGIj73n6T4gjxAcBJiR0lbGU2LtjNKkut5lhyXtF1b
QnI9gEF9HGPnR0bhZE7rOK1/yctqNUpPoSp+G3PWvS+ywN/tnI7Kbav6nyc+DxV/
edjmXz2t1nemcYPrfZf+jTgnlkcTBitzaJfxHS8AjM1xHtLHgyVKOaVTSUXPIKKX
DSjAgnmAlX6AibfAMEQZpinnSmbPzyQiUAR/8CLDXJbA7502Ce9H5Z/unJXkRBL9
SjNFdET2zsxbztbjq+R1Ub5X2pU4iKDK9r4etmnv7gyc38y0JGWfrs5tMYHAAEoP
6JMIExv7dZHeXF4dgqtLMbQq/X0BwA==
=EaOI
-----END PGP SIGNATURE-----

--Sig_/pWxTEZ4vOXMwEmPh+.KR_n5--
