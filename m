Return-Path: <linux-kernel+bounces-132298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419CD8992AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB58828934F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D4C6FB8;
	Fri,  5 Apr 2024 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YZKsd+a3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961245258;
	Fri,  5 Apr 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712278286; cv=none; b=MPUgApoCWq+LpSZ2ctJbFCF3AUAllki7Sl/hlWwEO8U1uuJ7VkHwBM1qWqr0WV9d3ReuCKOZEGqEmdsaEroKqV/QxwwL7LajzyAwE1W3NphPPBuvXS1JTmgniSislh8ysQb2AXi/2QZd7LqnCdbXxAGVdB830Phxe00P9u1Dq3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712278286; c=relaxed/simple;
	bh=pjrhOaLsXXpOmwKXuBc00FUe1MGQYcZ25af8LTVmY9s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uymaQPkms2qBsgxeyy9FN/9jpIhxdYE9pIgPfBa8k+vrU3umd7FzsIBAXPML2w1dZX5oyQB7MxtepI16oBEmH/2BwT2U77+oveyvOLbyM45Mnx8tc2/meiQn3SBlo4dQMqcR1VHChgWdCEQvklSfj7W/+EzZtXKr8IeB/wCAzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YZKsd+a3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712278275;
	bh=0xcpK+/tp61187jUvOW+Gbn+cQ5wB0S6ZpepQtQQhUQ=;
	h=Date:From:To:Cc:Subject:From;
	b=YZKsd+a3JASN2obqsHUre8Y9CrljCrrxXsFcqoZ87k1DoXfgbjy7ZK0FfiqltY6EC
	 hiij8dr7ghkFKGXWrl2iiYDrt8OYXThkQKlpe3uS959V/7hYs/8U5B7RbecguV1r+n
	 5LGXGFE1ovgllaJidIvPVftBRy/n9AYrBkgVrKup2e2voujcBA668OXnPPwdaffL69
	 Y+OKjHgGCs91twu0CL3k2wrDqgE8vceA4CpPAc8BPxbQdp4c9CULK6ax2RV+fTjGzA
	 ymJWa879xgPb/vEPAHcL1DWCHw4bSwhcA9J4nJtvLDSNsca5AX5iO9N843pxeBc9J7
	 U0sVJ2ttg5OCw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V9g0L1QjMz4wcd;
	Fri,  5 Apr 2024 11:51:14 +1100 (AEDT)
Date: Fri, 5 Apr 2024 11:51:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the tip tree with the mm tree
Message-ID: <20240405115111.132053a5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tVck7d_9CMMHvmaGVlfnBdx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tVck7d_9CMMHvmaGVlfnBdx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/mm/numa_32.c

between commit:

  d82a37ff6b88 ("fixup! fix missing vmalloc.h includes")

from the mm-unstable branch of the mm tree and commit:

  9852b1dc6a14 ("x86/numa/32: Include missing <asm/pgtable_areas.h>")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/mm/numa_32.c
index e25e08ba4531,025fd7ea5d69..000000000000
--- a/arch/x86/mm/numa_32.c
+++ b/arch/x86/mm/numa_32.c
@@@ -24,7 -24,7 +24,8 @@@
 =20
  #include <linux/memblock.h>
  #include <linux/init.h>
 +#include <linux/vmalloc.h>
+ #include <asm/pgtable_areas.h>
 =20
  #include "numa_internal.h"
 =20

--Sig_/tVck7d_9CMMHvmaGVlfnBdx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYPSv8ACgkQAVBC80lX
0GyTcQgApTZIaZ8GULdnEH+9OBQSVde20ZMDYE+UstexmVJ90uVTy5mCzoZtjkSH
lY33730MOjVAI0QW//WT9KWg8eZ/uu6z/0HhwZRMgilJGC5XselLGRf7hdF4wf/h
Y+UX3IgZjA13uFAuIqHtjA1zOxVGqEqWnJ24xzCX4ckVDk3vgyQPg1jFvMFyW5Gc
XAoCd/zLlfDPnUR3C3FHV2G1kOuDwwhHDQ4NHqxIUxOGaRF6o0IwLvalEkmhFiRq
nbc2xWCpcZLehGZN7Tj2fWG3BLUZgm2ucP2OGeJM3PF3sjrsHF+VzlYkL5Or34Qa
y0G3n9RYJYtCErIdjFxyeMF0FU2hXQ==
=1zT6
-----END PGP SIGNATURE-----

--Sig_/tVck7d_9CMMHvmaGVlfnBdx--

