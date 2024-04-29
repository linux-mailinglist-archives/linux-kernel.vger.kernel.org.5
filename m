Return-Path: <linux-kernel+bounces-161671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235678B4F41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15841F21CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD831C10;
	Mon, 29 Apr 2024 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YYV+sJQ2"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC47F;
	Mon, 29 Apr 2024 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714354994; cv=none; b=eIDG/oGCmLuqmCi588NcBMUMvTB99ATt5OCgRo6ZOGbnKc7a3ZqCJF87IMuIV9LSIOKjQpblLCfw3+ouImDdfOpE9JPBpz1cfVXMjwHsgTVKVqA+KRF5RzP4WJYd7LzgC4tSFlD6qV/IXhblIljrsTOGgp83cX1sVdTecLQEyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714354994; c=relaxed/simple;
	bh=dCwF0j7zBDqMvnlF3bUjK48/1jRHPwdPDgA3fd6oL+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ApDBR5XAZ9ZtyTURzJ3k7adr8pyuVXm3fb8IhdPpXfgAfADw1wqRNwyvE9awm9MkmssJYflqaWDGKyLZWy1V7d5ocZIZTbMkLZciu4AdVxXG67LzNQGHTVInjYrhjjhWMPf0CQ52my61g0d82A4Yvs5oC8YhH6Lg7c9BNDVVOQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YYV+sJQ2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714354988;
	bh=kJGpqHMHf3TJHbDG92G2y67dwb+ccaXeVDDi+a9AI/Y=;
	h=Date:From:To:Cc:Subject:From;
	b=YYV+sJQ2KvxOD7ourWh+8IbVDPDBqAbw4Ayr6uZUUPswxYE3/c/EmkulGdh0Hcn5I
	 R2lIBKwLKWvA/edivywGbK+SqULFTkYqo9r5WWWpnerJsl6djRZAyCpj9dqTyKg3Ao
	 vcBKmjCb3zwAyCdX1GqDoOsNiB/jjvQlOaAvUO8+C8jDeoRQz5caPtKPlyuLTiwiCW
	 2D8z0UFH/4tbrfjxENgDY4+cpoMBIbVEAa9GL8MMh/La0/BDXctE1zK5/5hdijSEYk
	 mJyKMlzyy4BNpNj0xHxLFudaIoUYLjpwC0ANlYUHBByxhkhme7IX2FWRC3SQjb1Fi4
	 5OaFPUx7UiDCw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSR161VV5z4wcC;
	Mon, 29 Apr 2024 11:43:05 +1000 (AEST)
Date: Mon, 29 Apr 2024 11:43:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Networking <netdev@vger.kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Suren
 Baghdasaryan <surenb@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: linux-next: manual merge of the net-next tree with the mm tree
Message-ID: <20240429114302.7af809e8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D4n1Gf9_x.KYjM/8OG3/Mn_";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/D4n1Gf9_x.KYjM/8OG3/Mn_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/linux/slab.h

between commit:

  7bd230a26648 ("mm/slab: enable slab allocation tagging for kmalloc and fr=
iends")

from the mm_unstable branch of the mm tree and commit:

  a1d6063d9f2f ("slab: introduce kvmalloc_array_node() and kvcalloc_node()")

from the net-next tree.

I fixed it up (maybe? see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/slab.h
index 4cc37ef22aae,d1d1fa5e7983..000000000000
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@@ -773,40 -744,66 +773,47 @@@ static inline __alloc_size(1, 2) void *
   * @size: how many bytes of memory are required.
   * @flags: the type of memory to allocate (see kmalloc).
   */
 -static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
 +static inline __alloc_size(1) void *kzalloc_noprof(size_t size, gfp_t fla=
gs)
  {
 -	return kmalloc(size, flags | __GFP_ZERO);
 +	return kmalloc_noprof(size, flags | __GFP_ZERO);
  }
 +#define kzalloc(...)				alloc_hooks(kzalloc_noprof(__VA_ARGS__))
 +#define kzalloc_node(_size, _flags, _node)	kmalloc_node(_size, (_flags)|_=
_GFP_ZERO, _node)
 =20
 -/**
 - * kzalloc_node - allocate zeroed memory from a particular memory node.
 - * @size: how many bytes of memory are required.
 - * @flags: the type of memory to allocate (see kmalloc).
 - * @node: memory node from which to allocate
 - */
 -static inline __alloc_size(1) void *kzalloc_node(size_t size, gfp_t flags=
, int node)
 -{
 -	return kmalloc_node(size, flags | __GFP_ZERO, node);
 -}
 +extern void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node) __a=
lloc_size(1);
 +#define kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__=
))
 =20
 -extern void *kvmalloc_node(size_t size, gfp_t flags, int node) __alloc_si=
ze(1);
 -static inline __alloc_size(1) void *kvmalloc(size_t size, gfp_t flags)
 -{
 -	return kvmalloc_node(size, flags, NUMA_NO_NODE);
 -}
 -static inline __alloc_size(1) void *kvzalloc_node(size_t size, gfp_t flag=
s, int node)
 -{
 -	return kvmalloc_node(size, flags | __GFP_ZERO, node);
 -}
 -static inline __alloc_size(1) void *kvzalloc(size_t size, gfp_t flags)
 -{
 -	return kvmalloc(size, flags | __GFP_ZERO);
 -}
 +#define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NO=
DE)
 +#define kvmalloc_noprof(_size, _flags)		kvmalloc_node_noprof(_size, _flag=
s, NUMA_NO_NODE)
 +#define kvzalloc(_size, _flags)			kvmalloc(_size, _flags|__GFP_ZERO)
 =20
 -static inline __alloc_size(1, 2) void *
 -kvmalloc_array_node(size_t n, size_t size, gfp_t flags, int node)
 +#define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, _flags|_=
_GFP_ZERO, _node)
 +
- static inline __alloc_size(1, 2) void *kvmalloc_array_noprof(size_t n, si=
ze_t size, gfp_t flags)
++static inline __alloc_size(1, 2) void *kvmalloc_array_node_noprof(size_t =
n, size_t size, gfp_t flags)
  {
  	size_t bytes;
 =20
  	if (unlikely(check_mul_overflow(n, size, &bytes)))
  		return NULL;
 =20
 -	return kvmalloc_node(bytes, flags, node);
 -}
 -
 -static inline __alloc_size(1, 2) void *
 -kvmalloc_array(size_t n, size_t size, gfp_t flags)
 -{
 -	return kvmalloc_array_node(n, size, flags, NUMA_NO_NODE);
 +	return kvmalloc_node_noprof(bytes, flags, NUMA_NO_NODE);
  }
 =20
- #define kvmalloc_array(...)			alloc_hooks(kvmalloc_array_noprof(__VA_ARGS=
__))
+ static inline __alloc_size(1, 2) void *
+ kvcalloc_node(size_t n, size_t size, gfp_t flags, int node)
+ {
 -	return kvmalloc_array_node(n, size, flags | __GFP_ZERO, node);
++	return kvmalloc_array_node_noprof(n, size, flags | __GFP_ZERO, node);
+ }
+=20
 -static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gf=
p_t flags)
 -{
 -	return kvmalloc_array(n, size, flags | __GFP_ZERO);
 -}
++#define kvmalloc_array(...)			alloc_hooks(kvmalloc_array_node_noprof(__VA=
_ARGS__))
++#define kvmalloc_array_noprof(_n, _size, _flags))	kvmalloc_array(_n, _siz=
e, _flags)
 +#define kvcalloc(_n, _size, _flags)		kvmalloc_array(_n, _size, _flags|__G=
FP_ZERO)
- #define kvcalloc_noprof(_n, _size, _flags)	kvmalloc_array_noprof(_n, _siz=
e, _flags|__GFP_ZERO)
++#define kvcalloc_noprof(_n, _size, _flags)	kvmalloc_array_node_noprof(_n,=
 _size, _flags|__GFP_ZERO)
 =20
 -extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp=
_t flags)
 +extern void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsi=
ze, gfp_t flags)
  		      __realloc_size(3);
 +#define kvrealloc(...)				alloc_hooks(kvrealloc_noprof(__VA_ARGS__))
 +
  extern void kvfree(const void *addr);
  DEFINE_FREE(kvfree, void *, if (_T) kvfree(_T))
 =20

--Sig_/D4n1Gf9_x.KYjM/8OG3/Mn_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYu+yYACgkQAVBC80lX
0Gzvuwf/ekJ2/iUeN3NsK39CXAiZmPUphSJOS+QRZUlCLZFD7kGSg2n+EvOTsCD+
X5FFXpwIajEy03ctJ240eJcDW0IoT3sHe5y5tlH40LdE1NVOv4NW5nWl8YZ8JYVO
bdkXIAckEVIbIFNRE5YV/lPSNrxxGbjFg90CywmCsI9y7cIjP0FYNjHppxMAPvyw
n+wT+aLgXYTUnfgF49/+3ju1ZiIX6j95pB8XaV/yUgJGbtUxuHMGv2Fqec48xSA7
+jlOr6dIQeXqrlCxuiaHCvlIEJHVVP889RFJB88D/G4cT8SgJHLTQxwXqycIoqJf
DXTH6NVZkshM2ExDeqhBVBui/w2yGg==
=FLmK
-----END PGP SIGNATURE-----

--Sig_/D4n1Gf9_x.KYjM/8OG3/Mn_--

