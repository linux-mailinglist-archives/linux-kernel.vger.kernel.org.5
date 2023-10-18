Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0F27CDA95
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjJRLgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:36:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC1FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:35:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E6C433C7;
        Wed, 18 Oct 2023 11:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697628959;
        bh=auqTNLipd3mDc/YcCEnSBeelbAAfYDDTuTo0Vv6a5uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+Wdr4Euwkm2PmwDzKVGLB7zKPMBqG+ksDsnufCKVlZ6EonsZSvD3BSiU/bWdstEp
         UzDZ+9jBq9b8KdvbrVRIdd2UlsEA9S9jsX+okvK9KCpojusNi9AvAALCxzD3bOTI3W
         C6VhTmhaQveG2DE4rqAKHUqsK4ms5HfOS9TSuBzlxn4nkdw1RjQYK08mDSYq0+IXBB
         10JMFkBbldHjhABg4q0HmkYzc6oTVrcrbPFWuPHdKGubY+JB1N7k/5Ac7G/na/GxZT
         l75r0CBVjOfG0mE503xqPVEDRvcBPVxyuwGbPWFOePw60azeQM+RwbytU7L98eOILR
         m3m7YrOi2I3wQ==
Date:   Wed, 18 Oct 2023 12:35:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 0/2] riscv: Add remaining module relocations and tests
Message-ID: <20231018-smite-bungee-f46b15b4ce6f@spud>
References: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1okcQQvN+RgqgcjX"
Content-Disposition: inline
In-Reply-To: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1okcQQvN+RgqgcjX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Charlie,

On Tue, Oct 17, 2023 at 10:34:15PM -0700, Charlie Jenkins wrote:
> A handful of module relocations were missing, this patch includes the
> remaining ones. I also wrote some test cases to ensure that module
> loading works properly. Some relocations cannot be supported in the
> kernel, these include the ones that rely on thread local storage and
> dynamic linking.
>=20
> ULEB128 handling is a bit special because SET and SUB relocations must
> happen together, and SET must happen before SUB. A psABI proposal [1]
> mandates that the first SET_ULEB128 that appears before a SUB_ULEB128
> is the associated SET_ULEB128.
>=20
> This can be tested by enabling KUNIT, RUNTIME_KERNEL_TESTING_MENU, and
> RISCV_MODULE_LINKING_KUNIT.
>=20
> [1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/403
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v4:
> - Complete removal of R_RISCV_RVC_LUI
> - Fix bug in R_RISCV_SUB6 linking
> - Only build ULEB128 tests if supported by toolchain
> - Link to v3: https://lore.kernel.org/r/20231016-module_relocations-v3-0-=
a667fd6071e9@rivosinc.com

On patch 2/2:

=2E./arch/riscv/kernel/tests/module_test/test_uleb128.S:18:17: error: unkno=
wn relocation name
=2E./arch/riscv/kernel/tests/module_test/test_uleb128.S:19:17: error: unkno=
wn relocation name

Same toolchain configuration in the patchwork automation as before.

Cheers,
Conor.

>=20
> Changes in v3:
> - Add prototypes to test_module_linking_main as recommended by intel
>   zero day bot
> - Improve efficiency of ULEB128 pair matching
> - Link to v2: https://lore.kernel.org/r/20231006-module_relocations-v2-0-=
47566453fedc@rivosinc.com
>=20
> Changes in v2:
> - Added ULEB128 relocations
> - Link to v1: https://lore.kernel.org/r/20230913-module_relocations-v1-0-=
bb3d8467e793@rivosinc.com
>=20
> ---
> Charlie Jenkins (2):
>       riscv: Add remaining module relocations
>       riscv: Add tests for riscv module loading
>=20
>  arch/riscv/Kconfig.debug                           |   1 +
>  arch/riscv/include/uapi/asm/elf.h                  |   5 +-
>  arch/riscv/kernel/Makefile                         |   1 +
>  arch/riscv/kernel/module.c                         | 207 +++++++++++++++=
+++---
>  arch/riscv/kernel/tests/Kconfig.debug              |  35 ++++
>  arch/riscv/kernel/tests/Makefile                   |   1 +
>  arch/riscv/kernel/tests/module_test/Makefile       |  15 ++
>  .../tests/module_test/test_module_linking_main.c   |  85 +++++++++
>  arch/riscv/kernel/tests/module_test/test_set16.S   |  23 +++
>  arch/riscv/kernel/tests/module_test/test_set32.S   |  20 ++
>  arch/riscv/kernel/tests/module_test/test_set6.S    |  23 +++
>  arch/riscv/kernel/tests/module_test/test_set8.S    |  23 +++
>  arch/riscv/kernel/tests/module_test/test_sub16.S   |  22 +++
>  arch/riscv/kernel/tests/module_test/test_sub32.S   |  22 +++
>  arch/riscv/kernel/tests/module_test/test_sub6.S    |  22 +++
>  arch/riscv/kernel/tests/module_test/test_sub64.S   |  27 +++
>  arch/riscv/kernel/tests/module_test/test_sub8.S    |  22 +++
>  arch/riscv/kernel/tests/module_test/test_uleb128.S |  20 ++
>  18 files changed, 548 insertions(+), 26 deletions(-)
> ---
> base-commit: 4d320c2d9a2b22f53523a1b012cda17a50220965
> change-id: 20230908-module_relocations-f63ced651bd7
> --=20
> - Charlie
>=20

--1okcQQvN+RgqgcjX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS/DGwAKCRB4tDGHoIJi
0gMDAP0WbgwU87WIuhP0GqZRc4filSavgJ3pf5gzvnAAYbBAPAEAuuKUU48p/pb4
cjTzJOq1xJ30NhLxK8Npc0BLQvqxpwU=
=tuJ6
-----END PGP SIGNATURE-----

--1okcQQvN+RgqgcjX--
