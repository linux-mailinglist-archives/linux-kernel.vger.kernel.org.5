Return-Path: <linux-kernel+bounces-7682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2C81AB97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D7A281826
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36679639;
	Thu, 21 Dec 2023 00:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MvA2/SZN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C87383;
	Thu, 21 Dec 2023 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703117929;
	bh=EdF4RwMl5bB1yeUUdg9xgQGrjD9wFijsEoUGGXQW66o=;
	h=Date:From:To:Cc:Subject:From;
	b=MvA2/SZNPfF0NBlrFbpQAK4FXSXAwnkmLvkUHAL8UkFQkZ5Eaz9bAXJ2B7bRYM0I+
	 g/B0Y89V344RB6G8XVCZKopY1MYW03ApY1aZOZ0wOchyDeWuWPpPOEgKRJD0PN61Pc
	 uH722iYQa9B8t0JaXWyLMAlVswFDzfMnufyxJoV3eNVFSc0hAeiF32nP1289Sihafq
	 hSGLWOs8Bvlb9KcNg4VhDAGLeMJtVDbwotNb5x5QQXGn27Y+/lCoOygcoCUEGOCQ83
	 Pbkv+fjv6ZO2f+y2KyVhrvvhoC7RN6wiHxtPACrYDF9CkZfMEczKOSx7+CpQfuQv2P
	 /+DEsm2oZ6l+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwWHs00FJz4wbr;
	Thu, 21 Dec 2023 11:18:48 +1100 (AEDT)
Date: Thu, 21 Dec 2023 11:18:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Howells
 <dhowells@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20231221111847.689ea41f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jVYJpyN+lRwKsnc3tK+eeuL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/jVYJpyN+lRwKsnc3tK+eeuL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/netfs/buffered_write.c: In function 'netfs_kill_pages':
fs/netfs/buffered_write.c:569:17: error: implicit declaration of function '=
generic_error_remove_page'; did you mean 'generic_error_remove_folio'? [-We=
rror=3Dimplicit-function-declaration]
  569 |                 generic_error_remove_page(mapping, folio_page(folio=
, 0));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
      |                 generic_error_remove_folio

Caused by commit

  dec5b4af52dc ("netfs: Provide a writepages implementation")

interacting with commit

  af7628d6ec19 ("fs: convert error_remove_page to error_remove_folio")

from the mm-stable tree.

I have applied the following merge resolution patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Dec 2023 11:08:57 +1100
Subject: [PATCH] fixup for "netfs: Provide a writepages implementation"

interacting with

  af7628d6ec19 ("fs: convert error_remove_page to error_remove_folio")

from the mm-stable tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/netfs/buffered_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index a739805dd394..d7ce424b9188 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -566,7 +566,7 @@ static void netfs_kill_pages(struct address_space *mapp=
ing,
 			folio_end_fscache(folio);
 		folio_end_writeback(folio);
 		folio_lock(folio);
-		generic_error_remove_page(mapping, folio_page(folio, 0));
+		generic_error_remove_folio(mapping, folio);
 		folio_unlock(folio);
 		folio_put(folio);
=20
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/jVYJpyN+lRwKsnc3tK+eeuL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWDhGcACgkQAVBC80lX
0GxPWAf6A9EwsCkOWlmoR8H2Sb7nY5ZXdZRhChMDx+tmIq7xB4MF1IqFYI3If9O2
RHyaLr/UT9DQXSxfOlhpLQXtp1VOeb2r41j1z2mkfxCuuy4HQM+8IOUJHand+2LE
Luq4FC3neTHAFZyBJlOD59AbyPlYh2+gVeuSrA7nFIcGaXAzbAw+jQf+Qxfddwy7
Rv1SPd0XddSdmvtPkmkID9xruW2HIbH20oCvm2gyWxKdZ9tPUqnG03ys5Z8eDLu1
jJ3nXbs8zGE4ZQ0YukVSk3878DgQH91FdEYG4RPHravVFpU80AnYbb1Yw7efnAGn
afzunftJvhj0nmDHztwoiVxu++grdQ==
=ao8G
-----END PGP SIGNATURE-----

--Sig_/jVYJpyN+lRwKsnc3tK+eeuL--

