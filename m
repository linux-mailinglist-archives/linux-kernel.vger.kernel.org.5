Return-Path: <linux-kernel+bounces-150362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8448A9DF1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6B9286C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824316C437;
	Thu, 18 Apr 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE03bmgw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2425916ABEA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452760; cv=none; b=FNZq7+1veIbuftos+jSK1ePLghXUUgc4F5hpFUy3pvLJ4R78geL8hRnmQPLvU8sgt8JkjRpscXFnH9s0S5FEwACAlzDIjY8MOtMidycaQlBsdaqiZX/LxjfE/k2DP9uoYmqhVFt0izobi7Kph+QkYL5inKrZbyYbzX9VYF08byc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452760; c=relaxed/simple;
	bh=+n6ASrep4rJoEHRc9MR1zx75DlI9VbOIWLCu5kaRRS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa9kczCWjoKU3xS51MBE+vf/f2kYNChVawBd9VrcrXy4Gn/WdWuXzmEfjPkHHq1Rh2kGYCeoeO8BS7MrfdNUMnY1CW5qytwicB4nv/EcYck0qXJ96b9HeYNQ4HvM5LNTh5E4sEGu+5tOsd3q9G6exP4QEczPeiSNeHbB6atiNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE03bmgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70079C113CC;
	Thu, 18 Apr 2024 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713452760;
	bh=+n6ASrep4rJoEHRc9MR1zx75DlI9VbOIWLCu5kaRRS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mE03bmgwtprNd/G1IRYw0JNGMZbK3KktG2zSr0Nn4pRG4ZnbILOkUnUoQcns8qQPT
	 3N9p7MVJzYT4xOjy2n+ga/vowLGxcraGOm6bOG06q/oWanx10qOEKQvHgoX6BJ+i2A
	 GIEk62HwkKAOv9Ae0tp0tPWft2fCbvd7nxeP86/0E0Sy/VlgRWf4YNxSJ70XYRH/jF
	 gF9czmv0d+oSy70KmhUvl8zpoiE69hqmNl1VbsmMhIYCtN5VYEo1jORmuhiAtELy4T
	 deYoX24zrtX1JDVCtpkTa7dUrV+nlm/jyMEepxscwfFDIr4cTpYMxgauabdNjZOd8l
	 hDHSN7mYwDp1Q==
Date: Thu, 18 Apr 2024 16:05:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	andy.chiu@sifive.com, guoren@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	lihangjing@bytedance.com, dengliang.1214@bytedance.com,
	xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [RFC 1/2] riscv: process: Introduce idle thread using Zawrs
 extension
Message-ID: <20240418-dove-deferral-2b01100e13ca@spud>
References: <20240418114942.52770-1-luxu.kernel@bytedance.com>
 <20240418114942.52770-2-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W4+rgWywh9lWFt3p"
Content-Disposition: inline
In-Reply-To: <20240418114942.52770-2-luxu.kernel@bytedance.com>


--W4+rgWywh9lWFt3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+ Drew,

On Thu, Apr 18, 2024 at 07:49:41PM +0800, Xu Lu wrote:
> The Zawrs extension introduces a new instruction WRS.NTO, which will
> register a reservation set and causes the hart to temporarily stall
> execution in a low-power state until a store occurs to the reservation
> set or an interrupt is observed.
>=20
> This commit implements new version of idle thread for RISC-V via Zawrs
> extension.
>=20
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> Reviewed-by: Hangjing Li <lihangjing@bytedance.com>
> Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
> Reviewed-by: Wen Chai <chaiwen.cc@bytedance.com>
> ---
>  arch/riscv/Kconfig                 | 24 +++++++++++++++++
>  arch/riscv/include/asm/cpuidle.h   | 11 +-------
>  arch/riscv/include/asm/hwcap.h     |  1 +
>  arch/riscv/include/asm/processor.h | 17 +++++++++++++
>  arch/riscv/kernel/cpu.c            |  5 ++++
>  arch/riscv/kernel/cpufeature.c     |  1 +
>  arch/riscv/kernel/process.c        | 41 +++++++++++++++++++++++++++++-
>  7 files changed, 89 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index be09c8836d56..a0d344e9803f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -19,6 +19,7 @@ config RISCV
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>  	select ARCH_HAS_BINFMT_FLAT
> +	select ARCH_HAS_CPU_FINALIZE_INIT
>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEBUG_VM_PGTABLE
> @@ -525,6 +526,20 @@ config RISCV_ISA_SVPBMT
> =20
>  	   If you don't know what to do here, say Y.
> =20
> +config RISCV_ISA_ZAWRS
> +	bool "Zawrs extension support for wait-on-reservation-set instructions"
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the Zawrs
> +	   extension and enable its usage.

Drew, could you, in your update, use the wording:
	   Add support for enabling optimisations in the kernel when the
	   Zawrs extension is detected at boot.

There was some confusion recently about what these options were actually
for, because this option doesn't control "dynamic detection" as the
ACPI or DT detection is compiled at all times. I had written a patch for
this wording in other options at the time but had forgotten to properly
send it:
https://lore.kernel.org/linux-riscv/20240418-stable-railway-7cce07e1e440@sp=
ud/T/#u

> +
> +	   The Zawrs extension defines a pair of instructions to be used
> +	   in polling loops that allows a core to enter a low-power state
> +	   and wait on a store to a memory location.
> +
> +	   If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_HAS_V
>  	bool
>  	default y
> @@ -1075,6 +1090,15 @@ endmenu # "Power management options"
> =20
>  menu "CPU Power Management"
> =20
> +config RISCV_ZAWRS_IDLE
> +	bool "Idle thread using ZAWRS extensions"
> +	depends on RISCV_ISA_ZAWRS
> +	default y
> +	help
> +		Adds support to implement idle thread using ZAWRS extension.
> +
> +		If you don't know what to do here, say Y.

I don't think this second option is needed, why would we not always want
to use the Zawrs version of this when it is available? Can we do it
unconditionally when RISCV_ISA_ZAWRS is set and the extension is
detected at runtime?

Cheers,
Conor.



--W4+rgWywh9lWFt3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiE20wAKCRB4tDGHoIJi
0mB2AP9jDM+N0TaP3N/aRVlNJxBAwWPjQeQiXXdjkXc4uIfepAEAxccqrQyX3H0O
FYtsk8xkGJ2X1LJ0uU4Kb7k4EqyF5wA=
=byH8
-----END PGP SIGNATURE-----

--W4+rgWywh9lWFt3p--

