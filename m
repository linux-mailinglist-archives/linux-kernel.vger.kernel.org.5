Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2950E7680D6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 19:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjG2RsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 13:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG2RsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 13:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAFB2D64;
        Sat, 29 Jul 2023 10:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A804360288;
        Sat, 29 Jul 2023 17:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79462C433C9;
        Sat, 29 Jul 2023 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690652888;
        bh=426Plr62YIRVVd7idefnHiN/75xOXxFwgyitLpzWikI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ml2RZxAenphY2R+EU5yWpJOcmOG/MVc8GX8AsiALO21yS2ff9XnOMpyryixIJWHVS
         MFE3y5fS98ByWyiqZlo5rdb3HDVXKG7ed3QtCn3reyw7PXw8+dXgkt62Nud0yjEuzN
         m6khptTa5+EAxubkvi3qxNJvSeD+isKPNA4UPtMXS2ixLCQdKmlE0ayHB8arnSJR6u
         cjGQoEih8NH3fp2vmddZnN/PsRS+hPsOXXhhLAgK53ZsdBdVDteB76HVaW8enar4bY
         Gjv06JgSGVnYJC1Np1a0BHANcKfcvzk7pqPruEzHPy/rLP3iKDJuRqQptUyXOzNn6u
         EIz9DX3ZGnXHg==
Date:   Sat, 29 Jul 2023 18:48:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v2] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
Message-ID: <20230729-chaps-coauthor-95557d86b189@spud>
References: <20230726174524.340952-1-xingmingzheng@iscas.ac.cn>
 <20230726-outclass-parade-2ccea9f6688a@spud>
 <10231b81-ea42-26d0-4c11-92851229e658@iscas.ac.cn>
 <20230726-armchair-evasive-427dd245a9fe@spud>
 <20230727-briskness-sappy-e2d9e4c1ef36@spud>
 <d75ef570-c0ad-cea4-687a-d02b560aa676@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/xQjWBbnHuYsLKM8"
Content-Disposition: inline
In-Reply-To: <d75ef570-c0ad-cea4-687a-d02b560aa676@iscas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/xQjWBbnHuYsLKM8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2023 at 01:36:49AM +0800, Mingzheng Xing wrote:

> I reproduced the error with gcc-12.2.0 and binutils-2.35. I tried a
> different solution, which I think makes the logic easier. Showing
> the new patch code:

It is indeed simpler, neat.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4c07b9189c86..a6fa1eed895c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -569,25 +569,24 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>=20
> =A0config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
> =A0=A0=A0=A0=A0=A0=A0 def_bool y
> -=A0=A0=A0=A0=A0=A0 # https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=
=3Dcommit;h=3Daed44286efa8ae8717a77d94b51ac3614e2ca6dc
> -=A0=A0=A0=A0=A0=A0 depends on AS_IS_GNU && AS_VERSION >=3D 23800
> +=A0=A0=A0=A0=A0=A0 depends on AS_IS_GNU && AS_VERSION >=3D 23600
> =A0=A0=A0=A0=A0=A0=A0 help
> -=A0=A0=A0=A0=A0=A0=A0=A0 Newer binutils versions default to ISA spec ver=
sion 20191213 which
> -=A0=A0=A0=A0=A0=A0=A0=A0 moves some instructions from the I extension to=
 the Zicsr and Zifencei
> -=A0=A0=A0=A0=A0=A0=A0=A0 extensions.
> +=A0=A0=A0=A0=A0=A0=A0=A0 Binutils has supported zicsr and zifencei exten=
sions since version 2.36,
> +=A0=A0=A0=A0=A0=A0=A0=A0 try to adapt to the changes by using explicit z=
icsr and zifencei via
> +=A0=A0=A0=A0=A0=A0=A0=A0 -march.

This sentence no longer makes sense to me, the motivation for why we are
doing this is lost. Please preserve the link & explanation about the
20191213 version of the spec, adding to it the commentary about how we
can relax the check to 2.36, since that makes our lives easier.

The rest of this looks fine to me, if you resubmit I'll look at it
further on Monday.

--/xQjWBbnHuYsLKM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMVQ0wAKCRB4tDGHoIJi
0hSNAQC4nTdM3esMZyV0dCcSxV4Vouv1QrjdKIehT8d0Ekj1FgEAzV4i7k7xFRWu
eCpwfwzJaU7gFR6zdpfx0+KDSo2Cugc=
=UWMZ
-----END PGP SIGNATURE-----

--/xQjWBbnHuYsLKM8--
