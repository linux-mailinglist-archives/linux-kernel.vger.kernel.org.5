Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC17763E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjGZSCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjGZSCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B32269E;
        Wed, 26 Jul 2023 11:02:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55CFA61C2A;
        Wed, 26 Jul 2023 18:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4799CC433C7;
        Wed, 26 Jul 2023 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690394561;
        bh=ZuEBFKvfvWvmo7RjmoDN0IFVptnWEiaCxWHx7e3scdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRZb+vSdMaDrEDii2mqaKfhC/axpTjFGGcq/anbalORnGsHk6wpre5hOHR7uDoIc7
         fVQLRH3RQZjibGwjweDJJAQI7GBqxNXjoNe2eKK57v5o5lJcuU4QL8aHvUezuWzyZx
         rJsq3Rdr4RAZJdMyLKtsQyDouD3QDh9sWFsl2PTwcNeG0RGXEVKrFmpv7Ciyhqhphd
         5Y3+70q3IVKS4GJ+EpIEF9OfVPMTrvA2/PO1uaTFTgdQMa5pUeW9AWtaHNQSwS80S3
         AdwpA1VTAcGbBVVgAV3lwY8mb5k/mAvBS9Exee15tqIbRnpnzFsalAyXf2nGvb3iGt
         wqJLsyvJkYc8g==
Date:   Wed, 26 Jul 2023 19:02:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
Message-ID: <20230726-outclass-parade-2ccea9f6688a@spud>
References: <20230726174524.340952-1-xingmingzheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UtMXT2cLyqU/RCBj"
Content-Disposition: inline
In-Reply-To: <20230726174524.340952-1-xingmingzheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UtMXT2cLyqU/RCBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 01:45:24AM +0800, Mingzheng Xing wrote:
> Binutils-2.38 and GCC-12.1.0 bump[0] default ISA spec to newer version
> 20191213 which moves some instructions from the I extension to the
> Zicsr and Zifencei extensions. So if one of the binutils and GCC exceeds
> that version, we should turn on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
> to cope with the new changes.
>=20
> The case of clang is special[1][2], where older clang versions (<17) need
> to be rolled back to old ISA spec to fix it. And the less common case,
> since older GCC versions (<11.1.0) did not support zicsr and zifencei

Can you provide a link to explain why this is 11.1.0 in particular?

> extension for -march, also requires a fallback to cope with it.
>=20
> For more information, please refer to:
> commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
> commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang a=
nd binutils")
> Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D98416dbb0a62579=
d4a7a4a76bab51b5b52fec2cd [0]
> Link: https://lore.kernel.org/all/20230308220842.1231003-1-conor@kernel.o=
rg [1]
> Link: https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.org=
 [2]

> Link: https://lore.kernel.org/all/20230725170405.251011-1-xingmingzheng@i=
scas.ac.cn

This shouldn't be here, you don't link to your old patches.

> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>

This is still broken for:
CONFIG_CLANG_VERSION=3D0
CONFIG_AS_IS_GNU=3Dy
CONFIG_AS_VERSION=3D23500
CONFIG_LD_IS_BFD=3Dy
CONFIG_LD_VERSION=3D23500

Please don't post a v2 while there is still ongoing discussion on the
v1. I'll try to reply here tomorrow with a diff you can fold in to fix
the problem.

Thanks,
Conor.

> ---
>=20
> v2:
> - Update the Kconfig help text and commit message.
> - Add considerations for low version gcc case.
>=20
> Sorry for the formatting error on my mailing list reply.
>=20
>  arch/riscv/Kconfig | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4c07b9189c86..08afd47de157 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -570,24 +570,27 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>  config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>  	def_bool y
>  	# https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Daed44=
286efa8ae8717a77d94b51ac3614e2ca6dc
> -	depends on AS_IS_GNU && AS_VERSION >=3D 23800
> +	# https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D98416dbb0a62579d4=
a7a4a76bab51b5b52fec2cd
> +	depends on GCC_VERSION >=3D 120100 || (AS_IS_GNU && AS_VERSION >=3D 238=
00)
>  	help
> -	  Newer binutils versions default to ISA spec version 20191213 which
> -	  moves some instructions from the I extension to the Zicsr and Zifencei
> -	  extensions.
> +	  Binutils-2.38 and GCC-12.1.0 bump default ISA spec to newer version
> +	  20191213 which moves some instructions from the I extension to the
> +	  Zicsr and Zifencei extensions.
> =20
>  config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
>  	def_bool y
>  	depends on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>  	# https://github.com/llvm/llvm-project/commit/22e199e6afb1263c943c0c0d4=
498694e15bf8a16
> -	depends on CC_IS_CLANG && CLANG_VERSION < 170000
> +	# https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3Db03be74bad08c382d=
a47e048007a78fa3fb4ef49
> +	depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || \
> +		   (CC_IS_GCC && GCC_VERSION < 110100)
>  	help
> -	  Certain versions of clang do not support zicsr and zifencei via -march
> -	  but newer versions of binutils require it for the reasons noted in the
> -	  help text of CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. This
> +	  Certain versions of clang (or GCC) do not support zicsr and zifencei =
via
> +	  -march but newer versions of binutils require it for the reasons noted
> +	  in the help text of CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. T=
his
>  	  option causes an older ISA spec compatible with these older versions
> -	  of clang to be passed to GAS, which has the same result as passing zi=
csr
> -	  and zifencei to -march.
> +	  of clang (or GCC) to be passed to GAS, which has the same result as
> +	  passing zicsr and zifencei to -march.
> =20
>  config FPU
>  	bool "FPU support"
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--UtMXT2cLyqU/RCBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMFfvAAKCRB4tDGHoIJi
0qoeAQDp3ypoQuZjQevaA9Hr4AFTnPXwwDMwgAo89yt9uZDNRgD/XaPIQrd0555E
aPpCSI4Ukz489022i+qI1s80u07U0AI=
=UaXr
-----END PGP SIGNATURE-----

--UtMXT2cLyqU/RCBj--
