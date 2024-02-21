Return-Path: <linux-kernel+bounces-74942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE285E04B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB37B26A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5037780034;
	Wed, 21 Feb 2024 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMFnpjLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1B3D393;
	Wed, 21 Feb 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527111; cv=none; b=pl3Ns5jUtmm86bdGY89hO91m3zs5zb0emq7JunUIDPsfPeyLRkobRi3hKtCnDaA6AbitpGXbpg6WXRhtp9cYZkQlakdGhQb2xXOR/eggr+2ZZo+jzAQJDZh14FVxM5GGqZUk1gY1WGKkmwmDA3/GE7NazQTAKL54Ul1chjOeD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527111; c=relaxed/simple;
	bh=HPUPYQyaExW8zA3yPaGmJKIXa5Geol1ui08QSwOJ+e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh++fXAcZdF0pi19hWZAlz0XkqaV5QzNljL91UPWdRxEEJ7VWQppKbWk0n50htiEmXBre3QXL1VJItIuqk4BQy8hu4pusvohs4MMEDe1+8vk6u4U5f6RwVWyOoJYfb+OJXeBYhQRV51hShOgR53HTbzkgxaU8eRJLlcu8FsCUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMFnpjLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE38C433C7;
	Wed, 21 Feb 2024 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708527111;
	bh=HPUPYQyaExW8zA3yPaGmJKIXa5Geol1ui08QSwOJ+e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMFnpjLXedjM59DSIP7iXzY0WAdOEKWw2u/GS9ufpmMUhyN1gq2g56jJr1k5cb6me
	 ndysQF7iAZHjVGkxJl2V/twPaSZxqgpBWSG/5mJYAUw71cd0FPPz7UvcHNaAaYvbP2
	 hCl9qtJuDmcpRxM2uSR7CoNhU60gCMgSxl75YS+dcLs8NvtMmXH/jcfLfoTxla6Eam
	 4dGj5WLY8810xEziHMVbFfO3CV5HbXz1e5ojaa/UFlnVAbanhfqAuR0ETEC1wbqWTL
	 nlYTECKP+aLri0NjRU/zScHoCyXQzwcaWAtm3Wa2kgdC6Iqzs/IdkfsR62xmNe2RO9
	 t2iypTiwEKWqQ==
Date: Wed, 21 Feb 2024 14:51:46 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Robin Ehn <rehn@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Stefan O'Rear <sorear@fastmail.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v2] riscv: hwprobe: export largest userspace address
Message-ID: <20240221-pacifism-seismic-589dbbcbf38b@spud>
References: <20240220110950.871307-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XafRae+w6EWwmvjz"
Content-Disposition: inline
In-Reply-To: <20240220110950.871307-1-cleger@rivosinc.com>


--XafRae+w6EWwmvjz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:09:46PM +0100, Cl=E9ment L=E9ger wrote:
> Some userspace applications (OpenJDK for instance) uses the free MSBs
> in pointers to insert additional information for their own logic and
> need to get this information from somewhere. Currently they rely on
> parsing /proc/cpuinfo "mmu=3Dsvxx" string to obtain the current value of
> virtual address used bits [1]. Since this reflect the raw MMU mode
> supported, it might differ from the logical one used internally.
> Exporting the maximum mmappable address through hwprobe will allow a
> more stable interface to be used. For that purpose, add a new hwprobe
> key named RISCV_HWPROBE_MAX_KEY which will export the maximum mmappable
> userspace address.
>=20
> Link: https://github.com/openjdk/jdk/blob/master/src/hotspot/os_cpu/linux=
_riscv/vm_version_linux_riscv.cpp#L171 [1]
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

Doesn't build for nommu:
https://patchwork.kernel.org/project/linux-riscv/patch/20240220110950.87130=
7-1-cleger@rivosinc.com/

Cheers,
Conor.

--XafRae+w6EWwmvjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdYOAgAKCRB4tDGHoIJi
0obVAQC6GAs9ZIYjcC3yuuwCX/HL09UmNvDXdYBZhG/lJ6OKywEAp01wPF8n5uxf
K6XtGuHbFpAbomgUMPBexQpL2ieUxgM=
=gv0b
-----END PGP SIGNATURE-----

--XafRae+w6EWwmvjz--

