Return-Path: <linux-kernel+bounces-86117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308586BFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0599D2865F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55119376E1;
	Thu, 29 Feb 2024 04:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cUb0E7wi"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A71C3E;
	Thu, 29 Feb 2024 04:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709180821; cv=none; b=k7Dc/SzSuR+cdlBF8fORdIa81xVKPmaWOgm0g3/z6XrICfPEVfR9/Sm+clrBQMbCoDrni9cFcam3NRsE07hYQEvawMqEH0sHIVpA0aVrV/dhhbU7kpKD1EO9BGFzrzRXM0qHon9qEFQLW2nUjq5JS4ypvaMiKq20KNooOdC0oYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709180821; c=relaxed/simple;
	bh=h/5G9NNcnkDMRKX6jAh2VhWg9yz8dbicS7iS1TG4GEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aFMcdCUQT35FSRKXo+4QlSI3DFGSk1uItjnVTDwFDGJqX8Hdy1xJTOvhr1oMdp7gLJK/zLxq9lVg4XPeGo7AncSbmv1loX73w2nIjraLVVPU/BS+4hYPmOx+oxB+m/z7kHITeUXEtJAAQuaH8BRzo24KlIhsmIv/65npHHbRiwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cUb0E7wi; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709180816;
	bh=QaXdlZBTDkaeRTH8hHnwNLiN9wYY0RBx9cffFy2xxTY=;
	h=Date:From:To:Cc:Subject:From;
	b=cUb0E7wikUlJVhjdOXFk2VhHo6L77CY4RAI8kbgSVZD5gUezItbMSRukwH/J5kLoZ
	 Wliods/NRVA3AS6gaaAQW/hRlqBcVktuZkBTdycHviV+3C/TL7b98rTx/iNVJIke7s
	 XOx81m+TvDfmqVkLLSKWGvpGDySTzKesoc5tbH4LCeeRQfcb7nGYPyGVkwURcujJcx
	 37BBQ3kAkHDIJtw8UNfx+EY6VVcD8DovNaVzPlS1Wjp3DEvFKTdPcjUH6QvP+MjzaV
	 NfMWJSkDGwQsoCLYwR/M6kptbB9ZXdCJoqn5mPKki4WcoYZJnQfZda1J8v8t8rjilW
	 uTgru97baqrEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TldTp2Glyz4wbQ;
	Thu, 29 Feb 2024 15:26:54 +1100 (AEDT)
Date: Thu, 29 Feb 2024 15:26:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins
 <brendanhiggins@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Matthew Auld <matthew.auld@intel.com>, David
 Gow <davidgow@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kunit-next tree
Message-ID: <20240229152653.09ecf771@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aI6337UaqxBnHRtmTs_90Hu";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/aI6337UaqxBnHRtmTs_90Hu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kunit-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from drivers/gpu/drm/tests/drm_buddy_test.c:7:
drivers/gpu/drm/tests/drm_buddy_test.c: In function 'drm_test_buddy_alloc_r=
ange_bias':
drivers/gpu/drm/tests/drm_buddy_test.c:191:40: error: format '%u' expects a=
 matching 'unsigned int' argument [-Werror=3Dformat=3D]
  191 |                                        "buddy_alloc failed with bia=
s(%x-%x), size=3D%u, ps=3D%u\n",
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:597:37: note: in definition of macro '_KUNIT_FAILED'
  597 |                                     fmt,                           =
            \
      |                                     ^~~
include/kunit/test.h:662:9: note: in expansion of macro 'KUNIT_UNARY_ASSERT=
ION'
  662 |         KUNIT_UNARY_ASSERTION(test,                                =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~
include/kunit/test.h:1233:9: note: in expansion of macro 'KUNIT_FALSE_MSG_A=
SSERTION'
 1233 |         KUNIT_FALSE_MSG_ASSERTION(test,                            =
            \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:186:17: note: in expansion of macro =
'KUNIT_ASSERT_FALSE_MSG'
  186 |                 KUNIT_ASSERT_FALSE_MSG(test,
      |                 ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/tests/drm_buddy_test.c:191:91: note: format string is defin=
ed here
  191 |                                        "buddy_alloc failed with bia=
s(%x-%x), size=3D%u, ps=3D%u\n",
      |                                                                    =
                      ~^
      |                                                                    =
                       |
      |                                                                    =
                       unsigned int
cc1: all warnings being treated as errors

Caused by commit

  806cb2270237 ("kunit: Annotate _MSG assertion variants with gnu printf sp=
ecifiers")

interacting with commit

  c70703320e55 ("drm/tests/drm_buddy: add alloc_range_bias test")

from the drm-misc-fixes tree.

I have applied the following patch for today (this should probably
actually be fixed in the drm-misc-fixes tree).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 29 Feb 2024 15:18:36 +1100
Subject: [PATCH] fix up for "drm/tests/drm_buddy: add alloc_range_bias test"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/tests/drm_buddy_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests=
/drm_buddy_test.c
index 1e73e3f0d278..369edf587b44 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -188,7 +188,7 @@ static void drm_test_buddy_alloc_range_bias(struct kuni=
t *test)
 							      bias_end, size, ps,
 							      &allocated,
 							      DRM_BUDDY_RANGE_ALLOCATION),
-				       "buddy_alloc failed with bias(%x-%x), size=3D%u, ps=3D%u\n",
+				       "buddy_alloc failed with bias(%x-%x), size=3D%u\n",
 				       bias_start, bias_end, size);
 		bias_rem -=3D size;
=20
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/aI6337UaqxBnHRtmTs_90Hu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXgB40ACgkQAVBC80lX
0GzV/wf/RGYkdSH7g7RogpotZFFU0jh3bvcrzQu1LG3uAQQ4RIVtdXEu6go1saxk
oWUTLPLqo7xLcVi66WQQM9+3hx0q5742+2tjiwaQKCgJndfXaYMwIhoBDL3MOZE6
5XW5BrfqatrkMEODrq3beZ1sgPEYdfL/9n58o6VnimPb9f2YbinPyookSkwMFxZS
pZzpHAJuNhHbmyHjhDPvxsKe/9Hqd62amt/vXQW2QQ4UKssmqUrPcCVMzVuf0IhM
oaG3+nbnN9yTWlsO1o28Ogp90fZfXijAoG6PBS24ieS1Uf+05CNSdp6KUhFqkT1P
7CvwJa94RlkPeUpOiBMpsvHBjrq+tA==
=73Tp
-----END PGP SIGNATURE-----

--Sig_/aI6337UaqxBnHRtmTs_90Hu--

