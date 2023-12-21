Return-Path: <linux-kernel+bounces-7956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B381AFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F79E281B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1A48CC2;
	Thu, 21 Dec 2023 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sB4RtgRu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE0C433CF;
	Thu, 21 Dec 2023 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703144286;
	bh=bef3Xm85G2zTC6gd7H773Ic3Su0fXzsEsuzi5iz+aF0=;
	h=Date:From:To:Cc:Subject:From;
	b=sB4RtgRuVZdrgUI0naBnG3gPboPlJ3PZ2QojbFzMNB5T6Yo1Qfb7eV5GU++DzmST7
	 leMcsIzEXnC/a1hskjRNV74izxc+oJMaenuLlV1ChBr3MIzyFkQZbALWqUjYIeCtU6
	 GwDmmNGrjtpvmpOL15ZtwYbpP83hWwBNu2R7EEL7AQEsr34kyqxtynHHcsK9U97Mj9
	 WeoubDtrdcG7WCdaMvIZQp1NAbGfgPvee/+18daeiDKLI82Q5CsHrkBKGeKVocj3hp
	 uRz9/US/Z2jilERgHuVxhhujyGWhq64bUECCDp/vIovdZYnzGeAEs1gaC+EclyD6aX
	 Sk5h3lz74KSqw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swj2k0GVHz4wd4;
	Thu, 21 Dec 2023 18:38:05 +1100 (AEDT)
Date: Thu, 21 Dec 2023 18:38:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Changbin Du <changbin.du@huawei.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20231221183803.1dd342aa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xEm.X/IOObuScyjXp_MmcFp";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xEm.X/IOObuScyjXp_MmcFp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (x86_64 allnoconfig)
failed like this:

x86_64-linux-gnu-ld: init/main.o: in function `kernel_init':
main.c:(.ref.text+0xbf): undefined reference to `flush_module_init_free_wor=
k'

Caused by commit

  1d8053432676 ("modules: wait do_free_init correctly")

This build has
# CONFIG_MODULES is not set

I have applied this (hack) patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Dec 2023 18:27:07 +1100
Subject: [PATCH] fix up for "modules: wait do_free_init correctly"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 init/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/main.c b/init/main.c
index f0b7e21ac67f..1df1106ff09b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1407,7 +1407,9 @@ static void mark_readonly(void)
 		 * flushed so that we don't hit false positives looking for
 		 * insecure pages which are W+X.
 		 */
+#ifdef CONFIG_MODULES
 		flush_module_init_free_work();
+#endif
 		mark_rodata_ro();
 		rodata_test();
 	} else
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/xEm.X/IOObuScyjXp_MmcFp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWD61sACgkQAVBC80lX
0GwPDQgAoPFlJXY0V0LvRX3MpnC0ypEcjyR9cT0uEkps5/PzVwDkEzZt9Br2d0tw
xGiSHsR8uJfrP8Ix312iGEBQJHkJ8p216U7QkOyY4VTYQxugJre3tpxzsvbq5sGn
T8FTCSNhemny3v3Sgh5WtBWDBForPeWdpT3+d9wFLftfWMx0otuHl9X5TFDjXPzF
sO1irD6mSYTfFzxRC7vjet/ez4S7vkCRJPbWDP2aBfJfY7k8m/NlJl9bVapltN3t
VPK1OYD0hjHyUU4+5wwNEf0ONy8Obk99JQU3jwmgCiicPoRfJBj0ftMqgSDeXAgn
6AVOyuSKmE/xaat7YJNZfVWMfO8jtg==
=nce+
-----END PGP SIGNATURE-----

--Sig_/xEm.X/IOObuScyjXp_MmcFp--

