Return-Path: <linux-kernel+bounces-7892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE9C81AEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B963286520
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B85BE4D;
	Thu, 21 Dec 2023 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rmN34+ri"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8DB671;
	Thu, 21 Dec 2023 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703140286;
	bh=Rapc3Tfs1cCcH1qpsutR1bzBhPHIjD7KmbnugD5r/pU=;
	h=Date:From:To:Cc:Subject:From;
	b=rmN34+ribrVMv54rD0pStGFHf0C5PFSAfyKB3RfAWjSm5nDyV8ZEsRulydmyH6vOp
	 SrSXnzTnm1sYKChTmUlygLrcBlfuxYI5gLOvrBVJgZmpE8VTi9pZYMjMdQIhedpAMo
	 guul52ljTLhAq5gBSYc8sWSf2o2MAtbGBCnrhlhBVdBYWwtPFWqjHpg22xWeqF8SeV
	 uhf33A52OoJQ35U5RlefPMmt+tA7t2BPWDldCWzv1e3hQ0nYXJdczqxIVxdeSG2EPy
	 y22GKxBpC7rdbSjoSoK0UIKNjMA/U6gWWPyzW9RijTC4f/c1uzNvGxWVrLSppx+TiP
	 z1dWFCoq1bMBQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SwgYp2g4rz4xNH;
	Thu, 21 Dec 2023 17:31:26 +1100 (AEDT)
Date: Thu, 21 Dec 2023 17:31:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Andrey Konovalov
 <andreyknvl@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the slab tree with the mm-stable, mm
 trees
Message-ID: <20231221173124.78c7df98@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ynlm/+rE6q+wooN_qc6k/hu";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ynlm/+rE6q+wooN_qc6k/hu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  mm/kasan/quarantine.c

between commits:

  773688a6cb24 ("kasan: use stack_depot_put for Generic mode")
  f91ba46acc15 ("kasan: memset free track in qlink_free")

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
index 782e045da911,138c57b836f2..000000000000
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@@ -143,22 -143,7 +143,21 @@@ static void *qlink_to_object(struct qli
  static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
  {
  	void *object =3D qlink_to_object(qlink, cache);
 -	struct kasan_free_meta *meta =3D kasan_get_free_meta(cache, object);
 +	struct kasan_alloc_meta *alloc_meta =3D kasan_get_alloc_meta(cache, obje=
ct);
 +	struct kasan_free_meta *free_meta =3D kasan_get_free_meta(cache, object);
- 	unsigned long flags;
 +
 +	if (alloc_meta) {
 +		stack_depot_put(alloc_meta->alloc_track.stack);
 +		stack_depot_put(alloc_meta->aux_stack[0]);
 +		stack_depot_put(alloc_meta->aux_stack[1]);
 +		__memset(alloc_meta, 0, sizeof(*alloc_meta));
 +	}
 +
 +	if (free_meta &&
 +	    *(u8 *)kasan_mem_to_shadow(object) =3D=3D KASAN_SLAB_FREETRACK) {
 +		stack_depot_put(free_meta->free_track.stack);
 +		__memset(&free_meta->free_track, 0, sizeof(free_meta->free_track));
 +	}
 =20
  	/*
  	 * If init_on_free is enabled and KASAN's free metadata is stored in

--Sig_/ynlm/+rE6q+wooN_qc6k/hu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWD27wACgkQAVBC80lX
0Gx6Hwf/XtMzTNjptTv7+tpgzbalsWEP2g1p/6Dp1kud6x+fqWW03zGl4F8SAquo
yhOx5Ay0meeTZ2e+ErmIoOvVIqnOeoZxYiUvBS4Mc599ipBJyyRxC13vIxB16iSz
+u+Uf85y8Kr/HrP0n2GAv+Bd2iLv42Bi7TZtPWVHIh+TfKVgpdI+xWPiwp8gQunu
+Qi7dZhJVen7mararUDe+lppUAm552tmVpqEuDUso+qpn5t9BQKwUrQSBW+WQkCN
lmBl+up/FhUnTNl4NNoRb/qPGm8jf7jR/C5xhlwrNxtLsgcLum1lZ1RcNGFguhi4
QBmhUEtdGYZDbjaSoOGrEKV5bqEpMw==
=v/EN
-----END PGP SIGNATURE-----

--Sig_/ynlm/+rE6q+wooN_qc6k/hu--

