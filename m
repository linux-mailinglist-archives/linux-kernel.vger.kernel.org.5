Return-Path: <linux-kernel+bounces-66845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A85856251
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67BC285BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B68A12C54E;
	Thu, 15 Feb 2024 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ84AC55"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2A12AAE5;
	Thu, 15 Feb 2024 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998230; cv=none; b=W0VCudskVAOrvCm8JyAsn/7S6Jp+2PzXYlYldewb0ZFFHZ4zVbDMT8d8H/7XG8wTqQjeCAiGfMGkP+pAecNBnNpM+WJ7KnZJqbiDtJo46ZJju7SsJ2LCQ8l9HNsVBGL0yge/ALswbZSq1qAW7g1RqNeo38nOcs2J6JLMIvWU8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998230; c=relaxed/simple;
	bh=8EtCj8174u/9CY5HA4Rdd9Ev916skpFEoWMR5yIz1Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9YLd0VLVVJ7C3SPyzlcycX46/LPAhM58GfOiaubocEjHvopD+8ljxAceLgKRN3a0V6Nias7I82c5HDaGaOwj18eO8m1X3t7SYEmjkNG+F6CsJ9dOjDPwWW/4lSi0dAK/32YDlN2K+16Nit9n7xXCQ8Dyux4ylupunceE9Lvo4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ84AC55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA4BC43390;
	Thu, 15 Feb 2024 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707998229;
	bh=8EtCj8174u/9CY5HA4Rdd9Ev916skpFEoWMR5yIz1Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQ84AC55K5n9FYtlt2jUyhI/L8qxHMjIenJ7cF4dEyBBnrAaeCFCC6VnbNZ95vxQP
	 njcvBKPpz4pU2B9ViYvpH7Zs/sHlE9tFWwYovTOqrmT3nZYk4oV2go08LKjEFFnXpg
	 I3X07kaPGGeS178gExqPqGuBzgygKADD4m3FHpyQP3tft0U+5LK6lZ+3G8V4nly0uh
	 NCFRgzVTjjz63xAogD/fWdWlZ66k5IB9QBbLkpE30xzyMPFbamBhnUOE0juxlcYww6
	 i+OZvAOP9J7TE1bXIB1S3ZG4bN/5fbx5SYyqpsR5zYzMy9PlS0SR9Zt6hnq/cheQLF
	 9k3Li6CSuPJDQ==
Date: Thu, 15 Feb 2024 12:57:05 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] page_pool: disable direct recycling based on
 pool->cpuid on destroy
Message-ID: <Zc38EQhnIX8IVn5E@lore-desk>
References: <20240215113905.96817-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lhZuqyEuG84JyEoi"
Content-Disposition: inline
In-Reply-To: <20240215113905.96817-1-aleksander.lobakin@intel.com>


--lhZuqyEuG84JyEoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Now that direct recycling is performed basing on pool->cpuid when set,
> memory leaks are possible:
>=20
> 1. A pool is destroyed.
> 2. Alloc cache is emptied (it's done only once).
> 3. pool->cpuid is still set.
> 4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
> 5. Now alloc cache is not empty, but it won't ever be freed.
>=20
> In order to avoid that, rewrite pool->cpuid to -1 when unlinking NAPI to
> make sure no direct recycling will be possible after emptying the cache.
> This involves a bit of overhead as pool->cpuid now must be accessed
> via READ_ONCE() to avoid partial reads.
> Rename page_pool_unlink_napi() -> page_pool_disable_direct_recycling()
> to reflect what it actually does and unexport it.

Hi Alexander,

IIUC the reported issue, it requires the page_pool is destroyed (correct?),
but system page_pool (the only one with cpuid not set to -1) will never be
destroyed at runtime (or at we should avoid that). Am I missing something?

Rergards,
Lorenzo

>=20
> Fixes: 2b0cfa6e4956 ("net: add generic percpu page_pool allocator")
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/net/page_pool/types.h |  5 -----
>  net/core/page_pool.c          | 10 +++++++---
>  net/core/skbuff.c             |  2 +-
>  3 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 3828396ae60c..3590fbe6e3f1 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -210,17 +210,12 @@ struct page_pool *page_pool_create_percpu(const str=
uct page_pool_params *params,
>  struct xdp_mem_info;
> =20
>  #ifdef CONFIG_PAGE_POOL
> -void page_pool_unlink_napi(struct page_pool *pool);
>  void page_pool_destroy(struct page_pool *pool);
>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(vo=
id *),
>  			   struct xdp_mem_info *mem);
>  void page_pool_put_page_bulk(struct page_pool *pool, void **data,
>  			     int count);
>  #else
> -static inline void page_pool_unlink_napi(struct page_pool *pool)
> -{
> -}
> -
>  static inline void page_pool_destroy(struct page_pool *pool)
>  {
>  }
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 89c835fcf094..e8b9399d8e32 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -949,8 +949,13 @@ void page_pool_use_xdp_mem(struct page_pool *pool, v=
oid (*disconnect)(void *),
>  	pool->xdp_mem_id =3D mem->id;
>  }
> =20
> -void page_pool_unlink_napi(struct page_pool *pool)
> +static void page_pool_disable_direct_recycling(struct page_pool *pool)
>  {
> +	/* Disable direct recycling based on pool->cpuid.
> +	 * Paired with READ_ONCE() in napi_pp_put_page().
> +	 */
> +	WRITE_ONCE(pool->cpuid, -1);
> +
>  	if (!pool->p.napi)
>  		return;
> =20
> @@ -962,7 +967,6 @@ void page_pool_unlink_napi(struct page_pool *pool)
> =20
>  	WRITE_ONCE(pool->p.napi, NULL);
>  }
> -EXPORT_SYMBOL(page_pool_unlink_napi);
> =20
>  void page_pool_destroy(struct page_pool *pool)
>  {
> @@ -972,7 +976,7 @@ void page_pool_destroy(struct page_pool *pool)
>  	if (!page_pool_put(pool))
>  		return;
> =20
> -	page_pool_unlink_napi(pool);
> +	page_pool_disable_direct_recycling(pool);
>  	page_pool_free_frag(pool);
> =20
>  	if (!page_pool_release(pool))
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0d9a489e6ae1..b41856585c24 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1018,7 +1018,7 @@ bool napi_pp_put_page(struct page *page, bool napi_=
safe)
>  		unsigned int cpuid =3D smp_processor_id();
> =20
>  		allow_direct =3D napi && READ_ONCE(napi->list_owner) =3D=3D cpuid;
> -		allow_direct |=3D (pp->cpuid =3D=3D cpuid);
> +		allow_direct |=3D READ_ONCE(pp->cpuid) =3D=3D cpuid;
>  	}
> =20
>  	/* Driver set this to memory recycling info. Reset it on recycle.
> --=20
> 2.43.0
>=20

--lhZuqyEuG84JyEoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZc38EQAKCRA6cBh0uS2t
rOtLAQD3JBmShlBpliJcxIqzBFd5Vw12O8XuEw5ESHqBRpi2yQEA1shHcfMpUK41
j5pEAYpRezmFaoDcGroD8y3dKQt/3QM=
=REM3
-----END PGP SIGNATURE-----

--lhZuqyEuG84JyEoi--

