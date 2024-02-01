Return-Path: <linux-kernel+bounces-48916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD1846328
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D531C24F6C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B463FB2A;
	Thu,  1 Feb 2024 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pV8i93ih"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90954405F8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825353; cv=none; b=JPfnPjbM4bpxMm8cVBPDzGCsaCeGxeWyVFc5+TsUx5wQaBiQ/q886wch4PYgUlm2Bk3atTp3qFIWepU/tBS4iaLjhOQCHKFK4crtl3ewvINrLBfqMMI49XWkvEno69iuPnUtDLwFMEAOFSGHoqdcINO9AGdJw9KQFd3u6O6wcFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825353; c=relaxed/simple;
	bh=FNRWaapzIP96o6avBHUwnyDp2UuzJDEtzi68MNZb3XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgBfsnJHHqBHXDutJFgCG9GAMCoZ8n1JcHegsuYcmZPK3jFHz2W8poGDEP2tE5qJRUHji1iW9XzJZT03mltxb3O/yJufPFXflhzAy4G9i+tI08bZQ86XbGHL7HUjPs411HH35JQ/d8EyLd+jNw/4w3Z2Az76c0PllRPH00ohupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pV8i93ih; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706825346;
	bh=vL7SJZQiX7iBH2yVQNL2VeEYjvGEbCOoRew0Z3DhEek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pV8i93ihpBQWX/Jum97yQQApGrpd9muWbWh8gsRBKxPjOU8wbJEurgEQmCNAq6dly
	 5gsQW24igc680rGzBzMJAACXdSmnWO3JSBW2muSyo9rmKPL4tN1Gu79/OTFiYP8BAd
	 5OgNVBYpIrf+86i0kikm1mI6wSfIHV4YM16BzMCIoMf2V6ttz1R/u2noCQiXJx0C0b
	 O/pmdpEi101tEWzsVCLpMVUPl6Jlo0Xpmpfkg2yN/TP7aJ78K2ysqU5xpN6AVYVi4z
	 JF8eLmG/Uo2b2cuN0SydjhyGlPzHheSxPBD4V8EGhpjnhRjx29C3OkWB0OkMk1xMDI
	 HrWFsbsEtuWfA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQtNJ6PYTz4wcP;
	Fri,  2 Feb 2024 09:09:04 +1100 (AEDT)
Date: Fri, 2 Feb 2024 09:09:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov
 <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com
Subject: Re: [PATCH -mm v2] stackdepot: fix -Wstringop-overflow warning
Message-ID: <20240202090903.6ba062ac@canb.auug.org.au>
In-Reply-To: <20240201090434.1762340-1-elver@google.com>
References: <20240201090434.1762340-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E5HTHIzNlHNnd_U1O+bvlVs";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/E5HTHIzNlHNnd_U1O+bvlVs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu,  1 Feb 2024 10:04:30 +0100 Marco Elver <elver@google.com> wrote:
>
> Since 113a61863ecb ("Makefile: Enable -Wstringop-overflow globally")
> string overflow checking is enabled by default. Within stackdepot, the
> compiler (GCC 13.2.0) assumes that a multiplication overflow may be
> possible and flex_array_size() can return SIZE_MAX (4294967295 on
> 32-bit), resulting in this warning:
>=20
>  In function 'depot_alloc_stack',
>      inlined from 'stack_depot_save_flags' at lib/stackdepot.c:688:4:
>  arch/x86/include/asm/string_32.h:150:25: error: '__builtin_memcpy' speci=
fied bound 4294967295 exceeds maximum object size 2147483647 [-Werror=3Dstr=
ingop-overflow=3D]
>    150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>  lib/stackdepot.c:459:9: note: in expansion of macro 'memcpy'
>    459 |         memcpy(stack->entries, entries, flex_array_size(stack, e=
ntries, nr_entries));
>        |         ^~~~~~
>  cc1: all warnings being treated as errors
>=20
> This is due to depot_alloc_stack() accepting an 'int nr_entries' which
> could be negative without deeper analysis of callers.
>=20
> The call to depot_alloc_stack() from stack_depot_save_flags(), however,
> only passes in its nr_entries which is unsigned int. Fix the warning by
> switching depot_alloc_stack()'s nr_entries to also be unsigned.
>=20
> Link: https://lore.kernel.org/all/20240201135747.18eca98e@canb.auug.org.a=
u/
> Fixes: d869d3fb362c ("stackdepot: use variable size records for non-evict=
able entries")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Just switch 'nr_entries' to unsigned int which is already the case
>   elsewhere.
> ---
>  lib/stackdepot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 8f3b2c84ec2d..4a7055a63d9f 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -420,7 +420,7 @@ static inline size_t depot_stack_record_size(struct s=
tack_record *s, unsigned in
> =20
>  /* Allocates a new stack in a stack depot pool. */
>  static struct stack_record *
> -depot_alloc_stack(unsigned long *entries, int nr_entries, u32 hash, depo=
t_flags_t flags, void **prealloc)
> +depot_alloc_stack(unsigned long *entries, unsigned int nr_entries, u32 h=
ash, depot_flags_t flags, void **prealloc)
>  {
>  	struct stack_record *stack =3D NULL;
>  	size_t record_size;
> --=20
> 2.43.0.429.g432eaa2c6b-goog
>=20

I have applied this patch to the merge of the mm tree today.

--=20
Cheers,
Stephen Rothwell

--Sig_/E5HTHIzNlHNnd_U1O+bvlVs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW8Fn8ACgkQAVBC80lX
0GwEdQf/QnOi4Qm8+1/IkO10QkmuLja/E9BrYs9hA8MrzNS5sUIvOr1HmQEvEP7Y
CdpwEuMEITu9EgLXtwF9LqrddOg3WxHEsMpzwr4XSwJQk+zzyJV9OUMY0LV+OZw2
AT7P083oFYYMhfwvoTHTGMri7LQbB44JMqV+O4814bQCo63YCmDVxvZBc5xEiJT7
qdGhqra4nJpdURCQIpDEBFz49x/NQHsIAeUuqW1mGt963xX7BjfPd/8h7gZFM+PX
rT0n8Nq1YALzqOXO+Q6sG06W2JURy7Pa0Asnc5TQITfD/zL1dV33YF0ljTOD1J8x
qFy9tuJidBXQc4bTX6K7QRA5Mx5TxQ==
=zrpL
-----END PGP SIGNATURE-----

--Sig_/E5HTHIzNlHNnd_U1O+bvlVs--

