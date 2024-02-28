Return-Path: <linux-kernel+bounces-85273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB78086B34A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF481F239CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F59E15CD7E;
	Wed, 28 Feb 2024 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBbUo0BS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538315B99D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134654; cv=none; b=nO5D+QhS/LpErWLJ/FadJrjVWjsCY3Vo3/cIx3/81Vi2iEJ0f4kv/YVboHaWpfzWooqXeR5sHH9NjIIlc4WlQHyQh7w+jya1SQK+2Z66aODeI8i6x2VWVum9mrU7ziTnuTbaKDt2JtGN3D9gPHec4WGhOoWBTMwhfAtuMUFCpuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134654; c=relaxed/simple;
	bh=K6qcyY7tmKWlPwGFAWfBA2nTcEkDy4NjDJTddRb/t88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esuLiJMkiFAkcAsZnNyn+rQ1ISwcbQnb43cC8wCeeTmgakNTxRX/ZYNWzUxJYNA0ZTl5WmhCkTxTfFoY4CMDGhXPqq1gd0WGosJc8shUzmEopVsziCV6ZK3Oe58ITCRRi7VWJ+34Ht122FewbkwiG32TKjaiFpxfGldev5Y3t1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBbUo0BS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5628C433C7;
	Wed, 28 Feb 2024 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709134654;
	bh=K6qcyY7tmKWlPwGFAWfBA2nTcEkDy4NjDJTddRb/t88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VBbUo0BSkLc1goRk+1bILw3JXxuPO45gtApjIESIr+gZ6qaqZ8e2co3Ns1HZaxItg
	 msP9WS7J1W84wjFIUkCkmn3RXwpO0QSA33aAhBHGiptNYX/zPhV4M1zTyco++lgyPO
	 YwBfySTgUpqBBcI2AidKGkwmCwWBjjOgKXmKHefN6uRsb5s/ex6wMWDoyPLxZEK/8h
	 kgM4ZMNqI7WweDxblbx9wlEfY6c5ejINnPjZTjt80BkwxpdYntbIN1rL8A9ny8tSjz
	 AE75D4NrWvCDVzPdjKWrJ6y2GEtFz7P8E3mhAu2V1qnXt67h1gJCt2dXVHBoedoZha
	 kVQqYPFjmsZvA==
Date: Wed, 28 Feb 2024 15:37:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] riscv: Fix loading 64-bit NOMMU kernels past the
 start of RAM
Message-ID: <20240228-cavity-aground-d1e8072a2c0d@spud>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
 <20240227003630.3634533-3-samuel.holland@sifive.com>
 <20240227-unfitting-rectangle-cd0f23a4f3f1@wendy>
 <9673cbe7-41ec-4261-9be8-fc5191ade56c@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="29t4/8GEDLrsNf/T"
Content-Disposition: inline
In-Reply-To: <9673cbe7-41ec-4261-9be8-fc5191ade56c@sifive.com>


--29t4/8GEDLrsNf/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 01:22:12PM -0600, Samuel Holland wrote:
> Hi Conor,
>=20
> On 2024-02-27 6:18 AM, Conor Dooley wrote:
> > On Mon, Feb 26, 2024 at 04:34:47PM -0800, Samuel Holland wrote:
> >> commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear
> >> mapping") added logic to allow using RAM below the kernel load address.
> >> However, this does not work for NOMMU, where PAGE_OFFSET is fixed to t=
he
> >> kernel load address. Since that range of memory corresponds to PFNs
> >> below ARCH_PFN_OFFSET, mm initialization runs off the beginning of
> >> mem_map and corrupts adjacent kernel memory. Fix this by restoring the
> >> previous behavior for NOMMU kernels.
> >>
> >> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapp=
ing")
> >=20
> > This commit was a year ago, why has nobody reported this as being an
> > issue before?
>=20
> I can think of a few reasons:
> 1) NOMMU users are likely to be using RV32, which is not affected.
> 2) Before patch 4 of this series, NOMMU implied M-mode, so there was noth=
ing in
> the way to prevent loading Linux at the very beginning of RAM. (U-Boot/SPL
> relocates itself to the end of RAM, so it would not cause a problem.)
> 3) Platforms where RAM does not begin at exactly 0x80000000 would be affe=
cted,
> there are several workarounds: change the start of RAM (for soft cores), =
change
> PAGE_OFFSET, or change the memory ranges in the devicetree to exclude any=
thing
> below PAGE_OFFSET.
>=20
> It's possible that nobody was affected, but it's still technically a regr=
ession
> (a hypothetical platform with RAM from 0x40000000 to 0xc0000000 would cra=
sh
> instead of only being able to use half its RAM), so I thought it still de=
served
> the Fixes: tag.

Right, thanks for explaining.

Cheers,
Conor.

--29t4/8GEDLrsNf/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd9TOgAKCRB4tDGHoIJi
0vk6AP0TSxofF/mXzet5PRaY+C3fUEgn0adwntRDThmt24rOkwD9Gvlsb3xwmGcN
f0hJY0qds2ScDTzQXUVTxVY6hE0krQ0=
=oZgb
-----END PGP SIGNATURE-----

--29t4/8GEDLrsNf/T--

