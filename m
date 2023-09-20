Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F437A8FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 01:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjITXOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 19:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITXOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:14:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB56B7;
        Wed, 20 Sep 2023 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695251635;
        bh=Jax4QiRNwepvVIwXxs1UWMsI2Jx/hXZe78H9Co8AuGE=;
        h=Date:From:To:Cc:Subject:From;
        b=LglUSZ4VJUD9W2r1j+MU+I953kPP6CP2yjCQr1LG6e+cG8e6gMrOak6m8EySJcfR3
         g7iKMv3d5FjjtVbAoVkA9G1Y+5o8fo5ZHnbdi0Cm3zp6cNGoNZOkruF/+I3RQd96u+
         Mg9Rgd0Z0C2bbuh6xTa7dq1z3QNc3cV6zYKgaUTLLBRLHtpPbX8RvphqCuIdA3Y2nO
         UOGviicSZqxSqahwB0B3vKUqAPw1ooYQkHhn7bpnwQllucJZbAe9+OyyWfkE/72fxH
         IiH4ETRrc8eMaAlmegH64DXxFh+30ioRs2Q3wfxceU6Ixm6bconROe+Y4vE9QWv0FL
         +HJlROHeB6kBw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RrZ8x4f3yz4x4D;
        Thu, 21 Sep 2023 09:13:53 +1000 (AEST)
Date:   Thu, 21 Sep 2023 09:13:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ying Sun <sunying@nj.iscas.ac.cn>
Subject: linux-next: manual merge of the vfs-brauner tree with the mm tree
Message-ID: <20230921091352.01306900@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ab_d6kmKoTJ3hBjotJm9urW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ab_d6kmKoTJ3hBjotJm9urW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  mm/shmem.c

between commit:

  449e3b71c77c ("mm/shmem: remove dead code can not be satisfied by "(CONFI=
G_SHMEM)&&(!(CONFIG_SHMEM))"")

from the mm tree and commit:

  db58b5eea8a4 ("Revert "tmpfs: add support for multigrain timestamps"")

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

diff --cc mm/shmem.c
index be050efe18cb,69595d341882..000000000000
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@@ -4602,7 -4585,11 +4602,7 @@@ static struct file_system_type shmem_fs
  	.parameters	=3D shmem_fs_parameters,
  #endif
  	.kill_sb	=3D kill_litter_super,
- 	.fs_flags	=3D FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 -#ifdef CONFIG_SHMEM
+ 	.fs_flags	=3D FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
 -#else
 -	.fs_flags	=3D FS_USERNS_MOUNT,
 -#endif
  };
 =20
  void __init shmem_init(void)

--Sig_/ab_d6kmKoTJ3hBjotJm9urW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmULfLAACgkQAVBC80lX
0GzAVgf/e2yLK5Nt9UJjjjc5OxUir4/PJzA/bnBIyRyr6rC4hpw3St0kH96Fh2f+
UwaEJwVQbIOe0uX0XWnqPtrKfaUqpyNMWT43PAdU5koU4mUyT2DDpmCEHFLyuJXz
3z0ItYySelpgd6U7jKFRj/uW5SVA1OpS6r/fggTFLFyMIwqwO+gH24voSCPnDw65
IwjHnPl69IvVBWTYq9uqm5xrqX8u5OW+R6oxku22FP3ggvRc5/mevfmZ8zUAtkI2
6Q5fq4CIDT01hlx5DLPj2LxL7Kp4Nz0VcDwO+Y1odIwsv/HlueBp/SrXcZvqVR+w
QUnTlpBT5U+/JT0PD8RCmmStzFxqsw==
=pc46
-----END PGP SIGNATURE-----

--Sig_/ab_d6kmKoTJ3hBjotJm9urW--
