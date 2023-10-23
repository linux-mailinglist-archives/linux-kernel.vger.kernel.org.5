Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1417D3AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjJWPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJWPiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:38:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42248A9;
        Mon, 23 Oct 2023 08:38:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57122C433CA;
        Mon, 23 Oct 2023 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075481;
        bh=+7sxujCsz7fhFdaQKZ5gvA6XFkli0RKQBHNxU9igRO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CauCbHomgV3Pqhze715gE+HXa3kd18QQbm85tZ5slSuNo7E+uCtK+gb42iaHDj7eL
         d3Hpl/dbruQAREzN4GEG+kb+EkOjcqUCYGz0URZdXFZLPzwCm7x1NRhQypbOslcue8
         e7UvCxHRRFNcJEtTaBg30PfvQyCJX5wclP/dAWTMa34QMekW6men+DV0QJ4jG2E34a
         KIBlz8Z9dCej1FfIWF8+IudLMtYeb+nLE7cFYDYjYepKqk0gmBVRubHPWwKaL8y3bT
         uiYPj018EucQiDyPKjKtzU+RCESjj31Vg4xtKmkTERfystBDEb/TUlpLEWMCMv50M8
         YAbSWDQsG2UGA==
Date:   Mon, 23 Oct 2023 16:37:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] kexec: fix KEXEC_FILE dependencies
Message-ID: <20231023-thievish-imitation-c7c4b36d76f1@spud>
References: <20231023110308.1202042-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mRjpzI3+zD7u3ldz"
Content-Disposition: inline
In-Reply-To: <20231023110308.1202042-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mRjpzI3+zD7u3ldz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 01:01:54PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The cleanup for the CONFIG_KEXEC Kconfig logic accidentally changed the
> 'depends on CRYPTO=3Dy' dependency to a plain 'depends on CRYPTO', which
> causes a link failure when all the crypto support is in a loadable module
> and kexec_file support is built-in:
>=20
> x86_64-linux-ld: vmlinux.o: in function `__x64_sys_kexec_file_load':
> (.text+0x32e30a): undefined reference to `crypto_alloc_shash'
> x86_64-linux-ld: (.text+0x32e58e): undefined reference to `crypto_shash_u=
pdate'
> x86_64-linux-ld: (.text+0x32e6ee): undefined reference to `crypto_shash_f=
inal'
>=20
> Both s390 and x86 have this problem, while ppc64 and riscv have the
> correct dependency already. On riscv, the dependency is only used
> for the purgatory, not for the kexec_file code itself, which may
> be a bit surprising as it means that with CONFIG_CRYPTO=3Dm, it is
> possible to enable KEXEC_FILE but then the purgatory code is silently
> left out.
>=20
> Move this into the common Kconfig.kexec file in a way that is
> correct everywhere, using the dependency on CRYPTO_SHA256=3Dy only
> when the purgatory code is available. This requires reversing the
> dependency between ARCH_SUPPORTS_KEXEC_PURGATORY and KEXEC_FILE,
> but the effect remains the same, other than making riscv behave
> like the other ones.
>=20
> On s390, there is an additional dependency on CRYPTO_SHA256_S390, which
> should technically not be required but gives better performance. Remove
> this dependency here, noting that it was not present in the initial
> Kconfig code but was brought in without an explanation in commit
> 71406883fd357 ("s390/kexec_file: Add kexec_file_load system call").
>=20
> Fixes: 6af5138083005 ("x86/kexec: refactor for kernel/Kconfig.kexec")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/Kconfig | 4 ++--

>  arch/riscv/Kconfig   | 4 +---

This doesn't appear to work for rv32. The defconfig build in our
patchwork automation complains:
  /tmp/tmp.Aq21JVRQTx/arch/riscv/purgatory/entry.S:29:2: error: instruction=
 requires the following: RV64I Base Instruction Set

>  arch/s390/Kconfig    | 4 ++--
>  arch/x86/Kconfig     | 4 ++--
>  kernel/Kconfig.kexec | 1 +
>  5 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d5d5388973ac7..4640cee33f123 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -607,10 +607,10 @@ config ARCH_SUPPORTS_KEXEC
>  	def_bool PPC_BOOK3S || PPC_E500 || (44x && !SMP)
> =20
>  config ARCH_SUPPORTS_KEXEC_FILE
> -	def_bool PPC64 && CRYPTO=3Dy && CRYPTO_SHA256=3Dy
> +	def_bool PPC64
> =20
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> +	def_bool y
> =20
>  config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 25474f8c12b79..f571bad2d22d0 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -687,9 +687,7 @@ config ARCH_SELECTS_KEXEC_FILE
>  	select KEXEC_ELF
> =20
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> -	depends on CRYPTO=3Dy
> -	depends on CRYPTO_SHA256=3Dy
> +	def_bool y

This being the problem, KEXEC_FILE is 64-bit only.

IIRC I commented on this same thing during the original conversion
patches.

Cheers,
Conor.

> =20
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index b0d67ac8695f9..ec77106af4137 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -253,13 +253,13 @@ config ARCH_SUPPORTS_KEXEC
>  	def_bool y
> =20
>  config ARCH_SUPPORTS_KEXEC_FILE
> -	def_bool CRYPTO && CRYPTO_SHA256 && CRYPTO_SHA256_S390
> +	def_bool y
> =20
>  config ARCH_SUPPORTS_KEXEC_SIG
>  	def_bool MODULE_SIG_FORMAT
> =20
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> +	def_bool y
> =20
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 94efde80ebf35..f9975b15ccd57 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2073,7 +2073,7 @@ config ARCH_SUPPORTS_KEXEC
>  	def_bool y
> =20
>  config ARCH_SUPPORTS_KEXEC_FILE
> -	def_bool X86_64 && CRYPTO && CRYPTO_SHA256
> +	def_bool X86_64
> =20
>  config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
> @@ -2081,7 +2081,7 @@ config ARCH_SELECTS_KEXEC_FILE
>  	select HAVE_IMA_KEXEC if IMA
> =20
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> +	def_bool y
> =20
>  config ARCH_SUPPORTS_KEXEC_SIG
>  	def_bool y
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 7aff28ded2f48..bfc636d64ff2b 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -36,6 +36,7 @@ config KEXEC
>  config KEXEC_FILE
>  	bool "Enable kexec file based system call"
>  	depends on ARCH_SUPPORTS_KEXEC_FILE
> +	depends on CRYPTO_SHA256=3Dy || !ARCH_SUPPORTS_KEXEC_PURGATORY
>  	select KEXEC_CORE
>  	help
>  	  This is new version of kexec system call. This system call is
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--mRjpzI3+zD7u3ldz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTaTUQAKCRB4tDGHoIJi
0jQmAP9v+uwdj5uO4bmAsvYAS/mBJ+2BjVxZTAaQAidZQdF3ggD+LzhE+bC2da+g
DCs8WnrAasntuvfNZbHoXsUkKgUB9gI=
=uyT2
-----END PGP SIGNATURE-----

--mRjpzI3+zD7u3ldz--
