Return-Path: <linux-kernel+bounces-142051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FAE8A26C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D41DB25656
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7C6446B6;
	Fri, 12 Apr 2024 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FnzK/4HE"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623C3FE37;
	Fri, 12 Apr 2024 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904006; cv=none; b=PdgWwaZLZm+kR/61rA2TOagKA+ol/QRNEtQveLVONwRbj+rIrYD2uFIa61Ku/QbmxPc7wfsjjoixlYODD4TKKUS1kfnjF4oFxhP3f/KMeaIEB2Bmt9h1YFD5Zi/HTp6x+Rt8/C3mhNOiWkeYtwEBWckhjx4XLhMn13SXXqQ/TGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904006; c=relaxed/simple;
	bh=PCkee1BgUzC1EAtuUO8qm/VJInsFRKB7YkPED+SoodI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ak6vu0wPCJzL/uS5iI9AXBWH0G5wKsrIm8J2UsSqj8Iq3VZTd2Mp80ZhVwADefa/nB9wZ66oBotAnwF7bqHvYyhgJJqUCUuAfcp0VZhRs93ncBKRekJ1kWGQffUzSsALyYJN0hOtc9Hcv7SsLoy0KGSfOPpGuSj+LXbo4sHRSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=FnzK/4HE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712904001;
	bh=Y5l5hkAzwvAQKUhuF9D8ucm9ZhOjltCqyRNj+w2o3BA=;
	h=Date:From:To:Cc:Subject:From;
	b=FnzK/4HEukrdWMqC+ByYSwKcGGlT7O2yjXruMRjZEcpfJ90DKUWSTxadJ3YtAhehE
	 aOAzQDqUnAusRO7G40PD1BiJk4Ic1FYAgQMieVYBpHqTESyCU/fTLIf9xNEiqWrbaw
	 HIhGbpFzhzVUpi9kVI9QwbziEUFeUjPX7A8ZebHFgVJZQEWF5NC+0PJwlz0oKcoFEL
	 ATO5um8n8f4Y3CSUT8dgGKrvzI4medx0SanF2DryMPGZ7maJsNh6tSmHN5wYYYXGBC
	 7I0XneF/xf3s9f/MJqVEDuMF0X04bZF/kixxPeorArEqd5blnWahoW8Hthyr6BJjQp
	 uh4lz0aHv6qZw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG6PX4C9Pz4wx5;
	Fri, 12 Apr 2024 16:40:00 +1000 (AEST)
Date: Fri, 12 Apr 2024 16:39:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <v-songbaohua@oppo.com>, Chuanhua Han <hanchuanhua@oppo.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240412163959.3092804a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1r+1bu_1ySpe+jg/pD+T/sB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1r+1bu_1ySpe+jg/pD+T/sB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (x86_64 allnoconfig)
failed like this:

In file included from include/linux/suspend.h:5,
                 from arch/x86/kernel/asm-offsets.c:14:
include/linux/swap.h:568:6: warning: no previous prototype for 'swap_free_n=
r' [-Wmissing-prototypes]
  568 | void swap_free_nr(swp_entry_t entry, int nr_pages)
      |      ^~~~~~~~~~~~
(lots of these)

Caused by commit

  ca23b4d4cae5 ("mm: swap: introduce swap_free_nr() for batched swap_free()=
")

from the mm-unstable branch of the mm tree.

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 12 Apr 2024 16:25:26 +1000
Subject: [PATCH] fixup for "mm: swap: introduce swap_free_nr() for batched
 swap_free()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/swap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b7a107e983b8..d1d35e92d7e9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -565,7 +565,7 @@ static inline void swap_free(swp_entry_t swp)
 {
 }
=20
-void swap_free_nr(swp_entry_t entry, int nr_pages)
+static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 }
=20
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/1r+1bu_1ySpe+jg/pD+T/sB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYY10AACgkQAVBC80lX
0Gy60ggAhf4V6fK4QeUQoYkfBr1uZJev2Iff7FF8D+cSAlBdJEtqEF4Beax/SHGk
XAcpWC2jlZM+pIDPbrPAoSTejdoZ1e+r/sCrjxJoGJJBBsBfYEIeqbnu3ZE5tOaJ
nVVJWwPXmjRsqGjdIViRb/Nb9f3jggz9wW0Vg1eQ2S7WG53reNAcK4aKU/u/jwYG
AwvCHk2TH02vX5g6TsY6RqJ0RkBW+tjiRXLsVJW4xbORPJ4LRbbsFX4ydRo2+zb2
DbfMFSqL/aP+DgY+eDSkTcEoMBaAlkcViNr5j8XVUMcaSvBTi+/bpC5DxfaQvsOj
01is3lnd9D4gj/s94jzIq4KNTurvQg==
=XfYs
-----END PGP SIGNATURE-----

--Sig_/1r+1bu_1ySpe+jg/pD+T/sB--

