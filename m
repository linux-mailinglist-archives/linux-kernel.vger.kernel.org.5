Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA87A8E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjITVEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjITVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:03:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE14CC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:03:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DCFC433C8;
        Wed, 20 Sep 2023 21:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695243831;
        bh=OLB7oDrv5ooNLbRTNix2Xc97l0Z4tqh8a92sf+yMsA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k++4IS5CNvaGJwJ1AFoGHHewRaUQ0tV+bgKJhAv7oaA9gEum90L+ps3XXAZR+OheC
         idNdf7EOHxGO+U6f/mpDooJRqNIa0SIof3rAiuI2alm26Q1YQFG+CaptOFN/+T4xRU
         ABj6rYeKVTPkiDiT2vfU9bxsob3pa5O6FshOuT/LM9qjwBo0cMd2VR9+FymLwp5HCz
         psqrgcGOKUvd4OhE2qIqgMq+MVqHhj8bT00Kp7rwZCxS3SZ2gI71/ALTssnpueQE1L
         5eW/kQeHhCVyor0kVQONTWc46uWmTEluVK83Xs5tGeOtNJAxApSyid+sLdyoYEEJVI
         mueMtKNUUEf0w==
Date:   Wed, 20 Sep 2023 22:03:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] RISC-V: Probe misaligned access speed in parallel
Message-ID: <20230920-98a392b40f88c69e852e2c88@fedora>
References: <20230920193801.3035093-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mYs5g9D4GCVb2xK"
Content-Disposition: inline
In-Reply-To: <20230920193801.3035093-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mYs5g9D4GCVb2xK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Wed, Sep 20, 2023 at 12:38:01PM -0700, Evan Green wrote:
> Probing for misaligned access speed takes about 0.06 seconds. On a
> system with 64 cores, doing this in smp_callin() means it's done
> serially, extending boot time by 3.8 seconds. That's a lot of boot time.
>=20
> Instead of measuring each CPU serially, let's do the measurements on
> all CPUs in parallel. If we disable preemption on all CPUs, the
> jiffies stop ticking, so we can do this in stages of 1) everybody
> except core 0, then 2) core 0.
>=20
> The measurement call in smp_callin() stays around, but is now
> conditionalized to only run if a new CPU shows up after the round of
> in-parallel measurements has run. The goal is to have the measurement
> call not run during boot or suspend/resume, but only on a hotplug
> addition.
>=20
> Reported-by: Jisheng Zhang <jszhang@kernel.org>
> Closes: https://lore.kernel.org/all/mhng-9359993d-6872-4134-83ce-c97debe1=
cf9a@palmer-ri-x1c9/T/#mae9b8f40016f9df428829d33360144dc5026bcbf
> Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Tested-by: Andrew Jones <ajones@ventanamicro.com>
>=20
> ---
>=20
> Changes in v2:
>  - Removed new global, used system_state =3D=3D SYSTEM_RUNNING instead
>    (Jisheng)
>  - Added tags
>=20
>  arch/riscv/include/asm/cpufeature.h |  2 +-
>  arch/riscv/kernel/cpufeature.c      | 22 +++++++++++++++++-----
>  arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
>  3 files changed, 28 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index d0345bd659c9..b139796392d0 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -30,6 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
> =20
> -void check_unaligned_access(int cpu);
> +int check_unaligned_access(void *unused);
> =20
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 1cfbba65d11a..40bb854fcb96 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -556,8 +556,9 @@ unsigned long riscv_get_elf_hwcap(void)
>  	return hwcap;
>  }
> =20
> -void check_unaligned_access(int cpu)
> +int check_unaligned_access(void *unused)
>  {
> +	int cpu =3D smp_processor_id();
>  	u64 start_cycles, end_cycles;
>  	u64 word_cycles;
>  	u64 byte_cycles;
> @@ -571,7 +572,7 @@ void check_unaligned_access(int cpu)
>  	page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
>  	if (!page) {
>  		pr_warn("Can't alloc pages to measure memcpy performance");
> -		return;
> +		return 0;

Dumb question maybe, but I am limited setup wise at the moment due to
a hardware failure which makes checking stuff hard, why the signature
change? Requirement for on_each_cpu()?

>  	}
> =20
>  	/* Make an unaligned destination buffer. */
> @@ -643,15 +644,26 @@ void check_unaligned_access(int cpu)
> =20
>  out:
>  	__free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> +	return 0;
> +}
> +
> +static void check_unaligned_access_nonboot_cpu(void *param)
> +{
> +	if (smp_processor_id() !=3D 0)
> +		check_unaligned_access(param);
>  }
> =20
> -static int check_unaligned_access_boot_cpu(void)
> +static int check_unaligned_access_all_cpus(void)
>  {
> -	check_unaligned_access(0);
> +	/* Check everybody except 0, who stays behind to tend jiffies. */
> +	on_each_cpu(check_unaligned_access_nonboot_cpu, NULL, 1);
> +
> +	/* Check core 0. */
> +	smp_call_on_cpu(0, check_unaligned_access, NULL, true);
>  	return 0;

Why does this function return an int if it can only return 0?

Cheers,
Conor.

>  }
> =20
> -arch_initcall(check_unaligned_access_boot_cpu);
> +arch_initcall(check_unaligned_access_all_cpus);
> =20
>  #ifdef CONFIG_RISCV_ALTERNATIVE
>  /*
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 1b8da4e40a4d..a014955b8699 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -27,6 +27,7 @@
>  #include <linux/sched/mm.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/cpufeature.h>
> +#include <asm/hwprobe.h>
>  #include <asm/irq.h>
>  #include <asm/mmu_context.h>
>  #include <asm/numa.h>
> @@ -246,7 +247,15 @@ asmlinkage __visible void smp_callin(void)
> =20
>  	numa_add_cpu(curr_cpuid);
>  	set_cpu_online(curr_cpuid, 1);
> -	check_unaligned_access(curr_cpuid);
> +
> +	/*
> +	 * Boot-time misaligned access speed measurements are done in parallel
> +	 * in an initcall. Only measure here for hotplug.
> +	 */
> +	if ((system_state =3D=3D SYSTEM_RUNNING) &&
> +	    (per_cpu(misaligned_access_speed, curr_cpuid) =3D=3D RISCV_HWPROBE_=
MISALIGNED_UNKNOWN)) {
> +		check_unaligned_access(NULL);
> +	}
> =20
>  	if (has_vector()) {
>  		if (riscv_v_setup_vsize())
> --=20
> 2.34.1
>=20

--5mYs5g9D4GCVb2xK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQteLQAKCRB4tDGHoIJi
0nbzAQDntgQEICHVv5aJTHbUL/w2FHj/Ki1XSspCxq3x0ZadCQEAluzwk2hjM+7s
y49xnHaUDezu6lFi1aNbMX1dBv4p2wI=
=WrQ/
-----END PGP SIGNATURE-----

--5mYs5g9D4GCVb2xK--
