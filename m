Return-Path: <linux-kernel+bounces-14007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B8E8216CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADB61C2107B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F131B10EC;
	Tue,  2 Jan 2024 04:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="roGpUTUf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D73EC8;
	Tue,  2 Jan 2024 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704168147;
	bh=gdqz2rnL9/XLeUfL3L5ooxL2yikVnNBJ4WRz67IDyiQ=;
	h=Date:From:To:Cc:Subject:From;
	b=roGpUTUfLX9keYNElAJxvHNkRg8X7jQ1bKdyjacpFuRsk/MCNPCrzF28A4ktvseCp
	 X9mpg9pMDqsP7b8xBqzVF4cXkr8tJrCMlVF5PpL8x8KnP10ZzxV6kq0sr8THEcxDVj
	 3wHBxdK0mbwJp1DDvBdx44ETEKaESAFeJnVe3BUueXpp6sgN0Fw+eqQy3sWOEmJAK2
	 ytDyv7jT7R+X3LK9FsSDQtms8ZNWx/8rYCzZEaBsuhlY3Wlx1gr/angCJhmJ9+7/8E
	 d6mbi53ra4E1U45TjS6IYQaHQZpBjwrrVnFRsLr/hV4rwYHVU/0RqtnYdsZMusROqA
	 v0+t1BrtULXKg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3zhK6YjJz4wcc;
	Tue,  2 Jan 2024 15:02:25 +1100 (AEDT)
Date: Tue, 2 Jan 2024 15:02:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the slab tree with the mm tree
Message-ID: <20240102150224.3c091932@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nzPrdCZFY8XSgWxki9yE8uE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nzPrdCZFY8XSgWxki9yE8uE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  include/linux/slab.h

between commit:

  78f5d33f3dd4 ("mm, treewide: rename MAX_ORDER to MAX_PAGE_ORDER")

from the mm tree and commit:

  a9e0b9f27266 ("mm/slab: remove CONFIG_SLAB code from slab common code")

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

diff --cc include/linux/slab.h
index d63823e518c0,b2015d0e01ad..000000000000
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@@ -308,19 -307,10 +307,10 @@@ static inline unsigned int arch_slab_mi
   * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
   */
  #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
 -#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
 +#define KMALLOC_SHIFT_MAX	(MAX_PAGE_ORDER + PAGE_SHIFT)
  #ifndef KMALLOC_SHIFT_LOW
- #define KMALLOC_SHIFT_LOW	5
- #endif
- #endif
-=20
- #ifdef CONFIG_SLUB
- #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
- #define KMALLOC_SHIFT_MAX	(MAX_PAGE_ORDER + PAGE_SHIFT)
- #ifndef KMALLOC_SHIFT_LOW
  #define KMALLOC_SHIFT_LOW	3
  #endif
- #endif
 =20
  /* Maximum allocatable size */
  #define KMALLOC_MAX_SIZE	(1UL << KMALLOC_SHIFT_MAX)

--Sig_/nzPrdCZFY8XSgWxki9yE8uE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTitAACgkQAVBC80lX
0GwStgf+IZvl+B5gAHUm5EuVoEqe2vrUIpYgnxG4oHklgrz9R6qfuOaemRECfELl
7SoHqHWwGsSJniLptwX0jsUTnJH9X9tfb7ML8pO998JwbLc9f8Fm4lpowsMapNmP
jGRqTtnnbgQg3YddlyjWuIdES0OeGJkexz1g5hnocZBhlicitFWq8MmMT2upAxCn
9Qmrdcv4kkkKn5IgMRYsLnkFRnI3Kd7zXhjvRlEb3A4m87jXXZ5BLqUxZaK1S8ec
SQz06sZVhAhDVp1rTxt33+jAkHugk4CTplIBJd4T/eRAJMzaAt2Z9sbXiOAPHBhC
d6oirYA1Uh9Ki9C75EkMHDlVQHMQHg==
=3U+4
-----END PGP SIGNATURE-----

--Sig_/nzPrdCZFY8XSgWxki9yE8uE--

