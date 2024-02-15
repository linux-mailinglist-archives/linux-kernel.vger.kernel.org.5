Return-Path: <linux-kernel+bounces-66272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A0F85598E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD291F26330
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EED7475;
	Thu, 15 Feb 2024 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZXtLaCrj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E946FAF;
	Thu, 15 Feb 2024 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707968865; cv=none; b=XykLgDPXqZcrD34eaTlHmAhammUcntZaZpaumGw5nJ8WTHNLtXXYailuMyJq3Rnc4B1MH+Jv05v0e1rvVGcZMSGIsPJo4yJgs5XdGHWw/AbuVL6QejqmqsNx6YTb2KQicRF/rTHRE1VXq1bxCq6ZUkMoP0UtJB+HPA++lQuShUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707968865; c=relaxed/simple;
	bh=d9JIEffC0Ru+l8d00ZWYMJ6rCCcbMiSITba4JL8uUnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TID/hX78ZlG0tZ3gDt9Uj8Fvax5mGthRsSyS/hnwmmZ/2Di0pMqY6gqn7VOnBs75IrBsbVO0FNrafaHKuJjLLvCWbtJ8hd5VKWWbiS6nj9CMNuwd2Fjq1r6XlKvATH1JS/+QPOeI1kQT/DVRTQPXeIb3vwWcqnXGmH4Dvl3WDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ZXtLaCrj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707968858;
	bh=vnImonB9giYOEiEgQMk/p1YJhq0VELghflUVqAoT0fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZXtLaCrjjq9Pl+M+KwkfK++aDL2/mmyeIvjACQv60D10Mmrd2IHz7u4j/4hGDgzWA
	 8ToDr+tineodnZsKle0McJ+XYukjlAqVj/pX+CfUt8BWV4m4kjVqYdT6oL834RzNMm
	 5rk6lRMJSH7Zm+vY9bG6hTBxtKEKseTYjnwRNHcx1QzkRBpv772+WtyUlEaXLWZmGl
	 lbddf7bbxp4wIsvR0Pomol6VuoUZIVg1+VkPO+PsPeygtcQgwrdGUUiCQvJGo+209d
	 hT9VWhg6Tiq4hVkAMw/7mqRWXRRy6VhJGOPA2d9lYZE1VVztYyDs+b1e83C3UjuXAw
	 zW++byOCzh5Mg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tb1Gy2grwz4wyt;
	Thu, 15 Feb 2024 14:47:38 +1100 (AEDT)
Date: Thu, 15 Feb 2024 14:47:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20240215144736.21e8c19f@canb.auug.org.au>
In-Reply-To: <20240214071938.f8ca072c08e618b483bae1c7@linux-foundation.org>
References: <20240214145719.1cc4f320@canb.auug.org.au>
	<20240214071938.f8ca072c08e618b483bae1c7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KDdd4i5c=QStkA6TAQbhr9v";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/KDdd4i5c=QStkA6TAQbhr9v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 14 Feb 2024 07:19:38 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Wed, 14 Feb 2024 14:57:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > After merging the mm tree, today's linux-next build (sparc defconfig)
> > failed like this:
> >=20
> > In file included from include/linux/page_ext.h:7,
> >                  from include/linux/mm.h:22,
> >                  from fs/sysfs/file.c:18:
> > include/linux/stackdepot.h:59:39: error: 'CONFIG_STACKDEPOT_MAX_FRAMES'=
 undeclared here (not in a function)
> >    59 |                 unsigned long entries[CONFIG_STACKDEPOT_MAX_FRA=
MES];    /* Frames */
> >       |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> >=20
> > (and many more)
> >=20
> > Caused by commit
> >=20
> >   18d4230bb372 ("lib/stackdepot: move stack_record struct definition in=
to the header") =20
>=20
> Thanks, I'll try this.
>=20
>=20
> --- a/include/linux/stackdepot.h~lib-stackdepot-move-stack_record-struct-=
definition-into-the-header-fix
> +++ a/include/linux/stackdepot.h
> @@ -39,6 +39,7 @@ typedef u32 depot_stack_handle_t;
>  #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
>  			       STACK_DEPOT_EXTRA_BITS)
> =20
> +#ifdef CONFIG_STACKDEPOT
>  /* Compact structure that stores a reference to a stack. */
>  union handle_parts {
>  	depot_stack_handle_t handle;
> @@ -73,6 +74,7 @@ struct stack_record {
>  		};
>  	};
>  };
> +#endif
> =20
>  typedef u32 depot_flags_t;
> =20
> _
>=20

Works for me.

--=20
Cheers,
Stephen Rothwell

--Sig_/KDdd4i5c=QStkA6TAQbhr9v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXNiVgACgkQAVBC80lX
0GxrVgf7B3HdXv1Cvhvc8iVm301x25+WCxOcamW3CCVVZLLdWO0xuuJutjqXNwdU
wQ9zecGtrsKz2GU4CmNrthDTzSqCkvLOiFhfArd47GlOX9exzrUQ9IiwWD71bjps
6aNin3cbTQ2kZFF5U1hBMLzdMJyWYrLK8eOHeIwCIaL9rw68SfcNFBAhpmLVIhd8
14LeyV2RSxCRt94tVbFxXOYQhuIl4euFMtLlkEcUiyGZ1U43UdIk1U1swZ7XgtKV
NwMgkf3Hh7HZC/cacs55jzD6lQAEfKyNfOOSa5NiijrUmmjNfIHziPkmepMXN58b
wtAH73G9UUjllelV5mLx+pllOJHByg==
=l3Fb
-----END PGP SIGNATURE-----

--Sig_/KDdd4i5c=QStkA6TAQbhr9v--

