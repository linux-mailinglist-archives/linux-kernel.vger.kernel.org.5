Return-Path: <linux-kernel+bounces-42689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E861E84050B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C1C282A68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8285660DEF;
	Mon, 29 Jan 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpESaN2A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFA3527A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531463; cv=none; b=e41JgxZPfPN7itRf6tsWzBIeiS62cIt1dlyif8A0DwJB3ioKwVcL5zqt/mQFWcgtWe4BD3kQdTfgBTUyLMRT05NijiuJdEKH7x308vNv4EJG9DO9VKg26PcTvHCwNhPt8HbsVoW/QEOyP7DprgR00RmKrGSO5q1Cg6AS1IQpkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531463; c=relaxed/simple;
	bh=OMjG087pQhKBaSUbWJ01ewqPvsYZPCOIy7ZK/xWIyLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLw2Gv8fd4CFJpm2+jl8xbVGPMaavoRmN8Ai4AZiiSqDuISfbD20mMGVj0KKeIdcnlJbh9wBimm9BaWpZaztmoyBJTGaQbRvOHSLqqaL5rDJt0UssFQVJy/D4KKJzjaiKPCfbYIODjd/Bdjr3zKzJYS9WIDATTglyfkAqOh1cFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpESaN2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8200AC433C7;
	Mon, 29 Jan 2024 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706531463;
	bh=OMjG087pQhKBaSUbWJ01ewqPvsYZPCOIy7ZK/xWIyLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpESaN2AmpfQFQYUKYs+EQbLWFkPPNM+IzD4Jn9kW1zbuPrDWsV+go03/pzx2lFuF
	 r2X09hQBKVNvGDGOs1+Jn+JF1KLoqQ/J5L0aI3h/1p0CxRKVfD2z4m1NfxDlHiFU2h
	 xGCenlPZpg72QOMHycpLzAMC/TzA8H+aScDbhWO4M7zIhh9gisOoIRhGZ8k1ug62rX
	 DRlzGBJqjSv75FCBDIG5xdWJEmhIo2uAKAsKDwtav/ouSgPRfVL3useLSi2i0cxBrL
	 JWX6m2gs0/H8gCAU4Aac91MhjZgp+0KjWEi99pX2j98Wg9YMgWEgQ1GJRh44yWUxp0
	 unmvaNfw68XKw==
Date: Mon, 29 Jan 2024 12:30:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	sudeep.holla@arm.com, robh@kernel.org, conor.dooley@microchip.com,
	suagrfillet@gmail.com
Subject: Re: [RFC v1 2/2] riscv: cacheinfo: Refactor populate_cache_leaves()
Message-ID: <20240129-parrot-dropout-c4ece33a98da@spud>
References: <20240129075957.116033-1-jeeheng.sia@starfivetech.com>
 <20240129075957.116033-3-jeeheng.sia@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vVQN45TubuFKPBU4"
Content-Disposition: inline
In-Reply-To: <20240129075957.116033-3-jeeheng.sia@starfivetech.com>


--vVQN45TubuFKPBU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Firstly, the $subject should really mention that the motivation for the
refactoring is ACPI support.

On Sun, Jan 28, 2024 at 11:59:57PM -0800, Sia Jee Heng wrote:
> Refactoring the cache population function to support both DT and
> ACPI-based platforms.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>  arch/riscv/kernel/cacheinfo.c | 47 ++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 30a6878287ad..f10e26fb75b6 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -74,36 +74,27 @@ int populate_cache_leaves(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
>  	struct cacheinfo *this_leaf =3D this_cpu_ci->info_list;
> -	struct device_node *np =3D of_cpu_device_node_get(cpu);
> -	struct device_node *prev =3D NULL;
> -	int levels =3D 1, level =3D 1;
> -
> -	if (of_property_read_bool(np, "cache-size"))
> -		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> -	if (of_property_read_bool(np, "i-cache-size"))
> -		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> -	if (of_property_read_bool(np, "d-cache-size"))
> -		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> -
> -	prev =3D np;
> -	while ((np =3D of_find_next_cache_node(np))) {
> -		of_node_put(prev);
> -		prev =3D np;
> -		if (!of_device_is_compatible(np, "cache"))
> -			break;
> -		if (of_property_read_u32(np, "cache-level", &level))
> -			break;
> -		if (level <=3D levels)
> -			break;
> -		if (of_property_read_bool(np, "cache-size"))
> -			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> -		if (of_property_read_bool(np, "i-cache-size"))
> -			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> -		if (of_property_read_bool(np, "d-cache-size"))
> +	unsigned int level, idx;
> +
> +	for (idx =3D 0, level =3D 1; level <=3D this_cpu_ci->num_levels &&
> +	     idx < this_cpu_ci->num_leaves; idx++, level++) {
> +		/*
> +		 * Since the RISC-V architecture doesn't provide any register for dete=
cting the
> +		 * Cache Level and Cache type, this assumes that:
> +		 * - There cannot be any split caches (data/instruction) above a unifi=
ed cache.
> +		 * - Data/instruction caches come in pairs.
> +		 * - Significant work is required elsewhere to fully support data/inst=
ruction-only
> +		 *   type caches.
> +		 * - The above assumptions are based on conventional system design and=
 known
> +		 *   examples.

I don't think this comment matches what you are doing.

For example, the comment only requires that split caches cannot be above
unified ones, but the code will always make a level 1 cache be split and
higher level caches unified.

The place you took the comment about the split caches from does not
enforce the type of cache layout that you do where the 1st level is
always split and anything else is unified.

populate_cache_leaves() only gets called in a fallback path when the
information has not already been configured by other means (and as you
probably noticed on things like arm64 it uses some other means to fill
in the data).

Is there a reason why we would not just return -ENOENT for ACPI systems
if this has not been populated earlier in boot and leave the DT code
here alone?

Thanks,
Conor.

> +		 */
> +		if (level =3D=3D 1) {
>  			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> -		levels =3D level;
> +			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> +		} else {
> +			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> +		}
>  	}
> -	of_node_put(np);
> =20
>  	return 0;
>  }
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--vVQN45TubuFKPBU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbeagwAKCRB4tDGHoIJi
0p2vAP91xqgYKdI5R4E8M2TeUKf7W4MillrhtPoe4A++bU5YagD+NYICS59UguEb
kC/D3NRlCAVajtBJRjiLWpUC77PETws=
=E7YN
-----END PGP SIGNATURE-----

--vVQN45TubuFKPBU4--

