Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CABC76DD28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjHCB2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjHCB2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:28:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2C530CA;
        Wed,  2 Aug 2023 18:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691026112;
        bh=zzUxoMrW0h/cLUqTaqtv4wQNJt5GODwlXy3Re2dpgPc=;
        h=Date:From:To:Cc:Subject:From;
        b=OJXBlizEuP1aN95mUTkyeZ3TZookzhjNn5qkwNwEMkXkEDuo7erl1qm0H1Rf9Be8f
         d9xCqL3LZIRI+RcKazK0UkeOSlJj6KL2uEQYmbR/P8b9MFhwXWYXqvJSm3Ej1AB7+s
         f3SrdLY2c5fi0odTVh9ONFSxdlEDvZsdBG5cibJUOzvdKh12B1peL+NtlkJZYjThiL
         bpGDWWsQIFkicKMBTHMLvQ3ser3auUzx3WKsptRxerJrpdEpPl/whR/3W1iVjfnCjj
         uajlzadEBFffJtCpbjhTcxNVBtVpo4eJD4Ml6nbQtdxcgDTQdhOWZ2HInXv5VHCaTC
         Ra0TEpflkLj0A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RGWSw52zcz4wbj;
        Thu,  3 Aug 2023 11:28:31 +1000 (AEST)
Date:   Thu, 3 Aug 2023 11:28:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the djw-vfs tree
Message-ID: <20230803112830.21c805a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Buv3IITV=ap.THZsaND54hy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Buv3IITV=ap.THZsaND54hy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/super.c

between commit:

  880b9577855e ("fs: distinguish between user initiated freeze and kernel i=
nitiated freeze")

from the djw-vfs tree and commit:

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
index edc588bca7fc,bc666e7ee1a9..000000000000
--- a/fs/super.c
+++ b/fs/super.c
@@@ -1029,8 -1029,10 +1029,10 @@@ static void do_thaw_all_callback(struc
  {
  	down_write(&sb->s_umount);
  	if (sb->s_root && sb->s_flags & SB_BORN) {
- 		emergency_thaw_bdev(sb);
+ 		if (IS_ENABLED(CONFIG_BLOCK))
+ 			while (sb->s_bdev && !thaw_bdev(sb->s_bdev))
+ 				pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
 -		thaw_super_locked(sb);
 +		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
  	} else {
  		up_write(&sb->s_umount);
  	}

--Sig_/Buv3IITV=ap.THZsaND54hy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTLAr4ACgkQAVBC80lX
0Gy8QQgAjftO2ZUGP9ttUAf7vFwVka82EsCeDhA9uYqiiTOMkcqRy+oEI2ozn1BY
fM6u0zrcFfaxCNXnenU5pspnEoMajzXJj5kd6mxXvMNz8oyROpxj27Tx/2Ni1hC1
Qzsdx3B3QF1Qhg7ubUzZ9YN4Nw2AaR/Yqlof1nmAAOPApcdBgd7nhGwPJRrkceh1
glRMDbt2HPv1JAs9T1BWGAm1pqBtANw15vmeSgxBVHS6VMMAsF8W5kFH/UedwdHQ
vR5QBWSD26UK92oPL/lsPuDFDTPIYEKQhpJQB+vKLs2cqik0zhABqAk87JCPc5Nf
5FB+Dg984wMlnnJ5Ky8yuib/v6WF7A==
=PmkS
-----END PGP SIGNATURE-----

--Sig_/Buv3IITV=ap.THZsaND54hy--
