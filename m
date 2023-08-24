Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C28878667E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbjHXEKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbjHXEKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:10:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B22B10C4;
        Wed, 23 Aug 2023 21:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692850216;
        bh=7KoZN98JmSo+SAci6EI9ZRUGXtPbnTFUP1z/hpL229U=;
        h=Date:From:To:Cc:Subject:From;
        b=DW1NwQayhHPWnHNJ+DmyuPKgZq/rVW/v3L678O8gwW55/UBq1IeoCmyfTNM7H6yiO
         wgM6AcB2m/aIPqpd9JCoClhTsSRxC3c6/Iu1INs2ApupEAF/eDVTDapEOTwVXUE/PM
         CP03hm2i6nBG25fLg6ihsZhTfCsYB0ES5XINZZ7daf+QAgmMDed500mxAuqYc3yOBx
         UPLIkG9j3bybJXIlQs6GzfoZIuWfyiaDs1yq/4m8v+fGLH2NDItKdiBhe37cBsB8Ws
         CUqj9ooDlLzTNwBese5gyUbpLEyjBJHWGRW0iBtipnF1J/kCtMeiHW8CZbUba677ev
         XIfnFRTCHM25A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RWV3l1H29z4wb8;
        Thu, 24 Aug 2023 14:10:11 +1000 (AEST)
Date:   Thu, 24 Aug 2023 14:10:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1?= =?UTF-8?B?aA==?= 
        <linux@weissschuh.net>, Zhangjin Wu <falcon@tinylab.org>
Subject: linux-next: manual merge of the nolibc tree with the vfs-brauner
 tree
Message-ID: <20230824141008.27f7270b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zvpK2mmdN4DBbtKv2zqL.tO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zvpK2mmdN4DBbtKv2zqL.tO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nolibc tree got a conflict in:

  tools/testing/selftests/nolibc/nolibc-test.c

between commit:

  49319832de90 ("selftests/nolibc: drop test chmod_net")

from the vfs-brauner tree and commit:

  148e9718e2a2 ("selftests/nolibc: add chmod_argv0 test")

from the nolibc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/nolibc/nolibc-test.c
index 970df9e55131,e2b70641a1e7..000000000000
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@@ -572,11 -857,14 +857,13 @@@ int run_syscall(int min, int max
  		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
  		CASE_TEST(kill_CONT);         EXPECT_SYSZR(1, kill(getpid(), 0)); break;
  		CASE_TEST(kill_BADPID);       EXPECT_SYSER(1, kill(INT_MAX, 0), -1, ESR=
CH); break;
+ 		CASE_TEST(sbrk_0);            EXPECT_PTRNE(1, sbrk(0), (void *)-1); bre=
ak;
  		CASE_TEST(sbrk);              if ((p1 =3D p2 =3D sbrk(4096)) !=3D (void=
 *)-1) p2 =3D sbrk(-4096); EXPECT_SYSZR(1, (p2 =3D=3D (void *)-1) || p2 =3D=
=3D p1); break;
  		CASE_TEST(brk);               EXPECT_SYSZR(1, brk(sbrk(0))); break;
- 		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); break;
+ 		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv=
("PWD")); break;
  		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
  		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOEN=
T); break;
+ 		CASE_TEST(chmod_argv0);       EXPECT_SYSZR(1, chmod(argv0, 0555)); brea=
k;
 -		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net"=
, 0555)); break;
  		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 05=
55), -1, EPERM); break;
  		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0,=
 0), -1, EPERM); break;
  		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;

--Sig_/zvpK2mmdN4DBbtKv2zqL.tO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTm2CAACgkQAVBC80lX
0Gz/wwgAnUQ5Z3PuFF1pV0jT1A1JVtBfr5TLLCkxCN2gTf4RWtV3kC28/ofCZIpE
1yr8Ow9lTkn0lHaMvgzfIhGRE/hBitQL1Hhw5EZixDifdaKbraQcijGk537wRM8R
fHxpjfHMAHrTDhAVVdd8qvKw0wACCfSE7o6cvqkB/wSKoh2x23/QFkCERgmhdgFb
5pwlmlJoB4zWN7VVkpV0KpTbKAUPwWpyfrHRi6xVwRGKQg4ALZLp+W/Ebxmo/tq8
GJHf+V+uA/R7qm079TZEKb+xDpAx29MtCuqY2hmSyN14QuyLfPEe7kc56mt7Bb1v
cqDv0y1WP79MxSCMgZHjpBP2ABjlrw==
=O0Rz
-----END PGP SIGNATURE-----

--Sig_/zvpK2mmdN4DBbtKv2zqL.tO--
