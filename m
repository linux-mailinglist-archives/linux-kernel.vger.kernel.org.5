Return-Path: <linux-kernel+bounces-14018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CC98216EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE460B2105F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C981510FC;
	Tue,  2 Jan 2024 04:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g2fWFsoV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDEECD;
	Tue,  2 Jan 2024 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704170081;
	bh=p84+/d7JM+5YT13P6Sdcft2mkIKgQb6NrBwFdV6zXhc=;
	h=Date:From:To:Cc:Subject:From;
	b=g2fWFsoVuCi5K2VRN6suIsXmlTswGRWKDDL2J5SELg3fZsn6HN48y0hO8RTiEpzdV
	 JRluCoTJeKHGg3sCnOwiZsstd/+lcb/o5uNMkuWiMDpI/IdODjSv+BLQAMtcLtlXcI
	 D1s3/v9msAU0W9KTU5/gkn1G38pollHFiv/Jk3ndmH4aqzeLDFB3+3j4CtvIdWBN/u
	 fB0Muf86MLNIijyQW6bEORmuXxvmp7bayD6uIGAdB1Qgem30IXhD6UpO9A/li4Apg3
	 aMyepnyUfXZGtKuI8IjBd7y8YlJdoJcILoeD9ZqtfxMXJy12O/DZ+Zmq9Wmb2TLj6L
	 RVQEl04/aTZNQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T40PX5vrcz4wcd;
	Tue,  2 Jan 2024 15:34:40 +1100 (AEDT)
Date: Tue, 2 Jan 2024 15:34:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>
Subject: linux-next: manual merge of the slab tree with the mm tree
Message-ID: <20240102153438.5b29f8c5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bs=xQ.87GHfE6RoDVE0Wg4h";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/bs=xQ.87GHfE6RoDVE0Wg4h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  mm/slab_common.c

between commits:

  01869cf7b4c6 ("slub: use folio APIs in free_large_kmalloc()")
  8017164cb101 ("slub: use a folio in __kmalloc_large_node")

from the mm tree and commits:

  b774d3e326d3 ("mm/slab: move kfree() from slab_common.c to slub.c")
  4862caa5cba0 ("mm/slab: move kmalloc() functions from slab_common.c to sl=
ub.c")

from the slab tree.

I fixed it up (I used the latter version of this file and applied the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 2 Jan 2024 15:26:48 +1100
Subject: [PATCH] fix up for "mm/slab: move kfree() from slab_common.c to
 slub.c"

and "mm/slab: move kmalloc() functions from slab_common.c to slub.c"
interacting with commits

  01869cf7b4c6 ("slub: use folio APIs in free_large_kmalloc()")
  8017164cb101 ("slub: use a folio in __kmalloc_large_node")

from the mm tree

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/slub.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 236e728e49ed..2ef88bbf56a3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3915,7 +3915,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_node);
  */
 static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
-	struct page *page;
+	struct folio *folio;
 	void *ptr =3D NULL;
 	unsigned int order =3D get_order(size);
=20
@@ -3923,10 +3923,10 @@ static void *__kmalloc_large_node(size_t size, gfp_=
t flags, int node)
 		flags =3D kmalloc_fix_flags(flags);
=20
 	flags |=3D __GFP_COMP;
-	page =3D alloc_pages_node(node, flags, order);
-	if (page) {
-		ptr =3D page_address(page);
-		mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+	folio =3D (struct folio *)alloc_pages_node(node, flags, order);
+	if (folio) {
+		ptr =3D folio_address(folio);
+		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
 				      PAGE_SIZE << order);
 	}
=20
@@ -4375,9 +4375,9 @@ static void free_large_kmalloc(struct folio *folio, v=
oid *object)
 	kasan_kfree_large(object);
 	kmsan_kfree_large(object);
=20
-	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
+	lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
 			      -(PAGE_SIZE << order));
-	__free_pages(folio_page(folio, 0), order);
+	folio_put(folio);
 }
=20
 /**
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/bs=xQ.87GHfE6RoDVE0Wg4h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTkl4ACgkQAVBC80lX
0GxAZwf+N41qMPpe3J/EtCJxlZ2HvAR+pDkZYD9sqXeOGzL3POQ7VrhSA/CQHnQy
cxQXI1vydvEKwRBU/DAvRg3MofNywsqM8klfo7sOlzB+iaRq6d0uP6YdY/R9dNwV
4yRGh+/F+IWKJMHF6sXvYPZBm0s6yOiozPyp+mysp0IlBnL+CzGLH4MZjfA420HC
URji94yXD+fRU9O6xWi7NMu6E7kUHExh5DqYaYu9RCwGG42hs3toB+sn75xp002m
3TSE0wfMHiUDxoISQOdMxGO7fPXgpGUrlsANyMOvcvhp5+wvZLyWgkUq8p9zJt4h
otm6MRpuqY2S/3GscDMkGg2ip15jyA==
=Ngof
-----END PGP SIGNATURE-----

--Sig_/bs=xQ.87GHfE6RoDVE0Wg4h--

