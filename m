Return-Path: <linux-kernel+bounces-161684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E648B4F76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7396A1C20B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD67460;
	Mon, 29 Apr 2024 02:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RuKGoTx2"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470EA7FE;
	Mon, 29 Apr 2024 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714358038; cv=none; b=UztlGvs4zq0NLaMLAPLRqKk82uk64F1JVAP7eYFI+oBPj2JB7K4IZuIkPushkhqGFCIbA6RZg1l7b3DBM5AHrGJqcZhipXvfwCnHhe0Kf84Ai+rjdZCl67AH2SClaRKg1/ECdzHmqFiSG+hND6U1oEBzg3umb20oCaX+RBRVl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714358038; c=relaxed/simple;
	bh=h/opiJnZpmZpouz2+MELfEpG2wucS5m9X5tSKHAMWMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMc6EGx0fqKrWKuvj8raGlRCHRnIp9stOzczCdK9wZVkpi3oR91eJuSAbx1X8X7MNOKTsoT9MWSTdImYvfIT8U4EyZZOmFztNaHgPJRIJpXc7miiGN0sW6liOtpfk6xJsl7F7fvhPdR/ddt4MfBAyUBMIBa0013xpoZ5e1N//tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RuKGoTx2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714358033;
	bh=u+UhjTsEA+5N3Ev1yrs7sFh5vXXmYDontS3DPeNM0nM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RuKGoTx2HCgKZYhtA68KTpE3pbJtqYmJGZtddK9JBdvtUk19hv1jqp9GifeEUGwRl
	 tiO5nqvXY8ltJ7KfEP699yM4feAVq7Xq0wMHfAtZgodT2qPdlQwE1TIPEGhLd8Eh3B
	 DMObZAqCahcmPuhVbFU6OM7X4ThEYimGG8hAEUkkvUce7cZFU/4DWQ3rBqWnL/KeWl
	 6e6MABEEmM9FJaHzsV6xlrLk337U452uMv4PHpRf8LTJri2htbfIz6okvgLlpt0TkJ
	 9Xbz0uMa/jK3xMWsw3NMxUgvv7kxQcj0cOr1baVUKavibzbPd/WKX9JosBICSwPynb
	 /jAu1/NXDzYKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSS7h52dBz4wyk;
	Mon, 29 Apr 2024 12:33:51 +1000 (AEST)
Date: Mon, 29 Apr 2024 12:33:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Networking <netdev@vger.kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Suren
 Baghdasaryan <surenb@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: linux-next: manual merge of the net-next tree with the mm tree
Message-ID: <20240429123351.03b44797@canb.auug.org.au>
In-Reply-To: <20240429114302.7af809e8@canb.auug.org.au>
References: <20240429114302.7af809e8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/85.Si+AxzyH5ns4uTat.sbw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/85.Si+AxzyH5ns4uTat.sbw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 29 Apr 2024 11:43:02 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   include/linux/slab.h
>=20
> between commit:
>=20
>   7bd230a26648 ("mm/slab: enable slab allocation tagging for kmalloc and =
friends")
>=20
> from the mm_unstable branch of the mm tree and commit:
>=20
>   a1d6063d9f2f ("slab: introduce kvmalloc_array_node() and kvcalloc_node(=
)")
>=20
> from the net-next tree.
>=20
> I fixed it up (maybe? see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

I tried again, see below.
--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/slab.h
index 4cc37ef22aae,d1d1fa5e7983..88426b015faa
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@@ -773,40 -744,66 +773,54 @@@ static inline __alloc_size(1, 2) void *
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
n, size_t size, gfp_t flags, int node)
  {
  	size_t bytes;
 =20
  	if (unlikely(check_mul_overflow(n, size, &bytes)))
  		return NULL;
 =20
- 	return kvmalloc_node_noprof(bytes, flags, NUMA_NO_NODE);
 -	return kvmalloc_node(bytes, flags, node);
++	return kvmalloc_node_noprof(bytes, flags, node);
+ }
+=20
++#define kvmalloc_array_node(...)	alloc_hooks(kvmalloc_array_node_noprof(_=
_VA_ARGS__))
++
+ static inline __alloc_size(1, 2) void *
+ kvmalloc_array(size_t n, size_t size, gfp_t flags)
+ {
+ 	return kvmalloc_array_node(n, size, flags, NUMA_NO_NODE);
+ }
++#define kvmalloc_array_noprof(_n, _size, _flags)	kvmalloc_array(_n, _size=
, _flags)
+=20
+ static inline __alloc_size(1, 2) void *
+ kvcalloc_node(size_t n, size_t size, gfp_t flags, int node)
+ {
 -	return kvmalloc_array_node(n, size, flags | __GFP_ZERO, node);
++	return kvmalloc_array_node_noprof(n, size, flags | __GFP_ZERO, node);
  }
 =20
- #define kvmalloc_array(...)			alloc_hooks(kvmalloc_array_noprof(__VA_ARGS=
__))
 -static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gf=
p_t flags)
 -{
 -	return kvmalloc_array(n, size, flags | __GFP_ZERO);
 -}
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

--Sig_/85.Si+AxzyH5ns4uTat.sbw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYvBw8ACgkQAVBC80lX
0Gx4JggApEOgP/Pl3GMzrZ86iVsw6wLb/fOfqnbppBQd4aWZKSAO7+0E+jzT9ikG
L1UKvw60OW604oxPIze5cT1MRvOpa8cygRAnxiHpzj3IV85+2HrzMrXvsSLC+k0X
G4KysLSW8BzRHDLGW7KxbJmRHKbvMTCleEr95xf5s/OcTyJ+WqFUK7LyA9fwiCVl
82WaVbfzHTtoUSqjaJJgql5aBBYmAAlILMnyOkOTJZcmZBmDQhAzPmMtDAiy9hk2
jx+dVQ63GA5YUAgz9L9MWAbjxLeHiBnLAynPhRBeAraUV8Ossk0EE45y6S8+UfYM
NerMlORefcxIf3R3O3+QnCtO6QIfCw==
=pfHy
-----END PGP SIGNATURE-----

--Sig_/85.Si+AxzyH5ns4uTat.sbw--

