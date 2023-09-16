Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36BD7A2CE8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 03:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbjIPBMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 21:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbjIPBMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:12:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A4E3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 18:12:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAFAC433C8;
        Sat, 16 Sep 2023 00:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694823395;
        bh=KVD5/Hzc2O0pK0uQVAxIpL/l7Ybq76eSDT1eP8jejfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqmFxnLZU74ovH6yS4VAqaw1t5nNnOzQ8wefTNWAY9Z9vYhrT6m4ne9oeMciU+JXh
         ZFUPhNCldoNZ7i8LZnUuLZdeg29eROEvMDADioenGxgUnJICAtK9nmIL1GEmdC+8gU
         lS2tdQ4UZRzDlYI7M2webMInj+8xn9QrbScJqlcNstP6/LlucruvKeW6gshaRJ0i+v
         GDAHRULMzdY47670KU6WmBWfEmYdmFAOhqgRHnD1z82DGPRz8ACchjuVvJiQZts6H2
         1Q7PPVAGAP3Oc4C9eXsm5IWI1jZk5n6da6TYyNLysFf7KZB5Yp7Sa7n1j7mP9I6/zS
         E0Lz4AHgxTDzQ==
Date:   Sat, 16 Sep 2023 01:16:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH] RISC-V: Probe misaligned access speed in parallel
Message-ID: <20230916-celtic-flavored-f6e5f49cec20@spud>
References: <20230915184904.1976183-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EtuFmNE6fZ9CiTEz"
Content-Disposition: inline
In-Reply-To: <20230915184904.1976183-1-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EtuFmNE6fZ9CiTEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo Evan,

On Fri, Sep 15, 2023 at 11:49:03AM -0700, Evan Green wrote:
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
> Signed-off-by: Evan Green <evan@rivosinc.com>
>=20
> ---
>=20
> Jisheng, I didn't add your Tested-by tag since the patch evolved from
> the one you tested. Hopefully this one brings you the same result.

Ya know, I think there's scope to add Reported-by:, Closes: and Fixes:
tags to this patch, mentioning explicitly that this has regressed boot
time for many core systems, so that this can be fixes material. What do
you think?

> ---
>  arch/riscv/include/asm/cpufeature.h |  3 ++-
>  arch/riscv/kernel/cpufeature.c      | 28 +++++++++++++++++++++++-----
>  arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
>  3 files changed, 35 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index d0345bd659c9..19e7817eba10 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -30,6 +30,7 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
> =20
> -void check_unaligned_access(int cpu);
> +extern bool misaligned_speed_measured;
> +int check_unaligned_access(void *unused);
> =20
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 1cfbba65d11a..8eb36e1dfb95 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -42,6 +42,9 @@ struct riscv_isainfo hart_isa[NR_CPUS];
>  /* Performance information */
>  DEFINE_PER_CPU(long, misaligned_access_speed);
> =20
> +/* Boot-time in-parallel unaligned access measurement has occurred. */
> +bool misaligned_speed_measured;

If you did something like s/measured/complete/ I think you could drop
the comment. Tis whatever though :)

Conor.

--EtuFmNE6fZ9CiTEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQTz3gAKCRB4tDGHoIJi
0pL6APoCJx7gPKIJyKx4k4hG/Noh2gJZfE37eh09UhuU5jaYYQD8CUoYpcT0HQHB
pQLKcJ6KdLxEs3zcHVsMGIxM2Q232gY=
=gqqj
-----END PGP SIGNATURE-----

--EtuFmNE6fZ9CiTEz--
