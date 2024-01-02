Return-Path: <linux-kernel+bounces-14014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B978216DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355F71F21A21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83D10F8;
	Tue,  2 Jan 2024 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F+hD3Sct"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E0ECB;
	Tue,  2 Jan 2024 04:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704168813;
	bh=nzjB48cCE5VSIzRwROBH6itfJxdakHetauGeOCGlZUQ=;
	h=Date:From:To:Cc:Subject:From;
	b=F+hD3SctfdecCH+JptjFhCzUgVmxxW375fljX4auBlQk5z5uqJMa/dlCg5j1SktBe
	 N1VUvhdeO1C+DM4flBZyXe2IP0oDQWVSUgTTaV2d794tNsIlBO7nOg48pnTYX7B5RI
	 cbdxYcv/TyhssTXnmqIYuuGp0Y+DL8Ov8utgqwae37NlhPJrjH2UhZ/w8vHyX9SKFW
	 SgdFMgv+ajOy5mxkPpAD0xCgkolyDJiNBA7lKO7RC7k8PIVij0KIzdXORmOCtscOlm
	 HO6SVgflewncTorvwM13S2ax+YTy3IxRLfbU5Cnypx8mJMkx2k8uXqams8Q2cNfJiz
	 nOnWBL8l35bdA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3zx94417z4wcM;
	Tue,  2 Jan 2024 15:13:33 +1100 (AEDT)
Date: Tue, 2 Jan 2024 15:13:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Andrey Konovalov
 <andreyknvl@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the slab tree with the mm-stable, mm
 trees
Message-ID: <20240102151332.48a87d86@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wfB=MU5Q0Sr7Y2VG9iIw_Sa";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/wfB=MU5Q0Sr7Y2VG9iIw_Sa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  mm/kasan/quarantine.c

between commits:

  773688a6cb24 ("kasan: use stack_depot_put for Generic mode")
  435736586ddc ("kasan: stop leaking stack trace handles")

from the mm-stable, mm trees and commit:

  72786c0a3dc5 ("KASAN: remove code paths guarded by CONFIG_SLAB")

from the slab tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/kasan/quarantine.c
index 8afa77bc5d3b,138c57b836f2..000000000000
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@@ -143,10 -143,7 +143,9 @@@ static void *qlink_to_object(struct qli
  static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
  {
  	void *object =3D qlink_to_object(qlink, cache);
 -	struct kasan_free_meta *meta =3D kasan_get_free_meta(cache, object);
 +	struct kasan_free_meta *free_meta =3D kasan_get_free_meta(cache, object);
- 	unsigned long flags;
 +
 +	kasan_release_object_meta(cache, object);
 =20
  	/*
  	 * If init_on_free is enabled and KASAN's free metadata is stored in
@@@ -156,15 -153,15 +155,9 @@@
  	 */
  	if (slab_want_init_on_free(cache) &&
  	    cache->kasan_info.free_meta_offset =3D=3D 0)
 -		memzero_explicit(meta, sizeof(*meta));
 -
 -	/*
 -	 * As the object now gets freed from the quarantine, assume that its
 -	 * free track is no longer valid.
 -	 */
 -	*(u8 *)kasan_mem_to_shadow(object) =3D KASAN_SLAB_FREE;
 +		memzero_explicit(free_meta, sizeof(*free_meta));
 =20
- 	if (IS_ENABLED(CONFIG_SLAB))
- 		local_irq_save(flags);
-=20
  	___cache_free(cache, object, _THIS_IP_);
-=20
- 	if (IS_ENABLED(CONFIG_SLAB))
- 		local_irq_restore(flags);
  }
 =20
  static void qlist_free_all(struct qlist_head *q, struct kmem_cache *cache)

--Sig_/wfB=MU5Q0Sr7Y2VG9iIw_Sa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTjWwACgkQAVBC80lX
0Gy4/Af/cL43FDP9ZkJ03TvRNhUmSZ6igR6ZwynFZcTGx0PzE/F+8zWZNL02iGWy
LrQ6npksmc6H6xGkUfzh4YUIh3rsgjXp7EVEeDQz+nWQu8mc6i5mUsUfa5nxmafX
DO/9c5UjfAEvCqlV4hpP5lyaB6PrubPY9xWs7uNn992kCcpQXVHZhrPpT5kkIjKb
n0SW4HWapBha/ojZuTudzjQxP4AJeR+ofxg/788AYY2D83OnEheYVNbGS+9OEyOy
RMtDQeFrKWI+nJF8GmNB5KfEc1lMHQklfShGiYsHwbLtEhZHcKyoHLHAJRQHH3yg
FsbdXGYTJqEPCIIi3lIBXcRGGNZkqg==
=7QH2
-----END PGP SIGNATURE-----

--Sig_/wfB=MU5Q0Sr7Y2VG9iIw_Sa--

