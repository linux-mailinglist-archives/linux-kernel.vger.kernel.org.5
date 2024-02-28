Return-Path: <linux-kernel+bounces-85254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC35186B2F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0691C2574E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021E515B987;
	Wed, 28 Feb 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5+3am7d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798B1C10
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133700; cv=none; b=Upwb1Fxw8Q3neFCfNpN1/o/SxdZqtAt+2djtYMWBliXDxF44eEuLObxT8uReg6t0Yd8NlSjUzlT04esN8vyWd8zHP+/IM7fzM6XXHHxw8rI+M2Y1bRStbJj1laLRrI0idomXz5cR/UGwrVhJP2ZEyVghgl0jbGALVoieiTbIQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133700; c=relaxed/simple;
	bh=Y2o0FRacDS3mFULfR5wkJ8AGuzyyqfzfYbMEDh5ISvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvDSf0Zwlov8I74q1vAggRXz7TJ3M07G8d6UiDXGIXf1Y3sNES8RypkjZ4zxvDirRRzt4czaUAkH14FaitOd922u+cc1mGVpU46aFuP80Vt7znsIiGDBw+1RqjR5ixKS+jCcEA8GtxcnL/1Y5Ku5cThi1HYTM2TfPsX3JwxZU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5+3am7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFB2C433F1;
	Wed, 28 Feb 2024 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709133699;
	bh=Y2o0FRacDS3mFULfR5wkJ8AGuzyyqfzfYbMEDh5ISvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5+3am7dFzyNH3svpjQNbZ18bBVtGFxJN9sYU/AQsZYlh3HKOvEJYXZ/RP46/wB9e
	 9u3I88AkDbLXdc3tiysjSX8/xSjhNJrflJLTTrNcKBJQlYqAPSiP3h6CxsgaEE+93F
	 iQQQqm8aoy1QBv2qJSH18Sxg1aBveIEx5HvgfXiuK1qeYjQjZ8rAZSZ1EM+KiaTaS4
	 F5+O1tTzYS4lkpYK3g0htvY34Q90IBR8LO7nwTXxM2H7cX3oek7Ykm7dnKsvbfH/d1
	 yX5CDPTLtye3G6wpj4bStDej7Sv6ci9x1lPa2OLitkURzHJbYN+WB5Mgt3YprRcLsJ
	 AhmpXBWJ+Aclw==
Date: Wed, 28 Feb 2024 15:21:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] riscv: Allow NOMMU kernels to run in S-mode
Message-ID: <20240228-reverence-vaseline-590175d7901e@spud>
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
 <20240227003630.3634533-5-samuel.holland@sifive.com>
 <20240227-seventh-overgrown-2fa453e8a775@wendy>
 <21e03db9-efb7-4e26-9b0d-4931afd62194@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mJowefI5gHiXMm/u"
Content-Disposition: inline
In-Reply-To: <21e03db9-efb7-4e26-9b0d-4931afd62194@sifive.com>


--mJowefI5gHiXMm/u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 01:02:11PM -0600, Samuel Holland wrote:
> Hi Conor,
>=20
> On 2024-02-27 6:24 AM, Conor Dooley wrote:
> > On Mon, Feb 26, 2024 at 04:34:49PM -0800, Samuel Holland wrote:
> >> For ease of testing, it is convenient to run NOMMU kernels in supervis=
or
> >> mode. The only required change is to offset the kernel load address,
> >> since the beginning of RAM is usually reserved for M-mode firmware.
> >>
> >> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >> ---
> >>
> >>  arch/riscv/Kconfig | 15 ++++++++++-----
> >>  1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index ef53c00470d6..0dc09b2ac2f6 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -64,7 +64,7 @@ config RISCV
> >>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> >>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >>  	select BUILDTIME_TABLE_SORT if MMU
> >> -	select CLINT_TIMER if !MMU
> >> +	select CLINT_TIMER if RISCV_M_MODE
> >>  	select CLONE_BACKWARDS
> >>  	select COMMON_CLK
> >>  	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
> >> @@ -220,8 +220,12 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
> >> =20
> >>  # set if we run in machine mode, cleared if we run in supervisor mode
> >>  config RISCV_M_MODE
> >> -	bool
> >> -	default !MMU
> >> +	bool "Build a kernel that runs in machine mode"
> >> +	depends on !MMU
> >> +	default y
> >> +	help
> >> +	  Select this option if you want to run the kernel in M-mode,
> >> +	  without the assistance of any other firmware.
> >> =20
> >>  # set if we are running in S-mode and can use SBI calls
> >>  config RISCV_SBI
> >> @@ -238,8 +242,9 @@ config MMU
> >> =20
> >>  config PAGE_OFFSET
> >>  	hex
> >> -	default 0xC0000000 if 32BIT && MMU
> >> -	default 0x80000000 if !MMU
> >> +	default 0x80000000 if !MMU && RISCV_M_MODE
> >> +	default 0x80200000 if !MMU
> >> +	default 0xc0000000 if 32BIT
> >>  	default 0xff60000000000000 if 64BIT
> >=20
> > The first default seen with a passing condition is the default chosen,
> > right?
>=20
> Yes, exactly. It's not required for the conditions to all be disjoint.

I had actually gone and checked was doing the right thing, but I didn't
manage to convince myself that this was intended behaviour rather than
an implementation detail. What I saw in the docs for default was:
"If multiple default values are visible, only the first defined one is acti=
ve"
and I suppose "visible" is what is used to cover the if part.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--mJowefI5gHiXMm/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd9PgAAKCRB4tDGHoIJi
0p9fAP4oVyq079FR8VVeHLxfQpN1jV17v4VmsjHPNWksXn+mNQD/Rv7JMAR+mJbV
LAy3Zpg/8TRlPfdbhnqwRAmKtOvdoQ0=
=hrDd
-----END PGP SIGNATURE-----

--mJowefI5gHiXMm/u--

