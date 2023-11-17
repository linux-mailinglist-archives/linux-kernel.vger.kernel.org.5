Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0D7EEA5F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKQAdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjKQAdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:33:23 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F020182;
        Thu, 16 Nov 2023 16:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700181194;
        bh=KTMVv7/Ueb564ZJYWnTWcSzc5IuQGbeTYWJDICffPOg=;
        h=Date:From:To:Cc:Subject:From;
        b=aJKdrTF+HPa3kq/Km3hW2uBurMvo03E+HDp1EIGFhrqgN7xbVht/bqYePlEBPxeyH
         PIm3wgc29vbCRYDm4Y4U8eEd96dAWYyT2R96z3yP4nIfAYOnCKCI4TveOJAnnR/0t2
         2A48kiRaPO5o0BmK8BlD0/BZCxDKlGv3aF3ZMxv5Ka9goxfDKByTreTTPEV2ONSg2Q
         N8bRgiUNS5opfIDl7mXF6wrktV5a2qfSggeInPk6z8vSu2sTwgsXmt/ymLZrhU5e4O
         qtLagHAevPe1eXCFddHb1+C++zl4KCUH1vF1vq3aG44KKXAXQwRb3ZnD9SVZg672Vl
         J0f262h+0iI1g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SWdD96rKNz4wdD;
        Fri, 17 Nov 2023 11:33:13 +1100 (AEDT)
Date:   Fri, 17 Nov 2023 11:33:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp-gustavo tree
Message-ID: <20231117113312.31379f74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JsIxQBj1mIatj2rNJwWgdKt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JsIxQBj1mIatj2rNJwWgdKt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp-gustavo tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In function 'do_byte_reverse',
    inlined from 'do_vec_store' at arch/powerpc/lib/sstep.c:722:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3510:9:
arch/powerpc/lib/sstep.c:287:23: error: writing 8 bytes into a region of si=
ze 0 [-Werror=3Dstringop-overflow=3D]
  287 |                 up[3] =3D tmp;
      |                 ~~~~~~^~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:708:11: note: at offset [24, 39] into destination =
object 'u' of size 16
  708 |         } u;
      |           ^
In function 'do_byte_reverse',
    inlined from 'do_vec_store' at arch/powerpc/lib/sstep.c:722:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3510:9:
arch/powerpc/lib/sstep.c:289:23: error: writing 8 bytes into a region of si=
ze 0 [-Werror=3Dstringop-overflow=3D]
  289 |                 up[2] =3D byterev_8(up[1]);
      |                 ~~~~~~^~~~~~~~~~~~~~~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:708:11: note: at offset 16 into destination object=
 'u' of size 16
  708 |         } u;
      |           ^
In function 'do_byte_reverse',
    inlined from 'do_vec_load' at arch/powerpc/lib/sstep.c:691:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3439:9:
arch/powerpc/lib/sstep.c:287:23: error: writing 8 bytes into a region of si=
ze 0 [-Werror=3Dstringop-overflow=3D]
  287 |                 up[3] =3D tmp;
      |                 ~~~~~~^~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into destination =
object 'u' of size 16
  681 |         } u =3D {};
      |           ^
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into destination =
object 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset [24, 39] into destination =
object 'u' of size 16
In function 'do_byte_reverse',
    inlined from 'do_vec_load' at arch/powerpc/lib/sstep.c:691:3,
    inlined from 'emulate_loadstore' at arch/powerpc/lib/sstep.c:3439:9:
arch/powerpc/lib/sstep.c:289:23: error: writing 8 bytes into a region of si=
ze 0 [-Werror=3Dstringop-overflow=3D]
  289 |                 up[2] =3D byterev_8(up[1]);
      |                 ~~~~~~^~~~~~~~~~~~~~~~~~
arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into destination object=
 'u' of size 16
  681 |         } u =3D {};
      |           ^
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into destination object=
 'u' of size 16
arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into destination object=
 'u' of size 16
cc1: all warnings being treated as errors

Caused by commit

  c94c73da81d7 ("Makefile: Enable -Wstringop-overflow globally")

I have used te kspp-gustavo tree from next-20231116 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/JsIxQBj1mIatj2rNJwWgdKt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVWtMgACgkQAVBC80lX
0GwnIQf+L5Nuw/fA+7yL7I3fa51i0CLqCLl2qjdQmWlbjsVEcunt2MJjc0y3Kofs
/XPjhEAZTp2G+6kfmAs9L/xvkksog7ol4OGnSS8qsVPWiiJlY6gcF7VARx8rpIpl
XswyH5G+3RhDRquNSsHuKhmWTKNqFd8CUsS5lyaaz5cRDXBGzrDQnn5RpbBKfT4j
xqtgWSJntrmpkNKLY0Du8RPhPZqUgCrgONmO7bKtxKKEs3FNmDlxNaWXDo5VSZ6s
daggmJCXctmDPROsddDU2tzAAQtumhBFrXGWE83ecbosihdEpPjwFKS8YDYiHAt4
6CH+isVuuIxppIhN0lgeDsdwlhbXYg==
=nfoi
-----END PGP SIGNATURE-----

--Sig_/JsIxQBj1mIatj2rNJwWgdKt--
