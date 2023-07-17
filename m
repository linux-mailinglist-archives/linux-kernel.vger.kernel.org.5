Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E68975709F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGQXlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGQXlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:41:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137331715;
        Mon, 17 Jul 2023 16:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689637206;
        bh=XnZc9WIcCXEeu1/qyKVH7xEr6ZjX1Z2UDPIv42jFExA=;
        h=Date:From:To:Cc:Subject:From;
        b=elbgduIgx56P0EhHf8uMby4KIo/5DXAAMA4Mqk8yUWJDQK4Ie06070aU7Cd4ugB1r
         /ggKh2IZChhZ1/7QXoPFoLvFBsxyVKOm1dMkzhv3ixIkkl0+PweEVEAZNoc+xFGesk
         hqeZUu9GOyQ581d/lIdADjIcZ2QleLjsV+4sCpbRvNxjlwn+Vwg3yteYVqHAusidn0
         ciawfX/bdC0f+//N5BbAyrYQJxdgyKnMEWm27xbhB1thTt7Y1WZOOiNKC/MmP56VLd
         Va4VnP5lGVIxpTiRCkRRL0Zirq1QI+Nf2Mjic19Ri8XA8UC0dkMl9ySk+fFhqvf4aT
         Xdw02zwWsujTQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R4dq96yg8z4wb0;
        Tue, 18 Jul 2023 09:40:05 +1000 (AEST)
Date:   Tue, 18 Jul 2023 09:40:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230718094004.3dd0dc52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2vrB65mXnI5FFfU+LiHokWR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2vrB65mXnI5FFfU+LiHokWR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/limits.h:6,
                 from include/linux/kernel.h:16,
                 from mm/mmap.c:12:
mm/mmap.c: In function 'do_vmi_align_munmap':
include/linux/stddef.h:8:14: error: incompatible types when assigning to ty=
pe 'lockdep_map_p' from type 'void *'
    8 | #define NULL ((void *)0)
      |              ^
mm/mmap.c:2430:38: note: in expansion of macro 'NULL'
 2430 |         mt_detach.ma_external_lock =3D NULL;
      |                                      ^~~~

Caused by commit

  f40b24c7c416 ("mm/mmap: change detached vma locking scheme")

CONFIG_LOCKDEP is not set for this build.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/2vrB65mXnI5FFfU+LiHokWR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS10VQACgkQAVBC80lX
0Gyh9QgAgKVValxU7q0uyh7DzHqGh7qFtYLcKuGldaC3uD5Ip8z8/J2hE3OzI7/Z
bEQAk0WuLxz517WervgEMeh+B6Sz+ANOQCvF6537qbIckc3Vf6XAAkvBm9vSQMWt
KkfBedM/1xwpOSIsgvQMPu0oCZJEFhtLktK+fzApJnlIsqjdqE2vXwQGvn+nQmH8
Rmhg2P0pud+st6Ftz3ValxA58fNVRU5IoPd+MJYqTKcwBxO37EFq2YQi3SI8tIwK
pLIpD5JpJFLM1NytxMdeYAf+/Bw5s+59rOqcyyiiwMNPUD93T6RR3qk6vlQwo8Jh
gGadNmOEKEpoPA6ym1stz1wrkqcj1g==
=i8Xi
-----END PGP SIGNATURE-----

--Sig_/2vrB65mXnI5FFfU+LiHokWR--
