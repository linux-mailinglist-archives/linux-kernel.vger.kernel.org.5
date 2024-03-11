Return-Path: <linux-kernel+bounces-99581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9D878A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8861F21C18
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361256B9F;
	Mon, 11 Mar 2024 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CMuMW/8N"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75356B79;
	Mon, 11 Mar 2024 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194184; cv=none; b=WO9dEzmiCSZtHKm8+hh/IL7VEAXg0BNpfWeC+7psjaDRInFCxDnGUUj/cjQBZiwHNsdvqFZX0l7xna7Ff4u22QDG23+3i0KitwXLyUvzbMhZbdDFECjV/esbepC2RzG9bIFpsiHCLbBAYRrfe6frDSyxg1dpWFbK43l+RHZJKPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194184; c=relaxed/simple;
	bh=UIGkaKDh66bPE6UOPBSZSX0hDeAoqr1FyXz1/fGioIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3naa0u1/zHtVeVBynvdo+KSIXfvRAV2Pd0DL/BJAaiUnr2DHkXAdzzlTwSnQ9P9bMZCYZDxUabR3PR4rwnVVOsYBnJKVNhQoop/4uY+sVheLGwBBfSymP4MoYrdXXItVpJHt+GB7UJq9OU5rKsj3tA5CUqiIx1W+BkMGA6Xt5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=CMuMW/8N; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710194179;
	bh=Wz8Ujw3rI9QMgBW9lKvOkkitX0MszA4zxm71kT6Iva4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CMuMW/8NLz+kwdmtnD8Wv9y36hf+JEQuaJfLunM1P/N6Xwdo2xnIsTqbPtxZTKi1N
	 0DqPnRnGRhKBmHyH/U3kuOv6684HFweRHUmjLaekWtqnIL5gWCja0k31kdoJEo1P5d
	 UqoJ36ciyKfXjBTN0YDI+MSYxfOafJZevgT346vvV1pVx+oQcBUdqAknUuAnyzn1tu
	 7TH2LIFBNYMXNTjWKNaqAAEAmqxLHQuYSqh8Af8RmX0yL0UHzBXJBEteiu1AB6Z6g6
	 wTztiEKeVRGevD0QxKgZMbSKdF1YS5yHMfFjLv1Xr1tqOthezVnszp7hHaCnBR9F23
	 ux1FaYDAqUWwA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TtrFb2jHHz4wcT;
	Tue, 12 Mar 2024 08:56:19 +1100 (AEDT)
Date: Tue, 12 Mar 2024 08:56:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the mm
 tree
Message-ID: <20240312085618.55544252@canb.auug.org.au>
In-Reply-To: <20240221103200.165d8cd5@canb.auug.org.au>
References: <20240221103200.165d8cd5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B_1GS=2eiTXdUHjwl6ZQeVC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/B_1GS=2eiTXdUHjwl6ZQeVC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 21 Feb 2024 10:32:00 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   init/main.c
>=20
> between commit:
>=20
>   4728b74d1992 ("arm64, powerpc, riscv, s390, x86: ptdump: refactor CONFI=
G_DEBUG_WX")
>=20
> from the mm-unstable branch of the mm tree and commit:
>=20
>   193d98b1d3aa ("pidfd: add pidfs")
>=20
> from the vfs-brauner tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc init/main.c
> index bc3b6b49b3d8,2fbf6a3114d5..000000000000
> --- a/init/main.c
> +++ b/init/main.c
> @@@ -100,7 -99,7 +100,8 @@@
>   #include <linux/init_syscalls.h>
>   #include <linux/stackdepot.h>
>   #include <linux/randomize_kstack.h>
>  +#include <linux/ptdump.h>
> + #include <linux/pidfs.h>
>   #include <net/net_namespace.h>
>  =20
>   #include <asm/io.h>

This is now a conflict between the mm-stable tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/B_1GS=2eiTXdUHjwl6ZQeVC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXvfgIACgkQAVBC80lX
0GyaYAf/QB2Z1fTgVzq/mbxy9xqw8P4aJdg6qsFQPD/p9jEyc+lFP2SrZRoA7KRl
oUrTFuCAdr2Dio9dK2Kfv+hgHcO7HicLsANPVLdzxL3cQ+c49/62WCxEYONF49F9
8KEq2/J5w8ZruAT1aH0578QPG8d2Jf69e1ViuviCcLBNoHtD34uSPiPEz82hEdv5
KNwZm5pFwSMoozwLJjqIf/i8N43tQ5S6LoqbjQt13Zob51K6Qh6Fs4XHMegwght/
h8/bd+w4qgq2Oh3eaq4VKSwn9VhfSsWbHXHVk3mHUFnkkz5QTBCxZ4fjpuNTMqJ2
PVLOM6vguG0PYHAOy0JIzxxB2wc2Jw==
=noqE
-----END PGP SIGNATURE-----

--Sig_/B_1GS=2eiTXdUHjwl6ZQeVC--

