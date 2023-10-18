Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F307CE512
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjJRRmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjJRRls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:41:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B079F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:41:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C39DC433C7;
        Wed, 18 Oct 2023 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697650906;
        bh=aj+p4AGcRGnsdjRD0n/a3mq6+ABBqlyLJtvKg+WBq9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gu69o4ZC/L70fyBCHx8E9zpnBf4EUeY6LgV7eJALpSrQ2oQFNAckllrykdGJj4N9C
         HcyTS/T2PjJzQcv/tBBqAa7sGA5dDWU95AIrHslSAUNkNFZggIL2yoMA6AbB+DHMUd
         aLdhh6N6li4HM0VCC07U1fv4VlkAl0LsXyug5qe4kFF2Aa2g5u+FZVF6xJBVJ3/MLn
         x5rMBYHGgKpZPM2e1gyFuZvZphT3ZXDSIJ753Vk3G3SDrxOoLGdAJODU3i2sSkZgYa
         UoMTou1ROspEvhyyEI9pMXgfsSg3aF1EVqirvWUL8TyNxX5xQBb6EaTqoutVO9qcL/
         umzdnfxhBTA4A==
Date:   Wed, 18 Oct 2023 18:41:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, bjorn@kernel.org
Subject: Re: [PATCH v4 0/2] riscv: Add remaining module relocations and tests
Message-ID: <20231018-confidant-frostily-e8f4dbdcd478@spud>
References: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
 <20231018-smite-bungee-f46b15b4ce6f@spud>
 <ZTAWcX1qVhkC71BJ@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mLW7xijzAMttePh"
Content-Disposition: inline
In-Reply-To: <ZTAWcX1qVhkC71BJ@ghost>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mLW7xijzAMttePh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 10:31:29AM -0700, Charlie Jenkins wrote:
> On Wed, Oct 18, 2023 at 12:35:55PM +0100, Conor Dooley wrote:
> > Hey Charlie,
> >=20
> > On Tue, Oct 17, 2023 at 10:34:15PM -0700, Charlie Jenkins wrote:
> > > A handful of module relocations were missing, this patch includes the
> > > remaining ones. I also wrote some test cases to ensure that module
> > > loading works properly. Some relocations cannot be supported in the
> > > kernel, these include the ones that rely on thread local storage and
> > > dynamic linking.
> > >=20
> > > ULEB128 handling is a bit special because SET and SUB relocations must
> > > happen together, and SET must happen before SUB. A psABI proposal [1]
> > > mandates that the first SET_ULEB128 that appears before a SUB_ULEB128
> > > is the associated SET_ULEB128.
> > >=20
> > > This can be tested by enabling KUNIT, RUNTIME_KERNEL_TESTING_MENU, and
> > > RISCV_MODULE_LINKING_KUNIT.
> > >=20
> > > [1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/403
> > >=20
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > > Changes in v4:
> > > - Complete removal of R_RISCV_RVC_LUI
> > > - Fix bug in R_RISCV_SUB6 linking
> > > - Only build ULEB128 tests if supported by toolchain
> > > - Link to v3: https://lore.kernel.org/r/20231016-module_relocations-v=
3-0-a667fd6071e9@rivosinc.com
> >=20
> > On patch 2/2:
> >=20
> > ../arch/riscv/kernel/tests/module_test/test_uleb128.S:18:17: error: unk=
nown relocation name
> > ../arch/riscv/kernel/tests/module_test/test_uleb128.S:19:17: error: unk=
nown relocation name
> >=20
> > Same toolchain configuration in the patchwork automation as before.
> >=20
> > Cheers,
> > Conor.
>=20
> Where do you see this error? On Patchwork I see a success [1].
>=20
> [1] https://patchwork.kernel.org/project/linux-riscv/patch/20231017-modul=
e_relocations-v4-2-937f5ef316f0@rivosinc.com/

It was a failure this morning!
See
<https://github.com/linux-riscv/linux-riscv/actions/runs/6549280771/job/177=
85844013>

I wonder if there is something wrong with the CI code, where it
erroneously reports the state from previous patches and then runs the
tests again with the new patches and re-pushes the results.

Bjorn, any idea?


--5mLW7xijzAMttePh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTAY1QAKCRB4tDGHoIJi
0pOTAQDCCiKYNA+6gFVQD5Eo6wg279/gtXLnlGuiK55RNr9/egD9GNwwnGI1yzfP
25wEREfFQDaiH0oG02EbQpF+P8UDpgU=
=3a8X
-----END PGP SIGNATURE-----

--5mLW7xijzAMttePh--
