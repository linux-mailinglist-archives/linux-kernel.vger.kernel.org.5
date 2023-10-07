Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD067BC6F4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbjJGK5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJGK5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:57:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343F93;
        Sat,  7 Oct 2023 03:57:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9ADC433C8;
        Sat,  7 Oct 2023 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696676220;
        bh=FbDCBpNcB5UA8Pkt82Ea7XaptxlhhJwPIUs8N5p1Y3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPHOeOAjSgipfP1E4/ZSmHjMoLg/VK4jn8AUf5SjmhS5D/fjs07/blfVev+cunNlC
         hEV8rDSOWcB898Ig04TXWx8V5U5mJnNuwK7iFi54crqVa1+LjCTMVHNL8el4BlwkDb
         hd4otYl2Meusl5NrydfCzJJu1M4OpD0Z0vY8xWvBu2LAnVHb5YlNo7pJOEvO7/1kq8
         52K98XE0Hlz7VtObYvd7EghONIef2r15mwpXKuiWYIKWFuYOs0WAE4VU6F6lWKOLjZ
         prGsLoarVS0wyeoXYguBgdxJ5pUo37HMGuvDKcZLm0h7uBe9RA83hk2sps8SVlM3XF
         vcRa1z2hVf+3Q==
Date:   Sat, 7 Oct 2023 11:56:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: linux-next: Tree for Oct 6 (riscv: andes)
Message-ID: <20231007-poach-refute-b84fe5b7431a@spud>
References: <20231006153809.2054a0f8@canb.auug.org.au>
 <09a6b0f0-76a1-45e3-ab52-329c47393d1d@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vJKcyeb3DdW70Crt"
Content-Disposition: inline
In-Reply-To: <09a6b0f0-76a1-45e3-ab52-329c47393d1d@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vJKcyeb3DdW70Crt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 05:28:27PM -0700, Randy Dunlap wrote:
>=20
>=20
> On 10/5/23 21:38, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20231005:
> >=20
>=20
> on riscv 64bit:
>=20
> WARNING: unmet direct dependencies detected for ERRATA_ANDES
>   Depends on [n]: RISCV_ALTERNATIVE [=3Dn] && RISCV_SBI [=3Dy]
>   Selected by [y]:
>   - ARCH_R9A07G043 [=3Dy] && SOC_RENESAS [=3Dy] && RISCV [=3Dy] && NONPOR=
TABLE [=3Dy] && RISCV_SBI [=3Dy]
>=20
> ../arch/riscv/errata/andes/errata.c:59:54: warning: 'struct alt_entry' de=
clared inside parameter list will not be visible outside of this definition=
 or declaration
>    59 | void __init_or_module andes_errata_patch_func(struct alt_entry *b=
egin, struct alt_entry *end,
>       |                                                      ^~~~~~~~~
>=20
>=20
> Full randconfig file is attached.

Riiight. XIP_KERNEL is enabled, which means no alternatives are
permitted, but that R9A config option selects the Andes errata, which in
turn depends on alternatives.

I suppose we could do something like (untested):
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 7b74de732718..6fe85255e2ce 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -343,7 +343,7 @@ config ARCH_R9A07G043
        select ARCH_RZG2L
        select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
        select DMA_GLOBAL_POOL
-       select ERRATA_ANDES if RISCV_SBI
+       select ERRATA_ANDES if (RISCV_SBI & RISCV_ALTERNATIVE)
        select ERRATA_ANDES_CMO if ERRATA_ANDES
        help
          This enables support for the Renesas RZ/Five SoC.

--vJKcyeb3DdW70Crt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSE5eAAKCRB4tDGHoIJi
0sYXAP4lnHnMabjCni4wbpGFk69frnCb9rSEfcZuCdPQHjzcVwD/Tu5poWLRcoxu
oUkhKLb+7gPk3njdHxW8GTEBJQZTNQc=
=ZG8q
-----END PGP SIGNATURE-----

--vJKcyeb3DdW70Crt--
