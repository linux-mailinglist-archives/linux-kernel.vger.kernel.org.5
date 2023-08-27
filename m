Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA1789ADD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjH0BnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjH0Bmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64530C5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 18:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C6D61D49
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 01:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEDDC433C8;
        Sun, 27 Aug 2023 01:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693100565;
        bh=N1Tp3URo53WXHDUa7LANqGVyvrY+vDBSLIvHpEQgAKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVS3BLuCLtx9xwEvHYcMVRtpLW9QAg6cPC03h6lX0u5HXjs5tyIe29T+SIeB4squB
         D3ObRqDXGMErt9KbV9vnY3ZVyDbgfUSLH07NZs2IlcojqYrZ3qSQqrDe7ud4KLUbOu
         9zcILYLLusN0RraqxwBCcfDUI1DjcWuYt4HprrH6AYuWteDPewvqiQxFDWqDBygQ7L
         VOCqyIQlVwYNK5l7uat7j9Bjizz3e8B00kTGX/9vKcC9YrYnueQWizfXn9TEBH3xiV
         mHN9GeCYtG7hoVPDwYJr25FgSUARwXzPb/+ISZFp13kweOKn8A3Foh2cz47FDM3Tkx
         81NTrB7TOYF8A==
Date:   Sun, 27 Aug 2023 02:42:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 1/5] riscv: Checksum header
Message-ID: <20230827-turf-parched-b965bc697882@spud>
References: <20230826-optimize_checksum-v1-0-937501b4522a@rivosinc.com>
 <20230826-optimize_checksum-v1-1-937501b4522a@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9cGvEmoU1B0QAhNd"
Content-Disposition: inline
In-Reply-To: <20230826-optimize_checksum-v1-1-937501b4522a@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9cGvEmoU1B0QAhNd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 06:26:06PM -0700, Charlie Jenkins wrote:
> Provide checksum algorithms that have been designed to leverage riscv
> instructions such as rotate. In 64-bit, can take advantage of the larger
> register to avoid some overflow checking.
>=20
> Add configuration for Zba extension and add march for Zba and Zbb.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig                | 23 +++++++++++
>  arch/riscv/Makefile               |  2 +
>  arch/riscv/include/asm/checksum.h | 86 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 111 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4c07b9189c86..8d7e475ca28d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -507,6 +507,29 @@ config RISCV_ISA_V_DEFAULT_ENABLE
> =20
>  	  If you don't know what to do here, say Y.
> =20
> +config TOOLCHAIN_HAS_ZBA
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zba)
> +	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_zba)
> +	depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 23900
> +	depends on AS_HAS_OPTION_ARCH
> +
> +config RISCV_ISA_ZBA
> +	bool "Zba extension support for bit manipulation instructions"
> +	depends on TOOLCHAIN_HAS_ZBA
> +	depends on MMU
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the ZBA
> +	   extension (basic bit manipulation) and enable its usage.
> +
> +	   The Zba extension provides instructions to accelerate a number
> +	   of bit-specific address creation operations.
> +
> +	   If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_HAS_ZBB
>  	bool
>  	default y
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 6ec6d52a4180..51fa3f67fc9a 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -61,6 +61,8 @@ riscv-march-$(CONFIG_ARCH_RV64I)	:=3D rv64ima
>  riscv-march-$(CONFIG_FPU)		:=3D $(riscv-march-y)fd
>  riscv-march-$(CONFIG_RISCV_ISA_C)	:=3D $(riscv-march-y)c
>  riscv-march-$(CONFIG_RISCV_ISA_V)	:=3D $(riscv-march-y)v
> +riscv-march-$(CONFIG_RISCV_ISA_ZBA)	:=3D $(riscv-march-y)_zba
> +riscv-march-$(CONFIG_RISCV_ISA_ZBB)	:=3D $(riscv-march-y)_zbb

AFAICT, this is going to break immediately on any system that enables
RISCV_ISA_ZBA (which will happen by default) but does not support the
extension. You made the option depend on RISCV_ALTERNATIVE, but I do
not see any use of alternatives in the code to actually perform the
dynamic detection of Zba.
Note that for fd & v, we add it to riscv-march-y, but then immediately
remove it again before passing to the compiler, only allow them in
AFLAGS:
	# Remove F,D,V from isa string for all. Keep extensions between "fd" and "=
v" by
	# matching non-v and non-multi-letter extensions out with the filter ([^v_=
]*)
	KBUILD_CFLAGS +=3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/(rv3=
2ima|rv64ima)fd([^v_]*)v?/\1\2/')

What am I missing?

Thanks,
Conor.

--9cGvEmoU1B0QAhNd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOqqEQAKCRB4tDGHoIJi
0n2OAQCuR4clvG/HNCrTOW90C5/ale2ryxd/UzGWGb64agc0KAEAqPeucVmG/JQQ
10As7RzkwjzlPEqWUCNH3o+aWLbmLQc=
=uOaG
-----END PGP SIGNATURE-----

--9cGvEmoU1B0QAhNd--
