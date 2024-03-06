Return-Path: <linux-kernel+bounces-94250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C3873BF6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC621C24399
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE487135A67;
	Wed,  6 Mar 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAF10WUw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C271EF1C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741979; cv=none; b=NCfjfU7xrWYxyZ6Wfaa/nugdOy2v3ZzLjGDx3vufnp2Fm6huWE3GmNG4XGwdhMkAEs6CoAKAvKaXxhOqvKXWU7dmJoiiDPsCNdV8nxcAhpvm0xJfqHckTXoAOyNZMIx738Fn05zB1Px6jiCE2b3IHduv9ZTJHj+4Rm3w3dAnAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741979; c=relaxed/simple;
	bh=gP7bOMzRxzfFwYCZyUNdmwtV0myPbRgaFLuAyGqYmVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9tZ4IyZQ35L5JGAxbXeMQlUX8YgFSHMMtYByQKnES4yZMIfzH72dOoFDxeZRTrwYcGRbrPcrhZUU8FGA1hsRiKfwSPFKM4PKH9Zj7ydgq0jKqWHBVSeb0CDCnRZiTtq3YZEjeANoZUV8ViK9rWbr8J7abNc427BfBIwrABe658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAF10WUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE7DC433F1;
	Wed,  6 Mar 2024 16:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709741978;
	bh=gP7bOMzRxzfFwYCZyUNdmwtV0myPbRgaFLuAyGqYmVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAF10WUwyPEBKnpM2gZGOUT/QTYcALKLYAYxprza7VjXNi/Ug9b+1JflkPFZBeT6F
	 okkIpFaAFnNat/TPXPS/+EQjr/2Pf4bH67G22GJ7iTLhcooko+9uE1+Iu7vdV121cH
	 tzYobxY1/B8sqwhUa1PYTL1E4Im+/Nb8CsBBH1fi8yQCfikJmxpgRaZk6sRx3BX9cI
	 mc/rfddByNPhV+QsL6ey0S6S3LIOP6HOfBc97/e2TDymyrmVk+Emm2bEfZzgVxfi3L
	 /JMJuq6IZlnTBg1vvB7OjQyXTRy0qmixHpIw56vSSRZ2PggDRvu3UtNWz9uTZTxKNF
	 NMCZCLroE7Oaw==
Date: Wed, 6 Mar 2024 16:19:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Charles Lohr <lohr85@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] riscv: Set unaligned access speed at compile time
Message-ID: <20240306-bring-gullible-72ec4260fd56@spud>
References: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
 <20240301-disable_misaligned_probe_config-v6-4-612ebd69f430@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1QDWyfojMrIhwScQ"
Content-Disposition: inline
In-Reply-To: <20240301-disable_misaligned_probe_config-v6-4-612ebd69f430@rivosinc.com>


--1QDWyfojMrIhwScQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Mar 01, 2024 at 05:45:35PM -0800, Charlie Jenkins wrote:
> Introduce Kconfig options to set the kernel unaligned access support.
> These options provide a non-portable alternative to the runtime
> unaligned access probe.
>=20
> To support this, the unaligned access probing code is moved into it's
> own file and gated behind a new RISCV_PROBE_UNALIGNED_ACCESS_SUPPORT
> option.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig                         |  58 ++++--
>  arch/riscv/include/asm/cpufeature.h        |  26 +--
>  arch/riscv/kernel/Makefile                 |   4 +-
>  arch/riscv/kernel/cpufeature.c             | 272 -----------------------=
-----
>  arch/riscv/kernel/sys_hwprobe.c            |  21 +++
>  arch/riscv/kernel/traps_misaligned.c       |   2 +
>  arch/riscv/kernel/unaligned_access_speed.c | 282 +++++++++++++++++++++++=
++++++
>  7 files changed, 369 insertions(+), 296 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bffbd869a068..60b6de35599d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -688,27 +688,61 @@ config THREAD_SIZE_ORDER
>  	  affects irq stack size, which is equal to thread stack size.
> =20
>  config RISCV_MISALIGNED
> -	bool "Support misaligned load/store traps for kernel and userspace"
> +	bool
>  	select SYSCTL_ARCH_UNALIGN_ALLOW
> -	default y
>  	help
> -	  Say Y here if you want the kernel to embed support for misaligned
> -	  load/store for both kernel and userspace. When disable, misaligned
> -	  accesses will generate SIGBUS in userspace and panic in kernel.
> +	  Embed support for misaligned load/store for both kernel and userspace.
> +	  When disabled, misaligned accesses will generate SIGBUS in userspace
> +	  and panic in kernel.

"in the kernel".

> +
> +choice
> +	prompt "Unaligned Accesses Support"
> +	default RISCV_PROBE_UNALIGNED_ACCESS
> +	help

> +	  This selects the hardware support for unaligned accesses. This

"This determines what level of support for..."

> +	  information is used by the kernel to perform optimizations. It is also
> +	  exposed to user space via the hwprobe syscall. The hardware will be
> +	  probed at boot by default.
> +
> +config RISCV_PROBE_UNALIGNED_ACCESS
> +	bool "Probe for hardware unaligned access support"
> +	select RISCV_MISALIGNED
> +	help
> +	  During boot, the kernel will run a series of tests to determine the
> +	  speed of unaligned accesses. This probing will dynamically determine
> +	  the speed of unaligned accesses on the boot hardware.

"on the underlying system"?

> The kernel will
> +	  also check if unaligned memory accesses will trap into the kernel and
> +	  handle such traps accordingly.

I think I would phrase this to be more understandable to users. I think
we need to explain why it would trap and what we will do. Maybe
something like: "if unaligned memory accesses trap into the kernel as
they are not supported by the system, the kernel will emulate the
unaligned accesses to preserve the UABI".

> +config RISCV_EMULATED_UNALIGNED_ACCESS
> +	bool "Assume the system expects emulated unaligned memory accesses"
> +	select RISCV_MISALIGNED
> +	help
> +	  Assume that the system expects unaligned memory accesses to be
> +	  emulated. The kernel will check if unaligned memory accesses will
> +	  trap into the kernel and handle such traps accordingly.

I guess the same suggestion applies here, but I think the description
here isn't quite accurate. This option is basically the same as above,
but without the speed test, right? It doesn't actually assume emulation
is required at all, in fact the assumption we make is that if the
hardware supports unaligned access that access is slow.

I think I'd do:
```
boot "Emulate unaligned access where system support is missing"
help
  If unaligned accesses trap into the kernel as they are not supported
  by the system, the kernel will emulate the unaligned accesses to
  preserve the UABI. When the underlying system does support unaligned
  accesses, probing at boot is not done and unaligned accesses are
  assumed to be slow.

> +config RISCV_SLOW_UNALIGNED_ACCESS
> +	bool "Assume the system supports slow unaligned memory accesses"
> +	depends on NONPORTABLE
> +	help
> +	  Assume that the system supports slow unaligned memory accesses. The
> +	  kernel may not be able to run at all on systems that do not support
> +	  unaligned memory accesses.

=2E..and userspace programs cannot use unaligned access either, I think
that is worth mentioning.

> =20
>  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> -	bool "Assume the CPU supports fast unaligned memory accesses"
> +	bool "Assume the system supports fast unaligned memory accesses"
>  	depends on NONPORTABLE
>  	select DCACHE_WORD_ACCESS if MMU
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	help
> -	  Say Y here if you want the kernel to assume that the CPU supports
> -	  efficient unaligned memory accesses.  When enabled, this option
> -	  improves the performance of the kernel on such CPUs.  However, the
> -	  kernel will run much more slowly, or will not be able to run at all,
> -	  on CPUs that do not support efficient unaligned memory accesses.
> +	  Assume that the system supports fast unaligned memory accesses. When
> +	  enabled, this option improves the performance of the kernel on such
> +	  systems.  However, the kernel will run much more slowly, or will not
> +	  be able to run at all, on systems that do not support efficient
> +	  unaligned memory accesses.
> =20
> -	  If unsure what to do here, say N.
> +endchoice
> =20
>  endmenu # "Platform type"

> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>  DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
> =20
>  static __always_inline bool has_fast_unaligned_accesses(void)
>  {
>  	return static_branch_likely(&fast_unaligned_access_speed_key);
>  }
> +#elif defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> +static __always_inline bool has_fast_unaligned_accesses(void)
> +{
> +	return true;
> +}
> +#else
> +static __always_inline bool has_fast_unaligned_accesses(void)
> +{
> +	return false;
> +}
> +#endif

These tree could just be one function with if(IS_ENABLED), whatever code
gets made dead should be optimised out.

> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index a7c56b41efd2..dad02f5faec3 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -147,8 +147,10 @@ static bool hwprobe_ext0_has(const struct cpumask *c=
pus, unsigned long ext)
>  	return (pair.value & ext);
>  }
> =20
> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>  static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  {
> +	return RISCV_HWPROBE_MISALIGNED_FAST;

This hack is still here.

>  	int cpu;
>  	u64 perf =3D -1ULL;
> =20
> @@ -169,6 +171,25 @@ static u64 hwprobe_misaligned(const struct cpumask *=
cpus)
> =20
>  	return perf;
>  }

> +#elif defined(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS)
> +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> +{
> +	if (unaligned_ctl_available())
> +		return RISCV_HWPROBE_MISALIGNED_EMULATED;
> +	else
> +		return RISCV_HWPROBE_MISALIGNED_SLOW;
> +}
> +#elif defined(CONFIG_RISCV_SLOW_UNALIGNED_ACCESS)
> +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> +{
> +	return RISCV_HWPROBE_MISALIGNED_SLOW;
> +}
> +#elif defined(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS)
> +static u64 hwprobe_misaligned(const struct cpumask *cpus)
> +{
> +	return RISCV_HWPROBE_MISALIGNED_FAST;
> +}
> +#endif

Same applies to these three functions.

Thanks,
Conor.

--1QDWyfojMrIhwScQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeiXlQAKCRB4tDGHoIJi
0s8pAP92tQidmmZ1PxlRi3m6iX230TX+r0mJ3pkjs9QgmHvmXQEAsOXRxufXjiFD
X1/e2clg0Gcvsc3mYTgk+QlJZqeYRww=
=+D5W
-----END PGP SIGNATURE-----

--1QDWyfojMrIhwScQ--

