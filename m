Return-Path: <linux-kernel+bounces-141709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F58A223D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC23B2236C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB66481C7;
	Thu, 11 Apr 2024 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Aye2Cc5c"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E047A6A;
	Thu, 11 Apr 2024 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877725; cv=none; b=M+dusWYxwADeF8aqOvtNlX1EVlpzUsUV8DxBsTu40uw453dm0vNbn9qvh50Opv1suL6XfgNCBP15yWGAvL/D/XJyklSK58QcZOlQzprvggBrkZgZJWbjPv2LtudjKjcL470pJLhedBBuOOfFsOig+FWAHAcKhtj8UOIVTBUaH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877725; c=relaxed/simple;
	bh=NiPMNkequhP1rKOVRsz2ygaVmwY+Odd+UMHIEOdjPRA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=u1U6LMIenjFh/Pe6gB/06SeaqmSRnT5Om2pKQ77SKoDpqBk9mGj8FXtojlhDUDOHBkmYJBMvbCCHpwtryjtnOwcF1wtcwl69TTRLRXrR1mm3nB5+B8UWfrEeRAD0vnAjDpLXg7rmcso60KFqjXBcf/Qu83dBvE1CXNNTMdsV5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Aye2Cc5c; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712877261;
	bh=7t25lDnXDTwlXYTBIkcJWNtQ9phcP0AeetbMBZHXvJA=;
	h=Date:From:To:Cc:Subject:From;
	b=Aye2Cc5chYgbkiOX39UaWQTduBeCtERu/fZjEO57S1JV0cRwqlmSmZPn+8rn86ruv
	 Fg8LpVql49pwM1nYbmN+7A41oynnmRtty7dGEa6iIQXlgI7lVOBHisX15QFrxhJWdC
	 8OL/qw9aT4ZqQqs2PWrKc+txf/+GJWTS8DNvRWAHzHks/0vQ+ZeomGUjMY3dztH+cs
	 E7pBdodjylkOR/uWCapenf5aGeA2iewfKxjOcmx65PAcLMVv3h+KEyaCmKUObWS2wN
	 7QoN50hDRMbygchhY1Ui6xWgxL9r5MkA8JLiHJG6NjQiQ2QSYR/1OzuF5wDKoGHbHL
	 DO+T5rnYbZznQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFwWK3D9Hz4wcb;
	Fri, 12 Apr 2024 09:14:21 +1000 (AEST)
Date: Fri, 12 Apr 2024 09:14:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <v-songbaohua@oppo.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240412091420.3d7c39ee@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j+xycq552cwx/eM8GNWel+a";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/j+xycq552cwx/eM8GNWel+a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

mm/memory.c: In function 'do_swap_page':
mm/memory.c:4169:17: error: implicit declaration of function 'count_mthp_st=
at' [-Werror=3Dimplicit-function-declaration]
 4169 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_=
SWPIN_REFAULT);
      |                 ^~~~~~~~~~~~~~~
mm/memory.c:4169:53: error: 'MTHP_STAT_ANON_SWPIN_REFAULT' undeclared (firs=
t use in this function)
 4169 |                 count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_=
SWPIN_REFAULT);
      |                                                     ^~~~~~~~~~~~~~~=
~~~~~~~~~~~~~
mm/memory.c:4169:53: note: each undeclared identifier is reported only once=
 for each function it appears in
cc1: some warnings being treated as errors

Caused by commits

  d46de7357458 ("mm: add per-order mTHP anon_alloc and anon_alloc_fallback =
counters")
  37a4ecbf36cb ("mm: add per-order mTHP swpin_refault counter")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 12 Apr 2024 09:11:42 +1000
Subject: [PATCH] fix up for ""mm: add per-order mTHP anon_alloc and
 anon_alloc_fallback counters"

and "mm: add per-order mTHP swpin_refault counter"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index b6fa5146b260..b3c33a76bcfa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4166,7 +4166,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		nr_pages =3D nr;
 		entry =3D folio->swap;
 		page =3D &folio->page;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_REFAULT);
+#endif
 	}
=20
 check_pte:
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/j+xycq552cwx/eM8GNWel+a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYbswACgkQAVBC80lX
0GxhKwf/VBJlmoGu6BUKeV2TRToe7I72vIK+VCLydL5u1qQx5rW0WHy0iq5GMlWe
a4pPQqed1aDfMmsrd6j0kCFmNDGRxgwMoy8/Br2m2ZR8ncKEVqXR7sqKoykjShlU
/klWRzWoDhnw4Bw6Z9ZBcltridjOUKLObHKUnvjabvAh6xXeelI3/LPkvx7+Gkvo
Noa7/JPvN4bpMzUI6yFZrceUT4X6UWz6pQ8QFNWyV+wRgTcyDSDs/R4a9yDwdVYo
MMWI5TlRkRBtUBIq6fw6xK59O9UyabdMtjrEH/FVojmU0OKjwGDKOSAnAPiBrdF6
grV2PcxXvm+gOA6gNrLZ3k/4c0h0ig==
=Vcqg
-----END PGP SIGNATURE-----

--Sig_/j+xycq552cwx/eM8GNWel+a--

